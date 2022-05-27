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
		text = "Toggle Auto Air Recover",
		x = 8,
		y = 50,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func =	function()
				air_recover_selector = air_recover_selector + 1
				if air_recover_selector > 1 then
					air_recover_selector = 0
				end
			end,
		autofunc = function(this)
				if air_recover_selector == 0 then
					this.text = "Toggle Auto Air Recover: Off"
				elseif air_recover_selector == 1 then
					this.text = "Toggle Auto Air Recover: On"
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
					crouch_cancel_training_selector = -1
				end
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