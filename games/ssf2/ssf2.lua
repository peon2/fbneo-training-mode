assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
dofile("games/sf2/sf2.lua") -- all the logic and hud is the same as sf2

p1uid = 0xFF83CE
p2uid = 0xFF87CE

timer = 0xFF8CCE
musicvolume = 0xF019
maxvolume = 0xFF