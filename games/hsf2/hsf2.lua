assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
-- ssf2x training mode by @pof

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 0x30
p2maxmeter = 0x30

local p1_need_health_refill = false
local p2_need_health_refill = false

local p1health = 0xFF8366
local p1redhealth = 0xFF8368
local p1disphealth = 0xFF84F8
local p2health = 0xFF8766
local p2redhealth = 0xFF8768
local p2disphealth = 0xFF88F8

local p1meter = 0xFF85F0
local p2meter = 0xFF89F0

local p1action = 0
local p2action = 0

local p2inputs = 0
local p1inputs = 0

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
	local refill = false
	if readPlayerOneHealth() < 33 then
		-- if health < 33 we refill regardless of the state
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
		p1_need_health_refill=false
	end
end

function readPlayerTwoHealth()
	return rw(p2redhealth)
end

function writePlayerTwoHealth(health)
	local refill = false
	if readPlayerTwoHealth() < 33 then
		-- if health < 33 we refill regardless of the state
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
		p2_need_health_refill=false
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

	if p2_need_health_refill then
		writePlayerTwoHealth(p2maxhealth)
	end
	if p1_need_health_refill then
		writePlayerOneHealth(p1maxhealth)
	end

	-- try to refill after being thrown, hold or knocked down
	if rb(0xff8741) == 10 or rb(0xff88bd) == 255 then
		p2_need_health_refill=true
		writePlayerTwoHealth(p2maxhealth)
	end
	if rb(0xff8341) == 10 or rb(0xff84bd) == 255 then
		p1_need_health_refill=true
		writePlayerOneHealth(p1maxhealth)
	end

	-- try to refill when health < 33 to avoid round ending
	if readPlayerTwoHealth() < 33 then
		p2_need_health_refill=true
		writePlayerTwoHealth(p2maxhealth)
	end
	if readPlayerOneHealth() < 33 then
		p1_need_health_refill=true
		writePlayerOneHealth(p1maxhealth)
	end
end

stage_selector = -1
local stageSelect = function()
	if stage_selector == -1 then
		return
	end
	if (rb(0xff8004) == 0x04 or rb(0xff8004) == 0x0e) then
		wb(0xff8c4f,stage_selector)
	end
	wb(0x003fb7,0)
	ww(0xFF8B64,stage_selector) -- actual stage
	ww(0xFFBDF2,stage_selector) -- text 1
	ww(0xFFBEB2,stage_selector) -- text 2
	ww(0xFFD0B2,stage_selector) -- flag
	ww(0xFFD295,stage_selector) -- announcement
end

local player1Crouching = function()
	if p1action == 2 then
		return true
	end
	if p1action == 4 or p1action == 6 then
		return false
	end
	if (p1action == 10 or p1action == 12) then
		local ypos = rw(0xFF8346)
		if (ypos <= 40) then
			return bit.band(p1inputs, 0x4) == 0x4
		end
	end
	return false
end

local getDistanceBetweenPlayers = function()
	if playerOneFacingLeft() then
		distance = rw(0xFF8342) - rw(0xFF8742)
	else
		distance = rw(0xFF8742) - rw(0xFF8342)
	end
	return distance
end

autoblock_selector = -1
local forceblock = false
local prev_p1action = 0
local inputs_at_jumpstart = 0
local autoblock_skip_counter = 60
local canblock = false
local autoBlock = function()

	if autoblock_selector == -1 then
		return
	end

	local DEBUG=false

	-- neutral when opponent is neutral, crouching or landing
	if (p1action == 0 or p1action == 2 or p1action==6) then
		setDirection(2,5)
		forceblock = false
		if autoblock_selector == 2 and canblock == true then
			canblock = false
		end
		return
	end

	local distance = getDistanceBetweenPlayers()

	-- if opponent is ground attacking, ground block
	if (p1action == 10 or p1action == 12) and distance < 265 then

		-- block: auto
		if autoblock_selector == 2 and canblock == false then
			if p2action == 14 then
				setDirection(2,5)
				canblock = true
			end
			return
		end

		-- block: random
		if autoblock_selector == 3 then
			autoblock_skip_counter = autoblock_skip_counter -1
			if autoblock_skip_counter == 0 then
				autoblock_skip_counter = 60
			end
			if autoblock_skip_counter > 40 then
				return
			end
		end

		local p1crouching = player1Crouching()
		if playerOneFacingLeft() and p1crouching then
			setDirection(2,1)
		end
		if playerTwoFacingLeft() and p1crouching then
			setDirection(2,3)
		end
		if playerOneFacingLeft() and not p1crouching then
			setDirection(2,4)
		end
		if playerTwoFacingLeft() and not p1crouching then
			setDirection(2,6)
		end
		if DEBUG then print("ground block @ p1action=" .. p1action .. " | inputs=" .. p1inputs .. " | distance=" .. distance) end
		return
	end

	-- block jump attacks
	local p1attacking = false
	if autoblock_selector ~= 1 and autoblock_selector ~= 2 and p1action == 4 and distance < 265 then

		if autoblock_selector == 3 then
			autoblock_skip_counter = autoblock_skip_counter -1
			if autoblock_skip_counter == 0 then
				autoblock_skip_counter = 60
			end
			if autoblock_skip_counter > 30 then
				return
			end
		end

		local p1buttons = bit.band(p1inputs, 0x000F)
		if prev_p1action ~= 4 then
			inputs_at_jumpstart = p1inputs-p1buttons
			p1attacking = false
		end
		if p1inputs-p1buttons ~= inputs_at_jumpstart and p1inputs-p1buttons > 10 then
			-- buttons pressed changed during jump, Player one is attacking
			p1attacking = true
			forceblock = true
		end
		if (p2action ~= 6 and p2action ~= 8 and p2action ~= 14) then
			forceblock = false
		end

		if (p1attacking or forceblock) then
			if playerOneFacingLeft() then
				setDirection(2,4)
			else
				setDirection(2,6)
			end
			if DEBUG then print("block high @ p1action=" .. p1action .. " | p2action=" .. p2action .. " | inputs=" .. p1inputs .. "/" .. p1buttons .. " | distance=" .. distance .. " | p1attacking=" .. tostring(p1attacking) .. " | forceblock=" .. tostring(forceblock)) end
			return
		end
		setDirection(2,5)
		if DEBUG then print("neutral @ p1action=" .. p1action .. " | p2action=" .. p2action .. " | inputs=" .. p1inputs .. "/" .. p1buttons .. " | distance=" .. distance .. " | p1attacking=" .. tostring(p1attacking) .. " | forceblock=" .. tostring(forceblock)) end
		forceblock = false
		return
	end

	-- stop blocking
	if (distance >= 265 or p1action == 2) then
		setDirection(2,5)
		if DEBUG then print("neutral-4 @ p1action=" .. p1action .. " | inputs=" .. p1inputs .. " | distance=" .. distance) end
		forceblock = false
		return
	end
	if DEBUG then print("FINAL @ p1action=" .. p1action .. " | inputs=" .. p1inputs .. " | distance=" .. distance) end

end

dizzy_selector = -1
local p2DizzyControl = function()

	local dizzy = 0
	if dizzy_selector == -1 then
		return
	end

	if dizzy_selector == 1 then
		dizzy = 0x40
	end

	ww(0xFF8798, dizzy) -- timeout
	ww(0xFF879A, dizzy) -- damage

end

function Run() -- runs every frame

	-- attacker state (ff833f or +0x400 for p2): 0 idle, 2 crouching, 4 jumping, 10 doing a normal attack or throw, 12 on hitstun (doing an special attack)
	-- attacked state (ff833f or +0x400 for p2): 6 waking up meaty, 8 blocking, 14 hit (receiving an attack), 20 thrown
	p1action = rb(0xff833f)
	p2action = rb(0xff873f)

	-- These addresses all work, I think you can use whichever you want
	p1inputs = rw(0xFF8076)
	-- p1inputs = rw(0xFF864C)
	-- p1inputs = rw(0xFF864E)
	-- p2inputs = rw(0xFF8476)
	-- p2inputs = rw(0xFF8A4C)
	-- p2inputs = rw(0xFF8A4E)

	infiniteTime()
	autoBlock()
	neverEnd()
	stageSelect()
	p2DizzyControl()
	prev_p1action = p1action
end
