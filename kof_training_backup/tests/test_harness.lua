-- tests/test_harness.lua
local M = {}

-- Global backups
local original_globals = {}
local mock_memory = {}
local mock_joypad = {}
local mock_frame = 0

function M.setup()
    -- Backup originals
    original_globals.rb = _G.rb
    original_globals.wb = _G.wb
    original_globals.rw = _G.rw
    original_globals.ww = _G.ww
    original_globals.joypad = _G.joypad
    original_globals.emu = _G.emu
    original_globals.gui = _G.gui
    original_globals.memory = _G.memory

    -- Reset mocks
    mock_memory = {}
    mock_joypad = {}
    mock_frame = 0

    -- Inject mocks
    _G.rb = function(addr) return mock_memory[addr] or 0 end
    _G.wb = function(addr, val) mock_memory[addr] = val end
    _G.rw = function(addr) return mock_memory[addr] or 0 end -- Simplified: byte=word
    _G.ww = function(addr, val) mock_memory[addr] = val end

    _G.memory = {
        readbyte = _G.rb,
        writebyte = _G.wb,
        readword = _G.rw,
        writeword = _G.ww
    }

    _G.joypad = {
        get = function() return mock_joypad end,
        set = function(tbl)
            for k, v in pairs(tbl) do
                -- print("[Mock Joypad] Set " .. k .. " = " .. tostring(v))
                mock_joypad[k] = v
            end
        end
    }

    _G.emu = {
        framecount = function() return mock_frame end,
        romname = function() return "kof98" end
    }

    _G.gui = {
        text = function(...) end -- Stub
    }
end

function M.teardown()
    -- Restore originals
    _G.rb = original_globals.rb
    _G.wb = original_globals.wb
    _G.rw = original_globals.rw
    _G.ww = original_globals.ww
    _G.joypad = original_globals.joypad
    _G.emu = original_globals.emu
    _G.gui = original_globals.gui
    _G.memory = original_globals.memory
end

function M.set_memory(addr, val)
    mock_memory[addr] = val
end

function M.get_joypad(btn)
    return mock_joypad[btn]
end

function M.advance_frame()
    mock_frame = mock_frame + 1
end

return M
