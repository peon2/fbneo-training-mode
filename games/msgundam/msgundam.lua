assert(rb,"Run fbneo-training-mode.lua")
-- fbneo doesn't currently support reading/writing to this game
p1maxhealth = 0xA0
p2maxhealth = 0xA0

local p1health = 0x202883
local p2health = 0x2029AF

local p1direction = 0x202154
local p2direction = 0x202438

function gamemsg()
	print "Note, due to msgundam having too few buttons to operate the training mode, Start is used to control the UI."
end

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"coin",
	"start",
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Start"] = 7,
	["Coin"] = 8,
	["Select"] = 9,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			x=140,
			y=33,
			enabled=true,
		},
		health = {
			P1 = {
				x = 18,
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 260,
				y = 20,
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
			refillhealthenabled = true,
			refillhealthspeed = 1
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
			refillhealthspeed = 1
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 18,
				y = 223,
				enabled = true
			},
			P2 = {
				x = 336,
				y = 223,
				enabled = true
			}
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==1
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function infiniteTime()
	ww(0x201F9C, 0x0DEC)
end

function Run() -- runs every frame
	infiniteTime()
end