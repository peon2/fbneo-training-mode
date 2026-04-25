assert(rb,"Run fbneo-training-mode.lua")
-- many of these values came from https://github.com/jedpossum/EmuLuaScripts/blob/master/cybots.lua

p1maxhealth = 152
p2maxhealth = 152

p1maxmeter = 63
p2maxmeter = 63

local p1health = 0xFF81E5
local p2health = 0xFF85E5

local p1meter = 0xFF8534
local p2meter = 0xFF8934

local p1direction = 0xFF81A9
local p2direction = 0xFF85A9

local p1state = 0xFF81A4
local p2state = 0xFF85A4
local state = {
	knockdown = 0x08,
	thrown = 0x0C,
	hitstun = 0x10,
}
--[[ Possible addresses related to hitstun or character state
	0xFF85A4
	0xFF85A8
	0xFF85CF
	0xFF85D0
	0xFF86C7
--]]

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
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Low Attack"] = 5,
	["High Attack"] = 6,
	["Boost"] = 7,
	["Weapon"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=38
		},
		health = {
			P1 = {
				x = 33,
				y = 27,
				enabled = true,
			},
			P2 = {
				x = 340,
				y = 27,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 66,
				y = 215,
				enabled = true,
			},
			P2 = {
				x = 311,
				y = 215,
				enabled = true,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth,
			maxmeter = 0
		},
		P2 = {
			maxhealth = p2maxhealth,
			maxmeter = 0
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
			refillhealthspeed = 1
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
			refillhealthspeed = 1
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
	local value = rb(p1state)
	return value == state.hitstun or value == state.thrown or value == state.knockdown
end

function playerTwoInHitstun()
	local value = rb(p2state)
	return value == state.hitstun or value == state.thrown or value == state.knockdown
end

function readPlayerOneHealth()
	return rb(p1health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerOneHealth(health)
	return wb(p1health,health)
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

local timer = 0xFFEBA0
function infiniteTime()
	wb(timer, 0x99)
end

function Run()
	infiniteTime()
	wb(0xff470c, 48) -- set arms to max
	wb(0xff870c, 48) -- set arms to max
end
