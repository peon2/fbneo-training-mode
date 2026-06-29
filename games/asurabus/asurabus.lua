assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xEF
p2maxhealth = 0xEF

p1character = 0x4039A7
p2character = 0x404667

local p1direction = 0x4033DB
local p2direction = 0x404091

local p1combocounter = 0x403DBD
local p2combocounter = 0x404A7D

local p1health = 0x4034EB
local p2health = 0x4041A5

local p1meter = 0x4034EF
local p2meter = 0x4041A9

local function setAsuraBusterConstants()
	p1maxmeter = rb(0x4034F3)
	p2maxmeter = rb(0x4041AD)
end

setAsuraBusterConstants()

local _reloadguipages = false

local function newRound()
	setAsuraBusterConstants() -- get new character data
	setGameConstants() -- update the training mode with that data
	_reloadguipages = true -- if reloading the gui is called here, the script crashes during savestate loading for some reason. Reload the gui during the next Run instance instead
end

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
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 22,
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 288,
				y = 16,
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
	wb(p1health, health)
end

function readPlayerTwoHealth()
	return rb(p2health)
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

local timer = 0x40000A
local maxtime = 0x90

function infiniteTime()
	wb(timer, maxtime-1)
	wb(0x400006, 0x99) -- char select timer
end

function maxCredits()
	wb(0x407A7F, 0x09)
end

function secretCharacters()
	wb(0x408837, 0x01) -- Alice!
	--wb(0x408839, 0x01) -- Nanami
end

P1SelectVebel = false
P2SelectVebel = false

function Run() -- runs every frame
	if (rb(timer) == maxtime) then
		newRound()
	end
	infiniteTime()
	maxCredits()
	secretCharacters()
	if P1SelectVebel then
		wb(p1character, 0x0D)
	end
	if P2SelectVebel then
		wb(p2character, 0x0D)
	end
	if _reloadguipages then
		_reloadguipages = false
		reloadGUIPages()
	end
end

function OnSaveStateLoad()
	newRound()
end