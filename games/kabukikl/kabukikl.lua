assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x64
p2maxhealth = 0x64

p1maxmeter = 0x3C
p2maxmeter = 0x3C

local p1health = 0x100e56
local p2health = 0x100f56

local p1meter = 0x100e6e
local p2meter = 0x100f6e

local p1direction = 0x100eb9 -- seems to be some sort of lead to animation pointers
local p2direction = 0x100fb9

local p1combocounter = 0x100f5c
local p2combocounter = 0x100e5c

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
		combotextx=140,
		combotexty=42,
		comboenabled=true,
		p1healthx=42,
		p1healthy=17,
		p1healthenabled=true,
		p2healthx=267,
		p2healthy=17,
		p2healthenabled=true,
		p1meterx=119,
		p1metery=209,
		p1meterenabled=true,
		p2meterx=194,
		p2metery=209,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==2
end

function playerTwoFacingLeft()
	return rb(p2direction)==2
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
	return rb(p1meter)
end

function writePlayerTwoMeter(meter)
	wb(p1meter, meter)
end

function infiniteTime()
	ww(0x103a16, 0x9900)
end

function Run() -- runs every frame
	infiniteTime()
end
