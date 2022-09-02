assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xFF
p2maxhealth = 0xFF

p1maxmeter = 0x3C
p2maxmeter = 0x3C

local p1health = 0x1037B7
local p1redhealth = 0x1037B9
local p2health = 0x1039B7
local p2redhealth = 0x1039B9

function gamemsg()
	print "Known issues with karnovr:"
	print "Note karnovr has no meter"
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
		combotextx=139,
		combotexty=42,
		comboenabled=true,
		p1healthx=18,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=275,
		p2healthy=21,
		p2healthenabled=true,
	}
}

function playerOneFacingLeft()
	return rb(0x103691)==0 or rb(0x103691)==0x40
end

function playerTwoFacingLeft()
	return rb(0x103891)==0 or rb(0x103891)==0x40
end

function playerOneInHitstun()
	return rb(0x10372C)~=0
end

function playerTwoInHitstun()
	return rb(0x10392C)~=0
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

function infiniteTime()
	ww(0x103A70, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
