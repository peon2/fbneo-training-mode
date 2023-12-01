assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x8000 -- words
p2maxmeter = 0x8000

local p1health = 0x1092cd
local p2health = 0x1093cd

local p1meter = 0x1094a4
local p2meter = 0x1095a4

function gamemsg()
	print "Known issues with aof:"
	print "Hitstun detector can be inconsistent"
	print "No sideswap on replays"
end

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
	["Button A"] = 5,
	["Button B"] = 6,
	["Button C"] = 7,
	["Button D"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotextx=138,
		combotexty=35,
		comboenabled=true,
		p1healthx=10,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=282,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=10,
		p1metery=25,
		p1meterenabled=true,
		p2meterx=275,
		p2metery=25,
		p2meterenabled=true,
	},
}

function _playerOneFacingLeft()
end

function _playerTwoFacingLeft()
end

function playerOneInHitstun()
	return rb(0x1093C0)==0x02 or rb(0x1093C0)==0x04 -- damage animation?
end

function playerTwoInHitstun()
	return rb(0x1093C0)==0x40 -- damage animation?
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function readPlayerOneMeter()
	return rw(p1meter)
end

function writePlayerOneMeter(meter)
	ww(p1meter, meter)
end

function readPlayerTwoMeter()
	return rw(p2meter)
end

function writePlayerTwoMeter(meter)
	ww(p2meter, meter)
end

function infiniteTime()
	ww(0x108406, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
