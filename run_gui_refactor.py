import json
import re

content = open('c:/Users/usuario/Documents/Fightcade/emulator/fbneo/fbneo-training-mode/addon/pechan_training_mod/guipages.lua', 'r', encoding='utf-8').read()

# We identify the end of the guicustompage definition (which is around line 456, where it says "}")
# Let's find "local trial_mode_settings ="
parts = content.split('local trial_mode_settings =')
if len(parts) != 2:
    print("Error splitting")

orig = parts[0]
after = parts[1]

# Let's completely rebuild the starting file since it's just GUI definitions!
new_gui = '''local current_game = PECHAN_CONFIG.get_current_game()

guicustompage = {
	title = {
		text = "Pechan's Training Mode Settings",
		x = interactivegui.boxxlength / 2 - (#"Pechan's Training Mode Settings") * 2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
}

local cur_y = 15

if current_game.has_guard then
	table.insert(guicustompage, {
		text = "Guard Settings: ",
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
				this.text = "Action: Standing"
			elseif PECHAN_CONFIG.GUARD.dummy_action == 1 then
				this.text = "Action: Crouching"
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
			if PECHAN_CONFIG.GUARD.guard_mode > 0 then
				PECHAN_CONFIG.GUARD.dummy_guarding = true
			else
				PECHAN_CONFIG.GUARD.dummy_guarding = false
			end
		end,
		autofunc = function(this)
			if PECHAN_CONFIG.GUARD.guard_mode == 0 then
				this.text = "Guard: Off"
			elseif PECHAN_CONFIG.GUARD.guard_mode == 1 then
				this.text = "Guard: On"
			elseif PECHAN_CONFIG.GUARD.guard_mode == 2 then
				this.text = "Guard: Random"
			elseif PECHAN_CONFIG.GUARD.guard_mode == 3 then
				this.text = "Guard: All Guard"
			elseif PECHAN_CONFIG.GUARD.guard_mode == 4 then
				this.text = "Guard: 1 Hit Guard"
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
				this.text = "Enable G. Reversal: Off"
			elseif (PECHAN_CONFIG.GUARD.reversal == PECHAN_CONFIG.GUARD.REVERSAL_OPTIONS.ON) then
				this.text = "Enable G. Reversal: On"
			elseif (PECHAN_CONFIG.GUARD.reversal == PECHAN_CONFIG.GUARD.REVERSAL_OPTIONS.RANDOM) then
				this.text = "Enable G. Reversal: Random"
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
				this.text = "Enable Hit Reversal: Off"
			elseif (PECHAN_CONFIG.HIT.reversal == PECHAN_CONFIG.HIT.REVERSAL_OPTIONS.ON) then
				this.text = "Enable Hit Reversal: On"
			elseif (PECHAN_CONFIG.HIT.reversal == PECHAN_CONFIG.HIT.REVERSAL_OPTIONS.RANDOM) then
				this.text = "Enable Hit Reversal: Random"
			end
		end,
	})
end

cur_y = cur_y + 15
table.insert(guicustompage, {
	text = "Other Settings: ",
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
				this.text = "Wake Up Reversal: Off"
			elseif (PECHAN_CONFIG.WAKEUP.reversal == PECHAN_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON) then
				this.text = "Wake Up Reversal: On"
			elseif (PECHAN_CONFIG.WAKEUP.reversal == PECHAN_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM) then
				this.text = "Wake Up Reversal: Random"
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
		info = {"Controls how many frames until the character takes to do the reversal", "Because depending on the mo "},
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
				this.text = "Tech Recovery: Off"
			elseif PECHAN_CONFIG.RECOVERY.recovery == PECHAN_CONFIG.RECOVERY.OPTIONS.ON then
				this.text = "Tech Recovery: On"
			elseif PECHAN_CONFIG.RECOVERY.recovery == PECHAN_CONFIG.RECOVERY.OPTIONS.RANDOM then
				this.text = "Tech Recovery: Random"
			end
		end,
	})
	cur_y = cur_y + 10
	table.insert(guicustompage, { text = "Recovery Delay:", x = 8, y = cur_y, olcolour = "black", info = {"this is the delay it will take on frames and the times of the recovery"} })
	table.insert(guicustompage, { text = "-", x = 40 + 34, y = cur_y, olcolour = "black", info = {}, func = function() if PECHAN_CONFIG.RECOVERY.delay > 0 then PECHAN_CONFIG.RECOVERY.delay = PECHAN_CONFIG.RECOVERY.delay - 1 end end })
	table.insert(guicustompage, { text = tostring(PECHAN_CONFIG.RECOVERY.delay), x = 40 + 45, y = cur_y, olcolour = "black", info = {}, func = function() end, autofunc = function(this) this.text = tostring(PECHAN_CONFIG.RECOVERY.delay) end })
	table.insert(guicustompage, { text = "+", x = 40 + 60, y = cur_y, olcolour = "black", info = {}, func = function() PECHAN_CONFIG.RECOVERY.delay = PECHAN_CONFIG.RECOVERY.delay + 1 end })
	
	table.insert(guicustompage, { text = "Recovery Times:", x = 118, y = cur_y, olcolour = "black", info = {"this is the delay it will take on frames and the times of the recovery"} })
	table.insert(guicustompage, { text = "-", x = 150 + 34, y = cur_y, olcolour = "black", info = {}, func = function() if PECHAN_CONFIG.RECOVERY.times > 1 then PECHAN_CONFIG.RECOVERY.times = PECHAN_CONFIG.RECOVERY.times - 1 end end })
	table.insert(guicustompage, { text = tostring(PECHAN_CONFIG.RECOVERY.times), x = 150 + 45, y = cur_y, olcolour = "black", info = {}, func = function() end, autofunc = function(this) this.text = tostring(PECHAN_CONFIG.RECOVERY.times) end })
	table.insert(guicustompage, { text = "+", x = 150 + 60, y = cur_y, olcolour = "black", info = {}, func = function() PECHAN_CONFIG.RECOVERY.times = PECHAN_CONFIG.RECOVERY.times + 1 end })
end

cur_y = cur_y + 15
table.insert(guicustompage, { text = "Reversal Move List Settings", x = 2, y = cur_y })
cur_y = cur_y + 10

if current_game.has_guard then
	table.insert(guicustompage, { text = "Guard Reversals", x = 8, y = cur_y, olcolour = "black", handle = 9, func = function() CIG("guard_reversal_move_active_settings", 1) end })
	cur_y = cur_y + 10
	table.insert(guicustompage, { text = "()", x = 8, y = cur_y, olcolour = "black", handle = 2, info = {"active moves for reversal on guard"}, func = function() end, autofunc = function(this) local txt = ""; for i, v in ipairs(PECHAN_CONFIG.GUARD.reversal_moves) do txt = txt .. (i==1 and v or ", " .. v) end; this.text = "(" .. txt .. ")" end })
	cur_y = cur_y - 10
end
if current_game.has_dummy_settings then
	table.insert(guicustompage, { text = "p1 and dummy settings:", x = 118, y = cur_y, olcolour = "black", handle = 8, func = function() CIG("p1_and_dummy_settings", 1) end })
end

cur_y = cur_y + 20

if current_game.has_wakeup then
	table.insert(guicustompage, { text = "WakeUp Reversals", x = 8, y = cur_y, handle = 9, func = function() CIG("wakeup_reversal_move_active_settings", 1) end })
	cur_y = cur_y + 10
	table.insert(guicustompage, { text = "()", x = 8, y = cur_y, olcolour = "black", handle = 8, func = function() end, autofunc = function(this) local txt = ""; for i, v in ipairs(PECHAN_CONFIG.WAKEUP.reversal_moves) do txt = txt .. (i==1 and v or ", " .. v) end; this.text = "(" .. txt .. ")" end })
	cur_y = cur_y - 10
end
if current_game.has_character_selection then
	table.insert(guicustompage, { text = "Character Selecction", x = 118, y = cur_y, olcolour = "black", handle = 9, func = function() CIG("character_select_settings", 1) end })
end

cur_y = cur_y + 20

if current_game.has_hit_reversal then
	table.insert(guicustompage, { text = "Hit Reversals", x = 8, y = cur_y, handle = 9, func = function() CIG("hit_reversal_move_active_settings", 1) end })
	cur_y = cur_y + 10
	table.insert(guicustompage, { text = "()", x = 8, y = cur_y, olcolour = "black", handle = 8, func = function() end, autofunc = function(this) local txt = ""; for i, v in ipairs(PECHAN_CONFIG.HIT.reversal_moves) do txt = txt .. (i==1 and v or ", " .. v) end; this.text = "(" .. txt .. ")" end })
	cur_y = cur_y - 10
end
if current_game.has_cpu_settings then
	table.insert(guicustompage, { text = "CPU settings", x = 118, y = cur_y, olcolour = "black", handle = 9, func = function() CIG("cpu_settings", 1) end })
end

cur_y = cur_y + 20

table.insert(guicustompage, { text = "Configurations: ", x = 118, y = cur_y - 12 })

if current_game.has_setups_configuration then
	table.insert(guicustompage, { text = "Load Recorded Setup: ", x = 118, y = cur_y, olcolour = "black", handle = 2, info = {"load here the recorded setup from recording"}, func = function() CIG("activate_current_recording_setup", 1) end })
	cur_y = cur_y + 13
	table.insert(guicustompage, { text = "Current Conf: ", x = 118, y = cur_y, olcolour = "black", handle = 2, info = {"active moves for reversal on guard"}, func = function() PECHAN_CONFIG.TRAINING.current_configuration = PECHAN_CONFIG.TRAINING.current_configuration + 1; if PECHAN_CONFIG.TRAINING.current_configuration > 11 then PECHAN_CONFIG.TRAINING.current_configuration = -1 end; setDefaultConfig(PECHAN_CONFIG.TRAINING.current_configuration) end, autofunc = function(this) this.text = "Current Conf: " .. getIndexFromConfigValue(PECHAN_CONFIG.TRAINING.current_configuration) end })
end

if current_game.has_trials then
	cur_y = cur_y + 13
	table.insert(guicustompage, { text = "Trial Mode (KOF98)", x = 118, y = cur_y, olcolour = "black", handle = 9, func = function() if PECHAN_CONFIG.get_current_game().name == "The King of Fighters '98" then CIG("trial_mode_settings", 1) end end })
end

\n'''

with open('c:/Users/usuario/Documents/Fightcade/emulator/fbneo/fbneo-training-mode/addon/pechan_training_mod/guipages.lua', 'w', encoding='utf-8') as f:
    f.write(new_gui + '\nlocal trial_mode_settings =' + after)

print("SUCCESS")
