local Cinematics = {}

local KOF_CONFIG = require("addon.kof_training.config")

Cinematics.active_dialogue = nil

function Cinematics.init()
    print("Cinematics Module Initialized")
end

function Cinematics.start_sequence(sequence_id)
    KOF_CONFIG.CINEMATICS.active = true
    KOF_CONFIG.CINEMATICS.current_dialogue_index = 1

    -- Example dialogue data structure
    KOF_CONFIG.CINEMATICS.dialogues = {
        { speaker = "Kyo",    text = "Let's start the trial.", color = 0x880000FF },
        { speaker = "System", text = "Press Start to begin.",  color = 0x000000FF }
    }

    -- In a real scenario, we'll lock inputs via emu hooks here.
end

function Cinematics.advance_dialogue()
    if not KOF_CONFIG.CINEMATICS.active then return end

    KOF_CONFIG.CINEMATICS.current_dialogue_index = KOF_CONFIG.CINEMATICS.current_dialogue_index + 1

    if KOF_CONFIG.CINEMATICS.current_dialogue_index > #KOF_CONFIG.CINEMATICS.dialogues then
        KOF_CONFIG.CINEMATICS.active = false
        print("Cinematic sequence ended.")
        -- Restore inputs here.
    end
end

function Cinematics.draw()
    if not KOF_CONFIG.CINEMATICS.active then return end

    local d = KOF_CONFIG.CINEMATICS.dialogues[KOF_CONFIG.CINEMATICS.current_dialogue_index]
    if d then
        -- This is a placeholder for actual gui drawing functions
        -- gui.box(10, 200, 310, 240, d.color, 0xFFFFFFFF)
        -- gui.text(15, 205, d.speaker .. ": " .. d.text)
    end
end

return Cinematics
