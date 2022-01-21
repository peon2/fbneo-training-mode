assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x120
p2maxhealth = 0x120
p1maxmeter = 0x63
p2maxmeter = 0x63


local p1health = 0xFF8450
local p2health = 0xFF8850

local p1whitehealth = 0xFF8452
local p2whitehealth = 0xFF8852

local p1meter = 0xFF8509
local p2meter = 0xFF8909

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
		combotextx=176,
		combotexty=42,
		comboenabled=true,
		p1healthx=148,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=225,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=8,
		p1metery=206,
		p1meterenabled=true,
		p2meterx=209,
		p2metery=206,
		p2meterenabled=true,
	},
	p2 = {
		instantrefillhealth = false,
		instantrefillmeter = true,
	},
}

function playerOneFacingLeft()
	return rb(0xFF840B)==0
end

function playerTwoFacingLeft()
	return rb(0xFF880B)==0
end

function playerOneInHitstun()
	return rb(0xFF8544)~=0
end

function playerTwoInHitstun()
	return rb(0xFF8944)~=0
end

function readPlayerOneHealth()
	return rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
	ww(p1whitehealth, health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
	ww(p2whitehealth, health)
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
	ww(0xFF8109, 0x6300)
end

function Run() -- runs every frame
	infiniteTime()
end
