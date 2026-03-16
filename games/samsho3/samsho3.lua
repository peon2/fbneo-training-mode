assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x40
p2maxmeter = 0x40

function gamemsg()
	print "Known issues with samsho3:"
	print "Inconsistent combo counter"
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
			x = 138,
			y = 56,
			enabled = false
		},
		health = {
			P1 = {
				x = 9,
				y = 21,
				enabled = true,
			},
			P2 = {
				x = 284,
				y = 21,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 113,
				y = 208,
				enabled = true,
			},
			P2 = {
				x = 188,
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
	-- eq 0 or 2 0x1085db
	return rb(0x1085db)==2
end

function playerTwoFacingLeft()
	return rb(0x1085db)==0
end

function playerOneInHitstun()
	return rb(0x1085c4)~=0
end

function playerTwoInHitstun()
	return rb(0x10f295)~=0 or rb(0x1086c4)~=0 -- why would ss3 make me do this? 
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
	-- 108561
	--print(rb(0x1086dc))
	infiniteTime()
end