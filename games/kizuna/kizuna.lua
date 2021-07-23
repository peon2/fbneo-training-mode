assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xC0
p2maxhealth = 0xC0


local p1health = 0x108313

local p2health = 0x108513

local p1combocounter = 0x108554



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
		combotextx=138,
		combotexty=42,
		comboenabled=true,
		p1healthx=34,
		p1healthy=19,
		p1healthenabled=true,
		p2healthx=259,
		p2healthy=19,
		p2healthenabled=true,
	},
}


function playerTwoFacingLeft()
	return rb(0x10840F) == 0
end

function playerTwoInHitstun()
	return rb(p1combocounter) ~= 0
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

function infiniteTime()
	memory.writebyte(0x10892A,0x99)
end

function maxCredits()
	memory.writebyte(0xD00034, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
