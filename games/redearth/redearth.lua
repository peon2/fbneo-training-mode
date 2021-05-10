assert(rb,"Run fbneo-training-mode.lua")

--p1maxhealth = 124
-- p2maxhealth = 124
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

function playerOneFacingLeft()
	return rb(0x206aa66) == 16
end

function playerTwoFacingLeft()
	return rb(0x206aa66) == 0
end

function _playerOneInHitstun()
	
end

function playerTwoInHitstun()
	return rb(0x206AAEE)~=0 -- inconsistent
end

function readPlayerOneHealth()
	return rb(0x206A843)
end

function writePlayerOneHealth(health)
	return wb(0x206a841, health)
end

function readPlayerTwoHealth()
	return rb(0x206A713)
end

function writePlayerTwoHealth(health)
	wb(0x206AAC1, health)
end

function readPlayerOneMeter()
	return rb(0x206A8D5)
end

function writePlayerOneMeter(meter)

	if meter > 3 then meter = 3 end
	memory.writebyte(0x206A8D5, meter)
	for i = 1,meter do
		memory.writebyte(0x0206A8CD+i, 2)
	end
end

function _readPlayerTwoMeter()

end

function _writePlayerTwoMeter(meter)
	
end

function infiniteTime()
	memory.writebyte(0x2060701,154)
	gui.text(184,72, "Stun: " ..rb(0x206AADA), "green")
end

function Run()
	infiniteTime()
	P2StunMeter = rb(0x206AADA)
	P2StunCounter = rb(0x206AB13)
	P2UnitID = memory.readbyte(0x206AB25)

	if P2UnitID == 0 then P2StunResistance = 36
	elseif	P2UnitID == 1 then P2StunResistance = 34
	elseif	P2UnitID == 2 then P2StunResistance = 30
	elseif	P2UnitID == 3 then P2StunResistance = 28
	end
	
	P2TotalSR = P2StunResistance + (P2StunCounter*5) -- maths to figure out stun cap
	
	gui.text(184,72, "Stun: " ..P2StunMeter, "green")
	gui.text(168,82, "Max Stun: " ..P2TotalSR, "green")
end
