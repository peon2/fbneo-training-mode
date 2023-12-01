assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x040B
p2maxhealth = 0x040B

function gamemsg()
	print "Known issues with sf:"
	print "Combos not tracked"
end

local p1health = 0xFF83E9
local p2health = 0xFF86E9

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
	["Weak Punch"] = 5,
	["Medium Punch"] = 6,
	["Strong Punch"] = 7,
	["Weak Kick"] = 8,
	["Medium Kick"] = 9,
	["Strong Kick"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		p1healthx=34,
		p1healthy=23,
		p1healthenabled=true,
		p2healthx=339,
		p2healthy=23,
		p2healthenabled=true,
	},
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
	ww(0xFF9498,0x0909)
end

function Run() -- runs every frame
	infiniteTime()
end
