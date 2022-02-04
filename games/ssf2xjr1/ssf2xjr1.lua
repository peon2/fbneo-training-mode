assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
-- ssf2x training mode by @pof

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 0x30
p2maxmeter = 0x30

local p1_need_health_refill = false
local p2_need_health_refill = false

local p1health = 0xFF8478
local p1redhealth = 0xff847A
local p1disphealth = 0xff860A
local p2health = 0xFF8878
local p2redhealth = 0xFF887A
local p2disphealth = 0xFF8A0A

local p1meter = 0xFF8702
local p2meter = 0xFF8B02

local p1action = 0
local p2action = 0

local p2inputs = 0
local p1inputs = 0

local prev_p1action = 0
local prev_p2action = 0


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
	if rb(0xFF863E) > 0 then
		-- false when dizzy
		return false
	end
        if rb(0xFF8451) == 14 then
		return true
	end
	return false
end

function playerTwoInHitstun()
	if rb(0xFF8A3E) > 0 then
		-- false when dizzy
		return false
	end
        if rb(0xFF8851) == 14 then
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

	if p2_need_health_refill then
		writePlayerTwoHealth(p2maxhealth)
	end
	if p1_need_health_refill then
		writePlayerOneHealth(p1maxhealth)
	end

	-- try to refill after being thrown, hold or knocked down
	if rb(0xff8853) == 10 or rb(0xff89cf) == 255 then
		p2_need_health_refill=true
		writePlayerTwoHealth(p2maxhealth)
	end
	if rb(0xff8453) == 10 or rb(0xff85cf) == 255 then
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
	if rb(0xff8008) == 0x04 then
		wb(0xff8c4f,stage_selector)
	end
	wb(0xFF8C51,0)
	ww(0xFFE18A,stage_selector)
end

local player1Crouching = function()
	if p1action == 2 then
		return true
	end
	if p1action == 4 or p1action == 6 then
		return false
	end
	if (p1action == 10 or p1action == 12) then
		local ypos = rw(0xFF8458)
		if (ypos <= 40) then
			return bit.band(p1inputs, 0x4) == 0x4
		end
	end
	return false
end

local getDistanceBetweenPlayers = function()
	if playerOneFacingLeft() then
		distance = rw(0xFF8454) - rw(0xFF8854)
	else
		distance = rw(0xFF8854) - rw(0xFF8454)
	end
	return distance
end

local frameskip_currval = 0
local frameskip_prevval = 0
local was_frameskip = false

local function checkFrameskip()
	frameskip_address = 0xFF801D
	frameskip_prevval = frameskip_currval
	frameskip_currval = rb(frameskip_address)
	local x = frameskip_currval - frameskip_prevval
	if x % 2 == 0 then
		was_frameskip = true
	else
		was_frameskip = false
	end
end

local numframes = 0
local function setFrameskip(status)
	if status then
		local speed = rb(0xFF83A9)
		if speed == 0 then frameskip_value = 0x80
		elseif speed == 1 then frameskip_value = 0x70
		elseif speed == 2 then frameskip_value = 0x60
		elseif speed == 3 then frameskip_value = 0x50
		end
		--print ("FRAMESKIP ENABLED @ " .. numframes.. " - speed: ".. frameskip_value)
		wb(0xFF8CD3, frameskip_value) -- frameskip enabled
	else
		--print ("FRAMESKIP DISABLED @ " .. numframes)
		wb(0xFF8CD3, 0xff) -- frameskip disabled
	end
end

autoreversal_selector = -1
local frame_for_reversal = 0
local idle_frameanim = 122
local grounded = {}
local counter_for_wakeup_reversal = 38
local wakeup_reversal = 35
local iswakeup = false
local autoReversal = function()
	if autoreversal_selector == -1 then
		return
	end

	local DEBUG=true

	local framesrecorded = #recording[recording.recordingslot]
	if (framesrecorded < 1) then
		gui.text(220,50,"Use the Replay Editor in the ")
		gui.text(220,60,"Recording menu (hold coin) to")
		gui.text(220,70,"program the desired reversal action.")
		return
	end

	local frameanimation = rb(0xff896b)
	local groundval = rb(0xff89e1)
	if (p2action == 14 and prev_p2action ~= 14) or (p2action == 20 and prev_p2action ~= 20) then
		numframes = 1
	end
	if (p2action == 14 and prev_p2action == 14) or (p2action == 20 and prev_p2action == 20) then
		numframes = numframes + 1
		if was_frameskip then
			--print("FRAMESKIP MID! @ " .. numframes)
			numframes=numframes+1
		end

		if (numframes > 38) then
			grounded[0]=grounded[1]
			grounded[1]=grounded[2]
			grounded[2]=groundval
			if (grounded[0] == 0 and grounded[1] == 0 and grounded[2] ~=0) then
				counter_for_wakeup_reversal = 1
				iswakeup = true
			else
				local diff = grounded[1] - grounded[2]
				if (diff > 2 or diff < 0) then diff = 1 end
				counter_for_wakeup_reversal = counter_for_wakeup_reversal + diff
			end
		else
			grounded[0]=0
			grounded[1]=0
			grounded[2]=0
		end
	end
	-- local reversal_flag = rb(0xFF89B7)
	-- local lastspecial = rb(0xFF89B8)
	--if (p2action ~= 0) then print("p2action=" .. p2action .. " | numframes=" .. numframes .. " | groundval=".. groundval .." | cfw="..counter_for_wakeup_reversal .. " | sp="..lastspecial .. " | rv="..reversal_flag ) end
	if (p2action ~= 14 and prev_p2action == 14) or (p2action ~= 20 and prev_p2action == 20) then
		-- learn the value of frameanimation after last hit frame
		idle_frameanim = frameanimation
		setFrameskip(true)
		if (numframes - frame_for_reversal == framesrecorded) then
			if (p2action ~= 12) then
				if (DEBUG) then print("=> FAILED FRAME-PERFECT REVERSAL PERFORMED AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
			else
				if (DEBUG) then print("=> SUCCESSFUL REVERSAL PERFORMED AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
			end
		elseif (numframes - frame_for_reversal < framesrecorded) then
			if (p2action ~= 12) then
				if (DEBUG) then print("=> MISSED REVERSAL PERFORMED TOO LATE AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
				if iswakeup then counter_for_wakeup_reversal = counter_for_wakeup_reversal + 1 end
			else
				if (DEBUG) then print("=> SUCCESSFUL LATE REVERSAL PERFORMED AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
			end
		elseif (numframes - frame_for_reversal > framesrecorded) then
			if (p2action ~= 12) then
				if (DEBUG) then print("=> MISSED REVERSAL PERFORMED TOO EARLY AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
			else
				if (DEBUG) then print("=> SUCCESSFUL EARLY REVERSAL PERFORMED AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
				if iswakeup and framesrecorded < 4 then counter_for_wakeup_reversal = counter_for_wakeup_reversal - 1 end
			end

		end
		wakeup_reversal = counter_for_wakeup_reversal - framesrecorded
		if (DEBUG) then
			print("=> FRAME FOR NEXT REVERSAL: [count:" .. frame_for_reversal .. " / "..numframes.."] [wakeup: "..wakeup_reversal.." / " ..counter_for_wakeup_reversal.."]")
			print(" ")
		end
	end

	if (p2action == 14 or p2action == 20) then
		local safeguard=2
		if (frameanimation == 105 - framesrecorded - safeguard) or (frameanimation == 105 - framesrecorded - safeguard + 1) or (frameanimation == 122 - framesrecorded - safeguard) or (frameanimation == 122 - framesrecorded - safeguard + 1) or (frameanimation == 144 - framesrecorded - safeguard) or (frameanimation == 144 - framesrecorded - safeguard + 1) then
			if (groundval ~= 0) then
				iswakeup = false
				setFrameskip(false)
			else
				iswakeup = true
			end
		end
		if iswakeup then safeguard = framesrecorded+1 end
		if (counter_for_wakeup_reversal == wakeup_reversal - safeguard) or (counter_for_wakeup_reversal == wakeup_reversal - safeguard + 1) then
			iswakeup = true
			setFrameskip(false)
		end
	end

	if (( p2action == 14 or p2action == 20 ) and not iswakeup and ( ( frameanimation == idle_frameanim - framesrecorded) or (frameanimation == idle_frameanim - framesrecorded + 1) or (frameanimation == 105 - framesrecorded) or (frameanimation == 122 - framesrecorded) or (frameanimation == 144 - framesrecorded) ) ) then
		if not recording.playback then
			togglePlayBack(nil, {})
			frame_for_reversal = numframes
			if (DEBUG) then print("GROUND REVERSAL! numframes=[" .. numframes .. "]") end
		end
	end
	if (( p2action == 14 or p2action == 20 ) and iswakeup and (counter_for_wakeup_reversal == wakeup_reversal) ) then
		if not recording.playback then
			togglePlayBack(nil, {})
			frame_for_reversal = numframes
			if (DEBUG) then print("WAKEUP REVERSAL! numframes=[" .. numframes .. "]") end
		end
	end
end

autoblock_selector = -1
local forceblock = false
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

	ww(0xFF88AA, dizzy) -- timeout
	ww(0xFF88AC, dizzy) -- damage

end

function Run() -- runs every frame

	-- attacker state (ff8451 or +0x400 for p2): 0 idle, 2 crouching, 4 jumping, 10 doing a normal attack or throw, 12 on hitstun (doing an special attack)
	-- attacked state (ff8451 or +0x400 for p2): 6 waking up meaty, 8 blocking, 14 hit (receiving an attack), 20 thrown
	p1action = rb(0xff8451)
	p2action = rb(0xff8851)

	-- p2inputs = rw(0xFF8BE0)
	p1inputs = rw(0xFF87E0)

	checkFrameskip()
	autoBlock()
	autoReversal()
	neverEnd()
	stageSelect()
	p2DizzyControl()
	infiniteTime()
	prev_p1action = p1action
	prev_p2action = p2action
end
