assert(rb,"Run fbneo-training-mode.lua")

--[[
	Small Table Serialise/Unserialise library to work with the fbneo-training-mode.
	Doesn't work with metatables, functions, threads, or userdata.
	Doesn't work with numbers larger than 0xFFFFFFFF.
	Doesn't work with strings larger than 4111 chars, strings smaller than 16 chars are preferable.
	No table should be referenced more than once.
	Each table should have no more than 65535 indices, unlimited keys are allowed.
	Each key should be 256 or fewer chars in length.
	
	Stores files in binary format:
	
	metadata: => TABLE (NO INDEXING, ONLY KEYS)
	data: => TABLE (INDEXING (MAX 65535) AND KEYS OK)
	
	CHUNK OF DATA: after each KEY CHUNK OF DATA the KEY NAME is given (no KEY NAME for indices)
		DATA TYPE => 1 byte: [UPPER NIBBLE->MISC, LOWER NIBBLE->TYPE]
			0 -> false,
			1 -> true,
			2 -> nil,
			3 -> INTEGER: [UPPER NIBBLE->LEN, LOWER NIBBLE->3]
				value -> 1-4 bytes
			11-> NEGATIVE INTEGER: [UPPER NIBBLE->LEN, LOWER NIBBLE->11]
				-value -> 1-4 bytes
			4 -> FLOAT: [UPPER NIBBLE->LEN, LOWER NIBBLE->4]
				value -> 3-19 chars
			5 -> STRING: [UPPER NIBBLE->N (0-15), LOWER NIBBLE->5]
				N chars
			13-> Extended String: [UPPER NIBBLE->LEN1, LOWER NIBBLE bits->13]
				LEN2 -> 1 byte, N = LEN2<<4+LEN1
				N chars
			6 -> TABLE:
				INTEGER OF NUMBERED ENTRIES, N => 2 bytes
				Nx[INTEGER index, CHUNK OF DATA] => variable size
				Mx[STRING key, CHUNKS OF DATA] => variable size
				DELIMITER
	
	KEY NAME:
		LEN => 1 byte, 1->256
		N chars
--]]

local CONSTANTS = {
	TYPE = {
		FALSE = 0,
		TRUE = 1,
		NIL = 2,
		INTEGER = 3,
		NEGATIVE_INTEGER = 8+3,
		FLOAT = 4,
		STRING = 5,
		EXTENDED_STRING = 8+5,
		TABLE = 6,
		TABLE_END = 7
	},
	INTEGER = {
		MINIMUM_SIZE = 1,
		SIZE_MASK = 0x30,
		ONE_BYTE = 0x00,
		TWO_BYTES = 0x10,
		THREE_BYTES = 0x20,
		FOUR_BYTES = 0x30,
	},
	FLOAT = {
		MINIMUM_SIZE = 3,
		SIZE_MASK = 0xF0,
	},
	STRING = {
		SHORT_LEN = 15,
		SHORT_LEN_MASK = 0xF0,
		MAX_LEN = 4096+15,
	},
	TABLE_END_VALUE = "__SAVELOAD_TABLE_END"
}

local function ERR(msg) assert(1==0, msg) end

----------------------------------------------
-- SAVE/SERIALISE
----------------------------------------------

local writeCount = 0
local writeFlush = 200

local writeValue -- forward declaration

local function writeTable(t, file)
	local indexcount = #t
	if indexcount > 0xFFFF then
		ERR("Tried to serialise a table with too many indices.")
	end
	local indices = {} -- Two bytes for max indices count.
	indices[1] = AND(SHIFT(indexcount,8), 0xFF)
	indices[2] = AND(indexcount, 0xFF)
	file:write(string.char(unpack(indices)))
	for i, v in ipairs(t) do -- Indices first, we don't track the table index, assume it's calculated as the data is parsed back.
		err = writeValue(v, file)
		if err then
			ERR("Tried to save Value with Bad Type: "..i..", "..type(v)..", "..err)
		end
	end
	local length
	for i, v in pairs(t) do
		if not tonumber(i) or i>indexcount then -- Skip covered Indices. We need to track table names now.
			err = writeValue(v, file)
			if err then
				ERR("Tried to save Value with Bad Type: "..i..", "..type(v)..", "..err)
			end
			length = (#tostring(i))-1 -- There's always at least one character for the table name.
			file:write(string.char(length), i)
		end
	end
	file:write(string.char(CONSTANTS.TYPE.TABLE_END))
end

writeValue = function (v, file)
	writeCount = writeCount + 1
	if writeCount > writeFlush then
		file:flush()
		writeCount = 0
	end
	local v_type = type(v)
	if v_type == "nil" then
		file:write(string.char(CONSTANTS.TYPE.NIL))
	elseif v_type == "boolean" then
		file:write(string.char(v and CONSTANTS.TYPE.TRUE or CONSTANTS.TYPE.FALSE))
	elseif v_type == "number" then
		local v_floor = math.floor(v)
		if v == v_floor then
			local d_type = CONSTANTS.TYPE.INTEGER
			if v<0 then -- Track if negative.
				d_type = d_type + CONSTANTS.TYPE.NEGATIVE_INTEGER
				v = v*-1
			end
			local values = {}
			if v > 0xFFFFFFFF then
				return "Number too large."
			elseif v > 0x00FFFFFF then -- I can't think of a better way to split the number, at least the size gets tracked too as an after-effect.
				d_type = d_type + CONSTANTS.INTEGER.FOUR_BYTES
				values[4] = AND(v, 0xFF)
				values[1] = AND(SHIFT(v,24), 0xFF)
				values[2] = AND(SHIFT(v,16), 0xFF)
				values[3] = AND(SHIFT(v,8), 0xFF)
			elseif v > 0x0000FFFF then
				d_type = d_type + CONSTANTS.INTEGER.THREE_BYTES
				values[3] = AND(v, 0xFF)
				values[1] = AND(SHIFT(v,16), 0xFF)
				values[2] = AND(SHIFT(v,8), 0xFF)
			elseif v > 0x000000FF then
				d_type = d_type + CONSTANTS.INTEGER.TWO_BYTES
				values[2] = AND(v, 0xFF)
				values[1] = AND(SHIFT(v,8), 0xFF)
			else
				--d_type = d_type + CONSTANTS.INTEGER.ONE_BYTE
				values[1] = AND(v, 0xFF)
			end
			file:write(string.char(d_type, unpack(values)))
		else -- converting this to a long instead of storing it as a string would be much more space-efficient (idk how to cleanly do that in Lua)
			local v_string = tostring(v)
			local d_type = 0x10*(#v_string-CONSTANTS.FLOAT.MINIMUM_SIZE)+CONSTANTS.TYPE.FLOAT -- a float is guaranteed to have at least 3 chars (e.g. 9.9), count everything after that (max 16 chars in total?)
			file:write(string.char(d_type), v_string)
		end
	elseif v_type == "string" then
		local d_type
		local v_len = #v
		if v_len > CONSTANTS.STRING.MAX_LEN then
			return "String too long."
		elseif v_len <= CONSTANTS.STRING.SHORT_LEN then -- if the string is 15 chars or less, we can fit the len in only the type byte.
			d_type = CONSTANTS.TYPE.STRING + SHIFT(v_len, -4)
			file:write(string.char(d_type), v)
		else -- otherwise, we need a new byte to extend len, we can skip what the short len could cover. EXTENDED STRING
			v_len = v_len-CONSTANTS.STRING.SHORT_LEN-1
			d_type = SHIFT(AND(CONSTANTS.STRING.SHORT_LEN, v_len), -4)+CONSTANTS.TYPE.EXTENDED_STRING
			v_len = SHIFT(v_len, 4)
			file:write(string.char(d_type, v_len), v)
		end
	elseif v_type == "table" then
		file:write(string.char(CONSTANTS.TYPE.TABLE))
		writeTable(v, file)
	else
		return "Type not handled"
	end
	return nil
end

function saveTableToFile(metadata, data, filename)
	metadata = metadata or {}
	data = data or {}
	local file = io.open(filename, "wb")
	writeCount = 0
	
	local length
	for i, v in pairs(metadata) do -- manually handle metadata as a special case, we know there's no indexing in the metatable, only keys.
		length = (#i)-1 -- There's always at least one character for the table name.
		err = writeValue(v, file)
		if err then
			ERR("Tried to save Value "..i.." with Bad Type: "..type(v)..", "..err)
		end
		file:write(string.char(length), i)
	end
	file:write(string.char(CONSTANTS.TYPE.TABLE_END))
	
	writeTable(data, file)
	
	file:close()
end

----------------------------------------------
-- LOAD/PARSE
----------------------------------------------

local parseValue -- forward declaration
local parseKey -- forward declaration

local function parseTable(rawdata, ind)
	local data = {}
	local indexcount = SHIFT(rawdata[ind], -8) + rawdata[ind+1]
	ind = ind + 2
	for i = 1, indexcount do -- first parse each index
		local value, key
		value, ind = parseValue(rawdata, ind)
		if value == CONSTANTS.TABLE_END_VALUE then ERR("Unexpected End of Table "..string.format("0x%X", ind)) end -- we should never exit here
		data[i] = value
	end
	while rawdata[ind] do -- now handle keys
		local value, key
		value, ind = parseValue(rawdata, ind)
		if value == CONSTANTS.TABLE_END_VALUE then break end -- finished parsing
		key, ind = parseKey(rawdata, ind) 
		data[key] = value
	end
	return data, ind
end

parseValue = function(rawdata, ind)
	local value
	local d_type = AND(rawdata[ind], 0x0F)
	if d_type == CONSTANTS.TYPE.FALSE then
		value = false
		ind = ind + 1
	elseif d_type == CONSTANTS.TYPE.TRUE then
		value = true
		ind = ind + 1
	elseif d_type == CONSTANTS.TYPE.NIL then
		value = nil
		ind = ind + 1
	elseif d_type == CONSTANTS.TYPE.INTEGER then
		local integer_size = SHIFT(AND(rawdata[ind], CONSTANTS.INTEGER.SIZE_MASK), 4)+CONSTANTS.INTEGER.MINIMUM_SIZE
		ind = ind + 1
		local integer = 0
		for i = 0, integer_size-1 do
			integer = SHIFT(integer, -8)
			integer = integer+rawdata[ind+i]
		end
		print(integer_size, string.format("0x%X", integer))
		ind = ind + integer_size
		value = integer
	elseif d_type == CONSTANTS.TYPE.NEGATIVE_INTEGER then
		local integer_size = SHIFT(AND(rawdata[ind], CONSTANTS.INTEGER.SIZE_MASK), 4)+CONSTANTS.INTEGER.MINIMUM_SIZE
		ind = ind + 1
		local integer = 0
		for i = 1, integer_size do
			integer = integer*0x100
			integer = integer+rawdata[ind+integer_size-i]
		end
		ind = ind + integer_size
		value = -integer
	elseif d_type == CONSTANTS.TYPE.FLOAT then
		local float_size = SHIFT(AND(rawdata[ind], CONSTANTS.FLOAT.SIZE_MASK), 4)+CONSTANTS.FLOAT.MINIMUM_SIZE
		ind = ind + 1
		value = tonumber(string.char(unpack(rawdata, ind, ind+float_size-1)))
		ind = ind + float_size
	elseif d_type == CONSTANTS.TYPE.STRING then
		local string_size = SHIFT(AND(rawdata[ind], CONSTANTS.STRING.SHORT_LEN_MASK), 4)
		ind = ind + 1
		value = string.char(unpack(rawdata, ind, ind+string_size-1))
		ind = ind + string_size
	elseif d_type == CONSTANTS.TYPE.EXTENDED_STRING then
		local string_size = SHIFT(rawdata[ind+1], -4) + SHIFT(AND(rawdata[ind], CONSTANTS.STRING.SHORT_LEN_MASK), 4) + CONSTANTS.STRING.SHORT_LEN+1
		ind = ind + 2
		value = string.char(unpack(rawdata, ind, ind+string_size-1))
		ind = ind + string_size
	elseif d_type == CONSTANTS.TYPE.TABLE then
		ind = ind + 1
		value, ind = parseTable(rawdata, ind)
	elseif d_type == CONSTANTS.TYPE.TABLE_END then
		value = CONSTANTS.TABLE_END_VALUE
		ind = ind + 1
	else
		ERR("Couldn't parse data type: "..rawdata[ind].." at position: "..string.format("0x%X", ind-1))
	end
	return value, ind
end

parseKey = function(rawdata, ind)
	local keylen = rawdata[ind]
	ind = ind + 1
	local key = string.char(unpack(rawdata, ind, ind+keylen))
	ind = ind + keylen + 1
	return key, ind
end

local metadataloaded = nil
local rawdata = nil
local ind = 0
--[[
	These two should be loaded one after another
--]]
function loadMetaDataFromFile(filename)
	local d_string = assert(io.open(filename, "rb")):read("*a")
	rawdata = {string.byte(d_string, 1, #d_string)}
	ind = 1
	local metadata = {}
	while rawdata[ind] do -- parse metadata manually, immediately starts with keys
		local value, key
		value, ind = parseValue(rawdata, ind)
		if value == CONSTANTS.TABLE_END_VALUE then break end -- finished parsing
		key, ind = parseKey(rawdata, ind) 
		metadata[key] = value
	end
	
	metadataloaded = filename
	return metadata
end

function loadDataFromFile(filename)
	if not metadataloaded or not rawdata or metadataloaded~=filename then -- we can't load if the metadata hasn't been extracted yet
		return nil
	end
	local data = {}
	data, ind = parseTable(rawdata, ind) -- data is formatted like a regular table
	
	metadataloaded = nil
	return data
end

function loadTableFromFile(filename)
	local metadata = loadMetaDataFromFile(filename)
	local data = loadDataFromFile(filename)
	metadataloaded = nil
	return metadata, data
end