function printTable(table, indent)
    indent = indent or 0
    local indentStr = string.rep("  ", indent)

    if type(table) == "table" then
        print(indentStr .. "{")
        for key, value in pairs(table) do
            local keyStr = type(key) == "string" and '["' .. key .. '"]' or "[" .. tostring(key) .. "]"
            print(indentStr .. "  " .. keyStr .. " = " .. tostring(value) .. ",")
            if type(value) == "table" then
                printTable(value, indent + 1)
            end
        end
        print(indentStr .. "}")
    else
        print(indentStr .. tostring(table))
    end
end


	-- Define the structure and default values for the ReversalMove class
	local reversalMove_structure = {
		name = "Default Move",
		on_guard_times = 3,
		on_guard_delay = 0,
		on_wake_up_times = 1,
		on_wake_up_delay = 27,
	}



-- Constructor function to create an instance of the ReversalMove class with default values
	function createReversalMove(moveData)
		local reversalMoveInstance = {}
	
		-- Set default values
		for key, defaultValue in pairs(reversalMove_structure) do
			reversalMoveInstance[key] = defaultValue
		end
	
		-- Override with provided values
		for key, value in pairs(moveData) do
			reversalMoveInstance[key] = value
		end
	
		return reversalMoveInstance
	end
	

-- ReversalList Class
ReversalList = {}

-- Constructor function for ReversalList
	function ReversalList:new()
		local newObj = {}
		newObj.moves = {}  -- Initialize the moves field as an empty table
		setmetatable(newObj, self)
		self.__index = self
		return newObj
	end
	
function ReversalList:setReversals(moves)

	self.moves = {}  -- Clear existing moves

    for moveName, moveData in pairs(moves) do
        local reversalMove = createReversalMove({ name = moveName })
        self.moves[moveName] = reversalMove
    end
end

function ReversalList:getReversal(reversal_name)
    return self.moves[reversal_name]
end

function ReversalList:setReversal(reversal)
    local reversal_name = reversal.move_name
    self.moves[reversal_name] = createReversalMove(reversal)
end
--[[ REVERSAL MOVE ACTIVE SETTINGS  ]]
MOVE_TYPES = {
	NORMAL ="NORMAL",
	COMMAND_NORMAL ="COMMAND_NORMAL",
	SPECIAL = "SPECIAL",
	SUPER = "SUPER"
}
-- Define the BUTTONS table with unique keys
-- Define the BUTTONS table with values wrapped in tables
local BUTTONS = {
    A = 1,
    B = 2,
    C = 3,
    D = 4,
}
local BUTTON_NAMES = {
    [1] = 'a',
    [2] = 'b',
    [3] = 'c',
    [4] = 'd'
}


moves = {
	['DPC'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
		["sequence"] = {
			{'_'},
			{'_'},
			{ 'forward'},
			{ 'forward'},
			{'_'},
			{'_'},
			{'down'},
			{'down'},
			{'down', 'forward','c'},
			{'down', 'forward','c'},
			{'down', 'forward','c'},
			{'down', 'forward','c'},
			{'down', 'forward','c'},
			{'c'},
			{'c'},
			{'c'},
			{'c'},
			{'c'},
		},
			times = 5,
			default = true,
			type = MOVE_TYPES.SPECIAL,

			button_editable = true
	},
	['DP'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'forward'},
            {'forward'},
            {'_'},
            {'_'},
            {'down'},
            {'down'},
            {'down', 'forward', 'a'},
            {'down', 'forward', 'a'},
            {'down', 'forward', 'a'},
            {'down', 'forward', 'a'},
            {'down', 'forward', 'a'},
            {'a'},
            {'a'},
            {'a'},
            {'a'},
            {'a'},
        },
		description = "Dragon Punch (623)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SPECIAL,
		button_editable = true
    },
	['QCF'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'down'},
            {'down'},
            {'down', 'forward'},
            {'down', 'forward'},
            { 'forward', 'a'},
            { 'forward', 'a'},
            {'a'},
            {'a'},
        },
		description = "Quarter circle forward (236)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SPECIAL,
		button_editable = true
    },
	['HCF'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'back'},
            {'back'},
            {'down','back'},
            {'down','back'},
            {'down'},
            {'down'},
            {'down', 'forward'},
            {'down', 'forward'},
            {'forward', 'a'},
            {'forward', 'a'},
            {'a'},
            {'a'},
        },
		description = "Half circle forward (41236)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SPECIAL,
		button_editable = true
    },
	['HCB'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'forward'},
            {'forward'},
            {'down','forward'},
            {'down','forward'},
            {'down'},
            {'down'},
            {'down', 'back'},
            {'down', 'back'},
            {'back', 'a'},
            {'back', 'a'},
            {'a'},
            {'a'},
        },
		description = "Half circle Back (63214)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SPECIAL,
		button_editable = true
    },
	['HCB_F'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'forward'},
            {'forward'},
            {'down','forward'},
            {'down','forward'},
            {'down'},
            {'down'},
            {'down', 'back'},
            {'down', 'back'},
            {'back', },
            {'back', },
            {'forward', 'a'},
            {'forward', 'a'},
            {'a'},
            {'a'},
        },
		description = "Half circle Back Forward (632146)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SPECIAL,
		button_editable = true
    },
	['QCB'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'down'},
            {'down'},
            {'down', 'back'},
            {'down', 'back'},
            {'back', 'a'},
            {'back', 'a'},
            {'a'},
            {'a'},
        },
		description = "Quarter circle Back (214)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SPECIAL,
		button_editable = true
    },
	['QCB_F'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'down'},
            {'down'},
            {'down', 'back'},
            {'down', 'back'},
            {'back', },
            {'back', },
            {'forward', 'a'},
            {'forward', 'a'},
            {'a'},
            {'a'},
        },
		description = "Quarter circle Back Forward (2146)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SUPER,
		button_editable = true
    },
	['QCB_HCF'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'down'},
            {'down'},
            {'down', 'back'},
            {'down', 'back'},
            {'back', },
            {'back', },
            {'down'},
            {'down'},
            {'down', 'forward'},
            {'down', 'forward'},
            {'forward', 'a'},
            {'forward', 'a'},
            {'a'},
            {'a'},
        },
		description = "Quarter circle Back Half circle Forward (214236)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SUPER,
		button_editable = true
    },
	['QCF_QCF'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'down'},
            {'down'},
            {'down', 'forward'},
            {'down', 'forward'},
            { 'forward'},
            { 'forward'},
            {'down'},
            {'down'},
            {'down', 'forward'},
            {'down', 'forward'},
            { 'forward', 'a'},
            { 'forward', 'a'},
            {'a'},
            {'a'},
        },
		description = "Quarter circle forward * 2 (236236)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SUPER,
		button_editable = true
    },
	['QCF_HCB'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'down'},
            {'down'},
            {'down', 'forward'},
            {'down', 'forward'},
            { 'forward'},
            { 'forward'},
            {'down'},
            {'down'},
            {'down', 'back'},
            {'down', 'back'},
            {'back', 'a'},
            {'back', 'a'},
            {'a'},
            {'a'},
        },
		description = "Quarter circle forward (236214)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SUPER,
		button_editable = true
    },
	['PRETZEL'] = {
        wakeup_current_button = BUTTONS.A,
        guard_current_button = BUTTONS.A,
        sequence = {
            {'_'},
            {'_'},
            {'down', 'back'},
            {'down', 'back'},
            { 'forward'},
            { 'forward'},
            {'down', 'forward'},
            {'down', 'forward'},
            {'down'},
            {'down'},
            {'down', 'back'},
            {'down', 'back'},
            {'back'},
            {'back'},
            {'back', 'a'},
            {'back', 'a'},
            {'a'},
            {'a'},
        },
		description = "pretzel (1632143)",
        times = 5,
        default = true,
        type = MOVE_TYPES.SUPER,
		button_editable = true
    },
	['DOWN_C']={
		["sequence"] = {
			{'down', 'forward'},
			{'down', 'forward'},
			{'down', 'forward', 'c'},
			{'down', 'forward', 'c'},
		},
		times = 13,
		default  = true
	},
	['STAND_A']={
		["sequence"] = {
			{'_'},		
			{'_'},		
			{'a'},
			{'a'},
		},
		times = 13
	},
	['C_GUARD']={
		["sequence"] = {
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},

		},
		times = 10
	},	
	['ST_A']={
		["sequence"] = {
			{'_'},		
			{'_'},	
			{ 'a'},
			{ 'a'},
		},
		description = "standing A",
		type = MOVE_TYPES.NORMAL
		 },
	['ST_B']={
		["sequence"] = {
			{'_'},		
			{'_'},	
			{ 'b'},
			{ 'b'},
		},
		description = "standing B",
		type = MOVE_TYPES.NORMAL
		 },
	['ST_C']={
		["sequence"] = {
			{'_'},		
			{'_'},	
			{ 'c'},
			{ 'c'},
		},
		description = "standing C",
		type = MOVE_TYPES.NORMAL
		 },
	['ST_D']={
		["sequence"] = {
			{'_'},		
			{'_'},	
			{ 'd'},
			{ 'd'},
		},
		description = "standing C",
		type = MOVE_TYPES.NORMAL
	},
	['CR_A']={
		["sequence"] = {
			{ 'down'},
			{ 'down'},
			{ 'down','a'},
			{ 'down','a'},
		},
		description = "crouching A",
		type = MOVE_TYPES.NORMAL
		 },
	['CR_B']={
		["sequence"] = {
			{ 'down'},
			{ 'down'},
			{ 'down','b'},
			{ 'down','b'},
		},
		description = "crouching B",
		type = MOVE_TYPES.NORMAL
		 },
	['CR_C']={
		["sequence"] = {
			{ 'down'},
			{ 'down'},
			{ 'down','c'},
			{ 'down','c'},
		},
		description = "crouching C",
		type = MOVE_TYPES.NORMAL
		 },
	['CR_D']={
		["sequence"] = {
			{'down',},
			{'down',},
			{'down', 'd'},
			{ 'down','d'},
		},
		description = "crouching D",
		type = MOVE_TYPES.NORMAL
		 },
		 ['FWD_A']={
			 ["sequence"] = {
				 {'forward',},
				 {'forward',},
				 {'forward', 'a'},
				 { 'forward','a'},
			 },
			 description = "forward A",
			 type = MOVE_TYPES.COMMAND_NORMAL
			  },
		 ['FWD_B']={
			 ["sequence"] = {
				 {'forward',},
				 {'forward',},
				 {'forward', 'b'},
				 { 'forward','b'},
			 },
			 description = "forward B",
			 type = MOVE_TYPES.COMMAND_NORMAL
			  },
		 ['BACK_A']={
			 ["sequence"] = {
				 {'back',},
				 {'back',},
				 {'back', 'a'},
				 { 'back','a'},
			 },
			 description = "back A",
			 type = MOVE_TYPES.COMMAND_NORMAL
			  },
		 ['BACK_B']={
			 ["sequence"] = {
				 {'back',},
				 {'back',},
				 {'back', 'b'},
				 { 'back','b'},
			 },
			 description = "back B",
			 type = MOVE_TYPES.COMMAND_NORMAL
			  },
		 ['DF_B']={
			 ["sequence"] = {
				{'down', 'forward'},
				{'down', 'forward'},
				{'down', 'forward', 'b'},
				{'down', 'forward', 'b'},
			 },
			 description = "back B",
			 type = MOVE_TYPES.COMMAND_NORMAL
			  },
		 ['DF_C']={
			 ["sequence"] = {
				{'down', 'forward'},
				{'down', 'forward'},
				{'down', 'forward', 'c'},
				{'down', 'forward', 'c'},
			 },
			 description = "back B",
			 type = MOVE_TYPES.COMMAND_NORMAL
			  },
		 ['DF_D']={
			 ["sequence"] = {
				{'down', 'forward'},
				{'down', 'forward'},
				{'down', 'forward', 'd'},
				{'down', 'forward', 'd'},
			 },
			 description = "back B",
			 type = MOVE_TYPES.COMMAND_NORMAL
			  },
	['THROW_C']={
		["sequence"] = {
			{'forward'},
			{'forward'},
			{'forward', 'c'},
			{'forward', 'c'},
		},
		times = 10
	},
	['CD']={
		["sequence"] = {		
			{'_'},
			{'_'},
			{'c', 'd'} 
		},
		times = 10,
		type = MOVE_TYPES.NORMAL
	},
	['AB']={
		["sequence"] = {
			{'a', 'b'}, 
			{'a', 'b'}, 
			{'a', 'b'}, 
			{'a', 'b'} 
		},
		times = 3,
		type = MOVE_TYPES.NORMAL
	},
	['MASH_CRB']={
		["sequence"] = {
			{'down','b'},
			{'down', 'b'},
			{'down', 'b'},
			{'down', 'b'},
			{'down', 'b'},
			{'-'},
			{'-'},
			{'-'},
			{'-'},
			{'-'},
		},
		times = 17,
	},
	['SUPER_JUMP_BACK']={
		["sequence"] = {	
			{'-'},
			{'-'},
			{'down'},
			{'down'},
			{'up','back'},
			{'up','back'},
			{'up','back'},
			{'up','back'},
			{'up','back'},
			{'up','back'},
		},
		times = 17,
		hidden = true
	},
}
-- Example usage:
--[[ print("Initial sequence:")
for _, step in ipairs(moves.DP.sequence) do
    local actions = table.concat(step, ', ')
    print(actions)
end

-- Update the current button dynamically using the method
moves.DP:updateButton(BUTTONS.B)

print("\nUpdated sequence:")
for _, step in ipairs(moves.DP.sequence) do
    local actions = table.concat(step, ', ')
    print(actions)
end
 ]]
local movelist = ReversalList:new()
movelist:setReversals(moves)
KOF_CONFIG.REVERSAL_MOVES.MOVELIST = movelist
local reversal_types = {
GUARD = "GUARD",
WAKEUP = "WAKEUP",
ALL = "ALL" 
}
local function initializeReversalMoveSettings(moves, config, guipages, type)
	local reversalmoveactivesettings = {}

	local elementsPerColumn = 6-- Elements per column
	local xSpacing = 115 -- Spacing between columns
	local xPosition = 8
	local yPosition = 10
	local iterator = 1
	local elementsPerRow = 20
	local rowGap = 25
	for index, value in pairs(moves) do
		if moves[index].hidden then
			-- Skip this iteration        
		else
			local baseIndex = ((iterator- 1) *elementsPerRow )+ 1
			if moves[index].default == true then
				table.insert(config.MOVES_VAR_NAMES[type],index)
				config.MOVES_VAR_NAMES[type][index]= config.REVERSAL_MOVES.OPTIONS.ON
			else
				table.insert(config.MOVES_VAR_NAMES[type],index)
				config.MOVES_VAR_NAMES[type][index]= config.REVERSAL_MOVES.OPTIONS.OFF
			end

			local column = math.floor((iterator - 1) / elementsPerColumn) + 1
			local columnElement = (iterator - 1) % elementsPerColumn + 1
			
			xPosition = 8 + (column - 1) * xSpacing
			
			if columnElement == 1 then
				yPosition = 10
			else
				yPosition = yPosition + rowGap
			end

			

			reversalmoveactivesettings[baseIndex] = {
				text = index,
				x = xPosition,
				y = yPosition,
				olcolour = "black",
				info = {moves[index].description},
				func = function()
						config.MOVES_VAR_NAMES[type][index] = config.MOVES_VAR_NAMES[type][index]+ 1
						if config.MOVES_VAR_NAMES[type][index] > 1 then
							config.MOVES_VAR_NAMES[type][index]  = 0
						end
						config[type].reversal_moves = getCurrentReversalMoves(type)
				end,
				autofunc = function(this)
					
					if (config.MOVES_VAR_NAMES[type][index] == config.REVERSAL_MOVES.OPTIONS.OFF) then
						this.text = index .. ": Off" 
					elseif (config.MOVES_VAR_NAMES[type][index] == config.REVERSAL_MOVES.OPTIONS.ON) then
						this.text = index .. ": ON" 
					end
					config[type].reversal_moves = getCurrentReversalMoves(type)
				end,
			}

			table.insert(guipages, reversalmoveactivesettings[baseIndex])
			local current_reversal_move = config.REVERSAL_MOVES.MOVELIST:getReversal(index)
			if(moves[index].button_editable) then 
				reversalmoveactivesettings[baseIndex   +1]  = {
					text = "Button: ",
					x = xPosition + 60,
					y = yPosition,
					olcolour = "black",
					info = {"Button used to make the move"},
					func = function()
						if type == reversal_types.GUARD then
							moves[index].guard_current_button = moves[index].guard_current_button   +  1
							if moves[index].guard_current_button > 4 then
								moves[index].guard_current_button = 1
							end
						elseif type == reversal_types.WAKEUP then
							moves[index].wakeup_current_button = moves[index].wakeup_current_button   +  1
							if moves[index].wakeup_current_button > 4 then
								moves[index].wakeup_current_button = 1
							end
						end
					end,
					autofunc = function(this)
						if type == reversal_types.GUARD then
							this.text = "Button: (".. BUTTON_NAMES[moves[index].guard_current_button ] ..")" 
						elseif type == reversal_types.WAKEUP then
							this.text = "Button: (".. BUTTON_NAMES[moves[index].wakeup_current_button ] ..")" 						
						end
					end,
				}
			end
			
			table.insert(guipages, reversalmoveactivesettings[baseIndex +1])
			--[[ -- Set hook to trace line execution
			debug.sethook(trace_line, "l")
			-- Execute the line in question
			table.insert(guipages, reversalmoveactivesettings[baseIndex])

			-- Clear hook when done
			debug.sethook() ]]
			

			

			--ELEMENTS OF THE CALIBRATION ROW  for guard
				-- First Element: "delay: "
				reversalmoveactivesettings[baseIndex * 2 ] = {
					text = "d & t:",
					x = xPosition,
					y = yPosition + 12,				
					olcolour = "black",
					info = { 
						"this is the delay it will take on frames and the times of the reversal on guard"
						
					},
					func = function()
						-- Function for "delay: "
					end,
				}
				table.insert(guipages, reversalmoveactivesettings[baseIndex * 2])
			
				-- Second Element: "(-) delay"
				reversalmoveactivesettings[baseIndex * 2  + 1] = {
					text = "-",
					x = xPosition + 34,  -- Adjust x position as needed
					y = yPosition + 12,  -- Keep the same y position
					olcolour = "black",
					info = {},
					func = function()
						-- Function for "(-) delay"				
						if current_reversal_move.on_guard_delay == 0 then
							return
						end
						current_reversal_move.on_guard_delay  = current_reversal_move.on_guard_delay - 1
					end,
				}
				table.insert(guipages, reversalmoveactivesettings[baseIndex * 2  + 1])
				-- Third Element: "delay"
				reversalmoveactivesettings[baseIndex * 2 + 2] = {
					text = tostring(current_reversal_move.on_guard_delay),
					x = xPosition + 45,  -- Adjust x position as needed
					y = yPosition + 12,  -- Keep the same y position
					olcolour = "black",
					info = {},
					func = function()
						
					end,
					autofunc = function(this)
						this.text = tostring(current_reversal_move.on_guard_delay)
					end,
			
				}
				table.insert(guipages, reversalmoveactivesettings[baseIndex * 2 + 2])
				-- Fourth Element: "+ delay"
				reversalmoveactivesettings[baseIndex * 2 + 3] = {
					text = "+",
					x = xPosition + 60,  -- Adjust x position as needed
					y = yPosition + 12,  -- Keep the same y position
					olcolour = "black",
					info = {},
					func = function()
						-- Function for "(+) delay"
						current_reversal_move.on_guard_delay  = current_reversal_move.on_guard_delay + 1
					end,
				}
				table.insert(guipages, reversalmoveactivesettings[baseIndex * 2 + 3])
			
				-- fith Element: "(-) Times"
				reversalmoveactivesettings[baseIndex * 2 + 4] = {
					text = "-",
					x = xPosition + 75,  -- Adjust x position as needed
					y = yPosition + 12,  -- Keep the same y position
					olcolour = "black",
					info = {},
					func =  function()
						-- Function for "(-) times"				
						if current_reversal_move.on_guard_times == 1 then
							return
						end
						current_reversal_move.on_guard_times  = current_reversal_move.on_guard_times - 1
					end,
				}
				table.insert(guipages, reversalmoveactivesettings[baseIndex * 2 + 4])
				-- sixth Element: "times"
				reversalmoveactivesettings[baseIndex * 2 + 5] = {
					text = tostring(current_reversal_move.on_guard_times),
					x = xPosition + 86,  -- Adjust x position as needed
					y = yPosition + 12,  -- Keep the same y position
					olcolour = "black",
					info = {},
					func = function()
						
					end,
					autofunc = function(this)
						this.text = tostring(current_reversal_move.on_guard_times)
					end,
				}
				table.insert(guipages, reversalmoveactivesettings[baseIndex * 2 + 5])
				-- Seventh Element: "+ times"
				reversalmoveactivesettings[baseIndex * 2 + 6] = {
					text = "+",
					x = xPosition + 99,  -- Adjust x position as needed
					y = yPosition + 12,  -- Keep the same y position
					olcolour = "black",
					info = {},
					func = function()
						current_reversal_move.on_guard_times  = current_reversal_move.on_guard_times + 1
					end,
				}
				table.insert(guipages, reversalmoveactivesettings[baseIndex * 2 + 6])
				
			
			
			iterator = iterator + 1
		end
	end
	command_normals_custom_page_link ={
		text = "command normals",
		x = 8,
		y = interactivegui.boxy2 -30,
		olcolour = "black",
		handle = 8,
		func = 	function() changeInteractiveGuiPage("command_normals_move_settings") end,
	}
	table.insert(guipages, command_normals_custom_page_link)
	
	specials_custom_page_link ={
		text = "specials",
		x = 78,
		y = interactivegui.boxy2 -30,
		olcolour = "black",
		handle = 8,
		func = 	function() changeInteractiveGuiPage("special_move_settings") end,
	}
	table.insert(guipages, specials_custom_page_link)
	
	supers_custom_page_link ={
		text = "Supers ",
		x = 118,
		y = interactivegui.boxy2 -30,
		olcolour = "black",
		handle = 8,
		func = 	function() changeInteractiveGuiPage("supers_move_settings") end,
	}
	table.insert(guipages, supers_custom_page_link)
	

end
-- Function to filter elements by type
local function filterMoves(moves, moveType)
    local filtered = {}
	for key, move in pairs(moves) do
		print("move type: ", key.type)
		print("moveType: ", moveType)
		if move.type and move.type == moveType then  
			filtered[key] = move
		end
	end
    return filtered
end
--- added normal moves to default page
local normal_moves = filterMoves(moves, MOVE_TYPES.NORMAL) 
initializeReversalMoveSettings(normal_moves, KOF_CONFIG,guipages.guard_reversal_move_active_settings , reversal_types.GUARD)
--adds command normal moves config page
local command_normals_moves = filterMoves(moves, MOVE_TYPES.COMMAND_NORMAL) 
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
		func =  function() CIG("guard_reversal_move_active_settings",2) end,
	},
}
guipages.command_normals_move_settings = command_normals_move_settings
initializeReversalMoveSettings(command_normals_moves, KOF_CONFIG,guipages.command_normals_move_settings, reversal_types.GUARD)
--- add special moves
local special_moves = filterMoves(moves, MOVE_TYPES.SPECIAL) 
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
		func =  function() CIG("guard_reversal_move_active_settings",1) end,
	},
}
guipages.special_move_settings = special_move_settings
initializeReversalMoveSettings(special_moves, KOF_CONFIG,guipages.special_move_settings, reversal_types.GUARD)
--adds super moves
local super_moves = filterMoves(moves, MOVE_TYPES.SUPER) 
local super_move_settings = {
	title = {
		text = "super Move  Settings",
		x = interactivegui.boxxlength/2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG(1,1) end,
	},
}
guipages.supers_move_settings = super_move_settings
initializeReversalMoveSettings(super_moves, KOF_CONFIG,guipages.supers_move_settings, reversal_types.GUARD) 
-- Function to get the index from the value
function getIndexFromConfigValue(value)
    for index, confValue in pairs(KOF_CONFIG.TRAINING.CONFIGURATIONS) do
        if confValue == value then
            return index
        end
    end
    return nil  -- Value not found
end

function getCurrentReversalMoves(type)
	local tabl = {}
	for index, value in pairs(KOF_CONFIG.MOVES_VAR_NAMES[type]) do
		if (KOF_CONFIG.MOVES_VAR_NAMES[type][index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
		
            local reversalMove = index
			table.insert(tabl, reversalMove)
		end
	end
	
	return tabl
end


KOF_CONFIG.GUARD.reversal_moves = getCurrentReversalMoves(reversal_types.GUARD)
KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.WAKEUP)


function deactivateAllDefaultMoves()
	for index, value in pairs(KOF_CONFIG.MOVES_VAR_NAMES) do
		KOF_CONFIG.MOVES_VAR_NAMES[index] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF
			
	end

	KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
	KOF_CONFIG.GUARD.reversal_moves  = getCurrentGuardReversalMoves()
end

function resetAllConfiguration()
	deactivateAllDefaultMoves()
	KOF_CONFIG.GUARD.standing_guard = 0
	KOF_CONFIG.GUARD.crouch_guard = 0
	KOF_CONFIG.GUARD.dummy_guarding = false
	KOF_CONFIG.GUARD.random_guard = 0
	KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.REVERSAL_OPTIONS.OFF
	KOF_CONFIG.WAKEUP.dummy_waking_up = false
	KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.OFF

	KOF_CONFIG.RECOVERY.dummy_recovering = false
	KOF_CONFIG.RECOVERY.recovery = KOF_CONFIG.RECOVERY.OPTIONS.OFF

	KOF_CONFIG.RECOVERY.delay = 10
	KOF_CONFIG.RECOVERY.times = 8
end

-- Function to set default configuration based on configName
function setDefaultConfig(configName)

	resetAllConfiguration()
	if configName ==  KOF_CONFIG.TRAINING.CONFIGURATIONS["None"] then
		return
	end
    if configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["cd_pressure_1"] then
			-- activate recovery
		KOF_CONFIG.RECOVERY.dummy_recovering = true
		KOF_CONFIG.RECOVERY.recovery = KOF_CONFIG.RECOVERY.OPTIONS.ON
		--set recovery time for CD knockdown
		KOF_CONFIG.RECOVERY.delay = 24
		KOF_CONFIG.RECOVERY.times = 3
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["cd_pressure_2"] then
		print("now on pressure 2")
			-- activate recovery
		KOF_CONFIG.RECOVERY.dummy_recovering = true
		KOF_CONFIG.RECOVERY.recovery = KOF_CONFIG.RECOVERY.OPTIONS.ON
		--set recovery time for CD knockdown
		KOF_CONFIG.RECOVERY.delay = 24
		KOF_CONFIG.RECOVERY.times = 3
		--activate wake up on
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON
		-- activate dp on wakeup 
		local move_name = "DPC"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["cd_pressure_3"] then
			-- activate recovery
		KOF_CONFIG.RECOVERY.dummy_recovering = true
		KOF_CONFIG.RECOVERY.recovery = KOF_CONFIG.RECOVERY.OPTIONS.ON
		--set recovery time for CD knockdown
		KOF_CONFIG.RECOVERY.delay = 24
		KOF_CONFIG.RECOVERY.times = 3
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		-- activate dp on wakeup 
		local move_name = "DPC"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- activate cr guard on wakeup 
		local move_name = "C_GUARD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 30
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["cd_pressure_4"] then
			-- activate recovery
		KOF_CONFIG.RECOVERY.dummy_recovering = true
		KOF_CONFIG.RECOVERY.recovery = KOF_CONFIG.RECOVERY.OPTIONS.ON
		--set recovery time for CD knockdown
		KOF_CONFIG.RECOVERY.delay = 24
		KOF_CONFIG.RECOVERY.times = 3
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		-- activate dp on wakeup 
		local move_name = "DPC"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- activate cr guard on wakeup 
		local move_name = "C_GUARD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 5
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
		--activate guard reversal
		KOF_CONFIG.GUARD.dummy_guarding = true
        KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.REVERSAL_OPTIONS.ON
		--activate crouch guard
		KOF_CONFIG.GUARD.crouch_guard = 1
		-- activate guard random
		KOF_CONFIG.GUARD.random_guard = 1
		-- activate throw C on guard 
		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_guard_delay = 10
		current_reversal_move.on_guard_times = 5
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD
		-- reload reversal moves
		KOF_CONFIG.GUARD.reversal_moves  = getCurrentGuardReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["crouching_frametrap"] then
		--activate guard reversal
		KOF_CONFIG.GUARD.dummy_guarding = true
        KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.REVERSAL_OPTIONS.ON
		--activate crouch guard
		KOF_CONFIG.GUARD.crouch_guard = 1
		-- activate throw C on guard 
		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_guard_delay = 10
		current_reversal_move.on_guard_times = 5
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD
		-- reload reversal moves
		KOF_CONFIG.GUARD.reversal_moves  = getCurrentGuardReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["standing_frametrap"] then
		--activate guard reversal
		KOF_CONFIG.GUARD.dummy_guarding = true
        KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.REVERSAL_OPTIONS.ON
		--activate crouch guard
		KOF_CONFIG.GUARD.standing_guard = 1
		-- activate throw C on guard 
		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_guard_delay = 10
		current_reversal_move.on_guard_times = 5
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD
		-- reload reversal moves
		KOF_CONFIG.GUARD.reversal_moves  = getCurrentGuardReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["high_confirm_against_CDA"] then
		--activate guard reversal
		KOF_CONFIG.GUARD.dummy_guarding = true
        KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.REVERSAL_OPTIONS.RANDOM
		--activate crouch guard
		KOF_CONFIG.GUARD.standing_guard = 1
		-- activate guard random
		KOF_CONFIG.GUARD.random_guard = 1
		-- activate throw C on guard 
		local move_name = "C_GUARD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_guard_delay = 0
		current_reversal_move.on_guard_times = 10
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD
		-- activate CD on guard 
		local move_name = "CD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_guard_delay = 0
		current_reversal_move.on_guard_times = 3
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD
		-- reload reversal moves
		KOF_CONFIG.GUARD.reversal_moves  = getCurrentGuardReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["wakeup_whiff_cr_c"] then
		--activate crouch guard
		KOF_CONFIG.GUARD.dummy_guarding = true
		KOF_CONFIG.GUARD.crouch_guard = 1
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON
		-- activate dp on wakeup 
		local move_name = "DOWN_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 40
		current_reversal_move.on_wake_up_times = 2
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["wakeup_dpc"] then
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON
		-- activate dp on wakeup 
		local move_name = "DPC"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["shimmy_wakeup"] then
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		-- activate dp on wakeup 
		local move_name = "DPC"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 35
		current_reversal_move.on_wake_up_times = 5
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["wakeup_delay_OS_basic"] then
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		-- activate dp on wakeup 
		local move_name = "DPC"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 35
		current_reversal_move.on_wake_up_times = 5
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name = "MASH_CRB"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 35
		current_reversal_move.on_wake_up_times = 3
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["wakeup_delay_OS_full"] then
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
        KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		-- activate dp on wakeup 
		local move_name = "DPC"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 35
		current_reversal_move.on_wake_up_times = 5
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name = "MASH_CRB"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 6
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name = "AB"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 39
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		local move_name = "SUPER_JUMP_BACK"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 36
		current_reversal_move.on_wake_up_times = 1
		KOF_CONFIG.MOVES_VAR_NAMES[move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
	else
        print("Unknown configuration:", configName)
    end
end