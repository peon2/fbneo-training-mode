assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 0x30
p2maxmeter = 0x30

local p1health = 0xFF8478
local p1redhealth = 0xff847A
local p1disphealth = 0xff860A
local p2health = 0xFF8878
local p2redhealth = 0xFF887A
local p2disphealth = 0xFF8A0A

local p1meter = 0xFF8702
local p2meter = 0xFF8B02

translationtable = {
	{
		"coin",
		"start",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
		"button5",
		"button6",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Weak Punch"] = 7,
	["Medium Punch"] = 8,
	["Strong Punch"] = 9,
	["Weak Kick"] = 10,
	["Medium Kick"] = 11,
	["Strong Kick"] = 12
}

function playerOneFacingLeft()
	return rw(0xFF8454) >= rw(0xFF8854)
end

function playerTwoFacingLeft()
	return rw(0xFF8454) < rw(0xFF8854)
end

function playerOneInHitstun()
	return rb(0xff84ad)~=0
end

function playerTwoInHitstun()
	return rb(0xff88ad)~=0
end

function readPlayerOneHealth()
	return rw(p1redhealth)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
	ww(p1redhealth, health)
	ww(p1disphealth, health)
end

function readPlayerTwoHealth()
	return rw(p2redhealth)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
	ww(p2redhealth, health)
	ww(p2disphealth, health)
end

function readPlayerOneMeter()
	if rw(0xFF8008) == 0xa then
		return rb(p1meter)
	else
		return p1maxmeter
	end
end

function writePlayerOneMeter(meter)
	if rw(0xFF8008) == 0xa then
		wb(p1meter, meter)
	end
end

function readPlayerTwoMeter()
	if rw(0xFF8008) == 0xa then
		return rb(p2meter)
	else
		return p2maxmeter
	end
end

function writePlayerTwoMeter(meter)
	if rw(0xFF8008) == 0xa then
		wb(p2meter, meter)
	end
end

local infiniteTime = function()
	timer = rb(0xff8dce)
	if (timer < 0x98) then
		ww(0xff8dce,0x9928)
	end
end

local neverEnd = function()
	if combovars.p1.refillmeterenabled and readPlayerOneHealth() < 2 then
		writePlayerOneHealth(p1maxhealth)
	end
	if combovars.p2.refillmeterenabled and readPlayerTwoHealth() < 2 then
		writePlayerTwoHealth(p1maxhealth)
	end
end

function Run() -- runs every frame
	infiniteTime()
	neverEnd()
end
