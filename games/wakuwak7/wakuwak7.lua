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
	{
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
	},
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
	combogui = {
		combotextx=140,
		combotexty=42,
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
	memory.writebyte(0x100B02,0x9B)
end

function maxCredits()
	memory.writebyte(0xD00034, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
