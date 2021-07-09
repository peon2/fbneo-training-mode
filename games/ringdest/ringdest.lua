assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x0116
p2maxhealth = 0x0116

local p1health = 0xFF802C
local p1redhealth = 0xFF802E
local p2health = 0xFF842C
local p2redhealth = 0xFF842E

local p1direction = 0xFF8038
local p2direction = 0xFF8438

print "Known issues with ringdest:"
print "Doesn't track combos"
print "Note that slammast doesn't have meter"
print ""

translationtable = {
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
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Hold"] = 7,
	["Weak punch"] = 8,
	["Strong punch"] = 9,
	["Button 4"] = 10,
	["Weak kick"] = 11,
	["Strong kick"] = 12,
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
