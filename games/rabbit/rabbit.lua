assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x88
p2maxhealth = 0x88

p1maxmeter = 0x03
p2maxmeter = 0x03

local p1health = 0xFF24EF

local p2health = 0xFF2533

local p1combocounter = 0xFF2525

local p2combocounter = 0xFF2569

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"coin",
	"start",
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Button 4"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotextx=138,
		combotexty=42,
		comboenabled=true,
		p1healthx=9,
		p1healthy=12,
		p1healthenabled=true,
		p2healthx=300,
		p2healthy=12,
		p2healthenabled=true,
        p1meterx=22,
		p1metery=223,
		p1meterenabled=true,
		p2meterx=288,
		p2metery=223,
		p2meterenabled=true,
	},
}

function playerOneFacingleft()
	return rb(0xFF1C25) == 0
end

function playerTwoFacingLeft()
	return rb(0xFF2025) == 0
end

function playerOneInHitstun()
	return rb(p2combocounter) ~= 0
end

function playerTwoInHitstun()
	return rb(p1combocounter) ~= 0
end

function readPlayerOneHealth(health)
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function readPlayerTwoHealth(health)
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function readPlayerOneMeter()
	return rb(0xFF24FA)
end

function writePlayerOneMeter(meter)
	wb(0xFF24FA, meter)
end

function readPlayerTwoMeter()
	return rb(0xFF253F)
end

function writePlayerTwoMeter(meter)
	wb(0xFF253F, meter)
end

function infiniteTime()
	wb(0xFF2570,0x99)
end

function maxCredits()
	wb(0xFFFE48, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
