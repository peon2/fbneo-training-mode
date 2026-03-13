assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x7F -- Actually 0x7FFF
p2maxhealth = 0x7F

local p1health = 0x200FCE -- this is a word, but we can get away with treating this as a byte
local p2health = 0x201216

local p1combocounter = 0x2012A9
local p2combocounter = 0x201061

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
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Button 4"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=42,
			enabled = true,
		},
		health = {
			P1 = {
				x = 13,
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 289,
				y = 20,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 74,
				y = 222,
				enabled = true,
			},
			P2 = {
				x = 227,
				y = 222,
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
				x = 4,
				y = 220,
				enabled = true
			},
			P2 = {
				x = 252,
				y = 220,
				enabled = true
			}
		}
	}
}

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

local p1prevhealth = rb(p1health)
local p2prevhealth = rb(p2health)

function readPlayerOneHealth() -- returns health from 1f ago to be in sync with the combo counter
	local ret = p1prevhealth
	p1prevhealth = rb(p1health)
	return ret
end

function readPlayerTwoHealth()
	local ret = p2prevhealth
	p2prevhealth = rb(p2health)
	return ret
end

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

local function infiniteTime()
	wb(0x200101, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end