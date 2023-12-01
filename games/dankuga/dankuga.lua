assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Known issues with dankuga:"
	print "Combos are inconsistent"
end


p1maxhealth = 0x64
p2maxhealth = 0x64

p1maxmeter = 0xc8
p2maxmeter = 0xc8


local p1health = 0x412B35
local p2health = 0x412D35

local p1meter = 0x412BC1
local p2meter = 0x412DC1

local p1combocounter = 0x40cb1f
local p2combocounter = 0x40C91F

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
		combotextx=147,
		combotexty=42,
		comboenabled=true,
		p1healthx=35,
		p1healthy=18,
		p1healthenabled=true,
		p2healthx=274,
		p2healthy=18,
		p2healthenabled=true,
        p1meterx=29,
		p1metery=47,
		p1meterenabled=true,
		p2meterx=278,
		p2metery=47,
		p2meterenabled=true,
	},
}

function Hitboxes()
	wb(0x412B4A,0x3B)
	wb(0x412B4B,0xE4)
end

function playerOneFacingLeft()
	return rb(0x412AE0) == 2
end

function playerTwoFacingLeft()
	return rb(0x412CE0) == 2
end

function playerTwoInHitstun()
	return rb(p1combocounter) ~= 0
end

function playerOneInHitstun()
	return rb(p2combocounter) ~= 0
end

function readPlayerOneHealth(health)
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
	wb(0x409737,0x09)
    wb(0x409733,0x09)
end

function maxCredits()
	wb(0x40E175, 0x09)
end


function Run() -- runs every frame
	infiniteTime()
	maxCredits()
	Hitboxes()
end
