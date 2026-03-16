assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x20
p2maxmeter = 0x20

local p1health = rdw(0x100a46) + 0xbb
local p2health = rdw(0x100a4a) + 0xbb

local p1meter = rdw(0x100a46) + 0xf0
local p2meter = rdw(0x100a4a) + 0xf0

local p1direction = 0x10105c
local p2direction = 0x100ad0

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
		health = {
			P1 = {
				x = 17,
				y = 21,
				enabled = true,
			},
			P2 = {
				x = 292,
				y = 21,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 114,
				y = 208,
				enabled = true,
			},
			P2 = {
				x = 199,
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

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function _playerOneInHitstun()
end

function _playerTwoInHitstun()
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
	wb(0x100Ac6, 0x98)
end

function Run()
	infiniteTime()
end