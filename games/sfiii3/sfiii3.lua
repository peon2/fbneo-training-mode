assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

-- Uses values taken from https://www.mamecheat.co.uk/

REPLAY_SAVESTATE_INTERVAL = 300

p1maxhealth = 0xA0
p2maxhealth = 0xA0
local p1maxbarsize
local p2maxbarsize

local function setSFIII3Constants()
	p1maxbarsize = rb(0x20695B3)
	p2maxbarsize = rb(0x20695DF)
	p1maxmeter = rb(0x20286AD) * p1maxbarsize -- Max stocks * Max bar size
	p2maxmeter = rb(0x20286E1) * p2maxbarsize -- Max stocks * Max bar size

	p1maxstun = rb(0x020695F7)
	p2maxstun = rb(0x0206960B)
end

setSFIII3Constants()

local p1health = 0x2068D0B
local p2health = 0x20691A3

local p1meterbar = 0x20695B5
local p1meterstocks = 0x20695BE

local p2meterbar = 0x20695E1
local p2meterstocks = 0x20695EB

local p1direction = 0x2068C76 
local p2direction = 0x2068C77

local p1hitstun = 0x20288A8
local p2hitstun = 0x20288A9

local p1stunbar = 0x020695FD
local p2stunbar = 0x02069611

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
				x = 9,
				y = 17,
				enabled = true,
			},
			P2 = {
				x = 364,
				y = 17,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 41,
				y = 210,
				enabled = true,
			},
			P2 = {
				x = 334,
				y = 210,
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

local sfiii3 = { stun = { P1 = {}, P2 = {}, hud = { P1 = {}, P2 = {} } } }
local colours = {}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==1
end

function playerOneInHitstun()
	return rb(p1hitstun)~=0
end

function playerTwoInHitstun()
	return rb(p2hitstun)~=0
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
	if meter > p1maxmeter then
		meter = p1maxmeter
	end
	local bar = meter%p1maxbarsize
	local stocks = meter/p1maxbarsize
	wb(p1meterbar, bar)
	wb(p1meterstocks, stocks)
end

function readPlayerTwoMeter()
	return rb(p2meterstocks)*p2maxbarsize + rb(p2meterbar)
end

function writePlayerTwoMeter(meter)
	if meter > p2maxmeter then
		meter = p2maxmeter
	end
	local bar = meter%p2maxbarsize
	local stocks = meter/p2maxbarsize
	wb(p2meterbar, bar)
	wb(p2meterstocks, stocks)
end

local function readPlayerOneStun()
	return rb(p1stunbar)
end

local function readPlayerTwoStun()
	return rb(p2stunbar)
end

local function writePlayerOneStun(stun)
	wb(p1stunbar, stun)
end

local function writePlayerTwoStun(stun)
	wb(p2stunbar, stun)
end

local maxvolume = 0x80
local function setMusicVolume(volume) -- squeeze from 0 to 100
	volume = math.floor( (volume*maxvolume)/100 )
	wb(0x2078D06, volume)
end

local timer = 0x2011377
local timemax = 0x63

local function clockControl()
	wb(timer, timemax-1)
	wb(0x2028682, 0x0) -- stops timer flash
	ww(0x2028688, 0xFFFF) -- how many frames must pass before decrementing the clock, it should take over a day for the timer to reduce from 99 seconds to 0
end
clockControl()

function Run() -- runs every frame
	if (rb(timer) == timemax) then
		setSFIII3Constants()
		setGameConstants()
		reloadGUIPages()
		clockControl()
		-- Reset these changeable values
		changeConfig("sfiii3stunp1", 0)
		changeConfig("sfiii3stunp2", 0)
	end
	if sfiii3.stun.P1.enabled then
		if sfiii3.stun.P1.aftercombo then
			if not playerOneInHitstun() then
				writePlayerOneStun(sfiii3.stun.P1.value)
			end
		else
			writePlayerOneStun(sfiii3.stun.P1.value)
		end
	end

	if sfiii3.stun.P2.enabled then
		if sfiii3.stun.P2.aftercombo then
			if not playerTwoInHitstun() then
				writePlayerTwoStun(sfiii3.stun.P2.value)
			end
		else
			writePlayerTwoStun(sfiii3.stun.P2.value)
		end
	end
	setMusicVolume(sfiii3.musicvolume)
end

initConfigTable("sfiii3", sfiii3, "config")
createConfigValue(
	"sfiii3stunenabledp1",
	"enabled",
	true,
	sfiii3.stun.P1,
	sfiii3.stun.P1,
	"config"
)
createConfigValue(
	"sfiii3stunenabledp2",
	"enabled",
	true,
	sfiii3.stun.P2,
	sfiii3.stun.P2,
	"config"
)
createConfigValue(
	"sfiii3stunaftercombop1",
	"aftercombo",
	true,
	sfiii3.stun.P1,
	sfiii3.stun.P1,
	"config"
)
createConfigValue(
	"sfiii3stunaftercombop2",
	"aftercombo",
	true,
	sfiii3.stun.P2,
	sfiii3.stun.P2,
	"config"
)
createConfigValue(
	"sfiii3stunp1",
	"value",
	0,
	sfiii3.stun.P1,
	sfiii3.stun.P1,
	"config"
)
createConfigValue(
	"sfiii3stunp2",
	"value",
	0,
	sfiii3.stun.P2,
	sfiii3.stun.P2,
	"config"
)
createConfigValue(
	"sfiii3stunxp1",
	"x",
	84,
	sfiii3.stun.hud.P1,
	sfiii3.stun.hud.P1,
	"config"
)
createConfigValue(
	"sfiii3stunxp2",
	"x",
	285,
	sfiii3.stun.hud.P2,
	sfiii3.stun.hud.P2,
	"config"
)
createConfigValue(
	"sfiii3stunyp1",
	"y",
	24,
	sfiii3.stun.hud.P1,
	sfiii3.stun.hud.P1,
	"config"
)
createConfigValue(
	"sfiii3stunyp2",
	"y",
	24,
	sfiii3.stun.hud.P2,
	sfiii3.stun.hud.P2,
	"config"
)
createConfigValue(
	"sfiii3stunhudenabledp1",
	"enabled",
	true,
	sfiii3.stun.hud.P1,
	sfiii3.stun.hud.P1,
	"config"
)
createConfigValue(
	"sfiii3stunhudenabledp2",
	"enabled",
	true,
	sfiii3.stun.hud.P2,
	sfiii3.stun.hud.P2,
	"config"
)
createConfigValue(
	"sfiii3musicvolume",
	"musicvolume",
	25,
	sfiii3,
	sfiii3,
	"config"
)
initConfigTable("sfiii3", colours, "colourconfig")
createConfigValue(
	"sfiii3stuncolourp1",
	"stunp1",
	0xFF0000FF,
	colours,
	colours,
	"colourconfig",
	"Stun Colour P1"
)
createConfigValue(
	"sfiii3stuncolourp2",
	"stunp2",
	0x00FFFFFF,
	colours,
	colours,
	"colourconfig",
	"Stun Colour P2"
)

createHUDElement(
	"p1stun",
	function(n)
		if n then
			changeConfig("sfiii3stunxp1", n)
		end
		return sfiii3.stun.hud.P1.x
	end,
	function(n)
		if n then
			changeConfig("sfiii3stunyp1", n)
		end
		return sfiii3.stun.hud.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sfiii3stunenabledp1", n)
		end
		return sfiii3.stun.P1.enabled
	end,
	function()
		resetConfig("sfiii3stunxp1")
		resetConfig("sfiii3stunyp1")
		resetConfig("sfiii3stunenabledp1")
	end,
	function()
		gui.text(sfiii3.stun.hud.P1.x, sfiii3.stun.hud.P1.y, readPlayerOneStun(), colours.stunp1)
	end
)
createHUDElement(
	"p2stun",
	function(n)
		if n then
			changeConfig("sfiii3stunxp2", n)
		end
		return sfiii3.stun.hud.P2.x
	end,
	function(n)
		if n then
			changeConfig("sfiii3stunyp2", n)
		end
		return sfiii3.stun.hud.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sfiii3stunenabledp2", n)
		end
		return sfiii3.stun.P2.enabled
	end,
	function()
		resetConfig("sfiii3stunxp2")
		resetConfig("sfiii3stunyp2")
		resetConfig("sfiii3stunenabledp2")
	end,
	function()
		gui.text(sfiii3.stun.hud.P2.x, sfiii3.stun.hud.P2.y, readPlayerTwoStun(), colours.stunp2)
	end
)