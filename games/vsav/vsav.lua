assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 0x0120
p2maxhealth = 0x0120

local meterbarmax = 0x90
local meterstockmax = 10

p1maxmeter = meterbarmax*meterstockmax
p2maxmeter = meterbarmax*meterstockmax

local p1health = 0xFF8450
local p2health = 0xFF8850
local p1redhealth = 0xFF8452
local p2redhealth = 0xFF8852

local p1meterstocks = 0xFF8509
local p1meterbar = 0xFF850A
local p2meterstocks = 0xFF8909
local p2meterbar = 0xFF890A

local p1direction = 0xFF8520
local p2direction = 0xFF8920

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
			y=52,
			enabled=true,
		},
		health = {
			P1 = {
				x = 18,
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 355,
				y = 16,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 160,
				y = 206,
				enabled = false,
			},
			P2 = {
				x = 209,
				y = 206,
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
	return rb(p1direction) == 1
end

function playerTwoFacingLeft()
	return rb(p2direction) == 1
end

function playerOneInHitstun()
	return ((rb(0xFF8544)~=0) or (rb(0xFF8545)~=0))
end

function playerTwoInHitstun()
	return ((rb(0xFF8944)~=0) or (rb(0xFF8945)~=0))
end

function readPlayerOneHealth()
	return rw(p1health)
end

function writePlayerOneHealth(health)
	ww(p1health, health)
	ww(p1redhealth, health)
end

function readPlayerTwoHealth()
	return rw(p2health)
end

function writePlayerTwoHealth(health)
	ww(p2health, health)
	ww(p2redhealth, health)
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
	wb(0xFF8109, 0x63)
end


local vsav = {}

initConfigTable("vsav", vsav, "config")
createConfigValue(
	"vsavmusicvolume",
	50,
	vsav,
	"musicvolume"
)

local maxmusicvolume = 0xFF -- what the maximum volume is in game
local musicvolume = 0xF027

function setMusicVolume(volume) -- squeeze from 0 to 100
	local volume = math.floor( (volume*maxmusicvolume)/100 )
	memory.writebyte_audio(musicvolume, volume)
end

function Run()
	setMusicVolume(vsav.musicvolume)
	infiniteTime()
end
