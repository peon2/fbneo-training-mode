assert(rb,"Run fbneo-training-mode.lua")
-- most of these values came from FlabCaptain's sgemf training mode script

print "Known Issues: with sgemf"
print "Chain combos sometimes won't update the combo counter properly on whiffed attacks."
print ""

p1maxhealth = 144
p2maxhealth = 144

p1maxmeter = 96
p2maxmeter = 96

local p1health = 0xFF8441
local p2health = 0xFF8841

local p1meter = 0xFF8595
local p2meter = 0xFF8995

local p1combocounter = 0xFF8944
local p2combocounter = 0xFF8544

local p1direction = 0xFF840b
local p2direction = 0xFF880b

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
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Punch"] = 7,
	["Kick"] = 8,
	["Special"] = 9,
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
	return rb(p1combocounter) ~= 0
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	return wb(p1health,health)
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
	wb(0xFF8188,0x99)
end

function Run()
	gui.text(50,50, rb(p1combocounter))
	infiniteTime()
end