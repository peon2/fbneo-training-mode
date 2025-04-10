assert(rb,"Run fbneo-training-mode.lua")


local p1hitstatus = 0x108172
local p2hitstatus = 0x108372

local in_air = 0x108322


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
local function playerTwoInBlockstun()
	if (rb(p2blockstun_address) == 0x20) or (rb(p2blockstun_address) == 0xA0) then
		return true
	end
	return false
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
	if rb(p2hitstatus) == 11 then
		print ("playerTwoIsFalling")
	end
	if rb(p2hitstatus) == 1 or rb(p2hitstatus) == 11 then
		if ACTcodesOfFallingActive() then
			return true
		end
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
	stateMachine.lastState = stateMachine.currentState
    -- Logic for transitioning to a new state
    stateMachine.currentState = newState
    print("Transitioned to state:", newState)
    -- Additional logic for state transition...
end
local iddle_time_running = false
local iddle_finish_time = 0
local iddle_time = 80
local function wakeUpEnabled()
	if iddle_time_running then
		--print("current iddle Time is: "..(iddle_finish_time))
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
local delay_count = 0
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
local function delay(delay_frames, functionToExecute, ...)
    if delay_count < delay_frames then
		if KOF_CONFIG.GUARD.dummy_guarding then
			if KOF_CONFIG.GUARD.crouch_guard ==  1 then
				dummyCrouchGuard()				
			end
			if KOF_CONFIG.GUARD.standing_guard ==  1 then
				dummyGuard()			
			end
		end
        delay_count = delay_count + 1
        --print("DELAYED BY: ", delay_count)
        return
    end

    if functionToExecute(...) == false then
        delay_count = 0
    end
end
local sequence_reversal_type = nil
local current_move_index_counter = 1
local current_move_time_counter = 0
local current_sequence = {}
local function doMove(move_name, times, conf)
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

    if current_move_time_counter >= times then
        current_move_time_counter = 0
        current_move_index_counter = 1
		current_sequence = {}
        return false
    end

    if current_move_index_counter > #seq then
        current_move_index_counter = 1
        current_move_time_counter = current_move_time_counter + 1
        if current_move_time_counter >= times then
            current_move_time_counter = 0
			current_sequence = {}
            return false
        end
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


local move_index_counter = 1

function doMoves(moveList, callback)
	
    if #moveList == 0 then
        if callback then
            callback()  -- Trigger the callback if provided and there are no moves
        end
        return false  -- No moves to execute
    end
	if move_index_counter > #moveList then
		move_index_counter = 1
		if callback then
			callback()  -- Trigger the callback if provided and all moves are executed
		end
		return true -- All moves executed the specified number of times
	end

    local currentMove = moveList[move_index_counter]

    delay(currentMove.delay, function()
        local res = doMove(currentMove.name, currentMove.times, currentMove.conf)  -- Execute the current move once

        if res == false then
            move_index_counter = move_index_counter + 1
        end

        return res
    end)

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
	return doMove('GUARD_BACK',10, true)
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

local start_press = false
local function block()
    -- Additional logic for blocking...
	if KOF_CONFIG.GUARD.standing_guard == 1 then
		if(start_press == false) then
			if playerOnePressedButtons()  then
				start_press = true
			end
		end
		if(start_press or  functionRunningFlags["dummyGuardForATime"] == true or functionRunningFlags['doNothing'] == true ) then			
			if start_press and KOF_CONFIG.GUARD.random_guard == 1 then
				local percentage_of_down = 30
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
		if(start_press == false) then
			if playerOnePressedButtons()  then
				start_press = true
			end
		end
		if (start_press or  functionRunningFlags["dummyCrouchGuardForATime"] == true or functionRunningFlags['p2Crouch'] == true ) then
			if start_press and KOF_CONFIG.GUARD.random_guard == 1 then
				local percentage_of_down = 35
				local randomNumber = math.random(1, 100)
				if(randomNumber <= percentage_of_down )then
					executeWithCooldown( dummyCrouchForATime, 1, "dummyCrouchForATime")
				else
					executeWithCooldown( dummyCrouchGuardForATime, 1, "dummyCrouchGuardForATime")
				end
				start_press = false
				return
			elseif start_press and KOF_CONFIG.GUARD.random_guard == 0 then
				if dummyMoveIsActive() then
					dummyCrouchGuard()
				elseif dummyCrouchGuardForATime()  == false  then
					start_press = false
				end
				
				return		
			end
			if(functionRunningFlags["dummyCrouchGuardForATime"] ) then
				
				if dummyMoveIsActive() then
					dummyCrouchGuard()
				else		
					executeWithCooldown( dummyCrouchGuardForATime, 1, "dummyCrouchGuardForATime")
				end
			end
			if(functionRunningFlags["dummyCrouchForATime"] ) then				
				executeWithCooldown( dummyCrouchForATime, 1, "dummyCrouchForATime")
			end
		else
			p2Crouch()
		end
		
	end
end
local active_wake_up =false
local function isOnWakeUp()
	return rb(0x108321) > 0
end
local function closeToGround()
	return rb(0x108321) < 20 and rb(0x108321) >  5
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
	  local first_character_location_p1 = 0x10A84E
	  local first_character_location_p2 = 0x10A85F
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
local function draw_debug_info()
	

draw_action_code(char1, 30, 180)
draw_action_code(char2, 170, 180)
gui.text(70,40, "in air: ".. tostring(playerTwoIsFalling() ) , "cyan", "black")
draw_screen_position(char1, 30,190)
draw_screen_position(char2, 170,190)
draw_distance_status(char1, char2)

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
function Run() -- runs every 
	draw_debug_info()
	if kof_config_throw_os_on_jump then
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

		wb(first_character_location_p1, KOF_CONFIG.UI.CURRENT_PLAYER1.code)
		wb(first_character_location_p2, KOF_CONFIG.UI.CURRENT_PLAYER2.code)
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
		
		--
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
			
			
			if (wakeUpEnabled() and closeToGround()) then
				if KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.RANDOM then
					local percentage_of_success = 50
					local randomNumber = math.random(1, 100)
					if(randomNumber <= percentage_of_success )then
						dont_recover = true
					else 
						recovery_enabled = true
					end
				elseif KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.ON then
					recovery_enabled = true
				end
				if dont_recover then
					delay(10, function()
						local res = doNothing()
						if not res then
							dont_recover = false
						end
						return res
					end
					)
					return
				end			
				if recovery_enabled then transitionToState("recovering")	end			
			end
		end
		if KOF_CONFIG.GUARD.dummy_guarding  then
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
		if not KOF_CONFIG.GUARD.dummy_guarding then
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
			transitionToState("guard_reversal")
		end
		block()
	elseif stateMachine.currentState == "waking_up" then
		if(isWakeUpTime() and active_wake_up == true and wakeUpEnabled()) then
	
			local reversal_name = getCurrentReversalMove("waking_up")
			local reversal = buildReversal(reversal_name)
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
	elseif stateMachine.currentState == "guard_reversal" then
		local reversal_name = getCurrentReversalMove("guard_reversal")
	local reversal = buildReversal(reversal_name)
	if isRecording(reversal_name) then
		if recording.loop then
			return
		end
		local _recording = recording.recordingslot
		recording.recordingslot = moves[reversal_name].index
		print("index is" ..moves[reversal_name].index)
		print("recording is" ..reversal_name)
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
		local recovery_moves = {}
		table.insert(recovery_moves,{ name = "AB", delay = KOF_CONFIG.RECOVERY.delay, times = KOF_CONFIG.RECOVERY.times, conf = true } )
		if KOF_CONFIG.WAKEUP.dummy_waking_up then
			local reversal_name = getCurrentReversalMove("waking_up")
			local reversal = buildReversal(reversal_name)
			table.insert(recovery_moves,{ name = reversal.name, delay = reversal.on_wake_up_delay, times = reversal.on_wake_up_times } )
		end
		doMoves(recovery_moves,function()
			--print("All moves executed!")
			recovery_enabled = false
			if KOF_CONFIG.WAKEUP.dummy_waking_up then 
				startWakeupIddleTime()
				resetCurrentReversalName()
			end
			if KOF_CONFIG.GUARD.dummy_guarding then
				transitionToState("blocking")
			else
				transitionToState("start")
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
						print("random success")
						running_randomned_cpu_action_gccd = true
					else
						print("random fail")
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
						print("random success")
						running_randomned_cpu_action_gcab = true
					else
						print("random fail")
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
