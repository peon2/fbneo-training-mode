assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Note that meter only visually updates when the character is hit"
end

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x20
p2maxmeter = 0x20

local p1uid
local p2uid

local healthoffset = 0xA5
local meteroffset = 0xCD
local meteraddoffset = 0xAC -- actually updates the meter

local function newRound()
	p1uid = rdw(0x100A0A)
	p2uid = rdw(0x100A0E)
end

newRound()

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
		health = {
			P1 = {
				x = 18,
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 291,
				y = 20,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 114,
				y = 208,
				enabled = false,
			},
			P2 = {
				x = 199,
				y = 208,
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
			instantrefillhealth = true,
			refillhealthenabled = true,
			instantrefillmeter = true,
			refillmeterenabled = true,
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
			instantrefillmeter = true,
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

function readPlayerOneHealth()
	return rb(p1uid + healthoffset)
end

function writePlayerOneHealth(health)
	wb(p1uid + healthoffset, health)
end

function readPlayerTwoHealth()
	return rb(p2uid + healthoffset)
end

function writePlayerTwoHealth(health)
	wb(p2uid + healthoffset, health)
end

function readPlayerOneMeter()
	return rb(p1uid + meteroffset)
end

function writePlayerOneMeter(meter)
	wb(p1uid + meteraddoffset, meter - rb(p1uid + meteroffset))
end

function readPlayerTwoMeter()
	return rb(p2uid + meteroffset)
end

function writePlayerTwoMeter(meter)
	wb(p2uid + meteraddoffset, meter - rb(p2uid + meteroffset))
end

local timer = 0x100A08
local maxtime = 0x99

function infiniteTime()
	wb(timer, maxtime-1)
end

function Run()
	if rb(timer) == maxtime then
		newRound()
	end
	infiniteTime()
end