assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x90
p2maxhealth = 0x90

p1maxmeter = 0x03
p2maxmeter = 0x03

function gamemsg()
	print "Known issues with msh:"
	print "No combo counter"
end

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
	hud = {
		p1healthx=18,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=355,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=31,
		p1metery=26,
		p1meterenabled=true,
		p2meterx=350,
		p2metery=26,
		p2meterenabled=true,
	},
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
	wb(0xFF4808, 0x99)
end

function gemsPlayerOne()
    wb(0xFF41B6, 0x00)	--Power
    wb(0xFF41B7, 0x02)	--Time
    wb(0xFF41B8, 0x04)	--Space
    wb(0xFF41B9, 0x06)	--Soul
    wb(0xFF41BA, 0x08)	--Reality
    wb(0xFF41BB, 0x0A)	--Mind

end

function Run() -- runs every frame

	infiniteTime()

	for gemMem = 0xFF41B6, 0xFF41BB, 1 do
		if rb(gemMem) ~= 0x00 and rb(gemMem) ~= 0x02 and rb(gemMem) ~= 0x04 and rb(gemMem) ~= 0x06 and rb(gemMem) ~= 0x08 and rb(gemMem) ~= 0x0A then
				gemsPlayerOne()
		end
	end
end
