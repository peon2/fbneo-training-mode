assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1uid = 0xFF83C6
p2uid = 0xFF86C6
timer = 0xFF8ACE
musicvolume = 0xD04B
maxvolume = 0x3F -- what the maximum volume is in game

p1maxhealth = 0x90
p2maxhealth = 0x90

local healthoffset = 0x2B
local redhealthoffset = 0x2D
local directionoffset = 0x12

local stateoffset = 0x03

local state = {
	hitstun = 0x0E,
	thrown = 0x14
}

local maxtime = 0x99

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
			y = 50
		},
		health = {
			P1 = {
				x = 34,
				y = 23,
				enabled = true
			},
			P2 = {
				x = 339,
				y = 23,
				enabled = true
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth
		},
		P2 = {
			maxhealth = p2maxhealth
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
			refillhealthspeed = 1 -- hitstun won't work in sf2 if health is refilling, refill it in 1f
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true,
			refillhealthspeed = 1
		}
	}
}

function playerOneFacingLeft()
	return rb(p1uid + directionoffset)==0
end

function playerTwoFacingLeft()
	return rb(p2uid + directionoffset)==0
end

function playerOneInHitstun()
	local val = rb(p1uid + stateoffset)
	return val == state.hitstun or val == state.thrown
end

function playerTwoInHitstun()
	local val = rb(p2uid + stateoffset)
	return val == state.hitstun or val == state.thrown
end
-- Health is 1f behind combos
local p1previoushealth = p1maxhealth
function readPlayerOneHealth()
	local ret = p1previoushealth
	p1previoushealth = rb(p1uid + healthoffset)
	return ret
end

local p2previoushealth = p2maxhealth
function readPlayerTwoHealth()
	local ret = p2previoushealth
	p2previoushealth = rb(p2uid + healthoffset)
	return ret
end

function writePlayerOneHealth(health)
	wb(p1uid + healthoffset, health)
	wb(p1uid + redhealthoffset, health)
end

function writePlayerTwoHealth(health)
	wb(p2uid + healthoffset, health)
	wb(p2uid + redhealthoffset, health)
end

local function infiniteTime()
	wb(timer, maxtime)
end

local sf2 = {}

initConfigTable("sf2", sf2, "config")
createConfigValue(
	"sf2musicvolume",
	"musicvolume",
	50,
	sf2,
	sf2,
	"config"
)

function setMusicVolume(volume) -- squeeze from 0 to 100
	local volume = math.floor( (volume*maxvolume)/100 )
	memory.writebyte_audio(musicvolume, volume)
end

function Run() -- runs every frame
	infiniteTime()
	setMusicVolume(sf2.musicvolume)
end