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
	{
		text = "AutoBlock",
		x = 8,
		y = 60,
		olcolour = "black",
		info = {
			"Control auto-block on P2",
			"Can be Disabled, block everything, block only ground attacks, block auto or block random."
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
}
