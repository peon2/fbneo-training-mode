assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x20
p2maxmeter = 0x20

timer = 0x100A08 -- we can treat this as a byte
local timemax = 0x99

local p1uid
local p2uid

local p1char
local p2char

local p1maxstun
local p2maxstun
local p1maxstunreset
local p2maxstunreset

samshostunlookup = 0x0004D0D4 -- lookup table for character stun reset values
	
uidoffset = {
	P1UIDLocation = 0x100A0A,
	P2UIDLocation = 0x100A0E,
	character = 0x31, -- we can treat this as a byte, I'm pretty sure this is the address for character, but I can't be certain.
	direction = 0x4E,
	health = 0xA5,
	healthadd = 0xA6, -- signed word, actually updates health
	meteradd = 0xAC, -- actually updates meter
	meter = 0xCD,
	stunreset = 0xB0, -- word
	stun = 0xB3, -- we can treat this as a byte
	state = 0xBC, -- word
}

function newRound() -- uid locations update each round
	p1uid = rdw(uidoffset.P1UIDLocation)
	p2uid = rdw(uidoffset.P2UIDLocation)
	p1char = rb(p1uid+uidoffset.character)
	p2char = rb(p2uid+uidoffset.character)
	p1maxstunreset = rw(samshostunlookup+p1char*4)
	p1maxstun = rw(2+samshostunlookup+p1char*4)
	p2maxstunreset = rw(samshostunlookup+p2char*4)
	p2maxstun = rw(2+samshostunlookup+p2char*4)
end

newRound()

character_state = { -- found by lansingwolverine
	neutral = 0x0000,
	forward = 0x0001,
	backwards = 0x0002,
	downforward = 0x0003,
	down = 0x0004,
	downback = 0x0005,
	neutraljump = 0x0006,
	forwardjump = 0x0008,
	backjump = 0x0009,
	preguard = 0x000E,
	standingproximityguard = 0x000F, -- also the end of blockstun
	crouchingproximityguard = 0x0010,
	crouchingendguard = 0x0011,
	landingrecovery = 0x0012,
	stunned = 0x0015,
	rageanimation = 0x002E, -- Samsho2, I'm still not sure about this one
	backdash = 0x001D,
	run = 0x001E,
	lightbladebounceback = 0x001F,
	heavybladebounceback = 0x0020,
	lightheavybladebounceback = 0x0032,
	crouchheavybladebounceback = 0x0033,
	-- attacks seems to be between 0x0100 and 0x011F?
	Cthrown = 0x0120,
	Dthrown = 0x0123,
	-- special attacks seems to be between 0x0124 and 0x0200?
	lightattackhitstun = 0x0304,
	heavyattackhitstun = 0x0305,
	lightattackcrouchhitstun = 0x0307,
	heavyattackcrouchhitstun = 0x0308,
	lightattackblockstun = 0x0312,
	heavyattackblockstun = 0x0312,
	lightattackcrouchblockstun = 0x0313,
	heavyattackcrouchblockstun = 0x0313,
	nobladestandblockstun = 0x0312,
	nobladecrouchblockstun = 0x0313,
	knockeddown = 0x0338,
	gettingup = 0x0315,
	Cthrow = 0x0327,
	Dthrow = 0x0328,
}

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"coin",
	"start",
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button A"] = 5,
	["Button B"] = 6,
	["Button C"] = 7,
	["Button D"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			x = 144,
			y = 57
		},
		health = {
			P1 = {
				x = 18,
				y = 20,
				enabled = false,
			},
			P2 = {
				x = 291,
				y = 20,
				enabled = false,
			}
		},
		meter = {
			P1 = {
				x = 114,
				y = 208,
				enabled = false,
			},
			P2 = {
				x = 199,
				y = 208,
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
			instantrefillmeter = true,
			refillmeterenabled = true,
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 62,
				y = 190,
				enabled = false
			},
			P2 = {
				x = 202,
				y = 190,
				enabled = false
			}
		},
	}
}

local samsho = { stun = { P1 = {}, P2 = {} }, framedata = { P1 = {}, P2 = {} } }

function playerOneFacingLeft()
	return rb(p1uid+uidoffset.direction)==1
end

function playerTwoFacingLeft()
	return rb(p2uid+uidoffset.direction)==1
end

local function inHitstun(state)
	return (state >= character_state.Cthrown and state <= character_state.Dthrown) or
	       (state == character_state.stunned) or
		   (
			(state >= 0x300 and state <= 0x400) and
			(state < character_state.lightattackblockstun or state > character_state.nobladecrouchblockstun)
		   )
end

function playerOneInHitstun()
	return inHitstun(rw(p1uid + uidoffset.state))
end

function playerTwoInHitstun()
	return inHitstun(rw(p2uid + uidoffset.state))
end

local function inAnimation(state)
	return inHitstun(state) or
	       (state >= 0x0100 and state <= 0x011F) or
		   (state >= 0x0124 and state <= 0x0200) or
		   (state >= character_state.lightattackblockstun and state <= character_state.nobladecrouchblockstun) or
		   (state >= character_state.lightbladebounceback and state <= character_state.crouchheavybladebounceback) or
		   (state >= character_state.Cthrow and state <= character_state.Dthrow) or
		   state == character_state.rageanimation
end

function playerOneInAnimation()
	return inAnimation(rw(p1uid + uidoffset.state))
end

function playerTwoInAnimation()
	return inAnimation(rw(p2uid + uidoffset.state))
end

--[[
	Samsho decrements health by 1 every frame instead of taking it all away at once like other games.
	Calculate what the health will be after it decrements using uidoffset.healthadd,
	otherwise the training mode thinks a character is getting hit every frame.
--]]
function readPlayerOneHealth()
	return rb(p1uid + uidoffset.health) + rws(p1uid + uidoffset.healthadd)
end
function readPlayerTwoHealth()
	return rb(p2uid + uidoffset.health) + rws(p2uid + uidoffset.healthadd)
end

--[[
	Writing to healthadd forces the healthbar to update
--]]
function writePlayerOneHealth(health)
	wb(p1uid + uidoffset.health, health+1)
	ww(p1uid + uidoffset.healthadd, 0xFFFF) -- take one away
end
function writePlayerTwoHealth(health)
	wb(p2uid + uidoffset.health, health+1)
	ww(p2uid + uidoffset.healthadd, 0xFFFF) -- take one away
end

function readPlayerOneMeter()
	return rb(p1uid + uidoffset.meter) + rb(p1uid + uidoffset.meteradd)
end

function writePlayerOneMeter(meter)
	wb(p1uid + uidoffset.meteradd, meter - rb(p1uid + uidoffset.meter))
end

function readPlayerTwoMeter()
	return rb(p2uid + uidoffset.meter) + rb(p2uid + uidoffset.meteradd)
end

function writePlayerTwoMeter(meter)
	wb(p2uid + uidoffset.meteradd, meter - rb(p2uid + uidoffset.meter))
end

function infiniteTime()
	wb(timer, timemax-1)
end

local function writePlayerOneStunReset(value)
	ww(p1uid + uidoffset.stunreset, value)
end

local function writePlayerTwoStunReset(value)
	ww(p2uid + uidoffset.stunreset, value)
end

function Run()
	if rb(timer) == timemax then
		newRound()
	end
	infiniteTime()

	if samsho.p1stun then
		writePlayerOneStunReset(0)
	end
	if samsho.p2stun then
		writePlayerTwoStunReset(0)
	end
end

function OnSaveStateLoad()
	newRound()
end

initConfigTable("samsho", samsho, "config")

createConfigItem("samshodisablestunp1", true, samsho, "p1stun")
createConfigItem("samshodisablestunp2", false, samsho, "p2stun")

createConfigItem("samshostunenabledp1", false, samsho.stun.P1, "enabled")
createConfigItem("samshostunxp1", 30, samsho.stun.P1, "x")
createConfigItem("samshostunyp1", 45, samsho.stun.P1, "y")
createConfigItem("samshostunenabledp2", true, samsho.stun.P2, "enabled")
createConfigItem("samshostunxp2", 230, samsho.stun.P2, "x")
createConfigItem("samshostunyp2", 45, samsho.stun.P2, "y")

createConfigItem("samshoframedataenabledp1", true, samsho.framedata.P1, "enabled")
createConfigItem("samshoframedataxp1", 30, samsho.framedata.P1, "x")
createConfigItem("samshoframedatayp1", 60, samsho.framedata.P1, "y")
createConfigItem("samshoframedataenabledp2", false, samsho.framedata.P2, "enabled")
createConfigItem("samshoframedataxp2", 230, samsho.framedata.P2, "x")
createConfigItem("samshoframedatayp2", 60, samsho.framedata.P2, "y")


local function readPlayerOneStunReset()
	return rw(p1uid + uidoffset.stunreset)
end

local function readPlayerTwoStunReset()
	return rw(p2uid + uidoffset.stunreset)
end

local function readPlayerOneStun()
	local _stun = rb(p1uid + uidoffset.stun)
	if _stun > p1maxstun or readPlayerOneStunReset() == 0 then
		return 0
	else
		return p1maxstun-_stun
	end
end

local function readPlayerTwoStun()
	local _stun = rb(p2uid + uidoffset.stun)
	if _stun > p2maxstun or readPlayerTwoStunReset() == 0 then
		return 0
	else
		return p2maxstun-_stun
	end
end

createHUDElement(
	"p1stun",
	function(n)
		if n then
			changeConfig("samshostunxp1", n)
		end
		return samsho.stun.P1.x
	end,
	function(n)
		if n then
			changeConfig("samshostunyp1", n)
		end
		return samsho.stun.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("samshostunenabledp1", n)
		end
		return samsho.stun.P1.enabled
	end,
	function()
		resetConfig("samshostunxp1")
		resetConfig("samshostunyp1")
		resetConfig("samshostunenabledp1")
	end,
	function()
		drawFillBar(
			samsho.stun.P1.x,
			samsho.stun.P1.y,
			readPlayerOneStunReset(),
			LETTER_WIDTH*3,
			math.floor(readPlayerOneStunReset()/4),
			math.floor(p1maxstunreset/4)
		)
		drawFillBar(
			samsho.stun.P1.x,
			samsho.stun.P1.y+LETTER_HEIGHT,
			readPlayerOneStun(),
			LETTER_WIDTH*3,
			readPlayerOneStun(),
			p1maxstun
		)
	end
)

createHUDElement(
	"p2stun",
	function(n)
		if n then
			changeConfig("samshostunxp2", n)
		end
		return samsho.stun.P2.x
	end,
	function(n)
		if n then
			changeConfig("samshostunyp2", n)
		end
		return samsho.stun.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("samshostunenabledp2", n)
		end
		return samsho.stun.P2.enabled
	end,
	function()
		resetConfig("samshostunxp2")
		resetConfig("samshostunyp2")
		resetConfig("samshostunenabledp2")
	end,
	function()
		drawFillBar(
			samsho.stun.P2.x,
			samsho.stun.P2.y,
			readPlayerTwoStunReset(),
			LETTER_WIDTH*3,
			math.floor(readPlayerTwoStunReset()/4),
			math.floor(p2maxstunreset/4)
		)
		drawFillBar(
			samsho.stun.P2.x,
			samsho.stun.P2.y+LETTER_HEIGHT,
			readPlayerTwoStun(),
			LETTER_WIDTH*3,
			readPlayerTwoStun(),
			p2maxstun
		)
	end
)