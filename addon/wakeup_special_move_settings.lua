return {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'Half circle Back (63214)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCB" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "HCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["2"] = {
        y = 10,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "WAKEUP" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["HCB"].guard_current_button = moves["HCB"].guard_current_button   +  1
							if moves["HCB"].guard_current_button > 4 then
								moves["HCB"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["HCB"].wakeup_current_button = moves["HCB"].wakeup_current_button   +  1
							if moves["HCB"].wakeup_current_button > 4 then
								moves["HCB"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_delay  - 1
					end,
    },
    ["5"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_times - 1
					end,
    },
    ["8"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_guard_times + 1
					end,
    },
    ["10"] = {
        y = 35,
        x = 8,
        info = {'Quarter circle Back (214)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "QCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["11"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "WAKEUP" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["QCB"].guard_current_button = moves["QCB"].guard_current_button   +  1
							if moves["QCB"].guard_current_button > 4 then
								moves["QCB"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["QCB"].wakeup_current_button = moves["QCB"].wakeup_current_button   +  1
							if moves["QCB"].wakeup_current_button > 4 then
								moves["QCB"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_delay  - 1
					end,
    },
    ["14"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_times - 1
					end,
    },
    ["17"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_guard_times + 1
					end,
    },
    ["19"] = {
        y = 60,
        x = 8,
        info = {'dpc'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DPC"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DPC" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DPC"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DPC" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "DPC",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DPC"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DPC"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DPC"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DPC"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["20"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "WAKEUP" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["DPC"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["DPC"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["DPC"].guard_current_button = moves["DPC"].guard_current_button   +  1
							if moves["DPC"].guard_current_button > 4 then
								moves["DPC"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["DPC"].wakeup_current_button = moves["DPC"].wakeup_current_button   +  1
							if moves["DPC"].wakeup_current_button > 4 then
								moves["DPC"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_delay  - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_times - 1
					end,
    },
    ["26"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DPC").on_guard_times + 1
					end,
    },
    ["28"] = {
        y = 85,
        x = 8,
        info = {'Half circle Back Forward (632146)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCB_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCB_F" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "HCB_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["29"] = {
        y = 85,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "WAKEUP" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB_F"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB_F"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["HCB_F"].guard_current_button = moves["HCB_F"].guard_current_button   +  1
							if moves["HCB_F"].guard_current_button > 4 then
								moves["HCB_F"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["HCB_F"].wakeup_current_button = moves["HCB_F"].wakeup_current_button   +  1
							if moves["HCB_F"].wakeup_current_button > 4 then
								moves["HCB_F"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_delay  - 1
					end,
    },
    ["32"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_times - 1
					end,
    },
    ["35"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_guard_times + 1
					end,
    },
    ["37"] = {
        y = 110,
        x = 8,
        info = {'Half circle forward (41236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCF" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "HCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["38"] = {
        y = 110,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "WAKEUP" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["HCF"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["HCF"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["HCF"].guard_current_button = moves["HCF"].guard_current_button   +  1
							if moves["HCF"].guard_current_button > 4 then
								moves["HCF"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["HCF"].wakeup_current_button = moves["HCF"].wakeup_current_button   +  1
							if moves["HCF"].wakeup_current_button > 4 then
								moves["HCF"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_delay  - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_times - 1
					end,
    },
    ["44"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_guard_times + 1
					end,
    },
    ["46"] = {
        y = 135,
        x = 8,
        info = {'Dragon Punch (623)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DP" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DP" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "DP",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["47"] = {
        y = 135,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "WAKEUP" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["DP"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["DP"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["DP"].guard_current_button = moves["DP"].guard_current_button   +  1
							if moves["DP"].guard_current_button > 4 then
								moves["DP"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["DP"].wakeup_current_button = moves["DP"].wakeup_current_button   +  1
							if moves["DP"].wakeup_current_button > 4 then
								moves["DP"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_delay  - 1
					end,
    },
    ["50"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_times - 1
					end,
    },
    ["53"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_guard_times + 1
					end,
    },
    ["55"] = {
        y = 10,
        x = 123,
        info = {'Quarter circle forward (236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "QCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"]  = 0
						end
						config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["56"] = {
        y = 10,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
						if "WAKEUP" == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["QCF"].guard_current_button = moves["QCF"].guard_current_button   +  1
							if moves["QCF"].guard_current_button > 4 then
								moves["QCF"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["QCF"].wakeup_current_button = moves["QCF"].wakeup_current_button   +  1
							if moves["QCF"].wakeup_current_button > 4 then
								moves["QCF"].wakeup_current_button = 1
							end
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_delay  - 1
					end,
    },
    ["59"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_times - 1
					end,
    },
    ["62"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_guard_times + 1
					end,
    },
}
