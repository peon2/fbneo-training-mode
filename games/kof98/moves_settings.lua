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

moves = {
	['DPC'] = {
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
			default = true
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
		times = 10
	},
	['AB']={
		["sequence"] = {
			{'a', 'b'}, 
			{'a', 'b'}, 
			{'a', 'b'}, 
			{'a', 'b'} 
		},
		times = 3
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


local movelist = ReversalList:new()
movelist:setReversals(moves)
KOF_CONFIG.REVERSAL_MOVES.MOVELIST = movelist

local reversalmoveactivesettings = {}

local elementsPerColumn = 4-- Elements per column
local xSpacing = 115 -- Spacing between columns
local xPosition = 8
local yPosition = 10
local iterator = 1
local elementsPerRow = 15
local rowGap = 40
for index, value in pairs(moves) do
	if moves[index].hidden then
        -- Skip this iteration        
	else
		local baseIndex = ((iterator- 1) *elementsPerRow )+ 1
		if moves[index].default == true then
			print("KOF_CONFIG.MOVES_VAR_NAMES")
			printTable(KOF_CONFIG.MOVES_VAR_NAMES[index])
			KOF_CONFIG.MOVES_VAR_NAMES[index] =  KOF_CONFIG.REVERSAL_MOVES.OPTIONS.BOTH
			printTable(KOF_CONFIG.MOVES_VAR_NAMES[index])
		else
			KOF_CONFIG.MOVES_VAR_NAMES[index] =  KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF
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
			info = {},
			func = function()
					KOF_CONFIG.MOVES_VAR_NAMES[index] = KOF_CONFIG.MOVES_VAR_NAMES[index]+ 1
					if KOF_CONFIG.MOVES_VAR_NAMES[index]> 3 then
						KOF_CONFIG.MOVES_VAR_NAMES[index] = 0
					end
					KOF_CONFIG.GUARD.reversal_moves = getCurrentGuardReversalMoves()
					KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
			end,
			autofunc = function(this)
				
				if (KOF_CONFIG.MOVES_VAR_NAMES[index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF) then
					this.text = index .. ": Off" 
				elseif (KOF_CONFIG.MOVES_VAR_NAMES[index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD) then
					this.text = index .. ": Guard" 
				elseif (KOF_CONFIG.MOVES_VAR_NAMES[index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP)then
					this.text = index .. ": WakeUp" 
				elseif (KOF_CONFIG.MOVES_VAR_NAMES[index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.BOTH)then
					this.text = index .. ": Both" 
				end
				KOF_CONFIG.GUARD.reversal_moves = getCurrentGuardReversalMoves()
				KOF_CONFIG.WAKEUP.reversal_moves  = getCurrentWakeupReversalMoves()
			end,
		}
		table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex])
		

		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(index)

		--ELEMENTS OF THE CALIBRATION ROW  for guard
			-- First Element: "delay: "
			reversalmoveactivesettings[baseIndex * 2 ] = {
				text = "Guard:",
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
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2])
		
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
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2  + 1])
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
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 2])
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
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 3])
		
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
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 4])
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
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 5])
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
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 6])
			--ELEMENTS OF THE CALIBRATION ROW  for Wake Up
				-- First Element: "delay: "
			reversalmoveactivesettings[baseIndex * 2 + 7 ] = {
				text = "WakeUp:",
				x = xPosition,
				y = yPosition + 24,				
				olcolour = "black",
				info = { 
					"this is the delay it will take on frames and the times of the reversal on guard"
					
				},
				func = function()
					-- Function for "delay: "
				end,
			}
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 7])
		
			-- Second Element: "(-) delay"
			reversalmoveactivesettings[baseIndex * 2  + 8] = {
				text = "-",
				x = xPosition + 34,  -- Adjust x position as needed
				y = yPosition + 24,  -- Keep the same y position
				olcolour = "black",
				info = {},
				func = function()
					-- Function for "(-) delay"				
					if current_reversal_move.on_wake_up_delay == 0 then
						return
					end
					current_reversal_move.on_wake_up_delay  = current_reversal_move.on_wake_up_delay - 1
				end,
			}
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2  + 8])
			-- Third Element: "delay"
			reversalmoveactivesettings[baseIndex * 2 + 9] = {
				text = tostring(current_reversal_move.on_wake_up_delay),
				x = xPosition + 45,  -- Adjust x position as needed
				y = yPosition + 24,  -- Keep the same y position
				olcolour = "black",
				info = {},
				func = function()
					
				end,
				autofunc = function(this)
					this.text = tostring(current_reversal_move.on_wake_up_delay)
				end,
		
			}
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 9])
			-- Fourth Element: "+ delay"
			reversalmoveactivesettings[baseIndex * 2 + 10] = {
				text = "+",
				x = xPosition + 60,  -- Adjust x position as needed
				y = yPosition + 24,  -- Keep the same y position
				olcolour = "black",
				info = {},
				func = function()
					-- Function for "(+) delay"
					current_reversal_move.on_wake_up_delay  = current_reversal_move.on_wake_up_delay + 1
				end,
			}
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 10])
		
			-- fith Element: "(-) Times"
			reversalmoveactivesettings[baseIndex * 2 + 11] = {
				text = "-",
				x = xPosition + 75,  -- Adjust x position as needed
				y = yPosition + 24,  -- Keep the same y position
				olcolour = "black",
				info = {},
				func =  function()
					-- Function for "(-) times"				
					if current_reversal_move.on_wake_up_times == 1 then
						return
					end
					current_reversal_move.on_wake_up_times  = current_reversal_move.on_wake_up_times - 1
				end,
			}
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 11])
			-- sixth Element: "times"
			reversalmoveactivesettings[baseIndex * 2 + 12] = {
				text = tostring(current_reversal_move.on_wake_up_times),
				x = xPosition + 86,  -- Adjust x position as needed
				y = yPosition + 24,  -- Keep the same y position
				olcolour = "black",
				info = {},
				func = function()
					
				end,
				autofunc = function(this)
					this.text = tostring(current_reversal_move.on_wake_up_times)
				end,
			}
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 12])
			-- Seventh Element: "+ times"
			reversalmoveactivesettings[baseIndex * 2 + 13] = {
				text = "+",
				x = xPosition + 99,  -- Adjust x position as needed
				y = yPosition + 24,  -- Keep the same y position
				olcolour = "black",
				info = {},
				func = function()
					current_reversal_move.on_wake_up_times  = current_reversal_move.on_wake_up_times + 1
				end,
			}
			table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[baseIndex * 2 + 13])
		
		
		iterator = iterator + 1
	end
end

-- Function to get the index from the value
function getIndexFromConfigValue(value)
    for index, confValue in pairs(KOF_CONFIG.TRAINING.CONFIGURATIONS) do
        if confValue == value then
            return index
        end
    end
    return nil  -- Value not found
end
function getCurrentGuardReversalMoves()
	local tabl = {}
	for index, value in pairs(KOF_CONFIG.MOVES_VAR_NAMES) do
		if (KOF_CONFIG.MOVES_VAR_NAMES[index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.GUARD) or KOF_CONFIG.MOVES_VAR_NAMES[index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.BOTH then
		
            local reversalMove = index
			table.insert(tabl, reversalMove)
		end
	end
	
	return tabl
end

 function getCurrentWakeupReversalMoves()
    local tabl = {}
    
    for index, value in pairs(KOF_CONFIG.MOVES_VAR_NAMES) do
        if (KOF_CONFIG.MOVES_VAR_NAMES[index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.WAKEUP) or KOF_CONFIG.MOVES_VAR_NAMES[index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.BOTH then
            
            local reversalMove = index
			table.insert(tabl, reversalMove)
		end
    end
    return tabl
end

KOF_CONFIG.GUARD.reversal_moves = getCurrentGuardReversalMoves()
KOF_CONFIG.WAKEUP.reversal_moves = getCurrentWakeupReversalMoves()


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