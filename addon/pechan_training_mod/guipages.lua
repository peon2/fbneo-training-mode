local current_game = PECHAN_CONFIG.get_current_game()
local translate_mod = require("addon.pechan_training_mod.translate_mod")
local tl = translate_mod.tl

guicustompage = {
	title = {
		text = tl("ui.menu.title"),
		x = interactivegui.boxxlength / 2 - (#"Pechan's Training Mode Settings") * 2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
}

local cur_y = 15

if current_game.has_guard then
	table.insert(guicustompage, {
		text = tl("ui.menu.guard_settings"),
		x = 2,
		y = cur_y,
	})
	cur_y = cur_y + 10
	table.insert(guicustompage, {
		text = "Action",
		x = 8,
		y = cur_y,
		olcolour = "black",
		handle = 1,
		info = {},
		func = function()
			PECHAN_CONFIG.GUARD.dummy_action = PECHAN_CONFIG.GUARD.dummy_action + 1
			if PECHAN_CONFIG.GUARD.dummy_action > 1 then
				PECHAN_CONFIG.GUARD.dummy_action = 0
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.GUARD.dummy_action == 0 then
				this.text = tl("ui.guard.action.standing")
			elseif PECHAN_CONFIG.GUARD.dummy_action == 1 then
				this.text = tl("ui.guard.action.crouching")
			end
		end,
	})
	table.insert(guicustompage, {
		text = "Guard",
		x = 118,
		y = cur_y,
		olcolour = "black",
		handle = 1,
		info = {},
		func = function()
			PECHAN_CONFIG.GUARD.guard_mode = PECHAN_CONFIG.GUARD.guard_mode + 1
			if PECHAN_CONFIG.GUARD.guard_mode > 4 then
				PECHAN_CONFIG.GUARD.guard_mode = 0
			end
			-- Logic update: dummy_guarding flag might still be used by external scripts?
			-- Keeping it synced just in case, though logic should rely on guard_mode
			if PECHAN_CONFIG.GUARD.guard_mode > 0 then
				PECHAN_CONFIG.GUARD.dummy_guarding = true
			else
				PECHAN_CONFIG.GUARD.dummy_guarding = false
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.GUARD.guard_mode == 0 then
				this.text = tl("ui.guard.mode.off")
			elseif PECHAN_CONFIG.GUARD.guard_mode == 1 then
				this.text = tl("ui.guard.mode.on")
			elseif PECHAN_CONFIG.GUARD.guard_mode == 2 then
				this.text = tl("ui.guard.mode.random")
			elseif PECHAN_CONFIG.GUARD.guard_mode == 3 then
				this.text = tl("ui.guard.mode.all_guard")
			elseif PECHAN_CONFIG.GUARD.guard_mode == 4 then
				this.text = tl("ui.guard.mode.one_hit")
			end
		end,
	})
	cur_y = cur_y + 10
	table.insert(guicustompage, {
		text = "Toggle Guard Reversal",
		x = 118,
		y = cur_y,
		olcolour = "black",
		handle = 2,
		info = {},
		func = function()
			PECHAN_CONFIG.GUARD.reversal = PECHAN_CONFIG.GUARD.reversal + 1
			if PECHAN_CONFIG.GUARD.reversal > 2 then
				PECHAN_CONFIG.GUARD.reversal = 0
			end
		end,
		autofunc = function(this)
			if (PECHAN_CONFIG.GUARD.reversal == PECHAN_CONFIG.GUARD.REVERSAL_OPTIONS.OFF) then
				this.text = tl("ui.guard.reversal.off")
			elseif (PECHAN_CONFIG.GUARD.reversal == PECHAN_CONFIG.GUARD.REVERSAL_OPTIONS.ON) then
				this.text = tl("ui.guard.reversal.on")
			elseif (PECHAN_CONFIG.GUARD.reversal == PECHAN_CONFIG.GUARD.REVERSAL_OPTIONS.RANDOM) then
				this.text = tl("ui.guard.reversal.random")
			end
		end,
	})
end

if current_game.has_hit_reversal then
	if not current_game.has_guard then cur_y = cur_y + 10 end
	table.insert(guicustompage, {
		text = "Toggle Hit Reversal",
		x = 8,
		y = cur_y,
		olcolour = "black",
		handle = 2,
		info = {},
		func = function()
			PECHAN_CONFIG.HIT.reversal = PECHAN_CONFIG.HIT.reversal + 1
			if PECHAN_CONFIG.HIT.reversal > 2 then
				PECHAN_CONFIG.HIT.reversal = 0
			end
		end,
		autofunc = function(this)
			if (PECHAN_CONFIG.HIT.reversal == PECHAN_CONFIG.HIT.REVERSAL_OPTIONS.OFF) then
				this.text = tl("ui.hit.reversal.off")
			elseif (PECHAN_CONFIG.HIT.reversal == PECHAN_CONFIG.HIT.REVERSAL_OPTIONS.ON) then
				this.text = tl("ui.hit.reversal.on")
			elseif (PECHAN_CONFIG.HIT.reversal == PECHAN_CONFIG.HIT.REVERSAL_OPTIONS.RANDOM) then
				this.text = tl("ui.hit.reversal.random")
			end
		end,
	})
end

cur_y = cur_y + 15
table.insert(guicustompage, {
	text = tl("ui.menu.other_settings"),
	x = 2,
	y = cur_y,
})
cur_y = cur_y + 10

if current_game.has_wakeup then
	table.insert(guicustompage, {
		text = "WakeUp Reversal",
		x = 8,
		y = cur_y,
		olcolour = "black",
		handle = 2,
		info = {},
		func = function()
			if next(PECHAN_CONFIG.WAKEUP.reversal_moves) == nil then
				return
			end
			PECHAN_CONFIG.WAKEUP.reversal = PECHAN_CONFIG.WAKEUP.reversal + 1
			if PECHAN_CONFIG.WAKEUP.reversal > 2 then
				PECHAN_CONFIG.WAKEUP.reversal = 0
			end
			if PECHAN_CONFIG.WAKEUP.reversal ~= PECHAN_CONFIG.WAKEUP.REVERSAL_OPTIONS.OFF then
				PECHAN_CONFIG.WAKEUP.dummy_waking_up = true
			else
				PECHAN_CONFIG.WAKEUP.dummy_waking_up = false
			end
		end,
		autofunc = function(this)
			if (PECHAN_CONFIG.WAKEUP.reversal == PECHAN_CONFIG.WAKEUP.REVERSAL_OPTIONS.OFF) then
				this.text = tl("ui.wakeup.reversal.off")
			elseif (PECHAN_CONFIG.WAKEUP.reversal == PECHAN_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON) then
				this.text = tl("ui.wakeup.reversal.on")
			elseif (PECHAN_CONFIG.WAKEUP.reversal == PECHAN_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM) then
				this.text = tl("ui.wakeup.reversal.random")
			end
		end,
	})
end

if current_game.has_recovery then
	table.insert(guicustompage, {
		text = "Enable Tech Recovery",
		x = 118,
		y = cur_y,
		olcolour = "black",
		handle = 2,
		info = { "Controls how many frames until the character takes to do the reversal", "Because depending on the mo " },
		func = function()
			PECHAN_CONFIG.RECOVERY.recovery = PECHAN_CONFIG.RECOVERY.recovery + 1
			if PECHAN_CONFIG.RECOVERY.recovery > 2 then
				PECHAN_CONFIG.RECOVERY.recovery = 0
			end
			if PECHAN_CONFIG.RECOVERY.recovery ~= PECHAN_CONFIG.RECOVERY.OPTIONS.OFF then
				PECHAN_CONFIG.RECOVERY.dummy_recovering = true
			else
				PECHAN_CONFIG.RECOVERY.dummy_recovering = false
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.RECOVERY.recovery == PECHAN_CONFIG.RECOVERY.OPTIONS.OFF then
				this.text = tl("ui.recovery.tech.off")
			elseif PECHAN_CONFIG.RECOVERY.recovery == PECHAN_CONFIG.RECOVERY.OPTIONS.ON then
				this.text = tl("ui.recovery.tech.on")
			elseif PECHAN_CONFIG.RECOVERY.recovery == PECHAN_CONFIG.RECOVERY.OPTIONS.RANDOM then
				this.text = tl("ui.recovery.tech.random")
			end
		end,
	})
	cur_y = cur_y + 10
	table.insert(guicustompage,
		{ text = tl("ui.recovery.delay"), x = 8, y = cur_y, olcolour = "black", info = { "this is the delay it will take on frames and the times of the recovery" } })
	table.insert(guicustompage,
		{
			text = "-",
			x = 40 + 34,
			y = cur_y,
			olcolour = "black",
			info = {},
			func = function()
				if PECHAN_CONFIG.RECOVERY.delay > 0 then
					PECHAN_CONFIG.RECOVERY.delay =
						PECHAN_CONFIG.RECOVERY.delay - 1
				end
			end
		})
	table.insert(guicustompage,
		{
			text = tostring(PECHAN_CONFIG.RECOVERY.delay),
			x = 40 + 45,
			y = cur_y,
			olcolour = "black",
			info = {},
			func = function() end,
			autofunc = function(
				this)
				this.text = tostring(PECHAN_CONFIG.RECOVERY.delay)
			end
		})
	table.insert(guicustompage,
		{
			text = "+",
			x = 40 + 60,
			y = cur_y,
			olcolour = "black",
			info = {},
			func = function()
				PECHAN_CONFIG.RECOVERY.delay =
					PECHAN_CONFIG.RECOVERY.delay + 1
			end
		})

	table.insert(guicustompage,
		{ text = tl("ui.recovery.times"), x = 118, y = cur_y, olcolour = "black", info = { "this is the delay it will take on frames and the times of the recovery" } })
	table.insert(guicustompage,
		{
			text = "-",
			x = 150 + 34,
			y = cur_y,
			olcolour = "black",
			info = {},
			func = function()
				if PECHAN_CONFIG.RECOVERY.times > 1 then
					PECHAN_CONFIG.RECOVERY.times =
						PECHAN_CONFIG.RECOVERY.times - 1
				end
			end
		})
	table.insert(guicustompage,
		{
			text = tostring(PECHAN_CONFIG.RECOVERY.times),
			x = 150 + 45,
			y = cur_y,
			olcolour = "black",
			info = {},
			func = function() end,
			autofunc = function(
				this)
				this.text = tostring(PECHAN_CONFIG.RECOVERY.times)
			end
		})
	table.insert(guicustompage,
		{
			text = "+",
			x = 150 + 60,
			y = cur_y,
			olcolour = "black",
			info = {},
			func = function()
				PECHAN_CONFIG.RECOVERY.times =
					PECHAN_CONFIG.RECOVERY.times + 1
			end
		})
end

cur_y = cur_y + 8
table.insert(guicustompage, { text = tl("ui.menu.reversal_settings"), x = 2, y = cur_y })
cur_y = cur_y + 12

local left_y = cur_y
local right_y = cur_y

if current_game.has_guard then
	table.insert(guicustompage,
		{
			text = tl("ui.reversals.guard"),
			x = 8,
			y = left_y,
			olcolour = "black",
			handle = 9,
			func = function()
				CIG(
					"guard_reversal_move_active_settings", 1)
			end
		})
	table.insert(guicustompage,
		{
			text = "()",
			x = 8,
			y = left_y + 8,
			olcolour = "black",
			handle = 2,
			info = { "active moves for reversal on guard" },
			func = function() end,
			autofunc = function(this)
				local txt = ""; for i, v in ipairs(PECHAN_CONFIG.GUARD.reversal_moves) do
					txt = txt ..
						(i == 1 and v or ", " .. v)
				end; this.text = "(" .. txt .. ")"
			end
		})
	left_y = left_y + 18
end

if current_game.has_wakeup then
	table.insert(guicustompage,
		{
			text = tl("ui.reversals.wakeup"),
			x = 8,
			y = left_y,
			handle = 9,
			func = function()
				CIG(
					"wakeup_reversal_move_active_settings", 1)
			end
		})
	table.insert(guicustompage,
		{
			text = "()",
			x = 8,
			y = left_y + 8,
			olcolour = "black",
			handle = 8,
			func = function() end,
			autofunc = function(this)
				local txt = ""; for i, v in ipairs(PECHAN_CONFIG.WAKEUP.reversal_moves) do
					txt = txt ..
						(i == 1 and v or ", " .. v)
				end; this.text = "(" .. txt .. ")"
			end
		})
	left_y = left_y + 18
end

if current_game.has_hit_reversal then
	table.insert(guicustompage,
		{
			text = tl("ui.reversals.hit"),
			x = 8,
			y = left_y,
			handle = 9,
			func = function()
				CIG(
					"hit_reversal_move_active_settings", 1)
			end
		})
	table.insert(guicustompage,
		{
			text = "()",
			x = 8,
			y = left_y + 8,
			olcolour = "black",
			handle = 8,
			func = function() end,
			autofunc = function(this)
				local txt = ""; for i, v in ipairs(PECHAN_CONFIG.HIT.reversal_moves) do
					txt = txt ..
						(i == 1 and v or ", " .. v)
				end; this.text = "(" .. txt .. ")"
			end
		})
	left_y = left_y + 18
end

if current_game.has_dummy_settings then
	table.insert(guicustompage,
		{
			text = tl("ui.menu.p1_dummy_settings"),
			x = 118,
			y = right_y,
			olcolour = "black",
			handle = 8,
			func = function()
				CIG(
					"p1_and_dummy_settings", 1)
			end
		})
	right_y = right_y + 12
end

if current_game.has_character_selection then
	table.insert(guicustompage,
		{
			text = tl("ui.menu.char_selection"),
			x = 118,
			y = right_y,
			olcolour = "black",
			handle = 9,
			func = function()
				CIG(
					"character_select_settings", 1)
			end
		})
	right_y = right_y + 12
end

if current_game.has_cpu_settings then
	table.insert(guicustompage,
		{
			text = tl("ui.menu.cpu_settings"),
			x = 118,
			y = right_y,
			olcolour = "black",
			handle = 9,
			func = function()
				CIG(
					"cpu_settings", 1)
			end
		})
	right_y = right_y + 12
end

table.insert(guicustompage, { text = tl("ui.menu.configurations"), x = 118, y = right_y })
right_y = right_y + 12

if current_game.has_setups_configuration then
	table.insert(guicustompage,
		{
			text = tl("ui.menu.load_setup"),
			x = 118,
			y = right_y,
			olcolour = "black",
			handle = 2,
			info = { "load here the recorded setup from recording" },
			func = function()
				CIG("activate_current_recording_setup", 1)
			end
		})
	right_y = right_y + 12
	table.insert(guicustompage,
		{
			text = tl("ui.menu.current_conf"),
			x = 118,
			y = right_y,
			olcolour = "black",
			handle = 2,
			info = { "active moves for reversal on guard" },
			func = function()
				PECHAN_CONFIG.TRAINING.current_configuration = PECHAN_CONFIG.TRAINING.current_configuration + 1; if PECHAN_CONFIG.TRAINING.current_configuration > 11 then PECHAN_CONFIG.TRAINING.current_configuration = -1 end; setDefaultConfig(
					PECHAN_CONFIG.TRAINING.current_configuration)
			end,
			autofunc = function(this)
				this.text = "Current Conf: " ..
					getIndexFromConfigValue(PECHAN_CONFIG.TRAINING.current_configuration)
			end
		})
	right_y = right_y + 12
end

if current_game.has_trials then
	table.insert(guicustompage,
		{
			text = tl("ui.menu.trial_mode"),
			x = 118,
			y = right_y,
			olcolour = "black",
			handle = 9,
			func = function()
				if PECHAN_CONFIG.get_current_game().name == "The King of Fighters '98" then
					CIG("trial_mode_settings", 1)
				end
			end
		})
	right_y = right_y + 15
end

cur_y = math.max(left_y, right_y) + 10

local trial_mode_settings = {
	title = {
		text = "Trial Mode (KOF98 Only)",
		x = interactivegui.boxxlength / 2 - 60,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(0, 1) end,
	},
	{
		text = "Trial 1: The Destined Battle",
		x = 10,
		y = 15,
		olcolour = "black",
		info = { "Perform a 3-hit combo after the dialogue." },
		func = function()
			local Trials = require("addon.pechan_training_mod.ai.trials")
			Trials.load_trial(1)
		end,
	}
}
guipages.trial_mode_settings = trial_mode_settings

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
local DBIndex = DBIndex or require("addon.pechan_training_mod.db_lua.db.index")
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
			PECHAN_CONFIG.CPU.vs_enabled = PECHAN_CONFIG.CPU.vs_enabled + 1
			if PECHAN_CONFIG.CPU.vs_enabled > 1 then
				PECHAN_CONFIG.CPU.vs_enabled = 0
			end
			if PECHAN_CONFIG.CPU.vs_enabled ~= PECHAN_CONFIG.CPU.OPTIONS.OFF then
				PECHAN_CONFIG.CPU.dummy_can_fight = true
			else
				PECHAN_CONFIG.CPU.dummy_can_fight = false
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.CPU.vs_enabled == PECHAN_CONFIG.CPU.OPTIONS.OFF then
				this.text = tl("ui.cpu.enable.off")
			elseif PECHAN_CONFIG.CPU.vs_enabled == PECHAN_CONFIG.CPU.OPTIONS.ON then
				this.text = tl("ui.cpu.enable.on")
			end
		end,
	},
	["2"] = {
		x = 10,
		y = 20,
		info = { 'set CPU difficulty' },
		func = function()
			PECHAN_CONFIG.CPU.HAS_CHANGED       = true
			PECHAN_CONFIG.CPU.current_dificulty = PECHAN_CONFIG.CPU.current_dificulty + 1
			if PECHAN_CONFIG.CPU.current_dificulty > 7 then
				PECHAN_CONFIG.CPU.current_dificulty = 0
			end
			print("current dificulty " .. PECHAN_CONFIG.CPU.current_dificulty)
		end,
		text = "Dummy Difficulty",
		olcolour = "black",
		autofunc = function(this)
			this.text = tl("ui.cpu.difficulty", { diff = PECHAN_CONFIG.CPU:getDifficultyString(rb(0x10FD8E)) })
		end,
	},
	["3"] = {
		x = 10,
		y = 32,
		info = { 'Guard Cancel CD' },
		func = function()
			PECHAN_CONFIG.CPU.GCCD.current_gccd = PECHAN_CONFIG.CPU.GCCD.current_gccd + 1
			if PECHAN_CONFIG.CPU.GCCD.current_gccd > 2 then
				PECHAN_CONFIG.CPU.GCCD.current_gccd = 0
			end

			if PECHAN_CONFIG.CPU.GCCD.current_gccd ~= PECHAN_CONFIG.CPU.GCCD.OPTIONS.OFF then
				PECHAN_CONFIG.CPU.GCCD.dummy_can_gccd = true
			else
				PECHAN_CONFIG.CPU.GCCD.dummy_can_gccd = false
			end
		end,
		text = "CD on Guard:",
		olcolour = "black",
		autofunc = function(this)
			if PECHAN_CONFIG.CPU.GCCD.current_gccd == PECHAN_CONFIG.CPU.GCCD.OPTIONS.OFF then
				this.text = tl("ui.cpu.gccd.off")
			elseif PECHAN_CONFIG.CPU.GCCD.current_gccd == PECHAN_CONFIG.CPU.GCCD.OPTIONS.ON then
				this.text = tl("ui.cpu.gccd.on")
			elseif PECHAN_CONFIG.CPU.GCCD.current_gccd == PECHAN_CONFIG.CPU.GCCD.OPTIONS.RANDOM then
				this.text = tl("ui.cpu.gccd.random")
			end
		end,
	},
	["4"] = {
		x = 10,
		y = 44,
		info = { 'Guard Cancel AB' },
		func = function()
			PECHAN_CONFIG.CPU.GCAB.current_gcab = PECHAN_CONFIG.CPU.GCAB.current_gcab + 1
			if PECHAN_CONFIG.CPU.GCAB.current_gcab > 2 then
				PECHAN_CONFIG.CPU.GCAB.current_gcab = 0
			end

			if PECHAN_CONFIG.CPU.GCAB.current_gcab ~= PECHAN_CONFIG.CPU.GCAB.OPTIONS.OFF then
				PECHAN_CONFIG.CPU.GCAB.dummy_can_gcab = true
			else
				PECHAN_CONFIG.CPU.GCAB.dummy_can_gcab = false
			end
		end,
		text = "AB on Guard:",
		olcolour = "black",
		autofunc = function(this)
			if PECHAN_CONFIG.CPU.GCAB.current_gcab == PECHAN_CONFIG.CPU.GCAB.OPTIONS.OFF then
				this.text = tl("ui.cpu.gcab.off")
			elseif PECHAN_CONFIG.CPU.GCAB.current_gcab == PECHAN_CONFIG.CPU.GCAB.OPTIONS.ON then
				this.text = tl("ui.cpu.gcab.on")
			elseif PECHAN_CONFIG.CPU.GCAB.current_gcab == PECHAN_CONFIG.CPU.GCAB.OPTIONS.RANDOM then
				this.text = tl("ui.cpu.gcab.random")
			end
		end,
	},
	["5"] = {
		x = 10,
		y = 56,
		info = { 'Guard OS' },
		func = function()
			PECHAN_CONFIG.CPU.THROW_OS_ON_JUMP = not PECHAN_CONFIG.CPU.THROW_OS_ON_JUMP
		end,
		text = "Guard OS:",
		olcolour = "black",
		autofunc = function(this)
			if PECHAN_CONFIG.CPU.THROW_OS_ON_JUMP then
				this.text = tl("ui.cpu.os.on")
			else
				this.text = tl("ui.cpu.os.off")
			end
		end,
	},
}


for key, item in pairs(cpu_data) do
	table.insert(guipages.cpu_settings, item)
end
local p1_and_dummy_settings = {
	title = {
		text = tl("ui.p1_dummy.title"),
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
			PECHAN_CONFIG.DIZZY.enabled = PECHAN_CONFIG.DIZZY.enabled + 1
			if PECHAN_CONFIG.DIZZY.enabled > 1 then
				PECHAN_CONFIG.DIZZY.enabled = 0
			end
			if PECHAN_CONFIG.DIZZY.enabled ~= PECHAN_CONFIG.DIZZY.OPTIONS.OFF then
				PECHAN_CONFIG.DIZZY.dummy_can_dizzy = true
			else
				PECHAN_CONFIG.DIZZY.dummy_can_dizzy = false
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.DIZZY.enabled == PECHAN_CONFIG.DIZZY.OPTIONS.OFF then
				this.text = tl("ui.p1_dummy.dizzy.off")
			elseif PECHAN_CONFIG.DIZZY.enabled == PECHAN_CONFIG.DIZZY.OPTIONS.ON then
				this.text = tl("ui.p1_dummy.dizzy.on")
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
			PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED = PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED + 1
			if PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED > 1 then
				PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED = 0
			end
			if PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED ~= PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.OPTIONS.OFF then
				PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.can_crouch_guard = true
			else
				PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.can_crouch_guard = false
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED == PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.OPTIONS.OFF then
				this.text = tl("ui.p1_dummy.p1_crouch_guard.off")
			elseif PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.ENABLED == PECHAN_CONFIG.PLAYERS.PLAYER1.CROUCH_GUARD.OPTIONS.ON then
				this.text = tl("ui.p1_dummy.p1_crouch_guard.on")
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
			PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED = PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED + 1
			if PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED > 1 then
				PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED = 0
			end
			if PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED ~= PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.OPTIONS.OFF then
				PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.can_be_countered = true
			else
				PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.can_be_countered = false
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED == PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.OPTIONS.OFF then
				this.text = tl("ui.p1_dummy.counter.off")
			elseif PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.ENABLED == PECHAN_CONFIG.PLAYERS.PLAYER2.COUNTER.OPTIONS.ON then
				this.text = tl("ui.p1_dummy.counter.on")
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
			PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE = PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE + 1
			if PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE > 2 then
				PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE = 0
			end
			if PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.NORMAL then
				PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.state_toggled = false
			else
				PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.state_toggled = true
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.NORMAL then
				this.text = tl("ui.p1_dummy.guard_break.normal")
			elseif PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.NEVER then
				this.text = tl("ui.p1_dummy.guard_break.never")
			elseif PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.STATE == PECHAN_CONFIG.PLAYERS.PLAYER2.GUARD_BREAK.OPTIONS.ALWAYS then
				this.text = tl("ui.p1_dummy.guard_break.always")
			end
		end,
	},
	["lang"] = {
		text = "Language / Idioma",
		x = 10,
		y = 56,
		olcolour = "black",
		handle = 4,
		func = function()
			if PECHAN_CONFIG.LANGUAGE.current_language == PECHAN_CONFIG.LANGUAGE.OPTIONS.EN then
				PECHAN_CONFIG.LANGUAGE.current_language = PECHAN_CONFIG.LANGUAGE.OPTIONS.ES
			else
				PECHAN_CONFIG.LANGUAGE.current_language = PECHAN_CONFIG.LANGUAGE.OPTIONS.EN
			end
			local translate_mod = require("addon.pechan_training_mod.translate_mod")
			translate_mod.set_locale(PECHAN_CONFIG.LANGUAGE.current_language)
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.LANGUAGE.current_language == PECHAN_CONFIG.LANGUAGE.OPTIONS.EN then
				this.text = "Language: English"
			else
				this.text = "Idioma: Español"
			end
		end,
	},
	["5"] = {
		text = "Debug Block",
		x = 118,
		y = 8,
		olcolour = "black",
		handle = 5,
		func = function()
			PECHAN_CONFIG.DEBUG.BLOCK = PECHAN_CONFIG.DEBUG.BLOCK == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.BLOCK == 1 and "On" or "Off")
			this.text = tl("ui.debug.block", { state = state })
		end,
	},
	["6"] = {
		text = "Debug Advantage",
		x = 118,
		y = 20,
		olcolour = "black",
		handle = 5,
		func = function()
			PECHAN_CONFIG.DEBUG.ADVANTAGE = PECHAN_CONFIG.DEBUG.ADVANTAGE == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.ADVANTAGE == 1 and "On" or "Off")
			this.text = tl("ui.debug.advantage", { state = state })
		end,
	},
	["7"] = {
		text = "Debug Action",
		x = 118,
		y = 32,
		olcolour = "black",
		handle = 6,
		func = function()
			PECHAN_CONFIG.DEBUG.ACTION = PECHAN_CONFIG.DEBUG.ACTION == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.ACTION == 1 and "On" or "Off")
			this.text = tl("ui.debug.action", { state = state })
		end,
	},
	["8"] = {
		text = "Debug Position",
		x = 118,
		y = 44,
		olcolour = "black",
		handle = 7,
		func = function()
			PECHAN_CONFIG.DEBUG.POSITION = PECHAN_CONFIG.DEBUG.POSITION == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.POSITION == 1 and "On" or "Off")
			this.text = tl("ui.debug.position", { state = state })
		end,
	},
	["9"] = {
		text = "Debug Stun",
		x = 118,
		y = 56,
		olcolour = "black",
		handle = 8,
		func = function()
			PECHAN_CONFIG.DEBUG.STUN = PECHAN_CONFIG.DEBUG.STUN == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.STUN == 1 and "On" or "Off")
			this.text = tl("ui.debug.stun", { state = state })
		end,
	},
	["10"] = {
		text = "Debug Guard",
		x = 118,
		y = 68,
		olcolour = "black",
		handle = 9,
		func = function()
			PECHAN_CONFIG.DEBUG.GUARD = PECHAN_CONFIG.DEBUG.GUARD == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.GUARD == 1 and "On" or "Off")
			this.text = tl("ui.debug.guard", { state = state })
		end,
	},
	["11"] = {
		text = "Debug Distance",
		x = 118,
		y = 80,
		olcolour = "black",
		handle = 10,
		func = function()
			PECHAN_CONFIG.DEBUG.DISTANCE = PECHAN_CONFIG.DEBUG.DISTANCE == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.DISTANCE == 1 and "On" or "Off")
			this.text = tl("ui.debug.distance", { state = state })
		end,
	},
	["12"] = {
		text = "Debug State",
		x = 118,
		y = 92,
		olcolour = "black",
		handle = 11,
		func = function()
			PECHAN_CONFIG.DEBUG.STATE = PECHAN_CONFIG.DEBUG.STATE == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.STATE == 1 and "On" or "Off")
			this.text = tl("ui.debug.state", { state = state })
		end,
	},
	["13"] = {
		text = "Debug Meter",
		x = 118,
		y = 104,
		olcolour = "black",
		handle = 12,
		func = function()
			PECHAN_CONFIG.DEBUG.METER = PECHAN_CONFIG.DEBUG.METER == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.METER == 1 and "On" or "Off")
			this.text = tl("ui.debug.meter", { state = state })
		end,
	},
	["14"] = {
		text = "Debug Frame Data",
		x = 118,
		y = 116,
		olcolour = "black",
		handle = 13,
		func = function()
			PECHAN_CONFIG.DEBUG.FRAMEDATA = PECHAN_CONFIG.DEBUG.FRAMEDATA + 1
			if PECHAN_CONFIG.DEBUG.FRAMEDATA > 3 then
				PECHAN_CONFIG.DEBUG.FRAMEDATA = 0
			end
		end,
		autofunc = function(this)
			local states = { [0] = "Off", [1] = "P1", [2] = "P2", [3] = "Both" }
			local state = (states[PECHAN_CONFIG.DEBUG.FRAMEDATA] or "Off")
			this.text = tl("ui.debug.frame_data", { state = state })
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

local function generate_character_popup(char, player_side, back_page, parent_x, parent_y)
	local popup_entries = {}
	local cur_y = 15

	-- Add character name as an inactive but styling "title" entry
	table.insert(popup_entries, {
		text = (player_side == 1 and "P1" or "P2") .. ": " .. (char.name or ""),
		x = -(#((player_side == 1 and "P1" or "P2") .. ": " .. (char.name or "")) * 2), -- Try to center it roughly
		y = 0,
		olcolour = "black",
		func = function() end, -- Inactive
		autofunc = function(i)
			-- Provide a wrapper that sets text colour on the actual menu item
			return function(this)
				this.textcolour = "yellow"
			end
		end,
	})

	local function add_option(label, assignment_func)
		table.insert(popup_entries, {
			text = label,
			releasefunc = function()
				return function()
					assignment_func()
					CIG(back_page, interactivegui.selection)
				end
			end,
		})
	end

	if player_side == 1 then
		add_option("Make P1", function()
			PECHAN_CONFIG.UI.P1_STRIKER1 = (PECHAN_CONFIG.UI.P1_STRIKER1 == char) and nil or PECHAN_CONFIG.UI
				.P1_STRIKER1
			if PECHAN_CONFIG.get_current_game().has_3_strikers then
				PECHAN_CONFIG.UI.P1_STRIKER2 = (PECHAN_CONFIG.UI.P1_STRIKER2 == char) and nil or
					PECHAN_CONFIG.UI.P1_STRIKER2
				PECHAN_CONFIG.UI.P1_STRIKER3 = (PECHAN_CONFIG.UI.P1_STRIKER3 == char) and nil or
					PECHAN_CONFIG.UI.P1_STRIKER3
			end
			PECHAN_CONFIG.UI.CURRENT_PLAYER1 = char
		end)
		if PECHAN_CONFIG.get_current_game().has_strikers then
			add_option("Make P1 Striker 1", function()
				PECHAN_CONFIG.UI.CURRENT_PLAYER1 = (PECHAN_CONFIG.UI.CURRENT_PLAYER1 == char) and nil or
					PECHAN_CONFIG.UI.CURRENT_PLAYER1
				if PECHAN_CONFIG.get_current_game().has_3_strikers then
					PECHAN_CONFIG.UI.P1_STRIKER2 = (PECHAN_CONFIG.UI.P1_STRIKER2 == char) and nil or
						PECHAN_CONFIG.UI.P1_STRIKER2
					PECHAN_CONFIG.UI.P1_STRIKER3 = (PECHAN_CONFIG.UI.P1_STRIKER3 == char) and nil or
						PECHAN_CONFIG.UI.P1_STRIKER3
				end
				PECHAN_CONFIG.UI.P1_STRIKER1 = char
				PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE = 0
			end)
			if PECHAN_CONFIG.get_current_game().has_3_strikers then
				add_option("Make P1 Striker 2", function()
					PECHAN_CONFIG.UI.CURRENT_PLAYER1 = (PECHAN_CONFIG.UI.CURRENT_PLAYER1 == char) and nil or
						PECHAN_CONFIG.UI.CURRENT_PLAYER1
					PECHAN_CONFIG.UI.P1_STRIKER1 = (PECHAN_CONFIG.UI.P1_STRIKER1 == char) and nil or
						PECHAN_CONFIG.UI.P1_STRIKER1
					PECHAN_CONFIG.UI.P1_STRIKER3 = (PECHAN_CONFIG.UI.P1_STRIKER3 == char) and nil or
						PECHAN_CONFIG.UI.P1_STRIKER3
					PECHAN_CONFIG.UI.P1_STRIKER2 = char
				end)
				add_option("Make P1 Striker 3", function()
					PECHAN_CONFIG.UI.CURRENT_PLAYER1 = (PECHAN_CONFIG.UI.CURRENT_PLAYER1 == char) and nil or
						PECHAN_CONFIG.UI.CURRENT_PLAYER1
					PECHAN_CONFIG.UI.P1_STRIKER1 = (PECHAN_CONFIG.UI.P1_STRIKER1 == char) and nil or
						PECHAN_CONFIG.UI.P1_STRIKER1
					PECHAN_CONFIG.UI.P1_STRIKER2 = (PECHAN_CONFIG.UI.P1_STRIKER2 == char) and nil or
						PECHAN_CONFIG.UI.P1_STRIKER2
					PECHAN_CONFIG.UI.P1_STRIKER3 = char
				end)
			end
		end
		add_option("Unassign", function()
			if PECHAN_CONFIG.UI.CURRENT_PLAYER1 == char then PECHAN_CONFIG.UI.CURRENT_PLAYER1 = nil end
			if PECHAN_CONFIG.get_current_game().has_strikers and PECHAN_CONFIG.UI.P1_STRIKER1 == char then
				PECHAN_CONFIG.UI.P1_STRIKER1 = nil; PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE = 0
			end
			if PECHAN_CONFIG.get_current_game().has_3_strikers then
				if PECHAN_CONFIG.UI.P1_STRIKER2 == char then PECHAN_CONFIG.UI.P1_STRIKER2 = nil end
				if PECHAN_CONFIG.UI.P1_STRIKER3 == char then PECHAN_CONFIG.UI.P1_STRIKER3 = nil end
			end
		end)
	else
		add_option("Make P2", function()
			PECHAN_CONFIG.UI.P2_STRIKER1 = (PECHAN_CONFIG.UI.P2_STRIKER1 == char) and nil or PECHAN_CONFIG.UI
				.P2_STRIKER1
			if PECHAN_CONFIG.get_current_game().has_3_strikers then
				PECHAN_CONFIG.UI.P2_STRIKER2 = (PECHAN_CONFIG.UI.P2_STRIKER2 == char) and nil or
					PECHAN_CONFIG.UI.P2_STRIKER2
				PECHAN_CONFIG.UI.P2_STRIKER3 = (PECHAN_CONFIG.UI.P2_STRIKER3 == char) and nil or
					PECHAN_CONFIG.UI.P2_STRIKER3
			end
			PECHAN_CONFIG.UI.CURRENT_PLAYER2 = char
		end)
		if PECHAN_CONFIG.get_current_game().has_strikers then
			add_option("Make P2 Striker 1", function()
				PECHAN_CONFIG.UI.CURRENT_PLAYER2 = (PECHAN_CONFIG.UI.CURRENT_PLAYER2 == char) and nil or
					PECHAN_CONFIG.UI.CURRENT_PLAYER2
				if PECHAN_CONFIG.get_current_game().has_3_strikers then
					PECHAN_CONFIG.UI.P2_STRIKER2 = (PECHAN_CONFIG.UI.P2_STRIKER2 == char) and nil or
						PECHAN_CONFIG.UI.P2_STRIKER2
					PECHAN_CONFIG.UI.P2_STRIKER3 = (PECHAN_CONFIG.UI.P2_STRIKER3 == char) and nil or
						PECHAN_CONFIG.UI.P2_STRIKER3
				end
				PECHAN_CONFIG.UI.P2_STRIKER1 = char
				PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE = 0
			end)
			if PECHAN_CONFIG.get_current_game().has_3_strikers then
				add_option("Make P2 Striker 2", function()
					PECHAN_CONFIG.UI.CURRENT_PLAYER2 = (PECHAN_CONFIG.UI.CURRENT_PLAYER2 == char) and nil or
						PECHAN_CONFIG.UI.CURRENT_PLAYER2
					PECHAN_CONFIG.UI.P2_STRIKER1 = (PECHAN_CONFIG.UI.P2_STRIKER1 == char) and nil or
						PECHAN_CONFIG.UI.P2_STRIKER1
					PECHAN_CONFIG.UI.P2_STRIKER3 = (PECHAN_CONFIG.UI.P2_STRIKER3 == char) and nil or
						PECHAN_CONFIG.UI.P2_STRIKER3
					PECHAN_CONFIG.UI.P2_STRIKER2 = char
				end)
				add_option("Make P2 Striker 3", function()
					PECHAN_CONFIG.UI.CURRENT_PLAYER2 = (PECHAN_CONFIG.UI.CURRENT_PLAYER2 == char) and nil or
						PECHAN_CONFIG.UI.CURRENT_PLAYER2
					PECHAN_CONFIG.UI.P2_STRIKER1 = (PECHAN_CONFIG.UI.P2_STRIKER1 == char) and nil or
						PECHAN_CONFIG.UI.P2_STRIKER1
					PECHAN_CONFIG.UI.P2_STRIKER2 = (PECHAN_CONFIG.UI.P2_STRIKER2 == char) and nil or
						PECHAN_CONFIG.UI.P2_STRIKER2
					PECHAN_CONFIG.UI.P2_STRIKER3 = char
				end)
			end
		end
		add_option("Unassign", function()
			if PECHAN_CONFIG.UI.CURRENT_PLAYER2 == char then PECHAN_CONFIG.UI.CURRENT_PLAYER2 = nil end
			if PECHAN_CONFIG.get_current_game().has_strikers and PECHAN_CONFIG.UI.P2_STRIKER1 == char then
				PECHAN_CONFIG.UI.P2_STRIKER1 = nil; PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE = 0
			end
			if PECHAN_CONFIG.get_current_game().has_3_strikers then
				if PECHAN_CONFIG.UI.P2_STRIKER2 == char then PECHAN_CONFIG.UI.P2_STRIKER2 = nil end
				if PECHAN_CONFIG.UI.P2_STRIKER3 == char then PECHAN_CONFIG.UI.P2_STRIKER3 = nil end
			end
		end)
	end

	-- Create the dynamic popup bound to the current selection. We pass it off to InteractiveGUI by wrapping it.
	-- `interactiveguipages[interactivegui.page]` is the current character list page
	-- We pass `guipages[back_page]` to `createPopUpMenu` to inherit its references if needed.

	-- We construct the popup on the fly, map it to a temporary string key "char_popup"
	guipages["char_popup"] = createPopUpMenu(guipages[back_page], nil, nil, nil, popup_entries, parent_x - 30,
		parent_y - 20)

	-- Re-run the table formatter to ensure navigation inside the popup works
	if formatGuiTables then formatGuiTables() end

	-- Jump to the newly created popup menu page
	CIG("char_popup", 2) -- Start at index 2 to skip the title
end

local characters = PECHAN_CONFIG.get_current_game().characters
local chars_per_page = 28
local total_pages = math.ceil(#characters / chars_per_page)
if total_pages == 0 then total_pages = 1 end

for page = 1, total_pages do
	local page_name = "character_select_page_" .. page
	local page_table = {
		title = {
			text = tl("ui.character.title", { page = page, total_pages = total_pages }),
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
				local char = PECHAN_CONFIG.get_current_game().characters[i]
				generate_character_popup(char, 1, page_name, basex + 37, yloc)
			end,
			autofunc = function(this)
				local char = PECHAN_CONFIG.get_current_game().characters[i]
				if PECHAN_CONFIG.UI.CURRENT_PLAYER1 == char then
					this.text = "P1"
				elseif PECHAN_CONFIG.get_current_game().has_strikers and PECHAN_CONFIG.UI.P1_STRIKER1 == char then
					this.text = "S1"
				elseif PECHAN_CONFIG.get_current_game().has_3_strikers and PECHAN_CONFIG.UI.P1_STRIKER2 == char then
					this.text = "S2"
				elseif PECHAN_CONFIG.get_current_game().has_3_strikers and PECHAN_CONFIG.UI.P1_STRIKER3 == char then
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
				local char = PECHAN_CONFIG.get_current_game().characters[i]
				generate_character_popup(char, 2, page_name, basex + 54, yloc)
			end,
			autofunc = function(this)
				local char = PECHAN_CONFIG.get_current_game().characters[i]
				if PECHAN_CONFIG.UI.CURRENT_PLAYER2 == char then
					this.text = "P2"
				elseif PECHAN_CONFIG.get_current_game().has_strikers and PECHAN_CONFIG.UI.P2_STRIKER1 == char then
					this.text = "S1"
				elseif PECHAN_CONFIG.get_current_game().has_3_strikers and PECHAN_CONFIG.UI.P2_STRIKER2 == char then
					this.text = "S2"
				elseif PECHAN_CONFIG.get_current_game().has_3_strikers and PECHAN_CONFIG.UI.P2_STRIKER3 == char then
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

	local current_game_config = PECHAN_CONFIG.get_current_game()

	if current_game_config.has_ex then
		table.insert(page_table, {
			y = 10,
			x = 144,
			info = { 'P1 Ex character' },
			func = function()
				if PECHAN_CONFIG.UI.CURRENT_PLAYER1.has_ex then
					PECHAN_CONFIG.UI.PLAYER1_EX = not PECHAN_CONFIG.UI.PLAYER1_EX
				end
			end,
			text = "P1 Ex",
			olcolour = "black",
			autofunc = function(this)
				if not PECHAN_CONFIG.UI.CURRENT_PLAYER1.has_ex then
					this.text = tl("ui.character.p1_ex.none")
				elseif PECHAN_CONFIG.UI.PLAYER1_EX == true then
					this.text = tl("ui.character.p1_ex.on")
				else
					this.text = tl("ui.character.p1_ex.off")
				end
			end,
		})

		table.insert(page_table, {
			y = 22,
			x = 144,
			info = { 'P2 Ex character' },
			func = function()
				if PECHAN_CONFIG.UI.CURRENT_PLAYER2.has_ex then
					PECHAN_CONFIG.UI.PLAYER2_EX = not PECHAN_CONFIG.UI.PLAYER2_EX
				end
			end,
			text = "P2 Ex",
			olcolour = "black",
			autofunc = function(this)
				if not PECHAN_CONFIG.UI.CURRENT_PLAYER2.has_ex then
					this.text = tl("ui.character.p2_ex.none")
				elseif PECHAN_CONFIG.UI.PLAYER2_EX == true then
					this.text = tl("ui.character.p2_ex.on")
				else
					this.text = tl("ui.character.p2_ex.off")
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
				PECHAN_CONFIG.UI.PLAYER1_MODE = PECHAN_CONFIG.UI.PLAYER1_MODE + 1
				PECHAN_CONFIG.UI.MODE_HAS_CHANGED = true
				if PECHAN_CONFIG.UI.PLAYER1_MODE > 1 then
					PECHAN_CONFIG.UI.PLAYER1_MODE = 0
				end
			end,
			text = "P1 Mode",
			olcolour = "black",
			autofunc = function(this)
				if PECHAN_CONFIG.UI.PLAYER1_MODE == PECHAN_CONFIG.UI.MODES.EXTRA then
					this.text = tl("ui.character.p1_mode.extra")
				else
					this.text = tl("ui.character.p1_mode.advanced")
				end
			end,
		})

		table.insert(page_table, {
			y = 46,
			x = 144,
			info = { 'P2 Mode' },
			func = function()
				PECHAN_CONFIG.UI.PLAYER2_MODE = PECHAN_CONFIG.UI.PLAYER2_MODE + 1
				PECHAN_CONFIG.UI.MODE_HAS_CHANGED = true
				if PECHAN_CONFIG.UI.PLAYER2_MODE > 1 then
					PECHAN_CONFIG.UI.PLAYER2_MODE = 0
				end
			end,
			text = "P2 Mode",
			olcolour = "black",
			autofunc = function(this)
				if PECHAN_CONFIG.UI.PLAYER2_MODE == PECHAN_CONFIG.UI.MODES.EXTRA then
					this.text = tl("ui.character.p2_mode.extra")
				else
					this.text = tl("ui.character.p2_mode.advanced")
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
					PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE = PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE + 1
					PECHAN_CONFIG.UI.MODE_HAS_CHANGED = true
					local max_mode = (PECHAN_CONFIG.UI.P1_STRIKER1 and PECHAN_CONFIG.UI.P1_STRIKER1.has_maniac) and 2 or
						1
					if PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE > max_mode then
						PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE = 0
					end
				end,
				text = "P1 SK: Regular",
				olcolour = "black",
				autofunc = function(this)
					if PECHAN_CONFIG.UI.P1_STRIKER1 and not PECHAN_CONFIG.UI.P1_STRIKER1.has_maniac and PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE == 2 then
						PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE = 0
					end

					if PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE == 1 then
						this.text = "P1 SK: Alternate"
					elseif PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE == 2 then
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
					PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE = PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE + 1
					PECHAN_CONFIG.UI.MODE_HAS_CHANGED = true
					local max_mode = (PECHAN_CONFIG.UI.P2_STRIKER1 and PECHAN_CONFIG.UI.P2_STRIKER1.has_maniac) and 2 or
						1
					if PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE > max_mode then
						PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE = 0
					end
				end,
				text = "P2 SK: Regular",
				olcolour = "black",
				autofunc = function(this)
					if PECHAN_CONFIG.UI.P2_STRIKER1 and not PECHAN_CONFIG.UI.P2_STRIKER1.has_maniac and PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE == 2 then
						PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE = 0
					end

					if PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE == 1 then
						this.text = "P2 SK: Alternate"
					elseif PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE == 2 then
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
				PECHAN_CONFIG.UI.INFINITE_STRIKERS = PECHAN_CONFIG.UI.INFINITE_STRIKERS + 1
				PECHAN_CONFIG.UI.MODE_HAS_CHANGED = true
				if PECHAN_CONFIG.UI.INFINITE_STRIKERS > 3 then
					PECHAN_CONFIG.UI.INFINITE_STRIKERS = 0
				end
			end,
			text = "Inf Strikers: Off",
			olcolour = "black",
			autofunc = function(this)
				if PECHAN_CONFIG.UI.INFINITE_STRIKERS == 1 then
					this.text = tl("ui.character.inf_strikers.p1")
				elseif PECHAN_CONFIG.UI.INFINITE_STRIKERS == 2 then
					this.text = tl("ui.character.inf_strikers.p2")
				elseif PECHAN_CONFIG.UI.INFINITE_STRIKERS == 3 then
					this.text = tl("ui.character.inf_strikers.both")
				else
					this.text = tl("ui.character.inf_strikers.off")
				end
			end,
		})
	end

	table.insert(page_table, {
		y = 70,
		x = 144,
		info = { 'Load Matchup' },
		func = function()
			PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
		end,
		text = tl("ui.character.apply_changes"),
		textcolour = "white",
		bgcolour = 0x4CAF50FF,
		olcolour = "black",
		autofunc = function(this)
			local pending = false
			local applied = PECHAN_CONFIG.UI.APPLIED
			if PECHAN_CONFIG.UI.CURRENT_PLAYER1 ~= applied.PLAYER1 then pending = true end
			if PECHAN_CONFIG.UI.CURRENT_PLAYER2 ~= applied.PLAYER2 then pending = true end
			if PECHAN_CONFIG.UI.PLAYER1_EX ~= applied.PLAYER1_EX then pending = true end
			if PECHAN_CONFIG.UI.PLAYER2_EX ~= applied.PLAYER2_EX then pending = true end
			if PECHAN_CONFIG.UI.PLAYER1_MODE ~= applied.PLAYER1_MODE then pending = true end
			if PECHAN_CONFIG.UI.PLAYER2_MODE ~= applied.PLAYER2_MODE then pending = true end
			if PECHAN_CONFIG.get_current_game().has_strikers then
				if PECHAN_CONFIG.UI.P1_STRIKER1 ~= applied.P1_STRIKER1 then pending = true end
				if PECHAN_CONFIG.UI.P2_STRIKER1 ~= applied.P2_STRIKER1 then pending = true end
				if PECHAN_CONFIG.UI.INFINITE_STRIKERS ~= applied.INFINITE_STRIKERS then pending = true end

				if emu.romname() == "kof2000" then
					if PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE ~= applied.PLAYER1_STRIKER_MODE then pending = true end
					if PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE ~= applied.PLAYER2_STRIKER_MODE then pending = true end
				end
				if PECHAN_CONFIG.get_current_game().has_3_strikers then
					if PECHAN_CONFIG.UI.P1_STRIKER2 ~= applied.P1_STRIKER2 then pending = true end
					if PECHAN_CONFIG.UI.P1_STRIKER3 ~= applied.P1_STRIKER3 then pending = true end
					if PECHAN_CONFIG.UI.P2_STRIKER2 ~= applied.P2_STRIKER2 then pending = true end
					if PECHAN_CONFIG.UI.P2_STRIKER3 ~= applied.P2_STRIKER3 then pending = true end
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
				text = tl("ui.character.prev_page"),
				olcolour = "black",
				func = function() CIG("character_select_page_" .. (page - 1), 1) end,
			})
		end
		if page < total_pages then
			table.insert(page_table, {
				y = 102,
				x = 144,
				info = { 'Next Page' },
				text = tl("ui.character.next_page"),
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
