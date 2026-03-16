-- addon/pechan_training_mod/core/game_manager.lua

local GameManager = {}

require("addon.pechan_training_mod.config")

function GameManager.get_addresses()
    local current_game = PECHAN_CONFIG.get_current_game()
    local p1_base = current_game.player1_base
    local p2_base = current_game.player2_base
    local offsets = current_game.offsets

    local addr = {}
    addr.p1_stored_index = p1_base + (offsets.player_stored_index or 0)
    addr.p2_stored_index = offsets.player2_stored_index and (p1_base + offsets.player2_stored_index) or
    (addr.p1_stored_index + 0x11)

    addr.p1_striker1 = offsets.striker1_stored_index and (p1_base + offsets.striker1_stored_index) or nil
    addr.p2_striker1 = offsets.striker2_stored_index and (p1_base + offsets.striker2_stored_index) or nil

    addr.p1_striker_mode = offsets.p1_striker_mode_address and (p1_base + offsets.p1_striker_mode_address) or nil
    addr.p2_striker_mode = offsets.p2_striker_mode_address and (p1_base + offsets.p2_striker_mode_address) or nil

    addr.p1_striker2 = offsets.p1_striker2_stored_index and (p1_base + offsets.p1_striker2_stored_index) or nil
    addr.p1_striker3 = offsets.p1_striker3_stored_index and (p1_base + offsets.p1_striker3_stored_index) or nil
    addr.p2_striker2 = offsets.p2_striker2_stored_index and (p1_base + offsets.p2_striker2_stored_index) or nil
    addr.p2_striker3 = offsets.p2_striker3_stored_index and (p1_base + offsets.p2_striker3_stored_index) or nil

    addr.level = offsets.level_address
    addr.stage = offsets.stage_address
    addr.music = offsets.music_address

    addr.p1_ex = offsets.p1_ex_address
    addr.p1_color = offsets.p1_color_address
    addr.p2_ex = offsets.p2_ex_address
    addr.p2_color = offsets.p2_color_address
    addr.ex_val = offsets.ex_value or 0x01

    addr.p1_mode = offsets.p1_mode_address
    addr.p2_mode = offsets.p2_mode_address

    return addr
end

function GameManager.load_state(path)
    local file = io.open(path, "rb")
    if file then
        file:close()
        savestate.load(path)
        print("GameManager: Loaded state " .. path)
        return true
    end
    print("GameManager Error: State not found " .. path)
    return false
end

function GameManager.apply_changes(setup)
    local current_game = PECHAN_CONFIG.get_current_game()
    local rom = emu.romname()
    local addr = GameManager.get_addresses()

    -- 1. Savestate
    local state_path = (setup and setup.savestate) or PECHAN_CONFIG.TRIAL.custom_savestate or
        ("addon\\pechan_training_mod\\savestates\\" .. rom .. "_select.fs")

    GameManager.load_state(state_path)

    -- 2. General Settings
    if addr.level then wb(addr.level, PECHAN_CONFIG.CPU.current_dificulty) end
    -- STAGES.JAPAN_STREET (0) and MUSIC (0x13) are used in init.lua.
    -- For now we keep them hardcoded as they were in init.lua or use config if available.
    if addr.stage then wb(addr.stage, 0) end
    if addr.music then wb(addr.music, 0x13) end

    -- 3. Characters
    if PECHAN_CONFIG.UI.CURRENT_PLAYER1 and PECHAN_CONFIG.UI.CURRENT_PLAYER1.code then
        wb(addr.p1_stored_index, tonumber(PECHAN_CONFIG.UI.CURRENT_PLAYER1.code, 16))
    end
    if PECHAN_CONFIG.UI.CURRENT_PLAYER2 and PECHAN_CONFIG.UI.CURRENT_PLAYER2.code then
        wb(addr.p2_stored_index, tonumber(PECHAN_CONFIG.UI.CURRENT_PLAYER2.code, 16))
    end

    -- 4. Strikers
    if current_game.has_strikers then
        if PECHAN_CONFIG.UI.P1_STRIKER1 and PECHAN_CONFIG.UI.P1_STRIKER1.code and addr.p1_striker1 then
            wb(addr.p1_striker1, tonumber(PECHAN_CONFIG.UI.P1_STRIKER1.code, 16))
            if addr.p1_striker_mode and rom == "kof2000" then
                wb(addr.p1_striker_mode, PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE)
            end
        end
        if PECHAN_CONFIG.UI.P2_STRIKER1 and PECHAN_CONFIG.UI.P2_STRIKER1.code and addr.p2_striker1 then
            wb(addr.p2_striker1, tonumber(PECHAN_CONFIG.UI.P2_STRIKER1.code, 16))
            if addr.p2_striker_mode and rom == "kof2000" then
                wb(addr.p2_striker_mode, PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE)
            end
        end
        if current_game.has_3_strikers then
            if PECHAN_CONFIG.UI.P1_STRIKER2 and PECHAN_CONFIG.UI.P1_STRIKER2.code and addr.p1_striker2 then
                wb(addr.p1_striker2, tonumber(PECHAN_CONFIG.UI.P1_STRIKER2.code, 16))
            end
            if PECHAN_CONFIG.UI.P1_STRIKER3 and PECHAN_CONFIG.UI.P1_STRIKER3.code and addr.p1_striker3 then
                wb(addr.p1_striker3, tonumber(PECHAN_CONFIG.UI.P1_STRIKER3.code, 16))
            end
            if PECHAN_CONFIG.UI.P2_STRIKER2 and PECHAN_CONFIG.UI.P2_STRIKER2.code and addr.p2_striker2 then
                wb(addr.p2_striker2, tonumber(PECHAN_CONFIG.UI.P2_STRIKER2.code, 16))
            end
            if PECHAN_CONFIG.UI.P2_STRIKER3 and PECHAN_CONFIG.UI.P2_STRIKER3.code and addr.p2_striker3 then
                wb(addr.p2_striker3, tonumber(PECHAN_CONFIG.UI.P2_STRIKER3.code, 16))
            end
        end
    end

    -- 5. EX Mode
    local function apply_ex(id)
        local is_ex = (id == 1) and PECHAN_CONFIG.UI.PLAYER1_EX or PECHAN_CONFIG.UI.PLAYER2_EX
        local char = (id == 1) and PECHAN_CONFIG.UI.CURRENT_PLAYER1 or PECHAN_CONFIG.UI.CURRENT_PLAYER2
        if not char or not char.has_ex then is_ex = false end

        local ex_addr = (id == 1) and addr.p1_ex or addr.p2_ex
        local color_addr = (id == 1) and addr.p1_color or addr.p2_color

        if is_ex then
            if ex_addr then wb(ex_addr, addr.ex_val) end
            if color_addr then wb(color_addr, 0x02) end
        else
            if ex_addr then wb(ex_addr, 0x00) end
            if color_addr and current_game.has_ex then wb(color_addr, 0x00) end
        end
    end
    apply_ex(1)
    apply_ex(2)

    -- 6. Player Modes (Extra/Advanced)
    local function apply_mode(id)
        local mode = (id == 1) and PECHAN_CONFIG.UI.PLAYER1_MODE or PECHAN_CONFIG.UI.PLAYER2_MODE
        local mode_addr = (id == 1) and addr.p1_mode or addr.p2_mode
        if mode_addr then
            if mode == PECHAN_CONFIG.UI.MODES.ADVANCED then
                wb(mode_addr, 0x00)
            elseif mode == PECHAN_CONFIG.UI.MODES.EXTRA then
                wb(mode_addr, 0x01)
            end
        end
    end
    apply_mode(1)
    apply_mode(2)

    -- 7. Sync Applied State
    PECHAN_CONFIG.UI.APPLIED.PLAYER1 = PECHAN_CONFIG.UI.CURRENT_PLAYER1
    PECHAN_CONFIG.UI.APPLIED.PLAYER2 = PECHAN_CONFIG.UI.CURRENT_PLAYER2
    -- ... (and others)
    -- Actually, copying the whole table is safer
    for k, v in pairs(PECHAN_CONFIG.UI) do
        if PECHAN_CONFIG.UI.APPLIED[k] ~= nil then
            PECHAN_CONFIG.UI.APPLIED[k] = v
        end
    end

    PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED = false
    PECHAN_CONFIG.CPU.HAS_CHANGED = false
    PECHAN_CONFIG.UI.MODE_HAS_CHANGED = false
end

return GameManager
