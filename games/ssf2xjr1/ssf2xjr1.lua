assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
-- ssf2x training mode by @pof & @asunaro
require("games/ssf2xjr1/character_specific")
require("games/ssf2xjr1/gamestate")
require("games/ssf2xjr1/constants")

-- create a custom config file for training mode
if not fexists("games/ssf2xjr1/customconfig.lua") then
	local file = io.open("games/ssf2xjr1/customconfig.lua", "w")
	file:write("customconfig = {\n\tdraw_hud = -1,\n\tautoblock_selector = -1,\n\tautoreversal_selector = -1,\n\tdizzy_selector = -1,\n\teasy_charge_moves_selector = -1,\n\tframe_advantage_selector = -1,\n\tframe_trap_selector = -1,\n\tframeskip_selector = -1,\n\tprojectile_frequence_selector = -1,\n\treversal_trigger_selector = -1,\n\troundstart_selector = -1,\n\tslowdown_selector = - 1,\n\tnomusic_selector = -1,\n\tstage_selector = -1,\n\ttech_throw_selector = -1,\n\tcrossup_display_selector = -1,\n\tsafe_jump_display_selector = -1,\n\ttick_throw_display_selector = -1,\n}")
	file:close()
end
dofile("games/ssf2xjr1/customconfig.lua")
-- create a custom config file for replay mode
local replay_config = false

if not fexists("games/ssf2xjr1/customconfig_replay.lua") then
	local file = io.open("games/ssf2xjr1/customconfig_replay.lua", "w")
	file:write("draw_hud = -1\nframe_advantage_selector = -1\nframe_trap_selector = -1\nnomusic_selector = -1\ncrossup_display_selector = -1\nsafe_jump_display_selector = -1\ntick_throw_display_selector = -1")
	file:close()
end

local function loadReplayConfig()
	if REPLAY then
		if not replay_config then
			dofile("games/ssf2xjr1/customconfig_replay.lua")
			replay_config = true
		end
	else
		if replay_config then
			draw_hud = customconfig.draw_hud
			frame_advantage_selector = customconfig.frame_advantage_selector
			frame_trap_selector = customconfig.frame_trap_selector
			nomusic_selector = customconfig.nomusic_selector
			crossup_display_selector = customconfig.crossup_display_selector
			safe_jump_display_selector = customconfig.safe_jump_display_selector
			tick_throw_display_selector = customconfig.tick_throw_display_selector
			replay_config = false
		end
	end
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
	"button5",
	"button6",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Weak Punch"] = 5,
	["Medium Punch"] = 6,
	["Strong Punch"] = 7,
	["Weak Kick"] = 8,
	["Medium Kick"] = 9,
	["Strong Kick"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotextx=174,
		combotexty=49,
		comboenabled=true,
		p1healthx=17,
		p1healthy=22,
		p1healthenabled=true,
		p2healthx=355,
		p2healthy=22,
		p2healthenabled=true,
		p1meterx=82,
		p1metery=207,
		p1meterenabled=false,
		p2meterx=294,
		p2metery=207,
		p2meterenabled=false,
	},
	inputs = {
		iconsize=8,
		framenumbersenabled=true,
		scrollinginputxoffset={2,335},
		scrollinginputyoffset={95,95},
	},
	p1 = {
		instantrefillhealth=false,
		refillhealthenabled=true,
		instantrefillmeter=true,
		refillmeterenabled=true,
	},
	p2 = {
		instantrefillhealth=false,
		refillhealthenabled=true,
		instantrefillmeter=true,
		refillmeterenabled=true,
	},
}
----------------------------
----------------------------
-- Initialization
----------------------------
----------------------------
local first_load = true
-- Initialize RNG
math.randomseed(os.time())
math.random(); math.random(); math.random()
--
gamestate.reset_player_objects()
gamestate.read_game_vars()
gamestate.update_patch()
gamestate.read_player_vars(gamestate.P1)
gamestate.read_player_vars(gamestate.P2)
gamestate.prev	  = gamestate.stock_game_vars()
gamestate.P1.prev = gamestate.stock_player_vars(gamestate.P1)
gamestate.P2.prev = gamestate.stock_player_vars(gamestate.P2)

local previous_patch  = gamestate.patched
local current_patch   = gamestate.patched
local patch_changed   = false

local function updatePatch()
	previous_patch = current_patch
	gamestate.update_patch()
	current_patch = gamestate.patched
	if previous_patch ~= current_patch then
		patch_changed = true
	end
end

local player = {
	gamestate.P1,
	gamestate.P2
}

emu.registerstart(updatePatch)
-----------------------------
-----------------------------
-- General Functions
-----------------------------
-----------------------------
-----------------------
-- Character related
-----------------------
function readCharacterName(_player_obj) -- Translate _player_obj.character into the string sequence used in character_specific.lua
	local character = _player_obj.character
	if character == Ryu then
		return "ryu"
	elseif character == Honda then
		return "ehonda"
	elseif character == Blanka then
		return "blanka"
	elseif character == Guile then
		return "guile"
	elseif character == Ken then
		return "ken"
	elseif character == Chun then
		return "chunli"
	elseif character == Zangief then
		return "zangief"
	elseif character == Dhalsim then
		return "dhalsim"
	elseif character == Dictator then
		return "dictator"
	elseif character == Sagat then
		return "sagat"
	elseif character == Boxer then
		return "boxer"
	elseif character == Claw then
		return "claw"
	elseif character == Cammy then
		return "cammy"
	elseif character == Hawk then
		return "thawk"
	elseif character == Fei then
		return "feilong"
	elseif character == Deejay then
		return "deejay"
	end
end

function printName(_player_obj)
	local character = _player_obj.character
	if character == Ryu then
		return "Ryu"
	elseif character == Honda then
		return "Honda"
	elseif character == Blanka then
		return "Blanka"
	elseif character == Guile then
		return "Guile"
	elseif character == Ken then
		return "Ken"
	elseif character == Chun then
		return "Chun-Li"
	elseif character == Zangief then
		return "Zangief"
	elseif character == Dhalsim then
		return "Dhalsim"
	elseif character == Dictator then
		return "Dictator"
	elseif character == Sagat then
		return "Sagat"
	elseif character == Boxer then
		return "Boxer"
	elseif character == Claw then
		return "Claw"
	elseif character == Cammy then
		return "Cammy"
	elseif character == Hawk then
		return "T-Hawk"
	elseif character == Fei then
		return "Fei Long"
	elseif character == Deejay then
		return "Deejay"
	end
end

function isChargeCharacter(_player_obj)
	if character_specific[readCharacterName(_player_obj)].infos.charge_character then
		return true
	else
		return false
	end
end

function isCharacterLeft(_player_obj)
	if _player_obj.id == 1 then
		return gamestate.P2.pos_x-gamestate.P1.pos_x > 0
	elseif _player_obj.id == 2 then
		return not (gamestate.P2.pos_x-gamestate.P1.pos_x > 0)
	end
end

-- used by peon --
function playerOneFacingLeft()
	return gamestate.P1.pos_x >= gamestate.P2.pos_x
end

function playerTwoFacingLeft()
	return gamestate.P1.pos_x < gamestate.P2.pos_x
end
---------------------------------

getDistanceBetweenPlayers = function()
	if playerOneFacingLeft() then
		distance = gamestate.P1.pos_x - gamestate.P2.pos_x
	else
		distance = gamestate.P2.pos_x - gamestate.P1.pos_x
	end
	return distance
end

function playerCrouching(_player_obj)
	if _player_obj.state == crouching then
		return true
	end
	if _player_obj.state == jumping or _player_obj.state == landing then
		return false
	end
	if (_player_obj.state == doing_normal_move or _player_obj.state == doing_special_move) then
		local ypos = _player_obj.pos_y
		if (ypos <= 40) then
			return bit.band(_player_obj.curr_input, 0x4) == 0x4
		end
	end
	return false
end
---------------------
-- Game related
---------------------
local function setFrameskip(status)
	if status then
		local turbo = gamestate.turbo
		if turbo == 0 then frameskip_value = 0x80
		elseif turbo == 1 then frameskip_value = 0x70
		elseif turbo == 2 then frameskip_value = 0x60
		elseif turbo == 3 then frameskip_value = 0x50
		end
		wb(addresses.global.frameskip, frameskip_value) -- frameskip enabled
	else
		wb(addresses.global.frameskip, 0xff) -- frameskip disabled
	end
end

was_frameskip = false

local function checkFrameskip()
	local x = gamestate.prev.frame_number - gamestate.frame_number
	if x % 2 == 0 then
		was_frameskip = true
	else
		was_frameskip = false
	end
end

function countFrames(event_frame_count)
	local frame_count = event_frame_count
	if gamestate.prev.frame_number == gamestate.frame_number then
		return frame_count
	end
	if was_frameskip then
		return frame_count + 2
	end
	return frame_count + 1
end

function isPressed(_player_obj, _input)
	local bitmask = 0
	if _input == "left" then
		bitmask = 0x0001
	elseif _input == "right" then
		bitmask = 0x0002
	elseif _input == "forward" then
		if _player_obj.flip_input then
			bitmask = 0x0001
		else
			bitmask = 0x0002
		end
	elseif _input == "back" then
		if _player_obj.flip_input then
			bitmask = 0x0002
		else
			bitmask = 0x0001
		end
	elseif _input == "down" then
		bitmask = 0x0004
	elseif _input == "up" then
		bitmask = 0x0008
	elseif _input == "direction" then
		bitmask = 0x000F
	elseif _input == "LP" then
		bitmask = 0x0010
	elseif _input == "MP" then
		bitmask = 0x0020
	elseif _input == "HP" then
		bitmask = 0x0040
	elseif _input == "punch" then
		bitmask = 0x00F0
	elseif _input == "LK" then
		bitmask = 0x0100
	elseif _input == "MK" then
		bitmask = 0x0200
	elseif _input == "HK" then
		bitmask = 0x0400
	elseif _input == "kick" then
		bitmask = 0x0F00
	elseif _input == "button" then
		bitmask = 0x0FF0
	end
	if _player_obj.prev.curr_input == _player_obj.prev_input then
		return bit.band(_player_obj.curr_input, bitmask) > 0
	else
		return bit.band(_player_obj.prev_input, bitmask) > 0
	end
end

function wasPressed(_player_obj, _input)
	local bitmask = 0
	if _input == "left" then
		bitmask = 0x0001
	elseif _input == "right" then
		bitmask = 0x0002
	elseif _input == "forward" then
		if _player_obj.flip_input then
			bitmask = 0x0001
		else
			bitmask = 0x0002
		end
	elseif _input == "back" then
		if _player_obj.flip_input then
			bitmask = 0x0002
		else
			bitmask = 0x0001
		end
	elseif _input == "down" then
		bitmask = 0x0004
	elseif _input == "up" then
		bitmask = 0x0008
	elseif _input == "direction" then
		bitmask = 0x000F
	elseif _input == "LP" then
		bitmask = 0x0010
	elseif _input == "MP" then
		bitmask = 0x0020
	elseif _input == "HP" then
		bitmask = 0x0040
	elseif _input == "punch" then
		bitmask = 0x00F0
	elseif _input == "LK" then
		bitmask = 0x0100
	elseif _input == "MK" then
		bitmask = 0x0200
	elseif _input == "HK" then
		bitmask = 0x0400
	elseif _input == "kick" then
		bitmask = 0x0F00
	elseif _input == "button" then
		bitmask = 0x0FF0
	end
	if _player_obj.prev.curr_input == _player_obj.prev_input then
		return bit.band(_player_obj.prev.curr_input, bitmask) > 0
	else
		return bit.band(_player_obj.prev.prev_input, bitmask) > 0
	end
end

function isPressedKKK(_player_obj)
	return isPressed(_player_obj, "LK") and isPressed(_player_obj, "MK") and isPressed(_player_obj, "HK")
end

function wasPressedKKK(_player_obj)
	return wasPressed(_player_obj, "LK") and wasPressed(_player_obj, "MK") and wasPressed(_player_obj, "HK")
end

function isPressedPPP(_player_obj)
	return isPressed(_player_obj, "LP") and isPressed(_player_obj, "MP") and isPressed(_player_obj, "HP")
end

function wasPressedPPP(_player_obj)
	return wasPressed(_player_obj, "LP") and wasPressed(_player_obj, "MP") and wasPressed(_player_obj, "HP")
end
----------------------
-- Check for changes
----------------------
function characterChanged(_player_obj)
	if _player_obj.prev.character ~= _player_obj.character then
		return true
	else
		return false
	end
end

function oldStatusChanged(_player_obj)
	if _player_obj.prev.is_old ~= _player_obj.is_old then
		return true
	else
		return false
	end

end
------------------------------------------------------------
--	 Messages -- Borrowed from sako.lua by Born2SPD
------------------------------------------------------------
-- Messages in the middle of the screen
msg1 = ""
msg2 = ""
msg3 = ""
-- Messages following the players
player_msg1 = {"",""}
player_msg2 = {"",""}
-- Messages timer
MSG_FRAMELIMIT = 600
msg_fcount = 0
player_msg1_fcount = {0,0}
player_msg2_fcount = {0,0}

function update_msg(code)
	if code == 0 then -- reset general messages
		msg1 = ""
		msg2 = ""
		msg3 = ""
		msg_fcount = 0
	elseif code == -11 then -- reset player messages
		player_msg1[1] = ""
		player_msg1_fcount[1] = 0
	elseif code == -12 then
		player_msg2[1] = ""
		player_msg2_fcount[1] = 0
	elseif code == -21 then
		player_msg1[2] = ""
		player_msg1_fcount[2] = 0
	elseif code == -22 then
		player_msg2[2] = ""
		player_msg2_fcount[2] = 0
	end
end

function reset_msg()
	update_msg(0)
end

function reset_player_msg1(player)
	if player == 1 then
		update_msg(-11)
	elseif player == 2 then
		update_msg(-21)
	end
end

function reset_player_msg2(player)
	if player == 1 then
		update_msg(-12)
	elseif player == 2 then
		update_msg(-22)
	end
end

local function get_player_msg_x(_player_obj)
	return (_player_obj.pos_x-gamestate.screen_x)-15
end

local function get_player_msg_y(_player_obj)
	local character = _player_obj.character
	local screen_y = 0
	
	if character == Boxer or character == Zangief then
		screen_y = 120
	elseif character == Claw or character == Hawk or character == Sagat then
		screen_y = 110
	elseif character == Deejay then
		screen_y = 125
	else
		screen_y = 135
	end
	return screen_y-_player_obj.pos_y
end 

local function draw_messages()
	-- General messages
	if msg_fcount >= MSG_FRAMELIMIT then
		reset_msg()
	elseif msg_fcount > 0 then
		msg_fcount = countFrames(msg_fcount)
	end
	-- P1 messages
	if player_msg1_fcount[1] >= MSG_FRAMELIMIT then
		reset_player_msg1(1)
	elseif player_msg1_fcount[1] > 0 then
		player_msg1_fcount[1] = countFrames(player_msg1_fcount[1])
	end
	if player_msg2_fcount[1] >= MSG_FRAMELIMIT then
		reset_player_msg2(1)
	elseif player_msg2_fcount[1] > 0 then
		player_msg2_fcount[1] = countFrames(player_msg2_fcount[1])
	end
	-- P2 messages
	if player_msg1_fcount[2] >= MSG_FRAMELIMIT then
		reset_player_msg1(2)
	elseif player_msg1_fcount[2] > 0 then
		player_msg1_fcount[2] = countFrames(player_msg1_fcount[2])
	end
	if player_msg2_fcount[2] >= MSG_FRAMELIMIT then
		reset_player_msg2(2)
	elseif player_msg2_fcount[2] > 0 then
		player_msg2_fcount[2] = countFrames(player_msg2_fcount[2])
	end
	-- Draw
	gui.text(92,78,msg1)
	gui.text(92,86,msg2)
	gui.text(92,94,msg3)
	gui.text(get_player_msg_x(gamestate.P1),get_player_msg_y(gamestate.P1),player_msg1[1])
	gui.text(get_player_msg_x(gamestate.P1),get_player_msg_y(gamestate.P1)+10,player_msg2[1])
	gui.text(get_player_msg_x(gamestate.P2),get_player_msg_y(gamestate.P2),player_msg1[2])
	gui.text(get_player_msg_x(gamestate.P2),get_player_msg_y(gamestate.P2)+10,player_msg2[2])
end

function str(bool)
	if bool then
		return "true"
	else
		return "false"
	end
end
------------------------------------------
------------------------------------------
-- Infinite time, infinite life etc.
------------------------------------------
------------------------------------------
trainingmaxhealth = 0x7fff
p1maxhealth = trainingmaxhealth
p2maxhealth = trainingmaxhealth
p1maxmeter = 0x30
p2maxmeter = 0x30

local p1_need_health_refill = false
local p2_need_health_refill = false
---------------------------------------
-- The following global functions
-- are used by peon training mode.
-- can't be removed
---------------------------------------
function playerOneInHitstun()
	if gamestate.P1.dizzy then
		return false
	end
	if gamestate.P1.state == being_hit then
		return true
	end
	return false
end

local p2dizzy=false -- this is needed for the combo counter to work properly
function playerTwoInHitstun()
	if gamestate.P2.dizzy then
		if p2dizzy == false then
			p2dizzy = true
			return true
		else
			return false
		end
	else
		p2dizzy = false
	end
	if gamestate.P2.state == being_hit then
		return true
	end
	return false
end

function readPlayerOneHealth()
	if not gamestate.is_in_match then return 0 end
	if REPLAY then return gamestate.P1.life end
	-- this must be life_backup (health at previous frame, otherwise breaks the combo counter)
	if p1maxhealth == trainingmaxhealth then
		return gamestate.P1.life_backup-(trainingmaxhealth-144)
	else
		return gamestate.P1.life_backup
	end
end

function readPlayerTwoHealth()
	if not gamestate.is_in_match then return 0 end
	if REPLAY then return gamestate.P2.life end
	-- this must be life_backup (health at previous frame, otherwise breaks the combo counter)
	if p2maxhealth == trainingmaxhealth then
		return gamestate.P2.life_backup-(trainingmaxhealth-144)
	else
		return gamestate.P2.life_backup
	end
end

function writePlayerOneHealth(health)
	if REPLAY then return end
	if not combovars.p1.refillhealthenabled then
		return
	end
	local refill = false
	if gamestate.P1.life < 16 then
		-- if health < 16 we refill regardless of the state to avoid round ending
		refill = true
	elseif gamestate.P1.life < 33 and gamestate.P2.prev.state ~= doing_special_move and gamestate.P1.state ~= being_hit then
		-- if health < 33 we refill even if it will cause some small glitches
		refill = true
	elseif ((gamestate.P1.life < p1maxhealth) and (gamestate.P1.state ~= being_thrown and gamestate.P1.state ~= being_hit and gamestate.P1.state ~= blocking_attempt) and (gamestate.P2.state == crouching or gamestate.P2.state == standing) and (gamestate.P2.projectile_ready)) then
		-- this only refills when p2 is idle or crouching and p1 is not blocking or after being hit/thrown
		refill = true
	end
	if refill then
		ww(gamestate.P1.addresses.life, p1maxhealth)
		ww(gamestate.P1.addresses.life_backup, p1maxhealth)
		ww(gamestate.P1.addresses.life_hud, p1maxhealth)
		p1_need_health_refill=false
	end
end

function writePlayerTwoHealth(health)
	if REPLAY then return end
	if not combovars.p2.refillhealthenabled then
		return
	end
	local refill = false
	if gamestate.P2.life < 16 then
		-- if health < 16 we refill regardless of the state to avoid round ending
		refill = true
	elseif gamestate.P2.life < 33 and gamestate.P1.prev.state ~= doing_special_move and gamestate.P2.state ~= being_hit then
		-- if health < 33 we refill regardless of the state
		refill = true
	elseif ((gamestate.P2.life < p2maxhealth) and (gamestate.P2.state ~= being_thrown and gamestate.P2.state ~= being_hit and gamestate.P2.state ~= blocking_attempt) and (gamestate.P1.state == crouching or gamestate.P1.state == standing) and (gamestate.P1.projectile_ready)) then
		-- this only refills when p1 is idle or crouching and p2 is not blocking or after being hit/thrown
		refill = true
	end
	if refill then
		ww(gamestate.P2.addresses.life, p2maxhealth)
		ww(gamestate.P2.addresses.life_backup, p2maxhealth)
		ww(gamestate.P2.addresses.life_hud, p2maxhealth)
		p2_need_health_refill=false
	end
end

function readPlayerOneMeter()
	if gamestate.curr_state == in_match then
		return gamestate.P1.special_meter
	else
		return p1maxmeter
	end
end

function readPlayerTwoMeter()
	if gamestate.curr_state == in_match then
		return gamestate.P2.special_meter
	else
		return p2maxmeter
	end
end

function writePlayerOneMeter(meter)
	if REPLAY then return end
	if gamestate.curr_state == in_match then
		wb(gamestate.P1.addresses.special_meter, meter)
	end
end

function writePlayerTwoMeter(meter)
	if REPLAY then return end
	if gamestate.curr_state == in_match then
		wb(gamestate.P2.addresses.special_meter, meter)
	end
end

------------------------
-- neverEnd()
------------------------

local infiniteTime = function()
	if REPLAY then return end
	if (gamestate.round_timer < 0x98) then
		ww(addresses.global.round_timer,0x9928)
	end
end

local neverEnd_p1 = function()
	if REPLAY then return end

	local DEBUG=false
	local p1scaledhealth = p1maxhealth

	-- no health refill
	if not combovars.p1.refillhealthenabled then
		if gamestate.P1.life > 144 and gamestate.P1.life <= trainingmaxhealth then
			p1maxhealth = 144
			ww(gamestate.P1.addresses.life, p1maxhealth)
			ww(gamestate.P1.addresses.life_backup, p1maxhealth)
			ww(gamestate.P1.addresses.life_hud, p1maxhealth)
		end
		return
	end

	if gamestate.P1.life <= 144 then
		p1maxhealth = trainingmaxhealth
		p1_need_health_refill = true
	end

	-- health always full
	if combovars.p1.instantrefillhealth then
		p1scaledhealth = gamestate.P1.life
		ww(gamestate.P1.addresses.life_hud, p1scaledhealth)
	end

	-- refill after combo, compute the scaled health value to display
	if not combovars.p1.instantrefillhealth then
		p1scaledhealth = 144-(p1maxhealth-gamestate.P1.life)
		p1limit = p1scaledhealth
		if p1scaledhealth >= 144 then
			p1scaledhealth = p1maxhealth
		end
		if (gamestate.P1.life_hud > p1scaledhealth) and gamestate.P1.life_hud < 144 then
			p1scaledhealth = gamestate.P1.life_hud
		end
		if (gamestate.P1.life_hud > p1scaledhealth) and gamestate.P1.life_hud >= p1maxhealth - 1 and p1limit > 0 then
			p1scaledhealth = 144
			if DEBUG then print("[P1] >>>>>> 144") end
		end
		if gamestate.P1.life_hud <= p1limit + 1 then
			p1scaledhealth = p1limit + 1
		end
		if p1scaledhealth <= 0 then
			p1scaledhealth = 0
		end
		if DEBUG and p1scaledhealth ~= p1maxhealth then print("[P1] SCALED: "..p1scaledhealth.." / "..gamestate.P1.life_hud.." ["..p1limit.."]") end
		ww(gamestate.P1.addresses.life_hud, p1scaledhealth)
	end

	-- refill after being thrown or hold
	if (gamestate.P1.state == standing and gamestate.P1.prev.state==standing and gamestate.P1.life < p1maxhealth) or (gamestate.P1.state == landing and gamestate.P1.prev.state == being_thrown) or (gamestate.P1.state == standing and gamestate.P1.prev.state == being_thrown) or (gamestate.P1.state == jumping and gamestate.P1.prev.state == being_hit) or (gamestate.P1.state == landing and gamestate.P1.prev.state == being_hit) then
		p1_need_health_refill=true
	end

	if p1_need_health_refill then
		writePlayerOneHealth(p1maxhealth)
	end
end

local neverEnd_p2 = function()
	if REPLAY then return end

	local DEBUG=false
	local p2scaledhealth = p2maxhealth

	-- no health refill
	if not combovars.p2.refillhealthenabled then
		if gamestate.P2.life > 144 and gamestate.P2.life <= trainingmaxhealth then
			p2maxhealth = 144
			ww(gamestate.P2.addresses.life, p2maxhealth)
			ww(gamestate.P2.addresses.life_backup, p2maxhealth)
			ww(gamestate.P2.addresses.life_hud, p2maxhealth)
		end
		return
	end

	if gamestate.P2.life <= 144 then
		p2maxhealth = trainingmaxhealth
		p2_need_health_refill = true
	end

	-- health always full
	if combovars.p2.instantrefillhealth then
		p2scaledhealth = gamestate.P2.life
		ww(gamestate.P2.addresses.life_hud, p2scaledhealth)
	end

	-- refill after combo, compute the scaled health value to display
	if not combovars.p2.instantrefillhealth then
		p2scaledhealth = 144-(p2maxhealth-gamestate.P2.life)
		p2limit = p2scaledhealth
		if p2scaledhealth >= 144 then
			p2scaledhealth = p2maxhealth
		end
		if (gamestate.P2.life_hud > p2scaledhealth) and gamestate.P2.life_hud < 144 then
			p2scaledhealth = gamestate.P2.life_hud
		end
		if (gamestate.P2.life_hud > p2scaledhealth) and gamestate.P2.life_hud >= p2maxhealth - 1 and p2limit > 0 then
			p2scaledhealth = 144
			if DEBUG then print("[P2] >>>>>> 144") end
		end
		if gamestate.P2.life_hud <= p2limit + 1 then
			p2scaledhealth = p2limit + 1
		end
		if p2scaledhealth <= 0 then
			p2scaledhealth = 0
		end
		if DEBUG and p2scaledhealth ~= p2maxhealth then print("[P2] SCALED: "..p2scaledhealth.." / "..gamestate.P2.life_hud.." ["..p2limit.."]") end
		ww(gamestate.P2.addresses.life_hud, p2scaledhealth)
	end

	-- refill after being thrown or hold
	if (gamestate.P2.state == standing and gamestate.P2.prev.state==standing and gamestate.P2.life < p2maxhealth) or (gamestate.P2.state == landing and gamestate.P2.prev.state == being_thrown) or (gamestate.P2.state == standing and gamestate.P2.prev.state == being_thrown) or (gamestate.P2.state == jumping and gamestate.P2.prev.state == being_hit) or (gamestate.P2.state == landing and gamestate.P2.prev.state == being_hit) then
		p2_need_health_refill=true
	end
	if p2_need_health_refill then
		writePlayerTwoHealth(p2maxhealth)
	end
end

local neverEnd = function()
	if REPLAY then return end
	if not gamestate.is_in_match then
		return
	end
	infiniteTime()
	neverEnd_p1()
	neverEnd_p2()
end

----------------------------------------------
----------------------------------------------
-- SSF2T_HUD - made by Pasky
----------------------------------------------
----------------------------------------------
-------------------------
-- Variables
-------------------------
local p2 = 0x000400
draw_hud = customconfig.draw_hud
---------------------------
--Miscellaneous functions
---------------------------
-- Calculate positional difference between the two dummies
local function calc_range()
	local range = 0
	if gamestate.P1.pos_x >= gamestate.P2.pos_x then
		if gamestate.P1.pos_y >= gamestate.P2.pos_y then
			range = (gamestate.P1.pos_x - gamestate.P2.pos_x) .. "/" .. (gamestate.P1.pos_y - gamestate.P2.pos_y)
		else
			range = (gamestate.P1.pos_x - gamestate.P2.pos_x) .. "/" .. (gamestate.P2.pos_y - gamestate.P1.pos_y)
		end
	else
		if gamestate.P2.pos_y >= gamestate.P1.pos_y then
			range = (gamestate.P2.pos_x - gamestate.P1.pos_x) .. "/" .. (gamestate.P2.pos_y - gamestate.P1.pos_y)
		else
			range = (gamestate.P2.pos_x - gamestate.P1.pos_x) .. "/" .. (gamestate.P1.pos_y - gamestate.P2.pos_y)
		end
	end
	return range
end

--Determines if a projectile is still in game and if one can be exectued
local function projectile_onscreen(_player_obj)
	local text
	if _player_obj.projectile_ready then
		text = "Ready"
	else
		text = "Not Ready"
	end
	return text
end

--Displays TAP level for boxer (by pof)
local function display_taplevel(player_side)
	local text
	local punch = 0
	local kick = 0
	local p_level = 0
	local k_level = 0
	if player_side == 1 then
		punch = rw(0xFF8504)
		kick = rw(0xFF8506)
	elseif player_side == 2 then
		punch = rw(0xFF8904)
		kick = rw(0xFF8906)
	end
	--print("p:"..punch.." / k:"..kick)
	if punch == 0000 then p_level = "0" end
	if punch >= 0031 then p_level = "1" end
	if punch >= 0121 then p_level = "2" end
	if punch >= 0241 then p_level = "3" end
	if punch >= 0481 then p_level = "4" end
	if punch >= 0961 then p_level = "5" end
	if punch >= 1441 then p_level = "6" end
	if punch >= 1921 then p_level = "7" end
	if punch >= 2401 then p_level = "Final" end
	if kick == 0000 then k_level = "0" end
	if kick >= 0031 then k_level = "1" end
	if kick >= 0121 then k_level = "2" end
	if kick >= 0241 then k_level = "3" end
	if kick >= 0481 then k_level = "4" end
	if kick >= 0961 then k_level = "5" end
	if kick >= 1441 then k_level = "6" end
	if kick >= 1921 then k_level = "7" end
	if kick >= 2401 then k_level = "Final" end
	text="P("..tostring(p_level)..") / K("..tostring(k_level)..")"
	return text
end

--Determines if a special cancel can be performed after a normal move has been executed
local function check_cancel(_player_obj)
	local text
	if _player_obj.cancel_ready then
		text = "Ready"
	else
		text = "Not Ready"
	end
	return text
end

--Determine the character being used and draw approriate readings
local function determine_char(_player_obj)
	local text
	if _player_obj.id == 1 then
		if gamestate.P1.character == Boxer then
			gui.text(2,65,"Buffalo Headbutt: " .. rb(0xFF850E))
			gui.text(50,56,"TAP: " .. display_taplevel(1))
			if gamestate.P1.is_old then
				gui.text(2,73,"Straight: " .. rb(0xFF84CE))
				gui.text(2,81,"Upper Dash: " .. rb(0xFF84D6))
			else
				gui.text(2,73,"Straight: " .. rb(0xFF852B))
				gui.text(2,81,"Upper Dash: " .. rb(0xFF8524))
				gui.text(83,65,"Ground Straight: ".. rb(0xFF84CE))
				gui.text(83,73,"Ground Upper: " ..rb(0xFF84D6))
				gui.text(83,81,"Crazy Buffalo: " .. rb(0xFF8522))
			end
		elseif gamestate.P1.character == Blanka then
			gui.text(2,65,"Normal Roll: " .. rb(0xFF8507))
			gui.text(2,73,"Vertical Roll: " .. rb(0xFF84FE))
			gui.text(2,81,"Rainbow Roll: " .. rb(0xFF8507))
			gui.text(80,65,"Electricity: " .. rb(0xFF84E8)%6 .. ", " .. rb(0xFF84EA)%6 .. ", " .. rb(0xFF84EC)%6) -- this way you know when you reached the 5 inputs needed
			if not gamestate.P1.is_old then
				gui.text(80,73,"Ground Shave Roll: " .. rb(0xFF850F))
			end
		elseif gamestate.P1.character == Cammy then
			gui.text(2,65,"Spin Knuckle: " .. rb(0xFF84F0))
			gui.text(2,73,"Cannon Spike: " .. rb(0xFF84E0))
			gui.text(2,81,"Spiral Arrow: ".. rb(0xFF84E4))
			if not gamestate.P1.is_old then
				gui.text(80,65,"Hooligan Combination: " .. rb(0xFF84F7))
				gui.text(80,73,"Spin Drive Smasher: " .. rb(0xFF84F4))
			end
		elseif gamestate.P1.character == Chun then
			gui.text(2,73,"Spinning Bird Kick: " .. rb(0xFF84FE))
			gui.text(2,81,"Hyakuretsu Kyaku: " .. rb(0xFF84E8)%6 .. ", " .. rb(0xFF84EA)%6 .. ", " .. rb(0xFF84EC)%6)
			if gamestate.P1.is_old then
				gui.text(2,65,"Kikouken: ".. rb(0xFF84FE))
			else
				gui.text(2,65,"Kikouken: ".. rb(0xFF84CE))
				gui.text(92,65,"Up Kicks: " .. rb(0xFF8508))
				gui.text(92,73,"Senretsu Kyaku: " .. rb(0xFF850D))
			end
		elseif gamestate.P1.character == Deejay then
			gui.text(2,65,"Air Slasher: " .. rb(0xFF84E0))
			gui.text(2,73,"Sovat Kick: " .. rb(0xFF84F4))
			if gamestate.P1.is_old then
				gui.text(2,81,"Machine Gun Upper: " .. rb(0xFF84E4))
			else
				gui.text(2,81,"Machine Gun Upper: " .. rb(0xFF84F9))
				gui.text(80,65,"Jack Knife: ".. rb(0xFF84E4))
				gui.text(80,73,"Sovat Carnival: " .. rb(0xFF84FD))
			end
		elseif gamestate.P1.character == Dhalsim then
			gui.text(2,65,"Yoga Teleport: ".. rb(0xFF84D6))
			gui.text(2,81,"Yoga Fire: " .. rb(0xFF84CE))
			if gamestate.P1.is_old then
				gui.text(2,73,"Yoga Flame: " .. rb(0xFF84D2))
			else
				gui.text(2,73,"Yoga Flame: " .. rb(0xFF84E8))
				gui.text(80,65,"Yoga Blast: " .. rb(0xFF84D2))
				gui.text(80,73,"Yoga Inferno: " .. rb(0xFF84E4))
			end
		elseif gamestate.P1.character == Honda then
			if gamestate.P1.is_old then
				gui.text(2,65,"Flying Headbutt: " .. rb(0xFF84CE))
				gui.text(2,73,"Butt Drop: " .. rb(0xFF84F8))
				gui.text(2,81,"Hundred Hands Slap: " .. rb(0xFF84E8)%6 .. ", " .. rb(0xFF84EA)%6 .. ", " .. rb(0xFF84EC)%6)
			else
				gui.text(2,65,"Flying Headbutt: " .. rb(0xFF84D6))
				gui.text(2,73,"Butt Drop: " .. rb(0xFF84DE))
				gui.text(2,81,"Hundred Hands Slap: " .. rb(0xFF8514)%6 .. ", " .. rb(0xFF8516)%6 .. ", " .. rb(0xFF8518)%6)
				gui.text(80,65,"Oichio Throw: " .. rb(0xFF84E4))
				gui.text(80,73, "Double Headbutt: " .. rb(0xFF84E2))
			end
		elseif gamestate.P1.character == Fei then
			gui.text(2,65,"Rekka: " .. rb(0xFF84DE))
			gui.text(2,73,"Rekka 2: " .. rb(0xFF84EE))
			gui.text(2,81,"Flame Kick: " .. rb(0xFF84E2))
			if not gamestate.P1.is_old then
				gui.text(80,65,"Chicken Wing: " .. rb(0xFF8502))
				gui.text(80,73,"Rekka Sinken: " .. rb(0xFF84FE))
			end
		elseif gamestate.P1.character == Guile then
			gui.text(2,65,"Sonic Boom: " .. rb(0xFF84CE))
			gui.text(2,73,"Flash Kick: " .. rb(0xFF84D4))
			if not gamestate.P1.is_old then
				gui.text(2,81,"Double Somersault: " .. rb(0xFF84E2))
			end
		elseif gamestate.P1.character == Ken then
			gui.text(2,65, "Hadouken: ".. rb(0xFF84E2))
			gui.text(2,73, "Shoryuken: " .. rb(0xFF84E6))
			gui.text(2,81, "Hurricane Kick: " .. rb(0xFF84DE))
			if not gamestate.P1.is_old then
				gui.text(42,89, "Shoryureppa: " .. rb(0xFF84EE))
				gui.text(80,65, "Crazy Kick 1: " .. rb(0xFF8534))
				gui.text(80,73, "Crazy Kick 2: " .. rb(0xFF8536))
				gui.text(80,81, "Crazy Kick 3: " .. rb(0xFF8538))
			end
		elseif gamestate.P1.character == Dictator then
			gui.text(2,65,"Scissor Kick: " .. rb(0xFF84D6))
			gui.text(2,73,"Head Stomp: ".. rb(0xFF84DF))
			gui.text(2,81,"Devil's Reverse: " .. rb(0xFF84FA))
			gui.text(80,65,"Psycho Crusher: " .. rb(0xFF84CE))
			if not gamestate.P1.is_old then
				gui.text(80,73,"Knee Press Knightmare: " .. rb(0xFF8513))
			end
		elseif gamestate.P1.character == Ryu then
			gui.text(2,65,"Hadouken: " .. rb(0xFF84E2))
			gui.text(2,73,"Shoryuken: " .. rb(0xFF84E6))
			gui.text(2,81, "Hurricane Kick: " .. rb(0xFF84DE))
			gui.text(80,65, "Red Hadouken: " .. rb(0xFF852E))
			if not gamestate.P1.is_old then
				gui.text(80,73, "Shinku Hadouken: " .. rb(0xFF84EE))
			end
		elseif gamestate.P1.character == Sagat then
			gui.text(2,65,"Tiger Shot: " .. rb(0xFF84DA))
			gui.text(2,73,"Tiger Knee: " .. rb(0xFF84D2))
			gui.text(2,81,"Tiger Uppercut: " .. rb(0xFF84CE))
			if not gamestate.P1.is_old then
				gui.text(80,65, "Tiger Genocide: " .. rb(0xFF84EC))
			end
		elseif gamestate.P1.character == Hawk then
			if gamestate.P1.is_old then
				gui.text(2,65,"Mexican Typhoon: " .. rb(0xFF84E8))
				gui.text(2,73,"Tomahawk: " .. rb(0xFF84E0))
			else
				gui.text(2,65,"Mexican Typhoon: " .. rb(0xFF84E0) .. ", " .. rb(0xFF84E1))
				gui.text(2,73,"Tomahawk: " .. rb(0xFF84DB))
				gui.text(2,81,"Double Typhoon: " .. rb(0xFF84E0) .. ", " .. rb(0xFF84ED))
			end
		elseif gamestate.P1.character == Claw then
			gui.text(2,65,"Wall Dive (Kick): " .. rb(0xFF84DA))
			gui.text(2,73,"Wall Dive (Punch): " .. rb(0xFF84DE))
			gui.text(2,81,"Crystal Flash: " .. rb(0xFF84D6))
			if not gamestate.P1.is_old then
				gui.text(2,81,"Crystal Flash: " .. rb(0xFF84D6))
				gui.text(90,65,"Flip Kick: " .. rb(0xFF84EB))
				gui.text(90,73,"Rolling Izuna Drop: " .. rb(0xFF84E7))
			end
		elseif gamestate.P1.character == Zangief then
			gui.text(2,65, "Bear Grab: " .. rb(0xFF84E9) .. ", " .. rb(0xFF84EA))
			gui.text(2,73, "Spinning Pile Driver: " .. rb(0xFF84CE) .. ", " .. rb(0xFF84CF))
			if not gamestate.P1.is_old then
				gui.text(2,81, "Banishing Flat: " .. rb(0xFF8501))
				gui.text(2,89, "Final Atomic Buster: " .. rb(0xFF84FA) .. ", " .. rb(0xFF84FB))
			end
		end
	else
		if gamestate.P2.character == Boxer then
			gui.text(227,65,"Buffalo Headbutt: " .. rb(0xFF850E+p2))
			gui.text(266,56,"TAP: " .. display_taplevel(2))
			if gamestate.P2.is_old then
				gui.text(227,73,"Straight: " .. rb(0xFF84CE+p2))
				gui.text(227,81,"Upper Dash: " .. rb(0xFF84D6+p2))
			else
				gui.text(227,73,"Straight: " .. rb(0xFF852B+p2))
				gui.text(227,81,"Upper Dash: " .. rb(0xFF8524+p2))
				gui.text(307,65,"Ground Straight: " .. rb(0xFF84CE+p2))
				gui.text(307,73,"Ground Upper: " ..rb(0xFF84D6+p2))
				gui.text(307,81,"Crazy Buffalo: " .. rb(0xFF8522+p2))
			end
		elseif gamestate.P2.character == Blanka then
			gui.text(225,65,"Normal Roll: " .. rb(0xFF8507+p2))
			gui.text(225,73,"Vertical Roll: " .. rb(0xFF84FE+p2))
			gui.text(225,81,"Rainbow Roll: " .. rb(0xFF8507+p2))
			gui.text(302,65,"Electricity: " .. rb(0xFF84E8+p2)%6 .. ", " .. rb(0xFF84EA+p2)%6 .. ", " .. rb(0xFF84EC+p2)%6)
			if not gamestate.P2.is_old then
				gui.text(302,73,"Ground Shave Roll: " .. rb(0xFF850F+p2))
			end
		elseif gamestate.P2.character == Cammy then
			gui.text(218,65,"Spin Knuckle: " .. rb(0xFF84F0+p2))
			gui.text(218,73,"Cannon Spike: " .. rb(0xFF84E0+p2))
			gui.text(218,81,"Spiral Arrow: " .. rb(0xFF84E4+p2))
			if not gamestate.P2.is_old then
				gui.text(290,65,"Hooligan Combination: " .. rb(0xFF84F7+p2))
				gui.text(290,73,"Spin Drive Smasher: " .. rb(0xFF84F4+p2))
			end
		elseif gamestate.P2.character == Chun then
			gui.text(233,73,"Spinning Bird Kick: " .. rb(0xFF84FE+p2))
			gui.text(233,81,"Hyakuretsu Kyaku: " .. rb(0xFF84E8+p2)%6 .. ", " .. rb(0xFF84EA+p2)%6 .. ", " .. rb(0xFF84EC+p2)%6)
			if gamestate.P2.is_old then
				gui.text(233,65,"Kikouken: " .. rb(0xFF84FE+p2))
			else
				gui.text(233,65,"Kikouken: " .. rb(0xFF84CE+p2))
				gui.text(313,65,"Up Kicks: " .. rb(0xFF8508+p2))
				gui.text(313,73,"Senretsu Kyaku: " .. rb(0xFF850D+p2))
			end
		elseif gamestate.P2.character == Deejay then
			gui.text(223,65,"Air Slasher: " .. rb(0xFF84E0+p2))
			gui.text(223,73,"Sovat Kick: " .. rb(0xFF84F4+p2))
			if gamestate.P2.is_old then
				gui.text(223,81,"Machine Gun Upper: " .. rb(0xFF84E4+p2))
			else
				gui.text(223,81,"Machine Gun Upper: " .. rb(0xFF84F9+p2))
				gui.text(303,65,"Jack Knife: " .. rb(0xFF84E4+p2))
				gui.text(303,73,"Sovat Carnival: " .. rb(0xFF84FD+p2))
			end
		elseif gamestate.P2.character == Dhalsim then
			gui.text(223,65,"Yoga Teleport: ".. rb(0xFF84D6+p2))
			gui.text(223,81,"Yoga Fire: " .. rb(0xFF84CE+p2))
			if gamestate.P2.is_old then
				gui.text(223,73,"Yoga Flame: " .. rb(0xFF84D2+p2))
			else
				gui.text(223,73,"Yoga Flame: " .. rb(0xFF84E8+p2))
				gui.text(303,65,"Yoga Blast: " .. rb(0xFF84D2+p2))
				gui.text(303,73,"Yoga Inferno: " .. rb(0xFF84E4+p2))
			end
		elseif gamestate.P2.character == Honda then
			if gamestate.P2.is_old then
				gui.text(223,65,"Flying Headbutt: " .. rb(0xFF84CE+p2))
				gui.text(223,73,"Butt Drop: " .. rb(0xFF84F8+p2))
				gui.text(223,81,"Hundred Hands Slap: " .. rb(0xFF84E8+p2)%6 .. ", " .. rb(0xFF84EA+p2)%6 .. ", " .. rb(0xFF84EC+p2)%6)
			else
				gui.text(223,65,"Flying Headbutt: " .. rb(0xFF84D6+p2))
				gui.text(223,73,"Butt Drop: " .. rb(0xFF84DE+p2))
				gui.text(223,81,"Hundred Hands Slap: " .. rb(0xFF8514+p2)%6 .. ", " .. rb(0xFF8516+p2)%6 .. ", " .. rb(0xFF8518+p2)%6)
				gui.text(303,65,"Oichio Throw: " .. rb(0xFF84E4+p2))
				gui.text(303,73, "Double Headbutt: " .. rb(0xFF84E2+p2))
			end
		elseif gamestate.P2.character == Fei then
			gui.text(242,65,"Rekka: " .. rb(0xFF84DE+p2))
			gui.text(242,73,"Rekka 2: "	.. rb(0xFF84EE+p2))
			gui.text(242,81,"Flame Kick: " .. rb(0xFF84E2+p2))
			if not gamestate.P2.is_old then
				gui.text(322,65, "Chicken Wing: " .. rb(0xFF8502+p2))
				gui.text(322,73, "Rekka Sinken: " .. rb(0xFF84FE+p2))
			end
		elseif gamestate.P2.character == Guile then
			gui.text(302,65,"Sonic Boom: " .. rb(0xFF84CE+p2))
			gui.text(302,73,"Flash Kick: " .. rb(0xFF84D4+p2))
			if not gamestate.P2.is_old then
				gui.text(302,81,"Double Somersault: " .. rb(0xFF84E2+p2))
			end
		elseif gamestate.P2.character == Ken then
			gui.text(223,65, "Hadouken: " .. rb(0xFF84E2+p2))
			gui.text(223,73, "Shoryuken: " .. rb(0xFF84E6+p2))
			gui.text(223,81, "Hurricane Kick: " .. rb(0xFF84DE+p2))
			if not gamestate.P2.is_old then
				gui.text(322,65, "Crazy Kick 1: " .. rb(0xFF8534+p2))
				gui.text(322,73, "Crazy Kick 2: " .. rb(0xFF8536+p2))
				gui.text(322,81, "Crazy Kick 3: " .. rb(0xFF8538+p2))
				gui.text(272,89, "Shoryureppa: " .. rb(0xFF84EE+p2))
			end
		elseif gamestate.P2.character == Dictator then
			gui.text(217,65,"Scissor Kick: " .. rb(0xFF84D6+p2))
			gui.text(217,73,"Headstomp: " .. rb(0xFF84DF+p2))
			gui.text(217,81,"Devil's Reverse: " .. rb(0xFF84FA+p2))
			gui.text(290,65,"Psycho Crusher: " .. rb(0xFF84CE+p2))
			if not gamestate.P2.is_old then
				gui.text(290,73,"Knee Press Nightmare: " .. rb(0xFF8513+p2))
			end
		elseif gamestate.P2.character == Ryu then
			gui.text(210,65,"Hadouken: " .. rb(0xFF84E2+p2))
			gui.text(210,73,"Shoryuken: " .. rb(0xFF84E6+p2))
			gui.text(210,81, "Hurricane Kick: " .. rb(0xFF84DE+p2))
			gui.text(310,65, "Red Hadouken: " .. rb(0xFF852E+p2))
			if not gamestate.P2.is_old then
				gui.text(310,73, "Shinku Hadouken: " .. rb(0xFF84EE+p2))
			end
		elseif gamestate.P2.character == Sagat then
			gui.text(214,65,"Tiger Shot: " .. rb(0xFF84DA+p2))
			gui.text(214,73,"Tiger Knee: " .. rb(0xFF84D2+p2))
			gui.text(214,81,"Tiger Uppercut: " .. rb(0xFF84CE+p2))
			if not gamestate.P2.is_old then
				gui.text(314,65, "Tiger Genocide: " .. rb(0xFF84EC+p2))
			end
		elseif gamestate.P2.character == Hawk then
			if gamestate.P2.is_old then
				gui.text(294,65,"Mexican Typhoon: " .. rb(0xFF84E8+p2))
				gui.text(294,73,"Tomahawk: " .. rb(0xFF84E0+p2))
			else
				gui.text(294,65,"Mexican Typhoon: " .. rb(0xFF84E0+p2) .. ", " .. rb(0xFF84E1+p2))
				gui.text(294,73,"Tomahawk: " .. rb(0xFF84DB+p2))
				gui.text(294,81,"Double Typhoon: " .. rb(0xFF84E0+p2) .. ", " .. rb(0xFF84ED+p2))
			end
		elseif gamestate.P2.character == Claw then
			gui.text(210,65,"Wall Dive (Kick): " .. rb(0xFF84DA+p2))
			gui.text(210,73,"Wall Dive (Punch): " .. rb(0xFF84DE+p2))
			gui.text(210,81,"Crystal Flash: " .. rb(0xFF84D6+p2))
			if not gamestate.P2.is_old then
				gui.text(298,65,"Flip Kick: " .. rb(0xFF84EB+p2))
				gui.text(298,73,"Rolling Izuna Drop: " .. rb(0xFF84E7+p2))
			end
		elseif gamestate.P2.character == Zangief then
			gui.text(275,65, "Bear Grab: " .. rb(0xFF84E9+p2) .. ", " .. rb(0xFF84EA+p2))
			gui.text(275,73, "Spinning Pile Driver: " .. rb(0xFF84CE+p2) .. ", " .. rb(0xFF84CF+p2))
			if not gamestate.P2.is_old then
				gui.text(275,81, "Banishing Flat: " .. rb(0xFF8501+p2))
				gui.text(275,89, "Final Atomic Buster: " .. rb(0xFF84FA+p2) .. ", " .. rb(0xFF84FB+p2))
			end
		end
	end
end
-----------------------
--Dizzy meters
---- -------------------
--Determine the color of the bar based on the value (higher = darker)
local function diz_col(val,type)
	local color = 0x00000000

	if type == 0 then
		if val <= 5.66 then
			color = 0x00FF5DA0
			return color
		elseif val > 5.66 and val <= 11.22 then
			color = 0x54FF00A0
			return color
		elseif val > 11.22 and val <= 16.88 then
			color = 0xAEFF00A0
			return color
		elseif val > 16.88 and val <= 22.44 then
			color = 0xFAFF00A0
			return color
		elseif val > 22.4 and val <= 28.04 then
			color = 0xFF5400A0
			return color
		elseif val > 28.04 then
			color = 0xFF0026A0
			return color
		end
	else
		if val <= 10922.5 then
			color = 0x00FF5DA0
			return color
		elseif val > 10922.5 and val <= 21845 then
			color = 0x54FF00A0
			return color
		elseif val > 21845 and val <= 32767.5 then
			color = 0xAEFF00A0
			return color
		elseif val > 32767.5 and val <= 43690 then
			color = 0xFAFF00A0
			return color
		elseif val > 43690 and val <= 54612.5 then
			color = 0xFF5400A0
			return color
		elseif val > 54612.5 then
			color = 0xFF0026A0
			return color
		end
	end
end

local p1_dizzy_drawn = false
local p2_dizzy_drawn = false

local function draw_dizzy()

	local p1_s = gamestate.P1.stun_meter
	local p1_c = gamestate.P1.stun_counter
	local p1_d = gamestate.P1.destun_meter

	local p2_s = gamestate.P2.stun_meter
	local p2_c = gamestate.P2.stun_counter
	local p2_d = gamestate.P2.destun_meter

	-- P1 Stun meter
	if p1_s > 0 then
		if p1_s <= 10 then
			gui.box(35,45,(35+(3.38 * p1_s)),49,diz_col(p1_s,0),0x000000FF)
		elseif p1_s > 10 and p1_s <= 20 then
			gui.box(35,45,(35+(3.38 * p1_s)),49,diz_col(p1_s,0),0x000000FF)
		elseif p1_s > 20 then
			gui.box(35,45,(35+(3.38 * p1_s)),49,diz_col(p1_s,0),0x000000FF)
		end
	end

	-- P1 Stun counter
	if p1_c > 0 then
		if p1_c <= 70 then
			gui.box(35,49,(35+(0.001754 * p1_c)),53,diz_col(p1_c,1),0x000000FF)
		elseif p1_c > 70 and p1_c <= 150 then
			gui.box(35,49,(35+(0.001754* p1_c)),53,diz_col(p1_c,1),0x000000FF)
		elseif p1_c > 150 then
			gui.box(35,49,(35+(0.001754 * p1_c)),53,diz_col(p1_c,1),0x000000FF)
		end
	end

	-- P2 Stun meter
	if p2_s > 0 then
		if p2_s <= 10 then
			gui.box(233,45,(233+(3.38 * p2_s)),49,diz_col(p2_s,0),0x000000FF)
		elseif p2_s > 10 and p2_s <= 20 then
			gui.box(233,45,(233+(3.38 * p2_s)),49,diz_col(p2_s,0),0x000000FF)
		elseif p2_s > 20 then
			gui.box(233,45,(233+(3.38 * p2_s)),49,diz_col(p2_s,0),0x000000FF)
		end
	end

	-- P2 Stun counter
	if p2_c > 0 then
		if p2_c <= 70 then
			gui.box(233,49,(233+(0.001754 * p2_c)),53,diz_col(p2_c,1),0x000000FF)
		elseif p2_c > 70 and p2_c <= 150 then
			gui.box(233,49,(233+(0.001754 * p2_c)),53,diz_col(p2_c,1),0x000000FF)
		elseif p2_c > 150 then
			gui.box(233,49,(233+(0.001754 * p2_c)),53,diz_col(p2_c,1),0x000000FF)
		end
	end

	if gamestate.P1.dizzy then
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(3,190,11,(190 - (0.428 * p1_d)),0xFF0000B0,0x00000000)
		gui.text(3,192,p1_d)
		p1_dizzy_drawn = true
	else
		p1_dizzy_drawn = false
	end

	if gamestate.P2.dizzy then
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(370,190,378,(190 - (0.428 * p2_d)),0xFF0000B0,0x00000000)
		gui.text(365,192,p2_d)
		p2_dizzy_drawn = true
	else
		p2_dizzy_drawn = false
	end

end
--------------------------
--Grab meters
--------------------------
local p1_grab_drawn = false
local p2_grab_drawn = false

local function draw_grab(player,p1_char,p2_char,p_gc)

	local p_a = 0
	local p1_hg = gamestate.P1.grab_strength
	local p2_hg = gamestate.P2.grab_strength

	if player == 0 then

		-- Draw the grab speed meter

		if p1_hg == 0x15 then
			gui.box(16,190,22,180,0xFF0C00C0,0x000000FF)
			gui.text(18,182,"1")
		elseif p1_hg == 0x12 then
			gui.box(16,190,22,170,0xFF0C00C0,0x000000FF)
			gui.text(18,172,"2")
		elseif p1_hg == 0x0F then
			gui.box(16,190,22,160,0xFF0C00C0,0x000000FF)
			gui.text(18,162,"3")
		elseif p1_hg == 0x0C then
			gui.box(16,190,22,150,0xFF0C00C0,0x000000FF)
			gui.text(18,152,"4")
		elseif p1_hg == 0x09 then
			gui.box(16,190,22,140,0xFF0C00C0,0x000000FF)
			gui.text(18,142,"5")
		elseif p1_hg == 0x06 then
			gui.box(16,190,22,130,0xFF0C00C0,0x000000FF)
			gui.text(18,132,"6")
		elseif p1_hg == 0x03 then
			gui.box(16,190,22,120,0xFF0C00FF,0x000000FF)
			gui.text(18,122,"7")
		end


		gui.box(16,120,22,190,0x00000040,0x000000FF)
		gui.line(16,130,22,130,0x000000FF,0x000000FF)
		gui.line(16,140,22,140,0x000000FF,0x000000FF)
		gui.line(16,150,22,150,0x000000FF,0x000000FF)
		gui.line(16,160,22,160,0x000000FF,0x000000FF)
		gui.line(16,170,22,170,0x000000FF,0x000000FF)
		gui.line(16,180,22,180,0x000000FF,0x000000FF)


		if p1_char == Ken or p1_char == Hawk then
		--Ken thawk
		p_a = (90 / 120)
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(3,190,11,190 - (p_a * rb(p_gc)),0xFFFF00B0,0x00000000)
		gui.box(370,190,378,190 - ((90 / 63) * gamestate.P2.grab_break),0xFF0000B0,0x00000000)
		gui.text(363,192,gamestate.P2.grab_break .. "/" .. "63")
		gui.text(1,192,rb(p_gc) .. "/" .. "120")
		elseif p1_char == Blanka or p1_char == Honda then
		--Blanka E.Honda
		p_a = (90 / 130)
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(3,190,11,190 - (p_a * rb(p_gc)),0xFFFF00B0,0x00000000)
		gui.box(370,190,378,190 - ((90 / 63) * gamestate.P2.grab_break),0xFF0000B0,0x00000000)
		gui.text(363,192,gamestate.P2.grab_break .. "/" .. "63")
		gui.text(1,192,rb(p_gc) .. "/" .. "130")
		elseif p1_char == Dhalsim or p1_char == Zangief then
		--Dhalsim Zangief
		p_a = (90 / 180)
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(3,190,11,190 - (p_a * rb(p_gc)),0xFFFF00B0,0x00000000)
		gui.box(370,190,378,190 - ((90 / 63) * gamestate.P2.grab_break),0xFF0000B0,0x00000000)
		gui.text(363,192,gamestate.P2.grab_break .. "/" .. "63")
		gui.text(1,192,rb(p_gc) .. "/" .. "180")
		elseif p1_char == Boxer then
		--Boxer
		p_a = (90 / 210)
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(3,190,11,190 - (p_a * rb(p_gc)),0xFFFF00B0,0x00000000)
		gui.box(370,190,378,190 - ((90 / 63) * gamestate.P2.grab_break),0xFF0000B0,0x00000000)
		gui.text(363,192,gamestate.P2.grab_break .. "/" .. "63")
		gui.text(1,192,rb(p_gc) .. "/" .. "210")
		end

	else

		-- Draw grab speed

		if p2_hg == 0x15 then
			gui.box(357,190,363,180,0xFF0C00C0,0x000000FF)
			gui.text(359,182,"1")
		elseif p2_hg == 0x12 then
			gui.box(357,190,363,170,0xFF0C00C0,0x000000FF)
			gui.text(359,172,"2")
		elseif p2_hg == 0x0F then
			gui.box(357,190,363,160,0xFF0C00C0,0x000000FF)
			gui.text(359,162,"3")
		elseif p2_hg == 0x0C then
			gui.box(357,190,363,150,0xFF0C00C0,0x000000FF)
			gui.text(359,152,"4")
		elseif p2_hg == 0x09 then
			gui.box(357,190,363,140,0xFF0C00C0,0x000000FF)
			gui.text(359,142,"5")
		elseif p2_hg == 0x06 then
			gui.box(357,190,363,130,0xFF0C00C0,0x000000FF)
			gui.text(359,132,"6")
		elseif p2_hg == 0x03 then
			gui.box(357,190,363,120,0xFF0C00C0,0x000000FF)
			gui.text(359,122,"7")
		end


		gui.box(357,190,363,120,0x00000040,0x000000FF)
		gui.line(357,130,363,130,0x000000FF,0x000000FF)
		gui.line(357,140,363,140,0x000000FF,0x000000FF)
		gui.line(357,150,363,150,0x000000FF,0x000000FF)
		gui.line(357,160,363,160,0x000000FF,0x000000FF)
		gui.line(357,170,363,170,0x000000FF,0x000000FF)
		gui.line(357,180,363,180,0x000000FF,0x000000FF)
		if p2_char == Ken or p2_char == Hawk then
		--Ken thawk
		p_a = (90 / 120)
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(370,190,378,190 - (p_a * rb(p_gc)),0xFFFF00B0,0x00000000)
		gui.box(3,190,11,190 - ((90 / 63) * gamestate.P1.grab_break),0xFF0000B0,0x00000000)
		gui.text(1,192,gamestate.P1.grab_break .. "/" .. "63")
		gui.text(355,192,rb(p_gc) .. "/" .. "120")
		elseif p2_char == Blanka or p2_char == Honda then
		--Blanka E.Honda
		p_a = (90 / 130)
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(370,190,378,190 - (p_a * rb(p_gc)),0xFFFF00B0,0x00000000)
		gui.box(3,190,11,190 - ((90 / 63) * gamestate.P1.grab_break),0xFF0000B0,0x00000000)
		gui.text(1,192,gamestate.P1.grab_break .. "/" .. "63")
		gui.text(355,192,rb(p_gc) .. "/" .. "130")
		elseif p2_char == Dhalsim or p2_char == Zangief then
		--Dhalsim Zangief
		p_a = (90 / 180)
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(370,190,378,190 - (p_a * rb(p_gc)),0xFFFF00B0,0x00000000)
		gui.box(3,190,11,190 - ((90 / 63) * gamestate.P1.grab_break),0xFF0000B0,0x00000000)
		gui.text(1,192,gamestate.P1.grab_break .. "/" .. "63")
		gui.text(355,192,rb(p_gc) .. "/" .. "180")
		elseif p2_char == Boxer then
		--Boxer
		p_a = (90 / 210)
		gui.box(3,100,11,190,0x00000040,0x000000FF)
		gui.box(370,100,378,190,0x00000040,0x000000FF)
		gui.box(370,190,378,190 - (p_a * rb(p_gc)),0xFFFF00A0,0x00000000)
		gui.box(3,190,11,190 - ((90 / 63) * gamestate.P1.grab_break),0xFF0000B0,0x00000000)
		gui.text(1,192,gamestate.P1.grab_break .. "/" .. "63")
		gui.text(355,192,rb(p_gc) .. "/" .. "210")
		end
	end
end

local function check_grab()

local p1_c  = gamestate.P1.character
local p1_gc = 0 -- P1 Grab counter
local p1_gb = gamestate.P1.grab_break
local p1_gf = gamestate.P1.grab_flag
local p1_tf = gamestate.P1.throw_flag

local p2_c  = gamestate.P2.character
local p2_gc = 0 -- P1 Grab counter
local p2_gb = gamestate.P2.grab_break
local p2_gf = gamestate.P2.grab_flag
local p2_tf = gamestate.P2.throw_flag

	if p1_c == Honda or p1_c == Blanka or p1_c == Ken or p1_c == Zangief or p1_c == Dhalsim or p1_c == Boxer or p1_c == Hawk then
		if p1_c == Honda or p1_c == Blanka or p1_c == Ken or p1_c == Dhalsim or p1_c == Hawk then
			if p1_c == Dhalsim then
				p1_gv = 0x06
			end
			p1_gc = 0xFF846C
		elseif p1_c == Zangief then
			p1_gc = 0xFF84D7
		elseif p1_c == Boxer then
			p1_gc = 0xFF84E3
		end

		if p2_tf == 0xFF then
			if p1_c == Ken or p1_c == Blanka then
				if p1_gf == 0x07 then
					p1_grab_drawn = true
					draw_grab(0,p1_c,p2_c,p1_gc)
				end
			elseif p1_c == Honda then
				if p1_gf == 0x07 or p1_gf == 0x04 then
					p1_grab_drawn = true
					draw_grab(0,p1_c,p2_c,p1_gc)
				end
			elseif p1_c == Dhalsim then
				if p1_gf == 0x06 then
					p1_grab_drawn = true
					draw_grab(0,p1_c,p2_c,p1_gc)
				end
			elseif p1_c == Balrog then
				if p1_gf == 0x06 or p1_gf == 0x05 then
					p1_grab_drawn = true
					draw_grab(0,p1_c,p2_c,p1_gc)
				end
			elseif p1_c == Hawk then
				if p1_gf == 0x06 or p1_gf == 0x07 then
					p1_grab_drawn = true
					draw_grab(0,p1_c,p2_c,p1_gc)
				end
			elseif p1_c == Zangief then
				if p1_gf == 0x05 or p1_gf == 0x06 or p1_gf == 0x03 then
					p1_grab_drawn = true
					draw_grab(0,p1_c,p2_c,p1_gc)
				end
			end
		else
			p1_grab_drawn = false
		end
	end

	if p2_c == Honda or p2_c == Blanka or p2_c == Ken or p2_c == Zangief or p2_c == Dhalsim or p2_c == Boxer or p2_c == Hawk then
		if p2_c == Honda or p2_c == Blanka or p2_c == Ken or p2_c == Dhalsim or p2_c == Hawk then
			p2_gc = 0xFF886C
		elseif p2_c == Zangief then
			p2_gc = 0xFF88D7
		elseif p2_c == Boxer then
			p2_gc = 0xFF88E3
		end

		if p1_tf == 0xFF then
			if p2_c == Ken or p2_c == Blanka then
				if p2_gf == 0x07 then
					p2_grab_drawn = true
					draw_grab(1,p1_c,p2_c,p2_gc)
				end
			elseif p2_c == Honda then
				if p2_gf == 0x07 or p2_gf == 0x04 then
					grab_drawn = true
					draw_grab(1,p1_c,p2_c,p2_gc)
				end
			elseif p2_c == Dhalsim then
				if p2_gf == 0x06 then
					p2_grab_drawn = true
					draw_grab(1,p1_c,p2_c,p2_gc)
				end
			elseif p2_c == Boxer then
				if p2_gf == 0x06 or p2_gf == 0x05 then
					p2_grab_drawn = true
					draw_grab(1,p1_c,p2_c,p2_gc)
				end
			elseif p2_c == Hawk then
				if p2_gf == 0x06 or p2_gf == 0x07 then
					p2_grab_drawn = true
					draw_grab(1,p1_c,p2_c,p2_gc)
				end
			elseif p2_c == Zangief then
				if p2_gf == 0x05 or p2_gf == 0x06 or p2_gf == 0x03 then
					p2_grab_drawn = true
					draw_grab(1,p1_c,p2_c,p2_gc)
				end
			end
		else
			p2_grab_drawn = false
		end
	end
end
---------------------------------------------------------
-- Asunaro : Shift scrolling input display if we need it
---------------------------------------------------------
-- It seems that we can't compare tables so i had to create those variables
local prev_p1_dizzy_drawn = false
local prev_p2_dizzy_drawn = false
local prev_p1_grab_drawn = false
local prev_p2_grab_drawn = false
local curr_p1_dizzy_drawn = false
local curr_p2_dizzy_drawn = false
local curr_p1_grab_drawn = false
local curr_p2_grab_drawn = false

local function shiftP1(status)
	if status then
		inputs.properties.scrollinginput.scrollinginputxoffset[1] = 30
		inputs.properties.scrollinginput.scrollinginputyoffset[1] = 100
	else
		inputs.properties.scrollinginput.scrollinginputxoffset[1] = 3
		inputs.properties.scrollinginput.scrollinginputyoffset[1] = 100
	end
end

local function shiftP2(status)
	if status then
		inputs.properties.scrollinginput.scrollinginputxoffset[2] = 285
		inputs.properties.scrollinginput.scrollinginputyoffset[2] = 100
	else
		inputs.properties.scrollinginput.scrollinginputxoffset[2] = 310
		inputs.properties.scrollinginput.scrollinginputyoffset[2] = 100
	end
end

local function shiftScrollingInput()
	prev_p1_grab_drawn = curr_p1_grab_drawn
	curr_p1_grab_drawn = p1_grab_drawn
	prev_p2_grab_drawn = curr_p2_grab_drawn
	curr_p2_grab_drawn = p2_grab_drawn

	prev_p1_dizzy_drawn = curr_p1_dizzy_drawn
	curr_p1_dizzy_drawn = p1_dizzy_drawn
	prev_p2_dizzy_drawn = curr_p2_dizzy_drawn
	curr_p2_dizzy_drawn = p2_dizzy_drawn

	if (prev_p1_dizzy_drawn ~= curr_p1_dizzy_drawn) or (prev_p2_dizzy_drawn ~= curr_p2_dizzy_drawn) or (prev_p1_grab_drawn ~= curr_p1_grab_drawn) or (prev_p2_grab_drawn ~= curr_p2_grab_drawn) then
		if p1_dizzy_drawn then
			shiftP1(true)
		end
		if p2_dizzy_drawn then
			shiftP2(true)
		end
		if p1_grab_drawn or p2_grab_drawn then
			shiftP1(true)
			shiftP2(true)
		else
			if not p1_dizzy_drawn then
				shiftP1(false)
			end
			if not p2_dizzy_drawn then
				shiftP2(false)
			end
		end
		scrollingInputReload()
	end
end
-------------------------------
--Draw HUD
-------------------------------
local ST_HUD = false
local HUD_settings = {}
local HUD_backup = {}
local ST_HUD_settings = {
33,		--p1healthx
22,		--p1healthy
340,	--p2healthy
22,		--p2healthy
174,	--combotextx
49,		--combotexty
false,	--p1meterenabled
false,	--p2meterenabled
3,		--p1scrollinginputxoffset
100,	--p1scrollinginputyoffset
310,	--p2scrollinginputxoffset
100,	--p2scrollinginputyoffset
8,		--iconsize
false,	--p2scrollingstate
false,	--p1simplestate
false,	--p2simplestate
}

local function render_st_hud()

	if not gamestate.is_in_match then
		return
	end

	if draw_hud == 0 or draw_hud == 1 then
		if not ST_HUD then
			saveConfig()
			--
			HUD_backup = { -- Asunaro : I tried to make a function to make this less messy but unfortunately trying to access the table "hud" when ssf2xj.lua is loaded return an error
			hud.p1healthx,
			hud.p1healthy,
			hud.p2healthx,
			hud.p2healthy,
			hud.combotextx,
			hud.combotexty,
			hud.p1meterenabled,
			hud.p2meterenabled,
			inputs.properties.scrollinginput.scrollinginputxoffset[1],
			inputs.properties.scrollinginput.scrollinginputyoffset[1],
			inputs.properties.scrollinginput.scrollinginputxoffset[2],
			inputs.properties.scrollinginput.scrollinginputyoffset[2],
			inputs.properties.scrollinginput.iconsize,
			inputs.properties.scrollinginput.scrollingstate[2],
			inputs.properties.simpleinput.simplestate[1],
			inputs.properties.simpleinput.simplestate[2],
			}
			--
			HUD_settings = ST_HUD_settings
			hud.p1healthx			= HUD_settings[1]
			hud.p1healthy			= HUD_settings[2]
			hud.p2healthx			= HUD_settings[3]
			hud.p2healthy			= HUD_settings[4]
			hud.combotextx			= HUD_settings[5]
			hud.combotexty			= HUD_settings[6]
			hud.p1meterenabled		= HUD_settings[7]
			hud.p2meterenabled		= HUD_settings[8]
			inputs.properties.scrollinginput.scrollinginputxoffset[1] = HUD_settings[9]
			inputs.properties.scrollinginput.scrollinginputyoffset[1] = HUD_settings[10]
			inputs.properties.scrollinginput.scrollinginputxoffset[2] = HUD_settings[11]
			inputs.properties.scrollinginput.scrollinginputyoffset[2] = HUD_settings[12]
			inputs.properties.scrollinginput.iconsize 				  = HUD_settings[13]
			inputs.properties.scrollinginput.scrollingstate[2]		  = HUD_settings[14]
			inputs.properties.simpleinput.simplestate[1]		 	  = HUD_settings[15]
			inputs.properties.simpleinput.simplestate[2]		 	  = HUD_settings[16]
			scrollingInputReload()
			--
			ST_HUD = true
			ignore_save_config = true
		end
		--Universal
		gui.text(153,12,"Distance X/Y: " .. calc_range())
		--P1
		gui.text(6,16,"X/Y: ")
		gui.text(2,24,gamestate.P1.pos_x .. "," .. gamestate.P1.pos_y)
		--gui.text(35,22,"Life: " .. rb(0xFF8479))
		gui.text(154,41,gamestate.P1.stun_meter .. "/34")
		gui.text(154,50,gamestate.P1.stun_counter)
		gui.box(35,45,150,49,0x00000040,0x000000FF)
		gui.box(35,49,150,53,0x00000040,0x000000FF)
		gui.line(136,45,136,49,0x000000FF)
		--gui.text(22,206,"Super: " .. rb(0xFF8702))
		gui.text(8,216,"Cancel: " .. check_cancel(gamestate.P1))
		--P2
		gui.text(363,16,"X/Y: ")
		gui.text(356,24,gamestate.P2.pos_x .. "," .. gamestate.P2.pos_y)
		--gui.text(314,22,"Life: " .. rb(0xFF8879))
		gui.text(212,41,gamestate.P2.stun_meter .. "/34")
		gui.text(212,50,gamestate.P2.stun_counter)
		gui.box(233,45,348,49,0x00000040,0x000000FF)
		gui.box(233,49,348,53,0x00000040,0x000000FF)
		gui.line(334,45,334,49,0x000000FF)
		--gui.text(327,206,"Super: " .. rb(0xFF8B02))
		gui.text(310,216,"Cancel: " .. check_cancel(gamestate.P2))

		-- Character specific HUD
		if character_specific[readCharacterName(gamestate.P1)].infos.has_projectile then
			gui.text(34,56,"Projectile: " .. projectile_onscreen(gamestate.P1))
		end
		if character_specific[readCharacterName(gamestate.P2)].infos.has_projectile then
			gui.text(266,56,"Projectile: " .. projectile_onscreen(gamestate.P2))
		end
		draw_dizzy()
		check_grab()
		if draw_hud == 0 then
			determine_char(gamestate.P1)
			determine_char(gamestate.P2)
		end
		shiftScrollingInput()
	else
		if ST_HUD then
			HUD_settings = HUD_backup
			hud.p1healthx			= HUD_settings[1]
			hud.p1healthy			= HUD_settings[2]
			hud.p2healthx			= HUD_settings[3]
			hud.p2healthy			= HUD_settings[4]
			hud.combotextx			= HUD_settings[5]
			hud.combotexty			= HUD_settings[6]
			hud.p1meterenabled		= HUD_settings[7]
			hud.p2meterenabled		= HUD_settings[8]
			inputs.properties.scrollinginput.scrollinginputxoffset[1] = HUD_settings[9]
			inputs.properties.scrollinginput.scrollinginputyoffset[1] = HUD_settings[10]
			inputs.properties.scrollinginput.scrollinginputxoffset[2] = HUD_settings[11]
			inputs.properties.scrollinginput.scrollinginputyoffset[2] = HUD_settings[12]
			inputs.properties.scrollinginput.iconsize 				  = HUD_settings[13]
			inputs.properties.scrollinginput.scrollingstate[2]		  = HUD_settings[14]
			inputs.properties.simpleinput.simplestate[1]		 	  = HUD_settings[15]
			inputs.properties.simpleinput.simplestate[2]		 	  = HUD_settings[16]
			scrollingInputReload()
			ST_HUD = false
			ignore_save_config = false
		end
	end
end
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Reversal (patch method) by Asunaro
---------------------------------------------------------------------
---------------------------------------------------------------------
local reversal_options_checked = {} -- Stocks the relevant values to perform the choosen reversals
local listenReversalSettingsModifications = false
local once = false -- Condition of reversal_trigger 2

function stockReversalOptionsChecked()
	if interactivegui.enabled and not listenReversalSettingsModifications then -- If the menu has been opened, clean the table (maybe there's a cleaner way)
		for k in pairs(reversal_options_checked) do
			reversal_options_checked[k] = nil
		end
		patched_autoreversal_selector = 0
		listenReversalSettingsModifications = true
	end
	if not interactivegui.enabled and listenReversalSettingsModifications then -- If the menu has been closed, stock the options selected
		for i = 1, #reversal_options do
			if reversal_options[i].checked then
					table.insert(reversal_options_checked, reversal_options[i].reversal_id)
			end
		end
		if do_not_reversal.checked then
			table.insert(reversal_options_checked, "do_not_reversal")
		end
		if custom_sequence.checked then
			table.insert(reversal_options_checked, "custom_sequence")
		end
		if #reversal_options_checked == 0 then
			patched_autoreversal_selector = 0
		elseif #reversal_options_checked == 1 then
			if do_not_reversal.checked then
				patched_autoreversal_selector = 0
			else
				patched_autoreversal_selector = 1
			end
		elseif #reversal_options_checked > 1 then
			patched_autoreversal_selector = 2
		end
		listenReversalSettingsModifications = false
		once = false
	end
end
---------------------------------------------------------------------------------------------
-- Special moves : I'm using a patch which NOP the line clearing +0x169 each frame.
-- If +0x169 is set to 0x01 the character will reversal the special defined in +0x16A
---------------------------------------------------------------------------------------------
local function clearReversal(_player_obj)
	if _player_obj.reversal_flag == 0x01 then
		if _player_obj.character == Boxer then
			wb(_player_obj.addresses.reversal_flag_boxer, 0x00)
		else
			wb(_player_obj.addresses.reversal_flag, 0x00)
		end
	end
end

local function setReversal(_player_obj, reversal)
	if _player_obj.reversal_flag == 0x00 then
		if _player_obj.character == Boxer then
			wb(_player_obj.addresses.reversal_flag_boxer, 0x01)
		else
			wb(_player_obj.addresses.reversal_flag, 0x01)
		end
	end
	wb(_player_obj.addresses.reversal_id, reversal[1])
	wb(_player_obj.addresses.reversal_strength, reversal[2])
	-- just a little fix
	if _player_obj.character == Hawk then
		if not _player_obj.is_old then
			if reversal[1] == 0x00 then -- DP
				wb(0xFF88DE,reversal[2])
				wb(0xFF88DD,reversal[2])
			end
		else
			if reversal[1] == 0x00 then
				wb(0xFF88F0,reversal[2])
				wb(0xFF88F1,reversal[2])
			end
		end
	end
end

-----------------------------------------------------------------------------------------------
-- Reversal Throws : I'm using a patch which NOP the line writing p2 previous input dection (+0x394)
-- If we write 0x0000 in this address each input will now be autofired
-----------------------------------------------------------------------------------------------
local fixed_inputs = true

local function menuSelection()  -- Just a little fix : without it the cursor in character selection is buggy
	if gamestate.curr_state == 0x00 then -- In the character selection screen
		if gamestate.P2.curr_input ~= 0x0000 then
			ww(gamestate.P2.addresses.prev_input, 0xFFFF)
		end
	end
end

local function fixPreviousInputDetection(_fixed_inputs) -- Restores the previous input detection / Disables the autofire
	if REPLAY then return end
	if _fixed_inputs then
		ww(gamestate.P2.addresses.prev_input, gamestate.P2.prev.curr_input)
	end
	menuSelection()
end

local reversal_throw_ready = false
local iswakeup = false

local function reversalThrow(_throw)
	if (gamestate.P2.state == being_thrown) then
		iswakeup = true
	end
	if reversal_trigger_selector == 0 and not iswakeup then -- iswakeup is modified in patchedReversalLogic
		return
	end
	if reversal_trigger_selector == 1 and iswakeup then
		setDirection(2,5)
		return
	end
	if gamestate.P2.state == being_hit and gamestate.P2.prev.state == being_hit then
		local onair = gamestate.P2.air_state
		if onair == 255 then
			iswakeup = true
		end
		local counter = gamestate.P2.hitstun_counter -- We'll set reversal_throw_ready to true when the timing for a reversal is about to come

		if counter >= 0x69-0x03 and counter <= 0x69 then -- Light
			reversal_throw_ready = true
		elseif iswakeup and counter >= 0x7A-0x0A and counter <= 0x7A then -- Knockdown : the range is voluntarily wider because a knockdown can be interrupted by the corner and thus so does the hitstun counter
			reversal_throw_ready = true
		elseif not iswakeup and counter >= 0x7A-0x03 and counter <=0x7A then -- Medium
			reversal_throw_ready = true
		elseif counter >= 0x90-0x03 and counter <= 0x90 then -- Strong
			reversal_throw_ready = true
		elseif iswakeup and counter == 0x6A then -- Red Hadouken
			reversal_throw_ready = true
		else
			reversal_throw_ready = false
		end
	elseif gamestate.P2.state == being_thrown and gamestate.P2.prev.state == being_thrown then
		reversal_throw_ready = true
	else
		reversal_throw_ready = false
	end

	if reversal_throw_ready then
		fixed_inputs = false -- We disable the fix : the game won't update prev_p2inputs anymore
		ww(gamestate.P2.addresses.prev_input, 0x0000) -- We stock 0000 in prev_p2inputs : the game will think that the p2 didn't hold anything in the previous frame. Each input will now be interpreted as a new one, basically we're creating an autofire
		--if readPlayerTwoCharacter() == "blanka" then
		if gamestate.P2.character == Blanka then
			wb(0xFF88EC, 0x00) -- Disables Blanka HP electricity
		end
		--if readPlayerTwoCharacter() == "ehonda" then
		if gamestate.P2.character == Honda then
			wb(0xFF8916, 0x00) -- Disables Honda MP HHS
			wb(0xFF8918, 0x00) -- 				 HP HHS
			if gamestate.P2.is_old then -- Old Honda
				wb(0xFF88EA, 0x00) -- MP HHS
				wb(0xFF88EC, 0x00) -- HP HHS
			end
		end
		if playerTwoFacingLeft() then
				setDirection(2,"Right", determineThrowInput(_throw))
			else
				setDirection(2,"Left",determineThrowInput(_throw))
			end
		return
	else -- we enable the fix
		fixed_inputs = true
	end
	if gamestate.P2.state == doing_normal_move or gamestate.P2.state == doing_special_move then -- if the p2 attempts a throw we release the buttons
		setDirection(2,5)
	end
end

-------------------
-- Custom Sequence
-------------------
local p2_custom_sequence_ready = false

local function customSequence() -- Would need to be improved
	if gamestate.P2.hitfreeze_counter ~= 0x00 or (gamestate.P2.state == being_thrown and gamestate.P2.prev.state ~= being_thrown) then -- If the character has been thrown or if we detect hitfreeze (here it's more reliable than "gamestate.P2.state == 14 and gamestate.P2.prev.state ~= 14" because this expression can't detect combos)
		p2_custom_sequence_ready = true
		if (gamestate.P2.state == being_thrown) then
			iswakeup = true
		end
	end
	if (gamestate.P2.state == being_hit and gamestate.P2.prev.state == being_hit) then
	local onair = gamestate.P2.air_state
		if onair == 255 then
			iswakeup = true
			recording.playback = false
		end
	end

	if reversal_trigger_selector ~= 0 and (not iswakeup and p2_custom_sequence_ready and gamestate.P2.prev.state ~= standing and gamestate.P2.state ~= standing) then
		local counter = gamestate.P2.hitstun_counter
		--print("gamestate.P2.prev.state : "..gamestate.P2.prev.state)
		--print("curr_p2action : "..gamestate.P2.state)
		--print("counter : 0x"..string.format("%x",counter))
		if not recording.playback then
			if (counter == 0x68 and autoblock_selector == -1) or counter == 0x69 then -- Light
			togglePlayBack(nil, {})
			--print("Reversal on a Light")
			p2_custom_sequence_ready = false
			elseif (counter == 0x79 and autoblock_selector == -1) or counter == 0x7A then -- Medium
			togglePlayBack(nil, {})
			--print("Reversal on a Medium")
			p2_custom_sequence_ready = false
			elseif (counter == 0x8F and autoblock_selector == -1) or counter == 0x90 then -- Strong / Peut-être voir pour le red hado ?
			togglePlayBack(nil, {})
			--print("Reversal on a Strong")
			p2_custom_sequence_ready = false
			end
		end
	elseif reversal_trigger_selector ~= 1 and (iswakeup and (gamestate.P2.prev.state == being_hit and gamestate.P2.state ~= being_hit) or (gamestate.P2.prev.state == being_thrown and gamestate.P2.state ~= being_thrown)) then -- Would need to be more precise
		--print(" Reversal on Wakeup")
		togglePlayBack(nil, {})
		iswakeup = false
	end
	if recording.playback then
		p2_custom_sequence_ready = false
	end
end
-------------------
-- Reversal Logic
-------------------
local reversal_reroll = true -- Determine if a new reversal has to be selected
local current_recording_state = false
reversal_trigger_selector = customconfig.reversal_trigger_selector

function patchedReversalLogic()
	if custom_sequence.checked then
		local framesrecorded = #recording[recording.recordingslot]
		if (framesrecorded < 1) then
			gui.text(220,50,"Use the Replay Editor in the")
			gui.text(220,60,"Recording menu (hold coin) to")
			gui.text(220,70,"program the desired reversal action.")
			return
		end
	end
--------------------------
-- Reversal Trigger
--------------------------
	-- Off
	if reversal_trigger_selector == 3 or once then
		clearReversal(gamestate.P2)
		return
	end
	-- Knockdown only
	if gamestate.P2.substate == 0x06 and gamestate.P2.state ~= doing_special_move and gamestate.P2.state ~= doing_normal_move then
		knockdown_reversal = true
	end
	if reversal_trigger_selector == 0 then
		if not knockdown_reversal then
			clearReversal(gamestate.P2)
			return
		else
			iswakeup = true
			p2_custom_sequence_ready = true
		end
	end
	-- Hit only
	if reversal_trigger_selector == 1 then
		if (gamestate.P2.prev.state == being_hit and gamestate.P2.state ~= being_hit) or (gamestate.P2.prev.state == being_thrown and gamestate.P2.state ~= being_thrown) then
			knockdown_reversal = false
			iswakeup = false
		end
		if knockdown_reversal then
			clearReversal(gamestate.P2)
			return
		elseif gamestate.P2.hitfreeze_counter ~= 0x00 then
			iswakeup = false
			p2_custom_sequence_ready = true
		end
	end
------------------------------------
-- Reversal Logic
------------------------------------
	if patched_autoreversal_selector == 1 then -- One option has been checked
		if reversal_options_checked[1][1] == "throw" then
			clearReversal(gamestate.P2)
			reversalThrow(reversal_options_checked[1][2])
		elseif reversal_options_checked[1] == "custom_sequence" then
			clearReversal(gamestate.P2)
			customSequence()
			current_recording_state = recording.playback
		else
			if reversal_reroll or gamestate.P2.reversal_flag == 0x00 or gamestate.P2.reversal_id ~= reversal_options_checked[1] or gamestate.P2.reversal_strength ~= reversal_options_checked[2] then
				setReversal(gamestate.P2, reversal_options_checked[1])
				reversal_reroll = false
			end
		end
		if (gamestate.P2.prev.state ~= doing_special_move and gamestate.P2.state == doing_special_move) or (reversal_options_checked[1][1] == "throw" and gamestate.P2.prev.state ~= doing_normal_move and gamestate.P2.state == doing_normal_move) or (reversal_options_checked[1] == "custom_sequence" and current_recording_state == true) then
			if reversal_trigger_selector == 2 then
				once = true
			end
		end

	elseif patched_autoreversal_selector == 2 then -- Multiple options checked
		if reversal_reroll then
			random_reversal = math.random(1,#reversal_options_checked)
		end
		if not recording.playback then
			if reversal_options_checked[random_reversal][1] == "throw" then
				clearReversal(gamestate.P2)
				reversalThrow(reversal_options_checked[random_reversal][2])
			elseif reversal_options_checked[random_reversal] == "custom_sequence" then
				clearReversal(gamestate.P2)
				customSequence()
				current_recording_state = recording.playback
			elseif reversal_options_checked[random_reversal] == "do_not_reversal" then
				clearReversal(gamestate.P2)
			else
				if reversal_reroll or gamestate.P2.reversal_flag == 0x00 or gamestate.P2.reversal_id ~= reversal_options_checked[random_reversal][1] or gamestate.P2.reversal_strength ~= reversal_options_checked[random_reversal][2] then
					setReversal(gamestate.P2, reversal_options_checked[random_reversal])
				end
			end
			reversal_reroll = false
			if (gamestate.P2.prev.state ~= doing_special_move and gamestate.P2.state == doing_special_move) or (reversal_options_checked[random_reversal][1] == "throw" and gamestate.P2.prev.state ~= doing_normal_move and gamestate.P2.state == doing_normal_move) or (reversal_options_checked[random_reversal] == "do_not_reversal" and gamestate.P2.prev.state == being_hit and gamestate.P2.state ~= being_hit) or (reversal_options_checked[random_reversal] == "custom_sequence" and current_recording_state == true) then
				-- if p2 finished a special attack / if p2 attempted a throw / if p2 has been hit when "don't reversal" is selected
				-- if a playback has been launched -> reroll a special to be played
				reversal_reroll = true
				if reversal_trigger_selector == 2 then
					once = true
				end
			end
		end

	else
		clearReversal(gamestate.P2)
		reversal_reroll = true -- Set to true when you enter the gui
	end
	if (gamestate.P2.prev.state == being_hit and gamestate.P2.state ~= being_hit) or (gamestate.P2.prev.state == being_thrown and gamestate.P2.state ~= being_thrown) then
			knockdown_reversal = false
			iswakeup = false
	end
end

local function patchedAutoReversal()
	clearReversal(gamestate.P1)
	stockReversalOptionsChecked()
	patchedReversalLogic()
end
--------------------------------------------------------
--------------------------------------------------------
-- AutoReversal (Machine learning method) made by pof
--------------------------------------------------------
--------------------------------------------------------
autoreversal_selector = customconfig.autoreversal_selector
local numframes = 0
local frame_for_reversal = 0
local iswakeup = false
local wakeup_reversal = 35
local counter_for_wakeup_reversal = 0
local frame_for_wakeup_reversal = 35
local framesleft_for_wakeup_reversal = {}
framesleft_for_wakeup_reversal[0] = -1
framesleft_for_wakeup_reversal[1] = -1
local doreversal = false
local reversal_executed = false
local reversal_executed_at = -1
local framesleft = -1
local reversal_guessed = 0
local autoReversal = function()
	if REPLAY then return end
	local DEBUG=false
	if gamestate.patched then
		patchedAutoReversal()
	end

	if autoreversal_selector == -1 then
		return
	end

	local framesrecorded = #recording[recording.recordingslot]
	if (framesrecorded < 1) then
		gui.text(220,50,"Use the Replay Editor in the")
		gui.text(220,60,"Recording menu (hold coin) to")
		gui.text(220,70,"program the desired reversal action.")
		gui.text(35,80,"To improve auto-reversal select Game -> Load Game -> Apply IPS patches -> Play")
		return
	end
	if (framesrecorded > 8) then
		gui.text(220,50,"The recorded reversal action")
		gui.text(220,60,"is too long. Please record a")
		gui.text(220,70,"new action shorter than 9 frames.")
		return
	end

	local reversal_flag = rb(gamestate.P2.addresses.reversal_flag)
	local frameanimation = gamestate.P2.hitstun_counter
	local onair = gamestate.P2.air_state
	local prev_framesleft = gamestate.P2.prev.animation_frames_left
	framesleft = gamestate.P2.animation_frames_left

	if (gamestate.P2.state == being_hit and gamestate.P2.prev.state ~= being_hit) or (gamestate.P2.state == being_thrown and gamestate.P2.prev.state ~= being_thrown) then
		numframes = 1
		reversal_executed_at = -1
		reversal_executed = false
		counter_for_wakeup_reversal = 0
		if (gamestate.P2.state == being_thrown) then
			iswakeup = true
		end
	end
	if (gamestate.P2.state == being_hit and gamestate.P2.prev.state == being_hit) or (gamestate.P2.state == being_thrown and gamestate.P2.prev.state == being_thrown) then
		numframes = numframes + 1
		if was_frameskip then
			--if DEBUG then print ("FRAMESKIP @ "..numframes) end
			numframes=numframes+1
			if prev_framesleft - 1 == framesleft and framesleft > 1 then
				framesleft = framesleft - 1
			end
		end
		if onair == 255 then
			if not iswakeup then
				setFrameskip(true)
			end
			iswakeup = true
		end
		if (onair == 0) then
			if was_frameskip then
				counter_for_wakeup_reversal = counter_for_wakeup_reversal + 2
			else
				counter_for_wakeup_reversal = counter_for_wakeup_reversal + 1
			end
			wakeup_reversal = counter_for_wakeup_reversal - framesrecorded - 1
		else
			counter_for_wakeup_reversal = 0
		end

		if iswakeup and reversal_executed_at > 0 and reversal_executed_at + framesrecorded + 1 < numframes and framesrecorded < 5 then
			if DEBUG then print ("!!! Previous reversal attempt failed, trying again...") end
			framesleft_for_wakeup_reversal[0] = framesrecorded + 2
			framesleft_for_wakeup_reversal[1] = framesrecorded + 1
			frame_for_wakeup_reversal = counter_for_wakeup_reversal
			reversal_executed = false
			reversal_executed_at = -1
		end

		if iswakeup and reversal_guessed==1 and reversal_flag==0 then
			framesleft_for_wakeup_reversal[2]=framesleft
			reversal_guessed=2
		end


		if iswakeup and reversal_guessed==2 and reversal_flag==1 and framesleft_for_wakeup_reversal[1] ~= framesleft_for_wakeup_reversal[2] then
			if DEBUG then print("Adjusting wrong reversal guess from: "..framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1].." to "..framesleft_for_wakeup_reversal[1].."/"..framesleft_for_wakeup_reversal[2]) end
			framesleft_for_wakeup_reversal[0] = framesleft_for_wakeup_reversal[1]
			framesleft_for_wakeup_reversal[1] = framesleft_for_wakeup_reversal[2]
			reversal_guessed=0
		end
	end

	-- local boxer_reversal_flag = rb(0xFF89BB)
	-- if (DEBUG) and (gamestate.P2.state==14 or gamestate.P2.prev.state==14 or gamestate.P2.state==20 or gamestate.P2.prev.state==20) then print("gamestate.P2.state=" .. gamestate.P2.state .. " | numframes=" .. numframes .. " | onair="..onair.." | fa="..frameanimation.." | cfw="..counter_for_wakeup_reversal .. " | fl="..framesleft .. " | rf="..reversal_flag.." | brf="..boxer_reversal_flag) end

	if not iswakeup and (gamestate.P2.state ~= being_hit and gamestate.P2.prev.state == being_hit) then
		setFrameskip(true)
		if (reversal_flag==1) and (gamestate.P2.state == doing_special_move) then
			if (DEBUG) then print("=> SUCCESSFUL GROUND REVERSAL AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
		else
			if (DEBUG) then print("=> MISSED GROUND REVERSAL AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
		end
	elseif iswakeup and ( (gamestate.P2.state ~= being_hit and gamestate.P2.prev.state == being_hit) or (gamestate.P2.state ~= being_thrown and gamestate.P2.prev.state == being_thrown) ) then
		setFrameskip(true)
		if (reversal_flag==1) and (gamestate.P2.state == doing_special_move) then
			if (DEBUG) then print("=> SUCCESSFUL WAKEUP REVERSAL PERFORMED AT FRAME: [" .. frame_for_wakeup_reversal .. " / " ..counter_for_wakeup_reversal.. "] | [" .. frame_for_reversal .. " / " ..numframes.."] | rf="..reversal_flag.." framesleft="..framesleft) end
		elseif (counter_for_wakeup_reversal - frame_for_wakeup_reversal == framesrecorded) then
			if (DEBUG) then print("=> MISSED FRAME-PERFECT WAKEUP REVERSAL PERFORMED AT FRAME: [" .. frame_for_wakeup_reversal .. " / " ..counter_for_wakeup_reversal.. "] | [" .. frame_for_reversal .. " / " ..numframes.."] | rf="..reversal_flag.." framesleft="..framesleft) end
			wakeup_reversal = wakeup_reversal + 1
			framesleft_for_wakeup_reversal[0] = -1
			framesleft_for_wakeup_reversal[1] = -1
		elseif (counter_for_wakeup_reversal - frame_for_wakeup_reversal < framesrecorded) then
			if (DEBUG) then print("=> MISSED WAKEUP REVERSAL PERFORMED TOO LATE AT FRAME: [" .. frame_for_wakeup_reversal .. " / " ..counter_for_wakeup_reversal.. "] | [" .. frame_for_reversal .. " / " ..numframes.."] | rf="..reversal_flag.." framesleft="..framesleft) end
			framesleft_for_wakeup_reversal[0] = -1
			framesleft_for_wakeup_reversal[1] = -1
		elseif (counter_for_wakeup_reversal - frame_for_wakeup_reversal > framesrecorded) then
			if (DEBUG) then print("=> MISSED WAKEUP REVERSAL PERFORMED TOO EARLY AT FRAME: [" .. frame_for_wakeup_reversal .. " / " ..counter_for_wakeup_reversal.. "] | [" .. frame_for_reversal .. " / " ..numframes.."] | rf="..reversal_flag.." framesleft="..framesleft) end
			framesleft_for_wakeup_reversal[0] = -1
			framesleft_for_wakeup_reversal[1] = -1
		end
		frame_for_wakeup_reversal = wakeup_reversal
		iswakeup = false
		if (DEBUG) then
			print("=> FRAME FOR NEXT WAKEUP REVERSAL: ["..wakeup_reversal.." / "..counter_for_wakeup_reversal.."] @ framesleft == " .. framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1])
			print(" ")
		end
	end

	if not iswakeup and (gamestate.P2.state == being_hit) then
		if (frameanimation == 105 - framesrecorded) or (frameanimation == 104 - framesrecorded) or (frameanimation == 122 - framesrecorded) or (frameanimation == 121 - framesrecorded) or (frameanimation == 144 - framesrecorded) or (frameanimation == 143 - framesrecorded) then
			if not recording.playback then
				setFrameskip(false)
				togglePlayBack(nil, {})
				frame_for_reversal = numframes
				if (DEBUG) then print("GROUND REVERSAL! numframes=[" .. numframes .. "]") end
			end
		end
	end
	if iswakeup and (gamestate.P2.state == being_hit or gamestate.P2.state == being_thrown) and not reversal_executed then

		if counter_for_wakeup_reversal == frame_for_wakeup_reversal-4 or (counter_for_wakeup_reversal == frame_for_wakeup_reversal-3 and was_frameskip) then
			setFrameskip(false)
		end

		if (framesleft_for_wakeup_reversal[0] == -1 and counter_for_wakeup_reversal == frame_for_wakeup_reversal) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing reversal wakeup: cfwr["..counter_for_wakeup_reversal.."]==ffwr["..frame_for_wakeup_reversal.."]") end
			doreversal = true
		end
		if (framesleft_for_wakeup_reversal[0] ~= -1 and ( prev_framesleft ~= framesleft_for_wakeup_reversal[0] and framesleft == framesleft_for_wakeup_reversal[0]) and counter_for_wakeup_reversal > frame_for_wakeup_reversal - 1) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing EARLY reversal wakeup: prev_framesleft("..prev_framesleft..")!=framesleft_fwr[0]("..framesleft_for_wakeup_reversal[0]..") AND framesleft("..framesleft..")==framesleft_fwr[0]("..framesleft_for_wakeup_reversal[0]..")") end
			doreversal = true
		end
		if (framesleft_for_wakeup_reversal[0] ~= -1 and ( prev_framesleft == framesleft_for_wakeup_reversal[0] and framesleft == framesleft_for_wakeup_reversal[1]) and counter_for_wakeup_reversal > frame_for_wakeup_reversal - 2) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing LATE reversal wakeup: prev_framesleft("..prev_framesleft..")==framesleft_fwr[0]("..framesleft_for_wakeup_reversal[0]..") AND framesleft("..framesleft..")==framesleft_fwr[1]("..framesleft_for_wakeup_reversal[1]..")") end
			doreversal = true
		end

		local p2character = isChargeCharacter(gamestate.P2)

		if p2charge == false and (framesleft_for_wakeup_reversal[0] ~= -1 and ( framesleft == framesrecorded+2 or framesleft == framesrecorded+1) and counter_for_wakeup_reversal >= frame_for_wakeup_reversal) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing DESPERATE reversal wakeup: framesleft("..framesleft..")==framesrecorded("..framesrecorded..")+1or+2 AND cfwr("..counter_for_wakeup_reversal..")>="..frame_for_wakeup_reversal) end
			doreversal = true
		end
		if p2charge == false and counter_for_wakeup_reversal > 30 and framesrecorded < 5 and not doreversal and not recording.playback and (framesleft_for_wakeup_reversal[0] ~= -1 and ( framesleft == framesrecorded+2 or framesleft == framesrecorded+1) and counter_for_wakeup_reversal <= frame_for_wakeup_reversal) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing EARLY BLIND reversal wakeup: framesleft("..framesleft..")==framesrecorded("..framesrecorded..")+1or+2 AND cfwr("..counter_for_wakeup_reversal..")<="..frame_for_wakeup_reversal) end
			setFrameskip(false)
			togglePlayBack(nil, {})
		end

		if doreversal and not recording.playback then
			setFrameskip(false)
			togglePlayBack(nil, {})
			frame_for_reversal = numframes
			framesleft = gamestate.P2.animation_frames_left
			if framesleft == framesrecorded + 1 then
				framesleft_for_wakeup_reversal[0] = prev_framesleft
				framesleft_for_wakeup_reversal[1] = framesleft
				if (DEBUG) then print ("PERFECT 1 flfwr="..framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1]) end
				reversal_guessed=0
			elseif framesleft > framesrecorded + 1 then
				framesleft_for_wakeup_reversal[0] = framesrecorded + 2
				framesleft_for_wakeup_reversal[1] = framesrecorded + 1
				if (DEBUG) then print ("PERFECT 2 flfwr="..framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1]) end
				reversal_guessed=0
			elseif framesleft_for_wakeup_reversal[0] == -1 then
				framesleft_for_wakeup_reversal[0] = prev_framesleft
				framesleft_for_wakeup_reversal[1] = framesleft
				if (DEBUG) then print ("GUESSED flfwr="..framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1]) end
				reversal_guessed=1
			end
			if (DEBUG) then print("WAKEUP REVERSAL! cfwr="..counter_for_wakeup_reversal.." frame_for_wakeup_reversal=[" .. frame_for_wakeup_reversal .. "] numframes="..numframes.." framesleft="..framesleft) end
			doreversal = false
			reversal_executed = true
			reversal_executed_at = numframes
		end
	end
end

---------------------------------
---------------------------------
-- AutoBlock (made by pof)
---------------------------------
---------------------------------
autoblock_selector = customconfig.autoblock_selector
local forceblock = false
local inputs_at_jumpstart = 0
local autoblock_skip_counter = 60
local canblock = false
local canblock_counter = 0
local canblock_length = 20

local autoBlock = function()
	if REPLAY then return end

	if autoblock_selector == -1 or gamestate.P1.throw_flag == 0x01 then -- If P2 is thrown we return, this way the dummy can tech a throw
		return
	end

	local DEBUG=false

	-- neutral when opponent is neutral, crouching or landing
	if (gamestate.P1.state == standing or gamestate.P1.state == crouching or gamestate.P1.state == landing) then
		setDirection(2,5)
		forceblock = false
		if autoblock_selector == 2 and canblock == true then
			canblock_counter = countFrames(canblock_counter)
			if canblock_counter >= canblock_length then
				canblock = false
				canblock_counter = 0
			end
		end
		return
	end

	local distance = getDistanceBetweenPlayers()

	-- if opponent is ground attacking, ground block
	if (gamestate.P1.state == doing_normal_move or gamestate.P1.state == doing_special_move) and distance < 265 then

		-- block: auto
		if autoblock_selector == 2 and canblock == false then
			if gamestate.P2.state == being_hit then
				setDirection(2,5)
				canblock = true
			end
			return
		end

		-- block: random
		if autoblock_selector == 3 then
			autoblock_skip_counter = autoblock_skip_counter -1
			if autoblock_skip_counter == 0 then
				autoblock_skip_counter = 60
			end
			if autoblock_skip_counter > 40 then
				return
			end
		end

		local p1crouching = playerCrouching(gamestate.P1)
		if playerOneFacingLeft() and p1crouching then
			setDirection(2,1)
		end
		if playerTwoFacingLeft() and p1crouching then
			setDirection(2,3)
		end
		if playerOneFacingLeft() and not p1crouching then
			setDirection(2,4)
		end
		if playerTwoFacingLeft() and not p1crouching then
			setDirection(2,6)
		end
		if DEBUG then print("ground block @ p1action=" .. gamestate.P1.state .. " | inputs=" .. gamestate.P1.curr_input .. " | distance=" .. distance) end
		return
	end

	-- block jump attacks
	local p1attacking = false
	if autoblock_selector ~= 1 and autoblock_selector ~= 2 and gamestate.P1.state == jumping and distance < 265 then

		if autoblock_selector == 3 then
			autoblock_skip_counter = autoblock_skip_counter -1
			if autoblock_skip_counter == 0 then
				autoblock_skip_counter = 60
			end
			if autoblock_skip_counter > 30 then
				return
			end
		end

		local p1buttons = bit.band(gamestate.P1.curr_input, 0x000F)
		if gamestate.P1.prev.state ~= jumping then
			inputs_at_jumpstart = gamestate.P1.curr_input-p1buttons
			p1attacking = false
		end
		if gamestate.P1.curr_input-p1buttons ~= inputs_at_jumpstart and gamestate.P1.curr_input-p1buttons > 10 then
			-- buttons pressed changed during jump, Player one is attacking
			p1attacking = true
			forceblock = true
		end
		if (gamestate.P2.state ~= landing and gamestate.P2.state ~= blocking_attempt and gamestate.P2.state ~= being_hit) then
			forceblock = false
		end

		if (p1attacking or forceblock) then
			if playerOneFacingLeft() then
				setDirection(2,4)
			else
				setDirection(2,6)
			end
			if DEBUG then print("block high @ p1action=" .. gamestate.P1.state .. " | p2action=" .. gamestate.P2.state .. " | inputs=" .. gamestate.P1.curr_input .. "/" .. p1buttons .. " | distance=" .. distance .. " | p1attacking=" .. tostring(p1attacking) .. " | forceblock=" .. tostring(forceblock)) end
			return
		end
		setDirection(2,5)
		if DEBUG then print("neutral @ p1action=" .. gamestate.P1.state .. " | p2action=" .. gamestate.P2.state .. " | inputs=" .. gamestate.P1.curr_input .. "/" .. p1buttons .. " | distance=" .. distance .. " | p1attacking=" .. tostring(p1attacking) .. " | forceblock=" .. tostring(forceblock)) end
		forceblock = false
		return
	end

	-- stop blocking
	if (distance >= 265 or gamestate.P1.state == crouching) then
		setDirection(2,5)
		if DEBUG then print("neutral-4 @ p1action=" .. gamestate.P1.state .. " | inputs=" .. gamestate.P1.curr_input .. " | distance=" .. distance) end
		forceblock = false
		return
	end
	if DEBUG then print("FINAL @ p1action=" .. gamestate.P1.state .. " | inputs=" .. gamestate.P1.curr_input .. " | distance=" .. distance) end

end

--------------------------
-- Choosing a stage
--------------------------
stage_selector = customconfig.stage_selector
local stageSelect = function()
	if REPLAY then return end
	if stage_selector == -1 then
		return
	end
	if gamestate.curr_state == 0x04 then
		wb(addresses.global.stage_select, stage_selector)
	end
	wb(0xFF8C51,0)
	ww(0xFFE18A,stage_selector)
end
---------------------------
-- Dizzy settings
---------------------------
dizzy_selector = customconfig.dizzy_selector
local p2DizzyControl = function()
	if REPLAY then return end
	local dizzy = 0
	if dizzy_selector == -1 then
		return
	end
	if dizzy_selector == 1 then
		dizzy = 0x40
	end
	ww(0xFF88AA, dizzy) -- timeout
	ww(0xFF88AC, dizzy) -- damage
end

-------------------------------------
-- Round Start Training made by pof
-------------------------------------

roundstart_selector = customconfig.roundstart_selector
local statecount=0
local round_state=-1
local fight_anim = 123
local roundstart_played=false
local roundStart = function()
	if REPLAY then return end

	local DEBUG=false

	if roundstart_selector == -1 then
		return
	end

	local framesrecorded = #recording[recording.recordingslot]
	prev_round_state = round_state
	round_state = rw(0xFF8008) -- 4 -> 6 -> 8 -> 10
	if (framesrecorded < 1) then
		if (round_state >= 4 and round_state < 10) then
			gui.text(220,50,"Use the Replay Editor in the")
			gui.text(220,60,"Recording menu (hold coin) to")
			gui.text(220,70,"program the desired round start action.")
		end
		return
	end
	if (round_state == 10 and prev_round_state == 10) or (round_state ~= 8 and round_state ~= 10) then
		return
	end
	if round_state~=prev_round_state then
		if DEBUG then print("prev_round_state="..prev_round_state.." => round_state="..round_state.." (at "..prev_round_state.." during "..statecount.." frames)") end
		if (round_state == 10) and (prev_round_state ==8) then
			if DEBUG then print("fight_anim: "..fight_anim.." => "..statecount) end
			fight_anim = statecount
		end
		statecount=0
		roundstart_played = false
	end
	statecount=statecount+1
	if (round_state==8) then
		if DEBUG then print("FRAME: "..statecount) end
	end

	if roundstart_selector == 0 and (round_state == 8) and (statecount >= fight_anim - framesrecorded ) and not recording.playback then
		if not roundstart_played then
			if DEBUG then print("PLAYBACK pre-start @ frame "..statecount.."/"..fight_anim.." (framesrecorded="..framesrecorded..")") end
			togglePlayBack(nil, {})
			roundstart_played = true
		end
	end

	if roundstart_selector == 1 and (round_state == 10) and (prev_round_state == 8) and not recording.playback then
		if DEBUG then print("PLAYBACK post-start") end
		togglePlayBack(nil, {})
	end
end

-----------------------------------------------------------
-----------------------------------------------------------
-- Asunaro - Character Specific and Advanced Settings
-----------------------------------------------------------
-----------------------------------------------------------

-----------------------------
-- Advanced Settings
-----------------------------

---------------------------
-- Locking the characters
-- by pressing "Start"
---------------------------
local lock_selector = 0
local locking = {}
locking["P1"] = false
locking["P2"] = false
local p1_locked = false
local p2_locked = false
local p1_lock_distance = 0
local p2_lock_distance = 0
local start_input = false
local prev_start_input = false

local function lockCharacters()
	if REPLAY then return end
	if first_load then
		print("Lock the characters with Start")
	end
	if not gamestate.is_in_match then
		lock_selector = 0
		return
	end

	local joypad = joypad.get()
	start_input = joypad["P1 Start"]

	if start_input then
		prev_start_input = true
	end
	if prev_start_input and not start_input then
		lock_selector = lock_selector + 1
		prev_start_input = false
		p1_locked = false
		p2_locked = false
	end
	if lock_selector > 3 then
		lock_selector = 0
	end

	if lock_selector == 0 then
		locking["P1"] = false
		locking["P2"] = false
	elseif lock_selector == 1 then
		locking["P1"] = true
		locking["P2"] = false
		gui.text(6,7,"P1 Locked")
	elseif lock_selector == 2 then
		locking["P1"] = false
		locking["P2"] = true
		gui.text(342,7,"P2 Locked")
	elseif lock_selector == 3 then
		locking["P1"] = true
		locking["P2"] = true
		gui.text(6,7,"P1 Locked")
		gui.text(342,7,"P2 Locked")
	end

	if locking["P1"] then
		if not p1_locked then
			p1_lock_distance = gamestate.P1.pos_x
		end
		ww(gamestate.P1.addresses.pos_x, p1_lock_distance)
		p1_locked = true
	end
	if locking["P2"] then
		if not p2_locked then
			p2_lock_distance = gamestate.P2.pos_x
		end
		ww(gamestate.P2.addresses.pos_x, p2_lock_distance)
		p2_locked = true
	end
end
------------------------------------
-- Enable/Disable Auto Tech Throws
------------------------------------
tech_throw_selector = customconfig.tech_throw_selector

local function techThrowControl()
	if REPLAY then return end
	if tech_throw_selector == 0 then
		if gamestate.P1.throw_flag == 0x01 then
			modifyInputSet(2,6,5,3)
			wb(gamestate.P2.addresses.grab_break, 0x00) -- will now automatically escape hold throws
		end
	end
end
-----------------------------
-- Enable/Disable frameskip
-----------------------------
frameskip_selector = customconfig.frameskip_selector

local frameskipControl = function()
	if frameskip_selector == -1 then
		setFrameskip(true)
	end
	if frameskip_selector == 0 then
		setFrameskip(false)
	end
end
-----------------------------
-- Enable/Disable projectile
-- impact slowdown
-----------------------------
slowdown_selector = customconfig.slowdown_selector

local slowdownControl = function()
	if REPLAY then return end
	if slowdown_selector == -1 then
		return
	end
	if slowdown_selector == 0 then
		wb(addresses.global.slowdown,0x00)
	end
end
-----------------------------
-- Enable/Disable background music
-----------------------------
nomusic_selector = customconfig.nomusic_selector

local nomusicControl = function()
	if nomusic_selector == -1 then
		memory.writeword_audio(addresses.global.bgmusic,0xE378)
	end
	if nomusic_selector == 0 then
		memory.writeword_audio(addresses.global.bgmusic,0)
	end
end

-----------------------------
-- Enable/Disable easy charge
-----------------------------
local easyCharge = function(_player_obj)
	if _player_obj.character == Honda and _player_obj.is_old then
		wb(_player_obj.base + 0x81, 0x01) --B,F+P
	end
	if _player_obj.character == Honda and _player_obj.is_old and rb(0xAA+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xAB, 0x01) --D,U+K
	end
	if _player_obj.character == Honda and not _player_obj.is_old and rb(0x88+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x89, 0x01) --B,F+P
	end
	if _player_obj.character == Honda and not _player_obj.is_old and rb(0x90+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x91, 0x01) --D,U+K
	end
	if _player_obj.character == Honda and not _player_obj.is_old and rb(0x94+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x95, 0x01) --B,F,B,F+P
	end
 ------------------------------------
	if _player_obj.character == Blanka then
		wb(_player_obj.base + 0x81, 0x01) --B,F+P
		wb(_player_obj.base + 0xB4, 0x01) --D,U+K
		wb(_player_obj.base + 0xBA, 0x01) --B,F+K
		wb(_player_obj.base + 0xC2, 0x01) --B,F,B,F+P
	end
------------------------------------
	if _player_obj.character == Guile then
		wb(_player_obj.base + 0x81, 0x01) --B,F+P
		wb(_player_obj.base + 0x87, 0x01) --D,U+K
		wb(_player_obj.base + 0x95, 0x01) --D,F,B,U+K
	end
------------------------------------
	if _player_obj.character == Chun then
		wb(_player_obj.base + 0x81, 0x01) --B,F+P
	end
	if _player_obj.character == Chun and rb(0xB0+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xB1, 0x01) --B,F,B,F+K
	end
	if _player_obj.character == Chun and rb(0xBA+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xBB, 0x01) --D,U+K
	end
	if _player_obj.character == Chun and rb(0xBF+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xC0, 0x01) --B,F+K
	end
------------------------------------
	if _player_obj.character == Dictator then
		wb(_player_obj.base + 0x81, 0x01) --B,F+P
		wb(_player_obj.base + 0x89, 0x01) --B,F+K
		wb(_player_obj.base + 0x92, 0x01) --D,U+K
		wb(_player_obj.base + 0xC6, 0x01) --B,F,B,F+K
	end
	if _player_obj.character == Dictator and rb(0xAC+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xAD, 0x01) --D,U+P
	end
------------------------------------
	if _player_obj.character == Boxer then
		wb(_player_obj.base + 0x81, 0x01)  --B,F+P
		wb(_player_obj.base + 0x89, 0x01)  --B,F+K
		wb(_player_obj.base + 0xC1, 0x01)  --D,U+P
		wb(_player_obj.base + 0xD7, 0x01)  --B,DF+P
		wb(_player_obj.base + 0xDE, 0x01)  --B,DF+K
	end
	if _player_obj.character == Boxer and not _player_obj.is_old and rb(0xD4+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xD5, 0x01)--B,F,B,F+P
	end
------------------------------------
	if _player_obj.character == Claw and rb(0x88+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x89, 0x01)--B,F+P
	end
	if _player_obj.character == Claw and rb(0x8C+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x8D, 0x01)--D,U+K
	end
	if _player_obj.character == Claw and rb(0x90+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x91, 0x01)--D,U+P
	end
	if _player_obj.character == Claw and rb(0x99+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x9A, 0x01)--D,F,B,U+K
	end
	if _player_obj.character == Claw and rb(0x9D+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x9E, 0x01)--DB,F+K
	end
------------------------------------
	if _player_obj.character == Deejay and rb(0x92+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x93, 0x01) --B,F+K
	end
	if _player_obj.character == Deejay and rb(0x96+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0x97, 0x01) --D,U+P
	end
	if _player_obj.character == Deejay and rb(0xA6+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xA7, 0x01) --B,F+P
	end
	if _player_obj.character == Deejay and rb(0xAB+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xAC, 0x01) --D,U+K
	end
	if _player_obj.character == Deejay and rb(0xAF+_player_obj.base) <= 0x02 then
		wb(_player_obj.base + 0xB0, 0x01) --B,F,B,F+K
	end
end
-------------------------------
easy_charge_moves_selector = customconfig.easy_charge_moves_selector

local easyChargeControl = function ()
	if REPLAY then return end
	if easy_charge_moves_selector == 0 or easy_charge_moves_selector == 2 then
		easyCharge(gamestate.P1)
	end
	if easy_charge_moves_selector == 1 or easy_charge_moves_selector == 2 then
		easyCharge(gamestate.P2)
	end
end

-------------------------------------------
-- Enable/Disable Frame Advantage Display
-------------------------------------------
gamestate.P1.hitfreeze_end = false
gamestate.P2.hitfreeze_end = false
gamestate.P1.in_hitstun = false
gamestate.P2.in_hitstun = false

local function readInHitstun(_player_obj) -- Tells if the player_object is in hitstun or blockstun (return false if in hitfreeze)
	local DEBUG = false

	if _player_obj.hitfreeze_counter == 0 and _player_obj.prev.in_hitfreeze then
		_player_obj.hitfreeze_end = true
	else
		_player_obj.hitfreeze_end = false
	end

	if gamestate.prev.frame_number ~= gamestate.frame_number then
		if (_player_obj.prev.hitstun_counter ~= _player_obj.hitstun_counter and _player_obj.hitfreeze_counter == 0) or (_player_obj.state == being_hit and rb(addresses.global.slowdown) ~= 0x00) or (_player_obj.hitfreeze_end == true and _player_obj.state == being_hit) then
			_player_obj.in_hitstun = true
		else
			_player_obj.in_hitstun = false
		end
	end

	if DEBUG then
		gui.text(20,70,"Hitfreeze Counter P1 	 : "..gamestate.P1.hitfreeze_counter)
		gui.text(20,80,"Hitfreeze State P1   	 : "..str(gamestate.P1.in_hitfreeze))
		gui.text(20,90,"Hit/Blockstun Counter P1 : "..gamestate.P1.hitstun_counter)
		gui.text(20,100,"Hitstun/Blockstun P1	 : "..str(gamestate.P1.in_hitstun))

		gui.text(230,70,"Hitfreeze Counter P2 	  : "..gamestate.P2.hitfreeze_counter)
		gui.text(230,80,"Hitfreeze State P2   	  : "..str(gamestate.P2.in_hitfreeze))
		gui.text(230,90,"Hit/Blockstun Counter P2 : "..gamestate.P2.hitstun_counter)
		gui.text(230,100,"Hitstun/Blockstun P2	  : "..str(gamestate.P2.in_hitstun))
	end
end

gamestate.P1.is_knockdown = false
gamestate.P2.is_knockdown = false

local function readKnockdown(_player_obj)
	if _player_obj.air_state == 255 or _player_obj.state == being_thrown then
		_player_obj.is_knockdown = true
	end
	if _player_obj.is_knockdown then
		if _player_obj.state ~= being_hit and _player_obj.state ~= being_thrown then
			_player_obj.is_knockdown = false
		end
	end
end

frame_advantage_selector = customconfig.frame_advantage_selector

local step = 0
local calculation_end = false
local frame_advantage = 0
local frame_disadvantage = 0
local frame_addition = 0
local frame_advantage_result = 0
local frame_advantage_msg_fcount = 0
-- Read the kind of move performed
local projectile_hit = false
local projectile_duel = false
local knockdown = false
local successful_throw = false
local teched_throw = false
-- Help to continue the calculation even if the attacker is performing other actions after hitting the dummy
local projectile_move_ended = false
local attacker_duel_projectile_move_ended = false
local defender_duel_projectile_move_ended = false
local general_sequence_ended = false
local knockdown_sequence_ended = false
local throw_ended = false

local throw_exception = false

local function frameAdvantageDisplay()
	if not gamestate.is_in_match then
		return
	end

	if frame_advantage_selector > -1 then
		-------------------
		-- Initialization
		-------------------
		local DEBUG = false
		local attacker = {}
		local defender = {}
		local player = ""
		
		if frame_advantage_selector == 0 then
			attacker = gamestate.P1
			defender = gamestate.P2
			player = "P1"
		elseif frame_advantage_selector == 1 then
			attacker = gamestate.P2
			defender = gamestate.P1
			player = "P2"
		end
		-------------------
		-- Reset (new hit)
		-------------------
		 -- not a projectile
		if attacker.in_hitfreeze and defender.in_hitfreeze and not throw_exception and not defender.is_attacking then
			--
			frame_advantage = 0
			frame_disadvantage = 0
			--
			projectile_hit = false
			projectile_duel = false
			knockdown = false
			successful_throw = false
			teched_throw = false
			--
			general_sequence_ended = false
			projectile_move_ended = false
			attacker_duel_projectile_move_ended = false
			defender_duel_projectile_move_ended = false
			knockdown_sequence_ended = false
			throw_ended = false
			--
			if DEBUG then print("Reset : hit (not a projectile)") end
			step = 1
		end
		-- projectile
		if not attacker.projectile_ready and not attacker.in_hitfreeze and defender.in_hitfreeze then -- projectile
			--
			frame_advantage = 0
			frame_disadvantage = 0
			--
			projectile_hit = true
			projectile_duel = false
			knockdown = false
			successful_throw = false
			teched_throw = false
			--
			general_sequence_ended = false
			projectile_move_ended = false
			attacker_duel_projectile_move_ended = false
			defender_duel_projectile_move_ended = false
			knockdown_sequence_ended = false
			throw_ended = false
			--
			if DEBUG then print("Reset : hit (projectile)") end
			step = 1
		end

		if not attacker.prev.projectile_ready and not defender.prev.projectile_ready then -- Sometimes it won't trigger because of the frameskip, maybe we'll have to find a fix
			if attacker.projectile_ready and defender.projectile_ready then
			--
			frame_advantage = 0
			frame_disadvantage = 0
			--
			projectile_hit = false
			projectile_duel = true
			knockdown = false
			successful_throw = false
			teched_throw = false
			--
			general_sequence_ended = false
			projectile_move_ended = false
			attacker_duel_projectile_move_ended = false
			defender_duel_projectile_move_ended = false
			knockdown_sequence_ended = false
			throw_ended = false
			--
			if DEBUG then print("Reset : projectile duel") end
			step = 1
			end
		end
		-- throw
		if attacker.throw_flag == 0x01 then
			if attacker.character == Guile or attacker.character == Cammy or attacker.character == Zangief or attacker.character == Hawk then
				throw_exception = true -- Those characters can trigger hitfreeze with their throws
			end
		end
		if attacker.prev.throw_flag == 0x01 and attacker.throw_flag == 0x00 then
			if defender.state == being_thrown and defender.prev.state ~= being_thrown then
				if DEBUG then print("Reset : throw (successful)") end
				successful_throw = true
				teched_throw = false
			elseif defender.state == being_hit and defender.prev.state ~= being_hit then
				if DEBUG then print("Reset : throw (teched)") end
				teched_throw = true
				successful_throw = false
			end
			--
			frame_advantage = 0
			frame_disadvantage = 0
			--
			projectile_hit = false
			projectile_duel = false
			knockdown = false
			--
			general_sequence_ended = false
			projectile_move_ended = false
			attacker_duel_projectile_move_ended = false
			defender_duel_projectile_move_ended = false
			knockdown_sequence_ended = false
			throw_ended = false
			--
			step = 1
			--end
		end
		----------------
		-- Calculation
		----------------
		if step == 1 then
			frame_advantage_result = ""
			frame_advantage_msg_fcount = 0
			-- Display frameskip
			if DEBUG then
				if gamestate.prev.frame_number ~= gamestate.frame_number then
					if was_frameskip then
						frame_addition = 2
					else
						frame_addition = 1
					end
				end
			end
		----------------------
		-- Frame Advantage
		----------------------
			-- Projectile : We'll add hitfreeze to frame advantage
			if projectile_hit then
				if not attacker.is_attacking and defender.state == being_hit then -- problem : if P1 performs an attack right when the hitfreeze begins the count won't be exact
					projectile_move_ended = true
				end
				if defender.in_hitfreeze and projectile_move_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Hitfreeze)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			if projectile_duel then
				if not attacker.is_attacking then
					attacker_duel_projectile_move_ended = true
				end
				if not defender.is_attacking then
					defender_duel_projectile_move_ended = true
				end
				if attacker_duel_projectile_move_ended and not defender_duel_projectile_move_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Projectile Duel)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			-- Throw
			if successful_throw or teched_throw then
				if attacker.throw_flag == 0x00 and attacker.state ~= 0x0A and attacker.state ~= doing_special_move and attacker.substate ~= 0x04 then
					throw_ended = true
				end
				if throw_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Throw)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			-- Knockdown / Air recovery
			if defender.air_state == 255 then -- Knockdown or Air recovery
				knockdown = true
			end
			if not teched_throw and knockdown then
				if not attacker.is_attacking then
					knockdown_sequence_ended = true
				end
				if knockdown_sequence_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Knockdown/Air recovery)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			-- Normal moves / Non-projectile specials / Projectiles (when P2 hitfreeze ends)
			if defender.in_hitstun then
				if not knockdown and not attacker.is_attacking then
					general_sequence_ended = true
				end
				if general_sequence_ended or projectile_move_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Hit/blockstun)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			-------------------------
			-- Frame Disadvantage
			-------------------------
			if not defender.in_hitstun then
				if not successful_throw and not teched_throw and not knockdown and not projectile_move_ended and not projectile_duel and not general_sequence_ended then
					if attacker.is_attacking and not defender.in_hitfreeze then
						if DEBUG then print("Disadvantage + "..frame_addition) end
						frame_disadvantage = countFrames(frame_disadvantage)
					end
				end
			end
			if projectile_duel then
				if not attacker_duel_projectile_move_ended and defender_duel_projectile_move_ended then
					if DEBUG then print("Disadvantage + "..frame_addition) end
					frame_disadvantage = countFrames(frame_disadvantage)
				end
			end
			--------------------------
			-- Knowing when to end
			--------------------------
			if projectile_duel then
				if attacker_duel_projectile_move_ended and defender_duel_projectile_move_ended then
					if DEBUG then print("End (Projectile duel) : Both players have finished their moves") end
					calculation_end = true
				end
			elseif not knockdown and not successful_throw and not teched_throw then
				if not attacker.is_attacking and not defender.in_hitfreeze and not defender.in_hitstun then
					if DEBUG then print("End (General) : Defender is not in hitfreeze/hitstun/blockstun anymore") end
					calculation_end = true
				end
			elseif knockdown then
				if defender.prev.state == being_hit and defender.state ~= being_hit then
					if DEBUG then print("End (Knockdown/Air recovery) : Defender has landed on his feet") end
					calculation_end = true
				end
			elseif successful_throw then
				if defender.prev.state == being_thrown and defender.state ~= being_thrown then
					if DEBUG then print("End (Successful Throw) : Defender has recovered from the throw") end
					calculation_end = true
				end
			elseif teched_throw then
				if defender.prev.state == being_hit and defender.state ~= being_hit then
					if DEBUG then print("End (Teched Throw) : Defender has recovered from the throw") end
					calculation_end = true
				end
			end
		end
		----------------------------------------------
		----------------------------------------------
		if calculation_end then
			step = 0
			-- just to be sure, but maybe we should delete these lines
			projectile_hit = false
			knockdown = false
			successful_throw = false
			teched_throw = false

			general_sequence_ended = false
			projectile_move_ended = false
			projectile_duel = false
			attacker_duel_projectile_move_ended = false
			defender_duel_projectile_move_ended = false
			knockdown_sequence_ended = false
			throw_ended = false
			throw_exception = false
			--------------------------------
			if frame_disadvantage > 0 then
				frame_advantage_result = "-"..frame_disadvantage
				frame_advantage_msg_fcount = MSG_FRAMELIMIT-120
			else
				frame_advantage_result = "+"..frame_advantage
				frame_advantage_msg_fcount = MSG_FRAMELIMIT-120
			end
			calculation_end = false
		end
		
		if frame_advantage_msg_fcount >= MSG_FRAMELIMIT then
			frame_advantage_result = ""
			frame_advantage_msg_fcount = 0
		elseif frame_advantage_msg_fcount > 0 then
			frame_advantage_msg_fcount = countFrames(frame_advantage_msg_fcount)
		end
		gui.text(140,216,"Frame Advantage ("..player..") : "..frame_advantage_result)

		if DEBUG then
			gui.text(230,50,"Frame advantage : "..frame_advantage)
			gui.text(230,60,"Frame disadvantage : "..frame_disadvantage)

			gui.text(10,50,"Att. state : "..attacker.state)
			gui.text(10,60,"Att. substate : "..attacker.substate)
			gui.text(10,70,"Att. attacking : "..str(attacker.is_attacking))
			gui.text(10,80,"Att. throw : "..attacker.throw_flag)


			gui.text(120,50,"Def. state : "..defender.state)
			gui.text(120,60,"Def. substate : "..defender.substate)
			gui.text(120,70,"Def. hitfreeze : "..str(defender.in_hitfreeze))
			gui.text(120,80,"Def. hitstun : "..str(defender.in_hitstun))
		end
	end
end

---------------------------------------
-- Enable/Disable Frame Trap Display
-- (when the dummy goes out of blockstun/hitstun,
-- counts how many frames
-- are left before a new hit happens)
---------------------------------------
frame_trap_selector = customconfig.frame_trap_selector

local frame_trap_step = {0,0}
local frame_trap_timer = {0,0}
local post_first_hit = {false, false}
local frame_trap_calculated = {{false,false,false,false,false,false},{false,false,false,false,false,false}}
local frame_trap_result = {{"","","","","",""},{"","","","","",""}}
local frame_trap_calculation_end = {false,false}
local frame_trap_reset = {false,false}
local nb_calculation = {1,1}

local function frameTrapAnalysis(_player_obj)
	if not gamestate.is_in_match then
		return
	end
	---------------------
	-- Initialization
	---------------------
	local DEBUG = false

	if DEBUG then
		gui.text(40,120,"P1 Step : "..frame_trap_step[1])
		gui.text(40,130,"P1 Reset : "..str(frame_trap_reset[1]))
		gui.text(40,140,"P1 Frame trap calculation end :"..str(frame_trap_calculation_end[1]))
		gui.text(40,150,"P2 State : "..gamestate.P2.state)

		gui.text(230,120,"P2 Step : "..frame_trap_step[2])
		gui.text(230,130,"P2 Reset : "..str(frame_trap_reset[2]))
		gui.text(230,140,"P2 Frame trap calculation end :"..str(frame_trap_calculation_end[2]))
		gui.text(230,150,"P1 State : "..gamestate.P1.state)
	end

	local attacker = _player_obj
	local defender = {}
	if attacker.id == 1 then
		defender = gamestate.P2
	elseif attacker.id == 2 then
		defender = gamestate.P1
	end
	-----------------------
	-- Begin/Reset
	-----------------------
	if frame_trap_step[attacker.id] == 0 and defender.in_hitstun then
		-- begin
		frame_trap_step[attacker.id] = 1
		frame_trap_timer[attacker.id] = 0
		-- reset
		if frame_trap_calculated[attacker.id][#frame_trap_calculated[attacker.id]] or frame_trap_reset[attacker.id] then
			for i = 1, #frame_trap_calculated[attacker.id] do
				frame_trap_calculated[attacker.id][i] = false
			end
			for i = 1, #frame_trap_result[attacker.id] do
				frame_trap_result[attacker.id][i] = ""
			end
			nb_calculation[attacker.id] = 1
			post_first_hit[attacker.id] = false
			frame_trap_reset[attacker.id] = false
		end
	end
	-------------------------
	-- Calculation
	-------------------------
	if frame_trap_step[attacker.id] == 1 then
		if defender.in_hitstun then
			post_first_hit[attacker.id] = true
		end
		if defender.state ~= being_hit then
			frame_trap_timer[attacker.id] = countFrames(frame_trap_timer[attacker.id])
			if not frame_trap_calculated[attacker.id][nb_calculation[attacker.id]] then
				frame_trap_result[attacker.id][nb_calculation[attacker.id]] = frame_trap_timer[attacker.id]
			end
		end
		if defender.in_hitfreeze then
			if post_first_hit[attacker.id] and frame_trap_timer[attacker.id] == 0 and defender.combo_counter == 0x00 and defender.air_state ~= 255 then
				if not frame_trap_calculated[attacker.id][nb_calculation[attacker.id]] then
					frame_trap_result[attacker.id][nb_calculation[attacker.id]] = "blockstring"
				end
				frame_trap_calculation_end[attacker.id] = true
			end
		end
		if defender.state == being_hit or attacker.throw_flag == 0x01 then -- If we detect a new hit or a throw
			if frame_trap_timer[attacker.id] ~= 0 then
				if not frame_trap_calculated[attacker.id][nb_calculation[attacker.id]] then
					frame_trap_result[attacker.id][nb_calculation[attacker.id]] = frame_trap_timer[attacker.id]
				end
				frame_trap_calculation_end[attacker.id] = true
			end
		end
	end

	if frame_trap_calculation_end[attacker.id] then
		if not frame_trap_calculated[attacker.id][nb_calculation[attacker.id]] then
			frame_trap_calculated[attacker.id][nb_calculation[attacker.id]] = true
		end
		if not frame_trap_calculated[attacker.id][#frame_trap_calculated[attacker.id]] then
			frame_trap_step[attacker.id] = 0
		else
			frame_trap_step[attacker.id] = -1
		end
		if frame_trap_reset[attacker.id] then
			frame_trap_step[attacker.id] = -1
		end
		nb_calculation[attacker.id] = nb_calculation[attacker.id] + 1
		if nb_calculation[attacker.id] > #frame_trap_calculated[attacker.id] then
			nb_calculation[attacker.id] = 1
		end

		frame_trap_timer[attacker.id] = 0
		post_first_hit[attacker.id] = false
		frame_trap_calculation_end[attacker.id] = false
	end

	if frame_trap_step[attacker.id] == -1 and (defender.state ~= being_hit and defender.state ~= being_thrown) then
		frame_trap_step[attacker.id] = 0
	end

	if (frame_trap_timer[attacker.id] >= 50 and frame_trap_step[attacker.id] == 1) or (defender.air_state == 255 or attacker.throw_flag == 0x01) then
		frame_trap_step[attacker.id] = -1
		frame_trap_timer[attacker.id] = 0
		frame_trap_reset[attacker.id] = true
		if not frame_trap_calculated[attacker.id][nb_calculation[attacker.id]] then
			frame_trap_result[attacker.id][nb_calculation[attacker.id]] = ""
		end
	end
	----------------------
	-- Display
	----------------------
	local x = 0
	local y = 100
	if attacker.id == 1 then
		x = inputs.properties.scrollinginput.scrollinginputxoffset[1] + 90
	elseif attacker.id == 2 then
		x = inputs.properties.scrollinginput.scrollinginputxoffset[2] - 90
	end
	if frame_trap_calculated[attacker.id][#frame_trap_calculated[attacker.id]] then
		for i = 1, #frame_trap_calculated[attacker.id] do
			gui.text(x,y+10*i,"Gap "..i.." : "..frame_trap_result[attacker.id][i])
		end
	elseif frame_trap_reset[attacker.id] then
		for i = 1, #frame_trap_calculated[attacker.id] do
			if frame_trap_calculated[attacker.id][i] then
				gui.text(x,y+10*i,"Gap "..i.." : "..frame_trap_result[attacker.id][i])
			end
		end
	else
		for i = 1, nb_calculation[attacker.id] do
			if frame_trap_result[attacker.id][i] ~= "" then
				gui.text(x,y+10*i,"Gap "..i.." : "..frame_trap_result[attacker.id][i])
			end
		end
	end
end

local function frameTrapDisplay()
	if frame_trap_selector == 0 then
		frameTrapAnalysis(gamestate.P1)
		frameTrapAnalysis(gamestate.P2)
	end
end
-------------------------
-- Tick Throw
-------------------------
tick_throw_display_selector = customconfig.tick_throw_display_selector

local tick_step = {0,0}
local tick_timer = {0,0}
local throwable_timer = {0,0}
local reset_tick = {false,false}

local function tickThrow(_player_obj)
	-------------------
	-- Initialization
	-------------------
	local attacker = _player_obj
	local defender = {}
	if attacker.id == 1 then
		defender = gamestate.P2
	else
		defender = gamestate.P1
	end
	--------------------
	-- Reset
	--------------------
	if reset_tick[attacker.id] then
		tick_step[attacker.id] = 0
		tick_timer[attacker.id] = 0
		throwable_timer[attacker.id] = 0
		reset_tick[attacker.id] = false
	end
	---------------------
	-- Count
	---------------------
	if tick_step[attacker.id] == 0 and defender.in_hitstun and attacker.throw_flag == 0x00 then
		tick_step[attacker.id] = 1
		tick_timer[attacker.id] = 0
	elseif tick_step[attacker.id] == 1 then
		if defender.state ~= being_hit then
			tick_timer[attacker.id] = countFrames(tick_timer[attacker.id])
		end
		if tick_timer[attacker.id] > 12 or defender.in_hitfreeze then
			reset_tick[attacker.id] = true
		end
		if attacker.throw_flag == 0x01 then -- If we detect a throw after a tick, return true
			reset_tick[attacker.id] = true
			return true, tick_timer[attacker.id]
		end
	end
	-- return false if _player_obj did not tick throw
	return false
end

local p1_throw_range = {}
local p2_throw_range = {}
local could_have_been_thrown = {false,false}
local begin_throw_display = false
local buffersize_modified = false
msg_tick_throw = true

local function resetThrowDisplay(_player_obj)
	-- Display the correct Boxer throw distance
	if gamestate.P1.character == Boxer then
		getBoxerThrowDistance(gamestate.P2.character)
	elseif gamestate.P2.character == Boxer then
		getBoxerThrowDistance(gamestate.P1.character)
	end
	-- Reset throw range values
	local character = readCharacterName(_player_obj)
	if _player_obj.id == 1 then
		for i = 1, #p1_throw_range do
			p1_throw_range[i] = nil
		end
		for i = 1, #character_specific[character].hitboxes.throw do
			p1_throw_range[i] = {"", 0, nil}
			p1_throw_range[i][1] = character_specific[character].hitboxes.throw[i][1]
		end
	elseif _player_obj.id == 2 then 
		for i = 1, #p2_throw_range do
			p2_throw_range[i] = nil
		end
		for i = 1, #character_specific[character].hitboxes.throw do
			p2_throw_range[i] = {"", 0, nil}
			p2_throw_range[i][1] = character_specific[character].hitboxes.throw[i][1]
		end
	end
	-- Modify buffersize in scrolling-input-display, this way inputs won't overlap with the informations drawn
	if gamestate.P1.character == Zangief or gamestate.P2.character == Zangief then
		buffersize = 9
		scrollingInputClear()
		buffersize_modified = true
	else
		buffersize = 13
	end
end

local function throwInformationsDisplay()
	-- Throw Display initialization
	local p1character = readCharacterName(gamestate.P1)
	local p2character = readCharacterName(gamestate.P2)
	if characterChanged(gamestate.P1) then
		resetThrowDisplay(gamestate.P1)
	end
	if characterChanged(gamestate.P2) then
		resetThrowDisplay(gamestate.P2)
	end
	if gamestate.is_in_match then
		-- Get Throw Informations
		if gamestate.P1.throw_flag == 0x00 and gamestate.P2.throw_flag == 0x00 then
			-- P1 throw range
			if gamestate.P1.flip_input then
				for i = 1, #character_specific[p1character].hitboxes.throw do
					p1_throw_range[i][2] = (gamestate.P1.pos_x + character_specific[p1character].hitboxes.throw[i][2]) - (gamestate.P2.pos_x - character_specific[p2character].hitboxes.throwable)
				end
			else
				for i = 1, #character_specific[p1character].hitboxes.throw do
					p1_throw_range[i][2] = (gamestate.P2.pos_x + character_specific[p2character].hitboxes.throwable) - (gamestate.P1.pos_x - character_specific[p1character].hitboxes.throw[i][2])
				end
			end
			-- P2 throw range
			if gamestate.P2.flip_input then
				for i = 1, #character_specific[p2character].hitboxes.throw do
					p2_throw_range[i][2] = (gamestate.P2.pos_x + character_specific[p2character].hitboxes.throw[i][2]) - (gamestate.P1.pos_x - character_specific[p1character].hitboxes.throwable)
				end
			else
				for i = 1, #character_specific[p2character].hitboxes.throw do
					p2_throw_range[i][2] = (gamestate.P1.pos_x + character_specific[p1character].hitboxes.throwable) - (gamestate.P2.pos_x - character_specific[p2character].hitboxes.throw[i][2])
				end
			end
			-- Can P1 throw ?
			for i = 1, #p1_throw_range do
				if p1_throw_range[i][2] >= 0 then
					p1_throw_range[i][3] = true
					if (tick_step[2] == 1) and (gamestate.P1.state == standing or gamestate.P1.state == blocking_attempt or gamestate.P1.state == doing_normal_move or gamestate.P1.state == doing_special_move or gamestate.P1.state == 0x06) and (gamestate.P2.state ~= being_hit or gamestate.P2.state ~= being_thrown) then
						throwable_timer[2] = countFrames(throwable_timer[2])
					end
				else
					p1_throw_range[i][3] = false
				end
			end
			-- Can P2 throw ?
			for i = 1, #p2_throw_range do
				if p2_throw_range[i][2] >= 0 then
					p2_throw_range[i][3] = true
					if (tick_step[1] == 1) and (gamestate.P2.state == standing or gamestate.P2.state == blocking_attempt or gamestate.P2.state == doing_normal_move or gamestate.P2.state == doing_special_move or gamestate.P2.state == 0x06) and (gamestate.P1.state ~= being_hit or gamestate.P1.state ~= being_thrown) then
						throwable_timer[1] = countFrames(throwable_timer[1])
					end
				else
					p2_throw_range[i][3] = false
				end
			end
		end
		-- Informations at the bottom of the screen
		-- P1
		gui.text(85,165,"P1")
		for i = 1, #p1_throw_range do
			local column = 1
			if i > 3 then column = 2 end
			local line = (i%3)
			if line == 0 then line = 3 end
			local x_base = 0
			if #p1_throw_range > 3 then x_base = -88 else x_base = -15 end
			local x = x_base+100*column
			local y = 165 + 10*line
			if not p1_throw_range[i][3] then
				gui.text(x,y,p1_throw_range[i][1].." : "..p1_throw_range[i][2])
			else
				gui.text(x,y,p1_throw_range[i][1].." : OK (+"..p1_throw_range[i][2]..")")
			end
		end
		-- P2
		gui.text(265,165,"P2")
		for i=1, #p2_throw_range do
			local column = 1
			if i > 3 then column = 2 end
			local line = (i%3)
			if line == 0 then line = 3 end
			local x_base = 0
			if #p2_throw_range > 3 then x_base = 102 else x_base = 165 end
			local x = x_base+100*column
			local y = 165 + 10*line
			if not p2_throw_range[i][3] then
				gui.text(x,y,p2_throw_range[i][1].." : "..p2_throw_range[i][2])
			else
				gui.text(x,y,p2_throw_range[i][1].." : OK (+"..p2_throw_range[i][2]..")")
			end
		end
	end
end

local function tickThrowAnalysis(_player_obj)
	if gamestate.is_in_match then
		--------------------
		-- Initialization
		--------------------
		local attacker = _player_obj
		local defender = {}
		defender_throw_range = {}
		if attacker.id == 1 then
			defender = gamestate.P2
			defender_throw_range = p2_throw_range
		elseif attacker.id == 2 then
			defender = gamestate.P1
			defender_throw_range = p1_throw_range
		end
		---------------------
		-- Tick analysis
		---------------------
		if tickThrow(attacker) and msg_tick_throw then
			if attacker.id == 1 then
				msg1 = "Succesful tick throw: you threw "..tick_timer[attacker.id].." frames after your tick."
			elseif attacker.id == 2 then
				msg1 = "Succesful tick throw: P2 threw "..tick_timer[attacker.id].." frames after their tick."
			end
			msg_fcount = MSG_FRAMELIMIT-220
		end
		if attacker.throw_flag == 0x01 and tick_timer[attacker.id] > 0 and tick_timer[attacker.id] <= 12 then -- If the attacker did a tick
			for i = 1, #defender_throw_range do
				if defender_throw_range[i][3] then -- If the defender could have thrown
					could_have_been_thrown[attacker.id] = true
				end
			end
			if could_have_been_thrown[attacker.id] then
				if throwable_timer[attacker.id] == 0 then
					throwable_timer[attacker.id] = 1
				else
					throwable_timer[attacker.id] = countFrames(throwable_timer[attacker.id])
				end
			end
			if msg_tick_throw then
				if (not could_have_been_thrown[attacker.id]) and (throwable_timer[attacker.id] > 0) then
					if attacker.id == 1 then
						msg2 = "P2 could've thrown for "..throwable_timer[attacker.id].." frames, but you threw outside of P2 range."
					elseif attacker.id == 2 then
						msg2 = "You could've thrown for "..throwable_timer[attacker.id].." frames, but P2 threw outside of your range."
					end
				elseif (not could_have_been_thrown[attacker.id]) or (throwable_timer[attacker.id] == 0) then
					if attacker.id == 1 then
						msg2 = "P2 couldn't have thrown you. Nice!"
					elseif attacker.id == 2 then
						msg2 = "You couldn't have thrown P2!"
					end
				elseif could_have_been_thrown[attacker.id] and (throwable_timer[attacker.id] >= tick_timer[attacker.id]) then
					if attacker.id == 1 then
						msg2 = "However P2 could have thrown you :("
					elseif attacker.id == 2 then
						msg2 = "However you could have thrown them!"
					end
				elseif could_have_been_thrown[attacker.id] and (throwable_timer[attacker.id] < tick_timer[attacker.id]) then
					if attacker.id == 1 then
						msg2 = "However P2 could have thrown you during "..throwable_timer[attacker.id].." frames :("
					elseif attacker.id == 2 then
						msg2 = "However you could have thrown them during "..throwable_timer[attacker.id].." frames!"
					end
				end
				msg_fcount = MSG_FRAMELIMIT-300
			end
			could_have_been_thrown[attacker.id] = false
		end
	end
end

local function tickThrowDisplay()
	if tick_throw_display_selector == -1 then
		begin_throw_display = false
		if buffersize_modified then -- Can I simply write "buffersize = 13" every frame ? What is the most efficient ?
			buffersize = 13
			buffersize_modified = false
		end
	else
		if not begin_throw_display then
			resetThrowDisplay(gamestate.P1)
			resetThrowDisplay(gamestate.P2)
			begin_throw_display = true
		end
		throwInformationsDisplay()
		tickThrowAnalysis(gamestate.P1)
		tickThrowAnalysis(gamestate.P2)
	end
end
---------------------------------
-- Crossup Display
---------------------------------
crossup_display_selector = customconfig.crossup_display_selector

local begin_crossup_display = {false,false}
local jump_crossup_attempt = {false,false}
local ground_crossup_attempt = {false,false}
local special_crossup_attempt = {false,false}
local prev_flip_value = {nil,nil}
local prev_attacker_left_side = {false,false}
local did_not_crossup = {false,false}
local block_direction = {"",""}

local function crossupAnalysis(_player_obj)
	---------------------
	-- Initialization
	---------------------
	local DEBUG = false
	local attacker = _player_obj
	local defender = {}
	if attacker.id == 1 then
		defender = gamestate.P2
	elseif attacker.id == 2 then
		defender = gamestate.P1
	end
	---------------------
	-- Analysis
	---------------------
	if gamestate.is_in_match then
		if DEBUG then
			gui.text(250,80, "Def. Flip Input : "..str(defender.flip_input))
			gui.text(250,90, "Def. Hitfreeze counter : "..defender.hitfreeze_counter)
			if defender.flip_input then
				block_direction[attacker.id] = "left"
			else
				block_direction[attacker.id] = "right"
			end
		end
		if gamestate.frame_number ~= gamestate.prev.frame_number then
			if begin_crossup_display[attacker.id] then
				-- Correcting some attemps mislabeled
				if ground_crossup_attempt[attacker.id] and (attacker.character == Claw and attacker.state == doing_special_move and attacker.airborn) then 
					if DEBUG then
						print("Claw Flying move -> Correcting : Special crossup attempt")
					end
					begin_crossup_display[attacker.id] = false
					prev_flip_value[attacker.id] = nil
					jump_crossup_attempt[attacker.id] = false
					ground_crossup_attempt[attacker.id] = false
					special_crossup_attempt[attacker.id] = true
				end
				-- Reseting
				if jump_crossup_attempt[attacker.id] and ((attacker.prev.state == jumping and attacker.state ~= jumping) or (defender.prev.state == jumping and (defender.state == being_hit or defender.state == being_thrown))) then
					if DEBUG then
						print("Reset (Jump)")
					end
					begin_crossup_display[attacker.id] = false
					prev_flip_value[attacker.id] = nil
					jump_crossup_attempt[attacker.id] = false
					ground_crossup_attempt[attacker.id] = false
					special_crossup_attempt[attacker.id] = false
				elseif ground_crossup_attempt[attacker.id] and not attacker.is_attacking then
					if DEBUG then
						print("Reset (Ground)")
					end
					begin_crossup_display[attacker.id] = false
					prev_flip_value[attacker.id] = nil
					jump_crossup_attempt[attacker.id] = false
					ground_crossup_attempt[attacker.id] = false
					special_crossup_attempt[attacker.id] = false
				elseif special_crossup_attempt[attacker.id] and attacker.prev.state == doing_special_move and attacker.state ~= doing_special_move then
					if DEBUG then
						print("Reset (Special)")
					end
					begin_crossup_display[attacker.id] = false
					prev_flip_value[attacker.id] = nil
					jump_crossup_attempt[attacker.id] = false
					ground_crossup_attempt[attacker.id] = false
					special_crossup_attempt[attacker.id] = false
				end
			end

			if not begin_crossup_display[attacker.id] then
				if special_crossup_attempt[attacker.id] then
					if attacker.character == Claw then
						if attacker.prev.is_attacking and not attacker.is_attacking then -- Claw did bounce against a wall
							begin_crossup_display[attacker.id] = true
							prev_attacker_left_side[attacker.id] = isCharacterLeft(attacker)
							did_not_crossup[attacker.id] = false
						end
					end
				elseif attacker.state == jumping and attacker.prev.state ~= jumping then
					jump_crossup_attempt[attacker.id] = true
					begin_crossup_display[attacker.id] = true
					prev_attacker_left_side[attacker.id] = isCharacterLeft(attacker)
					did_not_crossup[attacker.id] = false
					if DEBUG then
						print("Jump crossup attempt")
					end
				elseif attacker.is_attacking and attacker.prev.state ~= jumping and attacker.throw_flag ~= 0x01 and defender.state ~= being_thrown then
					ground_crossup_attempt[attacker.id] = true -- slides etc.
					begin_crossup_display[attacker.id] = true
					prev_attacker_left_side[attacker.id] = isCharacterLeft(attacker)
					did_not_crossup[attacker.id] = false
					if DEBUG then
						print("Ground crossup attempt")
					end
				end
			end

			if begin_crossup_display[attacker.id] then
				if prev_flip_value[attacker.id] == nil then
					if jump_crossup_attempt[attacker.id] or special_crossup_attempt[attacker.id] then
						prev_flip_value[attacker.id] = not isCharacterLeft(attacker)
						if DEBUG then
							local side = ""
							if prev_attacker_left_side[attacker.id] then
								side = "Left"
							else
								side = "Right"
							end
							if jump_crossup_attempt[attacker.id] then
								print("Saving jump original side (jump crossup attempt) : "..side)
							elseif special_crossup_attempt[attacker.id] then
								print("Saving special move original side (special crossup attempt) : "..side)
							end
						end
					elseif ground_crossup_attempt[attacker.id] then
						prev_flip_value[attacker.id] = not isCharacterLeft(attacker)
						if DEBUG then
							local side = ""
							if prev_attacker_left_side[attacker.id] then
								side = "Left"
							else
								side = "Right"
							end
							print("Saving attack original side (ground crossup attempt) : "..side)
						end
					end
				end
				if DEBUG then
					if (defender.hitfreeze_counter > defender.prev.hitfreeze_counter) and defender.state == jumping then
						print("Air-to-Air : This is not a crossup")
					end
				end
				if (defender.hitfreeze_counter > defender.prev.hitfreeze_counter) and defender.state ~= jumping then
					if DEBUG then 
						print("Hit. gamestate prev/curr flip input : "..str(defender.prev.flip_input).."/"..str(defender.flip_input))
						print("Hit happened at :"..getDistanceBetweenPlayers())
					end
					if prev_attacker_left_side[attacker.id] ~= isCharacterLeft(attacker) then
						if prev_flip_value[attacker.id] == nil then
							if defender.flip_input then
								block_direction[attacker.id] = "left"
							else
								block_direction[attacker.id] = "right"
							end
							msg1 = "We couldn't determine if it was a crossup"
							msg2 = "Dummy should have blocked "..block_direction[attacker.id]
							msg_fcount = MSG_FRAMELIMIT-300
						end
						if (defender.flip_input ~= prev_flip_value[attacker.id]) or (defender.prev.flip_input ~= prev_flip_value[attacker.id]) then
							if DEBUG then
								print("> True Crossup : should have been blocked "..block_direction[attacker.id])
							end
							player_msg1[attacker.id] = "True crossup"
							if DEBUG then
								player_msg1[attacker.id] = "True crossup : should block "..block_direction[attacker.id]
							end
							player_msg1_fcount[attacker.id] = MSG_FRAMELIMIT-120
						else
							if DEBUG then
								print("> Fake Crossup : should have been blocked "..block_direction[attacker.id])
							end
							player_msg1[attacker.id] = "Fake crossup"
							if DEBUG then
								player_msg1[attacker.id] = "Fake crossup : should block "..block_direction[attacker.id]
							end
							player_msg1_fcount[attacker.id] = MSG_FRAMELIMIT-120
						end
					else
						if DEBUG then
							player_msg1[attacker.id] = "Non crossup : should block "..block_direction[attacker.id]
							player_msg1_fcount[attacker.id] = MSG_FRAMELIMIT-120
							print("> Non Crossup : should have been blocked "..block_direction[attacker.id])
						end
						did_not_crossup[attacker.id] = true
					end
				end
			end
		end
		if special_crossup_attempt[attacker.id] and (did_not_crossup[attacker.id] and isCharacterLeft(attacker) ~= prev_attacker_left_side[attacker.id]) then -- If Claw did a Barcelona over his opponent we want to display a message even if the special hit from front
			if DEBUG then
				print("> Fake Crossup : should have been blocked "..block_direction[attacker.id])
			end
			player_msg1[attacker.id] = "Fake crossup"
			if DEBUG then
				player_msg1[attacker.id] = "Fake crossup : should block "..block_direction[attacker.id]
			end
			player_msg1_fcount[attacker.id] = MSG_FRAMELIMIT-120
			did_not_crossup[attacker.id] = false
		end
	end
end

local function crossupDisplay()
	if crossup_display_selector > -1 then
		crossupAnalysis(gamestate.P1)
		crossupAnalysis(gamestate.P2)
	end
end
---------------------------------
-- Safe Jump Display
---------------------------------
safe_jump_display_selector = customconfig.safe_jump_display_selector

---------------------------------------------------
-- Maybe should be be moved in character_specific.lua
---------------------------------------------------
local function getJumpVersion(_player_obj) -- Returns neutral, back or forward
	--
	local DEBUG = false
	--
	local character = _player_obj.character
	local left = isCharacterLeft(_player_obj)
	local jump_x_coeff = 0
	if _player_obj.id == 1 then
		jump_x_coeff = rb(0xFF848A)
	elseif _player_obj.id == 2 then
		jump_x_coeff = rb(0xFF888A)
	end
	--
	if DEBUG then
		print("0x"..string.format("%x",jump_x_coeff))
	end
	--
	if jump_x_coeff == 0x00 then
		return "neutral"
	elseif character == Dhalsim or character == Hawk or character == Sagat or character == Zangief then 
		if jump_x_coeff == 0xFD then
			if left then
				return "back"
			else
				return "forward"
			end
		elseif jump_x_coeff == 0x02 or (character == Hawk and jump_x_coeff == 0x03) then -- Hawk 0x3 when right
			if left then
				return "forward"
			else
				return "back"
			end
		end
	elseif character == Chun or character == Dictator then
		if jump_x_coeff == 0xFB then
			if left then
				return "back"
			else
				return "forward"
			end
		elseif jump_x_coeff == 0x04 or (character == Dictator and jump_x_coeff == 0x05) then -- Dicta 0x05 when right
			if left then
				return "forward"
			else
				return "back"
			end
		end
	elseif character == Claw then
		if jump_x_coeff == 0xFA or jump_x_coeff == 0xFB then -- Claw 0xFB when right
			if left then
				return "back"
			else
				return "forward"
			end
		elseif jump_x_coeff == 0x05 then
			if left then
				return "forward"
			else
				return "back"
			end
		end
	else
		if jump_x_coeff == 0xFC or (character == Boxer and jump_x_coeff == 0xFD) then -- Boxer 0xFD when right
			if left then
				return "back"
			else
				return "forward"
			end
		elseif jump_x_coeff == 0x03 or ((character == DJ or character == Fei or character == Guile or character == Ken or character == Ryu) and jump_x_coeff == 0x04) then -- Shoto, Guile, Fei and DJ 0x4 when right
			if left then
				return "forward"
			else
				return "back"
			end
		end
	end
end

local function getJumpDuration(_player_obj, _jump_version) -- Returns the total of uncancellable jump frames
	--
	local character = _player_obj.character
	local old = _player_obj.is_old
	local duration = 0
	--
	if _jump_version == "neutral" then
		if character == Claw then
			duration = 42
		elseif character == Blanka or (character == Sagat and old) then
			duration = 45
		elseif character == Hawk or (character == Sagat and not old) then
			duration = 47
		elseif character == Zangief then
			duration = 48
		elseif character == Boxer or (character == DJ and not old) or character == Fei or (old and (character == Ken or character == Ryu)) then
			duration = 49
		elseif character == Chun or (not old and (character == Ken or character == Ryu)) then
			duration = 50
		elseif character == Honda or (character == DJ and old) then
			duration = 51
		elseif character == Cammy or character == Dictator then
			duration = 52
		elseif character == Guile then
			duration = 53
		elseif character == Dhalsim then
			duration = 67
		end
	elseif _jump_version == "back" then
		if character == Claw then
			duration = 42
		elseif character == Blanka or character == Hawk then
			duration = 46
		elseif (character == Sagat and old) then
			duration = 47
		elseif old and (character == Ken or character == Ryu) then
			duration = 48
		elseif character == Ken or character == Ryu or character == Sagat or character == Zangief then
			duration = 49
		elseif character == Boxer or (character == DJ and not old) or character == Fei then
			duration = 50
		elseif character == Chun or character == Honda then
			duration = 51
		elseif character == Cammy or (character == DJ and old) then
			duration = 52
		elseif character == Dictator or character == Guile then
			duration = 53
		elseif character == Dhalsim then
			duration = 68
		end
	elseif _jump_version == "forward" then
		if character == Claw then
			duration = 41
		elseif character == Blanka or (character == Sagat and old) then
			duration = 44
		elseif character == Fei or character == Hawk or character == Zangief or (character == DJ and old) or (character == Sagat and not old) then
			duration = 46
		elseif character == Boxer or (character == DJ and not old) or (old and (character == Ken or character == Ryu)) then
			duration = 48
		elseif not old and (character == Ken or character == Ryu) then
			duration = 49
		elseif character == Cammy or character == Chun or character == Honda then
			duration = 50
		elseif character == Dictator then
			duration = 51
		elseif character == Guile then
			duration = 52
		end
	end

	return duration
end

local function getReversalStartup(_player_obj)
	--
	local character = _player_obj.character
	local old = _player_obj.is_old
	local has_super = (_player_obj.special_meter == 48)
	--
	if character == Chun and not old then
		return 2
	elseif character == Sagat then
		return 3
	elseif character == Cammy or character == DJ or character == Hawk or character == Ryu then
		return 4
	elseif character == Guile or (character == Claw and not old) then
		return 5
	elseif character == Fei or character == Honda or (character == Boxer and has_super) then
		return 6
	elseif character == Dictator and has_super then
		return 9
	elseif character == Boxer and not has_super then
		return 11
	elseif character == Chun and old then
		return 17
	end
end
---------------------
-- Detect Safe Jump
---------------------
local safe_jump_attempt = {false,false}
local recovery_count = {0,0}
local jump_version = {"",""}
local jump_duration = {0,0}
-- DEBUG values
local curr_jump_frame = {0,0}
local landing_frame = {false,false}
local landing_msg_counter = 0
local debug_diff = {0,0}
local debug_recovery_count = {0,0}
--
local function detectSafeJump(_player_obj)
	--
	local DEBUG = false
	--
	local attacker = _player_obj
	local defender = {}
	if attacker.id == 1 then
		defender = gamestate.P2
	elseif attacker.id == 2 then
		defender = gamestate.P1
	end
	-- Detecting a safe jump attempt
	if defender.is_knockdown then
		if (attacker.prev.state ~= jumping and attacker.state == jumping) then -- to be fixed : some moves trigger the jumping state
			-- Is the jump a safe jumpt attempt ? (Maybe add distance conditions)
			jump_version[attacker.id] = getJumpVersion(attacker)
			if jump_version[attacker.id] == "back" or (jump_version[attacker.id] ~= "neutral" and jump_version[attacker.id] ~= "forward") then return end
			-- Can the defender be safe jumped ?
			if defender.character == Blanka or defender.character == Ken or defender.character == Zangief then
				player_msg2[attacker.id] = printName(defender).." can't be safe jumped"
				player_msg2_fcount[attacker.id] = MSG_FRAMELIMIT-120
				return
			elseif defender.character == Dhalsim or (defender.character == Dictator and defender.special_meter ~= 48) or (defender.character == Claw and defender.is_old) then
				player_msg2[attacker.id] = printName(defender).." doesn't have any invulnerable reversal"
				player_msg2_fcount[attacker.id] = MSG_FRAMELIMIT-120
				return
			end
			-- If they can, continue
			jump_duration[attacker.id] = getJumpDuration(attacker,jump_version[attacker.id])
			safe_jump_attempt[attacker.id] = true
			if DEBUG then
				-- Reset debug values
				curr_jump_frame[attacker.id] = 0
				debug_diff[attacker.id] = 0
				debug_recovery_count[defender.id] = 0
			end
		end
	end
	-- Is the jump safe ?
	if safe_jump_attempt[attacker.id] then
		if defender.is_knockdown then
			recovery_count[defender.id] = countFrames(recovery_count[defender.id])
		else
			if jump_duration[attacker.id] >= recovery_count[defender.id] then -- If the attacker lands (or would have landed) after the defender recovered
				if getReversalStartup(defender) ~= nil then
					if jump_duration[attacker.id]-recovery_count[defender.id] <= getReversalStartup(defender) then -- Check if the attacker lands (or would have landed) before the reversal's active frames
						player_msg2[attacker.id] = "Safe jump"
					else
						player_msg2[attacker.id] = "Too late ("..jump_duration[attacker.id]-recovery_count[defender.id].."f)"
					end
				end
			else -- If the attacker lands before the defender recovers
				player_msg2[attacker.id] = "Too soon ("..recovery_count[defender.id]-jump_duration[attacker.id].."f)"
			end
			player_msg2_fcount[attacker.id] = MSG_FRAMELIMIT-120
			safe_jump_attempt[attacker.id] = false
			recovery_count[defender.id] = 0
		end
	end
	if DEBUG then
		--
		local x = 0
		if attacker.id == 1 then
			x = 100
		elseif attacker.id == 2 then
			x = 230
		end
		--
		if safe_jump_attempt[attacker.id] then
			if curr_jump_frame[attacker.id] < jump_duration[attacker.id] then
				curr_jump_frame[attacker.id] = countFrames(curr_jump_frame[attacker.id])
			elseif (curr_jump_frame[attacker.id] ~= 0) and (curr_jump_frame[attacker.id] >= jump_duration[attacker.id]) then
				landing_frame[attacker.id] = true
			end
			debug_recovery_count[defender.id] = recovery_count[defender.id]
			debug_diff[attacker.id] = jump_duration[attacker.id]-recovery_count[defender.id]
			if getReversalStartup(defender) ~= nil then
				debug_diff[attacker.id] = debug_diff[attacker.id].." (max = "..getReversalStartup(defender)..")"
			else
				debug_diff[attacker.id] = debug_diff[attacker.id].." (can't be safe jumped)"
			end
		end
		-- Display
		gui.text(x,50,"P"..attacker.id.." State : "..player[attacker.id].state)
		gui.text(x,60,"P"..defender.id.." is knockdown : "..str(player[defender.id].is_knockdown))
		--gui.text(x,60,"P"..attacker.id.." Curr. Jump Frame : "..curr_jump_frame[attacker.id])
		gui.text(x,70,"P"..attacker.id.." Total Jump Duration : "..jump_duration[attacker.id])
		gui.text(x,80,"P"..defender.id.." Recovery Count : "..debug_recovery_count[defender.id])
		gui.text(x,90,"Diff : "..debug_diff[attacker.id])

		if landing_frame[attacker.id] then
			landing_msg_counter = countFrames(landing_msg_counter)
			if landing_msg_counter < 30 then
				gui.text(x,130,"P"..attacker.id.." Landing frame")
			else
				landing_msg_counter = 0
				landing_frame[attacker.id] = false
			end
		end
	end
end

local function safeJumpDisplay()
	if safe_jump_display_selector > -1 then
		detectSafeJump(gamestate.P1)
		detectSafeJump(gamestate.P2)
	end
end
-------------------------
-------------------------
-- Character Specific
-------------------------
-------------------------
projectile_frequence_selector = customconfig.projectile_frequence_selector
local projectile_delay = math.random(-150,0)

local function throwProjectile(_projectile_id)
	if not gamestate.is_in_match then
		return
	end

	local character = readCharacterName(gamestate.P2)

	if not interactivegui.enabled then
		if gamestate.P2.projectile_ready and not gamestate.P2.is_attacking and gamestate.P2.state ~= being_hit then
			if projectile_delay < 0 and projectile_frequence_selector == 0 then
				projectile_delay = countFrames(projectile_delay)
			end
		end
		if not isChargeCharacter(gamestate.P2) then
			if gamestate.P2.projectile_ready then
				if projectile_frequence_selector == 0 and projectile_delay < 0 then
					return
				end
				if not gamestate.P2.is_attacking and gamestate.P2.state ~= being_hit then
					ready_to_fire = true
				end
			end
		elseif character == "chunli" then
			if (rb(0xFF84CE+p2) < 0x04 and gamestate.P2.projectile_ready) or (projectile_frequence_selector == -1 and not gamestate.P2.projectile_ready and easy_charge_moves_selector <= 0) or (projectile_frequence_selector == 0 and projectile_delay < 0)then
				if gamestate.P2.flip_input then
					modifyInputSet(2,1)
				else
					modifyInputSet(2,3)
				end
			elseif rb(0xFF84CE+p2) == 0x04 then
				modifyInputSet(2,5)
			elseif rb(0xFF84CE+p2) == 0x06 then
				ready_to_fire = true
			end
		elseif character == "deejay" then
			if (rb(0xFF84E0+p2) < 0x04 and gamestate.P2.projectile_ready) or (projectile_frequence_selector == -1 and not gamestate.P2.projectile_ready and easy_charge_moves_selector <= 0) or (projectile_frequence_selector == 0 and projectile_delay < 0)then
				if gamestate.P2.flip_input then
					modifyInputSet(2,1)
				else
					modifyInputSet(2,3)
				end
			elseif rb(0xFF84E0+p2) == 0x04 then
				modifyInputSet(2,5)
			elseif rb(0xFF84E0+p2) == 0x06 then
				ready_to_fire = true
			end
		elseif character == "guile" then
			if (rb(0xFF84CE+p2) < 0x04 and gamestate.P2.projectile_ready) or (projectile_frequence_selector == -1 and not gamestate.P2.projectile_ready and easy_charge_moves_selector <= 0) or (projectile_frequence_selector == 0 and projectile_delay < 0)then
			if gamestate.P2.flip_input then
					modifyInputSet(2,1)
				else
					modifyInputSet(2,3)
				end
			elseif rb(0xFF84CE+p2) == 0x04 then
				modifyInputSet(2,5)
			elseif rb(0xFF84CE+p2) == 0x06 then
				ready_to_fire = true
			end
		end
	end
	if ready_to_fire then
		if not isChargeCharacter(gamestate.P2) then
			do_special_move(gamestate.P2, character_specific[character].specials[_projectile_id[1]], _projectile_id[2], true)
		else
			do_special_move(gamestate.P2, character_specific[character].specials[_projectile_id[1]], _projectile_id[2], false)
		end
		if projectile_frequence_selector == 0 then
			if projectile_delay >= 0 then
				projectile_delay = math.random(-150,0)
			end
		end
		ready_to_fire = false
	end
end

local projectiles_checked = {} -- Stocks the relevant values to perform the choosen projectiles
local listenProjectileSettingsModfications = false

function stockProjectilesChecked()
	if interactivegui.enabled and not listenProjectileSettingsModfications then -- If the menu has been opened, clean the table (maybe there's a cleaner way)
		for k in pairs(projectiles_checked) do
			projectiles_checked[k] = nil
		end
		projectile_selector = 0
		listenProjectileSettingsModfications = true
	end
	if not interactivegui.enabled and listenProjectileSettingsModfications then -- If the menu has been closed, check the options selected
		for i = 1, #projectile_options do
			if projectile_options[i].checked then
					table.insert(projectiles_checked, projectile_options[i].projectile_id)
			end
		end
		if #projectiles_checked == 0 then
			projectile_selector = 0
		elseif #projectiles_checked == 1 then
			projectile_selector = 1
		elseif #projectiles_checked > 1 then
			projectile_selector = 2
		end
		listenProjectileSettingsModfications = false
	end
end

local projectile_reroll = true -- Determine if a new projectile has to be selected

local function throwProjectilesLogic()
	if projectile_selector == 1 then -- One option has been checked
		throwProjectile(projectiles_checked[1])
	elseif projectile_selector == 2 then -- Multiple options checked
		if projectile_reroll then
			random_projectile = math.random(1,#projectiles_checked)
		end
		throwProjectile(projectiles_checked[random_projectile])
		projectile_reroll = false
		if (gamestate.P2.prev.state ~= doing_special_move and gamestate.P2.state == doing_special_move) then -- if p2 finished a special attack -> reroll a special to be played
			projectile_reroll = true
		end
	else
		projectile_reroll = true -- Set to true when you enter the gui
	end
end

local function projectileTraining()
	if REPLAY then return end
	stockProjectilesChecked()
	throwProjectilesLogic()
end

------------------------------------------
------------------------------------------
-- Display the relevant options
------------------------------------------
------------------------------------------

function displayReversalSettings()
	if patch_changed or first_load then
		makeReversalSettings(gamestate.patched)
	end
	if gamestate.patched then
		if characterChanged(gamestate.P2) or oldStatusChanged(gamestate.P2) then
			if #reversal_options_checked > 0 then
				for k in pairs(reversal_options_checked) do
				reversal_options_checked[k] = nil
				end
			end
			patched_autoreversal_selector = 0
			reloadReversalSettings()
		end
	else
		if not fixed_inputs then
			fixed_inputs = true
		end
	end
end

function displayProjectileSettings()
	if first_load then
		makeProjectileSettings()
	end
	if characterChanged(gamestate.P2) then
		if #projectiles_checked > 0 then
			for k in pairs(projectiles_checked) do
				projectiles_checked[k] = nil
			end
		end
		projectile_selector = 0
		reloadProjectileSettings()
	end
end

function displayContextualSettings()
	if REPLAY then return end
	displayReversalSettings()
	displayProjectileSettings()
end
---------------------------------------
---------------------------------------
-- Run
---------------------------------------
---------------------------------------
local function updateGamestate()
	-- prev
	gamestate.prev = gamestate.stock_game_vars()
	gamestate.P1.prev = gamestate.stock_player_vars(gamestate.P1)
	gamestate.P1.prev.in_hitstun = gamestate.P1.in_hitstun
	gamestate.P2.prev = gamestate.stock_player_vars(gamestate.P2)
	gamestate.P2.prev.in_hitstun = gamestate.P2.in_hitstun
	-- curr
	gamestate.read_game_vars()
	gamestate.read_player_vars(gamestate.P1)
	readInHitstun(gamestate.P1)
	readKnockdown(gamestate.P1)
	gamestate.read_player_vars(gamestate.P2)
	readInHitstun(gamestate.P2)
	readKnockdown(gamestate.P2)
	-- global
	checkFrameskip()
end

local function ST_Training_basic_settings()
	if REPLAY then return end
	neverEnd()
	autoBlock()
	autoReversal()
	p2DizzyControl()
	techThrowControl()
	stageSelect()
end

local function ST_Training_advanced_settings()
	render_st_hud()
	lockCharacters()
	frameskipControl()
	slowdownControl()
	nomusicControl()
	easyChargeControl()
	frameAdvantageDisplay()
	frameTrapDisplay()
	tickThrowDisplay()
	crossupDisplay()
	safeJumpDisplay()
	projectileTraining()
	roundStart()
end

local function ST_Training_misc()
	loadReplayConfig()
	if REPLAY then return end
	displayContextualSettings()
	fixPreviousInputDetection(fixed_inputs)
	if first_load then
		first_load = false
	end
	if patch_changed then
		patch_changed = false
	end
end

ST_functions = {updateGamestate, ST_Training_misc, ST_Training_basic_settings, ST_Training_advanced_settings, draw_messages}

function Run() -- runs every frame
	for i = 1, #ST_functions do
		ST_functions[i]()
	end
end
