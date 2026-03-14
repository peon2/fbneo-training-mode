assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x100
p2maxhealth = 0x100

local p1health = 0xFF55B8
local p2health = 0xFF55F8

local p1direction = 0xFF2F2A 
local p2direction = 0xFF2F4A

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Coin"] = 8,
	["Start"] = 9,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			x=146,
			y=26,
			enabled=true,
		},
		health = {
			P1 = {
				x = 10,
				y = 12,
				enabled = true,
			},
			P2 = {
				x = 299,
				y = 12,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 112,
				y = 226,
				enabled = true,
			},
			P2 = {
				x = 202,
				y = 226,
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
	},
	inputs = {
		simple = {
			P1 = {
				x = 7,
				y = 212,
				enabled = true
			},
			P2 = {
				x = 271,
				y = 212,
				enabled = true
			}
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
	return rb(0xFF57B5)~=0
end

function playerTwoInHitstun()
	return rb(0xFF57F5)~=0
end

local healthhistory = { P1 = {}, P2 = {}} -- the combo counter is 2f behind?
local historydepth = 2
for i = 1, historydepth do
	healthhistory.P1[i] = p1maxhealth
	healthhistory.P2[i] = p2maxhealth
end

function readPlayerOneHealth()
	for i = 1, historydepth do
		healthhistory.P1[i+1] = healthhistory.P1[i]
	end
	healthhistory.P1[1] = rw(p1health)
	return healthhistory.P1[historydepth+1]
end

function readPlayerTwoHealth()
	for i = 1, historydepth do
		healthhistory.P2[i+1] = healthhistory.P2[i]
	end
	healthhistory.P2[1] = rw(p2health)
	return healthhistory.P2[historydepth+1]
end

function writePlayerOneHealth(health)
	ww(p1health, health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
end

local infiniteTime = function()
	wb(0xFF5A9B, 0x63)
end

function Run() -- runs every frame
	infiniteTime()
end
