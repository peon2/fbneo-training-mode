assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Known issues with wh1:"
	print "Combo Counter is inconsistent"
	print "Health bars don't always visually update, even when the health values update"
end

p1maxhealth = 0x68
p2maxhealth = 0x68

local p1health = 0x10600A
local p2health = 0x10610A

local p1direction = 0x100021
local p2direction = 0x100121

local p1hitstun = 0x106135
local p2hitstun = 0x106035

-- P1 inputs are at 0x106000, WH1 keeps a history of inputs from 0x106400 onwards
-- P2 -> 106100 and 0x106500

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
		health = {
			P1 = {
				x = 34,
				y = 24,
				enabled = true,
			},
			P2 = {
				x = 275,
				y = 24,
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
			instantrefillhealth = true,
			refillhealthenabled = false
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = false
		}
	}
}

function playerOneFacingLeft()
	return AND(rb(p1direction), 0x80) > 0
end

function playerTwoFacingLeft()
	return AND(rb(p2direction), 0x80) > 0
end

function playerOneInHitstun() -- I don't know how combos work in this game, or even if combos exist
	return rb(p1hitstun) > 0
end

function playerTwoInHitstun()
	return rb(p2hitstun) > 0
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

local timer = 0x10B008
local maxtime = 0x991E

function infiniteTime()
	ww(timer, maxtime-1)
end

function Run() -- runs every frame
	infiniteTime()
end
