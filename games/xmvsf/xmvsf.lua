assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 3
p2maxmeter = 3

-- p1 char 1 UID is 0xff4000
-- p1 char 2 UID is 0xff4800
local p1health = 0xff4211
local p1redhealth = 0xff421b
local p1char2health = 0xff4a11
local p1char2redhealth = 0xff4a1b
local p1charactive = 0xff4220 -- 0 for point, 1 for anchor

-- p2 char 1 UID is 0xff4400
-- p2 char 2 UID is 0xff4c00
local p2health = 0xff4611
local p2redhealth = 0xff461b
local p2char2health = 0xff4e11
local p2char2redhealth = 0xff4e1b
local p2charactive = 0xff4620 -- 0 for point, 1 for anchor

local p1meter = 0xff4214 -- both chars share the same meter
local p2meter = 0xff4614

local p1combocounter = 0xff4110 -- both chars share the same combo counter
local p2combocounter = 0xff4510

local p1direction = 0xff404b -- 0 is facing left, both chars share the same direction flag
local p2direction = 0xff444b

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
		combotexty=53,
		comboenabled=true,
		p1healthx=157,
		p1healthy=20,
		p1healthenabled=true,
		p2healthx=215,
		p2healthy=20,
		p2healthenabled=true,
		p1meterx=179,
		p1metery=209,
		p1meterenabled=true,
		p2meterx=202,
		p2metery=209,
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
	if (rb(p1charactive)==0) then
		return rb(p1health)
	end
	return rb(p1char2health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
    wb(p1redhealth, health)
    wb(p1char2health, health)
    wb(p1char2redhealth, health)
end

function readPlayerTwoHealth()
	if (rb(p2charactive)==0) then
		return rb(p2health)
	end
	return rb(p2char2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
    wb(p2redhealth, health)
    wb(p2char2health, health)
    wb(p2char2redhealth, health)
end

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
    ww(0xff4212, 0x90) -- percentage of bar
end

function readPlayerTwoMeter()
	return rb(p2meter, meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
    ww(0xff4612, 0x90) -- percentage of bar
end

function infiniteTime()
	wb(0xff5008,0x99)
end

function Run()
	infiniteTime()
end