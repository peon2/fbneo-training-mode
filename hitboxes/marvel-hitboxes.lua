--[[
--print("CPS-2 Marvel series hitbox viewer")
--print("February 20, 2012")
--print("http://code.google.com/p/mame-rr/wiki/Hitboxes")
--print("Lua hotkey 1: toggle blank screen")
--print("Lua hotkey 2: toggle object axis")
--print("Lua hotkey 3: toggle hitbox axis")
--print("Lua hotkey 4: toggle pushboxes")
--print("Lua hotkey 5: toggle throwable boxes")
--]]

local boxes = {
	      ["vulnerability"] = {color = 0x7777FF, fill = 0x20, outline = 0xFF},
	             ["attack"] = {color = 0xFF0000, fill = 0x40, outline = 0xFF},
	["proj. vulnerability"] = {color = 0x00FFFF, fill = 0x40, outline = 0xFF},
	       ["proj. attack"] = {color = 0xFF66FF, fill = 0x40, outline = 0xFF},
	               ["push"] = {color = 0x00FF00, fill = 0x20, outline = 0xFF},
	    ["potential throw"] = {color = 0xFFFF00, fill = 0x00, outline = 0x00}, --not visible by default
	       ["active throw"] = {color = 0xFFFF00, fill = 0x40, outline = 0xFF},
	          ["throwable"] = {color = 0xF0F0F0, fill = 0x20, outline = 0xFF},
}

local globals = {
	blank_color          = 0xFFFFFFFF,
	axis_color           = 0xFFFFFFFF,
	axis_size            = 12,
	mini_axis_size       = 2,
	blank_screen         = false,
	draw_axis            = true,
	draw_mini_axis       = false,
	draw_pushboxes       = true,
	draw_throwable_boxes = false,
	no_alpha             = false, --fill = 0x00, outline = 0xFF for all box types
}

--------------------------------------------------------------------------------
-- game-specific modules

local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local any_true, update_push, no_push
local game, frame_buffer

local profile = {
{	game = "xmcota",
	number_players = 2,
	address = {
		player         = 0xFF4000,
		match_status   = 0xFF4800,
		projectile_ptr = 0xFFD6C4,
		stage          = 0xFF488F,
	},
	offset = {
		flip           = 0x4D,
		character_id   = 0x50,
		addr_table_ptr = 0x88, 
		proj_ptr_space = 0x1C8,
		stage_base = {
			-0x3680, -0x3600, -0x3600, -0x3600, -0x3600, -0x3600, -0x3600, -0x3600, 
			-0x3600, -0x3600, -0x3600, -0x3680, -0x3680, -0x3680, -0x3680, -0x3600,
		},
	},
	stage_lag = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, fba = 1},
	box_list = {
		{id_ptr = 0xA2, type = "push"},
		{id_ptr = 0x74, type = "vulnerability"},
		{id_ptr = 0x76, type = "vulnerability"},
		{id_ptr = 0x78, type = "vulnerability"},
		{id_ptr = 0x7A, type = "vulnerability"},
		{id_ptr = 0x7C, type = "throwable"},
		{id_ptr = 0x70, type = "attack"},
		{id_ptr = 0x72, type = "attack"},
	},
	pushbox_data = { base = 0x0C15E2, 
		["xmcotajr"] = -0x9FA0, --941208
		["xmcotaj3"] = -0xCEC, ["xmcotaar1"] = -0xCEC, --941217
		["xmcotaj2"] = -0xB52, --941219
		["xmcotaj1"] = -0xB24, --941222
		["xmcota"] = 0x36, ["xmcotaa"] = 0, ["xmcotad"] = 0, ["xmcotahr1"] = 0, ["xmcotaj"] = 0, ["xmcotau"] = 0, --950105
		["xmcotah"] = 0x36, --950331
	},
	push_check = { base = 0x00A010,
		["xmcotajr"] = -0x614, --941208
		["xmcotaj3"] = -0x56, ["xmcotaar1"] = -0x56, --941217
		["xmcotaj2"] = -0x34, --941219
		["xmcotaj1"] = -0x32, --941222
		["xmcota"] = 0, ["xmcotaa"] = 0, ["xmcotad"] = 0, ["xmcotahr1"] = 0, ["xmcotaj"] = 0, ["xmcotau"] = 0, --950105
		["xmcotah"] = 0, --950331
		func = function()
			update_push(0xFF4000, 0xFF4400, 0x10A)
		end,
	},
	throw_check = { base  = 0x01544A,
		["xmcotajr"] = -0x2E9A, --941208
		["xmcotaj3"] = -0x5CA, ["xmcotaar1"] = -0x5CA, --941217
		["xmcotaj2"] = -0x544, --941219
		["xmcotaj1"] = -0x520, --941222
		["xmcota"] = 0, ["xmcotaa"] = 0, ["xmcotad"] = 0, ["xmcotahr1"] = 0, ["xmcotaj"] = 0, ["xmcotau"] = 0, --950105
		["xmcotah"] = 0, --950331
	},
	match_active = function(p1_base, stage)
		return stage < 0xC
	end,
	no_hit = function(obj, box) return any_true({
		rb(obj.base + 0x083) == 0,
	}) end,
	invulnerable = function(obj, box) return any_true({
		rb(obj.base + 0x084) == 0,
	}) end,
	unpushable = function(obj, box) return any_true({
		obj.projectile ~= nil,
		rw(obj.base + 0x10A) > 0,
		rw(obj.base + 0x006) == 0x04,
		rw(obj.base + 0x006) == 0x08,
	}) end,
	unthrowable = function(obj, box) return any_true({
		bit.band(rb(0xFF480F), 0x08) > 0,
		rb(obj.base + 0x125) > 0,
		rb(0xFF4800) ~= 0x04,
		rb(obj.base + 0x11E) >= 0x02,
		rb(obj.base + 0x084) == 0 and rb(obj.base + 0x10C) == 0,
		rb(obj.base + 0x137) > 0,
		rw(obj.base + 0x006) == 0 and 
		(rb(obj.base + 0x0A0) == 0x1C or rb(obj.base + 0x0A0) == 0x1E),
	}) end,
},
{	game = "msh",
	number_players = 2,
	address = {
		player         = 0xFF4000,
		match_status   = 0xFF4800,
		projectile_ptr = 0xFFE400,
		stage          = 0xFF4893,
	},
	offset = {
		flip           = 0x4D,
		character_id   = 0x50,
		addr_table_ptr = 0x90,
		proj_ptr_space = 0x148,
		stage_base = {
			-0x3600, -0x3600, -0x3600, -0x3600, -0x3680, -0x3600, -0x3500, -0x3600, 
			-0x3600, -0x3600, -0x3600, -0x3600, -0x3600, -0x3600, -0x3600, -0x3600,
		},
	},
	stage_lag = {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, fba = 1},
	box_list = {
		{id_ptr = 0xA2, type = "push"},
		{id_ptr = 0x78, type = "vulnerability"},
		{id_ptr = 0x7A, type = "vulnerability"},
		{id_ptr = 0x7C, type = "vulnerability"},
		{id_ptr = 0x7E, type = "vulnerability"},
		{id_ptr = 0x80, type = "throwable"},
		{id_ptr = 0x74, type = "attack"},
		{id_ptr = 0x76, type = "attack"},
	},
	pushbox_data = { base = 0x09E82C,
		["msh"] = 0, ["msha"] = 0, ["mshjr1"] = 0, ["mshud"] = 0, ["mshu"] = 0, --951024
		["mshb"] = 0x132, ["mshh"] = 0x132, ["mshj"] = 0x132, --951117
	},
	push_check = { base = 0x00DD0A,
		["msh"] = 0, ["msha"] = 0, ["mshjr1"] = 0, ["mshud"] = 0, ["mshu"] = 0, --951024
		["mshb"] = 0x8, ["mshh"] = 0x8, ["mshj"] = 0x8, --951117
		func = function()
			update_push(0xFF4000, 0xFF4400, 0x10A)
		end,
	},
	throw_check = { base  = 0x091882, 
		["msh"] = 0, ["msha"] = 0, ["mshjr1"] = 0, ["mshud"] = 0, ["mshu"] = 0, --951024
		["mshb"] = 0x18, ["mshh"] = 0x18, ["mshj"] = 0x18, --951117
	},
	match_active = function(p1_base, stage)
		return rd(0xFF8FA2) == p1_base
	end,
	no_hit = function(obj, box) return any_true({
		rb(obj.base + 0x086) == 0,
	}) end,
	invulnerable = function(obj, box) return any_true({
		rb(obj.base + 0x087) == 0,
	}) end,
	unpushable = function(obj, box) return any_true({
		obj.projectile ~= nil,
		rb(obj.base + 0x10A) > 0,
		rw(obj.base + 0x006) == 0x04,
	}) end,
	unthrowable = function(obj, box) return any_true({
		bit.band(rb(0xFF480F), 0x08) > 0,
		rb(obj.base + 0x125) > 0,
		rb(0xFF4800) ~= 0x08,
		rb(obj.base + 0x11E) >= 0x02,
		rb(obj.base + 0x087) == 0 and rb(obj.base + 0x10C) == 0,
		rb(obj.base + 0x137) > 0,
		rw(obj.base + 0x006) == 0 and 
		(rb(obj.base + 0x0A0) == 0x24 or rb(obj.base + 0x0A0) == 0x26),
	}) end,
},
{	game = "xmvsf",
	number_players = 4,
	address = {
		player         = 0xFF4000,
		match_status   = 0xFF5000,
		projectile_ptr = 0xFFE3D8,
		stage          = 0xFF5113,
	},
	offset = {
		flip           = 0x4B,
		character_id   = 0x52,
		addr_table_ptr = 0x6C,
		proj_ptr_space = 0x150,
		stage_base = {
			-0x2CC0, -0x2DC0, -0x2DC0, -0x2D40, -0x2DC0, -0x2DC0, -0x2CC0, -0x2DC0, 
			-0x2D40, -0x2D40, -0x2DC0, -0x2DC0, -0x2DC0, -0x2DC0, -0x2DC0, -0x2DC0,
		},
	},
	stage_lag = {1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, fba = 1},
	box_list = {
		{id_ptr = 0xA4, projectile_id_ptr = 0xB2, type = "push"},
		{id_ptr = 0x74, type = "vulnerability"},
		{id_ptr = 0x76, type = "vulnerability"},
		{id_ptr = 0x78, type = "vulnerability"},
		{id_ptr = 0x7A, type = "vulnerability"},
		{id_ptr = 0x7C, type = "throwable"},
		{id_ptr = 0x70, type = "attack"},
		{id_ptr = 0x72, type = "attack"},
	},
	pushbox_data = { base = 0x08B022, 
		["xmvsfjr2"] = -0x16E, --960909
		["xmvsfar2"] = -0x134, ["xmvsfr1"] = -0x134, ["xmvsfjr1"] = -0x134, --960910
		["xmvsfar1"] = 0, --960919
		["xmvsf"] = 0, ["xmvsfh"] = 0, ["xmvsfj"] = 0, ["xmvsfu1d"] = 0, ["xmvsfur1"] = 0, --961004
		["xmvsfa"] = 0x2E, ["xmvsfb"] = 0x2E, ["xmvsfu"] = 0x2E, --961023
	},
	push_check = { base = 0x0104D4,
		["xmvsfjr2"] = -0x28, --960909
		["xmvsfar2"] = -0x22, ["xmvsfr1"] = -0x22, ["xmvsfjr1"] = -0x22, --960910
		["xmvsfar1"] = 0, --960919
		["xmvsf"] = 0, ["xmvsfh"] = 0, ["xmvsfj"] = 0, ["xmvsfu1d"] = 0, ["xmvsfur1"] = 0, --961004
		["xmvsfa"] = 0xE, ["xmvsfb"] = 0xE, ["xmvsfu"] = 0xE, --961023
		func = function()
			update_push(0xFF4000, 0xFF4400, 0x10A)
		end,
	},
	throw_check = { base  = 0x07CC62, 
		["xmvsfjr2"] = -0x74, --960909
		["xmvsfar2"] = -0x4A, ["xmvsfr1"] = -0x4A, ["xmvsfjr1"] = -0x4A, --960910
		["xmvsfar1"] = 0x8, --960919
		["xmvsf"] = 0, ["xmvsfh"] = 0, ["xmvsfj"] = 0, ["xmvsfu1d"] = 0, ["xmvsfur1"] = 0, --961004
		["xmvsfa"] = 0x2E, ["xmvsfb"] = 0x2E, ["xmvsfu"] = 0x2E, --961023
	},
	match_active = function(p1_base, stage)
		return rd(0xFFA014) == p1_base
	end,
	no_hit = function(obj, box) return any_true({
		rb(obj.base + 0x082) == 0,
	}) end,
	invulnerable = function(obj, box) return any_true({
		rb(obj.base + 0x083) == 0,
	}) end,
	unpushable = function(obj, box) return any_true({
		obj.projectile ~= nil and rw(obj.base + 0x24) ~= 0x94, --Apocalypse fist
		not obj.projectile and obj.base > 0xFF4400, --only the two point chars can push
		not obj.projectile and rb(obj.base + 0x105) > 0,
		not obj.projectile and rw(obj.base + 0x006) == 0x04,
	}) end,
	unthrowable = function(obj, box) return any_true({
		bit.band(rb(0xFF500F), 0x08) > 0,
		rb(obj.base + 0x221) > 0,
		rb(0xFF5031) > 0,
		rb(obj.base + 0x120) > 0,
		rb(0xFF5000) ~= 0x08,
		rb(obj.base + 0x10A) >= 0x02,
		rb(obj.base + 0x083) == 0,
		rw(obj.base + 0x006) == 0 and 
		(rb(obj.base + 0x0A0) == 0x24 or rb(obj.base + 0x0A0) == 0x26),
		rw(obj.base + 0x006) == 0x0C,
	}) end,
},
{	game = "mshvsf",
	number_players = 4,
	address = {
		player         = 0xFF3800,
		match_status   = 0xFF4800,
		projectile_ptr = 0xFFE32E,
		stage          = 0xFF4913,
	},
	offset = {
		flip           = 0x4B,
		character_id   = 0x52,
		addr_table_ptr = 0x6C,
		proj_ptr_space = 0x150,
		stage_base = {
			-0x34C0, -0x35C0, -0x35C0, -0x3540, -0x35C0, -0x35C0, -0x34C0, -0x35C0, 
			-0x3540, -0x3540, -0x35C0, -0x35C0, -0x35C0, -0x35C0, -0x35C0, -0x35C0,
		},
	},
	stage_lag = {1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, fba = 1},
	box_list = {
		{id_ptr = 0xA4, projectile_id_ptr = 0xB2, type = "push"},
		{id_ptr = 0x74, type = "vulnerability"},
		{id_ptr = 0x76, type = "vulnerability"},
		{id_ptr = 0x78, type = "vulnerability"},
		{id_ptr = 0x7A, type = "vulnerability"},
		{id_ptr = 0x7C, type = "throwable"},
		{id_ptr = 0x70, type = "attack"},
		{id_ptr = 0x72, type = "attack"},
	},
	pushbox_data = { base = 0x137EE2, 
		["mshvsfa1"] = -0x52, --970620
		["mshvsf"] = 0, ["mshvsfa"] = 0, ["mshvsfb1"] = 0, ["mshvsfh"] = 0, ["mshvsfj2"] = 0, ["mshvsfu1"] = 0, ["mshvsfu1d"] = 0, --970625
		["mshvsfj1"] = 0x276, --970702
		["mshvsfj"] = 0x302, --970707
		["mshvsfu"] = 0x2E4, ["mshvsfb"] = 0x2E4, --970827
	},
	push_check = { base = 0x011922,
		["mshvsfa1"] = -0x34, --970620
		["mshvsf"] = 0, ["mshvsfa"] = 0, ["mshvsfb1"] = 0, ["mshvsfh"] = 0, ["mshvsfj2"] = 0, ["mshvsfu1"] = 0, ["mshvsfu1d"] = 0, --970625
		["mshvsfj1"] = -0x4, --970702
		["mshvsfj"] = -0x4, --970707
		["mshvsfu"] = -0x4, ["mshvsfb"] = -0x4, --970827
		func = function()
			update_push(memory.getregister("m68000.a2"), memory.getregister("m68000.a3"), 0x105)
		end,
	},
	throw_check = { base  = 0x0B0A58, 
		["mshvsfa1"] = -0x3C, --970620
		["mshvsf"] = 0, ["mshvsfa"] = 0, ["mshvsfb1"] = 0, ["mshvsfh"] = 0, ["mshvsfj2"] = 0, ["mshvsfu1"] = 0, ["mshvsfu1d"] = 0, --970625
		["mshvsfj1"] = 0x276, --970702
		["mshvsfj"] = 0x302, --970707
		["mshvsfu"] = 0x2E4, ["mshvsfb"] = 0x2E4, --970827
	},
	match_active = function(p1_base, stage)
		return rd(0xFF9F2A) == p1_base
	end,
	no_hit = function(obj, box) return any_true({
		rb(obj.base + 0x082) == 0,
	}) end,
	invulnerable = function(obj, box) return any_true({
		rb(obj.base + 0x083) == 0,
	}) end,
	unpushable = function(obj, box) return any_true({
		obj.projectile ~= nil and rw(obj.base + 0x24) ~= 0x94, --Apocalypse fist
		not obj.projectile and rb(obj.base) == 0,
		not obj.projectile and rw(obj.base + 0x006) == 0x04,
		not obj.projectile and rb(obj.base + 0x105) > 0,
	}) end,
	unthrowable = function(obj, box) return any_true({
		bit.band(rb(0xFF480F), 0x08) > 0,
		rb(0xFF4831) > 0,
		rb(obj.base + 0x261) > 0,
		rb(obj.base + 0x120) > 0,
		rb(0xFF4800) ~= 0x08,
		rb(obj.base + 0x10A) >= 0x02,
		rb(obj.base + 0x083) == 0,
		rw(obj.base + 0x006) == 0 and 
		(rb(obj.base + 0x0A0) == 0x24 or rb(obj.base + 0x0A0) == 0x26),
		rw(obj.base + 0x006) == 0x0C,
		rw(obj.base + 0x006) == 0x08,
	}) end,
},
{	game = "mvsc",
	number_players = 4,
	address = {
		player         = 0xFF3000,
		match_status   = 0xFF4000,
		projectile_ptr = 0xFFDF1A,
		stage          = 0xFF4113,
	},
	offset = {
		flip           = 0x4B,
		character_id   = 0x52,
		addr_table_ptr = 0x6C,
		proj_ptr_space = 0x158,
		stage_base = {
			-0x3DA0, -0x3DA0, -0x3DA0, -0x3D20, -0x3D20, -0x3DA0, -0x3DA0, -0x3E20, 
			-0x3E20, -0x3CA0, -0x3DA0, -0x3DA0, -0x3DA0, -0x3DA0, -0x3DA0, -0x3DA0,
		},
	},
	stage_lag = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, fba = 1},
	box_list = {
		{id_ptr = 0xB4, type = "push"},
		{id_ptr = 0x74, type = "vulnerability"},
		{id_ptr = 0x76, type = "vulnerability"},
		{id_ptr = 0x78, type = "vulnerability"},
		{id_ptr = 0x7A, type = "vulnerability"},
		{id_ptr = 0x7C, type = "throwable"},
		{id_ptr = 0x70, type = "attack"},
		{id_ptr = 0x72, type = "attack"},
	},
	pushbox_data = { base = 0x0E6FEE,
		["mvscur1"] = -0x1248, --971222
		["mvscar1"] = -0x10FA, ["mvscr1"] = -0x10FA, ["mvscjr1"] = -0x10FA, --980112
		["mvsc"] = 0, ["mvsca"] = 0, ["mvscb"] = 0, ["mvsch"] = 0, ["mvscj"] = 0, ["mvscud"] = 0, ["mvscu"] = 0, --980123
	},
	push_check = { base = 0x0137CE, 
		["mvscur1"] = -0x28, --971222
		["mvscar1"] = -0x34, ["mvscr1"] = -0x34, ["mvscjr1"] = -0x34, --980112
		["mvsc"] = 0, ["mvsca"] = 0, ["mvscb"] = 0, ["mvsch"] = 0, ["mvscj"] = 0, ["mvscud"] = 0, ["mvscu"] = 0, --980123
		func = function()
			update_push(memory.getregister("m68000.a2"), memory.getregister("m68000.a3"), 0x115)
		end,
	},
	throw_check = { base = 0x0D75E8, 
		["mvscur1"] = -0x1156, --971222
		["mvscar1"] = -0x10FA, ["mvscr1"] = -0x10FA, ["mvscjr1"] = -0x10FA, --980112
		["mvsc"] = 0, ["mvsca"] = 0, ["mvscb"] = 0, ["mvsch"] = 0, ["mvscj"] = 0, ["mvscud"] = 0, ["mvscu"] = 0, --980123
	},
	match_active = function(p1_base, stage)
		return rd(0xFF963E) == p1_base
	end,
	no_hit = function(obj, box) return any_true({
		rb(obj.base + 0x082) == 0,
	}) end,
	invulnerable = function(obj, box) return any_true({
		rb(obj.base + 0x083) == 0,
	}) end,
	unpushable = function(obj, box) return any_true({
		obj.projectile ~= nil,
		rb(obj.base) == 0,
		rw(obj.base + 0x006) == 0x04,
		rb(obj.base + 0x115) > 0,
	}) end,
	unthrowable = function(obj, box) return any_true({
		bit.band(rb(0xFF400F), 0x08) > 0,
		rb(0xFF4031) > 0,
		rb(obj.base) == 0,
		rw(obj.base + 0x270) == 0,
		rb(obj.base + 0x130) > 0,
		rb(0xFF4000) ~= 0x08,
		rb(obj.base + 0x11A) >= 0x02,
		rb(obj.base + 0x083) == 0,
		rw(obj.base + 0x006) > 0,
		rb(obj.base + 0x0B0) == 0x24,
		rb(obj.base + 0x0B0) == 0x26,
		rw(obj.base + 0x006) == 0x0C,
		rw(obj.base + 0x006) == 0x08,
	}) end,
},
}

--------------------------------------------------------------------------------
-- post-process modules

for game in ipairs(profile) do
	local g = profile[game]
	g.offset.player_space = 0x400
	g.offset.pos_x = 0x0C
	g.offset.pos_y = 0x10
	g.address.projectile_limit = g.address.player + g.offset.player_space * g.number_players
	g.match_over = g.match_over or 0x0E
end

for _, box in pairs(boxes) do
	box.fill    = bit.lshift(box.color, 8) + (globals.no_alpha and 0x00 or box.fill)
	box.outline = bit.lshift(box.color, 8) + (globals.no_alpha and (box.outline == 0x00 and 0x00 or 0xFF) or box.outline)
end

local DRAW_DELAY = 1
emu.registerfuncs = fba and memory.registerexec --0.0.7+
if not emu.registerfuncs then
	--print() --print("(FBA-rr 0.0.7+ can show more accurate throwboxes and pushboxes.)")
end


any_true = function(condition)
	for n = 1, #condition do
		if condition[n] == true then return true end
	end
end


local update_push = function(base_1, base_2, offset)
	no_push[base_1] = rb(base_1 + offset) > 0
	no_push[base_2] = rb(base_2 + offset) > 0
end


--------------------------------------------------------------------------------
-- prepare the hitboxes

local display = true
local togglehitboxdisplay = function() display = not display globals.draw_axis = not globals.draw_axis end
input.registerhotkey(3, togglehitboxdisplay) -- Has to be here or script crashes

local get_address = function(obj, box, box_entry)
	box.id = box_entry.id or rw(obj.base + box_entry.id_ptr)
	if box.id == 0 then
		return false
	end

	box.address = rd(obj.base + game.offset.addr_table_ptr) + bit.lshift(bit.band(box.id, 0x1FFF), 3)
end


local process_box_type = {
	["vulnerability"] = function(obj, box, box_entry)
		if get_address(obj, box, box_entry) == false or game.invulnerable(obj, box) then
			return false
		elseif obj.projectile then
			box.type = "proj. vulnerability"
		end
	end,

	["attack"] = function(obj, box, box_entry)
		if get_address(obj, box, box_entry) == false or game.no_hit(obj, box) then
			return false
		elseif bit.band(box.id, 0x8000) > 0 then
			box.type = "potential throw"
			if rw(obj.base + 0x06) > 0 then --hurt
				return false
			end
		elseif obj.projectile then
			box.type = "proj. attack"
		end
	end,

	["active throw"] = function(obj, box, box_entry)
		get_address(obj, box, box_entry)
	end,

	["throwable"] = function(obj, box, box_entry)
		if get_address(obj, box, box_entry) == false or game.unthrowable(obj, box) then
			return false
		end
	end,

	["push"] = function(obj, box, box_entry)
		if any_true({
			not globals.pushbox_base, 
			game.unpushable(obj, box), 
			no_push[obj.base], 
		}) then
			return false
		end
		box.id = rb(obj.base + (obj.projectile and box_entry.projectile_id_ptr or box_entry.id_ptr))
		box.address = rd(globals.pushbox_base + box.id * 2)
		box.address = box.address + bit.lshift(rw(obj.base + game.offset.character_id), 2)
	end,
}


local define_box = function(obj, box_entry)
	local box = {type = box_entry.type}

	if process_box_type[box.type](obj, box, box_entry) == false then
		return nil
	end

	box.rad_x = rw(box.address + 0x2)
	box.rad_y = rw(box.address + 0x6)
	box.val_x = rws(box.address + 0x0)
	box.val_y = rws(box.address + 0x4)

	box.val_x  = obj.pos_x + box.val_x * (bit.band(obj.flip, 1) > 0 and -1 or 1)
	box.val_y  = obj.pos_y + box.val_y * (bit.band(obj.flip, 2) > 0 and box.type ~= "push" and -1 or 1)
	box.left   = box.val_x - box.rad_x
	box.right  = box.val_x + box.rad_x
	box.top    = box.val_y - box.rad_y
	box.bottom = box.val_y + box.rad_y

	return box
end


local update_object = function(f, obj)
	obj.flip  = rb(obj.base + game.offset.flip)
	obj.pos_x = rws(obj.base + game.offset.pos_x) - f.screen_left
	obj.pos_y = rws(obj.base + game.offset.pos_y) - f.screen_top - 0x0F

	for entry = 1, #game.box_list do
		table.insert(obj, define_box(obj, game.box_list[entry]))
	end
	return obj
end


local update_hitboxes = function()
	if not game then
		return
	end
	local stage      = bit.band(rb(game.address.stage), 0xF)
	local stage_base = 0xFF8000 + game.offset.stage_base[stage + 1]

	globals.effective_delay = DRAW_DELAY + (fba and game.stage_lag.fba or game.stage_lag[stage + 1])
	for f = 1, globals.effective_delay do
		frame_buffer[f] = copytable(frame_buffer[f+1])
	end

	frame_buffer[globals.effective_delay+1] = {match_active = rb(game.address.match_status)}
	local f = frame_buffer[globals.effective_delay+1]

	f.match_active = f.match_active > 0 and f.match_active <= game.match_over and 
		game.match_active(game.address.player, stage)
	if not f.match_active then
		return
	end

	f.screen_left = rws(stage_base + game.offset.pos_x) + 0x40
	f.screen_top  = rws(stage_base + game.offset.pos_y)

	for p = 1, game.number_players do --player objects
		local player = {base = game.address.player + (p-1) * game.offset.player_space}
		if game.number_players <= 2 or rb(player.base) > 0 then
			table.insert(f, update_object(f, player))
		end
	end

	for player = 1, 2 do --projectile objects
		local i = 1
		while i do
			local obj = {base = rd(game.address.projectile_ptr + (player-1) * game.offset.proj_ptr_space - i * 4)}
			if obj.base < game.address.projectile_limit then
				i = nil
			else
				obj.projectile = true
				table.insert(f, update_object(f, obj))
				i = i + 1
			end
		end
	end
end

--------------------------------------------------------------------------------
-- draw the hitboxes

local draw_hitbox = function(hb)
	if not hb or any_true({
		not globals.draw_pushboxes and hb.type == "push",
		not globals.draw_throwable_boxes and (hb.type == "potential throw" or hb.type == "throwable"),
		not display,
	}) then return
	end

	if globals.draw_mini_axis then
		gui.drawline(hb.val_x, hb.val_y-globals.mini_axis_size, hb.val_x, hb.val_y+globals.mini_axis_size, boxes[hb.type].outline)
		gui.drawline(hb.val_x-globals.mini_axis_size, hb.val_y, hb.val_x+globals.mini_axis_size, hb.val_y, boxes[hb.type].outline)
	end

	gui.box(hb.left, hb.top, hb.right, hb.bottom, boxes[hb.type].fill, boxes[hb.type].outline)
end


local draw_axis = function(obj)
	gui.drawline(obj.pos_x, obj.pos_y-globals.axis_size, obj.pos_x, obj.pos_y+globals.axis_size, globals.axis_color)
	gui.drawline(obj.pos_x-globals.axis_size, obj.pos_y, obj.pos_x+globals.axis_size, obj.pos_y, globals.axis_color)
	--gui.text(obj.pos_x, obj.pos_y + 0x00, string.format("%06X", obj.base)) --debug
	--gui.text(obj.pos_x, obj.pos_y + 0x08, tostring(no_push[obj.base])) --debug
end


local render_hitboxes = function()
	--gui.clearuncommitted()
	local f = frame_buffer[1]
	if not f.match_active then
		return
	end

	if globals.blank_screen then
		gui.box(0, 0, emu.screenwidth(), emu.screenheight(), globals.blank_color)
	end

	for entry = 1, #game.box_list do
		for _, obj in ipairs(f) do
			draw_hitbox(obj[entry])
		end
	end

	if globals.draw_axis then
		for _, obj in ipairs(f) do
			draw_axis(obj)
		end
	end
end

--------------------------------------------------------------------------------
-- hotkey functions


--[[
input.registerhotkey(1, function()
	globals.blank_screen = not globals.blank_screen
	render_hitboxes()
	emu.message((globals.blank_screen and "activated" or "deactivated") .. " blank screen mode")
end)


input.registerhotkey(2, function()
	globals.draw_axis = not globals.draw_axis
	render_hitboxes()
	emu.message((globals.draw_axis and "showing" or "hiding") .. " object axis")
end)


input.registerhotkey(3, function()
	globals.draw_mini_axis = not globals.draw_mini_axis
	render_hitboxes()
	emu.message((globals.draw_mini_axis and "showing" or "hiding") .. " hitbox axis")
end)


input.registerhotkey(4, function()
	globals.draw_pushboxes = not globals.draw_pushboxes
	render_hitboxes()
	emu.message((globals.draw_pushboxes and "showing" or "hiding") .. " pushboxes")
end)


input.registerhotkey(5, function()
	globals.draw_throwable_boxes = not globals.draw_throwable_boxes
	render_hitboxes()
	emu.message((globals.draw_throwable_boxes and "showing" or "hiding") .. " throwable boxes")
end)
--]]

--------------------------------------------------------------------------------
-- initialize on game startup

local initialize_bps = function()
	for _, pc in ipairs(globals.breakpoints or {}) do
		memory.registerexec(pc, function() end)
	end
	globals.breakpoints = {}
end


local initialize_fb = function()
	no_push, frame_buffer = {}, {}
	for f = 1, DRAW_DELAY + 2 do
		frame_buffer[f] = {}
	end
end


local insert_throw = function()
	local thrower_base = bit.band(0xFFFFFF, memory.getregister("m68000.a6"))
	for _, obj in ipairs(frame_buffer[globals.effective_delay + 0]) do
		if obj.base == thrower_base then
			table.insert(obj, define_box(obj, {id = memory.getregister("m68000.d0"), type = "active throw"}))
			return
		end
	end
	--print(string.format("Breakpoint error: unknown object base %X", thrower_base))
end


local whatgame = function()
	game = nil
	initialize_fb()
	initialize_bps()
	globals.pushbox_base = nil
	for _, module in ipairs(profile) do
		if emu.romname() == module.game or emu.parentname() == module.game then
			game = module
			if game.pushbox_data[emu.romname()] then
				globals.pushbox_base = game.pushbox_data.base + game.pushbox_data[emu.romname()]
			else
				--print("Unrecognized version [" .. emu.romname() .. "]: cannot draw pushboxes")
			end
			--[[
			if not emu.registerfuncs then
				return
			end
			if game.push_check[emu.romname()] and globals.pushbox_base then
				local pc = game.push_check.base + game.push_check[emu.romname()]
				memory.registerexec(pc, game.push_check.func)
				table.insert(globals.breakpoints, pc)
			elseif globals.pushbox_base then
				--print("Unrecognized version [" .. emu.romname() .. "]: cannot accurately draw pushboxes")
			end
			if game.throw_check[emu.romname()] then
				local pc = game.throw_check.base + game.throw_check[emu.romname()]
				memory.registerexec(pc, insert_throw)
				table.insert(globals.breakpoints, pc)
			else
				--print("Unrecognized version [" .. emu.romname() .. "]: cannot draw active throwboxes")
			end
			]]--
			return
		end
	end
	--print("unsupported game: " .. emu.gamename())
end


savestate.registerload(function()
	initialize_fb()
end)

whatgame()

function hitboxesReg()
	if hitboxes.enabled then
		render_hitboxes()
	end
end

function hitboxesRegAfter()
	update_hitboxes()
end

