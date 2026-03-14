assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xD1
p2maxhealth = 0xD1

p1maxmeter = 0x68
p2maxmeter = 0x68

local p1health = 0x81C67F
local p2health = 0x81C7BB

local p1meter = 0x80DAA1
local p2meter = 0x80DC5D

local p1stocks = 0x80DA99
local p2stocks = 0x80DC55

function gamemsg()
	print "Known issues with martmast:"
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
				x = 42,
				y = 15,
				enabled = true,
			},
			P2 = {
				x = 395,
				y = 15,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 160,
				y = 212,
				enabled = true,
			},
			P2 = {
				x = 278,
				y = 212,
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
				x = 44,
				y = 194,
				enabled = true
			},
			P2 = {
				x = 344,
				y = 194,
				enabled = true
			}
		}
	}
}

function playerTwoFacingLeft()
	return rb(0x815A0D) == 0
end

function readPlayerOneHealth(health)
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

function readPlayerOneMeter()
	return rb(0x80DAA1)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
	wb(p1stocks, 0x09)
end

function readPlayerTwoMeter()
	return rb(0x80DC5D)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
	wb(p2stocks, 0x09)
end

function infiniteTime()
	wb(0x80AC19,0x64)
end

function maxCredits()
	wb(0x81B5B4, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
