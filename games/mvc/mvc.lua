assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 0x03
p2maxmeter = 0x03

local p1healthchar1 = 0xFF3271
local p1healthchar2 = 0xFF3A71
local p2healthchar1 = 0xFF3671
local p2healthchar2 = 0xFF3E71


local p1meter = 0xFF3274
local p2meter = 0xFF3674

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
		combotexty=45,
		comboenabled=true,
		p1healthx=32,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=341,
		p2healthy=21,
		p2healthenabled=true,
		p1meterx=176,
		p1metery=215,
		p1meterenabled=true,
		p2meterx=205,
		p2metery=215,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0xff344b)==1
end
	
function playerTwoFacingLeft()
		return rb(0xff344b)==0
end

function playerOneInHitstun()
	return rb(0xff3520)~=0
end

function playerTwoInHitstun()
	return rb(0xff3120)~=0
end

function readPlayerOneHealth()
	return rb(p1healthchar1)
end

function readPlayerTwoHealth()
	return rb(p2healthchar1)
end

function writePlayerOneHealth(health)
	wb(p1healthchar1, health)
	wb(p1healthchar2, health)
end

function writePlayerTwoHealth(health)
	wb(p2healthchar1, health)
	wb(p2healthchar2, health)
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
	wb(0xFF4008, 0x99)
end

function Run()
	infiniteTime()
end
