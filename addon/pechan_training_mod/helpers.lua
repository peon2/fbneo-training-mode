-- addon/pechan_training_mod/helpers.lua
-- Helper variables and functions for UI elements

PECHAN_HELPERS = PECHAN_HELPERS or {}

-- Generates a generic popup menu for errors or context options
function PECHAN_HELPERS.create_context_popup(title, entries, back_page, parent_x, parent_y)
    local popup_entries = {}
    local previous_selection = interactivegui.selection

    -- Add Title (inactive, stylized)
    table.insert(popup_entries, {
        text = title,
        x = -(#title * 2) + (#entries > 0 and 20 or 0),
        y = 0,
        bgcolour = 0x880000FF,
        olcolour = "white",
        func = function() end,
        autofunc = function(i)
            return function(this)
                this.textcolour = "yellow"
            end
        end,
    })

    for _, entry in ipairs(entries) do
        table.insert(popup_entries, {
            text = entry.label,
            bgcolour = 0x222222FF,
            olcolour = "white",
            releasefunc = function()
                return function()
                    if entry.action then entry.action() end
                    CIG(back_page, previous_selection)
                end
            end,
        })
    end

    guipages["helper_popup"] = createPopUpMenu(guipages[back_page], nil, nil, nil, popup_entries, parent_x - 30,
        parent_y - 20)

    if formatGuiTables then formatGuiTables() end
    CIG("helper_popup", #entries > 0 and 2 or 1)
end

-- Specialty helper for error messages
function PECHAN_HELPERS.show_error_popup(message, back_page, parent_x, parent_y)
    PECHAN_HELPERS.create_context_popup(message, {
        { label = "OK", action = function() end, require_click = true }
    }, back_page, parent_x, parent_y, 0x880000FF) -- Dark red background for errors
end

-----------------------------------------------------------------------------------------
-- CORE ENGINE OVERRIDES (MONKEY PATCHES)
-- These intercept the global fbneo-training-mode.lua UI functions safely at runtime
-----------------------------------------------------------------------------------------

local original_createPopUpMenu = createPopUpMenu
createPopUpMenu = function(BaseMenu, releasefunc, selectfunc, autofunc, Elements, startx, starty, numofelements, bg_color)
    -- Call the original to spawn the internal table
    local menu = original_createPopUpMenu(BaseMenu, releasefunc, selectfunc, autofunc, Elements, startx, starty,
        numofelements)

    -- Post-process the popup options to inject padding and measure dynamic width
    local max_text_len = 0
    local item_count = 0
    for _, v in ipairs(menu) do
        v.x = v.x + 4
        v.y = v.y + 4
        if type(v) == "table" and v.text then
            max_text_len = math.max(max_text_len, #v.text)
        end
        item_count = item_count + 1
    end

    local bg_width = math.max(40, (max_text_len * 4) + 12)
    local bg_height = (item_count * 10) + 8

    -- Override the background rendering closure injected by the core
    menu["aother_func"] = function()
        gui.box(
            interactivegui.boxx + startx,
            interactivegui.boxy + starty,
            interactivegui.boxx + startx + bg_width,
            interactivegui.boxy + starty + bg_height,
            bg_color or 0x000000FF, -- Custom BG color or fallback to black
            "white"                 -- White outline
        )
    end

    return menu
end

local original_changeInteractiveGuiSelection = changeInteractiveGuiSelection
changeInteractiveGuiSelection = function(n)
    if not interactivegui.enabled then return end
    local page = interactiveguipages[interactivegui.page]

    -- Calculate direction
    local dir = 1
    if n and n < interactivegui.selection then dir = -1 end
    if n == 0 then dir = -1 end -- explicit wrap-around backwards

    -- Let core perform the raw index mutation
    original_changeInteractiveGuiSelection(n)

    -- If the new index landed on an unselectable element, recursively skip forward
    local start_selection = interactivegui.selection
    while page[interactivegui.selection] and page[interactivegui.selection].unselectable do
        local target = interactivegui.selection + dir

        -- Wrap around manually for the skip checks
        if target > #page then
            target = 1
        elseif target < 1 then
            target = #page
        end

        interactivegui.selection = target

        if interactivegui.selection == start_selection then
            interactivegui.selection = 1 -- Failsafe
            break
        end
    end
end

return PECHAN_HELPERS
