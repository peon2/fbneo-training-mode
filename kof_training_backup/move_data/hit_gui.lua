local HIT_GUI = {}
 
 HIT_GUI.hit_command_normals = {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_D" .. ": ON" 
					end
				end,
        text = "DF_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_D"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_D"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["2"] = {
        y = 22,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["3"] = {
        y = 22,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["5"] = {
        y = 22,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_delay + 1
					end,
    },
    ["6"] = {
        y = 22,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["8"] = {
        y = 22,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_hit_times + 1
					end,
    },
    ["9"] = {
        y = 35,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_B" .. ": ON" 
					end
					
				end,
        text = "DF_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_B"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_B"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["10"] = {
        y = 47,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["11"] = {
        y = 47,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_delay  - 1
					end,
    },
    ["12"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["13"] = {
        y = 47,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_delay + 1
					end,
    },
    ["14"] = {
        y = 47,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_times - 1
					end,
    },
    ["15"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["16"] = {
        y = 47,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_hit_times + 1
					end,
    },
    ["17"] = {
        y = 60,
        x = 8,
        info = {'forward A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "FWD_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "FWD_A" .. ": ON" 
					end
					
				end,
        text = "FWD_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_A"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_A"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["18"] = {
        y = 72,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["19"] = {
        y = 72,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_delay  - 1
					end,
    },
    ["20"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["21"] = {
        y = 72,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_delay + 1
					end,
    },
    ["22"] = {
        y = 72,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_times - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["24"] = {
        y = 72,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_hit_times + 1
					end,
    },
    ["25"] = {
        y = 85,
        x = 8,
        info = {'forward B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "FWD_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "FWD_B" .. ": ON" 
					end
					
				end,
        text = "FWD_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_B"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["FWD_B"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["26"] = {
        y = 97,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["27"] = {
        y = 97,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_delay  - 1
					end,
    },
    ["28"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["29"] = {
        y = 97,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_delay + 1
					end,
    },
    ["30"] = {
        y = 97,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_times - 1
					end,
    },
    ["31"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["32"] = {
        y = 97,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_hit_times + 1
					end,
    },
    ["33"] = {
        y = 110,
        x = 8,
        info = {'back A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACK_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACK_A" .. ": ON" 
					end
					
				end,
        text = "BACK_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_A"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_A"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["34"] = {
        y = 122,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["35"] = {
        y = 122,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_delay  - 1
					end,
    },
    ["36"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["37"] = {
        y = 122,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_delay + 1
					end,
    },
    ["38"] = {
        y = 122,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_times - 1
					end,
    },
    ["39"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_time),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["40"] = {
        y = 122,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_hit_times + 1
					end,
    },
    ["41"] = {
        y = 135,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACK_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACK_B" .. ": ON" 
					end
					
				end,
        text = "BACK_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_B"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACK_B"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["42"] = {
        y = 147,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["43"] = {
        y = 147,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_delay  - 1
					end,
    },
    ["44"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["45"] = {
        y = 147,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_delay + 1
					end,
    },
    ["46"] = {
        y = 147,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_times - 1
					end,
    },
    ["47"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_time),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["48"] = {
        y = 147,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_hit_times + 1
					end,
    },
    ["49"] = {
        y = 10,
        x = 123,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_C" .. ": ON" 
					end
					
				end,
        text = "DF_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_C"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DF_C"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["50"] = {
        y = 22,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["51"] = {
        y = 22,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_delay  - 1
					end,
    },
    ["52"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["53"] = {
        y = 22,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_delay + 1
					end,
    },
    ["54"] = {
        y = 22,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_times - 1
					end,
    },
    ["55"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["56"] = {
        y = 22,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_hit_times + 1
					end,
    },
    ["57"] = {
        y = 35,
        x = 123,
        info = {'crouching guard'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_GUARD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_GUARD" .. ": ON" 
					end
					
				end,
        text = "CR_GUARD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_GUARD"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_GUARD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_GUARD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_GUARD"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["58"] = {
        y = 47,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["59"] = {
        y = 47,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_delay  - 1
					end,
    },
    ["60"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["61"] = {
        y = 47,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_delay + 1
					end,
    },
    ["62"] = {
        y = 47,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_times - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["64"] = {
        y = 47,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_hit_times + 1
					end,
    },
}


HIT_GUI.hit_normals =  {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'crouching D'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_D" .. ": ON" 
					end
					
				end,
        text = "CR_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_D"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_D"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["2"] = {
        y = 22,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["3"] = {
        y = 22,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["5"] = {
        y = 22,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_delay + 1
					end,
    },
    ["6"] = {
        y = 22,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["8"] = {
        y = 22,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_hit_times + 1
					end,
    },
    ["9"] = {
        y = 35,
        x = 8,
        info = {'standing A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_A" .. ": ON" 
					end
					
				end,
        text = "ST_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_A"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_A"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["10"] = {
        y = 47,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["11"] = {
        y = 47,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_delay  - 1
					end,
    },
    ["12"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["13"] = {
        y = 47,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_delay + 1
					end,
    },
    ["14"] = {
        y = 47,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_times - 1
					end,
    },
    ["15"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["16"] = {
        y = 47,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_hit_times + 1
					end,
    },
    ["17"] = {
        y = 60,
        x = 8,
        info = {'CD'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CD" .. ": ON" 
					end
					
				end,
        text = "CD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CD"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CD"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["18"] = {
        y = 72,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["19"] = {
        y = 72,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_delay  - 1
					end,
    },
    ["20"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["21"] = {
        y = 72,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_delay + 1
					end,
    },
    ["22"] = {
        y = 72,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_times - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["24"] = {
        y = 72,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_hit_times + 1
					end,
    },
    ["25"] = {
        y = 85,
        x = 8,
        info = {'crouching B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_B" .. ": ON" 
					end
					
				end,
        text = "CR_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_B"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_B"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["26"] = {
        y = 97,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["27"] = {
        y = 97,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_delay  - 1
					end,
    },
    ["28"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["29"] = {
        y = 97,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_delay + 1
					end,
    },
    ["30"] = {
        y = 97,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_times - 1
					end,
    },
    ["31"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["32"] = {
        y = 97,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_hit_times + 1
					end,
    },
    ["33"] = {
        y = 110,
        x = 8,
        info = {'crouching A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_A" .. ": ON" 
					end
					
				end,
        text = "CR_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_A"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_A"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["34"] = {
        y = 122,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["35"] = {
        y = 122,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_delay  - 1
					end,
    },
    ["36"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["37"] = {
        y = 122,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_delay + 1
					end,
    },
    ["38"] = {
        y = 122,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_times - 1
					end,
    },
    ["39"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["40"] = {
        y = 122,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_hit_times + 1
					end,
    },
    ["41"] = {
        y = 135,
        x = 8,
        info = {'AB'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "AB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "AB" .. ": ON" 
					end
					
				end,
        text = "AB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["AB"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["AB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["AB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["AB"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["42"] = {
        y = 147,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["43"] = {
        y = 147,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_delay  - 1
					end,
    },
    ["44"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["45"] = {
        y = 147,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_delay + 1
					end,
    },
    ["46"] = {
        y = 147,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_times - 1
					end,
    },
    ["47"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["48"] = {
        y = 147,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_hit_times + 1
					end,
    },
    ["49"] = {
        y = 10,
        x = 123,
        info = {'standing C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_D" .. ": ON" 
					end
					
				end,
        text = "ST_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_D"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_D"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["50"] = {
        y = 22,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["51"] = {
        y = 22,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_delay  - 1
					end,
    },
    ["52"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["53"] = {
        y = 22,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_delay + 1
					end,
    },
    ["54"] = {
        y = 22,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_times - 1
					end,
    },
    ["55"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["56"] = {
        y = 22,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_hit_times + 1
					end,
    },
    ["57"] = {
        y = 35,
        x = 123,
        info = {'standing C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_C" .. ": ON" 
					end
					
				end,
        text = "ST_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_C"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_C"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["58"] = {
        y = 47,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["59"] = {
        y = 47,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_delay  - 1
					end,
    },
    ["60"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["61"] = {
        y = 47,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_delay + 1
					end,
    },
    ["62"] = {
        y = 47,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_times - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["64"] = {
        y = 47,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_hit_times + 1
					end,
    },
    ["65"] = {
        y = 60,
        x = 123,
        info = {'standing B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_B" .. ": ON" 
					end
					
				end,
        text = "ST_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_B"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ST_B"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["66"] = {
        y = 72,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["67"] = {
        y = 72,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_delay  - 1
					end,
    },
    ["68"] = {
        y = 72,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["69"] = {
        y = 72,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_delay + 1
					end,
    },
    ["70"] = {
        y = 72,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_times - 1
					end,
    },
    ["71"] = {
        y = 72,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["72"] = {
        y = 72,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_hit_times + 1
					end,
    },
    ["73"] = {
        y = 85,
        x = 123,
        info = {'crouching C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_C" .. ": ON" 
					end
					
				end,
        text = "CR_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_C"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["CR_C"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["74"] = {
        y = 97,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["75"] = {
        y = 97,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_delay  - 1
					end,
    },
    ["76"] = {
        y = 97,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["77"] = {
        y = 97,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_delay + 1
					end,
    },
    ["78"] = {
        y = 97,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_times - 1
					end,
    },
    ["79"] = {
        y = 97,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["80"] = {
        y = 97,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_hit_times + 1
					end,
    },
    ["81"] = {
        y = 110,
        x = 123,
        info = {'throw C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["THROW_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "THROW_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["THROW_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "THROW_C" .. ": ON" 
					end
					
				end,
        text = "THROW_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["THROW_C"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["THROW_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["THROW_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["THROW_C"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["82"] = {
        y = 122,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["83"] = {
        y = 122,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_delay  - 1
					end,
    },
    ["84"] = {
        y = 122,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["85"] = {
        y = 122,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_delay + 1
					end,
    },
    ["86"] = {
        y = 122,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_times - 1
					end,
    },
    ["87"] = {
        y = 122,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["88"] = {
        y = 122,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_hit_times + 1
					end,
    },
    ["89"] = {
        y = 161.6,
        x = 8,
        handle = 8,
        text = "command normals",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType("command_normals_move_settings", "HIT") ) end,
    },
    ["90"] = {
        y = 161.6,
        x = 78,
        handle = 8,
        text = "specials",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType("specials_move_settings", "HIT") ) end,
    },
    ["91"] = {
        y = 161.6,
        x = 118,
        handle = 8,
        text = "Supers ",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "supers_move_settings", "HIT")) end,
    },
    ["92"] = {
        y = 161.6,
        x = 152,
        handle = 8,
        text = "Common ",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "commons_move_settings", "HIT")) end,
    },
    ["93"] = {
        y = 161.6,
        x = 185,
        handle = 8,
        text = "Recordings",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "recordings_move_settings", "HIT")) end,
    },
}


HIT_GUI.hit_specials = {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'Half circle Back (63214)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCB" .. ": ON" 
					end
					
				end,
        text = "HCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["2"] = {
        y = 10,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB"].hit_current_button ] ..")" 											
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCB"].hit_current_button = moves["HCB"].hit_current_button   +  1
							if moves["HCB"].hit_current_button > 4 then
								moves["HCB"].hit_current_button = 1
							end
					end,
    },
    ["3"] = {
        y = 22,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["4"] = {
        y = 22,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_delay  - 1
					end,
    },
    ["5"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["6"] = {
        y = 22,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_delay + 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_times - 1
					end,
    },
    ["8"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["9"] = {
        y = 22,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_hit_times + 1
					end,
    },
    ["10"] = {
        y = 35,
        x = 8,
        info = {'Quarter circle Back (214)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB" .. ": ON" 
					end
					
				end,
        text = "QCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["11"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
                        moves["QCB"].hit_current_button = moves["QCB"].hit_current_button   +  1
                        if moves["QCB"].hit_current_button > 4 then
                            moves["QCB"].hit_current_button = 1
                        end
					end,
    },
    ["12"] = {
        y = 47,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["13"] = {
        y = 47,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_delay  - 1
					end,
    },
    ["14"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["15"] = {
        y = 47,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_delay + 1
					end,
    },
    ["16"] = {
        y = 47,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_times - 1
					end,
    },
    ["17"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["18"] = {
        y = 47,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_hit_times + 1
					end,
    },
    ["19"] = {
        y = 60,
        x = 8,
        info = {'k9999 super'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["D_F_DF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "D_F_DF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["D_F_DF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "D_F_DF" .. ": ON" 
					end
					
				end,
        text = "D_F_DF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["D_F_DF"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["D_F_DF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["D_F_DF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["D_F_DF"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["20"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["D_F_DF"].hit_current_button ] ..")" 												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["D_F_DF"].hit_current_button = moves["D_F_DF"].hit_current_button   +  1
							if moves["D_F_DF"].hit_current_button > 4 then
								moves["D_F_DF"].hit_current_button = 1
							end
					end,
    },
    ["21"] = {
        y = 72,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["22"] = {
        y = 72,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_delay  - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["24"] = {
        y = 72,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_delay + 1
					end,
    },
    ["25"] = {
        y = 72,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_times - 1
					end,
    },
    ["26"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["27"] = {
        y = 72,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_hit_times + 1
					end,
    },
    ["28"] = {
        y = 85,
        x = 8,
        info = {'Half circle Back Forward (632146)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCB_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCB_F" .. ": ON" 
					end
					
				end,
        text = "HCB_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB_F"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCB_F"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["29"] = {
        y = 85,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB_F"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCB_F"].hit_current_button = moves["HCB_F"].hit_current_button   +  1
							if moves["HCB_F"].hit_current_button > 4 then
								moves["HCB_F"].hit_current_button = 1
							end
					end,
    },
    ["30"] = {
        y = 97,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["31"] = {
        y = 97,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_delay  - 1
					end,
    },
    ["32"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["33"] = {
        y = 97,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_delay + 1
					end,
    },
    ["34"] = {
        y = 97,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_times - 1
					end,
    },
    ["35"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["36"] = {
        y = 97,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_hit_times + 1
					end,
    },
    ["37"] = {
        y = 110,
        x = 8,
        info = {'Half circle forward (41236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCF" .. ": ON" 
					end
					
				end,
        text = "HCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCF"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HCF"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["38"] = {
        y = 110,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCF"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCF"].hit_current_button = moves["HCF"].hit_current_button   +  1
							if moves["HCF"].hit_current_button > 4 then
								moves["HCF"].hit_current_button = 1
							end
					end,
    },
    ["39"] = {
        y = 122,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["40"] = {
        y = 122,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_delay  - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["42"] = {
        y = 122,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_delay + 1
					end,
    },
    ["43"] = {
        y = 122,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_times - 1
					end,
    },
    ["44"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["45"] = {
        y = 122,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_hit_times + 1
					end,
    },
    ["46"] = {
        y = 135,
        x = 8,
        info = {'Dragon Punch (623)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DP" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DP" .. ": ON" 
					end
					
				end,
        text = "DP",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DP"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DP"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DP"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DP"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["47"] = {
        y = 135,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DP"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DP"].hit_current_button = moves["DP"].hit_current_button   +  1
							if moves["DP"].hit_current_button > 4 then
								moves["DP"].hit_current_button = 1
							end
					end,
    },
    ["48"] = {
        y = 147,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["49"] = {
        y = 147,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_delay  - 1
					end,
    },
    ["50"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["51"] = {
        y = 147,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_delay + 1
					end,
    },
    ["52"] = {
        y = 147,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_times - 1
					end,
    },
    ["53"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["54"] = {
        y = 147,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_hit_times + 1
					end,
    },
    ["55"] = {
        y = 10,
        x = 123,
        info = {'Quarter circle forward (236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF" .. ": ON" 
					end
					
				end,
        text = "QCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["56"] = {
        y = 10,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF"].hit_current_button = moves["QCF"].hit_current_button   +  1
							if moves["QCF"].hit_current_button > 4 then
								moves["QCF"].hit_current_button = 1
							end
					end,
    },
    ["57"] = {
        y = 22,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["58"] = {
        y = 22,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_delay  - 1
					end,
    },
    ["59"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["60"] = {
        y = 22,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_delay + 1
					end,
    },
    ["61"] = {
        y = 22,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_times - 1
					end,
    },
    ["62"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["63"] = {
        y = 22,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_hit_times + 1
					end,
    },
    ["64"] = {
        y = 35,
        x = 123,
        info = {'Reverse DP (421)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["R_DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "R_DP" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["R_DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "R_DP" .. ": ON" 
					end
					
				end,
        text = "R_DP",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["R_DP"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["R_DP"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["R_DP"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["R_DP"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["65"] = {
        y = 35,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["R_DP"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["R_DP"].hit_current_button = moves["R_DP"].hit_current_button   +  1
							if moves["R_DP"].hit_current_button > 4 then
								moves["R_DP"].hit_current_button = 1
							end
					end,
    },
    ["66"] = {
        y = 47,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["67"] = {
        y = 47,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_delay  - 1
					end,
    },
    ["68"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["69"] = {
        y = 47,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_delay + 1
					end,
    },
    ["70"] = {
        y = 47,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_times - 1
					end,
    },
    ["71"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["72"] = {
        y = 47,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_hit_times + 1
					end,
    },
}


HIT_GUI.hit_supers = {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'Quarter circle Back Half circle Forward (214236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB_HCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB_HCF" .. ": ON" 
					end
					
				end,
        text = "QCB_HCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_HCF"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_HCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_HCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_HCF"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["2"] = {
        y = 10,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_HCF"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCB_HCF"].hit_current_button = moves["QCB_HCF"].hit_current_button   +  1
							if moves["QCB_HCF"].hit_current_button > 4 then
								moves["QCB_HCF"].hit_current_button = 1
							end
					end,
    },
    ["3"] = {
        y = 22,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["4"] = {
        y = 22,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_delay  - 1
					end,
    },
    ["5"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["6"] = {
        y = 22,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_delay + 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_times - 1
					end,
    },
    ["8"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["9"] = {
        y = 22,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_hit_times + 1
					end,
    },
    ["10"] = {
        y = 35,
        x = 8,
        info = {'pretzel (1632143)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["PRETZEL"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "PRETZEL" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["PRETZEL"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "PRETZEL" .. ": ON" 
					end
					
				end,
        text = "PRETZEL",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["PRETZEL"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["PRETZEL"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["PRETZEL"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["PRETZEL"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["11"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["PRETZEL"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["PRETZEL"].hit_current_button = moves["PRETZEL"].hit_current_button   +  1
							if moves["PRETZEL"].hit_current_button > 4 then
								moves["PRETZEL"].hit_current_button = 1
							end
					end,
    },
    ["12"] = {
        y = 47,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["13"] = {
        y = 47,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_delay  - 1
					end,
    },
    ["14"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["15"] = {
        y = 47,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_delay + 1
					end,
    },
    ["16"] = {
        y = 47,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_times - 1
					end,
    },
    ["17"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["18"] = {
        y = 47,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_hit_times + 1
					end,
    },
    ["19"] = {
        y = 60,
        x = 8,
        info = {'Quarter circle forward (236214)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF_HCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF_HCB" .. ": ON" 
					end
					
				end,
        text = "QCF_HCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_HCB"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_HCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_HCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_HCB"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["20"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_HCB"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF_HCB"].hit_current_button = moves["QCF_HCB"].hit_current_button   +  1
							if moves["QCF_HCB"].hit_current_button > 4 then
								moves["QCF_HCB"].hit_current_button = 1
							end
					end,
    },
    ["21"] = {
        y = 72,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["22"] = {
        y = 72,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_delay  - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["24"] = {
        y = 72,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_delay + 1
					end,
    },
    ["25"] = {
        y = 72,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_times - 1
					end,
    },
    ["26"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["27"] = {
        y = 72,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_hit_times + 1
					end,
    },
    ["28"] = {
        y = 85,
        x = 8,
        info = {'Quarter circle Back Forward (2146)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB_F" .. ": ON" 
					end
					
				end,
        text = "QCB_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_F"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCB_F"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["29"] = {
        y = 85,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_F"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCB_F"].hit_current_button = moves["QCB_F"].hit_current_button   +  1
							if moves["QCB_F"].hit_current_button > 4 then
								moves["QCB_F"].hit_current_button = 1
							end
					end,
    },
    ["30"] = {
        y = 97,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["31"] = {
        y = 97,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_delay  - 1
					end,
    },
    ["32"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["33"] = {
        y = 97,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_delay + 1
					end,
    },
    ["34"] = {
        y = 97,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_times - 1
					end,
    },
    ["35"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["36"] = {
        y = 97,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_hit_times + 1
					end,
    },
    ["37"] = {
        y = 110,
        x = 8,
        info = {'Quarter circle forward * 2 (236236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF_QCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF_QCF" .. ": ON" 
					end
					
				end,
        text = "QCF_QCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_QCF"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_QCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_QCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["QCF_QCF"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["38"] = {
        y = 110,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_QCF"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF_QCF"].hit_current_button = moves["QCF_QCF"].hit_current_button   +  1
							if moves["QCF_QCF"].hit_current_button > 4 then
								moves["QCF_QCF"].hit_current_button = 1
							end
					end,
    },
    ["39"] = {
        y = 122,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["40"] = {
        y = 122,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_delay  - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["42"] = {
        y = 122,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_delay + 1
					end,
    },
    ["43"] = {
        y = 122,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_times - 1
					end,
    },
    ["44"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["45"] = {
        y = 122,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_hit_times + 1
					end,
                  },
}

HIT_GUI.hit_commons = {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'longer AB'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACKDASH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACKDASH" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACKDASH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACKDASH" .. ": ON" 
					end
					
				end,
        text = "BACKDASH",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACKDASH"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACKDASH"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACKDASH"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["BACKDASH"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["2"] = {
        y = 22,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["3"] = {
        y = 22,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["5"] = {
        y = 22,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_delay + 1
					end,
    },
    ["6"] = {
        y = 22,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["8"] = {
        y = 22,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_hit_times + 1
					end,
    },
    ["9"] = {
        y = 35,
        x = 8,
        info = {'super jump forward with a delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DSJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DSJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DSJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DSJ_F" .. ": ON" 
					end
					
				end,
        text = "DSJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DSJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DSJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DSJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DSJ_F"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["10"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DSJ_F"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DSJ_F"].hit_current_button = moves["DSJ_F"].hit_current_button   +  1
							if moves["DSJ_F"].hit_current_button > 4 then
								moves["DSJ_F"].hit_current_button = 1
							end
					end,
    },
    ["11"] = {
        y = 47,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["12"] = {
        y = 47,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_delay  - 1
					end,
    },
    ["13"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["14"] = {
        y = 47,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_delay + 1
					end,
    },
    ["15"] = {
        y = 47,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_times - 1
					end,
    },
    ["16"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["17"] = {
        y = 47,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_hit_times + 1
					end,
    },
    ["18"] = {
        y = 60,
        x = 8,
        info = {'instant super jump back'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["INS_SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "INS_SJ_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["INS_SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "INS_SJ_B" .. ": ON" 
					end
					
				end,
        text = "INS_SJ_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["INS_SJ_B"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["INS_SJ_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["INS_SJ_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["INS_SJ_B"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["19"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["INS_SJ_B"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["INS_SJ_B"].hit_current_button = moves["INS_SJ_B"].hit_current_button   +  1
							if moves["INS_SJ_B"].hit_current_button > 4 then
								moves["INS_SJ_B"].hit_current_button = 1
							end
					end,
    },
    ["20"] = {
        y = 72,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["21"] = {
        y = 72,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_delay  - 1
					end,
    },
    ["22"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["23"] = {
        y = 72,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_delay + 1
					end,
    },
    ["24"] = {
        y = 72,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_times - 1
					end,
    },
    ["25"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["26"] = {
        y = 72,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_hit_times + 1
					end,
    },
    ["27"] = {
        y = 85,
        x = 8,
        info = {'super jump forward'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "SJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "SJ_F" .. ": ON" 
					end
					
				end,
        text = "SJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_F"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["28"] = {
        y = 97,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["29"] = {
        y = 97,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_delay  - 1
					end,
    },
    ["30"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["31"] = {
        y = 97,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_delay + 1
					end,
    },
    ["32"] = {
        y = 97,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_times - 1
					end,
    },
    ["33"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["34"] = {
        y = 97,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_hit_times + 1
					end,
    },
    ["35"] = {
        y = 110,
        x = 8,
        info = {'Hyper Hop forward'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HH_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HH_F" .. ": ON" 
					end
					
				end,
        text = "HH_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HH_F"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HH_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HH_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["HH_F"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["36"] = {
        y = 122,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["37"] = {
        y = 122,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_delay  - 1
					end,
    },
    ["38"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["39"] = {
        y = 122,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_delay + 1
					end,
    },
    ["40"] = {
        y = 122,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_times - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["42"] = {
        y = 122,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_hit_times + 1
					end,
    },
    ["43"] = {
        y = 135,
        x = 8,
        info = {'super jump back'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "SJ_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "SJ_B" .. ": ON" 
					end
					
				end,
        text = "SJ_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_B"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["SJ_B"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["44"] = {
        y = 147,
        x = 8,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["45"] = {
        y = 147,
        x = 42,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_delay  - 1
					end,
    },
    ["46"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["47"] = {
        y = 147,
        x = 68,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_delay + 1
					end,
    },
    ["48"] = {
        y = 147,
        x = 83,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_times - 1
					end,
    },
    ["49"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["50"] = {
        y = 147,
        x = 107,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_hit_times + 1
					end,
    },
    ["51"] = {
        y = 10,
        x = 123,
        info = {'longer AB'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["LONG_AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "LONG_AB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["LONG_AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "LONG_AB" .. ": ON" 
					end
					
				end,
        text = "LONG_AB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["LONG_AB"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["LONG_AB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["LONG_AB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["LONG_AB"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["52"] = {
        y = 22,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["53"] = {
        y = 22,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_delay  - 1
					end,
    },
    ["54"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["55"] = {
        y = 22,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_delay + 1
					end,
    },
    ["56"] = {
        y = 22,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_times - 1
					end,
    },
    ["57"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["58"] = {
        y = 22,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_hit_times + 1
					end,
    },
    ["59"] = {
        y = 35,
        x = 123,
        info = {'hop forward with delayed  button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DH_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DH_F" .. ": ON" 
					end
					
				end,
        text = "DH_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DH_F"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DH_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DH_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DH_F"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["60"] = {
        y = 35,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DH_F"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DH_F"].hit_current_button = moves["DH_F"].hit_current_button   +  1
							if moves["DH_F"].hit_current_button > 4 then
								moves["DH_F"].hit_current_button = 1
							end
					end,
    },
    ["61"] = {
        y = 47,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["62"] = {
        y = 47,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_delay  - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["64"] = {
        y = 47,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_delay + 1
					end,
    },
    ["65"] = {
        y = 47,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_times - 1
					end,
    },
    ["66"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["67"] = {
        y = 47,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_hit_times + 1
					end,
    },
    ["68"] = {
        y = 60,
        x = 123,
        info = {'neutral hop with delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DNEUTRALH" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DNEUTRALH" .. ": ON" 
					end
					
				end,
        text = "DNEUTRALH",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALH"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALH"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALH"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALH"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["69"] = {
        y = 60,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALH"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DNEUTRALH"].hit_current_button = moves["DNEUTRALH"].hit_current_button   +  1
							if moves["DNEUTRALH"].hit_current_button > 4 then
								moves["DNEUTRALH"].hit_current_button = 1
							end
					end,
    },
    ["70"] = {
        y = 72,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["71"] = {
        y = 72,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_delay  - 1
					end,
    },
    ["72"] = {
        y = 72,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["73"] = {
        y = 72,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_delay + 1
					end,
    },
    ["74"] = {
        y = 72,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_times - 1
					end,
    },
    ["75"] = {
        y = 72,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["76"] = {
        y = 72,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_hit_times + 1
					end,
    },
    ["77"] = {
        y = 85,
        x = 123,
        info = {'delayed hyper hop forward with button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DHJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DHJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DHJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DHJ_F" .. ": ON" 
					end
					
				end,
        text = "DHJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DHJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DHJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DHJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DHJ_F"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["78"] = {
        y = 85,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DHJ_F"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DHJ_F"].hit_current_button = moves["DHJ_F"].hit_current_button   +  1
							if moves["DHJ_F"].hit_current_button > 4 then
								moves["DHJ_F"].hit_current_button = 1
							end
					end,
    },
    ["79"] = {
        y = 97,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["80"] = {
        y = 97,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_delay  - 1
					end,
    },
    ["81"] = {
        y = 97,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["82"] = {
        y = 97,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_delay + 1
					end,
    },
    ["83"] = {
        y = 97,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_times - 1
					end,
    },
    ["84"] = {
        y = 97,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["85"] = {
        y = 97,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_hit_times + 1
					end,
    },
    ["86"] = {
        y = 110,
        x = 123,
        info = {'neutral jump with delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALJ"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DNEUTRALJ" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALJ"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DNEUTRALJ" .. ": ON" 
					end
					
				end,
        text = "DNEUTRALJ",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALJ"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALJ"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALJ"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["DNEUTRALJ"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["87"] = {
        y = 110,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALJ"].hit_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DNEUTRALJ"].hit_current_button = moves["DNEUTRALJ"].hit_current_button   +  1
							if moves["DNEUTRALJ"].hit_current_button > 4 then
								moves["DNEUTRALJ"].hit_current_button = 1
							end
					end,
    },
    ["88"] = {
        y = 122,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["89"] = {
        y = 122,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_delay  - 1
					end,
    },
    ["90"] = {
        y = 122,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["91"] = {
        y = 122,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_delay + 1
					end,
    },
    ["92"] = {
        y = 122,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_times - 1
					end,
    },
    ["93"] = {
        y = 122,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["94"] = {
        y = 122,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_hit_times + 1
					end,
    },
    ["95"] = {
        y = 135,
        x = 123,
        info = {'alternate guard'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ALT_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ALT_GUARD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ALT_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ALT_GUARD" .. ": ON" 
					end
					
				end,
        text = "ALT_GUARD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ALT_GUARD"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ALT_GUARD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ALT_GUARD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["ALT_GUARD"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["97"] = {
        y = 147,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on guard'},
        text = "d & t:",
        olcolour = "black",
        func = function()
						-- Function for "delay: "
					end,
    },
    ["98"] = {
        y = 147,
        x = 157,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) delay"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_delay  - 1
					end,
    },
    ["99"] = {
        y = 147,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_delay),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["100"] = {
        y = 147,
        x = 183,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						-- Function for "(+) delay"
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_delay + 1
					end,
    },
    ["101"] = {
        y = 147,
        x = 198,
        info = {},
        text = "-",
        olcolour = "black",
        func = function()
						-- Function for "(-) times"				
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_times - 1
					end,
    },
    ["102"] = {
        y = 147,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_times),
        olcolour = "black",
        func = function()
						
					end,
    },
    ["103"] = {
        y = 147,
        x = 222,
        info = {},
        text = "+",
        olcolour = "black",
        func = function()
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_hit_times + 1
					end,
  },
}

HIT_GUI.hit_recordings = { 
    
    ["1"] = {
        y = 10,
        x = 8,
        info = {'Recording 1'},
        autofunc = function(this)
					if not next(recording[1]) then
						this.text = "REC_1" .. ": empty" 
                        
                        
                    elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_1"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "REC_1" .. ": Off" 
                        
                        if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_1"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF then
                            KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_1").propagates = false
                        end
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_1"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "REC_1" .. ": ON" 
					end
					
				end,
        text = "REC_1",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_1"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_1"] + 1
						if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_1"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_1"]  = 0
						end
						KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
				end,
    },
    ["2"] = {
        y = 22,
        x = 8,
        info = {'this is to check if the recordng should execute afterwards or during the guard move'},
        autofunc = function(this)
					if not next(recording[1]) then
						this.text = "Prop REC_1" .. ": N/A" 
                        
                    elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_1").propagates == false) then
						this.text = "Prop REC_1" .. ": false" 
					elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_1").propagates == true) then
						this.text = "Prop REC_1" .. ": true" 
					end
					
				end,
        text = "Propagate:",
        olcolour = "black",
        func = function()
						-- Function for "propagate: "
                        KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_1").propagates = not KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_1").propagates
                         
					end,
    },
    --REC 2 --
    ["3"] = {
        y = 34,
        x = 8,
        info = {'Recording 2'},
        autofunc = function(this)
                    
            if not next(recording[2]) then
                this.text = "REC_2" .. ": empty" 
                
            elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_2"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
                        this.text = "REC_2" .. ": Off" 
                        
                        if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_2"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF then
                            KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_2").propagates = false
                        end
                    elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_2"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
                        this.text = "REC_2" .. ": ON" 
                    end
                end,
        text = "REC_2",
        olcolour = "black",
        func = function()
                    KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_2"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_2"]+ 1
                    if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_2"] > 1 then
                        KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_2"]  = 0
                    end
                    KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
                end,
    },
    ["4"] = {
        y = 46,
        x = 8,
        info = {'this is to check if the recordng should execute afterwards or during the guard move'},
        autofunc = function(this)
					if not next(recording[2]) then
						this.text = "Prop REC_2" .. ": N/A" 
                        
                    elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_2").propagates == false) then
						this.text = "Prop REC_2" .. ": false" 
					elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_2").propagates == true) then
						this.text = "Prop REC_2" .. ": true" 
					end
					
				end,
        text = "Propagate:",
        olcolour = "black",
        func = function()
						-- Function for "propagate: "
                        KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_2").propagates = not KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_2").propagates
                         
					end,
    }    ,
    -- REC 3 --
    ["5"] = {
        y = 58,
        x = 8,
        info = {'Recording 3'},
        autofunc = function(this)
                    
            if not next(recording[3]) then
                this.text = "REC_3" .. ": empty" 
                
            elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_3"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
                        this.text = "REC_3" .. ": Off" 
                        
                        if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_3"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF then
                            KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_3").propagates = false
                        end
                    elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_3"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
                        this.text = "REC_3" .. ": ON" 
                    end
                end,
        text = "REC_3",
        olcolour = "black",
        func = function()
                    KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_3"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_3"]+ 1
                    if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_3"] > 1 then
                        KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_3"]  = 0
                    end
                    KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
                end,
    },
    ["6"] = {
        y = 70,
        x = 8,
        info = {'this is to check if the recordng should execute afterwards or during the guard move'},
        autofunc = function(this)
					if not next(recording[3]) then
						this.text = "Prop REC_3" .. ": N/A" 
                        
                    elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_3").propagates == false) then
						this.text = "Prop REC_3" .. ": false" 
					elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_3").propagates == true) then
						this.text = "Prop REC_3" .. ": true" 
					end
					
				end,
        text = "Propagate:",
        olcolour = "black",
        func = function()
						-- Function for "propagate: "
                        KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_3").propagates = not KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_3").propagates
                         
					end,
    },
    -- REC 4 -- 
    ["7"] = {
        y = 82,
        x = 8,
        info = {'Recording 4'},
        autofunc = function(this)
                    
            if not next(recording[4]) then
                this.text = "REC_4" .. ": empty" 
                
            elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_4"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
                        this.text = "REC_4" .. ": Off" 
                        
                        if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_4"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF then
                            KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_4").propagates = false
                        end
                    elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_4"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
                        this.text = "REC_4" .. ": ON" 
                    end
                end,
        text = "REC_4",
        olcolour = "black",
        func = function()
                    KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_4"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_4"]+ 1
                    if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_4"] > 1 then
                        KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_4"]  = 0
                    end
                    KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
                end,
    },
    ["8"] = {
        y = 94,
        x = 8,
        info = {'this is to check if the recordng should execute afterwards or during the guard move'},
        autofunc = function(this)
					if not next(recording[4]) then
						this.text = "Prop REC_4" .. ": N/A" 
                        
                    elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_4").propagates == false) then
						this.text = "Prop REC_4" .. ": false" 
					elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_4").propagates == true) then
						this.text = "Prop REC_4" .. ": true" 
					end
					
				end,
        text = "Propagate:",
        olcolour = "black",
        func = function()
						-- Function for "propagate: "
                        KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_4").propagates = not KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_4").propagates
                         
					end,
    },
    -- REC 5 -- 
    ["9"] = {
        y = 106,
        x = 8,
        info = {'Recording 5'},
        autofunc = function(this)
                    
                    if not next(recording[5]) then
						this.text = "REC_5" .. ": empty" 
                        
                    elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_5"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
                        this.text = "REC_5" .. ": Off" 
                        
                        if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_5"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF then
                            KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_5").propagates = false
                        end
                    elseif (KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_5"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
                        this.text = "REC_5" .. ": ON" 
                    end
                end,
        text = "REC_5",
        olcolour = "black",
        func = function()
                    KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_5"] = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_5"]+ 1
                    if KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_5"] > 1 then
                        KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_5"]  = 0
                    end
                    KOF_CONFIG["HIT"].reversal_moves = getCurrentReversalMoves("HIT")
                end,
    },
    ["10"] = {
        y = 118,
        x = 8,
        info = {'this is to check if the recordng should execute afterwards or during the guard move'},
        autofunc = function(this)
					if not next(recording[5]) then
						this.text = "Prop REC_5" .. ": N/A" 
                        
                    elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_5").propagates == false) then
						this.text = "Prop REC_5" .. ": false" 
					elseif ( KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_5").propagates == true) then
						this.text = "Prop REC_5" .. ": true" 
					end
					
				end,
        text = "Propagate:",
        olcolour = "black",
        func = function()
						-- Function for "propagate: "
                        KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_5").propagates = not KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_5").propagates
                         
					end,
    },
    ["11"] = {
        x = 80,
        y = 10,
        info = {'Save current recording setup to file'},
        autofunc = function(this)
					if isRecordingEmpty() then
                       this.text = "Setup to Save" .. ": N/A" 
                    else
                       this.text = "Save Setup for: " .. getCurrentSetupName()
                    end

					
				end,
        text = "..non data:",
        olcolour = "black",
        func = function()
                        if isRecordingEmpty() then
                            return
                        end
						-- Function for "save current setup to file: "
                       local setup = buildSetup()
                       setup.guard = true
                       setup.hit_CONFIG = KOF_CONFIG["HIT"]
                       setup.RECOVERY_CONFIG = KOF_CONFIG["RECOVERY"] -- Probably good to include recovery too like wakeup does
                       for i =1,5 do
                            setup.recording_var_states[i] = {}
                            setup.recording_var_states[i].value = KOF_CONFIG.MOVES_VAR_NAMES["HIT"]["REC_"..i]
                            setup.recording_var_states[i].propagates = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("REC_"..i).propagates
                       end

                       DBIndex.createSetup(setup)
                        -- refresh setups page immediately
                        refreshSetupMenu()
                       
                         
					end,
    },
}

return HIT_GUI