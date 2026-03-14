assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
dofile("games/sfiii3/sfiii3.lua") -- nearly everything is the same as sfiii3

p1maxhealth = 0xC0
p2maxhealth = 0xC0

gamedefaultconfig = {
	hud = {
		combotext = {
			x=235,
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 9,
				y = 17,
				enabled = true,
			},
			P2 = {
				x = 476,
				y = 17,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 38,
				y = 210,
				enabled = true,
			},
			P2 = {
				x = 447,
				y = 210,
				enabled = true,
			}
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 8,
				y = 208,
				enabled = true
			},
			P2 = {
				x = 418,
				y = 208,
				enabled = true
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth,
			maxmeter = p1maxmeter
		},
		P2 = {
			maxhealth = p2maxhealth,
			maxmeter = p2maxmeter
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
		}
	}
}

setConfigDefault("sfiii3stunxp1", 84)
setConfigDefault("sfiii3stunyp1", 24)
setConfigDefault("sfiii3stunxp2", 408)
setConfigDefault("sfiii3stunyp2", 24)