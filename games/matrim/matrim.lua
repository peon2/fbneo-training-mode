assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

-- needs more testing

p1maxhealth = 0x95
p2maxhealth = 0x95

p1maxmeter = 240
p2maxmeter = 240

local p1healthaddress = 0x10306B
local p1displayhealth = 0x103069
local p1redhealthaddress = 0x10306F
local p2healthaddress = 0x102E9F
local p2displayhealth = 0x102E9D
local p2redhealthaddress = 0x102EA3

local p1meteraddress = 0x10307D
local p2meteraddress = 0x102EB1

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
		combotextx=146,
		combotexty=32,
		comboenabled=true,
		p1healthx=41,
		p1healthy=12,
		p1healthenabled=true,
		p2healthx=268,
		p2healthy=12,
		p2healthenabled=true,
		p1meterx=122,
		p1metery=207,
		p1meterenabled=true,
		p2meterx=189,
		p2metery=207,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0x103041)==1
end

function playerTwoFacingLeft()
	return rb(0x103041)==0
end

function playerOneInHitstun()
	return rb(0x103085)~=0
end

function playerTwoInHitstun()
	return rb(0x102EB9)~=0
end

function readPlayerOneHealth()
	return rb(p1healthaddress)
end

function writePlayerOneHealth(health)
	wb(p1healthaddress, health)
	wb(p1displayhealth, health)
	wb(p1redhealthaddress, health)
end

function readPlayerTwoHealth()
	return rb(p2healthaddress)
end

function writePlayerTwoHealth(health)
	wb(p2healthaddress, health)
	wb(p2displayhealth, health)
	wb(p2redhealthaddress, health)
	writePlayerTwoMeter(0) -- work around, character softlocks for some reason after gaining two meter
end

function readPlayerOneMeter()
	return rb(p1meteraddress)
end

function writePlayerOneMeter(meter)
	wb(p1meteraddress, meter)
end

function readPlayerTwoMeter()
	return rb(p2meteraddress)
end

function writePlayerTwoMeter(meter)
	wb(p2meteraddress, meter)
end

local infiniteTime = function()
	wb(0x10b90b, 0x63)
end

function Run() -- runs every frame
	infiniteTime()
end