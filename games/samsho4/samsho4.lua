assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xFC
p2maxhealth = 0xFC

p1maxmeter = 0x40
p2maxmeter = 0x40

local p1health = 0x108443
local p2health = 0x108643

local p1meter = 0x10844C
local p2meter = 0x10864C

local p1combocounter = 0x10855e
local p2combocounter = 0x10875e

local p1direction = 0x10360f
local p2direction = 0x103a0f

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
		combotextx=147,
		combotexty=55,
		comboenabled=true,
		p1healthx=18,
		p1healthy=20,
		p1healthenabled=true,
		p2healthx=291,
		p2healthy=20,
		p2healthenabled=true,
		p1meterx=106,
		p1metery=209,
		p1meterenabled=true,
		p2meterx=207,
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
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	ww(0x108368, 0x6000)
end

function Run()
	infiniteTime()
end