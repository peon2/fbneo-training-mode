assert(rb,"Run fbneo-training-mode.lua")
DBIndex = require("addon.kof_training.db_lua.db.index")

local p1hitstatus = 0x108172
local p2hitstatus = 0x108372

local in_air = 0x108322

local p1_stored_index_location = 0x10A84E
local p2_stored_index_location = 0x10A85F

local stateMachine = {
    currentState = "start",
    lastState = nil,
}
--[[ local trigger_recovery = true ]]
local function isInAir()
	 return rb(in_air)~=0
end




--[[ customconfig = {
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
dummy_reversal_random = customconfig.dummy_reversal_random ]]

--local reversal_move =0x62 -- 0x63 --standing punch
local p2move_adress = 0x108373
local p2blockstun_address = 0x1083E3
local p2blockstun_value = 0xA0

-------------------------------------------------
--- POSIBBLE MEMORIE ADRESSES ----
-------------------------------------------------
--108477 dizzy timer- it stops counting when the oponent is dizzy
--1084b0 combo counter
--1084bb dummy has been grabbed
--1081a6 Player1 is in air = c0, d8 = standing, e0 = crouching
--108318 - 108319 Dummy stage position from 0020 (left corner) to 02e0  (right corner)
--if rb(0x10837E) == 1  then player 2 is in proximity block
-- 10837c == 00 think is oponent recovering ko


local	function playerOneIsBeingHit()
		return rb(p1hitstatus)~=0
	end
	
local 	function playerTwoIsBeingHit()
	
		return rb(p2hitstatus)~=0
	end
local function dummyMoveIsActive()
	return  rb(p2move_adress) ~=0
end
local last_frame = emu.framecount()

function saveStateLoaded()
    local f = emu.framecount()
    if f < last_frame then
        last_frame = f
        return true
    end
    last_frame = f
    return false
end


local base_action_adress = p1hitstatus +  1

local function P2ActionIsExecuting()
	local action_filtered = {
		[0] = true,
		[1] = true,
		[2] = true,
		[3] = true,
		[4] = true,	
		[5] = true, 
		[6] = true,
		[7] = true,
		[8] = true,	
		[9] = true,
		[10] = true,
		[11] = true, 
		[12] = true,
		[13] = true,
		[14] = true,	
		[15] = true,
		[16] = true,
		[17] = true,
		[18] = true,	
		[19] = true,
		[20] = true,
		[21] = true,
		[22] = true,	
		[23] = true,
		[45] = true,
		[46] = true,
		[47] = true,
		[48] = true,
		[49] = true,
		[50] = true,
		[51] = true,
		[52] = true,
		[53] = true,
		[54] = true,
		[55] = true,
		[56] = true,
		[157] = true,
		[158] = true,
		[159] = true,
		[232] = true,
		[233] = true
	}

	if not action_filtered[rb(base_action_adress)] then
		return true	
	end
	return false
end

local function P2CurrentAction()
	return rb(p2move_adress)
end
local function P2SetAction(action)
	wb(p2move_adress,action)
end
local current_p1_base_action = 0
local past_p1_base_action = 0

local action_frames = 0
local last_updated_frame_of_action = -1
local running_action = false
local p1_entered_new_action = false
local last_action_duration = 0
local function P1ActCodeRunning()
	current_p1_base_action = rb(base_action_adress)
	if current_p1_base_action == 0x23 then
		return false
	end
	
	if (current_p1_base_action == past_p1_base_action) and P2ActionIsExecuting() then
		local current_frame = emu.framecount()
		if current_frame ~= last_updated_frame_of_action then
			last_updated_frame_of_action = current_frame
			action_frames = action_frames + 1
			running_action = true
			p1_entered_new_action = true
		end
		return running_action
	end
	if p1_entered_new_action then
		last_action_duration = action_frames
		p1_entered_new_action = false
	end
	past_p1_base_action = current_p1_base_action
	action_frames = 0

	return false
end
local function p1CurrentAction()
	if P1ActCodeRunning() then
		return current_p1_base_action
	end
	return 0
	
end
local function getLastActionDuration()
	return last_action_duration
end
local player_two_entered_blockstun = false
local last_updated_frame = -1
local blockstun_frames = 0
local last_blockstun_duration = 0
local function playerTwoInBlockstun()
	if (rb(p2blockstun_address) == 0x20) or (rb(p2blockstun_address) == 0xA0) then
		local current_frame = emu.framecount()
		if current_frame ~= last_updated_frame then
			blockstun_frames = blockstun_frames + 1
			last_updated_frame = current_frame
		end
		player_two_entered_blockstun = true
		return true
	end
	if player_two_entered_blockstun then
		last_blockstun_duration = blockstun_frames
		player_two_entered_blockstun = false
	end
	blockstun_frames = 0
	return false
end
local p2blockstun_value = 0
local p2_blockstun_last_updated_frame = -1
local function p2CurrentBlockstun()
	if (rb(p2blockstun_address) == 0x20) or (rb(p2blockstun_address) == 0xA0) then
		local current_frame = emu.framecount()
		if current_frame ~= p2_blockstun_last_updated_frame then
			p2blockstun_value = p2blockstun_value + 1
			p2_blockstun_last_updated_frame = current_frame
		end
		return p2blockstun_value
	end
	return 0
end

local function playerTwoIsInFirstFrameOfBlockstun()
	if playerTwoInBlockstun() and blockstun_frames == 1 then
		return true
	end
	return false
end
local function getBlockstunFrames()
	return blockstun_frames
end
-- Getter for duration of last blockstun when player two leaves it
local function getLastBlockstunDuration()
	return last_blockstun_duration
end
local last_byte_of_ACT_code_address = 0x108373
local function ACTcodesOfFallingActive()
	--[[ if rb(last_byte_of_ACT_code_address) >= 28 and rb(last_byte_of_ACT_code_address) <= 33 then 
	 return true
	end ]]
	if rb(last_byte_of_ACT_code_address) == 31 then
		return true
	elseif rb(last_byte_of_ACT_code_address) == 32 then
		return true
	elseif rb(last_byte_of_ACT_code_address) == 33 then
		return true
	elseif rb(last_byte_of_ACT_code_address) == 35 then
		return true
	elseif rb(last_byte_of_ACT_code_address) == 37 then
		return true
	elseif rb(last_byte_of_ACT_code_address) == 42 then
		return true
	elseif rb(last_byte_of_ACT_code_address) == 51 then
		return true
	elseif rb(last_byte_of_ACT_code_address) == 128 then
		return true
	end
	return false
end
local function playerTwoIsFalling()
	--[[if rb(p2hitstatus) == 11 then
		print ("playerTwoIsFalling")
	end--]]
	if rb(p2hitstatus) == 1 or rb(p2hitstatus) == 11 then
		if ACTcodesOfFallingActive() then
			return true
		end
	end
	return false
end
--[[*** General Functions ***]]

function getPlayerName(player_id)
	if player_id == KOF_CONFIG.PLAYERS.PLAYER1.ID then
		local p1_rom_index = rb(p1_stored_index_location) + 1 -- +1 because the table CHARACTERS starts at 1
		return KOF_CONFIG.CHARACTERS[p1_rom_index].name
	elseif player_id == KOF_CONFIG.PLAYERS.PLAYER2.ID then
		local p2_rom_index = rb(p2_stored_index_location) + 1 -- +1 because the table CHARACTERS starts at 1
		return KOF_CONFIG.CHARACTERS[p2_rom_index].name
	end
end

function getPlayerStoredId(player_id)
	if player_id == KOF_CONFIG.PLAYERS.PLAYER1.ID then
		local p1_stored_id = rb(p1_stored_index_location)
		return p1_stored_id
	elseif player_id == KOF_CONFIG.PLAYERS.PLAYER2.ID then
		local p2_stored_id = rb(p2_stored_index_location)
		return p2_stored_id
	end
end
function dumpTable(t, indent)
    indent = indent or ""
    print(indent .. "{")

    for k, v in pairs(t) do
        local key = type(k) == "string" and k or "[" .. k .. "]"

        if type(v) == "table" then
            print(indent .. "  " .. key .. " = ")
            dumpTable(v, indent .. "  ")
        else
            print(indent .. "  " .. key .. " = " .. tostring(v))
        end
    end

    print(indent .. "}")
end

function getCurrentSetupName()
	local p1_rom_index = rb(p1_stored_index_location) + 1 -- +1 because the table CHARACTERS starts at 1
	local p2_rom_index = rb(p2_stored_index_location) + 1 -- +1 because the table CHARACTERS starts at 1
	local p1_short_name = KOF_CONFIG.CHARACTERS[p1_rom_index].short_name
	local p2_short_name = KOF_CONFIG.CHARACTERS[p2_rom_index].short_name
	local base_name = p1_short_name.."_"..p2_short_name
	return base_name
end


function loadSetupFromFile(recording_slot_number,setup_name)
	local pathname = "addon/kof_training/db_lua/db/"..emu.romname().."/"..setup_name..".lua"
	print("Loading replay from: "..pathname)
	local loaded_table, err = table.load(pathname)
	if fexists(pathname) and loaded_table then
		recording[recording_slot_number] = loaded_table
		print("Replay loaded successfully.")
	else
		print("Error loading replay:", err)
	end
	
end
function isRecordingEmpty()
	local t = recording
    for i = 1, 5 do
        if t[i] and next(t[i]) ~= nil then
            return false
        end
    end
    return true
end

function buildSetup()
    local setup = {}

    setup.base_name = getCurrentSetupName()

    setup.recordings = {}
    for i = 1, 5 do
        setup.recordings[i] = recording[i]
    end

    setup.p1 = {
        name = getPlayerName(1),
        stored_id = getPlayerStoredId(1)
    }

    setup.p2 = {
        name = getPlayerName(2),
        stored_id = getPlayerStoredId(2)
    }

    setup.recording_var_states = {}

    return setup
end
-- Function to reset all named keys to 0 in a subtable
local function resetReversals(tableRoot, subtableKey)
    local subtable = tableRoot[subtableKey]
    if not subtable then return end  -- do nothing if the key doesn't exist

    for k, v in pairs(subtable) do
        -- Only affect named keys, ignore numeric indexes
        if type(k) == "string" and v ~= 0 then
            subtable[k] = 0
        end
    end
end

function applySetup(setup)
    local rom = emu.romname()
    local base = setup.base_name

    local savestatePath =
        "addon/kof_training/db_lua/db/" .. rom .. "/savestates/" .. base .. ".fs"

    -- 1. Load savestate
    if fexists(savestatePath) then
        savestate.load(savestatePath)
    else
        print("Savestate not found:", savestatePath)
    end

    -- 2. Load recordings into active slots
    for i = 1, 5 do
        recording[i] = setup.recordings[i]
    end
	-- load wakeup and recovery configs
	if setup.WAKEUP_CONFIG ~= nil then
		KOF_CONFIG.WAKEUP = setup.WAKEUP_CONFIG
	end
    if setup.GUARD_CONFIG ~= nil then
		KOF_CONFIG.GUARD = setup.GUARD_CONFIG
	end
	if setup.RECOVERY_CONFIG ~= nil then
		KOF_CONFIG.RECOVERY = setup.RECOVERY_CONFIG
	end
	if setup.wakeup then
		
		resetReversals(KOF_CONFIG.MOVES_VAR_NAMES, "WAKEUP")
		dumpTable(KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]) 
		for i =1,5 do
			KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["REC_"..i] = setup.recording_var_states[i].value
			KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_"..i).propagates = setup.recording_var_states[i].propagates
		end
		
		KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
		formatGuiTables()

	end
    if setup.guard then
		
		resetReversals(KOF_CONFIG.MOVES_VAR_NAMES, "GUARD")
		dumpTable(KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]) 
		for i =1,5 do
			KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["REC_"..i] = setup.recording_var_states[i].value
			KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_"..i).propagates = setup.recording_var_states[i].propagates
		end
		
		KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
		formatGuiTables()

	end
end

--[[*** end of General Functions ***]]
local function getFacingDirection()
	if playerTwoFacingLeft() then
		return "P2 Left"
	end
	return "P2 Right"
end
local function getBlockingDirection(player_id)
	if player_id == nil then 
		player_id = KOF_CONFIG.PLAYERS.PLAYER2.ID
	end

	if player_id == KOF_CONFIG.PLAYERS.PLAYER2.ID then
		if playerTwoFacingLeft() then
			return "P2 Right"
		end
		return "P2 Left"
	elseif player_id == KOF_CONFIG.PLAYERS.PLAYER1.ID then
		if playerOneFacingLeft() then
			return "P1 Right"
		end
		return "P1 Left"
	end
end


local function transitionToState(newState)
	stateMachine.lastState = stateMachine.currentState
    -- Logic for transitioning to a new state
    stateMachine.currentState = newState
    print("Transitioned to state:", newState)
    -- Additional logic for state transition...
end
local iddle_time_running = false
local iddle_finish_time = 0
local iddle_time = 80
local last_frame_ran = 0
local function wakeUpEnabled()
	if saveStateLoaded() then
		iddle_time_running = false
		iddle_finish_time = 0
		last_frame_ran = 0

		return true
	end

	local current_frame = emu.framecount()

	-- already ran this frame
	if (current_frame == last_frame_ran) and iddle_time_running then
		print("Already ran this frame")
		return false
	end

	last_frame_ran = current_frame
	if iddle_time_running then
		print("current iddle Time is: "..(iddle_finish_time))
		if iddle_finish_time == 0  then			
			iddle_time_running = false
			return true
		end
		iddle_finish_time = iddle_finish_time -1
		return false
	end	
	return true
end
local function startWakeupIddleTime()
	iddle_time_running = true
	iddle_finish_time = iddle_time
end
local function dummyCrouchGuard()
	local tbl = {}	
	tbl[getBlockingDirection()] = 1
	tbl["P2 Down"] = 1
	joypad.set(tbl)
end

local function dummyGuard()
	local tbl = {}	
	tbl[getBlockingDirection()] = 1
	joypad.set(tbl)
end

local delay_count = 0
local function delay(delay_frames, functionToExecute, ...)
    if delay_count < delay_frames then
		delay_count = delay_count + 1
		return true
    end

    if functionToExecute(...) == false then
        delay_count = 0
		return false
    end
end
local sequence_reversal_type = nil
local current_move_index_counter = 1
local current_move_time_counter = 0
local current_sequence = {}
local function doMove(move_name, times, conf)
	--[[if saveStateLoaded() then
		return false
	end--]]
	if current_move_time_counter >= times then
        return false
    end
    if conf == nil then conf = false end

    local seq
    if conf == false  then
		if   (next(current_sequence) == nil) then 
        	current_sequence = getSequence(moves[move_name], sequence_reversal_type)
		end
		seq = current_sequence
    else
        seq = KOF_CONFIG.MOVES[move_name].sequence
    end


  if current_move_index_counter > #seq then
    current_move_time_counter = current_move_time_counter + 1
    if current_move_time_counter >= times then
        current_move_time_counter = 0
        current_move_index_counter = 1
        current_sequence = {}
        return false
    end
    current_move_index_counter = 1
end


    local tbl = {}
    for _, value in ipairs(seq[current_move_index_counter]) do
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

    joypad.set(tbl)
    current_move_index_counter = current_move_index_counter + 1

    return true
end





local CURRENT_REVERSAL_MOVE_NAME = nil
local function getCurrentReversalMove(state)
	if (CURRENT_REVERSAL_MOVE_NAME) == nil then
		if state == "guard_reversal"	then
			if KOF_CONFIG.GUARD.reversal  == KOF_CONFIG.GUARD.REVERSAL_OPTIONS.RANDOM then
				CURRENT_REVERSAL_MOVE_NAME =KOF_CONFIG.GUARD.reversal_moves[math.random(1,  #KOF_CONFIG.GUARD.reversal_moves)]
			else
				CURRENT_REVERSAL_MOVE_NAME =KOF_CONFIG.GUARD.reversal_moves[1]
			end
			sequence_reversal_type = reversal_types.GUARD
		elseif state == "waking_up" then	
			if KOF_CONFIG.WAKEUP.reversal  == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM then
				CURRENT_REVERSAL_MOVE_NAME =KOF_CONFIG.WAKEUP.reversal_moves[math.random(1,  #KOF_CONFIG.WAKEUP.reversal_moves)]
			else
				CURRENT_REVERSAL_MOVE_NAME =KOF_CONFIG.WAKEUP.reversal_moves[1]
			end
			sequence_reversal_type = reversal_types.WAKEUP
		end
	end
	return CURRENT_REVERSAL_MOVE_NAME
end

local function resetCurrentReversalName()
	CURRENT_REVERSAL_MOVE_NAME = nil
	sequence_reversal_type = nil
end
local function buildReversal(reversal_name)
	local _reversal = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(reversal_name)
	return _reversal
end
local function doReversal(_name, _times)

	if doMove(_name, _times) == false then

		resetCurrentReversalName()
		return false
	end
	return true
end


local function dummyCrouchForATime()
	return doMove("CROUCH", 10, true)
end
local function p2Crouch()
	local tbl = {}
	tbl["P2 Down"] = 1
	joypad.set(tbl)
end
local function p1CrouchGuard()
	local tbl = {}	
	tbl[getBlockingDirection(KOF_CONFIG.PLAYERS.PLAYER1.ID)] = 1
	tbl["P1 Down"] = 1
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
	if P2ActionIsExecuting() then
		return doMove('GUARD_BACK',10, true)		
	end
end
local function justGuard()	
	local tbl = {}	
	tbl[getBlockingDirection()] = 1
	joypad.set(tbl)
end

local function dummyCrouchGuardForATime()
	return doMove('CROUCH_GUARD',30, true)
end

local cooldowns = {}  -- Table to store cooldowns for different functions
local functionRunningFlags = {}  -- flag to track whether a function is currently running


local function executeWithCooldown(func, cooldownDuration, funcName)
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





local function doNothing()
	--print('Doing nothing')
	return false
end
local function filterAct(act)
	if act== 21 or act == 22 or act == 23 or act == 24 or act == 25 or act == 79 or act == 14 or act == 2 or act == 48 or act == 49 or act == 1 or act == 0 or act == 6 or act == 45 or act == 46 or act == 47 or act == 3 or act == 4 or act == 5 or act == 15 or act == 16 or act == 7 or act == 8 or act == 9 or act == 10 or act == 11 or act == 12 or act == 13 or act == 17 or act == 18 or act == 19 or act == 20 then
		return 0x00
	end
end
local function eliminateInvalidAct(act)
	local invalidActs = {
		[0] = true, [1] = true
	}


	if invalidActs[act] then
		return true
	end
	return false		
end

local function eliminateInvalidActOfBackdash(player)
	local act_of_backdash = 0
	local current_act = rb(base_action_adress)
	if act_of_backdash ~= current_act then
		return false
	end
	if player == 1 then
		wb(base_action_adress, 0x00)
	elseif player == 2 then
		wb(base_action_adress + 1, 0x00)
	end
end
local function filterActOfBlocking(act)
	local invalidActs = {
		[0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true,
		[6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true,
		[12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [17] = true,
		[18] = true, [19] = true, [20] = true, [21] = true, [22] = true, [23] = true,
		[24] = true, [25] = true, [45] = true, [46] = true, [47] = true, [48] = true,
		[49] = true, [50] = true, [79] = true
	}

	if invalidActs[act] then
		return 0x00
	end
	return act
end
local function p1MoveIsExecuting()
	local act = p1CurrentAction()
	if filterActOfBlocking(act) == 0x00 then
		return false
	end
	return true
end
local start_ = false

local chosenGuardOption = nil  -- nil = no decision yet

local function block()
	--TODO : add  a little prolongation of time to the block
    -- Additional logic for blocking.
	if KOF_CONFIG.GUARD.standing_guard == 1 then
		if KOF_CONFIG.GUARD.random_guard == 1 then
			local percentage_of_guard = 50
			if P2ActionIsExecuting() then
				-- Choose ONCE
				if not chosenGuardOption then
					local randomNumber = math.random(1, 100)
					if randomNumber <= percentage_of_guard then
						chosenGuardOption = "doNothing"
					else
						chosenGuardOption = "justGuard"
					end
				end

				-- Execute LOCKED choice
				if chosenGuardOption == "doNothing" then
					doNothing()
				elseif chosenGuardOption == "justGuard" then
					justGuard()
				end
			else
				-- Reset when action ends
				chosenGuardOption = nil
			end
			return
		else
			if P2ActionIsExecuting() then
				gui.text(10,103,"Guard")
				justGuard()
			end
		end
	elseif KOF_CONFIG.GUARD.crouch_guard == 1 then
		if P2ActionIsExecuting() then
				if KOF_CONFIG.GUARD.random_guard == 1 then
						-- Choose ONCE
				if not chosenOption then
					
					local percentage_of_guard = 50
					local randomNumber = math.random(1, 100)
					if randomNumber <= percentage_of_guard then
						chosenOption = "dummyCrouch"
					else
						chosenOption = "dummyCrouchGuard"
					end
				end

				-- Execute LOCKED choice
				if chosenOption == "dummyCrouch" then
					p2Crouch()
				elseif chosenOption == "dummyCrouchGuard" then
					dummyCrouchGuard()
				end
			else
				dummyCrouchGuard()
			end
		else
			-- Reset when action ends
			chosenOption = nil	
			p2Crouch()
		end
			
	end
end
local active_wake_up =false
local function isOnWakeUp()
	return rb(0x108321) > 0
end
local function closeToGround()
	return rb(0x108321) < 20 and rb(0x108321) >  10 -- 18 used to be 5
end
local function isWakeUpTime()
	return rb(0x108321) == 0  
end


-- Function to set default configuration based on configName
function setDefaultConfig(configName)
    if configName == "safe_jump_training" then
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		KOF_CONFIG.RECOVERY.dummy_recovering = true
        KOF_CONFIG.RECOVERY.recovery = KOF_CONFIG.RECOVERY.OPTIONS.ON
		KOF_CONFIG.RECOVERY.delay = 25
		KOF_CONFIG.RECOVERY.times = 3
		local move_name = "DPC"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name = "C_GUARD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 8
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		KOF_CONFIG.MOVES_VAR_NAMES["DOWN_C"] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
        -- Set other options as needed for "safe_jump_training" configuration
    elseif configName == "aggressive_training" then
        KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.REVERSAL_OPTIONS.ON
        -- Set other options as needed for "aggressive_training" configuration
    elseif configName == "custom_config" then
        -- Define custom configuration options here
    else
        print("Unknown configuration:", configName)
    end
end
local dizzy_location = 0x10843F
local function dissableDizzy()
		wb(dizzy_location, 0x67)	
end


local counter_location_1 = 0x1083e6
local counter_location_2 = 0x10d994
local function enableCounter()
	if playerTwoCanCounter() then
		ww(counter_location_1, 0x1000)
		ww(counter_location_2, 0x0070)
	end
end

local guard_break_location = 0x108447
local function toggleGuardBreak()
	if KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.NEVER then
		wb(guard_break_location, 0x67)
	elseif KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.ALWAYS then
		wb(guard_break_location, 0x00)
	end

end

local cpu_location = 0x108470
local function enableCPU()
		wb(cpu_location, 0x81)	
end

local function disableCPU()
		wb(cpu_location, 0x01)
end

local dont_recover = false
local recovery_enabled = false
-- global, as it is used in ssf2x
local kofTogglePlayBack = function(bool, vargs)
	if interactivegui.movehud.enabled then return end
	
	local _playbackslot = recording.playbackslot or recording.recordingslot -- tmp for playbackslot
	recording.playbackslot = nil
	
	local _rs = recording.recordingslot
	-- i dont want the recording to change based on the randomize of the hud screen been selected
	--[[ if recording.randomise then
		local b = false
		for i = 1, 5 do if recording[i][1] then b = true end end
		if not b then return end
		local pos
		_playbackslot = nil
		while _playbackslot==nil do -- keep running until we get a valid slot
			pos = math.random(5)
			if recording[pos][1] then -- check if there's something in here
				_playbackslot = pos
			end
		end
		-- make sure the recordslot is properly serialised if using randomise
		recording.recordingslot = _playbackslot
	end ]]
	
	if vargs then vargs.playback = false end
	toggleStates(vargs)
	
	recording.recordingslot = _rs -- restore recordingslot after serialise (through toggleRecord)
	
	local recordslot = recording[_playbackslot]
	if not recordslot then return end

	if not recordslot.p1start and not recordslot.p2start then -- if nothing is recorded
		recording[_playbackslot] = {}
	end
	if not recordslot[1] then return end -- if nothing is recorded

	if bool==nil then recording.playback = not recording.playback
	else recording.playback = bool end
	
	if not recording.replayP1 and not recording.replayP2 then
		recording.replayP2 = true
	end

	if not recording.playback then
		recordslot.framestart = nil
	else
		recording.playbackslot = _playbackslot
		
		if recording.replayP1 and recording.replayP2 then
			recordslot.start = recordslot.p1start
			if (recordslot.start==nil and recordslot.p2start~=nil) or (recordslot.start>recordslot.p2start) then recordslot.start = recordslot.p2start end
		elseif recording.replayP1 then
			toggleSwapInputs(true)
			recordslot.start = recordslot.p1start 
		else
			recordslot.start = recordslot.p2start
		end
		if recordslot.start==recordslot.finish then toggleSwapInputs(false) return end -- nothing recorded
		
		recording.startcounter = 0 -- randomise starting playback
		if recording.maxstarttime == 0 then
			recording.starttime = 0
		else
			recording.starttime = math.random(recording.maxstarttime+1)-1 -- [0,maxstarttime]
		end
	end
end
local function isRecording(reversal_name)
	if moves[reversal_name].type == MOVE_TYPES.RECORDING then
		return true
	end
	return false
end
	  -- Function to load a machine state from a specified file
function load_machine_state(file_path)
    -- Check if the save file exists
    local file = io.open(file_path, "rb")
    if file then
        file:close()  -- Close the file after checking for existence
        savestate.load(file_path)  -- Load the machine state
        print("Machine state loaded from: " .. file_path)
    else
        print("Error: Save file not found at " .. file_path)
    end
end
local running_randomned_cpu_action_gccd = false
local running_randomned_cpu_action_gcab = false
local gccd_random_move_ends = false
local gcab_random_move_ends = false
local current_cpu_action_running = false
local gccd_action_running = false
local gcab_action_running = false
Character = {}
Character.__index = Character

function Character:new(name, screen_address, screen_position_address, action_base_address, action_sequence_address)

    local obj = {
		name = name,
        screen_address = screen_address,
        screen_position_address = screen_position_address,
		action_base_address = action_base_address,
		action_sequence_address = action_sequence_address,
        screen_index = 0, -- Placeholder
        screen_position_index = 0, -- Placeholder
		action_base = 0,
		action_sequence = 0,
		short_jumping = false,
    }
    setmetatable(obj, Character)
    
    -- Call the private method inside the constructor
    obj:_calculate_indexes()
    
    return obj
end

function Character:_calculate_indexes()
    self.screen_index = rb(self.screen_address)
    self.screen_position_index = rb(self.screen_position_address)
end

function Character:calculate_actions()
    self.action_base = rb(self.action_base_address)
    self.action_sequence = rb(self.action_sequence_address)
end


function Character:get_screen_position()
    -- Recalculate indexes before returning
    self:_calculate_indexes()
    return string.format("%d-%d", self.screen_index, self.screen_position_index)
end

function Character:is_close_to(other)
    self:_calculate_indexes()
    other:_calculate_indexes()

    local screen_diff = (self.screen_index - other.screen_index) * 256
    local position_diff = self.screen_position_index - other.screen_position_index
    local total_distance = math.abs(screen_diff + position_diff)

    return total_distance < 155
end
function Character:get_distance_to(other)
    self:_calculate_indexes()  -- Ensure indexes are updated
    other:_calculate_indexes()

    local screen_diff = (other.screen_index - self.screen_index) * 256
    local position_diff = other.screen_position_index - self.screen_position_index

    return math.abs(screen_diff + position_diff)
end

function Character:is_short_jumping()
    self:calculate_actions() -- Update action values before checking
    return  self.action_base == 0 and self.action_sequence == 17
end

function Character:is_short_jumping_close_to(other)
    return self:is_short_jumping() and self:is_close_to(other)
end




local char1_screen_address = 0x108118
local char2_screen_address = 0x108318
local char1_name = "P1"
local char2_name = "P2"
local char1_screen_position_address =  0x108119
local char2_screen_position_address = 0x108319

-- Example usage:
local char1 = Character:new(char1_name, char1_screen_address, char1_screen_position_address, p1hitstatus, p1hitstatus+1)
local char2 = Character:new( char2_name, char2_screen_address, char2_screen_position_address, p2hitstatus, p2hitstatus+1)

local function draw_distance_status(character1, character2)
    local is_close = character1:is_close_to(character2)
    local text = is_close and "close" or "far"
    local color = is_close and "red" or "cyan"
    
    gui.text(170, 40, text, color, "black")
end
local function draw_action_code(character, x, y)
    character:calculate_actions() -- Ensure values are updated before drawing
    gui.text( x, y,character.name.." action: ".. character.action_base .. "-" .. character.action_sequence, "white", "black")
end

local draw_screen_position = function(character, x, y)
	character:calculate_actions() -- Ensure values are updated before drawing
	gui.text( x, y,character.name.." screen pos: ".. character:get_screen_position(), "white", "black")
end
local past_stun = 0
local decreased_stun = 0
local function draw_stun_status(character1, character2)
	local stun = rb(0x10843F)
	if stun < past_stun then
		decreased_stun = stun - past_stun
	elseif stun > past_stun then
		decreased_stun = 0
	end
	past_stun = stun
	x = 200
	y = 48
	gui.text( x, y," stun: ".. stun.." ("..decreased_stun..")" , "yellow")
end
local past_guard = 0
local decreased_guard = 0
local function draw_guard_status(character1, character2)
	local guard = rb(0x108447)
	if guard < past_guard then
		decreased_guard = guard - past_guard
	elseif guard > past_guard then
		decreased_guard = 0
	end
	past_guard = guard
	x = 200
	y = 40
	gui.text( x, y," guard: ".. guard.." ("..decreased_guard..")" , "cyan")
end
local p1_frame_advantage = 0
local update_advantage_message = true
local same_move_frame_count = 0
local blockstun_frame_count = 0
local action_frame_count = 0
local function draw_frame_advantage()
	if p1NewActCodeRunningStarted() then
		startCountingActionFrames()
		startCountingBlockstunFrames()
	end
	if P1ActCodeRunning() and 	playerTwoInBlockstun() then
		blockstun_frame_count = getLastBlockstunDuration()
		action_frame_count = getLastActionDuration()
		return
	end
	p1_frame_advantage = action_frame_count - blockstun_frame_count
	local x = 20
	local y = 40
	local color =""
	if p1_frame_advantage == 0 then 
		color = "yellow" 
	elseif p1_frame_advantage > 0 then
		color = "green" 
	else
		color = "red" 
	end
	

	-- this condition should detect if a the same move is puttingp2 inblockstun
	--[[if P1ActCodeRunning() and playerTwoInBlockstun() then
		same_move_frame_count = same_move_frame_count + 1

		p1_frame_advantage = same_move_frame_count - blockstun_frame_count	
		update_advantage_message  = false

	end ]]
	--if P1SameActCodeRunning() and blockstun_frame_count > 0 then



		gui.text( x, y,"adv: ".. p1_frame_advantage, color)
		gui.text( x, y+10,"act d: ".. action_frame_count, color)
		gui.text( x, y+20,"blck d: ".. blockstun_frame_count, color)
		

end
local function draw_debug_info()
	

draw_action_code(char1, 30, 180)
draw_action_code(char2, 170, 180)
draw_screen_position(char1, 30,190)
draw_screen_position(char2, 170,190)
draw_distance_status(char1, char2)
draw_stun_status(char1, char2)
draw_guard_status(char1, char2)
--draw_frame_advantage()

gui.text( 170, 170,"P1 meter: "..rb(0x1081e8), "white", "black")


end
local initial_distance = nil
local frame_counter = 0
local near_jump_os_action_active = false

local function check_jump_approaching(char1, char2)
    local current_distance = char1:get_distance_to(char2)

    if frame_counter == 0 and char1:is_short_jumping_close_to(char2) and not near_jump_os_action_active then
        initial_distance = current_distance
        frame_counter = 1  -- Start counting frames
    elseif frame_counter > 0 then
        frame_counter = frame_counter + 1

        if frame_counter >= 10 then
			frame_counter = 0  -- Reset after checking
            if current_distance <= initial_distance then
				near_jump_os_action_active = true
                return true
                -- Perform action here if needed
            end
        end
    end
	return false
end

local STAGES = {
	JAPAN_STREET = 0,
	CHINA = 1,
	KOREA = 2,
	MID_EAST = 3,
	SPAIN = 4,
	USA_YARD = 5,
	JAPAN_TEMPLE = 6,
	USA_WHARF = 7,
	BLACK_NOAH = 8,
}
local MUSIC_TRACKS = {
    ESAKA = 0x00,
    KURIKINTON = 0x01,
    ART_OF_FIGHT = 0x02,
    RUMBLING_ON_THE_CITY = 0x03,
    SHIN_SENRITSU_NO_DORA = 0x04,
    FAIRY = 0x05,
    SEOUL_ROAD = 0x06,
    BLOODY = 0x07,
    C62 = 0x08,
    BLUE_MARYS_BLUES = 0x09,
    LONDON_MARCH = 0x0A,
    ARASHI_NO_SAXOPHONE_2 = 0x0B,
    IN_SPITE_OF_ONES_AGE = 0x0C,
    SLUM_NO_5 = 0x0D,
    KETCHAKU_R_D = 0x0E,
    STILL_GREEN = 0x0F,
    THE_RR = 0x10,
    ESAKA_ALT = 0x11,
    RHYTHMIC_HALLUCINATION = 0x12,
    FANTASTIC_WALTZ = 0x13,
    MAD_FANTASY = 0x14,
    NE = 0x15,
    ARASHI_NO_SAXOPHONE = 0x16,
    ARASHI_NO_SAXOPHONE_2_ALT = 0x17
}





local kof_config_throw_os_on_jump = false
local p1_recovery_frames = 0
local p2_blockstun_frames = 0

local measuring = false
local frame_advantage = 0

local last_checked_frame = -1
local past_frame_act = 0
local p1_last_recovery_frames = 0
local latest_blockstun = 0
local filtered_act = 0
local function checkFrameAdvantage()
    local current_frame = emu.framecount()
    if current_frame == last_checked_frame then
        return -- Already updated this frame
    end
    last_checked_frame = current_frame

    local act = p1CurrentAction()
	filtered_act = filterAct(act)
    local blockstun = p2CurrentBlockstun()
	--gui.text(20, 50, "blockstun: " .. latest_blockstun, "yellow")

    -- Start measuring when blockstun begins
    if blockstun ~= 0 and not measuring then
        measuring = true
        p1_recovery_frames = 0
        p2_blockstun_frames = 0
        frame_advantage = 0
	end

    if measuring then
        -- Count blockstun frames
        if blockstun ~= 0 then
            p2_blockstun_frames = p2_blockstun_frames + 1
        end

        -- Count P1 recovery frames
        if filtered_act ~= 0 and filtered_act == past_frame_act then
            p1_recovery_frames = p1_recovery_frames + 1
		p1_last_recovery_frames = p1_recovery_frames

		elseif filtered_act ~= 0 and filtered_act ~= past_frame_act then
			latest_blockstun = p2_blockstun_frames
			p1_recovery_frames = 0
			p2_blockstun_frames = 0
		end
		past_frame_act = filtered_act

        -- End measurement when blockstun finishes
        if blockstun == 0 and act == 0 then
            frame_advantage = p2_blockstun_frames - p1_recovery_frames
			latest_blockstun = p2_blockstun_frames
			p2_blockstun_frames = 0
			p1_recovery_frames = 0
            measuring = false
        end
    end
	--gui.text(20, 60, "act duration: " .. p1_last_recovery_frames, "yellow")
	

    -- Draw last advantage result
    if frame_advantage ~= 0 then
        gui.text(20, 40, "Block Adv: " .. frame_advantage, "yellow")
        --gui.text(20, 90, "lts bs: " .. latest_blockstun, "yellow")

    end
end


local dummy_position = 0
local percentage_of_recovery = 50
local chosenRecoveryOption = nil  -- nil = no decision ye
local function recover(callback)
	if KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.RANDOM then	
			-- Choose ONCE
		if not chosenRecoveryOption then
			local randomNumber = math.random(1, 100)
			if randomNumber <= percentage_of_recovery then
				chosenRecoveryOption = "doNothing"
			else
				chosenRecoveryOption = "recoveryRoll"
			end
		end

		if chosenRecoveryOption == "doNothing" then
			delay(30,function ()
				chosenRecoveryOption =nil
				callback()
				return false
			end)
		elseif chosenRecoveryOption == "recoveryRoll" then
					
			delay(KOF_CONFIG.RECOVERY.delay, function()
				local res = doMove("AB",  KOF_CONFIG.RECOVERY.times, true)
				if res == false then				
					chosenRecoveryOption =nil
					callback()
					return false
				end

				return true
			end)
		end
	elseif KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.ON then
				
			delay(KOF_CONFIG.RECOVERY.delay, function()
				local res = doMove("AB",  KOF_CONFIG.RECOVERY.times, true)
				if res == false then
					chosenRecoveryOption =nil
					callback()
					return false
				end

				return true
			end)
	end
	return true
end
function Run() -- runs every frame
	if KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.can_crouch_guard then
		p1CrouchGuard()
	end
	--gui.text(20, 30, "block address: " .. rb(p2blockstun_address), "yellow")
	--justGuard()
	--108318 - 108319 Dummy stage position from 0020 (left corner) to 02e0  (right corner)
    gui.text(20, 80, "dummy position: " .. dummy_position, "yellow")
	if KOF_CONFIG.GUARD.dummy_guarding then
		gui.text(20, 100, "dummy guarding", "yellow")
		if P2CurrentAction() == 2 or P2CurrentAction() == 1 or P2CurrentAction() == 46 or P2CurrentAction() == 47 or P2CurrentAction() == 48 or P2CurrentAction() == 49 or P2CurrentAction() == 50 then
			dummy_position = rw(0x108318)
			if playerTwoFacingLeft then
				ww(0x108318,dummy_position)
			else 
				ww(0x108318,dummy_position)
			end	
			P2SetAction(0)
		end
	end

	checkFrameAdvantage()
	draw_debug_info()
	if kof_config_throw_os_on_jump or KOF_CONFIG.CPU.THROW_OS_ON_JUMP then
		check_jump_approaching(char1, char2)
		if near_jump_os_action_active then	
			delay(24, function()
				if doMove("THROW_OS", 1,true) == false then
					near_jump_os_action_active = false
				end 
			end)	
		end
	end
			
	if KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED or KOF_CONFIG.CPU.HAS_CHANGED then
		KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = false
		load_machine_state("addon\\kof_training\\savestates\\"..emu.romname().."_select.fs")  -- Replace with your file path
		if KOF_CONFIG.CPU.HAS_CHANGED then 
			KOF_CONFIG.CPU.HAS_CHANGED = false
		end	

		local level_address = 0x10FD8E
		wb(level_address, KOF_CONFIG.CPU.current_dificulty)

		local stage_address = 0x10A7EA
		wb(stage_address, STAGES.JAPAN_STREET)

		local music_address = 0x10ED5F
		wb(music_address, MUSIC_TRACKS.FANTASTIC_WALTZ)

		wb(p1_stored_index_location, KOF_CONFIG.UI.CURRENT_PLAYER1.code)
		wb(p2_stored_index_location, KOF_CONFIG.UI.CURRENT_PLAYER2.code)
		if KOF_CONFIG.UI.PLAYER1_EX then
			wb(0x10A85A,0x01)
		
		end
		if KOF_CONFIG.UI.PLAYER2_EX then
			wb(0x10A86B,0x01)
		end
		if KOF_CONFIG.UI.MODE_HAS_CHANGED then
			KOF_CONFIG.UI.MODE_HAS_CHANGED = false
			if KOF_CONFIG.UI.PLAYER1_MODE == KOF_CONFIG.UI.MODES.ADVANCED then
				wb(0x10A84C,0x00)
			elseif KOF_CONFIG.UI.PLAYER1_MODE == KOF_CONFIG.UI.MODES.EXTRA then
				wb(0x10A84C,0x01)
			end
			if KOF_CONFIG.UI.PLAYER2_MODE == KOF_CONFIG.UI.MODES.ADVANCED then
				wb(0x10A85D,0x00)
			elseif KOF_CONFIG.UI.PLAYER2_MODE == KOF_CONFIG.UI.MODES.EXTRA then
				wb(0x10A85D,0x01)
			end
		end
				
		

	end

	
	--gui.text(197, 73,  rb(in_air), "cyan", "black")
	--[[ if rb(0x108321)~=0  then
		
		print(rb(0x108321).."-"..rb(0x108322).."-"..rb(0x108323))
	end ]]
	 -- Check the current state and execute corresponding behavior
	--[[  gui.text(197, 73,  "test 1: "..rb(0x108321), "cyan", "black")
	 gui.text(197, 83,  "test 2: "..rb(0x108322), "cyan", "black")
	 gui.text(197, 93,  "test 3: "..rb(0x108323), "cyan", "black") ]]
	 if not KOF_CONFIG.DIZZY.dummy_can_dizzy  then
		dissableDizzy()
	 end
	 if KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.can_be_countered then
		enableCounter()
	 end
	
	 if KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.state_toggled then
		gui.text(197, 83,  "guard break state toggled:"..rb(guard_break_location) , "cyan", "black")
		toggleGuardBreak()
	 end
	 
	if KOF_CONFIG.CPU.dummy_can_fight then
		enableCPU()
	else	
		disableCPU()
	end

	
	--[[ if KOF_CONFIG.CPU.GCAB.dummy_can_gcab then
		if playerTwoInBlockstun() then
			disableCPU()
			KOF_CONFIG.CPU.dummy_can_fight = false
			transitionToState("cpu_action")
		end 
	end ]]
	 if stateMachine.currentState == "start" then
        -- Logic for the "start" state
        -- Additional logic specific to the "start" state...
		gui.text(10, 300,  "this is the wakeup state"..tostring(KOF_CONFIG.WAKEUP.dummy_waking_up).." " , "cyan", "black")
		--
		if KOF_CONFIG.WAKEUP.dummy_waking_up then
			wakeUpEnabled()
		end
		
		if KOF_CONFIG.CPU.dummy_can_fight or current_cpu_action_running then --only while cpu is enabled or a cpu action is running
			if KOF_CONFIG.CPU.GCCD.dummy_can_gccd then
				if playerTwoInBlockstun() then
					if gccd_random_move_ends == true then
						return
					end
					gccd_action_running = true
					disableCPU()
					KOF_CONFIG.CPU.dummy_can_fight = false
					transitionToState("cpu_action")
				else
					gccd_random_move_ends = false
				end
			end		
			--GCAB
			if KOF_CONFIG.CPU.GCAB.dummy_can_gcab then
				if playerTwoIsFalling() then
					if gcab_random_move_ends == true then
						return
					end
					gcab_action_running = true
					disableCPU()
					KOF_CONFIG.CPU.dummy_can_fight = false
					transitionToState("cpu_action")
				else
					gcab_random_move_ends = false
				end
			end
		end
		if KOF_CONFIG.RECOVERY.dummy_recovering then
			if dont_recover then
				delay(10, function()
					local res = doNothing()
					if not res then
						dont_recover = false
					end
					return res
				end
				)
				return false
			end	
			
			if closeToGround() and wakeUpEnabled() then
				
				transitionToState("recovering")
			else
				--recovery_enabled = true
			end
		elseif KOF_CONFIG.GUARD.dummy_guarding  then
        	transitionToState("blocking")  -- Transition to the "blocking" state
		elseif KOF_CONFIG.WAKEUP.dummy_waking_up and not KOF_CONFIG.RECOVERY.dummy_recovering  then
			if (wakeUpEnabled()) then			
				if(isOnWakeUp() and active_wake_up == false) then
					active_wake_up = true
					transitionToState("waking_up")
				end
			end
		end
	elseif stateMachine.currentState == "blocking" then
		if (wakeUpEnabled() and closeToGround()) and KOF_CONFIG.RECOVERY.dummy_recovering then
			transitionToState("recovering")
		end		if not KOF_CONFIG.GUARD.dummy_guarding then
			transitionToState("start")
		end
		if KOF_CONFIG.WAKEUP.dummy_waking_up then
			if (wakeUpEnabled()) then			
				if(isOnWakeUp() and active_wake_up == false) then
					active_wake_up = true
					transitionToState("waking_up")
				end
			end
		end
		if  playerTwoInBlockstun() and KOF_CONFIG.GUARD.reversal ~= KOF_CONFIG.GUARD.REVERSAL_OPTIONS.OFF then
			
			local reversal_name = getCurrentReversalMove("guard_reversal")
			local reversal = buildReversal(reversal_name)
			if isRecording(reversal_name) then
				if (not reversal.propagates) and recording.playback then
					return
				end
			end
			transitionToState("guard_reversal")
		end
		block()
	elseif stateMachine.currentState == "waking_up" then
		print("waking up")
		if isWakeUpTime() then
			print("wakeup time active")
		end
		if active_wake_up == true then
			print("active_wakeup active")
		end
		if wakeUpEnabled() then
			print("wakeup enabled")
		else
			print("wakeup disabled")
		end
		if(isWakeUpTime() and active_wake_up == true and wakeUpEnabled()) then
			dont_recover = true
			print("wakeup reversal is starting")
			local reversal_name = getCurrentReversalMove("waking_up")
			local reversal = buildReversal(reversal_name)
			if isRecording(reversal_name) then				
				if ( not reversal.propagates) and recording.playback then
					return	
				else	
						
					if recording.loop then
						return
					end
					local _recording = recording.recordingslot
					recording.recordingslot = moves[reversal_name].index
					kofTogglePlayBack(true, {})
					recording.recordingslot = _recording
					--print("wakeup reversal is stoping")
					startWakeupIddleTime()
					resetCurrentReversalName()
					active_wake_up=false			
					if KOF_CONFIG.GUARD.dummy_guarding then
						transitionToState("blocking")  -- Transition to the "blocking" state
					else
						transitionToState("start")
						startWakeupIddleTime()
					end
				end
			else			
				delay(reversal.on_wake_up_delay, function ()
					local res = doReversal(reversal.name, reversal.on_wake_up_times)
					if res ==false then
						startWakeupIddleTime()
						active_wake_up=false
						resetCurrentReversalName()					
						if KOF_CONFIG.GUARD.dummy_guarding then
							transitionToState("blocking")  -- Transition to the "blocking" state
						else
							transitionToState("start")
							startWakeupIddleTime()
						end
					end
					return res
				end) --for state waking up
			end
		end
	elseif stateMachine.currentState == "guard_reversal" then
		local reversal_name = getCurrentReversalMove("guard_reversal")
	local reversal = buildReversal(reversal_name)
	if isRecording(reversal_name) then
		
		if ( not reversal.propagates) and recording.playback then
			return	
		else	
				
			if recording.loop then
				print("recording loop active")
				return
			end
			local _recording = recording.recordingslot
			recording.recordingslot = moves[reversal_name].index
			kofTogglePlayBack(true, {})
			recording.recordingslot = _recording
			--print("guard reversal is stoping")
			startWakeupIddleTime()
			resetCurrentReversalName()
			active_wake_up=false			
			if KOF_CONFIG.GUARD.dummy_guarding then
				transitionToState("blocking")  -- Transition to the "blocking" state
			else
				transitionToState("start")
				startWakeupIddleTime()
			end
		end
	else
		delay(reversal.on_guard_delay, function ()
			--print("doing delay")
			local res = doReversal(reversal.name, reversal.on_guard_times)
			if res ==false then
				--print("guard reversal is stoping")
				startWakeupIddleTime()
				active_wake_up=false					
				if KOF_CONFIG.GUARD.dummy_guarding then
					transitionToState("blocking")  -- Transition to the "blocking" state
				else
					transitionToState("start")
					startWakeupIddleTime()
				end
			end
			return res
		end) --for state guard_reversal		
	end
		 	
	elseif stateMachine.currentState == "recovering" then
	
		recover(function()
			--print("Move executed!")
			dont_recover = true
			if KOF_CONFIG.WAKEUP.dummy_waking_up then 
				active_wake_up = true
				transitionToState("waking_up")
				return false
			elseif KOF_CONFIG.GUARD.dummy_guarding then
				transitionToState("blocking")
				return false

			else
				transitionToState("start")
				return false

			end
		end)
			
	elseif stateMachine.currentState == "cpu_action" then
		if KOF_CONFIG.CPU.GCCD.dummy_can_gccd then 
			if KOF_CONFIG.CPU.GCCD.current_gccd == KOF_CONFIG.CPU.GCCD.OPTIONS.ON and gccd_action_running then				
				if doMove("CD", 3,true) == false then

					enableCPU()
					current_cpu_action_running = false
					gccd_action_running = false
					KOF_CONFIG.CPU.dummy_can_fight = true
					transitionToState("start")
				end 
			elseif KOF_CONFIG.CPU.GCCD.current_gccd == KOF_CONFIG.CPU.GCCD.OPTIONS.RANDOM and gccd_random_move_ends == false then
				if running_randomned_cpu_action_gccd == true then
					if doMove("CD", 3,true) == false then
						enableCPU()
						gccd_random_move_ends = true
						running_randomned_cpu_action_gccd = false
						current_cpu_action_running = false
						KOF_CONFIG.CPU.dummy_can_fight = true
						transitionToState("start")
					end
					return
				else

					local percentage_of_success = 30
					local randomNumber = math.random(1, 100)
					if(randomNumber <= percentage_of_success )then
						--print("random success")
						running_randomned_cpu_action_gccd = true
					else
						--print("random fail")
						gccd_random_move_ends = true
						running_randomned_cpu_action_gccd = false
						enableCPU()
						KOF_CONFIG.CPU.dummy_can_fight = true
						current_cpu_action_running = false
						transitionToState("start")
					end
				end
			end

		end
		
		if KOF_CONFIG.CPU.GCAB.dummy_can_gcab and gcab_action_running then 
			if KOF_CONFIG.CPU.GCAB.current_gcab == KOF_CONFIG.CPU.GCAB.OPTIONS.ON then				
				if doMove("AB", 5,true) == false then

					enableCPU()
					
					KOF_CONFIG.CPU.dummy_can_fight = true
					current_cpu_action_running = false
					gcab_action_running = false
					transitionToState("start")
				end 
			elseif KOF_CONFIG.CPU.GCAB.current_gcab == KOF_CONFIG.CPU.GCAB.OPTIONS.RANDOM and gcab_random_move_ends == false then
				if running_randomned_cpu_action_gcab == true then
					if doMove("CD", 3,true) == false then
						enableCPU()
						gcab_random_move_ends = true
						running_randomned_cpu_action_gcab = false
						KOF_CONFIG.CPU.dummy_can_fight = true
						current_cpu_action_running = false
						transitionToState("start")
					end
					return
				else

					local percentage_of_success = 30
					local randomNumber = math.random(1, 100)
					if(randomNumber <= percentage_of_success )then
						--print("random success")
						running_randomned_cpu_action_gcab = true
					else
						--print("random fail")
						gcab_random_move_ends = true
						running_randomned_cpu_action_gcab = false
						enableCPU()
						KOF_CONFIG.CPU.dummy_can_fight = true
						current_cpu_action_running = false
						transitionToState("start")
					end
				end
			end

		end
	end
	infiniteTime()
end
