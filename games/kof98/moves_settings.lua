--[[ REVERSAL MOVE ACTIVE SETTINGS  ]]

moves = {
	['DPC'] = {
		["sequence"] = {
			{ 'forward'},
			{ 'forward'},
			{'_'},
			{'_'},
			{'down'},
			{'down'},
			{'down', 'forward','c'},
			{'down', 'forward','c'},
			{'c'},
			{'c'},
			{'c'}},
			times = 5,
	},
	['DPD'] = {
		["sequence"] = {
			{ 'forward'},
			{ 'forward'},
			{'_'},
			{'_'},
			{'down'},
			{'down'},
			{'down', 'forward','d'},
			{'down', 'forward','d'},
			{'d'},
			{'d'},
			{'d'}},
			times = 5,
	},
	['DPA'] = {
		["sequence"] = {
			{'_'},
			{'_'},
			{ 'forward'},
			{ 'forward'},
			{'_'},
			{'_'},
			{'down'},
			{'down'},
			{'down', 'forward','a'},
			{'down', 'forward','a'},
			{'a'},
			{'a'},
			{'a'}},
			times = 13
	},
	['DOWN_C']={
		["sequence"] = {
			{'down', 'forward'},
			{'down', 'forward'},
			{'down', 'forward', 'c'},
			{'down', 'forward', 'c'},
		},
		times = 13
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
	['GUARD']={
		["sequence"] = {
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},

		},
		times = 10
	},
	['GUARD_BACK']={
		["sequence"] = {
			{'back'},
			{'back'},

		},
		times = 10
	},
	['THROW_C']={
		["sequence"] = {
			{'back'},
			{'back'},
			{'back'},
			{'back'},
			{'back', 'c'},
			{'back', 'c'},				
			{'back'},
			{'back'},
			{'back'},
			{'back'},
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
		default = true
	},
	['AB']={
		["sequence"] = {
			{'a', 'b'}, 
			{'a', 'b'}, 
			{'a', 'b'}, 
			{'a', 'b'} 
		},
		times = 3,
		default = true
	},
	['FAB']={
		["sequence"] = {
			{'_'},		
			{'_'},		
			{'forward'},
			{'forward'},
			{'forward','a', 'b'},
			{'forward','a', 'b'},
			{'a', 'b'},
			{'a', 'b'},
		},
		times = 10
	},
	['MASH_CRB']={
		["sequence"] = {	
			{'down'},
			{'down'},
			{'down'},
			{'down'},
			{'down'},
			{'down'},
			{'down','b'},
			{'down', 'b'},
		},
		times = 17,
	},
	['HCBF_C']={
		["sequence"] = {
			{'_'},		
			{'_'},	
			{'_'},		
			{'_'},	
			{'_'},		
			{'_'},	
			{'_'},		
			{'_'},	
			{'_'},		
			{'_'},	
			{'forward'},
			{'forward'},
			{'down'},
			{'down'},
			{'back'},
			{'back'},
			{'forward','c'},
			{'forward', 'c'},
			{'forward', 'c'},
			{'forward', 'c'},
			{'c'},
			{'c'},
			{'c'},
			{'c'},
			{'c'},
			{'c'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
			{'back','down'},
		},
		times = 1,
	},
	['INSTANT_AA']={
		["sequence"] = {
			{'down'},
			{'down'},
			{'-'},
			{'up'},
			{'up'},
			{'up','b'},
			{'up','b'},
			{'b'},
			{'b'},

		},
		times = 3
	},
}
local reversalmoveactivesettings = {}
local moves_var_names = {}
local elementsPerColumn = 8  -- Elements per column
local xSpacing = 100  -- Spacing between columns
local xPosition = 8
local yPosition = 10
local iterator = 1

for index, value in pairs(moves) do
    if moves[index].default == true then
        moves_var_names[index] = 1
    else
        moves_var_names[index] = 0
    end

    local column = math.floor((iterator - 1) / elementsPerColumn) + 1
    local columnElement = (iterator - 1) % elementsPerColumn + 1
    
    xPosition = 8 + (column - 1) * xSpacing
    
    if columnElement == 1 then
        yPosition = 10
    else
        yPosition = yPosition + 20
    end

    reversalmoveactivesettings[index] = {
        text = "Enable " .. index,
        x = xPosition,
        y = yPosition,
        olcolour = "black",
        info = {},
        func = function()
            moves_var_names[index] = (moves_var_names[index] + 1) % 2
            dummy_reversal_moves = getCurrentReversalMoves()
        end,
        autofunc = function(this)
            this.text = "Enable " .. index .. ": " .. ((moves_var_names[index] == 0) and "Off" or "On")
        end,
    }
    table.insert(guipages.reversal_move_active_settings, reversalmoveactivesettings[index])
    iterator = iterator + 1
end


function getCurrentReversalMoves()
	local tabl = {}
	for index, value in pairs(moves_var_names) do
		if moves_var_names[index] == 1 then
			table.insert(tabl, index)
		end
	end
	return tabl
end

dummy_reversal_moves = getCurrentReversalMoves()
