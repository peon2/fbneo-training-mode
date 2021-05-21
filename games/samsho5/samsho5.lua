assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x7D
p2maxhealth = 0x7D

p1maxmeter = 0x40
p2maxmeter = 0x40

local p1health = 0x108445
local p2health = 0x108655

local p1meter = 0x10844E
local p2meter = 0x10865E

local p1combocounter = 0x108560
local p2combocounter = 0x108770

local p1direction = 0x102b0f
local p2direction = 0x102f0f

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
		combotextx=138,
		combotexty=55,
	},
}

function playerOneFacingLeft()
	local ptr = rdw(0x108332) -- pointer to some sort of memory block
	return rb(ptr+0xF)==2
end

function playerTwoFacingLeft()
	local ptr = rdw(0x108336) -- pointer to some sort of memory block
	return rb(ptr+0xF)==2
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
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	wb(0x10836B, 0x60)
end

function Run()
	infiniteTime()
end