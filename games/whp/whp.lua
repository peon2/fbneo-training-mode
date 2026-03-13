assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xc0
p2maxhealth = 0xc0

p1maxmeter = 0xdf
p2maxmeter = 0xdf

local p1health = 0x10600C
local p2health = 0x10610c

local p1meter = 0x106a17
local p2meter = 0x106B17

local p1direction = 0x108295

local p1combocounter = 0x106146
local p2combocounter = 0x106046

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
			y=35,
			enabled=true,
		},
		health = {
			P1 = {
				x = 50,
				y = 17,
				enabled = true,
			},
			P2 = {
				x = 259,
				y = 17,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 96,
				y = 207,
				enabled = false,
			},
			P2 = {
				x = 197,
				y = 207,
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
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p1direction)==0
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
	wb(p1health, health)
	wb(p1health+1, health) -- display health
	wb(0x10607d, 0) -- stops flashing
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
	wb(p2health+1, health) -- display health
	wb(0x10617d, 0) -- stops flashing
end

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter) -- meter is funky in whp
	wb(p1meter, meter)
	wb(p1meter+2, meter)
end

function readPlayerTwoMeter()
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
	wb(p2meter+2, meter)
end

function infiniteTime()
	wb(0x10C109, 0x9a)
end

function Run() -- runs every frame
	infiniteTime()
end
