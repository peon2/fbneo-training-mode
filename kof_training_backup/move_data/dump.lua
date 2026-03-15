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



