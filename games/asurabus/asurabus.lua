assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xEF
--p2maxhealth = 0xEF

p1maxmeter = 0x50
p2maxmeter = 0x50

print "Known Issues: with asurabus"
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
	},
	["Coin"] = 1,
	["Start"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Left"] = 5,
	["Right"] = 6,
	["Button 1"] = 7,
	["Button 2"] = 8,
	["Button 3"] = 9,
}

function readPlayerOneHealth()
	return rb(0x4034EB)
end

function writePlayerOneHealth(health)
	wb(0x4034EB, health)
end

function readPlayerTwoHealth()
	return rb(0x4041A5)
end

function writePlayerTwoHealth(health)
	wb(0x4041A5, health)
end

function readPlayerOneMeter()
	return rb(0x4034F3)
end

function writePlayerOneMeter(meter)
	wb(0x4034EF, meter)
    wb(0x4034F3, meter)
end

function readPlayerTwoMeter()
	return rb(0x4041A9)
end

function writePlayerTwoMeter(meter)
	wb(0x4041AD, meter)
    wb(0x4041A9, meter)
end

function infiniteTime()
	memory.writebyte(0x40000A, 0x99)
end

function secretCharacters()
    wb(0x408837, 0x01)
    wb(0x408839, 0x01)
end

function Run() -- runs every frame
	infiniteTime()
    secretCharacters()
end
