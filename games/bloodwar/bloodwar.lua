assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x87
p2maxhealth = 0x87

local p1health = 0x105f6e
local p2health = 0x1063C0

local p1direction = 0x102A30
local p2direction = 0x102A60

function gamemsg()
	print "Known issues with bloodwar:"
	print "No combo detection"
end

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
	["Fire 1"] = 5,
	["Fire 2"] = 6,
	["Fire 3"] = 7,
	["Fire 4"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		health = {
			P1 = {
				x = 12,
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 298,
				y = 16,
				enabled = true,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth,
		},
		P2 = {
			maxhealth = p2maxhealth,
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 8,
				y = 218,
				enabled = true
			},
			P2 = {
				x = 271,
				y = 218,
				enabled = true
			}
		},
		scrolling = {
			P1 = {
				x = 10,
				y = 66,
				enabled = true
			},
			P2 = {
				x = 281,
				y = 66,
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
	ww(0x105382, 0x6328)
end

function Run() -- runs every frame
	infiniteTime()
end