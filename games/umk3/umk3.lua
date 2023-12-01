assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Known issues with UMK3:"
	print "Coin button also triggers maintenance menu."
	print "Health doesn't refill on throws."
	print "Combo counter doesn't increment correctly."
end

local function getAddressFromPointer(pointeraddress)

    --Read the value at the pointer's address that will be converted to a memory address.
    local bytetable = memory.readbyterange(pointeraddress, 32)
    local targetaddress = ""

    --The address is little-endian so iterate backwards to construct the address as a string.
    for i=32,1,-8 do
        targetaddress = targetaddress .. string.format("%02x", bytetable[i])
    end

    return tonumber(targetaddress, 16)

end

p1maxhealth = 0xa6
p2maxhealth = 0xa6

local p1health = 0x01060a60
local p2health = 0x01061610

local p1direction = 0x01030541
local p2direction = 0x0105fa01

local p1combocounter = getAddressFromPointer(0x010615c0) + 0x390
local p2combocounter = getAddressFromPointer(0x01060a10) + 0x390

local p1inhitstun = false
local p2inhitstun = false

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
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["High Punch"] = 5,
	["Block"] = 6,
	["High Kick"] = 7,
	["Low Punch"] = 8,
    ["Low Kick"] = 9,
    ["Run"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
	["Select"] = 13,
}

gamedefaultconfig = {
	hud = {
		combotextx=185,
		combotexty=38,
		comboenabled=false,
		p1healthx=8,
		p1healthy=27,
		p1healthenabled=true,
		p2healthx=381,
		p2healthy=27,
		p2healthenabled=true
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0x82
end

function playerTwoFacingLeft()
	return rb(p2direction)==0x90
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
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function infiniteTime()
	wdw(0xff80dc60, 0x0300c0d7)
end

function Run()
	infiniteTime()
end
