assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0xFF
p2maxhealth = 0xFF

local p1health = 0xFF9157
local p2health = 0xFF9357

function gamemsg()
	print "Note that slammast doesn't have meter and only supports P1 and P2"
	print "Known issues with slammast:"
	print "Doesn't track combos"
end

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Attack"] = 5,
	["Jump"] = 6,
	["Pin"] = 7,
	["Coin"] = 8,
	["Start"] = 9,
}

gamedefaultconfig = {
	hud = {
		health = {
			P1 = {
				x = 50,
				y = 33,
				enabled = true,
			},
			P2 = {
				x = 356,
				y = 33,
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
			refillhealthenabled = true,
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
		}
	}
}

function playerOneFacingLeft()
	return rb(0xFF90FB)==0
end

function playerTwoFacingLeft()
	return rb(0xFF92FB)==0
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
	ww(0xFFA0C8, 0x0300)
	ww(0xFFA0CA, 0)
end

function Run() -- runs every frame
	infiniteTime()
end
