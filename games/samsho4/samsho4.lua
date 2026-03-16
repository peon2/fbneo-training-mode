assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xFC
p2maxhealth = 0xFC

p1maxmeter = 0x40
p2maxmeter = 0x40

local p1health = 0x108443
local p2health = 0x108643

local p1meter = 0x10844C
local p2meter = 0x10864C

local p1data -- some sort of memory block
local p2data
local hitstunoffset = 0x20
local directionoffset = 0x0F

local function newRound()
	p1data = rdw(0x108330) -- always seems to be 0x103600
	p2data = rdw(0x108334) -- always seems to be 0x103A00
end

newRound()

--local p1combocounter = 0x10855e
--local p2combocounter = 0x10875e


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
			y=50,
			enabled=true,
		},
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
				x = 106,
				y = 209,
				enabled = true,
			},
			P2 = {
				x = 207,
				y = 209,
				enabled = true,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth,
			maxmeter = p1maxmeter,
			refillhealthspeed = 1, -- Samsho4 already has a gradual health fill
		},
		P2 = {
			maxhealth = p2maxhealth,
			maxmeter = p2maxmeter,
			refillhealthspeed = 1,
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
			instantrefillmeter = true,
			refillmeterenabled = true,
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 58,
				y = 193,
				enabled = true
			},
			P2 = {
				x = 205,
				y = 193,
				enabled = true
			}
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

local timer = 0x108368
local maxtime = 0x60

function infiniteTime()
	wb(timer, maxtime-1)
end

function Run()
	if (rb(timer) == maxtime) then
		newRound()
	end
	infiniteTime()
end