assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x8000
p2maxmeter = 0x8000

local p1health = 0x1092ed
local p2health = 0x1093ed

local p1meter = 0x1094a4
local p2meter = 0x1095a4

local p1direction = 0x1080bd
local p2direction = 0x10847d

function gamemsg()
	print "Known issues with aof2:"
	print "Hitstun detector can be inconsistent"
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
			x = 138,
			y = 35,
			enabled = true
		},
		health = {
			P1 = {
				x = 10,
				y = 16,
				enabled = true
			},
			P2 = {
				x = 282,
				y = 16,
				enabled = true
			}
		},
		meter = {
			P1 = {
				x = 10,
				y = 25,
				enabled = true
			},
			P2 = {
				x = 275,
				y = 25,
				enabled = true
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

function playerTwoInHitstun()
	return rb(0x1093C0)==0x06 or rb(0x1093C0)==0x07 -- damage animation?
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
	ww(0x108406, 0x5000)
end

function Run() -- runs every frame
	infiniteTime()
end
