-- addon/pechan_training_mod/helpers.lua
-- Helper variables and functions for UI elements
-- All overrides are confined to this file; zero changes to core engine files.

PECHAN_HELPERS = PECHAN_HELPERS or {}

-- Generates a generic popup menu for errors or context options.
-- Parameters:
--   title        : string shown at the top of the box (non-selectable, purely visual)
--   entries      : list of { label, action, require_click }
--     require_click: if true, the button only fires on key-DOWN press so the
--                    key-UP that spawned the popup cannot accidentally dismiss it.
--   back_page    : page key to return to on close
--   parent_x/y   : coordinates of the parent button (popup anchors near it)
--   bg_color     : optional ARGB background colour (default dark-grey 0x222222FF)
function PECHAN_HELPERS.create_context_popup(title, entries, back_page, parent_x, parent_y, bg_color)
    local popup_entries = {}
    local previous_selection = interactivegui.selection

    for _, entry in ipairs(entries) do
        local but = {
            text     = entry.label,
            bgcolour = 0x333333FF,
            olcolour = "white",
        }

        if entry.require_click then
            -- Only fires on key-DOWN; the key-UP that opened the popup is ignored.
            but.func = function()
                if entry.action then entry.action() end
                CIG(back_page, previous_selection)
            end
            but.releasefunc = function() end -- absorb the key-up so it cannot dismiss
        else
            -- Standard: fires when the key is released (hold-to-show, release-to-pick)
            but.releasefunc = function()
                if entry.action then entry.action() end
                CIG(back_page, previous_selection)
            end
        end

        table.insert(popup_entries, but)
    end

    local startx = parent_x - 30
    local starty = parent_y - 20

    -- createPopUpMenu is already overridden below, so bg_color and title flow through
    guipages["helper_popup"] = createPopUpMenu(
        guipages[back_page], nil, nil, nil,
        popup_entries, startx, starty, nil,
        bg_color, title
    )

    if formatGuiTables then formatGuiTables() end
    CIG("helper_popup", 1)
end

-- Convenience wrapper: error popup with red background, requires explicit OK click.
function PECHAN_HELPERS.show_error_popup(message, back_page, parent_x, parent_y)
    PECHAN_HELPERS.create_context_popup(message, {
        { label = "OK", action = function() end, require_click = true }
    }, back_page, parent_x, parent_y, 0x880000FF)
end

-------------------------------------------------------------------------------
-- ADDON-LAYER MONKEY PATCHES
-- We intercept global functions declared in the core without modifying the
-- core file itself.  Lua's globals are just table entries, so we can wrap them.
-------------------------------------------------------------------------------

-- Wrap createPopUpMenu
-- Extra addon-only args (ignored by the real function):
--   [9]  bg_color  ARGB integer for the box background
--   [10] title     string rendered at the top of the box as a non-selectable label
local _orig_createPopUpMenu = createPopUpMenu
createPopUpMenu = function(BaseMenu, releasefunc, selectfunc, autofunc, Elements,
                           startx, starty, numofelements, bg_color, title)
    -- Call the original with only its known 8 parameters
    local menu = _orig_createPopUpMenu(
        BaseMenu, releasefunc, selectfunc, autofunc, Elements,
        startx, starty, numofelements
    )

    -- Measure the widest text (entries + optional title)
    local max_len = title and #title or 0
    for _, v in ipairs(menu) do
        if v.text and #v.text > max_len then
            max_len = #v.text
        end
        -- Push items right and down to leave room for the title row and left padding
        v.x = (v.x or 0) + 4
        if title then
            v.y = (v.y or 0) + 12 -- leave one row for the title
        else
            v.y = (v.y or 0) + 4
        end
    end

    local item_count = #menu
    local title_rows = title and 1 or 0
    local bg_w = math.max(48, max_len * 4 + 12)
    local bg_h = (item_count + title_rows) * 10 + 10

    -- other_func is called every frame by the draw loop (line 2320 in core).
    -- We set it directly on the returned menu table — this is safe as createPopUpMenu
    -- only copies BaseMenu string keys with "a" prefix, so there's no collision.
    menu["other_func"] = function()
        local bx = interactivegui.boxx + startx
        local by = interactivegui.boxy + starty

        -- Solid background + white border
        gui.box(bx, by, bx + bg_w, by + bg_h, bg_color or 0x222222FF, "white")

        -- Title text drawn inside the top of the box
        if title then
            gui.text(bx + 4, by + 3, title, "yellow")
        end
    end

    return menu
end

-- Wrap changeInteractiveGuiSelection to skip unselectable items.
-- guipages == interactiveguipages (the core assigns them at startup), so we
-- can read the current page via guipages[interactivegui.page] safely.
local _orig_changeInteractiveGuiSelection = changeInteractiveGuiSelection
changeInteractiveGuiSelection = function(n)
    -- Determine direction before the call mutates interactivegui.selection
    local dir = 1
    if n and n < interactivegui.selection then dir = -1 end
    if n == 0 then dir = -1 end

    _orig_changeInteractiveGuiSelection(n)

    -- After the core lands on a new index, skip over unselectable items
    local page = guipages[interactivegui.page]
    if not page then return end

    local guard = 0
    while page[interactivegui.selection] and page[interactivegui.selection].unselectable do
        guard = guard + 1
        if guard > #page then break end -- failsafe: prevent infinite loop

        local next_idx = interactivegui.selection + dir
        if next_idx > #page then next_idx = 1 end
        if next_idx < 1 then next_idx = #page end
        interactivegui.selection = next_idx
    end
end

return PECHAN_HELPERS
