assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xC0
p2maxhealth = 0xC0

p1maxmeter = 0x3C
p2maxmeter = 0x3C

local p1health = 0x10048b
local p2health = 0x10058b

local p1meter = 0x1004BC
local p2meter = 0x1005Bc

local p1direction = 0x100471
local p2direction = 0x100571

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
		combotextx=144,
		combotexty=40,
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
	return rb(0x100490)==0 -- time since damaged?
end

function playerTwoInHitstun()
	return rb(0x100590)==0 -- time since damaged?
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
	ww(0x107C28, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
