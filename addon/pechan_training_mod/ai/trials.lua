local Trials = {}

require("addon.pechan_training_mod.config")

function Trials.init()
    print("Trials Module Initialized")
end

function Trials.load_trial(id)
    local rom = emu.romname()
    local path = "addon/pechan_training_mod/db_lua/db/" .. rom .. "/trials/trial_" .. id .. ".lua"

    if not fexists(path) then
        print("Trial file not found: " .. path)
        return false
    end

    local trial = dofile(path)
    if not trial then
        print("Failed to load trial data from: " .. path)
        return false
    end

    PECHAN_CONFIG.TRIAL.active = true
    PECHAN_CONFIG.TRIAL.current_trial_id = id
    PECHAN_CONFIG.TRIAL.current_trial_data = trial -- Cache it!
    PECHAN_CONFIG.TRIAL.score = 0
    PECHAN_CONFIG.TRIAL.win_condition_met = false
    PECHAN_CONFIG.TRIAL.loss_condition_met = false
    PECHAN_CONFIG.TRIAL.hits = 0
    PECHAN_CONFIG.TRIAL.outro_triggered = false

    print("Loaded Trial: " .. trial.name)

    local GameManager = require("addon.pechan_training_mod.core.game_manager")
    GameManager.apply_changes(trial.setup)

    local Cinematics = require("addon.pechan_training_mod.ai.cinematics")
    Cinematics.start_sequence(trial.intro_scenes, trial.setup, trial.delay_before_dialogue)

    return true
end

function Trials.check_conditions()
    if not PECHAN_CONFIG.TRIAL.active or PECHAN_CONFIG.TRIAL.win_condition_met then return end

    local current_game = PECHAN_CONFIG.get_current_game()
    local combo_addr = current_game.offsets.combo_counter or 0x1084b0
    local combo = rb(combo_addr)
    PECHAN_CONFIG.TRIAL.hits = combo

    local trial = PECHAN_CONFIG.TRIAL.current_trial_data
    if trial and trial.win_condition and trial.win_condition.hits then
        if PECHAN_CONFIG.TRIAL.hits >= trial.win_condition.hits then
            PECHAN_CONFIG.TRIAL.win_condition_met = true
            print("TRIAL WIN CONDITION MET!")

            if trial.outro_scenes and not PECHAN_CONFIG.TRIAL.outro_triggered then
                PECHAN_CONFIG.TRIAL.outro_triggered = true
                local Cinematics = require("addon.pechan_training_mod.ai.cinematics")
                Cinematics.start_sequence(trial.outro_scenes)
            end
        end
    end
end

function Trials.draw()
    if not PECHAN_CONFIG.TRIAL.active then return end

    local trial = PECHAN_CONFIG.TRIAL.current_trial_data
    if not trial then return end

    local x, y = 5, 5
    gui.box(x, y, x + 120, y + 25, "black", "white")
    gui.text(x + 5, y + 5, "TRIAL: " .. trial.name, "yellow")

    if PECHAN_CONFIG.TRIAL.win_condition_met then
        gui.text(x + 5, y + 15, "SUCCESS!", "green")
    else
        local hits_req = (trial.win_condition and trial.win_condition.hits) or 0
        gui.text(x + 5, y + 15, "PROGRESS: " .. PECHAN_CONFIG.TRIAL.hits .. " / " .. hits_req, "white")
    end
end

function Trials.load_all_trials()
    local rom = emu.romname()
    local folder = "addon/pechan_training_mod/db_lua/db/" .. rom .. "/trials"
    local trials = {}

    local p = io.popen('dir "' .. folder .. '" /b')
    if not p then return trials end

    for file in p:lines() do
        if file:match("^trial_(%d+)%.lua$") then
            local id = file:match("^trial_(%d+)%.lua$")
            local path = folder .. "/" .. file
            local data = dofile(path)
            if data then
                table.insert(trials, {
                    id = tonumber(id),
                    name = data.name or ("Trial " .. id),
                    description = data.description or ""
                })
            end
        end
    end
    p:close()

    table.sort(trials, function(a, b) return a.id < b.id end)
    return trials
end

return Trials
