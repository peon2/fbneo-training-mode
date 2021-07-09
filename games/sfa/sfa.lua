assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 144
p2maxmeter = 144

local p1health = 0xFF8441
local p1redhealth = 0xFF8443
local p2health = 0xFF8841
local p2redhealth = 0xFF8843

local p1meter = 0xFF84BF
local p2meter = 0xFF88BF

local p1direction = 0xff840b
local p2direction = 0xff880b

local p1combocounter = 0xFF8857
local p2combocounter = 0xFF8457

print "Known issues with sfa:"
print "Combos can be inconsistent"
print ""

translationtable = {
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

gamedefaultconfig = {
	hud = {
		combotextx=176,
		combotexty=42,
		comboenabled=true,
		p1healthx=33,
		p1healthy=20,
		p1healthenabled=true,
		p2healthx=340,
		p2healthy=20,
		p2healthenabled=true,
		p1meterx=164,
		p1metery=207,
		p1meterenabled=true,
		p2meterx=208,
		p2metery=207,
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
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
	wb(p1redhealth, health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
	wb(p2redhealth, health)
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
	ww(0xFFAE09, 0x6300)
end

function Run() -- runs every frame
	infiniteTime()
end
