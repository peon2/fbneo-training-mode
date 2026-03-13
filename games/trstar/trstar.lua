assert(rb,"Run fbneo-training-mode.lua")

--0xDD5EC max health pointer
local p1uid = 0x418000
local p2uid = 0x418080

local p1charid = p1uid + 0x6a
local p2charid = p1uid + 0x6a

local maxhealthtable = 0x0DD5EC

local p1health = 0x41806D
local p2health = 0x4180ED

local function setTRSTARConstants()
	p1maxhealth = rw(maxhealthtable + rw(p1charid*24))
	p2maxhealth = rw(maxhealthtable + rw(p2charid*24))
end
setTRSTARConstants()

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
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Button 4"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		health = {
			P1 = {
				x = 48,
				y = 12,
				enabled = true
			},
			P2 = {
				x = 259,
				y = 12,
				enabled = true
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
			refillhealthenabled = true,
			instantrefillhealth = true
		},
		P2 = {
			refillhealthenabled = true,
			instantrefillhealth = true
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 12,
				y = 215,
				enabled = true
			},
			P2 = {
				x = 245,
				y = 215,
				enabled = true
			}
		},
		scrolling = {
			P1 = {
				x = 25,
				y = 57,
				enabled = true
			},
			P2 = {
				x = 260,
				y = 57,
				enabled = true
			}
		}
	}
}
-- cannot switch sides in this game
function playerOneFacingLeft()
	return false
end

function playerTwoFacingLeft()
	return true
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
	
local timer = 0x41301A
local maxtime = 0x0E10
function infiniteTime()
	ww(timer, maxtime-1)
end

function Run() -- runs every frame
	if rw(timer) == maxtime then
		setTRSTARConstants()
		setGameConstants()
		reloadGUIPages()
	end
	infiniteTime()
end