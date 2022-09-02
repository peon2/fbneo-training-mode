assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x60
p2maxhealth = 0x60

local p1health = 0x1003B8
local p1redhealth = 0x1003B9
local p2health = 0x100589
local p2redhealth = 0x100589

local p1direction = 0x100445
local p2direction = 0x100345

function gamemsg()
	print "Note that fatfury1 has no meter"
	print "Known issue:"
	print "Hitstun not set up"
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
		combotextx=144,
		combotexty=42,
		comboenabled=true,
		p1healthx=25,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=284,
		p2healthy=21,
		p2healthenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==1
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

function infiniteTime()
	wb(0x1042F3, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end
