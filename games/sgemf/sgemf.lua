assert(rb,"Run fbneo-training-mode.lua")
-- most of these values came from FlabCaptain's sgemf training mode script

function gamemsg()
	print "Known issues with sgemf:"
	print "Chain combos sometimes won't update the combo counter properly on whiffed attacks."
end

p1maxhealth = 144
p2maxhealth = 144

local meterbarmax = 96
local meterstockmax = 9

p1maxmeter = meterbarmax*meterstockmax
p2maxmeter = meterbarmax*meterstockmax

local p1health = 0xFF8441
local p2health = 0xFF8841

local p1meterstocks = 0xFF8594
local p1meterbar = 0xFF8595
local p2meterstocks = 0xFF8994
local p2meterbar = 0xFF8995

local p1combocounter = 0xFF8944
local p2combocounter = 0xFF8544

local p1direction = 0xFF840b
local p2direction = 0xFF880b

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
	["Punch"] = 5,
	["Kick"] = 6,
	["Special"] = 7,
	["Coin"] = 8,
	["Start"] = 9,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=46
		},
		health = {
			P1 = {
				x = 18,
				y = 23,
				enabled = true,
			},
			P2 = {
				x = 355,
				y = 23,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 155,
				y = 32,
				enabled = true,
			},
			P2 = {
				x = 219,
				y = 32,
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

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	return wb(p1health,health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function readPlayerOneMeter()
	return rb(p1meterstocks)*meterbarmax + rb(p1meterbar)
end

function writePlayerOneMeter(meter)
	if meter > p1maxmeter then
		meter = p1maxmeter
	end
	local bar = meter%meterbarmax
	local stocks = meter/meterbarmax
	wb(p1meterbar, bar)
	wb(p1meterstocks, stocks)
end

function readPlayerTwoMeter()
	return rb(p2meterstocks)*meterbarmax + rb(p2meterbar)
end

function writePlayerTwoMeter(meter)
	if meter > p2maxmeter then
		meter = p2maxmeter
	end
	local bar = meter%meterbarmax
	local stocks = meter/meterbarmax
	wb(p2meterbar, bar)
	wb(p2meterstocks, stocks)
end

function infiniteTime()
	wb(0xFF8188,0x99)
end

function Run()
	infiniteTime()
end
