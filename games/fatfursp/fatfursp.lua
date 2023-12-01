assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x60
p2maxhealth = 0x60

local p1health = 0x10049a
local p2health = 0x10059a

local p1direction = 0x100469
local p2direction = 0x100569

--Note that fatfursp has no meter"

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
		combotextx=144,
		combotexty=35,
		comboenabled=true,
		p1healthx=49,
		p1healthy=17,
		p1healthenabled=true,
		p2healthx=264,
		p2healthy=17,
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
	return rb(0x1004a4)~=0 -- damage animation?
end

function playerTwoInHitstun()
	return rb(0x1005a4)~=0 -- damage animation?
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

function infiniteTime()
	ww(0x10092a, 0x6030)
end

function Run() -- runs every frame
	infiniteTime()
end
