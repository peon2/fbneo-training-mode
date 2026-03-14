assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Known issues with kof95:"
	print "Combos aren't tracked"
end

p1maxhealth = 0xD0
p2maxhealth = 0xD0

p1maxmeter = 0x7F
p2maxmeter = 0x7F

local p1health = 0x108221
local p2health = 0x108421

local p1meter = 0x108219
local p2meter = 0x108419

local p1direction = 0x100931
local p2direction = 0x100d31

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
				x = 33,
				y = 21,
				enabled = true,
			},
			P2 = {
				x = 260,
				y = 21,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 97,
				y = 205,
				enabled = true,
			},
			P2 = {
				x = 196,
				y = 205,
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
	return rb(p1direction)==0
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
	wb(p1health, health-1)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health-1)
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
	ww(0x10A836, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
	wb(0x10E79A, 0x1) -- enable hidden chars
end
