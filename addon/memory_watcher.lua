-- https://github.com/peon2/Memory-Watcher/
local MEMORY_HISTORY_MAX = 3
local XOFFSET = 50
local YOFFSET = 30
local DISPLAY_COUNT = math.floor((emu.screenheight() - (YOFFSET + 15))/10)
local MEMORY_OUTPUT_FORMAT = "0x%X: Value: 0x%X Starting Value: 0x%X"
local DEFAULT_MEMORY_START = 0x100000 -- neogeo defaults
local DEFAULT_MEMORY_SIZE = 0x10000
local DEFAULT_WORD_SIZE = 2

local DUMP_FILE = "memory.txt"
local DEFAULT_KEYS = "ICSAUOD"
--[[
INIT		-- starts a new memory watch session
CMP			-- picks how to compare memory to it's previous value
STEP		-- steps memory session based on the chosen cmp operation
AUTO_STEP	-- steps for as long as the button is held down
UNDO		-- switches the memory map out for a copy of it prior to the previous step
CONFIG		-- sets the values of the keys
DUMP		-- dumps active memory addresses to the console

ENTER		-- finishes an input stream (NOT CHANGEABLE)
--]]

local ROM = emu.romname()
local keys = {"INIT", "CMP", "STEP", "AUTO_STEP", "UNDO", "CONFIG", "DUMP"}
local input_key = {ENTER = "enter"}

local function isKeyDefined(k)
	if #k ~= 1 then return true end
	for _, key in pairs(input_key) do
		if key == k then
			return true
		end
	end
end

local function setKeys(str)
	for i, key in ipairs(keys) do
		local new_key = str:sub(i,i)
		if #new_key==1 and not isKeyDefined(new_key) then
			input_key[key] = new_key
		end
	end
end

setKeys(DEFAULT_KEYS)

local fc
local FBNEO_TRAINING_MODE
local get_inputs
if rb then
	FBNEO_TRAINING_MODE = true
	get_inputs = function() return guiinputs.kb.inputs end -- fbneo will only serve the inputs once, so we need to get it from the fbneo-training-mode if it already grabbed it
-- create config to add saving settings?
else
	FBNEO_TRAINING_MODE = false
	get_inputs = input.get
end
local memorystart = DEFAULT_MEMORY_START
local wordsize = DEFAULT_WORD_SIZE
local memorysize = DEFAULT_MEMORY_SIZE
local memory_active = false
local readop
local active_addresses
local memorylength
local memoryhistory = {}
local memorymap
local display_values
local prev_inputs
local inputs = {}

local readoperations = {}
if FBNEO_TRAINING_MODE then
	readoperations[1] = rb
	readoperations[2] = rw
	readoperations[4] = rdw
else
	readoperations[1] = memory.readbyte
	readoperations[2] = memory.readword
	readoperations[4] = memory.readdoubleword -- TODO change this to always read longs/read byte ranges for more efficient operation, masking the result to the desired word size
end

local function init()
	display_values = nil
	memoryhistory = {}
	memorymap = {}
	memorylength = memorysize/wordsize
	memory_active = true
	readop = readoperations[wordsize]
	for i = 0, memorylength do
		local value = readop(memorystart+i*wordsize)
		memorymap[i] = {value = value, enabled = true, startingvalue = value}
	end
	active_addresses = memorylength
end

local cmp_constant = 0
local functiontable = {
	EQ	= function(a, b) 	return a==b end,
	IS	= function(a, _) 	return a==cmp_constant end,
	EQS	= function(a, _, s)	return a==s end,
	NE	= function(a, b) 	return a~=b end,
	NES	= function(a, _, s)	return a~=s end,
	LT	= function(a, _) 	return a<cmp_constant end,
	LTE	= function(a, _) 	return a<=cmp_constant end,
	LTS	= function(a, _, s)	return a<=s end,
	GT	= function(a, _) 	return a>cmp_constant end,
	GTE	= function(a, _) 	return a>=cmp_constant end,
	GTS	= function(a, _, s)	return a>=s end,
	DE	= function(a, b) 	return a<b end,
	DEE	= function(a, b) 	return a<=b end,
	INC	= function(a, b) 	return a>b end,
	INE	= function(a, b) 	return a>=b end
}
local funcname = "IS"
local cmp = functiontable.IS

local function hasArgument(funcname)
	return funcname == "IS" or funcname == "LT" or funcname == "LTE" or funcname == "GT" or funcname == "GTE"
end

local function setCompare(op)
	for name, func in pairs(functiontable) do
		if name == op then
			cmp = func
			funcname = op
		end
	end
end

local function step()
	for i = MEMORY_HISTORY_MAX, 2, -1 do
		memoryhistory[i] = memoryhistory[i-1]
	end
	memoryhistory[1] = {memory = memorymap, active_addresses = active_addresses}

	active_addresses = 0
	local new_memorymap = {}
	for i = 0, memorylength do
		new_memorymap[i] = {enabled = false}
		if memorymap[i].enabled then
			local value = readop(memorystart+i*wordsize)
			if cmp(value, memorymap[i].value, memorymap[i].startingvalue) then
				new_memorymap[i].value = value
				new_memorymap[i].enabled = true
				new_memorymap[i].startingvalue = memorymap[i].startingvalue
				active_addresses = active_addresses + 1
			end
		end
	end
	memorymap = new_memorymap

	if active_addresses <= DISPLAY_COUNT and active_addresses > 0 then
		display_values = {}
		print("Memory Watcher: ") -- print all these values, once, so they can be copied
		for i = 0, memorylength do
			if memorymap[i].enabled then
				local address = memorystart+i*wordsize
				table.insert(display_values, {memory = memorymap[i], address = address})
				print(string.format(MEMORY_OUTPUT_FORMAT, address, memorymap[i].value, memorymap[i].startingvalue))
			end
		end
	end
end

local function memoryDump()
	gui.text(XOFFSET, YOFFSET-10, "Dumping active memory to file memory.txt...", "teal")
	print("Dumping active memory to file memory.txt...")
	local file = io.open(DUMP_FILE, "w")
	file:write(string.format("%s: Framecount %d, Starting Memory: 0x%X, Memory Size: 0x%X, Word Size: %d\n", ROM, fc, memorystart, memorysize, wordsize))
	local linecnt = 0
	for i = 0, memorylength do
		if memorymap[i].enabled then
			linecnt = linecnt+1
			if (linecnt%1000==0) then
				file:flush()
			end
			local address = memorystart+i*wordsize
			file:write(string.format(MEMORY_OUTPUT_FORMAT, address, readop(address), memorymap[i].startingvalue))
			file:write("\n")
		end
	end
end

local function autoStep()
	active_addresses = 0
	for i = 0, memorylength do
		if memorymap[i].enabled then
			local value = readop(memorystart+i*wordsize)
			if cmp(value, memorymap[i].value) then
				memorymap[i].value = value
				active_addresses = active_addresses + 1
			else
				memorymap[i].enabled = false
			end
		end
	end
end

local function undo()
	if memoryhistory[1]~= nil then
		memorymap = memoryhistory[1].memory
		active_addresses = memoryhistory[1].active_addresses
		for i = 1, MEMORY_HISTORY_MAX do
			memoryhistory[i] = memoryhistory[i+1]
		end
	end
end

local function updateInputs()
	prev_inputs = nil
	prev_inputs = copytable(inputs)
	inputs = get_inputs()
end

local function PRESSED(key)
	return inputs[key] and not prev_inputs[key]
end

local alphabet_filter = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
local hexadecimal_filter = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"}
local wordsize_filter = {"1", "2", "4"}
local filter

local function getKeyWithFilter(filter)
	for _, letter in pairs(filter) do -- don't press multiple valid keys a frame!
		if inputs[letter] then
			return letter
		end
	end
	return nil
end

local input_states = { -- every state that requires kb input
	INIT = 0,
	CMP = 1,
	CONFIG = 2
}

local input_state = nil
local input_stream

local previous_key

local inittext1 = "Watching 0x"
local inittext2 = "%X-0x"
local inittext3 = "Word Size "
local input_stage
local function init_input(key)
	if key and key~=previous_key then
		input_stream = input_stream .. key
	end
	local display_stream = input_stream
	if fc%5 == 0 then
		display_stream = display_stream .. "_"
	end
	if input_stage == 0 then
		gui.text(XOFFSET, YOFFSET, inittext1..display_stream)
		if PRESSED(input_key.ENTER) then
			memorystart = tonumber(input_stream, 16) or memorystart

			input_stage = 1
			input_stream = ""
		end
	elseif input_stage == 1 then
		gui.text(XOFFSET, YOFFSET, string.format(inittext1..inittext2..display_stream, memorystart))
		if PRESSED(input_key.ENTER) then
			memorysize = (tonumber(input_stream, 16) or memorysize + memorystart) - memorystart
			if memorysize <= 0 then memorysize = 0x10000 end

			input_stage = 2
			filter = wordsize_filter
			input_stream = ""
		end
	elseif input_stage == 2 then
		gui.text(XOFFSET, YOFFSET, string.format(inittext1..inittext2.."%X", memorystart, memorysize + memorystart))
		gui.text(XOFFSET, YOFFSET+10, inittext3..display_stream)
		if PRESSED(input_key.ENTER) or #input_stream == 1 then
			wordsize = tonumber(input_stream) or wordsize
			init()

			input_state = nil
			input_stream = ""
		end
	end
end

local function cmp_input(key)
	if key and key~=previous_key then
		input_stream = input_stream .. key
	end
	local display_stream = input_stream
	if fc%5 == 0 then
		display_stream = display_stream .. "_"
	end
	if input_stage == 0 then
		gui.text(XOFFSET, YOFFSET, string.format(inittext1..inittext2.."%X with Operation "..display_stream, memorystart, memorystart+memorysize))
		gui.text(XOFFSET, YOFFSET+10, string.format(inittext3.."%d with %d active addresses.", wordsize, active_addresses))
		if PRESSED(input_key.ENTER) then
			setCompare(input_stream)
			if hasArgument(input_stream) then -- need to take in a constant
				input_stage = 1
				filter = hexadecimal_filter
				input_stream = ""
			else
				input_state = nil
			end
		end
	elseif input_stage == 1 then -- handle constant
		gui.text(XOFFSET, YOFFSET, string.format(inittext1..inittext2.."%X with Operation '%s' 0x"..display_stream, memorystart, memorystart+memorysize, funcname))
		gui.text(XOFFSET, YOFFSET+10, string.format(inittext3.."%d with %d active addresses.", wordsize, active_addresses))
		if PRESSED(input_key.ENTER) or #input_stream==wordsize*2 then
			cmp_constant = tonumber(input_stream, 16) or 0

			input_state = nil
		end
	end
end

local function config_input(key)
	local new_key_pressed = key and key~=previous_key
	if new_key_pressed then
		input_stream = input_stream .. key
		input_stage = input_stage + 1
		setKeys(input_stream)
	end
	for i, v in ipairs(keys) do
		gui.text(XOFFSET, YOFFSET+i*10, v..": ", "teal")
		if i == input_stage then
			gui.text(XOFFSET+44, YOFFSET+i*10, input_key[v], "red")
		else
			gui.text(XOFFSET+44, YOFFSET+i*10, input_key[v], "white")
		end
	end
	if PRESSED(input_key.ENTER) or input_stage > #keys then
		setKeys(input_stream)
		input_state = nil
	end
end

local script_lock_chars
local script_lock_text
if FBNEO_TRAINING_MODE then -- Lock the script before use when it's loaded as an addon
	script_locked = true
	script_lock_chars = {
		"Q",
		"W",
		"O",
		"P"
	}
	script_lock_text = "Input '"
	for _, letter in ipairs(script_lock_chars) do
		script_lock_text = script_lock_text.." "
		script_lock_chars[letter] = false
	end
	script_lock_text = script_lock_text .. "' in Sequence to start the script"
end

local function update()
	fc = emu.framecount()
	updateInputs()

	if script_locked then
		if fc%120 == 0 then for letter, _ in ipairs(script_lock_chars) do script_lock_chars[script_lock_chars[letter]] = false end end -- reset every 2 seconds
		gui.text(XOFFSET, YOFFSET, "Loaded Memory Watcher Script:", "teal")
		gui.text(XOFFSET, YOFFSET+10, script_lock_text, "teal")
		local xoffset2 = 28
		local bools = true
		for _, letter in ipairs(script_lock_chars) do
			script_lock_chars[letter] = inputs[letter] or script_lock_chars[letter]
			local val = script_lock_chars[letter]
			bools = bools and val
			gui.text(XOFFSET+xoffset2, YOFFSET+10, letter, (val and "yellow" or "white"))
			xoffset2 = xoffset2 + 4
		end
		if bools == true then -- if all keys have been pressed, unlock the script
			script_locked = false
		end
		return
	end

	if input_state then
		local key = getKeyWithFilter(filter)
		if input_state == input_states.INIT then
			init_input(key)
		elseif input_state == input_states.CMP then
			cmp_input(key)
		elseif input_state == input_states.CONFIG then
			config_input(key)
		end
		previous_key = key
	else
		if memory_active then
			if hasArgument(funcname) then
				gui.text(XOFFSET, YOFFSET, string.format(inittext1..inittext2.."%X with Operation '%s' '0x%X'.", memorystart, memorystart+memorysize, funcname, cmp_constant))
			else
				gui.text(XOFFSET, YOFFSET, string.format(inittext1..inittext2.."%X with Operation '%s'.", memorystart, memorystart+memorysize, funcname))
			end
			gui.text(XOFFSET, YOFFSET+10, string.format(inittext3.."%d with %d active addresses.", wordsize, active_addresses))
		else
			for i, v in ipairs(keys) do
				gui.text(XOFFSET, YOFFSET+i*10, v..": ", "teal")
				gui.text(XOFFSET+44, YOFFSET+i*10, input_key[v], "white")
			end
		end
		if display_values then
			for index, disp in ipairs(display_values) do
				gui.text(XOFFSET, YOFFSET+15+index*10, string.format(MEMORY_OUTPUT_FORMAT, disp.address, readop(disp.address), disp.memory.startingvalue))
			end
		end
		input_stream = ""
		input_stage = 0
		if PRESSED(input_key.INIT) then
			input_state = input_states.INIT
			filter = hexadecimal_filter
			previous_key = input_key.INIT
		elseif PRESSED(input_key.CMP) and memory_active then
			input_state = input_states.CMP
			filter = alphabet_filter
			previous_key = input_key.CMP
		elseif PRESSED(input_key.STEP) and memory_active then
			step()
		elseif inputs[input_key.AUTO_STEP] and memory_active then
			autoStep()
		elseif PRESSED(input_key.UNDO) and memory_active then -- maybe needs a log?
			undo()
		elseif PRESSED(input_key.CONFIG) then
			input_stage = 1
			input_state = input_states.CONFIG
			filter = alphabet_filter
			previous_key = input_key.CONFIG
		elseif PRESSED(input_key.DUMP) and memory_active then
			memoryDump()
		end
	end
end

if FBNEO_TRAINING_MODE then
	table.insert(registers.registerbefore, update)
else
	emu.registerbefore(update)
end
