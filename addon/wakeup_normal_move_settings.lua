return {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'crouching D'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_D" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "CR_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_guard_times + 1
					end,
    },
    ["9"] = {
        y = 35,
        x = 8,
        info = {'standing A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_A" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "ST_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_delay  - 1
					end,
    },
    ["12"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_times - 1
					end,
    },
    ["15"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_guard_times + 1
					end,
    },
    ["17"] = {
        y = 60,
        x = 8,
        info = {'CD'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CD" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "CD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_delay  - 1
					end,
    },
    ["20"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_times - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_guard_times + 1
					end,
    },
    ["25"] = {
        y = 85,
        x = 8,
        info = {'crouching B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_B" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "CR_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_delay  - 1
					end,
    },
    ["28"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_times - 1
					end,
    },
    ["31"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_guard_times + 1
					end,
    },
    ["33"] = {
        y = 110,
        x = 8,
        info = {'crouching A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_A" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "CR_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_delay  - 1
					end,
    },
    ["36"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_times - 1
					end,
    },
    ["39"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_guard_times + 1
					end,
    },
    ["41"] = {
        y = 135,
        x = 8,
        info = {'AB'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "AB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "AB" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "AB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_delay  - 1
					end,
    },
    ["44"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_times - 1
					end,
    },
    ["47"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_guard_times + 1
					end,
    },
    ["49"] = {
        y = 10,
        x = 123,
        info = {'standing C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_D" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "ST_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_delay  - 1
					end,
    },
    ["52"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_times - 1
					end,
    },
    ["55"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_guard_times + 1
					end,
    },
    ["57"] = {
        y = 35,
        x = 123,
        info = {'standing C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_C" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "ST_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_delay  - 1
					end,
    },
    ["60"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_times - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_guard_times + 1
					end,
    },
    ["65"] = {
        y = 60,
        x = 123,
        info = {'standing B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_B" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "ST_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_delay  - 1
					end,
    },
    ["68"] = {
        y = 72,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_times - 1
					end,
    },
    ["71"] = {
        y = 72,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_guard_times + 1
					end,
    },
    ["73"] = {
        y = 85,
        x = 123,
        info = {'crouching C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_C" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "CR_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_delay  - 1
					end,
    },
    ["76"] = {
        y = 97,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_times - 1
					end,
    },
    ["79"] = {
        y = 97,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_guard_times + 1
					end,
    },
    ["81"] = {
        y = 161.6,
        x = 8,
        handle = 8,
        text = "command normals",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType("command_normals_move_settings", "WAKEUP") ) end,
    },
    ["82"] = {
        y = 161.6,
        x = 78,
        handle = 8,
        text = "specials",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType("specials_move_settings", "WAKEUP") ) end,
    },
    ["83"] = {
        y = 161.6,
        x = 118,
        handle = 8,
        text = "Supers ",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "supers_move_settings", "WAKEUP")) end,
    },
    ["84"] = {
        y = 161.6,
        x = 152,
        handle = 8,
        text = "Common ",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "commons_move_settings", "WAKEUP")) end,
    },
}
