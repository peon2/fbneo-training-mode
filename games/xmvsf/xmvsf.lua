assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 3
p2maxmeter = 3

-- p1 char 1 UID is 0xff4000
-- p1 char 2 UID is 0xff4800
local p1health = 0xff4211
local p1redhealth = 0xff421b
local p1char2health = 0xff4a11
local p1char2redhealth = 0xff4a1b
local p1charactive = 0xff4220 -- 0 for point, 1 for anchor

-- p2 char 1 UID is 0xff4400
-- p2 char 2 UID is 0xff4c00
local p2health = 0xff4611
local p2redhealth = 0xff461b
local p2char2health = 0xff4e11
local p2char2redhealth = 0xff4e1b
local p2charactive = 0xff4620 -- 0 for point, 1 for anchor

local p1meter = 0xff4214 -- both chars share the same meter
local p2meter = 0xff4614

local p1combocounter = 0xff4110 -- both chars share the same combo counter
local p2combocounter = 0xff4510

local p1direction = 0xff404b -- 0 is facing left, both chars share the same direction flag
local p2direction = 0xff444b

character = {
	WOLVERINE		= 0x00,
	CYCLOPS			= 0x02,
	STORM			= 0x04,
	ROGUE			= 0x06,
	GAMBIT			= 0x08,
	SABRETOOTH		= 0x0A,
	JUGGERNAUT		= 0x0C,
	MAGNETO			= 0x0E,
	APOCALYPSE		= 0x10,
	RYU				= 0x12,
	KEN				= 0x14,
	CHUN_LI			= 0x16,
	DHALSIM			= 0x18,
	ZANGIEF			= 0x1A,
	M_BISON			= 0x1C,
	AKUMA			= 0x1E,
	CHARLIE			= 0x20,
	CAMMY			= 0x22,
	ALPHA_CHUN_LI	= 0x24
}
local p1characterid = 0xFF4053
local p2characterid = 0xFF4453
p1characterpick = nil -- don't really need to save these
p2characterpick = nil

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
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Weak Punch"] = 5,
	["Medium Punch"] = 6,
	["Strong Punch"] = 7,
	["Weak Kick"] = 8,
	["Medium Kick"] = 9,
	["Strong Kick"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=53,
		},
		health = {
			P1 = {
				x = 157,
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 215,
				y = 20,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 179,
				y = 209,
				enabled = false,
			},
			P2 = {
				x = 202,
				y = 209,
				enabled = false,
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
			refillmeterenabled = true
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function readPlayerOneHealth()
	if (rb(p1charactive)==0) then
		return rb(p1health)
	end
	return rb(p1char2health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
    wb(p1redhealth, health)
    wb(p1char2health, health)
    wb(p1char2redhealth, health)
end

function readPlayerTwoHealth()
	if (rb(p2charactive)==0) then
		return rb(p2health)
	end
	return rb(p2char2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
    wb(p2redhealth, health)
    wb(p2char2health, health)
    wb(p2char2redhealth, health)
end

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
    ww(0xff4212, 0x90) -- percentage of bar
end

function readPlayerTwoMeter()
	return rb(p2meter, meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
    ww(0xff4612, 0x90) -- percentage of bar
end

local function infiniteTime()
	wb(0xff5008,0x99)
end

function Run()
	infiniteTime()
	if p1characterpick then
		wb(p1characterid, p1characterpick)
	end
	if p2characterpick then
		wb(p2characterid, p2characterpick)
	end
end
