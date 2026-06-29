assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x79 -- +1 to account for the magic pixel
p2maxhealth = 0x79

p1maxmeter = 0x80
p2maxmeter = 0x80

-- Some values for both players or values set at character select seem to be stored from 0x100700
local timer = 0x107490 -- this is a word, but we only need to set the upper byte
local maxtime = 0x60
local screenfreezetimer = 0x1074F2
-- Palette: P1 0x107432, P2 0x107433
-- Top Bar Position: P1 0x1074C3, P2 0x1074C5
-- Rounds Won: P1 0x107474, P2 0x107475
-- Current Match Stage: 0x10748A

local characters = { -- character ids
	[0] = "TERRY",
	[1] = "ROCK",
	[2] = "DONG",
	[3] = "JAE",
	[4] = "HOTARU",
	[5] = "GATO",
	[6] = "BJENET",
	[7] = "BUTT",
	[8] = "HOKUTOMARU",
	[9] = "FREEMAN",
	[10] = "TIZOC",
	[11] = "KEVIN",
	[12] = "GRANT",
	[13] = "KAIN"
}
local character_max_guard = { } -- hardcode this to avoid dealing with bank switching, all characters begin flashing at 0x2B00

for i = 0, 13 do
	characters[ characters[i] ] = i
	character_max_guard[i] = 0x3700 -- median
end
for _, id in ipairs({characters.HOTARU, characters.BJENET, characters.HOKUTOMARU}) do -- low guard gauge
	character_max_guard[id] = 0x3200
end
for _, id in ipairs({characters.TIZOC, characters.KEVIN, characters.GRANT, characters.KAIN}) do -- high guard gauge
	character_max_guard[id] = 0x3C00
end

local JDDisplay = { -- offset for display the JD info {standing, crouching, jumping}
	[characters.TERRY] = {95, 130, 60},
	[characters.ROCK] = {95, 130, 100},
	[characters.DONG] = {95, 130, 100},
	[characters.JAE] = {95, 130, 100},
	[characters.HOTARU] = {105, 130, 100},
	[characters.GATO] = {105, 120, 90},
	[characters.BJENET] = {95, 130, 100},
	[characters.BUTT] = {95, 120, 80},
	[characters.HOKUTOMARU] = {115, 130, 100},
	[characters.FREEMAN] = {95, 130, 80},
	[characters.TIZOC] = {75, 110, 60},
	[characters.KEVIN] = {90, 120, 80},
	[characters.GRANT] = {80, 115, 60},
	[characters.KAIN] = {85, 125, 80}
}

local P1 = {
	uid = 0x100400,
	inputs = 0x10A4D6, -- some sort of table of inputs and timers used to check if a special can be done?
	jd = 0x10AC98,
	combocounter = 0x10A39C,
	guard = 0x10ACE4
}
local P2 = {
	uid = 0x100500,
	inputs = 0x10A59E,
	jd = 0x10AD98,
	combocounter = 0x10A39D,
	guard = 0x10ADE4
}

local uidoffsets = { -- derived from memory analysis rather than disassembly, these could be inaccurate
	action = 0x00,-- long, some sort of function pointer for when players hit/are hit (0x0002F9B2 is the counterhit function), (0x0002F538 is the blockstop function) values are set at around $02EDC6
	characterid = 0x10, -- word
	playeractive = 0x12, -- cpu opponent if 3, player controller otherwise
	control = 0x13, -- 1 = p1 in control, 2 = p2 in control, 3 = keep taunting, there are more values
	playername = 0x18, -- string 8 bytes long, FIGHTER1 for P1, FIGHTER2 for P2
	xpos = 0x20, -- word
	-- 0x22, -- word, somehow tied to xpos
	-- 0x2C, -- word, mirrors xpos
	-- 0x2E, -- word, mirrors 0x22
	ypos = 0x28, -- word
	-- 0x30 -- word, ypos acceleration?
	cameraheightoffset = 0x30, -- word, affects the camera height somehow
	upwardsvelocity = 0x3C, -- long, 0x44 is the next frame's(?) velocity, and 0x48 is gravity
	direction = 0x58, -- 0x80 if facing left
	characterstate = 0x60, -- word, if the upper byte is 1 the character is being hit, if it's 2 they're being thrown
	-- 0x62, -- word, something to do with character state
	-- 0x64, -- word, something to do with character state
	characterstateframe = 0x66, -- frame of animation for the characterstate?
	-- 0x6A, -- word, something to do with animation timings?
	timertype = 0x66, -- indicates what the following two timers are tracking
	blockstuntimer = 0x68,
	hitstuntimer = 0x69, -- hitstun timer??
	animationtimer = 0x6F,
	charactersize = 0x73, -- also affects projectile size
	romanimationdata = 0x7A, -- long, pointer to some data in ROM that contains some data for current animation, gives data for 0xEA and 0xEC, indicates when moves can be counterhit
	justdefendnextattack = 0x7F, -- some sort of state byte, fourth bit is set if the next attack is to be JD'd, works even without blocking, third bit is set if your opponent just JD'd you.
	directionalinput = 0x84, -- word, relative to opponent
	standingorcrouchingcurrentattack = 0x86, -- which attack the character is doing, only tracks standing and crouching
	-- 0x87, previous frame's value of 0x86
	-- 0x88, previous frame's(?) is stored at 0x89
	attackedstate = 0x90, -- 0x0 = neutral, 0x1 = in hitstun, 0x2 = in blockstun/JDing
	-- 0x91, -- the type of the last attack received? Only on hit
	-- 0x92, -- time since last blocked or been attacked
	-- 0x94, id of last attack received on hit or block?
	-- 0x98, long, address of opponent's uid
	-- 0x9B, when the high nibble is set, the character is forced to face left
	health = 0x8E,
	currentspecialorsupermove = 0xA5, -- id(?) of the current special or super move being done, only set for the first frame of the move, then returns to 0
	-- 0xA6, more info on the special move related to 0xA5
	-- 0xA7, more info on the special move related to 0xA5
	rotorchargingstate = 0xB2, -- byte
	-- 0xB7, hitstop timer?
	attackid = 0xB8,
	meter = 0xBE,
	-- 0xC0, ??
	-- 0xC2, long, something to do with animation to play?
	-- 0xD1, something to do with counterhits?
	-- 0xD2, something to do hitstun?
	hitdata = 0xEA, -- word, used for determining function pointer for 0x0, 0x10A122 writes high byte, 0x10A127 writes low byte, if the high byte is 4 at $2EE36, counter hit
	-- 0xEC, byte, id of the move the character is being hit by?
	-- 0xEF, byte, set if the character is in blockstun/hitstun?
	rotortimer = 0xF7, -- byte, timer for hell rotor after it reaches level 2
	-- 0xF8, word set to 0x1BBB when rotor is performed
	rotorinfo = 0xFA, --byte, the level of hell rotor among other things?
}

for _, player in pairs({P1, P2}) do
	for name, offset in pairs(uidoffsets) do
		player[name] = player.uid + offset
	end
end

local characterstates = { -- corresponds with 0x60 in uidoffsets 
	standing = 0x00,
	idle = 0x01,
	forwardwalk = 0x02,
	backwalk = 0x03,
	crouching = 0x04,
	crouchidle = 0x05,
	standtocrouch = 0x06,
	crouchtostand = 0x07,
	jumpsquat = 0x08,
	jumprecovery = 0x09,
	hoprecovery = 0x0A,
	jump = 0x0B, -- used as the start of a hop too
	jumpfall = 0x0C,
	jumpforward = 0x0D, -- used as the start of a forward hop too
	jumpforwardfall = 0x0E,
	jumpback = 0x0F, -- used as the start of a back hop too
	jumpbackfall = 0x10,
	hoppeak = 0x11,
	hopfall = 0x12,
	hopforwardpeak = 0x13,
	hopforwardfall = 0x14,
	hopbackpeak = 0x15,
	hopbackfall = 0x16,
	dashstart = 0x17,
	dash = 0x18,
	dashend = 0x19,
	backdashstart = 0x1A,
	backdash = 0x1B,
	backdashend = 0x1C,
	sideswitch = 0x1D,
	closeA = 0x1F,
	closeB = 0x20,
	closeC = 0x21,
	closeD = 0x22,
	standA = 0x23,
	standB = 0x24,
	standC = 0x25,
	standD = 0x26,
	crouchA = 0x27,
	crouchB = 0x28,
	crouchC = 0x29,
	crouchD = 0x2A,
	fallingjumpA = 0x2B,
	fallingjumpB = 0x2C,
	fallingjumpC = 0x2D,
	fallingjumpD = 0x2E,
	directionaljumpA = 0x2F,
	directionaljumpB = 0x30,
	directionaljumpC = 0x31,
	directionaljumpD = 0x32,
	risingjumpA = 0x33, -- also hopAstart
	risingjumpB = 0x34, -- also hopBstart
	risingjumpC = 0x35, -- also hopCstart
	risingjumpD = 0x36, -- also hopDstart
	jumplightattackend = 0x3B,
	jumpheavyattackend = 0x3C,
	hoplightattackend = 0x3D,
	hopheavyattackend = 0x3E,
	crouchABstart = 0x3F,
	crouchAB = 0x40,
	crouchABend = 0x41,
	standABstart = 0x42,
	standAB = 0x43,
	standABend = 0x44,
	grab = 0x51,
	grabend = 0x52,
	-- specials and supers ids are character based and occupy from here
	lowfeint = 0x134,
	forwardfeint = 0x135,
	continuousstandJD = 0x140,
	standlightblockstart = 0x160,
	standlightblock = 0x161,
	standlightblockend = 0x162,
	standheavyblockstart = 0x163,
	standheavyblock = 0x164,
	standheavyblockend = 0x165,
	crouchlightblockstart = 0x166,
	crouchlightblock = 0x167,
	crouchlightblockend = 0x168,
	crouchheavyblockstart = 0x169,
	crouchheavyblock = 0x16A,
	crouchheavyblockend = 0x16B,
	--0x16C, something to do with JD
	standlightJD = 0x16D,
	standheavyJD = 0x170,
	crouchlightJD = 0x173,
	crouchheavyJD = 0x176,
	airlightJD = 0x179,
	airheavyJD = 0x17C,
	getupanimation = 0x17E,
	standguardbreaking = 0x18B,
	crouchoverheadhurt = 0x19E,
	airJDend = 0x1FE,
	lightbodyhurt = 0x196, -- there are many more hurt animations than just these for being hit by specials and supers
	heavyheadhurt = 0x197,
	lightlegshurt = 0x198,
	heavybodyhurt = 0x199,
	lightlowhurt = 0x19A,
	heavylowhurt = 0x19B,
	crouchhurt = 0x19D,
	airlighthurt = 0x1A5,
	airheavyhurt = 0x1A6,
	knockdownstart = 0x1EC,
	knockdown = 0x1EE,
	knockdownfinish = 0x1FB,
	taunt = 0x0200,
	intro = 0x0201,
	intro2 = 0x0206,
	thrown = 0x235,
	throwend = 0x2A1,
}

local attackids = {
	[characters.KEVIN] = {
		lighthellrotorlvl1 = 0x60,
		lighthellrotorlvl2 = 0x61,
		lighthellrotorlvl3 = 0x62,
		heavyhellrotorlvl1 = 0x66,
		heavyhellrotorlvl2 = 0x67,
		heavyhellrotorlvl3 = 0x68,
	}
}

--some sort of lookup table of move properties begins at 0xB6476?

-- P1/P2 inputs come in pairs(?) of word/byte, one word to indicate the state of the charge, the other byte to countdown
-- after each charge move pair is a duplicate pair?
-- where a move is in the table is move specific
-- also includes leniency timers for inputting moves

local inputsoffsets = {
	down = {
		[characters.ROCK] = { name = "Rising Tackle", offset = 0x08, timer = 0x12, leniency = 0xF },
		[characters.JAE]  = { name = "Hienzan", offset = 0x2C, timer = 0x12, leniency = 0xF },
		[characters.GATO] = { name = "Houzan Sai Heki-ga", offset = 0x24, timer = 0x12, leniency = 0xF },
		[characters.KAIN] = { name = "Schwarze Lanze", offset = 0x14, timer = 0x12, leniency = 0xB }
	},
	back = {
		[characters.KAIN] = { name = "Schwarze Flamme/Panzer", offset = 0x4, timer = 0x12, leniency = 0xB } -- the other charge move probably is 0xC, but because the charge timers are always synced we can just use this one for both.
	},
	negativeedge = { -- these come with varying levels, timer is a word instead of byte, no special input leniency
		[characters.BUTT] = {
			{ -- [C]
				{ name = "Ryuu-sen Ken Level 1", offset = 0x04, timer = 120 },
				{ name = "Ryuu-sen Ken Level 2", offset = 0x08, timer = 120 },
				{ name = "Ryuu-sen Ken Level 3", offset = 0x0C, timer = 240 },
				{ name = "Ryuu-sen Ken Level 4", offset = 0x10, timer = 480 },
			},
			{ -- [D]
				{ name = "Ko-sen Kyaku Level 1", offset = 0x14, timer = 120 },
				{ name = "Ko-sen Kyaku Level 2", offset = 0x18, timer = 120 },
				{ name = "Ko-sen Kyaku Level 3", offset = 0x1C, timer = 240 },
				{ name = "Ko-sen Kyaku Level 4", offset = 0x20, timer = 480 },
			}
		},
		[characters.KEVIN] = {
			{ -- [A]
				{ name = "Hell Rotor Level 2", offset = 0xC, timer = 9 },
				{ name = "Hell Rotor Level 3", timer = 20 }, -- this timer is stored at uidoffset 0xF7
				{ name = "Hell Rotor Level 4", timer = 32 }, -- this timer is stored at uidoffset 0xF7
			},
			{ -- [C]
				{ name = "Hell Rotor Level 2", timer = 0x10 },-- this timer is stored at uidoffset 0xF7
				{ name = "Hell Rotor Level 3", timer = 20 },
				{ name = "Hell Rotor Level 4", timer = 32 },
				
			}
		}
	}
}

local jdoffsets = {
	count = 0x00, --how many JDs were done in a row
	--0x01, --some sort of flag??
	availableindicator = 0x02, --boolean if you can JD
	blockcooldowntimer = 0x03, --timer for 4f window after blocking where the character cannot JD
	framesheldback = 0x07, --number of frames spent holding back no matter what
	lastnumberofframesheldbackbeforeblocking = 0x08, --number of frames spent holding back for the last blocked/JD'd attack
	opponentsattacksdonethisround = 0x1C, --number of attacks opponent has done this round
	lastopponentattackindicator = 0x1D, --indicator on the last attack done by opponent, 0 if it's a special, 2 if it's a light normal, 3 if it's a heavy normal???
	hasairjdthisround = 0x22, --boolean if there has been an Air JD this round
	airjdcounterthisround = 0x27, --some sort of Air JD counter, increments by 0x1E for each JD you do per round
	--0x48, --some sort of Air JD timer after Air JDing
	framesheldbackground = 0x5A, --word, number of frames spent holding back on the ground, timer for crouch and stand JD.
	framesheldbackground2 = 0x5C, --word, number of frames spent holding back on the ground, unknown timer
	framesheldbackair = 0x5E, --word, number of frames spent holding back in the air from a neutral/back jump
	framesheldbackfwdjump = 0x60, --word, number of frames spent holding back in the air from a forward jump
	leniencytimer = 0x62, --word, JD leniency timer, when this is 0 the game clears 0x5A, 0x5C, 0x5E, 0x60, when this is above 0 you can JD.
	--0x64, --word, number of attacks opponent has done this round
}

local jdleniency = {
	grounded = 7, --$21E20E
	fwdjump = 8, --$21E210
	jump = 9 --$21E212
}
local pCameraX = 0x100E20 -- word
local CameraX

local p1character, p2character

local characterwakeups = { -- animation value + timer value for each animation frame
	[characters.TERRY] = {window = 8, {0x502, 0x4},{0x503, 0x4},{0x404, 0x4},{0x405, 0x4}},
	[characters.ROCK] = {window = 8, {0x503, 0x0},{0x403, 0x1},{0x304, 0x1},{0x504, 0x0},{0x306, 0x1},{0x204, 0x1},{0x303, 0x3},{0x405, 0x0}},
	[characters.DONG] = {window = 6, {0x702, 0x2},{0x601, 0x1},{0x602, 0x2},{0x502, 0x1},{0x403, 0x1},{0x303, 0x1},{0x305, 0x1},{0x306, 0x1}},
	[characters.JAE] = {window = 6, {0x702, 0x1},{0x602, 0x1},{0x502, 0x1},{0x403, 0x2},{0x303, 0x2},{0x305, 0x2},{0x306, 0x2}},
	[characters.HOTARU] = {window = 6, {0x503, 0x1},{0x403, 0x1},{0x402, 0x2},{0x403, 0x2},{0x303, 0x2},{0x403, 0x2},{0x305, 0x1}},
	[characters.GATO] = {window = 8, {0x503, 0x4},{0x504, 0x4},{0x404, 0x4},{0x505, 0x4}},
	[characters.BJENET] = {window = 8, {0x501, 0x4},{0x402, 0x3},{0x303, 0x3},{0x304, 0x3},{0x205, 0x2}},
	[characters.BUTT] = {window = 8, {0x603, 0x3},{0x503, 0x3},{0x504, 0x3},{0x404, 0x3},{0x405, 0x3}},
	[characters.HOKUTOMARU] = {window = 8, {0x603, 0x0},{0x404, 0x1},{0x405, 0x1},{0x305, 0x1},{0x407, 0x2},{0x509, 0x1},{0x606, 0x1},{0x604, 0x1},{0x504, 0x0},{0x404, 0x0}},
	[characters.FREEMAN] = {window = 5, {0x702, 0x2},{0x602, 0x2},{0x503, 0x2},{0x404, 0x2},{0x405, 0x2},{0x306, 0x1}},
	[characters.TIZOC] = {window = 4, {0x803, 0x3},{0x705, 0x3},{0x605, 0x3},{0x707, 0x3}},
	[characters.KEVIN] = {window = 5, {0x703, 0x3},{0x604, 0x3},{0x503, 0x2},{0x504, 0x2},{0x505, 0x2}},
	[characters.GRANT] = {window = 4, {0x803, 0x3},{0x605, 0x3},{0x405, 0x3},{0x406, 0x3}},
	[characters.KAIN] = {window = 8, {0x503, 0x3},{0x403, 0x3},{0x405, 0x3}}
}

function garou_resetreversalwindow()
	local window = characterwakeups[p2character].window
	garou_setwakeupreversalwindow(window, p2character)
	return window
end

function garou_setwakeupreversalwindow(window, characterid)
	if characterid == nil then characterid = p2character end
	local character = characterwakeups[characterid]
	for i = #character, 1, -1 do -- count backwards until we find the target window
		window = window - (character[i][2]+1) -- Add 1 to account for 0
		if window <= 0 then
			character.animation = character[i][1]
			character.timer = character[i][2]+window
			break
		end
	end
end

for id = characters.TERRY, characters.KAIN do
	garou_setwakeupreversalwindow(characterwakeups[id].window, id)
end

local function newRound()
	p1character = rw(P1.characterid)
	if p1character > characters.KAIN then p1character = characters.TERRY end
	p2character = rw(P2.characterid)
	if p2character > characters.KAIN then p2character = characters.TERRY end

	garou_p1maxguard = character_max_guard[p1character]
	garou_p2maxguard = character_max_guard[p2character]
	changeConfig("garouwakeupwindow", characterwakeups[p2character].window)
	garou_setwakeupreversalwindow(characterwakeups[p2character].window)
end

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"coin",
	"start",
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button A"] = 5,
	["Button B"] = 6,
	["Button C"] = 7,
	["Button D"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotext = {
			y=40
		},
		health = {
			P1 = {
				x = 3,
				y = 16,
				enabled = false,
			},
			P2 = {
				x = 306,
				y = 16,
				enabled = false,
			}
		},
		meter = {
			P1 = {
				x = 91,
				y = 208,
				enabled = false,
			},
			P2 = {
				x = 218,
				y = 208,
				enabled = false,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth,
			maxmeter = p1maxmeter
		},
		P2 = {
			maxhealth = p2maxhealth,
			maxmeter = p2maxmeter
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = true,
			refillmeterenabled = true,
		}
	},
	inputs = {
		simple = {
			P1 = {
				x = 25,
				y = 204,
				enabled = false				
			},
			P2 = {
				x = 236,
				y = 204,
				enabled = false				
			}
		}
	}
}

local garou = {guard = {P1 = {}, P2 = {}}, charge = {P1 = {}, P2 = {}}, reversal = {}}

function playerOneFacingLeft()
	return rb(P1.direction)==0
end

function playerTwoFacingLeft()
	return rb(P2.direction)==0
end

local function playerOneInCombo()
	return rb(P2.combocounter) > 0
end

local function playerTwoInCombo()
	return rb(P1.combocounter) > 0
end

local function playerOneThrown()
	return rw(P1.characterstate) >= characterstates.thrown
end

function playerTwoThrown()
	return rw(P2.characterstate) >= characterstates.thrown
end

local function inPreguard(state)
	return state == characterstates.standlightblockstart or
	       state == characterstates.standlightblockstart or
	       state == characterstates.standheavyblockstart or
	       state == characterstates.standheavyblockend or
	       state == characterstates.crouchlightblockstart or
	       state == characterstates.crouchlightblockend or
	       state == characterstates.crouchheavyblockstart or
	       state == characterstates.crouchheavyblockend
end

local function isBlocking(state)
	return state >= characterstates.standlightblockstart and
	       state <= characterstates.crouchheavyblockend or
		   state == characterstates.standguardbreaking
end

local function isJDing(state)
	return state >= characterstates.standlightJD-1 and state <= characterstates.airheavyJD
end

local function canJD(state) -- not sure if this is every state a character can JD in
	return state <= characterstates.jumpbackfall or -- Neutral animations
		   (isBlocking(state) and state ~= characterstates.standguardbreaking) or
		   isJDing(state)
end

local prevP1InHitstun = false
local prevP2InHitstun = false

function playerOneInHitstun()
	return playerOneInCombo() or playerOneThrown() -- we also want health to refill after throwing a character
end

function playerTwoInHitstun()
	return playerTwoInCombo() or playerTwoThrown()
end

local function getHitOrBlockRemainingFrames(player)
	local timer = rdws(player.uid + 0x4C) -- the signs change depending on the direction the characters are facing? The following long is how much is subtracted each frame
	if timer == 0 then
		return 0
	else
		return rb(player.uid + 0x69)+1
	end
end

local function canHitReversal(player, inhitstun)
	return inhitstun and getHitOrBlockRemainingFrames(player) == garou.reversal.hit -- account for reversal window
end

local function canWakeupReversal(player, character)
	return rdw(player.action) == 0x00030096 and -- getting up action
	       rw(player.uid + 0x5C) == characterwakeups[character].animation and
		   rb(player.uid + 0x6F) == characterwakeups[character].timer
end

function playerOneCanHitReversal()
	return canHitReversal(P1, playerOneInHitstun()) or canWakeupReversal(P1, p1character)
end

function playerTwoCanHitReversal()
	return canHitReversal(P2, playerTwoInHitstun()) or canWakeupReversal(P2, p2character)
end

local function canBlockReversal(player)
	local state = rw(player.characterstate)
	local remainingframes = getHitOrBlockRemainingFrames(player)

	return (isBlocking(state) and remainingframes == garou.reversal.hit) or -- account for reversal window
	       (isJDing(state) and remainingframes == garou.reversal.hit)
end

function playerOneCanBlockReversal()
	return canBlockReversal(P1)
end

function playerTwoCanBlockReversal()
	return canBlockReversal(P2)
end

local prevP1IsJDing = false
local prevP2IsJDing = false

local function playerOneIsJDing()
	return isJDing(rw(P1.characterstate))
end

local function playerTwoIsJDing()
	return isJDing(rw(P2.characterstate))
end

local function inAnimation(state)
	return (state >= characterstates.closeA and state <= characterstates.throwend) and not isBlocking(state) -- I'm not sure how high command normals/specials/supers go
end

function playerOneInAnimation()
	return playerOneInHitstun() or inAnimation(rw(P1.characterstate)) or rb(P1.attackedstate) > 0
end

function playerTwoInAnimation()
	return playerTwoInHitstun() or inAnimation(rw(P2.characterstate)) or rb(P2.attackedstate) > 0
end

local stoptimers = {
	screenfreeze = 0,
	P1 = {
		tmp = 0,
		total = 0,
		finished = false,
		count = 0
	},
	P2 = {
		tmp = 0,
		total = 0,
		finished = false,
		count = 0
	}
}

local function lastStartupOffset()
	local ret = stoptimers.screenfreeze
	stoptimers.screenfreeze = 0
	return ret
end

playerOneLastStartupOffset = lastStartupOffset
playerTwoLastStartupOffset = lastStartupOffset

function playerOneLastHitstopOffset()
	return stoptimers.P2.total+stoptimers.P2.count*3
end

function playerTwoLastHitstopOffset()
	return stoptimers.P1.total+stoptimers.P1.count*3
end

function readPlayerOneHealth()
	return rb(P1.health)+1
end

function writePlayerOneHealth(health)
	wb(P1.health, health-1)
end

function readPlayerTwoHealth()
	return rb(P2.health)+1
end

function writePlayerTwoHealth(health)
	wb(P2.health, health-1)
end

function readPlayerOneMeter()
	return rb(P1.meter)
end

function writePlayerOneMeter(meter)
	wb(P1.meter, meter)
end

function readPlayerTwoMeter()
	return rb(P2.meter)
end

function writePlayerTwoMeter(meter)
	wb(P2.meter, meter)
end

function readPlayerOneXPos()
	return rw(P1.xpos) - CameraX
end

function readPlayerOneYPos()
	return rw(P1.ypos)
end

function readPlayerTwoXPos()
	return rw(P2.xpos) - CameraX
end

function readPlayerTwoYPos()
	return rw(P2.ypos)
end

local function playerControl()
	wb(P1.playeractive, 1) -- we never want a CPU to be in control
	wb(P2.playeractive, 1)
end

local function infiniteTime()
	wb(timer, maxtime-7) -- stores time in hex
end

local function maxCredits()
	ww(0x10E008, 0x0909)
end

garou_guardsettings = {
	OFF = 1,
	ALWAYS = 2,
	AFTER_COMBO = 3
}

local function handleGuard()
	local guards = {
		{
			data = garou.guard.P1,
			max = garou_p1maxguard,
			addr = P1.guard,
			prevhitstun = prevP1InHitstun,
			hitstun = playerOneInHitstun
		},
		{
			data = garou.guard.P2,
			max = garou_p2maxguard,
			addr = P2.guard,
			prevhitstun = prevP2InHitstun,
			hitstun = playerTwoInHitstun
		},
	}
	for _, guard in ipairs(guards) do
		if guard.data.state == garou_guardsettings.ALWAYS
				and (rw(guard.addr) < guard.max) then -- If we don't wait for guard to regen before setting it again, the character is stuck in a guardbreak loop
			ww(guard.addr, SHIFT(guard.data.max, -8))
		elseif guard.data.state == garou_guardsettings.AFTER_COMBO
			and guard.prevhitstun and not guard.hitstun() then
			ww(guard.addr, SHIFT(guard.data.max, -8))
		end
	end
end

local P1JDLeniency = {jdleniency.grounded} -- these need to be persistent pointers
local P2JDLeniency = {jdleniency.grounded}

local function drawJDIndicator()
	local display = getConfigValue("garoujdbarenabled")
	local GAUGE_X_SCALE = 4
	local GAUGE = {
		DISPLAY_FACTOR = 4, -- Display the bar for 2x as long as the JD window
		HALF = GAUGE_X_SCALE/2,
		FULL = GAUGE_X_SCALE,
		Y_HEIGHT = 4,
		SUCCESS_COLOUR = 0x00FF00FF,
		FAIL_COLOUR = 0xFF0000FF,
		ATTEMPT_COLOUR = 0x00FFFFFF
	}
	local players = {
		{
			character = p1character,
			xpos = readPlayerOneXPos,
			ypos = readPlayerOneYPos,
			state = P1.characterstate,
			jd = P1.jd,
			leniency = P1JDLeniency
		},
		{
			character = p2character,
			xpos = readPlayerTwoXPos,
			ypos = readPlayerTwoYPos,
			state = P2.characterstate,
			jd = P2.jd,
			leniency = P2JDLeniency
		}
	}
	for _, player in ipairs(players) do
		local characterstate = rw(player.state)
		if not canJD(characterstate) then return end
		local blockcooldowntimer = rb(player.jd + jdoffsets.blockcooldowntimer)
		local groundframes = rw(player.jd + jdoffsets.framesheldbackground)
		local jumpframes = rw(player.jd + jdoffsets.framesheldbackair)
		local fwdjumpframes = rw(player.jd + jdoffsets.framesheldbackfwdjump)
		local frames = 0
		if groundframes > 0 then -- which type of JD is being attempted?
			player.leniency[1] = jdleniency.grounded
			frames = groundframes
		elseif jumpframes > 0 then
			player.leniency[1] = jdleniency.jump
			frames = jumpframes
		elseif fwdjumpframes > 0 then
			player.leniency[1] = jdleniency.fwdjump
			frames = fwdjumpframes
		end
		local xpos = player.xpos() - player.leniency[1]*GAUGE.HALF
		local ypos = JDDisplay[player.character][1]
		if characterstate == characterstates.crouching then
			ypos = JDDisplay[player.character][2]
		elseif characterstate >= characterstates.jump and characterstate <= characterstates.jumpbackfall then
			ypos = JDDisplay[player.character][3]
		end
		ypos = ypos-player.ypos()
		local count = rb(player.jd)
		if display then
			if count > 0 then
				gui.box(xpos,ypos,xpos+player.leniency[1]*GAUGE.FULL,ypos+GAUGE.Y_HEIGHT,GAUGE.SUCCESS_COLOUR)
			elseif blockcooldowntimer > 0 then
				gui.box(xpos,ypos,xpos+blockcooldowntimer*GAUGE.FULL*2,ypos+GAUGE.Y_HEIGHT,GAUGE.FAIL_COLOUR)
			elseif frames > player.leniency[1] and frames < player.leniency[1]*GAUGE.DISPLAY_FACTOR then
				gui.box(xpos,ypos,xpos+player.leniency[1]*GAUGE.FULL,ypos+GAUGE.Y_HEIGHT,GAUGE.FAIL_COLOUR)
			elseif frames > 0 and frames <= player.leniency[1] then
				gui.box(xpos,ypos,xpos+frames*GAUGE.FULL,ypos+GAUGE.Y_HEIGHT,GAUGE.ATTEMPT_COLOUR)
			end
		end
	end
end

local function drawCharge(x, y, player, character)
	local uid, inputs, x_offset, y_offset
	if player == 1 then
		uid = P1.uid
		inputs = P1.inputs
		x_offset = getConfigValue("garouchargexp1")
		y_offset = getConfigValue("garouchargeyp1")
		character = character or p1character
	else
		uid = P2.uid
		inputs = P2.inputs
		x_offset = getConfigValue("garouchargexp2")
		y_offset = getConfigValue("garouchargeyp2")
		character = character or p2character
	end
	local ol, bg, fill, empty, base, change = 0x000000FF, 0x80808080, 0xFFF000FF, 0xFF8000FF, 0xFF0000FF, 0x003F0000
	local fulldisplay = getConfigValue("garouchargefulldisplay")
	local len = fulldisplay and 60 or 20
	local height = len/10
	
	for _, move in pairs({inputsoffsets.back[character], inputsoffsets.down[character]}) do
		if (move) then
			local timer = move.timer
			local indicator = rw(inputs + move.offset)
			local charge = rb(inputs + move.offset+2)
			if fulldisplay then
				local name = move.name.." ("..timer.."f)"
				gui.text(x_offset+2,y_offset,name)
				y_offset = y_offset + LETTER_HEIGHT
			end
			gui.box(x_offset,y_offset,x_offset+len,y_offset+height,bg,ol)
			if indicator == 1 then -- 0 = nothing, 1 = charging, 2 = special input buffer timer
				local x_len = math.floor(((timer-charge)*(len-2))/timer)
				gui.box(x_offset+1,y_offset+1,x_offset+1+x_len,y_offset+height-1,fill)
			elseif indicator == 2 then
				local x_len = math.floor((charge*(len-2))/move.leniency)
				gui.box(x_offset+1,y_offset+1,x_offset+1+x_len,y_offset+height-1,empty)
			end
			y_offset = y_offset + height+2 -- accommodate for Kain
		end
	end
	-- negative edge moves
	if character == characters.BUTT then
		for _, move in ipairs(inputsoffsets.negativeedge[character]) do
			local level = 1
			local charge
			for i = 1, #move do -- check what our level is, iterate through the timers until we find the lowest level active one
				local offset = inputs + move[i].offset
				charge = rw(offset+2)
				if rw(offset) == 0 or charge > 0 then break end
				level = level + 1
			end
			if level > #move then
				level = #move
			end
			local timer = move[level].timer
			if fulldisplay then
				local name = move[level].name.." ("..timer.."f)"
				gui.text(x_offset+2,y_offset,name)
				y_offset = y_offset + LETTER_HEIGHT
			end
			gui.box(x_offset,y_offset,x_offset+len,y_offset+height,bg,ol)
			if charge > 0 or level > 1 then
				local x_len = math.floor(((timer-charge)*(len-2))/timer)
				gui.box(x_offset+1,y_offset+1,x_offset+1+x_len,y_offset+height-1,base+level*change)
			end
			y_offset = y_offset + height+2
		end
	elseif character == characters.KEVIN then -- Hell Rotor acts strangely
		local hellrotor = inputsoffsets.negativeedge[character]
		local A, C = 1, 2
		local level = 1
		local charge = 0
		local move = hellrotor[A] -- Default to A

		if rb(uid + uidoffsets.rotorchargingstate)==0x44 then -- Is Player charging Rotor?
			level = rb(uid+uidoffsets.rotorinfo)+1
		end

		if level > 1 then
			charge = rb(uid+uidoffsets.rotortimer)
		end
		local attackid = rb(uid + uidoffsets.attackid)
		if attackid == attackids[character].lighthellrotorlvl1 then
			charge = rb(inputs + move[level].offset+2) -- the rotortimer only works for C for some reason
		elseif attackid == attackids[character].heavyhellrotorlvl1 then
			charge = rb(uid+uidoffsets.rotortimer) - 0x15 -- timer starts 0x15 larger than it should for some reason
			move = hellrotor[C]
		end

		if level > #move then
			level = #move
		end
		local timer = move[level].timer
		if fulldisplay then
			local name = move[level].name.." ("..timer.."f)"
			gui.text(x_offset+2,y_offset,name)
			y_offset = y_offset + LETTER_HEIGHT
		end
		gui.box(x_offset,y_offset,x_offset+len,y_offset+height,bg,ol)
		if charge > 0 then
			local x_len = math.floor(((timer-charge)*(len-2))/timer)
			gui.box(x_offset+1,y_offset+1,x_offset+1+x_len,y_offset+height-1,fill)
		end
		y_offset = y_offset + height+2
	end
end

local function trackStopTimers()
	local players = {
		{
			timer = stoptimers.P1,
			uid = P1.uid,
			inAnimation = playerOneInAnimation
		},
		{
			timer = stoptimers.P2,
			uid = P2.uid,
			inAnimation = playerTwoInAnimation
		}
	}
	for _, player in pairs(players) do
		local timer = player.timer
		local screenfreeze = rb(screenfreezetimer)
		if player.inAnimation() then -- there's only hitstop/blockstop for P1 when interacting with P2
			if timer.finished then
				timer.total = 0
				timer.finished = false
				timer.count = 0
			end
			local state = rw(player.uid + uidoffsets.characterstate)
			if rw(player.uid + 0x4D)==0 and -- hitstop/blockstop
			   not (state >= characterstates.knockdownstart or state == characterstates.knockdownfinish) then
				local _timer = rb(player.uid + uidoffsets.hitstuntimer)
				if _timer > timer.tmp then
					timer.tmp = _timer
				end
			else -- timer over
				timer.total = timer.total + timer.tmp
				if timer.tmp > 0 then
					timer.count = timer.count + 1
				end
				timer.tmp = 0
			end
		else
			timer.finished = true
		end
		if screenfreeze > stoptimers.screenfreeze then
			stoptimers.screenfreeze = screenfreeze
		end
	end
end

local function guardCancelPlayBack()
	if garou.guardcancelslot==0 or garou.guardcancelslot>REPLAY_SLOTS_COUNT then return end
	if not prevP2IsJDing and playerTwoIsJDing() then -- just started JDing
		recording.playbackslot = garou.guardcancelslot
		togglePlayBack(true)
	end
end

function Run() -- runs every frame
	CameraX = rw(pCameraX)
	if rb(timer) == maxtime then
		newRound()
	end
	drawJDIndicator()
	infiniteTime()
	maxCredits()
	handleGuard()
	playerControl()
	trackStopTimers()
	guardCancelPlayBack()
	prevP1InHitstun = playerOneInHitstun()
	prevP2InHitstun = playerTwoInHitstun()
	prevP1IsJDing = playerOneIsJDing()
	prevP2IsJDing = playerTwoIsJDing()
end

function OnSaveStateLoad()
	newRound()
end

local CheckForCounterHitAddress = 0x0002EE36 -- I don't know if these are different in other garou versions
local CheckForJDAddress = 0x0002EBFE

if not REPLAY then
	memory.registerexec(
		CheckForCounterHitAddress,
		function()
			if getConfigValue("garouforcecounterp1") and not playerOneInCombo() then -- only the first hit should ever CH
				wb(P1.hitdata, 4) -- we only need the high byte
			end
			if getConfigValue("garouforcecounterp2") and not playerTwoInCombo() then
				wb(P2.hitdata, 4)
			end
		end
	)
	memory.registerexec(
		CheckForJDAddress,
		function()
			if getConfigValue("garouforcejdp1") and canJD(rw(P1.characterstate)) then
				wb(P1.uid+0xEA, 0x11) -- Indicate that the character is doing a heavy crouching JDing
				wb(P2.uid+0x97, 0) -- We're JDing regardless of the normal used
				ww(P1.jd+0x00, 0x1) -- Continuously JD
				wb(P1.jd+0x02, 0xFF)
			end
			if getConfigValue("garouforcejdp2") and canJD(rw(P2.characterstate)) then
				wb(P2.uid+0xEA, 0x11)
				wb(P1.uid+0x97, 0)
				ww(P2.jd+0x00, 0x1)
				wb(P2.jd+0x02, 0xFF)
			end
		end
	)
end

--[[
Besides setting up a break point, this logic works versus standing Marco to cause a CH, this can be extrapolated to the rest of the cast + crouching and jumping.
Alternatively, writing 0x0002F9B2 to uid 0x0 forces that character to be CH, but that's quite buggy
if rdw(p2uid + uidoffsets.romanimationdata) == 0x02245608 then -- Marco regular hit data
	wdw(p2uid + uidoffsets.romanimationdata, 0x02245CA8) -- Marco CH data
end
--]]

initConfigTable("garou", garou, "config")

createConfigItem("garouguardstatep1", garou_guardsettings.ALWAYS, garou.guard.P1, "state")
createConfigItem("garouguardmaxp1", 0, garou.guard.P1, "max")
createConfigItem("garouguardenabledp1", false, garou.guard.P1, "enabled") -- visibility of the HUD Element
createConfigItem("garouguardxp1", 20, garou.guard.P1, "x")
createConfigItem("garouguardyp1", 8, garou.guard.P1, "y")
createConfigItem("garouchargexp1", 25, garou.charge.P1, "x")
createConfigItem("garouchargeyp1", 60, garou.charge.P1, "y")
createConfigItem("garouchargeenabledp1", false, garou.charge.P1, "enabled")

createConfigItem("garouforcecounterp1", false, garou, "forcecounterp1")
createConfigItem("garouforcejdp1", false, garou, "forcejdp1")


createConfigItem("garouguardstatep2", garou_guardsettings.OFF, garou.guard.P2, "state")
createConfigItem("garouguardmaxp2", 0, garou.guard.P2, "max")
createConfigItem("garouguardenabledp2", true, garou.guard.P2, "enabled")
createConfigItem("garouguardxp2", 230, garou.guard.P2, "x")
createConfigItem("garouguardyp2", 8, garou.guard.P2, "y")
createConfigItem("garouchargexp2", 200, garou.charge.P2, "x")
createConfigItem("garouchargeyp2", 60, garou.charge.P2, "y")
createConfigItem("garouchargeenabledp2", false, garou.charge.P2, "enabled")

createConfigItem("garouforcecounterp2", false, garou, "forcecounterp2")
createConfigItem("garouforcejdp2", false, garou, "forcejdp2")


createConfigItem("garouguardcancelslot", 0, garou, "guardcancelslot")
createConfigItem("garouchargefulldisplay", true, garou, "chargefulldisplay")
createConfigItem("garoujdbarenabled", true, garou, "jdbarenabled")

createConfigItem("garoureversalwindow", 8, garou.reversal, "hit")
createConfigItem("garouwakeupwindow", 0, garou.reversal, "wakeup") -- 0 means use character default

createHUDElement(
	"p1guard",
	function(n)
		if n then
			changeConfig("garouguardxp1", n)
		end
		return garou.guard.P1.x
	end,
	function(n)
		if n then
			changeConfig("garouguardyp1", n)
		end
		return garou.guard.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("garouguardenabledp1", n)
		end
		return garou.guard.P1.enabled
	end,
	function()
		resetConfig("garouguardxp1")
		resetConfig("garouguardyp1")
		resetConfig("garouguardenabledp1")
	end,
	function()
		drawFillBar(
			garou.guard.P1.x,
			garou.guard.P1.y,
			rb(P1.guard), -- the srk wiki lists guard durability from 50-60, or only the high byte
			1+LETTER_WIDTH*2,
			rb(P1.guard),
			SHIFT(garou_p1maxguard, 8)
		)
	end
)

createHUDElement(
	"p2guard",
	function(n)
		if n then
			changeConfig("garouguardxp2", n)
		end
		return garou.guard.P2.x
	end,
	function(n)
		if n then
			changeConfig("garouguardyp2", n)
		end
		return garou.guard.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("garouguardenabledp2", n)
		end
		return garou.guard.P2.enabled
	end,
	function()
		resetConfig("garouguardxp2")
		resetConfig("garouguardyp2")
		resetConfig("garouguardenabledp2")
	end,
	function()
		drawFillBar(
			garou.guard.P2.x,
			garou.guard.P2.y,
			rb(P2.guard),
			1+LETTER_WIDTH*2,
			rb(P2.guard),
			SHIFT(garou_p2maxguard, 8)
		)
	end
)

createHUDElement(
	"p1charge",
	function(n)
		if n then
			changeConfig("garouchargexp1", n)
		end
		return garou.charge.P1.x
	end,
	function(n)
		if n then
			changeConfig("garouchargeyp1", n)
		end
		return garou.charge.P1.y
	end,
	function(n)
		if n~=nil then
			changeConfig("garouchargeenabledp1", n)
		end
		return garou.charge.P1.enabled
	end,
	function()
		resetConfig("garouchargexp1")
		resetConfig("garouchargeyp1")
		resetConfig("garouchargeenabledp1")
		resetConfig("garouchargerelativep1")
		resetConfig("garouchargefulldisplay")
	end,
	function()
		drawCharge(garou.charge.P1.x, garou.charge.P1.y, 1)
	end,
	function()
		drawCharge(garou.charge.P1.x, garou.charge.P1.y, 1, characters.KAIN)
	end,
	{
		{
			name="FULL",
			func = function(but)
				if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
					changeConfig("garouchargefulldisplay", not getConfigValue("garouchargefulldisplay"))
				end
			end
		}
	}
)

createHUDElement(
	"p2charge",
	function(n)
		if n then
			changeConfig("garouchargexp2", n)
		end
		return garou.charge.P2.x
	end,
	function(n)
		if n then
			changeConfig("garouchargeyp2", n)
		end
		return garou.charge.P2.y
	end,
	function(n)
		if n~=nil then
			changeConfig("garouchargeenabledp2", n)
		end
		return garou.charge.P2.enabled
	end,
	function()
		resetConfig("garouchargexp2")
		resetConfig("garouchargeyp2")
		resetConfig("garouchargeenabledp2")
		resetConfig("garouchargerelativep2")
		resetConfig("garouchargefulldisplay")
	end,
	function()
		drawCharge(garou.charge.P2.x, garou.charge.P2.y, 2)
	end,
	function()
		drawCharge(garou.charge.P2.x, garou.charge.P2.y, 2, characters.KAIN)
	end,
	{
		{
			name="FULL",
			func = function(but)
				if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
					changeConfig("garouchargefulldisplay", not getConfigValue("garouchargefulldisplay"))
				end
			end
		}
	}
)

newRound()