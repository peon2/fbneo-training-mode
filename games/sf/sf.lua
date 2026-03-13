assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x040B
p2maxhealth = 0x040B

function gamemsg()
	print "Known issues with sf:"
	print "Combos not tracked"
end

local p1health = 0xFF86B6
local p2health = 0xFF86E0

local p1direction = 0xFFE437
local p2direction = 0xFFEA37

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
	"button6",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Button 4"] = 8,
	["Button 5"] = 9,
	["Button 6"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		health = {
			P1 = {
				x = 277,
				y = 24,
				enabled = true
			},
			P2 = {
				x = 277,
				y = 40,
				enabled = true
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
			refillhealthenabled = true
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==4
end

function playerTwoFacingLeft()
	return rb(p2direction)==4
end

--[[
0xFFE105 and the addresses directly afterward seem to hold data on 
getting hit for both players, one of these might denote which player got hit.

function playerOneInHitstun()
	
end

function playerTwoInHitstun()
	
end

--]]

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

local infiniteTime = function()
	wdw(0xFF8E19, 0x70707000)
end

function Run() -- runs every frame
	infiniteTime()
end