assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 104
p2maxhealth = 104

p1maxmeter = 0x60
p2maxmeter = 0x60

function gamemsg()
	print "Known issues with dinorex:"
	print "Infinite meter breaks the game"
	print "No combo counter"
	print "Game is VERY prone to throwing errors"
end

local p1health = 0x605124
local p2health = 0x605190

local p1meter = 0x605123
local p2meter = 0x60518f

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
	["Left"] = 3,
	["Right"] = 4,
	["Up"] = 5,
	["Down"] = 6,
	["Fire 1"] = 7,
	["Fire 2"] = 8,
	["Fire 3"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
}

gamedefaultconfig = {
	combogui = {
		combotextx=180,
		combotexty=42,
	},
}

function _playerOneFacingLeft() -- hahahahaha dino rex doesnt have crossups
end

function _playerTwoFacingLeft()
end

function _playerOneInHitstun() -- I don't think dino rex even has combos
end

function _playerTwoInHitstun()
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	return wb(p1health,health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
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
	wb(0x60826F,0x99)
end

function Run()
	infiniteTime()
end