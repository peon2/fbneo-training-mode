local DebugViewer = {
    lines = {},
    max_lines = 15,
    bg_color = 0xAA000000, -- Alpha is the highest byte in fbneo GUI functions, so 0xAA is ~66% opacity
    text_color = "yellow",
    font_size = 9,      -- Base text offset multiplier
    enabled = false,
    log_to_file = false,
    log_filename = "addon/pechan_training_mod/debug_log.txt",
}

--- Enable or disable the viewer via code or config
function DebugViewer.setEnabled(state)
    DebugViewer.enabled = state
end

--- Clear the scrolling UI lines and internal history
function DebugViewer.clear()
    DebugViewer.lines = {}
end

--- Add a single string line to the rolling log history.
--- Also immediately writes to the log file if `log_to_file` is true.
function DebugViewer.log(text)
    if not DebugViewer.enabled then return end

    table.insert(DebugViewer.lines, text)

    if #DebugViewer.lines > DebugViewer.max_lines then
        table.remove(DebugViewer.lines, 1)
    end

    if DebugViewer.log_to_file then
        local f = io.open(DebugViewer.log_filename, "a")
        if f then
            f:write(text .. "\n")
            f:close()
        end
    end
end

--- Convenient wrapper to build a string out of a table of named variables
--- Example: DebugViewer.logVars("Player Inputs", { ["P1 Action"] = 0x01, ["Dummy Set"] = true })
function DebugViewer.logVars(title, variables_table)
    if not DebugViewer.enabled then return end

    local kv_strings = {}
    for k, v in pairs(variables_table) do
        -- Format hex numbers nicer if requested
        if type(v) == "number" and string.match(k:lower(), "address") then
            table.insert(kv_strings, string.format("%s:0x%X", k, v))
        elseif type(v) == "number" and (string.match(k:lower(), "cpu") or string.match(k:lower(), "action") or string.match(k:lower(), "hit")) then
            table.insert(kv_strings, string.format("%s:%02X", k, v))
        else
            table.insert(kv_strings, string.format("%s:%s", k, tostring(v)))
        end
    end

    local final_string = string.format("F:%d | %s -> %s", emu.framecount(), title, table.concat(kv_strings, " | "))
    DebugViewer.log(final_string)
end

--- Call this inside the main `guiregister` or render loop to draw the background box and text lines.
function DebugViewer.draw()
    if not DebugViewer.enabled or #DebugViewer.lines == 0 then return end

    -- Calculate box dimensions based on text length
    local box_width = 320
    local box_height = (#DebugViewer.lines * DebugViewer.font_size) + 15

    -- Draw semi-transparent dark background
    -- syntax: gui.box(x0, y0, x1, y1, fillcolor, outlnecolor)
    gui.box(0, 20, box_width, 20 + box_height, DebugViewer.bg_color, 0x00000000)

    for i, l in ipairs(DebugViewer.lines) do
        gui.text(5, 20 + (i * DebugViewer.font_size), l, DebugViewer.text_color)
    end
end

return DebugViewer
