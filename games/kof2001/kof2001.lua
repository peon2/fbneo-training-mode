assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x67
p2maxhealth = 0x67

p1maxmeter = 0x90
p2maxmeter = 0x90

local p1health = 0x108239
local p2health = 0x108439

local p1meter = 0x1081e8
local p2meter = 0x1083e8

local p1metertoggle = p1meter+0x1e3
local p2metertoggle = p2meter+0x1e3

local p1direction = 0x108131
local p2direction = 0x108331

local p1combocounter = 0x1084b0
local p2combocounter = 0x1082b0

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
			y=45,
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
				x = 114,
				y = 207,
				enabled = true,
			},
			P2 = {
				x = 179,
				y = 207,
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
	if rb(p1metertoggle) then return p1maxmeter end
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	if (meter==p1maxmeter) then
		wb(p1metertoggle, 1)
		wb(p1meter, 0)
	else
		wb(p1meter, meter)
		wb(p1metertoggle, 0)
	end
end

function readPlayerTwoMeter()
	if rb(p2metertoggle) then return p2maxmeter end
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	if (meter==p2maxmeter) then
		wb(p2metertoggle, 1)
		wb(p2meter, 0)
	else
		wb(p2meter, meter)
		wb(p2metertoggle, 0)
	end
end

function infiniteTime()
	ww(0x10A7d2, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
