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
		text = "Select stage",
		x = 8,
		y = 40,
		olcolour = "black",
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
	{
		text = "AutoBlock",
		x = 8,
		y = 80,
		olcolour = "black",
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
		y = 100,
		olcolour = "black",
		info = {
			"Control Stun/Dizzy",
			"Can be normal, off (never dizzy) or on (always dizzy)"
		},
		func =	function()
				dizzy_selector = dizzy_selector + 1
				if dizzy_selector > 2 then
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
}

-----------------------------------------------------------------------------------
-- Added by Asunaro - Create a Reversal Settings Menu if the game has been patched
-----------------------------------------------------------------------------------
-------------
-- General
-------------
local n = 0 -- count the number of reversal options
local s = 0 -- count the number of unique special moves a character can reversal
reversal_options = {} -- Contains the buttons with the relevant informations from character_specific.lua
function makeReversalSettingsButtons()
	local character = readPlayerTwoCharacter()
	n = 0
	s = 0
	-- Specials
	for i = 1, #character_specific[character].specials do
		if character_specific[character].specials[i].reversal then
			s = s + 1
			for k = 1, #character_specific[character].specials[i].input_variations do
			 if (character_specific[character].specials[i].strength_set ~= 0) or (character_specific[character].specials[i].strength_set == 0 and k == 1) then -- Don't display variations for super moves or moves that don't have variations
				n = n + 1
				if k == 1 then
					special_name = character_specific[character].specials[i].name
					horizontal_length = 4
				else
					special_name = ""
					if character_specific[character].specials[i].strength_set ~= -1 then -- Not Dhalsim TP not Boxer TAP
						horizontal_length = 85 + 20*k
					elseif character == "dhalsim" then -- Dhalsim TP
						horizontal_length = 65 + 30*k
					elseif character == "boxer" then   -- Boxer TAP
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
				horizontal_length = 11 + 17*i
			else
				horizontal_length = 4
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
				text = "Don't reversal",
				x = 4,
				y = 150,
				olcolour = "black",
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
				x = 75,
				y = 150,
				olcolour = "black",
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

customPageConfiguration = { -- Two different buttons depending on whether the game has been patched or not
	{
		text = "AutoReversal",
		x = 8,
		y = 60,
		olcolour = "black",
		info = {
			"Control reversal on P2",
			"Use the Replay Editor in the Recording menu to program the desired reversal action.",
			"To improve auto-reversal select Game -> Load Game -> Apply IPS patches -> Play"
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
			y = 60,
			olcolour = "black",
			info = {
				"Control reversal on P2",
			},
			func = 	function() CIG("reversalsettings", 1) end, -- "reversalsettings" has been placed in "fbneo-training-mode/guipages.lua(l.588)", maybe there's a way to place it in this file ?
	}
}

--------------------------
-- Displaying the options
--------------------------
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
	patched = _patched
	if not patched then
		if custom_page_setting == 2 then -- The game was previously patched : reinitialize the GUI
			interactivegui.page = 1
			interactivegui.selection = 1
			deleteReversalSettings()
			table.remove(guicustompage)
		end
		table.insert(guicustompage, customPageConfiguration[1])
		custom_page_setting = 1
	else
		if custom_page_setting == 1 then -- The game wasn't patched previously : reinitialize the GUI
			autoreversal_selector = -1
			table.remove(guicustompage)
		end
		if custom_page_setting ~= 2 then
		table.insert(guicustompage, customPageConfiguration[2])
		end
		custom_page_setting = 2
		makeReversalSettingsButtons()
		insertReversalSettingsFunctions()
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
