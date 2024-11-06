--[[ 
Please bear in consideration that this data was dinamically generated, if you want to include one new move, is better to do so 
manually instead of going through the process of identifying the code but I will describe it here if there's a problem in the future and all ths data needs to be generated again 
and or something alike: first this data used to be generated dinamically but the game started to crash after certain quantity of items so I decided to 
build the whole data and once I realized it would be a nig amount of work I instead used the old dinamic code to generate the static one 

 here is the function and all its helper functions: 

local function getCustomPageNameByType(name, type)
	return  LOWERC_TYPES[type].."_".. name
end
-- Function to serialize a Lua table to a Lua string
local function serializeTable(tbl)
    local str = "return {\n"
    for key, value in pairs(tbl) do
        str = str .. '    ["' .. key .. '"] = {\n'
        for k, v in pairs(value) do
            if type(v) == "string" then
                str = str .. '        ' .. k .. ' = "' .. v .. '",\n'
            else
                str = str .. '        ' .. k .. ' = ' .. tostring(v) .. ',\n'
            end
        end
        str = str .. '    },\n'
    end
    str = str .. "}\n"
    return str
end

-- Function to write a Lua table to a Lua file
local function writeTableToFile(tbl, filename)
    local file = io.open(filename, "w")
    if not file then
        error("Could not open file for writing: " .. filename)
    end

    local str = serializeTable(tbl)
    file:write(str)
    file:close()
end
-- endpage is base means that the sub elements will be listed ]]

--local function initializeReversalMoveSettings(moves, config, guipages, type, pageisbase)
	--local reversalmoveactivesettings = {}

	--local elementsPerColumn = 6-- Elements per column
	--local xSpacing = 115 -- Spacing between columns
	--local xPosition = 8
	--local yPosition = 10
	--local iterator = 1
	--local elementsPerRow = 20
	--local rowGap = 25
	--local arraindex = 1
	--local function addElementToarray(arrayindx)
	--	table.insert(guipages, reversalmoveactivesettings[arraindex])
	--	arraindex = arraindex +1
	--end
	--for index, value in pairs(moves) do
	--	
	--	if moves[index].hidden then
	--		-- Skip this iteration        
	--	elseif moves[index].type ~= MOVE_TYPES.COMMON then
	--		if moves[index].default == true then
	--			table.insert(config.MOVES_VAR_NAMES[type],index)
	--			config.MOVES_VAR_NAMES[type][index]= config.REVERSAL_MOVES.OPTIONS.ON
	--		else
	--			table.insert(config.MOVES_VAR_NAMES[type],index)
	--			config.MOVES_VAR_NAMES[type][index]= config.REVERSAL_MOVES.OPTIONS.OFF
	--		end
--
	--		local column = math.floor((iterator - 1) / elementsPerColumn) + 1
	--		local columnElement = (iterator - 1) % elementsPerColumn + 1
	--		
	--		xPosition = 8 + (column - 1) * xSpacing
	--		
	--		if columnElement == 1 then
	--			yPosition = 10
	--		else
	--			yPosition = yPosition + rowGap
	--		end
	--		
	--		
--
	--		reversalmoveactivesettings[arraindex] = {
	--			text = index,
	--			x = xPosition,
	--			y = yPosition,
	--			olcolour = "black",
	--			info = {moves[index].description},
	--			func = [[function()
	--					KOF_CONFIG.MOVES_VAR_NAMES["]]..type..[["]["]]..index..[["] = KOF_CONFIG.MOVES_VAR_NAMES["]]..type..[["]["]]..index..[["]+ 1
	--					if KOF_CONFIG.MOVES_VAR_NAMES["]]..type..[["]["]]..index..[["] > 1 then
	--						KOF_CONFIG.MOVES_VAR_NAMES["]]..type..[["]["]]..index..[["]  = 0
	--					end
	--					KOF_CONFIG["]]..type..[["].reversal_moves = getCurrentReversalMoves("]]..type..[[")
	--			end]],
	--			autofunc = [[function(this)
	--				
	--				if (KOF_CONFIG.MOVES_VAR_NAMES["]]..type..[["]["]]..index..[["] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
	--					this.text = "]]..index..[[" .. ": Off" 
	--				elseif (KOF_CONFIG.MOVES_VAR_NAMES["]]..type..[["]["]]..index..[["] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
	--					this.text = "]]..index..[[" .. ": ON" 
	--				end
	--				KOF_CONFIG["]]..type..[["].reversal_moves = getCurrentReversalMoves("]]..type..[[")
	--			end]],
	--		}
--
	--		addElementToarray(arraindex)
--			local current_reversal_move = config.REVERSAL_MOVES.MOVELIST:getReversal(index)
	--		if(moves[index].button_editable) then 
	--			reversalmoveactivesettings[arraindex]  = {
	--				text = "Button: ",
	--				x = xPosition + 60,
	--				y = yPosition,
	--				olcolour = "black",
	--				info = {"Button used to make the move"},
	--				func = [[function()
	--					if "]]..type..[[" == reversal_types.GUARD then
	--						moves["]]..index..[["].guard_current_button = moves["]]..index..[["].guard_current_button   +  1
	--						if moves["]]..index..[["].guard_current_button > 4 then
	--							moves["]]..index..[["].guard_current_button = 1
--							end
	--					elseif "]]..type..[[" == reversal_types.WAKEUP then
	--						moves["]]..index..[["].wakeup_current_button = moves["]]..index..[["].wakeup_current_button   +  1
	--						if moves["]]..index..[["].wakeup_current_button > 4 then
	--							moves["]]..index..[["].wakeup_current_button = 1
	--						end
	--					end
	--				end]],
	--				autofunc = [[function(this)
	--					if "]]..type..[[" == reversal_types.GUARD then
	--						this.text = "Button: (".. BUTTON_NAMES[moves["]]..index..[["].guard_current_button ] ..")" 
	--					elseif "]]..type..[[" == reversal_types.WAKEUP then
						
	--					end
	--				end]],
	--			}
--			addElementToarray(arraindex)
--
	--		end
	--		
	--		--[[ -- Set hook to trace line execution
	--		debug.sethook(trace_line, "l")
	--		-- Execute the line in question
--			table.insert(guipages, reversalmoveactivesettings[baseIndex])
--
	--		-- Clear hook when done
--			debug.sethook() ]]
--			
--
--			
--
	--		--ELEMENTS OF THE CALIBRATION ROW  for guard
	--			-- First Element: "delay: "
	--			reversalmoveactivesettings[arraindex ] = {
	--				text = "d & t:",
	--				x = xPosition,
	--				y = yPosition + 12,				
	--				olcolour = "black",
	--				info = { 
--						"this is the delay it will take on frames and the times of the reversal on guard"
	--					
	--				},
	--				func = [[function()
	--					-- Function for "delay: "
	--				end]],
	--			}
	--			addElementToarray(arraindex)
	--		
	--			-- Second Element: "(-) delay"
	--			reversalmoveactivesettings[arraindex] = {
	--				text = "-",
	--				x = xPosition + 34,  -- Adjust x position as needed
	--				y = yPosition + 12,  -- Keep the same y position
	--				olcolour = "black",
	--				info = {},
--					func = [[function()
--						-- Function for "(-) delay"				
	--					if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_delay  == 0 then
	--						return
	--					end
	--					KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_delay  - 1
	--				end]],
--				}
--				addElementToarray(arraindex)
	--			-- Third Element: "delay"
--				reversalmoveactivesettings[arraindex] = {
--					text = [[tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_delay)]],
--					x = xPosition + 45,  -- Adjust x position as needed
--					y = yPosition + 12,  -- Keep the same y position
--					olcolour = "black",
	--				info = {},
	--				func = [[function()
	--					
	--				end]],
	--				autofunc = [[function(this)
	--					this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_delay )
	--				end]],
	--		
--				}
	--			addElementToarray(arraindex)
	--			-- Fourth Element: "+ delay"
	--			reversalmoveactivesettings[arraindex] = {
	--				text = "+",
	--				x = xPosition + 60,  -- Adjust x position as needed
	--				y = yPosition + 12,  -- Keep the same y position
	--				olcolour = "black",
	--				info = {},
	--				func = [[function()
	--					-- Function for "(+) delay"
	--					KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_delay + 1
	--				end]],
	--			}
	--			addElementToarray(arraindex)
	--		
--				-- fith Element: "(-) Times"
--				reversalmoveactivesettings[arraindex] = {
	--				text = "-",
	--				x = xPosition + 75,  -- Adjust x position as needed
	--				y = yPosition + 12,  -- Keep the same y position
	--				olcolour = "black",
	--				info = {},
--					func =  [[function()
--						-- Function for "(-) times"				
	--					if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_times == 1 then
--							return
--						end
--						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_times - 1
--					end]],
--				}
--				addElementToarray(arraindex)
	--			-- sixth Element: "times"
	--			reversalmoveactivesettings[arraindex] = {
	--				text = [[tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_times)]],
	--				x = xPosition + 86,  -- Adjust x position as needed
	--				y = yPosition + 12,  -- Keep the same y position
	--				olcolour = "black",
	--				info = {},
	--				func = [[function()
	--					
	--				end]],
	--				autofunc =[[function(this)
	--					this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_times)
	--				end]],
	--			}
	--			addElementToarray(arraindex)
--				-- Seventh Element: "+ times"
--				reversalmoveactivesettings[arraindex] = {
	--				text = "+",
	--				x = xPosition + 99,  -- Adjust x position as needed
	--				y = yPosition + 12,  -- Keep the same y position
	--				olcolour = "black",
	--				info = {},
--					func = [[function()
--						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("]]..index..[[").on_guard_times + 1
	--				end]],
--				}
--				addElementToarray(arraindex)
--				
--			
--			
			--iterator = iterator + 1
		--end
	--end
	--if pageisbase then
		--reversalmoveactivesettings[arraindex] ={
			--text = "command normals",
			--x = 8,
			--y = interactivegui.boxy2 -30,
			--olcolour = "black",
			--handle = 8,
			--func = 	[[function() changeInteractiveGuiPage(getCustomPageNameByType("command_normals_move_settings", "]]..type..[[") ) end]],
		--}
			--addElementToarray(arraindex)
--		
		--reversalmoveactivesettings[arraindex] ={
			--text = "specials",
			--x = 78,
			--y = interactivegui.boxy2 -30,
			--olcolour = "black",
			--handle = 8,
			--func = 	[[function() changeInteractiveGuiPage(getCustomPageNameByType("specials_move_settings", "]]..type..[[") ) end]],
		--}
			--addElementToarray(arraindex)
--		
		--reversalmoveactivesettings[arraindex] ={
			--text = "Supers ",
			--x = 118,
			--y = interactivegui.boxy2 -30,
			--olcolour = "black",
			--handle = 8,
			--func = 	[[function() changeInteractiveGuiPage(getCustomPageNameByType( "supers_move_settings", "]]..type..[[")) end]],
		--}
			--addElementToarray(arraindex)
--	
--		
		--reversalmoveactivesettings[arraindex] ={
			--text = "Common ",
			--x = 152,
			--y = interactivegui.boxy2 -30,
			--olcolour = "black",
			--handle = 8,
			--func = 	[[function() changeInteractiveGuiPage(getCustomPageNameByType( "commons_move_settings", "]]..type..[[")) end]],
		--}
			--addElementToarray(arraindex)
	--end
	---- Get the first element (key-value pair)
--local firstKey, firstValue = next(moves)
	--writeTableToFile(reversalmoveactivesettings, LOWERC_TYPES[type].."_"..LOWERC_TYPES[moves[firstKey].type].."_move_settings.lua")
--
--	
--
--end
--theres also helper arrays like these for the names
--[[ MOVE_TYPES = {
	NORMAL ="NORMAL",
	COMMAND_NORMAL ="COMMAND_NORMAL",
	SPECIAL = "SPECIAL",
	SUPER = "SUPER",
	COMMON ="COMMON"
}
 ]]
--and this one
--[[ local LOWERC_TYPES = {
	['GUARD'] = "guard",
	['WAKEUP'] = "wakeup",
	['COMMAND_NORMAL'] = "command_normal",
	['SPECIAL'] = "special",
	['SUPER'] = "super",
	['NORMAL'] = "normal",
	['COMMON'] = "common",

} ]]

--AND HERE ARE TWO EXAMPLES OF HOW TOM USE IT
--[[--- added normal moves to default page
local normal_moves = filterMoves(moves, MOVE_TYPES.NORMAL) 
initializeReversalMoveSettings(normal_moves, KOF_CONFIG,guipages.guard_reversal_move_active_settings , reversal_types.WAKEUP, true) ]]
--initializeReversalMoveSettings(normal_moves, KOF_CONFIG,guipages.wakeup_reversal_move_active_settings , reversal_types.WAKEUP, true)

--adds command normal moves config page
--[[ local command_normals_moves = filterMoves(moves, MOVE_TYPES.COMMAND_NORMAL) 
local command_normals_move_settings = {
	title = {
		text = "Command Normals Move  Settings",
		x = interactivegui.boxxlength/2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(	interactivegui.previouspage ,2) end,
	},
}
local command_normals_page_name = getCustomPageNameByType("command_normals_move_settings",reversal_types.GUARD)
guipages[command_normals_page_name] = command_normals_move_settings
initializeReversalMoveSettings(command_normals_moves, KOF_CONFIG,guipages[command_normals_page_name], reversal_types.GUARD)
initializeReversalMoveSettings(command_normals_moves, KOF_CONFIG,guipages[command_normals_page_name], reversal_types.WAKEUP) ]]
--- add special moves
--[[ local special_moves = filterMoves(moves, MOVE_TYPES.SPECIAL) 
local special_move_settings = {
	title = {
		text = "Special Move  Settings",
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
local specials_page_name = getCustomPageNameByType("specials_move_settings",reversal_types.GUARD)
guipages[specials_page_name] = special_move_settings
initializeReversalMoveSettings(special_moves, KOF_CONFIG,guipages[specials_page_name], reversal_types.GUARD)
initializeReversalMoveSettings(special_moves, KOF_CONFIG,guipages[specials_page_name], reversal_types.WAKEUP) ]]
--[[ AND WHY WOULD SOMEONE ASK, EXISTING THE MAGIC OF GIT DO YOU NEED TO DO THIS, THE ANSWER IS I DONT' KNOW AND PROBABLY 
YOU DONT CARE, I JUST WANT THIS SOMEHOW DOCUMENTED 
 the resulting files have a few sintax errors around: "function(,   end", "tostring(KOF, and the end of the line of "tostring(KOF 
 a sweet find all in VS CODE would be enough, this script will help you generate  the config for reversals from the moves array in the 
 moves_setings.lua file, but again if you want to make a couple moves just copy paste and add them manually, this whole proccess coud be 
 made automatically later but i don't want to expend time on that right now ]]

 local move_data = {}

 move_data.guard_command_normals ={
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
				end,
        text = "DF_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_D"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "DF_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_B"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "FWD_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_A"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "FWD_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["FWD_B"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "BACK_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_A"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "BACK_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACK_B"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "DF_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DF_C"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
    ["57"] = {
        y = 35,
        x = 123,
        info = {'crouching guard'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_GUARD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_GUARD" .. ": ON" 
					end
					
				end,
        text = "CR_GUARD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_GUARD"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_GUARD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_GUARD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_GUARD"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_delay  - 1
					end,
    },
    ["60"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_times - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_guard_times + 1
					end,
    },
}

move_data.guard_normals =  {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'crouching D'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_D" .. ": ON" 
					end
					
				end,
        text = "CR_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_D"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_D"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_A" .. ": ON" 
					end
					
				end,
        text = "ST_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_A"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_A"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CD" .. ": ON" 
					end
					
				end,
        text = "CD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CD"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CD"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_B" .. ": ON" 
					end
					
				end,
        text = "CR_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_B"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_A" .. ": ON" 
					end
					
				end,
        text = "CR_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_A"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_A"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "AB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "AB" .. ": ON" 
					end
					
				end,
        text = "AB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["AB"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["AB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["AB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["AB"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_D" .. ": ON" 
					end
					
				end,
        text = "ST_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_D"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_D"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_C" .. ": ON" 
					end
					
				end,
        text = "ST_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_C"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_C"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ST_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ST_B" .. ": ON" 
					end
					
				end,
        text = "ST_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ST_B"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_C" .. ": ON" 
					end
					
				end,
        text = "CR_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_C"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["CR_C"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
        y = 110,
        x = 123,
        info = {'throw C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["THROW_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "THROW_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["THROW_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "THROW_C" .. ": ON" 
					end
					
				end,
        text = "THROW_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["THROW_C"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["THROW_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["THROW_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["THROW_C"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_delay  - 1
					end,
    },
    ["84"] = {
        y = 122,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_times - 1
					end,
    },
    ["87"] = {
        y = 122,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_guard_times + 1
					end,
    },
    ["89"] = {
        y = 161.6,
        x = 8,
        handle = 8,
        text = "command normals",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType("command_normals_move_settings", "GUARD") ) end,
    },
    ["90"] = {
        y = 161.6,
        x = 78,
        handle = 8,
        text = "specials",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType("specials_move_settings", "GUARD") ) end,
    },
    ["91"] = {
        y = 161.6,
        x = 118,
        handle = 8,
        text = "Supers ",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "supers_move_settings", "GUARD")) end,
    },
    ["92"] = {
        y = 161.6,
        x = 152,
        handle = 8,
        text = "Common ",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "commons_move_settings", "GUARD")) end,
    },
    ["93"] = {
        y = 161.6,
        x = 185,
        handle = 8,
        text = "Recordings",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "recordings_move_settings", "GUARD")) end,
    },
}

move_data.guard_specials = {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'Half circle Back (63214)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCB" .. ": ON" 
					end
					
				end,
        text = "HCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["2"] = {
        y = 10,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB"].guard_current_button ] ..")" 											
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCB"].guard_current_button = moves["HCB"].guard_current_button   +  1
							if moves["HCB"].guard_current_button > 4 then
								moves["HCB"].guard_current_button = 1
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB" .. ": ON" 
					end
					
				end,
        text = "QCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["11"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
                        moves["QCB"].guard_current_button = moves["QCB"].guard_current_button   +  1
                        if moves["QCB"].guard_current_button > 4 then
                            moves["QCB"].guard_current_button = 1
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
        info = {'k9999 super'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["D_F_DF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "D_F_DF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["D_F_DF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "D_F_DF" .. ": ON" 
					end
					
				end,
        text = "D_F_DF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["D_F_DF"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["D_F_DF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["D_F_DF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["D_F_DF"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["20"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["D_F_DF"].guard_current_button ] ..")" 												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["D_F_DF"].guard_current_button = moves["D_F_DF"].guard_current_button   +  1
							if moves["D_F_DF"].guard_current_button > 4 then
								moves["D_F_DF"].guard_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_delay  - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_times - 1
					end,
    },
    ["26"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_guard_times + 1
					end,
    },
    ["28"] = {
        y = 85,
        x = 8,
        info = {'Half circle Back Forward (632146)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCB_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCB_F" .. ": ON" 
					end
					
				end,
        text = "HCB_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCB_F"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["29"] = {
        y = 85,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB_F"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCB_F"].guard_current_button = moves["HCB_F"].guard_current_button   +  1
							if moves["HCB_F"].guard_current_button > 4 then
								moves["HCB_F"].guard_current_button = 1
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HCF" .. ": ON" 
					end
					
				end,
        text = "HCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCF"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HCF"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["38"] = {
        y = 110,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCF"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCF"].guard_current_button = moves["HCF"].guard_current_button   +  1
							if moves["HCF"].guard_current_button > 4 then
								moves["HCF"].guard_current_button = 1
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DP" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DP" .. ": ON" 
					end
					
				end,
        text = "DP",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DP"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DP"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DP"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DP"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["47"] = {
        y = 135,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DP"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DP"].guard_current_button = moves["DP"].guard_current_button   +  1
							if moves["DP"].guard_current_button > 4 then
								moves["DP"].guard_current_button = 1
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF" .. ": ON" 
					end
					
				end,
        text = "QCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["56"] = {
        y = 10,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF"].guard_current_button = moves["QCF"].guard_current_button   +  1
							if moves["QCF"].guard_current_button > 4 then
								moves["QCF"].guard_current_button = 1
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
    ["64"] = {
        y = 35,
        x = 123,
        info = {'Reverse DP (421)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["R_DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "R_DP" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["R_DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "R_DP" .. ": ON" 
					end
					
				end,
        text = "R_DP",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["R_DP"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["R_DP"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["R_DP"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["R_DP"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["65"] = {
        y = 35,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["R_DP"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["R_DP"].guard_current_button = moves["R_DP"].guard_current_button   +  1
							if moves["R_DP"].guard_current_button > 4 then
								moves["R_DP"].guard_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_delay  - 1
					end,
    },
    ["68"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_times - 1
					end,
    },
    ["71"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_guard_times + 1
					end,
    },
}

move_data.guard_supers = {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'Quarter circle Back Half circle Forward (214236)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB_HCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_HCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB_HCF" .. ": ON" 
					end
					
				end,
        text = "QCB_HCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_HCF"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_HCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_HCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_HCF"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["2"] = {
        y = 10,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_HCF"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCB_HCF"].guard_current_button = moves["QCB_HCF"].guard_current_button   +  1
							if moves["QCB_HCF"].guard_current_button > 4 then
								moves["QCB_HCF"].guard_current_button = 1
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["PRETZEL"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "PRETZEL" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["PRETZEL"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "PRETZEL" .. ": ON" 
					end
					
				end,
        text = "PRETZEL",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["PRETZEL"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["PRETZEL"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["PRETZEL"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["PRETZEL"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["11"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["PRETZEL"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["PRETZEL"].guard_current_button = moves["PRETZEL"].guard_current_button   +  1
							if moves["PRETZEL"].guard_current_button > 4 then
								moves["PRETZEL"].guard_current_button = 1
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF_HCB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_HCB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF_HCB" .. ": ON" 
					end
					
				end,
        text = "QCF_HCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_HCB"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_HCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_HCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_HCB"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["20"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_HCB"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF_HCB"].guard_current_button = moves["QCF_HCB"].guard_current_button   +  1
							if moves["QCF_HCB"].guard_current_button > 4 then
								moves["QCF_HCB"].guard_current_button = 1
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCB_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCB_F" .. ": ON" 
					end
					
				end,
        text = "QCB_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCB_F"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["29"] = {
        y = 85,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_F"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCB_F"].guard_current_button = moves["QCB_F"].guard_current_button   +  1
							if moves["QCB_F"].guard_current_button > 4 then
								moves["QCB_F"].guard_current_button = 1
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
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "QCF_QCF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_QCF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "QCF_QCF" .. ": ON" 
					end
					
				end,
        text = "QCF_QCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_QCF"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_QCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_QCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["QCF_QCF"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["38"] = {
        y = 110,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_QCF"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF_QCF"].guard_current_button = moves["QCF_QCF"].guard_current_button   +  1
							if moves["QCF_QCF"].guard_current_button > 4 then
								moves["QCF_QCF"].guard_current_button = 1
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
move_data.guard_commons = {
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
					
				end,
        text = "BACKDASH",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["BACKDASH"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "DSJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DSJ_F"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["10"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DSJ_F"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DSJ_F"].guard_current_button = moves["DSJ_F"].guard_current_button   +  1
							if moves["DSJ_F"].guard_current_button > 4 then
								moves["DSJ_F"].guard_current_button = 1
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
					
				end,
        text = "INS_SJ_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["INS_SJ_B"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["19"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["INS_SJ_B"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["INS_SJ_B"].guard_current_button = moves["INS_SJ_B"].guard_current_button   +  1
							if moves["INS_SJ_B"].guard_current_button > 4 then
								moves["INS_SJ_B"].guard_current_button = 1
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
					
				end,
        text = "SJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_F"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "HH_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["HH_F"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "SJ_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["SJ_B"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "LONG_AB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["LONG_AB"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
					
				end,
        text = "DH_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DH_F"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["60"] = {
        y = 35,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DH_F"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DH_F"].guard_current_button = moves["DH_F"].guard_current_button   +  1
							if moves["DH_F"].guard_current_button > 4 then
								moves["DH_F"].guard_current_button = 1
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
					
				end,
        text = "DNEUTRALH",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALH"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["69"] = {
        y = 60,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALH"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DNEUTRALH"].guard_current_button = moves["DNEUTRALH"].guard_current_button   +  1
							if moves["DNEUTRALH"].guard_current_button > 4 then
								moves["DNEUTRALH"].guard_current_button = 1
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
					
				end,
        text = "DHJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DHJ_F"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["78"] = {
        y = 85,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DHJ_F"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DHJ_F"].guard_current_button = moves["DHJ_F"].guard_current_button   +  1
							if moves["DHJ_F"].guard_current_button > 4 then
								moves["DHJ_F"].guard_current_button = 1
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
					
				end,
        text = "DNEUTRALJ",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["DNEUTRALJ"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["87"] = {
        y = 110,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALJ"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DNEUTRALJ"].guard_current_button = moves["DNEUTRALJ"].guard_current_button   +  1
							if moves["DNEUTRALJ"].guard_current_button > 4 then
								moves["DNEUTRALJ"].guard_current_button = 1
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
    ["95"] = {
        y = 135,
        x = 123,
        info = {'alternate guard'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ALT_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ALT_GUARD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ALT_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ALT_GUARD" .. ": ON" 
					end
					
				end,
        text = "ALT_GUARD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ALT_GUARD"] = KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ALT_GUARD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ALT_GUARD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["GUARD"]["ALT_GUARD"]  = 0
						end
						KOF_CONFIG["GUARD"].reversal_moves = getCurrentReversalMoves("GUARD")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_delay  - 1
					end,
    },
    ["99"] = {
        y = 147,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_times - 1
					end,
    },
    ["102"] = {
        y = 147,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_guard_times + 1
					end,
    },
}

move_data.wakeup_command_normals = {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_D" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_D"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_D" .. ": ON" 
					end
					
				end,
        text = "DF_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_D"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_D"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_D").on_wake_up_times + 1
					end,
    },
    ["9"] = {
        y = 35,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_B" .. ": ON" 
					end
					
				end,
        text = "DF_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_B"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_delay  - 1
					end,
    },
    ["12"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_times - 1
					end,
    },
    ["15"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_B").on_wake_up_times + 1
					end,
    },
    ["17"] = {
        y = 60,
        x = 8,
        info = {'forward A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "FWD_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "FWD_A" .. ": ON" 
					end
					
				end,
        text = "FWD_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_A"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_A"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_delay  - 1
					end,
    },
    ["20"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_times - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_A").on_wake_up_times + 1
					end,
    },
    ["25"] = {
        y = 85,
        x = 8,
        info = {'forward B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "FWD_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "FWD_B" .. ": ON" 
					end
					
				end,
        text = "FWD_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["FWD_B"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_delay  - 1
					end,
    },
    ["28"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_times - 1
					end,
    },
    ["31"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("FWD_B").on_wake_up_times + 1
					end,
    },
    ["33"] = {
        y = 110,
        x = 8,
        info = {'back A'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACK_A" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_A"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACK_A" .. ": ON" 
					end
					
				end,
        text = "BACK_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_A"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_A"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_delay  - 1
					end,
    },
    ["36"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_times - 1
					end,
    },
    ["39"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_A").on_wake_up_times + 1
					end,
    },
    ["41"] = {
        y = 135,
        x = 8,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACK_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACK_B" .. ": ON" 
					end
					
				end,
        text = "BACK_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACK_B"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_delay  - 1
					end,
    },
    ["44"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_times - 1
					end,
    },
    ["47"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACK_B").on_wake_up_times + 1
					end,
    },
    ["49"] = {
        y = 10,
        x = 123,
        info = {'back B'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DF_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DF_C" .. ": ON" 
					end
					
				end,
        text = "DF_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_C"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DF_C"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_delay  - 1
					end,
    },
    ["52"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_times - 1
					end,
    },
    ["55"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DF_C").on_wake_up_times + 1
					end,
    },
    ["57"] = {
        y = 35,
        x = 123,
        info = {'crouching guard'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "CR_GUARD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "CR_GUARD" .. ": ON" 
					end
					
				end,
        text = "CR_GUARD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_GUARD"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_GUARD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_GUARD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_GUARD"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_delay  - 1
					end,
    },
    ["60"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_times - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_GUARD").on_wake_up_times + 1
					end,
    },
}
move_data.wakeup_normals = {
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
					
				end,
        text = "CR_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_D"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_D").on_wake_up_times + 1
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
					
				end,
        text = "ST_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_A"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_delay  - 1
					end,
    },
    ["12"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_times - 1
					end,
    },
    ["15"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_A").on_wake_up_times + 1
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
					
				end,
        text = "CD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CD"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_delay  - 1
					end,
    },
    ["20"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_times - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CD").on_wake_up_times + 1
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
					
				end,
        text = "CR_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_B"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_delay  - 1
					end,
    },
    ["28"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_times - 1
					end,
    },
    ["31"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_B").on_wake_up_times + 1
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
					
				end,
        text = "CR_A",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_A"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_delay  - 1
					end,
    },
    ["36"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_times - 1
					end,
    },
    ["39"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_A").on_wake_up_times + 1
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
					
				end,
        text = "AB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["AB"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_delay  - 1
					end,
    },
    ["44"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_times - 1
					end,
    },
    ["47"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("AB").on_wake_up_times + 1
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
					
				end,
        text = "ST_D",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_D"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_delay  - 1
					end,
    },
    ["52"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_times - 1
					end,
    },
    ["55"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_D").on_wake_up_times + 1
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
					
				end,
        text = "ST_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_C"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_delay  - 1
					end,
    },
    ["60"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_times - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_C").on_wake_up_times + 1
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
					
				end,
        text = "ST_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ST_B"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_delay  - 1
					end,
    },
    ["68"] = {
        y = 72,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_times - 1
					end,
    },
    ["71"] = {
        y = 72,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ST_B").on_wake_up_times + 1
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
					
				end,
        text = "CR_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["CR_C"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_delay  - 1
					end,
    },
    ["76"] = {
        y = 97,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_times - 1
					end,
    },
    ["79"] = {
        y = 97,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("CR_C").on_wake_up_times + 1
					end,
    },
    ["81"] = {
        y = 110,
        x = 123,
        info = {'throw C'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["THROW_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "THROW_C" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["THROW_C"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "THROW_C" .. ": ON" 
					end
					
				end,
        text = "THROW_C",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["THROW_C"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["THROW_C"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["THROW_C"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["THROW_C"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_delay  - 1
					end,
    },
    ["84"] = {
        y = 122,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_times - 1
					end,
    },
    ["87"] = {
        y = 122,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("THROW_C").on_wake_up_times + 1
					end,
    },
    ["89"] = {
        y = 161.6,
        x = 8,
        handle = 8,
        text = "command normals",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType("command_normals_move_settings", "WAKEUP") ) end,
    },
    ["90"] = {
        y = 161.6,
        x = 78,
        handle = 8,
        text = "specials",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType("specials_move_settings", "WAKEUP") ) end,
    },
    ["91"] = {
        y = 161.6,
        x = 118,
        handle = 8,
        text = "Supers ",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "supers_move_settings", "WAKEUP")) end,
    },
    ["92"] = {
        y = 161.6,
        x = 152,
        handle = 8,
        text = "Common ",
        olcolour = "black",
        func = function() changeInteractiveGuiPage(getCustomPageNameByType( "commons_move_settings", "WAKEUP")) end,
    },
}
move_data.wakeup_specials = {
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
					
				end,
        text = "HCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["2"] = {
        y = 10,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCB"].wakeup_current_button = moves["HCB"].wakeup_current_button   +  1
							if moves["HCB"].wakeup_current_button > 4 then
								moves["HCB"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_delay  - 1
					end,
    },
    ["5"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_times - 1
					end,
    },
    ["8"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB").on_wake_up_times + 1
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
					
				end,
        text = "QCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["11"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB"].wakeup_current_button] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCB"].wakeup_current_button = moves["QCB"].wakeup_current_button   +  1
							if moves["QCB"].wakeup_current_button > 4 then
								moves["QCB"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_delay  - 1
					end,
    },
    ["14"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_times - 1
					end,
    },
    ["17"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB").on_wake_up_times + 1
					end,
    },
    ["19"] = {
        y = 60,
        x = 8,
        info = {'k9999 super move'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["D_F_DF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "D_F_DF" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["D_F_DF"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "D_F_DF" .. ": ON" 
					end
				end,
        text = "D_F_DF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["D_F_DF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["D_F_DF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["D_F_DF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["D_F_DF"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["20"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["D_F_DF"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["D_F_DF"].wakeup_current_button = moves["D_F_DF"].wakeup_current_button   +  1
							if moves["D_F_DF"].wakeup_current_button > 4 then
								moves["D_F_DF"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_delay  - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_times - 1
					end,
    },
    ["26"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("D_F_DF").on_wake_up_times + 1
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
					
				end,
        text = "HCB_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCB_F"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["29"] = {
        y = 85,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCB_F"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCB_F"].wakeup_current_button = moves["HCB_F"].wakeup_current_button   +  1
							if moves["HCB_F"].wakeup_current_button > 4 then
								moves["HCB_F"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_delay  - 1
					end,
    },
    ["32"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_times - 1
					end,
    },
    ["35"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCB_F").on_wake_up_times + 1
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
					
				end,
        text = "HCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HCF"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["38"] = {
        y = 110,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["HCF"].wakeup_current_button] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["HCF"].wakeup_current_button = moves["HCF"].wakeup_current_button   +  1
							if moves["HCF"].wakeup_current_button > 4 then
								moves["HCF"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_delay  - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_times - 1
					end,
    },
    ["44"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HCF").on_wake_up_times + 1
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
					
				end,
        text = "DP",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DP"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["47"] = {
        y = 135,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DP"].wakeup_current_button] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DP"].wakeup_current_button = moves["DP"].wakeup_current_button   +  1
							if moves["DP"].wakeup_current_button > 4 then
								moves["DP"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_delay  - 1
					end,
    },
    ["50"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_times - 1
					end,
    },
    ["53"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DP").on_wake_up_times + 1
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
					
				end,
        text = "QCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["56"] = {
        y = 10,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF"].wakeup_current_button = moves["QCF"].wakeup_current_button   +  1
							if moves["QCF"].wakeup_current_button > 4 then
								moves["QCF"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_delay  - 1
					end,
    },
    ["59"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_times - 1
					end,
    },
    ["62"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF").on_wake_up_times + 1
					end,
    },
    ["64"] = {
        y = 35,
        x = 123,
        info = {'Reverse DP (421)'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["R_DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "R_DP" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["R_DP"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "R_DP" .. ": ON" 
					end
					
				end,
        text = "R_DP",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["R_DP"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["R_DP"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["R_DP"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["R_DP"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("GUARD")
				end,
    },
    ["65"] = {
        y = 35,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["R_DP"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["R_DP"].wakeup_current_button = moves["R_DP"].wakeup_current_button   +  1
							if moves["R_DP"].wakeup_current_button > 4 then
								moves["R_DP"].wakeup_current_button = 1
							end
					end,
    },
    ["66"] = {
        y = 47,
        x = 123,
        info = {'this is the delay it will take on frames and the times of the reversal on wakeup'},
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_delay  - 1
					end,
    },
    ["68"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_times - 1
					end,
    },
    ["71"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("R_DP").on_wake_up_times + 1
					end,
    },
}
move_data.wakeup_supers = {
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
					
				end,
        text = "QCB_HCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_HCF"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["2"] = {
        y = 10,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_HCF"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCB_HCF"].wakeup_current_button = moves["QCB_HCF"].wakeup_current_button   +  1
							if moves["QCB_HCF"].wakeup_current_button > 4 then
								moves["QCB_HCF"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_delay  - 1
					end,
    },
    ["5"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_times - 1
					end,
    },
    ["8"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_HCF").on_wake_up_times + 1
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
					
				end,
        text = "PRETZEL",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["PRETZEL"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["11"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["PRETZEL"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["PRETZEL"].wakeup_current_button = moves["PRETZEL"].wakeup_current_button   +  1
							if moves["PRETZEL"].wakeup_current_button > 4 then
								moves["PRETZEL"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_delay  - 1
					end,
    },
    ["14"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_times - 1
					end,
    },
    ["17"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("PRETZEL").on_wake_up_times + 1
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
					
				end,
        text = "QCF_HCB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_HCB"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["20"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_HCB"].guard_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF_HCB"].wakeup_current_button = moves["QCF_HCB"].wakeup_current_button   +  1
							if moves["QCF_HCB"].wakeup_current_button > 4 then
								moves["QCF_HCB"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_delay  - 1
					end,
    },
    ["23"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_times - 1
					end,
    },
    ["26"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_HCB").on_wake_up_times + 1
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
					
				end,
        text = "QCB_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCB_F"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["29"] = {
        y = 85,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCB_F"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCB_F"].wakeup_current_button = moves["QCB_F"].wakeup_current_button   +  1
							if moves["QCB_F"].wakeup_current_button > 4 then
								moves["QCB_F"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_delay  - 1
					end,
    },
    ["32"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_times - 1
					end,
    },
    ["35"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCB_F").on_wake_up_times + 1
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
					
				end,
        text = "QCF_QCF",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["QCF_QCF"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["38"] = {
        y = 110,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["QCF_QCF"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["QCF_QCF"].wakeup_current_button = moves["QCF_QCF"].wakeup_current_button   +  1
							if moves["QCF_QCF"].wakeup_current_button > 4 then
								moves["QCF_QCF"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_delay  - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_times - 1
					end,
    },
    ["44"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("QCF_QCF").on_wake_up_times + 1
					end,
    },
}
move_data.wakeup_commons = {
    ["1"] = {
        y = 10,
        x = 8,
        info = {'longer AB'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACKDASH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "BACKDASH" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACKDASH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "BACKDASH" .. ": ON" 
					end
					
				end,
        text = "BACKDASH",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACKDASH"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACKDASH"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACKDASH"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["BACKDASH"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_delay  - 1
					end,
    },
    ["4"] = {
        y = 22,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_times - 1
					end,
    },
    ["7"] = {
        y = 22,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("BACKDASH").on_wake_up_times + 1
					end,
    },
    ["9"] = {
        y = 35,
        x = 8,
        info = {'super jump forward with a delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DSJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DSJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DSJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DSJ_F" .. ": ON" 
					end
					
				end,
        text = "DSJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DSJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DSJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DSJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DSJ_F"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["10"] = {
        y = 35,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DSJ_F"].wakeup_current_button ] ..")" 
												
						
					end,
        text ="Button:  ",
        olcolour = "black",
        func = function()
							moves["DSJ_F"].wakeup_current_button = moves["DSJ_F"].wakeup_current_button   +  1
							if moves["DSJ_F"].wakeup_current_button > 4 then
								moves["DSJ_F"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_delay  - 1
					end,
    },
    ["13"] = {
        y = 47,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_times - 1
					end,
    },
    ["16"] = {
        y = 47,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DSJ_F").on_wake_up_times + 1
					end,
    },
    ["18"] = {
        y = 60,
        x = 8,
        info = {'instant super jump back'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["INS_SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "INS_SJ_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["INS_SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "INS_SJ_B" .. ": ON" 
					end
					
				end,
        text = "INS_SJ_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["INS_SJ_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["INS_SJ_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["INS_SJ_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["INS_SJ_B"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["19"] = {
        y = 60,
        x = 68,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["INS_SJ_B"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["INS_SJ_B"].wakeup_current_button = moves["INS_SJ_B"].wakeup_current_button   +  1
							if moves["INS_SJ_B"].wakeup_current_button > 4 then
								moves["INS_SJ_B"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_delay  - 1
					end,
    },
    ["22"] = {
        y = 72,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_times - 1
					end,
    },
    ["25"] = {
        y = 72,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("INS_SJ_B").on_wake_up_times + 1
					end,
    },
    ["27"] = {
        y = 85,
        x = 8,
        info = {'super jump forward'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "SJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "SJ_F" .. ": ON" 
					end
					
				end,
        text = "SJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_F"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_delay  - 1
					end,
    },
    ["30"] = {
        y = 97,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_times - 1
					end,
    },
    ["33"] = {
        y = 97,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_F").on_wake_up_times + 1
					end,
    },
    ["35"] = {
        y = 110,
        x = 8,
        info = {'Hyper Hop forward'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "HH_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "HH_F" .. ": ON" 
					end
					
				end,
        text = "HH_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HH_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HH_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HH_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["HH_F"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_delay  - 1
					end,
    },
    ["38"] = {
        y = 122,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_times - 1
					end,
    },
    ["41"] = {
        y = 122,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("HH_F").on_wake_up_times + 1
					end,
    },
    ["43"] = {
        y = 135,
        x = 8,
        info = {'super jump back'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "SJ_B" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_B"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "SJ_B" .. ": ON" 
					end
					
				end,
        text = "SJ_B",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_B"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_B"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_B"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["SJ_B"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_delay  - 1
					end,
    },
    ["46"] = {
        y = 147,
        x = 53,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_times - 1
					end,
    },
    ["49"] = {
        y = 147,
        x = 94,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("SJ_B").on_wake_up_times + 1
					end,
    },
    ["51"] = {
        y = 10,
        x = 123,
        info = {'longer AB'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["LONG_AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "LONG_AB" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["LONG_AB"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "LONG_AB" .. ": ON" 
					end
					
				end,
        text = "LONG_AB",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["LONG_AB"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["LONG_AB"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["LONG_AB"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["LONG_AB"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_delay  - 1
					end,
    },
    ["54"] = {
        y = 22,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_times - 1
					end,
    },
    ["57"] = {
        y = 22,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("LONG_AB").on_wake_up_times + 1
					end,
    },
    ["59"] = {
        y = 35,
        x = 123,
        info = {'hop forward with delayed  button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DH_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DH_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DH_F" .. ": ON" 
					end
					
				end,
        text = "DH_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DH_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DH_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DH_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DH_F"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["60"] = {
        y = 35,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DH_F"].wakeup_current_button ] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DH_F"].wakeup_current_button = moves["DH_F"].wakeup_current_button   +  1
							if moves["DH_F"].wakeup_current_button > 4 then
								moves["DH_F"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_delay  - 1
					end,
    },
    ["63"] = {
        y = 47,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_times - 1
					end,
    },
    ["66"] = {
        y = 47,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DH_F").on_wake_up_times + 1
					end,
    },
    ["68"] = {
        y = 60,
        x = 123,
        info = {'neutral hop with delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DNEUTRALH" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALH"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DNEUTRALH" .. ": ON" 
					end
					
				end,
        text = "DNEUTRALH",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALH"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALH"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALH"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALH"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["69"] = {
        y = 60,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALH"].wakeup_current_button] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DNEUTRALH"].wakeup_current_button = moves["DNEUTRALH"].wakeup_current_button   +  1
							if moves["DNEUTRALH"].wakeup_current_button > 4 then
								moves["DNEUTRALH"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_delay  - 1
					end,
    },
    ["72"] = {
        y = 72,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_times - 1
					end,
    },
    ["75"] = {
        y = 72,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALH").on_wake_up_times + 1
					end,
    },
    ["77"] = {
        y = 85,
        x = 123,
        info = {'delayed hyper hop forward with button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DHJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DHJ_F" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DHJ_F"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DHJ_F" .. ": ON" 
					end
					
				end,
        text = "DHJ_F",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DHJ_F"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DHJ_F"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DHJ_F"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DHJ_F"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["78"] = {
        y = 85,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DHJ_F"].wakeup_current_button] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DHJ_F"].wakeup_current_button = moves["DHJ_F"].wakeup_current_button   +  1
							if moves["DHJ_F"].wakeup_current_button > 4 then
								moves["DHJ_F"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_delay  - 1
					end,
    },
    ["81"] = {
        y = 97,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_times - 1
					end,
    },
    ["84"] = {
        y = 97,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DHJ_F").on_wake_up_times + 1
					end,
    },
    ["86"] = {
        y = 110,
        x = 123,
        info = {'neutral jump with delayed button'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALJ"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "DNEUTRALJ" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALJ"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "DNEUTRALJ" .. ": ON" 
					end
					
				end,
        text = "DNEUTRALJ",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALJ"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALJ"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALJ"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["DNEUTRALJ"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
				end,
    },
    ["87"] = {
        y = 110,
        x = 183,
        info = {'Button used to make the move'},
        autofunc = function(this)
							this.text = "Button: (".. BUTTON_NAMES[moves["DNEUTRALJ"].wakeup_current_button] ..")" 
												
						
					end,
        text = "Button: ",
        olcolour = "black",
        func = function()
							moves["DNEUTRALJ"].wakeup_current_button = moves["DNEUTRALJ"].wakeup_current_button   +  1
							if moves["DNEUTRALJ"].wakeup_current_button > 4 then
								moves["DNEUTRALJ"].wakeup_current_button = 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_delay  - 1
					end,
    },
    ["90"] = {
        y = 122,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_times - 1
					end,
    },
    ["93"] = {
        y = 122,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("DNEUTRALJ").on_wake_up_times + 1
					end,
    },
    ["95"] = {
        y = 135,
        x = 123,
        info = {'fgrbg guard'},
        autofunc = function(this)
					
					if (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ALT_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = "ALT_GUARD" .. ": Off" 
					elseif (KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ALT_GUARD"] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = "ALT_GUARD" .. ": ON" 
					end
					
				end,
        text = "ALT_GUARD",
        olcolour = "black",
        func = function()
						KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ALT_GUARD"] = KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ALT_GUARD"]+ 1
						if KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ALT_GUARD"] > 1 then
							KOF_CONFIG.MOVES_VAR_NAMES["WAKEUP"]["ALT_GUARD"]  = 0
						end
						KOF_CONFIG["WAKEUP"].reversal_moves = getCurrentReversalMoves("WAKEUP")
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_delay  == 0 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_delay   = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_delay  - 1
					end,
    },
    ["99"] = {
        y = 147,
        x = 168,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_delay )
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_delay),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_delay  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_delay + 1
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
						if KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_times == 1 then
							return
						end
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_times - 1
					end,
    },
    ["102"] = {
        y = 147,
        x = 209,
        info = {},
        autofunc = function(this)
						this.text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_times)
					end,
        text = tostring(KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_times),
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
						KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_times  = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal("ALT_GUARD").on_wake_up_times + 1
					end,
    },
}

return move_data