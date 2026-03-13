assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 0x8E
p2maxmeter = 0x8E

local p1health = 0xFF4191
local p2health = 0xFF4591

local p1meter = 0xFF4195
local p2meter = 0xFF4595

local p1combocounter = 0xFF4110
local p2combocounter = 0xFF4510

local p1direction = 0xFF404D
local p2direction = 0xFF444D

character = {
	WOLVERINE		= 0x00,
	PSYLOCKE		= 0x02,
	COLOSSUS		= 0x04,
	CYCLOPS			= 0x06,
	STORM			= 0x08,
	ICEMAN			= 0x0A,
	SPIRAL			= 0x0C,
	SILVER_SAMURAI	= 0x0E,
	OMEGA_RED		= 0x10,
	SENTINEL		= 0x12,
	JUGGERNAUT		= 0X14,
	MAGNETO			= 0x16,
	AKUMA			= 0x18
}
local p1characterid = 0xFF4051
local p2characterid = 0xFF4451
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
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 338,
				y = 20,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 170,
				y = 30,
				enabled = false,
			},
			P2 = {
				x = 211,
				y = 30,
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
	return rb(p1meter, meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
end

function readPlayerTwoMeter()
	return rb(p2meter, meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

function infiniteTime()
	wb(0xFF4808,0x99)
end

local xmcota = {}

initConfigTable("xmcota", xmcota, "config")
createConfigValue(
	"xmcotamusicvolume",
	"musicvolume",
	50,
	xmcota,
	xmcota,
	"config"
)

local maxmusicvolume = 0xFF -- what the maximum volume is in game
local musicvolume = 0xF019

function setMusicVolume(volume) -- squeeze from 0 to 100
	local volume = math.floor( (volume*maxmusicvolume)/100 )
	memory.writebyte_audio(musicvolume, volume)
end

function Run()
	setMusicVolume(xmcota.musicvolume)
	infiniteTime()
	if p1characterpick then
		wb(p1characterid, p1characterpick)
	end
	if p2characterpick then
		wb(p2characterid, p2characterpick)
	end
end