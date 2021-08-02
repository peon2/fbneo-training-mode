assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x93
p2maxhealth = 0x93


local p1health = 0x204569

local p2health = 0x2045BF

local p1combocounter = 0x2035E7

local p2combocounter = 0x2035E9


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
	["Button 1"] = 8,
	["Button 2"] = 9,
	["Button 3"] = 10,
	["Button 4"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotextx=180,
		combotexty=42,
		comboenabled=true,
		p1healthx=32,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=342,
		p2healthy=16,
		p2healthenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0x203926) == 0
end

function playerTwoFacingLeft()
	return rb(0x203F3A) == 0
end

function playerOneInHitstun()
	return rb(p2combocounter) ~= 0
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
	memory.writebyte(0x2035A3,0x9B)
    memory.writebyte(0x2035A2,0x0B)
end

function maxCredits()
	memory.writebyte(0x2034EF, 0xFF)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
