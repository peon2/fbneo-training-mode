assert(rb,"Run fbneo-training-mode.lua")

----------------------------------------------
-- HUD ELEMENTS
----------------------------------------------
local HUDElements = { }

--[[
	This function creates something displayable on screen that can be modified by the 'HUD Settings'
	
	name -> Unique identifier of this element.
	&x -> A function that will both set the x value and return the x value.
	&y -> A function that will both set the y value and return the y value.
	&enabled -> A function that will both set whether this function is visible and return if it is visible.
	reset -> A function that will reset this HUDElement to default values.
	draw -> A function that will draw the HUDElement on screen, it should know the x and y values implicitly.
	*extrafuncs -> A table of helpElements.
	
	&: in the format:
		function(n)
			if n~=nil then
				[LOGIC TO CHANGE VALUE HERE]
			end
			return [LOGIC TO GET VALUE HERE]
		end
	*: Optional
	
	See redearth for user created examples, or "p1scrollinginput" below as an example.
--]]
function createHUDElement(name, x, y, enabled, reset, draw, extrafuncs)
	assert(type(name)=="string", "Name must be of type string")
	assert(type(x)=="function", "X must be a function")
	assert(type(y)=="function", "Y must be a function")
	assert(type(enabled)=="function", "Enabled must be a function")
	assert(type(reset)=="function", "Reset must be a function")
	assert(type(draw)=="function", "Draw must be a function")
	assert(type(extrafuncs)=="table" or extrafuncs == nil, "extrafuncs must be a table")

	table.insert(HUDElements, {
		name = name,
		x = x,
		y = y,
		enabled = enabled,
		reset = reset,
		draw = draw,
		extrafuncs = extrafuncs
	})
end

function drawHUD() -- all parts of the hud should be dropped in here
	if interactivegui.inmenu and not interactivegui.movehud.enabled then return end

	for _, v in ipairs(HUDElements) do
		if v.enabled() then v.draw() end
	end
end

function drawComboHUD()
	local player = inputs.properties.enableinputswap and "P1" or "P2"
	local cvars = combovars[player]
	local gvars = gamevars[player]

	if cvars.healthdiff > 0 then
		gui.text(hud.combotext.x-LETTER_WIDTH,hud.combotext.y,"Damage: " ..cvars.healthdiff, hud.combotext.damagecolour)
	else
		gui.text(hud.combotext.x-LETTER_WIDTH,hud.combotext.y,"Damage: " ..cvars.previousdamage, hud.combotext.damagecolour)
	end
	if gvars.inhitstun then
		gui.text(hud.combotext.x,hud.combotext.y+10,"Combo: "..cvars.displaycombo, hud.combotext.colour)
	else
		gui.text(hud.combotext.x,hud.combotext.y+10,"Combo: "..cvars.displaycombo, hud.combotext.colour2)
	end
   	gui.text(hud.combotext.x,hud.combotext.y+20,"Total: "..cvars.comboDamage, hud.combotext.totaldamagecolour)
end

local function HUDElementsParse(HUDElements) -- parses HUDElements to fit the createNavigatablePage format
	local parsedElements = {}
	for elementid, element in ipairs(HUDElements) do
		table.insert(parsedElements, {id=elementid, x=element.x(), y=element.y() })
		if parsedElements[#parsedElements].y == nil then
			print(elementid)
			print(element)
		end
	end
	return parsedElements
end

function toggleMoveHUD(bool, vargs)
	if #HUDElements==0 then return end

	if vargs then vargs.movehud = false end
	toggleStates(vargs)
	if bool then
		interactivegui.movehud.enabled = true
		guiinputs.P1.previousinputs.button1 = true -- stop double pressing
		HUDElements.NavigatableTable = createNavigatablePage(HUDElementsParse(HUDElements)) -- for menu navigation
		if gamefunctions.scrollinginputsetsampleinput then scrollingInputSetSampleInput() end
	elseif bool == false then
		interactivegui.movehud.enabled = false
		if gamefunctions.scrollinginputclear then scrollingInputClear() end
	else interactivegui.movehud.enabled = not interactivegui.movehud.enabled end

	interactivegui.movehud.selected = false
end

----------------------------------------------
-- TEXT DRAWER
----------------------------------------------
local textitems = {}

function addTextItem(text, x, y, colour, timer)
	table.insert(textitems, {text = text, x = x, y = y, colour = colour, timer = timer})
end

function drawTextItems()
	for i, v in pairs(textitems) do
		gui.text(v.x, v.y, v.text, v.colour)
		if v.timer then
			v.timer = v.timer-1
			if v.timer == 0 then
				textitems[i] = nil
			end
		end
	end
end

----------------------------------------------
-- MOVE HUD
----------------------------------------------

helpElements = {}
local buttonHandlerInputs = {}
local MAX_GUI_BUTTONS = 10 -- Things will get unmanageable if we surpass this
for i = 1, MAX_GUI_BUTTONS do
	buttonHandlerInputs["button"..i] = i
end

local function moreButtonsFunc(but)
	if not (guiinputs.P1[but] and not guiinputs.P1.previousinputs[but]) then return end
	if nbuttons+helpElements.block*(nbuttons-2) >= #helpElements then helpElements.block = 0 end
	for i = 1, nbuttons-2 do -- space for more and back
		local temp = helpElements[i]
		local offset = helpElements.block*(nbuttons-2) + i + nbuttons
		helpElements[i] = {} -- clear
		if not (offset > #helpElements) and next(helpElements[offset]) then
			helpElements[i] = helpElements[offset]
			helpElements[i].button = i -- make sure the buttons are set up right
			helpElements[i].buttonnum = "button"..i
			helpElements.len = i+2
		end
		helpElements[offset] = temp
	end
	helpElements.block = helpElements.block+1
end

function buttonHandler()
	local buttons = helpElements.buttons
	if buttons==nil then return end -- can't do anything with no buttons
	--[[
		buttons={
			{name="", button=""},
			{name="", button=""},
			{name="", button=""},
			.
			.
			.
			funcs = {... = (), other = ()}
			len
		}
	--]]

	buttons[1].button = buttons[1].button or "button1" -- just in case

	for i = 1, #buttons.funcs do
		buttons[i] = buttons[i] or {name = " "}
		buttons[i].button = buttons[i].button or "button"..(tonumber(buttons[i-1].button:sub(7))+1)
	end

	buttons.len=#buttons

	helpElements.more = helpElements.more or 0

	if helpElements.name==nil or buttons.funcs.name~=helpElements.name then -- new set of buttons, should be checking using enums
		helpElements = {name = buttons.funcs.name}
		buttons.len=buttons.len+1 -- space for back

		buttons[buttons.len] = {name="BACK", button="button"..nbuttons} -- insert back as the last button

		for i,v in ipairs(buttons.funcs) do buttons[i].func=v end -- copy across funcs

		helpElements.more = 0
		helpElements.block = 0
		if (buttons.len > nbuttons or #buttons.funcs > buttons.len) then -- not enough buttons for functions, set up the MORE button
			local back = buttons[buttons.len] -- back button
			for i = buttons.len+1, nbuttons+1, -1 do buttons[i] = buttons[i-2] buttons[i-2] = {} end -- shunt along
			buttons[nbuttons] = back -- put back in place
			buttons[nbuttons-1].name = "MORE" -- set attributes for more button
			buttons[nbuttons-1].button="button"..(nbuttons-1)
			buttons[nbuttons-1].func = buttons.funcs.more or moreButtonsFunc -- put more in place, use default if there isn't a specific one
			helpElements.more = 1 -- mark more as being added
			buttons.len=buttons.len+1 -- space for more
		end
		helpElements.funcs = buttons.funcs
		helpElements.len = buttons.len
		for i = 1, helpElements.len do
			helpElements[i]={name=buttons[i].name, button=buttonHandlerInputs[buttons[i].button], buttonnum=buttons[i].button, func=buttons[i].func}
		end
		helpElements.len = math.min(nbuttons,helpElements.len)
		helpElements[helpElements.len].func = buttons.funcs.back or function(but) -- default for back
			if guiinputs.P1.previousinputs[but] and not guiinputs.P1[but] then
				toggleStates({})
			end
		end
		helpElements.funcs.coin = helpElements.funcs.coin or function() -- run the back button with coin as default
			helpElements[math.min(nbuttons,buttons.len)].func("coin")
		end
		helpElements.len=0 -- real length ( account for {} in table )
		for _,v in ipairs(helpElements) do
			if v.name and v.button then helpElements.len=helpElements.len+1 end
		end
		helpElements.len = math.min(nbuttons, helpElements.len)
	end

	helpElements.name = buttons.funcs.name
end

local moveHUDFuncs = {
	function(but) -- slct
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			interactivegui.movehud.selected = not interactivegui.movehud.selected
			if interactivegui.movehud.selected then
				HUDElements[interactivegui.movehud.selection].prevx = HUDElements[interactivegui.movehud.selection].x()
				HUDElements[interactivegui.movehud.selection].prevy = HUDElements[interactivegui.movehud.selection].y()
			else
				HUDElements.NavigatableTable = createNavigatablePage(HUDElementsParse(HUDElements)) -- elements have changed position
			end
		end
	end,
	function(but) -- hide
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local enabled = HUDElements[interactivegui.movehud.selection].enabled()
			if enabled==nil then enabled=false end
			HUDElements[interactivegui.movehud.selection].enabled(not enabled)
		end
	end,
	function(but) -- default
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			if (HUDElements[interactivegui.movehud.selection].reset) then
				HUDElements[interactivegui.movehud.selection].reset()
			end
		end
	end,
	back = function(but) -- return to main menu
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			if interactivegui.movehud.selected then
				HUDElements[interactivegui.movehud.selection].x(HUDElements[interactivegui.movehud.selection].prevx)
				HUDElements[interactivegui.movehud.selection].y(HUDElements[interactivegui.movehud.selection].prevy)
				interactivegui.movehud.selected = false
			else
				toggleInteractiveGUI(true, {})
			end
		end
	end,
	coin = function()
		if guiinputs.P1.coin and not guiinputs.P1.previousinputs.coin then
			if interactivegui.movehud.selected then
				HUDElements[interactivegui.movehud.selection].x(HUDElements[interactivegui.movehud.selection].prevx)
				HUDElements[interactivegui.movehud.selection].y(HUDElements[interactivegui.movehud.selection].prevy)
				interactivegui.movehud.selected = false
			end
		end
	end,
	other = function()
		if interactivegui.movehud.selected then
			local diff
			local pos
			local x = HUDElements[interactivegui.movehud.selection].x()
			local y = HUDElements[interactivegui.movehud.selection].y()
			if guiinputs.P1.left then
				diff = scaleinputnum(guiinputs.P1.leftframecount)*-1
				pos = HUDElements[interactivegui.movehud.selection].x(x+diff)
				if (pos < 0) then HUDElements[interactivegui.movehud.selection].x(interactivegui.sw) end -- stay in bounds
			elseif guiinputs.P1.right then
				diff = scaleinputnum(guiinputs.P1.rightframecount)
				pos = HUDElements[interactivegui.movehud.selection].x(x+diff)
				if (pos > interactivegui.sw) then HUDElements[interactivegui.movehud.selection].x(0) end -- stay in bounds
			end

			if guiinputs.P1.up then
				diff = scaleinputnum(guiinputs.P1.upframecount)*-1
				pos = HUDElements[interactivegui.movehud.selection].y(y+diff)
				if (pos < 0) then HUDElements[interactivegui.movehud.selection].y(interactivegui.sh) end -- stay in bounds
			elseif guiinputs.P1.down then
				diff = scaleinputnum(guiinputs.P1.downframecount)
				pos = HUDElements[interactivegui.movehud.selection].y(y+diff)
				if (pos > interactivegui.sh) then HUDElements[interactivegui.movehud.selection].y(0) end -- stay in bounds
			end
		else
			local nav = HUDElements.NavigatableTable

			if not nav then -- just in case
				if guiinputs.P1.left and not guiinputs.P1.previousinputs.left then
					interactivegui.movehud.selection = interactivegui.movehud.selection-1
					if interactivegui.movehud.selection <= 0 then
						interactivegui.movehud.selection = #HUDElements
					end
				elseif guiinputs.P1.right and not guiinputs.P1.previousinputs.right then
					interactivegui.movehud.selection = interactivegui.movehud.selection+1
					if interactivegui.movehud.selection >= #HUDElements then
						interactivegui.movehud.selection = 1
					end
				end
				if guiinputs.P1.down and not guiinputs.P1.previousinputs.down then
					interactivegui.movehud.selection = interactivegui.movehud.selection-1
					if interactivegui.movehud.selection <= 0 then
						interactivegui.movehud.selection = #HUDElements
					end
				elseif guiinputs.P1.up and not guiinputs.P1.previousinputs.up then
					interactivegui.movehud.selection = interactivegui.movehud.selection+1
					if interactivegui.movehud.selection >= #HUDElements then
						interactivegui.movehud.selection = 1
					end
				end
			else
				if guiinputs.P1.left and not guiinputs.P1.previousinputs.left then
					interactivegui.movehud.selection = nav[interactivegui.movehud.selection].left or interactivegui.movehud.selection
				elseif guiinputs.P1.right and not guiinputs.P1.previousinputs.right then
					interactivegui.movehud.selection = nav[interactivegui.movehud.selection].right or interactivegui.movehud.selection
				end

				if guiinputs.P1.up and not guiinputs.P1.previousinputs.up then
					interactivegui.movehud.selection = nav[interactivegui.movehud.selection].up or interactivegui.movehud.selection
				elseif guiinputs.P1.down and not guiinputs.P1.previousinputs.down then
					interactivegui.movehud.selection = nav[interactivegui.movehud.selection].down or interactivegui.movehud.selection
				end
			end
		end
	end,
}

function moveHUDInteract()

	if not interactivegui.movehud.enabled then return end

	local helpButtons = {{name="SLCT", button="button1"}, {name="HIDE", button="button2"}, {name="DFLT", button="button3"}, funcs=moveHUDFuncs}

	local col = 0xff8000ff -- orange
	if interactivegui.movehud.selected then
		col = bit.bor(0xff0000ff, 0x00040000*(fc%40))
		helpButtons[1].name = "BACK"
	end

	local x = HUDElements[interactivegui.movehud.selection].x()
	local y = HUDElements[interactivegui.movehud.selection].y()
	helpButtons.funcs.name = HUDElements[interactivegui.movehud.selection].name

	local temp
	if helpElements.name ~= helpButtons.funcs.name then -- if this needs to be changed
		for _,v in ipairs(HUDElements[interactivegui.movehud.selection].extrafuncs or {}) do
			table.insert(helpButtons, {name=v.name, button=v.button})
			temp = copytable(helpButtons.funcs)
			helpButtons.funcs = nil -- avoid memory leaks
			helpButtons.funcs = temp
			table.insert(helpButtons.funcs, v.func)
		end
	end

	gui.pixel(x, y, col)
	col = 0xffffffff
	local enabled = HUDElements[interactivegui.movehud.selection].enabled()
	if not enabled then
		col = 0x0000ffff
		helpButtons[2].name = "SHOW"
	end

	local str = "("..x..","..y..")"
	local dispx, dispy = x, y-10
	if #str*LETTER_WIDTH+x>interactivegui.sw then dispx = interactivegui.sw - #str*LETTER_WIDTH end -- keep in bounds
	if dispy<0 then dispy = 0 end -- keep in bounds
	gui.text(dispx, dispy, str, col)

	-- don't display the tooltip if it will cover up elements
	toggledrawhelp = not (y>=interactivegui.sh-27 and (x>=(interactivegui.sw/2-helpElements.len*9) and x<=(interactivegui.sw/2+helpElements.len*9)))

	helpElements.buttons = helpButtons
end

----------------------------------------------
-- KEYBOARD
----------------------------------------------

local kb = { -- offset represents spacing for drawing to screen
	{'1','2','3','4','5','6','7','8','9', ["offset"] = 2},
	{'Q','W','E','R','T','Y','U','I','O','P', ["offset"] = 0},
	{'A','S','D','F','G','H','J','K','L', ["offset"] = 2},
	{'Z','X','C','V','B','N','M', ["offset"] = 6},
}
--fill in table
function blankKB()
	for _,v in ipairs(kb) do
		for _,k in ipairs(v) do
			guiinputs.kb.inputcount[k] = 0
		end
	end
end

function drawKB(x,y)
	for rowid, row in ipairs(kb) do
		for letterid,letter in ipairs(row) do
			local col="white"
			if inputs.hotkeys.funcs[letter] then col="green" end
			if guiinputs.kb.inputs and guiinputs.kb.inputs[letter] then col="red" end
			gui.text(x+row.offset+(letterid-1)*LETTER_WIDTH,y+8*(rowid-1),letter,col)
		end
	end
end

----------------------------------------------
-- STICK
----------------------------------------------
local stickimgs = {} -- one for each direction, numpad input
for i = 1,9 do
	stickimgs[i]=gd.createFromPng("resources/stick/"..i..".png"):gdStr() -- load images
end

function displayStick(x, y)
	local a = function(b) if b then return 1 end return 0 end -- bool to num
	local dir = 5+a(guiinputs.P1.up)*3 + a(guiinputs.P1.left)*-1 + a(guiinputs.P1.right)*1 + a(guiinputs.P1.down)*-3
	gui.gdoverlay(x, y, stickimgs[dir])
end

----------------------------------------------
-- BAR
----------------------------------------------
function drawFillBar(x, y, text, textoffset, barlen, barmaxsixe)
	gui.text(x, y, text, hud.fillbar.textcolour)
	x = x + textoffset
	gui.box(x, y, x+barmaxsixe+2, y+LETTER_HEIGHT-2, hud.fillbar.bgcolour, hud.fillbar.olcolour)
	if barlen>0 then
		x = x + 1
		y = y + 1
		gui.box(x, y, x+barlen, y+LETTER_HEIGHT-4, hud.fillbar.fillcolour, nil)
	end
end