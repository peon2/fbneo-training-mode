assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x20
p2maxmeter = 0x20

local p1uid
local p2uid

local healthoffset = 0xBB
local meteroffset = 0xF0
local meteraddoffset = 0x114

local function newRound()
	p1uid = rdw(0x100A46)
	p2uid = rdw(0x100A4A)
end
newRound()

local p1direction = 0x10105c
local p2direction = 0x100ad0

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
				x = 17,
				y = 21,
				enabled = true,
			},
			P2 = {
				x = 292,
				y = 21,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 114,
				y = 208,
				enabled = true,
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
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
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

local timer = 0x100AC6
local timemax = 0x99

function infiniteTime()
	wb(timer, timemax-1)
end

function Run()
	if rb(timer) == timemax then
		newRound()
	end
	infiniteTime()
end