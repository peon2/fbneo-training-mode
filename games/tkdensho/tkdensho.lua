assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x7F
p2maxhealth = 0x7F

p1maxmeter = 0x0B
p2maxmeter = 0x0B

local p1health = 0x2004A4

local p2health = 0x200534

local p1combocounter = 0x2004A0

local p2combocounter = 0x200530

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
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Button 4"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotextx=145,
		combotexty=39,
		comboenabled=true,
		p1healthx=18,
		p1healthy=20,
		p1healthenabled=true,
		p2healthx=290,
		p2healthy=20,
		p2healthenabled=true,
		p1meterx=100,
		p1metery=208,
		p1meterenabled=true,
		p2meterx=214,
		p2metery=208,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0x20065E) == 0xFF
end

function playerTwoFacingLeft()
	return rb(0x2004F4) == 0
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

function readPlayerOneMeter()
	return rb(0x2004C8)
end

function writePlayerOneMeter(meter)
	wb(0x2004C8, meter)
end

function readPlayerTwoMeter()
	return rb(0x200558)
end

function writePlayerTwoMeter(meter)
	wb(0x200558, meter)
end

function infiniteTime()
	wb(0x201C50,0x63)
end

function maxCredits()
	wb(0x201C3F, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
