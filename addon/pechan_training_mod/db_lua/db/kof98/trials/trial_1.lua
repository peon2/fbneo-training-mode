return {
    name = "The Destined Battle",
    description = "Perform a 3-hit combo after the dialogue.",
    setup = {
        character1 = "0x00", -- Kyo Kusanagi
        character2 = "0x1B", -- Iori Yagami
        savestate = "addon\\pechan_training_mod\\savestates\\kof98_select.fs"
    },
    intro_scenes = {
        {
            owner_id = 1, -- P1
            dialog = {
                { text = "Here we go, Iori!", color = 0xFF4444FF },
                { text = "Prepare yourself.", color = 0xFF4444FF }
            }
        },
        {
            owner_id = 2, -- P2
            dialog = {
                { text = "Hmph. Die!", color = 0x8800FFFF }
            }
        },
        {
            owner_id = -1, -- Narrator
            dialog = {
                { text = "The destined battle begins now.", color = "yellow" }
            }
        }
    },
    outro_scenes = {
        {
            owner_id = -1, -- Narrator
            dialog = {
                { text = "Kyo has emerged victorious!", color = "yellow" },
                { text = "Trial Complete.",             color = "green" }
            }
        }
    },
    win_condition = {
        hits = 3
    },
    delay_before_dialogue = 120
}
