local Cinematics = {}

require("addon.pechan_training_mod.config")

Cinematics.btn_a_pressed = false

function Cinematics.init()
    print("Cinematics Module Initialized")
end

function Cinematics.start_sequence(scenes, setup, wait_time)
    PECHAN_CONFIG.CINEMATICS.state = "LOADING"
    PECHAN_CONFIG.CINEMATICS.wait_timer = wait_time or 60
    PECHAN_CONFIG.CINEMATICS.scenes = scenes or {}
    PECHAN_CONFIG.CINEMATICS.current_scene_index = 1
    PECHAN_CONFIG.CINEMATICS.current_dialog_index = 1

    if setup then
        local current_game = PECHAN_CONFIG.get_current_game()
        for _, char in ipairs(current_game.characters) do
            if char.code == setup.character1 then
                PECHAN_CONFIG.UI.CURRENT_PLAYER1 = char
            end
            if char.code == setup.character2 then
                PECHAN_CONFIG.UI.CURRENT_PLAYER2 = char
            end
        end
        PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
    else
        -- If no setup, we skip characters_has_changed and go straight to waiting
        PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED = false
    end
end

local function lock_inputs()
    local lock = {
        ["P1 Up"] = false,
        ["P1 Down"] = false,
        ["P1 Left"] = false,
        ["P1 Right"] = false,
        ["P1 Button A"] = false,
        ["P1 Button B"] = false,
        ["P1 Button C"] = false,
        ["P1 Button D"] = false,
        ["P1 Start"] = false,
        ["P1 Coin"] = false,
        ["P2 Up"] = false,
        ["P2 Down"] = false,
        ["P2 Left"] = false,
        ["P2 Right"] = false,
        ["P2 Button A"] = false,
        ["P2 Button B"] = false,
        ["P2 Button C"] = false,
        ["P2 Button D"] = false,
        ["P2 Start"] = false,
        ["P2 Coin"] = false
    }
    pechanJoypadSet(lock)
end

function Cinematics.update()
    if PECHAN_CONFIG.CINEMATICS.state == "INACTIVE" or PECHAN_CONFIG.CINEMATICS.state == "FINISHED" then return end

    if PECHAN_CONFIG.CINEMATICS.state == "LOADING" then
        if not PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED then
            PECHAN_CONFIG.CINEMATICS.state = "WAITING"
        end
    elseif PECHAN_CONFIG.CINEMATICS.state == "WAITING" then
        lock_inputs()
        PECHAN_CONFIG.CINEMATICS.wait_timer = PECHAN_CONFIG.CINEMATICS.wait_timer - 1
        if PECHAN_CONFIG.CINEMATICS.wait_timer <= 0 then
            PECHAN_CONFIG.CINEMATICS.state = "PLAYING"
        end
    elseif PECHAN_CONFIG.CINEMATICS.state == "PLAYING" then
        lock_inputs()

        local p1_inputs = joypad.get()
        local btn_a = p1_inputs["P1 Button A"] or p1_inputs["P1 Fire 1"]

        if btn_a and not Cinematics.btn_a_pressed then
            Cinematics.btn_a_pressed = true
            Cinematics.advance_dialogue()
        elseif not btn_a then
            Cinematics.btn_a_pressed = false
        end
    end
end

function Cinematics.advance_dialogue()
    local scenes = PECHAN_CONFIG.CINEMATICS.scenes
    local s_idx = PECHAN_CONFIG.CINEMATICS.current_scene_index
    local d_idx = PECHAN_CONFIG.CINEMATICS.current_dialog_index

    if not scenes[s_idx] then
        PECHAN_CONFIG.CINEMATICS.state = "FINISHED"
        return
    end

    local dialogs = scenes[s_idx].dialog
    d_idx = d_idx + 1

    if d_idx > #dialogs then
        d_idx = 1
        s_idx = s_idx + 1
    end

    if s_idx > #scenes then
        PECHAN_CONFIG.CINEMATICS.state = "FINISHED"
        print("Cinematic sequence ended.")
    else
        PECHAN_CONFIG.CINEMATICS.current_scene_index = s_idx
        PECHAN_CONFIG.CINEMATICS.current_dialog_index = d_idx
    end
end

function Cinematics.draw()
    if PECHAN_CONFIG.CINEMATICS.state ~= "PLAYING" then return end

    local s_idx = PECHAN_CONFIG.CINEMATICS.current_scene_index
    local d_idx = PECHAN_CONFIG.CINEMATICS.current_dialog_index
    local scene = PECHAN_CONFIG.CINEMATICS.scenes[s_idx]

    if scene and scene.dialog and scene.dialog[d_idx] then
        local d = scene.dialog[d_idx]
        local owner_id = scene.owner_id

        -- Box positioning
        local y1, y2 = 180, 220
        if owner_id == -1 then
            y1, y2 = 80, 120 -- Narrator box in middle
        end

        gui.box(20, y1, 360, y2, 0x000000BB, 0xFFFFFFFF)

        if owner_id == -1 then
            -- Narrator centering
            gui.text(190 - (#d.text * 2), y1 + 10, d.text, d.color or "yellow", 0x000000FF)
        else
            local speaker = "Unknown"
            if owner_id == 1 then
                speaker = (PECHAN_CONFIG.UI.CURRENT_PLAYER1 and PECHAN_CONFIG.UI.CURRENT_PLAYER1.name) or "P1"
            elseif owner_id == 2 then
                speaker = (PECHAN_CONFIG.UI.CURRENT_PLAYER2 and PECHAN_CONFIG.UI.CURRENT_PLAYER2.name) or "P2"
            end

            gui.text(25, y1 + 5, speaker .. ":", d.color or "yellow", 0x000000FF)
            gui.text(25, y1 + 15, d.text, "white", 0x000000FF)
        end

        gui.text(320, y2 - 10, "Press A", "gray", 0x000000FF)
    end
end

return Cinematics
