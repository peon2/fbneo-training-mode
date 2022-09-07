assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x78
p2maxhealth = 0x78

local p1health = 0x100489
local p2health = 0x100589

local p1direction = 0x100471
local p2direction = 0x100571

-- Note that fatfury3 has no meter

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
		combotextx=144,
		combotexty=42,
		comboenabled=true,
		p1healthx=25,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=284,
		p2healthy=21,
		p2healthenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(0x1004CC)~=0 or rb(0x1004CD)==8 -- damage animation? seems to be a word, being hit causes animations 0x4000 or higher, some special moves trigger 0x0008
end

function playerTwoInHitstun()
	return rb(0x1005CC)~=0 or rb(0x1005CD)==8 -- damage animation? seems to be a word, being hit causes animations 0x4000 or higher, some special moves trigger 0x0008
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
	ww(0x105680, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
