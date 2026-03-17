DISABLE_SCROLLING_INPUT = false
-- flip this when the script keeps crashing
-- replace the text after the '=' with:
-- true, do use it
-- false, don't use it

FBNEO_TRAINING_MODE_VERSION = "v0.26.03.16"

--DEBUG = true
ROM = emu.romname()
REPLAY_SLOTS_COUNT = 5

LETTER_WIDTH = 4 -- width of a gui.text letter in pixels
LETTER_HALFWIDTH = 2

LETTER_HEIGHT = 8 -- height of a gui.text letter in pixels

local write = print -- alias to make sure debug print statements stand out

-- memory macros
wb = memory.writebyte
ww = memory.writeword
wdw = memory.writedword
rb = memory.readbyte
rbs = memory.readbytesigned
rw = memory.readword
rws = memory.readwordsigned
rdw = memory.readdword
rdws = memory.readdwordsigned

if not memory.writebyte_audio then -- writeword_audio is defined on fightcade, stub otherwise
	memory.writebyte_audio = function() end
	write "memory.writebyte_audio not defined"
end

if not memory.readbyte_audio then
	memory.readbyte_audio = function() end
	write "memory.readbyte_audio not defined"
end

if not memory.writeword_audio then -- writeword_audio is defined on fightcade, stub otherwise
	memory.writeword_audio = function() end
	write "memory.writeword_audio not defined"
end

if not memory.readword_audio then
	memory.readword_audio = function() end
	write "memory.readword_audio not defined"
end

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

local fc = emu.framecount()

local games = {
	[""] = {}, -- null case
	aliencha = {"aliencha", iconfile = "icons-capcom-32.png"},
	aof = {"aof", iconfile = "icons-neogeo-32.png"},
	aof2 = {"aof2", iconfile = "icons-neogeo-32.png"},
	aof3 = {"aof3", hitboxes = "aof3-hitboxes", iconfile = "icons-neogeo-32.png"},
	asurabld = {"asurabld", iconfile = "icons-asurabus-32.png"},
	asurabus = {"asurabus", iconfile = "icons-asurabus-32.png"},
	avengrgs = {"avengrgs", iconfile = "icons-banpresto-32.png"},
	bloodstm = {"bloodstm", iconfile = "icons-bloodstm-32.png"},
	bloodwar = {"bloodwar", iconfile = "icons-neogeo-32.png"},
	breakrev = {"breakrev", "brkrevext", iconfile = "icons-neogeo-32.png"},
	cybots = {"cybots", "cybotsam", hitboxes = "cps2-hitboxes", iconfile = "icons-cybots-32.png"},
	dankuga = {"dankuga", iconfile= "icons-capcom-32.png"},
	daraku = {"daraku", hitboxes = "daraku-hitboxes", iconfile= "icons-psikyo-32.png"},
	dbz2 = {"dbz2", iconfile = "icons-banpresto-32.png"},
	dinorex = {"dinorex", iconfile = "icons-taito-32.png"},
	doubledr = {"doubledr", iconfile = "icons-neogeo-32.png"},
	dstlk = {"dstlk", "vampjr1", "vampjbh", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	fatfury1 = {"fatfury1", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	fatfury2 = {"fatfury2", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	fatfury3 = {"fatfury3", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	fatfursp = {"fatfursp", "fatfurspbh", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	fightfev = {"fightfev", iconfile = "icons-neogeo-32.png"},
	galaxyfg = {"galaxyfg", iconfile = "icons-neogeo-32.png"},
	garou = {"garou", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	gowcaizr = {"gowcaizr", iconfile = "icons-neogeo-32.png"},
	gundamex = {"gundamex", iconfile = "icons-banpresto-32.png"},
	hippodrm = {"hippodrm", iconfile = "icons-hippodrm-32.png"},
	hsf2 = {"hsf2", hitboxes = "sf2-hitboxes", iconfile = "icons-capcom-32.png"},
	jchan = {"jchan", iconfile = "icons-kaneko-32.png"},
	jchan2 = {"jchan2", hitboxes = "jchan2-hitboxes", iconfile = "icons-kaneko-32.png"},
	jojo = {"jojo", "jojon", hitboxes = "jojo-hitboxes", iconfile = "icons-jojos-32.png"},
	jojoba = {"jojoba", "jojoban", "jojobanr1", hitboxes = "hftf-hitboxes", iconfile = "icons-jojos-32.png"},
	kabukikl = {"kabukikl", iconfile = "icons-neogeo-32.png"},
	karnovr = {"karnovr", hitboxes = "karnovr-hitboxes", iconfile = "icons-neogeo-32.png"},
	kf2k5uni = {"kf2k5uni", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kizuna = {"kizuna", iconfile = "icons-neogeo-32.png"},
	kof94 = {"kof94", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof95 = {"kof95", "kof95sp", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof96 = {"kof96", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof97 = {"kof97", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof98 = {"kof98", "kof98cb", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof99 = {"kof99", "kof99ae", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof2000 = {"kof2000", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof2001 = {"kof2001", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof2002 = {"kof2002", hitboxes = "kof-hitboxes", iconfile = "icons-neogeo-32.png"},
	kof2003 = {"kof2003", hitboxes = "kof2003-hitboxes", iconfile = "icons-neogeo-32.png"},
	lastblad = {"lastblad", iconfile = "icons-neogeo-32.png"},
	lastbld2 = {"lastbld2", iconfile = "icons-neogeo-32.png"},
	martmast = {"martmast", iconfile = "icons-martmast-32.png"},
	matrim = {"matrim", iconfile = "icons-neogeo-32.png"},
--	msgundam = {"msgundam", iconfile = "icons-msgundam-32.png"},
	msh = {"msh", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mshvsf = {"mshvsf", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mvsc = {"mvsc", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	mwarr = {"mwarr", iconfile = "icons-mwarr-32.png"},
	ninjamas = {"ninjamas", iconfile = "icons-neogeo-32.png"},
	nwarr = {"nwarr", "vhuntjr2", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	rabbit = {"rabbit", iconfile = "icons-banpresto-32.png"},
	ragnagrd = {"ragnagrd", iconfile = "icons-neogeo-32.png"},
	rbff1 = {"rbff1", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	rbff2 = {"rbff2", "rbff2h", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	rbffspec = {"rbffspec", hitboxes = "garou-hitboxes", iconfile = "icons-neogeo-32.png"},
	redearth = {"redearth", hitboxes = "cps3-hitboxes", iconfile = "icons-capcom-32.png"},
	ringdest = {"ringdest", hitboxes = "cps2-hitboxes", iconfile = "icons-ringdest-32.png"},
	rotd = {"rotd", hitboxes = "rotd-hitboxes", iconfile = "icons-neogeo-32.png"},
	samsho = {"samsho", iconfile = "icons-neogeo-32.png"},
	samsho2 = {"samsho2", iconfile = "icons-neogeo-32.png"},
	samsho3 = {"samsho3", iconfile = "icons-neogeo-32.png"},
	samsho4 = {"samsho4", iconfile = "icons-neogeo-32.png"},
	samsho5 = {"samsho5", iconfile = "icons-neogeo-32.png"},
	samsh5sp = {"samsh5sp", iconfile = "icons-neogeo-32.png"},
	schmeisr = {"schmeisr", iconfile = "icons-asurabus-32.png"},
	sf = {"sf", iconfile = "icons-sf1-32.png"},
	sf2 = {"sf2", hitboxes = "sf2-hitboxes", iconfile = "icons-capcom-32.png"},
	sf2ce = {"sf2ce", "sf2hf", "sf2rb", hitboxes = "sf2-hitboxes", iconfile = "icons-capcom-32.png"},
	sfa = {"sfa", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	sfa2 = {"sfa2", "sfa2u", "sfz2al", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	sfa3 = {"sfa3", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	sfiii = {"sfiii", hitboxes = "cps3-hitboxes", iconfile = "icons-capcom-32.png"},
	sfiii2 = {"sfiii2", hitboxes = "cps3-hitboxes", iconfile = "icons-capcom-32.png"},
	sfiii3 = {"sfiii3", "sfiii3nr1", hitboxes = "cps3-hitboxes", iconfile = "icons-capcom-32.png"},
	sfiii3ws = {"sfiii3ws", hitboxes = "cps3-hitboxes", iconfile = "icons-capcom-32.png"},
	sgemf = {"sgemf", hitboxes = "cps2-hitboxes", iconfile = "icons-sgemf-32.png"},
	slammast = {"slammast", iconfile = "icons-slammast-32.png"},
	ssf2 = {"ssf2", "ssf2us2", hitboxes = "sf2-hitboxes", iconfile = "icons-capcom-32letter.png"},
	ssf2t = {"ssf2t", "ssf2xjr1", "ssf2tnl", hitboxes = "st-hitboxes", iconfile = "icons-capcom-32letter.png"},
	svc = {"svc", "svcsplus", hitboxes = "svc-hitboxes", iconfile = "icons-neogeo-32.png"},
	teot = {"teot", iconfile = "icons-neogeo-32.png"},
	timekill = {"timekill", iconfile = "icons-timekill-32.png"},
	tkdensho = {"tkdensho", iconfile = "icons-banpresto-32.png"},
	trstar = {"trstar", iconfile = "icons-trstar-32.png"},
	umk3 = {"umk3", iconfile = "icons-midway-32.png"},
	vhunt2 = {"vhunt2", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	viofight = {"viofight", iconfile = "icons-viofight-32.png"},
	vsav = {"vsav", "vsavj", "vsavae", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	vsav2 = {"vsav2", hitboxes = "cps2-hitboxes", iconfile = "icons-capcom-32.png"},
	wakuwak7 = {"wakuwak7", "wakuwak7bh", iconfile = "icons-neogeo-32.png"},
	wh1 = {"wh1", iconfile = "icons-neogeo-32.png"},
	wh2 = {"wh2", iconfile = "icons-neogeo-32.png"},
	wh2j = {"wh2j", iconfile = "icons-neogeo-32.png"},
	whp = {"whp", iconfile = "icons-neogeo-32.png"},
	xmcota = {"xmcota", "xmcotabh", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
	xmvsf = {"xmvsf", hitboxes = "marvel-hitboxes", iconfile = "icons-capcom-32.png"},
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

--------
local HUDElements = { }

function createHUDElement(name, x, y, enabled, reset, draw, movehud)
	assert(type(name)=="string", "Name must be of type string")
	assert(type(x)=="function", "X must be a function")
	assert(type(y)=="function", "Y must be a function")
	assert(type(enabled)=="function" or enabled == nil, "Enabled must be a function")
	assert(type(reset)=="function" or reset == nil, "Reset must be a function")
	assert(type(draw)=="function" or draw == nil, "Draw must be a function")
	assert(type(movehud)=="table" or movehud == nil, "MoveHud must be a table")

	table.insert(HUDElements, {
		name = name,
		x = x,
		y = y,
		enabled = enabled,
		reset = reset,
		draw = draw,
		movehud = movehud
	})
end

gamepath = "games/other/"
local configpath = gamepath..ROM..".lua"
guiinputs = {
	P1 = {previousinputs={}, coinframestart = 0, coinpresscount = 0, leftframecount = 0, rightframecount = 0, downframecount = 0, upframecount = 0,},
	P2 = {previousinputs={}},
	kb = {inputcount={}},
}

----------------------------------------------
-- USER CONFIG
----------------------------------------------

local config = {
	gamevars = { P1 = { }, P2 = { } },
	combovars = { P1 = { }, P2 = { } },
	hud = { health = { P1 = { }, P2 = { } }, meter = { P1 = { }, P2 = { } }, combotext = { }, kb = { } },
	inputs = { simple = { P1 = { }, P2 = { } }, scrolling = { P1 = { }, P2 = { } } },
	hitboxes = { },
	interactivegui = { },
	colour = { },
	recording = { },
	type = "gameconfig"
}

local generalconfig = {
	type = "generalconfig",
	path = "config/generalsettings.config"
}

local colourconfig = {
	P1 = {},
	P2 = {},
	hud = { combotext = {} },
	type = "colourconfig",
	path = "config/colour.config"
}

-- vars the configs are mirrored in
combovars = {
	P1 = {
		healthdiff = 0,
		previousdamage = 0,
		combo = 0,
		previouscombo = 0,
		displaycombo = 0,
		comboDamage = 0,
		refillhealth = 0,
		refillmeter = 0,
	},
	P2 = {
		healthdiff = 0,
		previousdamage = 0,
		combo = 0,
		previouscombo = 0,
		displaycombo = 0,
		comboDamage = 0,
		refillhealth = 0,
		refillmeter = 0,
	},

}

hud = { health = { P1 = { }, P2 = { } }, meter = { P1 = { }, P2 = { } }, combotext = { }, kb = { } }

inputs = {
	properties = {
		simple = { P1 = {}, P2 = {} },
		scrolling = { P1 = {}, P2 = {} },
		kb = { },
		enableinputswap = false,
		holddirection = nil,
	},
	hotkeys = {
		hotkeyin = false,
		funcs = {},
	},
	P1 = {},
	P2 = {},
	other = {},
	setinputs = {},
}

hitboxes = { }

recording = {
	recordingslot = 1,
	hitslot,
	savestateslot,
	blockslot,
	editframe,
	swapplayers = true,
	replayP1 = false,
	replayP2 = true,
	delay = 0,
	starttime = 0,
	startcounter = 0,
	config = {
		P1 = {},
		P2 = {},
		type = "recordingconfig"
	}
}

for i = 1, REPLAY_SLOTS_COUNT do
	recording[i] = {}
end

interactivegui = {
	enabled = false,
	inmenu = false,
	page = 1, -- these should be numbers referencing guipages
	selection = 3,
	sw = emu.screenwidth(),
	sh = emu.screenheight(),
	movehud = {enabled = false, selected = false, selection = 1},
	replayeditor = {inputs = {}},
}

colour = { P1 = {}, P2 = {} }

gamevars = {
	P1 = {
		inhitstun = false,
		health = 0,
		previoushealth = 0,
		meter = 0,
		constants = {},
	},
	P2 = {
		inhitstun = false,
		health = 0,
		meter = 0,
		previoushealth = 0,
		constants = {},
	},
	constants = {},
}

-- config items to show the relationship between configs and vars
local configitems = {
--[[
	id = {
		name 			-> the name of the config in the configpointer or varpointer
		default			-> the default value of the configitem, also is used for typechecking
		configpointer	-> the table the config value is stored in (private)
		varpointer		-> the (option) table the variable value is stored in (public)
		config			-> the top level of the configpointer
		displayname		-> used for user-facing text
	}
--]]
--------- GAMEVARS ----------
	p1maxhealth = {
		name = "maxhealth",
		default = 1,
		configpointer = config.gamevars.P1,
		varpointer = gamevars.P1,
		config = config,
	},
	p2maxhealth = {
		name = "maxhealth",
		default = 1,
		configpointer = config.gamevars.P2,
		varpointer = gamevars.P2,
		config = config,
	},
	p1maxmeter = {
		name = "maxmeter",
		default = 0,
		configpointer = config.gamevars.P1,
		varpointer = gamevars.P1,
		config = config,
	},
	p2maxmeter = {
		name = "maxmeter",
		default = 0,
		configpointer = config.gamevars.P2,
		varpointer = gamevars.P2,
		config = config,
	},
--------- COMBOVARS ---------
	p1refillhealthspeed = {
		name = "refillhealthspeed",
		default = 10,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2refillhealthspeed = {
		name = "refillhealthspeed",
		default = 10,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1instantrefillhealth = {
		name = "instantrefillhealth",
		default = false,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2instantrefillhealth = {
		name = "instantrefillhealth",
		default = false,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1refillhealthenabled = {
		name = "refillhealthenabled",
		default = false,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2refillhealthenabled = {
		name = "refillhealthenabled",
		default = false,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1refillmeterspeed = {
		name = "refillmeterspeed",
		default = 10,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2refillmeterspeed = {
		name = "refillmeterspeed",
		default = 10,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1instantrefillmeter = {
		name = "instantrefillmeter",
		default = false,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2instantrefillmeter = {
		name = "instantrefillmeter",
		default = false,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
	p1refillmeterenabled = {
		name = "refillmeterenabled",
		default = true,
		configpointer = config.combovars.P1,
		varpointer = combovars.P1,
		config = config,
	},
	p2refillmeterenabled = {
		name = "refillmeterenabled",
		default = true,
		configpointer = config.combovars.P2,
		varpointer = combovars.P2,
		config = config,
	},
--------- HUD ---------
	p1healthx = {
		name = "x",
		default = 10,
		configpointer = config.hud.health.P1,
		varpointer = hud.health.P1,
		config = config,
	},
	p2healthx = {
		name = "x",
		default = 180,
		configpointer = config.hud.health.P2,
		varpointer = hud.health.P2,
		config = config,
	},
	p1healthy = {
		name = "y",
		default = 10,
		configpointer = config.hud.health.P1,
		varpointer = hud.health.P1,
		config = config,
	},
	p2healthy = {
		name = "y",
		default = 10,
		configpointer = config.hud.health.P2,
		varpointer = hud.health.P2,
		config = config,
	},
	p1healthtextcolour = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = config.hud.health.P1,
		varpointer = hud.health.P1,
		config = config,
	},
	p2healthtextcolour = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = config.hud.health.P2,
		varpointer = hud.health.P2,
		config = config,
	},
	p1healthenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.health.P1,
		varpointer = hud.health.P1,
		config = config,
	},
	p2healthenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.health.P2,
		varpointer = hud.health.P2,
		config = config,
	},
	p1meterx = {
		name = "x",
		default = 10,
		configpointer = config.hud.meter.P1,
		varpointer = hud.meter.P1,
		config = config,
	},
	p2meterx = {
		name = "x",
		default = 180,
		configpointer = config.hud.meter.P2,
		varpointer = hud.meter.P2,
		config = config,
	},
	p1metery = {
		name = "y",
		default = 100,
		configpointer = config.hud.meter.P1,
		varpointer = hud.meter.P1,
		config = config,
	},
	p2metery = {
		name = "y",
		default = 100,
		configpointer = config.hud.meter.P2,
		varpointer = hud.meter.P2,
		config = config,
	},
	p1metertextcolour = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = config.hud.meter.P1,
		varpointer = hud.meter.P1,
		config = config,
	},
	p2metertextcolour = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = config.hud.meter.P2,
		varpointer = hud.meter.P2,
		config = config,
	},
	p1meterenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.meter.P1,
		varpointer = hud.meter.P1,
		config = config,
	},
	p2meterenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.meter.P2,
		varpointer = hud.meter.P2,
		config = config,
	},
	combotextenabled = {
		name = "enabled",
		default = true,
		configpointer = config.hud.combotext,
		varpointer = hud.combotext,
		config = config,
	},
	combotextx = {
		name = "x",
		default = emu.screenwidth()/2-#"Combo: 00"*LETTER_HALFWIDTH,
		configpointer = config.hud.combotext,
		varpointer = hud.combotext,
		config = config,
	},
	combotexty = {
		name = "y",
		default = 42,
		configpointer = config.hud.combotext,
		varpointer = hud.combotext,
		config = config,
	},
	kbenabled = {
		name = "enabled",
		default = false,
		configpointer = config.hud.kb,
		varpointer = hud.kb,
		config = config,
	},
	kbx = {
		name = "x",
		default = 0,
		configpointer = config.hud.kb,
		varpointer = hud.kb,
		config = config,
	},
	kby = {
		name = "y",
		default = 0,
		configpointer = config.hud.kb,
		varpointer = hud.kb,
		config = config,
	},
--------- INPUTS ---------
	simpleinputenabledp1 = {
		name = "enabled",
		default = true,
		configpointer = config.inputs.simple.P1,
		varpointer = inputs.properties.simple.P1,
		config = config,
	},
	simpleinputenabledp2 = {
		name = "enabled",
		default = true,
		configpointer = config.inputs.simple.P2,
		varpointer = inputs.properties.simple.P2,
		config = config,
	},
	simpleinputxp1 = {
		name = "x",
		default = -1,
		configpointer = config.inputs.simple.P1,
		varpointer = inputs.properties.simple.P1,
		config = config,
	},
	simpleinputxp2 = {
		name = "x",
		default = -1,
		configpointer = config.inputs.simple.P2,
		varpointer = inputs.properties.simple.P2,
		config = config,
	},
	simpleinputyp1 = {
		name = "y",
		default = -1,
		configpointer = config.inputs.simple.P1,
		varpointer = inputs.properties.simple.P1,
		config = config,
	},
	simpleinputyp2 = {
		name = "y",
		default = -1,
		configpointer = config.inputs.simple.P2,
		varpointer = inputs.properties.simple.P2,
		config = config,
	},
	scrollinginputenabledp1 = {
		name = "enabled",
		default = true,
		configpointer = config.inputs.scrolling.P1,
		varpointer = inputs.properties.scrolling.P1,
		config = config,
	},
	scrollinginputenabledp2 = {
		name = "enabled",
		default = true,
		configpointer = config.inputs.scrolling.P2,
		varpointer = inputs.properties.scrolling.P2,
		config = config,
	},
	scrollinginputxp1 = {
		name = "x",
		default = -1,
		configpointer = config.inputs.scrolling.P1,
		varpointer = inputs.properties.scrolling.P1,
		config = config,
	},
	scrollinginputxp2 = {
		name = "x",
		default = -1,
		configpointer = config.inputs.scrolling.P2,
		varpointer = inputs.properties.scrolling.P2,
		config = config,
	},
	scrollinginputyp1 = {
		name = "y",
		default = -1,
		configpointer = config.inputs.scrolling.P1,
		varpointer = inputs.properties.scrolling.P1,
		config = config,
	},
	scrollinginputyp2 = {
		name = "y",
		default = -1,
		configpointer = config.inputs.scrolling.P2,
		varpointer = inputs.properties.scrolling.P2,
		config = config,
	},
	scrollinginputiconsize = {
		name = "iconsize",
		default = 10,
		configpointer = config.inputs.scrolling,
		varpointer = inputs.properties.scrolling,
		config = config,
	},
	scrollinginputframes = {
		name = "framesenabled",
		default = false,
		configpointer = config.inputs.scrolling,
		varpointer = inputs.properties.scrolling,
		config = config,
	},
--------- GUI ---------
	guiboxxd = {
		name = "boxxd",
		default = 8,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guiboxxm = {
		name = "boxxm",
		default = 7,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guiboxyd = {
		name = "boxyd",
		default = 10,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guiboxym = {
		name = "boxym",
		default = 9,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guicoinleniency = {
		name = "coinleniency",
		default = 10,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guilinespacing = {
		name = "linespacing",
		default = 15,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guipopupspacing = {
		name = "popupspacing",
		default = 10,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
	guihistorylength = {
		name = "historylength",
		default = 10,
		configpointer = generalconfig,
		varpointer = interactivegui,
		config = generalconfig,
	},
--------- COLOURS ---------
	colourbg = {
		name = "bgcolour",
		default = 0xF0F0F0FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "GUI Background"
	},
	colourol = {
		name = "olcolour",
		default = 0x000000FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "GUI Outline"
	},
	colourbar = {
		name = "bar",
		default = 0xFFFF00FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Bar-Fill Colour"
	},
	colourboolfalse = {
		name = "boolfalse",
		default = 0xFF0000FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Boolean False"
	},
	colourbooltrue = {
		name = "booltrue",
		default = 0x00FF00FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Boolean True"
	},
	colouroption1 = {
		name = "option1",
		default = 0xA0FF00FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Option 1"
	},
	colouroption2 = {
		name = "option2",
		default = 0x00FFFFFF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Option 2"
	},
	colouroption3 = {
		name = "option3",
		default = 0x00FFA0FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Option 3"
	},
	colourrecordingselected = {
		name = "recordingselected",
		default = 0xFFFF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = colour,
		config = colourconfig,
		displayname = "Selected Recording"
	},
	colourrecordingselecting = {
		name = "recordingselect",
		default = 0xFF0000FF,
		configpointer = colourconfig,
		varpointer = colour,
		config = colourconfig,
		displayname = "Recording Pick"
	},
	colourcombotext = {
		name = "colour",
		default = 0xFFFF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = hud.combotext,
		config = colourconfig,
		displayname = "In-Combo"
	},
	colourcombotext2 = {
		name = "colour2",
		default = 0x00FF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = hud.combotext,
		config = colourconfig,
		displayname = "Combo Colour"
	},
	colourcombotextdamage = {
		name = "damagecolour",
		default = 0x00FF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = hud.combotext,
		config = colourconfig,
		displayname = "HUD Damage Colour"
	},
	colourcombotexttotaldamage = {
		name = "totaldamagecolour",
		default = 0x00FF00FF,
		configpointer = colourconfig.hud.combotext,
		varpointer = hud.combotext,
		config = colourconfig,
		displayname = "HUD Total Damage Colour"
	},
	colourguiselect = {
		name = "selectcolour",
		default = 0xFF0000FF,
		configpointer = colourconfig,
		varpointer = interactivegui,
		config = colourconfig,
		displayname = "Select Colour"
	},
	colourguitext = {
		name = "textcolour",
		default = 0xFFFFFFFF,
		configpointer = colourconfig,
		varpointer = interactivegui,
		config = colourconfig,
		displayname = "Text Colour"
	},
	colourguiinfo = {
		name = "infocolour",
		default = 0x89cfefff,
		configpointer = colourconfig,
		varpointer = interactivegui,
		config = colourconfig,
		displayname = "Info Box Colour"
	},
--------- RECORDING ---------
	recordingslot = {
		name = "recordingslot",
		default = 1,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingsavestateslot = {
		name = "savestateslot",
		default = 0,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordinghitslot = {
		name = "hitslot",
		default = 0,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingloop = {
		name = "loop",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingreplayp1 = {
		name = "replayP1",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingreplayp2 = {
		name = "replayP2",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingdelay = {
		name = "delay",
		default = 0,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingautoturn = {
		name = "autoturn",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingskiptostart = {
		name = "skiptostart",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingskiptofinish = {
		name = "skiptofinish",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingrandomise = {
		name = "randomise",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingdelay = {
		name = "delay",
		default = 0,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
	recordingrandomisedelay = {
		name = "randomisedelay",
		default = false,
		configpointer = recording.config,
		varpointer = recording,
		config = recording.config,
	},
--------- HITBOX ---------
	hitboxtoggle = {
		name = "toggle",
		default = true,
		configpointer = config.hitboxes,
		varpointer = hitboxes,
		config = config,
	},
}
local validconfigs = {config = config, colourconfig = colourconfig, recordingconfig = recording.config}

-- CONFIG FUNCTIONS
--[[
	Expensive function.
	Recursively copies all values from table src to table dst, without changing dst tables.
	Triggers Assertion failure with table location name if the dst doesn't have a matching table.
	Call this WITHOUT the third argument defined
--]]
local function deepAppendCopy(src, dst, isrecursive)
	if type(src) ~= "table" then return end
	for i, v in pairs(src) do
		if type(v) == "table" then
			if dst[i] == nil then -- this should never happen
				return i
			end
			local ret = deepAppendCopy(v, dst[i], true)
			if ret then
				local tablename = i.."."..ret
				if isrecursive then
					return tablename
				else
					assert(1==0, "Table: '"..tablename.."' doesn't exist and cannot be appended to.")
				end
			end
		else
			dst[i] = v
		end
	end
end

local function updateDefaultConfig(id)
	local configitem = configitems[id]
	local name = configitem.name
	if configitem.configpointer[name] ~= nil then
		configitem.default = configitem.configpointer[name]
	end
end

local function copyConfigValuesToVar(id)
	local configitem = configitems[id]
	local name = configitem.name
	configitem.varpointer[name] = configitem.configpointer[name]
end

function initConfigTable(tablename, t, configstr)
	assert(type(tablename)=="string", "Table Name must be a string")
	assert(type(t)=="table", "Argument 2 should be the table")
	assert(validconfigs[configstr], configstr.." is not a valid config")

	validconfigs[configstr][tablename] = t
end

function createConfigValue(configname, name, default, configpointer, varpointer, configstr, displayname)
	assert(type(configname)=="string", "Config Name must be a string")
	assert(configitems[configname]==nil, "Config Name: "..configname.." is already taken, configname must be unique")
	assert(type(name)=="string", "Name must be a string")
	assert(default~=nil, "Default must have a value")
	assert(type(configpointer)=="table", "Config Pointer must be a table")
	assert(type(varpointer)=="table", "Var Pointer must be a table")
	assert(type(displayname)=="string" or displayname==nil, "Display Name must be a string")
	assert(validconfigs[configstr], configstr.." is not a valid config")

	configitems[configname] = {
		name = name,
		default = default,
		configpointer = configpointer,
		varpointer = varpointer,
		config = validconfigs[configstr],
		displayname = displayname
	}
end

function getConfigItemsFiltered(filter) -- returns configitems by comparing the start of their names against a filter
	assert(type(filter)=="string", "Filter should be of type string.")
	local newconfigitems = {}
	local len = #filter
	for id, configitem in pairs(configitems) do
		if filter == id:sub(1, len) then
			newconfigitems[id] = {}
			newconfigitems[id].name = configitem.name
			newconfigitems[id].default = configitem.default
			newconfigitems[id].varpointer = configitem.varpointer
			newconfigitems[id].displayname = configitem.displayname
		end
	end
	return newconfigitems
end

function getConfigValue(id)
	assert(configitems[id], "Config Item: '"..id.."' does not exist.")
	local configitem = configitems[id]
	local name = configitem.name
	return configitem.configpointer[name], configitem.varpointer and configitem.varpointer[name], configitem.default
end

function changeConfig(id, value, updatevar)
	assert(id, "Attempt to write value: '"..tostring(value).."' to nil.")
	assert(configitems[id], "Config Item: '"..id.."' does not exist.")
	assert(value~=nil, "Attempt to write nil to '"..id.."'")
	if updatevar == nil then updatevar = true end
	local configitem = configitems[id]
	local name = configitem.name
	assert(
		type(value) == type(configitem.default),
		"Bad value: "..tostring(value).." doesn't match the type of default value: "..tostring(configitem.default)
	)
	configitem.configpointer[name] = value
	if updatevar then
		configitem.varpointer[name] = value
	end
	configitem.config.changed = true
end

function setConfigDefault(id, default)
	assert(id, "Attempt to write value: "..tostring(default).." to nil.")
	assert(default~=nil, "Attempt to write nil to "..id)
	local configitem = configitems[id]
	assert(
		type(default) == type(configitem.default),
		"Bad value: "..tostring(default).." doesn't match the type of the previous default value: "..tostring(configitem.default)
	)
	configitem.default = default
end

function resetConfig(id)
	assert(id, "Attempt to reset a nil config item.")
	assert(configitems[id], "Config Item: '"..id.."' does not exist.")
	local configitem = configitems[id]
	local changed = configitem.config.changed -- remember status
	local value = configitem.varpointer[configitem.name]
	changeConfig(id, configitem.default, true)
	if value == configitem.varpointer[configitem.name] then -- if the value hasn't changed, keep the old status
		configitem.config.changed = changed
	end
end

for id, _ in pairs(configitems) do -- populate the config table with default values
	resetConfig(id)
end

local function removeDefaultConfigValues() -- reduce save file size
	for name, configitem in pairs(configitems) do
		if configitem.default == configitem.configpointer[configitem.name] and configitem.config == config then
			configitem.configpointer[configitem.name] = nil
		end
	end
end

local function trimConfigTable(t) -- remove any extra tables
	for i, v in pairs(t) do
		if type(v)=="table" then
			trimConfigTable(v)
			if next(v) == nil then
				t[i] = nil
			end
		end
	end
end

function saveGameConfigValues()
	if not gamefunctions.tablesave or not config.changed then return end -- only saves if the config has changed
	config.changed = nil
	write("Saving config: " .. configpath)
	assert(table.save(config, configpath)==nil, "Can't save config file")
end
function saveGeneralConfigValues()
	if not gamefunctions.tablesave or not generalconfig.changed then return end -- only saves if the config has changed
	generalconfig.changed = nil
	write("Saving general config: "..generalconfig.path)
	assert(table.save(generalconfig, generalconfig.path)==nil, "Can't save config file")
end
function saveColourConfigValues()
	if not gamefunctions.tablesave or not colourconfig.changed then return end -- only saves if the config has changed
	colourconfig.changed = nil
	write("Saving colour config: "..colourconfig.path)
	assert(table.save(colourconfig, colourconfig.path)==nil, "Can't save config file")
end

----------------------------------------------
-- TEXT DRAWER
----------------------------------------------

local textitems = {}

function addTextItem(text, x, y, colour, timer)
	table.insert(textitems, {text = text, x = x, y = y, colour = colour, timer = timer})
end

function drawTextItem()
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
-- ROM NAME
----------------------------------------------

-- file checking logic + global variables/tables
function fexists(s)
	local fs = io.open(s,"r")
	local res = fs~=nil
	if (res) then
		fs:close()
	end
	return res
end

gamename = ""
for i, v in pairs(games) do
	for _, k in ipairs(v) do
		if (ROM == k) then
			gamename = i
			gamepath = "games/"..gamename.."/"
			configpath = gamepath..ROM..".config"
		end
	end
end

if gamename == "" then
	local text = "GAME NOT RECOGNISED"
	addTextItem(text, interactivegui.sw/2 - #text*LETTER_HALFWIDTH, 10, "cyan")
end

----------------------------------------------
-- CHECK IF ROM MEMORY FILE EXISTS
----------------------------------------------
nbuttons = 0 -- makes calcs easier to already have this

if fexists("games/"..gamename.."/"..gamename..".lua") then
	dofile("games/"..gamename.."/"..gamename..".lua")
	local i = 5
	while (translationtable[i]:sub(1,6)=="button") do nbuttons = nbuttons+1 i=i+1 end
else
	write("Memory addresses not found for "..ROM)
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
	write("No buttons found for "..ROM)
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
		local d = {nil, nil, "icons-taito-32.png", "icons-neogeo-32.png", nil, "icons-capcom-32.png"} -- iconfiles, 3,4,6 buttons
		games[""].iconfile = d[nbuttons]
	else
		write "Can't make a translationtable"
		nbuttons = 0
	end
end

----------------------------------------------
-- INIT ANY GAME SPECIFIC SETTINGS
----------------------------------------------

if initGame then
	initGame(config, configitems, HUDElements)
end

function setGameConstants() -- use this if constants change
	if p1maxhealth then
		gamevars.P1.constants.maxhealth = p1maxhealth
		gamevars.P1.maxhealth = p1maxhealth
		configitems.p1maxhealth.default = p1maxhealth
	end
	if p2maxhealth then
		gamevars.P2.constants.maxhealth = p2maxhealth
		gamevars.P2.maxhealth = p2maxhealth
		configitems.p2maxhealth.default = p2maxhealth
	end
	if p1maxmeter then
		gamevars.P1.constants.maxmeter = p1maxmeter
		gamevars.P1.maxmeter = p1maxmeter
		configitems.p1maxmeter.default = p1maxmeter
	end
	if p2maxmeter then
		gamevars.P2.constants.maxmeter = p2maxmeter
		gamevars.P2.maxmeter = p2maxmeter
		configitems.p2maxmeter.default = p2maxmeter
	end
	if translationtable then
		gamevars.constants.translationtable = translationtable -- game to script inputs
		gamevars.constants.inversetranslationtable = {} -- script to game inputs
		for i,v in pairs(translationtable) do
			if type(i) == "number" then
				gamevars.constants.inversetranslationtable[v] = i
			elseif type(i) == "string" then
				gamevars.constants.inversetranslationtable[v] = i
			else
				assert("Translation table entry ".. i .. " is malformed")
			end
		end
	end
end

setGameConstants()

----------------------------------------------
-- CHECK IF TABLEIO IS PRESENT AND TRYING TO OPEN CONFIG FILE
----------------------------------------------
-- TRY TO USE CONFIG.LUA, THEN A GAME'S DEFAULT CONFIG, THEN THE GENERAL DEFAULT CONFIG
----------------------------------------------
do

if fexists("resources/tableio.lua") then
	dofile("resources/tableio.lua")
	if not gamedefaultconfig then -- comes from game luas
		write "Game default config not found."
	else
		deepAppendCopy(gamedefaultconfig, config)
		for id, _ in pairs(configitems) do -- update the default values and populate the config table with those values
			updateDefaultConfig(id)
			resetConfig(id)
		end
	end

	if fexists(configpath) then
		local gameconfig = table.load(configpath)
		if not gameconfig then
			write("Can't read config file found for "..gamename..", using default config.")
		elseif gameconfig.type ~= "gameconfig" then
			write("Can't read config file found for "..gamename..", bad format.")
		else -- if the file is loaded, make sure the contents are at least superficially correct
			deepAppendCopy(gameconfig, config)
		end
	end

	if fexists(generalconfig.path) then
		local savedgeneralconfig = table.load(generalconfig.path)
		if not savedgeneralconfig then
			write("Can't read general config, using default general config.")
		elseif savedgeneralconfig.type ~= "generalconfig" then
			write("Can't read general config file found, bad format.")
		else -- if the file is loaded, make sure the contents are at least superficially correct
			deepAppendCopy(savedgeneralconfig, generalconfig)
		end
	end

	if fexists(colourconfig.path) then
		local savedcolourconfig = table.load(colourconfig.path)
		if not savedcolourconfig then
			write("Can't read colour config, using colour general config.")
		elseif savedcolourconfig.type ~= "colourconfig" then
			write("Can't read colour config file found, bad format.")
		else -- if the file is loaded, make sure the contents are at least superficially correct
			deepAppendCopy(savedcolourconfig, colourconfig)
		end
	end
	for id, _ in pairs(configitems) do
		copyConfigValuesToVar(id)
	end
	config.changed = nil
	generalconfig.changed = nil
	colourconfig.changed = nil
else
	write("Can't read/write")
end

-- populate the vars tables with values, if applicable
for id, configitem in pairs(configitems) do
	if configitem.varpointer then
		local name = configitem.name
		if not configitem.varpointer then configitem.varpointer={} end
		configitem.varpointer[name] = configitem.configpointer[name]
	end
end

end
----------------------------------------------
-- CALC ANY COMMONLY USED DERIVED VALUES
----------------------------------------------

function calcDerivedValues()
	interactivegui.boxx = emu.screenwidth()/interactivegui.boxxd -- proportions of the screen
	interactivegui.boxy = emu.screenheight()/interactivegui.boxyd-10 -- keep out of range of the tooltips
	interactivegui.boxx2 = interactivegui.boxxm*(emu.screenwidth()/interactivegui.boxxd)
	interactivegui.boxy2 = interactivegui.boxym*(emu.screenheight()/interactivegui.boxyd)-10
	interactivegui.boxxlength = (interactivegui.boxxm-1)*(emu.screenwidth()/interactivegui.boxxd)
	interactivegui.boxylength = (interactivegui.boxym-1)*(emu.screenheight()/interactivegui.boxyd)
	interactivegui.boxxhalflength = (interactivegui.boxxm-1)*(emu.screenwidth()/interactivegui.boxxd)/2
	interactivegui.boxyhalflength = (interactivegui.boxym-1)*(emu.screenheight()/interactivegui.boxyd)/2
	interactivegui.boxxmid = emu.screenwidth()/interactivegui.boxxd+(interactivegui.boxxm-1)*(emu.screenwidth()/interactivegui.boxxd)/2
	interactivegui.boxymid = emu.screenheight()/interactivegui.boxyd-10+(interactivegui.boxym-1)*(emu.screenheight()/interactivegui.boxyd)/2
end

calcDerivedValues()

----------------------------------------------
-- VARIABLE TABLES
----------------------------------------------

gamefunctions = {}

function checkGameFunctions() -- set gamefunctions table
	-- Training mode functions
	if Run then gamefunctions.run = true end
	if playerOneInHitstun then gamefunctions.playeroneinhitstun = true end
	if playerTwoInHitstun then gamefunctions.playertwoinhitstun = true end
	if readPlayerOneHealth then gamefunctions.readplayeronehealth = true end
	if writePlayerOneHealth and not REPLAY then gamefunctions.writeplayeronehealth = true end
	if readPlayerTwoHealth then gamefunctions.readplayertwohealth = true end
	if writePlayerTwoHealth and not REPLAY then gamefunctions.writeplayertwohealth = true end
	if readPlayerOneMeter then gamefunctions.readplayeronemeter = true end
	if writePlayerOneMeter and not REPLAY then gamefunctions.writeplayeronemeter = true end
	if readPlayerTwoMeter then gamefunctions.readplayertwometer = true end
	if writePlayerTwoMeter and not REPLAY then gamefunctions.writeplayertwometer = true end
	if playerOneFacingLeft then gamefunctions.playeronefacingleft = true end
	if playerTwoFacingLeft then gamefunctions.playertwofacingleft = true end
	--
	-- Hitbox functions
	if hitboxesReg then gamefunctions.hitboxesreg = true end
	if hitboxesRegAfter then gamefunctions.hitboxesregafter = true end
	--
	-- Inputs functions try to get these to load a global input table to avoid multiple joypad.get()'s?
	if inputDisplayReg then gamefunctions.inputdisplayreg = true end
	if scrollingInputReg then gamefunctions.scrollinginputreg = true end
	if scrollingInputRegAfter then gamefunctions.scrollinginputregafter = true end
	if scrollingInputClear then gamefunctions.scrollinginputclear = true end
	if scrollingInputSetInput then gamefunctions.scrollinginputsetinput = true end
	if scrollingInputSetSampleInput then gamefunctions.scrollinginputsetsampleinput = true end
	--
	-- Saving/Loading
	if table.save then gamefunctions.tablesave = true end
	if table.load then gamefunctions.tableload = true end
	--
end

----------------------------------------------
-- TRYING TO OPEN HITBOXES
----------------------------------------------
do
	local hitbox = games[gamename].hitboxes
	if hitbox then
		if fexists("hitboxes/"..hitbox..".lua") then
			dofile("hitboxes/"..hitbox..".lua")
			else
			write("Hitbox file "..games[gamename].hitboxes.."not found for "..ROM)
		end
	else
		write("No associated hitbox file for "..ROM)
	end
end
----------------------------------------------
-- TRYING TO DISPLAY INPUTS
----------------------------------------------

if fexists("inputs/input-display.lua") then
	if fexists("inputs/input-modules.lua") then
		dofile("inputs/input-display.lua")
	else
		write("input-modules.lua not found")
	end
else
	write("input-display.lua not found")
end

write ""
write "If the script crashes here you may need to edit DISABLE_SCROLLING_INPUT based on your computer. Open the fbneo-training-mode.lua file with a text editor (notepad, notepad++, etc.) and change DISABLE_SCROLLING_INPUT to true or false, whichever it isn't"

if games[gamename].iconfile then
	iconfile = games[gamename].iconfile
	if fexists("inputs/scrolling-input/"..iconfile) and not DISABLE_SCROLLING_INPUT then
		if fexists("inputs/scrolling-input-display.lua") then
			if fexists("inputs/scrolling-input/scrolling-input-code.lua") then
				dofile("inputs/scrolling-input-display.lua")
			else
				write("scrolling-input-code.lua not found")
			end
		else
			write("scrolling-input-display.lua not found")
		end
	else
		write("inputs/scrolling-input/"..iconfile.." not found")
	end
else
	write("No scrolling input image found for "..ROM)
end

----------------------------------------------
--
----------------------------------------------

----------------------------------------------
-- CHECK IF GUIPAGES EXISTS AND OPEN
-- DEFINE FUNCTIONS USED BY GUIPAGES
----------------------------------------------

local function changeGUIPage(n)
	if not interactivegui.enabled then return end
	n = n or interactivegui.page+1

	if guipages[n] then -- if the page exists go there
		interactivegui.page = n
	else -- otherwise try to wrap-around
		if n == 0 then
			interactivegui.page = #guipages -- goto last
		elseif n == #guipages+1 then
			interactivegui.page = 1 -- goto first
		end -- otherwise do nothing
	end

	local page = guipages[interactivegui.page]

	if interactivegui.selection > #page then -- make sure selection is in bounds
		interactivegui.selection = #page
	elseif interactivegui.selection < 1 then
		interactivegui.selection = 1
	end
end

local function changeGUISelection(n)
	if not interactivegui.enabled then return end
	local page = guipages[interactivegui.page] -- current page
	if (#page<=1) then
		interactivegui.selection = 1
		return
	end
	n = n or interactivegui.selection+1

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

local helpElements = {}
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

local function buttonHandler()
	local buttons = helpElements.buttons
	if (nbuttons <= 2 or buttons==nil) then return end -- can't do anything with two or fewer buttons
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

local function callGUISelectionFunc()
	local func = guipages[interactivegui.page][interactivegui.selection].func
	if not interactivegui.enabled or not func then return end
	func()
end

local function callGUISelectionReleaseFunc()
	local func = guipages[interactivegui.page][interactivegui.selection].releasefunc
	if not interactivegui.enabled or not func then return end
	func()
end

local function interactiveGUISelectionInfo()
	local info = guipages[interactivegui.page][interactivegui.selection].info
	if not interactivegui.enabled or not info then return end

	local largest = 0
	local x1, x2, xm, y2 = interactivegui.boxx, interactivegui.boxx2, interactivegui.boxxmid, interactivegui.boxy2

	for _,v in ipairs(info) do
		if largest < #v then largest = #v end
	end

	gui.box(xm - 1 - (largest)*2, y2 - (#info)*10, xm + 1 + (largest)*2, y2, interactivegui.infocolour, "black")

	for i,v in ipairs(info) do
		gui.text(xm - #v*2 + 1, y2 - (#info)*10 + 2 + (i-1)*10, v)
	end
end

local interactiveGUISelectionBack = function()
	if not interactivegui.enabled then return end
	local tablelength = previousPageAndSelection()
	if tablelength == 0 then -- if back doesn't go anywhere, close the GUI instead
		toggleInteractiveGUI()
	end
end

local kb = { -- offset represents spacing for drawing to screen
	{'1','2','3','4','5','6','7','8','9', ["offset"] = 2},
	{'Q','W','E','R','T','Y','U','I','O','P', ["offset"] = 0},
	{'A','S','D','F','G','H','J','K','L', ["offset"] = 2},
	{'Z','X','C','V','B','N','M', ["offset"] = 6},
}

--fill in table
local function blankKB()
	for _,v in ipairs(kb) do
		for _,k in ipairs(v) do
			guiinputs.kb.inputcount[k] = 0
		end
	end
end

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
			elseif guiinputs.P1.down and not guiinputs.P1.previousinputs.down then
				interactivegui.selection = nav[interactivegui.selection].down or interactivegui.selection
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
			if (releasefunc) then but.releasefunc = releasefunc(elementid) end
			if (selectfunc) then but.selectfunc = selectfunc(elementid) end
			if (autofunc) then but.autofunc = autofunc(element) end
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
					x = x-(#tostring(minimum)+1)*LETTER_WIDTH,
					y = y+10,
					text = tostring(minimum)
				}

	page.maximum = {
					x = x+(#text)*LETTER_WIDTH,
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

	local workingframes = function(n) -- gets faster the longer it runs
		if (n < 60) then
			if n%10==1 then return 1 end -- maybe tie this to coin input leniency?
			return 0
		elseif (n < 120) then
			return 1
		elseif (n < 150) then
			return 2
		elseif (n < 180) then
			return 3
		elseif (n < 210) then
			return 5
		elseif (n < 240) then
			return 10
		elseif (n < 300) then
			return 10
		end
		return 100
	end

	but.autofunc = function(this)
		but.val = updatefunc()
		local d = 0
		if guiinputs.P1.left then

			d = workingframes(guiinputs.P1.leftframecount)

			if but.val-d>=minimum then
				updatefunc(-d)
			else
				updatefunc(maximum-but.val)
			end
		elseif guiinputs.P1.right then

			d = workingframes(guiinputs.P1.rightframecount)

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

 -- load images
local savestateslot_icon=gd.createFromPng("resources/replay/savestateslot.png"):gdStr()
local hitplayback_icon=gd.createFromPng("resources/replay/hitplayback.png"):gdStr()
local savestateslotselected_icon=gd.createFromPng("resources/replay/savestateslotselected.png"):gdStr()
local hitplaybackselected_icon=gd.createFromPng("resources/replay/hitplaybackselected.png"):gdStr()

function drawReplayInfo(x, y)
	local selectcolour = interactivegui.page == "recordingslot" and colour.recordingselected or colour.recordingselect
	local savestateslot = interactivegui.page == "savestateslot" and savestateslotselected_icon or savestateslot_icon
	local hitplayback = interactivegui.page == "hitslot" and hitplaybackselected_icon or hitplayback_icon
	local ystep = 10


	for i = 1, REPLAY_SLOTS_COUNT do
		if recording.recordingslot == i then
			gui.text(x+23,y+ystep*i, "Slot "..i, selectcolour)
		else
			gui.text(x+23,y+ystep*i, "Slot "..i)
		end
		if recording.savestateslot == i then
			gui.gdoverlay(x+11, y+ystep*i-2, savestateslot)
		end
		if recording.hitslot == i then
			gui.gdoverlay(x, y+ystep*i-2, hitplayback)
		end
		-- check if anything is recorded in that slot
		if (recording[i].p1start~=recording[i].p1finish and recording[i].p1finish and recording[i].p2start~=recording[i].p2finish and recording[i].p2finish) then
			gui.text(x+49, y+ystep*i, "P1&2")
		elseif (recording[i].p1start~=recording[i].p1finish and recording[i].p1finish) then
			gui.text(x+49, y+ystep*i, "P1")
		elseif (recording[i].p2start~=recording[i].p2finish and recording[i].p2finish) then
			gui.text(x+49, y+ystep*i, "P2")
		end
	end
end

function replaySave()
	if gamename~="" then
		recording.gamename = gamename
		assert(
			table.save(recording, gamepath.."save.replaypack")==nil,
			"Can't save replay file"
		)
		write("Saving replaypack to: "..gamepath.."save.replaypack")
	else
		assert(
			table.save(recording,gamepath..ROM..".replaypack")==nil,
			"Can't save replay file"
		)
		write(gamepath..ROM..".replaypack")
	end
end

function replayLoad()
	if gamename~="" then
		local path = gamepath.."save.replaypack"
		if fexists(path) then
			newrecording = table.load(path)
			if newrecording.gamename~=gamename then
				write("Tried to load replaypack for game: "..newrecording.gamename)
				return
			end
			deepAppendCopy(newrecording.config, recording.config)
			newrecording.config = recording.config
			for i, v in pairs(newrecording) do
				if i~="config" then
					recording[i] = v
				end
			end
			for id, _ in pairs(getConfigItemsFiltered("recording")) do
				copyConfigValuesToVar(id)
			end
		end
	else
		local path = gamepath..gamename..".replaypack"
		if fexists(path) then
			newrecording = table.load(path)
			deepAppendCopy(newrecording.config, recording.config)
			newrecording.config = recording.config
			for i, v in pairs(newrecording) do
				if i~="config" then
					recording[i] = v
				end
			end
			for id, _ in pairs(getConfigItemsFiltered("recording")) do
				copyConfigValuesToVar(id)
			end
		end
	end
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
		if (pageelements[id(elementind-1)] and pageelements[id(elementind-1)].y == element.y) then
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
	if fexists("guipages.lua") then
		dofile("guipages.lua")
	else
		write("GUI pages not found"..ROM)
	end
end

function orTable(tab) -- check if at least one value in the table is true/well defined
	for _,v in pairs(tab) do
		if v then
			return true
		end
	end

	return false
end

function notEmpty(tab) -- check if a table is not empty
	return next(tab) ~= nil
end

local function updategamevars()
	if gamefunctions.playertwoinhitstun then
		gamevars.P2.inhitstun = playerTwoInHitstun()
	end
	if gamefunctions.playeroneinhitstun then
		gamevars.P1.inhitstun = playerOneInHitstun()
	end

	if gamefunctions.readplayeronehealth then
		gamevars.P1.previoushealth = gamevars.P1.health
		gamevars.P1.health = readPlayerOneHealth()
	end

	if gamefunctions.readplayertwohealth then
		gamevars.P2.previoushealth = gamevars.P2.health
		gamevars.P2.health = readPlayerTwoHealth()
	end

	if gamefunctions.playertwofacingleft then
		gamevars.P2.facingleft = playerTwoFacingLeft()
	end
	if gamefunctions.playeronefacingleft then
		gamevars.P1.facingleft = playerOneFacingLeft()
	end

	if gamefunctions.readplayeronemeter then
		gamevars.P1.meter = readPlayerOneMeter()
	end
	if gamefunctions.readplayertwometer then
		gamevars.P2.meter = readPlayerTwoMeter()
	end

end

local function writePlayerHealth(player, health)
	if (player == "P1" and gamefunctions.writeplayeronehealth) then
		writePlayerOneHealth(health)
	elseif(player == "P2" and gamefunctions.writeplayertwohealth) then
		writePlayerTwoHealth(health)
	end
end

local function writePlayerMeter(player, health)
	if (player == "P1" and gamefunctions.writeplayeronemeter) then
		writePlayerOneMeter(health)
	elseif(player == "P2" and gamefunctions.writeplayertwometer) then
		writePlayerTwoMeter(health)
	end
end

function otherPlayer(player) -- returns "P2" when "P1" is given and vice versa
	return player=="P1" and "P2" or "P1"
end

local function comboHandler(player)
	local cvars = combovars[player]
	local gvars = gamevars[player]

	cvars.healthdiff = gvars.previoushealth - gvars.health
	cvars.previouscombo = cvars.combo -- used by other functions to track 'After Combo' logic

	--write(player.." "..fc..": "..tostring(gvars.inhitstun)..", "..cvars.healthdiff) -- debugging command to check if the hitstun and damage are in sync
	if gvars.inhitstun then
		if cvars.healthdiff > 0 then -- player has taken damage
			cvars.combo = cvars.combo+1
		end
		if cvars.combo == 0 then -- default view to be 1 rather than 0, if the player is in hitstun, they've probably been attacked
			cvars.displaycombo = 1
		else
			cvars.displaycombo = cvars.combo
		end
	else
		cvars.combo = 0 -- if player is not in hitstun the combo drops
	end

	if cvars.healthdiff > 0 then -- player has taken damage
		cvars.previousdamage = cvars.healthdiff -- remember how much damage has been taken to display to the user
		if cvars.combo == 1 then -- restart the count of total damage taken if it's the first hit
			cvars.comboDamage=0
		end
		cvars.comboDamage = cvars.comboDamage + cvars.healthdiff
	end
end

local function healthHandler(player)
	if not combovars[player].refillhealthenabled or combovars[player].instantrefillhealth then return end
	local cvars = combovars[player]
	local gvars = gamevars[player]

	if gvars.inhitstun then
		cvars.refillhealth = 0
	elseif cvars.combo ~= cvars.previouscombo and cvars.refillhealth == 0 then
		cvars.refillhealth = math.ceil((gvars.maxhealth - gvars.health) / cvars.refillhealthspeed) -- refill speed
	end

	if cvars.refillhealth ~= 0 then
		if (cvars.refillhealth + gvars.health >= gvars.maxhealth) or cvars.instantrefillhealth then
			writePlayerHealth(player, gvars.maxhealth)
			cvars.refillhealth = 0
		else
			writePlayerHealth(player, gvars.health + cvars.refillhealth)
		end
	end
end

local function meterHandler(player)
	if not combovars[player].refillmeterenabled or combovars[player].instantrefillmeter then return end
	local otherplayer = otherPlayer(player)
	local cvars = combovars[player]
	local gvars = gamevars[player]

	if gamevars[otherplayer].inhitstun and combovars[otherplayer].previouscombo == 0 then
		cvars.refillmeter = 0
	elseif combovars[otherplayer].combo < combovars[otherplayer].previouscombo then -- if the combo has dropped
		if cvars.refillmeter == 0 then
			cvars.refillmeter = math.ceil((gvars.maxmeter - gvars.meter) / cvars.refillmeterspeed) -- refill speed
		end
	end

	if cvars.refillmeter ~= 0 then
		if (cvars.refillmeter + gvars.meter >= gvars.maxmeter) then
			writePlayerMeter(player, gvars.maxmeter)
			cvars.refillmeter = 0
		else
			writePlayerMeter(player, gvars.meter + cvars.refillmeter)
		end
	end
end

local function instantHealth(player)
	if not combovars[player].refillhealthenabled then return end
	if not combovars[player].instantrefillhealth then return end
	writePlayerHealth(player, gamevars[player].maxhealth)
end

local function instantMeter(player)
	if not combovars[player].refillmeterenabled then return end
	if not combovars[player].instantrefillmeter then return end
	writePlayerMeter(player, gamevars[player].maxmeter)
end

local function readGUIInputs()
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

local stickimgs = {} -- one for each direction, numpad input
for i = 1,9 do
	stickimgs[i]=gd.createFromPng("resources/stick/"..i..".png"):gdStr() -- load images
end

function displayStick(x, y)
	local a = function(b) if b then return 1 end return 0 end -- bool to num
	local dir = 5+a(guiinputs.P1.up)*3 + a(guiinputs.P1.left)*-1 + a(guiinputs.P1.right)*1 + a(guiinputs.P1.down)*-3
	gui.gdoverlay(x, y, stickimgs[dir])
end

local function readInputs() -- these inputs can be altered for replays, swapping character etc., gui inputs won't be
	local player, input
	inputs.setinputs = {}
	for i,v in pairs(joypad.get()) do -- check every button
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

local function combinePlayerInputs(P1, P2, other)

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

local function toggleSwapInputs(bool, vargs)
	if bool==nil then inputs.properties.enableinputswap = not inputs.properties.enableinputswap
	else inputs.properties.enableinputswap = bool end
	if vargs then vargs.swapinputs = false end
	toggleStates(vargs)
end

local function swapInputs()
	if not inputs.properties.enableinputswap then return end
	gui.text(interactivegui.sw-#"REVERSED"*LETTER_WIDTH, 0, "REVERSED", "red")
	inputs.P1, inputs.P2 = inputs.P2, inputs.P1
	inputs.setinputs = combinePlayerInputs(inputs.P1, inputs.P2, inputs.other)
end

local function swapPlayerDirection(inputframe) -- swaps the directions for a recording and returns a new table with the values
	local inputs = copytable(inputframe) -- shallow copy

	if inputs.Left==true then inputs.Right=true inputs.Left=false
	elseif inputs.Right==true then inputs.Left=true inputs.Right=false end

	return inputs
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

local function freezePlayer(player)
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

-- Const
local SERIALISETABLE = {}
SERIALISETABLE.P1 = {}
SERIALISETABLE.P2 = {}

for i,v in pairs(joypad.get()) do -- assemble table in proper order
	local input
	if i:sub(1,2) == "P1" then -- P1 and P2 should have the same inputs
		input = i:sub(4)
		SERIALISETABLE.P1[#SERIALISETABLE.P1+1] = input
		SERIALISETABLE.P1[input] = #SERIALISETABLE.P1
		SERIALISETABLE.P2[#SERIALISETABLE.P2+1] = input
		SERIALISETABLE.P2[input] = #SERIALISETABLE.P2
	end
end

SERIALISETABLE.P1.len = #SERIALISETABLE.P1 -- used for cleaning up inputs
SERIALISETABLE.P2.len = SERIALISETABLE.P1.len

local function serialiseInit(recordslot) -- set up compression, reduce the size of _stable to make the numbers actually smaller
	local player, input, num
	for i,_ in pairs(recordslot.constants) do
		player = i:sub(1,2)
		input = i:sub(4)
		if player == "P1" and recordslot._stable.P1[input] then
			num = recordslot._stable.P1[input]
			for i = num+1, recordslot._stable.P1.len do
				recordslot._stable.P1[input] = nil -- remove
				recordslot._stable.P1[i-1] = recordslot._stable.P1[i]
				recordslot._stable.P1[ recordslot._stable.P1[i] ] = i-1
			end
			recordslot._stable.P1.len = recordslot._stable.P1.len-1
			for i = 1, #recordslot._stable.P1-recordslot._stable.P1.len do table.remove(recordslot._stable.P1) end-- remove garbage
			for i, v in pairs(recordslot._stable.P1) do if recordslot._stable.P1[v]==nil and i~="len" then recordslot._stable.P1[i]=nil end end
		elseif player == "P2" and recordslot._stable.P2[input] then
			num = recordslot._stable.P2[input]
			for i = num+1, recordslot._stable.P2.len do
				recordslot._stable.P2[input] = nil -- remove
				recordslot._stable.P2[i-1] = recordslot._stable.P2[i]
				recordslot._stable.P2[ recordslot._stable.P2[i] ] = i-1
			end
			recordslot._stable.P2.len = recordslot._stable.P2.len-1
			for i = 1, #recordslot._stable.P2-recordslot._stable.P2.len do table.remove(recordslot._stable.P2) end-- remove garbage
			for i, v in pairs(recordslot._stable.P2) do if recordslot._stable.P2[v]==nil and i~="len" then recordslot._stable.P2[i]=nil end end -- final check
		end
	end
end

local function serialise(recordslot)
	for i = 1, #recordslot do -- serialize
		local num = 0
		recordslot[i].serial={}
		recordslot[i].serial.other={}
		for i, v in pairs(recordslot[i].raw.P1 or {}) do
			if v and recordslot.constants["P1 "..i]==nil then num = bit.bor(num, bit.lshift(1, recordslot._stable.P1[i]-1)) end
		end
		for i, v in pairs(recordslot[i].raw.P2 or {}) do
			if v and recordslot.constants["P2 "..i]==nil then num = bit.bor(num, bit.lshift(1, recordslot._stable.P2[i]-1+recordslot._stable.P1.len)) end
		end
		for j, v in pairs(recordslot[i].raw.other or {}) do -- dipswitches aren't boolean so they can't be serialised
			if recordslot.constants[j]==nil then recordslot[i].serial.other[j] = v end -- only put in the ones we need
		end
		--final bit to track direction
		if recordslot[i].p1facingleft then num = bit.bor(num, bit.lshift(1, recordslot._stable.P1.len+recordslot._stable.P2.len)) end
		if recordslot[i].p2facingleft then num = bit.bor(num, bit.lshift(1, recordslot._stable.P1.len+recordslot._stable.P2.len+1)) end
		recordslot[i].serial.player = num
		if not next(recordslot[i].serial.other) then recordslot[i].serial.other = nil recordslot[i].serial=num end -- more often than not dipswitches wont change
		recordslot[i].raw = nil -- we can empty this now
	end
end

local function unserialise(inputs, _stable, constants) -- takes inputs (recordslot[frame]), _stable and constants to unserialise
	local serial, other
	if (type(inputs.serial)=="number") then
		serial = inputs.serial
		other = {}
	else
		serial = inputs.serial.player
		other = inputs.serial.other
	end

	inputs.raw = {} -- initialise
	for _, player in pairs({"P1", "P2"}) do
		inputs.raw[player] = {}
		local t = inputs.raw[player]
		for i = 1, #_stable[player] do
			if bit.band(serial,1)==1 then
				t[ _stable[player][i] ] = true
			else
				t[ _stable[player][i] ] = false
			end
			serial = bit.rshift(serial,1)
		end
	end
	inputs.p1facingleft = bit.band(serial,1)==1 -- set direction flag
	inputs.p2facingleft = bit.band(serial,2)==2 -- set direction flag
	inputs.raw.other = {}
	t=inputs.raw.other
	for i, v in pairs(other) do
		t[i] = v
	end

	local player, input
	for i, v in pairs(constants) do -- apply constants
		player = i:sub(1,2)
		input = i:sub(4)
		if player == "P1" then
			inputs.raw.P1[input] = v
		elseif player == "P2" then
			inputs.raw.P2[input] = v
		else
			t[i] = v
		end
	end
end

function toggleRecording(bool, vargs)

	if interactivegui.movehud.enabled then return end

	local swp = vargs and vargs.swapinputs

	if vargs then vargs.recording = false end
	toggleStates(vargs)

	vargs = vargs or {}

	if bool==nil then recording.enabled = not recording.enabled
	else recording.enabled = bool end

	recording.swapplayers = not recording.replayP1

	if swp~=false then -- we only want to toggle the inputs when toggleSwapInputs is not originally called
		if recording.swapplayers then
			toggleSwapInputs(recording.enabled, vargs)
		else
			toggleSwapInputs(false, vargs)
		end
	end

	if recording.enabled then -- start recording
		recording[recording.recordingslot] = {}
		recording.framestart = fc
		-- prep for serialising
		recording[recording.recordingslot]._stable = {}
		recording[recording.recordingslot]._stable.P1 = copytable(SERIALISETABLE.P1)
		recording[recording.recordingslot]._stable.P2 = copytable(SERIALISETABLE.P2)
		recording[recording.recordingslot].constants = joypad.get()
	else -- stop recordings
		for j = 1, #recording do -- try to serialise everything that has a new input
			local recordslot = recording[j]
			if not recordslot[1] or not recordslot[1].raw or not recordslot[1].raw.P1 or not recordslot[1].raw.P2 then -- nothing to do past here
			else
				if not recordslot.p1start and not recordslot.p2start then -- if nothing is recorded
					recording[j] = {}
				else
					recordslot.p1start = recordslot.p1start or #recordslot
					recordslot.p2start = recordslot.p2start or #recordslot
					for i=#recordslot,recordslot.p1start,-1 do
						if recordslot[i].raw.P1 then recordslot[i].raw.P1.Coin = false end -- clear coin
					end
					for i=#recordslot,recordslot.p2start,-1 do
						if recordslot[i].raw.P2 then recordslot[i].raw.P2.Coin = false end -- clear coin
					end
					serialiseInit(recordslot)
					serialise(recordslot)
				end
			end
		end
	end
end

local function logRecording()

	if not recording.enabled then return end
	recording[recording.recordingslot] = recording[recording.recordingslot] or {}

	local recordslot = recording[recording.recordingslot]
	local tab = {
		raw = {
			P1 = copytable(inputs.P1),
			P2 = copytable(inputs.P2),
			other = copytable(inputs.other)
		},
		serial = {
			player={},
			other={},
		},
	}

	for i, v in pairs(tab.raw.P1) do
		if recordslot.constants["P1 "..i]~=v then recordslot.constants["P1 "..i]=nil end -- remove non-duping values from table
	end
	for i, v in pairs(tab.raw.P2) do
		if recordslot.constants["P2 "..i]~=v then recordslot.constants["P2 "..i]=nil end -- remove non-duping values from table
	end
	for i, v in pairs(tab.raw.other) do
		if recordslot.constants[i]~=v then recordslot.constants[i]=nil end -- remove non-duping values from table
	end

	if not recording[recording.recordingslot].p1start then -- move start forward to first frame that something happens on
		if orTable(tab.raw.P1) and not tab.raw.P1.Coin then
			recordslot.p1start = fc - recording.framestart
		end
	end

	if not recording[recording.recordingslot].p2start then -- move start forward to first frame that something happens on
		if orTable(tab.raw.P2) and not tab.raw.P2.Coin then
			recordslot.p2start = fc - recording.framestart
		end
	end

	if orTable(tab.raw.P1) and not tab.raw.P1.Coin then  -- put finish on the last frame that something happens
		recordslot.p1finish = fc - recording.framestart
	end

	if orTable(tab.raw.P2) and not tab.raw.P2.Coin then  -- put finish on the last frame that something happens
		recordslot.p2finish = fc - recording.framestart
	end

	if gamefunctions.playeronefacingleft then
		tab.p1facingleft = gamevars.P1.facingleft
	end

	if gamefunctions.playertwofacingleft then
		tab.p2facingleft = gamevars.P2.facingleft
	end

	table.insert(recordslot, tab)
	gui.text(1,1,"Slot "..recording.recordingslot.." (0/"..#recordslot..")","red")

end

-- global, as it is used in ssf2x
function togglePlayBack(bool, vargs)
	if interactivegui.movehud.enabled then return end

	local _playbackslot = recording.playbackslot or recording.recordingslot -- tmp for playbackslot
	recording.playbackslot = nil

	local _rs = recording.recordingslot

	if recording.randomise then
		local b = false
		for i = 1, REPLAY_SLOTS_COUNT do if recording[i][1] then b = true end end
		if not b then return end
		local pos
		_playbackslot = nil
		while _playbackslot==nil do -- keep running until we get a valid slot
			pos = math.random(REPLAY_SLOTS_COUNT)
			if recording[pos][1] then -- check if there's something in here
				_playbackslot = pos
			end
		end
		-- make sure the recordslot is properly serialised if using randomise
		recording.recordingslot = _playbackslot
	end

	if vargs then vargs.playback = false end
	toggleStates(vargs)

	recording.recordingslot = _rs -- restore recordingslot after serialise (through toggleRecord)

	local recordslot = recording[_playbackslot]
	if not recordslot then return end

	if not recordslot.p1start and not recordslot.p2start then -- if nothing is recorded
		recording[_playbackslot] = {}
	end
	if not recordslot[1] then return end -- if nothing is recorded

	if bool==nil then recording.playback = not recording.playback
	else recording.playback = bool end

	if not recording.replayP1 and not recording.replayP2 then
		recording.replayP2 = true
	end

	if not recording.playback then
		recordslot.framestart = nil
	else
		recording.playbackslot = _playbackslot

		if recording.replayP1 and recording.replayP2 then
			recordslot.start = recordslot.p1start
			if (recordslot.start==nil and recordslot.p2start~=nil) or (recordslot.start>recordslot.p2start) then recordslot.start = recordslot.p2start end
		elseif recording.replayP1 then
			toggleSwapInputs(true)
			recordslot.start = recordslot.p1start
		else
			recordslot.start = recordslot.p2start
		end
		if recordslot.start==recordslot.finish then toggleSwapInputs(false) return end -- nothing recorded

		recording.startcounter = 0 -- randomise starting playback
		if recording.randomisedelay then
			recording.starttime = math.random(recording.delay+1)-1 -- [0,delay]
		else
			recording.starttime = recording.delay
		end
	end
end

local function playBack()
	if not recording.playback then return end
	recording.playbackslot = recording.playbackslot or recording.recordingslot
	local recordslot = recording[recording.playbackslot]
	if not recordslot then return end

	recordslot.framestart = recordslot.framestart or fc - 1

	local start, finish = 0, #recordslot

	if recording.skiptostart and recordslot.start then start = recordslot.start end
	if recording.skiptofinish and recordslot.finish then finish = recordslot.finish end

	if recording.delay>0 then gui.text(72,1,"Delay: "..recording.starttime) end -- show delay

	if recording.starttime > recording.startcounter then -- delay until replay starts
		gui.text(1,1,"Slot "..recording.playbackslot.." ("..fc-recordslot.framestart.."/"..#recordslot..")")
		recording.startcounter = recording.startcounter+1
		recordslot.framestart = recordslot.framestart+1
		return
	end

	if fc - recordslot.framestart + start > finish then
		if not recording.loop then -- finished replaying, reset everything
			recordslot.framestart = nil
			recording.playback = false
			recording.playbackslot = nil
			return
		else -- loop
			recordslot.framestart = fc-1
			if recording.delay>0 and recording.randomisedelay then
				recording.starttime = math.random(recording.delay+1)-1 -- [0,delay]
			end
		end
	end

	gui.text(1,1,"Slot "..recording.playbackslot.." ("..fc-recordslot.framestart.."/"..#recordslot..")")

	unserialise(recordslot[fc - recordslot.framestart + start], recordslot._stable, recordslot.constants)
	local raw = recordslot[fc - recordslot.framestart + start].raw

	if gamevars.P1.facingleft ~= recordslot[fc - recordslot.framestart + start].p1facingleft and recording.autoturn then
		raw.P1 = swapPlayerDirection(raw.P1)
	end
	if gamevars.P2.facingleft ~= recordslot[fc - recordslot.framestart + start].p2facingleft and recording.autoturn then
		raw.P2 = swapPlayerDirection(raw.P2)
	end
	if recording.replayP1 and recording.replayP2 then
		inputs.setinputs = combinePlayerInputs(raw.P1, raw.P2, raw.other)
	elseif recording.replayP1 then
		inputs.setinputs = combinePlayerInputs(raw.P1, inputs.P2, raw.other)
	else
		inputs.setinputs = combinePlayerInputs(inputs.P1, raw.P2, raw.other)
	end
	recordslot[fc - recordslot.framestart + start].raw = nil
end

local function hitPlayBack()
	if recording.hitslot < 1 or recording.hitslot > REPLAY_SLOTS_COUNT then return end
	if combovars.P2.previouscombo <= combovars.P2.combo then return end
	recording.playbackslot = recording.hitslot
	togglePlayBack(true)
end

function savestatePlayBack()
	if recording.savestateslot < 1 or recording.savestateslot > REPLAY_SLOTS_COUNT then return end
	recording.playbackslot = recording.savestateslot
	togglePlayBack(true)
end

local inputbuffer = {}

for i = 1, 9 do -- max 9 frames of delay
	inputbuffer[i] = joypad.get()
end

delayinputcount = 0

local function delayInputs()
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

local function applyHoldDirection() -- getting a player to hold down/up etc.
	if not inputs.properties.holddirection then return end
	for _, v in pairs(inputs.properties.holddirection) do
		inputs.setinputs["P2 " ..v] = true
		inputs.P2[v] = true
	end
	inputs.properties.enableinputset = true
end

-- set up gd images
local icons = {[16] = {}} -- follows translationtable series
local helpButtons = {}
local helpShell = gd.createFromPng("resources/info/shell.png")
helpShell = helpShell:gdStr()

if scrollingInputReg then -- if there's a scrolling input file loaded
	local img = gd.createFromPng("inputs/scrolling-input/"..games[gamename].iconfile) -- always assume we're using a 32x32 tileset image
	local imgcnt = img:sizeY()/32
	local y = img:sizeY()-(nbuttons+1)*32 -- y of first button, ignoring start
	--[[
		Left,
		Right,
		Up,
		Down,
		Up-Left, -- skip these
		Up-Right,
		Down-Left,
		Down-Right,
		{
		.
		.
		.
		*Buttons*,
		.
		.
		.
		},
		Start
	--]]

	-- change to 16x16 for displaying
	for i = 1, 4 do	-- cardinal directions
		icons[16][i] = gd.create(16,16)
		icons[16][i]:copyResampled(img, 0, 0, 0, (i-1)*32, 16, 16, 32, 32)
		icons[16][i] = icons[16][i]:gdStr()
	end

	for i = 9, imgcnt do -- skip diagonals, rest of the buttons
		icons[16][i-4] = gd.create(16,16)
		icons[16][i-4]:copyResampled(img, 0, 0, 0, (i-1)*32, 16, 16, 32, 32)
		icons[16][i-4] = icons[16][i-4]:gdStr()
	end

	for i = 1,nbuttons do
		helpButtons[i] = icons[16][i+4] -- assign buttons
		y=y+32
	end
else -- otherwise use these defaults
	for i = 1,nbuttons do
		helpButtons[i] = gd.createFromPng("resources/info/"..i..".png")
		helpButtons[i] = helpButtons[i]:gdStr()
	end
end

local toggledrawhelp = true

local function drawHelp()
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
	if element.bgcolour ~= nil or element.olcolour ~= nil then
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

local garbagecount = {disp = collectgarbage("count")}
local function drawGUI()
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

local function drawKB(x,y)
	for rowid, row in ipairs(kb) do
		for letterid,letter in ipairs(row) do
			local col="white"
			if inputs.hotkeys.funcs[letter] then col="green" end
			if guiinputs.kb.inputs and guiinputs.kb.inputs[letter] then col="red" end
			gui.text(x+row.offset+(letterid-1)*LETTER_WIDTH,y+8*(rowid-1),letter,col)
		end
	end
end

--fall backs in case can't read joypad input
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

local function processGUIInputs()
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

local function HUDElementsParse(HUDElements) -- parses HUDElements to fit the createNavigatablePage format
	local parsedElements = {}
	for elementid, element in ipairs(HUDElements) do
		table.insert(parsedElements, {id=elementid, x=element.x(), y=element.y() })
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

function drawHUD() -- all parts of the hud should be dropped in here
	if interactivegui.inmenu and not interactivegui.movehud.enabled then return end

	for _, v in ipairs(HUDElements) do
		if v.enabled() then v.draw() end
	end
end

local function hudworkingframes(n) -- gets faster the longer it runs
	if (n < 60) then
		if n%10==1 then return 1 end -- maybe tie this to coin input leniency?
		return 0
	elseif (n < 120) then
		return 1
	elseif (n < 150) then
		return 2
	elseif (n < 180) then
		return 3
	elseif (n < 210) then
		return 4
	elseif (n < 300) then
		return 5
	end
	return 10
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
				diff = hudworkingframes(guiinputs.P1.leftframecount)*-1
				pos = HUDElements[interactivegui.movehud.selection].x(x+diff)
				if (pos < 0) then HUDElements[interactivegui.movehud.selection].x(interactivegui.sw) end -- stay in bounds
			elseif guiinputs.P1.right then
				diff = hudworkingframes(guiinputs.P1.rightframecount)
				pos = HUDElements[interactivegui.movehud.selection].x(x+diff)
				if (pos > interactivegui.sw) then HUDElements[interactivegui.movehud.selection].x(0) end -- stay in bounds
			end

			if guiinputs.P1.up then
				diff = hudworkingframes(guiinputs.P1.upframecount)*-1
				pos = HUDElements[interactivegui.movehud.selection].y(y+diff)
				if (pos < 0) then HUDElements[interactivegui.movehud.selection].y(interactivegui.sh) end -- stay in bounds
			elseif guiinputs.P1.down then
				diff = hudworkingframes(guiinputs.P1.downframecount)
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

local function moveHUDInteract()

	if not interactivegui.movehud.enabled then return end

	-- pick different hud elements, hook them up to changeconfig

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
		for _,v in ipairs(HUDElements[interactivegui.movehud.selection].movehud or {}) do
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
	if y>=interactivegui.sh-27 and (x>=(interactivegui.sw/2-helpElements.len*9) and x<=(interactivegui.sw/2+helpElements.len*9)) then toggledrawhelp=false else toggledrawhelp=true end

	helpElements.buttons = helpButtons
end

registers = {
	registerbefore = {},
	guiregister = {},
	registerafter = {},
	emuexit = {},
}

local function drawcomboHUD()
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

function toggleReplayEditor(bool, vargs)
	-- need state switching

	if bool==nil then interactivegui.replayeditor.enabled = not interactivegui.replayeditor.enabled
	else interactivegui.replayeditor.enabled=bool end

	if vargs then vargs.replayeditor = false end
	toggleStates(vargs)

	if interactivegui.replayeditor.enabled then
		interactivegui.replayeditor.inputs = {}
		for j = 1, REPLAY_SLOTS_COUNT do
			interactivegui.replayeditor.inputs[j] = {}
			local recordslot = recording[j]
			for i = 1, #recordslot do -- unserialise them all so they can be seen
				interactivegui.replayeditor.inputs[j][i] = {serial={}}
				if (type(recordslot[i].serial)=="number") then -- copy across necessary values, two different kinds of serialising
					interactivegui.replayeditor.inputs[j][i].serial.player = recordslot[i].serial -- copy across necessary values
					interactivegui.replayeditor.inputs[j][i].serial.other = {}
				else
					interactivegui.replayeditor.inputs[j][i].serial.player = recordslot[i].serial.player
					interactivegui.replayeditor.inputs[j][i].serial.other = recordslot[i].serial.other
				end
				unserialise(interactivegui.replayeditor.inputs[j][i], recordslot._stable, recordslot.constants) -- should be able to do these in one and buffer it
			end
		end
	else
		--if not interactivegui.replayeditor.inputs then return end
		--if not interactivegui.replayeditor.inputs[recording.recordingslot] then return end
		--if not interactivegui.replayeditor.inputs[recording.recordingslot][1] then return end
		if not interactivegui.replayeditor.changed then return end

		for j,_ in pairs(interactivegui.replayeditor.changed) do
			local recordslot = recording[j]
			recordslot.constants = joypad.get()
			recording.framestart = fc-1
			for i = 1, #interactivegui.replayeditor.inputs[j] do
				recordslot[i] = {raw = {}}
				recordslot[i].raw.P1 = copytable(interactivegui.replayeditor.inputs[j][i].raw.P1)
				recordslot[i].raw.P2 = copytable(interactivegui.replayeditor.inputs[j][i].raw.P2)
				recordslot[i].raw.other = copytable(inputs.other) -- fallback

				for i, v in pairs(recordslot[i].raw.P1) do
					if recordslot.constants["P1 "..i]~=v then recordslot.constants["P1 "..i]=nil end -- remove non-duping values from table
				end
				for i, v in pairs(recordslot[i].raw.P2) do
					if recordslot.constants["P2 "..i]~=v then recordslot.constants["P2 "..i]=nil end -- remove non-duping values from table
				end
				for i, v in pairs(recordslot[i].raw.other) do
					if recordslot.constants[i]~=v then recordslot.constants[i]=nil end -- remove non-duping values from table
				end

				if not recordslot.p1start then -- move start forward to first frame that something happens on
					if orTable(recordslot[i].raw.P1) and not recordslot[i].raw.P1.Coin then
						recordslot.p1start = i
					end
				end

				if not recordslot.p2start then -- move start forward to first frame that something happens on
					if orTable(recordslot[i].raw.P2) and not recordslot[i].raw.P2.Coin then
						recordslot.p2start = i
					end
				end

				if orTable(recordslot[i].raw.P1) and not recordslot[i].raw.P1.Coin then  -- put finish on the last frame that something happens
					recordslot.p1finish = i
				end

				if orTable(recordslot[i].raw.P2) and not recordslot[i].raw.P2.Coin then  -- put finish on the last frame that something happens
					recordslot.p2finish = i
				end

				if gamefunctions.playeronefacingleft then
					recordslot[i].p1facingleft = interactivegui.replayeditor.inputs[j][i].p1facingleft
				end

				if gamefunctions.playertwofacingleft then
					recordslot[i].p2facingleft = interactivegui.replayeditor.inputs[j][i].p2facingleft
				end
			end
		end
		interactivegui.replayeditor.changed = {}
		toggleRecording(false, vargs) -- sets up serialising stuff
	end
end

local drawReplayEditorFuncs = {
	function(but) -- set
		if interactivegui.replayeditor.framestart then -- countdown to taking input
			local timer = 60
			gui.text(1,1,timer-(fc-interactivegui.replayeditor.framestart),"red")
			if fc >= interactivegui.replayeditor.framestart+timer or interactivegui.replayeditor.framestart>fc then -- one second/failsafe
				local recordslot = recording[recording.recordingslot]
				local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]

				reinputs[interactivegui.replayeditor.editframe] = {raw={P1={}, P2={}}}
				reinputs[interactivegui.replayeditor.editframe].raw.P2=copytable(inputs.P1) -- new value
				reinputs[interactivegui.replayeditor.editframe].p1facingleft = gamevars.P1.facingleft
				reinputs[interactivegui.replayeditor.editframe].p2facingleft = gamevars.P2.facingleft

				recordslot._stable = {} -- make sure this updates
				recordslot._stable.P1 = copytable(SERIALISETABLE.P1)
				recordslot._stable.P2 = copytable(SERIALISETABLE.P2)

				if (orTable(inputs.P1)) then -- if an input has been passed temp update start/finish for visuals
					if (recordslot.p2start and interactivegui.replayeditor.editframe<recordslot.p2start) then
						recordslot.p2start = interactivegui.replayeditor.editframe
					end
					if (recordslot.p2finish and interactivegui.replayeditor.editframe>recordslot.p2finish) then
						recordslot.p2finish = interactivegui.replayeditor.editframe
					end
				end

				interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {} -- this slot has updated
				interactivegui.replayeditor.changed[recording.recordingslot] = true

				interactivegui.replayeditor.editframe=interactivegui.replayeditor.editframe+1
				interactivegui.replayeditor.framestart=nil
			end
		elseif guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then -- starts the timer
			interactivegui.replayeditor.framestart = fc
		end
	end,
	function(but) -- copy
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			if interactivegui.replayeditor.framestart or not interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] then return end -- something to copy
			local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]

			for i=#reinputs,interactivegui.replayeditor.editframe,-1 do
				-- move everything down one
				reinputs[i+1] = {raw={P1={}, P2={}}}
				reinputs[i+1].raw.P2=copytable(reinputs[i].raw.P2)
				reinputs[i+1].p2facingleft = reinputs[i].p2facingleft
			end

			local recordslot = recording[recording.recordingslot] -- update start/finish for visuals
			if (recordslot.p2start and interactivegui.replayeditor.editframe<recordslot.p2start) then -- plus one
				recordslot.p2start = recordslot.p2start+1
			end
			if (recordslot.p2finish and interactivegui.replayeditor.editframe<=recordslot.p2finish) then -- plus one
				recordslot.p2finish = recordslot.p2finish+1
			end

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
			interactivegui.replayeditor.editframe=interactivegui.replayeditor.editframe+1
		end
	end,
	function(but) -- clear
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local prev_p2facingleft = interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] and interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p2facingleft
			interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] = {raw={P1={}, P2={}}, p2facingleft = prev_p2facingleft}

			local recordslot = recording[recording.recordingslot]

			local temp = true -- update start/finish for visuals
			if recordslot.p2start == interactivegui.replayeditor.editframe then -- iterate forward
				for i = recordslot.p2start+1, #interactivegui.replayeditor.inputs[recording.recordingslot] do
					if orTable(interactivegui.replayeditor.inputs[recording.recordingslot][i].raw.P2) and temp then
						recordslot.p2start = i
						temp = false -- found start
					end
				end
			end
			temp = true
			if recordslot.p2finish == interactivegui.replayeditor.editframe then -- iterate backwards
				for i = recordslot.p2finish-1, 1, -1 do
					if orTable(interactivegui.replayeditor.inputs[recording.recordingslot][i].raw.P2) and temp then
						recordslot.p2finish = i
						temp = false -- found finish
					end
				end
			end

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
		end
	end,
	function(but) -- delete
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]
			if #reinputs==0 then return end -- nothing to delete

			for i=interactivegui.replayeditor.editframe,#reinputs-1 do
				-- move everything up one
				reinputs[i] = {raw={P1={}, P2={}}}
				reinputs[i].raw.P2=copytable(reinputs[i+1].raw.P2)
				reinputs[i].p2facingleft = reinputs[i+1].p2facingleft
			end

			reinputs[#reinputs] = nil -- remove one

			local recordslot = recording[recording.recordingslot]
			recordslot._stable = {} -- need to redo stables/starts&finishes
			recordslot._stable.P1 = copytable(SERIALISETABLE.P1)
			recordslot._stable.P2 = copytable(SERIALISETABLE.P2)

			local temp = true -- update start/finish for visuals
			if recordslot.p2start == interactivegui.replayeditor.editframe then -- iterate forward
				for i = recordslot.p2start+1, #interactivegui.replayeditor.inputs[recording.recordingslot] do
					if orTable(interactivegui.replayeditor.inputs[recording.recordingslot][i].raw.P2) and temp then
						recordslot.p2start = i
						temp = false -- found start
					end
				end
			elseif (recordslot.p2start and interactivegui.replayeditor.editframe<recordslot.p2start) then -- minus 1
				recordslot.p2start = recordslot.p2start-1
			end
			temp = true
			if recordslot.p2finish == interactivegui.replayeditor.editframe then -- iterate backwards
				for i = recordslot.p2finish-1, 1, -1 do
					if orTable(interactivegui.replayeditor.inputs[recording.recordingslot][i].raw.P2) and temp then
						recordslot.p2finish = i
						temp = false -- found finish
					end
				end
			elseif (recordslot.p2finish and interactivegui.replayeditor.editframe<recordslot.p2finish) then -- minus 1
				recordslot.p2finish = recordslot.p2finish-1
			end

			recordslot[#recordslot] = nil -- remove one

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
		end
	end,
	function(but) -- blank
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			if (interactivegui.replayeditor.editframe==#interactivegui.replayeditor.inputs[recording.recordingslot]+1) then
				local prev_p2facingleft = interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe-1] and interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe-1].p2facingleft
				interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] = {raw={P1={}, P2={}}, p2facingleft = prev_p2facingleft}
			else
				local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]
				for i=#reinputs,interactivegui.replayeditor.editframe,-1 do
					-- move everything down one
					reinputs[i+1] = {raw={P1={}, P2={}}}
					reinputs[i+1].raw.P2=copytable(reinputs[i].raw.P2)
				end
				local prev_p2facingleft = interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] and interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p2facingleft
				reinputs[interactivegui.replayeditor.editframe+1] = {raw={P1={}, P2={}}, p2facingleft = prev_p2facingleft}
			end

			local recordslot = recording[recording.recordingslot] -- update for visuals
			if (recordslot.p2start and interactivegui.replayeditor.editframe<recordslot.p2start) then -- plus one
				recordslot.p2start = recordslot.p2start+1
			end
			if (recordslot.p2finish and interactivegui.replayeditor.editframe<recordslot.p2finish) then -- plus one
				recordslot.p2finish = recordslot.p2finish+1
			end

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
		end
	end,
	function(but) -- dec slot
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local slot = getConfigValue("recordingslot")
			if slot <= 1 then
				changeConfig("recordingslot", REPLAY_SLOTS_COUNT)
			else
				changeConfig("recordingslot", slot-1)
			end
		end
	end,
	function(but) -- inc slot
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local slot = getConfigValue("recordingslot")
			if slot >= REPLAY_SLOTS_COUNT then
				changeConfig("recordingslot", 1)
			else
				changeConfig("recordingslot", slot+1)
			end
		end
	end,
	function(but) -- swap directions
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then -- invert direction
			if not interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] then return end -- bad input
			interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p2facingleft = not interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p2facingleft

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
		end
	end,
	back = function(but) -- return to main menu
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			toggleInteractiveGUI(true, {})
		end
	end,
	coin = function()
		if guiinputs.P1.coin and not guiinputs.P1.previousinputs.coin then
			interactivegui.replayeditor.framestart = nil -- disable timer
		end
	end,
	more = function(but)
		if interactivegui.replayeditor.framestart then return end
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
	end,
	other = function()
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1.upframecount ~= 0 then interactivegui.replayeditor.editframe=interactivegui.replayeditor.editframe-hudworkingframes(guiinputs.P1.upframecount) end
		if guiinputs.P1.downframecount ~= 0 then interactivegui.replayeditor.editframe=interactivegui.replayeditor.editframe+hudworkingframes(guiinputs.P1.downframecount) end
	end,
	name = "drawReplayEditorFuncs",
}

local function drawReplayEditor()
	if not interactivegui.replayeditor.enabled then return end
	local length = SERIALISETABLE.P1.len-1 -- don't want to include start or coin
	local recordslot = recording[recording.recordingslot]
	local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]

	--use these to control how a grid is drawn, boxes are 16x16
	local x,y = interactivegui.sw/2 - (length)*8,1
	local frames = math.floor((interactivegui.sh-27-y)/16)-1 -- Tooltips are 27px high, avoid drawing under them

	helpElements.buttons = {
		{name="SET"},
		{name="COPY"},
		{name="CLR"},
		{name="DEL"},
		{name="BLNK"},
		{name="<NUM"},
		{name="NUM>"},
		{name="SWP"},
		funcs = drawReplayEditorFuncs
	}

	-- draw in frame numbers
	if not interactivegui.replayeditor.editframe or interactivegui.replayeditor.editframe<1 then interactivegui.replayeditor.editframe = 1 end -- failsafe
	local startframe = interactivegui.replayeditor.editframe -- first frame to draw
	startframe = startframe-math.floor(frames/2)
	if not reinputs[startframe+frames] then startframe = #reinputs-frames+2 end -- display only one frame out of bounds
	if startframe<1 then startframe = 1 end -- failsafe
	if interactivegui.replayeditor.editframe>=#reinputs+1 then interactivegui.replayeditor.editframe = #reinputs+1 end -- keep selection in bounds
	for i = 1, frames do
		if startframe+i-1 == interactivegui.replayeditor.editframe then
			gui.box(x, y+16*i, x+length*16, y+16*(i+1), "gray") -- highlight selected
		end
		if startframe+i-1 == recordslot.p2start or startframe+i-1 == recordslot.p2finish then -- start or end of inputs
			gui.box(x, y+16*i, x+16, y+16*(i+1), "green")
		end
		gui.text(x + 16 - #tostring(startframe+i-1)*LETTER_WIDTH, y+6+16*i, tostring(startframe+i-1))
	end

	-- draw grid
	gui.box(x,y,x+length*16,y+16, "blue") -- blue background
	gui.line(x,y,x+length*16,y) -- top line of top
	gui.line(x,y+16,x+length*16,y+16) -- underline of top
	gui.line(x,y,x,y+16+16*frames) -- first vertical line
	gui.line(x+length*16,y,x+length*16,y+16+16*frames) -- last vertical line
	gui.text(x+1,y+1,"SLOT")
	gui.text(x+7,y+8,recording.recordingslot)
	for i = 1,length-1 do
		gui.line(x+i*16,y,x+i*16,y+16+16*frames) -- vertical lines
		gui.gdoverlay(x+i*16, y, icons[16][i])
	end
	for i = 1, frames do -- should be the length of frames shown
		gui.line(x,y+16+i*16,x+length*16,y+16+i*16) -- horizontal lines
	end

	if startframe+frames>#reinputs+1 then -- make sure end of replay is on screen
		gui.line(x,y+32+(#reinputs-startframe)*16,x+length*16,y+32+(#reinputs-startframe)*16,"red") -- red line marking end of replay
	end

	gui.box(x,y+16+frames*16,x+16,y+32+frames*16, "blue") -- draw box with the number of inputs
	gui.box(x,y+16+frames*16,x+16,y+32+frames*16)
	gui.text(x+7-(#tostring(#reinputs)-1)*2,y+22+frames*16,#reinputs,"red")

	gui.box(x+length*16-16,y+16+frames*16,x+length*16,y+32+frames*16, "blue") -- draw box with the orientation of the input
	gui.box(x+length*16-16,y+16+frames*16,x+length*16,y+32+frames*16)
	if reinputs[interactivegui.replayeditor.editframe] and reinputs[interactivegui.replayeditor.editframe].p2facingleft == true then
		gui.text(x+length*16-9,y+22+frames*16,"L", "red")
	elseif reinputs[interactivegui.replayeditor.editframe] and reinputs[interactivegui.replayeditor.editframe].p2facingleft == false then
		gui.text(x+length*16-9,y+22+frames*16,"R", "red")
	else
		gui.text(x+length*16-13,y+22+frames*16,"N/A")
	end

	--deserialise and images
	--make sure that it does need to display images
	if not reinputs or not reinputs[1] then return end
	if not recordslot or not recordslot._stable or not reinputs[1].raw.P2 then return end

	for i = 1, frames do
		if not reinputs[startframe+i-1] then break end
		for j,v in pairs(reinputs[startframe+i-1].raw.P2) do
			if v and recordslot._stable.P2[j] and j~="Coin" then
				gui.gdoverlay(x+16*gamevars.constants.translationtable[j],y+16*i,icons[16][gamevars.constants.translationtable[j]])
			end
		end
	end
end

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

function setRegisters() -- pre-calc stuff
	checkGameFunctions()
	reloadGUIPages()

	if gamefunctions.playertwofacingleft then
		setConfigDefault("recordingautoturn", true)
		resetConfig("recordingautoturn", true)
		config.changed = nil
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

	registers.interactiveguiregister = {drawTextItem}
	registers.registerafter = {}

	if gamefunctions.run then
		table.insert(registers.interactiveguiregister, Run)
	else
		write "Nothing running every frame from memory file"
	end

	local str = ""

	if gamefunctions.readplayeronehealth then
		table.insert(HUDElements, {
			name = "p1health",
			x = function(n) if n then changeConfig("p1healthx", n) end return hud.health.P1.x end,
			y = function(n) if n then changeConfig("p1healthy", n) end return hud.health.P1.y end,
			enabled = function(n) if n~=nil then changeConfig("p1healthenabled", n) end return hud.health.P1.enabled end,
			reset = function() resetConfig("p1healthx") resetConfig("p1healthy") resetConfig("p1healthenabled") end,
			draw = function() gui.text(hud.health.P1.x, hud.health.P1.y, gamevars.P1.health, hud.health.P1.textcolour) end
		})
		if gamefunctions.playeroneinhitstun then
			table.insert(registers.interactiveguiregister, function() comboHandler("P1") end)
		else
			write "player one hitstun not set, can't do combos.\n"
		end
	else
		write "player one health read not set, can't do combos.\n"
	end

	if gamefunctions.readplayertwohealth then
		table.insert(HUDElements, {
			name = "p2health",
			x = function(n) if n then changeConfig("p2healthx", n) end return hud.health.P2.x end,
			y = function(n) if n then changeConfig("p2healthy", n) end return hud.health.P2.y end,
			enabled = function(n) if n~=nil then changeConfig("p2healthenabled", n) end return hud.health.P2.enabled end,
			reset = function() resetConfig("p2healthx") resetConfig("p2healthy") resetConfig("p2healthenabled") end,
			draw = function() gui.text(hud.health.P2.x, hud.health.P2.y, gamevars.P2.health, hud.health.P2.textcolour) end
		})
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
		table.insert(HUDElements, {
			name = "combocounter",
			x = function(n) if n then changeConfig("combotextx", n) end return hud.combotext.x end,
			y = function(n) if n then changeConfig("combotexty", n, hud) end return hud.combotext.y end,
			enabled = function(n) if n~=nil then changeConfig("combotextenabled", n) end return hud.combotext.enabled end,
			reset = function() resetConfig("combotextx") resetConfig("combotexty") resetConfig("combotextenabled") end,
			draw = drawcomboHUD
		})
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
		table.insert(HUDElements, {
			name = "p1meter",
			x = function(n) if n then changeConfig("p1meterx", n) end return hud.meter.P1.x end,
			y = function(n) if n then changeConfig("p1metery", n) end return hud.meter.P1.y end,
			enabled = function(n) if n~=nil then changeConfig("p1meterenabled", n) end return hud.meter.P1.enabled end,
			reset = function() resetConfig("p1meterx") resetConfig("p1metery") resetConfig("p1meterenabled") end,
			draw = function() gui.text(hud.meter.P1.x, hud.meter.P1.y, gamevars.P1.meter, hud.meter.P1.textcolour) end
		})
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
		table.insert(HUDElements, {
			name = "p2meter",
			x = function(n) if n then changeConfig("p2meterx", n) end return hud.meter.P2.x end,
			y = function(n) if n then changeConfig("p2metery", n) end return hud.meter.P2.y end,
			enabled = function(n) if n~=nil then changeConfig("p2meterenabled", n) end return hud.meter.P2.enabled end,
			reset = function() resetConfig("p2meterx") resetConfig("p2metery") resetConfig("p2meterenabled") end,
			draw = function() gui.text(hud.meter.P2.x, hud.meter.P2.y, gamevars.P1.meter, hud.meter.P2.textcolour) end
		})
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
	table.insert(registers.interactiveguiregister, buttonHandler)

	if gamevars.constants.translationtable then
		table.insert(registers.interactiveguiregister, drawHelp)
		table.insert(registers.registerbefore, readGUIInputs)
		table.insert(registers.interactiveguiregister, processGUIInputs)
		table.insert(registers.interactiveguiregister, moveHUDInteract)
	else
		write "No translation table found, can't read or process inputs from controller, or show input help, use lua hotkeys"
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
	table.insert(HUDElements, {
		name = "kb",
		x = function(n) if n then changeConfig("kbx", n) end return hud.kb.x end,
		y = function(n) if n then changeConfig("kby", n) end return hud.kb.y end,
		enabled = function(n) if n~=nil then changeConfig("kbenabled", n) end return hud.kb.enabled end,
		reset = function() resetConfig("kbx") resetConfig("kby") resetConfig("kbenabled") end,
		draw = function() drawKB(hud.kb.x, hud.kb.y) end
	})

	if scrollingInputReg then -- if scrolling-input-display.lua is loaded
		local scroll = inputs.properties.scrollinginput -- keep it short
		table.insert(HUDElements, {
			name = "p1scrollinginput",
			x = function(n) if n then changeConfig("scrollinginputxp1", n) end return inputs.properties.scrolling.P1.x end,
			y = function(n) if n then changeConfig("scrollinginputyp1", n) end return inputs.properties.scrolling.P1.y end,
			enabled = function(n) if n~=nil then changeConfig("scrollinginputenabledp1", n) end togglescrollinginputsplayer() return inputs.properties.scrolling.P1.enabled end,
			reset = function() resetConfig("scrollinginputxp1") resetConfig("scrollinginputyp1") resetConfig("scrollinginputenabledp1") resetConfig("scrollinginputframes") end,
			draw = function() end, -- handled by scrolling-input-display.lua
			movehud = { -- extra functions for scrolling input
				{name="NUMS",func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then changeConfig("scrollinginputframes", not getConfigValue("scrollinginputframes")) end end}, -- toggle numbers
				{name="INC", func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then if inputs.properties.scrolling.iconsize<16 then changeConfig("scrollinginputiconsize", inputs.properties.scrolling.iconsize+1) scrollingInputReload() end end end}, -- increase size of text (prone to crashing)
				{name="DEC", func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then if inputs.properties.scrolling.iconsize>8  then changeConfig("scrollinginputiconsize", inputs.properties.scrolling.iconsize-1) scrollingInputReload() end end end}, -- increase size of text (prone to crashing)
			}
		})
		table.insert(HUDElements, {
			name = "p2scrollinginput",
			x = function(n) if n then changeConfig("scrollinginputxp2", n) end return inputs.properties.scrolling.P2.x end,
			y = function(n) if n then changeConfig("scrollinginputyp2", n) end return inputs.properties.scrolling.P2.y end,
			enabled = function(n) if n~=nil then changeConfig("scrollinginputenabledp2", n) end togglescrollinginputsplayer() return inputs.properties.scrolling.P2.enabled end,
			reset = function() resetConfig("scrollinginputxp2") resetConfig("scrollinginputyp2") resetConfig("scrollinginputenabledp2") resetConfig("scrollinginputframes") end,
			draw = function() end, -- handled by scrolling-input-display.lua
			movehud = { -- extra functions for scrolling input
				{name="NUMS",func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then changeConfig("scrollinginputframes", not getConfigValue("scrollinginputframes")) end end}, -- toggle numbers
				{name="INC", func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then if inputs.properties.scrolling.iconsize<16 then changeConfig("scrollinginputiconsize", inputs.properties.scrolling.iconsize+1) scrollingInputReload() end end end}, -- increase size of text (prone to crashing)
				{name="DEC", func = function(but) if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then if inputs.properties.scrolling.iconsize>8  then changeConfig("scrollinginputiconsize", inputs.properties.scrolling.iconsize-1) scrollingInputReload() end end end}, -- increase size of text (prone to crashing)
			}
		})
	end

	if inputDisplayReg then -- simple inputs
		local simple = inputs.properties.simpleinput -- keep it short
		table.insert(HUDElements, {
			name = "p1simpleinput",
			x = function(n) if n then changeConfig("simpleinputxp1", n) end return inputs.properties.simple.P1.x end,
			y = function(n) if n then changeConfig("simpleinputyp1", n) end return inputs.properties.simple.P1.y end,
			enabled = function(n) if n~=nil then changeConfig("simpleinputenabledp1", n) end return inputs.properties.simple.P1.enabled end,
			reset = function() resetConfig("simpleinputxp1") resetConfig("simpleinputyp1") resetConfig("simpleinputenabledp1") end,
			draw = function() end -- handled by input-display.lua
		})
		table.insert(HUDElements, {
			name = "p2simpleinput",
			x = function(n) if n then changeConfig("simpleinputxp2", n) end return inputs.properties.simple.P2.x end,
			y = function(n) if n then changeConfig("simpleinputyp2", n) end return inputs.properties.simple.P2.y end,
			enabled = function(n) if n~=nil then changeConfig("simpleinputenabledp2", n) end return inputs.properties.simple.P2.enabled end,
			reset = function() resetConfig("simpleinputxp2") resetConfig("simpleinputyp2") resetConfig("simpleinputenabledp2") end,
			draw = function() end -- handled by input-display.lua
		})
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
			removeDefaultConfigValues()
			trimConfigTable(config)
			trimConfigTable(generalconfig)
			trimConfigTable(colourconfig)
			saveGameConfigValues()
			saveGeneralConfigValues()
			saveColourConfigValues()
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

setRegisters()

----------------------------------------------
-- ADDONS
----------------------------------------------

-- global addons
dofile("addon/addons.lua")
if DEBUG then
	for _, v in pairs(DEBUG_addons_run) do
		if fexists("addon/"..v) then
			dofile("addon/"..v)
		end
	end
else
	for _, v in pairs(addons_run) do
		if fexists("addon/"..v) then
			dofile("addon/"..v)
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
