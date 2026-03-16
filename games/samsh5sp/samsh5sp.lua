assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x7D
p2maxhealth = 0x7D

p1maxmeter = 0x40
p2maxmeter = 0x40

local p1health = 0x108445
local p2health = 0x108655

local p1meter = 0x10844E
local p2meter = 0x10865E

local p1data -- some sort of memory block
local p2data
local hitstunoffset = 0x20
local directionoffset = 0x0F
local function newRound()
	p1data = rdw(0x108332) -- always seems to be 0x102B00
	p2data = rdw(0x108336) -- always seems to be 0x102F00
end

newRound()

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
				x = 9,
				y = 24,
				enabled = true,
			},
			P2 = {
				x = 284,
				y = 24,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 98,
				y = 210,
				enabled = true,
			},
			P2 = {
				x = 199,
				y = 210,
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
	return rb(p1data + directionoffset)==2
end

function playerTwoFacingLeft()
	return rb(p2data + directionoffset)==2
end

function playerOneInHitstun()
	return rb(p1data+hitstunoffset)==3
end

function playerTwoInHitstun()
	return rb(p2data+hitstunoffset)==3
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
	wb(0x10836B, 0x3C)
end
-- TODO add these as guipages options
function longSwordGauge() -- Longest sword gauge/rage explode length
    wb(0x108554, 0x82)
    wb(0x108764, 0x82)
end

function maxSwordGaugeCharge() -- Can confirm this is max sword guage
    wb(0x1085F8, 0x78)
    wb(0x108808, 0x78)
end

function maxTimeSlow() -- Full Time Slow
    wb(0x1085FE, 0x7C)
    wb(0x10880E, 0x7C)
end

-- function maxRage() -- Full Rage
--     wb(0x10844E, 0x40)
--     wb(0x10865E, 0x40)
-- end

function Run() -- runs every frame
	infiniteTime()
    longSwordGauge()
    maxSwordGaugeCharge()
    maxTimeSlow()
    -- maxRage()
end