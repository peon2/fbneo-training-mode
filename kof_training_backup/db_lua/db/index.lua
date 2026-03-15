-- db_lua/db/index.lua

local M = {}

local function ensureDir(path)
    os.execute('mkdir "' .. path .. '"')
end

local function normalizeBooleanField(tbl, field)
  if tbl[field] == nil then
    tbl[field] = false
  else
    assert(type(tbl[field]) == "boolean",
      field .. " must be a boolean")
  end
end


function M.ensureSetupDirs()
    local rom = emu.romname()

    ensureDir("addon")
    ensureDir("addon/kof_training")
    ensureDir("addon/kof_training/db_lua")
    ensureDir("addon/kof_training/db_lua/db")
    ensureDir("addon/kof_training/db_lua/db/" .. rom)
    ensureDir("addon/kof_training/db_lua/db/" .. rom .. "/setups")
    ensureDir("addon/kof_training/db_lua/db/" .. rom .. "/savestates")
end
function M.createSetup(setup)
    
    assert(type(setup) == "table", "setup must be a table")
    assert(type(setup.base_name) == "string" and setup.base_name ~= "",
        "setup.base_name must be a non-empty string")

    normalizeBooleanField(setup, "wakeup")
    normalizeBooleanField(setup, "guard")
    M.ensureSetupDirs()

    local rom = emu.romname()
    local setupsFolder = "addon/kof_training/db_lua/db/" .. rom .. "/setups"
    local savestatesFolder = "addon/kof_training/db_lua/db/" .. rom .. "/savestates"

    local index = 1
    while true do
        local base_name = setup.base_name .. "_" .. index
        local setupFile = setupsFolder .. "/" .. base_name .. ".lua"
        local stateFile = savestatesFolder .. "/" .. base_name .. ".fs"

        if not fexists(setupFile) then
            setup.base_name = base_name
            assert(
		table.save(setup, setupFile) == nil, "Can't save setup file")
            
            savestate.save(stateFile)

            return setupFile, stateFile
        end

        index = index + 1
    end
end

function M.loadAllSetups()
    local rom = emu.romname()
    local setupsFolder =
        "addon/kof_training/db_lua/db/" .. rom .. "/setups"

    local setups = {}

    -- Windows (FBNeo/MAME on Windows)
    local p = io.popen('dir "' .. setupsFolder .. '" /b')

    if not p then
        return setups
    end

    for file in p:lines() do
        if file:match("%.lua$") then
            local fullpath = setupsFolder .. "/" .. file
            local setup = table.load(fullpath)
            if setup then
                table.insert(setups, setup)
            end
        end
    end

    p:close()
    return setups
end



return M
