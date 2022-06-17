assert(rb,"Run fbneo-training-mode.lua")

guicustompage = {
	title = {
		text = "Street Fighter Alpha 3 - Training Mode Settings",
		x = interactivegui.boxxlength/2 - (#"Street Fighter Alpha 3 - Training Mode Settings")*2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Toggle Auto Counter Hit",
		x = 8,
		y = 30,
		olcolour = "black",
		handle = 1,
		info = {
		},
		func =	function()
				counter_hit_selector = counter_hit_selector + 1
				if counter_hit_selector > 1 then
					counter_hit_selector = 0
				end
			end,
		autofunc = function(this)
				if counter_hit_selector == 0 then
					this.text = "Toggle Auto Counter Hit: Off"
				elseif counter_hit_selector == 1 then
					this.text = "Toggle Auto Counter Hit: On"
				end
			end,
	},
	{
		text = "Toggle Auto Air Tech",
		x = 8,
		y = 50,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func =	function()
				air_tech_selector = air_tech_selector + 1
				if air_tech_selector > 1 then
					air_tech_selector = 0
				end
			end,
		autofunc = function(this)
				if air_tech_selector == 0 then
					this.text = "Toggle Auto Air Tech: Off"
				elseif air_tech_selector == 1 then
					this.text = "Toggle Auto Air Tech: On"
				end
			end,
	},
	{
		text = "Air tech",
		x = 170,
		y = 50,
		olcolour = "black",
		handle = 3,
		info = {
		},
		func =	function()
				tech_type_selector = tech_type_selector + 1
				if tech_type_selector > 2 then
					tech_type_selector = 0
				end
			end,
		autofunc = function(this)
				if tech_type_selector == 0 then
					this.text = "Air Tech: Neutral"
				elseif tech_type_selector == 1 then
					this.text = "Air Tech: Backward"
				elseif tech_type_selector == 2 then
					this.text = "Air Tech: Forward"
				end
			end,
	},
	{
		text = "Crouch Cancel Training",
		x = 8,
		y = 70,
		olcolour = "black",
		handle = 4,
		info = {
		},
		func =	function()
				crouch_cancel_training_selector = crouch_cancel_training_selector + 1
				if crouch_cancel_training_selector > 1 then
					crouch_cancel_training_selector = 0
				end
				counter_hit_selector = 1
				air_tech_selector = 1
			end,
		autofunc = function(this)
				if crouch_cancel_training_selector == 0 then
					this.text = "Crouch Cancel Training: Off"
				elseif crouch_cancel_training_selector == 1 then
					this.text = "Crouch Cancel Training: On"
				end
			end,
	},
}
------------------------------------------
-- Add-on
------------------------------------------
addonpage = {
	title = {
		text = "Add-On",
		x = interactivegui.boxxlength/2 - 10,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() 
			interactivegui.page = 5
			interactivegui.selection = 1 
		end,
	},
}
guipages.addonpage = addonpage

addonbutton = {
		text = "Add-On",
		x = 210,
		y = 150,
		olcolour = "black",
		handle = 7,
		func = 	function() CIG("addonpage", 1) end,
		}

function insertAddonButton()
	if #addonpage > 1 then
		table.insert(guicustompage, addonbutton)
		formatGuiTables()
	end
end

function determineButtonYPos(_guipage)
	if #_guipage == 1 then 
		return 40
	else
		return _guipage[#_guipage].y+20
	end
end