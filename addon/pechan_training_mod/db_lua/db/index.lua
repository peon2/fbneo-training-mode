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
    ensureDir("addon/pechan_training_mod")
    ensureDir("addon/pechan_training_mod/db_lua")
    ensureDir("addon/pechan_training_mod/db_lua/db")
    ensureDir("addon/pechan_training_mod/db_lua/db/" .. rom)
    ensureDir("addon/pechan_training_mod/db_lua/db/" .. rom .. "/setups")
    ensureDir("addon/pechan_training_mod/db_lua/db/" .. rom .. "/savestates")
    ensureDir("addon/pechan_training_mod/db_lua/db/" .. rom .. "/replay_setups")
    ensureDir("addon/pechan_training_mod/db_lua/db/" .. rom .. "/replay_savestates")
    ensureDir("addon/pechan_training_mod/db_lua/db/" .. rom .. "/trials")
    ensureDir("addon/pechan_training_mod/db_lua/db/" .. rom .. "/trials/setups")
    ensureDir("addon/pechan_training_mod/db_lua/db/" .. rom .. "/trials/savestates")
end

function M.createSetup(setup, isTrial, isReplay)
    assert(type(setup) == "table", "setup must be a table")
    assert(type(setup.base_name) == "string" and setup.base_name ~= "",
        "setup.base_name must be a non-empty string")

    normalizeBooleanField(setup, "wakeup")
    normalizeBooleanField(setup, "guard")
    M.ensureSetupDirs()

    local rom = emu.romname()
    local setupsFolder = "addon/pechan_training_mod/db_lua/db/" .. rom
    if isTrial then
        setupsFolder = setupsFolder .. "/trials/setups"
    elseif isReplay then
        setupsFolder = setupsFolder .. "/replay_setups"
    else
        setupsFolder = setupsFolder .. "/setups"
    end

    local savestatesFolder = "addon/pechan_training_mod/db_lua/db/" .. rom
    if isTrial then
        savestatesFolder = savestatesFolder .. "/trials/savestates"
    elseif isReplay then
        savestatesFolder = savestatesFolder .. "/replay_savestates"
    else
        savestatesFolder = savestatesFolder .. "/savestates"
    end

    local index = 1
    while true do
        local base_name = setup.base_name .. "_" .. index
        local setupFile = setupsFolder .. "/" .. base_name .. ".lua"
        local stateFile = savestatesFolder .. "/" .. base_name .. ".fs"

        if not fexists(setupFile) then
            setup.base_name = base_name
            setup.savestate_path = stateFile

            -- Save main savestate (if not independent replay)
            if not isReplay then
                savestate.save(stateFile)
            end

            -- Handle slot savestates if they exist in RECORDING_CONFIG
            if setup.RECORDING_CONFIG and setup.RECORDING_CONFIG.slots then
                for i = 1, 5 do
                    local slot_info = setup.RECORDING_CONFIG.slots[i]
                    if slot_info and slot_info.savestate_reload_slot and slot_info.savestate_reload_slot >= 1 then
                        local slot_num = slot_info.savestate_reload_slot
                        local slot_str = string.format("%02d", slot_num)
                        local source = "../savestates/" .. rom .. " slot " .. slot_str .. ".fs"
                        local dest = savestatesFolder .. "/" .. base_name .. "_slot" .. i .. ".fs"

                        if fexists(source) then
                            -- Windows copy command
                            os.execute('copy /Y "' .. source .. '" "' .. dest .. '"')
                        end
                    end
                end
            end

            assert(
                table.save(setup, setupFile) == nil, "Can't save setup file")

            return setupFile, stateFile
        end

        index = index + 1
    end
end

function M.loadAllSetups(isTrial, isReplay)
    local rom = emu.romname()
    local setupsFolder = "addon/pechan_training_mod/db_lua/db/" .. rom
    if isTrial then
        setupsFolder = setupsFolder .. "/trials/setups"
    elseif isReplay then
        setupsFolder = setupsFolder .. "/replay_setups"
    else
        setupsFolder = setupsFolder .. "/setups"
    end

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
