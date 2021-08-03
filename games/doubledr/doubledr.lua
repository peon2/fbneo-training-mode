assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x6800 -- word
p2maxhealth = 0x6800
-- health tends towards 0x6800 from 0 as damage is taken

print "Known Issues: with doubledr"
print "Flipping the replay when characters swap sides"
print ""

p1maxmeter = 0x40
p2maxmeter = 0x40

local p1health = 0x100450
local p2health = 0x100550

local p1meter = 0x100510
local p2meter = 0x100610

local p1combocounter = 0x10061f
local p2combocounter = 0x10051f

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
		combotextx=142,
		combotexty=50,
		comboenabled=true,
		p1healthx=43,
		p1healthy=24,
		p1healthenabled=true,
		p2healthx=258,
		p2healthy=24,
		p2healthenabled=true,
		p1meterx=120,
		p1metery=35,
		p1meterenabled=true,
		p2meterx=193,
		p2metery=35,
		p2meterenabled=true,
	},
}

function _playerOneFacingLeft()

end

function _playerTwoFacingLeft()

end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function readPlayerOneHealth()
	return p1maxhealth-rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, p1maxhealth-health)
end

function readPlayerTwoHealth()
	return p2maxhealth-rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, p1maxhealth-health)
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
	wb(0x102242, 0x9a)
end

function Run()
	infiniteTime()
	wb(0x108E84,1) -- unlock secret chars
end