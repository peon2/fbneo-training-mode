
KOF_CONFIG = {

	GUARD = {
		dummy_guarding = false,
		standing_guard = 0,
		crouch_guard = 0,
		random_guard = 0,
		reversal =0,
		REVERSAL_OPTIONS = {
			
			OFF = 0,
			ON = 1,
			RANDOM = 2
		},
		reversal_moves = {}
	},
    REVERSAL_MOVES = {
		OPTIONS = {
			OFF = 0,
			GUARD = 1,
			WAKEUP = 2,
			BOTH = 3
		}},
    WAKEUP = {
		dummy_waking_up = false,
		reversal  = 0,
		REVERSAL_OPTIONS = {
			
			OFF = 0,
			ON = 1,
			RANDOM = 2
		},
		reversal_moves = {}
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
		text = "Toggle Guard Reversal",
		x = 118,
		y = 50,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func =	function()
				KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.reversal + 1
				if KOF_CONFIG.GUARD.reversal > 2 then
					KOF_CONFIG.GUARD.reversal = 0
				end
			end,
		autofunc = function(this)				
					if (KOF_CONFIG.GUARD.reversal  == KOF_CONFIG.GUARD.REVERSAL_OPTIONS.OFF) then
						this.text = "Enable G. Reversal: Off" 
					elseif (KOF_CONFIG.GUARD.reversal  == KOF_CONFIG.GUARD.REVERSAL_OPTIONS.ON) then
						this.text = "Enable G. Reversal: On" 
					elseif (KOF_CONFIG.GUARD.reversal  == KOF_CONFIG.GUARD.REVERSAL_OPTIONS.RANDOM ) then
						this.text = "Enable G. Reversal: Random"
					end
			end,
	},
	----{
	-- See below for the character specific button
	----}
	{
			text = "Reversal Move Active Settings",
			x = 8,
			y = 70,
			olcolour = "black",
			handle = 8,
			func = 	function() CIG("reversal_move_active_settings", 1) end,
	},
	{
		text = "Guard Rev(s)",
		x = 8,
		y = 90,
		olcolour = "black",
		handle = 2,
		info = {
            "active moves for reversal on guard"
		},
		func =	function()
				
			end,
		autofunc = function(this)
            local txt = ""
            local i = 1
                for index, value in ipairs(KOF_CONFIG.GUARD.reversal_moves) do
                    if i == 1 then
                        txt = txt..value
                        i = 1 + 1
                    else
                        txt = txt..", "..value
                    end
                end   
                this.text =  "Guard Rev(s): ("..txt..")"
			end,
	},
	{
		text = "Wake Up Rev(s)",
		x = 118,
		y = 90,
		olcolour = "black",
		handle = 2,
		info = {
            "active moves for reversal on Wake Up"
		},
		func =	function()
				
			end,
		autofunc = function(this)
            local txt = ""
            local i = 1
                for index, value in ipairs(KOF_CONFIG.WAKEUP.reversal_moves) do
                    if i == 1 then
                        txt = txt..value
                        i = 1 + 1
                    else
                        txt = txt..", "..value
                    end
                end   
                this.text =  "WakeUp Rev(s): ("..txt..")"
			end,
	},
	{
		text = "Enable WAKEUP",
		x = 8,
		y = 110,
		olcolour = "black",
		handle = 2,
		info = {
		},
		func =	function()
					if next(KOF_CONFIG.WAKEUP.reversal_moves) == nil then
						return
					end
					KOF_CONFIG.WAKEUP.reversal= KOF_CONFIG.WAKEUP.reversal+ 1
					if KOF_CONFIG.WAKEUP.reversal> 2 then
						KOF_CONFIG.WAKEUP.reversal= 0
					end
					if KOF_CONFIG.WAKEUP.reversal ~= KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.OFF then
						KOF_CONFIG.WAKEUP.dummy_waking_up = true
					end
				end,
		autofunc = function(this)				
					if (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.OFF) then
						this.text = "Enable Wake Up Reversal: Off" 
					elseif (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON) then
						this.text = "Enable Wake Up Reversal: On" 
					elseif (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM ) then
						this.text = "Enable Wake Up Reversal: Random"
					end
			end,
	},
	{
		text = "WakeUp delay",
		x = 8,
		y = 130,
		olcolour = "black",
		handle = 2,
		info = {
			"Controls how many frames until the character takes to do the reversal",
			"Because depending on the mo "
		},
		func =	function()

				
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


