assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x78
p2maxhealth = 0x78

p1maxmeter = 0x80
p2maxmeter = 0x80

print "Known Issues: with garou"
print "Combo counter doesn't work"
print "Total just adds every hits damage whether it combos or not"
print "hitboxes don't currently work"
print ""

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
		p1healthx=22,
		p1healthy=16,
		p1healthenabled=true,
		p2healthx=288,
		p2healthy=16,
		p2healthenabled=true,
		p1meterx=77,
		p1metery=208,
		p1meterenabled=true,
		p2meterx=232,
		p2metery=208,
		p2meterenabled=true,
	},
}

function readPlayerOneHealth()
	return rb(0x10048E)
end

function writePlayerOneHealth(health)
	wb(0x10048E, health)
end

function readPlayerTwoHealth()
	return rb(0x10058E)
end

function writePlayerTwoHealth(health)
	wb(0x10058E, health)
end

function readPlayerOneMeter()
	return rb(0x1004BE)
end

function writePlayerOneMeter(meter)
	wb(0x1004BE, meter)
end

function readPlayerTwoMeter()
	return rb(0x1005BE)
end

function writePlayerTwoMeter(meter)
	wb(0x1005BE, meter)
end

function infiniteTime()
	memory.writebyte(0x107490,0x99)
end

function maxCredits()
	memory.writebyte(0x10E008, 0x09)
	memory.writebyte(0x10E009, 0x09)
end

function Run() -- runs every frame
	infiniteTime()
	maxCredits()
end
