-------------------------------------------------------
-- Memory addresses for ST
-- Inspired by Grouflon 3rd Strike Training mode
-- https://github.com/Grouflon/3rd_training_lua
-- Made by Mcmic and Asunaro
-------------------------------------------------------
addresses = {
  global = {
	curr_gamestate 	= 0xFF8008,
    frame_number 	= 0xFF801D,    
	slowdown 		= 0xFF82F2,	
	bgmusic 		= 0xF018,
	turbo			= 0xFF83A9,
	match_state	    = 0xFF847F,   
	stage_select 	= 0xFF8C4F,
	frameskip 		= 0xFF8CD3,
	round_timer 	= 0xFF8DCE,
	hit_counter		= 0xFF8DE3,
    screen_x 		= 0xFF8ED4,
    screen_y 		= 0xFF8ED8,
  },
  players = {
    {
      base 	= 0xFF844E,
      input = 0xFF8086,
    },
    {
      base 	= 0xFF884E,
      input = 0xFF808A,
    }
  }
}

for i = 1, 2 do
  addresses.players[i].state          		= addresses.players[i].base + 0x03  -- byte
  addresses.players[i].substate       		= addresses.players[i].base + 0x04  -- byte
  addresses.players[i].pos_x          		= addresses.players[i].base + 0x06  -- wordsigned
  addresses.players[i].pos_y          		= addresses.players[i].base + 0x0A  -- wordsigned
  addresses.players[i].flip_x         		= addresses.players[i].base + 0x12  -- byte
  addresses.players[i].animation_frames_left= addresses.players[i].base + 0x19  -- byte
  addresses.players[i].animation_ptr  		= addresses.players[i].base + 0x1A  -- dword
  addresses.players[i].life           		= addresses.players[i].base + 0x2A  -- word
  addresses.players[i].life_backup    		= addresses.players[i].base + 0x2C  -- word
  addresses.players[i].hitbox_ptr     		= addresses.players[i].base + 0x34  -- dword
  addresses.players[i].hitfreeze_counter  	= addresses.players[i].base + 0x47  -- byte
  addresses.players[i].cornered_flag		= addresses.players[i].base + 0x48  -- byte
  addresses.players[i].stun_counter         = addresses.players[i].base + 0x5D  -- word
  addresses.players[i].stun_meter          	= addresses.players[i].base + 0x5F  -- byte
  addresses.players[i].destun_meter         = addresses.players[i].base + 0x60  -- word
  addresses.players[i].throw_flag       	= addresses.players[i].base + 0x63  -- byte
  addresses.players[i].grab_break        	= addresses.players[i].base + 0x7D  -- byte
  addresses.players[i].grab_strength      	= addresses.players[i].base + 0x7F  -- byte
  addresses.players[i].char_select    		= addresses.players[i].base + 0x80  -- byte
  addresses.players[i].hitstun_counter  	= addresses.players[i].base + 0x11D -- byte
  addresses.players[i].reversal_flag	  	= addresses.players[i].base + 0x169 -- byte
  addresses.players[i].reversal_id		  	= addresses.players[i].base + 0x16A -- byte
  addresses.players[i].reversal_strength	= addresses.players[i].base + 0x16B -- byte
  addresses.players[i].reversal_flag_boxer 	= addresses.players[i].base + 0x16D -- byte
  addresses.players[i].grab_flag	      	= addresses.players[i].base + 0x180 -- byte
  addresses.players[i].airborn        		= addresses.players[i].base + 0x181 -- byte
  addresses.players[i].attack_flag        	= addresses.players[i].base + 0x18B -- byte
  addresses.players[i].special_cancel      	= addresses.players[i].base + 0x195 -- byte
  addresses.players[i].life_hud       		= addresses.players[i].base + 0x1BC -- word
  addresses.players[i].projectile_ready     = addresses.players[i].base + 0x1D4 -- byte
  addresses.players[i].dizzy_flag		    = addresses.players[i].base + 0x1F0 -- word
  addresses.players[i].combo_counter	    = addresses.players[i].base + 0x1F4 -- byte
  addresses.players[i].special_meter	    = addresses.players[i].base + 0x2B4 -- byte
  addresses.players[i].character           	= addresses.players[i].base + 0x391 -- byte
  addresses.players[i].curr_input       	= addresses.players[i].base + 0x392 -- word
  addresses.players[i].prev_input      		= addresses.players[i].base + 0x394 -- word
  addresses.players[i].char_old       		= addresses.players[i].base + 0x3B6 -- byte
end
