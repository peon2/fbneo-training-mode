assert(rb,"Run fbneo-training-mode.lua")

print "Known Issues: with mwarr"
print "Messing with player inputs (recording, replaying, opening the menu) freezes the game"
print "Game unfreezes when controls are returned back to normal"
print ""

p1maxhealth = 0x0100 -- word
p2maxhealth = 0x0100

p1maxmeter = 0x0300 -- word
p2maxmeter = 0x0300

local p1health = 0x112fce
local p2health = 0x112fd0
-- 112fcf p2 bar?

local p1meter = 0x113684
local p2meter = 0x113686

local p1direction = 0x112f5e
local p2direction = 0x112f60

-- table of recovery(?) counters(?) that starts at 0x1128ff 
-- 0x1128ff: XX00 XX00 XX00 XX00 XX00 XX00 XX00 XX00
-- 0x11290f: XX00 XX00 [about this in size]
-- I've never seen anything that's not a move use more than the first 4 bytes, but I think if two characters do some action together it could go over it
-- this table also applies to p2, but this will work as an easy workaround for combos for now
local p1recovery = (0x1128ff+0x8)

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
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Button 1"] = 7,
	["Button 2"] = 8,
	["Button 3"] = 8,
}

function playerOneFacingLeft()
	return rb(p1direction)==2
end

function playerTwoFacingLeft()
	return rb(p2direction)==2
end

function _playerOneInHitstun()
end

function playerTwoInHitstun()
	return rb(p1recovery)~=0
end

function readPlayerOneHealth()
	return rw(p1health)
end

function writePlayerOneHealth(health)
	return ww(p1health,health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
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
	wb(0x112121,0x95)
end

function Run()
	infiniteTime()
end