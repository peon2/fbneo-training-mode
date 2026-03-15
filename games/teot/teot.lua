assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xC8
p2maxhealth = 0xC8

local p1health = 0x101FEC
local p2health = 0x102174

local p1state = 0x101EF8 -- 0x0002 -> hitstun, 0x000A -> blockstun
local p2state = 0x102080

local p1direction = 0x101FC8
local p2direction = 0x102150

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
			enabled=true,
		},
		health = {
			P1 = {
				x = 30,
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 260,
				y = 20,
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
	return rw(p1state)==0x0002
end

function playerTwoInHitstun()
	return rw(p2state)==0x0002
end
-- health updates 1f after the hitstun does
local prevp1health = rw(p1health)
function readPlayerOneHealth(health)
	local ret = prevp1health
	prevp1health = rw(p1health)
	return ret
end

function writePlayerOneHealth(health)
	ww(p1health, health)
end

local prevp2health = rw(p2health)
function readPlayerTwoHealth(health)
	local ret = prevp2health
	prevp2health = rw(p2health)
	return ret
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
end

local timer = 0x10117C
local maxtime = 0x0E10
local function infiniteTime()
	ww(timer, maxtime-1)
end

function Run()
	infiniteTime()
end