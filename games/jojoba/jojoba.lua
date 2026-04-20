assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
--many of these values came from https://github.com/maximusmaxy/JoJoban-Training-Mode-Menu-FBNeo

REPLAY_SAVESTATE_INTERVAL = 300

p1maxhealth = 144
p2maxhealth = 144

p1maxmeter = 10
p2maxmeter = 10

wb(0x20312C1, 0x01) -- Unlock Secret Characters

local p1health = 0x20349CD
local p2health = 0x2034DED

local p1meter = 0x2034863 -- 0x205BB63 this is the meter bar
local p2meter = 0x2034887

--local p1combocounter = 0x205BB38
--local p2combocounter = 0x205BB39 --  P2 actionable?

local p1hitstun = 0x2034971
local p2hitstun = 0x2034D91

local p1direction = 0x2034899
local p2direction = 0x2034CB9

local p1standhealth = 0x205BB48
local p2standhealth = 0x205BB49

p1childmode = 0x2034AB2
p2childmode = 0x2034ED2

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
			x=176,
			y=35,
			enabled=true,
		},
		health = {
			P1 = {
				x = 17,
				y = 15,
				enabled = true,
			},
			P2 = {
				x = 356,
				y = 15,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 132,
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
local jojoba = { stand = { P1 = {}, P2 = {}} }

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

local function readPlayerOneStandHealth()
	return rb(p1standhealth)
end

local function readPlayerTwoStandHealth()
	return rb(p2standhealth)
end

function setMusicVolume(volume) -- squeeze from 0 to 100
	if volume < 0 then volume = 0 end
	if volume > 100 then volume = 100 end
	volume = math.floor( (volume*0x80)/100 )
	wb(0x205CC1A, volume)
end

local function infiniteTime()
	wb(0x20314B4, 0x63)
end

local function infiniteCredit()
	wb(0x20713A8, 0x09)
end

P1ChildMode = false
P2ChildMode = false
function Run() -- runs every frame
	infiniteTime()
	infiniteCredit()
	setMusicVolume(jojoba.musicvolume)
	if P1ChildMode then
		wb(p1childmode, 0xFF)
	end
	if P2ChildMode then
		wb(p2childmode, 0xFF)
	end
end

initConfigTable("jojoba", jojoba, "config")
createConfigValue(
	"jojobamusicvolume",
	50,
	jojoba,
	"musicvolume"
)

createConfigValue(
	"p1standhealthx",
	152,
	jojoba.stand.P1,
	"x"
)
createConfigValue(
	"p1standhealthy",
	24,
	jojoba.stand.P1,
	"y"
)
createConfigValue(
	"p1standhealthenabled",
	true,
	jojoba.stand.P1,
	"enabled"
)

createConfigValue(
	"p2standhealthx",
	226,
	jojoba.stand.P2,
	"x"
)
createConfigValue(
	"p2standhealthy",
	24,
	jojoba.stand.P2,
	"y"
)
createConfigValue(
	"p2standhealthenabled",
	true,
	jojoba.stand.P2,
	"enabled"
)

createHUDElement(
	"p1standhealth",
	function(n)
		if n then
			changeConfig("p1standhealthx", n)
		end
		return jojoba.stand.P1.x
	end,
	function(n)
		if n then
			changeConfig("p1standhealthy", n)
		end
		return jojoba.stand.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("p1standhealthenabled", n)
		end
		return jojoba.stand.P1.enabled
	end,
	function()
		resetConfig("p1standhealthx")
		resetConfig("p1standhealthy")
		resetConfig("p1standhealthenabled")
	end,
	function()
		gui.text(jojoba.stand.P1.x, jojoba.stand.P1.y, readPlayerOneStandHealth(), colour.option1)
	end
)
createHUDElement(
	"p2standhealth",
	function(n)
		if n then
			changeConfig("p2standhealthx", n)
		end
		return jojoba.stand.P2.x
	end,
	function(n)
		if n then
			changeConfig("p2standhealthy", n)
		end
		return jojoba.stand.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("p2standhealthenabled", n)
		end
		return jojoba.stand.P2.enabled
	end,
	function()
		resetConfig("p2standhealthx")
		resetConfig("p2standhealthy")
		resetConfig("p2standhealthenabled")
	end,
	function()
		gui.text(jojoba.stand.P2.x, jojoba.stand.P2.y, readPlayerTwoStandHealth(), colour.option2)
	end
)