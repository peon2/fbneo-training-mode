assert(rb,"Run fbneo-training-mode.lua")
local p2blockstun_address = 0x100502
local p2blockstun_value = 0xf5

local player_two_entered_blockstun = false
local last_updated_frame = -1
local blockstun_frames = 0
local last_blockstun_duration = 0

local sequence_reversal_type = nil
local current_move_index_counter = 1
local current_move_time_counter = 0
local current_sequence = {}


GAROU_CONFIG = {
    GUARD = {
        dummy_guarding = true,
        reversal = false,
        reversal_move = {
			["sequence"] = {
				{'down','back'},
				{'down','back'},
                {'down','back','a'},
                {'down','back','a'},
	
			},
			times = 1
		},
    }
}

local function playerTwoFacingLeft()    
    local p2direction = 0x100558
    return rb(p2direction)==0x80
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
local stateMachine = {
    currentState = "start",
    lastState = nil,
}

local sequence_reversal_type = nil
local current_move_index_counter = 1
local current_move_time_counter = 0
local current_sequence = {}
local function doMove( times)
    local seq
     seq = GAROU_CONFIG.GUARD.reversal_move.sequence

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

local function playerTwoInBlockstun()
	if (rb(p2blockstun_address) == p2blockstun_value) then
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

local function dummyCrouchGuard()
	local tbl = {}	
	tbl[getBlockingDirection()] = 1
	tbl["P2 Down"] = 1
	joypad.set(tbl)
end
local function transitionToState(newState)
	stateMachine.lastState = stateMachine.currentState
    -- Logic for transitioning to a new state
    stateMachine.currentState = newState
    print("Transitioned to state:", newState)
    -- Additional logic for state transition...
end

function Run() -- runs every frame
    GAROU_CONFIG.GUARD.reversal = true
	infiniteTime()
	maxCredits()
    if stateMachine.currentState == "start" then
        if GAROU_CONFIG.GUARD.dummy_guarding then
            transitionToState("blocking")  -- Transition to the "blocking" state
        end
    elseif stateMachine.currentState == "blocking" then
        dummyCrouchGuard()
        if GAROU_CONFIG.GUARD.reversal then
            if playerTwoInBlockstun() then
                print("Blockstun detected")
                    transitionToState("guard_reversal")
            end
        end
    elseif stateMachine.currentState == "guard_reversal" then
        if doMove( 3) == false then
            transitionToState("start")
        end
    end
		

end