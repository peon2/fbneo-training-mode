assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x40
p2maxmeter = 0x40

local p1state = 0x10859B
local p2state = 0x10869B

local state = {
	hitstun = 0,
	neutral = 5,
	launch = 8
}

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
			y = 56,
			enabled = false
		},
		health = {
			P1 = {
				x = 10,
				y = 21,
				enabled = true,
			},
			P2 = {
				x = 283,
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
				x = 184,
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
			refillhealthspeed = 1, -- Samsho3 already has a gradual health fill
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
			instantrefillmeter = true,
			refillmeterenabled = true,
			refillhealthspeed = 1,
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 66,
				y = 185,
				enabled = true
			},
			P2 = {
				x = 179,
				y = 185,
				enabled = true
			}
		}
	}
}

function playerOneFacingLeft()
	return rb(0x1085db)==2
end

function playerTwoFacingLeft()
	return rb(0x1085db)==0
end

function playerOneInHitstun()
	local value = rb(p1state)
	return value == state.hitstun or value == state.launch
end

function playerTwoInHitstun()
	local value = rb(p2state)
	return value == state.hitstun or value == state.launch
end

function readPlayerOneHealth()
	return rb(0x108573)
end

function writePlayerOneHealth(health)
	wb(0x108573, health)
end

function readPlayerTwoHealth()
	return rb(0x108673)
end

function writePlayerTwoHealth(health)
	wb(0x108673, health)
end

function readPlayerOneMeter()
	return rb(0x10857c)
end

function writePlayerOneMeter(meter)
	wb(0x10857c, meter)
end

function readPlayerTwoMeter()
	return rb(0x10867c)
end

function writePlayerTwoMeter(meter)
	wb(0x10867c, meter)
end

local infiniteTime = function()
	wb(0x10849e, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end