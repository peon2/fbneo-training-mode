assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x64
p2maxhealth = 0x64

p1maxmeter = 0x3C
p2maxmeter = 0x3C

local p1health = 0x100e56
local p2health = 0x100f56

local p1meter = 0x100e6e
local p2meter = 0x100f6e

local p1direction = 0x100eb9 -- seems to be some sort of lead to animation pointers
local p2direction = 0x100fb9

local p1combocounter = 0x100f5c
local p2combocounter = 0x100e5c

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

function playerOneFacingLeft()
	return rb(p1direction)==2
end

function playerTwoFacingLeft()
	return rb(p2direction)==2
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
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

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
end

function readPlayerTwoMeter()
	return rb(p1meter)
end

function writePlayerTwoMeter(meter)
	wb(p1meter, meter)
end

function infiniteTime()
	ww(0x103a16, 0x9900)
end

function Run() -- runs every frame
	infiniteTime()
end
