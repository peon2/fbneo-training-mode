assert(rb,"Run fbneo-training-mode.lua")

print "Known Issues:"
print "Doesn't track direction or hitstun"

p1maxhealth = 0x90
p2maxhealth = 0x90
p1maxmeter = 3
p2maxmeter = 3

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
	return rw(0xff4000+0x210)
end

function writePlayerOneHealth(health)
	ww(0xff4000+0x210, health)
	ww(0xff4800+0x21a, health)
	ww(0xff4000+0x21a, health)
	ww(0xff4800+0x21a, health)
end

function readPlayerTwoHealth()
	return rw(0xff4400+0x210)
end

function writePlayerTwoHealth(health)
	ww(0xff4400+0x210, health)
	ww(0xff4c00+0x21a, health)
	ww(0xff4400+0x21a, health)
	ww(0xff4c00+0x21a, health)
end

function readPlayerOneMeter()
	return rb(0xff4000+0x214, meter)
end

function writePlayerOneMeter(meter)
	wb(0xff4000+0x214, meter)
    ww(0xff4000+0x212, 0x90)
	wb(0xff4800+0x214, meter)
    ww(0xff4800+0x212, 0x90)
end

function readPlayerTwoMeter()
	return rb(0xff4400+0x214, meter)
end

function writePlayerTwoMeter(meter)
	wb(0xff4400+0x214, meter)
    ww(0xff4400+0x212, 0x90)
	wb(0xff4c00+0x214, meter)
    ww(0xff4c00+0x212, 0x90)
end

function infiniteTime()
	memory.writebyte(0xff5008,0x99)
end

function Run()
	infiniteTime()
end