return {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'Quarter circle Back Half circle Forward (214236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB_HCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB_HCF" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "QCB_HCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"]  = 0
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
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_HCF"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_HCF"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["QCB_HCF"].guard_current_button = moves["QCB_HCF"].guard_current_button   +  1
							if moves["QCB_HCF"].guard_current_button > 4 then
								moves["QCB_HCF"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["QCB_HCF"].wakeup_current_button = moves["QCB_HCF"].wakeup_current_button   +  1
							if moves["QCB_HCF"].wakeup_current_button > 4 then
								moves["QCB_HCF"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_delay  - 1
					end,
    },
    ["5"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_times - 1
					end,
    },
    ["8"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_guard_times + 1
					end,
    },
    ["10"] = {
        y = 35,
        x = 8,
        info = {'pretzel (1632143)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "PRETZEL" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "PRETZEL" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "PRETZEL",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"]  = 0
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
							this.text = "Button: (".. BUTTON_NAMES[moves["PRETZEL"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["PRETZEL"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["PRETZEL"].guard_current_button = moves["PRETZEL"].guard_current_button   +  1
							if moves["PRETZEL"].guard_current_button > 4 then
								moves["PRETZEL"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["PRETZEL"].wakeup_current_button = moves["PRETZEL"].wakeup_current_button   +  1
							if moves["PRETZEL"].wakeup_current_button > 4 then
								moves["PRETZEL"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_delay  - 1
					end,
    },
    ["14"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_times - 1
					end,
    },
    ["17"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_guard_times + 1
					end,
    },
    ["19"] = {
        y = 60,
        x = 8,
        info = {'Quarter circle forward (236214)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF_HCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF_HCB" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "QCF_HCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"]  = 0
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
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_HCB"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_HCB"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["QCF_HCB"].guard_current_button = moves["QCF_HCB"].guard_current_button   +  1
							if moves["QCF_HCB"].guard_current_button > 4 then
								moves["QCF_HCB"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["QCF_HCB"].wakeup_current_button = moves["QCF_HCB"].wakeup_current_button   +  1
							if moves["QCF_HCB"].wakeup_current_button > 4 then
								moves["QCF_HCB"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_delay  - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_times - 1
					end,
    },
    ["26"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_guard_times + 1
					end,
    },
    ["28"] = {
        y = 85,
        x = 8,
        info = {'Quarter circle Back Forward (2146)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB_F" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "QCB_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"]  = 0
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
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_F"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_F"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["QCB_F"].guard_current_button = moves["QCB_F"].guard_current_button   +  1
							if moves["QCB_F"].guard_current_button > 4 then
								moves["QCB_F"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["QCB_F"].wakeup_current_button = moves["QCB_F"].wakeup_current_button   +  1
							if moves["QCB_F"].wakeup_current_button > 4 then
								moves["QCB_F"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_delay  - 1
					end,
    },
    ["32"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_times - 1
					end,
    },
    ["35"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_guard_times + 1
					end,
    },
    ["37"] = {
        y = 110,
        x = 8,
        info = {'Quarter circle forward * 2 (236236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF_QCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF_QCF" .. ": ON" 
					end
					config["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
        text = "QCF_QCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"]  = 0
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
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_QCF"].guard_current_button ] ..")" 
						elseif "WAKEUP" == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_QCF"].wakeup_current_button ] ..")" 						
						end
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
						if "WAKEUP" == reversal_types.GUARD then
							moves["QCF_QCF"].guard_current_button = moves["QCF_QCF"].guard_current_button   +  1
							if moves["QCF_QCF"].guard_current_button > 4 then
								moves["QCF_QCF"].guard_current_button = 1
							end
						elseif "WAKEUP" == reversal_types.WAKEUP then
							moves["QCF_QCF"].wakeup_current_button = moves["QCF_QCF"].wakeup_current_button   +  1
							if moves["QCF_QCF"].wakeup_current_button > 4 then
								moves["QCF_QCF"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_delay  - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_times - 1
					end,
    },
    ["44"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_guard_times + 1
					end,
    },
}
