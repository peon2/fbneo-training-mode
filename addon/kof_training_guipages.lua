
KOF_CONFIG = {

	GUARD = {
		dummy_guarding = false,
		standing_guard = 0,
		crouch_guard = 0,
		random_guard = 0
	},
	MOVES = {
		
		['GUARD_BACK']={
			["sequence"] = {
				{'back'},
	
			},
			times = 10
		},
	}
}

guicustompage = {
	title = {
		text = "The king of fighters 98 - Training Mode Settings",
		x = interactivegui.boxxlength/2 - (#"The king of fighters 98 - Training Mode Settings")*2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Stand Guard",
		x = 118,
		y = 30,
		olcolour = "black",
		handle = 1,
		info = {
		},
		func =	function()
				KOF_CONFIG.GUARD.standing_guard = KOF_CONFIG.GUARD.standing_guard + 1
				if KOF_CONFIG.GUARD.standing_guard > 1 then
					KOF_CONFIG.GUARD.standing_guard = 0
					KOF_CONFIG.GUARD.dummy_guarding = false
				end
				if KOF_CONFIG.GUARD.standing_guard == 1 then
					KOF_CONFIG.GUARD.dummy_guarding = true
                    KOF_CONFIG.GUARD.crouch_guard = 0
				end
			end,
		autofunc = function(this)
				if KOF_CONFIG.GUARD.standing_guard == 0 then
					this.text = "Toggle Stand Guard: Off"
				elseif KOF_CONFIG.GUARD.standing_guard == 1 then
					this.text = "Toggle Stand Guard: On"
				end
			end,
	},
	{
		text = "Toggle Crouch Guard",
		x = 8,
		y = 30,
		olcolour = "black",
		handle = 1,
		info = {
		},
		func =	function()
				KOF_CONFIG.GUARD.crouch_guard = KOF_CONFIG.GUARD.crouch_guard + 1
				if KOF_CONFIG.GUARD.crouch_guard > 1 then
					KOF_CONFIG.GUARD.crouch_guard = 0
					KOF_CONFIG.GUARD.dummy_guarding = false

				end
				if KOF_CONFIG.GUARD.crouch_guard == 1 then
					KOF_CONFIG.GUARD.dummy_guarding = true
                    KOF_CONFIG.GUARD.standing_guard = 0
				end
			end,
		autofunc = function(this)
				if KOF_CONFIG.GUARD.crouch_guard == 0 then
					this.text = "Toggle Crouch Guard: Off"
				elseif KOF_CONFIG.GUARD.crouch_guard == 1 then
					this.text = "Toggle Crouch Guard: On"
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
                if(not(KOF_CONFIG.GUARD.dummy_guarding) ) then              
                    return 
                end

				KOF_CONFIG.GUARD.random_guard = KOF_CONFIG.GUARD.random_guard + 1
				if KOF_CONFIG.GUARD.random_guard > 1 then
					KOF_CONFIG.GUARD.random_guard = 0
				end
			end,
		autofunc = function(this)
            if(not(KOF_CONFIG.GUARD.dummy_guarding) ) then              
                KOF_CONFIG.GUARD.random_guard =0
            end
				if KOF_CONFIG.GUARD.random_guard == 0 then
					this.text = "Toggle Random Guard: Off"
				elseif KOF_CONFIG.GUARD.random_guard == 1 then
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
		text = "Current Reversal Move(s)",
		x = 8,
		y = 130,
		olcolour = "black",
		handle = 2,
		info = {
            "the first one is the default"
		},
		func =	function()
				
			end,
		autofunc = function(this)
            local txt = ""
            local i = 1
                for index, value in ipairs(dummy_reversal_moves) do
                    if i == 1 then
                        txt = txt..value
                        i = 1 + 1
                    else
                        txt = txt..", "..value
                    end
                end   
                this.text =  "Current Reversal Move(s): ("..txt..")"
			end,
	},
	{
		text = "Toggle Recovery",
		x = 8,
		y = 150,
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


