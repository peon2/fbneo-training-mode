assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xC8
p2maxhealth = 0xC8

p1maxmeter = 0xD8
p2maxmeter = 0xD8

local p1uid = 0x1023D2
local p2uid = 0x10225A

local p1health = p1uid + 0xFD -- health + 3 is red health
local p1char2health = 0x1027BF
local p2health = p2uid + 0xFD
local p2char2health = 0x102067

local p1stun = p1uid + 0x10B -- double word, but we only care about the first byte. The previous dw is char 2 stun
local p2stun = p2uid + 0x10B

local p1meter = p1uid + 0x111
local p2meter = p2uid + 0x111

local p1direction = p1uid + 0x55
local p2direction = p2uid + 0x55

local p1combocounter = 0x102351
local p2combocounter = 0x1024C9

local p1constants = p1uid+0xe6 -- I'm not sure what this is, but it's a pointer to what seems to be some character constants
local p2constants = p2uid+0xe6

local maxstunoffset = 0x5 -- max stun is stored as a little-endian word, we only care about the high byte

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
			x=146,
			y=37,
			enabled=true,
		},
		health = {
			P1 = {
				x = 40,
				y = 16,
				enabled = true,
			},
			P2 = {
				x = 268,
				y = 16,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 94,
				y = 206,
				enabled = true,
			},
			P2 = {
				x = 216,
				y = 206,
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

local rotd = { stun = { P1 = {}, P2 = {} } }

function playerOneFacingLeft()
	return bit.band(rb(p1direction), 1)
end

function playerTwoFacingLeft()
	return bit.band(rb(p2direction), 1)
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
	wb(p1health+3, health) -- red health
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
	wb(p2health+3, health) -- red health
end

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
end

function readPlayerTwoMeter()
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
end

local function readPlayerOneStun()
	return rb(p1stun)
end

local function readPlayerTwoStun()
	return rb(p2stun)
end

local function readPlayerOneMaxStun()
	return rb(rdw(p1constants)+maxstunoffset)
end

local function readPlayerTwoMaxStun()
	return rb(rdw(p2constants)+maxstunoffset)
end

local maxtime = 0x3CFF
function infiniteTime()
	ww(0x106B11, maxtime)
end

function Run() -- runs every frame
	infiniteTime()
end

initConfigTable("rotd", rotd, "config")

createConfigItem("rotdstunenabledp1", false, rotd.stun.P1, "enabled")
createConfigItem("rotdstunxp1", 20, rotd.stun.P1, "x")
createConfigItem("rotdstunyp1", 50, rotd.stun.P1, "y")

createConfigItem("rotdstunenabledp2", true, rotd.stun.P2, "enabled")
createConfigItem("rotdstunxp2", 184, rotd.stun.P2, "x")
createConfigItem("rotdstunyp2", 50, rotd.stun.P2, "y")

local function drawStunBar(player)
	local stunfunc = { P1 = readPlayerOneStun, P2 = readPlayerTwoStun }
	local stun = stunfunc[player]()
	local maxstunfunc = { P1 = readPlayerOneMaxStun, P2 = readPlayerTwoMaxStun }
	local maxstun = maxstunfunc[player]()
	local xoffset = rotd.stun[player].x + #"100"*LETTER_WIDTH
	local heigth = LETTER_HEIGHT-2
	gui.box(xoffset, rotd.stun[player].y, xoffset+maxstun, rotd.stun[player].y+heigth, nil, "grey")
	if stun>0 then
		gui.box(xoffset+1, rotd.stun[player].y+1, xoffset+stun-1, rotd.stun[player].y+heigth-1, "cyan", nil)
	end
	gui.text(rotd.stun[player].x, rotd.stun[player].y, stun, "red")
end

createHUDElement(
	"p1stun",
	function(n)
		if n then
			changeConfig("rotdstunxp1", n)
		end
		return rotd.stun.P1.x
	end,
	function(n)
		if n then
			changeConfig("rotdstunyp1", n)
		end
		return rotd.stun.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("rotdstunenabledp1", n)
		end
		return rotd.stun.P1.enabled
	end,
	function()
		resetConfig("rotdstunxp1")
		resetConfig("rotdstunyp1")
		resetConfig("rotdstunenabledp1")
	end,
	function()
		drawStunBar("P1")
	end
)

createHUDElement(
	"p2stun",
	function(n)
		if n then
			changeConfig("rotdstunxp2", n)
		end
		return rotd.stun.P2.x
	end,
	function(n)
		if n then
			changeConfig("rotdstunyp2", n)
		end
		return rotd.stun.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("rotdstunenabledp2", n)
		end
		return rotd.stun.P2.enabled
	end,
	function()
		resetConfig("rotdstunxp2")
		resetConfig("rotdstunyp2")
		resetConfig("rotdstunenabledp2")
	end,
	function()
		drawStunBar("P2")
	end
)
