local Cinematics = {}

require("addon.pechan_training_mod.config")

Cinematics.btn_a_pressed = false

function Cinematics.init()
    print("Cinematics Module Initialized")
end

function Cinematics.start_sequence(trial)
    PECHAN_CONFIG.CINEMATICS.state = "LOADING"
    PECHAN_CONFIG.CINEMATICS.wait_timer = trial.delay_before_dialogue or 120
    PECHAN_CONFIG.CINEMATICS.dialogues = trial.dialogues or {}
    PECHAN_CONFIG.CINEMATICS.current_dialogue_index = 1

    local current_game = PECHAN_CONFIG.get_current_game()
    for _, char in ipairs(current_game.characters) do
        if char.code == trial.character1 then
            PECHAN_CONFIG.UI.CURRENT_PLAYER1 = char
        end
        if char.code == trial.character2 then
            PECHAN_CONFIG.UI.CURRENT_PLAYER2 = char
        end
    end

    PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
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
    PECHAN_CONFIG.CINEMATICS.current_dialogue_index = PECHAN_CONFIG.CINEMATICS.current_dialogue_index + 1

    if PECHAN_CONFIG.CINEMATICS.current_dialogue_index > #PECHAN_CONFIG.CINEMATICS.dialogues then
        PECHAN_CONFIG.CINEMATICS.state = "FINISHED"
        print("Cinematic sequence ended.")
    end
end

function Cinematics.draw()
    if PECHAN_CONFIG.CINEMATICS.state ~= "PLAYING" then return end

    local d = PECHAN_CONFIG.CINEMATICS.dialogues[PECHAN_CONFIG.CINEMATICS.current_dialogue_index]
    if d then
        gui.box(20, 180, 360, 220, 0x000000BB, 0xFFFFFFFF)
        gui.text(25, 185, d.speaker .. ":", d.color or "yellow", 0x000000FF)
        gui.text(25, 195, d.text, "white", 0x000000FF)
        gui.text(320, 210, "Press A", "gray", 0x000000FF)
    end
end

return Cinematics
