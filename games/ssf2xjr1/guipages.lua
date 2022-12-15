assert(rb,"Run fbneo-training-mode.lua")

guicustompage = {
	title = {
		text = "Super Street Fighter 2X - pof's Training Mode Settings",
		x = interactivegui.boxxlength/2 - (#"Super Street Fighter 2X - pof's Training Mode Settings")*2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Toggle ST HUD",
		x = 8,
		y = 30,
		olcolour = "black",
		handle = 1,
		info = {
			"Display ST specific informations",
			"Complete : Display distance between players, special moves buffers,",
			"stun bar, projectile, cancel and grab infos",
			"Simplified : doesn't display special moves buffers to save screen space"
		},
		func =	function()
				draw_hud = draw_hud + 1
				if draw_hud > 1 then
					draw_hud = -1
				end
			end,
		autofunc = function(this)
				if draw_hud == -1 then
					this.text = "Toggle ST HUD: Off"
				elseif draw_hud == 0 then
					this.text = "Toggle ST HUD: On (Complete)"
				elseif draw_hud == 1 then
					this.text = "Toggle ST HUD: On (Simplified)"
				end
			end,
	},
	{
		text = "AutoBlock",
		x = 8,
		y = 50,
		olcolour = "black",
		handle = 2,
		info = {
			"Control guard / auto-block on P2",
			"Block everything: will guard any ground or jump attack",
			"Block ground attacks: useful to practice combos that start with a jump-in",
			"Block auto: Allow the first hit, block if you drop the combo",
			"Block random: useful to practice hit-confirms"
		},
		func =	function()
				autoblock_selector = autoblock_selector + 1
				if autoblock_selector > 3 then
					autoblock_selector = -1
				end
			end,
		autofunc = function(this)
				if autoblock_selector == -1 then
					this.text = "AutoBlock (P2): Disabled"
				elseif autoblock_selector == 0 then
					this.text = "AutoBlock (P2): Block everything"
				elseif autoblock_selector == 1 then
					this.text = "AutoBlock (P2): Block ground attacks"
				elseif autoblock_selector == 2 then
					this.text = "AutoBlock (P2): Block auto"
				elseif autoblock_selector == 3 then
					this.text = "AutoBlock (P2): Block random"
				end
			end,
	},
	{
		text = "Stun/Dizzy",
		x = 8,
		y = 70,
		olcolour = "black",
		handle = 3,
		info = {
			"Control Stun/Dizzy",
			"Can be normal, off (never dizzy) or on (always dizzy)"
		},
		func =	function()
				dizzy_selector = dizzy_selector + 1
				if dizzy_selector > 1 then
					dizzy_selector = -1
				end
			end,
		autofunc = function(this)
				if dizzy_selector == -1 then
					this.text = "Stun/Dizzy (P2): Normal"
				elseif dizzy_selector == 0 then
					this.text = "Stun/Dizzy (P2): Off (never dizzy)"
				elseif dizzy_selector == 1 then
					this.text = "Stun/Dizzy (P2): On (always dizzy)"
				end
			end,
	},
	{
		text = "Tech Throws",
		x = 8,
		y = 90,
		olcolour = "black",
		handle = 4,
		info = {
			"Make the dummy tech your throws"
		},
		func =	function()
				tech_throw_selector = tech_throw_selector + 1
				if tech_throw_selector > 0 then
					tech_throw_selector = -1
				end
			end,
		autofunc = function(this)
				if tech_throw_selector == -1 then
					this.text = "Tech Throws: Off"
				elseif tech_throw_selector == 0 then
					this.text = "Tech Throws: On"
				end
			end,
	},
	----{
	-- See below for the contextual reversal button
	----}
	{
		text = "Select stage",
		x = 160,
		y = 30,
		olcolour = "black",
		handle = 6,
		info = {
			"Background stage selection",
			"Must be changed on player select screen, before selecting character."
		},
		func =	function()
				stage_selector = stage_selector + 1
				if stage_selector > 0xf then
					stage_selector=-1
				end
			end,
		autofunc = 	function(this)
						if stage_selector == -1 then
							this.text = "Select stage: Disabled"
						elseif stage_selector == 0 then
							this.text = "Stage: Japan (Ryu)"
						elseif stage_selector == 1 then
							this.text = "Stage: Japan (Honda)"
						elseif stage_selector == 2 then
							this.text = "Stage: Brazil (Blanka)"
						elseif stage_selector == 3 then
							this.text = "Stage: USA (Guile)"
						elseif stage_selector == 4 then
							this.text = "Stage: USA (Ken)"
						elseif stage_selector == 5 then
							this.text = "Stage: China (Chun-Li)"
						elseif stage_selector == 6 then
							this.text = "Stage: USSR (Zangief)"
						elseif stage_selector == 7 then
							this.text = "Stage: India (Dhalsim)"
						elseif stage_selector == 8 then
							this.text = "Stage: Thailand (Dictator)"
						elseif stage_selector == 9 then
							this.text = "Stage: Thailand (Sagat)"
						elseif stage_selector == 0xa then
							this.text = "Stage: USA (Boxer)"
						elseif stage_selector == 0xb then
							this.text = "Stage: Spain (Claw)"
						elseif stage_selector == 0xc then
							this.text = "Stage: England (Cammy)"
						elseif stage_selector == 0xd then
							this.text = "Stage: Mexico (T.Hawk)"
						elseif stage_selector == 0xe then
							this.text = "Stage: HongKong (Fei-Long)"
						elseif stage_selector == 0xf then
							this.text = "Stage: Jamaica (DeeJay)"
						end
					end
	},
	----{
	-- See below for the character specific button
	----}
	{
			text = "Advanced Settings",
			x = 8,
			y = 150,
			olcolour = "black",
			handle = 8,
			func = 	function() CIG("advancedsettings", 1) end,
	}
}

-----------------------------------------------------------------------------------
-- Added by peon2 - guipages is a global table so any 'main' pages can be added in game guipages freely
-----------------------------------------------------------------------------------

local reversalsettings = {
	title = {
		text = "Possibilities for reversal (each with the same probability)",
		x = interactivegui.boxxlength/2 - 115,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(interactivegui.previouspage,1) end,
	},
}
guipages.reversalsettings = reversalsettings

local specificsettings = {
	title = {
		text = "Projectiles",
		x = interactivegui.boxxlength/2 - 25,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(interactivegui.previouspage,1) end,
	},
}
guipages.specificsettings = specificsettings

local advancedsettings = {
	title = {
		text = "Advanced settings",
		x = interactivegui.boxxlength/2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(interactivegui.previouspage,1) end,
	},
}
guipages.advancedsettings = advancedsettings

------------------------------------------------


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- Added by Asunaro - Create a Reversal Settings Menu if the game has been patched
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
reversal_options = {} -- Contains the buttons with the relevant informations from character_specific.lua
function makeReversalSettingsButtons()
	local n = 0 -- count the number of reversal options
	local s = 0 -- count the number of unique special moves a character can reversal
	local character = readCharacterName(gamestate.P2)
	local old = gamestate.P2.is_old
	updateForOldChar(gamestate.P2) -- Uses the correct values for old characters
	-- Specials
	for i = 1, #character_specific[character].specials do
		if character_specific[character].specials[i].reversal and ((not old) or (old and not character_specific[character].specials[i].new_only)) then
			s = s + 1
			for k = 1, #character_specific[character].specials[i].input_variations do
			 if (character_specific[character].specials[i].strength_set ~= 0) or (character_specific[character].specials[i].strength_set == 0 and k == 1) then -- Don't display variations for super moves or moves that don't have variations
				n = n + 1
				if k == 1 then
					special_name = character_specific[character].specials[i].name
					horizontal_length = 8
				else
					special_name = ""
					if character_specific[character].specials[i].strength_set ~= -1 then -- Not Dhalsim TP not Boxer TAP
						horizontal_length = 85 + 20*k
					elseif character == "dhalsim" then -- Dhalsim TP
						horizontal_length = 77 + 24*k
					elseif character == "boxer" then -- Boxer TAP
						horizontal_length = 95 + 15*k
					end
				end
				if character_specific[character].specials[i].strength_set == 0 then -- no variations
					special_variation = ""
				else
					special_variation = character_specific[character].specials[i].input_variations[k][1]
				end
				vertical_length = 15 + 15*s
				reversal_options[n] = {
					text = special_name.." "..special_variation,
					x = horizontal_length,
					y = vertical_length,
					--info = tostring(character_specific[character].specials[i].input) -- Maybe add move description
					olcolour = "black",
					fillpercent = 0,
					checked = false,
					reversal_id = {character_specific[character].specials[i].id, determineStrengthValue(character_specific[character].specials[i].input_variations[k][1], character_specific[character].specials[i].strength_set)},
					func = function() end,
					autofunc = function(this)
							if this.checked then
								this.fillpercent = 1
							elseif not this.checked then
								this.fillpercent = 0
							end
						end,
				}
				table.insert(guipages.reversalsettings, reversal_options[n])
				end
			end
		end
	end
	-- Throws
	for i = 1, #character_specific[character].throw do
		n = n + 1
			if i == 1 then
				throw_name = "Throw "..character_specific[character].throw[i]
			else
				throw_name = character_specific[character].throw[i]
			end
			if i > 1 then
				horizontal_length = 15 + 17*i
			else
				horizontal_length = 8
			end
		reversal_options[n] = {
				text = throw_name,
				x = horizontal_length,
				y = vertical_length + 15,
				--info = tostring(character_specific[character].specials[i].input) -- Maybe add move description
				olcolour = "black",
				fillpercent = 0,
				checked = false,
				reversal_id = {"throw",character_specific[character].throw[i]},
				func = function() end,
				autofunc = function(this)
						if this.checked then
							this.fillpercent = 1
						elseif not this.checked then
							this.fillpercent = 0
						end
					end,
			}
		table.insert(guipages.reversalsettings, reversal_options[n])
	end
end

function insertReversalSettingsFunctions() -- Maybe there's a cleaner way ?
	local newfunction = nil
	for i = 1, #reversal_options do
		if i == 1 then
		newfunction = function()
				reversal_options[1].checked = not reversal_options[1].checked
				end
		elseif i == 2 then
			newfunction = function()
				reversal_options[2].checked = not reversal_options[2].checked
				end
		elseif i == 3 then
			newfunction = function()
				reversal_options[3].checked = not reversal_options[3].checked
				end
		elseif i == 4 then
			newfunction = function()
				reversal_options[4].checked = not reversal_options[4].checked
				end
		elseif i == 5 then
			newfunction = function()
				reversal_options[5].checked = not reversal_options[5].checked
				end
		elseif i == 6 then
			newfunction = function()
				reversal_options[6].checked = not reversal_options[6].checked
				end
		elseif i == 7 then
			newfunction = function()
				reversal_options[7].checked = not reversal_options[7].checked
				end
		elseif i == 8 then
			newfunction = function()
				reversal_options[8].checked = not reversal_options[8].checked
				end
		elseif i == 9 then
			newfunction = function()
				reversal_options[9].checked = not reversal_options[9].checked
				end
		elseif i == 10 then
			newfunction = function()
				reversal_options[10].checked = not reversal_options[10].checked
				end
		elseif i == 11 then
			newfunction = function()
				reversal_options[11].checked = not reversal_options[11].checked
				end
		elseif i == 12 then
			newfunction = function()
				reversal_options[12].checked = not reversal_options[12].checked
				end
		elseif i == 13 then
			newfunction = function()
				reversal_options[13].checked = not reversal_options[13].checked
				end
		elseif i == 14 then
			newfunction = function()
				reversal_options[14].checked = not reversal_options[14].checked
				end
		elseif i == 15 then
			newfunction = function()
				reversal_options[15].checked = not reversal_options[15].checked
				end
		elseif i == 16 then
			newfunction = function()
				reversal_options[16].checked = not reversal_options[16].checked
				end
		elseif i == 17 then
			newfunction = function()
				reversal_options[17].checked = not reversal_options[17].checked
				end
		elseif i == 18 then
			newfunction = function()
				reversal_options[18].checked = not reversal_options[18].checked
				end
		elseif i == 19 then
			newfunction = function()
				reversal_options[19].checked = not reversal_options[19].checked
				end
		elseif i == 20 then
			newfunction = function()
				reversal_options[20].checked = not reversal_options[20].checked
				end
		elseif i == 21 then
			newfunction = function()
				reversal_options[21].checked = not reversal_options[21].checked
				end
		elseif i == 22 then
			newfunction = function()
				reversal_options[22].checked = not reversal_options[22].checked
				end
		elseif i == 23 then
			newfunction = function()
				reversal_options[23].checked = not reversal_options[23].checked
				end
		elseif i == 24 then
			newfunction = function()
				reversal_options[24].checked = not reversal_options[24].checked
				end
		elseif i == 25 then
			newfunction = function()
				reversal_options[25].checked = not reversal_options[25].checked
				end
		elseif i == 26 then
			newfunction = function()
				reversal_options[26].checked = not reversal_options[26].checked
				end
		elseif i == 27 then
			newfunction = function()
				reversal_options[27].checked = not reversal_options[27].checked
				end
		elseif i == 28 then
			newfunction = function()
				reversal_options[28].checked = not reversal_options[28].checked
				end
		end
		reversal_options[i].func = newfunction
	end
end

do_not_reversal = { -- If checked, the dummy won't reversal, randomly
				text = "Nothing",
				x = 8,
				y = 155,
				olcolour = "black",
				info = {
					"If this option is checked, the dummy won't reversal, randomly",
					"Useful if you want the dummy to mix between reversal and guard"
				},
				fillpercent = 0,
				checked = false,
				func =	function()
						do_not_reversal.checked = not do_not_reversal.checked
				end,
			autofunc = function(this)
					if this.checked then
						this.fillpercent = 1
					elseif not this.checked then
						this.fillpercent = 0
					end
				end,
			}
table.insert(guipages.reversalsettings, do_not_reversal)

custom_sequence = { -- When the dummy goes out of blockstun/hitsun or lands on his feet,plays a sequence defined in the Replay Editor
				text = "Custom Sequence",
				x = 44,
				y = 155,
				olcolour = "black",
				info = {
				"Try to reversal the sequence defined in the replay slot"
				},
				fillpercent = 0,
				checked = false,
				func =	function()
					custom_sequence.checked = not custom_sequence.checked
					end,
				autofunc = function(this)
					if this.checked then
						this.fillpercent = 1
					elseif not this.checked then
						this.fillpercent = 0
					end
				end,
			}
table.insert(guipages.reversalsettings, custom_sequence)

reversal_frequence = { -- When the dummy goes out of blockstun/hitsun or lands on his feet,plays a sequence defined in the Replay Editor
				text = "Reversal : settings",
				x = 165,
				y = 155,
				olcolour = "black",
				info = {
					"Controls when a reversal should be performed"
				},
				fillpercent = 0,
				checked = false,
				func =	function()
						reversal_trigger_selector = reversal_trigger_selector + 1
						if reversal_trigger_selector > 3 then
							reversal_trigger_selector = -1
						end
					end,
				autofunc = function(this)
					if reversal_trigger_selector == -1 then
						this.text = "Reversal : Always"
					elseif reversal_trigger_selector == 0 then
						this.text = "Reversal : Knockdown only"
					elseif reversal_trigger_selector == 1 then
						this.text = "Reversal : Non-Knockdown only"
					elseif reversal_trigger_selector == 2 then
						this.text = "Reversal : Once"
					elseif reversal_trigger_selector == 3 then
						this.text = "Reversal : Off"
					end
				end,
			}
table.insert(guipages.reversalsettings, reversal_frequence)

customPageConfiguration = { -- Two different buttons depending on whether the game has been patched or not
	{
		text = "AutoReversal",
		x = 8,
		y = 110,
		olcolour = "black",
		handle = 5,
		info = {
			"Control reversal on P2",
			"Use the Replay Editor in the Recording menu to program the desired reversal action."
		},
		func =	function()
				autoreversal_selector = autoreversal_selector + 1
				if autoreversal_selector > 0 then
					autoreversal_selector = -1
				end
			end,
		autofunc = function(this)
				if autoreversal_selector == -1 then
					this.text = "AutoReversal (P2): Disabled"
				elseif autoreversal_selector == 0 then
					this.text = "AutoReversal (P2): Enabled"
				end
			end,
	},
	{
			text = "Select Reversal",
			x = 8,
			y = 110,
			olcolour = "black",
			handle = 5,
			info = {
				"In this menu, you can choose the moves you want to get as reversals",
			},
			func = 	function() CIG("reversalsettings", 1) end, -- "reversalsettings" has been placed in "fbneo-training-mode/guipages.lua(l.588)", maybe there's a way to place it in this file ?
	}
}
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- Asunaro - Some more training options
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

----------------------------------
-- Character Specific
----------------------------------
character_specific_settings = {
	throw_projectiles =
	{
			text = "Throw Projectiles",
			x = 160,
			y = 50,
			olcolour = "black",
			handle = 7,
			info = {
				"In this menu you can choose the projectiles you want to be thrown",
			},
			func = 	function() CIG("specificsettings", 1) end, -- "specifcsettings" has been placed in "fbneo-training-mode/guipages.lua(l.588)", maybe there's a way to place it in this file ?
	},
	projectile_frequence = {
		text = "Fire : ",
		x = 8,
		y = 155,
		olcolour = "black",
		info = "Controls when a projectile should be thrown",
		func =	function()
				projectile_frequence_selector = projectile_frequence_selector + 1
				if projectile_frequence_selector > 0 then
					projectile_frequence_selector = -1
				end
			end,
		autofunc = function(this)
				if projectile_frequence_selector == -1 then
					this.text = "Fire : When able"
				elseif projectile_frequence_selector == 0 then
					this.text = "Fire : Randomly"
				end
			end,
	},
}
 ---------------------
 -- Projectiles
 ---------------------
projectile_options = {}
table.insert(guipages.specificsettings, character_specific_settings["projectile_frequence"])
table.insert(guipages.specificsettings, character_specific_settings["random_range"])

function makeProjectileSettingsButtons()
	local n = 0 -- count the number of projectile options
	local character = readCharacterName(gamestate.P2)
	local special_id = {}
	if character == "chunli" then
		table.insert(guicustompage, character_specific_settings["throw_projectiles"])
		special_id = {3}
	elseif character == "deejay" then
		table.insert(guicustompage, character_specific_settings["throw_projectiles"])
		special_id = {3}
	elseif character == "dhalsim" then
		table.insert(guicustompage, character_specific_settings["throw_projectiles"])
		special_id = {1,2,3,7}
	elseif character == "guile" then
		table.insert(guicustompage, character_specific_settings["throw_projectiles"])
		special_id = {1}
	elseif character == "ken" then
		table.insert(guicustompage, character_specific_settings["throw_projectiles"])
		special_id = {1}
	elseif character == "ryu" then
		table.insert(guicustompage, character_specific_settings["throw_projectiles"])
		special_id = {1,4,5}
	elseif character == "sagat" then
		table.insert(guicustompage, character_specific_settings["throw_projectiles"])
		special_id = {1,2}
	end

	for k = 1, #special_id do
		for i = 1, #character_specific[character].specials[special_id[k]].input_variations do
			if character_specific[character].specials[special_id[k]].strength_set ~= 0 or (character_specific[character].specials[special_id[k]].strength_set == 0 and i == 1) then
				n = n + 1
				if i == 1 then
					projectile_name = character_specific[character].specials[special_id[k]].name
					horizontal_length = 8
				else
					projectile_name = ""
					horizontal_length = 40 + 23*i
				end
				vertical_length = 35+15*k
				if character_specific[character].specials[special_id[k]].strength_set == 0 then -- no variations
					projectile_variation = ""
				else
					projectile_variation = character_specific[character].specials[special_id[k]].input_variations[i][1]
				end
				projectile_options[n] = {
					text = projectile_name.." "..projectile_variation,
					x = horizontal_length,
					y = vertical_length,
					olcolour = "black",
					fillpercent = 0,
					checked = false,
					projectile_id = {special_id[k], i},
					func = function() end,
					autofunc = function(this)
							if this.checked then
								this.fillpercent = 1
							elseif not this.checked then
								this.fillpercent = 0
							end
						end,
				}
				table.insert(guipages.specificsettings, projectile_options[n])
			end
		end
	end
end

function insertProjectileSettingsFunctions() -- Maybe there's a cleaner way ?
	local newfunction = nil
	for i = 1, #projectile_options do
		if i == 1 then
		newfunction = function()
				projectile_options[1].checked = not projectile_options[1].checked
				end
		elseif i == 2 then
			newfunction = function()
				projectile_options[2].checked = not projectile_options[2].checked
				end
		elseif i == 3 then
			newfunction = function()
				projectile_options[3].checked = not projectile_options[3].checked
				end
		elseif i == 4 then
			newfunction = function()
				projectile_options[4].checked = not projectile_options[4].checked
				end
		elseif i == 5 then
			newfunction = function()
				projectile_options[5].checked = not projectile_options[5].checked
				end
		elseif i == 6 then
			newfunction = function()
				projectile_options[6].checked = not projectile_options[6].checked
				end
		elseif i == 7 then
			newfunction = function()
				projectile_options[7].checked = not projectile_options[7].checked
				end
		elseif i == 8 then
			newfunction = function()
				projectile_options[8].checked = not projectile_options[8].checked
				end
		elseif i == 9 then
			newfunction = function()
				projectile_options[9].checked = not projectile_options[9].checked
				end
		elseif i == 10 then
			newfunction = function()
				projectile_options[10].checked = not projectile_options[10].checked
				end
		end
		projectile_options[i].func = newfunction
	end
end
------------------------------------
-- Advanced Settings
------------------------------------
advanced_settings = {
		frameskip = {
			text = "Disable Frameksip",
			x = 150,
			y = 30,
			olcolour = "black",
			info = {
				"Disable frameskip",
				"The game will run slower than Turbo 0"
			},
			func =	function()
					frameskip_selector = frameskip_selector + 1
					if frameskip_selector > 0 then
						frameskip_selector = -1
					end
				end,
			autofunc = function(this)
					if frameskip_selector == -1 then
						this.text = "Disable Frameskip: Off"
					elseif frameskip_selector == 0 then
						this.text = "Disable Frameskip: On"
					end
				end,
		},
		slowdown = {
			text = "Disable Impact Slowdown",
			x = 150,
			y = 50,
			olcolour = "black",
			info = {
				"Disable the slowdown when a projectile hits"
			},
			func =	function()
					slowdown_selector = slowdown_selector + 1
					if slowdown_selector > 0 then
						slowdown_selector = -1
					end
				end,
			autofunc = function(this)
					if slowdown_selector == -1 then
						this.text = "Disable Impact Slowdown: Off"
					elseif slowdown_selector == 0 then
						this.text = "Disable Impact Slowdown: On"
					end
				end,
		},
		nomusic = {
			text = "Disable Background Music",
			x = 150,
			y = 70,
			olcolour = "black",
			info = {
				"Disable background music"
			},
			func =	function()
					nomusic_selector = nomusic_selector + 1
					if nomusic_selector > 0 then
						nomusic_selector = -1
					end
				end,
			autofunc = function(this)
					if nomusic_selector == -1 then
						this.text = "Disable Background Music: Off"
					elseif nomusic_selector == 0 then
						this.text = "Disable Background Music: On"
					end
				end,
		},
		easy_charge_moves = {
			text = "Easy Charge Moves",
			x = 8,
			y = 150,
			olcolour = "black",
			info = {
				"When this option is used, charge moves can be triggered",
				"using only one frame of charge"
			},
			func =	function()
					easy_charge_moves_selector = easy_charge_moves_selector + 1
					if easy_charge_moves_selector > 2 then
						easy_charge_moves_selector = -1
					end
				end,
			autofunc = function(this)
					if easy_charge_moves_selector == -1 then
						this.text = "Easy Charge Moves: Off"
					elseif easy_charge_moves_selector == 0 then
						this.text = "Easy Charge Moves: P1"
					elseif easy_charge_moves_selector == 1 then
						this.text = "Easy Charge Moves: P2"
					elseif easy_charge_moves_selector == 2 then
						this.text = "Easy Charge Moves: P1/P2"
					end
				end,
		},
		frame_advantage = {
			text = "Display Frame Advantage",
			x = 8,
			y = 30,
			olcolour = "black",
			info = {
				"Counts the number of frames the attacker is free to move",
				"while the defender is not"
			},
			func =	function()
					frame_advantage_selector = frame_advantage_selector + 1
					if frame_advantage_selector > 1 then
						frame_advantage_selector = -1
					end
				end,
			autofunc = function(this)
					if frame_advantage_selector == -1 then
						this.text = "Display Frame Advantage: Off"
					elseif frame_advantage_selector == 0 then
						this.text = "Display Frame Advantage: P1"
					elseif frame_advantage_selector == 1 then
						this.text = "Display Frame Advantage: P2"
					end
				end,
		},
		frame_trap = {
			text = "Display Gap",
			x = 8,
			y = 50,
			olcolour = "black",
			info = {
				"When the defender goes out of blockstun/hitstun, counts",
				"the number of frames before a second hit happens"
			},
			func =	function()
					frame_trap_selector = frame_trap_selector + 1
					if frame_trap_selector > 0 then
						frame_trap_selector = -1
					end
				end,
			autofunc = function(this)
					if frame_trap_selector == -1 then
						this.text = "Display Gap: Off"
					elseif frame_trap_selector == 0 then
						this.text = "Display Gap: On"
					end
				end,
		},
		round_start = {
		text = "Round start action",
		x = 8,
		y = 130,
		olcolour = "black",
		info = {
			"Control round start action on P2",
			"Disabled: don't replay anything when round starts.",
			"Pre-start: buffer special before round start to trigger at earliest possible frame.",
			"Post-start: replay action right when the round starts",
			"Use the Replay Editor in the Recording menu to program the desired round start action."
		},
		func =	function()
				roundstart_selector = roundstart_selector + 1
				if roundstart_selector > 1 then
					roundstart_selector = -1
				end
			end,
		autofunc = function(this)
				if roundstart_selector == -1 then
					this.text = "Round start action (P2): Disabled"
				elseif roundstart_selector == 0 then
					this.text = "Round start action (P2): Pre-start"
				elseif roundstart_selector == 1 then
					this.text = "Round start action (P2): Post-start"
				end
			end,
		},
		crossup = {
			text = "Display Crossups",
			x = 8,
			y = 70,
			olcolour = "black",
			info = {
				"Checks if a crossup did flip a character's guard",
			},
			func =	function()
					crossup_display_selector = crossup_display_selector + 1
					if crossup_display_selector > 0 then
						crossup_display_selector = -1
					end
				end,
			autofunc = function(this)
					if crossup_display_selector == -1 then
						this.text = "Display Crossups: Off"
					elseif crossup_display_selector == 0 then
						this.text = "Display Crossups: On"
					end
				end,
		},
		safe_jump = {
			text = "Display Safe jumps",
			x = 8,
			y = 90,
			olcolour = "black",
			info = {
				"Checks if a jump would have been safe from a reversal attempt",
			},
			func =	function()
					safe_jump_display_selector = safe_jump_display_selector + 1
					if safe_jump_display_selector > 0 then
						safe_jump_display_selector = -1
					end
				end,
			autofunc = function(this)
					if safe_jump_display_selector == -1 then
						this.text = "Display Safe jumps: Off"
					elseif safe_jump_display_selector == 0 then
						this.text = "Display Safe jumps: On"
					end
				end,
		},
		tick_throws = {
			text = "Display Throws Infos",
			x = 8,
			y = 110,
			olcolour = "black",
			info = {
				"Display throw range and print informations about",
				"tick throws attempts"
			},
			func =	function()
					tick_throw_display_selector = tick_throw_display_selector + 1
					if tick_throw_display_selector > 0 then
						tick_throw_display_selector = -1
					end
				end,
			autofunc = function(this)
					if tick_throw_display_selector == -1 then
						this.text = "Display Throws Infos: Off"
					elseif tick_throw_display_selector == 0 then
						this.text = "Display Throws Infos: On"
					end
				end,
		},
}
table.insert(guipages.advancedsettings, advanced_settings["frameskip"])
table.insert(guipages.advancedsettings, advanced_settings["slowdown"])
table.insert(guipages.advancedsettings, advanced_settings["nomusic"])
table.insert(guipages.advancedsettings, advanced_settings["easy_charge_moves"])
table.insert(guipages.advancedsettings, advanced_settings["frame_advantage"])
table.insert(guipages.advancedsettings, advanced_settings["frame_trap"])
table.insert(guipages.advancedsettings, advanced_settings["round_start"])
table.insert(guipages.advancedsettings, advanced_settings["crossup"])
table.insert(guipages.advancedsettings, advanced_settings["safe_jump"])
table.insert(guipages.advancedsettings, advanced_settings["tick_throws"])

------------------------------------------
------------------------------------------
-- Displaying the contextual options
------------------------------------------
------------------------------------------

deleteReversalSettings = function()
	for i = 1, #reversal_options do
		table.remove(guipages.reversalsettings)
		reversal_options[i] = nil
	end
	do_not_reversal.checked = false
	custom_sequence.checked = false
end

local patched = false
local custom_page_setting = 0 -- custompage : 0 = not loaded yet, 1 = not patched configuration, 2 = patched configuration

makeReversalSettings = function(_patched) -- Display "Select Reversal" if the game has been patched, else use the default "Autoreversal" option
	if not _patched then
		if custom_page_setting == 2 then -- The game was previously patched : reinitialize the GUI
			interactivegui.page = 1
			interactivegui.selection = 1
			deleteReversalSettings()
			for i = 1, #guicustompage do
				if guicustompage[i].handle == 5 then
					table.remove(guicustompage,i)
					break
				end
			end
		end
		table.insert(guicustompage, customPageConfiguration[1])
		custom_page_setting = 1
	else
		if custom_page_setting == 1 then -- The game wasn't patched previously : reinitialize the GUI
			autoreversal_selector = -1
			for i = 1, #guicustompage do
				if guicustompage[i].handle == 5 then
					table.remove(guicustompage,i)
					break
				end
			end
		end
		if custom_page_setting ~= 2 then
		table.insert(guicustompage, customPageConfiguration[2])
		end
		makeReversalSettingsButtons()
		insertReversalSettingsFunctions()
		custom_page_setting = 2
	end
	formatGuiTables() -- Function defined in fbneo-training-mode/guipages.lua (l.875). Maybe there's a cleaner way to reload the tables ?
end

reloadReversalSettings = function()
	interactivegui.page = 1
	interactivegui.selection = 1
	deleteReversalSettings()
	makeReversalSettings(true)
	formatGuiTables()
end

deleteProjectileSettings = function()
	for i = 1, #projectile_options do
		table.remove(guipages.specificsettings)
		projectile_options[i] = nil
	end
	for i = 1, #guicustompage do
		if guicustompage[i].handle == 7 then
			table.remove(guicustompage,i)
			return
		end
	end
end

makeProjectileSettings = function()
	projectile_selector = 0
	makeProjectileSettingsButtons()
	insertProjectileSettingsFunctions()
	formatGuiTables()
end

reloadProjectileSettings = function()
	interactivegui.page = 1
	interactivegui.selection = 1
	deleteProjectileSettings()
	makeProjectileSettings()
	formatGuiTables()
end
