assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x78
p2maxhealth = 0x78

local p1health = 0x10C602
local p2health = 0x10C702

local p1hitstun = 0x10C61E
local p2hitstun = 0x10C71E

local p1direction = 0x10C649
local p2direction = 0x10C749

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
			y=36,
			enabled=false,
		},
		health = {
			P1 = {
				x = 18,
				y = 19,
				enabled = true,
			},
			P2 = {
				x = 275,
				y = 19,
				enabled = true,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth
		},
		P2 = {
			maxhealth = p2maxhealth
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = false,
			refillhealthenabled = true
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 8,
				y = 208,
				enabled = true
			},
			P2 = {
				x = 236,
				y = 208,
				enabled = true
			}
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==1
end

function playerOneInHitstun()
	return rw(p1hitstun)~=0
end

function playerTwoInHitstun()
	return rw(p2hitstun)~=0
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

local timer = 0x108110
local maxtime = 0x99
local function infiniteTime()
	wb(timer, maxtime-1)
end

function Run()
	infiniteTime()
end