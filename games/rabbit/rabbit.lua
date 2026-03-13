assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x88
p2maxhealth = 0x88

p1maxmeter = 0x03
p2maxmeter = 0x03

local p1health = 0xFF24EF
local p2health = 0xFF2533

local p1meter = 0xFF24FA
local p2meter = 0xFF253F

local p1combocounter = 0xFF20B9
local p2combocounter = 0xFF20B8

local p1direction = 0xFF1C25
local p2direction = 0xFF2025

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
		combotext = {
			y=42
		},
		health = {
			P1 = {
				x = 9,
				y = 12,
				enabled = true,
			},
			P2 = {
				x = 300,
				y = 12,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 44,
				y = 21,
				enabled = false,
			},
			P2 = {
				x = 268,
				y = 21,
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
			refillmeterenabled = true,
			healthrefillspeed = 1,
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
			healthrefillspeed = 1,
		}
	}
}

function playerOneFacingleft()
	return rb(p1direction) == 0
end

function playerTwoFacingLeft()
	return rb(p2direction) == 0
end

function playerOneInHitstun()
	return rb(p2combocounter) ~= 0
end

function playerTwoInHitstun()
	return rb(p1combocounter) ~= 0
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
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
end

function readPlayerTwoMeter()
	return rb(p1meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	wb(0xFF2570,0x99)
end

function maxCredits()
	wb(0xFFFE48, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
