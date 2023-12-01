assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

function gamemsg()
	print "Note that you have to restart the script whenever characters are switched"
end

p1maxhealth = 0x100
p2maxhealth = 0x100
p1maxmeter = 0x40
p2maxmeter = 0x40

local p1uid = rdw(0x10E344)
local p2uid = rdw(0x10E348)

local p1health = p1uid+0x17E -- word
local p2health = p2uid+0x17E

local p1meter = p1uid+0x17D -- byte
local p2meter = p2uid+0x17D

local p1direction = p1uid+0x41 -- bit
local p2direction = p2uid+0x41

local p1combocounter = 0x10E486 -- byte
local p2combocounter = 0x10E487

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
		combotextx=147,
		combotexty=36,
		comboenabled=true,
		p1healthx=17,
		p1healthy=17,
		p1healthenabled=true,
		p2healthx=292,
		p2healthy=17,
		p2healthenabled=true,
		p1meterx=106,
		p1metery=209,
		p1meterenabled=true,
		p2meterx=208,
		p2metery=209,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(p2combocounter)>0
end

function playerTwoInHitstun()
	return rb(p1combocounter)>0
end

function readPlayerOneHealth()
	return rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
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

local function infiniteTime()
	wb(0x10E595, 0x60)
end

function Run()
	infiniteTime()
end
