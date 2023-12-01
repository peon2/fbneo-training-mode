assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x7D
p2maxhealth = 0x7D

p1maxmeter = 0x40
p2maxmeter = 0x40

local p1health = 0x108445
local p2health = 0x108655

local p1meter = 0x10844E
local p2meter = 0x10865E

local p1combocounter = 0x108560
local p2combocounter = 0x108770

local p1direction = 0x102b0f
local p2direction = 0x102f0f

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
		combotexty=55,
		comboenabled=true,
		p1healthx=9,
		p1healthy=24,
		p1healthenabled=true,
		p2healthx=284,
		p2healthy=24,
		p2healthenabled=true,
		p1meterx=98,
		p1metery=210,
		p1meterenabled=true,
		p2meterx=203,
		p2metery=210,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	local ptr = rdw(0x108332) -- pointer to some sort of memory block
	return rb(ptr+0xF)==2
end

function playerTwoFacingLeft()
	local ptr = rdw(0x108336) -- pointer to some sort of memory block
	return rb(ptr+0xF)==2
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
	wb(0x10836B, 0x60)
end

function Run()
	infiniteTime()
end