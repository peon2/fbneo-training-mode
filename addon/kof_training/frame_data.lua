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

local BOX_OFFSETS = { 0x90, 0x95, 0x9A, 0x9F }
local BOX_ACTIVE_BITS = {
    [0x90] = 0, [0x95] = 1, [0x9A] = 2, [0x9F] = 3
}

-- Boxes and Actions to IGNORE
local IGNORED_BOXES = {}
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
    [79] = true,
    [95] = true,
    [96] = true,
    [157] = true,
    [158] = true,
    [159] = true,
    [232] = true,
    [233] = true
}

local STATE = { IDLE = 1, STARTUP = 2, ACTIVE = 3, RECOVERY = 4 }
local STUN_STATE = { NONE = 0, BLOCK = 1, HIT = 2 }
local HISTORY_SIZE = 30
local OFFSET_STATUS = 0x7C

local function is_attack_type(id)
    return (id >= 12 and id <= 55)
end

local function create_tracker(name, base_addr, action_addr, opp_base_addr, opp_action_addr, opp_hitstatus_addr,
                              opp_blockstun_addr, draw_x)
    local self = {}
    self.name = name
    self.base_addr = base_addr
    self.action_addr = action_addr
    self.opp_base_addr = opp_base_addr
    self.opp_action_addr = opp_action_addr
    self.opp_hitstatus_addr = opp_hitstatus_addr
    self.opp_blockstun_addr = opp_blockstun_addr
    self.draw_x = draw_x
    local game_offsets = KOF_CONFIG.get_current_game().offsets
    self.air_height_addr = base_addr + (game_offsets.air_height or 0x21)

    function self:init()
        self.current_state = STATE.IDLE
        self.last_move = { startup = 0, active = 0, recovery = 0, total = 0, hit_frame = -1 }
        self.current_move = { startup = 0, active = 0, recovery = 0, total = 0, hit_frame = -1 }
        self.frames_since_action_lost = 0
        self.previous_frame_action = 0
        self.last_trigger_box = 0
        self.debug_last_box_id = 0

        self.global_persistent_hit_frame = -1
        self.opp_current_stun = STUN_STATE.NONE
        self.opp_stun_timer = 0
        self.global_persistent_stun = 0
        self.global_persistent_stun_type = STUN_STATE.NONE

        -- Traditional Advantage
        self.current_advantage = 0
        self.global_persistent_advantage = 0
        self.p1_recovery_frames = 0
        self.p2_stun_frames = 0
        self.advantage_calculating = false

        -- New Free Advantage
        self.current_free_advantage = 0
        self.global_persistent_free_advantage = 0
        self.free_adv_attacker_recovery = 0
        self.free_advantage_calculating = false

        self.current_air_frames = 0
        self.is_currently_in_air = false
        self.air_time_history = { 0, 0 }

        self.history_log = {}
        self.frozen_log = nil
    end

    self:init()

    function self:check_attack_box()
        -- 1. Check Personal Attack Boxes
        local status_byte = rb(self.base_addr + OFFSET_STATUS)
        local found_any_box = 0
        local active_box_id = 0
        for _, offset in ipairs(BOX_OFFSETS) do
            local bit_pos = BOX_ACTIVE_BITS[offset]
            local is_enabled = (bit.band(status_byte, bit.lshift(1, bit_pos)) ~= 0)

            if is_enabled then
                local box_addr = self.base_addr + offset
                local box_id = rb(box_addr)
                if box_id ~= 0 then
                    found_any_box = box_id
                    active_box_id = box_id
                    if is_attack_type(box_id) and not IGNORED_BOXES[box_id] then
                        self.debug_last_box_id = box_id
                        return true, box_id
                    end
                end
            end
        end
        self.debug_last_box_id = found_any_box

        -- 2. Check Global Projectiles
        -- For KOF94-2002, projectiles exist in a linked list or pointer array starting at a specific game phase address
        -- Since we only have access to basic memory reading here and need it to work across games (mostly 97/98/2002),
        -- we will use a known approach to scan for projectiles if applicable.
        local GAME_OBJ_PTR_LIST = nil
        local rom_name = emu.romname() or ""
        if rom_name == "kof98" or rom_name == "kof98h" then
            GAME_OBJ_PTR_LIST = 0x10B094 + 0xE90
        elseif rom_name == "kof97" then
            GAME_OBJ_PTR_LIST = 0x10B092 + 0xE90
        elseif rom_name == "kof2002" or rom_name == "kof2001" then
            GAME_OBJ_PTR_LIST = 0x10B056 + 0xE90
        end

        if GAME_OBJ_PTR_LIST then
            local offset = 0
            while offset < 100 do -- safety limit
                local obj_ptr = rw(GAME_OBJ_PTR_LIST + offset)
                if obj_ptr == 0 then break end

                local full_base = bit.bor(0x100000, obj_ptr)
                local active_status = rws(full_base + 0x6)

                if active_status >= 0 then
                    -- Projectile is allocated, but does it have an active attack box?
                    -- Projectile status offsets vary slightly by game, but usually 0x7C or 0x7D
                    local status_offset = (rom_name == "kof94" and 0x7A) or (rom_name == "kof95" and 0x7D) or 0x7C
                    local proj_status_byte = rb(full_base + status_offset)

                    local has_active_box = false
                    for _, box_offset in ipairs(BOX_OFFSETS) do
                        local bit_pos = BOX_ACTIVE_BITS[box_offset]
                        if (bit.band(proj_status_byte, bit.lshift(1, bit_pos)) ~= 0) then
                            local box_id = rb(full_base + box_offset)
                            if is_attack_type(box_id) then
                                has_active_box = true
                                break
                            end
                        end
                    end

                    if has_active_box then
                        self.debug_last_box_id = 999 -- special id for projectile
                        return true, 999
                    end
                end

                offset = offset + 2
            end
        end

        return false, active_box_id
    end

    function self:is_action_busy()
        local action = rb(self.action_addr)
        return not IGNORED_ACTIONS[action]
    end

    function self:is_opp_action_busy()
        local opp_action = rb(self.opp_action_addr)
        return not IGNORED_ACTIONS[opp_action]
    end

    function self:update()
        local current_frame_count = emu.framecount()
        local action_id = rb(self.action_addr)
        local status_byte = rb(self.base_addr + OFFSET_STATUS)
        local opp_hitstatus = rb(self.opp_hitstatus_addr)
        local opp_block_val = rb(self.opp_blockstun_addr)

        local current_air_height_word = rw(self.air_height_addr)
        local is_in_air = (current_air_height_word > 0)

        if is_in_air then
            if not self.is_currently_in_air then
                self.current_air_frames = 1
                self.is_currently_in_air = true
            else
                self.current_air_frames = self.current_air_frames + 1
            end
        else
            if self.is_currently_in_air then
                self.is_currently_in_air = false

                -- Shift history: [oldest, newest] <- [1st, 2nd]
                self.air_time_history[2] = self.air_time_history[1]
                self.air_time_history[1] = self.current_air_frames
            end
        end

        local raw_is_busy = self:is_action_busy()
        local opp_raw_is_busy = self:is_opp_action_busy()
        local is_attacking, active_box_id = self:check_attack_box()

        local opp_is_blockstun = (opp_block_val == 0x20 or opp_block_val == 0xA0)
        local opp_is_hitstun = (opp_hitstatus ~= 0)

        local new_stun_state = STUN_STATE.NONE
        if opp_is_blockstun then
            new_stun_state = STUN_STATE.BLOCK
        elseif opp_is_hitstun then
            new_stun_state = STUN_STATE.HIT
        end

        if self.opp_current_stun == STUN_STATE.NONE then
            if new_stun_state ~= STUN_STATE.NONE then
                self.opp_current_stun = new_stun_state
                self.opp_stun_timer = 1
                self.global_persistent_stun = self.opp_stun_timer
                self.global_persistent_stun_type = self.opp_current_stun
            end
        else
            if new_stun_state ~= STUN_STATE.NONE or opp_raw_is_busy then
                self.opp_stun_timer = self.opp_stun_timer + 1
                if new_stun_state == STUN_STATE.BLOCK then self.opp_current_stun = STUN_STATE.BLOCK end
                self.global_persistent_stun = self.opp_stun_timer
                self.global_persistent_stun_type = self.opp_current_stun
            else
                self.opp_current_stun = STUN_STATE.NONE
                self.opp_stun_timer = 0
            end
        end

        if self.current_state ~= STATE.IDLE and self.opp_current_stun ~= STUN_STATE.NONE and self.current_move.hit_frame == -1 then
            self.current_move.hit_frame = self.current_move.total
            self.global_persistent_hit_frame = self.current_move.total

            -- Traditional block/hit advantage starts calculating here
            self.current_advantage = 0
            self.p1_recovery_frames = 0
            self.p2_stun_frames = 0
            self.advantage_calculating = true

            -- New Free Advantage calculation setup
            self.current_free_advantage = 0
            self.free_adv_attacker_recovery = 0
            self.free_advantage_calculating = true
        end

        local p1_busy = (self.current_state ~= STATE.IDLE)
        local p2_busy = (self.opp_current_stun ~= STUN_STATE.NONE)

        -- Traditional Advantage (Based on explicitly known states)
        if self.advantage_calculating then
            if p1_busy then
                self.p1_recovery_frames = self.p1_recovery_frames + 1
            end
            if p2_busy then
                self.p2_stun_frames = self.p2_stun_frames + 1
            end

            self.current_advantage = self.p2_stun_frames - self.p1_recovery_frames
            self.global_persistent_advantage = self.current_advantage

            if not p1_busy and not p2_busy then self.advantage_calculating = false end
        end

        -- Free Advantage (Counts from Hit Frame)
        if self.free_advantage_calculating then
            local opp_is_stunned = (self.opp_current_stun ~= STUN_STATE.NONE)

            if opp_is_stunned then
                if raw_is_busy then
                    -- Track how many frames the attacker spent recovering DURING the opponent's stun
                    self.free_adv_attacker_recovery = (self.free_adv_attacker_recovery or 0) + 1
                end

                -- Free advantage is the opponent's total stun time minus the attacker's recovery time since the stun started.
                self.current_free_advantage = self.opp_stun_timer - self.free_adv_attacker_recovery
                self.global_persistent_free_advantage = self.current_free_advantage
            else
                -- Stop calculating when the opponent is no longer stunned.
                self.free_advantage_calculating = false
            end
        end

        table.insert(self.history_log, 1, {
            frame = current_frame_count,
            action = action_id,
            status = status_byte,
            box_id = active_box_id,
            state = self.current_state,
            raw_busy = raw_is_busy,
            attacking = is_attacking,
            opp_hit = opp_hitstatus
        })
        if #self.history_log > HISTORY_SIZE then table.remove(self.history_log) end

        local is_executing = raw_is_busy
        if self.current_state == STATE.IDLE then
            if is_executing then
                self.current_state = STATE.STARTUP
                self.frames_since_action_lost = 0

                -- Clear persistent data to "-"
                self.global_persistent_hit_frame = -1
                self.global_persistent_stun = 0
                self.global_persistent_stun_type = STUN_STATE.NONE

                self.global_persistent_advantage = 0
                self.p1_recovery_frames = 0
                self.p2_stun_frames = 0
                self.advantage_calculating = false

                self.global_persistent_free_advantage = 0
                self.current_free_advantage = 0
                self.free_adv_attacker_recovery = 0
                self.free_advantage_calculating = false

                self.current_move = { startup = 1, active = 0, recovery = 0, total = 1, hit_frame = -1 }
            end
        elseif self.current_state == STATE.STARTUP then
            if not is_executing then
                self.last_move = {
                    startup = self.current_move.startup,
                    active = 0,
                    recovery = 0,
                    total = self
                        .current_move.startup,
                    hit_frame = -1
                }
                self.current_state = STATE.IDLE
            elseif is_attacking then
                self.current_state = STATE.ACTIVE
                self.last_trigger_box = self.debug_last_box_id
                self.current_move.active = 1
                self.current_move.total = self.current_move.startup + self.current_move.active
                if self.current_move.startup <= 1 then
                    self.frozen_log = {}
                    for i, v in ipairs(self.history_log) do table.insert(self.frozen_log, v) end
                end
            else
                self.current_move.startup = self.current_move.startup + 1
                self.current_move.total = self.current_move.startup
            end
        elseif self.current_state == STATE.ACTIVE then
            if not is_executing then
                self.last_move = {
                    startup = self.current_move.startup,
                    active = self.current_move.active,
                    recovery = 0,
                    total =
                        self.current_move.startup + self.current_move.active,
                    hit_frame = self.current_move.hit_frame
                }
                self.current_state = STATE.IDLE
            elseif not is_attacking then
                self.current_state = STATE.RECOVERY
                self.current_move.recovery = 1
                self.current_move.total = self.current_move.startup + self.current_move.active +
                    self.current_move.recovery
            else
                self.current_move.active = self.current_move.active + 1
                self.current_move.total = self.current_move.startup + self.current_move.active
            end
        elseif self.current_state == STATE.RECOVERY then
            if not is_executing then
                self.last_move = {
                    startup = self.current_move.startup,
                    active = self.current_move.active,
                    recovery =
                        self.current_move.recovery,
                    total = self.current_move.total,
                    hit_frame = self.current_move.hit_frame
                }
                self.current_state = STATE.IDLE
            elseif is_attacking then
                self.current_state = STATE.ACTIVE
                self.current_move.active = self.current_move.active + 1
                self.current_move.total = self.current_move.startup + self.current_move.active +
                    self.current_move.recovery
            else
                self.current_move.recovery = self.current_move.recovery + 1
                self.current_move.total = self.current_move.startup + self.current_move.active +
                    self.current_move.recovery
            end
        end
        self.previous_frame_action = action_id
    end

    function self:draw()
        local x = self.draw_x
        if SHOW_DEBUG_INFO then
            gui.box(x - 2, 58, x + 158, 410, 0x00000080, 0x00000080)
        else
            -- Taller box to fit Free Adv and 2 Air Times
            gui.box(x - 2, 58, x + 88, 188, 0x00000080, 0x00000080)
        end

        gui.text(x, 60, self.name .. " Frame Data:", "yellow")
        local stats = (self.current_state == STATE.IDLE) and self.last_move or self.current_move

        gui.text(x, 72, "Startup:  " .. stats.startup)
        gui.text(x, 82, "Active:   " .. stats.active)
        gui.text(x, 92, "Recovery: " .. stats.recovery)
        gui.text(x, 102, "Total:    " .. stats.total)

        local hit_text = (self.global_persistent_hit_frame ~= -1) and tostring(self.global_persistent_hit_frame) or "-"
        local hit_color = (self.global_persistent_hit_frame ~= -1) and "yellow" or "white"
        gui.text(x, 112, "Hit Frame:" .. string.rep(" ", 3) .. hit_text, hit_color)

        local stun_text = "-"
        if self.global_persistent_stun_type == STUN_STATE.BLOCK then
            stun_text = self.global_persistent_stun .. " (Block)"
        elseif self.global_persistent_stun_type == STUN_STATE.HIT then
            stun_text = self.global_persistent_stun .. " (Hit)"
        end
        gui.text(x, 122, "Opp Stun: " .. string.rep(" ", 2) .. stun_text,
            (self.global_persistent_stun > 0) and "orange" or "white")

        local adv_text = "-"
        local adv_color = "white"

        local shared_adv_state = (self.name == "P1") and (_G.get_p1_advantage_state and _G.get_p1_advantage_state()) or
            (_G.get_p2_advantage_state and _G.get_p2_advantage_state())

        if shared_adv_state and (shared_adv_state.measuring or shared_adv_state.frame_advantage ~= 0) then
            local adv_suffix = ""
            if shared_adv_state.adv_type == "Block" then
                adv_suffix = " (Block)"
            elseif shared_adv_state.adv_type == "Hit" then
                adv_suffix = " (Hit)"
            end

            if shared_adv_state.frame_advantage > 0 then
                adv_text = "+" .. shared_adv_state.frame_advantage .. adv_suffix
                adv_color = "green"
            elseif shared_adv_state.frame_advantage < 0 then
                adv_text = tostring(shared_adv_state.frame_advantage) .. adv_suffix
                adv_color = "red"
            else
                adv_text = "0" .. adv_suffix
                adv_color = "yellow"
            end
        end
        gui.text(x, 132, "Advantage:" .. string.rep(" ", 2) .. adv_text, adv_color)

        -- Free Adv
        local free_adv_text = "-"
        local free_adv_color = "white"
        if self.global_persistent_hit_frame ~= -1 or self.free_advantage_calculating or self.global_persistent_free_advantage ~= 0 then
            if self.global_persistent_free_advantage > 0 then
                free_adv_text = "+" .. self.global_persistent_free_advantage
                free_adv_color = "green"
            elseif self.global_persistent_free_advantage < 0 then
                free_adv_text = tostring(self.global_persistent_free_advantage)
                free_adv_color = "red"
            else
                free_adv_text = "0"
                free_adv_color = "yellow"
            end
        end
        gui.text(x, 142, "Free Adv: " .. string.rep(" ", 2) .. free_adv_text, free_adv_color)

        local air1_text = (self.air_time_history[1] > 0) and tostring(self.air_time_history[1]) or "-"
        local air2_text = (self.air_time_history[2] > 0) and tostring(self.air_time_history[2]) or "-"

        gui.text(x, 152, "Air Time: " .. string.rep(" ", 2) .. air1_text, "cyan")
        gui.text(x, 162, "Air Time_2: " .. string.rep(" ", 0) .. air2_text, "cyan")

        local action = rb(self.action_addr)
        gui.text(x, 173, "Action ID:     " .. action, "gray")

        if SHOW_DEBUG_INFO then
            gui.text(x, 165, "Trigger Box:   " .. self.last_trigger_box, "red")
            gui.text(x, 180, "Debug Internal:", "yellow")
            gui.text(x, 190, "Grace Frames: " .. self.frames_since_action_lost)
            gui.text(x, 200, "Raw Busy: " .. tostring(self:is_action_busy()))
            gui.text(x, 210, "Attacking: " .. tostring(self:check_attack_box()))

            local log_to_show = self.frozen_log or self.history_log
            gui.text(x, 230, "LOG (Last 15):", "red")
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
                    local line = string.format("-%d%s A:%d", i - 1, s_char, entry.action)
                    gui.text(x, 240 + (i * 10), line, (entry.state == 3) and "red" or "white")
                end
            end
        end
    end

    return self
end

-- Create both P1 and P2 trackers. P2 gets passed P1's addresses for the "Opponent" arguments
local current_game = KOF_CONFIG.get_current_game()

local p1_base = current_game.player1_base
local p2_base = current_game.player2_base

local p1_action = current_game.player1_base + current_game.offsets.action
local p2_action = current_game.player2_base + current_game.offsets.action

local p1_hitstatus = current_game.player1_base + current_game.offsets.hitstatus
local p2_hitstatus = current_game.player2_base + current_game.offsets.hitstatus

local p1_blockstun = current_game.player1_base + current_game.offsets.blockstun
local p2_blockstun = current_game.player2_base + current_game.offsets.blockstun
local p1_is_in_air = current_game.player1_base + current_game.offsets.air_height
local p1_tracker = create_tracker("P1", p1_base, p1_action, p2_base, p2_action, p2_hitstatus, p2_blockstun, 4)
local p2_tracker = create_tracker("P2", p2_base, p2_action, p1_base, p1_action, p1_hitstatus, p1_blockstun, 225)

function frame_data.init()
    p1_tracker:init()
    p2_tracker:init()
end

function frame_data.update()
    local fd_mode = KOF_CONFIG.DEBUG.FRAMEDATA
    if fd_mode == 1 or fd_mode == 3 then
        p1_tracker:update()
    end
    if fd_mode == 2 or fd_mode == 3 then
        p2_tracker:update()
    end
end

function frame_data.draw()
    local fd_mode = KOF_CONFIG.DEBUG.FRAMEDATA
    if fd_mode == 1 or fd_mode == 3 then
        p1_tracker:draw()
    end
    if fd_mode == 2 or fd_mode == 3 then
        p2_tracker:draw()
    end
end

return frame_data
