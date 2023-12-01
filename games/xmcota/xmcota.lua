assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 0x8E
p2maxmeter = 0x8E

local p1health = 0xFF4191
local p2health = 0xFF4591

local p1meter = 0xFF4195
local p2meter = 0xFF4595

local p1combocounter = 0xFF4110
local p2combocounter = 0xFF4510

local p1direction = 0xFF404d
local p2direction = 0xFF444d

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
		combotextx=180,
		combotexty=42,
		comboenabled=true,
		p1healthx=34,
		p1healthy=20,
		p1healthenabled=true,
		p2healthx=338,
		p2healthy=20,
		p2healthenabled=true,
		p1meterx=170,
		p1metery=30,
		p1meterenabled=true,
		p2meterx=211,
		p2metery=30,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0xFF404d)==0
end

function playerTwoFacingLeft()
	return rb(0xFF444d)==0
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
	return rb(p1meter, meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
end

function readPlayerTwoMeter()
	return rb(p2meter, meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	wb(0xFF4808,0x99)
end

function Run()
	infiniteTime()
end