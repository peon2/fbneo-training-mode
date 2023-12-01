assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Known issues with svc:"
	print "Doesn't activate MAX properly"
end

p1maxhealth = 0xE1 -- offset 1 for magic pixel
p2maxhealth = 0xE1

p1maxmeter = 0x6400 - 0x80
p2maxmeter = 0x6400 - 0x80

local p1health = 0x10A239
local p2health = 0x10A4B9

local p1meter = 0x10A1E8
local p2meter = 0x10A468

local p1direction = 0x10A131
local p2direction = 0x10A3B1

local p1combocounter = 0x10A530
local p2combocounter = 0x10A2B0

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
		combotextx=137,
		combotexty=49,
		comboenabled=true,
		p1healthx=17,
		p1healthy=23,
		p1healthenabled=true,
		p2healthx=276,
		p2healthy=23,
		p2healthenabled=true,
		p1meterx=111,
		p1metery=208,
		p1meterenabled=true,
		p2meterx=173,
		p2metery=208,
		p2meterenabled=true,
	},
	inputs = {
		simpleinputxoffset = {42,205},
		simpleinputyoffset = {190,190},
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==0
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
	return rb(p1health)+1
end

function writePlayerOneHealth(health)
	wb(p1health, health-1)
end

function readPlayerTwoHealth()
	return rb(p2health)+1
end

function writePlayerTwoHealth(health)
	wb(p2health, health-1)
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
	ww(0x10AC14, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
