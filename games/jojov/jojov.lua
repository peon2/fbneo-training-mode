assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
--many of these values came from https://github.com/maximusmaxy/JoJoban-Training-Mode-Menu-FBNeo

p1maxhealth = 144
p2maxhealth = 144

p1maxmeter = 10
p2maxmeter = 10

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
	["Weak Attack"] = 5,
	["Medium Attack"] = 6,
	["Strong Attack"] = 7,
	["Stand"] = 8,
	["Not in use 1"] = 9,
	["Not in use 2"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotextx=176,
		combotexty=34,
		comboenabled=true,
		p1healthx=18,
		p1healthy=14,
		p1healthenabled=true,
		p2healthx=352,
		p2healthy=14,
		p2healthenabled=true,
		p1meterx=134,
		p1metery=216,
		p1meterenabled=true,
		p2meterx=242,
		p2metery=216,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(0x2030479)==0
end

function playerTwoFacingLeft()
	return rb(0x2030881)==0
end

function playerOneInHitstun()
	return rb(0x2030551)~=0
end

function playerTwoInHitstun()
	return rb(0x2030959)~=0
end

function readPlayerOneHealth()
	return rb(0x20305AD)
end

function writePlayerOneHealth(health)
	wb(0x20305AD, health)
end

function readPlayerTwoHealth()
	return rb(0x20309B5)
end

function writePlayerTwoHealth(health)
	wb(0x20309B5, health)
end

function readPlayerOneMeter()
	return rb(0x2030443)
end

function writePlayerOneMeter(meter)
	wb(0x2030443, meter)
end

function readPlayerTwoMeter()
	return rb(0x2030467)
end

function writePlayerTwoMeter(meter)
	wb(0x2030467, meter)
end

function Run() -- runs every frame
	wb(0x202CEBD, 0x1) --unlock characters
	wb(0x202D0B0, 0x63) --infinite time
	wb(0x206B850, 0x09) --infinite credits
end