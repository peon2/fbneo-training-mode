assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x1000 -- words
p2maxhealth = 0x1000

p1maxmeter = 0x1000
p2maxmeter = 0x1000

local p1health = 0x100468
local p2health = 0x100568

local p1meter = 0x10046A
local p2meter = 0x10056A

local p1direction = 0x10048c
local p2direction = 0x10058c

print "Known Issues: with aof3"
print "Hitstun detector can update a few frames after actually losing health for inconsistent combos"
print "No hitboxes"
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
		combotexty=42,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return false
end

function playerTwoInHitstun()
	return rb(0x1005c3)~=0 -- damage animation?
end

function readPlayerOneHealth()
	return rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
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
	memory.writebyte(0x10DF0F, 0x63)
end

function Run() -- runs every frame
	infiniteTime()
end
