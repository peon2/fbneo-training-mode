assert(rb,"Run fbneo-training-mode.lua")

--p1maxhealth = 0x80
--p2maxhealth = 0x80

--p1maxmeter = 0x20
--p2maxmeter = 0x20

--local p1meter = 0x10350f
--local p2meter = 0x10370f

local direction = 0x100a84

translationtable = {
	{
		"coin",
		"start",
		"select",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Select"] = 3,
	["Up"] = 4,
	["Down"] = 5,
	["Left"] = 6,
	["Right"] = 7,
	["Button A"] = 8,
	["Button B"] = 9,
	["Button C"] = 10,
	["Button D"] = 11,
}

function playerOneFacingLeft()
	return rb(direction)==1
end

function playerTwoFacingLeft()
	return rb(direction)==0
end

function _playerOneInHitstun()
end

function _playerTwoInHitstun()
end

function _readPlayerOneHealth()
--[[

local p1health = 0x1034e7
local p2health = 0x1036e7


001046: movea.l (A7)+, A6 -- 0x00102142
.
.
.
001070: move.l  A6, D0
001072: move.w  ($6,A6), D0
001076: movea.l D0, A6
.
.
. 104242
00532A: sub.w   D0, ($a4,A6)
]]--

	--local ptr = 0x00102142 -- A6
	--return rw(bit.bor(rw(ptr+0x6), bit.band(ptr, 0xFFFF0000))+0xa2)
end

function _writePlayerOneHealth(health)
end

function _readPlayerTwoHealth()
	return rb(p2health)
end

function _writePlayerTwoHealth(health)
	wb(p2health, health)
end

function _readPlayerOneMeter()
	return rb(p1meter)
end

function _writePlayerOneMeter(meter)
	wb(p1meter, meter)
end

function _readPlayerTwoMeter()
	return rb(p2meter)
end

function _writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	memory.writebyte(0x100A09, 0x63)
end

function Run()
	gui.text(50,50,readPlayerOneHealth())
	infiniteTime()
end