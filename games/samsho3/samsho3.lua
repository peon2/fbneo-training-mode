assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x80
p2maxhealth = 0x80

p1maxmeter = 0x40
p2maxmeter = 0x40

print "Known Issues: with samsho3"
print "Inconsistent combo counter"
print ""

translationtable = {
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

gamedefaultconfig = {
	hud = {
		combotextx=134,
		combotexty=56,
		comboenabled=true,
		p1healthx=9,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=284,
		p2healthy=21,
		p2healthenabled=true,
		p1meterx=113,
		p1metery=208,
		p1meterenabled=true,
		p2meterx=188,
		p2metery=208,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	-- eq 0 or 2 0x1085db
	return rb(0x1085db)==2
end

function playerTwoFacingLeft()
	return rb(0x1085db)==0
end

function playerOneInHitstun()
	return rb(0x1085c4)~=0
end

function playerTwoInHitstun()
	return rb(0x10f295)~=0 or rb(0x1086c4)~=0 -- why would ss3 make me do this? 
end

function readPlayerOneHealth()
	return rb(0x108573)
end

function writePlayerOneHealth(health)
	wb(0x108573, health)
end

function readPlayerTwoHealth()
	return rb(0x108673)
end

function writePlayerTwoHealth(health)
	wb(0x108673, health)
end

function readPlayerOneMeter()
	return rb(0x10857c)
end

function writePlayerOneMeter(meter)
	wb(0x10857c, meter)
end

function readPlayerTwoMeter()
	return rb(0x10867c)
end

function writePlayerTwoMeter(meter)
	wb(0x10867c, meter)
end

local infiniteTime = function()
	wb(0x10849e, 0x99)
end

function Run() -- runs every frame
	-- 108561
	--print(rb(0x1086dc))
	infiniteTime()
end