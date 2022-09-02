assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

function gamemsg()
	print "It's recommended to run characters health refill option on 'Health Always Full'"
end

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 0x50
p2maxmeter = 0x50

local p1health = 0xFF83CB
local p2health = 0xFF87CB

local p1meter = 0xFF855F
local p2meter = 0xFF895F

local p1direction = 0xFF830C
local p2direction = 0xFF830D

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
		combotextx=178,
		combotexty=49,
		comboenabled=true,
		p1healthx=30,
		p1healthy=20,
		p1healthenabled=true,
		p2healthx=342,
		p2healthy=20,
		p2healthenabled=true,
		p1meterx=136,
		p1metery=212,
		p1meterenabled=true,
		p2meterx=241,
		p2metery=212,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction) == 0
end

function playerTwoFacingLeft()
	return rb(p2direction) == 0
end

function playerOneInHitstun()
	return rb(0xFF84FD)~=0
end

function playerTwoInHitstun()
	return rb(0xFF88FD)~=0
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

local infiniteTime = function()
	wb(0xFF9409, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end
