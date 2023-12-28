----------------------------------------------------------------
-- Inspired by Grouflon 3rd Strike Training mode 
-- https://github.com/Grouflon/3rd_training_lua
----------------------------------------------------------------
require("games/ssf2xjr1/memory_addresses")
require("games/ssf2xjr1/constants")

gamestate = {
frame_number = 0,
turbo = 0,
curr_state = 0,
is_in_match = false,
screen_x = 0,
screen_y = 0,
patched = false,
player_objects = {},

P1 = nil,
P2 = nil,
hit_counter = 0
}

function make_player_object(_id, _base, _prefix)
	return {
	id = _id,
	base = _base,
	addresses = addresses.players[_id],
	prefix = _prefix,
	}
end

function gamestate.reset_player_objects()
	gamestate.player_objects = {
	make_player_object(1, addresses.players[1].base, "P1"),
	make_player_object(2, addresses.players[2].base, "P2")
	}

	gamestate.P1 = gamestate.player_objects[1]
	gamestate.P2 = gamestate.player_objects[2]
end

function gamestate.update_patch() -- Will be used when the game is reloaded
	local patch1 = memory.readdword(0x782a2)
	local patch2 = memory.readdword(0x2CC8)
	local patch3 = memory.readdword(0x8e94e)
	if (patch1 == 0x734AABE4) and (patch2 == 0x3F50A405) and (patch3 == 0x9BF781C3) then
		gamestate.patched = true 
	else
		gamestate.patched = false
	end 
end 

function gamestate.read_game_vars()
	--------------------------
	-- frame number and speed
	--------------------------
	gamestate.frame_number 	= rb(addresses.global.frame_number)
	gamestate.turbo 		= rb(addresses.global.turbo)
	gamestate.frameskip		= rb(addresses.global.frameskip)
	gamestate.round_timer	= rb(addresses.global.round_timer)
	---------------------
	-- current state
	---------------------
	--gamestate.patched 	= gamestate.update_patch()
	gamestate.curr_state 	= rw(addresses.global.curr_gamestate)
	gamestate.is_in_match 	= (rw(addresses.global.match_state) ~= 0)
	---------------------
	-- counters
	---------------------
	gamestate.hit_counter 	= rb(addresses.global.hit_counter)
	---------------------
	-- screen related
	---------------------
	gamestate.screen_x		= rw(addresses.global.screen_x)
	gamestate.screen_y		= rw(addresses.global.screen_y)
end

local function isAttacking(_player_obj)
	if _player_obj.character ~= Blanka and _player_obj.character ~= Claw then
		return rb(_player_obj.addresses.attack_flag) > 0x00 
	elseif _player_obj.character == Blanka then 
		return rb(_player_obj.addresses.attack_flag) > 0x00 or _player_obj.state == doing_special_move -- Forward and Back Dashes will return true 
	elseif _player_obj.character == Claw then 
		if _player_obj.state == doing_special_move and rb(_player_obj.addresses.attack_flag) > 0x00 and _player_obj.pos_y > 0x40 then 
			if rb(_player_obj.base + 0x05) ~= 0x04 then
				return false
			else
				return true
			end
		elseif _player_obj.state == doing_special_move or rb(_player_obj.addresses.attack_flag) > 0x00 then 
			return true
		end
	end
end

function gamestate.stock_game_vars()
	return {
	--------------------------
	-- frame number and speed
	--------------------------
	frame_number 			= gamestate.frame_number,
	turbo					= gamestate.turbo,
	frameskip				= gamestate.frameskip,
	round_timer				= gamestate.round_timer,
	---------------------
	-- current state
	---------------------
	patched					= gamestate.patched,
	curr_state				= gamestate.curr_state,
	is_in_match				= gamestate.is_in_match,
	---------------------
	-- counters
	---------------------
	hit_counter				= gamestate.hit_counter,
	}
end

function gamestate.read_player_vars(_player_obj)
	-----------------
	-- State
	-----------------
	_player_obj.state  				= rb(_player_obj.addresses.state)
	_player_obj.substate  			= rb(_player_obj.addresses.substate)
	_player_obj.air_state			= rb(_player_obj.addresses.airborn)
	_player_obj.airborn 			= (rb(_player_obj.addresses.airborn) > 0x00)
	_player_obj.projectile_ready 	= (rb(_player_obj.addresses.projectile_ready) == 0x00)
	_player_obj.cancel_ready		= (rb(_player_obj.addresses.special_cancel) > 0x00)
	_player_obj.dizzy				= (rb(_player_obj.addresses.dizzy_flag) > 0x00)
	-----------------
	-- Gauges
	-----------------
	_player_obj.life 				= rw(_player_obj.addresses.life)
	_player_obj.life_backup 		= rw(_player_obj.addresses.life_backup)
	_player_obj.life_hud 			= rw(_player_obj.addresses.life_hud)
	_player_obj.special_meter 		= rb(_player_obj.addresses.special_meter)
	_player_obj.stun_meter 			= rb(_player_obj.addresses.stun_meter)
	_player_obj.destun_meter		= rw(_player_obj.addresses.destun_meter)
	-----------------
	-- Position
	-----------------
	_player_obj.pos_x  				= rw(_player_obj.addresses.pos_x)
	_player_obj.pos_y  				= rw(_player_obj.addresses.pos_y)
	_player_obj.flip_input 			= (rb(_player_obj.addresses.flip_x) == 0x01)
	_player_obj.is_cornered			= (rb(_player_obj.addresses.cornered_flag) == 0x01 or rb(_player_obj.addresses.cornered_flag) == 0x02)
	-----------------
	-- Character
	-----------------
	_player_obj.character 			= rb(_player_obj.addresses.character)
	_player_obj.is_old 				= (rb(_player_obj.addresses.char_old) == 0x01)
	-----------------
	-- Counters
	-----------------
	_player_obj.hitfreeze_counter 	= rb(_player_obj.addresses.hitfreeze_counter)
	_player_obj.in_hitfreeze		= (_player_obj.hitfreeze_counter ~= 0)
	_player_obj.hitstun_counter 	= rb(_player_obj.addresses.hitstun_counter)
	-- _player_obj.in_hitstun =
	--readInHitstun(_player_obj) 
	_player_obj.stun_counter 		= rw(_player_obj.addresses.stun_counter)
	_player_obj.combo_counter		= rb(_player_obj.addresses.combo_counter)
	-----------------
	-- Throw related
	-----------------
	_player_obj.throw_flag 			= rb(_player_obj.addresses.throw_flag)
	_player_obj.grab_flag			= rb(_player_obj.addresses.grab_flag)
	_player_obj.grab_break			= rb(_player_obj.addresses.grab_break)
	_player_obj.grab_strength		= rb(_player_obj.addresses.grab_strength)
	--------------------
	-- Reversal related
	--------------------
	if _player_obj.character ~= 0x0A then
	_player_obj.reversal_flag 		= rb(_player_obj.addresses.reversal_flag)
	else
	_player_obj.reversal_flag 		= rb(_player_obj.addresses.reversal_flag_boxer)
	end 
	_player_obj.reversal_id 		= rb(_player_obj.addresses.reversal_id)
	_player_obj.reversal_strength 	= rb(_player_obj.addresses.reversal_strength)
	-----------------
	-- Animation
	-----------------
	_player_obj.animation_id 			= memory.readdword(_player_obj.addresses.animation_ptr)
	_player_obj.animation_frames_left	= rb(_player_obj.addresses.animation_frames_left)
	-- _player_obj.hitbox_id	 		= memory.readdword(_player_obj.addresses.hitbox_ptr )
	_player_obj.is_attacking			= isAttacking(_player_obj)
	_player_obj.hurting_move			= rb(_player_obj.addresses.attack_flag) > 0x00
	-----------------
	-- Inputs
	-----------------
	_player_obj.curr_input 			= rw(_player_obj.addresses.curr_input)
	_player_obj.prev_input 			= rw(_player_obj.addresses.prev_input)
end 

function gamestate.stock_player_vars(_player_obj)
	return {
	-----------------
	-- State
	-----------------
	state							= _player_obj.state,
	substate 						= _player_obj.substate,
	air_state						= _player_obj.air_state,
	airborn							= _player_obj.airborn,
	projectile_ready 				= _player_obj.projectile_ready,
	cancel_ready					= _player_obj.cancel_ready,
	dizzy							= _player_obj.dizzy,
	-----------------
	-- Gauges
	-----------------
	life 							= _player_obj.life,
	--life_backup					= _player_obj.life_backup,
	life_hud 						= _player_obj.life_hud,
	special_meter 					= _player_obj.special_meter,
	stun_meter						= _player_obj.stun_meter,
	--destun_meter					= _player_obj.destun_meter,
	-----------------
	-- Position
	-----------------
	pos_x							= _player_obj.pos_x,
	pos_y							= _player_obj.pos_y,
	flip_input						= _player_obj.flip_input,
	is_cornered						= _player_obj.is_cornered,
	-----------------
	-- Character
	-----------------
	character						= _player_obj.character,
	is_old							= _player_obj.is_old,
	-----------------
	-- Counters
	-----------------
	hitfreeze_counter				= _player_obj.hitfreeze_counter,
	in_hitfreeze					= _player_obj.in_hitfreeze,
	--hitfreeze_end					= _player_obj.hitfreeze_end,
	hitstun_counter					= _player_obj.hitstun_counter,
	in_hitstun						= _player_obj.in_hitstun,
	--stun_counter					= _player_obj.stun_counter,
	--combo_counter					= _player_obj.combo_counter,
	-----------------
	-- Throw related
	-----------------
	throw_flag 					= _player_obj.throw_flag,
	--grab_flag 					= _player_obj.grab_flag,
	--grab_break 					= _player_obj.grab_break,
	--grab_strength 				= _player_obj.grab_strength,
	--------------------
	-- Reversal related
	--------------------
	--reversal_flag					= _player_obj.reversal_flag,
	--reversal_id					= _player_obj.reversal_id,
	--reversal_strength				= _player_obj.reversal_strength,
	-----------------
	-- Animation
	-----------------
	animation_id 					= _player_obj.animation_id,
	animation_frames_left			= _player_obj.animation_frames_left,
	--hitbox_id						= _player_obj.hitbox_id,
	is_attacking					= _player_obj.is_attacking,
	hurting_move					= _player_obj.hurting_move,
	-----------------
	-- Inputs
	-----------------
	curr_input						= _player_obj.curr_input,
	prev_input						= _player_obj.prev_input,
	}
end