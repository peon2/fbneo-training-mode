assert(rb,"Run fbneo-training-mode.lua")
-- most of these values came from FlabCaptain's sgemf training mode script: https://github.com/FlabCaptain/Gemini

function gamemsg()
	print "Known issues with sgemf:"
	print "Chain combos sometimes won't update the combo counter properly on whiffed attacks."
end

p1maxhealth = 0x91 -- account for magic pixel
p2maxhealth = 0x91

local meterbarmax = 0x60
local meterstockmax = 9

p1maxmeter = meterbarmax*meterstockmax
p2maxmeter = meterbarmax*meterstockmax

local P1, P2 = {uid = 0xFF8400}, {uid = 0xFF8800}

local uidoffsets = {
	state = 0x6, -- word
	direction = 0x0B,
	health = 0x40, -- word
	combocounter = 0x144,
	stunduration = 0x146,
	stun = 0x17F,
	specials = 0x18A, -- 3 bytes ranging from 0-2 indicating what level special is to be done, setting the value to outside of that range crashes the game
	meterstocks = 0x194,
	meterbar = 0x195,
	maxstun = 0x19E,
	stunrecovery = 0x19F,
	specialsbars = 0x1A2, -- 3 words for displaying each special level ranging from 0x00 -> 0x60
	items = 0x1F0 -- 3 bytes for each item, ranging from 0xFF (empty) -> 0x06
}

for _, player in pairs({P1, P2}) do
	for name, offset in pairs(uidoffsets) do
		player[name] = player.uid + offset
	end
end

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Punch"] = 5,
	["Kick"] = 6,
	["Special"] = 7,
	["Coin"] = 8,
	["Start"] = 9,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=46
		},
		health = {
			P1 = {
				x = 18,
				y = 23,
				enabled = true,
			},
			P2 = {
				x = 355,
				y = 23,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 155,
				y = 32,
				enabled = true,
			},
			P2 = {
				x = 219,
				y = 32,
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
	},
	inputs = {
		simple = {
			P1 = {
				enabled = false
			},
			P2 = {
				enabled = false
			}
		}
	}
}

local sgemf = {stun = { P1 = {}, P2 = {}}, specials = {}}

function playerOneFacingLeft()
	return rb(P1.direction)==0
end

function playerTwoFacingLeft()
	return rb(P2.direction)==0
end

local previousP1Hitstun = false

function playerOneInHitstun()
	return rb(P1.combocounter)~=0
end

local previousP2Hitstun = false

function playerTwoInHitstun()
	return rb(P2.combocounter)~=0
end

function readPlayerOneHealth()
	return rw(P1.health)+1
end

function writePlayerOneHealth(health)
	ww(P1.health, health-1)
end

function readPlayerTwoHealth()
	return rw(P2.health)+1
end

function writePlayerTwoHealth(health)
	ww(P2.health, health-1)
end

function readPlayerOneMeter()
	return rb(P1.meterstocks)*meterbarmax + rb(P1.meterbar)
end

function writePlayerOneMeter(meter)
	if meter > p1maxmeter then
		meter = p1maxmeter
	end
	local bar = meter%meterbarmax
	local stocks = meter/meterbarmax
	wb(P1.meterbar, bar)
	wb(P1.meterstocks, stocks)
end

function readPlayerTwoMeter()
	return rb(P2.meterstocks)*meterbarmax + rb(P2.meterbar)
end

function writePlayerTwoMeter(meter)
	if meter > p2maxmeter then
		meter = p2maxmeter
	end
	local bar = meter%meterbarmax
	local stocks = meter/meterbarmax
	wb(P2.meterbar, bar)
	wb(P2.meterstocks, stocks)
end

local function readPlayerOneStun()
	return rb(P1.stun)
end

local function readPlayerTwoStun()
	return rb(P2.stun)
end

local function readPlayerOneMaxStun()
	return rb(P1.maxstun)
end

local function readPlayerTwoMaxStun()
	return rb(P2.maxstun)
end

local function infiniteTime()
	ww(0xFF8188,0x9963)
end

local function infiniteRounds()
	wdw(0xFF87A2, 0x01100102)
	wdw(0xFF8BA2, 0x01100102)
end

local function handleSpecialsLevels()
	local specialslevels = {
		P1 = {
			specials = P1.specials,
			bars = P1.specialsbars
		},
		P2 = {
			specials = P2.specials,
			bars = P2.specialsbars
		}
	}
	for player = 1, 2 do
		for button = 1, 3 do
			local name = "sgemfp"..player.."special"..button
			specialslevels["P"..player][button-1] = getConfigValue(name)
		end
	end
	for _, player in pairs(specialslevels) do
		for special = 0, 2 do
			if player[special]>0 then
				wb(player.specials+special, player[special]-1) -- set level of the special
				ww(player.bars+special*2, 0x30*(player[special]-1)) -- make sure the display matches
			end
		end
	end
end

local function handleItems()
	wb(P1.items, getConfigValue("sgemfitemp1"))
	wb(P2.items, getConfigValue("sgemfitemp2"))
end

sgemf_stunsettings = {
	OFF = 1,
	ALWAYS = 2,
	AFTER_COMBO = 3
}

local function handleStun()
	local players = {
		{
			memory = P1,
			max = "sgemfstunmaxp1",
			setting = "sgemfstunsettingp1",
			value = "sgemfstunvaluep1",
			prev = previousP1Hitstun,
			hitstun = playerOneInHitstun
		},
		{
			memory = P2,
			max = "sgemfstunmaxp2",
			setting = "sgemfstunsettingp2",
			value = "sgemfstunvaluep2",
			prev = previousP2Hitstun,
			hitstun = playerTwoInHitstun
		}
	}

	for _, player in ipairs(players) do
		wb(player.memory.maxstun, getConfigValue(player.max))
		local setting = getConfigValue(player.setting)
		if setting == sgemf_stunsettings.ALWAYS then
			wb(player.memory.stun, getConfigValue(player.value))
			wb(player.memory.stunrecovery, 0)
		elseif setting == sgemf_stunsettings.AFTER_COMBO and (player.prev and not player.hitstun()) then
			wb(player.memory.stun, getConfigValue(player.value))
			wb(player.memory.stunrecovery, 0)
		end
	end
end

function Run()
	infiniteTime()
	infiniteRounds()
	handleSpecialsLevels()
	handleItems()
	handleStun()
	previousP1Hitstun = playerOneInHitstun()
	previousP2Hitstun = playerTwoInHitstun()
end

initConfigTable("sgemf", sgemf, "config")

createConfigItem("sgemfstunenabledp1", false, sgemf.stun.P1, "enabled")
createConfigItem("sgemfstunxp1", 25, sgemf.stun.P1, "x")
createConfigItem("sgemfstunyp1", 5, sgemf.stun.P1, "y")
createConfigItem("sgemfstunsettingp1", sgemf_stunsettings.ALWAYS, sgemf.stun.P1, "setting")
createConfigItem("sgemfstunvaluep1", 0, sgemf.stun.P1, "value")
createConfigItem("sgemfstunmaxp1", 0x28, sgemf.stun.P1, "max")
createConfigItem("sgemfitemp1", 0, sgemf, "itemp1")

createConfigItem("sgemfstunenabledp2", true, sgemf.stun.P2, "enabled")
createConfigItem("sgemfstunxp2", 305, sgemf.stun.P2, "x")
createConfigItem("sgemfstunyp2", 5, sgemf.stun.P2, "y")
createConfigItem("sgemfstunsettingp2", sgemf_stunsettings.AFTER_COMBO, sgemf.stun.P2, "setting")
createConfigItem("sgemfstunvaluep2", 0, sgemf.stun.P2, "value")
createConfigItem("sgemfstunmaxp2", 0x28, sgemf.stun.P2, "max")
createConfigItem("sgemfitemp2", 0, sgemf, "itemp2")

for player = 1, 2 do
	for button = 1, 3 do
		local name = "p"..player.."special"..button
		createConfigItem("sgemf"..name, 3, sgemf.specials, name) -- default max level for all specials
	end
end

local function drawStunBar(x, y, player, full)
		if full then
			local stunrecovery = rb(player.stunrecovery)
			local stunduration = rb(player.stunduration)
			local val = stunduration>0 and stunduration or stunrecovery
			drawFillBar(
				x,
				y,
				val,
				LETTER_WIDTH*3,
				val/4,
				0xB4/4 -- stunrecovery is always 0xB4, stunduration is random with a maximum duration of 0xB4
			)
		end
		local stun = rb(player.stun)
		local maxstun = rb(player.maxstun)
		drawFillBar(
			x,
			y+8,
			stun,
			LETTER_WIDTH*3,
			stun,
			maxstun
		)
end

createHUDElement(
	"p1stun",
	function(n)
		if n then
			changeConfig("sgemfstunxp1", n)
		end
		return sgemf.stun.P1.x
	end,
	function(n)
		if n then
			changeConfig("sgemfstunyp1", n)
		end
		return sgemf.stun.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sgemfstunenabledp1", n)
		end
		return sgemf.stun.P1.enabled
	end,
	function()
		resetConfig("sgemfstunxp1")
		resetConfig("sgemfstunyp1")
		resetConfig("sgemfstunenabledp1")
	end,
	function()
		drawStunBar(
			sgemf.stun.P1.x,
			sgemf.stun.P1.y,
			P1,
			getConfigValue("sgemfstunsettingp1") == sgemf_stunsettings.OFF
		)
	end,
	function()
		drawStunBar(
			sgemf.stun.P1.x,
			sgemf.stun.P1.y,
			P1,
			true
		)
	end
)

createHUDElement(
	"p2stun",
	function(n)
		if n then
			changeConfig("sgemfstunxp2", n)
		end
		return sgemf.stun.P2.x
	end,
	function(n)
		if n then
			changeConfig("sgemfstunyp2", n)
		end
		return sgemf.stun.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sgemfstunenabledp2", n)
		end
		return sgemf.stun.P2.enabled
	end,
	function()
		resetConfig("sgemfstunxp2")
		resetConfig("sgemfstunyp2")
		resetConfig("sgemfstunenabledp2")
	end,
	function()
		drawStunBar(
			sgemf.stun.P2.x,
			sgemf.stun.P2.y,
			P2,
			getConfigValue("sgemfstunsettingp2") == sgemf_stunsettings.OFF
		)
	end,
	function()
		drawStunBar(
			sgemf.stun.P2.x,
			sgemf.stun.P2.y,
			P2,
			true
		)
	end
)