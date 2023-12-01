assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 0x70
p2maxmeter = 0x70


local p1health = 0xFF83CB
local p2health = 0xFF88CB

local p1meter = 0xFF855F
local p2meter = 0xFF8A5F

local p1stocks = 0xFF8565
local p2stocks = 0xFF8A65

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
		p1healthx=34,
		p1healthy=24,
		p1healthenabled=true,
		p2healthx=339,
		p2healthy=24,
		p2healthenabled=true,
		p1meterx=164,
		p1metery=34,
		p1meterenabled=true,
		p2meterx=208,
		p2metery=34,
		p2meterenabled=true,
	},
}

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
	return rw(p1meter)
end

function writePlayerOneMeter(meter)
	ww(p1meter, meter)
	wb(p1stocks, 0x0A)
end

function readPlayerTwoMeter()
	return rw(p2meter)
end

function writePlayerTwoMeter(meter)
	ww(p2meter, meter)
	wb(p2stocks, 0x0A)
end

local infiniteTime = function()
	wb(0xFF8E09, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end
