assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xEF
p2maxhealth = 0xEF

p1maxmeter = 0x51
p2maxmeter = 0x36

local p1health1 = 0x403911
local p1health2 = 0x40390F

local p2health1 = 0x4046C3
local p2health2 = 0x4046C5

local p1combocounter = 0x4041E7
local p2combocounter = 0x40470B

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Coin"] = 8,
	["Start"] = 9,
}

gamedefaultconfig = {
	hud = {
		combotextx=140,
		combotexty=42,
		comboenabled=true,
		p1healthx=24,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=285,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=112,
		p1metery=226,
		p1meterenabled=true,
		p2meterx=202,
		p2metery=226,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0x4037F9) == 0
end

function playerTwoFacingLeft()
	return rb(0x4045AD) == 0
end

function playerOneInHitstun()
	return rb(p2combocounter) ~= 0
end

function playerTwoInHitstun()
	return rb(p1combocounter) ~= 0
end

function readPlayerOneHealth(health)
	return rb(p1health1)
end

function writePlayerOneHealth(health)
	wb(p1health1, health)
	wb(p1health2, health)
end

function readPlayerTwoHealth()
	return rb(p2health1)
end

function writePlayerTwoHealth(health)
	wb(p2health1, health)
	wb(p2health2, health)
end

function readPlayerOneMeter()
	return rb(0x403913)
end

function writePlayerOneMeter(meter)
	wb(0x403913, meter)
end

function readPlayerTwoMeter()
	return rb(0x4046C7)
end

function writePlayerTwoMeter(meter)
	wb(0x4046C7, meter)
end

function infiniteTime()
	wb(0x40000A,0x99)
end

function maxCredits()
	wb(0x40655D, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end