assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

-- Uses values taken from https://www.mamecheat.co.uk/

REPLAY_SAVESTATE_INTERVAL = 300

p1maxhealth = 0xA0
p2maxhealth = 0xA0

local p1maxbarsize
local p2maxbarsize

local function setSFIII2Constants()
	p1maxbarsize = rb(0x200ED31)
	p2maxbarsize = rb(0x200ED5D)
	p1maxmeter = rb(0x200ED3D) * p1maxbarsize -- Max stocks * Max bar size
	p2maxmeter = rb(0x200ED69) * p2maxbarsize

	p1maxstun = rb(0x200ED77)
	p2maxstun = rb(0x200ED8B)
end

setSFIII2Constants()

local p1health = 0x200E5A3
local p2health = 0x200E9AF

local p1meterbar = 0x200ED35
local p1meterstocks = 0x200ED3F

local p2meterbar = 0x200ED61
local p2meterstocks = 0x200ED6B

local p1direction = 0x200E50E 
local p2direction = 0x200E91A

local p1hitstun = 0x2024124
local p2hitstun = 0x2024125

local p1stunned = 0x2024092
local p2stunned = 0x20240AA

local p1stunbar = 0x200ED7D
local p2stunbar = 0x200ED91

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
			enabled=true,
		},
		health = {
			P1 = {
				x = 10,
				y = 17,
				enabled = true,
			},
			P2 = {
				x = 363,
				y = 17,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 41,
				y = 209,
				enabled = true,
			},
			P2 = {
				x = 334,
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

local sfiii2 = { stun = { P1 = {}, P2 = {}, hud = { P1 = {}, P2 = {} } } }
local colours = {}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(p1hitstun)~=0 or rb(p1stunned)~=0
end

function playerTwoInHitstun()
	return rb(p2hitstun)~=0 or rb(p2stunned)~=0
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
	return rb(p1meterstocks)*p1maxbarsize + rb(p1meterbar)
end

function writePlayerOneMeter(meter)
	local bar = meter%p1maxbarsize
	local stocks = meter/p1maxbarsize
	wb(p1meterbar, bar)
	wb(p1meterstocks, stocks)
end

function readPlayerTwoMeter()
	return rb(p2meterstocks)*p2maxbarsize + rb(p2meterbar)
end

function writePlayerTwoMeter(meter)
	local bar = meter%p2maxbarsize
	local stocks = meter/p2maxbarsize
	wb(p2meterbar, bar)
	wb(p2meterstocks, stocks)
end

local function readPlayerOneStun()
	return rb(p1stunbar, stun)
end

local function readPlayerTwoStun()
	return rb(p2stunbar, stun)
end

local function writePlayerOneStun(stun)
	wb(p1stunbar, stun)
end

local function writePlayerTwoStun(stun)
	wb(p2stunbar, stun)
end

local function setMusicVolume(volume) -- squeeze from 0 to 100
	volume = math.floor( (volume*0x80)/100 )
	wb(0x20731D6, volume)
end

local timer = 0x2010167
local timemax = 0x63

local function infiniteTime()
	wb(0x2010167, timemax-1)
end

function Run() -- runs every frame
	wb(0x206510D, 0x02) -- unlock Akuma
	if (rb(timer) == timemax) then -- should be checking if char/super has changed instead...
		setSFIII2Constants()
		setGameConstants()
		reloadGUIPages()
		-- Reset these changeable values
		changeConfig("sfiii2stunp1", 0)
		changeConfig("sfiii2stunp2", 0)
	end
	if sfiii2.stun.P1.enabled then
		if sfiii2.stun.P1.aftercombo then
			if not playerOneInHitstun() then
				writePlayerOneStun(sfiii2.stun.P1.value)
			end
		else
			writePlayerOneStun(sfiii2.stun.P1.value)
		end
	end

	if sfiii2.stun.P2.enabled then
		if sfiii2.stun.P2.aftercombo then
			if not playerTwoInHitstun() then
				writePlayerTwoStun(sfiii2.stun.P2.value)
			end
		else
			writePlayerTwoStun(sfiii2.stun.P2.value)
		end
	end
	infiniteTime()
	setMusicVolume(sfiii2.musicvolume)
end


initConfigTable("sfiii2", sfiii2, "config")
createConfigValue(
	"sfiii2stunenabledp1",
	true,
	sfiii2.stun.P1,
	"enabled"
)
createConfigValue(
	"sfiii2stunenabledp2",
	true,
	sfiii2.stun.P2,
	"enabled"
)
createConfigValue(
	"sfiii2stunaftercombop1",
	true,
	sfiii2.stun.P1,
	"aftercombo"
)
createConfigValue(
	"sfiii2stunaftercombop2",
	true,
	sfiii2.stun.P2,
	"aftercombo"
)
createConfigValue(
	"sfiii2stunp1",
	0,
	sfiii2.stun.P1,
	"value"
)
createConfigValue(
	"sfiii2stunp2",
	0,
	sfiii2.stun.P2,
	"value"
)
createConfigValue(
	"sfiii2stunxp1",
	84,
	sfiii2.stun.hud.P1,
	"x"
)
createConfigValue(
	"sfiii2stunxp2",
	285,
	sfiii2.stun.hud.P2,
	"x"
)
createConfigValue(
	"sfiii2stunyp1",
	24,
	sfiii2.stun.hud.P1,
	"y"
)
createConfigValue(
	"sfiii2stunyp2",
	24,
	sfiii2.stun.hud.P2,
	"y"
)
createConfigValue(
	"sfiii2stunhudenabledp1",
	true,
	sfiii2.stun.hud.P1,
	"enabled"
)
createConfigValue(
	"sfiii2stunhudenabledp2",
	true,
	sfiii2.stun.hud.P2,
	"enabled"
)
createConfigValue(
	"sfiii2musicvolume",
	25,
	sfiii2,
	"musicvolume"
)
initConfigTable("sfiii2", colours, "colourconfig")
createConfigValue(
	"sfiii2stuncolourp1",
	0xFF0000FF,
	colours,
	"stunp1",
	colours,
	"Stun Colour P1"
)
createConfigValue(
	"sfiii2stuncolourp2",
	0x00FFFFFF,
	colours,
	"stunp2",
	colours,
	"Stun Colour P2"
)

createHUDElement(
	"p1stun",
	function(n)
		if n then
			changeConfig("sfiii2stunxp1", n)
		end
		return sfiii2.stun.hud.P1.x
	end,
	function(n)
		if n then
			changeConfig("sfiii2stunyp1", n)
		end
		return sfiii2.stun.hud.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sfiii2stunenabledp1", n)
		end
		return sfiii2.stun.P1.enabled
	end,
	function()
		resetConfig("sfiii2stunxp1")
		resetConfig("sfiii2stunyp1")
		resetConfig("sfiii2stunenabledp1")
	end,
	function()
		gui.text(sfiii2.stun.hud.P1.x, sfiii2.stun.hud.P1.y, readPlayerOneStun(), colours.stunp1)
	end
)
createHUDElement(
	"p2stun",
	function(n)
		if n then
			changeConfig("sfiii2stunxp2", n)
		end
		return sfiii2.stun.hud.P2.x
	end,
	function(n)
		if n then
			changeConfig("sfiii2stunyp2", n)
		end
		return sfiii2.stun.hud.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sfiii2stunenabledp2", n)
		end
		return sfiii2.stun.P2.enabled
	end,
	function()
		resetConfig("sfiii2stunxp2")
		resetConfig("sfiii2stunyp2")
		resetConfig("sfiii2stunenabledp2")
	end,
	function()
		gui.text(sfiii2.stun.hud.P2.x, sfiii2.stun.hud.P2.y, readPlayerTwoStun(), colours.stunp2)
	end
)