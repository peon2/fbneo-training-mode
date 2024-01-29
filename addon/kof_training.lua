assert(rb,"Run fbneo-training-mode.lua")


local p1hitstatus = 0x108172
local p2hitstatus = 0x108372

local in_air = 0x108322

local currentState = "start"

--[[ local trigger_recovery = true ]]
local function isInAir()
	 return rb(in_air)~=0
end




customconfig = {
	dummy_guard = 0,
	dummy_random_guard = 0,
	dummy_reversal = 0,
	dummy_recovery = 0,
	dummy_reversal_random = 0,
	}

dummy_guard = customconfig.dummy_guard
dummy_random_guard = customconfig.dummy_random_guard
dummy_recovery = customconfig.dummy_recovery
dummy_reversal = customconfig.dummy_reversal
dummy_reversal_random = customconfig.dummy_reversal_random

--local reversal_move =0x62 -- 0x63 --standing punch
--local p2move_adress = 0x108373
local p2blockstun_address = 0x1083E3
local p2blockstun_value = 0xA0
local trigger_reversal = true
local can_block = true

-------------------------------------------------
--- POSIBBLE MEMORIE ADRESSES ----
-------------------------------------------------
--108477 dizzy timer- it stops counting when the oponent is dizzy
--1084b0 combo counter
--1084bb dummy has been grabbed
--1081a6 Player1 is in air = c0, d8 = standing, e0 = crouching
--108318 - 108319 Dummy stage position from 0020 (left corner) to 02e0  (right corner)
--if rb(0x10837E) == 1  then player 2 is in proximity block



	function playerOneIsBeingHit()
		return rb(p1hitstatus)~=0
	end
	
	function playerTwoIsBeingHit()
		return rb(p2hitstatus)~=0
	end
	
local function playerTwoInBlockstun()
	if (rb(p2blockstun_address) == 0x20) or (rb(p2blockstun_address) == 0xA0) then
		return true
	end
	return false
end

local function getFacingDirection()
	if playerTwoFacingLeft() then
		return "P2 Left"
	end
	return "P2 Right"
end
local function getBlockingDirection()
	if playerTwoFacingLeft() then
		return "P2 Right"
	end
	return "P2 Left"
end


local function transitionToState(newState)
    -- Logic for transitioning to a new state
    currentState = newState
    print("Transitioned to state:", newState)
    -- Additional logic for state transition...
end
local iddle_time_running = false
local iddle_finish_time = 0
local iddle_time = 60
local function recoveryEnabled()
	if iddle_time_running then
		print("current iddle Time is: "..(iddle_finish_time - emu.framecount()))
		if iddle_finish_time == emu.framecount()  then
			iddle_finish_time = 0
			iddle_time_running = false
			return true
		end
		return false
	end	
	return true
end
local function startRecoveryIddleTime()
	iddle_time_running = true
	iddle_finish_time = emu.framecount() + iddle_time
end


local current_move_index_counter = 1
local current_move_time_counter = 1
local function doMove(move, times)
	local seq = move.sequence
	times = times or  move.times
	--[[ can_block = false ]]
	local tbl = {}--[[ 
	print("current_move_time_counter: "..current_move_time_counter) ]]
	if current_move_time_counter > times then
	--[[ print("last time") ]]
		
	
		current_move_time_counter =1
		--[[ can_block = true ]]	
		return false
	end
--[[ 	print(joypad.get()["P1 Button B"]) ]]
	if current_move_index_counter > #seq  then
		current_move_index_counter = 1		
		current_move_time_counter = current_move_time_counter +1
	end
	for index, value in ipairs(seq[current_move_index_counter]) do
		if value == 'forward' then
			tbl[getFacingDirection()] = 1
		elseif value == 'back' then
			tbl[getBlockingDirection()] = 1
		elseif value == 'down' then
			tbl["P2 Down"] = 1
		elseif value == 'up' then
			tbl["P2 Up"] = 1
		elseif value == 'a' then
			tbl["P2 Button A"] = 1
		elseif value == 'b' then
			tbl["P2 Button B"] = 1
		elseif value == 'c' then
			tbl["P2 Button C"] = 1
		elseif value == 'd' then
			tbl["P2 Button D"] = 1
		end
	end
	current_move_index_counter = current_move_index_counter +1
	joypad.set(tbl)
	return true
end
local CURRENT_REVERSAL_MOVE = {}
local function getCurrentReversalMove()
	local next = next
	if next(CURRENT_REVERSAL_MOVE) == nil then		
		if dummy_reversal_random == 1 then
			CURRENT_REVERSAL_MOVE =moves[dummy_reversal_moves[math.random(1,  #dummy_reversal_moves)]]
		else
			CURRENT_REVERSAL_MOVE = moves[dummy_reversal_moves[1]]
		end
	end
	return CURRENT_REVERSAL_MOVE
end



local function doReversal()
	if doMove(getCurrentReversalMove()) == false then
		--[[ trigger_reversal = false
		trigger_recovery = false ]]
		CURRENT_REVERSAL_MOVE = {}
		if dummy_guard == 1 then
        	transitionToState("blocking")  -- Transition to the "blocking" state
		else
			transitionToState("start")
			startRecoveryIddleTime()
		end
	end
end
local function doRecovery()
	if doMove(moves['AB'],1)== false then
		startRecoveryIddleTime()
		--[[ trigger_recovery = false ]]
		if dummy_reversal == 1 then
			transitionToState("reversal")
		elseif dummy_guard == 1 then
			transitionToState("blocking")
		else
			transitionToState("start")
		end
	end
end
 function p2Block()
	local tbl = {}	
	tbl[getBlockingDirection()] = 1
	tbl["P2 Down"] = 1
	joypad.set(tbl)
end
function p2Crouch()
	local tbl = {}
	tbl["P2 Down"] = 1
	joypad.set(tbl)
end
-- Initial state
local previousButtonState = {}

local function playerOnePressedButtons()
    local tbl = joypad.get()
    local buttonsPressed = false

    if (tbl["P1 Button A"] and not previousButtonState["P1 Button A"]) or
       (tbl["P1 Button B"] and not previousButtonState["P1 Button B"]) or
       (tbl["P1 Button C"] and not previousButtonState["P1 Button C"]) or
       (tbl["P1 Button D"] and not previousButtonState["P1 Button D"]) then
        buttonsPressed = true
    end

    -- Update the previous button state for the next frame
    previousButtonState["P1 Button A"] = tbl["P1 Button A"]
    previousButtonState["P1 Button B"] = tbl["P1 Button B"]
    previousButtonState["P1 Button C"] = tbl["P1 Button C"]
    previousButtonState["P1 Button D"] = tbl["P1 Button D"]

    return buttonsPressed
end

local function dummyGuardForATime()
	return doMove(KOF_CONFIG.MOVES['GUARD_BACK'],10)
end

local cooldowns = {}  -- Table to store cooldowns for different functions
local functionRunningFlags = {}  -- flag to track whether a function is currently running


function executeWithCooldown(func, cooldownDuration, funcName)
    if not cooldowns[funcName] or cooldowns[funcName] == 0 then
        if not func() then
            -- The function returned false, indicating it has finished executing
            cooldowns[funcName] = cooldownDuration  -- Set the cooldown
       
		else
			functionRunningFlags[funcName] = true -- Set the running flag
		end       
    end	
    if cooldowns[funcName] and cooldowns[funcName] > 0 then
        cooldowns[funcName] = cooldowns[funcName] - 1
		if(cooldowns[funcName]) == 0 then
			functionRunningFlags[funcName] = false-- Set the running flag
		end
	end
end

function printTable(tbl)
    print("Table content:")
    for funcName, flag in pairs(functionRunningFlags) do
    print(funcName, flag)
	end
end

local function doNothing()
	print('Doing nothing')
end

local start_press = false
function block()
    -- Additional logic for blocking...
	if KOF_CONFIG.GUARD.standing_guard == 1 then
		if(start_press == false) then
			if playerOnePressedButtons()  then
				start_press = true
			end
		end
		if(start_press or  functionRunningFlags["dummyGuardForATime"] == true or functionRunningFlags['doNothing'] == true ) then			
			if start_press and KOF_CONFIG.GUARD.random_guard == 1 then
				local percentage_of_down = 50
				local randomNumber = math.random(1, 100)
				if(randomNumber <= percentage_of_down )then
					executeWithCooldown( doNothing, 20, "doNothing")
				else
					executeWithCooldown( dummyGuardForATime, 20, "dummyGuardForATime")
				end
				start_press = false
				return
			else
				executeWithCooldown( dummyGuardForATime, 20, "dummyGuardForATime")
				start_press = false
				return
			end

			if(functionRunningFlags["dummyGuardForATime"] ) then				
				executeWithCooldown( dummyGuardForATime, 20, "dummyGuardForATime")
			end
		
			if(functionRunningFlags["doNothing"] ) then				
				executeWithCooldown( doNothing, 20, "doNothing")
			end
		end
	end
	if KOF_CONFIG.GUARD.crouch_guard == 1 then
		if KOF_CONFIG.GUARD.random_guard == 1 then
			local percentage_of_down = 50
			local randomNumber = math.random(1, 100)
			if(randomNumber <= percentage_of_down )then
				p2Crouch()
			else
				p2Block() 
			end
		else
			p2Block()		
		end
	end
	--[[ if dummy_random_guard == 1 then
		-- Logic for blocking behavior
		print("Random Blocking!")
		
	else
		-- Logic for blocking behavior
		print("Blocking!")
		
		p2Block()
	end ]]
end

require('games.kof98.tests_kof98')
testsRun = true
function Run() -- runs every frame
	--run tests once
	runTests()
	gui.text(197, 73,  rb(in_air), "cyan", "black")
	if rb(0x108321)~=0  then
		
		print(rb(0x108321).."-"..rb(0x108322).."-"..rb(0x108323))
	end
	 -- Check the current state and execute corresponding behavior
	 if currentState == "start" then
        -- Logic for the "start" state
        -- Additional logic specific to the "start" state...
		if (dummy_guard == 1 ) or KOF_CONFIG.GUARD.dummy_guarding == 1 then
        	transitionToState("blocking")  -- Transition to the "blocking" state
		elseif dummy_recovery == 1 then
			if (recoveryEnabled()) then
				if isInAir() then
					transitionToState("recovery")
				end
			end
		end
	elseif currentState == "blocking" then
		if  playerTwoInBlockstun() and dummy_reversal == 1 then
			transitionToState("reversal")
		end
		block()
	elseif currentState == "recovery" then
		doRecovery()
	elseif currentState == "reversal" then
		doReversal()
	 end
	infiniteTime()
end
