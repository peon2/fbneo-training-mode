--------------------
-- Characters
--------------------
Ryu                = 0x00
Honda              = 0x01
Blanka             = 0x02
Guile              = 0x03
Ken                = 0x04
Chun               = 0x05
Zangief            = 0x06
Dhalsim            = 0x07
Dictator           = 0x08
Sagat              = 0x09
Boxer              = 0x0A
Claw               = 0x0B
Cammy              = 0x0C
Hawk               = 0x0D
Fei                = 0x0E
Deejay             = 0x0F
-------------------
-- Player state
-------------------
standing           = 0x00
crouching          = 0x02
jumping            = 0x04
landing            = 0x06 -- After a throw
blocking_attempt   = 0x08
doing_normal_move  = 0x0A -- 10
doing_special_move = 0x0C -- 12
being_hit          = 0x0E -- 14
being_thrown       = 0x14 -- 20
-------------------
--        Speed
-------------------
turbo0             = 0x80
turbo1             = 0x70
turbo2             = 0x60
turbo3             = 0x50
no_frameskip       = 0xFF
always_frameskip   = 0x00
-------------------
-- Game State
-------------------
in_match           = 0x0A