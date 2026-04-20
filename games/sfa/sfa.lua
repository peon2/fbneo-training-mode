assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 144
p2maxmeter = 144

local p1health = 0xFF8441
local p1redhealth = 0xFF8443
local p2health = 0xFF8841
local p2redhealth = 0xFF8843

local p1meter = 0xFF84BF
local p2meter = 0xFF88BF

local p1direction = 0xff840b
local p2direction = 0xff880b

local p1combocounter = 0xFF8857
local p2combocounter = 0xFF8457

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
				x = 33,
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 340,
				y = 20,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 164,
				y = 207,
				enabled = true,
			},
			P2 = {
				x = 208,
				y = 207,
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

--[[
	SFA seems to desync randomly on the frames it takes damage and updates it's combo counter, frameskipping issue?
	Adding 4f of buffer in reading health seems to make it more accurate without adding too many false positives
--]]
local prevHealth = { P1 = {}, P2 = {} }
local healthhistorylen = 4
for i = 1, healthhistorylen do
	prevHealth.P1[i] = rb(p1health)
	prevHealth.P2[i] = rb(p2health)
end

function readPlayerOneHealth()
	for i = 1, healthhistorylen do
		prevHealth.P1[i+1] = prevHealth.P1[i]
	end
	prevHealth.P1[1] = rb(p1health)
	return prevHealth.P1[healthhistorylen+1]
end

function readPlayerTwoHealth()
	for i = 1, healthhistorylen do
		prevHealth.P2[i+1] = prevHealth.P2[i]
	end
	prevHealth.P2[1] = rb(p2health)
	return prevHealth.P2[healthhistorylen+1]
end

function writePlayerOneHealth(health)
	wb(p1health, health)
	wb(p1redhealth, health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
	wb(p2redhealth, health)
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
	ww(0xFFAE09, 0x6300)
end

local sfa = {}

initConfigTable("sfa", sfa, "config")
createConfigValue(
	"sfamusicvolume",
	50,
	sfa,
	"musicvolume"
)

local maxmusicvolume = 0xFF -- what the maximum volume is in game
local musicvolume = 0xF019

function setMusicVolume(volume) -- squeeze from 0 to 100
	local volume = math.floor( (volume*maxmusicvolume)/100 )
	memory.writebyte_audio(musicvolume, volume)
end

function Run()
	setMusicVolume(sfa.musicvolume)
	infiniteTime()
end
