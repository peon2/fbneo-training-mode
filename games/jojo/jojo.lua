assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

REPLAY_SAVESTATE_INTERVAL = 300

p1maxhealth = 144
p2maxhealth = 144

p1maxmeter = 10
p2maxmeter = 10

wb(0x202CEBD, 0x1) -- unlock characters

local p1direction = 0x2030479
local p2direction = 0x2030881

local p1hitstun = 0x2030551
local p2hitstun = 0x2030959

local p1health = 0x20305AD
local p2health = 0x20309B5

local p1meter = 0x2030443
local p2meter = 0x2030467

local p1standhealth = 0x2030DBD
local p2standhealth = 0x20311C5

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
	["Weak Attack"] = 5,
	["Medium Attack"] = 6,
	["Strong Attack"] = 7,
	["Stand"] = 8,
	["Not in use 1"] = 9,
	["Not in use 2"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=36,
			enabled=true,
		},
		health = {
			P1 = {
				x = 18,
				y = 14,
				enabled = false,
			},
			P2 = {
				x = 352,
				y = 14,
				enabled = false,
			}
		},
		meter = {
			P1 = {
				x = 134,
				y = 216,
				enabled = false,
			},
			P2 = {
				x = 242,
				y = 216,
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
local jojo = { stand = { P1 = {}, P2 = {} } }

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
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
	return rb(p1maxhealth)
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

local function readPlayerOneStandHealth()
	return rb(p1standhealth)
end

local function readPlayerTwoStandHealth()
	return rb(p2standhealth)
end

local function infiniteTime()
	wb(0x202D0B0, 0x63)
end

local function infiniteCredits()
	wb(0x206B850, 0x09)
end

P1ChildMode = false
P2ChildMode = false
function Run() -- runs every frame
	infiniteTime()
	infiniteCredits()
end

initConfigTable("jojo", jojo, "config")

createConfigItem("p1standhealthx", 152, jojo.stand.P1, "x")
createConfigItem("p1standhealthy", 24, jojo.stand.P1, "y")
createConfigItem("p1standhealthenabled", true, jojo.stand.P1, "enabled")

createConfigItem("p2standhealthx", 226, jojo.stand.P2, "x")
createConfigItem("p2standhealthy", 24, jojo.stand.P2, "y")
createConfigItem("p2standhealthenabled", true, jojo.stand.P2, "enabled")

createHUDElement(
	"p1standhealth",
	function(n)
		if n then
			changeConfig("p1standhealthx", n)
		end
		return jojo.stand.P1.x
	end,
	function(n)
		if n then
			changeConfig("p1standhealthy", n)
		end
		return jojo.stand.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("p1standhealthenabled", n)
		end
		return jojo.stand.P1.enabled
	end,
	function()
		resetConfig("p1standhealthx")
		resetConfig("p1standhealthy")
		resetConfig("p1standhealthenabled")
	end,
	function()
		gui.text(jojo.stand.P1.x, jojo.stand.P1.y, readPlayerOneStandHealth(), colour.option1)
	end
)
createHUDElement(
	"p2standhealth",
	function(n)
		if n then
			changeConfig("p2standhealthx", n)
		end
		return jojo.stand.P2.x
	end,
	function(n)
		if n then
			changeConfig("p2standhealthy", n)
		end
		return jojo.stand.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("p2standhealthenabled", n)
		end
		return jojo.stand.P2.enabled
	end,
	function()
		resetConfig("p2standhealthx")
		resetConfig("p2standhealthy")
		resetConfig("p2standhealthenabled")
	end,
	function()
		gui.text(jojo.stand.P2.x, jojo.stand.P2.y, readPlayerTwoStandHealth(), colour.option2)
	end
)
