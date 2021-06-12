assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 0x8E
p2maxmeter = 0x8E

local p1health = 0xFF4191
local p2health = 0xFF4591

local p1meter = 0xFF4195
local p2meter = 0xFF4595

local p1combocounter = 0xFF4110
local p2combocounter = 0xFF4510

local p1direction = 0xFF404d
local p2direction = 0xFF444d

translationtable = {
	{
		"coin",
		"start",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
		"button5",
		"button6",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Weak Punch"] = 7,
	["Medium Punch"] = 8,
	["Strong Punch"] = 9,
	["Weak Kick"] = 10,
	["Medium Kick"] = 11,
	["Strong Kick"] = 12
}

gamedefaultconfig = {
	combogui = {
		combotextx=180,
		combotexty=42,
	},
}

function playerOneFacingLeft()
	return rb(0xFF404d)==0
end

function playerTwoFacingLeft()
	return rb(0xFF444d)==0
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
	return rb(p1meter, meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
end

function readPlayerTwoMeter()
	return rb(p2meter, meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	memory.writebyte(0xFF4808,0x99)
end

function Run()
	infiniteTime()
end