assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x90
p2maxhealth = 0x90

print "Known issues with sf2ce:"
print "Combos not tracked"
print "Note sf2ce has no meter"
print ""

local p1health = 0xFF83E9
local p1redhealth = 0xFF83EB
local p2health = 0xFF86E9
local p2redhealth = 0xFF86EB

local p1direction = 0xFF83D0
local p2direction = 0xFF86D0

translationtable = {
	{
		"coin",
		"start",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
		"button5",
		"button6",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Weak Punch"] = 7,
	["Medium Punch"] = 8,
	["Strong Punch"] = 9,
	["Weak Kick"] = 10,
	["Medium Kick"] = 11,
	["Strong Kick"] = 12
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
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
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

local infiniteTime = function()
	ww(0xFF8ABE,0x9900)
end

function Run() -- runs every frame
	infiniteTime()
end
