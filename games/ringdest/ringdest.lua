assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x0116
p2maxhealth = 0x0116

local p1health = 0xFF802C
local p1redhealth = 0xFF802E
local p2health = 0xFF842C
local p2redhealth = 0xFF842E

local p1direction = 0xFF8038
local p2direction = 0xFF8438

function gamemsg()
	print "Known issues with ringdest:"
	print "Doesn't track combos"
	print "Note that slammast doesn't have meter"
end

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
	["Hold"] = 5,
	["Weak punch"] = 6,
	["Strong punch"] = 7,
	["Button 4"] = 8,
	["Weak kick"] = 9,
	["Strong kick"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		p1healthx=38,
		p1healthy=25,
		p1healthenabled=true,
		p2healthx=335,
		p2healthy=25,
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
	return rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
	ww(p1redhealth, health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
	ww(p2redhealth, health)	
end

local infiniteTime = function()
	wb(0xFF72CA, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end
