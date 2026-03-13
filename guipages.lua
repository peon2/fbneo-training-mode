assert(rb,"Run fbneo-training-mode.lua")

guipagenames = {
	Main = 1,
	Players = 2,
	Recording = 3,

	GeneralSettings = "generalsettings",
	RecordingExtraButtons = "recordingextrabuttons",
}

local ss = savestate.create(gamepath.."1.savestate") -- savestate

guielements = { -- some shorthands/parts of guipages that can be moved in or out
	backarrow = {
		text = "<",
		olcolour = colour.olcolour,
		info = "Back",
		canhotkey = true,
		func = previousPageAndSelection,
	},
	leftarrow = {
		text = "<<",
		x = 0,
		y = 0,
		olcolour = colour.olcolour,
		info = "Moves back one page",
		canhotkey = true,
		func = function()
			changePageAndSelection(interactivegui.page-1, 1)
		end,
	},
	rightarrow = {
		text = ">>",
		x = interactivegui.boxx2 - interactivegui.boxx - LETTER_WIDTH*3,
		y = 0,
		olcolour = colour.olcolour,
		info = "Moves forward one page",
		canhotkey = true,
		func = function()
			changePageAndSelection(interactivegui.page+1, 2)
		end,
	},
	falseleftarrow = {
		text = "<<",
		x = 0,
		y = 0,
		olcolour = colour.olcolour,
	},
	falserightarrow = {
		text = ">>",
		x = interactivegui.boxx2 - interactivegui.boxx - LETTER_WIDTH*3,
		y = 0,
		olcolour = colour.olcolour,
	}
}
local hudsettings = {
	text = "HUD Settings",
	alignment = "centre",
	y = 30,
	olcolour = colour.olcolour,
	info = "Move and hide parts of the HUD",
	canhotkey = true,
	func = function()
		toggleMoveHUD(true, {})
	end,
}
local coininputleniency = {
	text = "Coin Leniency 10",
	alignment = "centre",
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "This controls how many frames you have between each coin input.10 frames allows for faster usage but 15 might be easier.",
	func = function()
		changePageAndSelection("coinleniency", interactivegui.coinleniency-9)
	end,
	autofunc = function(this)
		this.text = "Coin Leniency "..(interactivegui.coinleniency)
		this.fillpercent = (interactivegui.coinleniency-10)/5
	end,
}
local inputdelay = {
	text = "Input Delay 0f",
	alignment = "centre",
	olcolour = colour.olcolour,
	info = "This controls how many frames of delay you have for each input, used to practice for delay netcode.",
	func = function()
		changePageAndSelection("inputdelay", 1+delayinputcount)
	end,
	autofunc = function(this)
		if delayinputcount>0 then
			this.text = "Input Delay "..delayinputcount.."f"
			this.textcolour = "red"
		else
			this.text = "Input Delay 0f"
			this.textcolour = interactivegui.textcolour
		end
	end,
}
local refillhealthspeed = {
	text = "Refill Health Speed 00",
	x = interactivegui.boxxhalflength-#"Refill Health Speed 000"*LETTER_WIDTH,
	olcolour = colour.olcolour,
	info = "The maximum number of frames it will take to refill health.",
	func = function()
		changePageAndSelection("refillhealthspeed")
	end,
	reset = function()
		resetConfig("p1refillhealthspeed")
		resetConfig("p2refillhealthspeed")
	end,
	autofunc = function(this)
		this.text = string.format("Refill Health Speed %2d", combovars.P1.refillhealthspeed)
	end,
}
local refillmeterspeed = {
	text = "Refill Meter Speed 00",
	x = interactivegui.boxxhalflength + LETTER_WIDTH,
	inline = true,
	olcolour = colour.olcolour,
	info = "The maximum number of frames it will take to refill meter.",
	func = function()
		changePageAndSelection("refillmeterspeed")
	end,
	reset = function()
		resetConfig("p1refillmeterspeed")
		resetConfig("p2refillmeterspeed")
	end,
	autofunc = function(this)
		this.text = string.format("Refill Meter Speed %2d", combovars.P1.refillmeterspeed)
	end,
}
selectedcolourconfig = selectedcolourconfig or nil -- global so it persists when this file is reloaded
currentcolour = currentcolour or { -- global so it persists when this file is reloaded
	red = 0xFF,
	blue = 0xFF,
	green = 0xFF,
	alpha = 0xFF
}
local colourconfigpicker = {
	text = "Current Config",
	rawx = interactivegui.boxxhalflength,
	y = 60,
	info = "The colour setting to edit.",
	olcolour = colour.olcolour,
	func = function()
		if selectedcolourconfig then
			changePageAndSelection("colourconfigpicker", selectedcolourconfig.pos)
		else
			changePageAndSelection("colourconfigpicker")
		end
	end,
	reset = function()
		if not selectedcolourconfig then return end
		resetConfig(selectedcolourconfig.id)
	end,
	autofunc = function(this)
		if selectedcolourconfig then
			local config = selectedcolourconfig.config
			this.text = selectedcolourconfig.displayname
			this.bgcolour = config.varpointer[config.name]
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
		else
			this.text = "None"
			this.bgcolour = nil
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
		end
	end
}
local savecolourconfig = {
	text = "Save Colour",
	x = 2,
	olcolour = colour.olcolour,
	func = function()
		if not selectedcolourconfig then return end
		local colour = currentcolour.red*0x01000000 + currentcolour.green*0x010000 + currentcolour.blue*0x0100 + currentcolour.alpha
		changeConfig(selectedcolourconfig.id, colour)
		reloadGUIPages()
	end
}
local colourpickerred = {
	text = "255",
	x = 15,
	y = colourconfigpicker.y+10,
	olcolour = colour.olcolour,
	info = "The Red component of the Colour",
	func = function()
		changePageAndSelection("colourpickerred")
	end,
	reset = function()
		currentcolour.red = 0xFF
	end,
	autofunc = function(this)
		this.text = string.format("%3d", currentcolour.red)
	end
}
local colourpickergreen = {
	text = "255",
	x = 15,
	olcolour = colour.olcolour,
	info = "The Green component of the Colour",
	func = function()
		changePageAndSelection("colourpickergreen")
	end,
	reset = function()
		currentcolour.green = 0xFF
	end,
	autofunc = function(this)
		this.text = string.format("%3d", currentcolour.green)
	end
}
local colourpickerblue = {
	text = "255",
	x = 15,
	olcolour = colour.olcolour,
	info = "The Blue component of the Colour",
	func = function()
		changePageAndSelection("colourpickerblue")
	end,
	reset = function()
		currentcolour.blue = 0xFF
	end,
	autofunc = function(this)
		this.text = string.format("%3d", currentcolour.blue)
	end
}

local directionset = {
	text = "Set CPU direction",
	info = "Allows you to set the direction CPU is holding",
	canhotkey = true,
	rawx = interactivegui.boxxhalflength,
	func = function() changePageAndSelection("setdirection", 1) end,
	olcolour = colour.olcolour,
	autofunc = function(this)
		local str = "CPU holding "
		for _, v in pairs(inputs.properties.holddirection or {}) do
			if v then
				str = str .. v .. " "
			end
		end
		str = str:sub(1, #str-1)
		if inputs.properties.holddirection and #inputs.properties.holddirection>0 then
			this.text = str
		else
			this.text = "Set CPU direction"
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end,
}
local hitboxstate = {
	text = "Hitboxes On",
	rawx = interactivegui.boxxhalflength,
	olcolour = colour.olcolour,
	info = "Toggles hitboxes on and off",
	canhotkey = true,
	reset = function()
		resetConfig("hitboxtoggle")
	end,
	func = 	function()
		changeConfig("hitboxtoggle", not getConfigValue("hitboxtoggle"))
	end,
	autofunc = 	function(this)
		if hitboxes.toggle then
			this.text = "Hitboxes On"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Hitboxes Off"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.boolfalse
		end
	end
}
local p1health = {
	text = "Health settings",
	rawx = interactivegui.boxxhalflength,
	y = 25,
	olcolour = colour.olcolour,
	info = "Controls how P1 health is handled",
	reset = function()
		resetConfig("p1refillhealthenabled") resetConfig("p1instantrefillhealth")
	end,
	func = function()
		changePageAndSelection(
			"p1health",
			(combovars.P1.refillhealthenabled and 3 or 0) + (combovars.P1.instantrefillhealth and -1 or 0)
		)
	end,
	autofunc = function(this)
		if not combovars.P1.refillhealthenabled then
			this.text = "No Health Refill"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.boolfalse
		elseif combovars.P1.refillhealthenabled and combovars.P1.instantrefillhealth then
			this.text = "Health Always Full"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Fill Health after Combo"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option2
		end
	end,
}
local p1healthmaxlen = #tostring(gamevars.P1.constants.maxhealth)
local p1healthmax = {
	text = "Max Health",
	rawx = interactivegui.boxxhalflength,
	y = 40,
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "Controls how much Health P1 gains",
	reset = function()
		resetConfig("p1maxhealth")
	end,
	func = function()
		changePageAndSelection("p1maxhealth")
	end,
	autofunc = function(this)
		local str = ""
		local health = gamevars.P1.maxhealth
		local healthlen = #tostring(health)
		if healthlen < p1healthmaxlen then
			for i = 1, p1healthmaxlen-healthlen do
				str = str .. " "
			end
			str = str .. health
		else
			str = health
		end
		this.text = "Max Health: "..str
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = gamevars.P1.maxhealth/gamevars.P1.constants.maxhealth
	end,
}
local p1meter = {
	text = "Meter settings",
	rawx = interactivegui.boxxhalflength,
	y = 55,
	olcolour = colour.olcolour,
	info = "Controls how P1 meter is handled",
	reset = function()
		resetConfig("p1refillmeterenabled") resetConfig("p1instantrefillmeter")
	end,
	func = function()
		changePageAndSelection(
			"p1meter",
			(combovars.P1.refillmeterenabled and 3 or 0) + (combovars.P1.instantrefillmeter and -1 or 0)
		)
	end,
	autofunc = function(this)
		if not combovars.P1.refillmeterenabled then
			this.text = "No Meter Refill"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.boolfalse
		elseif combovars.P1.refillmeterenabled and combovars.P1.instantrefillmeter then
			this.text = "Meter Always Full"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Fill Meter after Combo"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option2
		end
	end,
}
local p1metermaxlen = #tostring(gamevars.P1.constants.maxmeter)
local p1metermax = {
	text = "Max Meter",
	rawx = interactivegui.boxxhalflength,
	y = 70,
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "Controls how much Meter P1 gains",
	reset = function()
		resetConfig("p1maxmeter")
	end,
	func = function()
		changePageAndSelection("p1maxmeter")
	end,
	autofunc = function(this)
		local str = ""
		local meter = gamevars.P1.maxmeter
		local meterlen = #tostring(meter)
		if meterlen < p1metermaxlen then
			for i = 1, p1metermaxlen-meterlen do
				str = str .. " "
			end
			str = str .. meter
		else
			str = meter
		end
		this.text = "Max Meter: "..str
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = gamevars.P1.maxmeter/gamevars.P1.constants.maxmeter
	end,
}
local p2health = {
	text = "Health settings",
	rawx = interactivegui.boxxhalflength,
	y = 105,
	olcolour = colour.olcolour,
	info = "Controls how P2 health is handled",
	reset = function()
		resetConfig("p2refillhealthenabled") resetConfig("p2instantrefillhealth")
	end,
	func = function()
		changePageAndSelection(
			"p2health",
			(combovars.P2.refillhealthenabled and 3 or 0) + (combovars.P2.instantrefillhealth and -1 or 0)
		)
	end,
	autofunc = function(this)
		if not combovars.P2.refillhealthenabled then
			this.text = "No Health Refill"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.boolfalse
		elseif combovars.P2.refillhealthenabled and combovars.P2.instantrefillhealth then
			this.text = "Health Always Full"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Fill Health after Combo"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option2
		end
	end,
}
local p2healthmaxlen = #tostring(gamevars.P2.constants.maxhealth)
local p2healthmax = {
	text = "Max Health",
	rawx = interactivegui.boxxhalflength,
	y = 120,
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "Controls how much Health P2 gains",
	reset = function()
		resetConfig("p2healthmax")
	end,
	func = function()
		changePageAndSelection("p2healthmax")
	end,
	autofunc = function(this)
		local str = ""
		local health = gamevars.P2.maxhealth
		local healthlen = #tostring(health)
		if healthlen < p2healthmaxlen then
			for i = 1, p2healthmaxlen-healthlen do
				str = str .. " "
			end
			str = str .. health
		else
			str = health
		end
		this.text = "Max Health: "..str
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = gamevars.P2.maxhealth/gamevars.P2.constants.maxhealth
	end,
}
local p2metermaxlen = #tostring(gamevars.P2.constants.maxmeter)
local p2meter = {
	text = "Meter settings",
	rawx = interactivegui.boxxhalflength,
	y = 135,
	olcolour = colour.olcolour,
	info = "Controls how P2 meter is handled",
	reset = function()
		resetConfig("p2refillmeterenabled") resetConfig("p2instantrefillmeter")
	end,
	func = function()
		changePageAndSelection(
			"p2meter",
			(combovars.P2.refillmeterenabled and 3 or 0) + (combovars.P2.instantrefillmeter and -1 or 0)
		)
	end,
	autofunc = function(this)
		if not combovars.P2.refillmeterenabled then
			this.text = "No Meter Refill"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.boolfalse
		elseif combovars.P2.refillmeterenabled and combovars.P2.instantrefillmeter then
			this.text = "Meter Always Full"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Fill Meter after Combo"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option2
		end
	end,
}
local p2metermax = {
	text = "Max Meter",
	rawx = interactivegui.boxxhalflength,
	y = 150,
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "Controls how much Meter P2 gains",
	reset = function()
		resetConfig("p2metermax")
	end,
	func = function()
		changePageAndSelection("p2metermax")
	end,
	autofunc = function(this)
		local str = ""
		local meter = gamevars.P2.maxmeter
		local meterlen = #tostring(meter)
		if meterlen < p2metermaxlen then
			for i = 1, p2metermaxlen-meterlen do
				str = str .. " "
			end
			str = str .. meter
		else
			str = meter
		end
		this.text = "Max Meter: "..str
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = gamevars.P2.maxmeter/gamevars.P2.constants.maxmeter
	end,
}
local replaynonex = interactivegui.boxx2-70-interactivegui.boxx
local replaynoney = 2
local hitplayback = {
	text = "Hit Slot",
	rawx = interactivegui.boxxhalflength,
	olcolour = colour.olcolour,
	info = "Plays back the respective replay slot after hit",
	reset = function()
		resetConfig("recordinghitslot")
	end,
	func = function()
		if recording.hitslot then
			changePageAndSelection("hitslot", recording.hitslot)
		else
			changePageAndSelection("hitslot", REPLAY_SLOTS_COUNT+1)
		end
	end,
	autofunc = function(this)
		if recording.hitslot == 0 then
			this.text = "Hit Slot"
			this.bgcolour = colour.bgcolour
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		else
			this.text = "Hit Slot "..recording.hitslot
			this.bgcolour = colour.option2
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		end
	end
}
local savestateplayback = {
	text = "Savestate Slot",
	rawx = interactivegui.boxxhalflength,
	olcolour = colour.olcolour,
	info = "Plays back the respective replay slot after loading a savestate",
	reset = function()
		resetConfig("recordingsavestateslot")
	end,
	func = function()
		if recording.savestateslot then
			changePageAndSelection("savestateslot", recording.savestateslot)
		else
			changePageAndSelection("savestateslot", REPLAY_SLOTS_COUNT+1)
		end
	end,
	autofunc = function(this)
		if recording.savestateslot == 0 then
			this.text = "Savestate Slot"
			this.bgcolour = colour.bgcolour
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		else
			this.text = "Savestate Slot "..recording.savestateslot
			this.bgcolour = colour.option2
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		end
	end,
}
local replayautoturn = {
	text = "Auto-Turn",
	rawx = interactivegui.boxxhalflength,
	olcolour = colour.olcolour,
	info = "Allows you to control whether or not a replay will reverse directions while playing",
	canhotkey = true,
	reset = function()
		resetConfig("recordingautoturn")
	end,
	func = function()
		changeConfig("recordingautoturn", not getConfigValue("recordingautoturn"))
	end,
	autofunc = function(this)
		if recording.autoturn then
			this.text = "Auto-Turn"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Don't Auto-Turn"
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.boolfalse
		end
	end,
}
local replaysave = {
	text = "Save",
	x = interactivegui.boxxhalflength-#"Save"*LETTER_HALFWIDTH-40,
	olcolour = colour.olcolour,
	info = "Save Replays and Replay Settings",
	canhotkey = true,
	func = function() replaySave() end,
}
local replayload = {
	text = "Load",
	x = interactivegui.boxxhalflength-#"Load"*LETTER_HALFWIDTH,
	olcolour = colour.olcolour,
	inline = true,
	info = "Load Replays and Replay Settings",
	canhotkey = true,
	func = function() replayLoad() end,
}
local replayeditortoggle = {
	text = "Replay Editor",
	x = interactivegui.boxxhalflength-#"Replay Editor"*LETTER_HALFWIDTH,
	canhotkey = true,
	olcolour = colour.olcolour,
	info = "View and set replay inputs",
	func = 	function() toggleReplayEditor(nil, {}) end,
}
local replaysnipping = {
	text = "Snipping Replays",
	rawx = interactivegui.boxxhalflength,
	olcolour = colour.olcolour,
	info = "Controls whether there's a space at the start or end of replays",
	reset = function()
		resetConfig("recordingskiptostart")
		resetConfig("recordingskiptofinish")
	end,
	func = function()
		changePageAndSelection(
			"replaysnipping",
			(recording.skiptostart and 1 or 0) + (recording.skiptofinish and 2 or 0)+1
		)
	end,
	autofunc = 	function(this)
		if recording.skiptostart and recording.skiptofinish then
			this.text = "Skip Start & End"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option3
		elseif recording.skiptostart then
			this.text = "Skip Start"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option1
		elseif recording.skiptofinish then
			this.text = "Skip End"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option2
		else
			this.text = "Snipping Replays"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = nil
		end
	end,
}
local playerrecording = {
	text = "Player Recording",
	rawx = interactivegui.boxxhalflength,
	olcolour = colour.olcolour,
	info = "Controls which player(s) are recorded and played back",
	reset = function()
		resetConfig("recordingreplayp1") resetConfig("recordingreplayp2")
	end,
	func = function()
		changePageAndSelection("playerrecording", (recording.replayP1 and 1 or 0) + (recording.replayP2 and 2 or 0))
	end,
	autofunc = function(this)
		if recording.replayP1 and recording.replayP2 then
			this.text = "Record P1 and P2"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option3
		elseif recording.replayP1 then
			this.text = "Record P1"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option1
		elseif recording.replayP2 then
			this.text = "Record P2"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.option2
		end
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end,
}
local maxdelay = 60 -- maximum 60f of delay
local replaystartingtime = {
	text = "Replay Delay",
	x = 2,
	rawx = interactivegui.boxxhalflength,
	info = "Delay before Playback begins",
	olcolour = colour.olcolour,
	reset = function()
		resetConfig("recordingdelay")
	end,
	func = function()
		changePageAndSelection("replaystartingtime")
	end,
	autofunc = function(this)
		if recording.delay~=0 then
			this.text = string.format("%2df Delayed Start", recording.delay)
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.fillpercent = recording.delay/maxdelay
		else
			this.text = "Replay Delay"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.bgcolour
			this.fillpercent = 0
		end
	end,
}
local replayrandomisedelay = {
	text = "Randomise Delay",
	x = 1,
	rawx = interactivegui.boxxhalflength-70,
	inline = true,
	info = "Toggle whether the Delay is a random value from 0 to the set Replay Delay",
	olcolour = colour.olcolour,
	reset = function()
		resetConfig("recordingrandomisedelay")
	end,
	func = function()
		changeConfig("recordingrandomisedelay", not getConfigValue("recordingrandomisedelay"))
	end,
	autofunc = function(this)
		if recording.randomisedelay then
			this.text = "Randomise Delay"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Don't Randomise"
			this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			this.bgcolour = colour.bgcolour
		end
	end,
}

guinavigationtable = {}

guipages = {}

guipages[guipagenames.Main] = {
	title = {
		text = "Basic Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	hudsettings,
	{
		text = "General Settings",
		alignment = "centre",
		olcolour = colour.olcolour,
		info = "Non-Game Settings",
		func = function() changePageAndSelection(guipagenames.GeneralSettings, 2) end
	},
	{
		text = "Save State",
		x = interactivegui.boxxhalflength-2-#"Save State"*LETTER_WIDTH,
		olcolour = colour.olcolour,
		info = "Make a savestate",
		canhotkey = true,
		func = 	function() savestate.save(ss) end,
	},
	{
		text = "Load State",
		x = interactivegui.boxxhalflength+2,
		inline = true,
		olcolour = colour.olcolour,
		info = "Load a savestate",
		canhotkey = true,
		func = 	function() if ss then savestate.load(ss) savestatePlayBack() end end,
	},
	{
		text = "Add-On",
		alignment = "centre",
		olcolour = colour.olcolour,
		func = 	function() changePageAndSelection("addonpage1", 1) end,
	},
}
guipages[guipagenames.Players] = {
	title = {
		text = "Player Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	P1 = {
		text = "P1",
		x = 2,
		y = 15,
	},
	P2 = {
		text = "P2",
		x = 2,
		y = 95,
	},
}
guipages[guipagenames.Recording] = {
		guielements.leftarrow,
		guielements.rightarrow,
		title = {
			text = "Recording Menu"
		},
		{
			text = "Don't Loop",
			rawx = interactivegui.boxxhalflength,
			canhotkey = true,
			y = 15,
			info = "Controls whether or not playback loops until you press play again",
			olcolour = colour.olcolour,
			reset = function()
				resetConfig("recordingloop")
			end,
			func = function()
				changeConfig("recordingloop", not getConfigValue("recordingloop"))
			end,
			autofunc = function(this)
				if recording.loop then
					this.text = "Loop"
					this.x = this.rawx - #this.text*LETTER_HALFWIDTH
					this.bgcolour = colour.booltrue
				else
					this.text = "Don't Loop"
					this.x = this.rawx - #this.text*LETTER_HALFWIDTH
					this.bgcolour = colour.boolfalse
				end
			end,
		},
		{
			text = "Slot ",
			rawx = interactivegui.boxxhalflength,
			olcolour = colour.olcolour,
			reset = function()
				resetConfig("recordingslot")
			end,
			func = function()
				changePageAndSelection("recordingslot", recording.recordingslot)
			end,
			autofunc = function(this) -- calls every frame this is visible
				this.text = "Slot "..recording.recordingslot
				this.x = this.rawx - #this.text*LETTER_HALFWIDTH
			end,
			info = "Set the current recording slot",
		},
		savestateplayback,
		{
			text = "Don't Randomise",
			rawx = interactivegui.boxxhalflength,
			info = "Random playback between all slots that have been recorded into",
			canhotkey = true,
			olcolour = colour.olcolour,
			reset = function()
				resetConfig("recordingrandomise")
			end,
			func = function()
				changeConfig("recordingrandomise", not getConfigValue("recordingrandomise"))
			end,
			autofunc = function(this)
				if recording.randomise then
					this.text = "Randomise Slot"
					this.x = this.rawx - #this.text*LETTER_HALFWIDTH
					this.bgcolour = colour.booltrue
				else
					this.text = "Don't Randomise Slot"
					this.x = this.rawx - #this.text*LETTER_HALFWIDTH
					this.bgcolour = colour.bgcolour
				end
			end,
		},
		replaysnipping,
		playerrecording,
		replaystartingtime,
		replayrandomisedelay,
		other_func = function()
			drawReplayInfo(replaynonex + interactivegui.boxx, replaynoney + interactivegui.boxy + 3)
		end
	}

guipages[guipagenames.GeneralSettings] = {
	title = {
		text = "Config Settings"
	},
	guielements.backarrow,
	coininputleniency,
	inputdelay,
	refillhealthspeed,
	refillmeterspeed,
	colourconfigpicker,
	colourpicker = {
		text = "Colour Picker",
		x = 0,
		y = colourpickerred.y - 10
	},
	colouredsquare = {
		text = "  ",
		x = colourpickerred.x + 44,
		y = colourpickerred.y - 10,
		olcolour = colour.olcolour,
		autofunc = function(this)
			this.bgcolour = currentcolour.red*0x01000000 + currentcolour.green*0x010000 + currentcolour.blue*0x0100 + currentcolour.alpha
		end,
	},
	red = {
		text = "R",
		x = colourpickerred.x-9,
		y = colourpickerred.y
	},
	green = {
		text = "G",
		x = colourpickergreen.x-9,
		y = colourpickerred.y + interactivegui.linespacing
	},
	blue = {
		text = "B",
		x = colourpickerblue.x-9,
		y = colourpickerred.y + interactivegui.linespacing*2
	},
	colourpickerred,
	colourpickergreen,
	colourpickerblue,
	savecolourconfig,
	resetcolourconfig,
}
guipages[guipagenames.RecordingExtraButtons] = {
	title = {
		text = "Extra Buttons"
	},
	guielements.backarrow,
	Info = {
		text = "These buttons are intended to be bound",
		y = 20,
	},
	Info2 = {
		text = "to hotkeys to use while training",
		y = 30,
	},
	{
		text = "Next Slot",
		x = 2,
		y = 45,
		info = "Switch to the next replay slot",
		canhotkey = true,
		olcolour = colour.olcolour,
		func = function()
			if recording.recordingslot == REPLAY_SLOTS_COUNT then
				changeConfig("recordingslot", 1)
			else
				changeConfig("recordingslot", getConfigValue("recordingslot")+1)
			end
			if not interactivegui.enabled then
				local text = "Replay Slot "..getConfigValue("recordingslot")
				addTextItem(text, interactivegui.sw-#text*LETTER_WIDTH, 0, "red", 5)
			end
		end,
	},
	{
		text = "Previous Slot",
		x = 72,
		inline = true,
		info = "Switch to previous next replay slot",
		canhotkey = true,
		olcolour = colour.olcolour,
		func = function()
			if recording.recordingslot == 1 then
				changeConfig("recordingslot", REPLAY_SLOTS_COUNT)
			else
				changeConfig("recordingslot", getConfigValue("recordingslot")-1)
			end
			if not interactivegui.enabled then
				local text = "Replay Slot "..getConfigValue("recordingslot")
				addTextItem(text, interactivegui.sw-#text*LETTER_WIDTH, 0, "red", 5)
			end
		end,
	},
	{
		text = "Next Saveslot",
		x = 2,
		info = "Switch to the next savestate slot",
		canhotkey = true,
		olcolour = colour.olcolour,
		func = function()
			if recording.savestateslot == REPLAY_SLOTS_COUNT then
				changeConfig("recordingsavestateslot", 0)
			else
				changeConfig("recordingsavestateslot", getConfigValue("recordingsavestateslot")+1)
			end
			if not interactivegui.enabled then
				local text = "Replay Slot "..getConfigValue("recordingsavestateslot")
				addTextItem(text, interactivegui.sw-#text*LETTER_WIDTH, 0, "red", 5)
			end
		end,
	},
	{
		text = "Previous Saveslot",
		x = 72,
		inline = true,
		info = "Switch to previous next savestate slot",
		canhotkey = true,
		olcolour = colour.olcolour,
		func = function()
			if recording.savestateslot == 0 then
				changeConfig("recordingsavestateslot", REPLAY_SLOTS_COUNT)
			else
				changeConfig("recordingsavestateslot", getConfigValue("recordingsavestateslot")-1)
			end
			if not interactivegui.enabled then
				local text = "Replay Slot "..getConfigValue("recordingsavestateslot")
				addTextItem(text, interactivegui.sw-#text*LETTER_WIDTH, 0, "red", 5)
			end
		end,
	},
	{
		text = "Next Hitslot",
		x = 2,
		info = "Switch to the next hit slot",
		canhotkey = true,
		olcolour = colour.olcolour,
		func = function()
			if recording.hitslot == REPLAY_SLOTS_COUNT then
				changeConfig("recordinghitslot", 0)
			else
				changeConfig("recordinghitslot", getConfigValue("recordinghitslot")+1)
			end
			if not interactivegui.enabled then
				local text = "Replay Slot "..getConfigValue("recordinghitslot")
				addTextItem(text, interactivegui.sw-#text*LETTER_WIDTH, 0, "red", 5)
			end
		end,
	},
	{
		text = "Previous Hitslot",
		x = 72,
		inline = true,
		info = "Switch to previous next hit slot",
		canhotkey = true,
		olcolour = colour.olcolour,
		func = function()
			if recording.hitslot == 0 then
				changeConfig("recordinghitslot", REPLAY_SLOTS_COUNT)
			else
				changeConfig("recordinghitslot", getConfigValue("recordinghitslot")-1)
			end
			if not interactivegui.enabled then
				local text = "Replay Slot "..getConfigValue("recordinghitslot")
				addTextItem(text, interactivegui.sw-#text*LETTER_WIDTH, 0, "red", 5)
			end
		end,
	},
	other_func = function()
		drawReplayInfo(replaynonex + interactivegui.boxx, replaynoney + interactivegui.boxy + 3)
	end
}

if hitboxesReg then -- if a hitbox file is loaded
	table.insert(guipages[guipagenames.Main], hitboxstate)
end

if translationtable then -- if inputs can be processed
	table.insert(guipages[guipagenames.Main], directionset)
	guipages.setdirection = createFauxPage(guipages[guipagenames.Main])
	guipages.setdirection[1] = {
		text = "",
		x = -200, -- should be 'invisible'
		y = -200,
		func = function()
			local direction = {}
			if (guiinputs.P1["up"]) then
				table.insert(direction, "up")
			end
			if (guiinputs.P1["down"]) then
				table.insert(direction, "down")
			end
			if (guiinputs.P1["left"]) then
				table.insert(direction, "left")
			end
			if (guiinputs.P1["right"]) then
				table.insert(direction, "right")
			end
			setHoldDirection(direction)
			previousPageAndSelection()
		end,
		autofunc = 	function() displayStick(interactivegui.boxx + interactivegui.boxxhalflength + 40, directionset.y-1) end,
	}
end

-- if health is set up in file
if gamefunctions.writeplayeronehealth and gamevars.P1.constants.maxhealth then -- if health is set up in file
	table.insert(guipages[guipagenames.Players], p1health)
	table.insert(guipages[guipagenames.Players], p1healthmax)
end

-- if meter is set up in file
if gamevars.P1.constants.maxmeter and gamefunctions.readplayeronemeter and gamefunctions.writeplayeronemeter then
	table.insert(guipages[guipagenames.Players], p1meter)
	table.insert(guipages[guipagenames.Players], p1metermax)
end

if gamefunctions.writeplayertwohealth and gamevars.P2.constants.maxhealth then -- if health is set up in file
	table.insert(guipages[guipagenames.Players], p2health)
	table.insert(guipages[guipagenames.Players], p2healthmax)
end

if gamevars.P2.constants.maxmeter and gamefunctions.readplayertwometer and gamefunctions.writeplayertwometer then
	table.insert(guipages[guipagenames.Players], p2meter)
	table.insert(guipages[guipagenames.Players], p2metermax)
end

if gamefunctions.playertwofacingleft then
	table.insert(guipages[guipagenames.Recording], replayautoturn)
end

if gamefunctions.readplayertwohealth and gamefunctions.playertwoinhitstun then
	table.insert(guipages[guipagenames.Recording], hitplayback)
end

if gamefunctions.tablesave and gamefunctions.tableload then
	table.insert(guipages[guipagenames.Recording], replaysave)
	table.insert(guipages[guipagenames.Recording], replayload)
end

if gamevars.constants.translationtable then -- replay editor
	table.insert(guipages[guipagenames.Recording], replayeditortoggle)
end

local replayextrabuttons = {
	text = "Extra Buttons",
	x = interactivegui.boxxhalflength-#"Extra Buttons"*LETTER_HALFWIDTH-60,
	inline = true,
	olcolour = colour.olcolour,
	bgcolour = colour.option3,
	info = "Extra buttons for Replay functions",
	func = 	function() changePageAndSelection(guipagenames.RecordingExtraButtons, 2) end,
}
table.insert(guipages[guipagenames.Recording], replayextrabuttons)

if fexists("games/"..gamename.."/guipages.lua") then
	dofile("games/"..gamename.."/guipages.lua")
	table.insert(guipages, guicustompage)
end


--[[
	guinavigationtable[1] = {createNavigatablePage}
	guinavigationtable[2] = {createNavigatablePage}
	.
	.
	.
--]]
-- format the tables for better navigation and format the info to fit the screen better
function formatGUITables()
	local infomax = interactivegui.boxxlength/LETTER_WIDTH
	local halfpagex = interactivegui.boxxhalflength
	for pagename, page in pairs(guipages) do
		if page.title then
			if not page.title.x then
				page.title.x = halfpagex - (#page.title.text)*LETTER_HALFWIDTH
			end
			if not page.title.y then
				page.title.y = 1
			end
		end
		if (page[1]) then page[1].y = page[1].y or 0 end
		local pageelements = {}
		for elementid, element in ipairs(page) do
			if element.alignment == "centre" then
				element.x = halfpagex - (#element.text)*LETTER_HALFWIDTH
			elseif element.alignment == "left" then
				x = LETTER_WIDTH
			else
				element.x = element.x or 0 -- autospacing/failsafe
			end
			if element.autofunc then element:autofunc() end -- make sure x and y are set
			if not element.y then
				if element.inline then
					element.y = page[elementid-1].y
				else
					element.y = page[elementid-1].y+interactivegui.linespacing
				end
			end

			-- parse info to fit within the screen
			if element.info and type(element.info)=="string" then -- if it's not in a string format assume its already formatted
				local str = element.info
				element.info = {}
				while (#str>infomax) do
					local str2 = str:sub(1,infomax-1):reverse()
					str = str:sub(infomax)
					local hasdelimiter = false
					local pos =str2:find("\n")
					if pos then
						str = str2:reverse():sub(infomax-pos+1) .. str
						table.insert(element.info,str2:reverse():sub(1,infomax-pos-1))
						hasdelimiter=true
					end
					pos=str2:find("%.")
					if pos and not hasdelimiter then
						str = str2:reverse():sub(infomax-pos+1) .. str
						table.insert(element.info,str2:reverse():sub(1,infomax-pos))
						hasdelimiter=true
					end
					pos=str2:find(" ")
					if pos and not hasdelimiter then
						str = str2:reverse():sub(infomax-pos+1) .. str
						table.insert(element.info,str2:reverse():sub(1,infomax-pos-1))
						hasdelimiter=true
					end
					if not hasdelimiter then -- couldn't find a delimiter
						table.insert(element.info,str2:reverse())
					end
				end
				table.insert(element.info, str)
			end
			local textlen = (element.text and #element.text or 0)*LETTER_HALFWIDTH
			table.insert(pageelements, {id=elementid, x=element.x + textlen, y=element.y})
		end
		guinavigationtable[pagename] = createNavigatablePage(pageelements)
	end
end

formatGUITables()

-- pop up menus and stuff that can be pre-computed

-- Main Page


-- Player Page

if gamefunctions.writeplayeronehealth and gamevars.P1.constants.maxhealth then -- p1health
	local Elements = {
		{
			text = "No Health Refill",
			x = p1health.rawx-#"No Health Refill"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				changeConfig("p1refillhealthenabled", false)
			end end
		},
		{
			text = "Health Always Full",
			x = p1health.rawx-#"Health Always Full"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				changeConfig("p1refillhealthenabled", true)
				changeConfig("p1instantrefillhealth", true)
			end end
		},
	}
	if gamefunctions.playeroneinhitstun then -- won't always be available
		Elements[3] = {
			text = "Fill Health after Combo",
			x = p1health.rawx-#"Fill Health after Combo"*LETTER_HALFWIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("p1refillhealthenabled", true)
				changeConfig("p1instantrefillhealth", false)
			end end
		}
	end
	guipages.p1health = createPopUpMenu(
		guipages[guipagenames.Players],
		Elements,
		nil,
		p1health.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end

if gamefunctions.writeplayeronehealth and gamevars.P1.constants.maxhealth then -- p1maxhealth
	local len = #tostring(gamevars.P1.constants.maxhealth)
	local uf = 	function(n, k)
		if n then
			local maxhealth = getConfigValue("p1maxhealth")+n
			changeConfig("p1maxhealth", maxhealth)
			return maxhealth
		end
		if k then
			changeConfig("p1maxhealth", k)
			return k
		end
		return getConfigValue("p1maxhealth")
	end
	guipages.p1maxhealth = createScrollingBar(
		guipages[guipagenames.Players],
		"Max Health: "..gamevars.P1.constants.maxhealth,
		p1healthmax.rawx - #("Max Health: "..gamevars.P1.constants.maxhealth)*LETTER_HALFWIDTH,
		p1healthmax.y,
		1,
		gamevars.P1.constants.maxhealth,
		0,
		uf,
		function(this)
			local str = ""
			local health = gamevars.P1.maxhealth
			local healthlen = #tostring(health)
			if healthlen < len then
				for i = 1, len-healthlen do
					str = str .. " "
				end
				str = str .. health
			else
				str = health
			end
			this.text = "Max Health: "..str
			this.x = p1healthmax.rawx - #this.text*LETTER_HALFWIDTH
		end
	)
end

if gamevars.P1.constants.maxmeter and gamefunctions.readplayeronemeter and gamefunctions.writeplayeronemeter then -- p1meter
	local Elements = {
		{
			text = "No Meter Refill",
			x = p1meter.rawx-#"No Meter Refill"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				changeConfig("p1refillmeterenabled", false)
			end end
		},
		{
			text = "Meter Always Full",
			x = p1meter.rawx-#"Meter Always Full"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				changeConfig("p1refillmeterenabled", true)
				changeConfig("p1instantrefillmeter", true)
			end
		end
		},
	}
	if gamefunctions.playertwoinhitstun then -- won't always be available
		Elements[3] = {
			text = "Fill Meter after Combo",
			x = p1meter.rawx-#"Fill Meter after Combo"*LETTER_HALFWIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("p1refillmeterenabled", true)
				changeConfig("p1instantrefillmeter", false)
			end end
		}
	end
	guipages.p1meter = createPopUpMenu(
		guipages[guipagenames.Players],
		Elements,
		nil,
		p1meter.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end

if gamevars.P1.constants.maxmeter and gamefunctions.readplayeronemeter and gamefunctions.writeplayeronemeter then -- p1maxmeter
	local len = #tostring(gamevars.P1.constants.maxmeter)
	local uf = 	function(n, k)
		if n then
			local maxmeter = getConfigValue("p1maxmeter")+n
			changeConfig("p1maxmeter", maxmeter)
			return maxmeter
		end
		if k then
			changeConfig("p1maxmeter", k)
			return k
		end
		return getConfigValue("p1maxmeter")
	end
	guipages.p1maxmeter = createScrollingBar(
		guipages[guipagenames.Players],
		"Max Meter: "..gamevars.P1.constants.maxmeter,
		p1metermax.rawx - #("Max Meter: "..gamevars.P1.constants.maxmeter)*LETTER_HALFWIDTH,
		p1metermax.y,
		0,
		gamevars.P1.constants.maxmeter,
		nil,
		uf,
		function(this)
			local str = ""
			local meter = gamevars.P1.maxmeter
			local meterlen = #tostring(meter)
			if meterlen < len then
				for i = 1, len-meterlen do
					str = str .. " "
				end
				str = str .. meter
			else
				str = meter
			end
			this.text = "Max Meter: "..str
			this.x = p1metermax.rawx - #this.text*LETTER_HALFWIDTH
		end
	)
end

if gamefunctions.writeplayertwohealth and gamevars.P2.constants.maxhealth then -- p2health
	local Elements = {
		{
			text = "No Health Refill",
			x = p2health.rawx-#"No Health Refill"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				changeConfig("p2refillhealthenabled", false)
			end end
		},
		{
			text = "Health Always Full",
			x = p2health.rawx-#"Health Always Full"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				changeConfig("p2refillhealthenabled", true)
				changeConfig("p2instantrefillhealth", true)
			end
		end
		},
	}
	if gamefunctions.playertwoinhitstun then -- won't always be available
		Elements[3] = {
			text = "Fill Health after Combo",
			x = p2health.rawx-#"Fill Health after Combo"*LETTER_HALFWIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("p2refillhealthenabled", true)
				changeConfig("p2instantrefillhealth", false)
			end end
		}
	end
	guipages.p2health = createPopUpMenu(
		guipages[guipagenames.Players],
		Elements,
		nil,
		p2health.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end

if gamefunctions.writeplayertwohealth and gamevars.P2.constants.maxhealth then -- p2healthmax
	local len = #tostring(gamevars.P2.constants.maxhealth)
	local uf = 	function(n, k)
		if n then
			local maxhealth = getConfigValue("p2healthmax")+n
			changeConfig("p2healthmax", maxhealth)
			return maxhealth
		end
		if k then
			changeConfig("p2healthmax", k)
			return k
		end
		return gamevars.P2.maxhealth
	end
	guipages.p2healthmax = createScrollingBar(
		guipages[guipagenames.Players],
		"Max Health: "..gamevars.P2.constants.maxhealth,
		p2healthmax.rawx - #("Max Health: "..gamevars.P2.constants.maxhealth)*LETTER_HALFWIDTH,
		p2healthmax.y,
		1,
		gamevars.P2.constants.maxhealth,
		0,
		uf,
		function(this)
			local str = ""
			local health = gamevars.P2.maxhealth
			local healthlen = #tostring(health)
			if healthlen < len then
				for i = 1, len-healthlen do
					str = str .. " "
				end
				str = str .. health
			else
				str = health
			end
			this.text = "Max Health: "..str
			this.x = p2healthmax.rawx - #this.text*LETTER_HALFWIDTH
		end
	)
end

if gamevars.P2.constants.maxmeter and gamefunctions.readplayertwometer and gamefunctions.writeplayertwometer then -- p2meter
	local Elements = {
		{
			text = "No Meter Refill",
			x = p2meter.rawx-#"No Meter Refill"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				changeConfig("p2refillmeterenabled", false)
			end end
		},
		{
			text = "Meter Always Full",
			x = p2meter.rawx-#"Meter Always Full"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				changeConfig("p2refillmeterenabled", true)
				changeConfig("p2instantrefillmeter", true)
			end end
		},
	}
	if gamefunctions.playertwoinhitstun then -- won't always be available
		Elements[3] = {
			text = "Fill Meter after Combo",
			x = p2meter.rawx-#"Fill Meter after Combo"*LETTER_HALFWIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("p2refillmeterenabled", true)
				changeConfig("p2instantrefillmeter", false)
			end end
		}
	end
	guipages.p2meter = createPopUpMenu(
		guipages[guipagenames.Players],
		Elements,
		nil,
		p2meter.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end

if gamevars.P2.constants.maxmeter and gamefunctions.readplayertwometer and gamefunctions.writeplayertwometer then -- p2metermax
	local len = #tostring(gamevars.P2.constants.maxmeter)
	local uf = 	function(n, k)
		if n then
			local maxmeter = getConfigValue("p2maxmeter")+n
			changeConfig("p2maxmeter", maxmeter)
			return maxmeter
		end
		if k then
			changeConfig("p2maxmeter", k)
			return k
		end
		return getConfigValue("p2maxmeter")
	end
	guipages.p2metermax = createScrollingBar(
		guipages[guipagenames.Players],
		"Max Meter: "..gamevars.P2.constants.maxmeter,
		p2metermax.rawx - #("Max Meter: "..gamevars.P2.constants.maxmeter)*LETTER_HALFWIDTH,
		p2metermax.y,
		0,
		gamevars.P2.constants.maxmeter,
		nil,
		uf,
		function(this)
			local str = ""
			local meter = gamevars.P2.maxmeter
			local meterlen = #tostring(meter)
			if meterlen < len then
				for i = 1, len-meterlen do
					str = str .. " "
				end
				str = str .. meter
			else
				str = meter
			end
			this.text = "Max Meter: "..str
			this.x = p2metermax.rawx - #this.text*LETTER_HALFWIDTH
		end
	)
end

-- Replay Page

do -- recordingslot
	local rf = function() return function() previousPageAndSelection() end end
	local sf = function(n) return function() recording.recordingslot = n end end
	guipages.recordingslot = createPopUpMenu(
		guipages[guipagenames.Recording],
		nil,
		nil,
		-200, -- 'hide' the buttons
		REPLAY_SLOTS_COUNT,
		sf,
		rf
	)
end
do -- replaysnipping
	local elements = {
		{
			text = "Snipping Replays Off",
			x = replaysnipping.rawx-#"Snipping Replays Off"*LETTER_HALFWIDTH,
			bgcolour = colour.bgcolour,
			selectfunc = function() return function()
				changeConfig("recordingskiptostart", false) -- turn both off
				changeConfig("recordingskiptofinish", false)
			end end,
		},
		{
			text = "Skip Start",
			x = replaysnipping.rawx-#"Skip Start"*LETTER_HALFWIDTH,
			bgcolour = colour.option1,
			selectfunc = function() return function()
				changeConfig("recordingskiptostart", true)
				changeConfig("recordingskiptofinish", false)
			end end,
		},
		{
			text = "Skip End",
			x = replaysnipping.rawx-#"Skip End"*LETTER_HALFWIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("recordingskiptostart", false)
				changeConfig("recordingskiptofinish", true)
			end end,
		},
		{
			text = "Skip Start & End",
			x = replaysnipping.rawx-#"Skip Start & End"*LETTER_HALFWIDTH,
			bgcolour = colour.option3,
			selectfunc = function() return function()
				changeConfig("recordingskiptostart", true)
				changeConfig("recordingskiptofinish", true)
			end end,
		},
	}

	local rf = function() return function() previousPageAndSelection() end end
	guipages.replaysnipping = createPopUpMenu(
		guipages[guipagenames.Recording],
		elements,
		nil,
		replaysnipping.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end

do -- savestateslot
	local Elements = {
		{},
		{},
		{},
		{},
		{},
		{
			text = "None",
			x = replaynonex,
			y = replaynoney,
			selectfunc = function() return function()
				changeConfig("recordingsavestateslot", 0)
			end end,
			releasefunc = function() return function()
				previousPageAndSelection()
			end end,
		}
	}
	local rf = function() return function() previousPageAndSelection() end end
	local sf = function(n) return function() recording.savestateslot = n end end
	guipages.savestateslot = createPopUpMenu(
		guipages[guipagenames.Recording],
		Elements,
		nil,
		-200, -- 'hide' the buttons
		nil,
		sf,
		rf
	)
end

if gamefunctions.readplayertwohealth and gamefunctions.playertwoinhitstun then -- hitslot
	local Elements = {
		{},
		{},
		{},
		{},
		{},
		{
			x = replaynonex,
			y = replaynoney,
			text = "None",
			selectfunc = function() return function()
				changeConfig("recordinghitslot", 0)
			end end,
			releasefunc = function() return function()
				previousPageAndSelection()
			end end,
		}
	}
	local rf = function() return function() previousPageAndSelection() end end
	local sf = function(n) return function() recording.hitslot = n end end
	guipages.hitslot = createPopUpMenu(
		guipages[guipagenames.Recording],
		Elements,
		nil,
		-200, -- 'hide' the buttons
		nil,
		sf,
		rf
	)
end

do -- delay starting time
	local uf = 	function(n, k)
		if n then
			local delay = getConfigValue("recordingdelay")+n
			changeConfig("recordingdelay", delay)
			return delay
		end
		if k then
			changeConfig("recordingdelay", k)
			return k
		end
		return getConfigValue("recordingdelay")
	end
	guipages.replaystartingtime = createScrollingBar(
		guipages[guipagenames.Recording],
		"00 Delayed Start",
		interactivegui.boxxhalflength - #"00 Delayed Start"*LETTER_HALFWIDTH - 2,
		replaystartingtime.y,
		0,
		maxdelay,
		nil,
		uf,
		function(this) this.text = string.format("%2df Delayed Start", recording.delay) end
	)
end

do -- which player(s) to replay
	local playerrecelements = {
		{
			text = "P1",
			x = playerrecording.rawx+#"Recor"*LETTER_HALFWIDTH,
			bgcolour = colour.option1,
			selectfunc = function() return function()
				changeConfig("recordingreplayp1", true)
				changeConfig("recordingreplayp2", false)
			end end
		},
		{
			text = "P2",
			x = playerrecording.rawx+#"Recor"*LETTER_HALFWIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("recordingreplayp1", false)
				changeConfig("recordingreplayp2", true)
			end end
		},
		{
			text = "P1 and P2",
			x = playerrecording.rawx-#"P1"*LETTER_HALFWIDTH,
			bgcolour = colour.option3,
			selectfunc = function() return function()
				changeConfig("recordingreplayp1", true)
				changeConfig("recordingreplayp2", true)
			end end
		},
	}
	guipages.playerrecording = createPopUpMenu(
		guipages[guipagenames.Recording],
		playerrecelements,
		nil,
		playerrecording.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end

-- General Settings

do -- coininputleniency
	local Elements = {
		{text = "10"},
		{text = "11"},
		{text = "12"},
		{text = "13"},
		{text = "14"},
		{text = "15", autofunc = function(this) if (interactivegui.selection == 6) then this.bgcolour = colour.bar else this.bgcolour = colour.bgcolour end end},
	}
	local sf = function(n) return function() changeConfig("guicoinleniency", n+9) end end
	guipages.coinleniency = createPopUpMenu(
		guipages[guipagenames.GeneralSettings],
		Elements,
		coininputleniency.x+(#coininputleniency.text-#"0f")*LETTER_WIDTH,
		coininputleniency.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do -- inputdelay
	local Elements = {
		{text = "0f"},
		{text = "1f", textcolour = "red"},
		{text = "2f", textcolour = "red"},
		{text = "3f", textcolour = "red"},
		{text = "4f", textcolour = "red"},
		{text = "5f", textcolour = "red"},
		{text = "6f", textcolour = "red"},
		{text = "7f", textcolour = "red"},
		{text = "8f", textcolour = "red"},
		{text = "9f", textcolour = "red"},
	}
	local sf = function(n) return function() delayinputcount=n-1 end end
	guipages.inputdelay = createPopUpMenu(
		guipages[guipagenames.GeneralSettings],
		Elements,
		inputdelay.x+(#inputdelay.text-#"0f")*LETTER_WIDTH,
		inputdelay.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do -- refill health speed
	local uf = function(n, k)
		if n then
			local refillspeed = getConfigValue("p1refillhealthspeed")+n
			changeConfig("p1refillhealthspeed", refillspeed)
			changeConfig("p2refillhealthspeed", refillspeed)
			return refillspeed
		end
		if k then
			changeConfig("p1refillhealthspeed", k)
			changeConfig("p2refillhealthspeed", k)
			return k
		end
		return getConfigValue("p1refillhealthspeed")
	end
	guipages.refillhealthspeed = createScrollingBar(
		guipages[guipagenames.GeneralSettings],
		refillhealthspeed.text,
		refillhealthspeed.x,
		refillhealthspeed.y,
		1,
		60,
		nil,
		uf,
		function(this) this.text = string.format("Refill Health Speed %2d", combovars.P1.refillhealthspeed) end
	)
end

do
	local uf = function(n, k)
		if n then
			local refillspeed = getConfigValue("p1refillmeterspeed")+n
			changeConfig("p1refillmeterspeed", refillspeed)
			changeConfig("p2refillmeterspeed", refillspeed)
			return refillspeed
		end
		if k then
			changeConfig("p1refillmeterspeed", k)
			changeConfig("p2refillmeterspeed", k)
			return k
		end
		return getConfigValue("p1refillmeterspeed")
	end
	guipages.refillmeterspeed = createScrollingBar(
		guipages[guipagenames.GeneralSettings],
		refillmeterspeed.text,
		refillmeterspeed.x,
		refillmeterspeed.y,
		1,
		60,
		nil,
		uf,
		function(this) this.text = string.format("Refill Meter Speed %2d", combovars.P1.refillmeterspeed) end
	)
end

do
	local uf = function(n, k)
		if n then
			currentcolour.red = currentcolour.red+n
			return currentcolour.red
		end
		if k then
			currentcolour.red = k
			return k
		end
		return currentcolour.red
	end
	guipages.colourpickerred = createScrollingBar(
		guipages[guipagenames.GeneralSettings],
		"255",
		colourpickerred.x,
		colourpickerred.y,
		0,
		0xFF,
		0,
		uf,
		function(this) this.text = string.format("%3d", currentcolour.red) end
	)
end
do
	local Elements = {}
	for id, configitem in pairs(getConfigItemsFiltered("colour")) do
		local text = configitem.displayname
		table.insert(Elements,
		{
			text = text,
			x = colourconfigpicker.rawx - #text*LETTER_HALFWIDTH,
			selectfunc = function(n) return function()
				selectedcolourconfig = {
					id = id,
					name = text,
					config = configitem,
					displayname = configitem.displayname,
					pos = n
				}
			end end,
			releasefunc = function(n) return function()
				local colour = configitem.varpointer[configitem.name]
				currentcolour.red = bit.rshift(bit.band(0xFF000000, colour), 24)
				currentcolour.green = bit.rshift(bit.band(0x00FF0000, colour), 16)
				currentcolour.blue = bit.rshift(bit.band(0x0000FF00, colour), 8)
				currentcolour.alpha = bit.band(0x000000FF, colour)
				previousPageAndSelection()
			end end,
			autofunc = function(this)
				this.bgcolour = configitem.varpointer[configitem.name]
			end
		})
	end
	table.sort(Elements, function(a, b) return a.text < b.text end)
	guipages.colourconfigpicker = createPopUpMenu(
		guipages[guipagenames.GeneralSettings],
		Elements,
		nil,
		colourconfigpicker.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end
do
	local uf = function(n, k)
		if n then
			currentcolour.green = currentcolour.green+n
			return currentcolour.green
		end
		if k then
			currentcolour.green = k
			return k
		end
		return currentcolour.green
	end
	guipages.colourpickergreen = createScrollingBar(
		guipages[guipagenames.GeneralSettings],
		"255",
		colourpickergreen.x,
		colourpickergreen.y,
		0,
		0xFF,
		0,
		uf,
		function(this) this.text = string.format("%3d", currentcolour.green) end
	)
end
do
	local uf = function(n, k)
		if n then
			currentcolour.blue = currentcolour.blue+n
			return currentcolour.blue
		end
		if k then
			currentcolour.blue = k
			return k
		end
		return currentcolour.blue
	end
	guipages.colourpickerblue = createScrollingBar(
		guipages[guipagenames.GeneralSettings],
		"255",
		colourpickerblue.x,
		colourpickerblue.y,
		0,
		0xFF,
		0,
		uf,
		function(this) this.text = string.format("%3d", currentcolour.blue) end
	)
end

formatGUITables()

------------------------------------------
-- Add-on
------------------------------------------
local addonpage1 = {
	title = {
		text = "Add-On"
	},
	{
		text = "<",
		func = function() changePageAndSelection(1,7) end,
		olcolour = colour.olcolour
	},
}
guipages.addonpage1 = addonpage1

-- Is there a way to create new pages on the fly ?
local addonpage2 = {
	title = {
		text = "Add-On"
	},
	{
		text = "<<",
		alignment = "centre",
		olcolour = colour.olcolour,
		info = "Back",
		func = function() changePageAndSelection("addonpage1", 1) end,
	},
}
guipages.addonpage2 = addonpage2

local addonnextpage = {
		text = ">>",
		olcolour = colour.olcolour,
		info = "Back",
		x = 276,
		y = 15,
		func =  function() changePageAndSelection("addonpage2", 1) end,
}

local addon_nb = 0

local function determineButtonYPos(_guipage)
	if #_guipage%7 == 1 then
		return 30
	else
		return _guipage[#_guipage].y+20
	end
end

local function determineButtonXPos(_guipage)
	if #_guipage < 8 then
		return 8
	else
		return 150
	end
end

function insertAddonButton(addon_button) -- Could be improved to create as many pages as is necessary, I don't know if ther's a way to create new pages on the fly
	local _addonpage = nil
	addon_nb = addon_nb + 1

	if addon_nb == 1 then
		table.insert(addonpage1, addonbutton)
	elseif addon_nb == 15 then
		table.insert(addonpage1, addonnextpage)
	end

	if addon_nb <= 14 then
		_addonpage = addonpage1
	else
		_addonpage = addonpage2
	end

	addon_button.x = determineButtonXPos(_addonpage)
	addon_button.y = determineButtonYPos(_addonpage)
	table.insert(_addonpage, addon_button)
	formatGUITables()
end
