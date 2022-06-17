----------------------------------------------------------------
-- Inspired by Grouflon 3rd Strike Training mode 
-- https://github.com/Grouflon/3rd_training_lua
----------------------------------------------------------------
require("games/sfa3/memory_addresses")
require("games/sfa3/constants")

gamestate = {
frame_number = 0,
--turbo = 0,
--curr_state = 0,
--is_in_match = false,
--screen_x = 0,
--screen_y = 0,
--patched = false,
player_objects = {},

P1 = nil,
P2 = nil,
--hit_counter = 0
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

function gamestate.read_game_vars()
	--------------------------
	-- frame number and speed
	--------------------------
	gamestate.frame_number 	= rb(addresses.global.frame_number)
	--gamestate.turbo 		= rb(addresses.global.turbo)
	--gamestate.frameskip		= rb(addresses.global.frameskip)
	--gamestate.round_timer	= rb(addresses.global.round_timer)
	---------------------
	-- current state
	---------------------
	--gamestate.curr_state 	= rw(addresses.global.curr_gamestate)
	--gamestate.is_in_match 	= (rw(addresses.global.match_state) ~= 0)
	---------------------
	-- counters
	---------------------
	--gamestate.hit_counter 	= rb(addresses.global.hit_counter)
	---------------------
	-- screen related
	---------------------
	--gamestate.screen_x		= rw(addresses.global.screen_x)
	--gamestate.screen_y		= rw(addresses.global.screen_y)
end

function gamestate.stock_game_vars()
	return {
	--------------------------
	-- frame number and speed
	--------------------------
	frame_number 			= gamestate.frame_number,
	--turbo					= gamestate.turbo,
	--frameskip				= gamestate.frameskip,
	--round_timer				= gamestate.round_timer,
	---------------------
	-- current state
	---------------------
	--curr_state				= gamestate.curr_state,
	--is_in_match				= gamestate.is_in_match,
	---------------------
	-- counters
	---------------------
	--hit_counter				= gamestate.hit_counter,
	}
end

function gamestate.read_player_vars(_player_obj)
	_player_obj.state  					= rb(_player_obj.addresses.state)
	_player_obj.substate  				= rb(_player_obj.addresses.substate)
	_player_obj.air_state				= rb(_player_obj.addresses.air_state)
	_player_obj.pos_x					= rb(_player_obj.addresses.pos_x)
	--_player_obj.pos_y					= rb(_player_obj.addresses.pos_y)
	_player_obj.flip_input				= (rb(_player_obj.addresses.flip_x) == 1)
	_player_obj.is_attacking			= rb(_player_obj.addresses.is_attacking)
	_player_obj.jump_animation			= rb(_player_obj.addresses.jump_animation)
	_player_obj.counter_hit_related		= rb(_player_obj.addresses.counter_hit_related)
	_player_obj.been_air_counter_hit	= ((rb(_player_obj.addresses.jump_animation) ~= 0x00 and rb(_player_obj.addresses.jump_animation) ~= 0x05 and rb(_player_obj.addresses.jump_animation) ~= 0xFB) or rb(0xFF888F) == 0x4C)
end

function gamestate.stock_player_vars(_player_obj)
	return {
	state					= _player_obj.state,
	substate				= _player_obj.substate,
	air_state				= _player_obj.air_state,
	pos_x					= _player_obj.pos_x,
	--pos_y					= _player_obj.pos_y,
	is_attacking			= _player_obj.is_attacking,
	jump					= _player_obj.jump,
	counter_hit_related		= _player_obj.counter_hit_related,	
	been_air_counter_hit	= _player_obj.been_air_counter_hit,
	}
end