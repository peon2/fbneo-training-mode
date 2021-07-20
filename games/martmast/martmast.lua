assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xD1
p2maxhealth = 0xD1

p1maxmeter = 0x68
p2maxmeter = 0x68

local p1health = 0x81C67F
local p2health = 0x81C7BB


local p1meter = 0x80DAA1
 
local p2meter = 0x80DC5D

local p1stocks = 0x80DA99
local p2stocks = 0x80DC55




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
		p1healthx=42,
		p1healthy=14,
		p1healthenabled=true,
		p2healthx=395,
		p2healthy=14,
		p2healthenabled=true,
        p1meterx=160,
		p1metery=212,
		p1meterenabled=true,
		p2meterx=272,
		p2metery=212,
		p2meterenabled=true,
	},
}

function playerTwoFacingLeft()
	return rb(0x815A0D) == 0
end

function readPlayerOneHealth(health)
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

function readPlayerOneMeter()
	return rb(0x80DAA1)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
	wb(p1stocks, 0x09)
end

function readPlayerTwoMeter()
	return rb(0x80DC5D)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
	wb(p2stocks, 0x09)
end

function infiniteTime()
	memory.writebyte(0x80AC19,0x64)
end

function maxCredits()
	memory.writebyte(0x81B5B4, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
