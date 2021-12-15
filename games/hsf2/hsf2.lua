assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 0x30
p2maxmeter = 0x30

p1stuned=0
p2stuned=0

print "Known issues: "
print "Hitstun isn't accurate"
print ""

local p1health = 0xFF8366
local p1redhealth = 0xFF8368
local p1disphealth = 0xFF84F8
local p2health = 0xFF8766
local p2redhealth = 0xFF8768
local p2disphealth = 0xFF88F8

local p1meter = 0xFF85F0
local p2meter = 0xFF89F0

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
		combotextx=178,
		combotexty=49,
		comboenabled=true,
		p1healthx=34,
		p1healthy=23,
		p1healthenabled=true,
		p2healthx=339,
		p2healthy=23,
		p2healthenabled=true,
		p1meterx=82,
		p1metery=207,
		p1meterenabled=true,
		p2meterx=294,
		p2metery=207,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rw(0xFF8342) >= rw(0xFF8742)
end

function playerTwoFacingLeft()
	return rw(0xFF8342) < rw(0xFF8742)
end

function playerOneInHitstun()
	if rb(0xFF852C) > 0 then
		-- false when dizzy
		return false
	end
        if rb(0xFF833F) == 14 then
		return true
	end
	return false
end

function playerTwoInHitstun()
	if rb(0xFF892C) > 0 then
		-- false when dizzy
		return false
	end
        if rb(0xFF873F) == 14 then
		return true
	end
	return false
end

function readPlayerOneHealth()
	return rw(p1redhealth)
end

function writePlayerOneHealth(health)
	p1action = rb(0xFF833F)
	p2action = rb(0xFF873F)
	refill = false
	if readPlayerOneHealth() < 10 then
		-- if health < 10 we refill regardless of the state
		refill = true
	elseif ((p1action ~= 0x14 and p1action ~=0xe and p1action ~= 8) and (p2action==2 or p2action==0)) then
		-- this only refills when p2 is idle or crouching and p1 is not blocking or after being hit/thrown
		refill = true
	elseif (p1action ~= 8) and readPlayerOneHealth() < 50 then
		-- when health is depleting try to refill even if it will cause some small glitches
		refill = true
	end
	if refill then
		ww(p1health, health)
		ww(p1redhealth, health)
		ww(p1disphealth, health)
	end
end

function readPlayerTwoHealth()
	return rw(p2redhealth)
end

function writePlayerTwoHealth(health)
	p1action = rb(0xFF833F)
	p2action = rb(0xFF873F)
	refill = false
	if readPlayerTwoHealth() < 10 then
		-- if health < 10 we refill regardless of the state
		refill = true
	elseif ((p2action ~= 0x14 and p2action ~=0xe and p2action ~= 8) and (p1action==2 or p1action==0)) then
		-- this only refills when p1 is idle or crouching and p2 is not blocking or after being hit/thrown
		refill = true
	elseif (p2action ~= 8) and readPlayerTwoHealth() < 50 then
		-- when health is depleting try to refill even if it will cause some small glitches
		refill = true
	end
	if refill then
		ww(p2health, health)
		ww(p2redhealth, health)
		ww(p2disphealth, health)
	end
end

function readPlayerOneMeter()
	if rw(0xFF8008) == 0x2 then
		return rb(p1meter)
	else
		return p1maxmeter
	end
end

function writePlayerOneMeter(meter)
	if rw(0xFF8008) == 0x2 then
		wb(p1meter, meter)
	end
end

function readPlayerTwoMeter()
	if rw(0xFF8008) == 0x2 then
		return rb(p2meter)
	else
		return p2maxmeter
	end
end

function writePlayerTwoMeter(meter)
	if rw(0xFF8008) == 0x2 then
		wb(p2meter, meter)
	end
end

local infiniteTime = function()
	timer = rb(0xff8bfc)
	if (timer < 0x98) then
		ww(0xff8bfc,0x9928)
	end
end

local neverEnd = function()

	-- try to refill when health < 10 to avoid round ending
	p2h = readPlayerTwoHealth()
	if p2h < 10 then
		writePlayerTwoHealth(p2maxhealth)
	end
	p1h = readPlayerOneHealth()
	if p1h < 10 then
		writePlayerOneHealth(p1maxhealth)
	end
end

function Run() -- runs every frame
	infiniteTime()
	neverEnd()
end
