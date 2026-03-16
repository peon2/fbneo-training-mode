assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 104
p2maxhealth = 104

p1maxmeter = 0x60
p2maxmeter = 0x60

function gamemsg()
	print "Known issues with dinorex:"
	print "Infinite meter breaks the game"
	print "No combo counter"
	print "Game is VERY prone to throwing errors"
end

local p1health = 0x605124
local p2health = 0x605190

local p1meter = 0x605123
local p2meter = 0x60518f

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
	["Left"] = 3,
	["Right"] = 4,
	["Up"] = 5,
	["Down"] = 6,
	["Fire 1"] = 7,
	["Fire 2"] = 8,
	["Fire 3"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			x=180,
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 13,
				y = 8,
				enabled = true,
			},
			P2 = {
				x = 296,
				y = 8,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 82,
				y = 17,
				enabled = false,
			},
			P2 = {
				x = 231,
				y = 17,
				enabled = false,
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
			instantrefillhealth = true,
			refillhealthenabled = true,
			instantrefillmeter = true,
			refillmeterenabled = true,
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
			instantrefillmeter = true,
			refillmeterenabled = true,
		}
	}
}

-- cannot switch sides in this game
function playerOneFacingLeft()
	return false
end

function playerTwoFacingLeft()
	return true
end

-- I don't think dino rex even has combos
function _playerOneInHitstun()
end

function _playerTwoInHitstun()
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	return wb(p1health,health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
end

function readPlayerTwoMeter()
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	wb(0x60826F,0x99)
end

function Run()
	infiniteTime()
end