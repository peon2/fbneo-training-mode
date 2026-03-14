assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x6800 -- word
p2maxhealth = 0x6800
-- health goes to 0x6800 from 0 as damage is taken

p1maxmeter = 0x6800 - rw(0x100450)
p2maxmeter = 0x6800 - rw(0x100550)

local p1health = 0x100450
local p2health = 0x100550

local p1meter = 0x100510
local p2meter = 0x100610

local p1combocounter = 0x10061f
local p2combocounter = 0x10051f

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
			x=142,
			y=50,
			enabled=true,
		},
		health = {
			P1 = {
				x = 43,
				y = 24,
				enabled = true,
			},
			P2 = {
				x = 258,
				y = 24,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 120,
				y = 35,
				enabled = true,
			},
			P2 = {
				x = 193,
				y = 35,
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
	return rb(0x10042B)==0x00 or rb(0x10042B)==0x04 or rb(0x10042B)==0x81 or rb(0x10042B)==0x89
end

function playerTwoFacingLeft()
	return rb(0x10052B)==0x00 or rb(0x10052B)==0x04 or rb(0x10052B)==0x81 or rb(0x10052B)==0x89
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function readPlayerOneHealth()
	return p1maxhealth-rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, p1maxhealth-health)
end

function readPlayerTwoHealth()
	return p2maxhealth-rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, p1maxhealth-health)
end

function readPlayerOneMeter()
	return rw(p1meter)
end

function writePlayerOneMeter(meter)
	ww(p1meter, meter)
end

function readPlayerTwoMeter()
	return rw(p2meter)
end

function writePlayerTwoMeter(meter)
	ww(p2meter, meter)
end

function infiniteTime()
	wb(0x102242, 0x9a)
end

function Run()
	infiniteTime()
	wb(0x108E84,1) -- unlock secret chars
end
