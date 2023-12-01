assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

function gamemsg()
	print "Note that you have to restart the script whenever characters are switched"
end

p1maxhealth = 0x100
p2maxhealth = 0x100
p1maxmeter = 0x40
p2maxmeter = 0x40

local p1uid = rdw(0x10AC98)
local p2uid = rdw(0x10AC9C)

local p1health = p1uid+0x180 -- word
local p2health = p2uid+0x180

local p1meter = p1uid+0x18D -- byte
local p2meter = p2uid+0x18D

local p1direction = p1uid+0xE3 -- bit
local p2direction = p2uid+0xE3

local p1combocounter = 0x10E294 -- byte
local p2combocounter = 0x10E295

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
		combotexty=48,
		comboenabled=true,
		p1healthx=17,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=292,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=105,
		p1metery=209,
		p1meterenabled=true,
		p2meterx=210,
		p2metery=209,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
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

local infiniteTime = function()
	wb(0x10E32B,0x61)
end

function Run()
	infiniteTime()
end