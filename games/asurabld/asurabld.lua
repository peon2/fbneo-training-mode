assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xEF
p2maxhealth = 0xEF

local p1direction = 0x4037F9
local p2direction = 0x4045AD

local p1health1 = 0x403911
local p1health2 = 0x40390F

local p2health1 = 0x4046C3
local p2health2 = 0x4046C5

local p1meter = 0x403913
local p2meter = 0x4046C7

local function setAsuraBladeConstants()
	p1maxmeter = rb(0x403917)
	p2maxmeter = rb(0x4046CB)
end

setAsuraBladeConstants()

local _reloadguipages = false

local function newRound()
	setAsuraBladeConstants() -- get new character data
	setGameConstants() -- update the training mode with that data
	_reloadguipages = true -- if reloading the gui is called here, the script crashes during savestate loading for some reason. Reload the gui during the next Run instance instead
end

local p1combocounter = 0x4041E7
local p2combocounter = 0x40470B

local p1character = 0x403DD1
local p2character = 0x404B85

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
			x=144,
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 24,
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 285,
				y = 16,
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
	return rb(p1health1)
end

function writePlayerOneHealth(health)
	wb(p1health1, health)
	wb(p1health2, health)
end

function readPlayerTwoHealth()
	return rb(p2health1)
end

function writePlayerTwoHealth(health)
	wb(p2health1, health)
	wb(p2health2, health)
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

local timer = 0x40000A
local maxtime = 0x90

function infiniteTime()
	wb(timer, maxtime-7) -- represented in hex internally
end

function maxCredits()
	wb(0x40655D, 0x09)
end

function Run() -- runs every frame
	if (rb(timer) == maxtime) then
		newRound()
	end
	infiniteTime()
	maxCredits()
	if P1SelectCharacter then
		wb(p1character, P1SelectCharacter)
	end
	if P2SelectCharacter then
		wb(p2character, P2SelectCharacter)
	end
	if _reloadguipages then
		_reloadguipages = false
		reloadGUIPages()
	end
end

function OnSaveStateLoad()
	newRound()
end