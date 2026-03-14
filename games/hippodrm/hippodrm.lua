assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

function gamemsg()
	print "Note that Hippodrome has no meter"
	print "Known issue:"
	print "Only the inputs of P1 can be recorded."
end

p1maxhealth = 0x10
p2maxhealth = 0x10

local p1health = 0xFF8032
local p2health = 0xFF8072

local p1direction = 0xFF804E
local p2direction = 0xFF808E

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"button5",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Fire 1"] = 5,
	["Fire 2"] = 6,
	["Fire 3"] = 7,
	["Fire 4"] = 8,
	["Fire 5"] = 9,
	["Coin"] = 10,
	["Start"] = 11,
	["Left (Cocktail)"] = 1,
	["Right (Cocktail)"] = 2,
	["Up (Cocktail)"] = 3,
	["Down (Cocktail)"] = 4,
	["Fire 1 (Cocktail)"] = 5,
	["Fire 2 (Cocktail)"] = 6,
	["Fire 3 (Cocktail)"] = 7,
	["Fire 4 (Cocktail)"] = 8,
	["Fire 5 (Cocktail)"] = 9,
	["Coin (Cocktail)"] = 10,
	["Start (Cocktail)"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			x=115,
			y=50,
			enabled=true,
		},
		health = {
			P1 = {
				x = 40,
				y = 25,
				enabled = true,
			},
			P2 = {
				x = 209,
				y = 25,
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
				x = 177,
				y = 208,
				enabled = false
			}
		},
		scrolling = {
			P1 = {
				x = 8,
				y = 60,
				enabled = true
			},
			P2 = {
				x = 232,
				y = 60,
				enabled = false
			}
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==3
end

function playerTwoFacingLeft()
	return rb(p2direction)==3
end

function playerOneInHitstun()
	return rb(0xFF804C)~=0
end

function playerTwoInHitstun()
	return rb(0xFF808C)~=0
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

local infiniteTime = function()
	wdw(0xFF87fc, 0x03000000)
end

function Run() -- runs every frame
	infiniteTime()
end
