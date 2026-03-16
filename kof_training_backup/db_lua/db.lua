local serialize = require("serializer")

local DB = {}
DB.root = "db"

-- Ensure folder exists
local function mkdir(path)
    os.execute("mkdir " .. path)
end

-- Load index
local function loadIndex()
    local ok, index = pcall(dofile, DB.root .. "/index.lua")
    return ok and index or {}
end

-- Save index
local function saveIndex(index)
    local f = io.open(DB.root .. "/index.lua", "w")
    f:write("return " .. serialize(index))
    f:close()
end

-- Create new recording entry
function DB.create(game, p1, p2, data)
    mkdir(DB.root)
    mkdir(DB.root .. "/" .. game)

    local index = loadIndex()
    index[game] = index[game] or {}

    local key = p1 .. "_" .. p2
    local n = (index[game][key] or 0) + 1
    index[game][key] = n

    local path = DB.root .. "/" .. game .. "/" .. key .. "_" .. n .. ".lua"

    local f = io.open(path, "w")
    f:write("return " .. serialize(data))
    f:close()

    saveIndex(index)

    return path
end

-- Load existing recording
function DB.load(path)
    local ok, data = pcall(dofile, path)
    if ok then return data end
    return nil
end

return DB
