
assert(rb,"Run fbneo-training-mode.lua")

guicustompage = {
	title = {
		text = "The king of fighters 98 - Training Mode Settings",
		x = interactivegui.boxxlength/2 - (#"The king of fighters 98 - Training Mode Settings")*2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Toggle Guard",
		x = 8,
		y = 30,
		olcolour = "black",
		handle = 1,
		info = {
		},
		func =	function()
				dummy_guard = dummy_guard + 1
				if dummy_guard > 1 then
					dummy_guard = 0
				end
			end,
		autofunc = function(this)
				if dummy_guard == 0 then
					this.text = "Toggle Guard: Off"
				elseif dummy_guard == 1 then
					this.text = "Toggle Guard: On"
				end
			end,
	},
	{
		text = "Toggle Random Guard (works only if guard is on)",
		x = 8,
		y = 50,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func =	function()
				dummy_random_guard = dummy_random_guard + 1
				if dummy_random_guard > 1 then
					dummy_random_guard = 0
				end
			end,
		autofunc = function(this)
				if dummy_random_guard == 0 then
					this.text = "Toggle Random Guard: Off"
				elseif dummy_random_guard == 1 then
					this.text = "Toggle Random Guard: On"
				end
			end,
	},
	{
		text = "Toggle Reversal",
		x = 8,
		y = 70,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func =	function()
				dummy_reversal = dummy_reversal + 1
				if dummy_reversal > 1 then
					dummy_reversal = 0
				end
			end,
		autofunc = function(this)
				if dummy_reversal == 0 then
					this.text = "Toggle Reversal: Off"
				elseif dummy_reversal == 1 then
					this.text = "Toggle Reversal: On"
				end
			end,
	},
	{
		text = "Toggle Reversal Random",
		x = 8,
		y = 90,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func =	function()
				dummy_reversal_random = dummy_reversal_random + 1
				if dummy_reversal_random > 1 then
					dummy_reversal_random = 0
				end
			end,
		autofunc = function(this)
				if dummy_reversal_random == 0 then
					this.text = "Toggle Reversal Random: Off"
				elseif dummy_reversal_random == 1 then
					this.text = "Toggle Reversal Random: On"
				end
			end,
	},
	----{
	-- See below for the character specific button
	----}
	{
			text = "Reversal Move Active Settings",
			x = 8,
			y = 110,
			olcolour = "black",
			handle = 8,
			func = 	function() CIG("reversal_move_active_settings", 1) end,
	},
	{
		text = "Toggle Recovery",
		x = 8,
		y = 130,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func =	function()
				dummy_recovery = dummy_recovery + 1
				if dummy_recovery > 1 then
					dummy_recovery = 0
				end
			end,
		autofunc = function(this)
				if dummy_recovery == 0 then
					this.text = "Toggle Recovery: Off"
				elseif dummy_recovery == 1 then
					this.text = "Toggle Recovery: On"
				end
			end,
	},
}
local reversal_move_active_settings = {
	title = {
		text = "Reversal Move Active Settings",
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
guipages.reversal_move_active_settings = reversal_move_active_settings
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