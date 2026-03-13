assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 0x70
p2maxmeter = 0x70


local p1health = 0xFF83CB
local p2health = 0xFF88CB

local p1meter = 0xFF855F
local p2meter = 0xFF8A5F

local p1stocks = 0xFF8565
local p2stocks = 0xFF8A65

local p1combocounter = 0xFF8A0A
local p2combocounter = 0xFF850A

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
			x=180,
			y=42,
			enabled=true,
		},
		health = {
			P1 = {
				x = 34,
				y = 24,
				enabled = true,
			},
			P2 = {
				x = 339,
				y = 24,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 164,
				y = 34,
				enabled = false,
			},
			P2 = {
				x = 208,
				y = 34,
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
			refillmeterenabled = true
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true
		}
	}
}

function playerOneFacingLeft()
	return rb(p1direction)==1
end

function playerTwoFacingLeft()
	return rb(p2direction)==1
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
	return rw(p1meter)
end

function writePlayerOneMeter(meter)
	ww(p1meter, meter)
	wb(p1stocks, 0x0A)
end

function readPlayerTwoMeter()
	return rw(p2meter)
end

function writePlayerTwoMeter(meter)
	ww(p2meter, meter)
	wb(p2stocks, 0x0A)
end

local infiniteTime = function()
	wb(0xFF8E09, 0x99)
end

local nwarr = {}

initConfigTable("nwarr", nwarr, "config")
createConfigValue(
	"nwarrmusicvolume",
	"musicvolume",
	50,
	nwarr,
	nwarr,
	"config"
)

local maxmusicvolume = 0xFF -- what the maximum volume is in game
local musicvolume = 0xF019

function setMusicVolume(volume) -- squeeze from 0 to 100
	local volume = math.floor( (volume*maxmusicvolume)/100 )
	memory.writebyte_audio(musicvolume, volume)
end

function Run()
	setMusicVolume(nwarr.musicvolume)
	infiniteTime()
end
