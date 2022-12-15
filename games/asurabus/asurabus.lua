assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xEF
p2maxhealth = 0xEF

p1maxmeter = 0x40
p2maxmeter = 0x40

local p1direction = 0x4033DB
local p2direction = 0x404091

local p1combocounter = 0x403DBD
local p2combocounter = 0x404A7D

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
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Coin"] = 8,
	["Start"] = 9,
}

gamedefaultconfig = {
	hud = {
		combotextx=146,
		combotexty=42,
		comboenabled=true,
		p1healthx=22,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=288,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=22,
		p1metery=223,
		p1meterenabled=true,
		p2meterx=288,
		p2metery=223,
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
	return rb(0x4034EB)
end

function writePlayerOneHealth(health)
	wb(0x4034EB, health)
end

function readPlayerTwoHealth()
	return rb(0x4041A5)
end

function writePlayerTwoHealth(health)
	wb(0x4041A5, health)
end

function readPlayerOneMeter()
	return rb(0x4034EF)
end

function writePlayerOneMeter(meter)
	wb(0x4034EF, meter)
	wb(0x4034F3, meter)
end

function readPlayerTwoMeter()
	return rb(0x4041A9)
end

function writePlayerTwoMeter(meter)
	wb(0x4041AD, meter)
	wb(0x4041A9, meter)
end

function infiniteTime()
	wb(0x40000A, 0x99)
end

function secretCharacters()
	wb(0x408837, 0x01)
	wb(0x408839, 0x01)
end

function Run() -- runs every frame
	infiniteTime()
	secretCharacters()
end