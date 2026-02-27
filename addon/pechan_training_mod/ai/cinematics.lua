local Cinematics = {}

require("addon.pechan_training_mod.config")

Cinematics.active_dialogue = nil

function Cinematics.init()
    print("Cinematics Module Initialized")
end

function Cinematics.start_sequence(sequence_id)
    PECHAN_CONFIG.CINEMATICS.active = true
    PECHAN_CONFIG.CINEMATICS.current_dialogue_index = 1

    -- Example dialogue data structure
    PECHAN_CONFIG.CINEMATICS.dialogues = {
        { speaker = "Kyo",    text = "Let's start the trial.", color = 0x880000FF },
        { speaker = "System", text = "Press Start to begin.",  color = 0x000000FF }
    }

    -- In a real scenario, we'll lock inputs via emu hooks here.
end

function Cinematics.advance_dialogue()
    if not PECHAN_CONFIG.CINEMATICS.active then return end

    PECHAN_CONFIG.CINEMATICS.current_dialogue_index = PECHAN_CONFIG.CINEMATICS.current_dialogue_index + 1

    if PECHAN_CONFIG.CINEMATICS.current_dialogue_index > #PECHAN_CONFIG.CINEMATICS.dialogues then
        PECHAN_CONFIG.CINEMATICS.active = false
        print("Cinematic sequence ended.")
        -- Restore inputs here.
    end
end

function Cinematics.draw()
    if not PECHAN_CONFIG.CINEMATICS.active then return end

    local d = PECHAN_CONFIG.CINEMATICS.dialogues[PECHAN_CONFIG.CINEMATICS.current_dialogue_index]
    if d then
        -- This is a placeholder for actual gui drawing functions
        -- gui.box(10, 200, 310, 240, d.color, 0xFFFFFFFF)
        -- gui.text(15, 205, d.speaker .. ": " .. d.text)
    end
end

return Cinematics
