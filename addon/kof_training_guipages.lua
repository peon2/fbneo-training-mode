
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
			ON= 1,
		},
		MOVELIST = nil
	},
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
	RECOVERY = {
		dummy_recovering = false,
		recovery = 0,
		OPTIONS = {
			OFF = 0,
			ON = 1,
			RANDOM = 2,
		},
		delay = 10,
		times = 8
	},
	DIZZY ={
		dummy_can_dizzy = true,
		enabled = 1,
		OPTIONS = {
			OFF = 0,
			ON = 1,
		},

	},
	CPU ={
		HAS_CHANGED = false,
		dummy_can_fight = false,
		current_dificulty = 0,
		DIFFICULTY = {
			["BEGINNER"] = 0,
			["EASY"] = 1,
			["NORMAL"] = 2,
			["MVS"] = 3,
			["HARD"] = 4,
			["VERYHARD"] = 5,
			["HARDEST"] = 6,
			["EXPERT"] = 7

		},
		getDifficultyString = function(self, value)
			for key, val in pairs(self.DIFFICULTY) do
				if val == value then
					return tostring(val + 1) .. "-" .. key
				end
			end
			return nil
		end,
		vs_enabled = 0,
		OPTIONS = {
			OFF = 0,
			ON = 1,
		},
		GCCD = {
			dummy_can_gccd = false,
			current_gccd = 0,
			OPTIONS = {
				OFF = 0,
				ON = 1,
				RANDOM = 2,
			},

	},
	GCAB = {
		dummy_can_gcab = false,
		current_gcab = 0,
		OPTIONS = {
			OFF = 0,
			ON = 1,
			RANDOM = 2,
		},

},
	 },
	MOVES = {
		
		['GUARD_BACK']={
			["sequence"] = {
				{'back'},
	
			},
			times = 10
		},
		['AB']={
			["sequence"] = {
				{'-'},
				{'a','b'},
				{'a','b'},
				{'a','b'},
	
			},
			times = 3,
			delay = 25
		},
		['CD']={
			["sequence"] = {
				{'-'},
				{'c','d'},
				{'c','d'},
				{'c','d'},
	
			},
			times = 3,
			delay = 25
		},
		["CROUCH"] = {
			["sequence"] = {
			{"down"},
			}
		},
		["CROUCH_GUARD"] = {
			["sequence"] = {
			{"down", "back"}
			},
			times = 10
		}
	},
	MOVES_VAR_NAMES = {
		GUARD={},
		WAKEUP={},
	},
	TRAINING ={
		current_configuration = -1,
		CONFIGURATIONS =  {
			["None"] = -1,
			["cd_pressure_1"] = 0,
			["cd_pressure_2"] = 1,
			["cd_pressure_3"] = 2,
			["cd_pressure_4"] = 3,
			["crouching_frametrap"] = 4,
			["standing_frametrap"] = 5,
			["high_confirm_against_CDA"] = 6,
			["wakeup_whiff_cr_c"] = 7,
			["wakeup_dpc"] = 8,
			["shimmy_wakeup"] = 9,
			["wakeup_delay_OS_basic"] = 10,
			["wakeup_delay_OS_full"] = 11,
			
		}
	},
	CHARACTERS = {
		[1] = { name = "Kyo Kusanagi", code = "0x00" },
		[2] = { name = "Benimaru Nikaido", code = "0x01" },
		[3] = { name = "Goro Daimon", code = "0x02" },
		[4] = { name = "Terry Bogard", code = "0x03" },
		[5] = { name = "Andy Bogard", code = "0x04" },
		[6] = { name = "Joe Higashi", code = "0x05" },
		[7] = { name = "Ryo Sakazaki", code = "0x06" },
		[8] = { name = "Robert Garcia", code = "0x07" },
		[9] = { name = "Yuri Sakazaki", code = "0x08" },
		[10] = { name = "Leona", code = "0x09" },
		[11] = { name = "Ralf Jones", code = "0x0A" },
		[12] = { name = "Clark Steel", code = "0x0B" },
		[13] = { name = "Athena Asamiya", code = "0x0C" },
		[14] = { name = "Sie Kensou", code = "0x0D" },
		[15] = { name = "Chin Gentsai", code = "0x0E" },
		[16] = { name = "Chizuru Kagura", code = "0x0F" },
		[17] = { name = "Mai Shiranui", code = "0x10" },
		[18] = { name = "King", code = "0x11" },
		[19] = { name = "Kim Kaphwan", code = "0x12" },
		[20] = { name = "Chang Koehan", code = "0x13" },
		[21] = { name = "Choi Bounge", code = "0x14" },
		[22] = { name = "Yashiro Nanakase", code = "0x15" },
		[23] = { name = "Shermie", code = "0x16" },
		[24] = { name = "Chris", code = "0x17" },
		[25] = { name = "Ryuji Yamazaki", code = "0x18" },
		[26] = { name = "Blue Mary", code = "0x19" },
		[27] = { name = "Billy Kane", code = "0x1A" },
		[28] = { name = "Iori Yagami", code = "0x1B" },
		[29] = { name = "Mature", code = "0x1C" },
		[30] = { name = "Vice", code = "0x1D" },
		[31] = { name = "Heidern", code = "0x1E" },
		[32] = { name = "Takuma Sakazaki", code = "0x1F" },
		[33] = { name = "Saisyu Kusanagi", code = "0x20" },
		[34] = { name = "Heavy D!", code = "0x21" },
		[35] = { name = "Lucky Glauber", code = "0x22" },
		[36] = { name = "Brian Battler", code = "0x23" },
		[37] = { name = "Rugal Bernstein", code = "0x24" },
		[38] = { name = "Shingo Yabuki", code = "0x25" },
		
	},
	UI ={
		CURRENT_PLAYER1 = {

		},
		CURRENT_PLAYER2 = {

		},
		PLAYER1_EX = false,
		PLAYER2_EX = false,
		CHARACTERS_HAS_CHANGED = true,
		current_stage_selected = 1,
		curent_background_music_selected = 1,
		MODE_HAS_CHANGED = false,
		PLAYER1_MODE = 1,
		PLAYER2_MODE = 1,
		MODES = {
			EXTRA = 0,
			ADVANCED = 1,
		}
	}
	
}
KOF_CONFIG.UI.CURRENT_PLAYER1 = KOF_CONFIG.CHARACTERS[1]
KOF_CONFIG.UI.CURRENT_PLAYER2 = KOF_CONFIG.CHARACTERS[28]


guicustompage = {
	title = {
		text = "The king of fighters - Training Mode Settings",
		x = interactivegui.boxxlength/2 - (#"The king of fighters - Training Mode Settings")*2,
		y = 1,
	},
	guielements.leftarrow,
	guielements.rightarrow,
	{
		text = "Guard Settings: ",
		x = 2,
		y = 15,
	},
	{
		text = "Stand Guard",
		x = 118,
		y = 25,
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
		y = 25,
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
		y = 35,
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
		y = 35,
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
	{
		text = "Other Settings: ",
		x = 2,
		y = 50,
	},
	{
		text = "WakeUp Reversal",
		x = 8,
		y = 60,
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
					else KOF_CONFIG.WAKEUP.dummy_waking_up = false end
				end,
		autofunc = function(this)				
					if (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.OFF) then
						this.text = "Wake Up Reversal: Off" 
					elseif (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON) then
						this.text = "Wake Up Reversal: On" 
					elseif (KOF_CONFIG.WAKEUP.reversal == KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM ) then
						this.text = "Wake Up Reversal: Random"
					end
			end,
	},
	{
		text = "Enable Tech Recovery",
		x = 118,
		y = 60,
		olcolour = "black",
		handle = 2,
		info = {
			"Controls how many frames until the character takes to do the reversal",
			"Because depending on the mo "
		},
		func =	function()
					KOF_CONFIG.RECOVERY.recovery= KOF_CONFIG.RECOVERY.recovery+ 1
					if KOF_CONFIG.RECOVERY.recovery> 2 then
						KOF_CONFIG.RECOVERY.recovery= 0
					end
					if KOF_CONFIG.RECOVERY.recovery ~= KOF_CONFIG.RECOVERY.OPTIONS.OFF then
						KOF_CONFIG.RECOVERY.dummy_recovering = true
					else 
						KOF_CONFIG.RECOVERY.dummy_recovering = false
					end
				end,
		autofunc = function(this)				
					if KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.OFF  then
						this.text = "Tech Recovery: Off" 
					elseif KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.ON  then
						this.text = "Tech Recovery: On"  
					elseif KOF_CONFIG.RECOVERY.recovery == KOF_CONFIG.RECOVERY.OPTIONS.RANDOM then
						this.text = "Tech Recovery: Random" 
					end
			end,
	}, {
		text = "Recovery Delay:",
		x = 8,
		y = 70,				
		olcolour = "black",
		info = { 
			"this is the delay it will take on frames and the times of the recovery"
			
		 },
	}, {
		text = "-",
		x = 40 + 34,  -- Adjust x position as needed
		y = 70,  -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			-- Function for "(-) delay"				
			if KOF_CONFIG.RECOVERY.delay == 0 then
				return
			end
			KOF_CONFIG.RECOVERY.delay  = KOF_CONFIG.RECOVERY.delay - 1
		end,
	},{
		text = tostring(KOF_CONFIG.RECOVERY.delay),
		x = 40 + 45,  -- Adjust x position as needed
		y = 70,  -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			
		end,
		autofunc = function(this)
			this.text = tostring(KOF_CONFIG.RECOVERY.delay)
		end,

	}, {
		text = "+",
		x = 40+ 60,  -- Adjust x position as needed
		y = 70,  -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			-- Function for "(+) delay"
			KOF_CONFIG.RECOVERY.delay  = KOF_CONFIG.RECOVERY.delay + 1
		end,
	},{
		text = "Recovery Times:",
		x = 118,
		y = 70,				
		olcolour = "black",
		info = { 
			"this is the delay it will take on frames and the times of the recovery"
			
		 },
	}, {
		text = "-",
		x = 150 + 34,  -- Adjust x position as needed
		y = 70,  -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			-- Function for "(-) delay"				
			if KOF_CONFIG.RECOVERY.times == 1 then
				return
			end
			KOF_CONFIG.RECOVERY.times  = KOF_CONFIG.RECOVERY.times - 1
		end,
	},{
		text = tostring(KOF_CONFIG.RECOVERY.times),
		x = 150 + 45,  -- Adjust x position as needed
		y = 70,  -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			
		end,
		autofunc = function(this)
			this.text = tostring(KOF_CONFIG.RECOVERY.times)
		end,

	}, {
		text = "+",
		x = 150+ 60,  -- Adjust x position as needed
		y = 70,  -- Keep the same y position
		olcolour = "black",
		info = {},
		func = function()
			-- Function for "(+) delay"
			KOF_CONFIG.RECOVERY.times  = KOF_CONFIG.RECOVERY.times + 1
		end,
	},
	{
		text = "Reversal Move List Settings and information: ",
		x = 2,
		y = 75 + 10,
	},
	{
			text = "Dissy enabled",
			x = 110+8,
			y = 85  +10,
			olcolour = "black",
			handle = 8,
			func =	function()
				KOF_CONFIG.DIZZY.enabled  = KOF_CONFIG.DIZZY.enabled + 1
						if KOF_CONFIG.DIZZY.enabled> 1 then
							KOF_CONFIG.DIZZY.enabled= 0
						end
						if KOF_CONFIG.DIZZY.enabled ~= KOF_CONFIG.DIZZY.OPTIONS.OFF then
							KOF_CONFIG.DIZZY.dummy_can_dizzy = true
						else 
							KOF_CONFIG.DIZZY.dummy_can_dizzy= false
						end
					end,
			autofunc = function(this)				
						if KOF_CONFIG.DIZZY.enabled == KOF_CONFIG.DIZZY.OPTIONS.OFF  then
							this.text = "DIZZY: Off" 
						elseif KOF_CONFIG.DIZZY.enabled == KOF_CONFIG.DIZZY.OPTIONS.ON  then
							this.text = "DIZZY: On" 
						end
				end,
	},{
		text = "Character Selecction",
		x = 118,
		y = 95  +10,
		olcolour = "black",
		handle = 9,
		func = 	function() CIG("character_select_settings", 1) end,
	},
	{
			text = "CPU settings",
			x = 118,
			y = 115,
			olcolour = "black",			
			handle = 9,
			func = 	function() CIG("cpu_settings", 1) end,
	},{
		text = "Guard Reversals",
		x = 8,
		y = 85  +10,
		olcolour = "black",
		handle = 9,
		func = 	function() CIG("guard_reversal_move_active_settings", 1) end,
	},
	{
		text = "()",
		x = 8,
		y = 95 + 10,
		olcolour = "black",
		handle = 2,
		info = {
            "active moves for reversal on guard"
		},
		func = 	function()
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
                this.text =  "("..txt..")"
			end,
	},{
		text = "WakeUp Reversals",
		x = 8,
		y = 105 + 10,
		handle = 9,
		func = 	function() CIG("wakeup_reversal_move_active_settings", 1) end,
	},
	{
		text = "()",
		x = 8,
		y = 115 + 10,
		olcolour = "black",
		handle = 8,
		func = 	function()
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
                this.text =  "("..txt..")"
			end,
	},{
		text = "Configurations: ",
		x = 8,
		y = 125 + 10,
	},
	{
		text = "Current Conf: ",
		x = 8,
		y = 135 + 10,
		olcolour = "black",
		handle = 2,
		info = {
            "active moves for reversal on guard"
		},
		func = 	function()
			KOF_CONFIG.TRAINING.current_configuration = KOF_CONFIG.TRAINING.current_configuration + 1
				if KOF_CONFIG.TRAINING.current_configuration > 11 then
					KOF_CONFIG.TRAINING.current_configuration = -1
				end
				setDefaultConfig(KOF_CONFIG.TRAINING.current_configuration)
		end,
		autofunc = function(this) 
                this.text =  "Current Conf: "..getIndexFromConfigValue(KOF_CONFIG.TRAINING.current_configuration)
			end,
	},
}
local cpu_settings = {
	title = {
		text = "CPU Settings",
		x = interactivegui.boxxlength/2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(0,1) end,
	},
}

guipages.cpu_settings = cpu_settings
local cpu_data = {	
	["1"] = 
	{
			text = "Enable CPU",
			x = 10,
			y = 8,
			olcolour = "black",
			func =	function()

				KOF_CONFIG.CPU.vs_enabled  = KOF_CONFIG.CPU.vs_enabled + 1
						if KOF_CONFIG.CPU.vs_enabled> 1 then
							KOF_CONFIG.CPU.vs_enabled= 0
						end
						if KOF_CONFIG.CPU.vs_enabled ~= KOF_CONFIG.CPU.OPTIONS.OFF then
							KOF_CONFIG.CPU.dummy_can_fight = true
						else 
							KOF_CONFIG.CPU.dummy_can_fight= false
						end
					end,
			autofunc = function(this)				
						if KOF_CONFIG.CPU.vs_enabled == KOF_CONFIG.CPU.OPTIONS.OFF  then
							this.text = "CPU: Off" 
						elseif KOF_CONFIG.CPU.vs_enabled == KOF_CONFIG.CPU.OPTIONS.ON  then
							this.text = "CPU: On" 
						end
				end,
	},
	["2"] = {
		x = 10,
		y = 20,
		info = {'set CPU difficulty'},
		func = function()
					KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
					KOF_CONFIG.CPU.HAS_CHANGED = true
					print("current dificulty "..KOF_CONFIG.CPU.current_dificulty)
					KOF_CONFIG.CPU.current_dificulty  = KOF_CONFIG.CPU.current_dificulty + 1
						if KOF_CONFIG.CPU.current_dificulty> 7 then
							KOF_CONFIG.CPU.current_dificulty= 0
						end
				end,
		text = "Dummy Difficulty",
		olcolour = "black",
		autofunc = function(this)						
					KOF_CONFIG.CPU.current_dificulty =  rb(0x10FD8E)
					this.text = "Dummy Difficulty: ".. KOF_CONFIG.CPU:getDifficultyString(KOF_CONFIG.CPU.current_dificulty)
				end,
	},
	["3"] = {
		x = 10,
		y = 32,
		info = {'Guard Cancel CD'},
		func = function()
					KOF_CONFIG.CPU.GCCD.current_gccd  = KOF_CONFIG.CPU.GCCD.current_gccd + 1
					if KOF_CONFIG.CPU.GCCD.current_gccd> 2 then
						KOF_CONFIG.CPU.GCCD.current_gccd= 0
					end
					
					if KOF_CONFIG.CPU.GCCD.current_gccd ~= KOF_CONFIG.CPU.GCCD.OPTIONS.OFF then
						KOF_CONFIG.CPU.GCCD.dummy_can_gccd = true
					else 
						KOF_CONFIG.CPU.GCCD.dummy_can_gccd= false
					end
			end,
		text = "CD on Guard:",
		olcolour = "black",
		autofunc = function(this)				
							
					if KOF_CONFIG.CPU.GCCD.current_gccd == KOF_CONFIG.CPU.GCCD.OPTIONS.OFF  then
						this.text = "CD on Guard: Off" 
					elseif KOF_CONFIG.CPU.GCCD.current_gccd == KOF_CONFIG.CPU.GCCD.OPTIONS.ON  then
						this.text = "CD on Guard: On" 
					elseif KOF_CONFIG.CPU.GCCD.current_gccd == KOF_CONFIG.CPU.GCCD.OPTIONS.RANDOM  then
						this.text = "CD on Guard: Random"
					end
				end,
	},
	["4"] = {
		x = 10,
		y = 44,
		info = {'Guard Cancel AB'},
		func = function()
					KOF_CONFIG.CPU.GCAB.current_gcab  = KOF_CONFIG.CPU.GCAB.current_gcab + 1
					if KOF_CONFIG.CPU.GCAB.current_gcab> 2 then
						KOF_CONFIG.CPU.GCAB.current_gcab= 0
					end
					
					if KOF_CONFIG.CPU.GCAB.current_gcab ~= KOF_CONFIG.CPU.GCAB.OPTIONS.OFF then
						KOF_CONFIG.CPU.GCAB.dummy_can_gcab = true
					else 
						KOF_CONFIG.CPU.GCAB.dummy_can_gcab= false
					end
			end,
		text = "AB on Guard:",
		olcolour = "black",
		autofunc = function(this)				
							
					if KOF_CONFIG.CPU.GCAB.current_gcab == KOF_CONFIG.CPU.GCAB.OPTIONS.OFF  then
						this.text = "AB on Guard: Off" 
					elseif KOF_CONFIG.CPU.GCAB.current_gcab == KOF_CONFIG.CPU.GCAB.OPTIONS.ON  then
						this.text = "AB on Guard: On" 
					elseif KOF_CONFIG.CPU.GCAB.current_gcab == KOF_CONFIG.CPU.GCAB.OPTIONS.RANDOM  then
						this.text = "AB on Guard: Random"
					end
				end,
	},
}


for key, item in pairs( cpu_data) do
table.insert(guipages.cpu_settings,item)
end
local character_select_settings = {
	title = {
		text = "Character Selecction Settings",
		x = interactivegui.boxxlength/2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(0,1) end,
	},
}

guipages.character_select_settings = character_select_settings
local guard_reversal_move_active_settings = {
	title = {
		text = "Guard Reversal Move Active Settings",
		x = interactivegui.boxxlength/2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(0,1) end,
	},
}

local character_data = {	
		["1"] = {
			y = 10,
			x = 8,
			info = {'Kyo Kusanagi'},
			autofunc = function(this)
					end,
			text = "Kyo",
			olcolour = "black",
			func = function()
					end,
		},
		["2"] = {
			y = 10,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[1]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[1] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["3"] = {
			y = 10,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[1]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[1] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},	
		["4"] = {
			y = 22,
			x = 8,
			info = {'Benimaru'},
			autofunc = function(this)
					end,
			text = "Benimaru",
			olcolour = "black",
			func = function()
					end,
		},
		["5"] = {
			y = 22,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[2]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[2] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["6"] = {
			y = 22,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[2]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[2] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["7"] = {
			y = 34,
			x = 8,
			info = {'Goro Daimon'},
			autofunc = function(this)
					end,
			text = "Goro",
			olcolour = "black",
			func = function()
					end,
		},
		["8"] = {
			y = 34,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[3]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[3] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["9"] = {
			y = 34,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[3]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[3] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["10"] = {
			y = 46,
			x = 8,
			info = {'Terry Bogard'},
			autofunc = function(this)
					end,
			text = "Terry",
			olcolour = "black",
			func = function()
					end, 
		},
		["11"] = {
			y = 46,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[4]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[4] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["12"] = {
			y = 46,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[4]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[4] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["13"] = {
			y = 58,
			x = 8,
			info = {'Andy Bogard'},
			autofunc = function(this)
					end,
			text = "Andy",
			olcolour = "black",
			func = function()
					end,
		},
		["14"] = {
			y = 58,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[5]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[5] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["15"] = {
			y = 58,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[5]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[5] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["16"] = {
			y = 70,
			x = 8,
			info = {'Joe Higashi'},
			autofunc = function(this)
					end,
			text = "Joe",
			olcolour = "black",
			func = function()
					end,
		},
		["17"] = {
			y = 70,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[6]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[6] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["18"] = {
			y = 70,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[6]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[6] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["19"] = {	
			y = 82,
			x = 8,
			info = {'Ryo Sakazaki'},
			autofunc = function(this)
					end,
			text = "Ryo",
			olcolour = "black",
			func = function()
					end,
		},
		["20"] = {
			y = 82, 
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[7]
					end,	
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[7] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["21"] = {
			y = 82,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[7]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[7] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["22"] = {
			y = 94,
			x = 8,
			info = {'Robert Garcia'},
			autofunc = function(this)
					end, 
			text = "Robert",
			olcolour = "black",
			func = function()
					end,
		},
		["23"] = {
			y = 94,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[8]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[8] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["24"] = {
			y = 94,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[8]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[8] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["25"] = {
			y = 106,
			x = 8,
			info = {'Yuri Sakazaki'},
			autofunc = function(this)
					end, 
			text = "Yuri", 
			olcolour = "black",
			func = function()
					end,
		},
		["26"] = {
			y = 106,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[9]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[9] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["27"] = {
			y = 106,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[9]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[9] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["28"] = {
			y = 118,
			x = 8,
			info = {'Leona Heidern'},
			autofunc = function(this)
					end, 
			text = "Leona", 
			olcolour = "black",
			func = function()
					end,
		},
		["29"] = {
			y = 118,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[10]	
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[10] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["30"] = {
			y = 118,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[10]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[10] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["31"] = {
			y = 130,
			x = 8,
			info = {'Ralf Jones'}, 
			autofunc = function(this)
					end,	
			text = "Ralf", 
			olcolour = "black",
			func = function()
					end,
		},
		["32"] = {
			y = 130,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[11]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[11] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["33"] = {
			y = 130,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[11]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[11] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["34"] = {
			y = 142,
			x = 8,
			info = {'Clark Steel'}, 
			autofunc = function(this)
					end,	
			text = "Clark", 
			olcolour = "black",
			func = function()
					end,
		},
		["35"] = {
			y = 142,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[12]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[12] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["36"] = {
			y = 142,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[12]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[12] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},["37"] = {
			y = 154,
			x = 8,
			info = {'Athena Asamiya'}, 
			autofunc = function(this)
					end,	
			text = "Athena", 
			olcolour = "black",
			func = function()
					end,
		},
		["38"] = {
			y = 154,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[13]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[13] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["39"] = {
			y = 154,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[13]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[13] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},["40"] = {
			y = 166,
			x = 8,
			info = {'Sie Kensou'}, 
			autofunc = function(this)
					end,	
			text = "Sie", 
			olcolour = "black",
			func = function()
					end,
		},
		["41"] = {
			y = 166,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[14]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[14] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["42"] = {
			y = 166,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[14]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[14] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end, 
		},["43"] = {
			y = 178,
			x = 8,
			info = {'Chin Gentsai'}, 
			autofunc = function(this)
					end,	
			text = "Chin", 
			olcolour = "black",
			func = function()
					end,
		},
		["44"] = {
			y = 178,
			x = 35,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[15]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[15] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["45"] = {
			y = 178,
			x = 50,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[15]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[15] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},["46"] = {
			y = 10,
			x = 64,
			info = {'Chizuru Kagura'}, 
			autofunc = function(this)
					end,	
			text = "Chizuru", 
			olcolour = "black",
			func = function()
					end,
		},
		["47"] = {
			y = 10,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[16]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[16] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["48"] = {
			y = 10,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[16]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[16] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},["49"] = {
			y = 22,
			x = 64,
			info = {'Mai Shiranui'}, 
			autofunc = function(this)
					end,	
			text = "Mai", 
			olcolour = "black",
			func = function()
					end,
		},
		["50"] = {
			y = 22,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[17]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[17] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["51"] = {
			y = 22,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[17]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[17] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["52"] = {
			y = 34,
			x = 64,
			info = {'King'}, 
			autofunc = function(this)
					end,	
			text = "King", 
			olcolour = "black",
			func = function()
					end,
		},
		["53"] = {
			y = 34,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[18]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[18] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["54"] = {
			y = 34,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[18]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[18] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["55"] = {
			y = 46,
			x = 64,
			info = {'Kim Kaphwan'}, 
			autofunc = function(this)
					end,	
			text = "Kim", 
			olcolour = "black",
			func = function()
					end,
		},
		["56"] = {
			y = 46,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[19]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[19] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["57"] = {
			y = 46,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[19]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[19] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["58"] = {
			y = 58,
			x = 64,
			info = {'Chang Koehan'}, 
			autofunc = function(this)
					end,	
			text = "Chang", 
			olcolour = "black",
			func = function()
					end,
		},
		["59"] = {
			y = 58,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[20]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[20] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["60"] = {
			y = 58,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[20]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[20] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["61"] = {
			y = 70,
			x = 64,
			info = {'Choi Bounge'}, 
			autofunc = function(this)
					end,	
			text = "Choi", 
			olcolour = "black",
			func = function()
					end,
		},
		["62"] = {
			y = 70,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[21]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[21] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["63"] = {
			y = 70,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[21]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[21] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["64"] = {
			y = 82,
			x = 64,
			info = {'Yashiro Nanakase'}, 
			autofunc = function(this)
					end,	
			text = "Yashiro", 
			olcolour = "black",
			func = function()
					end,
		},
		["65"] = {
			y = 82,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[22]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[22] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["66"] = {
			y = 82,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[22]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[22] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["67"] = {
			y = 94,
			x = 64,
			info = {'Shermie'}, 
			autofunc = function(this)
					end,	
			text = "Shermie", 
			olcolour = "black",
			func = function()
					end,
		},
		["68"] = {
			y = 94,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[23]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[23] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["69"] = {
			y = 94,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[23]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[23] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["70"] = {
			y = 106,
			x = 64,
			info = {'Chris'}, 
			autofunc = function(this)
					end,	
			text = "Chris", 
			olcolour = "black",
			func = function()
					end,
		},
		["71"] = {
			y = 106,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true 
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[24]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[24] then	
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["72"] = {
			y = 106,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[24]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[24] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["73"] = {
			y = 118,
			x = 64,
			info = {'Ryuji Yamazaki'},
			func = function()
					end,
			text = "Yamazaki",
			olcolour = "black",
			autofunc = function(this)
					end, 
		},
		["74"] = {
			y = 118,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[25]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[25] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["75"] = {
			y = 118,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[25]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[25] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["76"] = {
			y = 130,
			x = 64,
			info = {'Blue Mary'},
			func = function()
					end,
			text = "Mary",
			olcolour = "black",
			autofunc = function(this)
					end, 
		},
		["77"] = {
			y = 130,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[26]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[26] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["78"] = {
			y = 130,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[26]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[26] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["79"] = {
			y = 142,
			x = 64,
			info = {'Billy Kane'},
			func = function()
					end,
			text = "Billy",
			olcolour = "black",
			autofunc = function(this)
					end, 
		},
		["80"] = {
			y = 142,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[27]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[27] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["81"] = {
			y = 142,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[27]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[27] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["82"] = {
			y = 154,
			x = 64,
			info = {'Iori Yagami'},
			func = function()
					end,
			text = "Iori",
			olcolour = "black",
			autofunc = function(this)
					end, 
		},
		["83"] = {
			y = 154,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[28]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[28] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["84"] = {
			y = 154,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[28]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[28] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["85"] = {
			y = 166,
			x = 64,
			info = {'Mature'},
			func = function()
					end,
			text = "Mature",
			olcolour = "black",
			autofunc = function(this)
					end, 
		},
		["86"] = {
			y = 166,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[29]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[29] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["87"] = {
			y = 166,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[29]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[29] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["88"] = {
			y = 178,
			x = 64,
			info = {'Vice'},
			func = function()
					end,
			text = "Vice",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["89"] = {
			y = 178,
			x = 102,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[30]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[30] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["90"] = {
			y = 178,
			x = 117,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[30]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[30] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["91"] = {
			y = 10,
			x = 137,
			info = {'Heidern'},
			func = function()
					end,
			text = "Heidern",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["92"] = {
			y = 10,
			x = 175,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[31]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[31] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["93"] = {
			y = 10,
			x = 190,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[31]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[31] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["94"] = {
			y = 22,
			x = 137,
			info = {'Takuma Sakazaki'},
			func = function()
					end,
			text = "Takuma",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["95"] = {
			y = 22,
			x = 175,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[32]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[32] then
							this.text = "P1"
						else
							this.text = "-"
						end	
					end,
		}, 
		["96"] = {
			y = 22,
			x = 190,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[32]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[32] then
							this.text = "P2"
						else	
							this.text = "-"
						end
					end,
		},
		["97"] = {
			y = 34,
			x = 137,
			info = {'Saisyu Kusanagi'},
			func = function()
					end,
			text = "Saisyu",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["98"] = {
			y = 34,
			x = 175,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[33] 
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[33] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["99"] = {
			y = 34,
			x = 190,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[33]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[33] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["100"] = {
			y = 46,
			x = 137,
			info = {'Heavy D'},
			func = function()
					end,
			text = "Heavy D",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["101"] = {
			y = 46,
			x = 175,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[34]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[34] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["102"] = {
			y = 46,
			x = 190,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[34]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[34] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["103"] = {
			y = 58,
			x = 137,
			info = {'Lucky Glaubert'},
			func = function()
					end,
			text = "Lucky",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["104"] = {
			y = 58,
			x = 175,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[35]
					end,
			text = "P1", 
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[35] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["105"] = {
			y = 58,
			x = 190,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[35]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[35] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
	    ["106"] = {
			y = 70,
			x = 137,
			info = {'Bryan Battler'}, 
			func = function()
					end,
			text = "Bryan",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["107"] = {
			y = 70,
			x = 175,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[36]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[36] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["108"] = {
			y = 70,
			x = 190,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[36]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[36] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["109"] = {
			y = 82,
			x = 137,
			info = {'Rugal Bernstein'}, 
			func = function()
					end,
			text = "Rugal",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["110"] = {
			y = 82,
			x = 175,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[37]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[37] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["111"] = {
			y = 82,
			x = 190,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[37]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[37] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		},
		["112"] = {
			y = 94,
			x = 137,
			info = {'Shingo Yabuki'},
			func = function()
					end,
			text = "Shingo",
			olcolour = "black",
			autofunc = function(this)
					end,
		},
		["113"] = {
			y = 94,
			x = 175,
			info = {'P1'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER1  = KOF_CONFIG.CHARACTERS[38]
					end,
			text = "P1",
			olcolour = "black",
			autofunc = function(this) 
						if KOF_CONFIG.UI.CURRENT_PLAYER1 == KOF_CONFIG.CHARACTERS[38] then
							this.text = "P1"
						else
							this.text = "-"
						end
					end,
		}, 
		["114"] = {
			y = 94,
			x = 190,
			info = {'P2'},
			func = function()
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.CURRENT_PLAYER2  = KOF_CONFIG.CHARACTERS[38]
					end,
			text = "P2",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.CURRENT_PLAYER2 == KOF_CONFIG.CHARACTERS[38] then
							this.text = "P2"
						else
							this.text = "-"
						end
					end,
		}, 
		["115"] = {
			y = 106,
			x = 137,
			info = {'P1 Ex character'},
			func = function()
						KOF_CONFIG.UI.PLAYER1_EX = not KOF_CONFIG.UI.PLAYER1_EX
					end,
			text = "P1 Ex",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.PLAYER1_EX == true then
							this.text = "P1 Character Ex: ON"
						else
							this.text = "P1 Character Ex: OFF"
						end
					end,
		},
		["116"] = {
			y = 118,
			x = 137,
			info = {'P2 Ex character'},
			func = function()
						KOF_CONFIG.UI.PLAYER2_EX = not KOF_CONFIG.UI.PLAYER2_EX
					end,
			text = "P2 Ex",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.PLAYER2_EX == true then
							this.text = "P2 Character Ex: ON"
						else
							this.text = "P2 Character Ex: OFF"
						end
					end,
		},
		["117"] = {
			y = 130,
			x = 137,
			info = {'P1 Mode'},
			func = function()
						KOF_CONFIG.UI.PLAYER1_MODE = KOF_CONFIG.UI.PLAYER1_MODE + 1
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.MODE_HAS_CHANGED = true
						if KOF_CONFIG.UI.PLAYER1_MODE > 1 then
							KOF_CONFIG.UI.PLAYER1_MODE  = 0
						end
					end,
			text = "P1 Mode",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.PLAYER1_MODE == KOF_CONFIG.UI.MODES.EXTRA then
							this.text = "P1 Mode: Extra"
						else
							this.text = "P1 Mode: Advanced"
						end
					end,
		},
		["118"] = {
			y = 142,
			x = 137,
			info = {'P2 Mode'},
			func = function()
						KOF_CONFIG.UI.PLAYER2_MODE = KOF_CONFIG.UI.PLAYER2_MODE + 1
						KOF_CONFIG.UI.CHARACTERS_HAS_CHANGED = true
						KOF_CONFIG.UI.MODE_HAS_CHANGED = true
						
						if KOF_CONFIG.UI.PLAYER2_MODE > 1 then
							KOF_CONFIG.UI.PLAYER2_MODE  = 0
						end
					end,
			text = "P2 Mode",
			olcolour = "black",
			autofunc = function(this)
						if KOF_CONFIG.UI.PLAYER2_MODE == KOF_CONFIG.UI.MODES.EXTRA then
							this.text = "P2 Mode: Extra"
						else
							this.text = "P2 Mode: Advanced"
						end
					end,
		},
}


for key, item in pairs( character_data) do
	table.insert(guipages.character_select_settings,item)
end


guipages.guard_reversal_move_active_settings = guard_reversal_move_active_settings
local wakeup_reversal_move_active_settings = {
	title = {
		text = "Wake UP Reversal Move Active Settings",
		x = interactivegui.boxxlength/2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(0,1) end,
	},
}


guipages.wakeup_reversal_move_active_settings = wakeup_reversal_move_active_settings

function trace_line(event, line)
    if event == "call" then
        local info = debug.getinfo(2, "Sl")
        print("Calling function at line:", info.currentline)
    elseif event == "line" then
        print("Executing line:", line)
    end
end

