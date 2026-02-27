local frame_data = {}

local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned,
    memory.readdword

-- TOGGLES
local SHOW_DEBUG_INFO = false

-- LOGGING SETUP
local log_file = io.open("debug_kof_framedata.log", "w")
if log_file then
    log_file:write("Frame,ActionID,Status,BoxID,State,Startup,Active\n")
end

-- ... (rest of file)



-- ... (rest of file)

local P1_BASE_ADDR = 0x108100
local P1_OBJ_PTR_LIST = 0x10BF24
local OFFSET_STATUS = 0x7C
local P1_ACTION_ADDR = 0x108173 -- p1hitstatus + 1
local P2_HITSTATUS_ADDR = 0x108372
local P2_BLOCKSTUN_ADDR = 0x1083E3

-- Hitbox Offsets
local BOX_OFFSETS = {
    0x90, 0x95, 0x9A, 0x9F
}

local BOX_ACTIVE_BITS = {
    [0x90] = 0,
    [0x95] = 1,
    [0x9A] = 2,
    [0x9F] = 3
}

-- Boxes to IGNORE (Empty now, because the active_bit check filters them properly!)
local IGNORED_BOXES = {
}

-- Actions to IGNORE (Idle, walking, guarding, hitstun, etc)
local IGNORED_ACTIONS = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [16] = true,
    [17] = true,
    [18] = true,
    [19] = true,
    [20] = true,
    [21] = true,
    [22] = true,
    [23] = true,
    [24] = true,
    [45] = true,
    [46] = true,
    [47] = true,
    [48] = true,
    [49] = true,
    [50] = true,
    [51] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [95] = true,
    [96] = true,
    [157] = true,
    [158] = true,
    [159] = true,
    [232] = true,
    [233] = true
}

-- State Enum
local STATE = {
    IDLE = 1,
    STARTUP = 2,
    ACTIVE = 3,
    RECOVERY = 4
}
local STUN_STATE = { NONE = 0, BLOCK = 1, HIT = 2 }

-- Grace Period
local GRACE_PERIOD = 8
local frames_since_action_lost = 0

-- Current Move Tracking
local current_state = STATE.IDLE
local debug_last_box_id = 0
local last_trigger_box = 0
local previous_frame_action = 0
local global_persistent_hit_frame = -1
local p2_current_stun = STUN_STATE.NONE
local p2_stun_timer = 0
local global_persistent_stun = 0
local global_persistent_stun_type = STUN_STATE.NONE
local current_advantage = 0
local global_persistent_advantage = 0
local advantage_calculating = false

-- Data Persistence
local last_move = {
    startup = 0,
    active = 0,
    recovery = 0,
    total = 0,
    hit_frame = -1
}

local current_move = {
    startup = 0,
    active = 0,
    recovery = 0,
    total = 0,
    hit_frame = -1
}

-- HISTORY LOGGER
local HISTORY_SIZE = 30
local history_log = {} -- Circular buffer of last 30 frames
local frozen_log = nil -- Snapshot when bug occurs

local function is_attack_type(id)
    return (id >= 12 and id <= 55)
end

local function check_attack_box(base_addr)
    local status_byte = rb(base_addr + OFFSET_STATUS)
    local found_any_box = 0
    for _, offset in ipairs(BOX_OFFSETS) do
        local bit_pos = BOX_ACTIVE_BITS[offset]
        local is_enabled = (bit.band(status_byte, bit.lshift(1, bit_pos)) ~= 0)

        if is_enabled then
            local box_addr = base_addr + offset
            local box_id = rb(box_addr)
            if box_id ~= 0 then
                found_any_box = box_id
                if is_attack_type(box_id) and not IGNORED_BOXES[box_id] then
                    debug_last_box_id = box_id
                    return true
                end
            end
        end
    end
    debug_last_box_id = found_any_box
    return false
end

local function is_action_busy()
    local action = rb(P1_ACTION_ADDR)
    return not IGNORED_ACTIONS[action]
end

function frame_data.init()
    current_state = STATE.IDLE
    last_move = { startup = 0, active = 0, recovery = 0, total = 0, hit_frame = -1 }
    current_move = { startup = 0, active = 0, recovery = 0, total = 0, hit_frame = -1 }
    frames_since_action_lost = 0
    previous_frame_action = 0
    history_log = {}
    frozen_log = nil

    p2_current_stun = STUN_STATE.NONE
    p2_stun_timer = 0
    global_persistent_stun = 0
    global_persistent_stun_type = STUN_STATE.NONE
    current_advantage = 0
    global_persistent_advantage = 0
    advantage_calculating = false
end

function frame_data.update()
    local current_frame_count = emu.framecount()
    local action_id = rb(P1_ACTION_ADDR)
    local status_byte = rb(P1_BASE_ADDR + OFFSET_STATUS)
    local p2_hitstatus = rb(P2_HITSTATUS_ADDR)

    local raw_is_busy = is_action_busy()
    local is_attacking = check_attack_box(P1_BASE_ADDR)

    -- Update History
    -- Ensure logged box respects filter too, for clarity
    local active_box_id = 0
    for _, offset in ipairs(BOX_OFFSETS) do
        local bit_pos = BOX_ACTIVE_BITS[offset]
        local is_enabled = (bit.band(status_byte, bit.lshift(1, bit_pos)) ~= 0)

        if is_enabled then
            local box_addr = P1_BASE_ADDR + offset
            local box_id = rb(box_addr)
            if box_id ~= 0 then
                active_box_id = box_id
                if is_attack_type(box_id) and not IGNORED_BOXES[box_id] then
                    break
                end
            end
        end
    end

    -- Hit and Block Detection Processing
    local p2_block_val = rb(P2_BLOCKSTUN_ADDR)
    local p2_is_blockstun = (p2_block_val == 0x20 or p2_block_val == 0xA0)
    local p2_is_hitstun = (p2_hitstatus ~= 0)

    local new_stun_state = STUN_STATE.NONE
    if p2_is_blockstun then
        new_stun_state = STUN_STATE.BLOCK
    elseif p2_is_hitstun then
        new_stun_state = STUN_STATE.HIT
    end

    if new_stun_state ~= STUN_STATE.NONE then
        if p2_current_stun == STUN_STATE.NONE then
            p2_current_stun = new_stun_state
            p2_stun_timer = 1
        else
            p2_stun_timer = p2_stun_timer + 1
            if new_stun_state == STUN_STATE.BLOCK then
                p2_current_stun = STUN_STATE.BLOCK
            end
        end
        global_persistent_stun = p2_stun_timer
        global_persistent_stun_type = p2_current_stun
    else
        if p2_current_stun ~= STUN_STATE.NONE then
            p2_current_stun = STUN_STATE.NONE
            p2_stun_timer = 0
        end
    end

    if current_state ~= STATE.IDLE and p2_current_stun ~= STUN_STATE.NONE and current_move.hit_frame == -1 then
        current_move.hit_frame = current_move.total
        global_persistent_hit_frame = current_move.total
        current_advantage = 0
        advantage_calculating = true
    end

    -- Advantage Tracking
    local p1_busy = (current_state ~= STATE.IDLE)
    local p2_busy = (p2_current_stun ~= STUN_STATE.NONE)

    if advantage_calculating then
        if p1_busy and not p2_busy then
            current_advantage = current_advantage - 1
        elseif not p1_busy and p2_busy then
            current_advantage = current_advantage + 1
        end
        global_persistent_advantage = current_advantage

        -- Stop calculating when both return to free state
        if not p1_busy and not p2_busy then
            advantage_calculating = false
        end
    end

    table.insert(history_log, 1,
        {
            frame = current_frame_count,
            action = action_id,
            status = status_byte,
            box_id = active_box_id,
            state =
                current_state,
            raw_busy = raw_is_busy,
            attacking = is_attacking,
            p2_hit = p2_hitstatus
        })
    if #history_log > HISTORY_SIZE then
        table.remove(history_log)
    end

    -- LOGGING TO FILE
    if log_file then
        local should_log = (action_id ~= 0) or (active_box_id ~= 0) or (current_state ~= STATE.IDLE)
        if should_log then
            -- Print status_byte as binary bits for debugging the active state issue
            local status_bits = ""
            for i = 7, 0, -1 do
                status_bits = status_bits .. (bit.btst(i, status_byte) ~= 0 and "1" or "0")
            end

            -- adding p2_hitstatus to the end of log
            log_file:write(string.format("%d,%d,%s,%d,%d,%d,%d,%d\n",
                current_frame_count, action_id, status_bits, active_box_id, current_state,
                current_move.startup, current_move.active, p2_hitstatus))
            log_file:flush()
        end
    end

    -- Grace Period Logic (Temporarily disabled as requested)
    local is_executing = raw_is_busy
    --[[
    if raw_is_busy then
        frames_since_action_lost = 0
    else
        if current_state ~= STATE.IDLE then
            frames_since_action_lost = frames_since_action_lost + 1
            if frames_since_action_lost <= GRACE_PERIOD then
                is_executing = true
            end
        end
    end
    --]]

    if current_state == STATE.IDLE then
        if is_executing then
            -- START
            print("Debug: Move STARTED at frame " .. current_frame_count)
            current_state = STATE.STARTUP
            frames_since_action_lost = 0

            -- Clear persistent data to show "-" on new moves
            global_persistent_hit_frame = -1
            global_persistent_stun = 0
            global_persistent_stun_type = STUN_STATE.NONE
            global_persistent_advantage = 0
            advantage_calculating = false

            -- To prevent 1-frame startup bugs when the engine throws a hitbox without startup,
            -- Reset explicitly distinct variables
            current_move = { startup = 1, active = 0, recovery = 0, total = 1, hit_frame = -1 }
        end
    elseif current_state == STATE.STARTUP then
        if not is_executing then
            -- Whiff (Move ended during startup)
            last_move = {
                startup = current_move.startup,
                active = 0,
                recovery = 0,
                total = current_move.startup,
                hit_frame = -1
            }
            current_state = STATE.IDLE
        elseif is_attacking then
            -- Transition to ACTIVE
            current_state = STATE.ACTIVE
            last_trigger_box = debug_last_box_id
            current_move.active = 1
            current_move.total = current_move.startup + current_move.active

            -- TRIGGER DEBUG
            if current_move.startup <= 1 then
                print("Debug: Startup 1 Detected! Box: " .. last_trigger_box)
                frozen_log = {}
                for i, v in ipairs(history_log) do
                    table.insert(frozen_log, v)
                end
            end
        else
            -- Still STARTUP
            current_move.startup = current_move.startup + 1
            current_move.total = current_move.startup
        end
    elseif current_state == STATE.ACTIVE then
        if not is_executing then
            -- Finish directly from active
            last_move = {
                startup = current_move.startup,
                active = current_move.active,
                recovery = 0,
                total = current_move.startup + current_move.active,
                hit_frame = current_move.hit_frame
            }
            current_state = STATE.IDLE
        elseif not is_attacking then
            -- Transition to Recovery
            current_state = STATE.RECOVERY
            current_move.recovery = 1
            current_move.total = current_move.startup + current_move.active + current_move.recovery
        else
            -- Still ACTIVE
            current_move.active = current_move.active + 1
            current_move.total = current_move.startup + current_move.active
        end
    elseif current_state == STATE.RECOVERY then
        if not is_executing then
            -- Finish
            last_move = {
                startup = current_move.startup,
                active = current_move.active,
                recovery = current_move.recovery,
                total = current_move.total,
                hit_frame = current_move.hit_frame
            }
            current_state = STATE.IDLE
        elseif is_attacking then
            -- Multi-hit move went back to active
            current_state = STATE.ACTIVE
            current_move.active = current_move.active + 1
            current_move.total = current_move.startup + current_move.active + current_move.recovery
        else
            -- Still RECOVERY
            current_move.recovery = current_move.recovery + 1
            current_move.total = current_move.startup + current_move.active + current_move.recovery
        end
    end

    previous_frame_action = action_id
end

function frame_data.draw()
    if SHOW_DEBUG_INFO then
        -- Increase box width and height for extra debug info
        gui.box(2, 58, 260, 225, 0x00000080, 0x00000080)
    else
        -- Slim box for clean data only, taller to fit Stun & Adv
        gui.box(2, 58, 90, 155, 0x00000080, 0x00000080)
    end

    gui.text(4, 60, "Frame Data:", "yellow")

    local stats = (current_state == STATE.IDLE) and last_move or current_move

    gui.text(4, 72, "Startup:  " .. stats.startup)
    gui.text(4, 82, "Active:   " .. stats.active)
    gui.text(4, 92, "Recovery: " .. stats.recovery)
    gui.text(4, 102, "Total:    " .. stats.total)
    -- Formatting fix

    local hit_text = (global_persistent_hit_frame ~= -1) and tostring(global_persistent_hit_frame) or "-"
    local hit_color = (global_persistent_hit_frame ~= -1) and "yellow" or "white"
    gui.text(4, 112, "Hit Frame:" .. string.rep(" ", 3) .. hit_text, hit_color)

    local stun_text = "-"
    if global_persistent_stun_type == STUN_STATE.BLOCK then
        stun_text = global_persistent_stun .. " (Block)"
    elseif global_persistent_stun_type == STUN_STATE.HIT then
        stun_text = global_persistent_stun .. " (Hit)"
    end
    gui.text(4, 122, "Opp Stun: " .. string.rep(" ", 2) .. stun_text,
        (global_persistent_stun > 0) and "orange" or "white")

    local adv_text = "-"
    local adv_color = "white"
    if global_persistent_hit_frame ~= -1 then
        local adv_suffix = ""
        if global_persistent_stun_type == STUN_STATE.BLOCK then
            adv_suffix = " (Block)"
        elseif global_persistent_stun_type == STUN_STATE.HIT then
            adv_suffix = " (Hit)"
        end

        if global_persistent_advantage > 0 then
            adv_text = "+" .. global_persistent_advantage .. adv_suffix
            adv_color = "green"
        elseif global_persistent_advantage < 0 then
            adv_text = tostring(global_persistent_advantage) .. adv_suffix
            adv_color = "red"
        else
            adv_text = "0" .. adv_suffix
            adv_color = "yellow"
        end
    end
    gui.text(4, 132, "Advantage:" .. string.rep(" ", 2) .. adv_text, adv_color)

    local action = rb(P1_ACTION_ADDR)
    gui.text(4, 145, "Action ID:     " .. action, "gray")

    if SHOW_DEBUG_INFO then
        gui.text(4, 165, "Trigger Box:   " .. last_trigger_box, "red")

        -- New Debug Info
        gui.text(4, 180, "Debug Internal:", "yellow")
        gui.text(4, 190, "Grace Frames: " .. frames_since_action_lost)
        gui.text(4, 200, "Raw Busy: " .. tostring(is_action_busy()))
        gui.text(4, 210, "Attacking: " .. tostring(check_attack_box(P1_BASE_ADDR)))

        -- Show History Log (Always)
        local log_to_show = frozen_log or history_log

        gui.text(140, 60, "LOG (Last 15):", "red")
        for i = 1, 15 do
            local entry = log_to_show[i]
            if entry then
                local s_char = "?"
                if entry.state == 1 then
                    s_char = "I"
                elseif entry.state == 2 then
                    s_char = "S"
                elseif entry.state == 3 then
                    s_char = "A"
                elseif entry.state == 4 then
                    s_char = "R"
                end

                local line = string.format("-%d%s A:%d B:%d", i - 1, s_char, entry.action, entry.box_id)
                gui.text(140, 70 + (i * 8), line, (entry.state == 3) and "red" or "white")
            end
        end
    end
end

return frame_data
