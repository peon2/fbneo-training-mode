local Trials = {}

require("addon.pechan_training_mod.config")

-- Placeholder structure for trials
Trials.list = {
    [1] = {
        name = "The Destined Battle",
        description = "Perform a 3-hit combo after the dialogue.",
        character1 = "0x00", -- Kyo Kusanagi
        character2 = "0x15", -- Iori Yagami
        dialogues = {
            { speaker = "Kyo",  text = "Here we go, Iori!", color = 0xFF4444FF },
            { speaker = "Iori", text = "Hmph. Die!",        color = 0x8800FFFF }
        },
        win_hits = 3,
        delay_before_dialogue = 120 -- Delay (in frames) before showing dialogue to allow round to start
    }
}

function Trials.init()
    print("Trials Module Initialized")
end

function Trials.load_trial(id)
    local trial = Trials.list[id]
    if not trial then return false end

    PECHAN_CONFIG.TRIAL.active = true
    PECHAN_CONFIG.TRIAL.current_trial_id = id
    PECHAN_CONFIG.TRIAL.score = 0
    PECHAN_CONFIG.TRIAL.win_condition_met = false
    PECHAN_CONFIG.TRIAL.loss_condition_met = false
    PECHAN_CONFIG.TRIAL.hits = 0 -- track combo hits

    print("Loaded Trial: " .. trial.name)

    local Cinematics = require("addon.pechan_training_mod.ai.cinematics")
    Cinematics.start_sequence(trial)

    return true
end

function Trials.check_conditions()
    if not PECHAN_CONFIG.TRIAL.active then return end

    -- Evaluate completion or failure conditions here
end

return Trials
