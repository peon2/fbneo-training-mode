assert(rb,"Run fbneo-training-mode.lua")
dofile("games/wh2/wh2.lua") -- Basically the same as wh2

gamedefaultconfig = {
	hud = {
		health = {
			P1 = {
				x = 42,
				y = 12,
				enabled = true,
			},
			P2 = {
				x = 251,
				y = 12,
				enabled = true,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth
		},
		P2 = {
			maxhealth = p2maxhealth
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = true,
			refillhealthenabled = true
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 4,
				y = 200,
				enabled = true
			},
			P2 = {
				x = 240,
				y = 200,
				enabled = true
			}
		}
	}
}