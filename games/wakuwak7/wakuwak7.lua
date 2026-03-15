assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xff
p2maxhealth = 0xff

local meterbarmax = 0xFFFF
local meterstockmax = 7

p1maxmeter = meterbarmax*meterstockmax
p2maxmeter = meterbarmax*meterstockmax

local p1health = 0x10014A
local p2health = 0x10028A

local p1meterbar = 0x100156
local p1meterstocks = 0x100159

local p2meterbar = 0x100296
local p2meterstocks = 0x100299

local p1combocounter = 0x10679d
local p2combocounter = 0x1067c7

local p1direction = 0x100119
local p2direction = 0x100259

character = {
	RAI	= 0,
	ARINA = 1,
	SLASH = 2,
	DANDY_J = 3,
	TESS = 4,
	MAURU = 5,
	POLITANK_Z = 6,
	FERNANDEZ = 7,
	BONUS_KUN = 8
}
local p1characterid = 0x106997
local p2characterid = 0x1069A1
p1characterpick = nil
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
			x=140,
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 27,
				y = 21,
				enabled = true,
			},
			P2 = {
				x = 266,
				y = 21,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 98,
				y = 191,
				enabled = false,
			},
			P2 = {
				x = 185,
				y = 191,
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
			refillmeterenabled = true,
			refillmeterspeed = 1
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
			refillmeterspeed = 1
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction) == 0
end

function playerTwoFacingLeft()
	return rb(p2direction) == 0
end

function playerOneInHitstun()
	return rb(p2combocounter) ~= 0
end

function playerTwoInHitstun()
	return rb(p1combocounter) ~= 0
end

function readPlayerOneHealth(health)
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
	return rb(p1meterstocks)*meterbarmax + rw(p1meterbar)
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
	return rb(p2meterstocks)*meterbarmax + rw(p2meterbar)
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

local function infiniteTime()
	wb(0x100B02, 0x9B)
end

local function maxCredits()
	wb(0xD00034, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
	if p1characterpick then
		wb(p1characterid, p1characterpick)
	end
	if p2characterpick then
		wb(p2characterid, p2characterpick)
	end
end