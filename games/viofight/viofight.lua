assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 64
p2maxhealth = 64

local p1health = 0xA0021C
local p2health = 0xA0029C

local p1position = 0xA01608
local p2position = 0xA01648

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
	["Button 1"] = 5,
	["Button 2"] = 6,
	["Button 3"] = 7,
	["Coin"] = 8,
	["Start"] = 9,
	["Select"] = 10,
}

gamedefaultconfig = {
	hud = {
		health = {
			P1 = {
				x = 8,
				y = 27,
				enabled = false,
			},
			P2 = {
				x = 381,
				y = 27,
				enabled = false,
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
			instantrefillhealth = true,
			refillhealthenabled = true
		},
		P2 = {
			instantrefillhealth = true,
			refillhealthenabled = true
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 68,
				y = 192,
				enabled = true
			},
			P2 = {
				x = 202,
				y = 192,
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
			},
		}
	}
}

-- Health is a range from 0x1 -> 0x64, skipping ABCDEF numerals
local dectable = {}
for i = 0, 64 do
	dectable[tonumber("0x"..i)] = i
end

local function decToHex(dec)
	return dectable[dec]
end

local hextable = {
	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10,
	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x20,
	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x30,
	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x40,
	0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x50,
	0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x60,
	0x61, 0x62, 0x63, 0x64
}
local function hexToDec(hex)
	return hextable[hex]
end


function playerOneFacingLeft()
	return rw(p2position)-rw(p1position)>0
end

function playerTwoFacingLeft()
	return rw(p1position)-rw(p2position)>0
end

function readPlayerOneHealth()
	return decToHex(rw(p1health))
end

function writePlayerOneHealth(health)
	ww(p1health, hexToDec(health))
end

function readPlayerTwoHealth()
	return decToHex(rw(p2health))
end

function writePlayerTwoHealth(health)
	ww(p2health, hexToDec(health))
end

function infiniteTime()
	wdw(0xA00140, 0x01009999)
end

function Run() -- runs every frame
	infiniteTime()
end