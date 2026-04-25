assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x78
p2maxhealth = 0x78

p1maxmeter = 0x80
p2maxmeter = 0x80

local p1direction = 0x100458
local p2direction = 0x100558

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
	["Button A"] = 5,
	["Button B"] = 6,
	["Button C"] = 7,
	["Button D"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=40
		},
		health = {
			P1 = {
				x = 3,
				y = 16,
				enabled = false,
			},
			P2 = {
				x = 306,
				y = 16,
				enabled = false,
			}
		},
		meter = {
			P1 = {
				x = 91,
				y = 208,
				enabled = true,
			},
			P2 = {
				x = 218,
				y = 208,
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

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(0x10a39D)~=0
end

function playerTwoInHitstun()
	return rb(0x10a39C)~=0 
end

function readPlayerOneHealth()
	return rb(0x10048E)
end

function writePlayerOneHealth(health)
	wb(0x10048E, health)
end

function readPlayerTwoHealth()
	return rb(0x10058E)
end

function writePlayerTwoHealth(health)
	wb(0x10058E, health)
end

function readPlayerOneMeter()
	return rb(0x1004BE)
end

function writePlayerOneMeter(meter)
	wb(0x1004BE, meter)
end

function readPlayerTwoMeter()
	return rb(0x1005BE)
end

function writePlayerTwoMeter(meter)
	wb(0x1005BE, meter)
end

function infiniteTime()
	wb(0x107490,0x99)
end

function maxCredits()
	wb(0x10E008, 0x09)
	wb(0x10E009, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end