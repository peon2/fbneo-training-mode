assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x66
p2maxhealth = 0x66

p1maxmeter = 0x14A
p2maxmeter = 0x14A

local p1health = 0x108239
local p2health = 0x108439

local p1meter = 0x1082E3 -- 0x1081E8 -> 0x42 = 0x1082E3++
local p2meter = 0x1084E3

local p1meterbar = 0x1081E8
local p2meterbar = 0x1083E8

local p1direction = 0x108131
local p2direction = 0x108331

local p1combocounter = 0x1084B0
local p2combocounter = 0x1082B0

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
				y = 21,
				enabled = true,
			},
			P2 = {
				x = 257,
				y = 21,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 98,
				y = 209,
				enabled = true,
			},
			P2 = {
				x = 195,
				y = 209,
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
	return rb(p1meterbar) + rb(p1meter)*0x42
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter/0x42)
	wb(p1meterbar, meter%0x42)
end

function readPlayerTwoMeter()
	return rb(p2meterbar) + rb(p2meter)*0x42
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter/0x42)
	wb(p2meterbar, meter%0x42)
end

function infiniteTime()
	ww(0x10A7D2, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
