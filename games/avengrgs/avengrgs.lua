assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xFF
p2maxhealth = 0xFF

p1maxmeter = 0x02
p2maxmeter = 0x02

local p1health = 0x00108DCD
local p2health = 0x00108F7D

function gamemsg()
	print "Known issues with avengrgs:"
	print "No combo detection"
end

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
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
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		health = {
			P1 = {
				x = 28,
				y = 11,
				enabled = true,
			},
			P2 = {
				x = 283,
				y = 11,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 44,
				y = 18,
				enabled = true,
			},
			P2 = {
				x = 290,
				y = 18,
				enabled = true,
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
	},
	inputs = {
		simple = {
			P1 = {
				x = 2,
				y = 224,
				enabled = true
			},
			P2 = {
				x = 273,
				y = 224,
				enabled = true
			}
		}
	}
}

function playerOneFacingleft()
	return rb(0x00108D38) == 0x0A
end

function playerTwoFacingLeft()
	return rb(0x00108ee8) == 0x0A
end

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

function readPlayerOneMeter()
	return rb(0x00108DD0)
end

function writePlayerOneMeter(meter)
	wb(0x00108DD0, meter)
end

function readPlayerTwoMeter()
	return rb(0x00108F80)
end

function writePlayerTwoMeter(meter)
	wb(0x00108F80, meter)
end

function infiniteTime()
	wb(0x001084C9,0x63)
end

function maxCredits()
	wb(0x001088A1, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
