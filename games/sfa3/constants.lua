-------------------
-- Player state
-------------------
idle           		= 0x00
crouching			= 0x02 -- Not crouched, but doing the movement of crouching
walking				= 0x04
jumping				= 0x06
doing_normal_move  	= 0x0A
doing_special_move 	= 0x0E
v_trigger			= 0x10
-------------------
-- Player substate
-------------------
being_hit          = 0x02
-------------------
-- Player air state
-------------------
jump_attack        = 0x06