assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x100
p2maxhealth = 0x100
p1maxmeter = 0x40
p2maxmeter = 0x40

local p1health
local p2health

local p1meter
local p2meter

local p1direction
local p2direction

local function setLastBlade2Constants()
	local p1uid = rdw(0x10E344)
	local p2uid = rdw(0x10E348)

	p1health = p1uid+0x17E -- word
	p2health = p2uid+0x17E

	p1meter = p1uid+0x17D -- byte
	p2meter = p2uid+0x17D

	p1direction = p1uid+0x41 -- bit
	p2direction = p2uid+0x41
end

setLastBlade2Constants()

local p1combocounter = 0x10E486 -- byte
local p2combocounter = 0x10E487

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
			y=36,
			enabled=true,
		},
		health = {
			P1 = {
				x = 17,
				y = 17,
				enabled = true,
			},
			P2 = {
				x = 292,
				y = 17,
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
				x = 208,
				y = 209,
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
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(p2combocounter)>0
end

function playerTwoInHitstun()
	return rb(p1combocounter)>0
end

function readPlayerOneHealth()
	return rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
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

local timer = 0x10E595
local maxtime = 0x60

local function infiniteTime()
	wb(timer, maxtime-1)
end

function Run()
	if rb(timer) == maxtime then
		setLastBlade2Constants()
		setGameConstants()
		reloadGUIPages()
	end
	infiniteTime()
end
