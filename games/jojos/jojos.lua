assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
--many of these values came from https://github.com/maximusmaxy/JoJoban-Training-Mode-Menu-FBNeo

p1maxhealth = 144
p2maxhealth = 144

p1maxmeter = 10
p2maxmeter = 10

translationtable = {
	{
		"coin",
		"start",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
		"button5",
		"button6",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Weak Attack"] = 7,
	["Medium Attack"] = 8,
	["Strong Attack"] = 9,
	["Stand"] = 10,
	["Not in use 1"] = 11,
	["Not in use 2"] = 12,
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