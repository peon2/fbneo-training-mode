assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x93
p2maxhealth = 0x93

local p1health = 0x2C7B
local p2health = 0x2DCF

local p1combocounter = 0
local p2combocounter = 0

local p1position = 0x2C14 -- word
local p2position = 0x2D68

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
			x=145,
			y=36,
			enabled=true,
		},
		health = {
			P1 = {
				x = 14,
				y = 14,
				enabled = true,
			},
			P2 = {
				x = 357,
				y = 14,
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
				x = 8,
				y = 224,
				enabled = true
			},
			P2 = {
				x = 309,
				y = 224,
				enabled = true
			}
		}
	}
}

function playerOneFacingLeft()
	return rw(p1position)>rw(p2position)
end

function playerTwoFacingLeft()
	return rw(p1position)<rw(p2position)
end

-- supposedly, this game doesn't have combos
function _playerOneInHitstun()
end

function _playerTwoInHitstun()
end

function readPlayerOneHealth(health)
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function readPlayerTwoHealth(health)
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

local function infiniteTime()
	ww(0x34C6, 0x0A01)
end

function Run() -- runs every frame
	infiniteTime()
end
