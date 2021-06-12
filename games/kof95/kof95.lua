assert(rb,"Run fbneo-training-mode.lua")

print "Known Issues: with kof95"
print "Combos aren't tracked"
print ""

p1maxhealth = 0xCF
p2maxhealth = 0xCF

p1maxmeter = 0x7F
p2maxmeter = 0x7F

local p1health = 0x108221
local p2health = 0x108421

local p1meter = 0x108219
local p2meter = 0x108419

local p1direction = 0x100931
local p2direction = 0x100d31

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
		combotextx=180,
		combotexty=42,
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

function _playerTwoInHitstun()
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
	ww(0x10A836, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
	wb(0x10E79A, 0x1) -- enable hidden chars
end
