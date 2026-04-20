assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 0x50
p2maxmeter = 0x50

local p1health = 0xFF83CB
local p2health = 0xFF87CB

local p1meter = 0xFF855F
local p2meter = 0xFF895F

local p1direction = 0xFF830C
local p2direction = 0xFF830D

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"button5",
	"button6",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Weak Punch"] = 5,
	["Medium Punch"] = 6,
	["Strong Punch"] = 7,
	["Weak Kick"] = 8,
	["Medium Kick"] = 9,
	["Strong Kick"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=49,
			enabled=true,
		},
		health = {
			P1 = {
				x = 30,
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 342,
				y = 20,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 136,
				y = 212,
				enabled = false,
			},
			P2 = {
				x = 241,
				y = 212,
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
			refillhealthspeed = 1
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
			refillhealthspeed = 1
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
	return rb(0xFF84FD)~=0
end

function playerTwoInHitstun()
	return rb(0xFF88FD)~=0
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

local infiniteTime = function()
	wb(0xFF9409, 0x99)
end

local dstlk = {}

initConfigTable("dstlk", dstlk, "config")
createConfigValue(
	"dstlkmusicvolume",
	50,
	dstlk,
	"musicvolume"
)

local maxmusicvolume = 0xFF -- what the maximum volume is in game
local musicvolume = 0xF019

function setMusicVolume(volume) -- squeeze from 0 to 100
	local volume = math.floor( (volume*maxmusicvolume)/100 )
	memory.writebyte_audio(musicvolume, volume)
end

function Run()
	setMusicVolume(dstlk.musicvolume)
	infiniteTime()
end
