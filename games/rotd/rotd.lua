assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xB4
p2maxhealth = 0xB4

p1maxmeter = 0xD8
p2maxmeter = 0xD8

local p1health = 0x1024CF	-- health + 3 is red health
local p1char2health = 0x1027BF
local p2health = 0x102357
local p2char2health = 0x102067

local p1meter = 0x1024E3
local p2meter = 0x10236B

local p1direction = 0x102427
local p2direction = 0x1022AF

local p1combocounter = 0x102351
local p2combocounter = 0x1024C9

translationtable = {
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
	["Coin"] = 1,
	["Start"] = 2,
	["Select"] = 3,
	["Up"] = 4,
	["Down"] = 5,
	["Left"] = 6,
	["Right"] = 7,
	["Button A"] = 8,
	["Button B"] = 9,
	["Button C"] = 10,
	["Button D"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotextx=146,
		combotexty=37,
		comboenabled=true,
		p1healthx=40,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=268,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=94,
		p1metery=206,
		p1meterenabled=true,
		p2meterx=216,
		p2metery=206,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return bit.band(rb(p1direction), 1)
end

function playerTwoFacingLeft()
	return bit.band(rb(p2direction), 1)
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
	wb(p1health+3, health) -- red health
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
	wb(p2health+3, health) -- red health
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
	memory.writeword(0x106B11, 0x3CFF)
end

function Run() -- runs every frame
	infiniteTime()
end
