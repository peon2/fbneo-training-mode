-------------------------------------------------------
-- Memory addresses for Z3
-- Inspired by Grouflon 3rd Strike Training mode
-- https://github.com/Grouflon/3rd_training_lua
-- Made by Asunaro
-------------------------------------------------------
addresses = {
  global = {
	--curr_gamestate	= ,
    frame_number		= 0xFF8080,    
	--slowdown			= ,	
	--turbo				= ,
	--match_state		= ,   
	--stage_select		= ,
	--frameskip			= ,
	--round_timer		= ,
	--hit_counter		= ,
    --screen_x			= ,
    --screen_y			= ,
  },
  players = {
    {
      base 	= 0xFF8400,
      --input = ,
    },
    {
      base 	= 0xFF8800,
      --input = ,
    }
  }
}

for i = 1, 2 do
  addresses.players[i].substate          	= addresses.players[i].base + 0x05  -- byte
  addresses.players[i].state        	  	= addresses.players[i].base + 0x06  -- byte
  addresses.players[i].air_state          	= addresses.players[i].base + 0x07  -- byte
  addresses.players[i].pos_x          		= addresses.players[i].base + 0x11  -- wordsigned
  --addresses.players[i].pos_y          	= addresses.players[i].base + 	    -- wordsigned
  addresses.players[i].flip_x          		= addresses.players[i].base + 0x0B  -- wordsigned
  addresses.players[i].jump_animation       = addresses.players[i].base + 0x4A  -- byte
  addresses.players[i].is_attacking        	= addresses.players[i].base + 0xA9  -- byte
  addresses.players[i].counter_hit_related  = addresses.players[i].base + 0xC7  -- byte
end