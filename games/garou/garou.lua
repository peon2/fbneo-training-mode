assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x78
p2maxhealth = 0x78

p1maxmeter = 0x80
p2maxmeter = 0x80

local p1direction = 0x100458
local p2direction = 0x100558

function gamemsg()
	print "Known issues with garou:"
	print "hitboxes don't currently work"
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
		combotextx=145,
		combotexty=40,
		comboenabled=true,
		p1healthx=6,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=303,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=90,
		p1metery=208,
		p1meterenabled=true,
		p2meterx=222,
		p2metery=208,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(0x10a39D)~=0
end

function playerTwoInHitstun()
	return rb(0x10a39C)~=0 
end

function readPlayerOneHealth()
	return rb(0x10048E)
end

function writePlayerOneHealth(health)
	wb(0x10048E, health)
end

function readPlayerTwoHealth()
	return rb(0x10058E)
end

function writePlayerTwoHealth(health)
	wb(0x10058E, health)
end

function readPlayerOneMeter()
	return rb(0x1004BE)
end

function writePlayerOneMeter(meter)
	wb(0x1004BE, meter)
end

function readPlayerTwoMeter()
	return rb(0x1005BE)
end

function writePlayerTwoMeter(meter)
	wb(0x1005BE, meter)
end

function infiniteTime()
	wb(0x107490,0x99)
end

function maxCredits()
	wb(0x10E008, 0x09)
	wb(0x10E009, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
