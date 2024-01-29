
assert(rb,"Run fbneo-training-mode.lua")
--[[ 
This file is needed so the guipages are loaded at the right moment, but theres one general 
file for al kofs in addon.kof_training_guipages ]]
local rom = emu.romname()
require('addon.kof_training_guipages')
require('games.'..rom..'.moves_settings')

