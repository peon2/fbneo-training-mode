assert(rb,"Run fbneo-training-mode.lua")

guicustompage = {
	title = {
		text = "Red Earth Settings",
		x = interactivegui.boxxlength/2 - (#"Red Earth Settings")*2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Stun info On",
		x = 8,
		y = 40,
		olcolour = "black",
		info = {
			"Toggle Red Earth stun info",
		},
		func =	function() stunMeterEnabled=not stunMeterEnabled end,
		autofunc = 	function(this)
						if stunMeterEnabled then
							this.text = "Stun info On"
							this.x = 8
						else
							this.text = "Stun info Off"
							this.x = 4
						end
					end
	},
}
