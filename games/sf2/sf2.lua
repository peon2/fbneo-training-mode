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

local stunresetoffset = 0x5C  -- word
local maxstunreset = 0x80 -- I don't know how large this should actually be
local stunoffset = 0x5F  -- byte
local maxstun = 0x1E -- if a character has 0x1E stun (or more) and gets hit, they're stunned

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
			instantrefillhealth = false,
			refillhealthenabled = true,
			refillhealthspeed = 1 -- hitstun won't work in sf2 if health is refilling, refill it in 1f
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			refillhealthspeed = 1
		}
	}
}

local sf2 = { stun = { P1 = {}, P2 = {} } }

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

local function readPlayerOneStun()
	return rb(p1uid + stunoffset)
end

local function readPlayerTwoStun()
	return rb(p2uid + stunoffset)
end

local function readPlayerOneStunReset()
	return rw(p1uid + stunresetoffset)
end

local function readPlayerTwoStunReset()
	return rw(p2uid + stunresetoffset)
end

local function writePlayerOneStunReset(value)
	ww(p1uid + stunresetoffset, value)
end

local function writePlayerTwoStunReset(value)
	ww(p2uid + stunresetoffset, value)
end

local function drawStunBarPlayerOne(player)
	local stun = readPlayerOneStun()
	local stunreset = readPlayerOneStunReset()
	local xoffset = sf2.stun.P1.x + #"10"*LETTER_WIDTH
	local heigth = LETTER_HEIGHT-2
	gui.box(xoffset, sf2.stun.P1.y, xoffset+maxstunreset, sf2.stun.P1.y+heigth, nil, "grey")
	if stunreset>0 then
		gui.box(xoffset+1, sf2.stun.P1.y+1, xoffset+stunreset-1, sf2.stun.P1.y+heigth-1, "cyan", nil)
	end
	gui.text(sf2.stun.P1.x, sf2.stun.P1.y, stunreset, "red")
	local yoffset = 8
	gui.box(xoffset, sf2.stun.P1.y+yoffset, xoffset+maxstun, sf2.stun.P1.y+heigth+yoffset, nil, "grey")
	if stun>0 then
		gui.box(xoffset+1, sf2.stun.P1.y+yoffset+1, xoffset+stun-1, sf2.stun.P1.y+heigth+yoffset-1, "cyan", nil)
	end
	gui.text(sf2.stun.P1.x, sf2.stun.P1.y+yoffset, stun, "red")
end

local function drawStunBarPlayerTwo(player)
	local stun = readPlayerTwoStun()
	local stunreset = readPlayerTwoStunReset()
	local xoffset = sf2.stun.P2.x + #"10"*LETTER_WIDTH
	local heigth = LETTER_HEIGHT-2
	gui.box(xoffset, sf2.stun.P2.y, xoffset+maxstunreset, sf2.stun.P2.y+heigth, nil, "grey")
	if stunreset>0 then
		gui.box(xoffset+1, sf2.stun.P2.y+1, xoffset+stunreset-1, sf2.stun.P2.y+heigth-1, "cyan", nil)
	end
	gui.text(sf2.stun.P2.x, sf2.stun.P2.y, stunreset, "red")
	local yoffset = 8
	gui.box(xoffset, sf2.stun.P2.y+yoffset, xoffset+maxstun, sf2.stun.P2.y+heigth+yoffset, nil, "grey")
	if stun>0 then
		gui.box(xoffset+1, sf2.stun.P2.y+yoffset+1, xoffset+stun-1, sf2.stun.P2.y+heigth+yoffset-1, "cyan", nil)
	end
	gui.text(sf2.stun.P2.x, sf2.stun.P2.y+yoffset, stun, "red")
end


local function infiniteTime()
	wb(timer, maxtime)
end

function setMusicVolume(volume) -- squeeze from 0 to 100
	local volume = math.floor( (volume*maxvolume)/100 )
	memory.writebyte_audio(musicvolume, volume)
end

function Run() -- runs every frame
	infiniteTime()
	setMusicVolume(sf2.musicvolume)
	if sf2.p1stun then
		writePlayerOneStunReset(0)
	end
	if sf2.p2stun then
		writePlayerTwoStunReset(0)
	end
end

initConfigTable("sf2", sf2, "config")
createConfigValue(
	"sf2musicvolume",
	"musicvolume",
	50,
	sf2,
	sf2,
	"config"
)
createConfigValue(
	"sf2disablestunp1",
	"p1stun",
	false,
	sf2,
	sf2,
	"config"
)
createConfigValue(
	"sf2disablestunp2",
	"p2stun",
	false,
	sf2,
	sf2,
	"config"
)

createConfigValue(
	"sf2stunenabledp1",
	"enabled",
	false,
	sf2.stun.P1,
	sf2.stun.P1,
	"config"
)
createConfigValue(
	"sf2stunxp1",
	"x",
	29,
	sf2.stun.P1,
	sf2.stun.P1,
	"config"
)
createConfigValue(
	"sf2stunyp1",
	"y",
	44,
	sf2.stun.P1,
	sf2.stun.P1,
	"config"
)

createConfigValue(
	"sf2stunenabledp2",
	"enabled",
	true,
	sf2.stun.P2,
	sf2.stun.P2,
	"config"
)
createConfigValue(
	"sf2stunxp2",
	"x",
	232,
	sf2.stun.P2,
	sf2.stun.P2,
	"config"
)
createConfigValue(
	"sf2stunyp2",
	"y",
	44,
	sf2.stun.P2,
	sf2.stun.P2,
	"config"
)

createHUDElement(
	"p1stun",
	function(n)
		if n then
			changeConfig("sf2stunxp1", n)
		end
		return sf2.stun.P1.x
	end,
	function(n)
		if n then
			changeConfig("sf2stunyp1", n)
		end
		return sf2.stun.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sf2stunenabledp1", n)
		end
		return sf2.stun.P1.enabled
	end,
	function()
		resetConfig("sf2stunxp1")
		resetConfig("sf2stunyp1")
		resetConfig("sf2stunenabledp1")
	end,
	function()
		drawStunBarPlayerOne()
	end
)

createHUDElement(
	"p2stun",
	function(n)
		if n then
			changeConfig("sf2stunxp2", n)
		end
		return sf2.stun.P2.x
	end,
	function(n)
		if n then
			changeConfig("sf2stunyp2", n)
		end
		return sf2.stun.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("sf2stunenabledp2", n)
		end
		return sf2.stun.P2.enabled
	end,
	function()
		resetConfig("sf2stunxp2")
		resetConfig("sf2stunyp2")
		resetConfig("sf2stunenabledp2")
	end,
	function()
		drawStunBarPlayerTwo()
	end
)