assert(rb, "Run fbneo-training-mode.lua")


require("addon.pechan_training_mod.config")
require("addon.pechan_training_mod.helpers")
local rom_name = emu.romname() or "unknown"
if PECHAN_CONFIG.SUPPORTED_GAMES[rom_name] then
	print("Pechan's Training mode activated for: " .. rom_name)
else
	return
end

-- Load translation module
local translate_mod = require("addon.pechan_training_mod.translate_mod")
local tl = translate_mod.tl
local en_data = require("addon.pechan_training_mod.locales.en")
local es_data = require("addon.pechan_training_mod.locales.es")
translate_mod.load_locale("en", en_data)
translate_mod.load_locale("es", es_data)
-- Set the language according to user config
translate_mod.set_locale(PECHAN_CONFIG.LANGUAGE.current_language)

--[[
if not _G.pechan_training_mod_tests_run then
	_G.pechan_training_mod_tests_run = true
	local luaunit = require("addon.pechan_training_mod.tests.luaunit")
	-- Load suites
	require("addon.pechan_training_mod.tests.test_guard")

	print(">>> RUNNING KOF TRAINING TESTS <<<")
	luaunit.LuaUnit.run()
	print(">>> TESTS COMPLETE <<<")
end
--]]

DBIndex = require("addon.pechan_training_mod.db_lua.db.index")
require("addon.pechan_training_mod.moves_settings")
require("addon.pechan_training_mod.guipages")
local frame_data = require("addon.pechan_training_mod.frame_data")

-- Debug Viewer Module
DebugViewer = require("addon.pechan_training_mod.utils.debug_viewer")
DebugViewer.setEnabled(true)
DebugViewer.log_to_file = true

-- AI and Trial Mode Modules
local AI = require("addon.pechan_training_mod.ai.init")
local Trials = require("addon.pechan_training_mod.ai.trials")
local Cinematics = require("addon.pechan_training_mod.ai.cinematics")

if rom_name == "kof98" then
	AI.init()
	Trials.init()
	Cinematics.init()
end

local current_game = PECHAN_CONFIG.get_current_game()

-- Base Player Singletons
local PlayerClass = require("addon.pechan_training_mod.core.player")
P1 = PlayerClass:new(1, current_game.player1_base, current_game.offsets, "Human")
P2 = PlayerClass:new(2, current_game.player2_base, current_game.offsets, "Dummy")

HumanPlayer = P1
DummyPlayer = P2

local air_height = current_game.player2_base + current_game.offsets.air_height

-- Calculate relative offset using the new player_stored_index property
local p1_stored_index_location = current_game.player1_base + (current_game.offsets.player_stored_index or 0)
local p2_stored_index_location = current_game.offsets.player2_stored_index and
	(current_game.player1_base + current_game.offsets.player2_stored_index) or (p1_stored_index_location + 0x11)
local p1_striker_stored_index_location = current_game.offsets.striker1_stored_index and
	(current_game.player1_base + current_game.offsets.striker1_stored_index) or nil
local p2_striker_stored_index_location = current_game.offsets.striker2_stored_index and
	(current_game.player1_base + current_game.offsets.striker2_stored_index) or nil
local p1_striker_count_location = current_game.offsets.striker_count_address and
	(current_game.player1_base + current_game.offsets.striker_count_address) or nil
local p2_striker_count_location = current_game.offsets.striker_count_address and
	(current_game.player2_base + current_game.offsets.striker_count_address) or nil
local p1_striker_mode_location = current_game.offsets.p1_striker_mode_address and
	(current_game.player1_base + current_game.offsets.p1_striker_mode_address) or nil
local p2_striker_mode_location = current_game.offsets.p2_striker_mode_address and
	(current_game.player1_base + current_game.offsets.p2_striker_mode_address) or nil

local p1_striker2_stored_index_location = current_game.offsets.p1_striker2_stored_index and
	(current_game.player1_base + current_game.offsets.p1_striker2_stored_index) or nil
local p1_striker3_stored_index_location = current_game.offsets.p1_striker3_stored_index and
	(current_game.player1_base + current_game.offsets.p1_striker3_stored_index) or nil
local p2_striker2_stored_index_location = current_game.offsets.p2_striker2_stored_index and
	(current_game.player1_base + current_game.offsets.p2_striker2_stored_index) or nil
local p2_striker3_stored_index_location = current_game.offsets.p2_striker3_stored_index and
	(current_game.player1_base + current_game.offsets.p2_striker3_stored_index) or nil

local stateMachine = {
	currentState = "start",
	lastState = nil,
	is_a_soft_reset = false,
	-- Migrated variables
	active_wake_up = false,
	isJustGuardRunning = false,
	chosenGuardOption = nil,
	last_do_move_name = nil,
	dont_recover = false,
	p2_was_in_hitstun = false,
	dummy_position = 0,
	-- CPU Action Flags
	running_randomned_cpu_action_gccd = false,
	running_randomned_cpu_action_gcab = false,
	gccd_random_move_ends = false,
	gcab_random_move_ends = false,
	current_cpu_action_running = false,
	gccd_action_running = false,
	gcab_action_running = false,
	-- WakeUp Event Manager Data
	wakeUpEvent = {
		active = false,
		handled = false,
	}
}

reversal_types = {
	GUARD = "GUARD",
	WAKEUP = "WAKEUP",
	HIT = "HIT"
}

-- [[ System State Variables ]]

local delay_count = 0

local one_hit_guard_triggered = false

local iddle_time_running = false
local iddle_finish_time = 0
local iddle_time = 80
local last_frame_ran = 0

local sequence_reversal_type = nil
local current_move_index_counter = 1
local current_move_time_counter = 0
local current_sequence = {}


local CURRENT_REVERSAL_MOVE_NAME = nil


local player_two_entered_blockstun = false
local last_updated_frame = -1
local blockstun_frames = 0
local last_blockstun_duration = 0

local p2blockstun_value = 0
local p2_blockstun_last_updated_frame = -1

local p2hitstun_value = 0
local p2_hitstun_last_updated_frame = -1

local previousButtonState = {}
local cooldowns = {}            -- Table to store cooldowns for different functions
local functionRunningFlags = {} -- flag to track whether a function is currently running

-- [[ Core Helper Functions ]]
local function getFacingDirection()
	if DummyPlayer:isFacingLeft() then
		return "P" .. DummyPlayer.id .. " Left"
	end
	return "P" .. DummyPlayer.id .. " Right"
end

local function getBlockingDirection(player_id)
	if player_id == nil then
		player_id = DummyPlayer.id
	end

	if player_id == DummyPlayer.id then
		if DummyPlayer:isFacingLeft() then
			return "P" .. DummyPlayer.id .. " Right"
		end
		return "P" .. DummyPlayer.id .. " Left"
	elseif player_id == HumanPlayer.id then
		if HumanPlayer:isFacingLeft() then
			return "P" .. HumanPlayer.id .. " Right"
		end
		return "P" .. HumanPlayer.id .. " Left"
	end
end

local function transitionToState(newState)
	stateMachine.lastState = stateMachine.currentState
	stateMachine.currentState = newState
	if PECHAN_CONFIG.DEBUG.STATE == 1 then
		print("Transitioned to state:", newState)
	end

	delay_count = 0
	if newState == "start" or newState == "blocking" then
		stateMachine.active_wake_up = false
	end
end

local function delay(delay_frames, functionToExecute, ...)
	if delay_count < delay_frames then
		delay_count = delay_count + 1
		return true
	end

	local res = functionToExecute(...)
	if res == false then
		delay_count = 0
		return false
	end
	return true
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
-- p2blockstun_value is handled locally in the updater


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

local base_action_adress = P1.addresses.hitstatus + 1


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

	if (current_p1_base_action == past_p1_base_action) then
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
local function getP1ExecutingAction()
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
	if (rb(P2.addresses.blockstun) == 0x20) or (rb(P2.addresses.blockstun) == 0xA0) then
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
local function p2CurrentBlockstun()
	if (rb(P2.addresses.blockstun) == 0x20) or (rb(P2.addresses.blockstun) == 0xA0) then
		local current_frame = emu.framecount()
		if current_frame ~= p2_blockstun_last_updated_frame then
			p2_blockstun_last_updated_frame = current_frame
			p2blockstun_value = (p2blockstun_value or 0) + 1
		end
		return p2blockstun_value
	end
	p2blockstun_value = 0 -- Reset when out of blockstun
	return 0
end

local function p2CurrentHitstun()
	if DummyPlayer:isBeingHit() then
		local current_frame = emu.framecount()
		if current_frame ~= p2_hit_stun_last_updated_frame then
			p2_hit_stun_last_updated_frame = current_frame
			p2hitstun_value = (p2hitstun_value or 0) + 1
		end
		return p2hitstun_value
	end
	p2hitstun_value = 0 -- Reset when out of hitstun
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

local p1blockstun_value = 0
local p1_blockstun_last_updated_frame = -1
local p1_hitstun_value = 0
local p1_hitstun_last_updated_frame = -1
local p1_entered_blockstun = false
local p1_blockstun_frames = 0
local p1_last_updated_frame = -1

local function playerOneInBlockstun()
	if (rb(P1.addresses.blockstun) == 0x20) or (rb(P1.addresses.blockstun) == 0xA0) then
		local current_frame = emu.framecount()
		if current_frame ~= p1_last_updated_frame then
			p1_blockstun_frames = p1_blockstun_frames + 1
			p1_last_updated_frame = current_frame
		end
		p1_entered_blockstun = true
		return true
	end
	if p1_entered_blockstun then
		-- last_blockstun_duration = blockstun_frames -- Not currently used for P1 logic but good for parity
		p1_entered_blockstun = false
	end
	p1_blockstun_frames = 0
	return false
end

local function p1CurrentBlockstun()
	if (rb(P1.addresses.blockstun) == 0x20) or (rb(P1.addresses.blockstun) == 0xA0) then
		local current_frame = emu.framecount()
		if current_frame ~= p1_blockstun_last_updated_frame then
			p1_blockstun_last_updated_frame = current_frame
			p1blockstun_value = (p1blockstun_value or 0) + 1
		end
		return p1blockstun_value
	end
	p1blockstun_value = 0
	return 0
end

local function p1CurrentHitstun()
	if HumanPlayer:isBeingHit() then
		local current_frame = emu.framecount()
		if current_frame ~= p1_hitstun_last_updated_frame then
			p1_hitstun_last_updated_frame = current_frame
			p1_hitstun_value = (p1_hitstun_value or 0) + 1
		end
		return p1_hitstun_value
	end
	p1_hitstun_value = 0
	return 0
end

local current_p2_base_action = 0
local past_p2_base_action = 0
local p2_action_frames = 0
local p2_last_updated_frame_of_action = -1
local p2_running_action = false
local p2_entered_new_action = false
local p2_last_action_duration = 0
local p2_base_action_address = P2.addresses.action -- This seems to be the move address based on usage

local function P2ActCodeRunning()
	current_p2_base_action = rb(P2.addresses.action)
	if current_p2_base_action == 0x23 then -- Standing/Idle likely
		return false
	end

	if (current_p2_base_action == past_p2_base_action) then
		local current_frame = emu.framecount()
		if current_frame ~= p2_last_updated_frame_of_action then
			p2_last_updated_frame_of_action = current_frame
			p2_action_frames = p2_action_frames + 1
			p2_running_action = true
			p2_entered_new_action = true
		end
		return p2_running_action
	end
	if p2_entered_new_action then
		p2_last_action_duration = p2_action_frames
		p2_entered_new_action = false
	end
	past_p2_base_action = current_p2_base_action
	p2_action_frames = 0

	return false
end

local function getP2ExecutingAction()
	if P2ActCodeRunning() then
		return current_p2_base_action
	end
	return 0
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
local function dummyIsFalling()
	if rb(DummyPlayer.addresses.hitstatus) == 1 or rb(DummyPlayer.addresses.hitstatus) == 11 then
		if ACTcodesOfFallingActive() then
			return true
		end
	end
	return false
end
--[[*** General Functions ***]]

function getPlayerName(player_id)
	local current_game = PECHAN_CONFIG.get_current_game()
	if player_id == PECHAN_CONFIG.PLAYERS.PLAYER1.ID then
		local p1_rom_index = rb(p1_stored_index_location) + 1 -- +1 because the table CHARACTERS starts at 1
		local char = current_game.characters[p1_rom_index]
		return char and char.name or "Unknown"
	elseif player_id == PECHAN_CONFIG.PLAYERS.PLAYER2.ID then
		local p2_rom_index = rb(p2_stored_index_location) + 1 -- +1 because the table CHARACTERS starts at 1
		local char = current_game.characters[p2_rom_index]
		return char and char.name or "Unknown"
	end
end

function getPlayerStoredId(player_id)
	if player_id == PECHAN_CONFIG.PLAYERS.PLAYER1.ID then
		local p1_stored_id = rb(p1_stored_index_location)
		return p1_stored_id
	elseif player_id == PECHAN_CONFIG.PLAYERS.PLAYER2.ID then
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
	local current_game = PECHAN_CONFIG.get_current_game()
	local p1_rom_index = rb(p1_stored_index_location) + 1 -- +1 because the table CHARACTERS starts at 1
	local p2_rom_index = rb(p2_stored_index_location) + 1 -- +1 because the table CHARACTERS starts at 1

	local p1_char = current_game.characters[p1_rom_index]
	local p2_char = current_game.characters[p2_rom_index]

	local p1_short_name = p1_char and p1_char.short_name or "p1"
	local p2_short_name = p2_char and p2_char.short_name or "p2"
	local base_name = p1_short_name .. "_" .. p2_short_name
	return base_name
end

function loadSetupFromFile(recording_slot_number, setup_name)
	local pathname = "addon/pechan_training_mod/db_lua/db/" .. emu.romname() .. "/" .. setup_name .. ".lua"
	print("Loading replay from: " .. pathname)
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
	if not subtable then return end -- do nothing if the key doesn't exist

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
		"addon/pechan_training_mod/db_lua/db/" .. rom .. "/savestates/" .. base .. ".fs"

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
		PECHAN_CONFIG.WAKEUP = setup.WAKEUP_CONFIG
	end
	if setup.GUARD_CONFIG ~= nil then
		PECHAN_CONFIG.GUARD = setup.GUARD_CONFIG
	end
	if setup.RECOVERY_CONFIG ~= nil then
		PECHAN_CONFIG.RECOVERY = setup.RECOVERY_CONFIG
	end
	if setup.wakeup then
		resetReversals(PECHAN_CONFIG.MOVES_VAR_NAMES, "WAKEUP")
		dumpTable(PECHAN_CONFIG.MOVES_VAR_NAMES["WAKEUP"])
		for i = 1, 5 do
			PECHAN_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["REC_" .. i] = setup.recording_var_states[i].value
			PECHAN_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_" .. i).propagates = setup.recording_var_states[i]
				.propagates
		end

		PECHAN_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
		formatGuiTables()
	end
	if setup.guard then
		resetReversals(PECHAN_CONFIG.MOVES_VAR_NAMES, "GUARD")
		dumpTable(PECHAN_CONFIG.MOVES_VAR_NAMES["GUARD"])
		for i = 1, 5 do
			PECHAN_CONFIG.MOVES_VAR_NAMES["GUARD"]["REC_" .. i] = setup.recording_var_states[i].value
			PECHAN_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_" .. i).propagates = setup.recording_var_states[i]
				.propagates
		end

		PECHAN_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
		formatGuiTables()
	end
	if setup.hit then
		resetReversals(PECHAN_CONFIG.MOVES_VAR_NAMES, "HIT")
		dumpTable(PECHAN_CONFIG.MOVES_VAR_NAMES["HIT"])
		for i = 1, 5 do
			if setup.recording_var_states[i] then
				PECHAN_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_" .. i] = setup.recording_var_states[i].value
				PECHAN_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_" .. i).propagates = setup.recording_var_states
					[i]
					.propagates
			end
		end

		PECHAN_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
		formatGuiTables()
	end
end

--[[*** end of General Functions ***]]
local function getFacingDirection()
	if DummyPlayer:isFacingLeft() then
		return "P" .. DummyPlayer.id .. " Left"
	end
	return "P" .. DummyPlayer.id .. " Right"
end
local function getBlockingDirection(player_id)
	if player_id == nil then
		player_id = DummyPlayer.id
	end

	if player_id == DummyPlayer.id then
		if DummyPlayer:isFacingLeft() then
			return "P" .. DummyPlayer.id .. " Right"
		end
		return "P" .. DummyPlayer.id .. " Left"
	elseif player_id == HumanPlayer.id then
		if HumanPlayer:isFacingLeft() then
			return "P" .. HumanPlayer.id .. " Right"
		end
		return "P" .. HumanPlayer.id .. " Left"
	end
end


local function transitionToState(newState)
	stateMachine.lastState = stateMachine.currentState
	-- Logic for transitioning to a new state
	stateMachine.currentState = newState
	if PECHAN_CONFIG.DEBUG.STATE == 1 then
		print("Transitioned to state:", newState)
	end

	-- Reset state-specific flags and counters
	delay_count = 0
	if newState == "start" or newState == "blocking" then
		stateMachine.active_wake_up = false
		one_hit_guard_triggered = false
		stateMachine.isJustGuardRunning = false
	end
end

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
		print("current iddle Time is: " .. (iddle_finish_time))
		if iddle_finish_time == 0 then
			iddle_time_running = false
			return true
		end
		iddle_finish_time = iddle_finish_time - 1
		return false
	end
	return true
end
local function startWakeupIddleTime()
	iddle_time_running = true
	iddle_finish_time = iddle_time
end
local function dummyCrouchGuard()
	local tbl = joypad.get()
	tbl[getBlockingDirection()] = 1
	tbl["P" .. DummyPlayer.id .. " Down"] = 1
	joypad.set(tbl)
end

local function dummyGuard()
	local tbl = joypad.get()
	tbl[getBlockingDirection()] = 1
	joypad.set(tbl)
end


local function delay(delay_frames, functionToExecute, ...)
	if delay_count < delay_frames then
		delay_count = delay_count + 1
		return true
	end

	local res = functionToExecute(...)
	if res == false then
		delay_count = 0
		return false
	end
	return true -- Return true if function is running or just finished? Actually, res is usually true if running.
end

local function doMove(move_name, times, conf)
	--[[if saveStateLoaded() then
		return false
	end--]]

	if stateMachine.last_do_move_name ~= move_name then
		current_move_time_counter = 0
		current_move_index_counter = 1
		current_sequence = {}
		stateMachine.last_do_move_name = move_name
	end

	if current_move_time_counter >= times then
		return false
	end
	if conf == nil then conf = false end

	local seq
	if conf == false then
		if (next(current_sequence) == nil) then
			current_sequence = getSequence(moves[move_name], sequence_reversal_type)
		end
		seq = current_sequence
	else
		seq = PECHAN_CONFIG.MOVES[move_name].sequence
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


	local tbl = joypad.get()
	local p_prefix = "P" .. DummyPlayer.id .. " "
	for _, value in ipairs(seq[current_move_index_counter]) do
		if value == 'forward' then
			tbl[getFacingDirection()] = 1
		elseif value == 'back' then
			tbl[getBlockingDirection()] = 1
		elseif value == 'down' then
			tbl[p_prefix .. "Down"] = 1
		elseif value == 'up' then
			tbl[p_prefix .. "Up"] = 1
		elseif value == 'a' then
			tbl[p_prefix .. "Button A"] = 1
		elseif value == 'b' then
			tbl[p_prefix .. "Button B"] = 1
		elseif value == 'c' then
			tbl[p_prefix .. "Button C"] = 1
		elseif value == 'd' then
			tbl[p_prefix .. "Button D"] = 1
		end
	end

	joypad.set(tbl)
	current_move_index_counter = current_move_index_counter + 1

	return true
end








local function getCurrentReversalMove(state)
	if (CURRENT_REVERSAL_MOVE_NAME) == nil then
		if state == "guard_reversal" then
			if PECHAN_CONFIG.GUARD.reversal == PECHAN_CONFIG.GUARD.REVERSAL_OPTIONS.RANDOM then
				CURRENT_REVERSAL_MOVE_NAME = PECHAN_CONFIG.GUARD.reversal_moves
					[math.random(1, #PECHAN_CONFIG.GUARD.reversal_moves)]
			else
				CURRENT_REVERSAL_MOVE_NAME = PECHAN_CONFIG.GUARD.reversal_moves[1]
			end
			sequence_reversal_type = reversal_types.GUARD
		elseif state == "waking_up" then
			if PECHAN_CONFIG.WAKEUP.reversal == PECHAN_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM then
				CURRENT_REVERSAL_MOVE_NAME = PECHAN_CONFIG.WAKEUP.reversal_moves
					[math.random(1, #PECHAN_CONFIG.WAKEUP.reversal_moves)]
			else
				CURRENT_REVERSAL_MOVE_NAME = PECHAN_CONFIG.WAKEUP.reversal_moves[1]
			end
			sequence_reversal_type = reversal_types.WAKEUP
		elseif state == "hit_reversal" then
			if PECHAN_CONFIG.HIT.reversal == PECHAN_CONFIG.HIT.REVERSAL_OPTIONS.RANDOM then
				CURRENT_REVERSAL_MOVE_NAME = PECHAN_CONFIG.HIT.reversal_moves
					[math.random(1, #PECHAN_CONFIG.HIT.reversal_moves)]
			else
				CURRENT_REVERSAL_MOVE_NAME = PECHAN_CONFIG.HIT.reversal_moves[1]
			end
			sequence_reversal_type = reversal_types.HIT
		end
	end
	return CURRENT_REVERSAL_MOVE_NAME
end

local function resetCurrentReversalName()
	CURRENT_REVERSAL_MOVE_NAME = nil
	sequence_reversal_type = nil
end
local function buildReversal(reversal_name)
	local _reversal = PECHAN_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(reversal_name)
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
local function dummyCrouch()
	local tbl = joypad.get()
	tbl["P" .. DummyPlayer.id .. " Down"] = 1
	joypad.set(tbl)
end

local function dummyCrouchGuard()
	local tbl = joypad.get()
	tbl[getBlockingDirection()] = 1
	tbl["P" .. DummyPlayer.id .. " Down"] = 1
	joypad.set(tbl)
end
local function humanCrouchGuard()
	local tbl = joypad.get()
	tbl[getBlockingDirection(PECHAN_CONFIG.PLAYERS.PLAYER1.ID)] = 1
	tbl["P1 Down"] = 1
	joypad.set(tbl)
end
-- Initial state


local function humanPressedButtons()
	local tbl = joypad.get()
	local buttonsPressed = false
	local h_prefix = "P" .. HumanPlayer.id .. " "

	if (tbl[h_prefix .. "Button A"] and not previousButtonState[h_prefix .. "Button A"]) or
		(tbl[h_prefix .. "Button B"] and not previousButtonState[h_prefix .. "Button B"]) or
		(tbl[h_prefix .. "Button C"] and not previousButtonState[h_prefix .. "Button C"]) or
		(tbl[h_prefix .. "Button D"] and not previousButtonState[h_prefix .. "Button D"]) then
		buttonsPressed = true
	end

	-- Update the previous button state for the next frame
	previousButtonState[h_prefix .. "Button A"] = tbl[h_prefix .. "Button A"]
	previousButtonState[h_prefix .. "Button B"] = tbl[h_prefix .. "Button B"]
	previousButtonState[h_prefix .. "Button C"] = tbl[h_prefix .. "Button C"]
	previousButtonState[h_prefix .. "Button D"] = tbl[h_prefix .. "Button D"]

	return buttonsPressed
end
local function dummyGuardForATime()
	if HumanPlayer:isActionExecuting() then
		return doMove('GUARD_BACK', 10, true)
	end
end
local function justGuard()
	return doMove("GUARD_BACK", 30, true)
end

local function dummyCrouchGuardForATime()
	return doMove('CROUCH_GUARD', 30, true)
end




local function executeWithCooldown(func, cooldownDuration, funcName)
	if not cooldowns[funcName] or cooldowns[funcName] == 0 then
		if not func() then
			-- The function returned false, indicating it has finished executing
			cooldowns[funcName] = cooldownDuration -- Set the cooldown
		else
			functionRunningFlags[funcName] = true -- Set the running flag
		end
	end
	if cooldowns[funcName] and cooldowns[funcName] > 0 then
		cooldowns[funcName] = cooldowns[funcName] - 1
		if (cooldowns[funcName]) == 0 then
			functionRunningFlags[funcName] = false -- Set the running flag
		end
	end
end





local function doNothing()
	--print('Doing nothing')
	return false
end
local function filterAct(act)
	if act == 21 or act == 22 or act == 23 or act == 24 or act == 25 or act == 79 or act == 14 or act == 2 or act == 48 or act == 49 or act == 1 or act == 0 or act == 6 or act == 45 or act == 46 or act == 47 or act == 3 or act == 4 or act == 5 or act == 15 or act == 16 or act == 7 or act == 8 or act == 9 or act == 10 or act == 11 or act == 12 or act == 13 or act == 17 or act == 18 or act == 19 or act == 20 then
		return 0x00
	end
	return act
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
		[24] = true,
		[25] = true,
		[45] = true,
		[46] = true,
		[47] = true,
		[48] = true,
		[49] = true,
		[50] = true,
		[79] = true
	}

	if invalidActs[act] then
		return 0x00
	end
	return act
end
local function p1MoveIsExecuting()
	local act = getP1ExecutingAction()
	if filterActOfBlocking(act) == 0x00 then
		return false
	end
	return true
end

local low_attack_act_codes = {
	[97] = true,
	[115] = true,
	[210] = true,
	[211] = true,
	[213] = true,
	[189] = true,
	[190] = true,
	[191] = true,
	[216] = true,
	[217] = true,
	[218] = true,
	[235] = true,
}

local list_of_char_ids_for_89 = {
	[0x00] = true, -- Kyo
	[0x07] = true, -- Robert
	[0x08] = true, -- Yuri
	[0x11] = true, -- King
	[0x18] = true, -- Yamazaki
	[0x1A] = true, -- Billy
	[0x1B] = true, -- Iori
	[0x1C] = true, -- Mature
	[0x25] = true, -- Shingo
}

local function shouldCrouchGuard(act_code)
	if low_attack_act_codes[act_code] then
		return true
	end

	local p1_char_id = rb(p1_stored_index_location)

	if act_code == 90 then
		if p1_char_id == 0x02 then -- Goro Daimon
			return true
		end
	end

	if act_code == 89 then
		if list_of_char_ids_for_89[p1_char_id] then
			return true
		end
	end

	return false
end


local function block()
	stateMachine.active_wake_up = false
	iddle_time_running = false
	delay_count = 0

	if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
		gui.text(10, 40, "DEBUG: block() cycle")
	end
	--TODO : add  a little prolongation of time to the block
	-- Additional logic for blocking.

	-- 1. Check Guard Mode. If OFF, return (Base Action handled in Start state, or just let it fall through)
	-- Actually, if we are in "blocking" state, we should probably output the Base Action if we are NOT actively blocking.
	if PECHAN_CONFIG.GUARD.guard_mode == PECHAN_CONFIG.GUARD.MODE_OPTIONS.OFF then
		if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
			gui.text(10, 50, tl("ui.debug.mode_off", "Mode: OFF"))
		end
		-- Should have transitioned to start, but if here safely:
		if PECHAN_CONFIG.GUARD.dummy_action == PECHAN_CONFIG.GUARD.ACTION_OPTIONS.CROUCHING then dummyCrouch() end
		return
	end

	-- 2. Check Guard Mode: ON
	if PECHAN_CONFIG.GUARD.guard_mode == PECHAN_CONFIG.GUARD.MODE_OPTIONS.ON then
		if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
			gui.text(10, 50, "Mode: ON")
		end
		-- ALWAYS GUARD
		-- Initial trigger: ONLY IF P1 IS EXECUTING OR P2 ENTERED BLOCKSTUN
		local isAttackTriggered = HumanPlayer:isActionExecuting() or playerTwoInBlockstun()

		if (isAttackTriggered) and not stateMachine.isJustGuardRunning then
			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 60, "Trigger: NEW")
			end
			stateMachine.isJustGuardRunning = true
			current_move_time_counter = 0
		end

		if isAttackTriggered and (stateMachine.last_do_move_name == "GUARD_BACK" or stateMachine.last_do_move_name == "CROUCH_GUARD") then
			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 60, "Trigger: SUSTAIN")
				gui.text(10, 103, "Guard: ON")
			end
			current_move_time_counter = 0 -- Sustain
			stateMachine.isJustGuardRunning = true
		end

		if stateMachine.isJustGuardRunning then
			if PECHAN_CONFIG.GUARD.dummy_action == PECHAN_CONFIG.GUARD.ACTION_OPTIONS.STANDING then -- Standing
				if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
					gui.text(10, 70, "Exec: Stand Guard")
				end
				stateMachine.isJustGuardRunning = justGuard()
			elseif PECHAN_CONFIG.GUARD.dummy_action == PECHAN_CONFIG.GUARD.ACTION_OPTIONS.CROUCHING then -- Crouching
				if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
					gui.text(10, 70, "Exec: Crouch Guard")
				end
				stateMachine.isJustGuardRunning = dummyCrouchGuardForATime()
			end
		else
			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 70, tl("ui.debug.exec_base_action", "Exec: Base Action"))
			end
			-- If not actively blocking (post-sustain or idle), enforce Base Action
			if PECHAN_CONFIG.GUARD.dummy_action == PECHAN_CONFIG.GUARD.ACTION_OPTIONS.CROUCHING then dummyCrouch() end
		end
		return
	end

	-- 3. Check Guard Mode: RANDOM (2)
	if PECHAN_CONFIG.GUARD.guard_mode == PECHAN_CONFIG.GUARD.MODE_OPTIONS.RANDOM then
		if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
			gui.text(10, 50, tl("ui.debug.mode_random", "Mode: RANDOM"))
		end
		local percentage_of_guard = 50

		-- Logic: If P2 Action is executing, we need to make a decision (if not made)
		-- OR if we already made a decision ("justGuard" or "doNothing" or "dummyCrouchGuard" etc)

		-- We used to have "stateMachine.chosenGuardOption". We need to map new options.
		-- Options: "Block" vs "NoBlock".
		-- If Block -> Execute Guard (Stand/Crouch based on dummy_action).
		-- If NoBlock -> Execute Base Action (Stand/Crouch based on dummy_action).

		if HumanPlayer:isActionExecuting() or playerTwoInBlockstun() or stateMachine.chosenGuardOption then
			-- INITIAL DECISION
			if not stateMachine.chosenGuardOption and (HumanPlayer:isActionExecuting() or playerTwoInBlockstun()) then
				local randomNumber = math.random(1, 100)
				if randomNumber <= percentage_of_guard then
					stateMachine.chosenGuardOption = "Block"
				else
					stateMachine.chosenGuardOption = "NoBlock"
				end
			end

			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 80, "Choice: " .. tostring(stateMachine.chosenGuardOption))
			end

			-- EXECUTION
			if stateMachine.chosenGuardOption == "NoBlock" then
				if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
					gui.text(10, 70, "Exec: NoBlock (Base)")
				end
				-- Execute Base Action
				if PECHAN_CONFIG.GUARD.dummy_action == 1 then dummyCrouch() end

				-- Release choice if action ends
				if not (HumanPlayer:isActionExecuting() or playerTwoInBlockstun()) then stateMachine.chosenGuardOption = nil end
			elseif stateMachine.chosenGuardOption == "Block" then
				-- Initialize Guard if needed
				if not stateMachine.isJustGuardRunning then
					current_move_time_counter = 0
					stateMachine.isJustGuardRunning = true
				end

				-- Execute Guard
				if stateMachine.isJustGuardRunning then
					if PECHAN_CONFIG.GUARD.dummy_action == 0 then -- Standing
						if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
							gui.text(10, 70, "Exec: Random Stand Guard")
						end
						stateMachine.isJustGuardRunning = justGuard()
					elseif PECHAN_CONFIG.GUARD.dummy_action == 1 then -- Crouching
						if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
							gui.text(10, 70, "Exec: Random Crouch Guard")
						end
						stateMachine.isJustGuardRunning = dummyCrouchGuardForATime()
					end
				end

				-- Release choice if guard finished
				if not stateMachine.isJustGuardRunning then
					stateMachine.chosenGuardOption = nil
				end
			end
		else
			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 80, "Choice: NONE")
			end
			-- Reset
			if not stateMachine.isJustGuardRunning then
				stateMachine.chosenGuardOption = nil
				if PECHAN_CONFIG.GUARD.dummy_action == 1 then dummyCrouch() end
			end
		end
		return
	end

	-- 4. Check Guard Mode: ALL GUARD (3)
	if PECHAN_CONFIG.GUARD.guard_mode == PECHAN_CONFIG.GUARD.MODE_OPTIONS.ALL_GUARD then
		if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
			gui.text(10, 50, tl("ui.debug.mode_all_guard", "Mode: ALL GUARD"))
		end
		-- DYNAMIC STANCE SWITCHING
		local p1_act = getP1ExecutingAction()
		local needs_crouch = shouldCrouchGuard(p1_act)

		if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
			gui.text(10, 90,
				tl("ui.debug.stance",
					{ stance = (needs_crouch and tl("ui.debug.stance_low", "LOW") or tl("ui.debug.stance_high", "HIGH")) }))
		end

		-- Initial trigger
		local isAttackTriggered = HumanPlayer:isActionExecuting() or playerTwoInBlockstun()
		if isAttackTriggered and not stateMachine.isJustGuardRunning then
			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 60, tl("ui.debug.trigger_new_ag", "Trigger: NEW (AG)"))
			end
			stateMachine.isJustGuardRunning = true
			current_move_time_counter = 0
		end

		if isAttackTriggered and (stateMachine.last_do_move_name == "GUARD_BACK" or stateMachine.last_do_move_name == "CROUCH_GUARD") then
			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 60, "Trigger: SUSTAIN (AG)")
				gui.text(10, 103, "All Guard: ACTIVE")
			end
			current_move_time_counter = 0 -- Sustain
		end

		if stateMachine.isJustGuardRunning then
			if needs_crouch then
				if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
					gui.text(10, 70, "Exec: AG Crouch Guard")
				end
				stateMachine.isJustGuardRunning = dummyCrouchGuardForATime()
			else
				if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
					gui.text(10, 70, "Exec: AG Stand Guard")
				end
				stateMachine.isJustGuardRunning = justGuard()
			end
		else
			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 70, "Exec: AG Base Action")
			end
			-- Post-block or idle: Return to default Action stance
			if PECHAN_CONFIG.GUARD.dummy_action == 1 then dummyCrouch() end
		end
		return
	end
	gui.text(10, 150, "block is still being executed")
	-- 5. Check Guard Mode: 1 HIT GUARD (4)
	if PECHAN_CONFIG.GUARD.guard_mode == PECHAN_CONFIG.GUARD.MODE_OPTIONS.ONE_HIT_GUARD then
		if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
			gui.text(10, 50, tl("ui.debug.mode_1hit_guard", "Mode: 1 HIT GUARD"))
		end

		-- Use hitstun counter for more reliable detection
		local hitstun = p2CurrentHitstun()
		local wasHit = hitstun > 0
		local isBlocking = playerTwoInBlockstun()
		local isAttackTriggered = HumanPlayer:isActionExecuting() or isBlocking

		if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
			gui.text(10, 110, "Hitstun: " .. hitstun .. " Trig:" .. tostring(one_hit_guard_triggered))
		end

		-- STATE 1: IDLE (waiting for hit)
		if not one_hit_guard_triggered then
			if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
				gui.text(10, 60, "IDLE - waiting for hit")
			end
			-- Do base action while waiting
			-- Do base action while waiting
			-- if PECHAN_CONFIG.GUARD.dummy_action == 1 then dummyCrouch() end

			-- Detect hit → arm the guard
			if wasHit then
				one_hit_guard_triggered = true
			else
				transitionToState("start")
			end
			return
		end

		-- STATE 2: GUARDING (after being hit)
		if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
			gui.text(10, 60, tl("ui.debug.guarding", "GUARDING"))
		end

		-- Start guard immediately when triggered
		if not stateMachine.isJustGuardRunning then
			stateMachine.isJustGuardRunning = true
			current_move_time_counter = 0
		end

		-- Sustain guard while under attack or just entered guard state
		if isAttackTriggered and (stateMachine.last_do_move_name == "GUARD_BACK" or stateMachine.last_do_move_name == "CROUCH_GUARD") then
			current_move_time_counter = 0
		end

		-- Execute guard
		if stateMachine.isJustGuardRunning then
			if PECHAN_CONFIG.GUARD.dummy_action == 0 then
				if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
					gui.text(10, 70, "Exec: Stand Guard")
				end
				stateMachine.isJustGuardRunning = justGuard()
			elseif PECHAN_CONFIG.GUARD.dummy_action == 1 then
				if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
					gui.text(10, 70, "Exec: Crouch Guard")
				end
				stateMachine.isJustGuardRunning = dummyCrouchGuardForATime()
			end
		else
			-- Guard finished → return to IDLE only when both not attacking and not being hit
			if not isAttackTriggered and not wasHit then
				one_hit_guard_triggered = false
				if PECHAN_CONFIG.DEBUG.BLOCK == 1 then
					gui.text(10, 70, "Returning to IDLE")
				end
				transitionToState("start")
			else
				-- Still under pressure, restart guard
				stateMachine.isJustGuardRunning = true
				current_move_time_counter = 0
			end
			-- if PECHAN_CONFIG.GUARD.dummy_action == 1 then dummyCrouch() end
		end
		return
	end
end


local function isOnWakeUp()
	--gui.text(10, 80, "WakeUp: " .. rw(dummy_air_height_address))
	local current_game = PECHAN_CONFIG.get_current_game()
	local air_height_offset = current_game.offsets.air_height
	local dummy_air_height_address = DummyPlayer.base_address + air_height_offset
	local dummy_is_in_air = (rw(dummy_air_height_address) > 0) and rb(DummyPlayer.addresses.hitstatus) == 1
	return dummy_is_in_air
end
local function closeToGround()
	local current_game = PECHAN_CONFIG.get_current_game()
	local air_height_offset = current_game.offsets.air_height
	local dummy_air_height_address = DummyPlayer.base_address + air_height_offset
	return rw(dummy_air_height_address) < 20000 and (rw(dummy_air_height_address) > 0)
end

local function isWakeUpTime()
	if DummyPlayer:getRawActionByte() == 52 then
		stateMachine.is_a_soft_reset = true
		return true
	elseif stateMachine.is_a_soft_reset then
		return true
	else
		local current_game = PECHAN_CONFIG.get_current_game()
		local air_height_offset = current_game.offsets.air_height
		local dummy_air_height_address = DummyPlayer.base_address + air_height_offset
		if rb(dummy_air_height_address) == 0 then
			return true
		end
		return false
	end
end


-- Function to set default configuration based on configName
function setDefaultConfig(configName)
	if configName == "safe_jump_training" then
		PECHAN_CONFIG.WAKEUP.dummy_waking_up     = true
		PECHAN_CONFIG.WAKEUP.reversal            = PECHAN_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		PECHAN_CONFIG.RECOVERY.dummy_recovering  = true
		PECHAN_CONFIG.RECOVERY.recovery          = PECHAN_CONFIG.RECOVERY.OPTIONS.ON
		PECHAN_CONFIG.RECOVERY.delay             = 25
		PECHAN_CONFIG.RECOVERY.times             = 3
		local move_name                          = "DPC"
		local current_reversal_move              = PECHAN_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay   = 0
		current_reversal_move.on_wake_up_times   = 1
		PECHAN_CONFIG.MOVES_VAR_NAMES[move_name] = PECHAN_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name                          = "C_GUARD"
		local current_reversal_move              = PECHAN_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay   = 0
		current_reversal_move.on_wake_up_times   = 8
		PECHAN_CONFIG.MOVES_VAR_NAMES[move_name] = PECHAN_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		PECHAN_CONFIG.MOVES_VAR_NAMES["DOWN_C"]  = PECHAN_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD
		PECHAN_CONFIG.WAKEUP.reversal_moves      = PECHAN_CONFIG.REVERSAL_MOVES.getCurrentReversalMoves("WAKEUP")
		-- Set other options as needed for "safe_jump_training" configuration
	elseif configName == "aggressive_training" then
		PECHAN_CONFIG.GUARD.reversal = PECHAN_CONFIG.GUARD.REVERSAL_OPTIONS.ON
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
	if PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.NEVER then
		wb(guard_break_location, 0x67)
	elseif PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.ALWAYS then
		wb(guard_break_location, 0x00)
	end
end

local function enableCPU()
	local cpu_location = DummyPlayer.base_address + 0x170
	wb(cpu_location, 0x81)
end

local function disableCPU()
	local cpu_location = DummyPlayer.base_address + 0x170
	wb(cpu_location, 0x01)
end

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

	if bool == nil then
		recording.playback = not recording.playback
	else
		recording.playback = bool
	end

	if not recording.replayP1 and not recording.replayP2 then
		recording.replayP2 = true
	end

	if not recording.playback then
		recordslot.framestart = nil
	else
		recording.playbackslot = _playbackslot

		if recording.replayP1 and recording.replayP2 then
			recordslot.start = recordslot.p1start
			if (recordslot.start == nil and recordslot.p2start ~= nil) or (recordslot.start > recordslot.p2start) then
				recordslot.start =
					recordslot.p2start
			end
		elseif recording.replayP1 then
			toggleSwapInputs(true)
			recordslot.start = recordslot.p1start
		else
			recordslot.start = recordslot.p2start
		end
		if recordslot.start == recordslot.finish then
			toggleSwapInputs(false)
			return
		end                  -- nothing recorded

		recording.startcounter = 0 -- randomise starting playback
		if recording.maxstarttime == 0 then
			recording.starttime = 0
		else
			recording.starttime = math.random(recording.maxstarttime + 1) - 1 -- [0,maxstarttime]
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
		file:close()        -- Close the file after checking for existence
		savestate.load(file_path) -- Load the machine state
		print("Machine state loaded from: " .. file_path)
	else
		print("Error: Save file not found at " .. file_path)
	end
end

Character = {}
Character.__index = Character

function Character:new(name, screen_address, screen_position_address, action_base_address, action_sequence_address)
	local obj = {
		name = name,
		screen_address = screen_address,
		screen_position_address = screen_position_address,
		action_base_address = action_base_address,
		action_sequence_address = action_sequence_address,
		screen_index = 0,    -- Placeholder
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
	self:_calculate_indexes() -- Ensure indexes are updated
	other:_calculate_indexes()

	local screen_diff = (other.screen_index - self.screen_index) * 256
	local position_diff = other.screen_position_index - self.screen_position_index

	return math.abs(screen_diff + position_diff)
end

function Character:is_short_jumping()
	self:calculate_actions() -- Update action values before checking
	return self.action_base == 0 and self.action_sequence == 17
end

function Character:is_short_jumping_close_to(other)
	return self:is_short_jumping() and self:is_close_to(other)
end

local char1_screen_address = 0x108118
local char2_screen_address = 0x108318
local char1_name = "P1"
local char2_name = "P2"
local char1_screen_position_address = 0x108119
local char2_screen_position_address = 0x108319

-- Example usage:
local char1 = Character:new(char1_name, char1_screen_address, char1_screen_position_address, P1.addresses.hitstatus,
	P1.addresses.hitstatus + 1)
local char2 = Character:new(char2_name, char2_screen_address, char2_screen_position_address, P2.addresses.hitstatus,
	P2.addresses.hitstatus + 1)

local function draw_distance_status(character1, character2)
	local is_close = character1:is_close_to(character2)
	local text = is_close and "close" or "far"
	local color = is_close and "red" or "cyan"

	if PECHAN_CONFIG.DEBUG.DISTANCE == 1 then
		gui.text(170, 40, text, color, "black")
	end
end
local function draw_action_code(character, x, y)
	character:calculate_actions() -- Ensure values are updated before drawing
	if PECHAN_CONFIG.DEBUG.ACTION == 1 then
		gui.text(x, y, character.name .. " action: " .. character.action_base .. "-" .. character.action_sequence,
			"white",
			"black")
	end
end

local draw_screen_position = function(character, x, y)
	character:calculate_actions() -- Ensure values are updated before drawing
	if PECHAN_CONFIG.DEBUG.POSITION == 1 then
		gui.text(x, y, character.name .. " screen pos: " .. character:get_screen_position(), "white", "black")
	end
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
	if PECHAN_CONFIG.DEBUG.STUN == 1 then
		gui.text(x, y, " stun: " .. stun .. " (" .. decreased_stun .. ")", "yellow")
	end
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
	if PECHAN_CONFIG.DEBUG.GUARD == 1 then
		gui.text(x, y, " guard: " .. guard .. " (" .. decreased_guard .. ")", "cyan")
	end
end
local function p1NewActCodeRunningStarted()
	return p1_entered_new_action
end

local function startCountingActionFrames()
	action_frame_count = 0 -- Should use the counter variable
end

local function startCountingBlockstunFrames()
	blockstun_frame_count = 0
end

local function draw_frame_advantage()
	if p1NewActCodeRunningStarted() then
		startCountingActionFrames()
		startCountingBlockstunFrames()
	end
	if P1ActCodeRunning() and playerTwoInBlockstun() then
		blockstun_frame_count = getLastBlockstunDuration()
		action_frame_count = getLastActionDuration()
		return
	end
	p1_frame_advantage = action_frame_count - blockstun_frame_count
	local x = 20
	local y = 40
	local color = ""
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



	if PECHAN_CONFIG.DEBUG.ADVANTAGE == 1 then
		gui.text(x, y, "adv: " .. p1_frame_advantage, color)
		gui.text(x, y + 10, "act d: " .. action_frame_count, color)
		gui.text(x, y + 20, "blck d: " .. blockstun_frame_count, color)
	end
end

local function draw_player_advantage(player, x, y)
	if player.advantage_state.measuring or player.advantage_state.frame_advantage ~= 0 then
		if PECHAN_CONFIG.DEBUG.ADVANTAGE == 1 then
			local color = "yellow"
			if player.advantage_state.frame_advantage > 0 then
				color = "green"
			elseif player.advantage_state.frame_advantage < 0 then
				color = "red"
			end
			local label = (player.advantage_state.adv_type == "Block") and ("P" .. player.id .. " Block Adv: ") or
				("P" .. player.id .. " Hit Adv: ")
			gui.text(x, y, label .. player.advantage_state.frame_advantage, color)
		end
	end
end

local function draw_debug_info()
	draw_action_code(char1, 30, 180)
	draw_action_code(char2, 170, 180)
	draw_screen_position(char1, 30, 190)
	draw_screen_position(char2, 170, 190)
	draw_distance_status(char1, char2)
	draw_stun_status(char1, char2)
	draw_guard_status(char1, char2)
	--draw_frame_advantage()

	-- Draw new dynamic advantages
	draw_player_advantage(P1, 20, 60)
	draw_player_advantage(P2, 170, 60)

	if PECHAN_CONFIG.DEBUG.METER == 1 then
		gui.text(170, 170, "P1 meter: " .. rb(0x1081e8), "white", "black")
	end
end
local initial_distance = nil
local frame_counter = 0
local near_jump_os_action_active = false

local function check_jump_approaching(char1, char2)
	local current_distance = char1:get_distance_to(char2)

	if frame_counter == 0 and char1:is_short_jumping_close_to(char2) and not near_jump_os_action_active then
		initial_distance = current_distance
		frame_counter = 1 -- Start counting frames
	elseif frame_counter > 0 then
		frame_counter = frame_counter + 1

		if frame_counter >= 10 then
			frame_counter = 0 -- Reset after checking
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


local PECHAN_CONFIG_throw_os_on_jump = false

-- Export to frame_data
_G.get_p1_advantage_state = function() return P1.advantage_state end
_G.get_p2_advantage_state = function() return P2.advantage_state end

local percentage_of_recovery = 50
local chosenRecoveryOption = nil -- nil = no decision ye
local function recover(callback)
	if PECHAN_CONFIG.RECOVERY.recovery == PECHAN_CONFIG.RECOVERY.OPTIONS.RANDOM then
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
			delay(30, function()
				chosenRecoveryOption = nil
				callback()
				return false
			end)
		elseif chosenRecoveryOption == "recoveryRoll" then
			delay(PECHAN_CONFIG.RECOVERY.delay, function()
				local res = doMove("AB", PECHAN_CONFIG.RECOVERY.times, true)
				if res == false then
					chosenRecoveryOption = nil
					callback()
					return false
				end

				return true
			end)
		end
	elseif PECHAN_CONFIG.RECOVERY.recovery == PECHAN_CONFIG.RECOVERY.OPTIONS.ON then
		delay(PECHAN_CONFIG.RECOVERY.delay, function()
			local res = doMove("AB", PECHAN_CONFIG.RECOVERY.times, true)
			if res == false then
				chosenRecoveryOption = nil
				callback()
				return false
			end

			return true
		end)
	end
	return true
end


-- WakeUp Event Manager Logic
local function updateWakeUpEventStatus(ctx)
	local is_now_waking_up = isOnWakeUp()

	-- Rising Edge: Event started, reset handled flag
	if is_now_waking_up and not ctx.wakeUpEvent.active then
		ctx.wakeUpEvent.handled = false
	end

	-- Falling Edge: Event ended, reset handled flag
	if not is_now_waking_up and ctx.wakeUpEvent.active then
		ctx.wakeUpEvent.handled = false
	end

	ctx.wakeUpEvent.active = is_now_waking_up
end

local function shouldTriggerWakeUpAction(ctx, propagate)
	if not ctx.wakeUpEvent.active then return false end

	-- If we handled this event and we are NOT propagating, don't trigger.
	if ctx.wakeUpEvent.handled and not propagate then
		return false
	end

	return true
end

local function consumeWakeUpEvent(ctx)
	ctx.wakeUpEvent.handled = true
end

local StateHandlers = {}

function StateHandlers.start(ctx)
	-- RESET / INTERRUPT
	if DummyPlayer:isBeingHit() then
		iddle_time_running = false
		iddle_finish_time = 0
		stateMachine.active_wake_up = false
	end

	-- 1. CPU ACTIONS
	if PECHAN_CONFIG.CPU.dummy_can_fight or stateMachine.current_cpu_action_running then
		if PECHAN_CONFIG.CPU.GCCD.dummy_can_gccd and playerTwoInBlockstun() then
			if not stateMachine.gccd_random_move_ends then
				stateMachine.gccd_action_running = true
				disableCPU()
				PECHAN_CONFIG.CPU.dummy_can_fight = false
				transitionToState("cpu_action")
				return
			end
		else
			stateMachine.gccd_random_move_ends = false
		end

		if PECHAN_CONFIG.CPU.GCAB.dummy_can_gcab and dummyIsFalling() then
			if not stateMachine.gcab_random_move_ends then
				stateMachine.gcab_action_running = true
				disableCPU()
				PECHAN_CONFIG.CPU.dummy_can_fight = false
				transitionToState("cpu_action")
				return
			end
		else
			stateMachine.gcab_random_move_ends = false
		end
	end

	-- 2. RECOVERY
	if PECHAN_CONFIG.RECOVERY.dummy_recovering then
		-- propagate=false: Trigger only once per wakeup event
		if shouldTriggerWakeUpAction(ctx, false) then
			consumeWakeUpEvent(ctx)
			transitionToState("recovering")
			return
		end
	end
	-- 3. HIT REVERSAL CHECK
	local dummy_is_hit = DummyPlayer:isBeingHit()
	if stateMachine.dummy_was_in_hitstun and not dummy_is_hit and not dummyIsFalling() and not isOnWakeUp() then
		if PECHAN_CONFIG.HIT.reversal ~= PECHAN_CONFIG.HIT.REVERSAL_OPTIONS.OFF then
			transitionToState("hit_reversal")
			stateMachine.dummy_was_in_hitstun = false
			return
		end
	end
	stateMachine.dummy_was_in_hitstun = dummy_is_hit

	-- 4. WAKEUP
	if PECHAN_CONFIG.WAKEUP.dummy_waking_up and wakeUpEnabled() then
		-- propagate=false: Trigger only once per wakeup event
		if shouldTriggerWakeUpAction(ctx, false) and stateMachine.active_wake_up == false then
			consumeWakeUpEvent(ctx)
			stateMachine.active_wake_up = true
			transitionToState("waking_up")
			return
		end
	end

	if PECHAN_CONFIG.GUARD.guard_mode > PECHAN_CONFIG.GUARD.MODE_OPTIONS.OFF and not isOnWakeUp() and not stateMachine.active_wake_up then
		if PECHAN_CONFIG.GUARD.guard_mode == PECHAN_CONFIG.GUARD.MODE_OPTIONS.ONE_HIT_GUARD then
			if DummyPlayer:isBeingHit() then
				transitionToState("blocking")
				return
			end
		else
			transitionToState("blocking")
			return
		end
	end

	-- 5. HIT REVERSAL TRIGGER
	-- ... (comments) ...

	-- Safety Reset for Wakeup Flag
	if not isOnWakeUp() and stateMachine.active_wake_up then
		stateMachine.active_wake_up = false
	end

	-- Strategy: Track 'wasHit' in previous frame.
	-- Logic: If we were being hit, and now we are not, and we are not falling, trigger Hit Reversal.
	-- (Basic implementation: Rely on hitstun transition logic if feasible, or check hit status edge detection)
	-- Actually, detecting the transition from "Being Hit" to "Neutral/Action" is best done by tracking state.
	-- But for simplicity, we can do it by checking if we ARE recovering from a hit?
	-- Or we can trust the 'p2CurrentHitstun()' logic?

	-- Let's use a simple edge detector for now or reuse existing state checks.
	-- If we are in 'start' and just finished being hit?

	-- Better approach:
	local hitstun = p2CurrentHitstun()
	-- If hitstun just became 0, we finished being hit.
	-- But p2CurrentHitstun() resets to 0 when not being hit.
	-- We need a frame-by-frame tracker for this.

	-- Let's assume the user wants it "like guard or wakeup".
	-- Guard reversal triggers when blockstun ends? No, it triggers while in blockstun?
	-- "guard_reversal": "if playerTwoInBlockstun() ... transitionToState('guard_reversal')".
	-- Then in guard_reversal, it waits or executes.
	-- For HIT, we can't do it WHILE being hit (usually), unless it's a "break" (like burst).
	-- Assuming "Reversal" means "After Hitstun Ends".

	-- Strategy: Track 'wasHit' in previous frame.
	if PECHAN_CONFIG.HIT.reversal ~= PECHAN_CONFIG.HIT.REVERSAL_OPTIONS.OFF then
		-- We need to know if we just recovered from a hit.
		-- Using a global variable for tracking previous hit state might be cleanest.
	end

	-- STANCE
	if PECHAN_CONFIG.GUARD.dummy_action == 1 then
		dummyCrouch()
	end
end

function StateHandlers.blocking(ctx)
	if dummyIsFalling() or isOnWakeUp() then
		transitionToState("start")
		return
	end

	if playerTwoInBlockstun() and PECHAN_CONFIG.GUARD.reversal ~= PECHAN_CONFIG.GUARD.REVERSAL_OPTIONS.OFF then
		transitionToState("guard_reversal")
		return
	end

	block()
end

function StateHandlers.waking_up(ctx)
	if (isWakeUpTime() and stateMachine.active_wake_up == true and wakeUpEnabled()) then
		stateMachine.dont_recover = true
		local reversal_name = getCurrentReversalMove("waking_up")
		local reversal = buildReversal(reversal_name)

		if isRecording(reversal_name) then
			if (not reversal.propagates) and recording.playback then
				transitionToState("start")
				stateMachine.active_wake_up = true -- Prevent immediate re-entry loop
				return
			end
			if recording.loop then return end

			local _recording = recording.recordingslot
			recording.recordingslot = moves[reversal_name].index
			kofTogglePlayBack(true, {})
			recording.recordingslot = _recording

			startWakeupIddleTime()
			stateMachine.active_wake_up = false
			stateMachine.isJustGuardRunning = false
			stateMachine.chosenGuardOption = nil
			stateMachine.last_do_move_name = nil
			resetCurrentReversalName()
			stateMachine.active_wake_up = false
			stateMachine.isJustGuardRunning = false
			stateMachine.chosenGuardOption = nil
			stateMachine.last_do_move_name = nil
			stateMachine.is_a_soft_reset = false
			transitionToState("start")
			return
		else
			delay(reversal.on_wake_up_delay, function()
				local res = doReversal(reversal.name, reversal.on_wake_up_times)
				if res == false then
					startWakeupIddleTime()
					stateMachine.active_wake_up = false
					stateMachine.isJustGuardRunning = false
					stateMachine.chosenGuardOption = nil
					stateMachine.last_do_move_name = nil
					stateMachine.is_a_soft_reset = false
					resetCurrentReversalName()
					transitionToState("start")
				end
				return res
			end)
		end
	end
end

function StateHandlers.guard_reversal(ctx)
	if DummyPlayer:isBeingHit() or dummyIsFalling() or isOnWakeUp() then
		transitionToState("start")
		return
	end

	local reversal_name = getCurrentReversalMove("guard_reversal")
	local reversal = buildReversal(reversal_name)

	if isRecording(reversal_name) then
		if (not reversal.propagates) and recording.playback then
			transitionToState("blocking")
			return
		end
		if recording.loop then return end

		local _recording = recording.recordingslot
		recording.recordingslot = moves[reversal_name].index
		kofTogglePlayBack(true, {})
		recording.recordingslot = _recording

		startWakeupIddleTime()
		resetCurrentReversalName()
		transitionToState("blocking")
	else
		delay(reversal.on_guard_delay, function()
			local res = doReversal(reversal.name, reversal.on_guard_times)
			if res == false then
				stateMachine.isJustGuardRunning = false
				stateMachine.chosenGuardOption = nil
				stateMachine.last_do_move_name = nil
				startWakeupIddleTime()
				transitionToState("blocking")
			end
			return res
		end)
	end
end

function StateHandlers.hit_reversal(ctx)
	if DummyPlayer:isBeingHit() or dummyIsFalling() or isOnWakeUp() then
		transitionToState("start")
		return
	end

	local reversal_name = getCurrentReversalMove("hit_reversal")
	local reversal = buildReversal(reversal_name)

	if isRecording(reversal_name) then
		if (not reversal.propagates) and recording.playback then
			transitionToState("start")
			return
		end
		if recording.loop then return end

		local _recording = recording.recordingslot
		recording.recordingslot = moves[reversal_name].index
		kofTogglePlayBack(true, {})
		recording.recordingslot = _recording

		startWakeupIddleTime()
		resetCurrentReversalName()
		transitionToState("start")
	else
		local d = reversal.on_hit_delay or reversal.on_guard_delay or 0
		local t = reversal.on_hit_times or reversal.on_guard_times or 1

		delay(d, function()
			local res = doReversal(reversal.name, t)
			if res == false then
				-- Finished
				stateMachine.isJustGuardRunning = false
				stateMachine.chosenGuardOption = nil
				stateMachine.last_do_move_name = nil
				startWakeupIddleTime()
				transitionToState("start") -- Return to start
			end
			return res
		end)
	end
end

function StateHandlers.recovering(ctx)
	recover(function()
		stateMachine.dont_recover = true
		if PECHAN_CONFIG.WAKEUP.dummy_waking_up then
			stateMachine.active_wake_up = true
			transitionToState("waking_up")
		elseif PECHAN_CONFIG.GUARD.guard_mode > 0 then
			stateMachine.isJustGuardRunning = false
			stateMachine.chosenGuardOption = nil
			stateMachine.last_do_move_name = nil
			transitionToState("blocking")
		else
			stateMachine.isJustGuardRunning = false
			stateMachine.chosenGuardOption = nil
			stateMachine.last_do_move_name = nil
			transitionToState("start")
		end
	end)
end

function StateHandlers.cpu_action(ctx)
	if PECHAN_CONFIG.CPU.GCCD.dummy_can_gccd and stateMachine.gccd_action_running then
		if PECHAN_CONFIG.CPU.GCCD.current_gccd == PECHAN_CONFIG.CPU.GCCD.OPTIONS.ON then
			if doMove("CD", 3, true) == false then
				enableCPU()
				stateMachine.current_cpu_action_running = false
				stateMachine.gccd_action_running = false
				PECHAN_CONFIG.CPU.dummy_can_fight = true
				transitionToState("start")
			end
		elseif PECHAN_CONFIG.CPU.GCCD.current_gccd == PECHAN_CONFIG.CPU.GCCD.OPTIONS.RANDOM and not stateMachine.gccd_random_move_ends then
			if stateMachine.running_randomned_cpu_action_gccd then
				if doMove("CD", 3, true) == false then
					enableCPU()
					stateMachine.gccd_random_move_ends = true
					stateMachine.running_randomned_cpu_action_gccd = false
					stateMachine.current_cpu_action_running = false
					PECHAN_CONFIG.CPU.dummy_can_fight = true
					transitionToState("start")
				end
			else
				if math.random(1, 100) <= 30 then
					stateMachine.running_randomned_cpu_action_gccd = true
				else
					stateMachine.gccd_random_move_ends = true
					enableCPU()
					PECHAN_CONFIG.CPU.dummy_can_fight = true
					stateMachine.current_cpu_action_running = false
					transitionToState("start")
				end
			end
		end
	end

	if PECHAN_CONFIG.CPU.GCAB.dummy_can_gcab and stateMachine.gcab_action_running then
		if PECHAN_CONFIG.CPU.GCAB.current_gcab == PECHAN_CONFIG.CPU.GCAB.OPTIONS.ON then
			if doMove("AB", 5, true) == false then
				enableCPU()
				PECHAN_CONFIG.CPU.dummy_can_fight = true
				stateMachine.current_cpu_action_running = false
				stateMachine.gcab_action_running = false
				transitionToState("start")
			end
		elseif PECHAN_CONFIG.CPU.GCAB.current_gcab == PECHAN_CONFIG.CPU.GCAB.OPTIONS.RANDOM and not stateMachine.gcab_random_move_ends then
			if stateMachine.running_randomned_cpu_action_gcab then
				if doMove("AB", 5, true) == false then
					enableCPU()
					stateMachine.gcab_random_move_ends = true
					stateMachine.running_randomned_cpu_action_gcab = false
					PECHAN_CONFIG.CPU.dummy_can_fight = true
					stateMachine.current_cpu_action_running = false
					transitionToState("start")
				end
			else
				if math.random(1, 100) <= 30 then
					stateMachine.running_randomned_cpu_action_gcab = true
				else
					stateMachine.gccd_random_move_ends = true
					enableCPU()
					PECHAN_CONFIG.CPU.dummy_can_fight = true
					stateMachine.current_cpu_action_running = false
					transitionToState("start")
				end
			end
		end
	end
end

function KofTrainingRun() -- runs every frame
	--wb(0x02FD3A, 0x68)

	updateWakeUpEventStatus(stateMachine)


	--gui.text(20, 30, "block address: " .. rb(P2.addresses.blockstun), "yellow")
	--justGuard()
	--108318 - 108319 Dummy stage position from 0020 (left corner) to 02e0  (right corner)
	if PECHAN_CONFIG.DEBUG.POSITION == 1 then
		gui.text(20, 80, "dummy position: " .. stateMachine.dummy_position, "yellow")
	end
	if PECHAN_CONFIG.GUARD.dummy_guarding then
		if PECHAN_CONFIG.DEBUG.GUARD == 1 then
			gui.text(20, 100, "dummy guarding", "yellow")
		end
		if DummyPlayer:getRawActionByte() == 2 or DummyPlayer:getRawActionByte() == 1 or DummyPlayer:getRawActionByte() == 46 or DummyPlayer:getRawActionByte() == 47 or DummyPlayer:getRawActionByte() == 48 or DummyPlayer:getRawActionByte() == 49 or DummyPlayer:getRawActionByte() == 50 then
			stateMachine.dummy_position = rw(0x108318)
			if DummyPlayer:isFacingLeft() then
				ww(0x108318, stateMachine.dummy_position)
			else
				ww(0x108318, stateMachine.dummy_position)
			end
			DummyPlayer:setAction(0)
		end
	end

	if rom_name == "kof98" then
		AI.update()
		Trials.check_conditions()
		Cinematics.update()
		Cinematics.draw()
	end

	P1:updateAdvantage(P2)
	P2:updateAdvantage(P1)
	draw_debug_info()

	if emu.romname and (emu.romname() == "kof99" or emu.romname() == "kof2000" or emu.romname() == "kof2001") then
		local inf_striker_val = (emu.romname() == "kof2001") and 0x04 or 0x05
		if PECHAN_CONFIG.UI.APPLIED.INFINITE_STRIKERS then
			if PECHAN_CONFIG.UI.APPLIED.INFINITE_STRIKERS == 1 or PECHAN_CONFIG.UI.APPLIED.INFINITE_STRIKERS == 3 then
				if p1_striker_count_location then wb(p1_striker_count_location, inf_striker_val) end
			end
			if PECHAN_CONFIG.UI.APPLIED.INFINITE_STRIKERS == 2 or PECHAN_CONFIG.UI.APPLIED.INFINITE_STRIKERS == 3 then
				if p2_striker_count_location then wb(p2_striker_count_location, inf_striker_val) end
			end
		end
	end



	if emu.romname and emu.romname() == "kof2002" then
		-- KOF 2002 EXCEPTION: continuously enforce EX flags while active, as the engine clears active RAM
		if PECHAN_CONFIG.UI.APPLIED.PLAYER1_EX then
			local p1_ex_addr = PECHAN_CONFIG.get_current_game().offsets.p1_ex_address
			local p1_color_addr = PECHAN_CONFIG.get_current_game().offsets.p1_color_address
			local ex_val = PECHAN_CONFIG.get_current_game().offsets.ex_value or 0x01
			if p1_ex_addr then wb(p1_ex_addr, ex_val) end
			if p1_color_addr then wb(p1_color_addr, 0x02) end
		end

		if PECHAN_CONFIG.UI.APPLIED.PLAYER2_EX then
			local p2_ex_addr = PECHAN_CONFIG.get_current_game().offsets.p2_ex_address
			local p2_color_addr = PECHAN_CONFIG.get_current_game().offsets.p2_color_address
			local ex_val = PECHAN_CONFIG.get_current_game().offsets.ex_value or 0x01
			if p2_ex_addr then wb(p2_ex_addr, ex_val) end
			if p2_color_addr then wb(p2_color_addr, 0x02) end
		end
	end

	-- Striker mode debug removed
	-- if emu.romname and emu.romname() == "kof2000" then
	-- 	gui.text(10, 160, string.format("P1 Mode (10A80A): %02X", rb(0x10A80A)), "yellow")
	-- 	gui.text(10, 170, string.format("P2 Mode (10A81F): %02X", rb(0x10A81F)), "cyan")
	-- end



	if PECHAN_CONFIG_throw_os_on_jump or PECHAN_CONFIG.CPU.THROW_OS_ON_JUMP then
		check_jump_approaching(char1, char2)
		if near_jump_os_action_active then
			delay(24, function()
				if doMove("THROW_OS", 1, true) == false then
					near_jump_os_action_active = false
				end
			end)
		end
	end

	if PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED or PECHAN_CONFIG.CPU.HAS_CHANGED or PECHAN_CONFIG.UI.INITIAL_START == true then
		if PECHAN_CONFIG.UI.INITIAL_START then
			-- Frame 1: Load savestate and wait
			if not delay_initial_read then
				-- No longer auto-loading savestate on initial game start
				-- load_machine_state("addon\\pechan_training_mod\\savestates\\" .. emu.romname() .. "_select.fs")
				delay_initial_read = true
				return
			end

			-- Frame 2: Memory is now populated. Read characters loaded by savestate and sync the UI config
			PECHAN_CONFIG.UI.INITIAL_START = false
			delay_initial_read = false

			local current_game = PECHAN_CONFIG.get_current_game()
			local p1_id_hex = string.format("0x%02X", rb(p1_stored_index_location))
			local p2_id_hex = string.format("0x%02X", rb(p2_stored_index_location))
			local sk1_id_hex = nil
			local sk2_id_hex = nil
			local p1_s2_hex, p1_s3_hex, p2_s2_hex, p2_s3_hex

			if current_game.has_strikers then
				if p1_striker_stored_index_location then
					sk1_id_hex = string.format("0x%02X",
						rb(p1_striker_stored_index_location))
				end
				if p2_striker_stored_index_location then
					sk2_id_hex = string.format("0x%02X",
						rb(p2_striker_stored_index_location))
				end
				if emu.romname() == "kof2000" then
					if p1_striker_mode_location then
						PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE = rb(p1_striker_mode_location)
					end
					if p2_striker_mode_location then
						PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE = rb(p2_striker_mode_location)
					end
				end
				if current_game.has_3_strikers then
					if p1_striker2_stored_index_location then
						p1_s2_hex = string.format("0x%02X",
							rb(p1_striker2_stored_index_location))
					end
					if p1_striker3_stored_index_location then
						p1_s3_hex = string.format("0x%02X",
							rb(p1_striker3_stored_index_location))
					end
					if p2_striker2_stored_index_location then
						p2_s2_hex = string.format("0x%02X",
							rb(p2_striker2_stored_index_location))
					end
					if p2_striker3_stored_index_location then
						p2_s3_hex = string.format("0x%02X",
							rb(p2_striker3_stored_index_location))
					end
				end
			end

			for i, char in ipairs(current_game.characters) do
				if char.code == p1_id_hex then
					PECHAN_CONFIG.UI.CURRENT_PLAYER1 = char
				end
				if char.code == p2_id_hex then
					PECHAN_CONFIG.UI.CURRENT_PLAYER2 = char
				end
				if current_game.has_strikers then
					if char.code == sk1_id_hex then PECHAN_CONFIG.UI.P1_STRIKER1 = char end
					if char.code == sk2_id_hex then PECHAN_CONFIG.UI.P2_STRIKER1 = char end
					if current_game.has_3_strikers then
						if char.code == p1_s2_hex then PECHAN_CONFIG.UI.P1_STRIKER2 = char end
						if char.code == p1_s3_hex then PECHAN_CONFIG.UI.P1_STRIKER3 = char end
						if char.code == p2_s2_hex then PECHAN_CONFIG.UI.P2_STRIKER2 = char end
						if char.code == p2_s3_hex then PECHAN_CONFIG.UI.P2_STRIKER3 = char end
					end
				end
			end

			return
		end

		-- If not INITIAL_START (meaning the user changed characters in the UI)
		load_machine_state("addon\\pechan_training_mod\\savestates\\" .. emu.romname() .. "_select.fs")
		PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED = false
		if PECHAN_CONFIG.CPU.HAS_CHANGED then
			PECHAN_CONFIG.CPU.HAS_CHANGED = false
		end

		local current_game = PECHAN_CONFIG.get_current_game()


		local level_address = current_game.offsets.level_address
		if level_address then wb(level_address, PECHAN_CONFIG.CPU.current_dificulty) end

		local stage_address = current_game.offsets.stage_address
		if stage_address then wb(stage_address, STAGES.JAPAN_STREET) end

		local music_address = current_game.offsets.music_address
		if music_address then wb(music_address, MUSIC_TRACKS.FANTASTIC_WALTZ) end

		if PECHAN_CONFIG.UI.CURRENT_PLAYER1 and PECHAN_CONFIG.UI.CURRENT_PLAYER1.code then
			wb(p1_stored_index_location, tonumber(PECHAN_CONFIG.UI.CURRENT_PLAYER1.code, 16))
		end
		if PECHAN_CONFIG.UI.CURRENT_PLAYER2 and PECHAN_CONFIG.UI.CURRENT_PLAYER2.code then
			wb(p2_stored_index_location, tonumber(PECHAN_CONFIG.UI.CURRENT_PLAYER2.code, 16))
		end

		if PECHAN_CONFIG.get_current_game().has_strikers then
			if PECHAN_CONFIG.UI.P1_STRIKER1 and PECHAN_CONFIG.UI.P1_STRIKER1.code and p1_striker_stored_index_location then
				wb(p1_striker_stored_index_location, tonumber(PECHAN_CONFIG.UI.P1_STRIKER1.code, 16))
				if p1_striker_mode_location and emu.romname() == "kof2000" then
					wb(p1_striker_mode_location, PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE)
				end
			end
			if PECHAN_CONFIG.UI.P2_STRIKER1 and PECHAN_CONFIG.UI.P2_STRIKER1.code and p2_striker_stored_index_location then
				wb(p2_striker_stored_index_location, tonumber(PECHAN_CONFIG.UI.P2_STRIKER1.code, 16))
				if p2_striker_mode_location and emu.romname() == "kof2000" then
					wb(p2_striker_mode_location, PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE)
				end
			end
			if PECHAN_CONFIG.get_current_game().has_3_strikers then
				if PECHAN_CONFIG.UI.P1_STRIKER2 and PECHAN_CONFIG.UI.P1_STRIKER2.code and p1_striker2_stored_index_location then
					wb(p1_striker2_stored_index_location, tonumber(PECHAN_CONFIG.UI.P1_STRIKER2.code, 16))
				end
				if PECHAN_CONFIG.UI.P1_STRIKER3 and PECHAN_CONFIG.UI.P1_STRIKER3.code and p1_striker3_stored_index_location then
					wb(p1_striker3_stored_index_location, tonumber(PECHAN_CONFIG.UI.P1_STRIKER3.code, 16))
				end
				if PECHAN_CONFIG.UI.P2_STRIKER2 and PECHAN_CONFIG.UI.P2_STRIKER2.code and p2_striker2_stored_index_location then
					wb(p2_striker2_stored_index_location, tonumber(PECHAN_CONFIG.UI.P2_STRIKER2.code, 16))
				end
				if PECHAN_CONFIG.UI.P2_STRIKER3 and PECHAN_CONFIG.UI.P2_STRIKER3.code and p2_striker3_stored_index_location then
					wb(p2_striker3_stored_index_location, tonumber(PECHAN_CONFIG.UI.P2_STRIKER3.code, 16))
				end
			end
		end

		if not PECHAN_CONFIG.UI.CURRENT_PLAYER1 or not PECHAN_CONFIG.UI.CURRENT_PLAYER1.has_ex then
			PECHAN_CONFIG.UI.PLAYER1_EX = false
		end
		if not PECHAN_CONFIG.UI.CURRENT_PLAYER2.has_ex then
			PECHAN_CONFIG.UI.PLAYER2_EX = false
		end

		if PECHAN_CONFIG.UI.PLAYER1_EX then
			local p1_ex_addr = PECHAN_CONFIG.get_current_game().offsets.p1_ex_address
			local p1_color_addr = PECHAN_CONFIG.get_current_game().offsets.p1_color_address
			local ex_val = PECHAN_CONFIG.get_current_game().offsets.ex_value or 0x01
			if p1_ex_addr then wb(p1_ex_addr, ex_val) end
			if p1_color_addr then wb(p1_color_addr, 0x02) end
		else
			local p1_ex_addr = PECHAN_CONFIG.get_current_game().offsets.p1_ex_address
			if p1_ex_addr then wb(p1_ex_addr, 0x00) end
			local p1_color_addr = PECHAN_CONFIG.get_current_game().offsets.p1_color_address
			if p1_color_addr and PECHAN_CONFIG.get_current_game().has_ex then wb(p1_color_addr, 0x00) end
		end

		if PECHAN_CONFIG.UI.PLAYER2_EX then
			local p2_ex_addr = PECHAN_CONFIG.get_current_game().offsets.p2_ex_address
			local p2_color_addr = PECHAN_CONFIG.get_current_game().offsets.p2_color_address
			local ex_val = PECHAN_CONFIG.get_current_game().offsets.ex_value or 0x01
			if p2_ex_addr then wb(p2_ex_addr, ex_val) end
			if p2_color_addr then wb(p2_color_addr, 0x02) end
		else
			local p2_ex_addr = PECHAN_CONFIG.get_current_game().offsets.p2_ex_address
			if p2_ex_addr then wb(p2_ex_addr, 0x00) end
			local p2_color_addr = PECHAN_CONFIG.get_current_game().offsets.p2_color_address
			if p2_color_addr and PECHAN_CONFIG.get_current_game().has_ex then wb(p2_color_addr, 0x00) end
		end

		if PECHAN_CONFIG.UI.MODE_HAS_CHANGED then
			PECHAN_CONFIG.UI.MODE_HAS_CHANGED = false
			local p1_mode_addr = PECHAN_CONFIG.get_current_game().offsets.p1_mode_address
			local p2_mode_addr = PECHAN_CONFIG.get_current_game().offsets.p2_mode_address

			if p1_mode_addr then
				if PECHAN_CONFIG.UI.PLAYER1_MODE == PECHAN_CONFIG.UI.MODES.ADVANCED then
					wb(p1_mode_addr, 0x00)
				elseif PECHAN_CONFIG.UI.PLAYER1_MODE == PECHAN_CONFIG.UI.MODES.EXTRA then
					wb(p1_mode_addr, 0x01)
				end
			end
			if p2_mode_addr then
				if PECHAN_CONFIG.UI.PLAYER2_MODE == PECHAN_CONFIG.UI.MODES.ADVANCED then
					wb(p2_mode_addr, 0x00)
				elseif PECHAN_CONFIG.UI.PLAYER2_MODE == PECHAN_CONFIG.UI.MODES.EXTRA then
					wb(p2_mode_addr, 0x01)
				end
			end

			if emu.romname() == "kof2000" then
				if p1_striker_mode_location then
					wb(p1_striker_mode_location, PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE)
				end
				if p2_striker_mode_location then
					wb(p2_striker_mode_location, PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE)
				end
			end
		end

		PECHAN_CONFIG.UI.APPLIED.PLAYER1 = PECHAN_CONFIG.UI.CURRENT_PLAYER1
		PECHAN_CONFIG.UI.APPLIED.PLAYER2 = PECHAN_CONFIG.UI.CURRENT_PLAYER2
		PECHAN_CONFIG.UI.APPLIED.P1_STRIKER1 = PECHAN_CONFIG.UI.P1_STRIKER1
		PECHAN_CONFIG.UI.APPLIED.P2_STRIKER1 = PECHAN_CONFIG.UI.P2_STRIKER1
		PECHAN_CONFIG.UI.APPLIED.P1_STRIKER2 = PECHAN_CONFIG.UI.P1_STRIKER2
		PECHAN_CONFIG.UI.APPLIED.P1_STRIKER3 = PECHAN_CONFIG.UI.P1_STRIKER3
		PECHAN_CONFIG.UI.APPLIED.P2_STRIKER2 = PECHAN_CONFIG.UI.P2_STRIKER2
		PECHAN_CONFIG.UI.APPLIED.P2_STRIKER3 = PECHAN_CONFIG.UI.P2_STRIKER3
		PECHAN_CONFIG.UI.APPLIED.INFINITE_STRIKERS = PECHAN_CONFIG.UI.INFINITE_STRIKERS
		PECHAN_CONFIG.UI.APPLIED.PLAYER1_STRIKER_MODE = PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE
		PECHAN_CONFIG.UI.APPLIED.PLAYER2_STRIKER_MODE = PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE
		PECHAN_CONFIG.UI.APPLIED.PLAYER1_EX = PECHAN_CONFIG.UI.PLAYER1_EX
		PECHAN_CONFIG.UI.APPLIED.PLAYER2_EX = PECHAN_CONFIG.UI.PLAYER2_EX
		PECHAN_CONFIG.UI.APPLIED.PLAYER1_MODE = PECHAN_CONFIG.UI.PLAYER1_MODE
		PECHAN_CONFIG.UI.APPLIED.PLAYER2_MODE = PECHAN_CONFIG.UI.PLAYER2_MODE
	end


	--gui.text(197, 73,  rb(air_height), "cyan", "black")
	--[[ if rb(0x108321)~=0  then
		
		print(rb(0x108321).."-"..rb(0x108322).."-"..rb(0x108323))
	end ]]
	-- Check the current state and execute corresponding behavior
	--[[  gui.text(197, 73,  "test 1: "..rb(0x108321), "cyan", "black")
	 gui.text(197, 83,  "test 2: "..rb(0x108322), "cyan", "black")
	 gui.text(197, 93,  "test 3: "..rb(0x108323), "cyan", "black") ]]
	if not PECHAN_CONFIG.DIZZY.dummy_can_dizzy then
		dissableDizzy()
	end
	if PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.can_be_countered then
		enableCounter()
	end

	if PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.state_toggled then
		if PECHAN_CONFIG.DEBUG.GUARD == 1 then
			gui.text(197, 83, "guard break state toggled:" .. rb(guard_break_location), "cyan", "black")
		end
		toggleGuardBreak()
	end

	if PECHAN_CONFIG.CPU.dummy_can_fight then
		enableCPU()
	else
		disableCPU()
	end


	--[[ if PECHAN_CONFIG.CPU.GCAB.dummy_can_gcab then
		if playerTwoInBlockstun() then
			disableCPU()
			PECHAN_CONFIG.CPU.dummy_can_fight = false
			transitionToState("cpu_action")
		end
	end ]]

	-- Update frame data
	if PECHAN_CONFIG.DEBUG.FRAMEDATA > 0 then
		frame_data.update()
	end

	-- Dispatch to State Handlers
	local handler = StateHandlers[stateMachine.currentState]
	if handler then
		handler(stateMachine)
	else
		-- Fallback or error logging
		if PECHAN_CONFIG.DEBUG.STATE == 1 then
			print("Warning: No handler for state: " .. tostring(stateMachine.currentState))
		end
	end

	-- TEMPORARY DUMMY SWAP SCROLLING DEBUG & INPUT LOGGER
	local function get_active_inputs(player_id)
		local tbl = joypad.get()
		local active = {}
		for k, v in pairs(tbl) do
			if v == 1 then
				-- Just dump the raw key name exactly as FBNeo provides it
				table.insert(active, k)
			end
		end
		return table.concat(active, ",")
	end

	DebugViewer.logVars("Dummy", {
		Base = string.format("%06X", DummyPlayer.base_address or 0),
		CPU = rb((DummyPlayer.base_address or 0) + 0x170),
		Act = DummyPlayer:getRawActionByte(),
		Hit = rb(DummyPlayer.addresses.hitstatus or 0),
		Face = (DummyPlayer:isFacingLeft() and "L" or "R"),
		In = get_active_inputs(DummyPlayer.id),
	})
	DebugViewer.logVars("Human", {
		Base = string.format("%06X", HumanPlayer.base_address or 0),
		CPU = rb((HumanPlayer.base_address or 0) + 0x170),
		Act = HumanPlayer:getRawActionByte(),
		Hit = rb(HumanPlayer.addresses.hitstatus or 0),
		Face = (HumanPlayer:isFacingLeft() and "L" or "R"),
		In = get_active_inputs(HumanPlayer.id),
	})
end

if registers and registers.guiregister then
	table.insert(registers.guiregister, KofTrainingRun)
	table.insert(registers.guiregister, function()
		if PECHAN_CONFIG.DEBUG.FRAMEDATA > 0 then
			frame_data.draw()
		end
		DebugViewer.draw()
	end)
end
