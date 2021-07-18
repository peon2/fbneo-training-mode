assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xff
p2maxhealth = 0xff


local p1health = 0x10103C

local p2health = 0x101152

local p1combocounter = 0x10126A



translationtable = {
	"coin",
	"start",
	"select",
	"up",
	"down",
	"left",
	"right",
	"button1",
	"button2",
	"button3",
	"button4",
	["Coin"] = 1,
	["Start"] = 2,
	["Select"] = 3,
	["Up"] = 4,
	["Down"] = 5,
	["Left"] = 6,
	["Right"] = 7,
	["Button A"] = 8,
	["Button B"] = 9,
	["Button C"] = 10,
	["Button D"] = 11,
}

gamedefaultconfig = {
	hud = {
		p1healthx=18,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=275,
		p2healthy=16,
		p2healthenabled=true,
		comboenabled=true,
		combotextx=136,
		combotexty=42,
	},
}

function playerOneFacingLeft()
	return rb(0x10100D) == 0
end

function playerTwoFacingLeft()
	return rb(0x101285) == 0
end

function readPlayerOneHealth(health)
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function readPlayerTwoHealth(health)
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function playerTwoInHitstun()
	return rb(p1combocounter) ~= 0
end

function infiniteTime()
	memory.writebyte(0x101252,0xFE)
end

function maxCredits()
	memory.writebyte(0xD00034, 0x990)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
