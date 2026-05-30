assert(rb,"Run fbneo-training-mode.lua")

function readGUIInputs()
	local player, inp
	guiinputs.P1.previousinputs = nil
	guiinputs.P2.previousinputs = nil
	guiinputs.P1.previousinputs = copytable(guiinputs.P1)
	guiinputs.P2.previousinputs = copytable(guiinputs.P2)
	for i,v in pairs(joypad.get()) do -- check every button
		player = i:sub(1,2)
		inp = i:sub(4)
		if player == "P1" then
			guiinputs.P1[gamevars.constants.translationtable[gamevars.constants.translationtable[inp]]] = v
		elseif player == "P2" then
			guiinputs.P2[gamevars.constants.translationtable[gamevars.constants.translationtable[inp]]] = v
		end
	end

	--kb
	guiinputs.kb.previousinputs = nil
	guiinputs.kb.previousinputs = copytable(guiinputs.kb.inputs)
	guiinputs.kb.inputs = {}
	for i,v in pairs(input.get()) do -- check every button
		if i~="xmouse" and i~="ymouse" then -- mouse not implemented yet
			guiinputs.kb.inputs[i] = v
		end
	end

	for i,v in pairs(guiinputs.kb.inputcount) do
		if guiinputs.kb.inputs[i] then
			guiinputs.kb.inputcount[i] = v+1
		else
			guiinputs.kb.inputcount[i] = 0
		end
	end
end

function readInputs() -- these inputs can be altered for replays, swapping character etc., gui inputs won't be
	local player, input
	inputs.setinputs = {}
	inputs.raw = joypad.get() -- untouched inputs
	for i,v in pairs(inputs.raw) do -- check every button
		player = i:sub(1,2)
		input = i:sub(4)
		if player == "P1" then
			inputs.P1[input] = v
		elseif player == "P2" then
			inputs.P2[input] = v
		else
			inputs.other[i] = v
		end
	end
end

function combinePlayerInputs(P1, P2, other)

	if type(P1) ~= "table" or type(P2) ~= "table" then return end

	local combined = {}

	for i,v in pairs(P1) do
		combined["P1 "..i] = v
	end
	for i,v in pairs(P2) do
		combined["P2 "..i] = v
	end
	if type(other)=="table" then
		for i,v in pairs(other) do
			combined[i] = v
		end
	end

	inputs.properties.enableinputset = true
	return combined
end

function toggleSwapInputs(bool, vargs)
	if bool==nil then inputs.properties.enableinputswap = not inputs.properties.enableinputswap
	else inputs.properties.enableinputswap = bool end
	if vargs then vargs.swapinputs = false end
	toggleStates(vargs)
end

function swapInputs()
	if not inputs.properties.enableinputswap then return end
	gui.text(interactivegui.sw-#"REVERSED"*LETTER_WIDTH, 0, "REVERSED", "red")
	inputs.P1, inputs.P2 = inputs.P2, inputs.P1
	inputs.setinputs = combinePlayerInputs(inputs.P1, inputs.P2, inputs.other)
end

function swapPlayerDirection(inputframe) -- swaps the directions for a recording and returns a new table with the values
	local inputs = copytable(inputframe) -- shallow copy

	if inputs.Left==true then inputs.Right=true inputs.Left=false
	elseif inputs.Right==true then inputs.Left=true inputs.Right=false end

	return inputs
end

function freezePlayer(player)
	if player == 1 or not player then
		if inputs.properties.p1freeze then
			for i,_ in pairs(inputs.P1) do
				inputs.setinputs["P1 "..i] = false
				inputs.properties.enableinputset = true
			end
		end
	end

	if player == 2 or not player then
		if inputs.properties.p2freeze then
			for i,_ in pairs(inputs.P2) do
				inputs.setinputs["P2 "..i] = false
				inputs.properties.enableinputset = true
			end
		end
	end
end

local inputbuffer = {}

for i = 1, 9 do -- max 9 frames of delay
	inputbuffer[i] = joypad.get()
end

delayinputcount = 0

function delayInputs()
	if delayinputcount==0 then return end
	if next(inputs.setinputs) then -- processed input
		for i = delayinputcount, 2, -1 do
			inputbuffer[i] = {}
			inputbuffer[i] = copytable(inputbuffer[i-1])
		end -- advance frame
		inputbuffer[1] = {}
		inputbuffer[1] = inputs.setinputs

		inputs.setinputs = inputbuffer[delayinputcount]
	else -- raw
		for i = delayinputcount, 2, -1 do
			inputbuffer[i] = {p1={},p2={},other={}}
			inputbuffer[i].p1 = copytable(inputbuffer[i-1].p1)
			inputbuffer[i].p2 = copytable(inputbuffer[i-1].p2)
			inputbuffer[i].other = copytable(inputbuffer[i-1].other)
		end -- advance frame
		inputbuffer[1] = {}
		inputbuffer[1].p1 = inputs.P1 -- new inputs queued
		inputbuffer[1].p2 = inputs.P2
		inputbuffer[1].other = inputs.other

		inputs.setinputs = combinePlayerInputs(inputbuffer[delayinputcount].p1, inputbuffer[delayinputcount].p2, inputbuffer[delayinputcount].other) -- play input
	end
end

local function fillUpInputs(newinputs) -- fixes generated inputs by readding values ignored by the script
	local oldinputs = joypad.get()
	for k, v in pairs(oldinputs) do
		if newinputs[k] == nil then
			newinputs[k] = oldinputs[k]
		end
	end
end

function setInputs()
	if inputs.properties.enableinputset then
		fillUpInputs(inputs.setinputs)
		joypad.set(inputs.setinputs)
	end
	inputs.properties.enableinputset = false
end

function setHoldDirection(direction) -- getting a player to hold down/up etc.
	if direction == {} then
		inputs.properties.holddirection = nil
	else
		inputs.properties.holddirection = {}
		for _,v in ipairs(direction) do
			table.insert(inputs.properties.holddirection, gamevars.constants.inversetranslationtable[gamevars.constants.inversetranslationtable[v]])
		end
	end
	for _, v in pairs(inputs.properties.holddirection) do -- so it also happens same frame
		inputs.setinputs["P2 " ..v] = true
		inputs.P2[v] = true
	end
	inputs.properties.enableinputset = true
end

function applyHoldDirection() -- getting a player to hold down/up etc.
	if not inputs.properties.holddirection then return end
	for _, v in pairs(inputs.properties.holddirection) do
		inputs.setinputs["P2 " ..v] = true
		inputs.P2[v] = true
	end
	inputs.properties.enableinputset = true
end

function processGUIInputs()
	if REPLAY then return end
	--inspired by grouflons and crystal_cubes menus

	-- some general input stuff put at the start, could be put in its own function

	-- opening the menu and operating coin functionality
	if guiinputs.P1.coin and not guiinputs.P1.previousinputs.coin then -- one clean input
		guiinputs.P1.coinframestart = fc
		guiinputs.P1.coinpresscount = guiinputs.P1.coinpresscount+1
	end

	if fc - guiinputs.P1.coinframestart >= interactivegui.coinleniency and guiinputs.P1.coinframestart ~= 0 and not guiinputs.P1.coin then
		if (fc - guiinputs.P1.coinframestart > interactivegui.coinleniency*3) or interactivegui.enabled then
			guiinputs.P1.coinpresscount = 4
		end
		if interactivegui.replayeditor.enabled or interactivegui.movehud.enabled then -- do nothing
			guiinputs.P1.coinpresscount = 0
		end
		if guiinputs.P1.coinpresscount == 0 then
			toggleStates({}) -- clean up
		elseif guiinputs.P1.coinpresscount == 1 then
			togglePlayBack(nil, {})
		elseif guiinputs.P1.coinpresscount == 2 then
			toggleRecording(nil, {})
		elseif guiinputs.P1.coinpresscount == 3 then
			toggleSwapInputs(nil, {})
		else
			toggleInteractiveGUI(nil, {})
		end
		guiinputs.P1.coinframestart = 0
		guiinputs.P1.coinpresscount = 0
	end

	-- Count how many frames each input has been held
	if guiinputs.P1.left then
		guiinputs.P1.leftframecount = guiinputs.P1.leftframecount+1
	else
		guiinputs.P1.leftframecount = 0
	end

	if guiinputs.P1.right then
		guiinputs.P1.rightframecount = guiinputs.P1.rightframecount+1
	else
		guiinputs.P1.rightframecount = 0
	end

	if guiinputs.P1.down then
		guiinputs.P1.downframecount = guiinputs.P1.downframecount+1
	else
		guiinputs.P1.downframecount = 0
	end

	if guiinputs.P1.up then
		guiinputs.P1.upframecount = guiinputs.P1.upframecount+1
	else
		guiinputs.P1.upframecount = 0
	end
end