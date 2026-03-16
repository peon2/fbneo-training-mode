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
	on_hit_times = 3,
	on_hit_delay = 0,
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
	newObj.moves = {} -- Initialize the moves field as an empty table
	setmetatable(newObj, self)
	self.__index = self
	return newObj
end

function ReversalList:setReversals(moves)
	self.moves = {} -- Clear existing moves

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
	NORMAL = "NORMAL",
	COMMAND_NORMAL = "COMMAND_NORMAL",
	SPECIAL = "SPECIAL",
	SUPER = "SUPER",
	COMMON = "COMMON",
	RECORDING = "RECORDING"
}
-- Define the BUTTONS table with unique keys
-- Define the BUTTONS table with values wrapped in tables
BUTTONS = {
	A = 1,
	B = 2,
	C = 3,
	D = 4,
}

BUTTON_NAMES = {
	[1] = 'a',
	[2] = 'b',
	[3] = 'c',
	[4] = 'd'
}

moves = {
	['REC_1'] = { type = MOVE_TYPES.RECORDING, index = 1 },
	['REC_2'] = { type = MOVE_TYPES.RECORDING, index = 2 },
	['REC_3'] = { type = MOVE_TYPES.RECORDING, index = 3 },
	['REC_4'] = { type = MOVE_TYPES.RECORDING, index = 4 },
	['REC_5'] = { type = MOVE_TYPES.RECORDING, index = 5 },
	['DP'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ 'forward' },
			{ 'forward' },
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ 'down',   'forward', 'a' },
			{ 'down',   'forward', 'a' },
			{ 'down',   'forward', 'a' },
			{ 'down',   'forward', 'a' },
			{ 'down',   'forward', 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Dragon Punch (623)",
		times = 5,
		type = MOVE_TYPES.SPECIAL,
		button_editable = true
	},
	['R_DP'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'back' },
			{ 'back' },
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ 'down', 'back', 'a' },
			{ 'down', 'back', 'a' },
			{ 'down', 'back', 'a' },
			{ 'down', 'back', 'a' },
			{ 'down', 'back', 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Reverse Dragon Punch (421)",
		times = 5,
		type = MOVE_TYPES.SPECIAL,
		button_editable = true
	},
	['D_F_DF'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ '_' },
			{ '_' },
			{ 'forward' },
			{ 'forward' },
			{ 'down',   'forward', 'a' },
			{ 'down',   'forward', 'a' },
			{ 'down',   'forward', 'a' },
			{ 'down',   'forward', 'a' },
			{ 'down',   'forward', 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "k9999 super move",
		times = 5,
		type = MOVE_TYPES.SPECIAL,
		button_editable = true
	},
	['QCF'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ 'down',    'forward' },
			{ 'down',    'forward' },
			{ 'forward', 'a' },
			{ 'forward', 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Quarter circle forward (236)",
		times = 5,
		type = MOVE_TYPES.SPECIAL,
		button_editable = true
	},
	['HCF'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'back' },
			{ 'back' },
			{ 'down',    'back' },
			{ 'down',    'back' },
			{ 'down' },
			{ 'down' },
			{ 'down',    'forward' },
			{ 'down',    'forward' },
			{ 'forward', 'a' },
			{ 'forward', 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Half circle forward (41236)",
		times = 5,
		type = MOVE_TYPES.SPECIAL,
		button_editable = true
	},
	['HCB'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'forward' },
			{ 'forward' },
			{ 'down',   'forward' },
			{ 'down',   'forward' },
			{ 'down' },
			{ 'down' },
			{ 'down',   'back' },
			{ 'down',   'back' },
			{ 'back',   'a' },
			{ 'back',   'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Half circle Back (63214)",
		times = 5,
		type = MOVE_TYPES.SPECIAL,
		button_editable = true
	},
	['HCB_F'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'forward' },
			{ 'forward' },
			{ 'down',    'forward' },
			{ 'down',    'forward' },
			{ 'down' },
			{ 'down' },
			{ 'down',    'back' },
			{ 'down',    'back' },
			{ 'back', },
			{ 'back', },
			{ 'forward', 'a' },
			{ 'forward', 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Half circle Back Forward (632146)",
		times = 5,
		type = MOVE_TYPES.SPECIAL,
		button_editable = true
	},
	['QCB'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'back', 'a' },
			{ 'back', 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Quarter circle Back (214)",
		times = 5,
		type = MOVE_TYPES.SPECIAL,
		button_editable = true
	},
	['QCB_F'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ 'down',    'back' },
			{ 'down',    'back' },
			{ 'back', },
			{ 'back', },
			{ 'forward', 'a' },
			{ 'forward', 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Quarter circle Back Forward (2146)",
		times = 5,
		type = MOVE_TYPES.SUPER,
		button_editable = true
	},
	['QCB_HCF'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ 'down',    'back' },
			{ 'down',    'back' },
			{ 'back', },
			{ 'back', },
			{ 'down' },
			{ 'down' },
			{ 'down',    'forward' },
			{ 'down',    'forward' },
			{ 'forward', 'a' },
			{ 'forward', 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Quarter circle Back Half circle Forward (214236)",
		times = 5,
		type = MOVE_TYPES.SUPER,
		button_editable = true
	},
	['QCF_QCF'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ 'down',    'forward' },
			{ 'down',    'forward' },
			{ 'forward' },
			{ 'forward' },
			{ 'down' },
			{ 'down' },
			{ 'down',    'forward' },
			{ 'down',    'forward' },
			{ 'forward', 'a' },
			{ 'forward', 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Quarter circle forward * 2 (236236)",
		times = 5,
		type = MOVE_TYPES.SUPER,
		button_editable = true
	},
	['QCF_HCB'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'down' },
			{ 'down' },
			{ 'down',   'forward' },
			{ 'down',   'forward' },
			{ 'forward' },
			{ 'forward' },
			{ 'down' },
			{ 'down' },
			{ 'down',   'back' },
			{ 'down',   'back' },
			{ 'back',   'a' },
			{ 'back',   'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "Quarter circle forward (236214)",
		times = 5,
		type = MOVE_TYPES.SUPER,
		button_editable = true
	},
	['PRETZEL'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '_' },
			{ '_' },
			{ 'down',   'back' },
			{ 'down',   'back' },
			{ 'forward' },
			{ 'forward' },
			{ 'down',   'forward' },
			{ 'down',   'forward' },
			{ 'down' },
			{ 'down' },
			{ 'down',   'back' },
			{ 'down',   'back' },
			{ 'back' },
			{ 'back' },
			{ 'back',   'a' },
			{ 'back',   'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "pretzel (1632143)",
		times = 5,
		type = MOVE_TYPES.SUPER,
		button_editable = true
	},
	['SJ_B'] = {
		sequence = {
			{ '-' },
			{ '-' },
			{ 'down' },
			{ 'down' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back' },
		},
		description = "super jump back",
		times = 5,
		type = MOVE_TYPES.COMMON,
	},
	['SJ_F'] = {
		sequence = {
			{ '-' },
			{ '-' },
			{ 'down' },
			{ 'down' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
		},
		description = "super jump forward",
		times = 5,
		type = MOVE_TYPES.COMMON,
	},
	['DSJ_F'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '-' },
			{ '-' },
			{ 'down' },
			{ 'down' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "super jump forward with a delayed button",
		times = 5,
		type = MOVE_TYPES.COMMON,
		button_editable = true
	},
	['HH_F'] = {
		sequence = {
			{ '-' },
			{ '-' },
			{ 'down' },
			{ 'down' },
			{ '-' },
			{ '-' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
		},
		description = "Hyper Hop forward",
		times = 5,
		type = MOVE_TYPES.COMMON,
	},
	['LONG_AB'] = {
		sequence = {
			{ '-' },
			{ '-' },
			{ 'forward' },
			{ 'forward' },
			{ '-' },
			{ '-' },
			{ 'forward', 'a', 'b' },
			{ 'forward', 'a', 'b' },
			{ 'a',       'b' },
			{ 'a',       'b' },
		},
		description = "longer AB",
		times = 5,
		type = MOVE_TYPES.COMMON,
	},
	['BACKDASH'] = {
		sequence = {
			{ '-' },
			{ '-' },
			{ 'back' },
			{ 'back' },
			{ '-' },
			{ '-' },
			{ 'back' },
			{ 'back' },
		},
		description = "longer AB",
		times = 5,
		type = MOVE_TYPES.COMMON,
	},
	['INS_SJ_B'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '-' },
			{ '-' },
			{ 'down' },
			{ 'down' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back', 'a' },
			{ 'up',  'back', 'a' },
			{ 'up',  'back', 'a' },
			{ 'up',  'back', 'a' },
			{ 'up',  'back', 'a' },
			{ 'up',  'back', 'a' },
		},
		description = "instant super jump back",
		times = 5,
		type = MOVE_TYPES.COMMON,
		button_editable = true
	},
	['DHJ_F'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '-' },
			{ '-' },
			{ 'down' },
			{ 'down' },
			{ '-' },
			{ '-' },
			{ 'up',  'forward' },
			{ 'up',  'forward' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "delayed hyper hop forward with button",
		times = 5,
		type = MOVE_TYPES.COMMON,
		button_editable = true
	},
	['DH_F'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '-' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ 'up', 'forward' },
			{ 'up', 'forward' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ 'a' },
			{ 'a' },
		},
		description = "hop forward with delayed  button",
		times = 5,
		type = MOVE_TYPES.COMMON,
		button_editable = true
	},
	['DNEUTRALH'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '-' },
			{ '-' },
			{ 'up' },
			{ 'up' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ 'a' },
			{ 'a' },
		},
		description = "neutral hop with delayed button",
		times = 5,
		type = MOVE_TYPES.COMMON,
		button_editable = true
	},
	['DNEUTRALJ'] = {
		wakeup_current_button = BUTTONS.A,
		guard_current_button = BUTTONS.A,
		hit_current_button = BUTTONS.A,
		sequence = {
			{ '-' },
			{ '-' },
			{ 'up' },
			{ 'up' },
			{ 'up' },
			{ 'up' },
			{ 'up' },
			{ 'up' },
			{ '-' },
			{ '-' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
			{ 'a' },
		},
		description = "neutral jump with delayed button",
		times = 5,
		type = MOVE_TYPES.COMMON,
		button_editable = true
	},
	['ALT_GUARD'] = {
		sequence = {
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'back' },
			{ 'back' },
			{ 'back' },
			{ 'back' },
			{ 'back' },
			{ 'back' },
		},
		description = "alternate guard",
		times = 5,
		type = MOVE_TYPES.COMMON,
		default = true
	},
	['STAND_A'] = {
		["sequence"] = {
			{ '_' },
			{ '_' },
			{ 'a' },
			{ 'a' },
		},
		times = 13,
		description = "down c",
	},
	['C_GUARD'] = {
		["sequence"] = {
			{ 'back', 'down' },
			{ 'back', 'down' },
			{ 'back', 'down' },
			{ 'back', 'down' },
			{ 'back', 'down' },

		},
		times = 10,
		description = "down c",
	},
	['ST_A'] = {
		["sequence"] = {
			{ '_' },
			{ '_' },
			{ 'a' },
			{ 'a' },
		},
		description = "standing A",
		type = MOVE_TYPES.NORMAL
	},
	['ST_B'] = {
		["sequence"] = {
			{ '_' },
			{ '_' },
			{ 'b' },
			{ 'b' },
		},
		description = "standing B",
		type = MOVE_TYPES.NORMAL
	},
	['ST_C'] = {
		["sequence"] = {
			{ '_' },
			{ '_' },
			{ 'c' },
			{ 'c' },
		},
		description = "standing C",
		type = MOVE_TYPES.NORMAL
	},
	['ST_D'] = {
		["sequence"] = {
			{ '_' },
			{ '_' },
			{ 'd' },
			{ 'd' },
		},
		description = "standing C",
		type = MOVE_TYPES.NORMAL
	},
	['CR_A'] = {
		["sequence"] = {
			{ 'down' },
			{ 'down' },
			{ 'down', 'a' },
			{ 'down', 'a' },
		},
		description = "crouching A",
		type = MOVE_TYPES.NORMAL
	},
	['CR_B'] = {
		["sequence"] = {
			{ 'down' },
			{ 'down' },
			{ 'down', 'b' },
			{ 'down', 'b' },
		},
		description = "crouching B",
		type = MOVE_TYPES.NORMAL
	},
	['CR_C'] = {
		["sequence"] = {
			{ 'down' },
			{ 'down' },
			{ 'down', 'c' },
			{ 'down', 'c' },
		},
		description = "crouching C",
		type = MOVE_TYPES.NORMAL
	},
	['CR_D'] = {
		["sequence"] = {
			{ 'down', },
			{ 'down', },
			{ 'down', 'd' },
			{ 'down', 'd' },
		},
		description = "crouching D",
		type = MOVE_TYPES.NORMAL
	},
	['FWD_A'] = {
		["sequence"] = {
			{ 'forward', },
			{ 'forward', },
			{ 'forward', 'a' },
			{ 'forward', 'a' },
		},
		description = "forward A",
		type = MOVE_TYPES.COMMAND_NORMAL
	},
	['FWD_B'] = {
		["sequence"] = {
			{ 'forward', },
			{ 'forward', },
			{ 'forward', 'b' },
			{ 'forward', 'b' },
		},
		description = "forward B",
		type = MOVE_TYPES.COMMAND_NORMAL
	},
	['BACK_A'] = {
		["sequence"] = {
			{ 'back', },
			{ 'back', },
			{ 'back', 'a' },
			{ 'back', 'a' },
		},
		description = "back A",
		type = MOVE_TYPES.COMMAND_NORMAL
	},
	['BACK_B'] = {
		["sequence"] = {
			{ 'back', },
			{ 'back', },
			{ 'back', 'b' },
			{ 'back', 'b' },
		},
		description = "back B",
		type = MOVE_TYPES.COMMAND_NORMAL
	},
	['DF_B'] = {
		["sequence"] = {
			{ 'down', 'forward' },
			{ 'down', 'forward' },
			{ 'down', 'forward', 'b' },
			{ 'down', 'forward', 'b' },
		},
		description = "back B",
		type = MOVE_TYPES.COMMAND_NORMAL
	},
	['DF_C'] = {
		["sequence"] = {
			{ 'down', 'forward' },
			{ 'down', 'forward' },
			{ 'down', 'forward', 'c' },
			{ 'down', 'forward', 'c' },
		},
		description = "back B",
		type = MOVE_TYPES.COMMAND_NORMAL
	},
	['DF_D'] = {
		["sequence"] = {
			{ 'down', 'forward' },
			{ 'down', 'forward' },
			{ 'down', 'forward', 'd' },
			{ 'down', 'forward', 'd' },
		},
		description = "back B",
		type = MOVE_TYPES.COMMAND_NORMAL
	},
	['CR_GUARD'] = {
		["sequence"] = {
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'down', 'back' },
			{ 'down', 'back' },
		},
		description = "crouching guard",
		type = MOVE_TYPES.COMMAND_NORMAL
	},
	['THROW_C'] = {
		["sequence"] = {
			{ 'forward' },
			{ 'forward' },
			{ 'forward', 'c' },
			{ 'forward', 'c' },
		},
		times = 10,
		description = "down c",
		type = MOVE_TYPES.NORMAL,
	},
	['CD'] = {
		["sequence"] = {
			{ '_' },
			{ '_' },
			{ 'c', 'd' }
		},
		times = 10,
		type = MOVE_TYPES.NORMAL,
		description = "CD",
	},
	['AB'] = {
		["sequence"] = {
			{ 'a', 'b' },
			{ 'a', 'b' },
			{ 'a', 'b' },
			{ 'a', 'b' }
		},
		times = 3,
		type = MOVE_TYPES.NORMAL,
		description = "AB",
	},
	['MASH_CRB'] = {
		["sequence"] = {
			{ 'down', 'b' },
			{ 'down', 'b' },
			{ 'down', 'b' },
			{ 'down', 'b' },
			{ 'down', 'b' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ '-' },
			{ '-' },
		},
		times = 17,
		description = "down c",
	},
	['SUPER_JUMP_BACK'] = {
		["sequence"] = {
			{ '-' },
			{ '-' },
			{ 'down' },
			{ 'down' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back' },
			{ 'up',  'back' },
		},
		times = 17,
		hidden = true,
		description = "down c",
	},
}

local movelist = ReversalList:new()
movelist:setReversals(moves)
KOF_CONFIG.REVERSAL_MOVES.MOVELIST = movelist
reversal_types = {
	GUARD = "GUARD",
	WAKEUP = "WAKEUP",
	HIT = "HIT"
}
local LOWERC_TYPES = {
	['GUARD'] = "guard",
	['WAKEUP'] = "wakeup",
	['HIT'] = "hit",
	['COMMAND_NORMAL'] = "command_normal",
	['SPECIAL'] = "special",
	['SUPER'] = "super",
	['NORMAL'] = "normal",
	['COMMON'] = "common",

}




-- Function to get the current button based on move_type
local function getCurrentButton(move, reversal_type)
	if reversal_type == reversal_types.WAKEUP then
		return move.wakeup_current_button
	elseif reversal_type == reversal_types.GUARD then
		return move.guard_current_button
	end
end

function getSequence(move, reversal_type)
	if (not move.button_editable) or (reversal_type == nil) then
		return move.sequence
	end
	local current_button = getCurrentButton(move, reversal_type)
	local new_sequence = {}

	for _, step in ipairs(move.sequence) do
		local new_step = {}
		for _, action in ipairs(step) do
			if (action == BUTTON_NAMES[BUTTONS.A] or action == BUTTON_NAMES[BUTTONS.B] or action == BUTTON_NAMES[BUTTONS.C] or action == BUTTON_NAMES[BUTTONS.D]) and action ~= BUTTON_NAMES[current_button] then
				table.insert(new_step, BUTTON_NAMES[current_button])
			else
				table.insert(new_step, action)
			end
		end
		table.insert(new_sequence, new_step)
	end
	return new_sequence
end

function getCustomPageNameByType(name, type)
	return LOWERC_TYPES[type] .. "_" .. name
end

local function fillVarNames(type)
	for key, item in pairs(moves) do
		if moves[key].default == true then
			table.insert(KOF_CONFIG.MOVES_VAR_NAMES[type], key)
			KOF_CONFIG.MOVES_VAR_NAMES[type][key] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON
		else
			table.insert(KOF_CONFIG.MOVES_VAR_NAMES[type], key)
			KOF_CONFIG.MOVES_VAR_NAMES[type][key] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF
		end
	end
end
-- Initialize Reversal Menu Tables (Moved from guipages.lua to ensure they exist before population)
guipages.guard_reversal_move_active_settings = {
	title = {
		text = "Guard Reversal Move Active Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(0, 1) end,
	},
}

guipages.hit_reversal_move_active_settings = {
	title = {
		text = "Hit Reversal Move Active Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(0, 1) end,
	},
}

guipages.wakeup_reversal_move_active_settings = {
	title = {
		text = "Wake UP Reversal Move Active Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(0, 1) end,
	},
}

--[[
CONFIG FOR GUARD REVERSALS
]]
fillVarNames(reversal_types.GUARD)

local GUARD_GUI = require "addon.kof_training.move_data.guard_gui"
-- added normal moves to default page
for key, item in pairs(GUARD_GUI.guard_normals) do
	table.insert(guipages.guard_reversal_move_active_settings, item)
end
local guard_command_normals_move_settings = {
	title = {
		text = "Guard Command Normals Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 2) end,
	},
}
guipages.guard_command_normals_move_settings = guard_command_normals_move_settings

for key, item in pairs(GUARD_GUI.guard_command_normals) do
	table.insert(guipages.guard_command_normals_move_settings, item)
end
--special moves
local guard_special_move_settings = {
	title = {
		text = "Guard Special Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.guard_specials_move_settings = guard_special_move_settings
for key, item in pairs(GUARD_GUI.guard_specials) do
	table.insert(guipages.guard_specials_move_settings, item)
end
--supers
local guard_super_move_settings = {
	title = {
		text = "Guard super Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.guard_supers_move_settings = guard_super_move_settings
for key, item in pairs(GUARD_GUI.guard_supers) do
	table.insert(guipages.guard_supers_move_settings, item)
end
--common
local guard_common_move_settings = {
	title = {
		text = "Guard common Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}

guipages.guard_commons_move_settings = guard_common_move_settings
for key, item in pairs(GUARD_GUI.guard_commons) do
	table.insert(guipages.guard_commons_move_settings, item)
end
--recordings
local guard_recordings_move_settings = {
	title = {
		text = "Guard recordings Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.guard_recordings_move_settings = guard_recordings_move_settings
for key, item in pairs(GUARD_GUI.guard_recordings) do
	table.insert(guipages.guard_recordings_move_settings, item)
end

--[[
CONFIG FOR WAKEUP REVERSALS
]]

fillVarNames(reversal_types.WAKEUP)
-- added normal moves to default page
local WAKEUP_GUI = require "addon.kof_training.move_data.wakeup_gui"

for key, item in pairs(WAKEUP_GUI.wakeup_normals) do
	table.insert(guipages.wakeup_reversal_move_active_settings, item)
end
local wakeup_command_normals_move_settings = {
	title = {
		text = "Wakeup Command Normals Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 2) end,
	},
}
guipages.wakeup_command_normals_move_settings = wakeup_command_normals_move_settings
for key, item in pairs(WAKEUP_GUI.wakeup_command_normals) do
	table.insert(guipages.wakeup_command_normals_move_settings, item)
end
--special moves
local wakeup_special_move_settings = {
	title = {
		text = "Wakeup Special Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.wakeup_specials_move_settings = wakeup_special_move_settings
for key, item in pairs(WAKEUP_GUI.wakeup_specials) do
	table.insert(guipages.wakeup_specials_move_settings, item)
end
--supers
local wakeup_super_move_settings = {
	title = {
		text = "Wakeup super Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.wakeup_supers_move_settings = wakeup_super_move_settings
for key, item in pairs(WAKEUP_GUI.wakeup_supers) do
	table.insert(guipages.wakeup_supers_move_settings, item)
end
--common

local wakeup_common_move_settings = {
	title = {
		text = "Wakeup common Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
--recordings
local wakeup_recordings_move_settings = {
	title = {
		text = "Wakeup recordings Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.wakeup_recordings_move_settings = wakeup_recordings_move_settings
for key, item in pairs(WAKEUP_GUI.wakeup_recordings) do
	table.insert(guipages.wakeup_recordings_move_settings, item)
end
guipages.wakeup_commons_move_settings = wakeup_common_move_settings
for key, item in pairs(WAKEUP_GUI.wakeup_commons) do
	table.insert(guipages.wakeup_commons_move_settings, item)
end
-- HIT Reversarls ---

--[[
CONFIG FOR HIT REVERSALS
]]

fillVarNames(reversal_types.HIT)
-- added normal moves to default page
local HIT_GUI = require "addon.kof_training.move_data.hit_gui"

for key, item in pairs(HIT_GUI.hit_normals) do
	table.insert(guipages.hit_reversal_move_active_settings, item)
end
local hit_command_normals_move_settings = {
	title = {
		text = "Hit Command Normals Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 2) end,
	},
}
guipages.hit_command_normals_move_settings = hit_command_normals_move_settings
for key, item in pairs(HIT_GUI.hit_command_normals) do
	table.insert(guipages.hit_command_normals_move_settings, item)
end
--special moves
local hit_special_move_settings = {
	title = {
		text = "Hit Special Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.hit_specials_move_settings = hit_special_move_settings
for key, item in pairs(HIT_GUI.hit_specials) do
	table.insert(guipages.hit_specials_move_settings, item)
end
--supers
local hit_super_move_settings = {
	title = {
		text = "Hit super Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.hit_supers_move_settings = hit_super_move_settings
for key, item in pairs(HIT_GUI.hit_supers) do
	table.insert(guipages.hit_supers_move_settings, item)
end
--common

local hit_common_move_settings = {
	title = {
		text = "Hit common Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
--recordings
local hit_recordings_move_settings = {
	title = {
		text = "Hit recordings Move  Settings",
		x = interactivegui.boxxlength / 2 - 40,
		y = 1,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func = function() CIG(interactivegui.previouspage, 1) end,
	},
}
guipages.hit_recordings_move_settings = hit_recordings_move_settings
for key, item in pairs(HIT_GUI.hit_recordings) do
	table.insert(guipages.hit_recordings_move_settings, item)
end
guipages.hit_commons_move_settings = hit_common_move_settings
for key, item in pairs(HIT_GUI.hit_commons) do
	table.insert(guipages.hit_commons_move_settings, item)
end

-- Function to get the index from the value
function getIndexFromConfigValue(value)
	for index, confValue in pairs(KOF_CONFIG.TRAINING.CONFIGURATIONS) do
		if confValue == value then
			return index
		end
	end
	return nil -- Value not found
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
KOF_CONFIG.HIT.reversal_moves = getCurrentReversalMoves(reversal_types.HIT)


function deactivateAllDefaultMoves()
	for index, value in pairs(KOF_CONFIG.MOVES_VAR_NAMES[reversal_types.GUARD]) do
		KOF_CONFIG.MOVES_VAR_NAMES[reversal_types.GUARD][index] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF
	end


	for index, value in pairs(KOF_CONFIG.MOVES_VAR_NAMES[reversal_types.WAKEUP]) do
		KOF_CONFIG.MOVES_VAR_NAMES[reversal_types.WAKEUP][index] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.OFF
	end

	KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.GUARD)
	KOF_CONFIG.GUARD.reversal_moves  = getCurrentReversalMoves(reversal_types.WAKEUP)
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

local function enableReversalMove(move_name, type)
	KOF_CONFIG.MOVES_VAR_NAMES[type][move_name] = KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON
end
-- Function to set default configuration based on configName
function setDefaultConfig(configName)
	resetAllConfiguration()

	if configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["None"] then
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
		local move_name = "DP"
		moves[move_name].wakeup_current_button = BUTTONS.C
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 1
		enableReversalMove(move_name, reversal_types.WAKEUP)
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.WAKEUP)
		printTable(KOF_CONFIG.WAKEUP.reversal_moves)
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
		local move_name = "DP"
		moves[move_name].wakeup_current_button = BUTTONS.C
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 1

		enableReversalMove(move_name, reversal_types.WAKEUP)
		-- activate cr guard on wakeup
		local move_name = "CR_GUARD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 30

		enableReversalMove(move_name, reversal_types.WAKEUP)
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.WAKEUP)
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
		local move_name = "DP"
		moves[move_name].wakeup_current_button = BUTTONS.C
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 1

		enableReversalMove(move_name, reversal_types.WAKEUP)
		-- activate cr guard on wakeup
		local move_name = "CR_GUARD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 0
		current_reversal_move.on_wake_up_times = 5

		enableReversalMove(move_name, reversal_types.WAKEUP)
		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves     = getCurrentReversalMoves(reversal_types.WAKEUP)
		--activate guard reversal
		KOF_CONFIG.GUARD.dummy_guarding      = true
		KOF_CONFIG.GUARD.reversal            = KOF_CONFIG.GUARD.REVERSAL_OPTIONS.ON
		--activate crouch guard
		KOF_CONFIG.GUARD.crouch_guard        = 1
		-- activate guard random
		KOF_CONFIG.GUARD.random_guard        = 1
		-- activate throw C on guard
		local move_name                      = "THROW_C"
		local current_reversal_move          = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_guard_delay = 10
		current_reversal_move.on_guard_times = 5

		enableReversalMove(move_name, reversal_types.GUARD)
		-- reload reversal moves
		KOF_CONFIG.GUARD.reversal_moves = getCurrentReversalMoves(reversal_types.GUARD)
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
		enableReversalMove(move_name, reversal_types.GUARD)

		-- reload reversal moves
		KOF_CONFIG.GUARD.reversal_moves = getCurrentReversalMoves(reversal_types.GUARD)
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
		enableReversalMove(move_name, reversal_types.GUARD)

		-- reload reversal moves
		KOF_CONFIG.GUARD.reversal_moves = getCurrentReversalMoves(reversal_types.GUARD)
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["high_confirm_against_CDA"] then
		--activate guard reversal
		KOF_CONFIG.GUARD.dummy_guarding = true
		KOF_CONFIG.GUARD.reversal = KOF_CONFIG.GUARD.REVERSAL_OPTIONS.RANDOM
		--activate crouch guard
		KOF_CONFIG.GUARD.standing_guard = 1
		-- activate guard random
		KOF_CONFIG.GUARD.random_guard = 1
		-- activate throw C on guard
		local move_name = "CR_GUARD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_guard_delay = 0
		current_reversal_move.on_guard_times = 10
		enableReversalMove(move_name, reversal_types.GUARD)
		enableReversalMove(move_name, reversal_types.GUARD)

		-- activate CD on guard
		local move_name = "CD"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_guard_delay = 0
		current_reversal_move.on_guard_times = 3
		enableReversalMove(move_name, reversal_types.GUARD)
		enableReversalMove(move_name, reversal_types.GUARD)

		-- reload reversal moves
		KOF_CONFIG.GUARD.reversal_moves = getCurrentReversalMoves(reversal_types.GUARD)
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["wakeup_whiff_cr_c"] then
		--activate crouch guard
		KOF_CONFIG.GUARD.dummy_guarding = true
		KOF_CONFIG.GUARD.crouch_guard = 1
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
		KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON
		-- activate dp on wakeup
		local move_name = "CR_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 40
		current_reversal_move.on_wake_up_times = 2
		enableReversalMove(move_name, reversal_types.WAKEUP)

		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.WAKEUP)
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["wakeup_dpc"] then
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
		KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.ON
		-- activate dp on wakeup
		local move_name = "DP"
		moves[move_name].wakeup_current_button = BUTTONS.C
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 1
		enableReversalMove(move_name, reversal_types.WAKEUP)

		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.WAKEUP)
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["shimmy_wakeup"] then
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
		KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		-- activate dp on wakeup
		local move_name = "DP"
		moves[move_name].wakeup_current_button = BUTTONS.C
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 1
		enableReversalMove(move_name, reversal_types.WAKEUP)

		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 35
		current_reversal_move.on_wake_up_times = 5
		enableReversalMove(move_name, reversal_types.WAKEUP)

		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.WAKEUP)
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["wakeup_delay_OS_basic"] then
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
		KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		-- activate dp on wakeup
		local move_name = "DP"
		moves[move_name].wakeup_current_button = BUTTONS.C
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 1
		enableReversalMove(move_name, reversal_types.WAKEUP)

		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 35
		current_reversal_move.on_wake_up_times = 5
		enableReversalMove(move_name, reversal_types.WAKEUP)

		local move_name = "CR_B"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 35
		current_reversal_move.on_wake_up_times = 3
		enableReversalMove(move_name, reversal_types.WAKEUP)

		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.WAKEUP)
	elseif configName == KOF_CONFIG.TRAINING.CONFIGURATIONS["wakeup_delay_OS_full"] then
		--activate wake up random
		KOF_CONFIG.WAKEUP.dummy_waking_up = true
		KOF_CONFIG.WAKEUP.reversal = KOF_CONFIG.WAKEUP.REVERSAL_OPTIONS.RANDOM
		-- activate dp on wakeup
		local move_name = "DP"
		moves[move_name].wakeup_current_button = BUTTONS.C
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 1
		enableReversalMove(move_name, reversal_types.WAKEUP)

		local move_name = "THROW_C"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 35
		current_reversal_move.on_wake_up_times = 5
		enableReversalMove(move_name, reversal_types.WAKEUP)

		local move_name = "CR_B"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 25
		current_reversal_move.on_wake_up_times = 6
		enableReversalMove(move_name, reversal_types.WAKEUP)

		local move_name = "AB"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 39
		current_reversal_move.on_wake_up_times = 1
		enableReversalMove(move_name, reversal_types.WAKEUP)

		local move_name = "SJ_B"
		local current_reversal_move = KOF_CONFIG.REVERSAL_MOVES.MOVELIST:getReversal(move_name)
		current_reversal_move.on_wake_up_delay = 36
		current_reversal_move.on_wake_up_times = 1
		enableReversalMove(move_name, reversal_types.WAKEUP)

		-- reload reversal moves
		KOF_CONFIG.WAKEUP.reversal_moves = getCurrentReversalMoves(reversal_types.WAKEUP)
	else
		print("Unknown configuration:", configName)
	end
end
