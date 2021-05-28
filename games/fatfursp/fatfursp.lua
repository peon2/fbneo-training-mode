assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x60
p2maxhealth = 0x60

local p1health = 0x10049a
local p2health = 0x10059a

local p1direction = 0x100469
local p2direction = 0x100569

print "Note that fatfursp has no meter"

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
	return rb(0x1004a4)~=0 -- damage animation?
end

function playerTwoInHitstun()
	return rb(0x1005a4)~=0 -- damage animation?
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

function infiniteTime()
	memory.writeword(0x10092a, 0x6030)
end

function Run() -- runs every frame
	infiniteTime()
end
