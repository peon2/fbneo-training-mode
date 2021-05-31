assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x61
p2maxhealth = 0x61

p1maxmeter = 0x2C
p2maxmeter = 0x2C

local p1health = 0x602DF1B
local p2health = 0x602E11B

local p1meter = 0x602DF21
local p2meter = 0x602E121


local p1direction = 0x602de52
local p2direction = 0x602e052

local p1combocounter = 0x602E154
local p2combocounter = 0x602DF54

local p1character = 0x602DE81
local p2character = 0x602E081

translationtable = {
	{
		"coin",
		"start",
		"select",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Select"] = 3,
	["Up"] = 4,
	["Down"] = 5,
	["Left"] = 6,
	["Right"] = 7,
	["Button 1"] = 8,
	["Button 2"] = 9,
	["Button 3"] = 10,
	["Button 4"] = 11,
}

gamedefaultconfig = {
	combogui = {
		combotextx=145,
		combotexty=42,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==8
end

function playerTwoFacingLeft()
	return rb(p2direction)==8
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

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
	if (meter==p1maxmeter) then -- activates the timer
		wb(p1meter+1, 1)
	end
end

function readPlayerTwoMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p2meter, meter)
	if (meter==p2maxmeter) then -- activates the timer
		wb(p2meter+1, 1)
	end
end
--[[
0x60004a0 => head of a linked list? The data all seemed to be sequential though
head+0x10 => next link
head+0x14 => last link???
last link adr-0x600 => link with timer???
	links seem to be allocated in blocks of 0x200 so its 3 links back
link with timer + 0xD4 = timer location
	timer is read as a dword but its only ever the size of a word
--]]

function infiniteTime()
	ww(rdw(0x60004b4)-0x52A, 0x1530)
end

function Run() -- runs every frame
	infiniteTime()
end
