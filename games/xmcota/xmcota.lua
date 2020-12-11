assert(rb,"Run fbneo-training-mode.lua")

print "Known Issues:"
print "Doesn't track direction or hitstun"

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 0x8F
p2maxmeter = 0x8F

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

function _playerOneFacingLeft()

end

function _playerTwoFacingLeft()

end

function _playerOneInHitstun()
	
end

function _playerTwoInHitstun()

end

function readPlayerOneHealth()
	return rb(0xFF4055)
end

function writePlayerOneHealth(health)
	wb(0xFF4055, health)
end

function readPlayerTwoHealth()
	return rb(0xFF4055)
end

function writePlayerTwoHealth(health)
	wb(0xFF4455, health)
end

function readPlayerOneMeter()
	return rb(0xFF4191, meter)
end

function writePlayerOneMeter(meter)
	wb(0xFF4191, meter)
end

function readPlayerTwoMeter()
	return rb(0xFF4591, meter)
end

function writePlayerTwoMeter(meter)
	wb(0xFF4591, meter)
end

function infiniteTime()
	memory.writebyte(0xFF4808,0x99)
end

function Run()
	infiniteTime()
end