-- addon/pechan_training_mod/helpers.lua
-- All popup logic and UI overrides live here; the core engine files are NOT modified.

PECHAN_HELPERS = PECHAN_HELPERS or {}

-------------------------------------------------------------------------------
-- create_context_popup
--   title        : label at top (non-selectable, yellow text)
--   entries      : list of { label, action, require_click }
--     require_click = true  => fires on key-DOWN only (so a key-UP from the
--                              spawning action will not accidentally dismiss)
--   back_page    : page key to CIG to on close
--   parent_x/y   : screen coords of the parent button (popup anchors here)
--   bg_color     : ARGB (default 0x222222FF)
-------------------------------------------------------------------------------
function PECHAN_HELPERS.create_context_popup(title, entries, back_page, parent_x, parent_y, bg_color)
    local popup_entries = {}
    local previous_selection = interactivegui.selection
    bg_color = bg_color or 0x222222FF

    -- Title as item 1 — unselectable (cursor will skip it)
    if title then
        table.insert(popup_entries, {
            text         = title,
            bgcolour     = bg_color,
            olcolour     = "white",
            unselectable = true,
            func         = function() end,
            -- autofunc must be a factory: createPopUpMenu calls autofunc(i)
            autofunc     = function(i) return function(this) this.textcolour = "yellow" end end,
        })
    end

    for _, entry in ipairs(entries) do
        local but = { text = entry.label, bgcolour = bg_color, olcolour = "white" }
        if entry.require_click then
            -- Fire on key-DOWN; absorb key-UP so the spawning press doesn't dismiss
            but.func        = function()
                if entry.action then entry.action() end
                CIG(back_page, previous_selection)
            end
            but.releasefunc = function() end
        else
            -- Standard: fires on key-UP (hold-to-show, release-to-select)
            but.releasefunc = function()
                if entry.action then entry.action() end
                CIG(back_page, previous_selection)
            end
        end
        table.insert(popup_entries, but)
    end

    guipages["helper_popup"] = createPopUpMenu(
        guipages[back_page], nil, nil, nil,
        popup_entries, parent_x - 30, parent_y - 20, nil, bg_color
    )

    if formatGuiTables then formatGuiTables() end
    CIG("helper_popup", title and 2 or 1) -- skip title, start on first real button
end

-- Error popup: red background, explicit OK click required
function PECHAN_HELPERS.show_error_popup(message, back_page, parent_x, parent_y)
    PECHAN_HELPERS.create_context_popup(message, {
        { label = "OK", action = function() end, require_click = true }
    }, back_page, parent_x, parent_y, 0x880000FF)
end

-------------------------------------------------------------------------------
-- MONKEY PATCHES  (global functions wrapped, zero core file edits)
-------------------------------------------------------------------------------

-- Wrap createPopUpMenu
-- Extra 9th arg: bg_color
--   When provided the wrapper:
--   1. Copies direct-function fields (func, releasefunc, bgcolour, …) that the
--      original ignores or misinterprets as factories back onto the menu items.
--   2. Injects an other_func that draws a solid background box then redraws all
--      items on top, so the box appears behind the buttons.
local _orig_createPopUpMenu = createPopUpMenu
createPopUpMenu = function(BaseMenu, releasefunc_default, selectfunc, autofunc, Elements,
                           startx, starty, numofelements, bg_color)
    local menu = _orig_createPopUpMenu(
        BaseMenu, releasefunc_default, selectfunc, autofunc, Elements,
        startx, starty, numofelements
    )

    if not bg_color then return menu end -- no extras requested

    -- -----------------------------------------------------------------------
    -- 1. Fix up fields: the core treats Element.releasefunc/func as factories
    --    (calls them and stores the return value).  For our direct functions
    --    that returns nil, destroying our callbacks.  Restore them.
    -- -----------------------------------------------------------------------
    if Elements then
        for i, v in ipairs(Elements) do
            if menu[i] then
                if v.releasefunc then menu[i].releasefunc = v.releasefunc end
                if v.func then menu[i].func = v.func end
                if v.bgcolour then menu[i].bgcolour = v.bgcolour end
                if v.olcolour then menu[i].olcolour = v.olcolour end
                if v.unselectable then menu[i].unselectable = v.unselectable end
                if v.info then menu[i].info = v.info end
            end
        end
    end

    -- -----------------------------------------------------------------------
    -- 2. Compute background box size
    -- -----------------------------------------------------------------------
    local max_len    = 0
    local item_count = #menu
    for _, v in ipairs(menu) do
        if v.text and #v.text > max_len then max_len = #v.text end
    end
    local bg_w = math.max(48, max_len * 4 + 12)
    local bg_h = item_count * 10 + 8

    -- -----------------------------------------------------------------------
    -- 3. other_func: called every frame by the draw loop AFTER items are drawn.
    --    We draw the solid background box first, then redraw all items on top,
    --    achieving correct draw order without changing the core's draw loop.
    -- -----------------------------------------------------------------------
    menu["other_func"] = function()
        -- Only run when this exact menu is the active page
        if guipages[interactivegui.page] ~= menu then return end

        local bx     = interactivegui.boxx + startx
        local by     = interactivegui.boxy + starty
        local sel    = interactivegui.selection
        local selcol = interactivegui.selectioncolour

        -- Solid background box (drawn behind everything)
        gui.box(bx, by, bx + bg_w, by + bg_h, bg_color, "white")

        -- Redraw each item on top of the background
        for idx, v in ipairs(menu) do
            local ix   = (v.x or startx) + interactivegui.boxx
            local iy   = (v.y or (starty + (idx - 1) * 10)) + interactivegui.boxy
            local text = v.text or ""
            local iw   = #text * 4
            local ibg  = v.bgcolour or bg_color
            local iol  = (idx == sel) and selcol or (v.olcolour or "white")
            gui.box(ix, iy, ix + iw + 4, iy + 10, ibg, iol)
            gui.text(ix + 3, iy + 2, text, v.textcolour or "white")
        end
    end

    return menu
end

-- Wrap changeInteractiveGuiSelection to skip items with unselectable = true.
-- guipages == interactiveguipages (assigned at core startup), so we read the
-- current page via guipages[interactivegui.page] safely.
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
