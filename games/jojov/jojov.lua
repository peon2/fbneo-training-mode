assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
--many of these values came from https://github.com/maximusmaxy/JoJoban-Training-Mode-Menu-FBNeo

p1maxhealth = 144
p2maxhealth = 144

p1maxmeter = 10
p2maxmeter = 10

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
	["Weak Attack"] = 7,
	["Medium Attack"] = 8,
	["Strong Attack"] = 9,
	["Stand"] = 10,
	["Not in use 1"] = 11,
	["Not in use 2"] = 12,
}

gamedefaultconfig = {
	combogui = {
		combotextx=176,
		combotexty=55,
	},
}

function playerOneFacingLeft()
	return rb(0x2030479)==0
end

function playerTwoFacingLeft()
	return rb(0x2030881)==0
end

function playerOneInHitstun()
	return rb(0x2030551)~=0
end

function playerTwoInHitstun()
	return rb(0x2030959)~=0
end

function readPlayerOneHealth()
	return rb(0x20305AD)
end

function writePlayerOneHealth(health)
	wb(0x20305AD, health)
end

function readPlayerTwoHealth()
	return rb(0x20309B5)
end

function writePlayerTwoHealth(health)
	wb(0x20309B5, health)
end

function readPlayerOneMeter()
	return rb(0x2030443)
end

function writePlayerOneMeter(meter)
	wb(0x2030443, meter)
end

function readPlayerTwoMeter()
	return rb(0x2030467)
end

function writePlayerTwoMeter(meter)
	wb(0x2030467, meter)
end

function Run() -- runs every frame
	wb(0x202CEBD, 0x1) --unlock characters
	wb(0x202D0B0, 0x63) --infinite time
	wb(0x206B850, 0x09) --infinite credits
end