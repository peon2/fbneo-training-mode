return {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'longer AB'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACKDASH" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACKDASH" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "BACKDASH",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"]  = 0
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_guard_times + 1
					end,
    },
    ["9"] = {
        y = 35,
        x = 8,
        info = {'super jump forward with a delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DSJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DSJ_F" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "DSJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["10"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "GUARD" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["DSJ_F"].guard_current_button ] ..")" 
						elseif "GUARD" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["DSJ_F"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "GUARD" == reversal_types.GUARD then
							moves["DSJ_F"].guard_current_button = moves["DSJ_F"].guard_current_button   +  1
							if moves["DSJ_F"].guard_current_button > 4 then
								moves["DSJ_F"].guard_current_button = 1
							end
						elseif "GUARD" == reversal_types.WAKEUP then
							moves["DSJ_F"].wakeup_current_button = moves["DSJ_F"].wakeup_current_button   +  1
							if moves["DSJ_F"].wakeup_current_button > 4 then
								moves["DSJ_F"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_delay  - 1
					end,
    },
    ["13"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_times - 1
					end,
    },
    ["16"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_guard_times + 1
					end,
    },
    ["18"] = {
        y = 60,
        x = 8,
        info = {'instant super jump back'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "INS_SJ_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "INS_SJ_B" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "INS_SJ_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["19"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "GUARD" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["INS_SJ_B"].guard_current_button ] ..")" 
						elseif "GUARD" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["INS_SJ_B"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "GUARD" == reversal_types.GUARD then
							moves["INS_SJ_B"].guard_current_button = moves["INS_SJ_B"].guard_current_button   +  1
							if moves["INS_SJ_B"].guard_current_button > 4 then
								moves["INS_SJ_B"].guard_current_button = 1
							end
						elseif "GUARD" == reversal_types.WAKEUP then
							moves["INS_SJ_B"].wakeup_current_button = moves["INS_SJ_B"].wakeup_current_button   +  1
							if moves["INS_SJ_B"].wakeup_current_button > 4 then
								moves["INS_SJ_B"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_delay  - 1
					end,
    },
    ["22"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_times - 1
					end,
    },
    ["25"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_guard_times + 1
					end,
    },
    ["27"] = {
        y = 85,
        x = 8,
        info = {'super jump forward'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "SJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "SJ_F" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "SJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_delay  - 1
					end,
    },
    ["30"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_times - 1
					end,
    },
    ["33"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_guard_times + 1
					end,
    },
    ["35"] = {
        y = 110,
        x = 8,
        info = {'Hyper Hop forward'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HH_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HH_F" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "HH_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_delay  - 1
					end,
    },
    ["38"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_times - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_guard_times + 1
					end,
    },
    ["43"] = {
        y = 135,
        x = 8,
        info = {'super jump back'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "SJ_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "SJ_B" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "SJ_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_delay  - 1
					end,
    },
    ["46"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_times - 1
					end,
    },
    ["49"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_guard_times + 1
					end,
    },
    ["51"] = {
        y = 10,
        x = 123,
        info = {'longer AB'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "LONG_AB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "LONG_AB" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "LONG_AB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_delay  - 1
					end,
    },
    ["54"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_times - 1
					end,
    },
    ["57"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_guard_times + 1
					end,
    },
    ["59"] = {
        y = 35,
        x = 123,
        info = {'hop forward with delayed  button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DH_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DH_F" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "DH_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["60"] = {
        y = 35,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "GUARD" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["DH_F"].guard_current_button ] ..")" 
						elseif "GUARD" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["DH_F"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "GUARD" == reversal_types.GUARD then
							moves["DH_F"].guard_current_button = moves["DH_F"].guard_current_button   +  1
							if moves["DH_F"].guard_current_button > 4 then
								moves["DH_F"].guard_current_button = 1
							end
						elseif "GUARD" == reversal_types.WAKEUP then
							moves["DH_F"].wakeup_current_button = moves["DH_F"].wakeup_current_button   +  1
							if moves["DH_F"].wakeup_current_button > 4 then
								moves["DH_F"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_delay  - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_times - 1
					end,
    },
    ["66"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_guard_times + 1
					end,
    },
    ["68"] = {
        y = 60,
        x = 123,
        info = {'neutral hop with delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DNEUTRALH" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DNEUTRALH" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "DNEUTRALH",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["69"] = {
        y = 60,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "GUARD" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALH"].guard_current_button ] ..")" 
						elseif "GUARD" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALH"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "GUARD" == reversal_types.GUARD then
							moves["DNEUTRALH"].guard_current_button = moves["DNEUTRALH"].guard_current_button   +  1
							if moves["DNEUTRALH"].guard_current_button > 4 then
								moves["DNEUTRALH"].guard_current_button = 1
							end
						elseif "GUARD" == reversal_types.WAKEUP then
							moves["DNEUTRALH"].wakeup_current_button = moves["DNEUTRALH"].wakeup_current_button   +  1
							if moves["DNEUTRALH"].wakeup_current_button > 4 then
								moves["DNEUTRALH"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_delay  - 1
					end,
    },
    ["72"] = {
        y = 72,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_times - 1
					end,
    },
    ["75"] = {
        y = 72,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_guard_times + 1
					end,
    },
    ["77"] = {
        y = 85,
        x = 123,
        info = {'delayed hyper hop forward with button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DHJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DHJ_F" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "DHJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["78"] = {
        y = 85,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "GUARD" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["DHJ_F"].guard_current_button ] ..")" 
						elseif "GUARD" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["DHJ_F"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "GUARD" == reversal_types.GUARD then
							moves["DHJ_F"].guard_current_button = moves["DHJ_F"].guard_current_button   +  1
							if moves["DHJ_F"].guard_current_button > 4 then
								moves["DHJ_F"].guard_current_button = 1
							end
						elseif "GUARD" == reversal_types.WAKEUP then
							moves["DHJ_F"].wakeup_current_button = moves["DHJ_F"].wakeup_current_button   +  1
							if moves["DHJ_F"].wakeup_current_button > 4 then
								moves["DHJ_F"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_delay  - 1
					end,
    },
    ["81"] = {
        y = 97,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_times - 1
					end,
    },
    ["84"] = {
        y = 97,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_guard_times + 1
					end,
    },
    ["86"] = {
        y = 110,
        x = 123,
        info = {'neutral jump with delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DNEUTRALJ" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DNEUTRALJ" .. ": ON" 
					end
					config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
        text = "DNEUTRALJ",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"]  = 0
						end
						config["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["87"] = {
        y = 110,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "GUARD" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALJ"].guard_current_button ] ..")" 
						elseif "GUARD" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALJ"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "GUARD" == reversal_types.GUARD then
							moves["DNEUTRALJ"].guard_current_button = moves["DNEUTRALJ"].guard_current_button   +  1
							if moves["DNEUTRALJ"].guard_current_button > 4 then
								moves["DNEUTRALJ"].guard_current_button = 1
							end
						elseif "GUARD" == reversal_types.WAKEUP then
							moves["DNEUTRALJ"].wakeup_current_button = moves["DNEUTRALJ"].wakeup_current_button   +  1
							if moves["DNEUTRALJ"].wakeup_current_button > 4 then
								moves["DNEUTRALJ"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_delay  - 1
					end,
    },
    ["90"] = {
        y = 122,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_times - 1
					end,
    },
    ["93"] = {
        y = 122,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_guard_times + 1
					end,
    },
}
