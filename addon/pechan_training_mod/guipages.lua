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
		text = tl("ui.guard.action_title"),
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
		text = tl("ui.guard.guard_title"),
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
		text = tl("ui.guard.reversal_title"),
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
		text = tl("ui.hit.reversal_title"),
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

if current_game.has_other_settings then
	cur_y = cur_y + 15
	table.insert(guicustompage, {
		text = tl("ui.menu.other_settings"),
		x = 2,
		y = cur_y,
	})
	cur_y = cur_y + 10
end

if current_game.has_wakeup then
	table.insert(guicustompage, {
		text = tl("ui.wakeup.reversal_title"),
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
		text = tl("ui.recovery.tech_title"),
		x = 118,
		y = cur_y,
		olcolour = "black",
		handle = 2,
		info = { tl("ui.info.tech_recovery_1"), tl("ui.info.tech_recovery_2") },
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
		{ text = tl("ui.recovery.delay"), x = 8, y = cur_y, olcolour = "black", info = { tl("ui.info.recovery_delay") } })
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
		{ text = tl("ui.recovery.times"), x = 118, y = cur_y, olcolour = "black", info = { tl("ui.info.recovery_delay") } })
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
			info = { tl("ui.info.reversal_moves") },
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

if current_game.has_replays then
	table.insert(guicustompage, {
		text = "Manage Replays",
		x = 8,
		y = left_y,
		olcolour = "black",
		handle = 1,
		info = { "Manage recording slots, weights, and loop settings" },
		func = function()
			CIG("managerecordings", 1)
		end,
	})
	left_y = left_y + 12
end

guipages["managerecordings"] = {
	title = {
		text = "Manage Replays",
		x = interactivegui.boxxlength / 2 - (#"Manage Replays") * 2,
		y = 1,
	},
	{
		text = "<<",
		x = 0,
		y = 0,
		olcolour = "black",
		handle = 1,
		info = { "Return to previous menu" },
		func = function()
			CIG(0, 1)
		end,
	},
}

table.insert(guipages["managerecordings"], {
	text = "Loop Recording: Off",
	x = 8,
	y = 15,
	olcolour = "black",
	handle = 1,
	info = {},
	func = function()
		local count = 0
		for i = 1, 5 do
			if PECHAN_CONFIG.RECORDING.slots[i].enabled then count = count + 1 end
		end
		if count > 0 then
			PECHAN_CONFIG.RECORDING.loop = not PECHAN_CONFIG.RECORDING.loop
		else
			PECHAN_CONFIG.RECORDING.loop = false
		end
		-- Keep core variable false to allow addon to handle delay
		recording.loop = false
	end,
	autofunc = function(this)
		if PECHAN_CONFIG.RECORDING.loop then
			this.text = "Loop Recording: On"
		else
			this.text = "Loop Recording: Off"
		end
		-- Force core variable to false in case it was set elsewhere
		recording.loop = false
	end,
})

table.insert(guipages["managerecordings"], {
	text = "Wait Frames: 0",
	x = 100,
	y = 15,
	olcolour = "black",
	handle = 1,
	info = { "Frames to wait after dummy is idle before restarting recording. (Right: +5, Left: -5)" },
	func = function()
		local step = 5
		if guiinputs and guiinputs.P1 and guiinputs.P1.left then
			step = -5
		end
		PECHAN_CONFIG.RECORDING.cooldown = PECHAN_CONFIG.RECORDING.cooldown + step
		if PECHAN_CONFIG.RECORDING.cooldown < 0 then
			PECHAN_CONFIG.RECORDING.cooldown = 0
		elseif PECHAN_CONFIG.RECORDING.cooldown > 600 then
			PECHAN_CONFIG.RECORDING.cooldown = 600
		end
	end,
	autofunc = function(this)
		this.text = "Wait Frames: " .. PECHAN_CONFIG.RECORDING.cooldown
	end,
})

local ry = 30
for i = 1, 5 do
	local current_ry = ry -- Closure fix for popups
	-- Status Button (Number or X)
	table.insert(guipages["managerecordings"], {
		text = "Slot " .. i,
		x = 8,
		y = current_ry,
		olcolour = "black",
		handle = 1,
		info = { "Recording status: Number if exists, X if empty" },
		func = function() end,
		autofunc = function(this)
			local exists = recording[i] and (recording[i].p1start or recording[i].p2start)
			if exists then
				this.text = "[" .. i .. "]"
			else
				this.text = "[X]"
			end
		end,
	})

	-- Weight Button (1-10)
	table.insert(guipages["managerecordings"], {
		text = "Prob: 1",
		x = 35,
		y = current_ry,
		olcolour = "black",
		handle = 1,
		info = { "Probability weight (1-10)" },
		func = function()
			local step = 1
			if guiinputs and guiinputs.P1 and guiinputs.P1.left then
				step = -1
			end
			PECHAN_CONFIG.RECORDING.slots[i].weight = PECHAN_CONFIG.RECORDING.slots[i].weight + step
			if PECHAN_CONFIG.RECORDING.slots[i].weight > 10 then
				PECHAN_CONFIG.RECORDING.slots[i].weight = 1
			elseif PECHAN_CONFIG.RECORDING.slots[i].weight < 1 then
				PECHAN_CONFIG.RECORDING.slots[i].weight = 10
			end
		end,
		autofunc = function(this)
			this.text = "Prob: " .. PECHAN_CONFIG.RECORDING.slots[i].weight
		end,
	})

	-- Enabled Checkbox
	table.insert(guipages["managerecordings"], {
		text = "[ ]",
		x = 85,
		y = current_ry,
		olcolour = "black",
		handle = 1,
		info = { "Include in loop" },
		func = function()
			PECHAN_CONFIG.RECORDING.slots[i].enabled = not PECHAN_CONFIG.RECORDING.slots[i].enabled
			-- If unticking the last slot, disable loop
			if not PECHAN_CONFIG.RECORDING.slots[i].enabled then
				local count = 0
				for j = 1, 5 do
					if PECHAN_CONFIG.RECORDING.slots[j].enabled then count = count + 1 end
				end
				if count == 0 then
					recording.loop = false
					PECHAN_CONFIG.RECORDING.loop = false
				end
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.RECORDING.slots[i].enabled then
				this.text = "[X]"
			else
				this.text = "[ ]"
			end
		end,
	})

	-- Savestate Selector
	table.insert(guipages["managerecordings"], {
		text = "State: None",
		x = 115,
		y = current_ry,
		olcolour = "black",
		handle = 1,
		info = { "Reload a savestate slot before this recording playback starts." },
		func = function()
			local states = PECHAN_HELPERS.get_available_savestates()
			local entries = {
				{
					label = tl("ui.p1_dummy.recording.none"),
					action = function()
						PECHAN_CONFIG.RECORDING.slots[i].savestate_reload_slot = -1
						PECHAN_CONFIG.RECORDING.slots[i].savestate_reload_path = nil
					end
				}
			}
			for _, s in ipairs(states) do
				table.insert(entries, {
					label = s.label,
					action = function()
						PECHAN_CONFIG.RECORDING.slots[i].savestate_reload_slot = s.slot
						PECHAN_CONFIG.RECORDING.slots[i].savestate_reload_path = s.path
					end
				})
			end
			PECHAN_HELPERS.create_context_popup(tl("ui.p1_dummy.recording.popup_title"), entries, "managerecordings", 115,
				current_ry + 10)
		end,
		autofunc = function(this)
			local slot = PECHAN_CONFIG.RECORDING.slots[i].savestate_reload_slot
			local state_text = tl("ui.p1_dummy.recording.none")
			if slot and slot >= 0 then
				state_text = "Slot " .. slot
			end
			this.text = tl("ui.p1_dummy.recording.reload_state", { state = state_text })
		end,
	})
	ry = ry + 12
end

table.insert(guipages["managerecordings"], {
	text = "Save Replay Setup",
	x = 8,
	y = ry + 5,
	olcolour = "white",
	bgcolour = 0x444444FF,
	info = { "Save all 5 recording slots, weights and wait frames" },
	releasefunc = function()
		if isRecordingEmpty() then
			return
		end
		local setup = buildSetup()
		setup.base_name = "replay"
		local DBIndex = DBIndex or require("addon.pechan_training_mod.db_lua.db.index")
		DBIndex.createSetup(setup, false, true) -- isTrial = false, isReplay = true
		if refreshReplaySetupMenu then refreshReplaySetupMenu() end
	end,
	autofunc = function(this)
		if isRecordingEmpty() then
			this.text = "Recording Setup: Empty"
		else
			this.text = "Save Replay Setup"
		end
	end,
})

table.insert(guipages["managerecordings"], {
	text = "Load Replay Setup",
	x = 100,
	y = ry + 5,
	olcolour = "white",
	bgcolour = 0x444444FF,
	info = { "Select from saved independent replay setups" },
	func = function()
		CIG("activate_replay_recording_setup", 1)
	end,
})

left_y = left_y + 12

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

if current_game.has_setups_configuration then
	table.insert(guicustompage, { text = tl("ui.menu.configurations"), x = 118, y = right_y })
	right_y = right_y + 12
end

if current_game.has_setups_configuration then
	table.insert(guicustompage,
		{
			text = tl("ui.menu.load_setup"),
			x = 118,
			y = right_y,
			olcolour = "black",
			handle = 2,
			info = { tl("ui.info.load_setup") },
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
			info = { tl("ui.info.reversal_moves") },
			func = function()
				PECHAN_CONFIG.TRAINING.current_configuration = PECHAN_CONFIG.TRAINING.current_configuration + 1
				if PECHAN_CONFIG.TRAINING.current_configuration > 11 then
					PECHAN_CONFIG.TRAINING.current_configuration = -1
				end
				setDefaultConfig(PECHAN_CONFIG.TRAINING.current_configuration)
			end,
			autofunc = function(this)
				this.text = tl("ui.menu.current_conf") .. " " ..
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
		text = tl("ui.menu.trial_mode"),
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
		text = "Save Trial Setup",
		x = 130,
		y = 15,
		olcolour = "black",
		func = function()
			saveTrialSetup()
			refreshTrialSetupMenu()
		end,
	},
	{
		text = "Load Trial Setups",
		x = 130,
		y = 27,
		olcolour = "black",
		func = function()
			CIG("activate_trial_recording_setup", 1)
		end,
	},
}

local function buildSetupPages(setups, base_page_name, page_title, back_page, include_save_btn)
	local ITEMS_PER_PAGE = 10
	local total_pages = math.ceil(#setups / ITEMS_PER_PAGE)
	if total_pages == 0 then total_pages = 1 end

	for page = 1, total_pages do
		local page_name = base_page_name .. (page == 1 and "" or "_" .. page)
		local page_table = {
			title = {
				text = page_title .. " (Pg " .. page .. "/" .. total_pages .. ")",
				x = interactivegui.boxxlength / 2 - (#page_title + 7) * 2,
				y = 1,
			},
			{
				text = "<",
				olcolour = "black",
				info = "Back",
				func = function() CIG(back_page, 1) end,
			}
		}

		local start_y = 10

		if include_save_btn and page == 1 then
			table.insert(page_table, {
				text = "Save Current Setup",
				x = 10,
				y = start_y,
				olcolour = "white",
				bgcolour = 0x444444FF,
				info = { "Save the current reversal config to a new setup file" },
				releasefunc = function()
					if isRecordingEmpty() then
						return
					end
					local setup = buildSetup()
					setup.wakeup = true
					setup.guard = true
					setup.hit = true
					local DBIndex = DBIndex or require("addon.pechan_training_mod.db_lua.db.index")
					DBIndex.createSetup(setup)
					if refreshSetupMenu then refreshSetupMenu() end
				end,
				autofunc = function(this)
					if isRecordingEmpty() then
						this.text = "Setup to Save: N/A"
					else
						this.text = "Save Setup for: " .. getCurrentSetupName()
					end
				end,
			})
			start_y = start_y + 14
		end

		local item_start_y = start_y
		local spacing = 12
		local start_idx = (page - 1) * ITEMS_PER_PAGE + 1
		local end_idx = math.min(page * ITEMS_PER_PAGE, #setups)

		for i = start_idx, end_idx do
			local setup = setups[i]
			table.insert(page_table, {
				x = 10,
				y = item_start_y + (i - start_idx) * spacing,
				text = setup.title or (setup[1] and setup[1].title) or setup.base_name or
					(setup[1] and setup[1].base_name),
				olcolour = "black",
				fillpercent = 1,
				checked = false,
				setup_ref = setup,
				func = function()
					-- Uncheck all other items across all pages dynamically
					for p = 1, total_pages do
						local p_name = base_page_name .. (p == 1 and "" or "_" .. p)
						if guipages[p_name] then
							for _, el in ipairs(guipages[p_name]) do
								if el.text and el.checked ~= nil then
									el.checked = false
								end
							end
						end
					end
					-- Check this one
					local el = guipages[page_name][interactivegui.selection]
					if el then el.checked = true end
					-- Load the selected setup
					applySetup(setup)
				end,
				autofunc = function(this)
					if this.checked then
						this.fillpercent = 1
					else
						this.fillpercent = 0
					end
				end
			})
		end

		page_table.other_func = function()
			local sel = interactivegui.selection
			local el = page_table[sel]
			local setup = el and el.setup_ref
			local description = setup and (setup.description or (setup[1] and setup[1].description))

			if description then
				-- Position the box on the right half of the menu
				local box_x = 145
				local box_y = 20
				local box_w = 100
				local box_h = 110

				gui.box(box_x, box_y, box_x + box_w, box_y + box_h, 0x000000CC, "red")

				-- Word wrap (approx 4 pixels per char)
				local chars_per_line = math.floor((box_w - 8) / 4)
				local lines = {}
				-- Handle manual newlines first
				for paragraph in description:gmatch("([^\n]*)\n?") do
					if paragraph == "" then
						table.insert(lines, "")
					else
						-- Then wrap long paragraphs
						while #paragraph > 0 do
							if #paragraph <= chars_per_line then
								table.insert(lines, paragraph)
								paragraph = ""
							else
								local split_idx = chars_per_line
								-- Try to split at space
								local space_idx = paragraph:sub(1, chars_per_line):match(".*() ")
								if space_idx and space_idx > 5 then
									split_idx = space_idx
								end
								table.insert(lines, paragraph:sub(1, split_idx))
								paragraph = paragraph:sub(split_idx + 1)
							end
						end
					end
				end

				for line_idx, line_text in ipairs(lines) do
					if line_idx * 10 > box_h - 10 then break end
					gui.text(box_x + 4, box_y + 4 + (line_idx - 1) * 10, line_text, "white")
				end
			end
		end

		guipages[page_name] = page_table

		-- Pagination buttons
		if page > 1 then
			local prev_page_name = base_page_name .. (page == 2 and "" or "_" .. (page - 1))
			table.insert(page_table, {
				y = 145,
				x = 30,
				info = { 'Previous Page' },
				text = "<< Prev",
				olcolour = "black",
				func = function() CIG(prev_page_name, 1) end,
			})
		end
		if page < total_pages then
			local next_page_name = base_page_name .. "_" .. (page + 1)
			table.insert(page_table, {
				y = 145,
				x = 144,
				info = { 'Next Page' },
				text = "Next >>",
				olcolour = "black",
				func = function() CIG(next_page_name, 1) end,
			})
		end

		guipages[page_name] = page_table
	end
end


local Trials = require("addon.pechan_training_mod.ai.trials")
local trials = Trials.load_all_trials()
for i, trial in ipairs(trials) do
	table.insert(trial_mode_settings, {
		text = "Trial " .. trial.id .. ": " .. trial.name,
		x = 10,
		y = 15 + (i - 1) * 12,
		olcolour = "black",
		info = { trial.description },
		func = function()
			Trials.load_trial(trial.id)
		end,
	})
end
guipages.trial_mode_settings = trial_mode_settings

local activate_trial_recording_setup = {
	title = {
		text = "Trial Setups",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG("trial_mode_settings", 1) end,
	},
}
guipages.activate_trial_recording_setup = activate_trial_recording_setup

local trial_setups = DBIndex.loadAllSetups(true) -- isTrial = true
buildSetupPages(trial_setups, "activate_trial_recording_setup", "Trial Setups", "trial_mode_settings", false)

function refreshTrialSetupMenu()
	local setups = DBIndex.loadAllSetups(true)
	buildSetupPages(setups, "activate_trial_recording_setup", "Trial Setups", "trial_mode_settings", false)
	formatGuiTables()
end

local DBIndex = DBIndex or require("addon.pechan_training_mod.db_lua.db.index")
local setups = DBIndex.loadAllSetups()

buildSetupPages(setups, "activate_current_recording_setup", tl("ui.menu.load_setup"), 0, true)

function refreshSetupMenu()
	local new_setups = DBIndex.loadAllSetups()
	buildSetupPages(new_setups, "activate_current_recording_setup", tl("ui.menu.load_setup"), 0, true)
	formatGuiTables()
end

local replay_setups = DBIndex.loadAllSetups(false, true) -- isTrial = false, isReplay = true
buildSetupPages(replay_setups, "activate_replay_recording_setup", "Replay Setups", "managerecordings", false)

function refreshReplaySetupMenu()
	local setups = DBIndex.loadAllSetups(false, true)
	buildSetupPages(setups, "activate_replay_recording_setup", "Replay Setups", "managerecordings", false)
	formatGuiTables()
end

local cpu_settings = {
	title = {
		text = tl("ui.cpu.title"),
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
		text = "Dummy Player",
		x = 10,
		y = 20,
		olcolour = "black",
		handle = 2,
		func = function()
			local opts = PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.OPTIONS
			if PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.PLAYER == opts.P2 then
				PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.PLAYER = opts.P1
			else
				PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.PLAYER = opts.P2
			end
			-- Update active pointers
			if PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.PLAYER == opts.P2 then
				HumanPlayer = P1
				DummyPlayer = P2
			else
				HumanPlayer = P2
				DummyPlayer = P1
			end
			-- Free both players from CPU lock immediately; the loop will re-hijack the correct Dummy if needed
			wb(P1.base_address + 0x170, 0x01)
			wb(P2.base_address + 0x170, 0x01)
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.PLAYER == PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.OPTIONS.P1 then
				this.text = tl("ui.p1_dummy.dummy_player.p1", "Dummy: P1")
			elseif PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.PLAYER == PECHAN_CONFIG.PLAYERS.PLAYER1.DUMMY_CTRL.OPTIONS.P2 then
				this.text = tl("ui.p1_dummy.dummy_player.p2", "Dummy: P2")
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
	["15"] = {
		text = "3-Coin Swap",
		x = 10,
		y = 68,
		olcolour = "black",
		handle = 14,
		func = function()
			if toggleStates and inputs and inputs.properties then
				-- If swap is currently ON, calling toggleStates({}) turns it OFF (and closes menu)
				-- If swap is OFF, calling toggleStates({swapinputs=true}) turns it ON (and closes menu)
				if inputs.properties.enableinputswap then
					toggleStates({})
				else
					toggleStates({ swapinputs = true })
				end
			end
		end,
		autofunc = function(this)
			if inputs and inputs.properties and inputs.properties.enableinputswap then
				this.text = tl("ui.p1_dummy.coin_swap.on")
			else
				this.text = tl("ui.p1_dummy.coin_swap.off")
			end
		end,
	},
	["0"] = {
		text = "Master Debug",
		x = 10,
		y = 80,
		olcolour = "black",
		handle = 0,
		func = function()
			PECHAN_CONFIG.DEBUG.ENABLED = PECHAN_CONFIG.DEBUG.ENABLED == 0 and 1 or 0
		end,
		autofunc = function(this)
			local state = (PECHAN_CONFIG.DEBUG.ENABLED == 1 and "On" or "Off")
			this.text = tl("ui.debug.master", { state = state })
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
		text = tl("ui.reversals.guard_active_title"),
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
	local previous_selection = interactivegui.selection
	local saved_prev_page = interactivegui.previouspage
	local saved_prev_sel = interactivegui.previousselection

	-- Title will be passed to pechanCreatePopUpMenu as a parameter (non-selectable)
	local popup_title = (player_side == 1 and "P1" or "P2") .. ": " .. (char.name or "")

	local function add_option(label, assignment_func)
		table.insert(popup_entries, {
			text = label,
			bgcolour = 0x222222FF,
			olcolour = "white",
			releasefunc = function()
				assignment_func()
				CIG(back_page, previous_selection)
				interactivegui.previouspage = saved_prev_page
				interactivegui.previousselection = saved_prev_sel
			end,
		})
	end

	if player_side == 1 then
		add_option(tl("ui.character.popup.make_p1"), function()
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
			add_option(tl("ui.character.popup.make_p1_s1"), function()
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
				add_option(tl("ui.character.popup.make_p1_s2"), function()
					PECHAN_CONFIG.UI.CURRENT_PLAYER1 = (PECHAN_CONFIG.UI.CURRENT_PLAYER1 == char) and nil or
						PECHAN_CONFIG.UI.CURRENT_PLAYER1
					PECHAN_CONFIG.UI.P1_STRIKER1 = (PECHAN_CONFIG.UI.P1_STRIKER1 == char) and nil or
						PECHAN_CONFIG.UI.P1_STRIKER1
					PECHAN_CONFIG.UI.P1_STRIKER3 = (PECHAN_CONFIG.UI.P1_STRIKER3 == char) and nil or
						PECHAN_CONFIG.UI.P1_STRIKER3
					PECHAN_CONFIG.UI.P1_STRIKER2 = char
				end)
				add_option(tl("ui.character.popup.make_p1_s3"), function()
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
		add_option(tl("ui.character.popup.unassign"), function()
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
		add_option(tl("ui.character.popup.make_p2"), function()
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
			add_option(tl("ui.character.popup.make_p2_s1"), function()
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
				add_option(tl("ui.character.popup.make_p2_s2"), function()
					PECHAN_CONFIG.UI.CURRENT_PLAYER2 = (PECHAN_CONFIG.UI.CURRENT_PLAYER2 == char) and nil or
						PECHAN_CONFIG.UI.CURRENT_PLAYER2
					PECHAN_CONFIG.UI.P2_STRIKER1 = (PECHAN_CONFIG.UI.P2_STRIKER1 == char) and nil or
						PECHAN_CONFIG.UI.P2_STRIKER1
					PECHAN_CONFIG.UI.P2_STRIKER3 = (PECHAN_CONFIG.UI.P2_STRIKER3 == char) and nil or
						PECHAN_CONFIG.UI.P2_STRIKER3
					PECHAN_CONFIG.UI.P2_STRIKER2 = char
				end)
				add_option(tl("ui.character.popup.make_p2_s3"), function()
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
		add_option(tl("ui.character.popup.unassign"), function()
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

	-- Use our custom popup function with background box and title support
	guipages["char_popup"] = pechanCreatePopUpMenu(
		guipages[back_page], popup_entries,
		parent_x - 30, parent_y - 20,
		0x222222FF, popup_title
	)

	if formatGuiTables then formatGuiTables() end
	CIG("char_popup", 1) -- Start at index 1 (title is not an entry anymore)
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
				if PECHAN_CONFIG.UI.CURRENT_PLAYER1 and PECHAN_CONFIG.UI.CURRENT_PLAYER1.has_ex then
					PECHAN_CONFIG.UI.PLAYER1_EX = not PECHAN_CONFIG.UI.PLAYER1_EX
				end
			end,
			text = "P1 Ex",
			olcolour = "black",
			autofunc = function(this)
				if not PECHAN_CONFIG.UI.CURRENT_PLAYER1 or not PECHAN_CONFIG.UI.CURRENT_PLAYER1.has_ex then
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
				if PECHAN_CONFIG.UI.CURRENT_PLAYER2 and PECHAN_CONFIG.UI.CURRENT_PLAYER2.has_ex then
					PECHAN_CONFIG.UI.PLAYER2_EX = not PECHAN_CONFIG.UI.PLAYER2_EX
				end
			end,
			text = "P2 Ex",
			olcolour = "black",
			autofunc = function(this)
				if not PECHAN_CONFIG.UI.CURRENT_PLAYER2 or not PECHAN_CONFIG.UI.CURRENT_PLAYER2.has_ex then
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
						this.text = tl("ui.character.popup.p1_sk_mode.alternate")
					elseif PECHAN_CONFIG.UI.PLAYER1_STRIKER_MODE == 2 then
						this.text = tl("ui.character.popup.p1_sk_mode.maniac")
					else
						this.text = tl("ui.character.popup.p1_sk_mode.regular")
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
						this.text = tl("ui.character.popup.p2_sk_mode.alternate")
					elseif PECHAN_CONFIG.UI.PLAYER2_STRIKER_MODE == 2 then
						this.text = tl("ui.character.popup.p2_sk_mode.maniac")
					else
						this.text = tl("ui.character.popup.p2_sk_mode.regular")
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
			local current_game = PECHAN_CONFIG.get_current_game()

			if not PECHAN_CONFIG.UI.CURRENT_PLAYER1 or PECHAN_CONFIG.UI.CURRENT_PLAYER1.name == "None" then
				PECHAN_HELPERS.show_error_popup(tl("ui.error.no_character"), page_name, 144, 70)
				return
			end
			if not PECHAN_CONFIG.UI.CURRENT_PLAYER2 or PECHAN_CONFIG.UI.CURRENT_PLAYER2.name == "None" then
				PECHAN_HELPERS.show_error_popup(tl("ui.error.no_character"), page_name, 144, 70)
				return
			end

			if current_game.has_strikers then
				if not (PECHAN_CONFIG.UI.P1_STRIKER1 and PECHAN_CONFIG.UI.P1_STRIKER1.code) then
					PECHAN_HELPERS.show_error_popup(tl("ui.error.missing_striker", { player = "P1", num = 1 }), page_name,
						144, 70)
					return
				end
				if not (PECHAN_CONFIG.UI.P2_STRIKER1 and PECHAN_CONFIG.UI.P2_STRIKER1.code) then
					PECHAN_HELPERS.show_error_popup(tl("ui.error.missing_striker", { player = "P2", num = 1 }), page_name,
						144, 70)
					return
				end
				if current_game.has_3_strikers then
					if not (PECHAN_CONFIG.UI.P1_STRIKER2 and PECHAN_CONFIG.UI.P1_STRIKER2.code) then
						PECHAN_HELPERS.show_error_popup(tl("ui.error.missing_striker", { player = "P1", num = 2 }),
							page_name, 144, 70)
						return
					end
					if not (PECHAN_CONFIG.UI.P1_STRIKER3 and PECHAN_CONFIG.UI.P1_STRIKER3.code) then
						PECHAN_HELPERS.show_error_popup(tl("ui.error.missing_striker", { player = "P1", num = 3 }),
							page_name, 144, 70)
						return
					end
					if not (PECHAN_CONFIG.UI.P2_STRIKER2 and PECHAN_CONFIG.UI.P2_STRIKER2.code) then
						PECHAN_HELPERS.show_error_popup(tl("ui.error.missing_striker", { player = "P2", num = 2 }),
							page_name, 144, 70)
						return
					end
					if not (PECHAN_CONFIG.UI.P2_STRIKER3 and PECHAN_CONFIG.UI.P2_STRIKER3.code) then
						PECHAN_HELPERS.show_error_popup(tl("ui.error.missing_striker", { player = "P2", num = 3 }),
							page_name, 144, 70)
						return
					end
				end
			end

			PECHAN_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
			if toggleStates then
				toggleStates({}) -- Force the menu to close so KofTrainingUpdate can apply the changes
			end
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
