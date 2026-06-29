assert(rb,"Run fbneo-training-mode.lua")
dofile("games/samsho/samsho.lua") -- mostly only memory locations differ between samsho and samsho2

function gamemsg()
	print "Known issues with samsho2:"
	print "No control over Hikyaku (delivery man)"
end

timer = 0x100AC6

local p1uid
local p2uid

samshostunlookup = 0x00027EB4

uidoffset = { -- see samsho.lua
	P1UIDLocation = 0x100A46,
	P2UIDLocation = 0x100A4A,
	direction = 0x7F,
	character = 0xF6,
	health = 0xBB,
	healthadd = 0xBC,
	meteradd = 0x114,
	meter = 0xF0,
	stunreset = 0xBE,
	stun = 0xC1,
	state = 0xE6,
}

character_state.proximityguard = 0x001F
character_state.lightbladebounceback = 0x002F
character_state.heavybladebounceback = 0x0030,
character_state.lightattackblockstun = 0x030D
character_state.heavyattackblockstun = 0x030E
character_state.lightattackcrouchblockstun = 0x0310
character_state.heavyattackcrouchblockstun = 0x0311
character_state.nobladestandblockstun = 0x0312
character_state.nobladecrouchblockstun = 0x0313
character_state.Cthrow = 0x0400
character_state.Dthrow = 0x0402
character_state.Cthrown = 0x0500
character_state.Dthrown = 0x0502

newRound()

gamedefaultconfig.gamevars.P1.maxmeter = 0 -- samsho2 will run the rage animation often if meter is forced full
gamedefaultconfig.gamevars.P2.maxmeter = 0
gamedefaultconfig.inputs.simple.P1.y = 184 -- space for the super input display
gamedefaultconfig.inputs.simple.P2.y = 184