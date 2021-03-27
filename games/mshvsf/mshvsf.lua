assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90

p1maxmeter = 0x03
p2maxmeter = 0x03

print "Known Issues: with mshsf"
print "GUI noting working"
print ""

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

function readPlayerOneHealth()
	rb(0xFF3A51)
    rb(0xFF3A5B)
    rb(0xFF4251)
    rb(0xFF425B)
    return
end

function writePlayerOneHealth(health)
	wb(0xFF3A51, health)
    wb(0xFF3A5B, health)
    wb(0xFF4251, health)
    wb(0xFF425B, health)
end

function readPlayerTwoHealth()
	rb(0xFF3E51)
    rb(0xFF3E5B)
    rb(0xFF4651)
    rb(0xFF465B)
    return
end

function writePlayerTwoHealth(health)
	wb(0xFF3E51, health)
    wb(0xFF3E5B, health)
    wb(0xFF4651, health)
    wb(0xFF465B, health)
end

function readPlayerOneMeter()
	return rb(0xFF3A54)
end

function writePlayerOneMeter(meter)
	wb(0xFF3A54, meter)
end

function readPlayerTwoMeter()
	return rb(0xFF3E54)
end

function writePlayerTwoMeter(meter)
	wb(0xFF3E54, meter)
end

function infiniteTime()
	memory.writebyte(0xFF4808, 0x99)
end

function Run() -- runs every frame
	infiniteTime()
end

