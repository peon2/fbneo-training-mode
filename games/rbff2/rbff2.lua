assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xC0
p2maxhealth = 0xC0

p1maxmeter = 0x3C
p2maxmeter = 0x3C

local p1health = 0x10048b
local p2health = 0x10058b

local p1meter = 0x1004BC
local p2meter = 0x1005Bc

local p1direction = 0x100471
local p2direction = 0x100571

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
		combotextx=144,
		combotexty=35,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(0x100490)==0 -- time since damaged?
end

function playerTwoInHitstun()
	return rb(0x100590)==0 -- time since damaged?
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
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	memory.writeword(0x107C28, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
