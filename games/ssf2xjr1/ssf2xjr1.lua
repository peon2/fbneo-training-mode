assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
-- ssf2x training mode by @pof & @asunaro
require("games/ssf2xjr1/character_specific")
require("games/ssf2xjr1/gamestate")
require("games/ssf2xjr1/constants")

-- use a custom config file if one exists, otherwise load defaults
if fexists("games/ssf2xjr1/customconfig.lua") then
	dofile("games/ssf2xjr1/customconfig.lua")
else
	customconfig = {
		draw_hud = 0,
		autoblock_selector = -1,
		autoreversal_selector = -1,
		dizzy_selector = -1,
		easy_charge_moves_selector = -1,
		frame_advantage_selector = -1,
		frame_trap_selector = -1,
		frameskip_selector = -1,
		projectile_frequence_selector = 0,
		reversal_trigger_selector = -1,
		roundstart_selector = -1,
		slowdown_selector = - 1,
		stage_selector = -1,
		tech_throw_selector = -1,
	}
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
		p1healthenabled=false,
		p2healthx=355,
		p2healthy=22,
		p2healthenabled=false,
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

local function isChargeCharacter(_player_obj)
	if character_specific[readCharacterName(_player_obj)].infos.charge_character then
		return true
	else
		return false
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

local getDistanceBetweenPlayers = function()
	if playerOneFacingLeft() then
		distance = gamestate.P1.pos_x - gamestate.P2.pos_x
	else
		distance = gamestate.P2.pos_x - gamestate.P2.pos_x
	end
	return distance
end

local function playerCrouching(_player_obj)
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

local was_frameskip = false

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
----------------------
-- Check for changes
----------------------
local function characterChanged(_player_obj)
	if _player_obj.prev.character ~= _player_obj.character then
		return true
	else
		return false
	end
end
------------------------------------------------------------
--	 Messages -- Borrowed from sako.lua by Born2SPD
------------------------------------------------------------
local MSG_FRAMELIMIT = 600
local msg1 = ""
local msg2 = ""
local msg_fcount = 0

local hit_delay_result = 0

function update_msg(code)
	if code == 0 then -- reset
		msg1 = ""
		msg_fcount = 0
	elseif code == 1 then
		msg1 = result1
		msg_fcount = MSG_FRAMELIMIT-120
	elseif code == 2 then
		msg1 = "	Delay : "..hit_delay_result.." frames"
		msg_fcount = MSG_FRAMELIMIT-120
	end
end

function reset_msg()
	update_msg(0)
end

local message_selector = 0

function draw_messages()
	if msg_fcount >= MSG_FRAMELIMIT then
		reset_msg()
	elseif msg_fcount > 0 then
		msg_fcount = countFrames(msg_fcount)
	end
	gui.text(223,216,msg1)
	gui.text(100,216,msg2)
end

local function str(bool)
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
	-- this must be life_backup (health at previous frame, otherwise breaks the combo counter)
	return gamestate.P1.life_backup
end

function readPlayerTwoHealth()
	-- this must be life_backup (health at previous frame, otherwise breaks the combo counter)
	return gamestate.P2.life_backup
end

function writePlayerOneHealth(health)
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
	elseif ((gamestate.P1.life < p1maxhealth) and (gamestate.P1.state ~= being_thrown and gamestate.P1.state ~= being_hit and gamestate.P1.state ~= blocking_attempt) and (gamestate.P2.state == crouching or gamestate.P2.state == standing)) then
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
	elseif ((gamestate.P2.life < p2maxhealth) and (gamestate.P2.state ~= being_thrown and gamestate.P2.state ~= being_hit and gamestate.P2.state ~= blocking_attempt) and (gamestate.P1.state == crouching or gamestate.P1.state == standing)) then
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
	if gamestate.curr_state == in_match then
		wb(gamestate.P1.addresses.special_meter, meter)
	end
end

function writePlayerTwoMeter(meter)
	if gamestate.curr_state == in_match then
		wb(gamestate.P2.addresses.special_meter, meter)
	end
end

------------------------
-- neverEnd()
------------------------

local infiniteTime = function()
	if (gamestate.round_timer < 0x98) then
		ww(addresses.global.round_timer,0x9928)
	end
end

local neverEnd_p1 = function()

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
			gui.text(2,65,"Ground Straight: ".. rb(0xFF84CE))
			gui.text(2,73,"Ground Upper: " ..rb(0xFF84D6))
			gui.text(2,81,"Straight: " .. rb(0xFF852B))
			gui.text(80,65,"Upper Dash: " .. rb(0xFF8524))
			gui.text(80,73,"Buffalo Headbutt: " .. rb(0xFF850E))
			gui.text(80,81,"Crazy Buffalo: " .. rb(0xFF8522))
		elseif gamestate.P1.character == Blanka then
			gui.text(2,65,"Normal Roll: " .. rb(0xFF8507))
			gui.text(2,73,"Vertical Roll: " .. rb(0xFF84FE))
			gui.text(2,81,"Ground Shave Roll: " .. rb(0xFF850F))
		elseif gamestate.P1.character == Cammy then
			gui.text(2,65,"Spin Knuckle: " .. rb(0xFF84F0))
			gui.text(2,73,"Cannon Spike: " .. rb(0xFF84E0))
			gui.text(2,81,"Spiral Arrow: ".. rb(0xFF84E4))
			gui.text(80,65,"Hooligan Combination: " .. rb(0xFF84F7))
			gui.text(80,73,"Spin Drive Smasher: " .. rb(0xFF84F4))
		elseif gamestate.P1.character == Chun then
			gui.text(2,65,"Kikouken: ".. rb(0xFF84CE))
			gui.text(2,73,"Up Kicks: " .. rb(0xFF8508))
			gui.text(2,81,"Spinning Bird Kick: " .. rb(0xFF84FE))
			gui.text(80,65,"Senretsu Kyaku: " .. rb(0xFF850D))
		elseif gamestate.P1.character == Deejay then
			gui.text(2,65,"Air Slasher: " .. rb(0xFF84E0))
			gui.text(2,73,"Sovat Kick: " .. rb(0xFF84F4))
			gui.text(2,81,"Jack Knife: ".. rb(0xFF84E4))
			gui.text(80,65,"Machine Gun Upper: " .. rb(0xFF84F9))
			gui.text(80,73,"Sovat Carnival: " .. rb(0xFF84FD))
		elseif gamestate.P1.character == Dhalsim then
			gui.text(2,65,"Yoga Blast: " .. rb(0xFF84D2))
			gui.text(2,73,"Yoga Flame: " .. rb(0xFF84E8))
			gui.text(2,81,"Yoga Fire: " .. rb(0xFF84CE))
			gui.text(80,65,"Yoga Teleport: ".. rb(0xFF84D6))
			gui.text(80,73,"Yoga Inferno: " .. rb(0xFF84E4))
		elseif gamestate.P1.character == Honda then
			gui.text(2,65,"Flying Headbutt: " .. rb(0xFF84D6))
			gui.text(2,73,"Butt Drop: " .. rb(0xFF84DE))
			gui.text(2,81,"Oichio Throw: " .. rb(0xFF84E4))
			gui.text(80,65, "Double Headbutt" .. rb(0xFF84E2))
		elseif gamestate.P1.character == Fei then
			gui.text(2,65,"Rekka: " .. rb(0xFF84DE))
			gui.text(2,73,"Rekka 2: " .. rb(0xFF84EE))
			gui.text(2,81,"Flame Kick: " .. rb(0xFF84E2))
			gui.text(80,65,"Chicken Wing: " .. rb(0xFF8502))
			gui.text(80,73,"Rekka Sinken: " .. rb(0xFF84FE))
		elseif gamestate.P1.character == Guile then
			gui.text(2,65,"Sonic Boom: " .. rb(0xFF84CE))
			gui.text(2,73,"Flash Kick: " .. rb(0xFF84D4))
			gui.text(2,81,"Double Somersault: " .. rb(0xFF84E2))
		elseif gamestate.P1.character == Ken then
			gui.text(2,65, "Hadouken: ".. rb(0xFF84E2))
			gui.text(2,73, "Shoryuken: " .. rb(0xFF84E6))
			gui.text(2,81, "Hurricane Kick: " .. rb(0xFF84DE))
			gui.text(42,89, "Shoryureppa: " .. rb(0xFF84EE))
			gui.text(80,65, "Crazy Kick 1: " .. rb(0xFF8534))
			gui.text(80,73, "Crazy Kick 2: " .. rb(0xFF8536))
			gui.text(80,81, "Crazy Kick 3: " .. rb(0xFF8538))
		elseif gamestate.P1.character == Dictator then
			gui.text(2,65,"Scissor Kick: " .. rb(0xFF84D6))
			gui.text(2,73,"Head Stomp: ".. rb(0xFF84DF))
			gui.text(2,81,"Devil's Reverse: " .. rb(0xFF84FA))
			gui.text(80,65,"Psycho Crusher: " .. rb(0xFF84CE))
			gui.text(80,73,"Knee Press Knightmare: " .. rb(0xFF8513))
		elseif gamestate.P1.character == Ryu then
			gui.text(2,65,"Hadouken: " .. rb(0xFF84E2))
			gui.text(2,73,"Shoryuken: " .. rb(0xFF84E6))
			gui.text(2,81, "Hurricane Kick: " .. rb(0xFF84DE))
			gui.text(80,65, "Red Hadouken: " .. rb(0xFF852E))
			gui.text(80,73, "Shinku Hadouken: " .. rb(0xFF84EE))
		elseif gamestate.P1.character == Sagat then
			gui.text(2,65,"Tiger Shot: " .. rb(0xFF84DA))
			gui.text(2,73,"Tiger Knee: " .. rb(0xFF84D2))
			gui.text(2,81,"Tiger Uppercut: " .. rb(0xFF84CE))
			gui.text(80,65, "Tiger Genocide: " .. rb(0xFF84EC))
		elseif gamestate.P1.character == Hawk then
			gui.text(2,65,"Mexican Typhoon: " .. rb(0xFF84E0) .. ", " .. rb(0xFF84E1))
			gui.text(2,73,"Tomahawk: " .. rb(0xFF84DB))
			gui.text(2,81,"Double Typhoon: " .. rb(0xFF84E0) .. ", " .. rb(0xFF84ED))
		elseif gamestate.P1.character == Claw then
			gui.text(2,65,"Wall Dive (Kick): " .. rb(0xFF84DA))
			gui.text(2,73,"Wall Dive (Punch): " .. rb(0xFF84DE))
			gui.text(2,81,"Crystal Flash: " .. rb(0xFF84D6))
			gui.text(90,65,"Flip Kick: " .. rb(0xFF84EB))
			gui.text(90,73,"Rolling Izuna Drop: " .. rb(0xFF84E7))
		elseif gamestate.P1.character == Zangief then
			gui.text(2,65, "Bear Grab: " .. rb(0xFF84E9) ..  ", " .. rb(0xFF84EA))
			gui.text(2,73, "Spinning Pile Driver: " .. rb(0xFF84CE) .. ", " .. rb(0xFF84CF))
			gui.text(2,81, "Banishing Flat: " .. rb(0xFF8501))
			gui.text(2,89, "Final Atomic Buster: " .. rb(0xFF84FA) .. ", " .. rb(0xFF84FB))
		end
	else
		if gamestate.P2.character == Boxer then
			gui.text(230,65,"Ground Straight: " .. rb(0xFF84CE+p2))
			gui.text(230,73,"Ground Upper: " ..rb(0xFF84D6+p2))
			gui.text(230,81,"Straight: " .. rb(0xFF852B+p2))
			gui.text(307,65,"Upper Dash: " .. rb(0xFF8524+p2))
			gui.text(307,73,"Buffalo Headbutt: " .. rb(0xFF850E+p2))
			gui.text(307,81,"Crazy Buffalo: " .. rb(0xFF8522+p2))
		elseif gamestate.P2.character == Blanka then
			gui.text(302,65,"Normal Roll: " .. rb(0xFF8507+p2))
			gui.text(302,73,"Vertical Roll: " .. rb(0xFF84FE+p2))
			gui.text(302,81,"Ground Shave Roll: " .. rb(0xFF850F+p2))
		elseif gamestate.P2.character == Cammy then
			gui.text(218,65,"Spin Knuckle: " .. rb(0xFF84F0+p2))
			gui.text(218,73,"Cannon Spike: " .. rb(0xFF84E0+p2))
			gui.text(218,81,"Spiral Arrow: " .. rb(0xFF84E4+p2))
			gui.text(290,65,"Hooligan Combination: " .. rb(0xFF84F7+p2))
			gui.text(290,73,"Spin Drive Smasher: " .. rb(0xFF84F4+p2))
		elseif gamestate.P2.character == Chun then
			gui.text(233,65,"Kikouken: " .. rb(0xFF84CE+p2))
			gui.text(233,73,"Up Kicks: " .. rb(0xFF8508+p2))
			gui.text(233,81,"Spinning Bird Kick: " .. rb(0xFF84FE+p2))
			gui.text(313,65,"Senretsu Kyaku: " .. rb(0xFF850D+p2))
		elseif gamestate.P2.character == Deejay then
			gui.text(223,65,"Air Slasher: " .. rb(0xFF84E0+p2))
			gui.text(223,73,"Sovat Kick: " .. rb(0xFF84F4+p2))
			gui.text(223,81,"Jack Knife: " .. rb(0xFF84E4+p2))
			gui.text(303,65,"Machine Gun Upper: " .. rb(0xFF84F9+p2))
			gui.text(303,73,"Sovat Carnival: " .. rb(0xFF84FD+p2))
		elseif gamestate.P2.character == Dhalsim then
			gui.text(223,65,"Yoga Blast: " .. rb(0xFF84D2+p2))
			gui.text(223,73,"Yoga Flame: " .. rb(0xFF84E8+p2))
			gui.text(223,81,"Yoga Fire: " .. rb(0xFF84CE+p2))
			gui.text(303,65,"Yoga Teleport: ".. rb(0xFF84D6+p2))
			gui.text(303,73,"Yoga Inferno: " .. rb(0xFF84E4+p2))
		elseif gamestate.P2.character == Honda then
			gui.text(223,65,"Flying Headbutt: " .. rb(0xFF84D6+p2))
			gui.text(223,73,"Butt Drop: " .. rb(0xFF84DE+p2))
			gui.text(223,81,"Oichio Throw: " .. rb(0xFF84E4+p2))
			gui.text(303,65, "Double Headbutt: " .. rb(0xFF84E2+p2))
		elseif gamestate.P2.character == Fei then
			gui.text(242,65,"Rekka: " .. rb(0xFF84DE+p2))
			gui.text(242,73,"Rekka 2: "	.. rb(0xFF84EE+p2))
			gui.text(242,81,"Flame Kick: " .. rb(0xFF84E2+p2))
			gui.text(322,65, "Chicken Wing: " .. rb(0xFF8502+p2))
			gui.text(322,73, "Rekka Sinken: " .. rb(0xFF84FE+p2))
		elseif gamestate.P2.character == Guile then
			gui.text(302,65,"Sonic Boom: " .. rb(0xFF84CE+p2))
			gui.text(302,73,"Flash Kick: " .. rb(0xFF84D4+p2))
			gui.text(302,81,"Double Somersault: " .. rb(0xFF84E2+p2))
		elseif gamestate.P2.character == Ken then
			gui.text(223,65, "Hadouken: " .. rb(0xFF84E2+p2))
			gui.text(223,73, "Shoryuken: " .. rb(0xFF84E6+p2))
			gui.text(223,81, "Hurricane Kick: " .. rb(0xFF84DE+p2))
			gui.text(322,65, "Crazy Kick 1: " .. rb(0xFF8534+p2))
			gui.text(322,73, "Crazy Kick 2: " .. rb(0xFF8536+p2))
			gui.text(322,81, "Crazy Kick 3: " .. rb(0xFF8538+p2))
			gui.text(272,89, "Shoryureppa: " .. rb(0xFF84EE+p2))
		elseif gamestate.P2.character == Dictator then
			gui.text(217,65,"Scissor Kick: " .. rb(0xFF84D6+p2))
			gui.text(217,73,"Headstomp: " .. rb(0xFF84DF+p2))
			gui.text(217,81,"Devil's Reverse: " .. rb(0xFF84FA+p2))
			gui.text(290,65,"Psycho Crusher: " .. rb(0xFF84CE+p2))
			gui.text(290,73,"Knee Press Nightmare: " .. rb(0xFF8513+p2))
		elseif gamestate.P2.character == Ryu then
			gui.text(210,65,"Hadouken: " .. rb(0xFF84E2+p2))
			gui.text(210,73,"Shoryuken: " .. rb(0xFF84E6+p2))
			gui.text(210,81, "Hurricane Kick: " .. rb(0xFF84DE+p2))
			gui.text(310,65, "Red Hadouken: " .. rb(0xFF852E+p2))
			gui.text(310,73, "Shinku Hadouken: " .. rb(0xFF84EE+p2))
		elseif gamestate.P2.character == Sagat then
			gui.text(214,65,"Tiger Shot: " .. rb(0xFF84DA+p2))
			gui.text(214,73,"Tiger Knee: " .. rb(0xFF84D2+p2))
			gui.text(214,81,"Tiger Uppercut: " .. rb(0xFF84CE+p2))
			gui.text(314,65, "Tiger Genocide: " .. rb(0xFF84EC+p2))
		elseif gamestate.P2.character == Hawk then
			gui.text(294,65,"Mexican Typhoon: " .. rb(0xFF84E0+p2) .. ", " .. rb(0xFF84E1+p2))
			gui.text(294,73,"Tomahawk: " .. rb(0xFF84DB+p2))
			gui.text(294,81,"Double Typhoon: " .. rb(0xFF84E0+p2) .. ", " .. rb(0xFF84ED+p2))
		elseif gamestate.P2.character == Claw then
			gui.text(210,65,"Wall Dive (Kick): " .. rb(0xFF84DA+p2))
			gui.text(210,73,"Wall Dive (Punch): " .. rb(0xFF84DE+p2))
			gui.text(210,81,"Crystal Flash: " .. rb(0xFF84D6+p2))
			gui.text(298,65,"Flip Kick: " .. rb(0xFF84EB+p2))
			gui.text(298,73,"Rolling Izuna Drop: " .. rb(0xFF84E7+p2))
		elseif gamestate.P2.character == Zangief then
			gui.text(275,65, "Bear Grab: " .. rb(0xFF84E9+p2) ..  ", " .. rb(0xFF84EA+p2))
			gui.text(275,73, "Spinning Pile Driver: " .. rb(0xFF84CE+p2) .. ", " .. rb(0xFF84CF+p2))
			gui.text(275,81, "Banishing Flat: " .. rb(0xFF8501+p2))
			gui.text(275,89, "Final Atomic Buster: " .. rb(0xFF84FA+p2) .. ", " .. rb(0xFF84FB+p2))
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
local p_a = 0
local p1_hg = gamestate.P1.grab_strength
local p2_hg = gamestate.P2.grab_strength

local p1_grab_drawn = false
local p2_grab_drawn = false

local function draw_grab(player,p1_char,p2_char,p_gc)

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
		if p1_c == Honda  or p1_c == Blanka or p1_c == Ken or p1_c == Dhalsim or p1_c == Hawk then
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
		if p2_c == Honda  or p2_c == Blanka or p2_c == Ken or p2_c == Dhalsim or p2_c == Hawk then
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

	if draw_hud == 1 or draw_hud == 2 then
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
		if gamestate.P1.character == Boxer then
			gui.text(34,56,"TAP: " .. display_taplevel(1))
		end
		if gamestate.P2.character == Boxer then
			gui.text(266,56,"TAP: " .. display_taplevel(2))
		end
		if character_specific[readCharacterName(gamestate.P1)].infos.has_projectile then
			gui.text(34,56,"Projectile: " .. projectile_onscreen(gamestate.P1))
		end
		if character_specific[readCharacterName(gamestate.P2)].infos.has_projectile then
			gui.text(266,56,"Projectile: " .. projectile_onscreen(gamestate.P2))
		end
		draw_dizzy()
		check_grab()
		if draw_hud == 1 then
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
local listenReversalSettingsModfications = false
local once = false -- Condition of reversal_trigger 2

function stockReversalOptionsChecked()
	if interactivegui.enabled and not listenReversalSettingsModfications then -- If the menu has been opened, clean the table (maybe there's a cleaner way)
		for k in pairs(reversal_options_checked) do
			reversal_options_checked[k] = nil
		end
		patched_autoreversal_selector = 0
		listenReversalSettingsModfications = true
	end
	if not interactivegui.enabled and listenReversalSettingsModfications then -- If the menu has been closed, stock the options selected
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
		listenReversalSettingsModfications = false
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
	if _player_obj.character == Hawk then -- Voir si ça marche pour le P1 aussi
		if reversal[1] == 0x00 then -- DP
			wb(0xFF84DE,reversal[2])
			wb(0xFF84DD,reversal[2])
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
			if reversal_reroll or gamestate.P2.reversal_flag == 0x00 then
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
				if reversal_reroll or gamestate.P2.reversal_flag == 0x00 then
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
local autoBlock = function()

	if autoblock_selector == -1 then
		return
	end

	local DEBUG=false

	-- neutral when opponent is neutral, crouching or landing
	if (gamestate.P1.state == standing or gamestate.P1.state == crouching or gamestate.P1.state == landing) then
		setDirection(2,5)
		forceblock = false
		if autoblock_selector == 2 and canblock == true then
			canblock = false
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
	if tech_throw_selector == 0 then
		if gamestate.P1.throw_flag == 0x01 then
			modifyInputSet(2,6,5,3)
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
	if slowdown_selector == -1 then
		return
	end
	if slowdown_selector == 0 then
		wb(addresses.global.slowdown,0x00)
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

frame_advantage_selector = customconfig.frame_advantage_selector

local step = 0
local calculation_end = false
local frame_advantage = 0
local frame_disadvantage = 0
local frame_addition = 0
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

	if frame_advantage_selector == 0 then
		local DEBUG = false
		-------------------
		-- Reset (new hit)
		-------------------
		 -- not a projectile
		if gamestate.P1.in_hitfreeze and gamestate.P2.in_hitfreeze and not throw_exception then
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
		if not gamestate.P1.projectile_ready and not gamestate.P1.in_hitfreeze and gamestate.P2.in_hitfreeze then -- projectile
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

		if not gamestate.P1.prev.projectile_ready and not gamestate.P2.prev.projectile_ready then
			if gamestate.P1.projectile_ready and gamestate.P2.projectile_ready then
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
		if gamestate.P1.throw_flag == 0x01 then
			if gamestate.P1.character == Guile or gamestate.P1.character == Cammy or gamestate.P1.character == Zangief then
				throw_exception = true -- Those characters can trigger hitfreeze with their throws
			end
		end
		if gamestate.P1.prev.throw_flag == 0x01 and gamestate.P1.throw_flag == 0x00 then
			if gamestate.P2.state == being_thrown and gamestate.P2.prev.state ~= being_thrown then
				if DEBUG then print("Reset : throw (successful)") end
				successful_throw = true
				teched_throw = false
			elseif gamestate.P2.state == being_hit and gamestate.P2.prev.state ~= being_hit then
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
		update_msg(0)
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
				if not gamestate.P1.is_attacking and gamestate.P2.state == being_hit then -- problem : if P1 performs an attack right when the hitfreeze begins the count won't be exact
					projectile_move_ended = true
				end
				if gamestate.P2.in_hitfreeze and projectile_move_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Hitfreeze)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			if projectile_duel then
				if not gamestate.P1.is_attacking then
					attacker_duel_projectile_move_ended = true
				end
				if not gamestate.P2.is_attacking then
					defender_duel_projectile_move_ended = true
				end
				if attacker_duel_projectile_move_ended and not defender_duel_projectile_move_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Projectile Duel)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			-- Throw
			if successful_throw or teched_throw then
				if gamestate.P1.throw_flag == 0x00 and gamestate.P1.state ~= 0x0A and gamestate.P1.substate ~= 0x04 then
					throw_ended = true
				end
				if throw_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Throw)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			-- Knockdown / Air recovery
			if gamestate.P2.air_state == 255 then -- Knockdown or Air recovery
				knockdown = true
			end
			if not teched_throw and knockdown then
				if not gamestate.P1.is_attacking then
					knockdown_sequence_ended = true
				end
				if knockdown_sequence_ended then
					if DEBUG then print("Advantage + "..frame_addition.." (Knockdown/Air recovery)") end
					frame_advantage = countFrames(frame_advantage)
				end
			end
			-- Normal moves / Non-projectile specials / Projectiles (when P2 hitfreeze ends)
			if gamestate.P2.in_hitstun then
				if not knockdown and not gamestate.P1.is_attacking then
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
			if not gamestate.P2.in_hitstun then
				if not successful_throw and not teched_throw and not knockdown and not projectile_move_ended and not projectile_duel and not general_sequence_ended then
					if gamestate.P1.is_attacking and not gamestate.P2.in_hitfreeze then
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
					if DEBUG then print("End (Projectile duel) : Both player have finished their moves") end
					calculation_end = true
				end
			elseif not knockdown and not successful_throw and not teched_throw then
				if not gamestate.P1.is_attacking and not gamestate.P2.in_hitfreeze and not gamestate.P2.in_hitstun then
					if DEBUG then print("End (General) : P2 is not in hitfreeze/hitstun/blockstun anymore") end
					calculation_end = true
				end
			elseif knockdown then
				if gamestate.P2.prev.state == being_hit and gamestate.P2.state ~= being_hit then
					if DEBUG then print("End (Knockdown/Air recovery) : P2 has landed on his feet") end
					calculation_end = true
				end
			elseif successful_throw then
				if gamestate.P2.prev.state == being_thrown and gamestate.P2.state ~= being_thrown then
					if DEBUG then print("End (Successful Throw) : P2 has recovered from the throw") end
					calculation_end = true
				end
			elseif teched_throw then
				if gamestate.P2.prev.state == being_hit and gamestate.P2.state ~= being_hit then
					if DEBUG then print("End (Teched Throw) : P2 has recovered from the throw") end
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
			exception = false
			--------------------------------
			if frame_disadvantage > 0 then
				result1 = "-"..frame_disadvantage
			else
				result1 = "+"..frame_advantage
			end
			update_msg(1)
			calculation_end = false
		end

		gui.text(153,216,"Frame Advantage : ")

		if DEBUG then
			gui.text(210,50,"Frame advantage : "..frame_advantage)
			gui.text(210,60,"Frame disadvantage : "..frame_disadvantage)

			gui.text(10,50,"P1 state : "..gamestate.P1.state)
			gui.text(10,60,"P1 substate : "..gamestate.P1.substate)
			gui.text(10,70,"P1 attacking : "..str(gamestate.P1.is_attacking))
			gui.text(10,80,"P1 throw : "..gamestate.P1.throw_flag)


			gui.text(100,50,"P2 state : "..gamestate.P2.state)
			gui.text(100,60,"P2 substate : "..gamestate.P2.substate)
			gui.text(100,70,"P2 hitfreeze : "..str(gamestate.P2.in_hitfreeze))
			gui.text(100,80,"P2 hitstun : "..str(gamestate.P2.in_hitstun))
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

local frame_trap_step = 0
local frame_trap_timer = 0
local post_first_hit = false
local frame_trap_calculated = {false, false, false, false, false, false}
local frame_trap_result = {"","","","","",""}
local frame_trap_calculation_end = false
local reset = false
local nb_calculation = 1

local function frameTrapDisplay()
	if not gamestate.is_in_match then
		return
	end

	local DEBUG = false

	if DEBUG then
		gui.text(100,120,"Step : "..frame_trap_step)
		gui.text(100,130,"Reset : "..str(reset))
		gui.text(100,140,"Frame trap calculation end :"..str(frame_trap_calculation_end))
		gui.text(100,150,"State P2: "..gamestate.P2.state)
	end

	if frame_trap_selector == 0 then
		if frame_trap_step == 0 and gamestate.P2.in_hitstun then
			-- begin
			frame_trap_step = 1
			frame_trap_timer = 0
			-- reset
			if frame_trap_calculated[#frame_trap_calculated] or reset then
				for i = 1, #frame_trap_calculated do
					frame_trap_calculated[i] = false
				end
				for i = 1, #frame_trap_result do
					frame_trap_result[i] = ""
				end
				nb_calculation = 1
				post_first_hit = false
				reset = false
			end
		end
		-------------------------
		-- Calculation
		-------------------------
		if frame_trap_step == 1 then
			if gamestate.P2.in_hitstun then
				post_first_hit = true
			end
			if gamestate.P2.state ~= being_hit then
				frame_trap_timer = countFrames(frame_trap_timer)
				if not frame_trap_calculated[nb_calculation] then
					frame_trap_result[nb_calculation] = frame_trap_timer
				end
			end
			if gamestate.P2.in_hitfreeze then
				if post_first_hit and frame_trap_timer == 0 and gamestate.P2.combo_counter == 0x00 and gamestate.P2.air_state ~= 255 then
					if not frame_trap_calculated[nb_calculation] then
						frame_trap_result[nb_calculation] = "blockstring"
					end
					frame_trap_calculated_end = true
				end
			end
			if gamestate.P2.state == being_hit or gamestate.P1.throw_flag == 0x01 then -- If we detect a new hit or a throw
				if frame_trap_timer ~= 0 then
					if not frame_trap_calculated[nb_calculation] then
						frame_trap_result[nb_calculation] = frame_trap_timer
					end
					frame_trap_calculated_end = true
				end
			end
		end

		if frame_trap_calculated_end then
			if not frame_trap_calculated[nb_calculation] then
				frame_trap_calculated[nb_calculation] = true
			end
			if not frame_trap_calculated[#frame_trap_calculated] then
				frame_trap_step = 0
			else
				frame_trap_step = -1
			end
			if reset then
				frame_trap_step = -1
			end
			nb_calculation = nb_calculation + 1
			if nb_calculation > #frame_trap_calculated then
				nb_calculation = 1
			end

			frame_trap_timer = 0
			post_first_hit = false
			frame_trap_calculated_end = false
		end

		if frame_trap_step == -1 and (gamestate.P2.state ~= being_hit and gamestate.P2.state ~= being_thrown) then
			frame_trap_step = 0
		end

		if (frame_trap_timer >= 50 and frame_trap_step == 1) or (gamestate.P2.air_state == 255 or gamestate.P1.throw_flag == 0x01) then
			frame_trap_step = -1
			frame_trap_timer = 0
			reset = true
			if not frame_trap_calculated[nb_calculation] then
				frame_trap_result[nb_calculation] = ""
			end
		end
		----------------------
		-- Display
		----------------------
		local x = inputs.properties.scrollinginput.scrollinginputxoffset[1] + 90
		local y = 100
		if frame_trap_calculated[#frame_trap_calculated] then
			for i = 1, #frame_trap_calculated do
				gui.text(x,y+10*i,"Gap "..i.." : "..frame_trap_result[i])
			end
		elseif reset then
			for i = 1, #frame_trap_calculated do
				if frame_trap_calculated[i] then
					gui.text(x,y+10*i,"Gap "..i.." : "..frame_trap_result[i])
				end
			end
		else
			for i = 1, nb_calculation do
				if frame_trap_result[i] ~= "" then
					gui.text(x,y+10*i,"Gap "..i.." : "..frame_trap_result[i])
				end
			end
		end
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
			if projectile_delay < 0 and projectile_frequence_selector == 1 then
				projectile_delay = countFrames(projectile_delay)
			end
		end
		if not isChargeCharacter(gamestate.P2) then
			if gamestate.P2.projectile_ready then
				if projectile_frequence_selector == 1 and projectile_delay < 0 then
					return
				end
				if not gamestate.P2.is_attacking and gamestate.P2.state ~= being_hit then
					ready_to_fire = true
				end
			end
		elseif character == "chunli" then
			if (rb(0xFF84CE+p2) < 0x04 and gamestate.P2.projectile_ready) or (projectile_frequence_selector == 0 and not gamestate.P2.projectile_ready and easy_charge_moves_selector <= 0) or (projectile_frequence_selector == 1 and projectile_delay < 0)then
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
			if (rb(0xFF84E0+p2) < 0x04 and gamestate.P2.projectile_ready) or (projectile_frequence_selector == 0 and not gamestate.P2.projectile_ready and easy_charge_moves_selector <= 0) or (projectile_frequence_selector == 1 and projectile_delay < 0)then
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
			if (rb(0xFF84CE+p2) < 0x04 and gamestate.P2.projectile_ready) or (projectile_frequence_selector == 0 and not gamestate.P2.projectile_ready and easy_charge_moves_selector <= 0) or (projectile_frequence_selector == 1 and projectile_delay < 0)then
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
		if projectile_frequence_selector == 1 then
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
		if characterChanged(gamestate.P2) then
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
	gamestate.read_player_vars(gamestate.P2)
	readInHitstun(gamestate.P2)
	-- global
	checkFrameskip()
end

local function ST_Training_basic_settings()
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
	easyChargeControl()
	frameAdvantageDisplay()
	frameTrapDisplay()
	projectileTraining()
	roundStart()
end

local function ST_Training_misc()
	displayContextualSettings()
	fixPreviousInputDetection(fixed_inputs)
	if first_load then
		first_load = false
	end
	if patch_changed then
		patch_changed = false
	end
end

function Run() -- runs every frame
	updateGamestate()
	ST_Training_misc()
	ST_Training_basic_settings()
	ST_Training_advanced_settings()
	draw_messages()
end
