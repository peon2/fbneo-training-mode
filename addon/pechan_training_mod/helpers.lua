-- addon/pechan_training_mod/helpers.lua
-- All popup logic lives here. Zero changes to core engine files.

PECHAN_HELPERS = PECHAN_HELPERS or {}

-------------------------------------------------------------------------------
-- pechanCreatePopUpMenu
-- A copy of the core createPopUpMenu with two additions:
--   1. bg_color parameter: draws a solid background box behind items
--   2. title parameter: draws a non-selectable title label at the top
--   3. Does NOT call releasefunc/func/etc as factories — stores them directly
-- This function completely replaces createPopUpMenu for our addon popups.
-------------------------------------------------------------------------------
function pechanCreatePopUpMenu(BaseMenu, Elements, startx, starty, bg_color, title)
    local menu = {}

    -- Copy base menu with "a" prefix (same as original)
    for i, v in pairs(BaseMenu) do
        menu["a" .. i] = v
    end

    -- Measure widest text for background box sizing
    local max_text_len = title and #title or 0
    local title_rows = title and 1 or 0

    -- If title is given, items start one row lower
    local y_offset = title_rows * 12

    if Elements then
        for i, v in ipairs(Elements) do
            local but = {}

            -- Store functions DIRECTLY (not as factories)
            if v.releasefunc then but.releasefunc = v.releasefunc end
            if v.func then but.func = v.func end
            if v.selectfunc then but.selectfunc = v.selectfunc end
            if v.autofunc then but.autofunc = v.autofunc(i) end -- autofunc IS a factory

            but.text = v.text or tostring(i)
            but.x = v.x or startx
            but.y = v.y or (starty + y_offset + (i - 1) * 12)

            -- Carry over visual properties
            if v.bgcolour then but.bgcolour = v.bgcolour end
            if v.olcolour then but.olcolour = v.olcolour end
            if v.textcolour then but.textcolour = v.textcolour end
            if v.info then but.info = v.info end
            if v.unselectable then but.unselectable = v.unselectable end

            if but.text and #but.text > max_text_len then
                max_text_len = #but.text
            end

            table.insert(menu, but)
        end
    end

    -- Compute background dimensions
    local item_count = #menu
    local bg_w = math.max(48, max_text_len * 4 + 16)
    local bg_h = (item_count + title_rows) * 12 + 8

    -- other_func is called every frame by the draw loop (line 2320 of core).
    -- We draw the solid background box, then the title text on top.
    -- The core draw loop draws all items BEFORE calling other_func, so we
    -- draw everything (box + title + items) in other_func to layer correctly.
    local items_ref = menu   -- capture reference
    local inner_w = bg_w - 4 -- button width (2px margin each side)
    menu.other_func = function()
        local bx = interactivegui.boxx + startx - 2
        local by = interactivegui.boxy + starty - 2

        -- 1. Solid background box
        gui.box(bx, by, bx + bg_w, by + bg_h, bg_color or 0x222222FF, "white")

        -- 2. Title text inside box (centered)
        if title then
            local title_pixel_w = #title * 4
            local title_x = bx + math.floor((bg_w - title_pixel_w) / 2)
            gui.text(title_x, by + 3, title, "yellow")
        end

        -- 3. Redraw items on top of box — full width, centered text
        local boxx   = interactivegui.boxx
        local boxy   = interactivegui.boxy
        local sel    = interactivegui.selection
        local selcol = interactivegui.selectioncolour

        for idx, v in ipairs(items_ref) do
            local ix   = bx + 2 -- left margin inside box
            local iy   = (v.y or 0) + boxy
            local text = v.text or ""
            local ol   = (idx == sel) and selcol or (v.olcolour or "white")

            -- Button stretches full inner width
            gui.box(ix, iy, ix + inner_w, iy + 10, v.bgcolour or bg_color, ol)

            -- Center text within the button
            local text_pixel_w = #text * 4
            local text_x = ix + math.floor((inner_w - text_pixel_w) / 2)
            gui.text(text_x, iy + 2, text, v.textcolour or "white")
        end
    end

    return menu
end

-------------------------------------------------------------------------------
-- create_context_popup
-------------------------------------------------------------------------------
function PECHAN_HELPERS.create_context_popup(title, entries, back_page, parent_x, parent_y, bg_color)
    local popup_entries = {}
    local previous_selection = interactivegui.selection
    bg_color = bg_color or 0x222222FF

    for _, entry in ipairs(entries) do
        local but = {
            text     = entry.label,
            bgcolour = bg_color,
            olcolour = "white",
        }
        if entry.require_click then
            but.func        = function()
                if entry.action then entry.action() end
                CIG(back_page, previous_selection)
            end
            but.releasefunc = function() end
        else
            but.releasefunc = function()
                if entry.action then entry.action() end
                CIG(back_page, previous_selection)
            end
        end
        table.insert(popup_entries, but)
    end

    guipages["helper_popup"] = pechanCreatePopUpMenu(
        guipages[back_page], popup_entries,
        parent_x - 30, parent_y - 20,
        bg_color, title
    )

    if formatGuiTables then formatGuiTables() end
    CIG("helper_popup", 1)
end

-- Error popup: red background, requires explicit OK click
function PECHAN_HELPERS.show_error_popup(message, back_page, parent_x, parent_y)
    PECHAN_HELPERS.create_context_popup(message, {
        { label = "OK", action = function() end, require_click = true }
    }, back_page, parent_x, parent_y, 0x880000FF)
end

-------------------------------------------------------------------------------
-- Wrap changeInteractiveGuiSelection to skip unselectable items
-------------------------------------------------------------------------------
local _orig_changeInteractiveGuiSelection = changeInteractiveGuiSelection
changeInteractiveGuiSelection = function(n)
    local dir = 1
    if n and n < interactivegui.selection then dir = -1 end
    if n == 0 then dir = -1 end

    _orig_changeInteractiveGuiSelection(n)

    local page = guipages[interactivegui.page]
    if not page then return end

    local guard = 0
    while page[interactivegui.selection] and page[interactivegui.selection].unselectable do
        guard = guard + 1
        if guard > #page then break end
        local nxt = interactivegui.selection + dir
        if nxt > #page then nxt = 1 end
        if nxt < 1 then nxt = #page end
        interactivegui.selection = nxt
    end
end

return PECHAN_HELPERS
