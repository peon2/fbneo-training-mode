assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xff
p2maxhealth = 0xff


local p1health = 0x10103C

local p2health = 0x101152

local p1combocounter = 0x10126A

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
			x=136,
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 18,
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 275,
				y = 16,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 112,
				y = 226,
				enabled = true,
			},
			P2 = {
				x = 202,
				y = 226,
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
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
		}
	}
}

function playerOneFacingLeft()
	return rb(0x10100D) == 0
end

function playerTwoFacingLeft()
	return rb(0x101285) == 0
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

function playerTwoInHitstun()
	return rb(p1combocounter) ~= 0
end

function infiniteTime()
	wb(0x101252,0xFE)
end

function maxCredits()
	wb(0xD00034, 0x990)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
