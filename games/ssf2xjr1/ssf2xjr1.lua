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

local p1health = 0xFF8478
local p1redhealth = 0xff847A
local p1disphealth = 0xff860A
local p2health = 0xFF8878
local p2redhealth = 0xFF887A
local p2disphealth = 0xFF8A0A

local p1meter = 0xFF8702
local p2meter = 0xFF8B02

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
	return rw(0xFF8454) >= rw(0xFF8854)
end

function playerTwoFacingLeft()
	return rw(0xFF8454) < rw(0xFF8854)
end

function playerOneInHitstun()
	ADD=21

	if rb(0xff8495) == 0 and p1stuned <= ADD then
		p1stuned=p1stuned-1
	elseif rb(0xff8495) == 0 and p1stuned == 1 then
		p1stuned = 0
	else
		p1stuned=rb(0xff8495)+ADD
	end

	return p1stuned > 0
end

function playerTwoInHitstun()
	ADD=21

	if rb(0xff8895) == 0 and p2stuned <= ADD then
		p2stuned=p2stuned-1
	elseif rb(0xff8895) == 0 and p2stuned == 1 then
		p2stuned = 0
	else
		p2stuned=rb(0xff8895)+ADD
	end

	return p2stuned > 0
end

function readPlayerOneHealth()
	return rw(p1redhealth)
end

function writePlayerOneHealth(health)
	p1action = rb(0xff8451)
	p2action = rb(0xff8851)
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
	p1action = rb(0xff8451)
	p2action = rb(0xff8851)
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
	if rw(0xFF8008) == 0xa then
		return rb(p1meter)
	else
		return p1maxmeter
	end
end

function writePlayerOneMeter(meter)
	if rw(0xFF8008) == 0xa then
		wb(p1meter, meter)
	end
end

function readPlayerTwoMeter()
	if rw(0xFF8008) == 0xa then
		return rb(p2meter)
	else
		return p2maxmeter
	end
end

function writePlayerTwoMeter(meter)
	if rw(0xFF8008) == 0xa then
		wb(p2meter, meter)
	end
end

local infiniteTime = function()
	timer = rb(0xff8dce)
	if (timer < 0x98) then
		ww(0xff8dce,0x9928)
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
