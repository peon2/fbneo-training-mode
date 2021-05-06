assert(rb,"Run fbneo-training-mode.lua")

--p1maxhealth = 0x7D
p2maxhealth = 0x7D

p1maxmeter = 0x40
p2maxmeter = 0x40

print "Known Issues: with samsh5sp"
print "gui does not show up"
print "no hitboxes currently"
print "only way to toggle p1 health is to edit code"
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
	memory.writebyte(0x10836B, 0x3C)
end

function longSwordGague() -- Longest sword gauge/rage explode length
    memory.writebyte(0x108554, 0x82)
    memory.writebyte(0x108764, 0x82)
end

function maxSwordGuageCharge() -- Can confirm this is max sword guage
    memory.writebyte(0x1085F8, 0x78)
    memory.writebyte(0x108808, 0x78)
end

function maxTimeSlow() -- Full Time Slow
    memory.writebyte(0x1085FE, 0x7C)
    memory.writebyte(0x10880E, 0x7C)
end

-- function maxRage() -- Full Rage
--     memory.writebyte(0x10844E, 0x40)
--     memory.writebyte(0x10865E, 0x40)
-- end

function Run() -- runs every frame
	infiniteTime()
    longSwordGague()
    maxSwordGuageCharge()
    maxTimeSlow()
    -- maxRage()
end