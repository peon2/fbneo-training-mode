assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

-- Uses values taken from https://www.mamecheat.co.uk/

REPLAY_SAVESTATE_INTERVAL = 300

p1maxhealth = 0xA0
p2maxhealth = 0xA0
local p1maxbarsize
local p2maxbarsize

local function setSFIIIConstants()
	p1maxbarsize = rb(0x200D945)
	p2maxbarsize = rb(0x200D965)

	p1maxmeter = rb(0x200D951) * p1maxbarsize -- Max stocks * Max bar size
	p2maxmeter = rb(0x200D971) * p2maxbarsize

	p1maxstun = rb(0x200D97F)
	p2maxstun = rb(0x200D993)
end

setSFIIIConstants()

local p1health = 0x200D22B
local p2health = 0x200D603

local p1meterbar = 0x200D949
local p1meterstocks = 0x200D953

local p2meterbar = 0x200D969
local p2meterstocks = 0x200D973

local p1direction = 0x200D196
local p2direction = 0x200D197

local p1combocounter = 0x200DB9D
local p2combocounter = 0x200DAF5

local p1stunned = 0x201DC8E
local p2stunned = 0x201DCA6

local p1stunbar = 0x200D985
local p2stunbar = 0x200D999

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
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 364,
				y = 16,
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

local sfiii = { stun = { P1 = {}, P2 = {}, hud = { P1 = {}, P2 = {} } } }
local colours = {}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==1
end

function playerOneInHitstun()
	return (rb(p2combocounter)~=0 or rb(p1stunned)~=0)
end

function playerTwoInHitstun()
	return (rb(p1combocounter)~=0 or rb(p2stunned)~=0)
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
	if volume < 0 then volume = 0 end
	if volume > 100 then volume = 100 end
	volume = math.floor( (volume*0x80)/100 )
	wb(0x206CE16, volume)
end

local timer = 0x200EB33
local timemax = 0x63

local function infiniteTime()
	wb(timer, 0x63-1)
end

function Run() -- runs every frame
	if (rb(timer) == timemax) then -- should be checking if char/super has changed instead...
		setSFIIIConstants()
		setGameConstants()
		reloadGUIPages()
		infiniteTime()
		-- Reset these changeable values
		changeConfig("sfiiistunp1", 0)
		changeConfig("sfiiistunp2", 0)
	end
	if sfiii.stun.P1.enabled then
		if sfiii.stun.P1.aftercombo then
			if not playerOneInHitstun() then
				writePlayerOneStun(sfiii.stun.P1.value)
			end
		else
			writePlayerOneStun(sfiii.stun.P1.value)
		end
	end
	
	if sfiii.stun.P2.enabled then
		if sfiii.stun.P2.aftercombo then
			if not playerTwoInHitstun() then
				writePlayerTwoStun(sfiii.stun.P2.value)
			end
		else
			writePlayerTwoStun(sfiii.stun.P2.value)
		end
	end
	infiniteTime()
	setMusicVolume(sfiii.musicvolume)
	if sfiii.p1gill then
		wb(0x200EB43, 0x0)
	end
	if sfiii.p2gill then
		wb(0x200EB44, 0x0)
	end
end

initConfigTable("sfiii", sfiii, "config")

createConfigItem("sfiiistunenabledp1", true, sfiii.stun.P1, "enabled")
createConfigItem("sfiiistunenabledp2", true, sfiii.stun.P2, "enabled")
createConfigItem("sfiiistunaftercombop1", true, sfiii.stun.P1, "aftercombo")
createConfigItem("sfiiistunaftercombop2", true, sfiii.stun.P2, "aftercombo")
createConfigItem("sfiiistunp1", 0, sfiii.stun.P1, "value")
createConfigItem("sfiiistunp2", 0, sfiii.stun.P2, "value")
createConfigItem("sfiiistunxp1", 84, sfiii.stun.hud.P1, "x")
createConfigItem("sfiiistunxp2", 285, sfiii.stun.hud.P2, "x")
createConfigItem("sfiiistunyp1", 24, sfiii.stun.hud.P1, "y")
createConfigItem("sfiiistunyp2", 24, sfiii.stun.hud.P2, "y")
createConfigItem("sfiiistunhudenabledp1", true, sfiii.stun.hud.P1, "enabled")
createConfigItem("sfiiistunhudenabledp2", true, sfiii.stun.hud.P2, "enabled")

createConfigItem("sfiiip1gill", false, sfiii, "p1gill")
createConfigItem("sfiiip2gill", false, sfiii, "p2gill")

createConfigItem("sfiiimusicvolume", 25, sfiii, "musicvolume")

initConfigTable("sfiii", colours, "colourconfig")
createConfigItem("coloursfiiistunp1", 0xFF0000FF, colours, "stunp1", colours, "Stun Colour P1")
createConfigItem("coloursfiiistunp2", 0x00FFFFFF, colours, "stunp2", colours, "Stun Colour P2")

createHUDElement(
	"p1stun",
	function(n)
		if n then
			changeConfig("sfiiistunxp1", n)
		end
		return sfiii.stun.hud.P1.x
	end,
	function(n)
		if n then
			changeConfig("sfiiistunyp1", n)
		end
		return sfiii.stun.hud.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sfiiistunenabledp1", n)
		end
		return sfiii.stun.P1.enabled
	end,
	function()
		resetConfig("sfiiistunxp1")
		resetConfig("sfiiistunyp1")
		resetConfig("sfiiistunenabledp1")
	end,
	function()
		gui.text(sfiii.stun.hud.P1.x, sfiii.stun.hud.P1.y, readPlayerOneStun(), colours.stunp1)
	end
)
createHUDElement(
	"p2stun",
	function(n)
		if n then
			changeConfig("sfiiistunxp2", n)
		end
		return sfiii.stun.hud.P2.x
	end,
	function(n)
		if n then
			changeConfig("sfiiistunyp2", n)
		end
		return sfiii.stun.hud.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sfiiistunenabledp2", n)
		end
		return sfiii.stun.P2.enabled
	end,
	function()
		resetConfig("sfiiistunxp2")
		resetConfig("sfiiistunyp2")
		resetConfig("sfiiistunenabledp2")
	end,
	function()
		gui.text(sfiii.stun.hud.P2.x, sfiii.stun.hud.P2.y, readPlayerTwoStun(), colours.stunp2)
	end
)
