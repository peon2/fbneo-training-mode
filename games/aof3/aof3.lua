assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x1000 -- words
p2maxhealth = 0x1000

p1maxmeter = 0x1000
p2maxmeter = 0x1000

local p1health = 0x100468
local p2health = 0x100568

local p1meter = 0x10046A
local p2meter = 0x10056A

local p1direction = 0x10048c
local p2direction = 0x10058c

function gamemsg()
	print "Known issues with aof3:"
	print "Hitstun detector can update a few frames after actually losing health for inconsistent combos"
	print "No hitboxes"
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
			y = 40,
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
				x = 282,
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

function playerOneInHitstun()
	return false
end

function playerTwoInHitstun()
	return rb(0x1005c3)~=0 -- damage animation?
end

function readPlayerOneHealth()
	return rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
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
	wb(0x10DF0F, 0x63)
end

function Run() -- runs every frame
	infiniteTime()
end
