assert(rb,"Run fbneo-training-mode.lua")

--[[
Scrolling input display Lua script
requires the Lua gd library (http://luaforge.net/projects/lua-gd/)
written by Dammit (dammit9x at hotmail dot com)

Works with MAME, FBA, pcsx, snes9x and Gens:
http://code.google.com/p/mame-rr/downloads/list
http://code.google.com/p/fbarr/downloads/list
http://code.google.com/p/pcsxrr/downloads/list
http://code.google.com/p/snes9x-rr/downloads/list
http://code.google.com/p/gens-rerecording/downloads/list
]]

version      = "11/10/2010"

function toggleshowframes()
	margin_top = 16 - inputs.properties.scrollinginput.iconsize
	if inputs.properties.scrollinginput.frames then
		margin_left  = 0.4    --space from the left of the screen, in tiles, for player 1
		margin_right = 7      --space from the right of the screen, in tiles, for player 2
	else
		margin_left  = 1      --space from the left of the screen, in tiles, for player 1
		margin_right = 3      --space from the right of the screen, in tiles, for player 2
	end
end
toggleshowframes()

buffersize   = 13     --how many lines to show
timeout      = 240    --how many idle frames until old lines are cleared on the next input
screenwidth  = 256    --pixel width of the screen for spacing calculations (only applies if emu.screenwidth() is unavailable)

--Key bindings below only apply if the emulator does not support Lua hotkeys.
playerswitch = "Q"         --key pressed to toggle players on/off
clearkey     = "tilde"     --key pressed to clear screen
sizekey      = "semicolon" --key pressed to change icon size
scalekey     = "quote"     --key pressed to toggle icon stretching
recordkey    = "numpad/"   --key pressed to start/stop recording video

----------------------------------------------------------------------------------------------------

gamekeys = {
	{ set =
		{ "capcom",   snes9x,    gens,       pcsx,            fba,       mame },
		{      "l",   "left",  "left",     "left",         "Left",     "Left" },
		{      "r",  "right", "right",    "right",        "Right",    "Right" },
		{      "u",     "up",    "up",       "up",           "Up",       "Up" },
		{      "d",   "down",  "down",     "down",         "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{     "LP",      "Y",     "X",   "square",   "Weak Punch", "Button 1" },
		{     "MP",      "X",     "Y", "triangle", "Medium Punch", "Button 2" },
		{     "HP",      "L",     "Z",       "r1", "Strong Punch", "Button 3" },
		{     "LK",      "B",     "A",        "x",    "Weak Kick", "Button 4" },
		{     "MK",      "A",     "B",   "circle",  "Medium Kick", "Button 5" },
		{     "HK",      "R",     "C",       "r2",  "Strong Kick", "Button 6" },
		{      "S", "select",  "none",    "start",        "Start",    "Start" },
	},
	{ set =
		{ "jojos",   snes9x,    gens,       pcsx,            fba,       mame },
		{      "l",   "left",  "left",     "left",         "Left",     "Left" },
		{      "r",  "right", "right",    "right",        "Right",    "Right" },
		{      "u",     "up",    "up",       "up",           "Up",       "Up" },
		{      "d",   "down",  "down",     "down",         "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{     "A",      "Y",     "X",   "square",   "Weak Attack", "Button 1" },
		{     "B",      "X",     "Y", "triangle", "Medium Attack", "Button 2" },
		{     "C",      "L",     "Z",       "r1", "Strong Attack", "Button 3" },
		{     "S",      "B",     "A",        "x",    "Stand", "Button 4" },
		{      "S", "select",  "none",    "start",        "Start",    "Start" },
	},
	{ set =
		{ "cybots",   snes9x,    gens,       pcsx,            fba,       mame },
		{      "l",   "left",  "left",     "left",         "Left",     "Left" },
		{      "r",  "right", "right",    "right",        "Right",    "Right" },
		{      "u",     "up",    "up",       "up",           "Up",       "Up" },
		{      "d",   "down",  "down",     "down",         "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{     "L",      "Y",     "X",   "square",   "Low Attack", "Button 1" },
		{     "H",      "X",     "Y", "triangle", "High Attack", "Button 2" },
		{     "B",      "L",     "Z",       "r1", "Boost", "Button 3" },
		{     "W",      "B",     "A",        "x",    "Weapon", "Button 4" },
		{     "S", "select",  "none",    "start",        "Start",    "Start" },
	},
	{ set =
		{ "sgemf",   snes9x,    gens,       pcsx,            fba,       mame },
		{      "l",   "left",  "left",     "left",         "Left",     "Left" },
		{      "r",  "right", "right",    "right",        "Right",    "Right" },
		{      "u",     "up",    "up",       "up",           "Up",       "Up" },
		{      "d",   "down",  "down",     "down",         "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{     "P",      "Y",     "X",   "square",   "Punch", "Button 1" },
		{     "K",      "X",     "Y", "triangle", "Kick", "Button 2" },
		{     "S",      "B",     "A",        "x",    "Special", "Button 4" },
		{      "S", "select",  "none",    "start",        "Start",    "Start" },
	},
	{ set =
		{ "neogeo",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "A",   "square", "Button A", "Button 1" },
		{      "B", "triangle", "Button B", "Button 2" },
		{      "C",        "x", "Button C", "Button 3" },
		{      "D",   "circle", "Button D", "Button 4" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "kaneko",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "LP",   "square", "Button 1", "Button 1" },
		{      "HP", "triangle", "Button 2", "Button 2" },
		{      "LK",        "x", "Button 3", "Button 3" },
		{      "HK",   "circle", "Button 4", "Button 4" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "martmast",    pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "LP",   "square", "Button 1", "Button 1" },
		{      "LK",        "x", "Button 2", "Button 2" },
		{      "HP", "triangle", "Button 3", "Button 3" },
		{      "HK",   "circle", "Button 4", "Button 4" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "psikyo",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "LP",   "square", "Button 1", "Button 1" },
		{      "HP", "triangle", "Button 2", "Button 2" },
		{      "LK",        "x", "Button 3", "Button 3" },
		{      "HK",   "circle", "Button 4", "Button 4" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "mwarr",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "A",   "square", "Button 1", "Button 1" },
		{      "B", "triangle", "Button 2", "Button 2" },
		{      "C",        "x", "Button 3", "Button 3" },
		{      "D",   "circle", "Button 4", "Button 4" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "banpresto",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "A",   "square", "Button 1", "Button 1" },
		{      "B", "triangle", "Button 2", "Button 2" },
		{      "C",        "x", "Button 3", "Button 3" },
		{      "D",   "circle", "Button 4", "Button 4" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "taito",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "1",   "square", "Fire 1", "Button 1" },
		{      "2", "triangle", "Fire 2", "Button 2" },
		{      "3",        "x", "Fire 3", "Button 3" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "tekken",       pcsx,       mame },
		{      "l",     "left",     "Left" },
		{      "r",    "right",    "Right" },
		{      "u",       "up",       "Up" },
		{      "d",     "down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "1",   "square", "Button 1" },
		{      "2", "triangle", "Button 2" },
		{      "T",        nil, "Button 3" },
		{      "3",        "x", "Button 4" },
		{      "4",   "circle", "Button 5" },
		{      "S",    "start",    "Start" },
	},
	{ set =
		{ "asurabus",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "A",   "square", "Button 1", "Button 1" },
		{      "B", "triangle", "Button 2", "Button 2" },
		{      "C",        "x", "Button 3", "Button 3" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "slammast",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "Attack",   "Attack", "Attack", "Attack" },
		{      "Jump", "Jump", "Jump", "Jump" },
		{      "Pin",        "Pin", "Pin", "Pin" },
		{      "C",    "coin",    "Coin",    "Coin" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "ringdest",       pcsx,        fba,       mame },
		{      "l",     "left",     "Left",     "Left" },
		{      "r",    "right",    "Right",    "Right" },
		{      "u",       "up",       "Up",       "Up" },
		{      "d",     "down",     "Down",     "Down" },
		{     "ul"},
		{     "ur"},
		{     "dl"},
		{     "dr"},
		{      "Hold",   "square", "Hold", "Button 1" },
		{      "Weak punch", "triangle", "Weak punch", "Button 2" },
		{      "Strong punch",        "x", "Strong punch", "Button 3" },
		{      "Button 4",    "Button 4",    "Button 4",    "Button 4" },
		{      "Weak kick",    "Weak kick",    "Weak kick",    "Weak kick" },
		{      "Strong kick",    "Strong kick",    "Strong kick",    "Strong kick" },
		{      "C",        "coin", "Coin", "Coin" },
		{      "S",    "start",    "Start",    "Start" },
	},
	{ set =
		{ "midway",     fba,       mame    },
		{      "l",    "Left",     "Left"  },
		{      "r",    "Right",    "Right" },
		{      "u",    "Up",       "Up"    },
		{      "d",    "Down",     "Down"  },
		{     "ul"                         },
		{     "ur"                         },
		{     "dl"                         },
		{     "dr"                         },
		{      "1",    "Low Punch",  "Button 4" },
		{      "2",    "High Punch", "Button 1" },
		{     "BL",    "Block",  	 "Button 2" },
		{      "3",    "Low Kick",   "Button 5" },
		{      "4",    "High Kick",  "Button 3" },
		{     "RN",    "Run",        "Button 6" },
		{      "S",    "Start",      "Start" },
	},
}

--folder with scrolling-input-code.lua, icon files, & frame dump folder (relative to this lua file)
resourcepath = "inputs\\scrolling-input"

dofile(resourcepath .. "\\scrolling-input-code.lua")
