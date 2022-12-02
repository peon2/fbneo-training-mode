------------------------------------------
--	Guipages
------------------------------------------
boxer_dashes_button = {
		text = "Trigger Boxer Dashes",
		olcolour = "black",
		handle = 1,
		info = {
			"In this menu, you can choose the dashes",
			"you want to be performed by Boxer"
		},
		func = 	function() CIG("boxer_dashes_page", 1) end,
	}
insertAddonButton(boxer_dashes_button)

local boxer_dashes_page = {
	title = {
		text = "Select the dashes you want to be performed",
		x = interactivegui.boxxlength/2 - 80,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(interactivegui.previouspage,1) end,
	},
	{
		text = "Trigger : ",
		x = 3,
		y = 130,
		olcolour = "black",
		info = "",
		func =	function()
				dashes_frequence_selector = dashes_frequence_selector + 1
				if dashes_frequence_selector > 1 then
					dashes_frequence_selector = 0
				end
			end,
		autofunc = function(this)
				if dashes_frequence_selector == 0 then
					this.text = "Trigger : When able"
				elseif dashes_frequence_selector == 1 then
					this.text = "Trigger : Randomly"
				end
			end,
	},
	{
		text = "Distance : ",
		x = 3,
		y = 150,
		olcolour = "black",
		info = "",
		func =	function()
				distance_selector = distance_selector + 1
				if distance_selector > 1 then
					distance_selector = 0
				end
			end,
		autofunc = function(this)
				if distance_selector == 0 then
					this.text = "Distance : Fullscreen"
					dash_distance = 0
				elseif distance_selector == 1 then
					this.text = "Distance : Midscreen"
					dash_distance = 240
				elseif distance_selector == 2 then
					this.text = "Distance : Custom"
					dash_distance = 50
				end
			end,
	},
}
guipages.boxer_dashes_page = boxer_dashes_page

boxer_dashes_options = {}

function makeDashesSettingsButtons()
	local n = 0 
	local character = "boxer"
	local special_id = {1,2,4,5}
	
	for k = 1, #special_id do
		for i = 1, #character_specific[character].specials[special_id[k]].input_variations do
		n = n + 1
			if i == 1 then
				dash_name = character_specific[character].specials[special_id[k]].name
				horizontal_length = 4
			else
				dash_name = ""
				horizontal_length = 45 + 22*i
			end
			vertical_length = 20+17*k
			dash_variation = character_specific[character].specials[special_id[k]].input_variations[i][1]
			boxer_dashes_options[n] = {
				text = dash_name.." "..dash_variation,
				x = horizontal_length,
				y = vertical_length,
				olcolour = "black",
				fillpercent = 0,
				checked = false,
				dash_id = {special_id[k], i},
				func = function() end,
				autofunc = function(this)
						if this.checked then
							this.fillpercent = 1
						elseif not this.checked then
							this.fillpercent = 0
						end
					end,
			}
			table.insert(guipages.boxer_dashes_page, boxer_dashes_options[n])
		end
	end
end

function insertDashesSettingsFunctions()
	local newfunction = nil
	for i = 1, #boxer_dashes_options do
		if i == 1 then
			newfunction = function()
				boxer_dashes_options[1].checked = not boxer_dashes_options[1].checked
				end
		elseif i == 2 then
			newfunction = function()
				boxer_dashes_options[2].checked = not boxer_dashes_options[2].checked
				end
		elseif i == 3 then
			newfunction = function()
				boxer_dashes_options[3].checked = not boxer_dashes_options[3].checked
				end
		elseif i == 4 then
			newfunction = function()
				boxer_dashes_options[4].checked = not boxer_dashes_options[4].checked
				end
		elseif i == 5 then
			newfunction = function()
				boxer_dashes_options[5].checked = not boxer_dashes_options[5].checked
				end
		elseif i == 6 then
			newfunction = function()
				boxer_dashes_options[6].checked = not boxer_dashes_options[6].checked
				end
		elseif i == 7 then
			newfunction = function()
				boxer_dashes_options[7].checked = not boxer_dashes_options[7].checked
				end
		elseif i == 8 then
			newfunction = function()
				boxer_dashes_options[8].checked = not boxer_dashes_options[8].checked
				end
		elseif i == 9 then
			newfunction = function()
				boxer_dashes_options[9].checked = not boxer_dashes_options[9].checked
				end
		elseif i == 10 then
			newfunction = function()
				boxer_dashes_options[10].checked = not boxer_dashes_options[10].checked
				end
		elseif i == 11 then
			newfunction = function()
				boxer_dashes_options[11].checked = not boxer_dashes_options[11].checked
				end
		elseif i == 12 then
			newfunction = function()
				boxer_dashes_options[12].checked = not boxer_dashes_options[12].checked
				end
		elseif i == 13 then
			newfunction = function()
				boxer_dashes_options[13].checked = not boxer_dashes_options[13].checked
				end
		elseif i == 14 then
			newfunction = function()
				boxer_dashes_options[14].checked = not boxer_dashes_options[14].checked
				end
		elseif i == 15 then
			newfunction = function()
				boxer_dashes_options[15].checked = not boxer_dashes_options[15].checked
				end
		elseif i == 16 then
			newfunction = function()
				boxer_dashes_options[16].checked = not boxer_dashes_options[16].checked
				end
		elseif i == 17 then
			newfunction = function()
				boxer_dashes_options[17].checked = not boxer_dashes_options[17].checked
				end
		elseif i == 18 then
			newfunction = function()
				boxer_dashes_options[18].checked = not boxer_dashes_options[18].checked
				end
		elseif i == 19 then
			newfunction = function()
				boxer_dashes_options[19].checked = not boxer_dashes_options[19].checked
				end
		elseif i == 20 then
			newfunction = function()
				boxer_dashes_options[20].checked = not boxer_dashes_options[20].checked
				end
		end
		boxer_dashes_options[i].func = newfunction
	end
end
makeDashesSettingsButtons() 
insertDashesSettingsFunctions()
---------------------------------------------------------
-- 	Main
---------------------------------------------------------
local getDistanceBetweenPlayers = function()
	if playerOneFacingLeft() then
		distance = gamestate.P1.pos_x - gamestate.P2.pos_x
	else
		distance = gamestate.P2.pos_x - gamestate.P1.pos_x
	end
	return distance
end

dashes_frequence_selector = 0
distance_selector = 0
local dashes_delay = math.random(-150,0)
local distance_set = false
local dashing = false
local p2 = 0x400

local function triggerDash(_dash_id)
	local character = "boxer"
	local distance = getDistanceBetweenPlayers()
	
	if not gamestate.is_in_match or gamestate.P2.character ~= Boxer then
		return
	end
	
	if not interactivegui.enabled then
		if distance_selector ~= 0 then 
			if distance == dash_distance or distance == dash_distance -1 or distance == dash_distance + 1 then
				distance_set = true
			else
				distance_set = false
			end 
		elseif distance_selector == 0 then
			if gamestate.P2.is_cornered then
				distance_set = true
			else
				distance_set = false
			end
		end
		if gamestate.P2.state == doing_special_move then 
			dashing = false
		end
		if not distance_set and not dashing then 
			if (distance_selector == 0 and not gamestate.P2.is_cornered) or (distance_selector ~= 0 and distance < dash_distance) then
				if playerOneFacingLeft() then 
					modifyInputSet(2,4)
				else
					modifyInputSet(2,6)
				end
			elseif (distance_selector ~= 0 and distance > dash_distance) then 
				if playerOneFacingLeft() then 
					modifyInputSet(2,6)
				else
					modifyInputSet(2,4)
				end
			end
			return 
		end
		if not gamestate.P2.is_attacking and gamestate.P2.state ~= being_hit then
			if dashes_delay < 0 and dashes_frequence_selector == 1 then
				dashes_delay = countFrames(dashes_delay)
			end
		end

		if (rb(0xFF84CE+p2) < 0x04 or rb(0xFF84D6+p2) < 0x04 or rb(0xFF852B+p2) < 0x04 or rb(0xFF8524+p2) < 0x04) or (dashes_frequence_selector == 1 and dashes_delay < 0) then
			if gamestate.P2.flip_input then
				modifyInputSet(2,1)
			else
				modifyInputSet(2,3)
			end
			dashing = true
		elseif (rb(0xFF84CE+p2) == 0x04 and rb(0xFF84D6+p2) == 0x04 and rb(0xFF852B+p2) == 0x04 and rb(0xFF8524+p2) == 0x04) then
			modifyInputSet(2,5)
			dashing = true
		elseif (rb(0xFF84CE+p2) == 0x06 or rb(0xFF84D6+p2) == 0x06 or rb(0xFF852B+p2) == 0x06 or rb(0xFF8524+p2) == 0x06) then
			ready_to_fire = true
			dashing = true
		end

		if ready_to_fire then
			do_special_move(gamestate.P2, character_specific[character].specials[_dash_id[1]], _dash_id[2], false)
			if dashes_frequence_selector == 1 then
				if dashes_delay >= 0 then
					dashes_delay = math.random(-150,0)
				end
			end
			ready_to_fire = false
		end
	end
end

local dashes_checked = {}
local listenDashesSettingsModfications = false

function stockDashesChecked()
	if interactivegui.enabled and not listenDashesSettingsModfications then
		for k in pairs(dashes_checked) do
			dashes_checked[k] = nil
		end
		dashes_selector = 0
		listenDashesSettingsModfications = true
	end
	if not interactivegui.enabled and listenDashesSettingsModfications then
		for i = 1, #boxer_dashes_options do
			if boxer_dashes_options[i].checked then
				table.insert(dashes_checked, boxer_dashes_options[i].dash_id)
			end
		end
		if #dashes_checked == 0 then
			boxer_dashes_selector = 0
		elseif #dashes_checked == 1 then
			boxer_dashes_selector = 1
		elseif #dashes_checked > 1 then
			boxer_dashes_selector = 2
		end
		listenDashesSettingsModfications = false
	end
end

local boxer_dashes_reroll = true

local function triggerDashLogic()
	if boxer_dashes_selector == 1 then
		triggerDash(dashes_checked[1])
	elseif boxer_dashes_selector == 2 then
		if boxer_dashes_reroll then
			random_dash = math.random(1,#dashes_checked)
		end
		triggerDash(dashes_checked[random_dash])
		boxer_dashes_reroll = false
		if (gamestate.P2.prev.state ~= doing_special_move and gamestate.P2.state == doing_special_move) then
			boxer_dashes_reroll = true
		end
	else
		boxer_dashes_reroll = true
	end
end

local function dashTraining()
	stockDashesChecked()
	triggerDashLogic()
end
table.insert(ST_functions, dashTraining)