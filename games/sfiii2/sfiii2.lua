assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0xA000
p2maxhealth = 0xA000
p1maxmeter = 0xA0
p2maxmeter = 0xA0


local p1health = 0x200E5A3
local p2health = 0x200E9AF

local p1meter = 0x200ED35
local p2meter = 0x200ED61

local p1direction = 0x200E50E 
local p2direction = 0x200E91A 

local p1combocounter = 0x200E52B 
local p2combocounter = 0x200ED9D

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"button5",
	"button6",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Weak Punch"] = 5,
	["Medium Punch"] = 6,
	["Strong Punch"] = 7,
	["Weak Kick"] = 8,
	["Medium Kick"] = 9,
	["Strong Kick"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotextx=179,
		combotexty=42,
		comboenabled=true,
		p1healthx=33,
		p1healthy=18,
		p1healthenabled=true,
		p2healthx=340,
		p2healthy=18,
		p2healthenabled=true,
		p1meterx=176,
		p1metery=210,
		p1meterenabled=true,
		p2meterx=205,
		p2metery=210,
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
	wb(0x2010167, 0x63)
end

function Run() -- runs every frame
	infiniteTime()
end
