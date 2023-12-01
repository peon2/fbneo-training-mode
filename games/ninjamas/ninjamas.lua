assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xD0
p2maxhealth = 0xD0

p1maxmeter = 0x60
p2maxmeter = 0x60

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"coin",
	"start",
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button A"] = 5,
	["Button B"] = 6,
	["Button C"] = 7,
	["Button D"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotextx=150,
		combotexty=42,
		comboenabled=true,
		p1healthx=25,
		p1healthy=19,
		p1healthenabled=true,
		p2healthx=284,
		p2healthy=19,
		p2healthenabled=true,
		p1meterx=120,
		p1metery=207,
		p1meterenabled=true,
		p2meterx=193,
		p2metery=207,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0x100d21)==0
end
	
function playerTwoFacingLeft()
		return rb(0x101d21)==0
end

function playerOneInHitstun()
	return rb(0x100089)~=0
end

function playerTwoInHitstun()
	return rb(0x101089)~=0
end

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
	-- After meter is used ingame it turns grey and is disabled until it reaches 0
	if rb(0x1000AC) == 7 then
		wb(0x1000AE, 0)
	else
		wb(0x1000AE, meter)
	end
end

function readPlayerTwoMeter()
	return rb(0x1010AE)
end

function writePlayerTwoMeter(meter)
	if rb(0x1010AC) == 7 then
		wb(0x1010AE, 0)
	else
		wb(0x1010AE, meter)
	end
end

function infiniteTime()
	wb(0x10C021, 0x9A)
end

function Run() -- runs every frame
	infiniteTime()
end
