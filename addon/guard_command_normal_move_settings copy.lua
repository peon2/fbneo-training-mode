return {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_D" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "DF_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_guard_times + 1
					end,
    },
    ["9"] = {
        y = 35,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_B" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "DF_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_delay  - 1
					end,
    },
    ["12"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_times - 1
					end,
    },
    ["15"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_guard_times + 1
					end,
    },
    ["17"] = {
        y = 60,
        x = 8,
        info = {'forward A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "FWD_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "FWD_A" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "FWD_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_delay  - 1
					end,
    },
    ["20"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_times - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_guard_times + 1
					end,
    },
    ["25"] = {
        y = 85,
        x = 8,
        info = {'forward B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "FWD_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "FWD_B" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "FWD_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_delay  - 1
					end,
    },
    ["28"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_times - 1
					end,
    },
    ["31"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_guard_times + 1
					end,
    },
    ["33"] = {
        y = 110,
        x = 8,
        info = {'back A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACK_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACK_A" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "BACK_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_delay  - 1
					end,
    },
    ["36"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_times - 1
					end,
    },
    ["39"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_time),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_guard_times + 1
					end,
    },
    ["41"] = {
        y = 135,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACK_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACK_B" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "BACK_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_delay  - 1
					end,
    },
    ["44"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_times - 1
					end,
    },
    ["47"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_time),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_guard_times + 1
					end,
    },
    ["49"] = {
        y = 10,
        x = 123,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_C" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "DF_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_delay  - 1
					end,
    },
    ["52"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_times - 1
					end,
    },
    ["55"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_guard_times + 1
					end,
    },
}
