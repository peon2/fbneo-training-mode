assert(rb,"Run fbneo-training-mode.lua")
dofile("games/samsho/samsho.lua") -- mostly only memory locations differ between samsho and samsho2

timer = 0x100AC6

local p1uid
local p2uid

uidoffset = { -- see samsho.lua
	P1UIDLocation = 0x100A46,
	P2UIDLocation = 0x100A4A,
	direction = 0x7F,
	health = 0xBB,
	healthadd = 0xBC,
	meteradd = 0x114,
	meter = 0xF0,
	stunreset = 0xBE,
	stun = 0xC1,
	state = 0xE6,
}

samshoNewRound()

gamedefaultconfig.gamevars.P1.maxmeter = 0 -- samsho2 will run the rage animation often if meter is forced full
gamedefaultconfig.gamevars.P2.maxmeter = 0
gamedefaultconfig.inputs.simple.P1.y = 184 -- space for the super input display
gamedefaultconfig.inputs.simple.P2.y = 184