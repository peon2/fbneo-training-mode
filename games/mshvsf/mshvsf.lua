assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90

p1maxmeter = 0x03
p2maxmeter = 0x03

local p1health = 0xFF3A51
local p1redhealth = 0xFF3A5B
local p1char2health = 0xFF4251
local p1char2redhealth = 0xFF425B
local p1charactive = 0xFF3A61 -- 0 for point, 1 for anchor

local p2health = 0xFF3E51
local p2redhealth = 0xFF3E5B
local p2char2health = 0xFF4651
local p2char2redhealth = 0xFF465B
local p2charactive = 0xFF3E61 -- 0 for point, 1 for anchor

local p1meter = 0xFF3A54 -- both chars share the same meter
local p2meter = 0xFF3E54

local p1combocounter = 0xFF4110 -- both chars share the same combo counter
local p2combocounter = 0xFF4510

local p1direction = 0xFF384b -- 0 is facing left
local p1char2direction = 0xFF404b

local p2direction = 0xFF3C4b
local p2char2direction = 0xFF444B

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
		combotexty=32,
		comboenabled=true,
		p1healthx=32,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=341,
		p2healthy=16,
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
	if (rb(p1charactive)==0) then
		return rb(p1direction)==0
	end
	return rb(p1char2direction)==0
end

function playerTwoFacingLeft()
	if (rb(p2charactive)==0) then
		return rb(p2direction)==0
	end
	return rb(p2char2direction)==0
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
end

function readPlayerTwoMeter()
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	wb(0xFF4808, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end

