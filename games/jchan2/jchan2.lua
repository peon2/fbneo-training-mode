assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run


-- some training mode stuff taken from https://github.com/ehtrashy/Jchan2TrainingScript
-- P1 UID is 0x200F82, P2 UID is 20120E

p1maxhealth = 0x7FFF
p2maxhealth = 0x7FFF

p1maxmeter = 0x4000
p2maxmeter = 0x4000

local p1health = 0x201116 -- signed word
local p2health = 0x2013A2

local p1meter = 0x201200 -- signed word
local p2meter = 0x20148C

local p1combocounter = 0x20143b
local p2combocounter = 0x2011af

local p1prevhealth = rb(p1health)
local p2prevhealth = rb(p2health)

translationtable = {
	{
		"coin",
		"start",
		"select",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Select"] = 3,
	["Up"] = 4,
	["Down"] = 5,
	["Left"] = 6,
	["Right"] = 7,
	["Button 1"] = 8,
	["Button 2"] = 9,
	["Button 3"] = 10,
	["Button 4"] = 11,
}

function playerOneFacingLeft()
	return bit.band(bit.bxor(rb(0x200F86), rb(0x200F90)),0x2)==2 -- flags that check if a sprite needs to be flipped
end

function playerTwoFacingLeft()
	return bit.band(bit.bxor(rb(0x201212), rb(0x20121C)),0x2)==2 -- flags that check if a sprite needs to be flipped
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function readPlayerOneHealth()
	local ret = p1prevhealth
	p1prevhealth = rws(p1health)
	return ret
end

function writePlayerOneHealth(health)
	ww(p1health, health)
end

function readPlayerTwoHealth() -- returns health from 1f ago to be in sync with the combo counter
	local ret = p2prevhealth
	p2prevhealth = rws(p2health)
	return ret
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
end

function readPlayerOneMeter()
	return rws(p1meter)
end

function writePlayerOneMeter(meter)
	ww(p1meter, meter)
end

function readPlayerTwoMeter()
	return rws(p2meter)
end

function writePlayerTwoMeter(meter)
	ww(p2meter, meter)
end

local infiniteTime = function()
	wb(0x200109, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end