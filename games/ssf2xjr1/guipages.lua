assert(rb,"Run fbneo-training-mode.lua")

guicustompage = {
	title = {
		text = "Super Street Fighter 2X Settings",
		x = interactivegui.boxxlength/2 - (#"Super Street Fighter 2X Settings")*2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Stage selector",
		x = 8,
		y = 40,
		olcolour = "black",
		info = {
			"Background stage selection",
			"Must be changed on player select screen, before selecting character."
		},
		func =	function()
				-- CIG("guicustompage", stage_selector)
				-- changeConfig("ssf2xjr1","stage_selector", stage_selector, ssf2xjr1)
				-- modulevars.constants.stage_selector = stage_selector+1
				stage_selector = stage_selector + 1
				if stage_selector >= 0xf then
					stage_selector=-1
				end
				changeConfig("custom","stage_selector", stage_selector, custom)
				
			end,
		autofunc = 	function(this)
						if stage_selector == -1 then
							this.text = "Select stage"
							this.x = 8
						elseif stage_selector == 0 then
							this.text = "Stage: Japan (Ryu)"
							this.x = 8
						elseif stage_selector == 1 then
							this.text = "Stage: Japan (Honda)"
							this.x = 8
						elseif stage_selector == 2 then
							this.text = "Stage: Brazil (Blanka)"
							this.x = 8
						elseif stage_selector == 3 then
							this.text = "Stage: USA (Guile)"
							this.x = 8
						elseif stage_selector == 4 then
							this.text = "Stage: USA (Ken)"
							this.x = 8
						elseif stage_selector == 5 then
							this.text = "Stage: China (Chun-Li)"
							this.x = 8
						elseif stage_selector == 6 then
							this.text = "Stage: USSR (Zangief)"
							this.x = 8
						elseif stage_selector == 7 then
							this.text = "Stage: India (Dhalsim)"
							this.x = 8
						elseif stage_selector == 8 then
							this.text = "Stage: Thailand (Dictator)"
							this.x = 8
						elseif stage_selector == 9 then
							this.text = "Stage: Thailand (Sagat)"
							this.x = 8
						elseif stage_selector == 0xa then
							this.text = "Stage: USA (Boxer)"
							this.x = 8
						elseif stage_selector == 0xb then
							this.text = "Stage: Spain (Claw)"
							this.x = 8
						elseif stage_selector == 0xc then
							this.text = "Stage: England (Cammy)"
							this.x = 8
						elseif stage_selector == 0xd then
							this.text = "Stage: Mexico (T.Hawk)"
							this.x = 8
						elseif stage_selector == 0xe then
							this.text = "Stage: HongKong (Fei-Long)"
							this.x = 8
						elseif stage_selector == 0xf then
							this.text = "Stage: Jamaica (DeeJay)"
							this.x = 8
						end
					end
	},
}
