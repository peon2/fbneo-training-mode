assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x7D
p2maxhealth = 0x7D

p1maxmeter = 0x40
p2maxmeter = 0x40

function gamemsg()
	print "Known issues with samsh5sp:"
	print "gui does not show up"
	print "no hitboxes currently"
	print "only way to toggle p1 health is to edit code"
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
		p1healthx=9,
		p1healthy=24,
		p1healthenabled=true,
		p2healthx=284,
		p2healthy=24,
		p2healthenabled=true,
		p1meterx=98,
		p1metery=210,
		p1meterenabled=true,
		p2meterx=199,
		p2metery=210,
		p2meterenabled=true,
	},
}

function readPlayerOneHealth()
	return rb(0x108445)
end

function writePlayerOneHealth(health)
	wb(0x108445, health)
end

function readPlayerTwoHealth()
	return rb(0x108655)
end

function writePlayerTwoHealth(health)
	wb(0x108655, health)
end

function readPlayerOneMeter()
	return rb(0x10844E)
end

function writePlayerOneMeter(meter)
	wb(0x10844E, meter)
end

function readPlayerTwoMeter()
	return rb(0x10865E)
end

function writePlayerTwoMeter(meter)
	wb(0x10865E, meter)
end

function infiniteTime()
	wb(0x10836B, 0x3C)
end

function longSwordGague() -- Longest sword gauge/rage explode length
    wb(0x108554, 0x82)
    wb(0x108764, 0x82)
end

function maxSwordGuageCharge() -- Can confirm this is max sword guage
    wb(0x1085F8, 0x78)
    wb(0x108808, 0x78)
end

function maxTimeSlow() -- Full Time Slow
    wb(0x1085FE, 0x7C)
    wb(0x10880E, 0x7C)
end

-- function maxRage() -- Full Rage
--     wb(0x10844E, 0x40)
--     wb(0x10865E, 0x40)
-- end

function Run() -- runs every frame
	infiniteTime()
    longSwordGague()
    maxSwordGuageCharge()
    maxTimeSlow()
    -- maxRage()
end