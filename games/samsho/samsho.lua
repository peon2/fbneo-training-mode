assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Known issues with samsho:"
	print "Issues with reading/writing health and meter"
end

--p1maxhealth = 0x80
--p2maxhealth = 0x80

--p1maxmeter = 0x20
--p2maxmeter = 0x20

--local p1meter = 0x10350f
--local p2meter = 0x10370f

local direction = 0x100a84

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
		combotext = {
			x=180,
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 22,
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 288,
				y = 16,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 22,
				y = 223,
				enabled = true,
			},
			P2 = {
				x = 288,
				y = 223,
				enabled = true,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth,
			maxmeter = p1maxmeter
		},
		P2 = {
			maxhealth = p2maxhealth,
			maxmeter = p2maxmeter
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
		}
	}
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
	wb(0x100A09, 0x63)
end

function Run()
	infiniteTime()
end