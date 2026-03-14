assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x93
p2maxhealth = 0x93

local p1health = 0x65EF
local p2health = 0x6779

local p1hitstun = 0x6623
local p2hitstun = 0x67AD

local p1direction = 0x65B9
local p2direction = 0x6743

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"button5",
	"coin",
	"start",
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Button 4"] = 8,
	["Button 5"] = 9,
	["Coin"] = 10,
	["Start"] = 11,
	["Select"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			x = 176,
			y = 29,
			enabled = false
		},
		health = {
			P1 = {
				x = 12,
				y = 14,
				enabled = true,
			},
			P2 = {
				x = 362,
				y = 14,
				enabled = true,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth,
		},
		P2 = {
			maxhealth = p2maxhealth,
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 8,
				y = 218,
				enabled = true
			},
			P2 = {
				x = 324,
				y = 218,
				enabled = true
			}
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==2
end

function playerTwoFacingLeft()
	return rb(p2direction)==2
end

function playerOneInHitstun()
	return rb(p1hitstun)~=0
end

function playerTwoInHitstun()
	return rb(p2hitstun)~=0
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
	ww(0x6A72, 0x0909)
end

function Run() -- runs every frame
	infiniteTime()
end