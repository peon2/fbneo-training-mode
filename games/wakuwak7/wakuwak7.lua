assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xff
p2maxhealth = 0xff

p1maxmeter = 0xff
p2maxmeter = 0xff

local p1health1 = 0x10014A
local p1health2 = 0x10014B

local p2health1 = 0x10028A
local p2health2 = 0x10028B

local p1meter1 = 0x100156
local p1meter2 = 0x100517
 
local p2meter1 = 0x100296
local p2meter2 = 0x100297

local p1stocks = 0x100159
local p2stocks = 0x100299

local p1combocounter = 0x10679d
local p2combocounter = 0x1067c7

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
		combotextx=140,
		combotexty=42,
		comboenabled=true,
		p1healthx=27,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=266,
		p2healthy=21,
		p2healthenabled=true,
		p1meterx=121,
		p1metery=200,
		p1meterenabled=true,
		p2meterx=180,
		p2metery=200,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0x100119) == 0
end

function playerTwoFacingLeft()
	return rb(0x100259) == 0
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
	return rb(0x1004BE)
end

function writePlayerOneMeter(meter)
	wb(p1meter1, meter)
	wb(p1meter2, meter)
	wb(p1stocks, 0x07)
end

function readPlayerTwoMeter()
	return rb(0x1005BE)
end

function writePlayerTwoMeter(meter)
	wb(p2meter1, meter)
	wb(p2meter2, meter)
	wb(p2stocks, 0x07)
end


function infiniteTime()
	wb(0x100B02,0x9B)
end

function maxCredits()
	wb(0xD00034, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
