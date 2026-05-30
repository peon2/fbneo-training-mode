assert(rb,"Run fbneo-training-mode.lua")

----------------------------------------------
-- EXPOSED CONFIG VALUES
----------------------------------------------

-- Global vars the configs are mirrored in
combovars = {
	P1 = {
		healthdiff = 0,
		previousdamage = 0,
		combo = 0,
		previouscombo = 0,
		displaycombo = 0,
		comboDamage = 0,
		refillhealth = 0,
		refillmeter = 0,
	},
	P2 = {
		healthdiff = 0,
		previousdamage = 0,
		combo = 0,
		previouscombo = 0,
		displaycombo = 0,
		comboDamage = 0,
		refillhealth = 0,
		refillmeter = 0,
	},

}

hud = { health = { P1 = { }, P2 = { } }, meter = { P1 = { }, P2 = { } }, combotext = { }, kb = { }, fillbar = { } }

inputs = {
	properties = {
		simple = { P1 = {}, P2 = {} },
		scrolling = { P1 = {}, P2 = {} },
		kb = { },
		enableinputswap = false,
		holddirection = nil,
	},
	hotkeys = {
		hotkeyin = false,
		funcs = {},
	},
	P1 = {},
	P2 = {},
	other = {},
	setinputs = {},
}

hitboxes = { }

recording = {
	recordingslot = 1,
	hitslot,
	savestateslot,
	blockslot,
	editframe,
	swapplayers = true,
	replayP1 = false,
	replayP2 = true,
	delay = 0,
	starttime = 0,
	startcounter = 0,
	config = {
		P1 = {},
		P2 = {},
		type = "recordingconfig"
	}
}

for i = 1, REPLAY_SLOTS_COUNT do
	recording[i] = {}
end

interactivegui = {
	enabled = false,
	inmenu = false,
	page = 1, -- these should be numbers referencing guipages
	selection = 3,
	sw = emu.screenwidth(),
	sh = emu.screenheight(),
	background = {},
	movehud = {enabled = false, selected = false, selection = 1},
	replayeditor = {inputs = {}},
}

colour = { P1 = {}, P2 = {} }

gamevars = {
	P1 = {
		inhitstun = false,
		health = 0,
		previoushealth = 0,
		meter = 0,
		constants = {},
	},
	P2 = {
		inhitstun = false,
		health = 0,
		meter = 0,
		previoushealth = 0,
		constants = {},
	},
	constants = {},
}

----------------------------------------------
-- CONFIG INIT
----------------------------------------------

local config = {
	gamevars = { P1 = { }, P2 = { } },
	combovars = { P1 = { }, P2 = { } },
	hud = { health = { P1 = { }, P2 = { } }, meter = { P1 = { }, P2 = { } }, combotext = { }, kb = { } },
	inputs = { simple = { P1 = { }, P2 = { } }, scrolling = { P1 = { }, P2 = { } } },
	hitboxes = { },
	interactivegui = { },
	colour = { },
	recording = { }
}

local generalconfig = {
	path = "config/generalsettings.config"
}

local colourconfig = {
	P1 = {},
	P2 = {},
	hud = { combotext = {}, fillbar = {} },
	background = {},
	path = "config/colour.config"
}

--[[
	"config" -> General config, stored on a rom by rom basis. Nearly everything should go in here.
	"colourconfig" -> Global config, should only be used to store colours.
	"recordingconfig" -> Localised config for replaypacks, write to this if you want to save configs to be loaded with a replaypack.
--]]
local validconfigs = {
	config = config,
	generalconfig = generalconfig,
	colourconfig = colourconfig,
	recordingconfig = recording.config
}
-- Reserved values used by the training mode in config tables. These values shouldn't be saved to disk	
local configmarkers = {
	configstr = true
}

local configitems -- forward declaration

----------------------------------------------
-- NON-EXPOSED CONFIG FUNCTIONS
----------------------------------------------

--[[
	Expensive function.
	Recursively copies all values from table src to table dst, without changing dst tables.
	Triggers Assertion failure with table location name if the dst doesn't have a matching table.
	Call this WITHOUT the third argument given
--]]
local function deepAppendCopy(src, dst, isrecursive)
	if type(src) ~= "table" then return end
	for i, v in pairs(src) do
		if type(v) == "table" then
			if dst[i] == nil then -- this should never happen
				return i
			end
			local ret = deepAppendCopy(v, dst[i], true)
			if ret then
				local tablename = i.."."..ret
				if isrecursive then
					return tablename
				else
					assert(nil, "Table: '"..tablename.."' doesn't exist and cannot be appended to.")
				end
			end
		else
			dst[i] = v
		end
	end
end

--[[
	Expensive function.
	The same as deepAppendCopy, but if an uninitialised table is encountered, it is forceably copied over.
	Call this WITHOUT the third argument given.
--]]
local function unsafeDeepAppendCopy(src, dst, isrecursive)
	if type(src) ~= "table" then return end
	for i, v in pairs(src) do
		if type(v) == "table" then
			if dst[i] == nil then
				dst[i] = {}
			end
			local ret = unsafeDeepAppendCopy(v, dst[i], true)
			if ret then
				local tablename = i.."."..ret
				if isrecursive then
					return tablename
				else
					assert(nil, "Table: '"..tablename.."' doesn't exist and cannot be appended to.")
				end
			end
		else
			dst[i] = v
		end
	end
end

local function updateDefaultConfig(id)
	local configitem = configitems[id]
	local name = configitem.name
	if configitem.configpointer[name] ~= nil then
		configitem.default = configitem.configpointer[name]
	end
end

local function copyConfigValuesToVar(id)
	local configitem = configitems[id]
	local name = configitem.name
	configitem.varpointer[name] = configitem.configpointer[name]
end

-- Assign configstr recursively, assume no bi-lateral links
local function assignConfigStr(t, configstr)
	t.configstr = configstr
	for _, v in pairs(t) do
		if type(v) == "table" then
			assignConfigStr(v, configstr)
		end
	end
end

----------------------------------------------
-- EXPOSED CONFIG FUNCTIONS
----------------------------------------------

--[[
	This function will initialise the table given and all it's subtables for output with the config decided by configstr.

	tablename -> The unique name associated with this config table.
		For user config values, it's recommended to name this the romname.
	t -> The table to act as the config table.
		For user config values, it's recommended to create this table as a local.
		N.B. every subtable you will need in this table should be already initialised.
	configstr -> Which config, to be written to disc, this config should be associated with.
		See validconfigs for the list of strings this can be.
	
	See redearth as an example.
--]]
function initConfigTable(tablename, t, configstr)
	assert(type(tablename)=="string", "Table Name must be a string")
	assert(type(t)=="table", "Argument 2 should be the table")
	assert(validconfigs[configstr], configstr.." is not a valid config")
	
	assignConfigStr(t, configstr)
	validconfigs[configstr][tablename] = t
end

--[[
	Call this if a Config Table is created outside of a game script startup.
	If the table cannot be found in the config, a new table is created.
	Use initConfigTable instead if possible.
	If you need to use getConfigTable, you probably need to use initConfigItem too.
	
	See the mute addon as an example.
--]]
function getConfigTable(tablename, configstr)
	assert(type(tablename)=="string", "Table Name must be a string")
	assert(validconfigs[configstr], configstr.." is not a valid config")
	local t = {}
	if config[tablename] then
		unsafeDeepAppendCopy(config[tablename], t)
	end
	initConfigTable(tablename, t, configstr)
	return t
end

--[[
	This function will create a config item using the arguments given in the configpointer and varpointer tables given.

	configname -> The unique name associated with this config option, used to get this config and write to it.
		For user config values, it's recommended to preface with romname to avoid collisions.
	default -> Default value of the config. Whenever the config is updated, the type of the new value will be matched against the type of the default value.
	configpointer -> The table to be written to disk when the script closes.
	internalname -> The name of the value in the config table.
		For user config values, it's recommended to use the configname minus the romname.
	*varpointer -> The table that should be read and written to while the script is active.
		For user config values, it's recommended to leave this argument nil, to default configpointer and varpointer to the same table.
	*displayname -> If this config is displayed to the user, what should it show.
	
	*: Optional.
	
	See sfiii3 as an example.
--]]
function createConfigItem(configname, default, configpointer, internalname, varpointer, displayname)
	assert(type(configname)=="string", "Config Name must be a string")
	assert(not (configitems[configname] and configitems[configname].name), "Config item "..configname.." already exists.")
	assert(default~=nil, configname..": Default must have a value.")
	assert(type(configpointer)=="table", configname..": Config Pointer must be a table.")
	local configstr = configpointer.configstr
	assert(validconfigs[configstr], configname..": Config Pointer is not initialised. Call initConfigTable.")
	assert(type(internalname)=="string", configname..": Internal Name must be a string.")
	assert(configmarkers[internalname]==nil, configname..": Internal Name: '"..internalname.."' matches a reserved string, use a different string.")
	if varpointer == nil then varpointer = configpointer end
	assert(type(varpointer)=="table", configname..": Var Pointer must be a table.")
	assert(type(displayname)=="string" or displayname==nil, configname..": Display Name must be a string.")
	
	local value
	
	if configitems[configname] then
		value = configitems[configname].default
	else
		value = default
	end
	
	configitems[configname] = {
		name = internalname,
		default = default,
		configpointer = configpointer,
		varpointer = varpointer,
		config = validconfigs[configstr],
		displayname = displayname
	}
	
	configitems[configname].configpointer[configitems[configname].name] = value
	configitems[configname].varpointer[configitems[configname].name] = value
end

--[[
	Call this if a config item is created after the game luas are loaded.
	
	See the mute addon as an example.
--]]
function initConfigItem(configname)
	assert(type(configname)=="string", "Config Name must be a string")
	assert(configitems[configname], "Cannot find configname: '"..configname)
	local configitem = configitems[configname]
	local name = configitem.name
	local default = configitem.default
	if configitem.configpointer[name]==nil then
		configitem.configpointer[name] = default
	end
	if configitem.varpointer[name]==nil then
		configitem.varpointer[name] = default
	end
end

function getConfigItemsFiltered(filter) -- returns configitems by comparing the start of their names against a filter
	assert(type(filter)=="string", "Filter should be of type string.")
	local newconfigitems = {}
	local len = #filter
	for id, configitem in pairs(configitems) do
		if filter == id:sub(1, len) then
			newconfigitems[id] = {}
			newconfigitems[id].name = configitem.name
			newconfigitems[id].default = configitem.default
			newconfigitems[id].varpointer = configitem.varpointer
			newconfigitems[id].displayname = configitem.displayname
		end
	end
	return newconfigitems
end

function getConfigValue(id)
	assert(configitems[id], "Config Item: '"..id.."' does not exist.")
	local configitem = configitems[id]
	local name = configitem.name
	return configitem.configpointer[name], configitem.varpointer[name], configitem.default
end

function changeConfig(id, value, updatevar)
	assert(id, "Attempt to write value: '"..tostring(value).."' to nil.")
	assert(configitems[id], "Config Item: '"..id.."' does not exist.")
	assert(value~=nil, "Attempt to write nil to '"..id.."'")
	if updatevar == nil then updatevar = true end
	local configitem = configitems[id]
	local name = configitem.name
	assert(
		type(value) == type(configitem.default),
		id..": Bad value: "..tostring(value).." doesn't match the type of default value: "..tostring(configitem.default)
	)
	configitem.configpointer[name] = value
	if updatevar then
		configitem.varpointer[name] = value
	end
	configitem.config.changed = true
end

function setConfigDefault(id, default)
	assert(id, "Attempt to write value: "..tostring(default).." to nil.")
	assert(default~=nil, "Attempt to write nil to "..id)
	local configitem = configitems[id]
	assert(
		type(default) == type(configitem.default),
		"Bad value: "..tostring(default).." doesn't match the type of the previous default value: "..tostring(configitem.default)
	)
	configitem.default = default
end

function resetConfig(id)
	assert(id, "Attempt to reset a nil config item.")
	assert(configitems[id], "Config Item: '"..id.."' does not exist.")
	local configitem = configitems[id]
	local changed = configitem.config.changed -- remember status
	local value = configitem.varpointer[configitem.name]
	changeConfig(id, configitem.default, true)
	if value == configitem.varpointer[configitem.name] then -- if the value hasn't changed, keep the old status
		configitem.config.changed = changed
	end
end
--[[
	Should only be called by replayLoad()
--]]
function updateReplayConfig(_replayconfig)
	for i, v in pairs(_replayconfig) do
		recording.config[i] = v
	end
	for id, _ in pairs(getConfigItemsFiltered("recording")) do
		copyConfigValuesToVar(id)
	end
end

function markConfigsUnchanged()
	for _,v in pairs(validconfigs) do
		v.changed = false
	end
end

--[[
	Save Config Values
--]]

local function saveGameConfigValues()
	if not config.changed then return end -- only saves if the config has changed
	config.changed = false
	local save = {}
	for k, configitem in pairs(configitems) do
		if configitem.config == config and configitem.configpointer[configitem.name] ~= configitem.default then
			save[k] = configitem.configpointer[configitem.name]
		end
	end
	
	write("Saving config: " .. configpath)
	saveTableToFile({type = "gameconfig", version = FBNEO_TRAINING_MODE_VERSION}, save, configpath)
end
local function saveGeneralConfigValues()
	if not generalconfig.changed then return end -- only saves if the config has changed
	generalconfig.changed = false
	local save = {}
	for k, configitem in pairs(configitems) do
		if configitem.config == generalconfig and configitem.configpointer[configitem.name] ~= configitem.default then
			save[k] = configitem.configpointer[configitem.name]
		end
	end
	
	write("Saving general config: "..generalconfig.path)
	saveTableToFile({type = "generalconfig", version = FBNEO_TRAINING_MODE_VERSION}, save, generalconfig.path)
end
local function saveColourConfigValues()
	if not colourconfig.changed then return end -- only saves if the config has changed
	colourconfig.changed = false
	local save = {}
	for k, configitem in pairs(configitems) do
		if configitem.config == colourconfig and configitem.configpointer[configitem.name] ~= configitem.default then
			save[k] = configitem.configpointer[configitem.name]
		end
	end
	
	write("Saving colour config: "..colourconfig.path)
	saveTableToFile({type = "colourconfig", version = FBNEO_TRAINING_MODE_VERSION}, save, colourconfig.path)
end

function saveAllConfig()
	saveGameConfigValues()
	saveGeneralConfigValues()
	saveColourConfigValues()
end

----------------------------------------------
-- Hierarchy: 
--	-> SAVED CONFIG
--		-> GAME'S DEFAULT CONFIG
--			-> GENERAL DEFAULT CONFIG
----------------------------------------------
function loadSavedConfig() -- This should only need to be called once by fbneo-training-mode.lua
	if not gamedefaultconfig then -- comes from game luas
		write "Game default config not found."
	else
		deepAppendCopy(gamedefaultconfig, config)
		for configitemid, _ in pairs(configitems) do -- update the default values and populate the config table with those values
			updateDefaultConfig(configitemid)
			resetConfig(configitemid)
		end
	end

	if fexists(configpath) then
		local metadata = loadMetaDataFromFile(configpath)
		if not metadata then
			write("Can't read config file found for "..gamename..", using default config.")
		elseif metadata.type ~= "gameconfig" then -- if the file is loaded, make sure the contents are at least superficially correct
			write("Can't read config file found for "..gamename..", bad format.")
		else
			for configitemid, value in pairs(loadDataFromFile(configpath)) do
				if configitems[configitemid] then
					changeConfig(configitemid, value)
				else
					configitems[configitemid] = {
						name = nil,
						default = value,
						configpointer = config,
						varpointer = nil,
						config = nil,
					}
				end
			end
		end
	end

	if fexists(generalconfig.path) then
		local metadata = loadMetaDataFromFile(generalconfig.path)
		if not metadata then
			write("Can't read general config, using default general config.")
		elseif metadata.type ~= "generalconfig" then
			write("Can't read general config file found, bad format.")
		else -- if the file is loaded, make sure the contents are at least superficially correct
			for configitemid, value in pairs(loadDataFromFile(generalconfig.path)) do
				if configitems[configitemid] then
					changeConfig(configitemid, value)
				else
					configitems[configitemid] = {
						name = nil,
						default = value,
						configpointer = generalconfig,
						varpointer = nil,
						config = nil,
					}
				end
			end
		end
	end

	if fexists(colourconfig.path) then
		local metadata = loadMetaDataFromFile(colourconfig.path)
		if not metadata then
			write("Can't read colour config, using colour general config.")
		elseif metadata.type ~= "colourconfig" then
			write("Can't read colour config file found, bad format.")
		else -- if the file is loaded, make sure the contents are at least superficially correct
			for configitemid, value in pairs(loadDataFromFile(colourconfig.path)) do
				if configitems[configitemid] then
					changeConfig(configitemid, value)
				else
					configitems[configitemid] = {
						name = nil,
						default = value,
						configpointer = generalconfig,
						varpointer = nil,
						config = nil,
					}
				end
			end
		end
	end
	config.changed = nil
	generalconfig.changed = nil
	colourconfig.changed = nil

	-- populate the vars tables with values, if applicable
	for id, configitem in pairs(configitems) do
		if configitem.varpointer then
			local name = configitem.name
			if not configitem.varpointer then configitem.varpointer={} end
			configitem.varpointer[name] = configitem.configpointer[name]
		end
	end
end

-- config items to show the relationship between configs and vars
configitems = {
--[[
	id = {
		name 			-> the name of the config in the configpointer or varpointer
		default			-> the default value of the configitem, also is used for typechecking
		configpointer	-> the table the config value is stored in (private)
		varpointer		-> the (option) table the variable value is stored in (public)
		config			-> the top level of the configpointer
		displayname		-> used for user-facing text
	}
--]]
--------- GAMEVARS ----------
	p1maxhealth = {
		name = "maxhealth",
		default = 1,
		configpointer = config.gamevars.P1,
		varpointer = gamevars.P1,
		config = config,
	},
	p2maxhealth = {
		name = "maxhealth",
		default = 1,
		configpointer = config.gamevars.P2,
		varpointer = gamevars.P2,
		config = config,
	},
	p1maxmeter = {
		name = "maxmeter",
		default = 0,
		configpointer = config.gamevars.P1,
		varpointer = gamevars.P1,
		config = config,
	},
	p2maxmeter = {
		name = "maxmeter",
		default = 0,
		configpointer = config.gamevars.P2,
		varpointer = gamevars.P2,
		config = config,
	},
--------- COMBOVARS ---------
	p1refillhealthspeed = {
		name = "refillhealthspeed",
		default = 10,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2refillhealthspeed = {
		name = "refillhealthspeed",
		default = 10,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1instantrefillhealth = {
		name = "instantrefillhealth",
		default = false,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2instantrefillhealth = {
		name = "instantrefillhealth",
		default = false,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1refillhealthenabled = {
		name = "refillhealthenabled",
		default = false,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2refillhealthenabled = {
		name = "refillhealthenabled",
		default = false,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1refillmeterspeed = {
		name = "refillmeterspeed",
		default = 10,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2refillmeterspeed = {
		name = "refillmeterspeed",
		default = 10,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1instantrefillmeter = {
		name = "instantrefillmeter",
		default = false,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2instantrefillmeter = {
		name = "instantrefillmeter",
		default = false,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1refillmeterenabled = {
		name = "refillmeterenabled",
		default = true,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2refillmeterenabled = {
		name = "refillmeterenabled",
		default = true,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
--------- HUD ---------
	p1healthx = {
		name = "x",
		default = 10,
		configpointer = config.hud.health.P1,
		varpointer = hud.health.P1,
		config = config,
	},
	p2healthx = {
		name = "x",
		default = 180,
		configpointer = config.hud.health.P2,
		varpointer = hud.health.P2,
		config = config,
	},
	p1healthy = {
		name = "y",
		default = 10,
		configpointer = config.hud.health.P1,
		varpointer = hud.health.P1,
		config = config,
	},
	p2healthy = {
		name = "y",
		default = 10,
		configpointer = config.hud.health.P2,
		varpointer = hud.health.P2,
		config = config,
	},
	p1healthtextcolour = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = config.hud.health.P1,
		varpointer = hud.health.P1,
		config = config,
	},
	p2healthtextcolour = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = config.hud.health.P2,
		varpointer = hud.health.P2,
		config = config,
	},
	p1healthenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.health.P1,
		varpointer = hud.health.P1,
		config = config,
	},
	p2healthenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.health.P2,
		varpointer = hud.health.P2,
		config = config,
	},
	p1meterx = {
		name = "x",
		default = 10,
		configpointer = config.hud.meter.P1,
		varpointer = hud.meter.P1,
		config = config,
	},
	p2meterx = {
		name = "x",
		default = 180,
		configpointer = config.hud.meter.P2,
		varpointer = hud.meter.P2,
		config = config,
	},
	p1metery = {
		name = "y",
		default = 100,
		configpointer = config.hud.meter.P1,
		varpointer = hud.meter.P1,
		config = config,
	},
	p2metery = {
		name = "y",
		default = 100,
		configpointer = config.hud.meter.P2,
		varpointer = hud.meter.P2,
		config = config,
	},
	p1metertextcolour = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = config.hud.meter.P1,
		varpointer = hud.meter.P1,
		config = config,
	},
	p2metertextcolour = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = config.hud.meter.P2,
		varpointer = hud.meter.P2,
		config = config,
	},
	p1meterenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.meter.P1,
		varpointer = hud.meter.P1,
		config = config,
	},
	p2meterenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.meter.P2,
		varpointer = hud.meter.P2,
		config = config,
	},
	combotextenabled = {
		name = "enabled",
		default = true,
		configpointer = config.hud.combotext,
		varpointer = hud.combotext,
		config = config,
	},
	combotextx = {
		name = "x",
		default = emu.screenwidth()/2-#"Combo: 00"*LETTER_HALFWIDTH,
		configpointer = config.hud.combotext,
		varpointer = hud.combotext,
		config = config,
	},
	combotexty = {
		name = "y",
		default = 42,
		configpointer = config.hud.combotext,
		varpointer = hud.combotext,
		config = config,
	},
	kbenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.kb,
		varpointer = hud.kb,
		config = config,
	},
	kbx = {
		name = "x",
		default = 0,
		configpointer = config.hud.kb,
		varpointer = hud.kb,
		config = config,
	},
	kby = {
		name = "y",
		default = 0,
		configpointer = config.hud.kb,
		varpointer = hud.kb,
		config = config,
	},
--------- INPUTS ---------
	simpleinputenabledp1 = {
		name = "enabled",
		default = true,
		configpointer = config.inputs.simple.P1,
		varpointer = inputs.properties.simple.P1,
		config = config,
	},
	simpleinputenabledp2 = {
		name = "enabled",
		default = true,
		configpointer = config.inputs.simple.P2,
		varpointer = inputs.properties.simple.P2,
		config = config,
	},
	simpleinputxp1 = {
		name = "x",
		default = -1,
		configpointer = config.inputs.simple.P1,
		varpointer = inputs.properties.simple.P1,
		config = config,
	},
	simpleinputxp2 = {
		name = "x",
		default = -1,
		configpointer = config.inputs.simple.P2,
		varpointer = inputs.properties.simple.P2,
		config = config,
	},
	simpleinputyp1 = {
		name = "y",
		default = -1,
		configpointer = config.inputs.simple.P1,
		varpointer = inputs.properties.simple.P1,
		config = config,
	},
	simpleinputyp2 = {
		name = "y",
		default = -1,
		configpointer = config.inputs.simple.P2,
		varpointer = inputs.properties.simple.P2,
		config = config,
	},
	scrollinginputenabledp1 = {
		name = "enabled",
		default = true,
		configpointer = config.inputs.scrolling.P1,
		varpointer = inputs.properties.scrolling.P1,
		config = config,
	},
	scrollinginputenabledp2 = {
		name = "enabled",
		default = true,
		configpointer = config.inputs.scrolling.P2,
		varpointer = inputs.properties.scrolling.P2,
		config = config,
	},
	scrollinginputxp1 = {
		name = "x",
		default = -1,
		configpointer = config.inputs.scrolling.P1,
		varpointer = inputs.properties.scrolling.P1,
		config = config,
	},
	scrollinginputxp2 = {
		name = "x",
		default = -1,
		configpointer = config.inputs.scrolling.P2,
		varpointer = inputs.properties.scrolling.P2,
		config = config,
	},
	scrollinginputyp1 = {
		name = "y",
		default = -1,
		configpointer = config.inputs.scrolling.P1,
		varpointer = inputs.properties.scrolling.P1,
		config = config,
	},
	scrollinginputyp2 = {
		name = "y",
		default = -1,
		configpointer = config.inputs.scrolling.P2,
		varpointer = inputs.properties.scrolling.P2,
		config = config,
	},
	scrollinginputiconsize = {
		name = "iconsize",
		default = 10,
		configpointer = config.inputs.scrolling,
		varpointer = inputs.properties.scrolling,
		config = config,
	},
	scrollinginputframes = {
		name = "framesenabled",
		default = false,
		configpointer = config.inputs.scrolling,
		varpointer = inputs.properties.scrolling,
		config = config,
	},
--------- GUI ---------
	guiboxxd = {
		name = "boxxd",
		default = 8,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guiboxxm = {
		name = "boxxm",
		default = 7,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guiboxyd = {
		name = "boxyd",
		default = 10,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guiboxym = {
		name = "boxym",
		default = 9,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guicoinleniency = {
		name = "coinleniency",
		default = 10,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guilinespacing = {
		name = "linespacing",
		default = 15,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guipopupspacing = {
		name = "popupspacing",
		default = 10,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guihistorylength = {
		name = "historylength",
		default = 10,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guibackgroundstyle = {
		name = "style",
		default = BACKGROUND.None,
		configpointer = colourconfig.background,
		varpointer = interactivegui.background,
		config = colourconfig
	},
	guibackgroundvariant = {
		name = "variant",
		default = 1,
		configpointer = colourconfig.background,
		varpointer = interactivegui.background,
		config = colourconfig
	},
--------- COLOURS ---------
	colourbg = {
		name = "bgcolour",
		default = 0xF0F0F0FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "GUI Background Colour"
	},
	colourol = {
		name = "olcolour",
		default = 0x000000FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "GUI Outline Colour"
	},
	colourbar = {
		name = "bar",
		default = 0xFFFF00FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Menu Bar-Fill Colour"
	},
	colourboolfalse = {
		name = "boolfalse",
		default = 0xFF0000FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Menu False Colour"
	},
	colourbooltrue = {
		name = "booltrue",
		default = 0x00FF00FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Menu True Colour"
	},
	colouroption1 = {
		name = "option1",
		default = 0xA0FF00FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Menu Option 1 Colour"
	},
	colouroption2 = {
		name = "option2",
		default = 0x00FFFFFF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Menu Option 2 Colour"
	},
	colouroption3 = {
		name = "option3",
		default = 0x00FFA0FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Menu Option 3 Colour"
	},
	colourrecordingselected = {
		name = "recordingselected",
		default = 0xFFFF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = colour,
		config = colourconfig,
		displayname = "Recording Picked Colour"
	},
	colourrecordingselecting = {
		name = "recordingselect",
		default = 0xFF0000FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Recording Pick Colour"
	},
	colourcombotext = {
		name = "colour",
		default = 0xFFFF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = hud.combotext,
		config = colourconfig,
		displayname = "Combo In-Combo Colour"
	},
	colourcombotext2 = {
		name = "colour2",
		default = 0x00FF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = hud.combotext,
		config = colourconfig,
		displayname = "Combo Colour"
	},
	colourcombotextdamage = {
		name = "damagecolour",
		default = 0x00FF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = hud.combotext,
		config = colourconfig,
		displayname = "Combo Damage Colour"
	},
	colourcombotexttotaldamage = {
		name = "totaldamagecolour",
		default = 0x00FF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = hud.combotext,
		config = colourconfig,
		displayname = "Combo Total Damage Colour"
	},
	colourbartextcolour = {
		name = "textcolour",
		default = 0xFF0000FF,
		configpointer = colourconfig.hud.fillbar,
		varpointer = hud.fillbar,
		config = colourconfig,
		displayname = "HUD Bar Text Colour"
	},
	colourbarolcolour = {
		name = "olcolour",
		default = 0x808080FF,
		configpointer = colourconfig.hud.fillbar,
		varpointer = hud.fillbar,
		config = colourconfig,
		displayname = "HUD Bar Outline Colour"
	},
	colourbarbgcolour = {
		name = "bgcolour",
		default = 0x80808060,
		configpointer = colourconfig.hud.fillbar,
		varpointer = hud.fillbar,
		config = colourconfig,
		displayname = "HUD Bar Background Colour"
	},
	colourbarfillcolour = {
		name = "fillcolour",
		default = 0x00FFFFFF,
		configpointer = colourconfig.hud.fillbar,
		varpointer = hud.fillbar,
		config = colourconfig,
		displayname = "HUD Bar Fill Colour"
	},
	colourguiselect = {
		name = "selectcolour",
		default = 0xFF0000FF,
		configpointer = colourconfig,
		varpointer = interactivegui,
		config = colourconfig,
		displayname = "Menu Select Colour"
	},
	colourguitext = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = colourconfig,
		varpointer = interactivegui,
		config = colourconfig,
		displayname = "Menu Text Colour"
	},
	colourguiinfo = {
		name = "infocolour",
		default = 0x89CFEFFF,
		configpointer = colourconfig,
		varpointer = interactivegui,
		config = colourconfig,
		displayname = "Menu Info Box Colour"
	},
	colourbackground1 = {
		name = "colour1",
		default = 0x009B48FF,
		configpointer = colourconfig.background,
		varpointer = interactivegui.background,
		config = colourconfig,
		displayname = "Background Colour 1"
	},
	colourbackground2 = {
		name = "colour2",
		default = 0xFF7F00FF,
		configpointer = colourconfig.background,
		varpointer = interactivegui.background,
		config = colourconfig,
		displayname = "Background Colour 2"
	},
	colourbackground3 = {
		name = "colour3",
		default = 0xFF0000FF,
		configpointer = colourconfig.background,
		varpointer = interactivegui.background,
		config = colourconfig,
		displayname = "Background Colour 3"
	},
	colourbackground4 = {
		name = "colour4",
		default = 0x00FFFFFF,
		configpointer = colourconfig.background,
		varpointer = interactivegui.background,
		config = colourconfig,
		displayname = "Background Colour 4"
	},
	colourbackground5 = {
		name = "colour5",
		default = 0xFF00FFFF,
		configpointer = colourconfig.background,
		varpointer = interactivegui.background,
		config = colourconfig,
		displayname = "Background Colour 5"
	},
--------- RECORDING ---------
	recordingslot = {
		name = "recordingslot",
		default = 1,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingsavestateslot = {
		name = "savestateslot",
		default = 0,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordinghitslot = {
		name = "hitslot",
		default = 0,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingloop = {
		name = "loop",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingreplayp1 = {
		name = "replayP1",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingreplayp2 = {
		name = "replayP2",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingdelay = {
		name = "delay",
		default = 0,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingautoturn = {
		name = "autoturn",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingskiptostart = {
		name = "skiptostart",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingskiptofinish = {
		name = "skiptofinish",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingrandomise = {
		name = "randomise",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingdelay = {
		name = "delay",
		default = 0,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingrandomisedelay = {
		name = "randomisedelay",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
--------- HITBOX ---------
	hitboxtoggle = {
		name = "toggle",
		default = true,
		configpointer = config.hitboxes,
		varpointer = hitboxes,
		config = config,
	},
}

for id, _ in pairs(configitems) do -- populate the config table with default values
	resetConfig(id)
end