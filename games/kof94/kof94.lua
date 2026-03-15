assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xD0
p2maxhealth = 0xD0

p1maxmeter = 0x7F
p2maxmeter = 0x7F

local p1health = 0x108221
local p2health = 0x108421

local p1meter = 0x108219
local p2meter = 0x108419

local p1direction = 0x100731
local p2direction = 0x100b31

local p1combocounter = 0x10840e
local p2combocounter = 0x10820e

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
			x=140,
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 36,
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 258,
				y = 16,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 80,
				y = 205,
				enabled = true,
			},
			P2 = {
				x = 211,
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
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
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
	ww(0x10882E, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
