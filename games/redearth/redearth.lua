assert(rb,"Run fbneo-training-mode.lua")

REPLAY_SAVESTATE_INTERVAL = 300

p1maxhealth = 0x7C
p2maxhealth = 0x7C
p1maxmeter = 3
p2maxmeter = 3

local p1uid = 0x206A784
local p2uid = 0x206AA04

local p1health = p1uid + 0xBD
local p2health = p2uid + 0xBD

local p1meter = p1uid + 0x151
local p2meter = p2uid + 0x151


local ICE		= 1
local METEOR	= 2
local POISON	= 3
local FIRE		= 4
local WIND		= 5
local LIGHTNING	= 6

local p1orbs = p1uid + 0x149 -- 3 bytes in a row for the three orbs a character can hold at one time
local p2orbs = p2uid + 0x149


local LEO		= 0
local KENJI		= 1
local TESSA		= 2
local MAILING	= 3

local p1charid = p1uid + 0x121
local p2charid = p2uid + 0x121


local p1stun = p1uid + 0xD6
local p2stun = p2uid + 0xD6

local p1direction = p1uid + 0x62
local p2direction = p2uid + 0x62

local p1stuncount = p1uid + 0x10F -- how many times a character has been stunned this round
local p2stuncount = p2uid + 0x10F

local p1combocounter = p1uid + 0xEA
local p2combocounter = p2uid + 0xEA


local OLD_SWORD			= 0
local BRONZE_SWORD		= 1
local STEEL_SWORD		= 2
local FIRE_SWORD		= 3
local ICE_SWORD			= 4
local LIGHTNING_SWORD	= 5
local DIAMOND_SWORD		= 6
local BATTLEAXE 		= 7
local LEGENDARY_SWORD	= 8

local p1sword = p1uid + 0x158 -- Swords for Leo
local p2sword = p1uid + 0x158

-- Each number corresponds to different Swords being selectable, 0x11 and higher enables Legendary Sword
local LEGENDARYSWORDANDELEMENTALSWORDS = 0x1F
local p1weaponswap = p1uid + 0x159
local p2weaponswap = p2uid + 0x159

local OLD_SHIELD = 0
local WOODEN_SHIELD = 1
local STEEL_SHIELD = 2
local DIAMOND_SHIELD = 3
local LEGENDARY_SHIELD = 4

local p1shield = p1uid + 0x15A -- Shields for Leo
local p2shield = p1uid + 0x15A

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
				x = 49,
				y = 12,
				enabled = true,
			},
			P2 = {
				x = 324,
				y = 12,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 162,
				y = 28,
				enabled = false,
			},
			P2 = {
				x = 219,
				y = 28,
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
local redearth = {stun = { P1 = {}, P2 = {} }}

function playerOneFacingLeft()
	return rb(p1direction) == 0
end

function playerTwoFacingLeft()
	return rb(p2direction) == 0
end

function playerOneInHitstun()
	return rb(p1combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p2combocounter)~=0
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	return wb(p1health, health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	if meter > 3 then meter = 3 end
	wb(p1meter, meter)
	for i = 0, meter-1 do
		wb(p1orbs+i, redearth.orb) -- game crashes if an invalid orb is used
	end
end

function readPlayerTwoMeter()
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	if meter > 3 then meter = 3 end
	wb(p2meter, meter)
	for i = 0, meter-1 do
		wb(p2orbs+i, redearth.orb)
	end
end

local function readPlayerOneStun()
	return rb(p1stun)
end

local function readPlayerTwoStun()
	return rb(p2stun)
end

local charsstunresistance = {}
charsstunresistance[LEO] = 36
charsstunresistance[KENJI] = 34
charsstunresistance[TESSA] = 30
charsstunresistance[MAILING] = 28

local function readPlayerOneMaxStun()
	return charsstunresistance[rb(p1charid)] + rb(p1stuncount)*5
end

local function readPlayerTwoMaxStun()
	return charsstunresistance[rb(p2charid)] + rb(p2stuncount)*5
end

function setMusicVolume(volume) -- squeeze from 0 to 100
	if volume < 0 then volume = 0 end
	if volume > 100 then volume = 100 end
	volume = math.floor( (volume*0x80)/100 )
	wb(0x207BD0E, volume)
end

local function infiniteTime()
	ww(0x2060700, 0x9A)
end

local function infiniteCredits()
	wb(0x2000A10, 9)
end

function Run()
	infiniteTime()
	infiniteCredits()
	setMusicVolume(redearth.musicvolume)
	if (rb(p1charid) == LEO) then
		wb(p1sword, redearth.sword)
		wb(p1shield, redearth.shield)
		wb(p1weaponswap, LEGENDARYSWORDANDELEMENTALSWORDS)
	end
	if (rb(p2charid) == LEO) then
		wb(p2sword, redearth.sword)
		wb(p2shield, redearth.shield)
		wb(p2weaponswap, LEGENDARYSWORDANDELEMENTALSWORDS)
	end
end

initConfigTable("redearth", redearth, "config")

createConfigItem("redearthmusicvolume", 50, redearth, "musicvolume")
createConfigItem("redearthsword", LEGENDARY_SWORD, redearth, "sword")
createConfigItem("redearthshield", LEGENDARY_SHIELD, redearth, "shield")
createConfigItem("redearthorb", LIGHTNING, redearth, "orb")

createConfigItem("redearthstunenabledp1", false, redearth.stun.P1, "enabled")
createConfigItem("redearthstunxp1", 3, redearth.stun.P1, "x")
createConfigItem("redearthstunyp1", 42, redearth.stun.P1, "y")

createConfigItem("redearthstunenabledp2", true, redearth.stun.P2, "enabled")
createConfigItem("redearthstunxp2", 325, redearth.stun.P2, "x")
createConfigItem("redearthstunyp2", 42, redearth.stun.P2, "y")

local function drawStunBar(player)
	local stunfunc = { P1 = readPlayerOneStun, P2 = readPlayerTwoStun }
	local stun = stunfunc[player]()
	local maxstunfunc = { P1 = readPlayerOneMaxStun, P2 = readPlayerTwoMaxStun }
	local maxstun = maxstunfunc[player]()
	local xoffset = redearth.stun[player].x + #"00"*LETTER_WIDTH + 2
	local heigth = LETTER_HEIGHT-2
	gui.box(xoffset, redearth.stun[player].y, xoffset+maxstun, redearth.stun[player].y+heigth, nil, "grey")
	if stun>0 then
		gui.box(xoffset+1, redearth.stun[player].y+1, xoffset+stun-1, redearth.stun[player].y+heigth-1, "cyan", nil)
	end
	gui.text(redearth.stun[player].x, redearth.stun[player].y, stun, "red")
end

createHUDElement(
	"p1stun",
	function(n)
		if n then
			changeConfig("redearthstunxp1", n)
		end
		return redearth.stun.P1.x
	end,
	function(n)
		if n then
			changeConfig("redearthstunyp1", n)
		end
		return redearth.stun.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("redearthstunenabledp1", n)
		end
		return redearth.stun.P1.enabled
	end,
	function()
		resetConfig("redearthstunxp1")
		resetConfig("redearthstunyp1")
		resetConfig("redearthstunenabledp1")
	end,
	function()
		drawStunBar("P1")
	end
)

createHUDElement(
	"p2stun",
	function(n)
		if n then
			changeConfig("redearthstunxp2", n)
		end
		return redearth.stun.P2.x
	end,
	function(n)
		if n then
			changeConfig("redearthstunyp2", n)
		end
		return redearth.stun.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("redearthstunenabledp2", n)
		end
		return redearth.stun.P2.enabled
	end,
	function()
		resetConfig("redearthstunxp2")
		resetConfig("redearthstunyp2")
		resetConfig("redearthstunenabledp2")
	end,
	function()
		drawStunBar("P2")
	end
)
