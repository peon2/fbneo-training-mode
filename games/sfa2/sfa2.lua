assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 144
p2maxmeter = 144


local p1health = 0xFF8450
local p1redhealth = 0xff8452
local p2health = 0xFF8850
local p2redhealth = 0xFF8852

local p1meter = 0xFF849E
local p2meter = 0xFF889E

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
			y=42,
		},
		health = {
			P1 = {
				x = 18,
				y = 18,
				enabled = true,
			},
			P2 = {
				x = 355,
				y = 18,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 176,
				y = 209,
				enabled = true,
			},
			P2 = {
				x = 197,
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
	return rb(0xff8931)==1
end

function playerTwoFacingLeft()
	return rb(0xff8931)==0
end

function playerOneInHitstun()
	return rb(0xff845e)~=0
end

function playerTwoInHitstun()
	return rb(0xff885e)~=0
end

--[[
	SFA2 seems to desync randomly on the frames it takes damage and updates it's combo counter, frameskipping issue?
	Adding 4f of buffer in reading health seems to make it more accurate without adding too many false positives
--]]
local prevHealth = { P1 = {}, P2 = {} }
local healthhistorylen = 4
for i = 1, healthhistorylen do
	prevHealth.P1[i] = rw(p1health)
	prevHealth.P2[i] = rw(p2health)
end

function readPlayerOneHealth()
	for i = 1, healthhistorylen do
		prevHealth.P1[i+1] = prevHealth.P1[i]
	end
	prevHealth.P1[1] = rw(p1health)
	return prevHealth.P1[healthhistorylen+1]
end

function readPlayerTwoHealth()
	for i = 1, healthhistorylen do
		prevHealth.P2[i+1] = prevHealth.P2[i]
	end
	prevHealth.P2[1] = rw(p2health)
	return prevHealth.P2[healthhistorylen+1]
end

function writePlayerOneHealth(health)
	ww(p1health, health)
	ww(p1redhealth, health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
	ww(p2redhealth, health)
end

function readPlayerOneMeter()
	return rw(p1meter)
end

function writePlayerOneMeter(meter)
	ww(p1meter, meter)
end

function readPlayerTwoMeter()
	return rw(p2meter)
end

function writePlayerTwoMeter(meter)
	ww(p2meter, meter)
end

local infiniteTime = function()
	wb(0xff8109, 99)
end

local sfa2 = {}

initConfigTable("sfa2", sfa2, "config")
createConfigItem("sfa2musicvolume", 50, sfa2, "musicvolume")

local maxmusicvolume = 0xFF -- what the maximum volume is in game
local musicvolume = 0xF019

function setMusicVolume(volume) -- squeeze from 0 to 100
	local volume = math.floor( (volume*maxmusicvolume)/100 )
	memory.writebyte_audio(musicvolume, volume)
end

function Run()
	setMusicVolume(sfa2.musicvolume)
	infiniteTime()
end
