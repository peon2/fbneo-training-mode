assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x60
p2maxhealth = 0x60

-- Thanks to Guruslum for these health values
local p1health = 0x1003B8
local p1redhealth = 0x1003B9
local p2health = 0x1004B8
local p2redhealth = 0x1004B9

local p1direction = 0x100445
local p2direction = 0x100345

function gamemsg()
	print "Note that fatfury1 has no meter"
	print "Known issue:"
	print "Hitstun not set up"
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
			x=144,
			y=42,
			enabled=false,
		},
		health = {
			P1 = {
				x = 25,
				y = 21,
				enabled = true,
			},
			P2 = {
				x = 284,
				y = 21,
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
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==1
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
	wb(p1redhealth, health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
	wb(p2redhealth, health)
end

function infiniteTime()
	wb(0x1042F3, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end
