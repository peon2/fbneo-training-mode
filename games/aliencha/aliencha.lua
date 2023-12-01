assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

local p1health = 0x200fc5
local p2health = 0x2010a7

local p1direction = 0x200f7a
local p2direction = 0x20105C

function gamemsg()
	print "Known issues with aliencha:"
	print "No hitstun detector"
	print "Health display doesn't update"
	print "Note that aliencha has no meter"
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
	"button5",
	"button6",
	"coin",
	"start",
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Button 4"] = 8,
	["Button 5"] = 9,
	["Button 6"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
	["Select"] = 13,
}

gamedefaultconfig = {
	hud = {
		p1healthx=50,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=387,
		p2healthy=21,
		p2healthenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==1
end

--I don't even know if this game has combos
function _playerOneInHitstun()
end

function _playerTwoInHitstun()
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
	ww(0x200f31, 0x6200)
end

function Run() -- runs every frame
	infiniteTime()
end
