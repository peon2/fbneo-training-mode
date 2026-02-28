-- addon/pechan_training_mod/helpers.lua
-- Helper variables and functions for UI elements

PECHAN_HELPERS = PECHAN_HELPERS or {}

-- Generates a generic popup menu for errors or context options
-- entries: list of { label, action, require_click }
-- require_click: if true, the button only fires on key-DOWN (not release), so the
--                existing key-up from opening can't accidentally dismiss it
-- bg_color: optional ARGB integer for the popup background
function PECHAN_HELPERS.create_context_popup(title, entries, back_page, parent_x, parent_y, bg_color)
    local popup_entries = {}
    local previous_selection = interactivegui.selection
    local startx = parent_x - 30
    local starty = parent_y - 20

    -- Build the clickable entries (NO title as a selectable item)
    for _, entry in ipairs(entries) do
        local but = {
            text     = entry.label,
            bgcolour = 0x222222FF,
            olcolour = "white",
        }

        if entry.require_click then
            -- Fire on key-DOWN only, ignore the release that spawned this popup
            but.func = function()
                if entry.action then entry.action() end
                CIG(back_page, previous_selection)
            end
            but.releasefunc = function() end -- absorb the key-up cleanly
        else
            -- Standard behaviour: fires when the key is released
            but.releasefunc = function()
                if entry.action then entry.action() end
                CIG(back_page, previous_selection)
            end
        end

        table.insert(popup_entries, but)
    end

    guipages["helper_popup"] = createPopUpMenu(
        guipages[back_page], nil, nil, nil,
        popup_entries, startx, starty, nil, bg_color, title
    )

    if formatGuiTables then formatGuiTables() end
    CIG("helper_popup", 1)
end

-- Specialty helper for error messages (red bg, require explicit OK click)
function PECHAN_HELPERS.show_error_popup(message, back_page, parent_x, parent_y)
    PECHAN_HELPERS.create_context_popup(message, {
        { label = "OK", action = function() end, require_click = true }
    }, back_page, parent_x, parent_y, 0x880000FF)
end

-----------------------------------------------------------------------------------------
-- CORE ENGINE OVERRIDE: createPopUpMenu
-- Wraps the core function to add:
--   * per-element padding (+4 x/y)
--   * dynamic background box sized to the widest text
--   * custom bg_color support
--   * optional title drawn as pure text above the options (non-selectable)
-- The 9th arg (bg_color) and 10th arg (title) are addon-only extensions;
-- the original core function only reads args 1-8 so this is fully safe.
-----------------------------------------------------------------------------------------
local original_createPopUpMenu = createPopUpMenu
createPopUpMenu = function(BaseMenu, releasefunc, selectfunc, autofunc, Elements,
                           startx, starty, numofelements, bg_color, title)
    -- Call the original with only its known parameters
    local menu         = original_createPopUpMenu(
        BaseMenu, releasefunc, selectfunc, autofunc, Elements,
        startx, starty, numofelements
    )

    -- Measure width: consider both entries AND the title if provided
    local max_text_len = title and #title or 0
    local item_count   = 0
    for _, v in ipairs(menu) do
        if type(v) == "table" and v.text then
            max_text_len = math.max(max_text_len, #v.text)
        end
        -- Nudge each item down by one row to leave room for the title label
        if title then
            v.y = (v.y or 0) + 10
        end
        -- Add horizontal padding
        v.x = (v.x or 0) + 4
        item_count = item_count + 1
    end

    local title_rows    = title and 1 or 0
    local bg_width      = math.max(40, (max_text_len * 4) + 12)
    local bg_height     = ((item_count + title_rows) * 10) + 8

    -- Replace the core's aother_func with ours: solid bg + title text
    menu["aother_func"] = function()
        local bx = interactivegui.boxx + startx
        local by = interactivegui.boxy + starty

        -- Solid background box
        gui.box(bx, by, bx + bg_width, by + bg_height,
            bg_color or 0x222222FF, "white")

        -- Draw title inside the box if provided
        if title then
            gui.text(bx + 4, by + 3, title, "yellow")
        end
    end

    return menu
end

return PECHAN_HELPERS
