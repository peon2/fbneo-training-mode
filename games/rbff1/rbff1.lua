assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xC0
p2maxhealth = 0xC0

p1maxmeter = 0x3C
p2maxmeter = 0x3C

local p1health = 0x100489
local p2health = 0x100589

local p1meter = 0x1004BA
local p2meter = 0x1005BA

local p1direction = 0x100471
local p2direction = 0x100571

print "Note that fatfursp has no meter"

translationtable = {
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
	hud = {
		combotextx=144,
		combotexty=35,
		comboenabled=true,
		p1healthx=49,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=261,
		p2healthy=21,
		p2healthenabled=true,
		p1meterx=79,
		p1metery=208,
		p1meterenabled=true,
		p2meterx=234,
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
	return rb(0x100490)~=0 -- damage animation?
end

function playerTwoInHitstun()
	return rb(0x100590)~=0 -- damage animation?
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
	memory.writeword(0x106AA8, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
