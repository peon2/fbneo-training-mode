assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x60
p2maxhealth = 0x60

local p1health = 0x10049a
local p2health = 0x10059a

local p1dizzy = 0x1004a4
local p2dizzy = 0x1005a4

local p1direction = 0x100469
local p2direction = 0x100569

--Note that fatfursp has no meter"

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
			x=144,
			y=35,
			enabled=true,
		},
		health = {
			P1 = {
				x = 49,
				y = 17,
				enabled = true,
			},
			P2 = {
				x = 264,
				y = 17,
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
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

-- Thanks to Guruslum for these hitstun values
function playerOneInHitstun()
	return (rb(0x1004A0) + bit.band(rb(0x1004FD), 0x3F))~=0
end

function playerTwoInHitstun()
	return (rb(0x1005A0) + bit.band(rb(0x1005FD), 0x3F))~=0
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

function infiniteTime()
	ww(0x10092a, 0x6030)
end

function Run() -- runs every frame
	infiniteTime()
end
