assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 256
p2maxhealth = 256

print "Known Issues: with lb2"
print "Can't write health or meter"
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

function playerOneFacingLeft()
	return rb(0x10872f)==1
end

function playerOneFacingLeft()
	return rb(0x10872f)==0
end

function playerOneInHitstun()
	return rb(0x10e483)~=0
end

function playerTwoInHitstun()
	return rb(0x10e482)~=0
end

function readPlayerOneHealth()
	return rw(0x10e592)
end

function _writePlayerOneHealth(health) -- writing health issue
	return rb(0x10537E, health)
end

function readPlayerTwoHealth()
	return rw(0x10e590)
end

function _writePlayerTwoHealth(health) -- writing health issue
	wb(0x10197f, health)
end

function _readPlayerOneMeter() -- reading meter issue
	return rb(0x10537d)--0x205BB63)
end

function _writePlayerOneMeter(meter)  -- writing meter issue
	wb(0x2034863, meter)
end

function _readPlayerTwoMeter() -- reading meter issue
	return rb(0x10537d)--0x205BB63)
end

function _writePlayerTwoMeter(meter)  -- writing meter issue
	wb(0x2034863, meter)
end

local infiniteCredit = function()
	wb(0x10e595, 0x99)
end

function Run()
	infiniteCredit()
end