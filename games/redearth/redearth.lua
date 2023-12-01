assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 124
p2maxhealth = 124
p1maxmeter = 3
p2maxmeter = 3

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"button5",
	"button6",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Weak Punch"] = 5,
	["Medium Punch"] = 6,
	["Strong Punch"] = 7,
	["Weak Kick"] = 8,
	["Medium Kick"] = 9,
	["Strong Kick"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hitbox = {
		enabled=true,
	},
	hud = {
		combotextx=180,
		combotexty=42,
		comboenabled=true,
		p1healthx=49,
		p1healthy=12,
		p1healthenabled=true,
		p2healthx=324,
		p2healthy=12,
		p2healthenabled=true,
		p1meterx=162,
		p1metery=28,
		p1meterenabled=true,
		p2meterx=220,
		p2metery=28,
		p2meterenabled=true,
	},
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
	wb(0x206A8D5, meter)
	for i = 1,meter do
		wb(0x0206A8CD+i, 2)
	end
end

function _readPlayerTwoMeter()

end

function _writePlayerTwoMeter(meter)
	
end

local function infiniteTime()
	wb(0x2060701,154)
end

stunMeterEnabled = true

local function stunMeter()
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

function Run()
	infiniteTime()
	if stunMeterEnabled then stunMeter() end
end
