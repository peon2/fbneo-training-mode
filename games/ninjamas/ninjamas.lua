assert(rb,"Run fbneo-training-mode.lua")

--p1maxhealth = 0xD0
p2maxhealth = 0xD0

p1maxmeter = 0x60
p2maxmeter = 0x60

print "Known Issues: with ninjamas"
print "GUI not working"
print ""

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
	["Button A"] = 8,
	["Button B"] = 9,
	["Button C"] = 10,
	["Button D"] = 11,
}

gamedefaultconfig = {
	combogui = {
		combotextx=180,
		combotexty=42,
	},
}

function readPlayerOneHealth()
	return rb(0x100050)
end

function writePlayerOneHealth(health)
	wb(0x100050, health)
end

function readPlayerTwoHealth()
	return rb(0x101050)
end

function writePlayerTwoHealth(health)
	wb(0x101050, health)
end

function readPlayerOneMeter()
	return rb(0x1000AE)
end

function writePlayerOneMeter(meter)
	wb(0x1000AE, meter)
end

function readPlayerTwoMeter()
	return rb(0x1010AE)
end

function writePlayerTwoMeter(meter)
	wb(0x1010AE, meter)
end

function infiniteTime()
	memory.writebyte(0x10C021, 0x9A)
end

function Run() -- runs every frame
	infiniteTime()
end
