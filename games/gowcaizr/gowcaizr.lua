assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x64
p2maxhealth = 0x64

local p1health = 0x102D09
local p2health = 0x1035Bf

local p1direction = 0x100186
local p2direction = 0x100187

function gamemsg()
	print "Known issues with gowcaizr:"
	print "Inconsistent combos"
	print "Note that gowcaizr has no meter"
end

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
		combotextx=138,
		combotexty=42,
		comboenabled=true,
		p1healthx=35,
		p1healthy=17,
		p1healthenabled=true,
		p2healthx=258,
		p2healthy=17,
		p2healthenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0x80 -- seems to work off a flag at 0b00000010
end

function playerTwoFacingLeft()
	return rb(p2direction)==0x80
end

function playerOneInHitstun()
	return rb(0x10328c)==0x80 or rb(0x103b42)==0x80 -- hitstun flag?
end

function playerTwoInHitstun()
	return rb(0x103a90)==0x80 or rb(0x103a1b)==0x80 -- hitstun flag?
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
	wb(0x1062E1, 0x3C)
end

function Run() -- runs every frame
	infiniteTime()
end
