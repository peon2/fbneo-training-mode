DISABLE_SCROLLING_INPUT = false
--[[
   flip this when the script keeps crashing
   replace the text after the '=' with:
	-> true, do use it
	-> false, don't use it
--]]

FBNEO_TRAINING_MODE_VERSION = "v0.26.05"
REPO_SOURCE = "https://github.com/peon2/fbneo-training-mode"

--DEBUG = true
write = print -- alias to make sure debug print statements stand out

-- Training Mode fundamental files
filetree = {
	constants = "resources/constants.lua",
	guipages = "resources/guipages.lua",
	simpleinput = "inputs/input-display.lua",
	scrollinginput = "inputs/scrolling-input-display.lua",
	background = "code/background.lua",
	config = "code/config.lua",
	gamelogic = "code/gamelogic.lua",
	gui = "code/gui.lua",
	hud = "code/hud.lua",
	input = "code/input.lua",
	replay = "code/replay.lua",
	saveload = "code/saveload.lua",
	utils = "code/utils.lua",
	addons = "addon/addons.lua",
}

function fexists(filepath)
	local fs = io.open(filepath,"r")
	local res = fs~=nil
	if (res) then
		fs:close()
	end
	return res
end

do -- Validating expected files
	local missingfiles = ""

	for _,v in pairs(filetree) do
		if not fexists(v) then
			if #missingfiles == 0 then
				missingfiles = v
			else
				missingfiles = missingfiles..", "..v
			end
		end
	end

	if #missingfiles > 0 then
		write("Script can't run, missing files: "..missingfiles)
		write("Script Version: "..FBNEO_TRAINING_MODE_VERSION)
		write("Download the whole script from: "..REPO_SOURCE)
		while true do
			gui.text(1, 10, "Script can't run, missing files: "..missingfiles, "red")
			gui.text(1, 20, "Script Version: "..FBNEO_TRAINING_MODE_VERSION, "red")
			gui.text(1, 30, "Download the whole script from: "..REPO_SOURCE, "red")
			emu.frameadvance()
		end
	end
end
----------------------------------------------
-- CONSTANTS
--
-- ROM_NAME
-- PARENT_NAME
-- BASIC_ICONS_RESOURCEPATH
-- SCROLLING_INPUT_RESOURCEPATH
-- REPLAY_SLOTS_COUNT
-- MINIMUM_GUI_BUTTONS
-- LETTER_WIDTH
-- LETTER_HALFWIDTH
-- LETTER_HEIGHT
-- wb(address, value), ww(address, value), wdw(address, value)
-- rb(address), rbs(address), rw(address), rws(address), rdw(address), rdws(address)
----------------------------------------------
dofile(filetree.constants)

-- watch replay mode (no health refill, etc..)
if not emu.isreplay then
	REPLAY = false
else
	REPLAY = emu.isreplay()
end

if REPLAY then
	-- we don't want to write memory when watching a replay
	wb = function() end
	ww = function() end
	wdw = function() end
	-- this breaks throw hitboxes on some games
	-- memory.writebyte = function() end
	-- memory.writeword = function() end
	-- memory.writedword = function() end
end

require "gd"

--- wait 3 frames to allow for emu.screenwidth() and emu.screenheight() to be obtained properly
emu.frameadvance()
emu.frameadvance()
emu.frameadvance()

fc = emu.framecount()

local games = {
	[""] = {}, -- null case
	aliencha = {iconfile = "icons-capcom.png"},
	aof = {iconfile = "icons-neogeo.png"},
	aof2 = {iconfile = "icons-neogeo.png"},
	aof3 = {hitboxes = "aof3-hitboxes", iconfile = "icons-neogeo.png"},
	asurabld = {iconfile = "icons-asurabus.png"},
	asurabus = {iconfile = "icons-asurabus.png"},
	avengrgs = {iconfile = "icons-banpresto.png"},
	bloodstm = {iconfile = "icons-bloodstm.png"},
	bloodwar = {iconfile = "icons-neogeo.png"},
	breakrev = {iconfile = "icons-neogeo.png"},
	cybots = {hitboxes = "cps2-hitboxes", iconfile = "icons-cybots.png"},
	dankuga = {iconfile= "icons-capcom.png"},
	daraku = {hitboxes = "daraku-hitboxes", iconfile = "icons-psikyo.png"},
	dbz2 = {iconfile = "icons-banpresto.png"},
	dinorex = {iconfile = "icons-taito.png"},
	doubledr = {iconfile = "icons-neogeo.png"},
	dstlk = {hitboxes = "cps2-hitboxes", iconfile = "icons-capcom.png"},
	fatfury1 = {hitboxes = "garou-hitboxes", iconfile = "icons-neogeo.png"},
	fatfury2 = {hitboxes = "garou-hitboxes", iconfile = "icons-neogeo.png"},
	fatfury3 = {hitboxes = "garou-hitboxes", iconfile = "icons-neogeo.png"},
	fatfursp = {hitboxes = "garou-hitboxes", iconfile = "icons-neogeo.png"},
	fightfev = {iconfile = "icons-neogeo.png"},
	galaxyfg = {iconfile = "icons-neogeo.png"},
	garou = {hitboxes = "garou-hitboxes", iconfile = "icons-neogeo.png"},
	gowcaizr = {iconfile = "icons-neogeo.png"},
	gundamex = {iconfile = "icons-banpresto.png"},
	hippodrm = {iconfile = "icons-hippodrm.png"},
	hsf2 = {hitboxes = "sf2-hitboxes", iconfile = "icons-capcom.png"},
	jchan = {iconfile = "icons-kaneko.png"},
	jchan2 = {hitboxes = "jchan2-hitboxes", iconfile = "icons-kaneko.png"},
	jojo = {hitboxes = "jojo-hitboxes", iconfile = "icons-jojos.png"},
	jojoba = {hitboxes = "hftf-hitboxes", iconfile = "icons-jojos.png"},
	kabukikl = {iconfile = "icons-neogeo.png"},
	karnovr = {hitboxes = "karnovr-hitboxes", iconfile = "icons-neogeo.png"},
	kf2k5uni = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kizuna = {iconfile = "icons-neogeo.png"},
	kof94 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof95 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof96 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof97 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof98 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof99 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof2000 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof2001 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof2002 = {hitboxes = "kof-hitboxes", iconfile = "icons-neogeo.png"},
	kof2003 = {hitboxes = "kof2003-hitboxes", iconfile = "icons-neogeo.png"},
	lastblad = {iconfile = "icons-neogeo.png"},
	lastbld2 = {iconfile = "icons-neogeo.png"},
	martmast = {iconfile = "icons-martmast.png"},
	matrim = {iconfile = "icons-neogeo.png"},
--	msgundam = {iconfile = "icons-msgundam.png"},
	msh = {hitboxes = "marvel-hitboxes", iconfile = "icons-capcom.png"},
	mshvsf = {hitboxes = "marvel-hitboxes", iconfile = "icons-capcom.png"},
	mvsc = {hitboxes = "marvel-hitboxes", iconfile = "icons-capcom.png"},
	mwarr = {iconfile = "icons-mwarr.png"},
	ninjamas = {iconfile = "icons-neogeo.png"},
	nwarr = {hitboxes = "cps2-hitboxes", iconfile = "icons-capcom.png"},
	rabbit = {iconfile = "icons-banpresto.png"},
	ragnagrd = {iconfile = "icons-neogeo.png"},
	rbff1 = {hitboxes = "garou-hitboxes", iconfile = "icons-neogeo.png"},
	rbff2 = {hitboxes = "garou-hitboxes", iconfile = "icons-neogeo.png"},
	rbffspec = {hitboxes = "garou-hitboxes", iconfile = "icons-neogeo.png"},
	redearth = {hitboxes = "cps3-hitboxes", iconfile = "icons-redearth.png"},
	ringdest = {hitboxes = "cps2-hitboxes", iconfile = "icons-ringdest.png"},
	rotd = {hitboxes = "rotd-hitboxes", iconfile = "icons-neogeo.png"},
	samsho = {iconfile = "icons-neogeo.png"},
	samsho2 = {iconfile = "icons-neogeo.png"},
	samsho3 = {iconfile = "icons-neogeo.png"},
	samsho4 = {iconfile = "icons-neogeo.png"},
	samsho5 = {iconfile = "icons-neogeo.png"},
	samsh5sp = {iconfile = "icons-neogeo.png"},
	schmeisr = {iconfile = "icons-asurabus.png"},
	sf = {iconfile = "icons-sf1.png"},
	sf2 = {hitboxes = "sf2-hitboxes", iconfile = "icons-capcom.png"},
	sf2ce = {hitboxes = "sf2-hitboxes", iconfile = "icons-capcom.png"},
	sfa = {hitboxes = "cps2-hitboxes", iconfile = "icons-capcom.png"},
	sfa2 = {hitboxes = "cps2-hitboxes", iconfile = "icons-capcom.png"},
	sfa3 = {hitboxes = "cps2-hitboxes", iconfile = "icons-capcom.png"},
	sfiii = {hitboxes = "cps3-hitboxes", iconfile = "icons-capcom.png"},
	sfiii2 = {hitboxes = "cps3-hitboxes", iconfile = "icons-capcom.png"},
	sfiii3ws = {hitboxes = "cps3-hitboxes", iconfile = "icons-capcom.png"},
	sfiii3 = {hitboxes = "cps3-hitboxes", iconfile = "icons-capcom.png"},
	sgemf = {hitboxes = "cps2-hitboxes", iconfile = "icons-sgemf.png"},
	slammast = {iconfile = "icons-slammast.png"},
	ssf2 = {hitboxes = "sf2-hitboxes", iconfile = "icons-capcom-letter.png"},
	ssf2t = {hitboxes = "st-hitboxes", iconfile = "icons-capcom-letter.png"},
	svc = {hitboxes = "svc-hitboxes", iconfile = "icons-neogeo.png"},
	teot = {iconfile = "icons-neogeo.png"},
	timekill = {iconfile = "icons-timekill.png"},
	tkdensho = {iconfile = "icons-banpresto.png"},
	trstar = {iconfile = "icons-trstar.png"},
	umk3 = {iconfile = "icons-midway.png"},
	vhunt2 = {hitboxes = "cps2-hitboxes", iconfile = "icons-capcom.png"},
	viofight = {iconfile = "icons-viofight.png"},
	vsav = {hitboxes = "cps2-hitboxes", iconfile = "icons-capcom.png"},
	vsav2 = {hitboxes = "cps2-hitboxes", iconfile = "icons-capcom.png"},
	wakuwak7 = {iconfile = "icons-neogeo.png"},
	wh1 = {iconfile = "icons-neogeo.png"},
	wh2 = {iconfile = "icons-neogeo.png"},
	wh2j = {iconfile = "icons-neogeo.png"},
	whp = {iconfile = "icons-neogeo.png"},
	xmcota = {hitboxes = "marvel-hitboxes", iconfile = "icons-capcom.png"},
	xmvsf = {hitboxes = "marvel-hitboxes", iconfile = "icons-capcom.png"},
}

local function usage()
	write ("Beta for fbneo-training-script ("..FBNEO_TRAINING_MODE_VERSION..")")
	if not REPLAY then
		write "Replay with 1 coin press"
		write "Record with 2 coin presses"
		write "Swap inputs with 3 coin presses"
		write "Open the menu with 4 coin presses or hold the button to open it"
	end
end

gamepath = "games/other/"
configpath = gamepath..ROM_NAME..".config"

----------------------------------------------
-- UTILS
-- orTable(t)
-- isEmpty(t)
-- notEmpty(t)
-- otherPlayer(player)
-- scaleinputnum(n)
----------------------------------------------
dofile(filetree.utils)

----------------------------------------------
-- SAVE/LOAD
-- saveTableToFile(metadata, data, filename)
-- loadTableFromFile(filename)
----------------------------------------------
dofile(filetree.saveload)

----------------------------------------------
-- INPUT
-- readGUIInputs()
-- readInputs()
-- combinePlayerInputs(P1, P2, other)
-- toggleSwapInputs(bool, vargs)
-- swapInputs()
-- swapPlayerDirection(inputframe)
-- freezePlayer(player)
-- delayInputs()
-- setInputs()
-- setHoldDirection(direction)
-- applyHoldDirection()
-- processGUIInputs()
----------------------------------------------
dofile(filetree.input)

----------------------------------------------
-- GAME LOGIC
-- setGameConstants()
-- checkGameFunctions()
-- updategamevars()
-- writePlayerHealth(player, health)
-- writePlayerMeter(player, meter)
-- comboHandler(player)
-- healthHandler(player)
-- meterHandler(player)
-- instantHealth(player)
-- instantMeter(player)

----------------------------------------------
dofile(filetree.gamelogic)

----------------------------------------------
-- REPLAY
-- drawReplayInfo(x, y)
-- replaySave()
-- replayLoad()
-- toggleRecording(bool, vargs)
-- logRecording()
-- togglePlayBack(bool, vargs)
-- playBack()
-- hitPlayBack()
-- savestatePlayBack()
-- toggleReplayEditor(bool, vargs)
----------------------------------------------
dofile(filetree.replay)

----------------------------------------------
-- HUD
-- helpElements = {}
-- drawHUD()
-- drawComboHUD()
-- toggleMoveHUD(bool, vargs)
-- addTextItem(text, x, y, colour, timer)
-- drawTextItems()
-- buttonHandler()
-- moveHUDInteract()
-- blankKB()
-- drawKB(x,y)
-- displayStick(x, y)
-- drawFillBar(x, y, text, textoffset, barlen, barmaxsixe)
----------------------------------------------
dofile(filetree.hud)

----------------------------------------------
-- GUI
-- calcDerivedValues()
-- createNavigatablePage(pageelements)
-- reloadGUIPages()
-- createFauxPage(basepage)
-- createPopUpMenu(basepage, elements, x, y, numofelements, selectfunc, releasefunc, autofunc, forcecentre)
-- createScrollingBar(basepage, text, x, y, minimum, maximum, length, updatefunc, autofunc)
-- changePageAndSelection(page, selection)
-- previousPageAndSelection()
-- changeGUISelection(selection)
-- callGUISelectionFunc()
-- callGUISelectionReleaseFunc()
-- interactiveGUISelectionInfo()
-- interactiveGUISelectionBack()
-- drawHelp()
-- toggleInteractiveGUI(bool, vargs)
-- drawGUI()
----------------------------------------------
dofile(filetree.gui)

----------------------------------------------
-- CONFIG
-- combovars = {}
-- hud = {}
-- inputs = {}
-- hitboxes = {}
-- recording = {}
-- interactivegui = {}
-- colour = {}
-- gamevars = {}
-- initConfigTable(tablename, t, configstr)
-- getConfigTable(tablename, configstr)
-- createConfigItem(configname, default, configpointer, internalname, varpointer, displayname)
-- initConfigItem(configname)
-- getConfigItemsFiltered(filter)
-- getConfigValue(id)
-- changeConfig(id, value, updatevar)
-- setConfigDefault(id, default)
-- resetConfig(id)
-- markConfigsUnchanged()
-- saveAllConfig()
-- loadSavedConfig()
----------------------------------------------
dofile(filetree.config)

----------------------------------------------
-- ROM NAME
----------------------------------------------

gamename = ""
for _gamename, _ in pairs(games) do
	if (ROM_NAME == _gamename or PARENT_NAME == _gamename) then
		gamename = _gamename
		gamepath = "games/"..gamename.."/"
		configpath = gamepath..ROM_NAME..".config"
	end
end

if gamename == "" then
	local text = "GAME NOT RECOGNISED"
	addTextItem(text, interactivegui.sw/2 - #text*LETTER_HALFWIDTH, 10, "cyan")
end

----------------------------------------------
-- CHECK FOR GAME LUA FILE
----------------------------------------------
nbuttons = 0

if fexists("games/"..gamename.."/"..gamename..".lua") then
	dofile("games/"..gamename.."/"..gamename..".lua")
	local i = 5
	while (translationtable[i]:sub(1,6)=="button") do nbuttons = nbuttons+1 i=i+1 end
else
	write("Memory addresses not found for "..ROM_NAME)
end

-- check if the translationtable is valid, failsafe
if translationtable then
	local player, input
	for i,v in pairs(joypad.get()) do -- check every button
		player = i:sub(1,2)
		input = i:sub(4)
		if player == "P1" then -- assume the same inputs for each player
			if not translationtable[input] or not translationtable[translationtable[input]] then -- bad button found
				write(input)
				write "Translation table malformed"
				nbuttons = 0
				break
			end
		end
	end
end

if nbuttons == 0 then
	write("No buttons found for "..ROM_NAME)
	write "Attempting to make a translationtable from defaults"
	-- try to make a translation table

	-- modified from dammits input display script
	local a = {"Weak Punch", "Medium Punch", "Heavy Punch", "Weak Kick", "Medium Kick", "Heavy Kick",
		["Weak Punch"] = 1,
		["Medium Punch"] = 2,
		["Heavy Punch"] = 3,
		["Weak Kick"] = 4,
		["Medium Kick"] = 5,
		["Heavy Kick"] = 6,
	}
	local a2 = {"Weak Punch", "Medium Punch", "Strong Punch", "Weak Kick", "Medium Kick", "Strong Kick",
		["Weak Punch"] = 1,
		["Medium Punch"] = 2,
		["Strong Punch"] = 3,
		["Weak Kick"] = 4,
		["Medium Kick"] = 5,
		["Strong Kick"] = 6,
	}
	local c = joypad.get()
	local player, input
	nbuttons = nil
	local charoffset = 64
	for b=6,1,-1 do
		for _,v in ipairs({"P1 Button "..b, "P1 Button "..string.char(b+charoffset), "P1 Fire "..b, "P1 "..a[b], "P1 "..a2[b]}) do -- some common buttons
			if c[v] ~= nil then
				nbuttons = b
				break
			end
		end
		if nbuttons then break end
	end
	-- assume all games have cardinal directions
	if nbuttons then
		write("Found ".. nbuttons .. " buttons")
		local tonum = function(val) -- works for digits and letters in the context of joypad inputs
			if (tonumber(val:sub(#val))) then
				return tonumber(val:sub(#val))
			elseif string.byte(val:sub(#val))-charoffset <= 6 then -- F (6 buttons)
				return string.byte(val:sub(#val))-charoffset
			elseif a[val] then
				return a[val]
			elseif a2[val] then
				return a2[val]
			else
				return nil
			end
		end

		translationtable = {"coin", "start", "select", "up", "down", "left", "right", "button1", "button2", "button3", "button4", "button5", "button6",
			Coin = 1,
			Start = 2,
			Select = 3,
			Up = 4,
			Down = 5,
			Left = 6,
			Right = 7,
		}
		for i,v in pairs(c) do -- check buttons
			player = i:sub(1,2)
			input = i:sub(4)
			if player == "P1" and translationtable[input]==nil then -- change translation table to not work with [1]
				translationtable[input] = 7+assert(tonum(input), "Can't make a translation table") -- bind JUST attack buttons
			elseif player == "P2" then
			else -- stuff like dipswitches
				translationtable[i] = 7+nbuttons+1 -- we dont care about any of these but need to make sure they're bound to something
			end
		end
		local d = {nil, nil, "icons-taito.png", "icons-neogeo.png", nil, "icons-capcom.png"} -- iconfiles, 3,4,6 buttons
		games[""].iconfile = d[nbuttons]
	else
		write "Can't make a translationtable"
		nbuttons = 0
	end
end

----------------------------------------------
-- INIT ANY GAME SPECIFIC SETTINGS
----------------------------------------------

setGameConstants()

----------------------------------------------
-- LOAD SAVED CONFIG
----------------------------------------------

loadSavedConfig()

----------------------------------------------
-- CALC ANY COMMONLY USED DERIVED VALUES
----------------------------------------------

calcDerivedGUIValues()

----------------------------------------------
-- TRYING TO OPEN HITBOXES
----------------------------------------------
do
	local hitbox = games[gamename].hitboxes
	if hitbox then
		if fexists("hitboxes/"..hitbox..".lua") then
			dofile("hitboxes/"..hitbox..".lua")
			else
			write("Hitbox file "..games[gamename].hitboxes.." not found for "..ROM_NAME)
		end
	else
		write("No associated hitbox file for "..ROM_NAME)
	end
end
----------------------------------------------
-- INPUT DISPLAY
----------------------------------------------

dofile(filetree.simpleinput)

write ""
write "If the script crashes here you may need to edit DISABLE_SCROLLING_INPUT based on your computer. Open the fbneo-training-mode.lua file with a text editor (notepad, notepad++, etc.) and change DISABLE_SCROLLING_INPUT to true or false, whichever it isn't"

if games[gamename].iconfile then
	iconfile = games[gamename].iconfile
	if fexists(SCROLLING_INPUT_RESOURCEPATH.."32/"..iconfile) and not DISABLE_SCROLLING_INPUT then
		dofile(filetree.scrollinginput)
	else
		write(iconfile.. " missing in "..SCROLLING_INPUT_RESOURCEPATH.."32/")
	end
else
	write("No scrolling input image found for "..ROM_NAME)
end

local function menuCheck()
	interactivegui.inmenu = interactivegui.enabled or interactivegui.movehud.enabled or interactivegui.replayeditor.enabled

	inputs.properties.p1freeze = interactivegui.inmenu
	inputs.properties.p2freeze = interactivegui.inmenu

	-- toggle hitboxes/inputs while in a menu
	hitboxes.enabled = (not interactivegui.inmenu) and hitboxes.toggle

	-- find elements in HUDElements to adjust
	if (interactivegui.inmenu and not interactivegui.movehud.enabled and gamefunctions.scrollinginputclear) then scrollingInputClear() end
	for _,v in pairs(HUDElements or {}) do
		local enabled = not interactivegui.inmenu or interactivegui.movehud.enabled
		if v.name == "p1scrollinginput" then
			inputs.properties.scrolling.P1.enabled = enabled and getConfigValue("scrollinginputenabledp1")
		end
		if v.name == "p2scrollinginput" then
			inputs.properties.scrolling.P2.enabled = enabled and getConfigValue("scrollinginputenabledp2")
		end
		if v.name == "p1simpleinput" then
			inputs.properties.simple.P1.enabled = enabled and getConfigValue("simpleinputenabledp1")
		end
		if v.name == "p2simpleinput" then
			inputs.properties.simple.P2.enabled = enabled and getConfigValue("simpleinputenabledp2")
		end
	end
end

-- set up gd images
helpIcons = {[16] = {}} -- follows translationtable series
helpButtons = {}
helpShell = gd.createFromPng(BASIC_ICONS_RESOURCEPATH.."shell.png"):gdStr()

if scrollingInputReg then -- if there's a scrolling input file loaded
	local img
	local img_16_path = SCROLLING_INPUT_RESOURCEPATH.."16/"..games[gamename].iconfile
	if fexists(img_16_path) then -- use the 16x16 icons for the UI
		img = gd.createFromPng(img_16_path)
	else -- create a tileset of 16x16 icons using the 32x32 icons
		local img_32_path = SCROLLING_INPUT_RESOURCEPATH.."32/"..games[gamename].iconfile
		write("Couldn't find: "..img_16_path.." for the UI, using: "..img_32_path.." as a substitute.")
		local largeimg = gd.createFromPng(img_32_path)
		img = gd.create(16, largeimg:sizeY()/2)
		gd.copyResampled(img, largeimg, 0, 0, 0, 0, 16, largeimg:sizeY()/2, 32, largeimg:sizeY())
	end
	local imgcnt = img:sizeY()/16
	local y = img:sizeY()-(nbuttons+1)*16 -- y of first button, ignoring start
	--[[
		Left,
		Right,
		Up,
		Down,
		Up-Left,   -- skip this
		Up-Right,  -- skip this
		Down-Left, -- skip this
		Down-Right,-- skip this
		.
		.
		.
		*Buttons*,
		.
		.
		.,
		Start
	--]]

	for i = 1, 4 do	-- cardinal directions
		helpIcons[16][i] = gd.create(16,16)
		helpIcons[16][i]:copy(img, 0, 0, 0, (i-1)*16, 16, 16)
		helpIcons[16][i] = helpIcons[16][i]:gdStr()
	end

	for i = 9, imgcnt do -- skip diagonals, rest of the buttons
		helpIcons[16][i-4] = gd.create(16,16)
		helpIcons[16][i-4]:copy(img, 0, 0, 0, (i-1)*16, 16, 16)
		helpIcons[16][i-4] = helpIcons[16][i-4]:gdStr()
	end

	for i = 1,nbuttons do
		helpButtons[i] = helpIcons[16][i+4] -- assign buttons
		y=y+16
	end
else -- otherwise use these defaults
	for i = 1, nbuttons do
		helpButtons[i] = gd.createFromPng(BASIC_ICONS_RESOURCEPATH..i..".png")
		helpButtons[i] = helpButtons[i]:gdStr()
	end
end

registers = {
	registerbefore = {},
	guiregister = {},
	registerafter = {},
	emuexit = {},
}

local readHotkeyInFuncs = {
	back = function(but)
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			inputs.hotkeys.hotkeyin = false
		end
	end,
	name = "readHotkeyInFuncs",
}

local function readHotkeyIn()
	if not inputs.hotkeys.hotkeyin then return end
	drawKB(hud.kb.x,hud.kb.y)

	local boxx = interactivegui.boxx
	local boxx2 = interactivegui.boxx2
	local boxy = interactivegui.boxy

	gui.box(boxx,boxy-10,boxx2,boxy,"green","black")
	gui.text((boxx2+boxx)/2 - 14,boxy-8,"HOTKEYS")

	local helpButtons = {{}, funcs=readHotkeyInFuncs}
	if guipages[interactivegui.page][interactivegui.selection].info then helpButtons[1] = {name="INFO", button="button1"} end
	helpElements.buttons = helpButtons -- overload inputs

	local highest = 0
	for i,v in pairs(guiinputs.kb.inputcount) do
		if v>highest then highest=v end
		if v>60 then -- found a match
			local s = guipages[interactivegui.page][interactivegui.selection]
			if s.func or s.selectfunc or s.releasefunc then -- set function + hierarchy of functions to look for
				inputs.hotkeys.funcs[i] = s.func or s.selectfunc or s.releasefunc
			else write "Couldn't find a function to bind" end
			inputs.hotkeys.hotkeyin = false
			return
		end
	end
	gui.text(interactivegui.boxx+3, interactivegui.boxy-8, highest)
end

local function runHotkeys()
	if inputs.hotkeys.hotkeyin then return end -- don't run hotkeys while assigning new ones
	for i,v in pairs(inputs.hotkeys.funcs) do if guiinputs.kb.inputcount[i]==1 then v() end end
end

function toggleStates(vargs) -- nil = false, true = true, false = skip
	if vargs == nil then return end -- bad argument
	if vargs["swapinputs"]==nil then toggleSwapInputs(false, vargs) elseif vargs["swapinputs"] then toggleSwapInputs(true, vargs) end
	if vargs["recording"]==nil then toggleRecording(false, vargs) elseif vargs["recording"] then toggleRecording(true, vargs) end
	if vargs["playback"]==nil then togglePlayBack(false, vargs) elseif vargs["playback"] then togglePlayBack(true, vargs) end
	if vargs["interactiveguienabled"]==nil then toggleInteractiveGUI(false, vargs) elseif vargs["interactiveguienabled"] then toggleInteractiveGUI(true, vargs) end
	if vargs["movehud"]==nil then toggleMoveHUD(false, vargs) elseif vargs["movehud"] then toggleMoveHUD(true, vargs) end
	if vargs["replayeditor"]==nil then toggleReplayEditor(false, vargs) elseif vargs["replayeditor"] then toggleReplayEditor(true, vargs) end
end

do -- Configure the Training Mode depending on what functions and info is available on the game.
	checkGameFunctions()
	reloadGUIPages()

	replayLoad() -- load a game's saved replaypack at startup (if it exists)

	if gamefunctions.playertwofacingleft then
		setConfigDefault("recordingautoturn", true)
		resetConfig("recordingautoturn")
	else
		write "Can't auto-swap directions in replays"
	end

	registers.registerbefore = { -- order functions execute in
		updategamevars,
		readInputs,
		applyHoldDirection,
		swapInputs,
		logRecording,
		playBack,
		hitPlayBack,
		menuCheck,
		delayInputs,
		freezePlayer,
		setInputs
	}

	registers.interactiveguiregister = {drawTextItems}
	registers.registerafter = {}

	if gamefunctions.run then
		table.insert(registers.interactiveguiregister, Run)
	else
		write "Nothing running every frame from memory file"
	end

	local str = ""
	if gamefunctions.readplayeronehealth then
		createHUDElement(
			"p1health",
			function(n) if n then changeConfig("p1healthx", n) end return hud.health.P1.x end,
			function(n) if n then changeConfig("p1healthy", n) end return hud.health.P1.y end,
			function(n) if n~=nil then changeConfig("p1healthenabled", n) end return hud.health.P1.enabled end,
			function() resetConfig("p1healthx") resetConfig("p1healthy") resetConfig("p1healthenabled") end,
			function() gui.text(hud.health.P1.x, hud.health.P1.y, gamevars.P1.health, hud.health.P1.textcolour) end
		)
		if gamefunctions.playeroneinhitstun then
			table.insert(registers.interactiveguiregister, function() comboHandler("P1") end)
		else
			write "player one hitstun not set, can't do combos.\n"
		end
	else
		write "player one health read not set, can't do combos.\n"
	end

	if gamefunctions.readplayertwohealth then
		createHUDElement(
			"p2health",
			function(n) if n then changeConfig("p2healthx", n) end return hud.health.P2.x end,
			function(n) if n then changeConfig("p2healthy", n) end return hud.health.P2.y end,
			function(n) if n~=nil then changeConfig("p2healthenabled", n) end return hud.health.P2.enabled end,
			function() resetConfig("p2healthx") resetConfig("p2healthy") resetConfig("p2healthenabled") end,
			function() gui.text(hud.health.P2.x, hud.health.P2.y, gamevars.P2.health, hud.health.P2.textcolour) end
		)
		if gamefunctions.playertwoinhitstun then
			table.insert(registers.interactiveguiregister, function() comboHandler("P2") end)
		else
			write "player two hitstun not set, can't do combos.\n"
		end
	else
		write "player two health read not set, can't do combos.\n"
	end

	if gamevars.P1.constants.maxhealth and gamefunctions.readplayeronehealth and gamefunctions.writeplayeronehealth and gamefunctions.playeroneinhitstun then
		table.insert(registers.registerafter, function() healthHandler("P1") end)
	else
		str = ""
		if not gamevars.P1.constants.maxhealth then
			str = str .. "max health and "
		end
		if not gamefunctions.readplayeronehealth then
			str = str .. "player one health read and "
		end
		if not gamefunctions.writeplayeronehealth then
			str = str .. "player one health write and "
		end
		if not gamefunctions.playeroneinhitstun then
			str = str .. "player one hitstun and "
		end
		write(str:sub(1,#str-5) .. " not set, can't do health refill for P1.\n")
	end

	if gamevars.P2.constants.maxhealth and gamefunctions.readplayertwohealth and gamefunctions.writeplayertwohealth and gamefunctions.playertwoinhitstun then
		table.insert(registers.registerafter, function() healthHandler("P2") end)
		createHUDElement(
			"combocounter",
			function(n) if n then changeConfig("combotextx", n) end return hud.combotext.x end,
			function(n) if n then changeConfig("combotexty", n, hud) end return hud.combotext.y end,
			function(n) if n~=nil then changeConfig("combotextenabled", n) end return hud.combotext.enabled end,
			function() resetConfig("combotextx") resetConfig("combotexty") resetConfig("combotextenabled") end,
			drawComboHUD
		)
	else
		str = ""
		if not gamevars.P2.constants.maxhealth then
			str = str .. "max health and "
		end
		if not gamefunctions.readplayertwohealth then
			str = str .. "player two health read and "
		end
		if not gamefunctions.writeplayertwohealth then
			str = str .. "player two health write and "
		end
		if not gamefunctions.playertwoinhitstun then
			str = str .. "player two hitstun and "
		end
		write(str:sub(1,#str-5) .. " not set, can't do health refill for P2.\n")
	end

	if gamevars.P1.constants.maxhealth and gamefunctions.writeplayeronehealth then
		table.insert(registers.registerafter, function() instantHealth("P1") end)
	else
		str = ""
		if not gamevars.P1.constants.maxhealth then
			str = str .. "max health and "
		end
		if not gamefunctions.writeplayeronehealth then
			str = str .. "player one health write and "
		end
		write(str:sub(1,#str-5) .. " not set, can't set health for P1.\n")
	end

	if gamevars.P2.constants.maxhealth and gamefunctions.writeplayertwohealth then
		table.insert(registers.registerafter, function() instantHealth("P2") end)
	else
		str = ""
		if not gamevars.P2.constants.maxhealth then
			str = str .. "max health and "
		end
		if not gamefunctions.writeplayertwohealth then
			str = str .. "player two health write and "
		end
		write(str:sub(1,#str-5) .. " not set, can't set health for P2.\n")
	end

	if gamevars.P1.constants.maxmeter and gamefunctions.readplayeronemeter then
		createHUDElement(
			"p1meter",
			function(n) if n then changeConfig("p1meterx", n) end return hud.meter.P1.x end,
			function(n) if n then changeConfig("p1metery", n) end return hud.meter.P1.y end,
			function(n) if n~=nil then changeConfig("p1meterenabled", n) end return hud.meter.P1.enabled end,
			function() resetConfig("p1meterx") resetConfig("p1metery") resetConfig("p1meterenabled") end,
			function() gui.text(hud.meter.P1.x, hud.meter.P1.y, gamevars.P1.meter, hud.meter.P1.textcolour) end
		)
		if gamefunctions.writeplayeronemeter and gamefunctions.readplayertwohealth and gamefunctions.playertwoinhitstun then
			table.insert(registers.registerafter, function() meterHandler("P1") end)
		else
			combovars.P1.instantrefillmeter = true
		end
	else
		write "Can't auto-refill P1 meter"
	end

	if gamevars.P1.constants.maxmeter and gamefunctions.writeplayeronemeter then
		table.insert(registers.registerafter, function() instantMeter("P1") end)
	else
		write "Can't auto-refill P1 meter"
	end

	if gamevars.P2.constants.maxmeter and gamefunctions.readplayertwometer then
		createHUDElement(
			"p2meter",
			function(n) if n then changeConfig("p2meterx", n) end return hud.meter.P2.x end,
			function(n) if n then changeConfig("p2metery", n) end return hud.meter.P2.y end,
			function(n) if n~=nil then changeConfig("p2meterenabled", n) end return hud.meter.P2.enabled end,
			function() resetConfig("p2meterx") resetConfig("p2metery") resetConfig("p2meterenabled") end,
			function() gui.text(hud.meter.P2.x, hud.meter.P2.y, gamevars.P2.meter, hud.meter.P2.textcolour) end
		)
		if gamefunctions.writeplayertwometer and gamefunctions.readplayeronehealth and gamefunctions.playeroneinhitstun then
			table.insert(registers.registerafter, function() meterHandler("P2") end)
		else
			combovars.P2.instantrefillmeter = true
		end
	else
		write "Can't auto-refill P2 meter"
	end

	if gamevars.P2.constants.maxmeter and gamefunctions.writeplayertwometer then
		table.insert(registers.registerafter, function() instantMeter("P2") end)
	else
		write "Can't auto-refill P2 meter"
	end

	if gamefunctions.hitboxesreg and gamefunctions.hitboxesregafter then
		table.insert(registers.interactiveguiregister, hitboxesReg)
		table.insert(registers.registerafter, hitboxesRegAfter)
	else
		write "Can't display hitboxes"
	end

	if gamefunctions.inputdisplayreg then
		table.insert(registers.interactiveguiregister, inputDisplayReg)
	else
		write "Can't display simple inputs"
	end

	if gamefunctions.scrollinginputreg and gamefunctions.scrollinginputregafter then
		table.insert(registers.interactiveguiregister, scrollingInputReg)
		table.insert(registers.registerafter, scrollingInputRegAfter)
	else
		write "Can't display scrolling inputs"
	end

	if gamevars.constants.translationtable then
		table.insert(registers.interactiveguiregister, drawReplayEditor)
	else
		write "Can't use the replay editor"
	end

	table.insert(registers.interactiveguiregister, drawHUD)
	table.insert(registers.interactiveguiregister, drawGUI)
	table.insert(registers.interactiveguiregister, readHotkeyIn)
	table.insert(registers.interactiveguiregister, runHotkeys)
	if nbuttons < MINIMUM_GUI_BUTTONS then
		local text = "TOO FEW BUTTONS ("..nbuttons..") TO OPERATE THE GUI"
		addTextItem(text, interactivegui.sw/2 - #text*LETTER_HALFWIDTH, 50, "cyan")
	else
		table.insert(registers.interactiveguiregister, buttonHandler)
		if gamevars.constants.translationtable then
			table.insert(registers.interactiveguiregister, drawHelp)
			table.insert(registers.registerbefore, readGUIInputs)
			table.insert(registers.interactiveguiregister, processGUIInputs)
			table.insert(registers.interactiveguiregister, moveHUDInteract)
		else
			write "No translation table found, can't read or process inputs from controller, or show input help, use lua hotkeys"
		end
	end

	if DEBUG and gamefunctions.playeronefacingleft and gamefunctions.playertwofacingleft then
		local x = interactivegui.sw/2 - 80
		table.insert(registers.interactiveguiregister, function()
			local p1left = playerOneFacingLeft() and "true" or "false"
			local p2left = playerTwoFacingLeft() and "true" or "false"
			gui.text(x, 0, "Facing Left; Player 1: "..p1left..", Player 2: "..p2left)
		end)
	end

	--kb
	local kb = inputs.properties.kb
	createHUDElement(
		"kb",
		function(n) if n then changeConfig("kbx", n) end return hud.kb.x end,
		function(n) if n then changeConfig("kby", n) end return hud.kb.y end,
		function(n) if n~=nil then changeConfig("kbenabled", n) end return hud.kb.enabled end,
		function() resetConfig("kbx") resetConfig("kby") resetConfig("kbenabled") end,
		function() drawKB(hud.kb.x, hud.kb.y) end
	)

	if scrollingInputReg then -- if scrolling-input-display.lua is loaded
		local scroll = inputs.properties.scrollinginput -- keep it short
		createHUDElement(
			"p1scrollinginput",
			function(n) if n then changeConfig("scrollinginputxp1", n) end return inputs.properties.scrolling.P1.x end, -- we know n is either nil or an int, never a bool
			function(n) if n then changeConfig("scrollinginputyp1", n) end return inputs.properties.scrolling.P1.y end,
			function(n) if n~=nil then changeConfig("scrollinginputenabledp1", n) end togglescrollinginputsplayer() return inputs.properties.scrolling.P1.enabled end,
			function() resetConfig("scrollinginputxp1") resetConfig("scrollinginputyp1") resetConfig("scrollinginputenabledp1") resetConfig("scrollinginputframes") resetConfig("scrollinginputiconsize") scrollingInputReload() end,
			function() end, -- handled by scrolling-input-display.lua
			{ -- extra functions for scrolling input
				{name="NUMS",func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then changeConfig("scrollinginputframes", not getConfigValue("scrollinginputframes")) end end}, -- toggle numbers
				{name="INC", func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then if inputs.properties.scrolling.iconsize<16 then changeConfig("scrollinginputiconsize", inputs.properties.scrolling.iconsize+1) scrollingInputReload() end end end}, -- increase size of text (prone to crashing)
				{name="DEC", func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then if inputs.properties.scrolling.iconsize>8  then changeConfig("scrollinginputiconsize", inputs.properties.scrolling.iconsize-1) scrollingInputReload() end end end}, -- increase size of text (prone to crashing)
			}
		)
		createHUDElement(
			"p2scrollinginput",
			function(n) if n then changeConfig("scrollinginputxp2", n) end return inputs.properties.scrolling.P2.x end,
			function(n) if n then changeConfig("scrollinginputyp2", n) end return inputs.properties.scrolling.P2.y end,
			function(n) if n~=nil then changeConfig("scrollinginputenabledp2", n) end togglescrollinginputsplayer() return inputs.properties.scrolling.P2.enabled end,
			function() resetConfig("scrollinginputxp2") resetConfig("scrollinginputyp2") resetConfig("scrollinginputenabledp2") resetConfig("scrollinginputframes") resetConfig("scrollinginputiconsize") scrollingInputReload() end,
			function() end, -- handled by scrolling-input-display.lua
			{ -- extra functions for scrolling input
				{name="NUMS",func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then changeConfig("scrollinginputframes", not getConfigValue("scrollinginputframes")) end end}, -- toggle numbers
				{name="INC", func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then if inputs.properties.scrolling.iconsize<16 then changeConfig("scrollinginputiconsize", inputs.properties.scrolling.iconsize+1) scrollingInputReload() end end end}, -- increase size of text (prone to crashing)
				{name="DEC", func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then if inputs.properties.scrolling.iconsize>8  then changeConfig("scrollinginputiconsize", inputs.properties.scrolling.iconsize-1) scrollingInputReload() end end end}, -- increase size of text (prone to crashing)
			}
		)
	end

	if inputDisplayReg then -- simple inputs
		local simple = inputs.properties.simpleinput -- keep it short
		createHUDElement(
			"p1simpleinput",
			function(n) if n then changeConfig("simpleinputxp1", n) end return inputs.properties.simple.P1.x end,
			function(n) if n then changeConfig("simpleinputyp1", n) end return inputs.properties.simple.P1.y end,
			function(n) if n~=nil then changeConfig("simpleinputenabledp1", n) end return inputs.properties.simple.P1.enabled end,
			function() resetConfig("simpleinputxp1") resetConfig("simpleinputyp1") resetConfig("simpleinputenabledp1") end,
			function() end -- handled by input-display.lua
		)
		createHUDElement(
			"p2simpleinput",
			function(n) if n then changeConfig("simpleinputxp2", n) end return inputs.properties.simple.P2.x end,
			function(n) if n then changeConfig("simpleinputyp2", n) end return inputs.properties.simple.P2.y end,
			function(n) if n~=nil then changeConfig("simpleinputenabledp2", n) end return inputs.properties.simple.P2.enabled end,
			function() resetConfig("simpleinputxp2") resetConfig("simpleinputyp2") resetConfig("simpleinputenabledp2") end,
			function() end -- handled by input-display.lua
		)
	end

	emu.registerbefore(function()
		fc = emu.framecount() -- update framecount
		gui.clearuncommitted() -- just in case
		for _,v in pairs(registers.registerbefore) do
			v()
		end
	end)

	gui.register(function()
		for _,v in ipairs(registers.interactiveguiregister) do
			v()
		end
	end)

	local garbage = function() -- garbage collection
		if collectgarbage("count") > 15000 then -- not sure how much garbage fbneo can handle at a time
			collectgarbage("collect") -- garbage mostly comes from redoing gdimages in scrolling inputs and replays
		end
	end

	emu.registerafter(function()
		for _,v in ipairs(registers.registerafter) do
			v()
		end
		garbage()
	end)
	-- white space so error messages/etc. aren't immediately visible if the script launches successfully
	for _ = 1,20 do write() end

	usage()
	if gamemsg then write() gamemsg() write() end

	if not DEBUG then
		emu.registerexit(function()
			write()
			saveAllConfig()
			for _,v in ipairs(registers.emuexit) do
				v()
			end
		end)
	end
end

local saveprocedure = function()
	toggleStates({})
end

local loadprocedure = function()
	toggleStates({})
	savestatePlayBack()
end

savestate.registersave(saveprocedure)
savestate.registerload(loadprocedure)

----------------------------------------------
-- ADDONS
----------------------------------------------

-- global addons
dofile(filetree.addons) -- see what addons exist...
if DEBUG then
	for _, addon in pairs(DEBUG_addons_run) do
		if fexists("addon/"..addon) then
			dofile("addon/"..addon)
		end
	end
else
	for _, addon in pairs(addons_run) do
		if fexists("addon/"..addon) then
			dofile("addon/"..addon)
		end
	end
end
-- game specific addons
if fexists("games/"..gamename.."/addon/addons.lua") then
	dofile("games/"..gamename.."/addon/addons.lua")
	for _, v in pairs(addons_run) do
		if fexists("games/"..gamename.."/addon/"..v) then
			dofile("games/"..gamename.."/addon/"..v)
		end
	end
end
----------------------------------------------

-- Lua hotkeys
input.registerhotkey(1,
function()
	if interactivegui.enabled then
		callGUISelectionFunc()
	else
		togglePlayBack(nil, {})
	end
end)
input.registerhotkey(2,
function()
	if interactivegui.enabled then
		changeGUISelection()
	else
		toggleRecording(nil, {})
	end
end)
input.registerhotkey(3,
function()
	if interactivegui.enabled then
		interactiveGUISelectionInfo()
	else
		toggleSwapInputs(nil, {})
	end
end)
input.registerhotkey(4,
function()
	toggleInteractiveGUI(nil, {})
end)
input.registerhotkey(9, reloadGUIPages)

markConfigsUnchanged() -- anything before this was editing default values