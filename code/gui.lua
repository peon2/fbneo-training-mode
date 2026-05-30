assert(rb,"Run fbneo-training-mode.lua")

----------------------------------------------
-- EXPOSED GUI VALUES
----------------------------------------------

guiinputs = {
	P1 = {previousinputs={}, coinframestart = 0, coinpresscount = 0, leftframecount = 0, rightframecount = 0, downframecount = 0, upframecount = 0,},
	P2 = {previousinputs={}},
	kb = {inputcount={}},
}

function calcDerivedGUIValues() -- should only need to be called once from fbneo-training-mode.lua
	interactivegui.boxx = math.floor(emu.screenwidth()/interactivegui.boxxd)	-- proportions of the screen
	interactivegui.boxy = math.floor((emu.screenheight()/interactivegui.boxyd)-10) -- keep out of range of the tooltips
	interactivegui.boxx2 = math.floor(interactivegui.boxxm*(emu.screenwidth()/interactivegui.boxxd))
	interactivegui.boxy2 = math.floor(interactivegui.boxym*(emu.screenheight()/interactivegui.boxyd)-10)
	interactivegui.boxxlength = math.floor((interactivegui.boxxm-1)*(emu.screenwidth()/interactivegui.boxxd))
	interactivegui.boxylength = math.floor((interactivegui.boxym-1)*(emu.screenheight()/interactivegui.boxyd))
	interactivegui.boxxhalflength = math.floor((interactivegui.boxxm-1)*(emu.screenwidth()/interactivegui.boxxd)/2)
	interactivegui.boxyhalflength = math.floor((interactivegui.boxym-1)*(emu.screenheight()/interactivegui.boxyd)/2)
	interactivegui.boxxmid = math.floor(emu.screenwidth()/interactivegui.boxxd+(interactivegui.boxxm-1)*(emu.screenwidth()/interactivegui.boxxd)/2)
	interactivegui.boxymid = math.floor(emu.screenheight()/interactivegui.boxyd-10+(interactivegui.boxym-1)*(emu.screenheight()/interactivegui.boxyd)/2)
	-- leave this as a float for precision
	interactivegui.boxfactor = ((interactivegui.boxym-1)*(emu.screenheight()/interactivegui.boxyd))/((interactivegui.boxxm-1)*(emu.screenwidth()/interactivegui.boxxd))
end

--[[
	Takes a table of ids and coordinates.

	pageelements = {
	 {id1, x1, y1},
	 {id2, x2, y2},
	 ...
	}

	Returns a table of ids sorted based on x and y values, pre-computed for navigation.
	Lookup entries are included for each entry.

	navigationtable = {
		id1 = {"left" = idx, "right" = idx, "up" = idx, "down" = idx},
		id2 = {"left" = idx, "right" = idx, "up" = idx, "down" = idx},
		...
	}
--]]
function createNavigatablePage(pageelements) -- produces a table of element ids that can be used for up/down/left/right navigation
	local id = (function(t) return function(n)
		if not n or n == 0 then return nil end
		return t[n].id
	end end)(pageelements)

	table.sort(pageelements, function(a,b) -- make sure the page elements are in the order in which we want to navigate
		if a.y==b.y then
			return a.x<b.x
		end
		return a.y<b.y
	end)

	local navigationtable = {}
	for elementind, element in ipairs(pageelements) do
		navigationtable[element.id] = {}
		-- Left
		if (pageelements[elementind-1] and pageelements[elementind-1].y == element.y) then
			navigationtable[element.id].left = id(elementind-1)
		end
		if not navigationtable[element.id].left then
			for i=elementind+1, #pageelements do
				if pageelements[i].y ~= element.y then break end
				navigationtable[element.id].left = pageelements[i].id
			end
		end
		-- Right
		if (pageelements[elementind+1] and pageelements[elementind+1].y == element.y) then
			navigationtable[element.id].right =  id(elementind+1)
		end
		if not navigationtable[element.id].right then
			for i=elementind-1, 1, -1 do
				if i==0 then break end
				if pageelements[i].y ~= element.y then break end
				navigationtable[element.id].right =  pageelements[i].id
			end
		end
		-- Up
		local diff = 0xFFFFFFFF
		local closesty = -1
		local closestid = nil
		for i=elementind-1, 1, -1 do
			if pageelements[i] then
				if pageelements[i].y < closesty then
					break
				end
				if pageelements[i].y < element.y and math.abs(pageelements[i].x-element.x) < diff then
					diff = math.abs(pageelements[i].x-element.x)
					closesty = pageelements[i].y
					closestid = id(i)
				end
			end
		end
		navigationtable[element.id].up = closestid
		if not navigationtable[element.id].up then
			diff = 0xFFFFFFFF
			closesty = -1
			closestid = nil
			for i = #pageelements, 1, -1 do
				if pageelements[i].y < closesty then
					break
				end
				if math.abs(pageelements[i].x-element.x) < diff then
					diff = math.abs(pageelements[i].x-element.x)
					closesty = pageelements[i].y
					closestid = id(i)
				end
			end
			navigationtable[element.id].up = closestid
		end
		-- Down
		diff = 0xFFFFFFFF
		closesty = 0xFFFFFFFF
		closestid = nil
		for i=elementind+1, #pageelements do
			if pageelements[i].y > closesty then
				break
			end
			if pageelements[i].y > element.y and math.abs(pageelements[i].x-element.x) < diff then
				diff = math.abs(pageelements[i].x-element.x)
				closesty = pageelements[i].y
				closestid = id(i)
			end
		end
		navigationtable[element.id].down = closestid
		if not navigationtable[element.id].down then
			diff = 0xFFFFFFFF
			closesty = 0xFFFFFFFF
			closestid = nil
			for i = 1, #pageelements do
				if pageelements[i].y > closesty then
					break
				end
				if math.abs(pageelements[i].x-element.x) < diff then
					diff = math.abs(pageelements[i].x-element.x)
					closesty = pageelements[i].y
					closestid = id(i)
				end
			end
			navigationtable[element.id].down = closestid
		end
	end
	return navigationtable
end

----------------------------------------------

function reloadGUIPages()
	dofile(filetree.guipages)
end

----------------------------------------------
-- BUTTONS USED BY GUIPAGES
----------------------------------------------

local drawGUIFuncs = {
	function(but) -- SLCT
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			callGUISelectionFunc()
		end
		if not guiinputs.P1[but] and guiinputs.P1.previousinputs[but] then
			callGUISelectionReleaseFunc()
		end
	end,

	function(but) -- HKEY
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			inputs.hotkeys.hotkeyin = true
			blankKB()
		end
	end,

	function(but) -- INFO
		if guiinputs.P1[but] then
			interactiveGUISelectionInfo()
		end
	end,

	function(but) -- DEFAULT
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local reset = guipages[interactivegui.page][interactivegui.selection].reset
			if reset then reset() end
		end
	end,

	coin = function() end,

	back = function(but)
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then -- back button
			interactiveGUISelectionBack()
		end
	end,

	other = function() -- runs every frame regardless
		local nav = guinavigationtable[interactivegui.page] -- formatted table

		if not nav then -- just in case
			if guiinputs.P1.left and not guiinputs.P1.previousinputs.left then
				changeGUISelection(interactivegui.selection-1)
			elseif guiinputs.P1.right and not guiinputs.P1.previousinputs.right then
				changeGUISelection(interactivegui.selection+1)
			end
			if guiinputs.P1.down and not guiinputs.P1.previousinputs.down then
				changeGUISelection(interactivegui.selection-1)
			elseif guiinputs.P1.up and not guiinputs.P1.previousinputs.up then
				changeGUISelection(interactivegui.selection+1)
			end
		else
			if guiinputs.P1.left and not guiinputs.P1.previousinputs.left then
				interactivegui.selection = nav[interactivegui.selection].left or interactivegui.selection
			elseif guiinputs.P1.right and not guiinputs.P1.previousinputs.right then
				interactivegui.selection = nav[interactivegui.selection].right or interactivegui.selection
			end

			if guiinputs.P1.up and not guiinputs.P1.previousinputs.up then
				interactivegui.selection = nav[interactivegui.selection].up or interactivegui.selection
				if guipages[interactivegui.page][interactivegui.selection] == nil then -- failsafe
					interactivegui.selection = #guipages[interactivegui.page]
				end
			elseif guiinputs.P1.down and not guiinputs.P1.previousinputs.down then
				interactivegui.selection = nav[interactivegui.selection].down or interactivegui.selection
				if guipages[interactivegui.page][interactivegui.selection] == nil then -- failsafe
					interactivegui.selection = 1
				end
			end
		end
	end,
	name = "drawGUIFuncs",
}

local popupButtonsFuncs = copytable(drawGUIFuncs)
for i = 2, #popupButtonsFuncs do
	popupButtonsFuncs[i] = nil
end
popupButtonsFuncs.name = "popupButtonsFuncs"

----------------------------------------------
-- FUNCTIONS USED BY GUIPAGES
----------------------------------------------

function createFauxPage(basepage) -- copy over the table and make sure ipairs wont pick up the elements, making them unselectable
	local newpage = {}
	for i,v in pairs(basepage) do
		newpage["A"..i] = v
	end
	return newpage
end

--[[
	Returns a page set above the base page with a Pop Up Menu

	basepage 		-> Page the scrolling bar should be set up
	elements		-> List of Elements to populate the Popup Menu, if nil, creates a number of buttons equal to numofelements,
						elements should follow the same format as guipages buttons
	x 				-> X pos of the scrolling bar
	y				-> Y pos of the scrolling bar
	numofelements	-> Number of elements, unused if elements is defined
	selectfunc		-> Default Function to fire when a button is selected
						function(n): Where 'n' is the button number
	releasefunc		-> Default Function to fire when button1 is released
						function()
	autofunc		-> Default Function to fire each frame
						function(this): Where 'this' is the buttons
	forcecentre		-> Whether or not the selection should be centred at the X, Y position
--]]
function createPopUpMenu(basepage, elements, x, y, numofelements, selectfunc, releasefunc, autofunc, forcecentre)
	if releasefunc == nil then
		releasefunc = function() return function() previousPageAndSelection() end end
	end

	local page = {}
	page.faux = createFauxPage(basepage)

	local but

	if (elements) then
		for elementid, element in ipairs(elements) do
			-- create buttons
			but = {}
			if (element.releasefunc) then
				but.releasefunc = element.releasefunc(elementid)
			else
				if (releasefunc) then but.releasefunc = releasefunc(elementid) end
			end

			if (element.selectfunc) then
				but.selectfunc = element.selectfunc(elementid)
			else
				if (selectfunc) then but.selectfunc = selectfunc(elementid) end
			end

			local autofunc

			if (element.autofunc) then
				autofunc = element.autofunc
			else
				if (autofunc) then
					autofunc = autofunc
				end
			end

			if (forcecentre) then
				if (autofunc) then
					but.autofunc = function(element)
						element.y = y + (elementid - interactivegui.selection)*interactivegui.popupspacing
						autofunc(element)
					end
				else
					but.autofunc = function(element)
						element.y = y + (elementid - interactivegui.selection)*interactivegui.popupspacing
					end
				end
			else
				but.autofunc = autofunc
			end

			if (element.text) then
				but.text = element.text
			else
				but.text = tostring(elementid)
			end

			if (element.x) then
				but.x = element.x
			else
				but.x = x
			end

			if (element.y) then
				but.y = element.y
			else
				but.y = y+(elementid-1)*interactivegui.popupspacing
			end

			but.textcolour = element.textcolour
			but.olcolour = element.olcolour or "black"
			but.bgcolour = element.bgcolour or colour.bgcolour

			table.insert(page, but)
		end
	else
		for elementid = 1, numofelements do
			-- create buttons
			but = {}
			
			if (forcecentre) then
				if (autofunc) then
					but.autofunc = function(element)
						element.y = y + (elementid - interactivegui.selection)*interactivegui.popupspacing
						autofunc(element)
					end
				else
					but.autofunc = function(element)
						element.y = y + (elementid - interactivegui.selection)*interactivegui.popupspacing
					end
				end
			else
				but.autofunc = autofunc
			end
			
			if (releasefunc) then but.releasefunc = releasefunc(elementid) end
			if (selectfunc) then but.selectfunc = selectfunc(elementid) end
			but.text = tostring(elementid)
			but.x = x
			but.y = y+(elementid-1)*interactivegui.popupspacing
			table.insert(page, but)
		end
	end

	page.other_func = function()
		local hudbuttons = {
			{name="RLSE"},
			funcs=popupButtonsFuncs
		}
		helpElements.buttons = hudbuttons
	end

	return page
end

--[[
	Returns a page set above the base page with a scrolling bar

	basepage 	-> Page the scrolling bar should be set up
	text		-> Text to display in the scrolling bar
	x 			-> X pos of the scrolling bar
	y			-> Y pos of the scrolling bar
	minimum		-> Minimum value for the scrolling bar
	maximum		-> Maximum value for the scrolling bar
	length		-> Length of the scrolling bar
	updatefunc	-> Function to call when the bar value increments or decrements, should be of the form:
		function(n, k): Where n is a number to apply to the value (positive or negative) and k is a number to set the value to
	autofunc	-> Function to call every frame
		function(this): Where 'this' is the scrolling bar
--]]
function createScrollingBar(basepage, text, x, y, minimum, maximum, length, updatefunc, autofunc)
	local valuerange = (maximum - minimum)
	text = text or ""

	length = length or valuerange
	if #text > 0 then length = #text*LETTER_WIDTH end
	length = length/LETTER_WIDTH -- account for text size

	for _=1,(length-#text)/LETTER_WIDTH do
		text = " "..text
		x = x - LETTER_WIDTH
	end
	for _=1,(length-(#text/LETTER_HALFWIDTH))/LETTER_WIDTH do
		text = text.." "
	end

	local page = {}
	page.faux = createFauxPage(basepage)

	page.minimum = {
		x = x-1-(#tostring(minimum)+1)*LETTER_WIDTH,
		y = y+10,
		text = tostring(minimum)
	}

	page.maximum = {
		x = x+1+length*LETTER_WIDTH + LETTER_WIDTH,
		y = y+10,
		text = tostring(maximum)
	}

	local but = {}
	but.x = x
	but.y = y
	but.text = text
	but.olcolour = colour.olcolour
	but.bgcolour = colour.bgcolour
	but.val = updatefunc()
	but.fillpercent = (but.val-minimum)/valuerange

	but.autofunc = function(this)
		but.val = updatefunc()
		local d = 0
		if guiinputs.P1.left then

			d = scaleinputnum(guiinputs.P1.leftframecount)

			if but.val-d>=minimum then
				updatefunc(-d)
			else
				updatefunc(maximum-but.val)
			end
		elseif guiinputs.P1.right then

			d = scaleinputnum(guiinputs.P1.rightframecount)

			if but.val+d<=maximum then
				updatefunc(d)
			else
				updatefunc(minimum-but.val)
			end
		end
		but.fillpercent = (but.val-minimum)/valuerange
		if autofunc then autofunc(but) end
	end

	but.func = function() previousPageAndSelection() end

	page[1] = but
	page.other_func = function()
		local funcs = copytable(popupButtonsFuncs)

		funcs[2] = function(but) -- MIN
			if guiinputs.P1[but] then
				updatefunc(nil, minimum)
			end
		end

		funcs[3] = function(but) -- MAX
			if guiinputs.P1[but] then
				updatefunc(nil, maximum)
			end
		end

		funcs.name = "scrollingbarbuttons"

		helpElements.buttons = {
			{name="SLCT"},
			{name="MIN"},
			{name="MAX"},
			funcs=funcs
		}
	end

	return page
end

local function changeGUIPage(page)
	if not interactivegui.enabled then return end
	page = page or interactivegui.page+1

	if guipages[page] then -- if the page exists go there
		interactivegui.page = page
	else -- otherwise try to wrap-around
		if page == 0 then
			interactivegui.page = #guipages -- goto last
		elseif page == #guipages+1 then
			interactivegui.page = 1 -- goto first
		end -- otherwise do nothing
	end

	page = guipages[interactivegui.page]

	if interactivegui.selection > #page then -- make sure selection is in bounds
		interactivegui.selection = #page
	elseif interactivegui.selection < 1 then
		interactivegui.selection = 1
	end
end

local interactiveguihistory = { length = 0 }

function changePageAndSelection(page, selection) -- macro, both of these are used together so often
	interactivegui.previouspage = interactivegui.page
	interactivegui.previousselection = interactivegui.selection
	local history = { interactivegui.page, interactivegui.selection }
	local length = interactiveguihistory.length
	if interactiveguihistory.length >= getConfigValue("guihistorylength") then
		length = length - 1
		for i = 1, length do
			interactiveguihistory[i] = interactiveguihistory[i+1]
		end
		interactiveguihistory.length = length
	end
	length = length + 1
	interactiveguihistory[length] = history
	interactiveguihistory.length = length
	changeGUIPage(page)
	changeGUISelection(selection)
end

function previousPageAndSelection()
	local length = interactiveguihistory.length
	if length == 0 then return 0 end
	local page = interactiveguihistory[length][1]
	local selection = interactiveguihistory[length][2]
	interactiveguihistory.length = length - 1
	changeGUIPage(page)
	changeGUISelection(selection)
	return length
end

function changeGUISelection(selection)
	if not interactivegui.enabled then return end
	local page = guipages[interactivegui.page] -- current page
	if (#page<=1) then
		interactivegui.selection = 1
		return
	end
	selection = selection or interactivegui.selection+1

	if page[selection] then -- if the selection exists go there
		interactivegui.selection = selection
	else -- otherwise try to wrap around
		if selection == 0 then
			interactivegui.selection = #page -- goto last
		elseif selection == #page+1 then
			interactivegui.selection = 1 -- goto first
		end -- otherwise do nothing
	end
end

function callGUISelectionFunc()
	local func = guipages[interactivegui.page][interactivegui.selection].func
	if not interactivegui.enabled or not func then return end
	func()
end

function callGUISelectionReleaseFunc()
	local func = guipages[interactivegui.page][interactivegui.selection].releasefunc
	if not interactivegui.enabled or not func then return end
	func()
end

function interactiveGUISelectionInfo()
	local info = guipages[interactivegui.page][interactivegui.selection].info
	if not interactivegui.enabled or not info then return end

	local largest = 0
	local x1, x2, xm, y2 = interactivegui.boxx, interactivegui.boxx2, interactivegui.boxxmid, interactivegui.boxy2-2

	for _,v in ipairs(info) do
		if largest < #v then largest = #v end
	end

	gui.box(xm - 1 - (largest)*2, y2 - (#info)*10, xm + 1 + (largest)*2, y2, interactivegui.infocolour, "black")

	for i,v in ipairs(info) do
		gui.text(xm - #v*2 + 1, y2 - (#info)*10 + 2 + (i-1)*10, v)
	end
end

function interactiveGUISelectionBack()
	if not interactivegui.enabled then return end
	local tablelength = previousPageAndSelection()
	if tablelength == 0 then -- if back doesn't go anywhere, close the GUI instead
		toggleInteractiveGUI()
	end
end

local toggledrawhelp = true

function drawHelp()
	if not (interactivegui.movehud.enabled or interactivegui.enabled or interactivegui.replayeditor.enabled) then return end

	-- run buttons
	for i=1,nbuttons do if helpElements[i] and helpElements[i].func then helpElements[i].func(helpElements[i].buttonnum) end end -- run all the functions
	if helpElements.funcs.other then helpElements.funcs.other() end
	if helpElements.funcs.coin then helpElements.funcs.coin() end

	if not toggledrawhelp then return end

	local offset = helpElements.len*9
	local i,l = 1, helpElements.len
	while i<=l do
		if helpElements[i] and helpElements[i].name then
			helpElements[i].button = helpElements[i].button or i
			gui.gdoverlay(interactivegui.sw/2 - offset, interactivegui.sh-27, helpShell)
			gui.gdoverlay(interactivegui.sw/2 - offset + 1, interactivegui.sh-26, helpButtons[helpElements[i].button])
			gui.text(interactivegui.sw/2 - offset + 9 - #helpElements[i].name:sub(1,4)*2, interactivegui.sh-9, helpElements[i].name:sub(1,4))
			offset=offset-18
		else
			l=l+1 -- more to iterate
		end
		assert(i<=nbuttons, "Button Handler Draw Error")
		i=i+1
	end
end

function toggleInteractiveGUI(bool, vargs)
	if vargs then vargs.interactiveguienabled = false end
	toggleStates(vargs)
	recording[recording.recordingslot] = recording[recording.recordingslot] or {}
	recording[recording.recordingslot].framestart = nil

	if bool==nil then interactivegui.enabled = not interactivegui.enabled
	else interactivegui.enabled = bool end
end

local function drawElement(elementid, element)
	element.x = element.x or 0
	element.y = element.y or 0
	element.text = element.text or " "
	element.textcolour = element.textcolour or interactivegui.textcolour
	local olcolour = elementid == interactivegui.selection and interactivegui.selectcolour or element.olcolour
	local w = #element.text*LETTER_WIDTH + LETTER_WIDTH
	local h = LETTER_HEIGHT + 2 -- small amount of empty space
	if element.bgcolour ~= nil or olcolour ~= nil then
		gui.box(
			element.x + interactivegui.boxx,
			element.y + interactivegui.boxy,
			element.x + interactivegui.boxx + w,
			element.y + interactivegui.boxy + h,
			element.bgcolour,
			olcolour
		)
	end
	if (element.fillpercent and element.fillpercent>0) then
		w = math.floor(w*element.fillpercent)
		w = (w<=1) and 2 or w -- make sure w is in bounds
		gui.box(
			element.x + interactivegui.boxx + 1,
			element.y + interactivegui.boxy + 1,
			element.x + interactivegui.boxx + w - 1,
			element.y + interactivegui.boxy + h - 1,
			colour.bar
		)
	end
	gui.text(element.x + interactivegui.boxx + 3, element.y + interactivegui.boxy + 2, element.text, element.textcolour)
end

dofile(filetree.background)

local garbagecount = {disp = collectgarbage("count")}
function drawGUI() -- should only be called by fbneo-training-mode.lua
	if not interactivegui.enabled then return end

	local page = guipages[interactivegui.page]
	local selection = page[interactivegui.selection]

	gui.box( -- main window everything is drawn upon
		interactivegui.boxx,
		interactivegui.boxy,
		interactivegui.boxx2,
		interactivegui.boxy2,
		colour.bgcolour,
		colour.olcolour
	)

	drawBackground()

	if page.faux then
		for elementid, element in pairs(page.faux) do
			if type(element)=="table" then
				if element.autofunc then
					element:autofunc()
				end
				drawElement(elementid, element)
			end
		end
		if page.faux.Aother_func then page.faux.Aother_func() end -- if there's anything else to be ran
	end
	for elementid, element in pairs(page) do -- force 'active' elements to be drawn on top
		if elementid ~= "faux" and type(element)=="table" then
			if element.autofunc then
				element:autofunc()
			end
			drawElement(elementid, element)
		end
	end

	drawElement(interactivegui.selection, selection) -- make sure this is drawn on top
	if selection.selectfunc then selection.selectfunc() end
	helpElements.buttons = {
		{name="SLCT"},
		funcs = {
			drawGUIFuncs[1],
			coin = drawGUIFuncs.coin,
			back = drawGUIFuncs.back,
			other = drawGUIFuncs.other,
			name = "drawGUIFuncs"
		}
	}
	if selection.canhotkey then
		table.insert(helpElements.buttons, {name = "HKEY"})
		table.insert(helpElements.buttons.funcs, drawGUIFuncs[2])
		helpElements.buttons.funcs.name = helpElements.buttons.funcs.name.."HKEY"
	end

	if selection.info then
		table.insert(helpElements.buttons, {name = "INFO"})
		table.insert(helpElements.buttons.funcs, drawGUIFuncs[3])
		helpElements.buttons.funcs.name = helpElements.buttons.funcs.name.."INFO"
	end

	if selection.reset then
		table.insert(helpElements.buttons, {name = "DFLT"})
		table.insert(helpElements.buttons.funcs, drawGUIFuncs[4])
		helpElements.buttons.funcs.name = helpElements.buttons.funcs.name.."DFLT"
	end

	if page.other_func then page.other_func() end -- if there's anything else to be ran

	if DEBUG then
		table.insert(garbagecount, collectgarbage("count")) -- round to two places
		if #garbagecount>=30 then
			local disp = 0
			for _, v in ipairs(garbagecount) do
				disp = disp+v
			end
			disp = disp/#garbagecount
			garbagecount={}
			garbagecount.disp = math.floor(disp*100)/100
		end
		gui.text(interactivegui.boxx+1, interactivegui.boxy2-7, "kB:"..garbagecount.disp)
	end
end