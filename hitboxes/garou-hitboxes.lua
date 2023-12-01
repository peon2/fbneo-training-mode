--print("Garou Densetsu/Fatal Fury hitbox viewer")
--print("February 20, 2012")
--print("http://code.google.com/p/mame-rr/wiki/Hitboxes")
--print("Lua hotkey 1: toggle blank screen")
--print("Lua hotkey 2: toggle object axis")
--print("Lua hotkey 3: toggle hitbox axis")
--print("Lua hotkey 4: toggle pushboxes")

local boxes = {
	["vulnerability"] = {color = 0x7777FF, fill = 0x40, outline = 0xFF},
	       ["attack"] = {color = 0xFF0000, fill = 0x40, outline = 0xFF},
	 ["proj. attack"] = {color = 0xFF66FF, fill = 0x40, outline = 0xFF},
	         ["push"] = {color = 0x00FF00, fill = 0x20, outline = 0xFF},
	        ["guard"] = {color = 0xCCCCFF, fill = 0x40, outline = 0xFF},
	        ["throw"] = {color = 0xFFFF00, fill = 0x40, outline = 0xFF}, --fatfury3
	   ["axis throw"] = {color = 0xFFAA00, fill = 0x40, outline = 0xFF},
}

local globals = {
	axis_color      = 0xFFFFFFFF,
	blank_color     = 0xFFFFFFFF,
	axis_size       = 12,
	mini_axis_size  = 2,
	blank_screen    = false, --remove all game graphics
	draw_axis       = true,
	draw_mini_axis  = false,
	draw_pushboxes  = true,
	no_alpha        = true, --fill = 0x00, outline = 0xFF for all box types
	throwbox_height = 0x50, --default for ground throws
	no_background   = false, --remove backgrounds for sprite ripping
	bg_color        = 0x8F8F, --color of removed background (16-bit depth) ...broken in FBA?
}

--------------------------------------------------------------------------------
-- game-specific modules

local rb, rbs, rw, rws, rd, fc = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, emu.framecount
local game, buffer, box_buffer, throw_buffer
local offset, any_true, get_obj, set_vulnerable, set_harmless, insert_throw, define_box, gr
local a,v,p,g,t,x = "attack","vulnerability","push","guard","throw","undefined"

local profile = {
{	game = "fatfury1",
	number_players = 3,
	extra_frame = 1,
	no_combos = true,
	match_active = 0x1042CC,
	stage_base   = 0x104100,
	player_base  = 0x100300,
	box_types = {
		v,p,g,g
	},
	box = {
		top = 0x6, bottom = 0x8, left = 0x2, right = 0x4, space = 0xA, scale = 1, header = 2, 
		read = rws,
		get_id = function(address)
			return rw(address)
		end
	},
	adjust_y = function(f, y)
		return y - f.screen_top
	end,
	update_object = function(obj)
		obj.flip_x = bit.band(rb(obj.base + 0x47), 0x01) > 0 and 1 or -1
		obj.hitbox_ptr = rd(obj.base + 0xB2)
		obj.num_boxes = (bit.band(obj.hitbox_ptr, 0xFFFFFF) > 0 and rw(obj.hitbox_ptr)) or 0
		obj.scale = rb(obj.base + 0x4B) + 1
		obj.char_id = rw(obj.base + 0x30)
	end,
	harmless = function(obj)
		return bit.btst(6, rb(obj.base + 0x36)) == 0
	end,
	process_throw = function(obj, box)
		box.right = box.range * obj.flip_x
		box.top = globals.throwbox_height
		box.bottom = 0
	end,
	breakpoints = {
		{base = 0x003ABE, func = function() --vulnerability
			set_vulnerable() end}, 
		{base = 0x009A9A, func = function() --throws
			if rd(gr("a7")) == 0x00755E then
				insert_throw({range = rw(gr("a0"))})
			end
		end}, 

		{base = 0x00EBE4, no_background = true, func = function() --no BG *** setregister for m68000.pc is broken ***
			memory.setregister("m68000.pc", gr("pc")-0x2) end}, 
	},
	remove_background = function()
		if rb(0x100002) == 0x22 then
			memory.writeword(0x1068BA, 0) --HUD
		end
	end,
},
{	game = "fatfury2",
	no_combos = true,
	match_active   = 0x100B89,
	stage_base     = 0x100B00,
	player_base    = 0x100300,
	obj_ptr_offset = 0xBA,
	box_types = {
		p,v,v,g,g,a,a,a,a,g,x,x,x,x,x,a,
		v
	},
	box = {
		top = 0x2, bottom = 0x3, left = 0x4, right = 0x5, space = 0x6, scale = 4, header = 0, 
		read = rbs,
		get_id = function(address)
			return bit.band(rw(address), 0x000F)
		end
	},
	update_object = function(obj)
		obj.flip_x = bit.rol(rw(obj.base + 0x7A), 16+1)
		obj.flip_x = bit.bxor(obj.flip_x, rb(obj.base + 0x67))
		obj.flip_x = bit.band(obj.flip_x, 1) > 0 and 1 or -1
		local hitbox_ptr_offset = rw(obj.base + 0x88)
		obj.hitbox_ptr = rd(obj.base + 0x8A) + bit.band(hitbox_ptr_offset, 0x0FFF) * 6
		obj.num_boxes = bit.rshift(bit.band(hitbox_ptr_offset, 0xF000), 12)
		obj.scale = rb(obj.base + 0x63) + 1
		obj.char_id = rw(obj.base + 0x5C)
	end,
	harmless = function(obj)
		return bit.btst(5, rb(obj.base + 0x7A)) == 0
	end,
	process_throw = function(obj, box)
		if box.range then --ground throws
			box.right = box.range * obj.flip_x
			return
		elseif box.ptr then --air throws
			box.top    = -rws(box.ptr + 0x0)
			box.bottom = -rws(box.ptr + 0x2)
			box.left   = -rws(box.ptr + 0x4) * obj.flip_x
		end
	end,
	breakpoints = {
		{base = 0x028904, func = function() --vulnerability
			set_vulnerable() end},
		{base = 0x013E14, func = function() --ground throws
			local stack = rd(gr("a7") + 0x8)
			for _, throw_type in ipairs({
				{ptr = 0x026320, level = 0}, --HP throw
				{ptr = 0x0274DC, level = 0}, --HK throw
				{ptr = 0x01F368, level = 0}, --kim DM
				{ptr = 0x01D154, level = 0}, --jubei _B,F+LK
				{ptr = 0x01D416, level = 0}, --jubei _B,F+HK
				{ptr = 0x01D6E0, level = 1}, --jubei _D,U+LP
				{ptr = 0x01DA7A, level = 1}, --jubei _D,U+HP
				{ptr = 0x01DC10, level = 1}, --jubei DM
			}) do
				if stack == throw_type.ptr then
					insert_throw({range = rws(gr("a0") + throw_type.level * 2)})
					return
				end
			end
			end},
		{base = 0x0263BC, base = 0x013EFE, func = function() --jubei/laurence airthrow
			local stack = rd(gr("a7"))
			if stack == 0x0199B8 and memory.readwordsigned(gr("a4") + offset.pos_y) > 0 then
				insert_throw({ptr = gr("a0")})
			end
		end},
	},
	remove_background = function()
		memory.writebyte(0x100920, 0x20) memory.writebyte(0x10092B, 0x3C) --HUD
		if rb(0x100002) == 0x43 then
			memory.writebyte(0x1051C9, 0x10) --BG layers
			memory.writebyte(0x1041C1, 0x40) --flashing text
			memory.writeword(0x1041C3, 0) --solid shadows
		end
	end,
},
{	game = "fatfursp",
	match_active   = 0x100A62,
	player_base    = 0x100400,
	stage_base     = 0x100B00,
	obj_ptr_offset = 0xAC,
	box_types = {
		p,v,v,g,g,a,a,a,a,g,x,x,x,x,x,a,
		v
	},
	update_object = function(obj)
		obj.flip_x = rbs(obj.base + 0x62) < 0 and -1 or 1
		obj.hitbox_ptr = rd(obj.base + 0x8A)
		obj.num_boxes  = bit.rshift(obj.hitbox_ptr, 24)
		obj.scale = rb(obj.base + 0x65) + 1
		obj.char_id = rw(obj.base + 0x5C)
	end,
	harmless = function(obj)
		return bit.btst(5, rb(obj.base + 0x7C)) == 0
	end,
	process_throw = function(obj, box)
		obj.opp_base = rd(obj.base + 0xA8)
		obj.opp_id = rw(obj.opp_base + 0x5C)
		obj.side = rbs(obj.base + 0x62) < 0 and 1 or -1
		if box.ground then
			box.ptr = rd(0x027268 + obj.char_id * 4) + bit.lshift(box.ground, 3) + rb(obj.base + 0x92)
			box.ptr = rd(0x0271DC + rb(box.ptr) * 4)
			for _, throw_type in ipairs({
				0x02C066, --F/B+HP
				0x02C0BA, --B+HK jubei
				0x02C10E, --DF+HP jubei
				0x02C162, --DF+HP bear
				0x02D71A, --F/B+HK
				0x02D760, --F+HK jubei
				0x02D7A6, --B+HK bear
			}) do
				if box.ptr == throw_type then
					local range = rd(0x064892 + obj.char_id * 4)
					range = rws(range + (obj.opp_id - 1) * 0xA)
					box.right = range * obj.flip_x
					return
				end
			end
			return false
		elseif box.air then
			local ptr = rd(0x027F70 + obj.char_id * 4) + box.air
			ptr = rb(ptr) * 4 + box.offset
			ptr = rd(ptr)
			for _, throw_type in ipairs({
				0x02C210, --jubei
				0x02C354, --mai
				0x02C4C4, --duck
				0x02C624, --laurence
			}) do
				if ptr == throw_type then
					ptr = rd(0x06491A + obj.char_id * 4)
					ptr = ptr + obj.opp_id * 0x18
					box.top    = -rws(ptr - 0x6)
					box.bottom = -rws(ptr - 0x8)
					box.left   = -rws(ptr - 0x2) * obj.side
					return
				end
			end
			return false
		elseif box.tier then
			local range = rd(0x064892 + obj.char_id * 4)
			range = rws(range + (obj.opp_id - 1) * 0xA + (box.tier - 1) * 2)
			box.right = range * obj.flip_x
		end
	end,
	breakpoints = {
		{base = 0x01803C, func = function() 
			set_vulnerable() end},
		{base = 0x0182F8, func = function() --duplicate?
			set_vulnerable() end},

		{base = 0x0249BA, func = function() --ground throws
			insert_throw({ground = bit.band(0xFFFF, gr("d0"))}) end},
		{base = 0x025AD0, func = function() --air throws
			insert_throw({air = gr("d0"), offset = gr("a1")}) end},
		{base = 0x024210, func = function() --special throw param
			insert_throw({tier = bit.band(0xFF, gr("d0")) + 1}) end},
		{base = 0x030BF0, func = function() --jubei _B,F+LK
			insert_throw({tier = rw(gr("pc") + 0x2)}) end},
		{base = 0x030C98, func = function() --jubei _B,F+HK
			insert_throw({tier = rw(gr("pc") + 0x2)}) end},
		{base = 0x036BE6, func = function() --ryo DM
			local pc = gr("pc")
			insert_throw({
				tier = rw(pc + 0x2) + 1, 
				hard_top = rws(pc + 0xC), 
			}) end},
	},
	clones = {["fatfursa"] = 0},
	remove_background = function()
		local match = rb(0x100003)
		memory.writebyte(0x100920, 0x20) memory.writebyte(0x10092B, 0x3C) --HUD
		if bit.band(match, 0x9F) > 0x90 and bit.band(match, 0x40) == 0 then
			memory.writebyte(0x1051E1, 0x10) --BG layers
			memory.writebyte(0x1041D9, 0x40) --flashing text
			memory.writeword(0x1041DA, 0) --solid shadows
		end
	end,
},
{	game = "fatfury3",
	match_active = 0x100B24,
	player_base  = 0x100400,
	stage_base   = 0x100B00,
	obj_ptr_list = 0x10088A,
	box_types = {
		p,v,v,v,g,g,v,a,a,a,a,a,a,a,a,a,
		a,a,t,g,g
	},
	harmless = function(obj)
		return bit.btst(4, rb(obj.base + 0x6A)) == 0 or rb(obj.base + 0xA8) > 0
	end,
	process_throw = function(obj, box)
		obj.side = rbs(obj.base + 0x58) < 0 and -1 or 1
		if box.ptr then
			box.right  = rws(box.ptr - 0x2) * obj.side
			box.left   = rws(box.ptr - 0x4) * obj.side
			box.top    = rws(box.ptr - 0x6)
			box.bottom = rws(box.ptr - 0x8)
		elseif box.range then
			box.right = box.range * obj.side
		end
	end,
	breakpoints = {
		{base = 0x06449E, func = function() --p1
			set_vulnerable(0xAF) end},
		{base = 0x064506, func = function() --p2
			set_vulnerable(0xAF) end},
		{base = 0x0645B6, func = function() --pushboxes
			insert_box(4, 2) insert_box(3, 1) end},

		{base = 0x0681EC, func = function() --airthrows
			insert_throw({ptr = gr("a0")}) end},
		{base = 0x044ED4, func = function() --sokaku 360
			insert_throw({range = gr("d7")}) end}, 
		{base = 0x04555C, func = function() --mary 360
			insert_throw({range = gr("d7")}) end}, 
		{base = 0x0474B0, func = function() --andy spider hold
			local alt = rws(gr("a4") + 0x28)
			local pc = gr("pc")
			if alt > rws(pc + 0x38) then
				return
			end
			local range = rws(pc + 0x28)
			insert_throw({right = range, left = -range, top = 0}) end}, 
		{base = 0x052B88, func = function() --mary spider hold
			local alt = rws(gr("a4") + 0x28)
			local pc = gr("pc")
			if alt > rws(pc + 0x34) or alt < rws(pc + 0x3E) then
				return
			end
			insert_throw({right = rws(pc + 0x2C), top = 0}) end}, 
		{base = 0x053B72, func = function() --mary DM/SDM
			local alt = rws(gr("a4") + 0x28)
			local pc = gr("pc")
			if alt > rws(pc + 0x34) or alt < rws(pc + 0x3E) then
				return
			end
			insert_throw({right = rws(pc + 0x2C), top = 0}) end}, 

		{base = 0x003718, no_background = true, func = function() --solid shadows
			memory.setregister("m68000.d0", 1) end}, 
	},
	remove_background = function()
		if rb(0x10567A) > 0 and rb(0x10567B) == 0 and rb(0x10562D) == 0x01 then
			memory.writeword(0x100916, 0x0001) --HUD
			memory.writebyte(0x1051E3, 0x00) --BG layers
			memory.writebyte(0x1051E5, 0x01)
		end
	end,
},
{	game = "rbff1",
	match_active = 0x106AA2,
	player_base  = 0x100400,
	stage_base   = 0x100B00,
	obj_ptr_list = 0x100890,
	box_types = {
		p,v,v,v,g,g,v,a,a,a,a,a,a,a,a,a,
		a,a,a,g,g
	},
	harmless = function(obj)
		return bit.btst(4, rb(obj.base + 0x6A)) == 0 or rb(obj.base + 0xA8) > 0
	end,
	process_throw = function(obj, box)
		obj.opp_base = rd(obj.base + 0x94)
		obj.opp_id = rw(obj.opp_base + 0x10)
		obj.side = rbs(obj.base + 0x58) < 0 and -1 or 1
		if box.d7 then --ground throws
			box.address = rd(0x06CBB0 + (game.clones[emu.romname()] or 0) + obj.char_id * 4)
			local range = (obj.opp_id - 1) * 0xC
			range = range + bit.band(box.d7 - 0x60, 0x07) * 2
			range = rws(box.address + range)
			box.right = range * obj.side
		elseif box.ptr then --airthrows
			box.left   = rws(box.ptr - 0x2) * obj.flip_x
			box.right  = rws(box.ptr - 0x4) * obj.flip_x
			box.top    = rws(box.ptr - 0x6)
			box.bottom = rws(box.ptr - 0x8)
		else
			box.right = box.range * obj.side
			if box.mirror then
				box.left = -box.range * obj.side
			end
		end
	end,
	breakpoints = {
		{base = 0x06BCEE, func = function() --p1
			set_vulnerable(0xAF) end},
		{base = 0x06BD58, func = function() --p2
			set_vulnerable(0xAF) end},
		{base = 0x06BE16, func = function() --pushboxes
			insert_box(4, 2) insert_box(3, 1) end},

		{base = 0x06CAFA, func = function() --ground throws
			insert_throw({d7 = bit.band(0xFFFF, gr("d7"))})
		end},
		{base = 0x0709AE, func = function() --airthrows
			insert_throw({ptr = gr("a0")})
		end},
		{base = 0x040ED2, func = function() --sokaku 360; duck dm/sdm; yamazaki sdm
			insert_throw({range = bit.band(0xFFFF, gr("d7"))})
		end},
		{base = 0x043CD6, func = function() --andy spider throw
			local pc = gr("pc")
			local alt = rws(gr("a4") + 0x28)
			if alt > rws(pc + 0x5E) then
				return
			end
			insert_throw({range = rws(pc + 0x4E), top = 0, mirror = true})
		end},
		{base = 0x04EC5C, func = function() --mary spider throw
			local pc = gr("pc")
			local alt = rws(gr("a4") + 0x28)
			if alt > rws(pc + 0x4A) or alt < rws(pc + 0x54) then
				return
			end
			insert_throw({range = rws(pc + 0x42), top = 0})
		end},
		{base = 0x0500EC, func = function() --mary 360
			insert_throw({range = rws(gr("pc") + 0x64)})
		end},
		{base = 0x050C0C, func = function() --mary dm
			insert_throw({range = rws(gr("pc") + 0x34)})
		end},
		{base = 0x051136, func = function() --mary sdm
			insert_throw({range = rws(gr("pc") + 0x3C)})
		end},

		{base = 0x003758, ["rbff1a"] = 0, no_background = true, --solid shadows
			func = function() memory.setregister("m68000.d0", 1) end},
	},
	clones = {["rbff1a"] = 0x1A},
	remove_background = function()
		if rb(0x106A39) ~= 0x01 then
			return
		end
		local match = rb(0x106AA2)
		if match == 0x38 then --HUD
			memory.writebyte(0x106AA2, 0x33)
		end
		if match > 0 and rb(0x106AA3) == 0 then --BG layers
			memory.writebyte(0x1065E3, 0x00)
			memory.writebyte(0x1065E5, 0x01)
		end
	end,
},
{	game = "rbffspec",
	bank_switching = true,
	match_active = 0x106AAE,
	player_base  = 0x100400,
	stage_base   = 0x100E00,
	obj_ptr_list = 0x100C92,
	box_types = {
		p,v,v,v,v,v,v,x,x,x,x,x,x,x,x,x,
		g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,
	},
	harmless = function(obj)
		return bit.btst(3, rb(obj.base + 0x6A)) == 0 or rb(obj.base + 0xAA) > 0 or
			(obj.projectile and rb(obj.base + 0xE7) > 0) or 
			(not obj.projectile and rb(obj.base + 0xB6) == 0)
	end,
	process_throw = function(obj, box)
		obj.opp_base = rd(obj.base + 0x96)
		obj.opp_id = rw(obj.opp_base + 0x10)
		obj.side = rbs(obj.base + 0x58) < 0 and -1 or 1
		if box.pushbox_ptr then --ground throws
			local range = (rb(obj.base + 0x58) == rb(obj.opp_base + 0x58) and 0x4) or 0x3
			range = math.abs(rbs(box.pushbox_ptr + bit.lshift(obj.opp_id, 3) + range) * 4)
			range = range + rbs(box.pushbox_ptr + bit.lshift(obj.char_id, 3) + 0x3) * -4
			box.d7 = (box.d7 == 0x65 and 0x3) or bit.band(box.d7 - 0x60, 0x7)
			range = range + rbs(box.range_ptr + obj.char_id * 4 + box.d7)
			box.right  = range * obj.side
		elseif box.range_y then --air throws
			box.right  = box.range_x * obj.flip_x
			box.top    = -box.range_y
			box.bottom =  box.range_y
		elseif box.range then --special ground throw
			box.right = box.range * obj.side
			if rws (obj.base + offset.pos_y) > 0 then
				box.top = 0
			end
		end
	end,
	breakpoints = {
		{base = 0x0729BA, func = function() set_vulnerable() end}, --p1
		{base = 0x072A0C, func = function() set_vulnerable() end}, --p2
		{base = 0x07299A, func = function() set_vulnerable(0xB1) end},
		{base = 0x07299C, func = function() --check vuln at all times *** setregister for m68000.pc is broken ***
			memory.setregister("m68000.pc", gr("pc") + 0x6) end},
		{base = 0x07299C, func = function() --check vuln at all times *** hackish workaround ***
			memory.setregister("m68000.a3", gr("a3") - 0xB5) end},
		{base = 0x0729A2, func = function() --*** fix for hackish workaround ***
			memory.setregister("m68000.a3", gr("a3") + 0xB5) end},
		{base = 0x00D8CE, ["rbffspeck"] = -0x5E, func = function() insert_box(4, 2) end},
		{base = 0x00D906, ["rbffspeck"] = -0x5E, func = function() insert_box(3, 1, true) end},
		{base = 0x00D9B4, ["rbffspeck"] = -0x5E, func = function() insert_box(4, 2) end}, --p1 push
		{base = 0x00D9EC, ["rbffspeck"] = -0x5E, func = function() insert_box(3, 1) end}, --p2 push

		{base = 0x073DF2, func = function() --ground throws
			local pc = gr("pc")
			insert_throw({
				pushbox_ptr = rd(pc + 0x2), 
				range_ptr = pc + 0xD6, 
				d7 = bit.band(gr("d7"), 0xFFFF), 
		}) end},
		{base = 0x076CFE, func = function() --air throws
			local range_ptr = gr("a0")
			insert_throw({
				range_x = rws(range_ptr + 0x0), 
				range_y = rws(range_ptr + 0x2), 
		}) end}, 
		{base = 0x045660, func = function() --special ground throw
			insert_throw({range = gr("d7")})
		end},
		{base = 0x0544C6, func = function() --ex mary snatcher
			local pc = gr("pc")
			insert_throw({
				range_x = rws(pc + 0x12), 
				range_y = rws(pc + 0x28), 
		}) end}, 
		{base = 0x054F86, func = function() --ex mary dm
			insert_throw({range = rws(gr("pc") + 0x12)})
		end},

		{base = 0x011158, no_background = true, --solid shadows
			func = function() memory.writebyte(gr("a4") + 0x82, 0) end},
	},
	clones = {["rbffspeck"] = -0x11C},
	remove_background = function()
		if rb(0x106A37) ~= 0x01 then
			return
		end
		local match = rb(0x106AAE)
		if match == 0x38 then --HUD
			memory.writebyte(0x106AAE, 0x33)
		end
		if match > 0 then --BG layers
			memory.writebyte(0x1065E3, 0x00)
			memory.writebyte(0x1065E5, 0x01)
		end
	end,
},
{	game = "rbff2",
	bank_switching = true,
	match_active = 0x107C22,
	player_base  = 0x100400,
	stage_base   = 0x100E00,
	obj_ptr_list = 0x100C92,
	box_types = {
		p,v,v,v,v,v,v,x,x,x,x,x,x,x,x,x,
		g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,
	},
	harmless = function(obj)
		return bit.btst(3, rb(obj.base + 0x6A)) == 0 or rb(obj.base + 0xAA) > 0 or
			(obj.projectile and rb(obj.base + 0xE7) > 0) or 
			(not obj.projectile and rb(obj.base + 0xB6) == 0)
	end,
	process_throw = function(obj, box)
		obj.opp_base = rd(obj.base + 0x96)
		obj.opp_id = rw(obj.opp_base + 0x10)
		obj.side = rbs(obj.base + 0x58) < 0 and -1 or 1
		if box.ptr then --ground
			local range = (rb(obj.base + 0x58) == rb(obj.opp_base + 0x58) and 0x4) or 0x3
			range = math.abs(rbs(rd(box.ptr + 0x02) + bit.lshift(obj.opp_id, 3) + range) * 4)
			range = range + rbs(rd(box.ptr + 0x02) + bit.lshift(obj.char_id, 3) + 0x3) * -4
			box.d7 = (box.d7 == 0x65 and 0x3) or bit.band(box.d7 - 0x60, 0x7)
			range = range + rbs(box.ptr + 0xD2 + obj.char_id * 4 + box.d7)
			box.right = range * obj.side
		elseif box.range_y then --air
			box.right  = box.range_x * obj.flip_x
			box.top    = -box.range_y
			box.bottom =  box.range_y
		else --special
			box.right  = box.front * obj.side
			if box.top == 0 then
				box.top    = nil
				box.bottom = nil
			end
		end
	end,
	breakpoints = {
		{base = 0x05C2DA, func = function() set_vulnerable() end}, 
		{base = 0x05C2E6, func = function() set_vulnerable(0xB1) end},
		{base = 0x05C2E8, func = function() --check vuln at all times *** setregister for m68000.pc is broken ***
			memory.setregister("m68000.pc", gr("pc") + 0x6) end},
		{base = 0x05C2E8, --check vuln at all times *** hackish workaround ***
			func = function() memory.setregister("m68000.a3", gr("a3") - 0xB5) end},
		{base = 0x05C2EE, --*** fix for hackish workaround ***
			func = function() memory.setregister("m68000.a3", gr("a3") + 0xB5) end},
		{base = 0x012C42, ["rbff2k"] = 0x28, ["rbff2h"] = 0x0,
			func = function() insert_box(4, 2) end},
		{base = 0x012C88, ["rbff2k"] = 0x28, ["rbff2h"] = 0x0, 
			func = function() insert_box(3, 1, true) end},
		{base = 0x012D4C, ["rbff2k"] = 0x28, ["rbff2h"] = 0x0, --p1 push 
			func = function() insert_box(4, 2) end},
		{base = 0x012D92, ["rbff2k"] = 0x28, ["rbff2h"] = 0x0, --p2 push
			func = function() insert_box(3, 1) end},

		{base = 0x05D782, func = function() --ground throws
			insert_throw({
				ptr = gr("pc"),
				d7 = bit.band(gr("d7"), 0xFFFF),
		}) end},
		{base = 0x060428, func = function() --air throws
			local	ptr = gr("a0")
			insert_throw({
				range_x = rws(ptr + 0x0),
				range_y = rws(ptr + 0x2),
		}) end},
		{base = 0x039F2A, ["rbff2k"] = 0xC, ["rbff2h"] = 0x20, func = function() --special throws
			local	ptr = gr("a0")
			insert_throw({
				front  = rws(ptr + 0x0),
				top    = rws(ptr + 0x2),
				bottom = rws(ptr + 0x4),
		}) end},

		{base = 0x017300, ["rbff2k"] = 0x28, ["rbff2h"] = 0x0, no_background = true, --solid shadows
			func = function() memory.writebyte(gr("a4") + 0x82, 0) end},
	},
	clones = {["rbff2k"] = -0x104, ["rbff2h"] = 0x20},
	remove_background = function()
		if rb(0x107BB9) ~= 0x01 then
			return
		end
		local match = rb(0x107C22)
		if match == 0x38 then --HUD
			memory.writebyte(0x107C22, 0x33)
		end
		if match > 0 then --BG layers
			memory.writebyte(0x107762, 0x00)
			memory.writebyte(0x107765, 0x01)
		end
	end,
},
{	game = "garou",
	bank_switching = true,
	match_active = 0x10748A,
	player_base  = 0x100400,
	stage_base   = 0x100E00,
	obj_ptr_list = 0x100C88,
	box_types = {
		p,v,v,v,v,v,v,x,x,x,x,x,x,x,x,x,
		g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,g,
	},
	adjust_y = function(f, y)
		return y + f.screen_top - 0x4
	end,
	harmless = function(obj)
		return bit.btst(3, rb(obj.base + 0x6A)) == 0 or rb(obj.base + 0xAC) > 0 or 
			(obj.projectile and rb(obj.base + 0xE9) > 0) or 
			(not obj.projectile and rb(obj.base + 0xB8) == 0)
	end,
	process_throw = function(obj, box)
		obj.side = box.air == 0 and 0x59 or 0x58
		obj.side = rbs(obj.base + obj.side) < 0 and -1 or 1
		box.right  = box.front * obj.side
		if box.air == 0 then --ground
			box.top    = nil
			box.bottom = nil
		elseif box.air == 1 then --air to air
			local ptr = {base = 0x03332E, ["garouo"] = 0, ["garoup"] = 0x82, ["garoubl"] = 0x82}
			ptr = ptr.base + (ptr[emu.romname()] or 0)
			box.right  =  math.min(box.front, rws(ptr)) * obj.side
			box.top    = -math.min(box.top, rws(ptr + 2))
			box.bottom =  math.min(box.bottom, rws(ptr + 2))
		elseif box.air == 3 then --air to ground
			box.top    = 0
			box.bottom = nil
		end
	end,
	breakpoints = {
		{base = 0x035204, ["garoup"] = -0x20C, ["garoubl"] = -0x20C, 
			func = function() set_vulnerable() end},
		{base = 0x035210, ["garoup"] = -0x20C, ["garoubl"] = -0x20C, 
			func = function() set_vulnerable(0xB3) end},
		{base = 0x035212, ["garoup"] = -0x20C, ["garoubl"] = -0x20C, --check vuln at all times *** setregister for m68000.pc is broken ***
			func = function() memory.setregister("m68000.pc", gr("pc") + 0x6) end},
		{base = 0x035212, ["garoup"] = -0x20C, ["garoubl"] = -0x20C, --check vuln at all times *** hackish workaround ***
			func = function() memory.setregister("m68000.a3", gr("a3") - 0xB7) end},
		{base = 0x035218, ["garoup"] = -0x20C, ["garoubl"] = -0x20C, --*** fix for hackish workaround ***
			func = function() memory.setregister("m68000.a3", gr("a3") + 0xB7) end},

		{base = 0x012A5A, ["garoup"] = -0x2FE, ["garoubl"] = -0x2FE, 
			func = function() insert_box(4, 2) end},
		{base = 0x012A88, ["garoup"] = -0x308, ["garoubl"] = -0x308, 
			func = function() insert_box(3, 1, true) end},
		{base = 0x012B56, ["garoup"] = -0x312, ["garoubl"] = -0x312, --p1 push
			func = function() insert_box(4, 2) end},
		{base = 0x012B84, ["garoup"] = -0x31C, ["garoubl"] = -0x31C, --p2 push
			func = function() insert_box(3, 1) end},

		{base = 0x02893C, ["garoup"] = 0x1EC, ["garoubl"] = 0x1EC, func = function()
			local ptr = gr("a1")
			insert_throw({
				front  = bit.band(gr("d2"), 0xFF),
				top    = rbs(ptr + 0x4),
				bottom = rbs(ptr + 0x5),
				air    = rb(ptr + 0x6),
		}) end},
	},
	clones = {["garouo"] = 0},
	remove_background = function()
		if rb(0x10743D) ~= 0x01 then
			return
		end
		local match = rb(0x10748A)
		if match == 0x38 then --HUD
			memory.writebyte(0x10748A, 0x33)
		end
		if match > 0 then --BG layers
			memory.writebyte(0x106FE8, 0x00)
		end
	end,
},
}


--------------------------------------------------------------------------------
-- post-process modules

offset = {
	player_space = 0x100,
	pos_x = 0x20,
	pos_z = 0x24,
	pos_y = 0x28,
}

for game in ipairs(profile) do
	local g = profile[game]
	g.number_players = g.number_players or 2
	g.obj_engine = (g.obj_ptr_list and "garou") or (g.obj_ptr_offset and "fatal fury 2") or "fatal fury 1"
	g.box = g.box or {
		top = 0x1, bottom = 0x2, left = 0x3, right = 0x4, space = 0x5, scale = 4, header = 0, read = rbs,
	}
	g.extra_frame = g.extra_frame or 0
	g.get_render_frame = g.extra_frame > 0 and function(b)
		return b[fc() - g.extra_frame] or {} --show only the previous frame in fatfury1
	end or function(b)
		return b[fc()] or b[fc()-1] or {} --paused or unpaused or n/a
	end
	g.box.get_id = g.box.get_id or function(address)
		return rb(address)
	end
	g.adjust_y = g.adjust_y or function(f, y)
		return y + f.screen_top
	end
	g.update_object = g.update_object or function(obj)
		obj.flip_x = rws(obj.base + 0x6A) < 0 and 1 or 0
		obj.flip_x = bit.bxor(obj.flip_x, bit.band(rb(obj.base + 0x71), 1))
		obj.flip_x = obj.flip_x > 0 and 1 or -1
		obj.hitbox_ptr = rd(obj.base + 0x7A)
		obj.num_boxes  = bit.rshift(obj.hitbox_ptr, 24)
		obj.scale      = rb(obj.base + 0x73) + 1
		obj.char_id    = rw(obj.base + 0x10)
	end
	g.clones = g.clones or {}
end

for _,box in pairs(boxes) do
	box.fill    = bit.lshift(box.color, 8) + (globals.no_alpha and 0x00 or box.fill)
	box.outline = bit.lshift(box.color, 8) + (globals.no_alpha and 0xFF or box.outline)
end
boxes["undefined"] = {}

emu.update_func = fba and emu.registerafter or emu.registerbefore
emu.registerfuncs = fba and memory.registerexec
if not emu.registerfuncs then
	print("Warning: This requires FBA-rr 0.0.7+.")
end
if globals.no_background then
	print("* Background removal on. *")
end


--------------------------------------------------------------------------------
-- functions referenced in the modules

gr = function(register)
	return memory.getregister("m68000." .. register)
end


any_true = function(condition)
	for n = 1, #condition do
		if condition[n] == true then return true end
	end
end


get_obj = function(register)
	local f = buffer[fc()-1] or buffer[fc()]
	for _, obj in ipairs(f or {}) do
		if bit.band(0xFFFFFF, gr("a" .. register)) == obj.base then
			return obj
		end
	end
end


set_vulnerable = function(offset)
	local f = buffer[fc()-1] or buffer[fc()]
	if not f then
		return
	end
	local obj_base = bit.band(0xFFFFFF, gr("a4"))
	if not offset or rb(obj_base + offset) == 0 then
		f.vulnerable[obj_base] = true
	end
end


insert_throw = function(box)
	local obj = get_obj(4)
	if not obj or game.process_throw(obj, box) == false then
		return
	end

	local f = buffer[fc()-1] or buffer[fc()]
	if not f then
		return
	end
	--[[
	box.top    = obj.pos_y - bit.arshift(box.top    * (obj.scale or 0x100), 8)
	box.bottom = obj.pos_y - bit.arshift(box.bottom * (obj.scale or 0x100), 8)
	box.left   = obj.pos_x + bit.arshift(box.left   * (obj.scale or 0x100), 8)
	box.right  = obj.pos_x + bit.arshift(box.right  * (obj.scale or 0x100), 8)
	]]
	box.left   = obj.pos_x + (box.left or 0)
	box.right  = obj.pos_x + (box.right or 0)
	box.top    = box.hard_top and (emu.screenheight() + f.screen_top - obj.pos_z - box.hard_top) --ryo's DM
		or box.top and obj.pos_y - box.top --air throw
	box.bottom = box.bottom and (obj.pos_y - box.bottom) or emu.screenheight() + f.screen_top - obj.pos_z

	box.type = box.type or "axis throw"
	box.id = 0xFF
	throw_buffer[obj.base] = box
end


insert_box = function(base_register, data_ptr, attack_only)
	local obj = get_obj(base_register)
	if not obj then
		return
	end
	local box = {address = gr("a" .. data_ptr)}
	box.id = game.box.get_id(box.address)
	box.type = box.id + 1 > #game.box_types and a or game.box_types[box.id + 1]
	if (attack_only and box.type ~= a) or (not attack_only and box.type == a) then
		return
	end
	box.type = box.type or x
	table.insert(box_buffer[obj.base], define_box(obj, box))
end


bit.btst = function(bit_number, value)
	return bit.band(bit.lshift(1, bit_number), value)
end

--------------------------------------------------------------------------------
-- prepare the hitboxes

local type_check = {
	["push"] = function(obj, box)
		obj.height = obj.height or box.bottom - box.top --used for height of ground throwbox
		if obj.unpushable then
			return true
		end
	end,

	["vulnerability"] = function(obj, box)
		if game.no_combos then
			obj.height = obj.height or box.bottom - box.top --used for height of ground throwbox
		end
		local f = buffer[fc()-1] or buffer[fc()]
		if f.same_plane and not obj.vulnerable then
			if not game.no_combos then
				return true
			end
			box.type = "push"
		end
	end,

	["guard"] = function(obj, box)
	end,

	["attack"] = function(obj, box)
		if obj.harmless then
			return true
		elseif obj.projectile then
			box.type = "proj. attack"
		end
	end,

	["throw"] = function(obj, box)
		if obj.harmless then
			return true
		end
	end,

	["undefined"] = function(obj, box)
		emu.message(string.format("%x, unk box id: %02x", obj.base, box.id)) --debug
	end,
}


local plane_scale = function(obj, box, offset)
	return bit.arshift(game.box.read(box.address + offset) * (obj.scale or 0x100), 8)
end


define_box = function(obj, box)
	box.top    = obj.pos_y - plane_scale(obj, box, game.box.top)    * game.box.scale
	box.bottom = obj.pos_y - plane_scale(obj, box, game.box.bottom) * game.box.scale
	box.left   = obj.pos_x - plane_scale(obj, box, game.box.left)   * game.box.scale * obj.flip_x
	box.right  = obj.pos_x - plane_scale(obj, box, game.box.right)  * game.box.scale * obj.flip_x

	if (box.top == box.bottom and box.left == box.right) or type_check[box.type](obj, box) then
		return nil
	end
	return box
end


local update_object = function(f, obj)
	obj.pos_x = rws(obj.base + offset.pos_x) - f.screen_left
	obj.pos_z = rws(obj.base + offset.pos_z)
	obj.pos_y = emu.screenheight() - rws(obj.base + offset.pos_y) - obj.pos_z
	obj.pos_y = game.adjust_y(f, obj.pos_y)
	obj.ptr   = rd(obj.base)
	game.update_object(obj)
	local f = buffer[fc()-1] or buffer[fc()]
	obj.vulnerable = f.vulnerable[obj.base]
	if game.bank_switching and not obj.projectile then --delay harmlessness check by a frame
		obj.harmless = f.harmless[obj.base]
		f.harmless[obj.base] = game.harmless(obj)
	else
		obj.harmless = game.harmless(obj)
	end

	local b = box_buffer[obj.base] or {} --fatfury3 ~ garou use insert_box() and box_buffer[]
	for n = #b, 1, -1 do --reverse the draw order to make bottom > top: p > v > a
		table.insert(obj, b[n])
	end
	box_buffer[obj.base] = {}

	if not game.bank_switching then --fatfury1 ~ rbff1 can get boxes without BPs
		for n = obj.num_boxes, 1, -1 do
			local box = {address = obj.hitbox_ptr + (n-1)*game.box.space + game.box.header}
			box.id = game.box.get_id(box.address)
			box.type = box.id + 1 > #game.box_types and "attack" or game.box_types[box.id + 1] or "undefined"
			--box.type = "undefined" --debug
			table.insert(obj, define_box(obj, box))
		end
	end

	local throw = throw_buffer[obj.base]
	if throw then
		throw.top = throw.top or obj.pos_y - (obj.height or globals.throwbox_height) --typical ground throw
		table.insert(obj, throw)
	end
	throw_buffer[obj.base] = nil
	
	return obj
end


local read_projectiles = {
	["fatal fury 1"] = function(f)
		local prev_address = game.player_base + offset.player_space * (game.number_players-1)
		while true do
			local obj = {base = 0x100100 + rw(prev_address + 0x4)}
			obj.projectile = true
			if obj.base == game.player_base or obj.base == 0x100100 then
				return
			end
			prev_address = obj.base
			local hitbox_ptr = bit.band(rd(obj.base + 0xB2), 0xFFFFFF)
			if hitbox_ptr > 0 and rw(hitbox_ptr + game.box.header) ~= 0x0006 then --back plane obstacle
				table.insert(f, update_object(f, obj))
			end
		end
	end,

	["fatal fury 2"] = function(f)
		for p = 1, game.number_players do
			local obj = {base = rd(game.player_base + offset.player_space * (p-1) + game.obj_ptr_offset)}
			obj.projectile = true
			local ptr = rd(obj.base)
			while obj.base > 0 do
				local inst = rw(ptr)
				if inst == 0x4E75 then --rts
					break
				elseif inst == 0x4EB9 or inst == 0x6100 then --jsr or bsr to some routine
					table.insert(f, update_object(f, obj))
					break
				end
				ptr = ptr + 2
			end
		end
	end,

	["garou"] = function(f)
		local offset = 0
		while true do
			local obj = {base = rd(game.obj_ptr_list + offset)}
			obj.projectile = true
			if obj.base == 0 or rw(rd(obj.base)) == 0x4E75 then --rts instruction
				return
			end
			for _, old_obj in ipairs(f) do
				if obj.base == old_obj.base then
					return
				end
			end
			table.insert(f, update_object(f, obj))
			offset = offset + 4
		end
	end,
}


local bios_test = function(address)
	local ram_value = rw(address)
	for _, test_value in ipairs({0x5555, 0xAAAA, bit.band(0xFFFF, address)}) do
		if ram_value == test_value then
			return true
		end
	end
end


local update_hitboxes = function()
	buffer[fc()] = {
		match_active = game and not bios_test(game.player_base) and rb(game.match_active) > 0,
		vulnerable = {}, harmless = {}
	}

	local f = buffer[fc()]
	if not f.match_active then
		return
	end

	f.screen_left = rws(game.stage_base + offset.pos_x) + (320 - emu.screenwidth()) / 2 --FBA removes the side margins for some games
	f.screen_top  = rws(game.stage_base + offset.pos_y)

	for p = 1, game.number_players do
		local player = {base = game.player_base + offset.player_space * (p-1)}
		table.insert(f, update_object(f, player))
	end
	read_projectiles[game.obj_engine](f)

	f.same_plane = game.number_players > 2 or f[1].pos_z == f[2].pos_z

	f.max_boxes = 0
	for _, obj in ipairs(f or {}) do
		f.max_boxes = math.max(f.max_boxes, #obj)
	end

	for frame in pairs(buffer) do
		if fc() > frame + game.extra_frame then
			buffer[frame] = nil
		end
	end

	if globals.no_background then
		game.remove_background()
		memory.writeword(0x401FFE, globals.bg_color) --broken in FBA?
	end
end


emu.update_func( function()
	globals.register_count = (globals.register_count or 0) + 1
	globals.last_frame = globals.last_frame or fc()
	if globals.register_count == 1 then
		update_hitboxes()
	end
	if globals.last_frame < fc() then
		globals.register_count = 0
	end
	globals.last_frame = fc()
end)


--------------------------------------------------------------------------------
-- draw the hitboxes

local draw_hitbox = function(hb, same_plane)
	if not hb or (hb.type == "push" and (not globals.draw_pushboxes or not same_plane)) then
		return
	end

	if globals.draw_mini_axis then
		hb.hval = (hb.right + hb.left)/2
		hb.vval = (hb.bottom + hb.top)/2
		gui.drawline(hb.hval, hb.vval-globals.mini_axis_size, hb.hval, hb.vval+globals.mini_axis_size, boxes[hb.type].outline)
		gui.drawline(hb.hval-globals.mini_axis_size, hb.vval, hb.hval+globals.mini_axis_size, hb.vval, boxes[hb.type].outline)
		--gui.text(hb.hval, hb.vval, string.format("%02X", hb.id)) --debug
	end

	gui.box(hb.left, hb.top, hb.right, hb.bottom, boxes[hb.type].fill, boxes[hb.type].outline)
end


local draw_axis = function(obj)
	gui.drawline(obj.pos_x, obj.pos_y-globals.axis_size, obj.pos_x, obj.pos_y+globals.axis_size, globals.axis_color)
	gui.drawline(obj.pos_x-globals.axis_size, obj.pos_y, obj.pos_x+globals.axis_size, obj.pos_y, globals.axis_color)
	--gui.text(obj.pos_x, obj.pos_y -0x10, string.format("%06X", obj.base)) --debug
	--gui.text(obj.pos_x, obj.pos_y -0x08, string.format("%06X", obj.ptr)) --debug
	--gui.text(obj.pos_x, obj.pos_y -0x08, string.format("%08X", obj.hitbox_ptr)) --debug
end


local render_hitboxes = function()
	gui.clearuncommitted()

	local f = game and game.get_render_frame(buffer) or {}
	if not f.match_active then
		return
	end

	if globals.blank_screen then
		gui.box(0, 0, emu.screenwidth(), emu.screenheight(), globals.blank_color)
	end

	for entry = 1, f.max_boxes or 0 do
		for _, obj in ipairs(f) do
			draw_hitbox(obj[entry], f.same_plane)
		end
	end

	if globals.draw_axis then
		for _, obj in ipairs(f) do
			draw_axis(obj)
		end
	end
end


gui.register(function()
	render_hitboxes()
end)


--------------------------------------------------------------------------------
-- hotkey functions

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


--------------------------------------------------------------------------------
-- initialize on game startup

local initialize_bps = function()
	for _, pc in ipairs(globals.breakpoints or {}) do
		memory.registerexec(pc, nil)
	end
	for _, addr in ipairs(globals.watchpoints or {}) do
		memory.registerwrite(addr, nil)
	end
	globals.breakpoints, globals.watchpoints = {}, {}
end


local initialize_buffers = function()
	buffer, box_buffer, throw_buffer = {}, {}, {}
end


local whatgame = function()
	print()
	game = nil
	initialize_bps()
	initialize_buffers()
	for _, module in ipairs(profile) do
		if emu.romname() == module.game or emu.parentname() == module.game then
			print("drawing hitboxes for " .. emu.gamename())
			game = module
			globals.pushbox_base = game.push and game.push.box_data + (game.push[emu.romname()] or 0)
			if not emu.registerfuncs then
				return
			end
			for _, bp in ipairs(game.breakpoints or {}) do
				if bp.no_background and not globals.no_background then
					break
				end
				local pc = bp.base + (bp[emu.romname()] or game.clones[emu.romname()] or 0)
				memory.registerexec(pc, bp.func)
				table.insert(globals.breakpoints, pc)
			end
			return
		end
	end
	print("unsupported game: " .. emu.gamename())
end


savestate.registerload(function()
	initialize_buffers()
end)


emu.registerstart(function()
	whatgame()
end)