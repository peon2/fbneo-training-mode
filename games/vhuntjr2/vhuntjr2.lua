assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 0x70
p2maxmeter = 0x70


local p1health = 0xFF83CB
local p2health = 0xFF88CB

local p1meter = 0xFF855F
local p2meter = 0xFF8A5F

local p1stocks = 0xFF8565
local p2stocks = 0xFF8A65

translationtable = {
	{
		"coin",
		"start",
		"up",
		"down",
		"left",
		"right",
		"button1",
		"button2",
		"button3",
		"button4",
		"button5",
		"button6",
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Weak Punch"] = 7,
	["Medium Punch"] = 8,
	["Strong Punch"] = 9,
	["Weak Kick"] = 10,
	["Medium Kick"] = 11,
	["Strong Kick"] = 12
}

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function writePlayerOneMeter(meter)
	ww(p1meter, meter)
	wb(p1stocks, 0x0A)
end

function writePlayerTwoMeter(meter)
	ww(p2meter, meter)
	wb(p2stocks, 0x0A)
end

local infiniteTime = function()
	wb(0xFF8E09, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end
