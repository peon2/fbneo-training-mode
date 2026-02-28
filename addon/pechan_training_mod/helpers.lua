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
        { label = "OK", action = function() end }
    }, back_page, parent_x, parent_y)
end

return PECHAN_HELPERS
