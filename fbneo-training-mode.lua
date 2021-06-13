-- macros
wb = memory.writebyte
ww = memory.writeword
rb = memory.readbyte
rw = memory.readword
rws = memory.readwordsigned
rdw = memory.readdword

FBNEO_TRAINING_MODE_VERSION = "v0.21.06.11"

local fc = emu.framecount()

local games = {
	aof = {"aof", iconfile = "icons-neogeo-32.png"},
	aof2 = {"aof2", iconfile = "icons-neogeo-32.png"},
	aof3 = {"aof3", iconfile = "icons-neogeo-32.png"},
	asurabus = {"asurabus", iconfile = "icons-asurabus-32.png"},
	breakrev = {"breakrev", iconfile = "icons-neogeo-32.png"},
	cyberbots = {"cybots", hitboxes = "cps2-hitboxes", iconfile = "icons-jojos-32.png"},
	daraku = {"daraku", hitboxes = "daraku-hitboxes", iconfile= "icons-psikyo-32.png"},
	dinorex = {"dinorex", iconfile = "icons-taito-32.png"},
	dbz2 = {"dbz2", iconfile = "icons-banpresto-32.png"},
	doubledr = {"doubledr", iconfile = "icons-neogeo-32.png"},
	fatfury3 = {"fatfury3", iconfile = "icons-neogeo-32.png"},
	fatfursp = {"fatfursp", iconfile = "icons-neogeo-32.png"},
	garou = {"garou", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	gowcaizr = {"gowcaizr", iconfile = "icons-neogeo-32.png"},
	jchan2 = {"jchan2", hitboxes = "jchan2-hitboxes", iconfile = "icons-kaneko-32.png"},
	jojos = {"jojoba", "jojoban", "jojobanr1", hitboxes = "hftf-hitboxes", iconfile = "icons-jojos-32.png"},
	jojov = {"jojo", "jojon", hitboxes = "jojo-hitboxes", iconfile = "icons-jojos-32.png"},
	kabukikl = {"kabukikl", iconfile = "icons-neogeo-32.png"},
	kof94 = {"kof94", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof95 = {"kof95", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof98 = {"kof98", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof2002 = {"kof2002", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	lb2 = {"lastbld2", hitboxes = "cps3-hitboxes", iconfile = "icons-neogeo-32.png"},
	matrim = {"matrim", iconfile = "icons-neogeo-32.png"},
	msh = {"msh", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mshvsf = {"mshvsf", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mvc = {"mvc", "mvsc", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mwarr = {"mwarr", iconfile = "icons-mwarr-32.png"},
	ninjamas = {"ninjamas", iconfile = "icons-neogeo-32.png"},
	rotd = {"rotd", hitboxes = "rotd-hitboxes", iconfile = "icons-neogeo-32.png"},
	rbff1 = {"rbff1", iconfile = "icons-neogeo-32.png"},
	rbff2 = {"rbff2", "rbff2h", iconfile = "icons-neogeo-32.png"},
	rbffspec = {"rbffspec", iconfile = "icons-neogeo-32"},
	redearth = {"redearth", hitboxes = "cps3-hitboxes", iconfile = "icons-capcom-32.png"},
	samsho = {"samsho", iconfile = "icons-neogeo-32.png"},
	samsho2 = {"samsho2", iconfile = "icons-neogeo-32.png"},
	samsho3 = {"samsho3", iconfile = "icons-neogeo-32.png"},
	samsho4 = {"samsho4", iconfile = "icons-neogeo-32.png"},
	samsho5 = {"samsho5", iconfile = "icons-neogeo-32.png"},
	samsho5sp = {"samsh5sp", iconfile = "icons-neogeo-32.png"},
	sfa2 = {"sfa2", "sfa2u", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	sgemf = {"sgemf", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	ssf2xjr1 = {"ssf2xjr1", hitboxes = "sf2-hitboxes", iconfile = "icons-capcom-32.png"},
	vhuntjr2 = {"nwarr", "vhuntjr2", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	wakuwak7 = {"wakuwak7", "wakuwak7bh", iconfile = "icons-neogeo-32.png"},
	whp = {"whp", iconfile = "icons-neogeo-32.png"},
	xmvsf = {"xmvsf", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	xmcota = {"xmcota", "xmcotabh", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
}

local usage = function()
		print ("Beta for fbneo-training-script ("..FBNEO_TRAINING_MODE_VERSION..")")
		print "Replay with 1 coin press"
		print "Record with 2 coin presses"
		print "Swap inputs with 3 coin presses"
		print "Open the menu with 4 coin presses or hold the button to open it"
		print ""
		print "Move around the menu with left/right"
		print "Select a function with P1 Button 1"
		print "Read function info with P1 Button 2"
		print "Return to the previous menu with P1 Button 3"
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
	hud = {
		p1healthx = 10,
		p1healthy = 10,
		p1healthtextcolour = 0xFFFFFFFF,
		p1healthenabled = false,
		p2healthx = 180,
		p2healthy = 10,
		p2healthtextcolour = 0xFFFFFFFF,
		p2healthenabled = false,
		p1meterx = 10,
		p1metery = 100,
		p1metertextcolour = 0xFFFFFFFF,
		p1meterenabled = false,
		p2meterx = 180,
		p2metery = 100,
		p2metertextcolour = 0xFFFFFFFF,
		p2meterenabled = false,
		combotextx = 180,
		combotexty = 42,
		combotextcolour = 0xFFFF00FF,
		combotextcolour2 = 0x00FF00FF,
		damagetextcolour = 0x00FF00FF,
		totaltextcolour = 0x00FF00FF,
		comboenabled = false,
	},
	
	-- Interactive Gui
	
	interactivegui = {
		bg = 0xF0F0F0FF,
		ol = 0x000000FF,
		barcolour = "yellow",
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
dirname = ""
local interactiveguipages = {}

function fexists(s)
	local fs = io.open(s,"r")
	local res = fs~=nil
	if (res) then
		fs:close()
	end
	return res
end

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

if fexists("games/"..dirname.."/"..dirname..".lua") then
	dofile("games/"..dirname.."/"..dirname..".lua")
else
	print("Memory addresses not found for "..rom)
end
----------------------------------------------
-- CHECK IF TABLEIO IS PRESENT AND TRYING TO OPEN CONFIG FILE
----------------------------------------------
-- TRY TO USE CONFIG.LUA, THEN A GAME'S DEFAULT CONFIG, THEN THE GENERAL DEFAULT CONFIG
----------------------------------------------
if fexists("tableio.lua") then
	dofile("tableio.lua")
	if not gamedefaultconfig then -- comes from game luas
		print "Game default config not found."
	else
		for i, v in pairs(gamedefaultconfig) do
			if not config[i] then config[i]={} end
			for j, k in pairs(v) do
				config[i][j] = k
			end
		end
	end
	if fexists("games/"..dirname.."/config.lua") then
		config = table.load("games/"..dirname.."/config.lua")
		if not config then
			print("Can't read config file found for "..dirname..", using default config.")
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
						print("Error reading value "..i.."."..j.." from config file, using default.")
					end
				end
			end
		end
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
	barcolour = config.interactivegui.barcolour,
	boxx = emu.screenwidth()/config.interactivegui.boxxd, -- proportions of the screen
	boxy = emu.screenheight()/config.interactivegui.boxyd,
	boxx2 = config.interactivegui.boxxm*(emu.screenwidth()/config.interactivegui.boxxd),
	boxy2 = config.interactivegui.boxym*(emu.screenheight()/config.interactivegui.boxyd),
	boxxlength = (config.interactivegui.boxxm-1)*(emu.screenwidth()/config.interactivegui.boxxd), -- commonly used calculations
	boxylength = (config.interactivegui.boxym-1)*(emu.screenheight()/config.interactivegui.boxyd),
	selectioncolour = config.interactivegui.selectioncolour,
	movehud = false,
	movehudselected = false,
	movehudselection = 1,
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
	if p1maxhealth then 
		modulevars.p1.constants.maxhealth = p1maxhealth
		modulevars.p1.maxhealth = p1maxhealth
	end
	if p2maxhealth then 
		modulevars.p2.constants.maxhealth = p2maxhealth
		modulevars.p2.maxhealth = p2maxhealth 
	end
	if p1maxmeter then 
		modulevars.p1.constants.maxmeter = p1maxmeter
		modulevars.p1.maxmeter = p1maxmeter
	end
	if p2maxmeter then 
		modulevars.p2.constants.maxmeter = p2maxmeter
		modulevars.p2.maxmeter = p2maxmeter
end
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
	
}

hud = {
	-- CONFIGS
	-- p1health
	p1healthx = config.hud.p1healthx,
	p1healthy = config.hud.p1healthy,
	p1healthtextcolour = config.hud.p1healthtextcolour,
	p1healthenabled = config.hud.p1healthenabled,
	--p1meter
	p1meterx = config.hud.p1meterx,
	p1metery = config.hud.p1metery,
	p1metertextcolour = config.hud.p1metertextcolour,
	p1meterenabled = config.hud.p1meterenabled,
	--p2health
	p2healthx = config.hud.p2healthx,
	p2healthy = config.hud.p2healthy,
	p2healthtextcolour = config.hud.p2healthtextcolour,
	p2healthenabled = config.hud.p2healthenabled,
	--p2meter
	p2meterx = config.hud.p2meterx,
	p2metery = config.hud.p2metery,
	p2metertextcolour = config.hud.p2healthtextcolour,
	p2meterenabled = config.hud.p2meterenabled,
	-- combos
	combotextx = config.hud.combotextx,
	combotexty = config.hud.combotexty,
	combotextcolour = config.hud.combotextcolour,
	combotextcolour2 = config.hud.combotextcolour2,
	damagetextcolour = config.hud.damagetextcolour,
	totaltextcolour = config.hud.totaltextcolour,
	comboenabled = config.hud.comboenabled,
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
	if fexists("hitboxes/"..hitbox..".lua") then
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
	
if fexists("inputs/input-display.lua") then
	if fexists("inputs/input-modules.lua") then
		dofile("inputs/input-display.lua")
	else
		print("input-modules.lua not found")
	end
else
	print("input-display.lua not found")
end

if games[dirname].iconfile then
	iconfile = games[dirname].iconfile
	if fexists("inputs/scrolling-input/"..iconfile) then
		if fexists("inputs/scrolling-input-display.lua") then
			if fexists("inputs/scrolling-input/scrolling-input-code.lua") then
				dofile("inputs/scrolling-input-display.lua")
			else
				print("scrolling-input-code.lua not found")
			end
		else
			print("scrolling-input-display.lua not found")
		end
	else
		print("inputs/scrolling-input/"..iconfile.." not found")
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
if fexists("guipages.lua") then
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
			combovars.p1.refillhealth = math.ceil((modulevars.p1.maxhealth - modulevars.p1.health) / combovars.p1.refillhealthspeed) -- refill speed
		end
	end
	
	if modulevars.p1.inhitstun then
		combovars.p1.refillhealth = 0
	end
	
	if combovars.p1.refillhealth ~= 0 then
		if (combovars.p1.refillhealth + modulevars.p1.health >= modulevars.p1.maxhealth) or combovars.p1.instantrefillhealth then
			writePlayerOneHealth(modulevars.p1.maxhealth)
			combovars.p1.refillhealth = 0
		else
			writePlayerOneHealth(modulevars.p1.health + combovars.p1.refillhealth)
		end
	end
end

local meterHandlerP1 = function()

	if not combovars.p1.refillmeterenabled then return end
	
	if combovars.p1.instantrefillmeter then
		writePlayerOneMeter(modulevars.p1.maxmeter)
	end
	
	if combovars.p2.combo ~= combovars.p2.previouscombo and not modulevars.p2.inhitstun then
		if combovars.p1.refillmeter == 0 then
			combovars.p1.refillmeter = math.ceil((modulevars.p1.maxmeter - modulevars.p1.meter) / combovars.p1.refillmeterspeed) -- refill speed
		end
	end
	
	if modulevars.p2.inhitstun then
		combovars.p1.refillmeter = 0
	end
	
	if combovars.p1.refillmeter ~= 0 then
		if (combovars.p1.refillmeter + modulevars.p1.meter >= modulevars.p1.maxmeter) then
			writePlayerOneMeter(modulevars.p1.maxmeter)
			combovars.p1.refillmeter = 0
		else
			writePlayerOneMeter(modulevars.p1.meter + combovars.p1.refillmeter)
		end
	end

end

local instantHealthP1 = function()
	if not combovars.p1.refillhealthenabled then return end
	if not combovars.p1.instantrefillhealth then return end
	writePlayerOneHealth(modulevars.p1.maxhealth)
end

local instantMeterP1 = function()
	if not combovars.p1.refillmeterenabled then return end
	if not combovars.p1.instantrefillmeter then return end
	writePlayerOneMeter(modulevars.p1.maxmeter)
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
		combovars.p2.displaycombo = combovars.p2.combo
	end
	
	if combovars.p2.healthdiff > 0 then
		combovars.p2.previousdamage = combovars.p2.healthdiff
		if combovars.p2.combo == 1 then
			combovars.p2.comboDamage=0
		end
		combovars.p2.comboDamage = combovars.p2.comboDamage + combovars.p2.healthdiff
	end
end

local healthHandlerP2 = function()
	
	if not combovars.p2.refillhealthenabled then return end

	if combovars.p2.combo ~= combovars.p2.previouscombo and not modulevars.p2.inhitstun then
		if combovars.p2.refillhealth == 0 then
			combovars.p2.refillhealth = math.ceil((modulevars.p2.maxhealth - modulevars.p2.health) / combovars.p2.refillhealthspeed) -- refill speed
		end
	end
	
	if modulevars.p2.inhitstun then
		combovars.p2.refillhealth = 0
	end
	
	if combovars.p2.refillhealth ~= 0 then
		if (combovars.p2.refillhealth + modulevars.p2.health >= modulevars.p2.maxhealth) or combovars.p2.instantrefillhealth then
			writePlayerTwoHealth(modulevars.p2.maxhealth)
			combovars.p2.refillhealth = 0
		else
			writePlayerTwoHealth(modulevars.p2.health + combovars.p2.refillhealth)
		end
	end
end

local meterHandlerP2 = function()

	if not combovars.p2.refillmeterenabled then return end
	
	if combovars.p2.instantrefillmeter then
		writePlayerTwoMeter(modulevars.p2.maxmeter)
	end
	
	if combovars.p1.combo ~= combovars.p1.previouscombo and not modulevars.p1.inhitstun then
		if combovars.p2.refillmeter == 0 then
			combovars.p2.refillmeter = math.ceil((modulevars.p2.maxmeter - modulevars.p2.meter) / combovars.p2.refillmeterspeed) -- refill speed
		end
	end
	
	if modulevars.p1.inhitstun then
		combovars.p2.refillmeter = 0
	end
	
	if combovars.p2.refillmeter ~= 0 then
		if (combovars.p2.refillmeter + modulevars.p2.meter >= modulevars.p2.maxmeter) then
			writePlayerTwoMeter(modulevars.p2.maxmeter)
			combovars.p2.refillmeter = 0
		else
			writePlayerTwoMeter(modulevars.p2.meter + combovars.p2.refillmeter)
		end
	end
end

local instantHealthP2 = function()
	if not combovars.p2.refillhealthenabled then return end
	if not combovars.p2.instantrefillhealth then return end
	writePlayerTwoHealth(modulevars.p2.maxhealth)
end

local instantMeterP2 = function()
	if not combovars.p2.refillmeterenabled then return end
	if not combovars.p2.instantrefillmeter then return end
	writePlayerTwoMeter(modulevars.p2.maxmeter)
end

local guiinputs = {
	P1 = {previousinputs={}, coinframestart = 0, coinpresscount = 0, leftframecount = 0, rightframecount = 0, downframecount = 0, upframecount = 0,},
	P2 = {previousinputs={}},
}

local readGuiInputs = function()
	local input
	guiinputs.P1.previousinputs = copytable(guiinputs.P1)
	guiinputs.P2.previousinputs = copytable(guiinputs.P2)
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
	inputs.setinputs = {}
	for i,v in pairs(joypad.get()) do -- check every button
		player = i:sub(1,2)
		input = i:sub(4)
		if player == "P1" then
			inputs.p1[input] = v
		elseif player == "P2" then
			inputs.p2[input] = v
		else
			inputs.other[i] = v
			inputs.setinputs[i] = v
		end
	end
end

local combinePlayerInputs = function(P1, P2, other)
	
	if type(P1) ~= "table" or type(P2) ~= "table" then return end
	
	local t = {}
	
	for i,v in pairs(P1) do
		t["P1 "..i] = v
	end
	for i,v in pairs(P2) do
		t["P2 "..i] = v
	end
	if type(other)=="table" then
		for i,v in pairs(other) do
			t[i] = v
		end
	end
	
	return t
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
	
	tab = combinePlayerInputs(inputs.p1, inputs.p2, inputs.other)
	inputs.setinputs = tab
end


local swapPlayerInput = function(player)
	
	local tab = copytable(player) -- shallow copy
	
	tab.Left = not tab.Left
	tab.Right = not tab.Right
	
	return tab
	
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

	if interactivegui.movehud then return end
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
	
	if interactivegui.movehud then return end
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
		inputs.setinputs = combinePlayerInputs(inputs.p1, t, inputs.other)
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
		inputs.setinputs = combinePlayerInputs(inputs.p1, t, inputs.other)
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
	interactivegui.movehud = false
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
	
	local barcolour = interactivegui.barcolour
	for i,v in pairs(page) do
		if v.autofunc then
			v:autofunc()
		end
		
		if i ~= interactivegui.selection then
	
			if not v.x then v.x = 0 end
			if not v.y then v.y = 0 end
			if not v.text then v.text = " " end
			if not v.textcolour then v.textcolour = "white" end
			if not v.bgcolour then v.bgcolour = bgcolour end
			if not v.olcolour then v.olcolour = bgcolour end
			
			w, h = #v.text*4, 10
			
			if (v.fillpercent) then
				gui.box(v.x + boxx, v.y + boxy, v.x + boxx + (w + 4)*v.fillpercent, v.y + boxy + h, barcolour)
				v.bgcolour = nil
			end
			
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
	if (selection.fillpercent) then
		gui.box(selection.x + boxx, selection.y + boxy, selection.x + boxx + (w + 4)*selection.fillpercent, selection.y + boxy + h, barcolour)
		selection.bgcolour = nil
	end
	gui.box(selection.x + boxx, selection.y + boxy, selection.x + boxx + w + 4, selection.y + boxy + h, selection.bgcolour, colour)
	gui.text(selection.x + boxx + 3, selection.y + boxy + 2, selection.text, selection.textcolour)
	
end

createPopUpMenu = function(BaseMenu, releasefunc, selectfunc, autofunc, Elements, startx, starty, numofelements)
	
	if releasefunc == nil then
		releasefunc = function() return function() CIG(interactivegui.previouspage, interactivegui.previousselection) end end
	end
	
	menu = {}
	
	for i,v in pairs(BaseMenu) do -- copy over the table and make sure ipairs wont pick up the elements
		menu["a"..i] = v
	end
	
	local but
	
	if (Elements) then -- fallback to the default, passed elements, if needed
		for i, v in ipairs(Elements) do
			-- create buttons
			but = {}
			if (v.releasefunc) then
				but.releasefunc = v.releasefunc(i)
			else
				if (releasefunc) then but.releasefunc = releasefunc(i) end
			end
			
			if (v.selectfunc) then
				but.selectfunc = v.selectfunc(i)
			else
				if (selectfunc) then but.selectfunc = selectfunc(i) end
			end
			
			if (v.autofunc) then
				but.autofunc = v.autofunc(i)
			else
				if (autofunc) then but.autofunc = autofunc(i) end
			end
			
			if (v.text) then 
				but.text = v.text
			else
				but.text = tostring(i)
			end
			
			if (v.x) then
				but.x = v.x
			else 
				but.x = startx
			end
			
			if (v.y) then
				but.y = v.y
			else 
				but.y = starty+(i-1)*10
			end

			table.insert(menu, but)
		end		
	else
		for i = 1, numofelements do
			-- create buttons
			but = {}
			if (releasefunc) then but.releasefunc = releasefunc(i) end
			if (selectfunc) then but.selectfunc = selectfunc(i) end
			if (autofunc) then but.autofunc = autofunc(i) end
			but.text = tostring(i)
			but.x = startx
			but.y = starty+(i-1)*10
			table.insert(menu, but)
		end
	end
	
	return menu
	
end

createScrollingBar = function(BaseMenu, x, y, min, max, updatefunc, length, closingfunc, autofunc, text)
	local menu = {}
	if not text then text = "" end
	
	local barlen = max - min
	
	if not length then length = barlen end
	
	length = length/4 -- account for text size
	
	text = string.format("%"..(length/2 - (#text/2)).."s", text) -- centre text
	text = string.format("%-"..(length - (#text/2)).."s", text)
	
	for i,v in pairs(BaseMenu) do -- copy over the table and make sure ipairs wont pick up the elements
		menu["a"..i] = v
	end
	
	menu.min = 	{
					x = x-(#tostring(min))*2,
					y = y+10,
					text = tostring(min)
				}
	
	menu.max = 	{
					x = x+(#text)*4-(#tostring(max))*2,
					y = y+10,
					text = tostring(max)
				}
	
	local but = {}
	but.x = x
	but.y = y
	but.text = text
	but.olcolour = "black"
	but.val = updatefunc()
	but.fillpercent = (but.val-min)/barlen
	
	local workingframes = function(n) -- get faster the longer it runs
		if (n < 60) then
			if n%10==0 then return 1 end -- maybe tie this to coin input leniency?
			return 0
		elseif (n < 120) then
			return 1
		elseif (n < 180) then
			return 5
		end
		return 10
	end
	
	but.autofunc = 	function(this)
		but.val = updatefunc()
		local d = 0
		if guiinputs.P1.left then
			
			d = workingframes(guiinputs.P1.leftframecount) 
			
			if but.val-d>=min then
				updatefunc(-d)
			else
				updatefunc(max-but.val)
			end
		elseif guiinputs.P1.right then
		
			d = workingframes(guiinputs.P1.rightframecount) 
		
			if but.val+d<=max then
				updatefunc(d)
			else
				updatefunc(min-but.val)
			end
		end
		but.fillpercent = (but.val-min)/barlen
		if autofunc then autofunc() end
	end
	
	if closingfunc then
		but.func = closingfunc
	else
		but.func = 	function() CIG(interactivegui.previouspage, interactivegui.previousselection) end
	end
	
	menu[1] = but
	
	return menu
end

changeInteractiveGuiPage = function(n)
	if not interactivegui.enabled then return end
	if not n then n = interactivegui.page+1 end
	interactivegui.previouspage = interactivegui.page -- keep previous for backing out
	interactivegui.previousselection = interactivegui.selection
	
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
	local page = interactiveguipages[interactivegui.page] -- current page
	if (#page<=1) then 
		interactivegui.selection = 1
		return
	end
	if not n then n = interactivegui.selection+1 end
	
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

CIG = function(page, selection) -- macro, both of these are used together so often
	changeInteractiveGuiPage(page)
	changeInteractiveGuiSelection(selection)
end

local callGuiSelectionFunc = function()
	local func = interactiveguipages[interactivegui.page][interactivegui.selection].func
	if not interactivegui.enabled or not func then return end
	func()
end

local callGuiSelectionReleaseFunc = function()
	local func = interactiveguipages[interactivegui.page][interactivegui.selection].releasefunc
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

local interactiveGuiSelectionBack = function()
	if not interactivegui.enabled then return end
	CIG(interactivegui.previouspage, interactivegui.previousselection)
end

--fall backs in case can't read joypad input
input.registerhotkey(1, toggleInteractiveGuiEnabled)
input.registerhotkey(2, callGuiSelectionFunc)
input.registerhotkey(3, changeInteractiveGuiSelection)
input.registerhotkey(4, function() print(interactiveguipages[interactivegui.page][interactivegui.selection].info) end)
input.registerhotkey(5, function() recording.hitplayback = true end)

local parseGUIInputs = function()
	--inspired by grouflons and crystal_cubes menus
	
	-- some general input stuff put at the start, could be put in its own function
	
	-- opening the menu and operating coin functionality
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
	
	-- unless the gui is open we don't need to parse anything else
	if not interactivegui.enabled then return end 
	
	if guiinputs.P1.button1 and not guiinputs.P1.previousinputs.button1 then
		callGuiSelectionFunc()
	end
	
	if not guiinputs.P1.button1 and guiinputs.P1.previousinputs.button1 then
		callGuiSelectionReleaseFunc()
	end
	
	if guiinputs.P1.button2 then
		interactiveGuiSelectionInfo()
	end
	
	if guiinputs.P1.button3 and not guiinputs.P1.previousinputs.button3 then -- back button
		interactiveGuiSelectionBack()
	end
	
	if guiinputs.P1.left and not guiinputs.P1.previousinputs.left then
		changeInteractiveGuiSelection(interactivegui.selection-1)
	elseif guiinputs.P1.right and not guiinputs.P1.previousinputs.right then
		changeInteractiveGuiSelection(interactivegui.selection+1)
	end	
end

local HUDElements = {}

toggleMoveHUD = function(bool)
	if #HUDElements==0 then return end
	toggleInteractiveGuiEnabled(false)
	interactivegui.movehud = bool
	interactivegui.movehudselected = false
	if bool then interactivegui.movehud = true guiinputs.P1.previousinputs.button1 = true -- stop double pressing
	elseif bool == false then interactivegui.movehud = false
	else interactivegui.movehud = not interactivegui.movehud end
	
	inputs.properties.p1freeze = interactivegui.movehud
	inputs.properties.p2freeze = interactivegui.movehud
end

function drawHUD() -- all parts of the hud should be dropped in here

	if interactivegui.enabled then return end
	
	for _, v in ipairs(HUDElements) do
		if v.enabled() then v.drawfunc() end
	end
end

local hudworkingframes = function(n) -- get faster the longer it runs
	if (n < 60) then
		if n%10==0 then return 1 end -- maybe tie this to coin input leniency?
		return 0
	elseif (n < 120) then
		return 1
	elseif (n < 180) then
		return 5
	end
	return 10
end

local moveHUD = function()

	if not interactivegui.movehud then return end
	
	-- pick different hud elements, hook them up to changeconfig
	
	local col = 0xff8000ff -- orange
	if interactivegui.movehudselected then
		col = bit.bor(0xff0000ff, 0x00040000*(fc%40))
	end
	local x = HUDElements[interactivegui.movehudselection].x()
	local y = HUDElements[interactivegui.movehudselection].y()
	gui.pixel(x, y, col)
	col = 0xffffffff
	local enabled = HUDElements[interactivegui.movehudselection].enabled()
	if not enabled then
		col = 0x0000ffff
	end
	gui.text(x, y-10, "("..x..","..y..")", col)
	
	if not interactivegui.movehudselected then
		gui.text(1,1,"Left/Right to pick a element.")
		gui.text(1,10,"Button1 to select an element.")
		gui.text(1,20,"Button2 to hide/show an element.")
		gui.text(1,30,"Button3 to back out.")
		if guiinputs.P1.button1 and not guiinputs.P1.previousinputs.button1 then -- on
			interactivegui.movehudselected = true
			return
		end
		
		if guiinputs.P1.left and not guiinputs.P1.previousinputs.left then -- switch through different elements
			interactivegui.movehudselection = interactivegui.movehudselection-1
			if interactivegui.movehudselection < 1 then interactivegui.movehudselection = #HUDElements end
		elseif guiinputs.P1.right and not guiinputs.P1.previousinputs.right then
			interactivegui.movehudselection = interactivegui.movehudselection+1
			if interactivegui.movehudselection > #HUDElements then interactivegui.movehudselection = 1 end
		end
	end
	
	if guiinputs.P1.button2 and not guiinputs.P1.previousinputs.button2 then -- hide
		if enabled==nil then enabled=false end
		HUDElements[interactivegui.movehudselection].enabled(not enabled)
	end
	
	if guiinputs.P1.button3 and not guiinputs.P1.previousinputs.button3 then -- back
		toggleMoveHUD(false)
		return
	end
	
	if not interactivegui.movehudselected then return end
	
	gui.text(1,1,"Left/Right/Up/Down to move an element.")
	gui.text(1,10,"Button1 to return.")
	gui.text(1,20,"Button2 to hide/show an element.")
	gui.text(1,30,"Button3 to back out.")
	
	if guiinputs.P1.button1 and not guiinputs.P1.previousinputs.button1 then -- off
		interactivegui.movehudselected = false
	end
	
	local d = 0
	local pos
	if guiinputs.P1.left then
		d = hudworkingframes(guiinputs.P1.leftframecount)*-1
		pos = HUDElements[interactivegui.movehudselection].x(x+d)
		if (pos < 0) then HUDElements[interactivegui.movehudselection].x(interactivegui.sw) end -- stay in bounds
	elseif guiinputs.P1.right then
		d = hudworkingframes(guiinputs.P1.rightframecount) 
		pos = HUDElements[interactivegui.movehudselection].x(x+d)
		if (pos > interactivegui.sw) then HUDElements[interactivegui.movehudselection].x(0) end -- stay in bounds
	end
	
	if guiinputs.P1.up then
		d = hudworkingframes(guiinputs.P1.upframecount)*-1
		pos = HUDElements[interactivegui.movehudselection].y(y+d)
		if (pos < 0) then HUDElements[interactivegui.movehudselection].y(interactivegui.sh) end -- stay in bounds
	elseif guiinputs.P1.down then
		d = hudworkingframes(guiinputs.P1.downframecount) 
		pos = HUDElements[interactivegui.movehudselection].y(y+d)
		if (pos > interactivegui.sh) then HUDElements[interactivegui.movehudselection].y(0) end -- stay in bounds
	end
end

local registers = {
	registerbefore = {},
	guiregister = {},
	registerafter = {},
}

local drawcomboHUD = function()
	if combovars.p2.healthdiff > 0 then
		gui.text(hud.combotextx-4,hud.combotexty,"Damage: " ..combovars.p2.healthdiff,hud.damagetextcolour)
	else
		gui.text(hud.combotextx-4,hud.combotexty,"Damage: " .. combovars.p2.previousdamage,hud.damagetextcolour)
	end
	if modulevars.p2.inhitstun then
		gui.text(hud.combotextx,hud.combotexty+10,"Combo: "..combovars.p2.combo,hud.combotextcolour)
	else
		gui.text(hud.combotextx,hud.combotexty+10,"Combo: "..combovars.p2.displaycombo,hud.combotextcolour2)
	end
   	gui.text(hud.combotextx,hud.combotexty+20,"Total: " .. combovars.p2.comboDamage,hud.totaltextcolour)
end

setRegisters = function() -- pre-calc stuff
	
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

	if availablefunctions.readplayeronehealth then
		table.insert(HUDElements, {x = function(n) if n then changeConfig("hud", "p1healthx", n, hud) end return hud.p1healthx end, y = function(n) if n then changeConfig("hud", "p1healthy", n, hud) end return hud.p1healthy end, enabled = function(n) if n or n==false then changeConfig("hud", "p1healthenabled", n, hud) end return hud.p1healthenabled end, drawfunc = function() gui.text(hud.p1healthx, hud.p1healthy, modulevars.p1.health, hud.p1healthtextcolour) end})
		if availablefunctions.playeroneinhitstun then
			table.insert(registers.guiregister, comboHandlerP1)
		else
			print "player one hitstun not set, can't do combos.\n"
		end
	else
		print "player one health read not set, can't do combos.\n"
	end
		
	if availablefunctions.readplayertwohealth then
		table.insert(HUDElements, {x = function(n) if n then changeConfig("hud", "p2healthx", n, hud) end return hud.p2healthx end, y = function(n) if n then changeConfig("hud", "p2healthy", n, hud) end return hud.p2healthy end, enabled = function(n) if n or n==false then changeConfig("hud", "p2healthenabled", n, hud) end return hud.p2healthenabled end, drawfunc = function() gui.text(hud.p2healthx, hud.p2healthy, modulevars.p2.health, hud.p2healthtextcolour) end})
		if availablefunctions.playertwoinhitstun then
			table.insert(registers.guiregister, comboHandlerP2)
		else
			print "player two hitstun not set, can't do combos.\n"
		end
	else
		print "player two health read not set, can't do combos.\n"
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
		table.insert(HUDElements, {x = function(n) if n then changeConfig("hud", "combotextx", n, hud) end return hud.combotextx end, y = function(n) if n then changeConfig("hud", "combotexty", n, hud) end return hud.combotexty end, enabled = function(n) if n or n==false then changeConfig("hud", "comboenabled", n, hud) end return hud.comboenabled end, drawfunc = drawcomboHUD})
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

	if modulevars.p1.constants.maxmeter and availablefunctions.readplayeronemeter then
		table.insert(HUDElements, {x = function(n) if n then changeConfig("hud", "p1meterx", n, hud) end return hud.p1meterx end, y = function(n) if n then changeConfig("hud", "p1metery", n, hud) end return hud.p1metery end, enabled = function(n) if n or n==false then changeConfig("hud", "p1meterenabled", n, hud) end return hud.p1meterenabled end, drawfunc = function() gui.text(hud.p1meterx, hud.p1metery, modulevars.p1.meter, hud.p1metertextcolour) end})
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
	else
		print "Can't auto-refill P1 meter"
	end
	
	
	if modulevars.p2.constants.maxmeter and availablefunctions.readplayertwometer then
		table.insert(HUDElements, {x = function(n) if n then changeConfig("hud", "p2meterx", n, hud) end return hud.p2meterx end, y = function(n) if n then changeConfig("hud", "p2metery", n, hud) end return hud.p2metery end, enabled = function(n) if n or n==false then changeConfig("hud", "p2meterenabled", n, hud) end return hud.p2meterenabled end, drawfunc = function() gui.text(hud.p2meterx, hud.p2metery, modulevars.p2.meter, hud.p2metertextcolour) end})	
		if availablefunctions.writeplayertwometer and availablefunctions.readplayeronehealth and availablefunctions.playeroneinhitstun then
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
	else
		print "Can't auto-refill P2 meter"
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
	
	table.insert(registers.guiregister, drawHUD)
	table.insert(registers.guiregister, drawInteractiveGui)
	
	if modulevars.constants.translationtable then
		table.insert(registers.registerbefore, readGuiInputs)
		table.insert(registers.guiregister, parseGUIInputs)
		table.insert(registers.guiregister, moveHUD)
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