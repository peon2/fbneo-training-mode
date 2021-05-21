assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x8000
p2maxmeter = 0x8000

local p1health = 0x1092ed
local p2health = 0x1093ed

local p1meter = 0x1094a4
local p2meter = 0x1095a4

local p1direction = 0x1080bd
local p2direction = 0x10847d

print "Known Issues: with aof2"
print "Hitstun detector can be inconsistent"
print ""

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
		combotexty=35,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function _playerOneInHitstun()
end

function playerTwoInHitstun()
	return rb(0x1093C0)==0x06 or rb(0x1093C0)==0x07 -- damage animation?
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
	return rw(p1meter)
end

function writePlayerOneMeter(meter)
	ww(p1meter, meter)
end

function readPlayerTwoMeter()
	return rw(p2meter)
end

function writePlayerTwoMeter(meter)
	ww(p2meter, meter)
end

function infiniteTime()
	memory.writeword(0x108406, 0x5000)
end

function Run() -- runs every frame
	infiniteTime()
end
