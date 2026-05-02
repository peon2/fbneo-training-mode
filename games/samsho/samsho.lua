assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print("Known issues with "..ROM_NAME..":")
	print "No control over Hikyaku (delivery man)"
end

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x20
p2maxmeter = 0x20

timer = 0x100A08 -- we can treat this as a byte

local p1uid
local p2uid

local maxstun = 0x40 -- not sure about this
local maxstunreset = 0x130 -- not sure about this

uidoffset = {
	P1UIDLocation = 0x100A0A,
	P2UIDLocation = 0x100A0E,
	direction = 0x4E,
	health = 0xA5,
	healthadd = 0xA6, -- signed word, actually updates health
	meteradd = 0xAC, -- actually updates meter
	meter = 0xCD,
	stunreset = 0xB0, -- word
	stun = 0xB3, -- we can treat this as a byte
	state = 0xBC, -- word
}

function samshoNewRound() -- uid locations update each round
	p1uid = rdw(uidoffset.P1UIDLocation)
	p2uid = rdw(uidoffset.P2UIDLocation)
end

samshoNewRound()

local character_state = { -- found by lansingwolverine
	neutral = 0x0000,
	forward = 0x0001,
	backwards = 0x0002,
	downforward = 0x0003,
	down = 0x0004,
	downback = 0x0005,
	neutraljump = 0x0006,
	forwardjump = 0x0008,
	backjump = 0x0009,
	landingrecovery = 0x0012,
	stunned = 0x0015,
	rageanimation = 0x002E, -- Samsho2, I'm still not sure about this one
	attacking = 0x0100, -- the second byte indicates which attack
	hitstun = 0x0300,
	lightattackhitstun = 0x0304,
	heavyattackhitstun = 0x0305,
	knockeddown = 0x0338,
	gettingup = 0x0315,
	thrown = 0x0500,
	Cthrow = 0x0500,
	Dthrow = 0x0502
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

function playerOneInHitstun()
	local state = rw(p1uid + uidoffset.state)
	local maskedhigh = AND(state, 0xFF00)
	return maskedhigh == character_state.hitstun or maskedhigh == character_state.thrown or state == character_state.stunned
end

function playerTwoInHitstun()
	local state = rw(p2uid + uidoffset.state)
	local maskedhigh = AND(state, 0xFF00)
	return maskedhigh == character_state.hitstun or maskedhigh == character_state.thrown or state == character_state.stunned
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

local maxtime = 0x99

function infiniteTime()
	wb(timer, maxtime-1)
end

local p1previousanimation = false
local p2previousanimation = false

local frameadvantagecalc = false -- we only need to calculate once per animations playing

local p1animationstart = emu.framecount()
local p2animationstart = emu.framecount()

local p1animationend = emu.framecount()
local p2animationend = emu.framecount()

local p1attackstartup = 0
local p2attackstartup = 0

local p1advantage = 0
local p2advantage = 0

local p1animationtotal = 0
local p2animationtotal = 0

local function inAnimation(state)
	return AND(state, 0xFF00) == character_state.attacking or state == character_state.rageanimation
end

local function calcFrameAdvantage()
	local fc = emu.framecount()
	local p1state = rw(p1uid + uidoffset.state)
	local p2state = rw(p2uid + uidoffset.state)
	
	local p1attacking = (AND(p1state, 0xFF00) == character_state.attacking)
	local p2attacking = (AND(p2state, 0xFF00) == character_state.attacking)
	
	local p1animation = playerOneInHitstun() or p1attacking or (p1state == character_state.rageanimation)
	local p2animation = playerTwoInHitstun() or p2attacking or (p2state == character_state.rageanimation)
	
	-- Animation started
	if not p1previousanimation and p1animation then
		p1animationstart = fc
		p1animationend = fc
	end
	if not p2previousanimation and p2animation then
		p2animationstart = fc
		p2animationend = fc
	end
	
	-- Animation ended
	if p1previousanimation and not p1animation then
		p1animationend = fc
		frameadvantagecalc = true
	end
	if p2previousanimation and not p2animation then
		p2animationend = fc
		frameadvantagecalc = true
	end

	-- Both Animations have ended, calculate the values
	if frameadvantagecalc and (not p1animation and not p2animation) then
		frameadvantagecalc = false
		p1attackstartup = 0
		p2attackstartup = 0
		p1animationtotal = 0
		p2animationtotal = 0
		if p2animationend < p1animationstart then -- P1 whiffed attack
			p1animationtotal = p1animationend - p1animationstart
			p1advantage = -p1animationtotal
			p2advantage = p1animationtotal
		elseif p1animationend < p2animationstart then -- P2 whiffed attack
			p2animationtotal = p2animationend - p2animationstart
			p2advantage = -p2animationtotal
		else
			local startup = p1animationstart - p2animationstart
			if startup<0 then -- P1 attacked
				p1attackstartup = math.abs(startup)
			else -- P2 attacked
				p2attackstartup = startup
			end
			p1advantage = p2animationend - p1animationend
			p2advantage = p1animationend - p2animationend
			p1animationtotal = p1animationend - p1animationstart
			p2animationtotal = p2animationend - p2animationstart
		end
	end
	
	p1previousanimation = p1animation
	p2previousanimation = p2animation
end

local function writePlayerOneStunReset(value)
	ww(p1uid + uidoffset.stunreset, value)
end

local function writePlayerTwoStunReset(value)
	ww(p2uid + uidoffset.stunreset, value)
end

function Run()
	if rb(timer) == timemax then
		samshoNewRound()
	end
	infiniteTime()
	calcFrameAdvantage()
	
	if samsho.p1stun then
		writePlayerOneStunReset(0)
	end
	if samsho.p2stun then
		writePlayerTwoStunReset(0)
	end
end

initConfigTable("samsho", samsho, "config")

createConfigItem("samshodisablestunp1", false, samsho, "p1stun")
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
	if _stun > maxstun or readPlayerOneStunReset() == 0 then
		return 0
	else
		return maxstun-_stun
	end
end

local function readPlayerTwoStun()
	local _stun = rb(p2uid + uidoffset.stun)
	if _stun > maxstun or readPlayerTwoStunReset() == 0 then
		return 0
	else
		return maxstun-_stun
	end
end

local function drawStunBarPlayerOne(player)
	local stunreset = readPlayerOneStunReset() -- too large to display on screen
	local xoffset = samsho.stun.P1.x + #"10"*LETTER_WIDTH
	local height = LETTER_HEIGHT-2
	gui.box(xoffset+4, samsho.stun.P1.y, xoffset+maxstunreset/4, samsho.stun.P1.y+height, nil, "grey")
	if stunreset>0 then
		gui.box(xoffset+5, samsho.stun.P1.y+1, xoffset+5+math.floor(stunreset/4), samsho.stun.P1.y+height-1, "cyan", nil)
	end
	gui.text(samsho.stun.P1.x, samsho.stun.P1.y, stunreset, "red")
	
	local stun = readPlayerOneStun()
	local yoffset = 8
	gui.box(xoffset+4, samsho.stun.P1.y+yoffset, xoffset+maxstun, samsho.stun.P1.y+height+yoffset, nil, "grey")
	if stun>0 then
		gui.box(xoffset+5, samsho.stun.P1.y+yoffset+1, xoffset+5+stun, samsho.stun.P1.y+height+yoffset-1, "cyan", nil)
	end
	gui.text(samsho.stun.P1.x, samsho.stun.P1.y+yoffset, stun, "red")
end

local function drawStunBarPlayerTwo(player)
	local stunreset = readPlayerTwoStunReset() -- too large to display on screen
	local xoffset = samsho.stun.P2.x + #"10"*LETTER_WIDTH
	local height = LETTER_HEIGHT-2
	gui.box(xoffset+4, samsho.stun.P2.y, xoffset+maxstunreset/4, samsho.stun.P2.y+height, nil, "grey")
	if stunreset>0 then
		gui.box(xoffset+5, samsho.stun.P2.y+1, xoffset+5+math.floor(stunreset/4), samsho.stun.P2.y+height-1, "cyan", nil)
	end
	gui.text(samsho.stun.P2.x, samsho.stun.P2.y, stunreset, "red")
	
	local stun = readPlayerTwoStun()
	local yoffset = 8
	gui.box(xoffset+4, samsho.stun.P2.y+yoffset, xoffset+maxstun, samsho.stun.P2.y+height+yoffset, nil, "grey")
	if stun>0 then
		gui.box(xoffset+5, samsho.stun.P2.y+yoffset+1, xoffset+5+stun, samsho.stun.P2.y+height+yoffset-1, "cyan", nil)
	end
	gui.text(samsho.stun.P2.x, samsho.stun.P2.y+yoffset, stun, "red")
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
		drawStunBarPlayerOne()
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
		drawStunBarPlayerTwo()
	end
)

createHUDElement(
	"p1framedata",
	function(n)
		if n then
			changeConfig("samshoframedataxp1", n)
		end
		return samsho.framedata.P1.x
	end,
	function(n)
		if n then
			changeConfig("samshoframedatayp1", n)
		end
		return samsho.framedata.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("samshoframedataenabledp1", n)
		end
		return samsho.framedata.P1.enabled
	end,
	function()
		resetConfig("samshoframedataxp1")
		resetConfig("samshoframedatayp1")
		resetConfig("samshoframedataenabledp1")
	end,
	function()
		local xoffset = samsho.framedata.P1.x
		local yoffset = samsho.framedata.P1.y
		gui.text(xoffset, yoffset, "Startup: ")
		gui.text(xoffset+10*LETTER_WIDTH+1, yoffset, p1attackstartup, "green")
		gui.text(xoffset, yoffset+10, "Advantage: ")
		local advantagecolour = "green"
		local _p1advantage = 0
		if p1advantage < 0 then
			advantagecolour = "red"
			_p1advantage = p1advantage
		elseif p1advantage > 0 then
			_p1advantage = "+"..p1advantage
			advantagecolour = "cyan"
		end
		gui.text(xoffset+10*LETTER_WIDTH+1, yoffset+10, _p1advantage, advantagecolour)
		gui.text(xoffset, yoffset+20, "Total: ")
		gui.text(xoffset+10*LETTER_WIDTH+1, yoffset+20, p1animationtotal, "green")
	end
)

createHUDElement(
	"p2framedata",
	function(n)
		if n then
			changeConfig("samshoframedataxp2", n)
		end
		return samsho.framedata.P2.x
	end,
	function(n)
		if n then
			changeConfig("samshoframedatayp2", n)
		end
		return samsho.framedata.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("samshoframedataenabledp2", n)
		end
		return samsho.framedata.P2.enabled
	end,
	function()
		resetConfig("samshoframedataxp2")
		resetConfig("samshoframedatayp2")
		resetConfig("samshoframedataenabledp2")
	end,
	function()
		local xoffset = samsho.framedata.P2.x
		local yoffset = samsho.framedata.P2.y
		gui.text(xoffset, yoffset, "Startup: ")
		gui.text(xoffset+10*LETTER_WIDTH+1, yoffset, p2attackstartup, "green")
		gui.text(xoffset, yoffset+10, "Advantage: ")
		local advantagecolour = "green"
		local _p2advantage = 0
		if p2advantage < 0 then
			advantagecolour = "red"
			_p2advantage = p2advantage
		elseif p2advantage > 0 then
			_p2advantage = "+"..p2advantage
			advantagecolour = "cyan"
		end
		gui.text(xoffset+10*LETTER_WIDTH+1, yoffset+10, _p2advantage, advantagecolour)
		gui.text(xoffset, yoffset+20, "Total: ")
		gui.text(xoffset+10*LETTER_WIDTH+1, yoffset+20, p2animationtotal, "green")
	end
)