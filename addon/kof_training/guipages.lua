guicustompage = {
	title = {
		text = "The king of fighters - Training Mode Settings",
		x = interactivegui.boxxlength / 2 - (#"The king of fighters - Training Mode Settings") * 2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Guard Settings: ",
		x = 2,
		y = 15,
	},
	{
		text = "Guard",
		x = 118,
		y = 25,
		olcolour = "black",
		handle = 1,
		info = {
		},
		func = function()
			KOF_CONFIG.GUARD.guard_mode = KOF_CONFIG.GUARD.guard_mode + 1
			if KOF_CONFIG.GUARD.guard_mode > 4 then
				KOF_CONFIG.GUARD.guard_mode = 0
			end
			-- Logic update: dummy_guarding flag might still be used by external scripts?
			-- Keeping it synced just in case, though logic should rely on guard_mode
			if KOF_CONFIG.GUARD.guard_mode > 0 then
				KOF_CONFIG.GUARD.dummy_guarding = true
			else
				KOF_CONFIG.GUARD.dummy_guarding = false
			end
		end,
		autofunc = function(this)
			if KOF_CONFIG.GUARD.guard_mode == 0 then
				this.text = "Guard: Off"
			elseif KOF_CONFIG.GUARD.guard_mode == 1 then
				this.text = "Guard: On"
			elseif KOF_CONFIG.GUARD.guard_mode == 2 then
				this.text = "Guard: Random"
			elseif KOF_CONFIG.GUARD.guard_mode == 3 then
				this.text = "Guard: All Guard"
			elseif KOF_CONFIG.GUARD.guard_mode == 4 then
				this.text = "Guard: 1 Hit Guard"
			end
		end,
	},
	{
		text = "Action",
		x = 8,
		y = 25,
		olcolour = "black",
		handle = 1,
		info = {
		},
		func = function()
			KOF_CONFIG.GUARD.dummy_action = KOF_CONFIG.GUARD.dummy_action + 1
			if KOF_CONFIG.GUARD.dummy_action > 1 then
				KOF_CONFIG.GUARD.dummy_action = 0
			end
		end,
		autofunc = function(this)
			if KOF_CONFIG.GUARD.dummy_action == 0 then
				this.text = "Action: Standing"
			elseif KOF_CONFIG.GUARD.dummy_action == 1 then
				this.text = "Action: Crouching"
			end
		end,
	},
	{
		text = "Toggle Hit Reversal",
		x = 8,
		y = 35,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func = function()
			KOF_CONFIG.HIT.reversal = KOF_CONFIG.HIT.reversal + 1
			if KOF_CONFIG.HIT.reversal > 2 then
				KOF_CONFIG.HIT.reversal = 0
			end
		end,
		autofunc = function(this)
			if (KOF_CONFIG.HIT.reversal == KOF_CONFIG.HIT.REVERSAL_OPTIONS.OFF) then
				this.text = "Enable Hit Reversal: Off"
			elseif (KOF_CONFIG.HIT.reversal == KOF_CONFIG.HIT.REVERSAL_OPTIONS.ON) then
				this.text = "Enable Hit Reversal: On"
			elseif (KOF_CONFIG.HIT.reversal == KOF_CONFIG.HIT.REVERSAL_OPTIONS.RANDOM) then
				this.text = "Enable Hit Reversal: Random"
			end
		end,
	},
	-- Removed Random Guard Toggle as it is merged into "Guard"

	{
		text = "Toggle Guard Reversal",
		x = 118,
		y = 35,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func = function()
			KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.reversal + 1
			if KOF_CONFIG.GUARD.reversal > 2 then
				KOF_CONFIG.GUARD.reversal = 0
			end
		end,
		autofunc = function(this)
			if (KOF_CONFIG.GUARD.reversal == KOF_CONFIG.GUARD.REVERSAL_OPTIONS.OFF) then
				this.text = "Enable G. Reversal: Off"
			elseif (KOF_CONFIG.GUARD.reversal == KOF_CONFIG.GUARD.REVERSAL_OPTIONS.ON) then
				this.text = "Enable G. Reversal: On"
			elseif (KOF_CONFIG.GUARD.reversal == KOF_CONFIG.GUARD.REVERSAL_OPTIONS.RANDOM) then
				this.text = "Enable G. Reversal: Random"
			end
		end,
	},
	{
		text = "Other Settings: ",
		x = 2,
		y = 50,
	},
	{
		text = "WakeUp Reversal",
		x = 8,
		y = 60,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func = function()
			if next(KOF_CONFIG.WAKEUP.reversal_moves) == nil then
				return
			end
			KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.reversal + 1
			if KOF_CONFIG.WAKEUP.reversal > 2 then
				KOF_CONFIG.WAKEUP.reversal = 0
			end
			if KOF_CONFIG.WAKEUP.reversal ~= KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.OFF then
				KOF_CONFIG.WAKEUP.dummy_waking_up = true
			else
				KOF_CONFIG.WAKEUP.dummy_waking_up = false
			end
		end,
		autofunc = function(this)
			--gui.text(10, 200, "wake up reversal: "..tostring(KOF_CONFIG.WAKEUP.reversal))		
			if (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.OFF) then
				this.text = "Wake Up Reversal: Off"
			elseif (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON) then
				this.text = "Wake Up Reversal: On"
			elseif (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM) then
				this.text = "Wake Up Reversal: Random"
			end
		end,
	},
	{
		text = "Enable Tech Recovery",
		x = 118,
		y = 60,
		olcolour = "black",
		handle = 2,
		info = {
			"Controls how many frames until the character takes to do the reversal",
			"Because depending on the mo "
		},
		func = function()
			KOF_CONFIG.RECOVERY.recovery = KOF_CONFIG.RECOVERY.recovery + 1
			if KOF_CONFIG.RECOVERY.recovery > 2 then
				KOF_CONFIG.RECOVERY.recovery = 0
			end
			if KOF_CONFIG.RECOVERY.recovery ~= KOF_CONFIG.RECOVERY.OPTIONS.OFF then
				KOF_CONFIG.RECOVERY.dummy_recovering = true
			else
				KOF_CONFIG.RECOVERY.dummy_recovering = false
			end
		end,
		autofunc = function(this)
			if KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.OFF then
				this.text = "Tech Recovery: Off"
			elseif KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.ON then
				this.text = "Tech Recovery: On"
			elseif KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.RANDOM then
				this.text = "Tech Recovery: Random"
			end
		end,
	},
	{
		text = "Recovery Delay:",
		x = 8,
		y = 70,
		olcolour = "black",
		info = {
			"this is the delay it will take on frames and the times of the recovery"

		},
	},
	{
		text = "-",
		x = 40 + 34, -- Adjust x position as needed
		y = 70, -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			-- Function for "(-) delay"				
			if KOF_CONFIG.RECOVERY.delay == 0 then
				return
			end
			KOF_CONFIG.RECOVERY.delay = KOF_CONFIG.RECOVERY.delay - 1
		end,
	},
	{
		text = tostring(KOF_CONFIG.RECOVERY.delay),
		x = 40 + 45, -- Adjust x position as needed
		y = 70, -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()

		end,
		autofunc = function(this)
			this.text = tostring(KOF_CONFIG.RECOVERY.delay)
		end,

	},
	{
		text = "+",
		x = 40 + 60, -- Adjust x position as needed
		y = 70, -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			-- Function for "(+) delay"
			KOF_CONFIG.RECOVERY.delay = KOF_CONFIG.RECOVERY.delay + 1
		end,
	},
	{
		text = "Recovery Times:",
		x = 118,
		y = 70,
		olcolour = "black",
		info = {
			"this is the delay it will take on frames and the times of the recovery"

		},
	},
	{
		text = "-",
		x = 150 + 34, -- Adjust x position as needed
		y = 70, -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			-- Function for "(-) delay"				
			if KOF_CONFIG.RECOVERY.times == 1 then
				return
			end
			KOF_CONFIG.RECOVERY.times = KOF_CONFIG.RECOVERY.times - 1
		end,
	},
	{
		text = tostring(KOF_CONFIG.RECOVERY.times),
		x = 150 + 45, -- Adjust x position as needed
		y = 70, -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()

		end,
		autofunc = function(this)
			this.text = tostring(KOF_CONFIG.RECOVERY.times)
		end,

	},
	{
		text = "+",
		x = 150 + 60, -- Adjust x position as needed
		y = 70, -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			-- Function for "(+) delay"
			KOF_CONFIG.RECOVERY.times = KOF_CONFIG.RECOVERY.times + 1
		end,
	},
	{
		text = "Reversal Move List Settings and information: ",
		x = 2,
		y = 75 + 10,
	},
	{
		text = "p1 and dummy settings:",
		x = 118,
		y = 95,
		olcolour = "black",
		handle = 8,
		func = function() CIG("p1_and_dummy_settings", 1) end,
	},
	{
		text = "Character Selecction",
		x = 118,
		y = 95 + 10,
		olcolour = "black",
		handle = 9,
		func = function() CIG("character_select_settings", 1) end,
	},
	{
		text = "CPU settings",
		x = 118,
		y = 115,
		olcolour = "black",
		handle = 9,
		func = function() CIG("cpu_settings", 1) end,
	},
	{
		text = "Guard Reversals",
		x = 8,
		y = 85 + 10,
		olcolour = "black",
		handle = 9,
		func = function() CIG("guard_reversal_move_active_settings", 1) end,
	},
	{
		text = "()",
		x = 8,
		y = 95 + 10,
		olcolour = "black",
		handle = 2,
		info = {
			"active moves for reversal on guard"
		},
		func = function()
		end,
		autofunc = function(this)
			local txt = ""
			local i = 1
			for index, value in ipairs(KOF_CONFIG.GUARD.reversal_moves) do
				if i == 1 then
					txt = txt .. value
					i = 1 + 1
				else
					txt = txt .. ", " .. value
				end
			end
			this.text = "(" .. txt .. ")"
		end,
	},
	{
		text = "WakeUp Reversals",
		x = 8,
		y = 105 + 10,
		handle = 9,
		func = function() CIG("wakeup_reversal_move_active_settings", 1) end,
	},
	{
		text = "()",
		x = 8,
		y = 115 + 10,
		olcolour = "black",
		handle = 8,
		func = function()
		end,
		autofunc = function(this)
			local txt = ""
			local i = 1
			for index, value in ipairs(KOF_CONFIG.WAKEUP.reversal_moves) do
				if i == 1 then
					txt = txt .. value
					i = 1 + 1
				else
					txt = txt .. ", " .. value
				end
			end
			this.text = "(" .. txt .. ")"
		end,
	},
	{
		text = "Hit Reversals",
		x = 8,
		y = 125 + 10,
		handle = 9,
		func = function() CIG("hit_reversal_move_active_settings", 1) end,
	},
	{
		text = "()",
		x = 8,
		y = 135 + 10,
		olcolour = "black",
		handle = 8,
		func = function()
		end,
		autofunc = function(this)
			local txt = ""
			local i = 1
			for index, value in ipairs(KOF_CONFIG.HIT.reversal_moves) do
				if i == 1 then
					txt = txt .. value
					i = 1 + 1
				else
					txt = txt .. ", " .. value
				end
			end
			this.text = "(" .. txt .. ")"
		end,
	},
	{
		text = "Configurations: ",
		x = 118,
		y = 127,
	},
	{
		text = "Current Conf: ",
		x = 118,
		y = 152,
		olcolour = "black",
		handle = 2,
		info = {
			"active moves for reversal on guard"
		},
		func = function()
			KOF_CONFIG.TRAINING.current_configuration = KOF_CONFIG.TRAINING.current_configuration + 1
			if KOF_CONFIG.TRAINING.current_configuration > 11 then
				KOF_CONFIG.TRAINING.current_configuration = -1
			end
			setDefaultConfig(KOF_CONFIG.TRAINING.current_configuration)
		end,
		autofunc = function(this)
			this.text = "Current Conf: " .. getIndexFromConfigValue(KOF_CONFIG.TRAINING.current_configuration)
		end,
	},
	{
		text = "Load Recorded Setup: ",
		x = 118,
		y = 139,
		olcolour = "black",
		handle = 2,
		info = {
			"load here the recorded setup from recording"
		},
		func = function() CIG("activate_current_recording_setup", 1) end,
	}
}

local activate_current_recording_setup = {
	title = {
		text = "Activate Recorded setup from recording",
		x = interactivegui.boxxlength / 2 - (#"Activate Recorded setup from recording") * 2,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(0, 1) end,
	},
}
guipages.activate_current_recording_setup = activate_current_recording_setup
local function buildSetupMenu(setups)
	local items = {}

	local start_x = 10
	local start_y = 8
	local spacing = 12

	for i, setup in ipairs(setups) do
		local item = {
			x = start_x,
			y = start_y + (i - 1) * spacing,
			text = setup.base_name,
			olcolour = "black",
			fillpercent = 1,
			checked = false,
			func = function()
				items[i].checked = not items[i].checked
				if items[i].checked then
					-- Uncheck other items
					for j, other_item in ipairs(items) do
						if j ~= i then
							other_item.checked = false
						end
					end
					-- Load the selected setup
					applySetup(setups[i])
				end
			end,
			autofunc = function(this)
				if this.checked then
					this.fillpercent = 1
				elseif not this.checked then
					this.fillpercent = 0
				end
			end
		}

		table.insert(items, item)
	end

	return items
end
local DBIndex = DBIndex or require("addon.kof_training.db_lua.db.index")
local setups = DBIndex.loadAllSetups()
local setup_items = buildSetupMenu(setups)

for _, item in ipairs(setup_items) do
	table.insert(guipages.activate_current_recording_setup, item)
end
local SETUP_MENU_START_INDEX = #activate_current_recording_setup + 1

function refreshSetupMenu()
	-- remove old dynamic items
	for i = #guipages.activate_current_recording_setup, SETUP_MENU_START_INDEX, -1 do
		table.remove(guipages.activate_current_recording_setup, i)
	end

	-- reload setups from disk
	local setups = DBIndex.loadAllSetups()
	local setup_items = buildSetupMenu(setups)

	-- insert new items
	for _, item in ipairs(setup_items) do
		table.insert(guipages.activate_current_recording_setup, item)
	end
	formatGuiTables() --  this is VERY important as it resets the gui for the new element to work properly
end

local cpu_settings = {
	title = {
		text = "CPU Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(0, 1) end,
	},
}

guipages.cpu_settings = cpu_settings
local cpu_data = {
	["1"] =
	{
		text = "Enable CPU",
		x = 10,
		y = 8,
		olcolour = "black",
		func = function()
			KOF_CONFIG.CPU.vs_enabled = KOF_CONFIG.CPU.vs_enabled + 1
			if KOF_CONFIG.CPU.vs_enabled > 1 then
				KOF_CONFIG.CPU.vs_enabled = 0
			end
			if KOF_CONFIG.CPU.vs_enabled ~= KOF_CONFIG.CPU.OPTIONS.OFF then
				KOF_CONFIG.CPU.dummy_can_fight = true
			else
				KOF_CONFIG.CPU.dummy_can_fight = false
			end
		end,
		autofunc = function(this)
			if KOF_CONFIG.CPU.vs_enabled == KOF_CONFIG.CPU.OPTIONS.OFF then
				this.text = "CPU: Off"
			elseif KOF_CONFIG.CPU.vs_enabled == KOF_CONFIG.CPU.OPTIONS.ON then
				this.text = "CPU: On"
			end
		end,
	},
	["2"] = {
		x = 10,
		y = 20,
		info = { 'set CPU difficulty' },
		func = function()
			KOF_CONFIG.CPU.HAS_CHANGED       = true
			KOF_CONFIG.CPU.current_dificulty = KOF_CONFIG.CPU.current_dificulty + 1
			if KOF_CONFIG.CPU.current_dificulty > 7 then
				KOF_CONFIG.CPU.current_dificulty = 0
			end
			print("current dificulty " .. KOF_CONFIG.CPU.current_dificulty)
		end,
		text = "Dummy Difficulty",
		olcolour = "black",
		autofunc = function(this)
			this.text = "Dummy Difficulty: " .. KOF_CONFIG.CPU:getDifficultyString(rb(0x10FD8E))
		end,
	},
	["3"] = {
		x = 10,
		y = 32,
		info = { 'Guard Cancel CD' },
		func = function()
			KOF_CONFIG.CPU.GCCD.current_gccd = KOF_CONFIG.CPU.GCCD.current_gccd + 1
			if KOF_CONFIG.CPU.GCCD.current_gccd > 2 then
				KOF_CONFIG.CPU.GCCD.current_gccd = 0
			end

			if KOF_CONFIG.CPU.GCCD.current_gccd ~= KOF_CONFIG.CPU.GCCD.OPTIONS.OFF then
				KOF_CONFIG.CPU.GCCD.dummy_can_gccd = true
			else
				KOF_CONFIG.CPU.GCCD.dummy_can_gccd = false
			end
		end,
		text = "CD on Guard:",
		olcolour = "black",
		autofunc = function(this)
			if KOF_CONFIG.CPU.GCCD.current_gccd == KOF_CONFIG.CPU.GCCD.OPTIONS.OFF then
				this.text = "CD on Guard: Off"
			elseif KOF_CONFIG.CPU.GCCD.current_gccd == KOF_CONFIG.CPU.GCCD.OPTIONS.ON then
				this.text = "CD on Guard: On"
			elseif KOF_CONFIG.CPU.GCCD.current_gccd == KOF_CONFIG.CPU.GCCD.OPTIONS.RANDOM then
				this.text = "CD on Guard: Random"
			end
		end,
	},
	["4"] = {
		x = 10,
		y = 44,
		info = { 'Guard Cancel AB' },
		func = function()
			KOF_CONFIG.CPU.GCAB.current_gcab = KOF_CONFIG.CPU.GCAB.current_gcab + 1
			if KOF_CONFIG.CPU.GCAB.current_gcab > 2 then
				KOF_CONFIG.CPU.GCAB.current_gcab = 0
			end

			if KOF_CONFIG.CPU.GCAB.current_gcab ~= KOF_CONFIG.CPU.GCAB.OPTIONS.OFF then
				KOF_CONFIG.CPU.GCAB.dummy_can_gcab = true
			else
				KOF_CONFIG.CPU.GCAB.dummy_can_gcab = false
			end
		end,
		text = "AB on Guard:",
		olcolour = "black",
		autofunc = function(this)
			if KOF_CONFIG.CPU.GCAB.current_gcab == KOF_CONFIG.CPU.GCAB.OPTIONS.OFF then
				this.text = "AB on Guard: Off"
			elseif KOF_CONFIG.CPU.GCAB.current_gcab == KOF_CONFIG.CPU.GCAB.OPTIONS.ON then
				this.text = "AB on Guard: On"
			elseif KOF_CONFIG.CPU.GCAB.current_gcab == KOF_CONFIG.CPU.GCAB.OPTIONS.RANDOM then
				this.text = "AB on Guard: Random"
			end
		end,
	},
	["5"] = {
		x = 10,
		y = 56,
		info = { 'Guard OS' },
		func = function()
			KOF_CONFIG.CPU.THROW_OS_ON_JUMP = not KOF_CONFIG.CPU.THROW_OS_ON_JUMP
		end,
		text = "Guard OS:",
		olcolour = "black",
		autofunc = function(this)
			if KOF_CONFIG.CPU.THROW_OS_ON_JUMP then
				this.text = "Guard OS: On"
			else
				this.text = "Guard OS: Off"
			end
		end,
	},
}


for key, item in pairs(cpu_data) do
	table.insert(guipages.cpu_settings, item)
end
local p1_and_dummy_settings = {
	title = {
		text = "P1 and Dummy  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(0, 1) end,
	},
}

guipages.p1_and_dummy_settings = p1_and_dummy_settings
local p1_and_dummy_data = {
	["1"] =
	{
		text = "Dissy enabled",
		x = 10,
		y = 8,
		olcolour = "black",
		handle = 1,
		func = function()
			KOF_CONFIG.DIZZY.enabled = KOF_CONFIG.DIZZY.enabled + 1
			if KOF_CONFIG.DIZZY.enabled > 1 then
				KOF_CONFIG.DIZZY.enabled = 0
			end
			if KOF_CONFIG.DIZZY.enabled ~= KOF_CONFIG.DIZZY.OPTIONS.OFF then
				KOF_CONFIG.DIZZY.dummy_can_dizzy = true
			else
				KOF_CONFIG.DIZZY.dummy_can_dizzy = false
			end
		end,
		autofunc = function(this)
			if KOF_CONFIG.DIZZY.enabled == KOF_CONFIG.DIZZY.OPTIONS.OFF then
				this.text = "DIZZY: Off"
			elseif KOF_CONFIG.DIZZY.enabled == KOF_CONFIG.DIZZY.OPTIONS.ON then
				this.text = "DIZZY: On"
			end
		end,
	},
	["2"] =
	{
		text = "P1 crouch guard",
		x = 10,
		y = 20,
		olcolour = "black",
		handle = 2,
		func = function()
			KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED = KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED + 1
			if KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED > 1 then
				KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED = 0
			end
			if KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED ~= KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.OPTIONS.OFF then
				KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.can_crouch_guard = true
			else
				KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.can_crouch_guard = false
			end
		end,
		autofunc = function(this)
			if KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED == KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.OPTIONS.OFF then
				this.text = "P1_CROUCH_GUARD: Off"
			elseif KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED == KOF_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.OPTIONS.ON then
				this.text = "P1_CROUCH_GUARD: On"
			end
		end,
	},
	["3"] = {
		text = "P2 Guard Break",
		x = 10,
		y = 32,
		olcolour = "black",
		handle = 3,
		func = function()
			KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED = KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED + 1
			if KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED > 1 then
				KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED = 0
			end
			if KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED ~= KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.OPTIONS.OFF then
				KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.can_be_countered = true
			else
				KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.can_be_countered = false
			end
		end,
		autofunc = function(this)
			if KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED == KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.OPTIONS.OFF then
				this.text = "Counter: Off"
			elseif KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED == KOF_CONFIG.PLAYERS.PLAYER2.COUNTER.OPTIONS.ON then
				this.text = "Counter: On"
			end
		end,
	},
	["4"] = {
		text = "P2 Guard Break",
		x = 10,
		y = 44,
		olcolour = "black",
		handle = 3,
		func = function()
			KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE = KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE + 1
			if KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE > 2 then
				KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE = 0
			end
			if KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.NORMAL then
				KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.state_toggled = false
			else
				KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.state_toggled = true
			end
		end,
		autofunc = function(this)
			if KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.NORMAL then
				this.text = "GUARD BREAK: Normal"
			elseif KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.NEVER then
				this.text = "GUARD BREAK: Never"
			elseif KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == KOF_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.ALWAYS then
				this.text = "GUARD BREAK: always"
			end
		end,
	},
	["5"] = {
		text = "Debug Block",
		x = 118,
		y = 8,
		olcolour = "black",
		handle = 4,
		func = function()
			KOF_CONFIG.DEBUG.BLOCK = KOF_CONFIG.DEBUG.BLOCK == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug Block: " .. (KOF_CONFIG.DEBUG.BLOCK == 1 and "On" or "Off")
		end,
	},
	["6"] = {
		text = "Debug Advantage",
		x = 118,
		y = 20,
		olcolour = "black",
		handle = 5,
		func = function()
			KOF_CONFIG.DEBUG.ADVANTAGE = KOF_CONFIG.DEBUG.ADVANTAGE == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug Advantage: " .. (KOF_CONFIG.DEBUG.ADVANTAGE == 1 and "On" or "Off")
		end,
	},
	["7"] = {
		text = "Debug Action",
		x = 118,
		y = 32,
		olcolour = "black",
		handle = 6,
		func = function()
			KOF_CONFIG.DEBUG.ACTION = KOF_CONFIG.DEBUG.ACTION == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug Action: " .. (KOF_CONFIG.DEBUG.ACTION == 1 and "On" or "Off")
		end,
	},
	["8"] = {
		text = "Debug Position",
		x = 118,
		y = 44,
		olcolour = "black",
		handle = 7,
		func = function()
			KOF_CONFIG.DEBUG.POSITION = KOF_CONFIG.DEBUG.POSITION == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug Position: " .. (KOF_CONFIG.DEBUG.POSITION == 1 and "On" or "Off")
		end,
	},
	["9"] = {
		text = "Debug Stun",
		x = 118,
		y = 56,
		olcolour = "black",
		handle = 8,
		func = function()
			KOF_CONFIG.DEBUG.STUN = KOF_CONFIG.DEBUG.STUN == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug Stun: " .. (KOF_CONFIG.DEBUG.STUN == 1 and "On" or "Off")
		end,
	},
	["10"] = {
		text = "Debug Guard",
		x = 118,
		y = 68,
		olcolour = "black",
		handle = 9,
		func = function()
			KOF_CONFIG.DEBUG.GUARD = KOF_CONFIG.DEBUG.GUARD == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug Guard: " .. (KOF_CONFIG.DEBUG.GUARD == 1 and "On" or "Off")
		end,
	},
	["11"] = {
		text = "Debug Distance",
		x = 118,
		y = 80,
		olcolour = "black",
		handle = 10,
		func = function()
			KOF_CONFIG.DEBUG.DISTANCE = KOF_CONFIG.DEBUG.DISTANCE == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug Distance: " .. (KOF_CONFIG.DEBUG.DISTANCE == 1 and "On" or "Off")
		end,
	},
	["12"] = {
		text = "Debug State",
		x = 118,
		y = 92,
		olcolour = "black",
		handle = 11,
		func = function()
			KOF_CONFIG.DEBUG.STATE = KOF_CONFIG.DEBUG.STATE == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug State: " .. (KOF_CONFIG.DEBUG.STATE == 1 and "On" or "Off")
		end,
	},
	["13"] = {
		text = "Debug Meter",
		x = 118,
		y = 104,
		olcolour = "black",
		handle = 12,
		func = function()
			KOF_CONFIG.DEBUG.METER = KOF_CONFIG.DEBUG.METER == 0 and 1 or 0
		end,
		autofunc = function(this)
			this.text = "Debug Meter: " .. (KOF_CONFIG.DEBUG.METER == 1 and "On" or "Off")
		end,
	},
	["14"] = {
		text = "Debug Frame Data",
		x = 118,
		y = 116,
		olcolour = "black",
		handle = 13,
		func = function()
			KOF_CONFIG.DEBUG.FRAMEDATA = KOF_CONFIG.DEBUG.FRAMEDATA + 1
			if KOF_CONFIG.DEBUG.FRAMEDATA > 3 then
				KOF_CONFIG.DEBUG.FRAMEDATA = 0
			end
		end,
		autofunc = function(this)
			local states = { [0] = "Off", [1] = "P1", [2] = "P2", [3] = "Both" }
			this.text = "Debug Frame Data: " .. (states[KOF_CONFIG.DEBUG.FRAMEDATA] or "Off")
		end,
	},
}
for key, item in pairs(p1_and_dummy_data) do
	table.insert(guipages.p1_and_dummy_settings, item)
end
local guard_reversal_move_active_settings = {
	title = {
		text = "Guard Reversal Move Active Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(0, 1) end,
	},
}

local characters = KOF_CONFIG.get_current_game().characters
local chars_per_page = 28
local total_pages = math.ceil(#characters / chars_per_page)
if total_pages == 0 then total_pages = 1 end

for page = 1, total_pages do
	local page_name = "character_select_page_" .. page
	local page_table = {
		title = {
			text = "Character Selecction Settings (Page " .. page .. "/" .. total_pages .. ")",
			x = interactivegui.boxxlength / 2 - 60,
			y = 1,
		},
		{
			text = "<",
			olcolour = "black",
			info = "Back",
			func = function() CIG(0, 1) end,
		},
	}

	local start_idx = (page - 1) * chars_per_page + 1
	local end_idx = math.min(page * chars_per_page, #characters)

	local row = 0
	local col = 0
	for i = start_idx, end_idx do
		local yloc = 10 + row * 12
		local basex = 8 + col * 66

		-- Name button
		table.insert(page_table, {
			y = yloc,
			x = basex,
			info = { characters[i].name },
			text = characters[i].short_name:gsub("^%l", string.upper),
			olcolour = "black",
			func = function() end,
			autofunc = function(this) end,
		})

		-- P1 / SK1 cycler button
		table.insert(page_table, {
			y = yloc,
			x = basex + 37,
			info = { 'P1' },
			text = "P1",
			olcolour = "black",
			func = function()
				local char = KOF_CONFIG.get_current_game().characters[i]
				if KOF_CONFIG.get_current_game().has_strikers then
					if KOF_CONFIG.UI.CURRENT_PLAYER1 == char then
						KOF_CONFIG.UI.CURRENT_PLAYER1 = nil
						KOF_CONFIG.UI.P1_STRIKER1 = char
						KOF_CONFIG.UI.PLAYER1_STRIKER_MODE = 0
					elseif KOF_CONFIG.UI.P1_STRIKER1 == char then
						KOF_CONFIG.UI.P1_STRIKER1 = nil
						KOF_CONFIG.UI.PLAYER1_STRIKER_MODE = 0
						if KOF_CONFIG.get_current_game().has_3_strikers then
							KOF_CONFIG.UI.P1_STRIKER2 = char
						end
					elseif KOF_CONFIG.get_current_game().has_3_strikers and KOF_CONFIG.UI.P1_STRIKER2 == char then
						KOF_CONFIG.UI.P1_STRIKER2 = nil
						KOF_CONFIG.UI.P1_STRIKER3 = char
					elseif KOF_CONFIG.get_current_game().has_3_strikers and KOF_CONFIG.UI.P1_STRIKER3 == char then
						KOF_CONFIG.UI.P1_STRIKER3 = nil
					else
						KOF_CONFIG.UI.CURRENT_PLAYER1 = char
					end
				else
					KOF_CONFIG.UI.CURRENT_PLAYER1 = char
				end
			end,
			autofunc = function(this)
				local char = KOF_CONFIG.get_current_game().characters[i]
				if KOF_CONFIG.UI.CURRENT_PLAYER1 == char then
					this.text = "P1"
				elseif KOF_CONFIG.get_current_game().has_strikers and KOF_CONFIG.UI.P1_STRIKER1 == char then
					this.text = "S1"
				elseif KOF_CONFIG.get_current_game().has_3_strikers and KOF_CONFIG.UI.P1_STRIKER2 == char then
					this.text = "S2"
				elseif KOF_CONFIG.get_current_game().has_3_strikers and KOF_CONFIG.UI.P1_STRIKER3 == char then
					this.text = "S3"
				else
					this.text = "-"
				end
			end,
		})

		-- P2 / SK2 cycler button
		table.insert(page_table, {
			y = yloc,
			x = basex + 54,
			info = { 'P2' },
			text = "P2",
			olcolour = "black",
			func = function()
				local char = KOF_CONFIG.get_current_game().characters[i]
				if KOF_CONFIG.get_current_game().has_strikers then
					if KOF_CONFIG.UI.CURRENT_PLAYER2 == char then
						KOF_CONFIG.UI.CURRENT_PLAYER2 = nil
						KOF_CONFIG.UI.P2_STRIKER1 = char
						KOF_CONFIG.UI.PLAYER2_STRIKER_MODE = 0
					elseif KOF_CONFIG.UI.P2_STRIKER1 == char then
						KOF_CONFIG.UI.P2_STRIKER1 = nil
						KOF_CONFIG.UI.PLAYER2_STRIKER_MODE = 0
						if KOF_CONFIG.get_current_game().has_3_strikers then
							KOF_CONFIG.UI.P2_STRIKER2 = char
						end
					elseif KOF_CONFIG.get_current_game().has_3_strikers and KOF_CONFIG.UI.P2_STRIKER2 == char then
						KOF_CONFIG.UI.P2_STRIKER2 = nil
						KOF_CONFIG.UI.P2_STRIKER3 = char
					elseif KOF_CONFIG.get_current_game().has_3_strikers and KOF_CONFIG.UI.P2_STRIKER3 == char then
						KOF_CONFIG.UI.P2_STRIKER3 = nil
					else
						KOF_CONFIG.UI.CURRENT_PLAYER2 = char
					end
				else
					KOF_CONFIG.UI.CURRENT_PLAYER2 = char
				end
			end,
			autofunc = function(this)
				local char = KOF_CONFIG.get_current_game().characters[i]
				if KOF_CONFIG.UI.CURRENT_PLAYER2 == char then
					this.text = "P2"
				elseif KOF_CONFIG.get_current_game().has_strikers and KOF_CONFIG.UI.P2_STRIKER1 == char then
					this.text = "S1"
				elseif KOF_CONFIG.get_current_game().has_3_strikers and KOF_CONFIG.UI.P2_STRIKER2 == char then
					this.text = "S2"
				elseif KOF_CONFIG.get_current_game().has_3_strikers and KOF_CONFIG.UI.P2_STRIKER3 == char then
					this.text = "S3"
				else
					this.text = "-"
				end
			end,
		})

		row = row + 1
		if row >= 14 then
			row = 0
			col = col + 1
		end
	end

	local current_game_config = KOF_CONFIG.get_current_game()

	if current_game_config.has_ex then
		table.insert(page_table, {
			y = 10,
			x = 144,
			info = { 'P1 Ex character' },
			func = function()
				if KOF_CONFIG.UI.CURRENT_PLAYER1.has_ex then
					KOF_CONFIG.UI.PLAYER1_EX = not KOF_CONFIG.UI.PLAYER1_EX
				end
			end,
			text = "P1 Ex",
			olcolour = "black",
			autofunc = function(this)
				if not KOF_CONFIG.UI.CURRENT_PLAYER1.has_ex then
					this.text = "P1 Character Ex: ---"
				elseif KOF_CONFIG.UI.PLAYER1_EX == true then
					this.text = "P1 Character Ex: ON"
				else
					this.text = "P1 Character Ex: OFF"
				end
			end,
		})

		table.insert(page_table, {
			y = 22,
			x = 144,
			info = { 'P2 Ex character' },
			func = function()
				if KOF_CONFIG.UI.CURRENT_PLAYER2.has_ex then
					KOF_CONFIG.UI.PLAYER2_EX = not KOF_CONFIG.UI.PLAYER2_EX
				end
			end,
			text = "P2 Ex",
			olcolour = "black",
			autofunc = function(this)
				if not KOF_CONFIG.UI.CURRENT_PLAYER2.has_ex then
					this.text = "P2 Character Ex: ---"
				elseif KOF_CONFIG.UI.PLAYER2_EX == true then
					this.text = "P2 Character Ex: ON"
				else
					this.text = "P2 Character Ex: OFF"
				end
			end,
		})
	end

	if current_game_config.has_modes then
		table.insert(page_table, {
			y = 34,
			x = 144,
			info = { 'P1 Mode' },
			func = function()
				KOF_CONFIG.UI.PLAYER1_MODE = KOF_CONFIG.UI.PLAYER1_MODE + 1
				KOF_CONFIG.UI.MODE_HAS_CHANGED = true
				if KOF_CONFIG.UI.PLAYER1_MODE > 1 then
					KOF_CONFIG.UI.PLAYER1_MODE = 0
				end
			end,
			text = "P1 Mode",
			olcolour = "black",
			autofunc = function(this)
				if KOF_CONFIG.UI.PLAYER1_MODE == KOF_CONFIG.UI.MODES.EXTRA then
					this.text = "P1 Mode: Extra"
				else
					this.text = "P1 Mode: Advanced"
				end
			end,
		})

		table.insert(page_table, {
			y = 46,
			x = 144,
			info = { 'P2 Mode' },
			func = function()
				KOF_CONFIG.UI.PLAYER2_MODE = KOF_CONFIG.UI.PLAYER2_MODE + 1
				KOF_CONFIG.UI.MODE_HAS_CHANGED = true
				if KOF_CONFIG.UI.PLAYER2_MODE > 1 then
					KOF_CONFIG.UI.PLAYER2_MODE = 0
				end
			end,
			text = "P2 Mode",
			olcolour = "black",
			autofunc = function(this)
				if KOF_CONFIG.UI.PLAYER2_MODE == KOF_CONFIG.UI.MODES.EXTRA then
					this.text = "P2 Mode: Extra"
				else
					this.text = "P2 Mode: Advanced"
				end
			end,
		})
	end

	if current_game_config.has_strikers then
		if emu.romname() == "kof2000" then
			table.insert(page_table, {
				y = 34,
				x = 144,
				info = { 'P1 Striker Mode' },
				func = function()
					KOF_CONFIG.UI.PLAYER1_STRIKER_MODE = KOF_CONFIG.UI.PLAYER1_STRIKER_MODE + 1
					KOF_CONFIG.UI.MODE_HAS_CHANGED = true
					local max_mode = (KOF_CONFIG.UI.P1_STRIKER1 and KOF_CONFIG.UI.P1_STRIKER1.has_maniac) and 2 or
						1
					if KOF_CONFIG.UI.PLAYER1_STRIKER_MODE > max_mode then
						KOF_CONFIG.UI.PLAYER1_STRIKER_MODE = 0
					end
				end,
				text = "P1 SK: Regular",
				olcolour = "black",
				autofunc = function(this)
					if KOF_CONFIG.UI.P1_STRIKER1 and not KOF_CONFIG.UI.P1_STRIKER1.has_maniac and KOF_CONFIG.UI.PLAYER1_STRIKER_MODE == 2 then
						KOF_CONFIG.UI.PLAYER1_STRIKER_MODE = 0
					end

					if KOF_CONFIG.UI.PLAYER1_STRIKER_MODE == 1 then
						this.text = "P1 SK: Alternate"
					elseif KOF_CONFIG.UI.PLAYER1_STRIKER_MODE == 2 then
						this.text = "P1 SK: Maniac"
					else
						this.text = "P1 SK: Regular"
					end
				end,
			})

			table.insert(page_table, {
				y = 46,
				x = 144,
				info = { 'P2 Striker Mode' },
				func = function()
					KOF_CONFIG.UI.PLAYER2_STRIKER_MODE = KOF_CONFIG.UI.PLAYER2_STRIKER_MODE + 1
					KOF_CONFIG.UI.MODE_HAS_CHANGED = true
					local max_mode = (KOF_CONFIG.UI.P2_STRIKER1 and KOF_CONFIG.UI.P2_STRIKER1.has_maniac) and 2 or
						1
					if KOF_CONFIG.UI.PLAYER2_STRIKER_MODE > max_mode then
						KOF_CONFIG.UI.PLAYER2_STRIKER_MODE = 0
					end
				end,
				text = "P2 SK: Regular",
				olcolour = "black",
				autofunc = function(this)
					if KOF_CONFIG.UI.P2_STRIKER1 and not KOF_CONFIG.UI.P2_STRIKER1.has_maniac and KOF_CONFIG.UI.PLAYER2_STRIKER_MODE == 2 then
						KOF_CONFIG.UI.PLAYER2_STRIKER_MODE = 0
					end

					if KOF_CONFIG.UI.PLAYER2_STRIKER_MODE == 1 then
						this.text = "P2 SK: Alternate"
					elseif KOF_CONFIG.UI.PLAYER2_STRIKER_MODE == 2 then
						this.text = "P2 SK: Maniac"
					else
						this.text = "P2 SK: Regular"
					end
				end,
			})
		end

		table.insert(page_table, {
			y = 58,
			x = 144,
			info = { 'Infinite Strikers' },
			func = function()
				KOF_CONFIG.UI.INFINITE_STRIKERS = KOF_CONFIG.UI.INFINITE_STRIKERS + 1
				KOF_CONFIG.UI.MODE_HAS_CHANGED = true
				if KOF_CONFIG.UI.INFINITE_STRIKERS > 3 then
					KOF_CONFIG.UI.INFINITE_STRIKERS = 0
				end
			end,
			text = "Inf Strikers: Off",
			olcolour = "black",
			autofunc = function(this)
				if KOF_CONFIG.UI.INFINITE_STRIKERS == 1 then
					this.text = "Inf Strikers: P1"
				elseif KOF_CONFIG.UI.INFINITE_STRIKERS == 2 then
					this.text = "Inf Strikers: P2"
				elseif KOF_CONFIG.UI.INFINITE_STRIKERS == 3 then
					this.text = "Inf Strikers: Both"
				else
					this.text = "Inf Strikers: Off"
				end
			end,
		})
	end

	table.insert(page_table, {
		y = 70,
		x = 144,
		info = { 'Load Matchup' },
		func = function()
			KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
		end,
		text = ">>> APPLY CHANGES <<<",
		textcolour = "white",
		bgcolour = 0x4CAF50FF,
		olcolour = "black",
		autofunc = function(this)
			local pending = false
			local applied = KOF_CONFIG.UI.APPLIED
			if KOF_CONFIG.UI.CURRENT_PLAYER1 ~= applied.PLAYER1 then pending = true end
			if KOF_CONFIG.UI.CURRENT_PLAYER2 ~= applied.PLAYER2 then pending = true end
			if KOF_CONFIG.UI.PLAYER1_EX ~= applied.PLAYER1_EX then pending = true end
			if KOF_CONFIG.UI.PLAYER2_EX ~= applied.PLAYER2_EX then pending = true end
			if KOF_CONFIG.UI.PLAYER1_MODE ~= applied.PLAYER1_MODE then pending = true end
			if KOF_CONFIG.UI.PLAYER2_MODE ~= applied.PLAYER2_MODE then pending = true end
			if KOF_CONFIG.get_current_game().has_strikers then
				if KOF_CONFIG.UI.P1_STRIKER1 ~= applied.P1_STRIKER1 then pending = true end
				if KOF_CONFIG.UI.P2_STRIKER1 ~= applied.P2_STRIKER1 then pending = true end
				if KOF_CONFIG.UI.INFINITE_STRIKERS ~= applied.INFINITE_STRIKERS then pending = true end

				if emu.romname() == "kof2000" then
					if KOF_CONFIG.UI.PLAYER1_STRIKER_MODE ~= applied.PLAYER1_STRIKER_MODE then pending = true end
					if KOF_CONFIG.UI.PLAYER2_STRIKER_MODE ~= applied.PLAYER2_STRIKER_MODE then pending = true end
				end
				if KOF_CONFIG.get_current_game().has_3_strikers then
					if KOF_CONFIG.UI.P1_STRIKER2 ~= applied.P1_STRIKER2 then pending = true end
					if KOF_CONFIG.UI.P1_STRIKER3 ~= applied.P1_STRIKER3 then pending = true end
					if KOF_CONFIG.UI.P2_STRIKER2 ~= applied.P2_STRIKER2 then pending = true end
					if KOF_CONFIG.UI.P2_STRIKER3 ~= applied.P2_STRIKER3 then pending = true end
				end
			end

			if pending then
				this.bgcolour = 0xFFB347FF
			else
				this.bgcolour = 0x4CAF50FF
			end
		end,
	})

	if total_pages > 1 then
		if page > 1 then
			table.insert(page_table, {
				y = 90,
				x = 144,
				info = { 'Previous Page' },
				text = "<< Prev Page",
				olcolour = "black",
				func = function() CIG("character_select_page_" .. (page - 1), 1) end,
			})
		end
		if page < total_pages then
			table.insert(page_table, {
				y = 102,
				x = 144,
				info = { 'Next Page' },
				text = "Next Page >>",
				olcolour = "black",
				func = function() CIG("character_select_page_" .. (page + 1), 1) end,
			})
		end
	end

	guipages[page_name] = page_table
end

guipages.character_select_settings = guipages.character_select_page_1

-- assignments moved to moves_settings.lua
-- guipages.guard_reversal_move_active_settings = guard_reversal_move_active_settings
-- guipages.hit_reversal_move_active_settings = hit_reversal_move_active_settings
-- guipages.wakeup_reversal_move_active_settings = wakeup_reversal_move_active_settings

function trace_line(event, line)
	if event == "call" then
		local info = debug.getinfo(2, "Sl")
		print("Calling function at line:", info.currentline)
	elseif event == "line" then
		print("Executing line:", line)
	end
end

-- Register the KOF Training menu into the global guipages list


if guipages then
	-- Insert button into Main Menu (Page 1)
	table.insert(guipages, guicustompage)

	-- Refresh layout to auto-calculate position and update navigation
	if formatGuiTables then
		formatGuiTables()
	end
end
