assert(rb,"Run fbneo-training-mode.lua")

--p1maxhealth = 0x90
p2maxhealth = 0x90

p1maxmeter = 0x03
p2maxmeter = 0x03

print "Known Issues: with msh"
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
	return rb(0xFF4191)
end

function writePlayerOneHealth(health)
	wb(0xFF4191, health)
end

function readPlayerTwoHealth()
	return rb(0xFF4591)
end

function writePlayerTwoHealth(health)
	wb(0xFF4591, health)
end

function readPlayerOneMeter()
	return rb(0xFF4198)
end

function writePlayerOneMeter(meter)
	wb(0xFF4198, meter)
end

function readPlayerTwoMeter()
	return rb(0xFF4598)
end

function writePlayerTwoMeter(meter)
	wb(0xFF4598, meter)
end

function infiniteTime()
	memory.writebyte(0xFF4808, 0x99)
end

function gemsPlayerOne()
    memory.writebyte(0xFF41B6, 0x00)
    memory.writebyte(0xFF41B7, 0x02)
    memory.writebyte(0xFF41B8, 0x04)
    memory.writebyte(0xFF41B9, 0x06)
    memory.writebyte(0xFF41BA, 0x08)
    memory.writebyte(0xFF41BB, 0x0A)
    
end

gemLoop = true

function Run() -- runs every frame

	infiniteTime()

    while gmeLoop == true do

        gemsPlayerOne()

        gemLoop = false
    end

end

