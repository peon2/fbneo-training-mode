-- addon/pechan_training_mod/db_lua/db/kof98/trials/trial_2.lua

local trial = {
    id = 2,
    name = "Terry's Power Dunk",
    description = "Perform a 4-hit combo with Terry Bogard.",
    setup = {
        p1 = { name = "Terry Bogard", code = "0x03" },
        p2 = { name = "Joe Higashi", code = "0x05" },
        savestate = "addon/pechan_training_mod/db_lua/db/kof98/savestates/trial_2_default.fs"
    },
    win_condition = {
        hits = 4
    },
    delay_before_dialogue = 30,
    intro_scenes = {
        {
            owner_id = 1, -- Terry
            dialogue = {
                "Are you ready?",
                "Let's see if you can handle my Power Dunk combo!"
            }
        },
        {
            owner_id = 2, -- Joe
            dialogue = {
                "Hey Terry, don't underestimate the Muay Thai Champ!",
                "Come on!"
            }
        }
    },
    outro_scenes = {
        {
            owner_id = 1,
            dialogue = {
                "OK! Power Dunk!",
                "Great practice, Joe."
            }
        }
    }
}

return trial
