assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
--many of these values came from https://github.com/maximusmaxy/JoJoban-Training-Mode-Menu-FBNeo

p1maxhealth = 144
p2maxhealth = 144

p1maxmeter = 10
p2maxmeter = 10

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"button5",
	"button6",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Weak Attack"] = 5,
	["Medium Attack"] = 6,
	["Strong Attack"] = 7,
	["Stand"] = 8,
	["Not in use 1"] = 9,
	["Not in use 2"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotextx=176,
		combotexty=35,
		comboenabled=true,
		p1healthx=17,
		p1healthy=15,
		p1healthenabled=true,
		p2healthx=356,
		p2healthy=15,
		p2healthenabled=true,
		p1meterx=132,
		p1metery=216,
		p1meterenabled=true,
		p2meterx=242,
		p2metery=216,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0x2034899)==0
end

function playerTwoFacingLeft()
	return rb(0x2034CB9)==0
end

function playerOneInHitstun()
	return rb(0x205BB39)~=0
end

function playerTwoInHitstun()
	return rb(0x02034D91)~=0
end

function readPlayerOneHealth()
	return rb(0x205BB28)
end

function writePlayerOneHealth(health)
	wb(0x20349CD, health)
end

function readPlayerTwoHealth()
	return rb(0x205BB29)
end

function writePlayerTwoHealth(health)
	wb(0x2034DED, health)
end

function readPlayerOneMeter()
	return rb(0x2034863)--0x205BB63)
end

function writePlayerOneMeter(meter)
	wb(0x2034863, meter)
end

function readPlayerTwoMeter()
	return rb(0x2034887)
end

function writePlayerTwoMeter(meter)
	wb(0x2034887, meter)
end

local infiniteTime = function()
	wb(0x20314B4, 0x63)
end

local infiniteCredit = function()
	wb(0x20713A8, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	infiniteCredit()
end