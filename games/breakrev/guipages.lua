assert(rb,"Run fbneo-training-mode.lua")

guicustompage = {
	title = {
		text = "Breakers Revenge Settings",
		x = interactivegui.boxxlength/2 - (#"Breakers Revenge Settings")*2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Hitbox enable/disable",
		x = 8,
		y = 40,
		olcolour = "black",
		info = {
			"Must be changed at character select to take effect",
		},
		func =	function() 
			changeConfig("hitbox", "enabled", not hitboxes.prev, hitboxes) 
			hitboxes.prev = hitboxes.enabled
		end,
		autofunc = 	function(this)
						if hitboxes.prev then
							this.text = "Hitboxes On"
							this.x = 8
						else
							this.text = "Hitboxes Off"
							this.x = 4
						end
					end
	},
}