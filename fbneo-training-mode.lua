-- macros
wb = memory.writebyte
ww = memory.writeword
rb = memory.readbyte
rw = memory.readword
rws = memory.readwordsigned
rdw = memory.readdword

local fc = emu.framecount()

local games = {
	aof3 = {"aof3", iconfile = "icons-neogeo-32.png"},
	cyberbots = {"cybots", hitboxes = "cps2-hitboxes", iconfile = "icons-jojos-32.png"},
	dinorex = {"dinorex", iconfile = "icons-taito-32.png"},
	dbz2 = {"dbz2", iconfile = "icons-banpresto-32.png"},
	doubledr = {"doubledr", iconfile= "icons-neogeo-32.png"},
	garou = {"garou", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	jchan2 = {"jchan2", hitboxes = "jchan2-hitboxes", iconfile = "icons-jchan2-32.png"},
	jojos = {"jojoba", "jojoban", "jojobanr1", hitboxes = "hftf-hitboxes", iconfile = "icons-jojos-32.png"},
	jojov = {"jojo", "jojon", hitboxes = "jojo-hitboxes", iconfile = "icons-jojos-32.png"},
	kof98 = {"kof98", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof2002 = {"kof2002", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	lb2 = {"lastbld2", hitboxes = "cps3-hitboxes", iconfile = "icons-neogeo-32.png"},
	matrim = {"matrim", iconfile = "icons-neogeo-32.png"},
	msh = {"msh", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mshvsf = {"mshvsf", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mvc = {"mvc", "mvsc", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mwarr = {"mwarr", iconfile = "icons-mwarr-32.png"},
	ninjamas = {"ninjamas", iconfile = "icons-neogeo-32.png"},
	redearth = {"redearth", hitboxes = "cps3-hitboxes", iconfile = "icons-capcom-32.png"},
	samsho = {"samsho", iconfile = "icons-neogeo-32.png"},
	samsho2 = {"samsho2", iconfile = "icons-neogeo-32.png"},
	samsho3 = {"samsho3", iconfile = "icons-neogeo-32.png"},
	samsho4 = {"samsho4", iconfile = "icons-neogeo-32.png"},
	samsho5 = {"samsho5", iconfile = "icons-neogeo-32.png"},
	samsho5sp = {"samsh5sp", iconfile = "icons-neogeo-32.png"},
	sfa2 = {"sfa2u", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	sgemf = {"sgemf", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	ssf2xjr1 = {"ssf2xjr1", hitboxes = "sf2-hitboxes", iconfile = "icons-capcom-32.png"},
	vhuntjr2 = {"vhuntjr2", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	wakuwak7 = {"wakuwak7" , iconfile = "icons-neogeo-32.png"},
	whp = {"whp", iconfile = "icons-neogeo-32.png"},
	xmvsf = {"xmvsf", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	xmcota = {"xmcota", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
}

local usage = function()
		print "Beta for fbneo-training-script"
		print "Replay with 1 coin press"
		print "Record with 2 coin presses"
		print "Swap inputs with 3 coin presses"
		print "Open the menu with 4 coin presses or hold the button to open it"
		print ""
		print "Move around the menu with left/right"
		print "Select a function with P1 Button 1"
		print "Read function info with P1 Button 2"
end

local defaultconfig = {
	p1 = {
		-- Health
		refillhealthspeed = 10,
		instantrefillhealth = true,
		refillhealthenabled = true,
		refillmeterspeed = 10,
		instantrefillmeter = false,
		refillmeterenabled = true,
	},
	p2 = {
		-- Health
		refillhealthspeed = 10,
		instantrefillhealth = false,
		refillhealthenabled = true,
		refillmeterspeed = 10,
		instantrefillmeter = false,
		refillmeterenabled = true,
	},
	
	-- Combo Gui
	combogui = {
		combotextx = 180,
		combotexty = 42,
		combotextcolour = 0xFFFF00FF,
		combotextcolour2 = 0x00FF00FF,
		damagetextcolour = 0x00FF00FF,
		totaltextcolour = 0x00FF00FF,
	},
	
	-- Interactive Gui
	
	interactivegui = {
		bg = 0xF0F0F0FF,
		ol = 0x000000FF,
		boxxd = 8, -- divisor
		boxxm = 7, -- multiplier
		boxyd = 10, -- divisor
		boxym = 9, -- multiplier
		selectioncolour = 0xFF0000FF,
	},
	
	-- Input Settings
	inputs = {
		simpleinputenabled = true,
		iconsize = 10,
		coinleniency = 10,
		state = 1,
		framenumbersenabled = false,
	},
	
	recording = {
		skiptostart = false,
		skiptofinish = false,
	},
	
	hitbox = {
		enabled = true,
	},
}

local config = defaultconfig
local rom = emu.romname()
local dirname
local interactiveguipages = {}

do -- file checking logic + variable tables
----------------------------------------------
-- ROM NAME
----------------------------------------------

for i, v in pairs(games) do
	for _, k in ipairs(v) do
		if (rom == k) then
			dirname = i
		end
	end
end

if not dirname then dirname = "" end
----------------------------------------------
-- CHECK IF ROM MEMORY FILE EXISTS
----------------------------------------------
local fs = io.open("games/"..dirname.."/"..dirname..".lua","r")

if fs then
	dofile("games/"..dirname.."/"..dirname..".lua")
else
	print("Memory addresses not found for "..rom)
end
----------------------------------------------
-- CHECK IF TABLEIO IS PRESENT AND TRYING TO OPEN CONFIG FILE
----------------------------------------------
fs = io.open("tableio.lua","r")
if fs then
	dofile("tableio.lua")
	fs = io.open("games/"..dirname.."//config.lua","r")
	if fs then
		config = table.load("games/"..dirname.."//config.lua")
		if not config then
			print("Can't read config file found for "..dirname..", using default config")
			config = defaultconfig
		else -- if the file is loaded, make sure the contents are at least superifically correct
			local check = true 
			for i, v in pairs(defaultconfig) do
				for j, k in pairs(v) do
					if not config[i] or type(k) ~= type(config[i][j]) then
						if not config[i] then
							config[i] = defaultconfig[i]					
						else
							config[i][j] = defaultconfig[i][j]
						end
						print("Error reading value "..i.."."..j.." from config file, using default")
					end
				end
			end
		end
	else
		print("Config file not found for "..dirname..", using default")
	end
	if dirname ~= nil and dirname~="" then
		assert(table.save(config,"games/"..dirname.."//config.lua")==nil, "Can't save config file")
	end
else
	print("Can't read/write")
end
----------------------------------------------


----------------------------------------------
-- VARIABLE TABLES
----------------------------------------------

availablefunctions = {}

checkAvailableFunctions = function() -- SETUP availablefunctions TABLE
	-- Training mode functions
	if Run then availablefunctions.run = true end
	if playerOneInHitstun then availablefunctions.playeroneinhitstun = true end
	if playerTwoInHitstun then availablefunctions.playertwoinhitstun = true end
	if readPlayerOneHealth then availablefunctions.readplayeronehealth = true end
	if writePlayerOneHealth then availablefunctions.writeplayeronehealth = true end
	if readPlayerTwoHealth then availablefunctions.readplayertwohealth = true end
	if writePlayerTwoHealth then availablefunctions.writeplayertwohealth = true end
	if readPlayerOneMeter then availablefunctions.readplayeronemeter = true end
	if writePlayerOneMeter then availablefunctions.writeplayeronemeter = true end
	if readPlayerTwoMeter then availablefunctions.readplayertwometer = true end
	if writePlayerTwoMeter then availablefunctions.writeplayertwometer = true end
	if playerOneFacingLeft then availablefunctions.playeronefacingleft = true end
	if playerTwoFacingLeft then availablefunctions.playertwofacingleft = true end
	-- 
	-- Hitbox functions
	if hitboxesReg then availablefunctions.hitboxesreg = true end
	if hitboxesRegAfter then availablefunctions.hitboxesregafter = true end
	--
	-- Inputs functions try to get these to load a global input table to avoid multiple joypad.get()'s?
	if inputDisplayReg then availablefunctions.inputdisplayreg = true end
	if scrollingInputReg then availablefunctions.scrollinginputreg = true end
	if scrollingInputRegAfter then availablefunctions.scrollinginputregafter = true end
	--
	-- Saving/Loading
	if table.save then availablefunctions.tablesave = true end
	if table.load then availablefunctions.tableload = true end
	--
end

checkAvailableFunctions()

interactivegui = {
	enabled = false,
	page = 1, -- these should be numbers referencing interactiveguipages
	selection = 1,
	sw = emu.screenwidth(),
	sh = emu.screenheight(),
	-- CONFIGS
	bgcolour = config.interactivegui.bg,
	olcolour = config.interactivegui.ol,
	boxx = emu.screenwidth()/config.interactivegui.boxxd, -- proportions of the screen
	boxy = emu.screenheight()/config.interactivegui.boxyd,
	boxx2 = config.interactivegui.boxxm*(emu.screenwidth()/config.interactivegui.boxxd),
	boxy2 = config.interactivegui.boxym*(emu.screenheight()/config.interactivegui.boxyd),
	boxxlength = (config.interactivegui.boxxm-1)*(emu.screenwidth()/config.interactivegui.boxxd), -- commonly used calculations
	boxylength = (config.interactivegui.boxym-1)*(emu.screenheight()/config.interactivegui.boxyd),
	selectioncolour = config.interactivegui.selectioncolour,
}

modulevars = {
	p1 = {
		inhitstun = false,
		health = 0,
		previoushealth = 0,
		meter = 0,
		constants = {},
	},
	p2 = {
		inhitstun = false,
		health = 0,
		meter = 0,
		previoushealth = 0,
		constants = {},
	},
	constants = {},
}

setAvailableConstants = function()  -- SETUP modulevars CONSTANTS TABLES
	if p1maxhealth then modulevars.p1.constants.maxhealth = p1maxhealth end
	if p2maxhealth then modulevars.p2.constants.maxhealth = p2maxhealth end
	if p1maxmeter then modulevars.p1.constants.maxmeter = p1maxmeter end
	if p2maxmeter then modulevars.p2.constants.maxmeter = p2maxmeter end
	if translationtable then modulevars.constants.translationtable = translationtable end
end

setAvailableConstants()

combovars = {
	p1 = {
		healthdiff = 0,
		previousdamage = 0,
		combo = 0,
		previouscombo = 0,
		displaycombo = 0,
		comboDamage = 0,
		refillhealth = 0,
		refillmeter = 0,
		-- CONFIGS
		refillhealthspeed = config.p1.refillhealthspeed,
		instantrefillhealth = config.p1.instantrefillhealth,
		refillhealthenabled = config.p1.refillhealthenabled,
		refillmeterspeed = config.p1.refillmeterspeed,
		instantrefillmeter = config.p1.instantrefillmeter,
		refillmeterenabled = config.p1.refillmeterenabled,
	},
	p2 = {
		healthdiff = 0,
		previousdamage = 0,
		combo = 0,
		previouscombo = 0,
		displaycombo = 0,
		comboDamage = 0,
		refillhealth = 0,
		refillmeter = 0,
		-- CONFIGS
		refillhealthspeed = config.p2.refillhealthspeed,
		instantrefillhealth = config.p2.instantrefillhealth,
		refillhealthenabled = config.p2.refillhealthenabled,
		refillmeterspeed = config.p2.refillmeterspeed,
		instantrefillmeter = config.p2.instantrefillmeter,
		refillmeterenabled = config.p2.refillmeterenabled,
	},
	-- CONFIGS
	-- combos
	combotextx = config.combogui.combotextx,
	combotexty = config.combogui.combotexty+10,
	combotextcolour = config.combogui.combotextcolour,
	combotextcolour2 = config.combogui.combotextcolour2,
	damagetextx = config.combogui.combotextx-4,
	damagetexty = config.combogui.combotexty,
	damagetextcolour = config.combogui.damagetextcolour,
	totaltextx = config.combogui.combotextx,
	totaltexty = config.combogui.combotexty+20,
	totaltextcolour = config.combogui.totaltextcolour,
	-- 
	
}

inputs = {
	properties = {
		simpleinput = {
			enabled = config.inputs.simpleinputenabled,
		},
		scrollinginput = {
			iconsize = config.inputs.iconsize,
			state = config.inputs.state,
			frames = config.inputs.framenumbersenabled,
		},
		coinleniency = config.inputs.coinleniency,
		enableinputswap = false,
		enablehold = false,
		p1hold = {},
		p2hold = {},
	},
	p1 = {},
	p2 = {},
	other = {},
	setinputs = {},
}

hitboxes = {
	enabled = config.hitbox.enabled,
}

recording = {
	{}, 
	{}, 
	{}, 
	{}, 
	{}, 
	recordingslot = 1,
	hitslot,
	blockslot,
	skiptostart = config.recording.skiptostart,
	skiptofinish = config.recording.skiptofinish,
}

----------------------------------------------
-- 
----------------------------------------------

----------------------------------------------
-- TRYING TO OPEN HITBOXES
----------------------------------------------
if games[dirname] then
	hitbox = games[dirname].hitboxes
else
	print("Game not supported")
	return
end

if hitbox then
	fs = io.open("hitboxes/"..hitbox..".lua","r")
	if fs then
		dofile("hitboxes/"..hitbox..".lua")
		else
		print("Hitbox file "..games[dirname].hitboxes.."not found for "..rom)
	end
else
	print("No associated hitbox file for "..rom)
end

----------------------------------------------	
-- TRYING TO DISPLAY INPUTS
----------------------------------------------
fs = io.open("inputs\\input-display.lua","r")
	
if fs then
	fs = io.open("inputs\\input-modules.lua","r")
	
	if fs then
		dofile("inputs\\input-display.lua")
	else
		print("input-modules.lua not found")
	end
else
	print("input-display.lua not found")
end

if games[dirname].iconfile then
	iconfile = games[dirname].iconfile
	fs = io.open("inputs\\scrolling-input\\"..iconfile,"r")
	if fs then
		fs = io.open("inputs\\scrolling-input-display.lua","r")
	
		if fs then
			fs = io.open("inputs\\scrolling-input\\scrolling-input-code.lua","r")
			if fs then
				dofile("inputs\\scrolling-input-display.lua")
			else
				print("scrolling-input-code.lua not found")
			end
		else
			print("scrolling-input-display.lua not found")
		end
	else
		print("inputs\\scrolling-input\\"..iconfile.." not found")
	end
else
	print("No scrolling input image found for "..rom)
end
----------------------------------------------
-- 
----------------------------------------------

----------------------------------------------
-- CHECK IF GUI PAGES EXISTS AND OPEN
----------------------------------------------
local fs = io.open("guipages.lua","r")

if fs then
	dofile("guipages.lua")
	interactiveguipages = guipages
else
	print("Gui pages not found"..rom)
end
----------------------------------------------
end

function orTable(tab) -- or a table (check if not empty)
	
	for _,v in pairs(tab) do
		if v then
			return true
		end
	end

	return false
end

function changeConfig(tab, index, value, otherlocation, otherindex) -- table in config (false or nil for base), index of variable to change, new value, otherlocation to change if necessary, otherindex if the index is different
	local c = {}
	
	if not tab then c = config
	else c = config[tab] end

	if type(value) ~=  type(c[index]) then return end -- make sure the right type is being passed
	config.changed = true
	c[index] = value
	if otherlocation then
		if otherindex then
			otherlocation[otherindex] = value
		else
			otherlocation[index] = value
		end
	end
end

local saveConfig = function()
	if not availablefunctions.tablesave or not config.changed then return end
	config.changed = nil -- only saves if the config has changed
	print("Saving config: " ..dirname.."//config.lua")
	assert(table.save(config,"games/"..dirname.."//config.lua")==nil, "Can't save config file")
end

local updateModuleVars = function()
	if availablefunctions.playertwoinhitstun then
		modulevars.p2.inhitstun = playerTwoInHitstun()
	end
	if availablefunctions.playeroneinhitstun then
		modulevars.p1.inhitstun = playerOneInHitstun()
	end

	if availablefunctions.readplayeronehealth then
		modulevars.p1.previoushealth = modulevars.p1.health
		modulevars.p1.health = readPlayerOneHealth()
	end
	
	if availablefunctions.readplayertwohealth then
		modulevars.p2.previoushealth = modulevars.p2.health
		modulevars.p2.health = readPlayerTwoHealth()
	end
	
	if availablefunctions.playertwofacingleft then
		modulevars.p2.facingleft = playerTwoFacingLeft()
	end
	if availablefunctions.playeronefacingleft then
		modulevars.p1.facingleft = playerOneFacingLeft()
	end

	if availablefunctions.readplayeronemeter then
		modulevars.p1.meter = readPlayerOneMeter()
	end
	if availablefunctions.readplayertwometer then
		modulevars.p2.meter = readPlayerTwoMeter()
	end

end


local comboHandlerP1 = function()

	combovars.p1.healthdiff = modulevars.p1.previoushealth - modulevars.p1.health
	
	combovars.p1.previouscombo = combovars.p1.combo
	
	if combovars.p1.healthdiff ~= 0 and modulevars.p1.inhitstun then
		combovars.p1.combo = combovars.p1.combo+1 -- if theres a difference in health detected and p1 is in a combo
	end
	
	if not modulevars.p1.inhitstun then
		combovars.p1.combo = 0 -- if p1 is not in hitstun the combo drops
	end
end

local healthHandlerP1 = function()

	if not combovars.p1.refillhealthenabled then return end
	
	if combovars.p1.combo ~= combovars.p1.previouscombo and not modulevars.p1.inhitstun then
		if combovars.p1.refillhealth == 0 then
			combovars.p1.refillhealth = math.ceil((modulevars.p1.constants.maxhealth - modulevars.p1.health) / combovars.p1.refillhealthspeed) -- refill speed
		end
	end
	
	if modulevars.p1.inhitstun then
		combovars.p1.refillhealth = 0
	end
	
	if combovars.p1.refillhealth ~= 0 then
		if (combovars.p1.refillhealth + modulevars.p1.health >= modulevars.p1.constants.maxhealth) or combovars.p1.instantrefillhealth then
			writePlayerOneHealth(modulevars.p1.constants.maxhealth)
			combovars.p1.refillhealth = 0
		else
			writePlayerOneHealth(modulevars.p1.health + combovars.p1.refillhealth)
		end
	end
end

local meterHandlerP1 = function()

	if not combovars.p1.refillmeterenabled then return end
	
	if combovars.p1.instantrefillmeter then
		writePlayerOneMeter(modulevars.p1.constants.maxmeter)
	end
	
	if combovars.p2.combo ~= combovars.p2.previouscombo and not modulevars.p2.inhitstun then
		if combovars.p1.refillmeter == 0 then
			combovars.p1.refillmeter = math.ceil((modulevars.p1.constants.maxmeter - modulevars.p1.meter) / combovars.p1.refillmeterspeed) -- refill speed
		end
	end
	
	if modulevars.p2.inhitstun then
		combovars.p1.refillmeter = 0
	end
	
	if combovars.p1.refillmeter ~= 0 then
		if (combovars.p1.refillmeter + modulevars.p1.meter >= modulevars.p1.constants.maxmeter) then
			writePlayerOneMeter(modulevars.p1.constants.maxmeter)
			combovars.p1.refillmeter = 0
		else
			writePlayerOneMeter(modulevars.p1.meter + combovars.p1.refillmeter)
		end
	end

end

local instantHealthP1 = function()
	if not combovars.p1.refillhealthenabled then return end
	if not combovars.p1.instantrefillhealth then return end
	writePlayerOneHealth(modulevars.p1.constants.maxhealth)
end

local instantMeterP1 = function()
	if not combovars.p1.refillmeterenabled then return end
	if not combovars.p1.instantrefillmeter then return end
	writePlayerOneMeter(modulevars.p1.constants.maxmeter)
end


local comboHandlerP2 = function()

	combovars.p2.healthdiff = modulevars.p2.previoushealth - modulevars.p2.health
	
	combovars.p2.previouscombo = combovars.p2.combo
	
	if combovars.p2.healthdiff ~= 0 and modulevars.p2.inhitstun then
		combovars.p2.combo = combovars.p2.combo+1 -- if theres a difference in health detected and p2 is in a combovars.combo
	end
	
	if not modulevars.p2.inhitstun then
		combovars.p2.combo = 0 -- if p2 is not in hitstun the combovars.combo drops
	end
	
	if modulevars.p2.inhitstun then
		gui.text(combovars.combotextx,combovars.combotexty,"Combo: "..combovars.p2.combo,combovars.combotextcolour)
		combovars.p2.displaycombo = combovars.p2.combo
	else
		gui.text(combovars.combotextx,combovars.combotexty,"Combo: "..combovars.p2.displaycombo,combovars.combotextcolour2)
	end
	
	if combovars.p2.healthdiff > 0 then
		gui.text(combovars.damagetextx,combovars.damagetexty,"Damage: " ..combovars.p2.healthdiff,combovars.damagetextcolour)
		combovars.p2.previousdamage = combovars.p2.healthdiff
		if combovars.p2.combo == 1 then
			combovars.p2.comboDamage=0
		end
		combovars.p2.comboDamage = combovars.p2.comboDamage + combovars.p2.healthdiff
	else
		gui.text(combovars.damagetextx,combovars.damagetexty,"Damage: " .. combovars.p2.previousdamage,combovars.damagetextcolour)
	end
   
   gui.text(combovars.totaltextx,combovars.totaltexty,"Total: " .. combovars.p2.comboDamage,combovars.totaltextcolour)
end

local healthHandlerP2 = function()
	
	if not combovars.p2.refillhealthenabled then return end

	if combovars.p2.combo ~= combovars.p2.previouscombo and not modulevars.p2.inhitstun then
		if combovars.p2.refillhealth == 0 then
			combovars.p2.refillhealth = math.ceil((modulevars.p2.constants.maxhealth - modulevars.p2.health) / combovars.p2.refillhealthspeed) -- refill speed
		end
	end
	
	if modulevars.p2.inhitstun then
		combovars.p2.refillhealth = 0
	end
	
	if combovars.p2.refillhealth ~= 0 then
		if (combovars.p2.refillhealth + modulevars.p2.health >= modulevars.p2.constants.maxhealth) or combovars.p2.instantrefillhealth then
			writePlayerTwoHealth(modulevars.p2.constants.maxhealth)
			combovars.p2.refillhealth = 0
		else
			writePlayerTwoHealth(modulevars.p2.health + combovars.p2.refillhealth)
		end
	end
end

local meterHandlerP2 = function()

	if not combovars.p2.refillmeterenabled then return end
	
	if combovars.p2.instantrefillmeter then
		writePlayerTwoMeter(modulevars.p2.constants.maxmeter)
	end
	
	if combovars.p1.combo ~= combovars.p1.previouscombo and not modulevars.p1.inhitstun then
		if combovars.p2.refillmeter == 0 then
			combovars.p2.refillmeter = math.ceil((modulevars.p2.constants.maxmeter - modulevars.p2.meter) / combovars.p2.refillmeterspeed) -- refill speed
		end
	end
	
	if modulevars.p1.inhitstun then
		combovars.p2.refillmeter = 0
	end
	
	if combovars.p2.refillmeter ~= 0 then
		if (combovars.p2.refillmeter + modulevars.p2.meter >= modulevars.p2.constants.maxmeter) then
			writePlayerTwoMeter(modulevars.p2.constants.maxmeter)
			combovars.p2.refillmeter = 0
		else
			writePlayerTwoMeter(modulevars.p2.meter + combovars.p2.refillmeter)
		end
	end
end

local instantHealthP2 = function()
	if not combovars.p2.refillhealthenabled then return end
	if not combovars.p2.instantrefillhealth then return end
	writePlayerTwoHealth(modulevars.p2.constants.maxhealth)
end

local instantMeterP2 = function()
	if not combovars.p2.refillmeterenabled then return end
	if not combovars.p2.instantrefillmeter then return end
	writePlayerTwoMeter(modulevars.p2.constants.maxmeter)
end

local guiinputs = {
	P1 = {previousinputs={}, coinframestart = 0, coinpresscount = 0},
	P2 = {previousinputs={}},
}

local readGuiInputs = function()
	local input
	for i,v in pairs(joypad.get()) do -- check every button
		player = i:sub(1,2)
		input = i:sub(4)
		if player == "P1" then
			guiinputs.P1[modulevars.constants.translationtable[1][modulevars.constants.translationtable[input]]] = v
		elseif player == "P2" then
			guiinputs.P2[modulevars.constants.translationtable[1][modulevars.constants.translationtable[input]]] = v
		end
	end
end

local readInputs = function()
	local input
	for i,v in pairs(joypad.get()) do -- check every button
		player = i:sub(1,2)
		input = i:sub(4)
		if player == "P1" then
			inputs.p1[input] = v
		elseif player == "P2" then
			inputs.p2[input] = v
		else
			inputs.other[i] = v
		end
	end
	inputs.setinputs = {}
end


local toggleSwapInputs = function(bool)
	if bool == false then inputs.properties.enableinputswap = false return end
	if bool == true then inputs.properties.enableinputswap = true return end
	inputs.properties.enableinputswap = not inputs.properties.enableinputswap
end

local swapInputs = function()

	if not inputs.properties.enableinputswap then return end
	
	local tab = inputs.p1
	inputs.p1 = inputs.p2
	inputs.p2 = tab
	
	tab = combinePlayerInputs(inputs.p1, inputs.p2)
	inputs.setinputs = tab
end


local swapPlayerInput = function(player)
	
	local tab = copytable(player) -- shallow copy
	
	tab.Left = not tab.Left
	tab.Right = not tab.Right
	
	return tab
	
end

combinePlayerInputs = function(P1, P2)
	
	if type(P1) ~= "table" or type(P2) ~= "table" then return end
	
	local t = {}
	
	for i,v in pairs(P1) do
		t["P1 "..i] = v
	end
	for i,v in pairs(P2) do
		t["P2 "..i] = v
	end
	return t
end

local freezePlayer = function(player)
	
	if player == 1 or not player then
		if inputs.properties.p1freeze then
			for i,_ in pairs(inputs.p1) do
				inputs.setinputs["P1 "..i] = false
			end
		end
	end
	
	if player == 2 or not player then
		if inputs.properties.p2freeze then
			for i,_ in pairs(inputs.p2) do
				inputs.setinputs["P2 "..i] = false
			end
		end
	end
end

local toggleRecording = function(bool)
	recording.playback = false
	
	if bool then recording.enabled = true end
	if bool == false then recording.enabled = false
	elseif not bool then recording.enabled = not recording.enabled end
	
	toggleSwapInputs(recording.enabled)
	
	if recording.enabled then
		recording[recording.recordingslot] = {}
		recording.framestart = fc
	else
		if not recording[recording.recordingslot].start then -- if nothing is recorded
			recording[recording.recordingslot] = {}			
		end
	end
end

local logRecording = function()

	if not recording.enabled then return end
	if not recording[recording.recordingslot] then recording[recording.recordingslot] = {} end
	
	local tab = {
		p1 = copytable(inputs.p1),
		p2 = copytable(inputs.p2),
		other = copytable(inputs.other)
	}
	
	if not recording[recording.recordingslot].start then
		if orTable(tab.p2) and not tab.p2.Coin then
			recording[recording.recordingslot].start = fc - recording.framestart
		end
	end
	
	if orTable(tab.p2) and not tab.p2.Coin then
		recording[recording.recordingslot].finish = fc - recording.framestart
	end
	
	if availablefunctions.playertwofacingleft then
		tab.p2facingleft = modulevars.p2.facingleft
	end
	
	table.insert(recording[recording.recordingslot], tab)
	gui.text(1,1,"Slot "..recording.recordingslot.." (0/"..#recording[recording.recordingslot]..")","red")
	
end

local tableList = function()
	local tab = {}
	local count = 0
	for _,v in ipairs(recording) do
		if orTable(v) then
			count = count+1
			tab[count] = v
		end
	end
	return tab
end

local togglePlayBack = function(bool)
	recording.enabled = false
	toggleSwapInputs(false)
	
	local recordslot = recording[recording.recordingslot]
	
	if not recordslot.start then -- if nothing is recorded
		recording[recording.recordingslot] = {}		
	end
	if not recordslot[1] then return end
	
	if bool then recording.playback = true end
	if bool == false then recording.playback = false 
	elseif not bool then recording.playback = not recording.playback end	
	
	if not recording.playback then 
		recordslot.framestart = nil
	else
		if recording.randomise then
			local pos
			local recordings = tableList()
			if #recordings > 0 then
				pos = math.random(#recordings)
			end
			if recordings[pos] ~= nil then
				recording.recordingslot = pos
			end
		end
	end
end

local playBack = function()
	if not recording.playback then return end
	local recordslot = recording[recording.recordingslot]
	if not recordslot then return end
	
	if not recordslot.framestart then recordslot.framestart = fc - 1 end
	
	local start, finish = 0, #recordslot
	
	if recording.skiptostart and recordslot.start then start = recordslot.start end
	if recording.skiptofinish and recordslot.finish then finish = recordslot.finish end
	
	if fc - recordslot.framestart + start > finish then
		recordslot.framestart = nil
		if not recording.loop then
			recording.playback = false
		end
	else
		gui.text(1,1,"Slot "..recording.recordingslot.." ("..fc-recordslot.framestart.."/"..#recordslot..")")
		local t = recordslot[fc - recordslot.framestart + start].p2
		local orientated = modulevars.p2.facingleft == recordslot[fc - recordslot.framestart + start].p2facingleft
		if not orientated and recording.autoturn then
			t = swapPlayerInput(t)
		end
		inputs.setinputs = combinePlayerInputs(inputs.p1, t)
	end
end

local hitPlayBack = function()
	if not recording.hitslot then return end
	if not recording.hitplayback and combovars.p2.previouscombo <= combovars.p2.combo then return end
	
	recording.hitplayback = true
	
	if recording.randomise then
		local pos
		local recordings = tableList()
		if #recordings > 0 then
			pos = math.random(#recordings)
		end
		if recordings[pos] ~= nil then
			recording.hitslot = pos
		end
	end
	
	local recordslot = recording[recording.hitslot]
	if not recordslot.start then -- if nothing is recorded
		recording[recording.hitslot] = {}		
	end
	if not recordslot[1] then return end
	
	if not recordslot.framestart then recordslot.framestart = fc - 1 end
	
	local start, finish = 0, #recordslot
	
	if recording.skiptostart and recordslot.start then start = recordslot.start end
	if recording.skiptofinish and recordslot.finish then finish = recordslot.finish end
	
	if fc - recordslot.framestart + start > finish then
		recordslot.framestart = nil
		if not recording.loop then
			recording.hitplayback = false
		end
	else
		gui.text(1,1,"Slot "..recording.hitslot.." ("..fc-recordslot.framestart.."/"..#recordslot..")")
		local t = recordslot[fc - recordslot.framestart + start].p2
		local orientated = modulevars.p2.facingleft == recordslot[fc - recordslot.framestart + start].p2facingleft
		if not orientated and recording.autoturn then
			t = swapPlayerInput(t)
		end
		inputs.setinputs = combinePlayerInputs(inputs.p1, t)
	end
end

local setInputs = function()
	if inputs.properties.enableinputswap or recording.playback or recording.hitplayback or inputs.properties.enablehold or inputs.properties.p1freeze or inputs.properties.p2freeze then
		joypad.set(inputs.setinputs)
	end
end

setDirection = function(player, ...) -- getting a player to hold down/up etc.
	local dir1, dir2 = ...

	inputs.properties.enablehold = dir1 or dir2

	inputs.properties.p1hold = {}
	inputs.properties.p2hold = {}

	if player == 1 then 
		if dir1 then inputs.properties.p1hold[dir1] = true end
		if dir2 then inputs.properties.p1hold[dir2] = true end
	end

	if player == 2 then
		if dir1 then inputs.properties.p2hold[dir1] = true end
		if dir2 then inputs.properties.p2hold[dir2] = true end
	end

end

local applyDirection = function() -- getting a player to hold down/up etc.
	if not inputs.properties.enablehold then return end
	for i, _ in pairs(inputs.properties.p1hold) do
		inputs.setinputs["P1 "..i] = true
	end
	for i, _ in pairs(inputs.properties.p2hold) do
		inputs.setinputs["P2 "..i] = true
	end
end

local toggleInteractiveGuiEnabled = function(bool)
	recording.playback = false
	recording.hitplayback = false
	recording.enabled = false
	if not recording[recording.recordingslot] then recording[recording.recordingslot] = {} end
	recording[recording.recordingslot].framestart = nil
	inputs.properties.enableinputswap = false
	
	if bool then interactivegui.enabled = true end
	if bool == false then interactivegui.enabled = false
	elseif not bool then interactivegui.enabled = not interactivegui.enabled end
	
	inputs.properties.p1freeze = interactivegui.enabled
	inputs.properties.p2freeze = interactivegui.enabled
end

local drawInteractiveGui = function()

	if not interactivegui.enabled then return end
	
	local boxx, boxy, boxx2, boxy2, bgcolour, olcolour, page, selection
	
	boxx = interactivegui.boxx 
	boxy = interactivegui.boxy 
	boxx2 = interactivegui.boxx2 
	boxy2 = interactivegui.boxy2 
	bgcolour = interactivegui.bgcolour
	olcolour = interactivegui.olcolour
	
	gui.box(boxx,boxy,boxx2,boxy2,bgcolour,olcolour)

	page = interactiveguipages[interactivegui.page]
	selection = page[interactivegui.selection]

	local w, h, colour
	for i,v in pairs(page) do
		if v.autofunc then
			v:autofunc()
		end
		
		if i ~= interactivegui.selection then 
			--FC uses 5.1 at the time of writing so I can't goto
	
			if not v.x then v.x = 0 end
			if not v.y then v.y = 0 end
			if not v.text then v.text = " " end
			if not v.textcolour then v.textcolour = "white" end
			if not v.bgcolour then v.bgcolour = bgcolour end
			if not v.olcolour then v.olcolour = bgcolour end
		
			w, h = #v.text*4, 10
			
			if v.bgcolour ~= bgcolour or v.olcolour ~= bgcolour then
				gui.box(v.x + boxx, v.y + boxy, v.x + boxx + w + 4, v.y + boxy + h, v.bgcolour, v.olcolour)
			end
			gui.text(v.x + boxx + 3, v.y + boxy + 2, v.text, v.textcolour)
		end
	end
	
	-- draws the selected box but with a red outline instead
	
	if selection.selectfunc then selection.selectfunc() end
	
	if not selection.x then selection.x = 0 end
	if not selection.y then selection.y = 0 end
	if not selection.text then selection.text = "" end
	if not selection.textcolour then selection.textcolour = "white" end
	if not selection.bgcolour then selection.bgcolour = bgcolour end
	if not selection.olcolour then selection.olcolour = bgcolour end
		
	w, h = #selection.text*4, 10
	colour = interactivegui.selectioncolour
	gui.box(selection.x + boxx, selection.y + boxy, selection.x + boxx + w + 4, selection.y + boxy + h, selection.bgcolour, colour)
	gui.text(selection.x + boxx + 3, selection.y + boxy + 2, selection.text, selection.textcolour)
	
end

local callGuiSelectionFunc = function()
	local func = interactiveguipages[interactivegui.page][interactivegui.selection].func
	if not interactivegui.enabled or not func then return end
	func()
end

local interactiveGuiSelectionInfo = function()
	local info = interactiveguipages[interactivegui.page][interactivegui.selection].info
	if not interactivegui.enabled or not info then return end
	
	local largest = 0
	local sw, sh, y2 = interactivegui.sw, interactivegui.sh, interactivegui.boxy2
	
	
	for _,v in ipairs(info) do
		if largest < #v then largest = #v end
	end
	
	gui.box(sw/2 - 3 - (largest)*2, y2 - (#info)*10, sw/2 + 1 + (largest)*2, y2, 0x89cfefff, "black")
	
	for i,v in ipairs(info) do
		gui.text(sw/2 - #v*2, y2 - (#info)*10 + 2 + (i-1)*10, v)
	end
end


changeInteractiveGuiPage = function(n)
	if not interactivegui.enabled then return end
	if not n then n = 1 end
	
	if interactiveguipages[n] then -- if the page exists go there
		interactivegui.page = n
	else -- otherwise try to wrap-around
		if n == 0 then
			interactivegui.page = #interactiveguipages -- goto last
		elseif n == #interactiveguipages+1 then
			interactivegui.page = 1 -- goto first
		end -- otherwise do nothing
	end
	
	local page = interactiveguipages[interactivegui.page]
	
	if interactivegui.selection > #page then -- make sure selection is in bounds
		interactivegui.selection = #page
	elseif interactivegui.selection < 1 then
		interactivegui.selection = 1
	end
end

changeInteractiveGuiSelection = function(n)
	if not interactivegui.enabled then return end
	if not n then n = interactivegui.selection+1 end
	local page = interactiveguipages[interactivegui.page] -- current page
	
	if page[n] then -- if the selection exists go there
		interactivegui.selection = n
	else -- otherwise try to wrap around
		if n == 0 then
			interactivegui.selection = #page -- goto last
		elseif n == #page+1 then
			interactivegui.selection = 1 -- goto first
		end -- otherwise do nothing
	end
end


--fall backs in case can't read joypad input
input.registerhotkey(1, toggleInteractiveGuiEnabled) 
input.registerhotkey(2, callGuiSelectionFunc)
input.registerhotkey(3, changeInteractiveGuiSelection)
input.registerhotkey(4, function() print(interactiveguipages[interactivegui.page][interactivegui.selection].info) end)
input.registerhotkey(5, function() recording.hitplayback = true end)


local parseInputs = function() 
	--inspired by grouflons and crystal_cubes menus
	if guiinputs.P1.coin and not guiinputs.P1.previousinputs.coin then -- one clean input
		guiinputs.P1.coinframestart = fc
		guiinputs.P1.coinpresscount = guiinputs.P1.coinpresscount+1
	end
	
	
	if fc - guiinputs.P1.coinframestart >= inputs.properties.coinleniency and guiinputs.P1.coinframestart ~= 0 and not guiinputs.P1.coin then
		if fc - guiinputs.P1.coinframestart > inputs.properties.coinleniency*3 or interactivegui.enabled then
			guiinputs.P1.coinpresscount = 0
		end
		if guiinputs.P1.coinpresscount == 1 then
			togglePlayBack()
		elseif guiinputs.P1.coinpresscount == 2 then
			toggleRecording()
		elseif guiinputs.P1.coinpresscount == 3 then
			toggleSwapInputs()
		else
			toggleInteractiveGuiEnabled()
		end
		guiinputs.P1.coinframestart = 0
		guiinputs.P1.coinpresscount = 0
	end
	
	if guiinputs.P1.button1 and not guiinputs.P1.previousinputs.button1 then
		callGuiSelectionFunc()
	end
	
	if guiinputs.P1.button2 then -- maybe add a func2 to buttons and move this to button3
		interactiveGuiSelectionInfo()
	end
	
	if guiinputs.P1.left and not guiinputs.P1.previousinputs.left then
		changeInteractiveGuiSelection(interactivegui.selection-1)
	end
	
	if guiinputs.P1.right and not guiinputs.P1.previousinputs.right then
		changeInteractiveGuiSelection(interactivegui.selection+1)
	end
	
	guiinputs.P1.previousinputs.coin = guiinputs.P1.coin
	guiinputs.P1.previousinputs.button1 = guiinputs.P1.button1
	guiinputs.P1.previousinputs.button3 = guiinputs.P1.button3
	guiinputs.P1.previousinputs.left = guiinputs.P1.left
	guiinputs.P1.previousinputs.right = guiinputs.P1.right
end


local registers = {
	registerbefore = {},
	guiregister = {},
	registerafter = {},
}

setRegisters = function()
	
	checkAvailableFunctions()
	setAvailableConstants()
	
	if availablefunctions.playertwofacingleft then
		recording.autoturn = true
	else 
		print("Can't auto-swap directions in replays") 
	end
	
	registers.registerbefore = {updateModuleVars, readInputs, swapInputs, logRecording, applyDirection, playBack, hitPlayBack, freezePlayer, setInputs}
	registers.guiregister = {}
	registers.registerafter = {}
	
	if availablefunctions.run then
		table.insert(registers.guiregister, Run)
	else
		print("Nothing running every frame from memory file")
	end
	
	local str = ""
		
	if availablefunctions.readplayertwohealth and availablefunctions.playertwoinhitstun then
		table.insert(registers.guiregister, comboHandlerP2)
	else
		if not availablefunctions.readplayertwohealth then
			str = str .. "player two health read and "
		end
		if not availablefunctions.playertwoinhitstun then
			str = str .. "player two hitstun and "
		end
		print(str:sub(1,#str-5) .. " not set, can't do combos.\n")
	end

	if availablefunctions.readplayeronehealth and availablefunctions.playeroneinhitstun then
		table.insert(registers.guiregister, comboHandlerP1)
	else
		if not availablefunctions.readplayeronehealth then
			str = str .. "player one health read and "
		end
		if not availablefunctions.playeroneinhitstun then
			str = str .. "player one hitstun and "
		end
		print(str:sub(1,#str-5) .. " not set, can't do combos.\n")
	end

	if modulevars.p1.constants.maxhealth and availablefunctions.readplayeronehealth and availablefunctions.writeplayeronehealth and availablefunctions.playeroneinhitstun then
		table.insert(registers.registerafter, healthHandlerP1)
	else
		str = ""
		if not modulevars.p1.constants.maxhealth then
			str = str .. "max health and "
		end
		if not availablefunctions.readplayeronehealth then
			str = str .. "player one health read and "
		end
		if not availablefunctions.writeplayeronehealth then
			str = str .. "player one health write and "
		end
		if not availablefunctions.playeroneinhitstun then
			str = str .. "player one hitstun and "
		end
		print(str:sub(1,#str-5) .. " not set, can't do health refill for p1.\n")
	end

	if modulevars.p2.constants.maxhealth and availablefunctions.readplayertwohealth and availablefunctions.writeplayertwohealth and availablefunctions.playertwoinhitstun then
		table.insert(registers.registerafter, healthHandlerP2)
	else
		str = ""
		if not modulevars.p2.constants.maxhealth then
			str = str .. "max health and "
		end
		if not availablefunctions.readplayertwohealth then
			str = str .. "player two health read and "
		end
		if not availablefunctions.writeplayertwohealth then
			str = str .. "player two health write and "
		end
		if not availablefunctions.playertwoinhitstun then
			str = str .. "player two hitstun and "
		end
		print(str:sub(1,#str-5) .. " not set, can't do health refill for p2.\n")
	end
	
	if modulevars.p1.constants.maxhealth and availablefunctions.writeplayeronehealth then
		table.insert(registers.registerafter, instantHealthP1)
	else
		str = ""
		if not modulevars.p1.constants.maxhealth then
			str = str .. "max health and "
		end
		if not availablefunctions.writeplayeronehealth then
			str = str .. "player one health write and "
		end
		print(str:sub(1,#str-5) .. " not set, can't do health refill for p1.\n")
	end

	if modulevars.p2.constants.maxhealth and availablefunctions.writeplayertwohealth then
		table.insert(registers.registerafter, instantHealthP2)
	else
		str = ""
		if not modulevars.p2.constants.maxhealth then
			str = str .. "max health and "
		end
		if not availablefunctions.writeplayertwohealth then
			str = str .. "player two health write and "
		end
		print(str:sub(1,#str-5) .. " not set, can't do health refill for p2.\n")
	end

	if modulevars.p1.constants.maxmeter and availablefunctions.readplayeronemeter and availablefunctions.writeplayeronemeter and availablefunctions.readplayertwohealth and availablefunctions.playertwoinhitstun then
		table.insert(registers.registerafter, meterHandlerP1)
	else
		if modulevars.p1.constants.maxmeter and availablefunctions.writeplayeronemeter then
			print "Using P1 back-up Meter always full"
			table.insert(registers.registerafter, instantMeterP1)
			combovars.p1.instantrefillmeter = true
		else
			print "Can't auto-refill P1 meter"
		end
	end
	
	if modulevars.p2.constants.maxmeter and availablefunctions.readplayertwometer and availablefunctions.writeplayertwometer and availablefunctions.readplayeronehealth and availablefunctions.playeroneinhitstun then
		table.insert(registers.registerafter, meterHandlerP2)
	else
		if modulevars.p2.constants.maxmeter and availablefunctions.writeplayertwometer then
			print "Using P2 back-up Meter always full"
			table.insert(registers.registerafter, instantMeterP2)
			combovars.p2.instantrefillmeter = true
		else
			print "Can't auto-refill P2 meter"
		end
	end

	if availablefunctions.hitboxesreg and availablefunctions.hitboxesregafter then
		table.insert(registers.guiregister, hitboxesReg)
		table.insert(registers.registerafter, hitboxesRegAfter)
	else
		print "Can't display hitboxes"
	end
	
	if availablefunctions.inputdisplayreg then
		table.insert(registers.guiregister, inputDisplayReg)
	else
		print("Can't display simple inputs")
	end
	
	if availablefunctions.scrollinginputreg and availablefunctions.scrollinginputregafter then
		table.insert(registers.guiregister, scrollingInputReg)
		table.insert(registers.registerafter, scrollingInputRegAfter)
	else
		print("Can't display scrolling inputs")
	end
	
	table.insert(registers.guiregister, drawInteractiveGui) -- this should always be near the top
		
	if modulevars.constants.translationtable then
		table.insert(registers.registerbefore, readGuiInputs)
		table.insert(registers.guiregister, parseInputs)
	else
		print("No translation table found, can't read or process inputs from controller, use lua hotkeys")
	end
	
	emu.registerbefore(function ()
		fc = emu.framecount() -- update framecount
		for _,v in pairs(registers.registerbefore) do
			v()
		end
	end)
	
	gui.register(function ()
		for _,v in ipairs(registers.guiregister) do
			v()
		end
	end)
	
	
	
	local garbage = 	function () -- garbage collection
							if collectgarbage("count") > 100 then -- not sure how much garbage fbneo can handle at a time
								collectgarbage("collect") -- garbage mostly comes from redoing gdimages in scrolling inputs
							end
						end
	
	emu.registerafter(function ()
		for _,v in ipairs(registers.registerafter) do
			v()
		end
		garbage()
	end)
	
	print()
	usage()
end

local exitprocedure = function()
	saveConfig()
end

emu.registerexit(exitprocedure)

setRegisters()
