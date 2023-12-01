assert(rb,"Run fbneo-training-mode.lua")
-- most of these values came from FlabCaptain's sgemf training mode script

function gamemsg()
	print "Known issues with sgemf:"
	print "Chain combos sometimes won't update the combo counter properly on whiffed attacks."
end

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
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Punch"] = 5,
	["Kick"] = 6,
	["Special"] = 7,
	["Coin"] = 8,
	["Start"] = 9,
}

gamedefaultconfig = {
	hud = {
		combotextx=178,
		combotexty=45,
		comboenabled=true,
		p1healthx=18,
		p1healthy=23,
		p1healthenabled=true,
		p2healthx=355,
		p2healthy=23,
		p2healthenabled=true,
		p1meterx=125,
		p1metery=44,
		p1meterenabled=true,
		p2meterx=257,
		p2metery=44,
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
	infiniteTime()
end