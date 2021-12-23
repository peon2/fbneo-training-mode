assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x0120
p2maxhealth = 0x0120
p1maxmeter = 0x90
p2maxmeter = 0x90

local p1health = 0xFF8450
local p2health = 0xFF8850
local p1redhealth = 0xFF8452
local p2redhealth = 0xFF8852

local p1meter = 0xFF850A
local p2meter = 0xFF890A

local p1stocks = 0xFF8509
local p2stocks = 0xFF8909

local p1direction = 0xFF8520
local p2direction = 0xFF8920

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
	p1 = {
		instantrefillhealth = false,
		instantrefillmeter = true,
	},
	p2 = {
		instantrefillhealth = false,
		instantrefillmeter = true,
	},
	hud = {
		combotextx=178,
		combotexty=52,
		comboenabled=true,
		p1healthx=18,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=355,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=164,
		p1metery=206,
		p1meterenabled=true,
		p2meterx=209,
		p2metery=206,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction) == 1
end

function playerTwoFacingLeft()
	return rb(p2direction) == 1
end

function playerOneInHitstun()
	return ((rb(0xFF8544)~=0) or (rb(0xFF8545)~=0))
end

function playerTwoInHitstun()
	return ((rb(0xFF8944)~=0) or (rb(0xFF8945)~=0))
end

function readPlayerOneHealth()
	return rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
	ww(p1redhealth, health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
	ww(p2redhealth, health)
end

function readPlayerOneMeter()
	return rw(p1meter)
end

function writePlayerOneMeter(meter)
-- 	ww(p1meter, meter)
	wb(p1stocks, 0x63)
end

function readPlayerTwoMeter()
	return rw(p2meter)
end

function writePlayerTwoMeter(meter)
-- 	ww(p2meter, meter)
	wb(p2stocks, 0x63)
end

local infiniteTime = function()
	wb(0xFF8109, 0x63)
end

function Run() -- runs every frame
	infiniteTime()
end
