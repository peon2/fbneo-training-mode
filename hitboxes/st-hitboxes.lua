----------------------------------------------------------------------------------------------------
-- Hitboxes
-- Original Authors for this Script: Dammit, MZ, Felineki
-- Homepage: http://code.google.com/p/mame-rr/
----------------------------------------------------------------------------------------------------

local boxes = {
	      ["vulnerability"] = {color = 0x0000FF, fill = 0x00, outline = 0xFF},
	             ["attack"] = {color = 0xFF0000, fill = 0x00, outline = 0xFF},
	["proj. vulnerability"] = {color = 0x00FFFF, fill = 0x00, outline = 0xFF},
	       ["proj. attack"] = {color = 0xFF6600, fill = 0x00, outline = 0xFF},
	               ["push"] = {color = 0x00FF00, fill = 0x00, outline = 0xFF},
	               ["weak"] = {color = 0xFF00FF, fill = 0x00, outline = 0xFF},
	              ["throw"] = {color = 0xFFFF00, fill = 0x00, outline = 0xFF},
	          ["throwable"] = {color = 0xF0F0F0, fill = 0x00, outline = 0xFF},
	      ["air throwable"] = {color = 0x202020, fill = 0x00, outline = 0xFF},
}

local AXIS_COLOR           = 0x7F7F7FFF
local BLANK_COLOR          = 0xFFFFFFFF
local AXIS_SIZE            = 4
local MINI_AXIS_SIZE       = 2
local BLANK_SCREEN         = false
local DRAW_AXIS            = true
local DRAW_MINI_AXIS       = false
local DRAW_PUSHBOXES       = true
local DRAW_THROWABLE_BOXES = true
local DRAW_DELAY           = 0
local NUMBER_OF_PLAYERS    = 2
local MAX_GAME_PROJECTILES = 8
local MAX_BONUS_OBJECTS    = 16
local draw_hitboxes = 1

local profile = {
	{
		games = {"ssf2t", "ssf2xj", "ssf2xjr1", "ssf2tnl"},
		status_type = "normal",
		address = {
			player           = 0xFF844E,
			projectile       = 0xFF97A2,
			left_screen_edge = 0xFF8ED4,
			stage            = 0xFFE18B,
		},
		player_space       = 0x400,
		box_parameter_size = 1,
		box_list = {
			{addr_table = 0x8, id_ptr = 0xD, id_space = 0x04, type = "push"},
			{addr_table = 0x0, id_ptr = 0x8, id_space = 0x04, type = "vulnerability"},
			{addr_table = 0x2, id_ptr = 0x9, id_space = 0x04, type = "vulnerability"},
			{addr_table = 0x4, id_ptr = 0xA, id_space = 0x04, type = "vulnerability"},
			{addr_table = 0x6, id_ptr = 0xC, id_space = 0x10, type = "attack"},
		},
		throw_box_list = {
			{param_offset = 0x6C, type = "throwable"},
			{param_offset = 0x64, type = "throw"},
		}
	},
}

for _,game in ipairs(profile) do
	game.box_number = #game.box_list + #game.throw_box_list
end

for _,box in pairs(boxes) do
	box.fill    = box.color * 0x100 + box.fill
	box.outline = box.color * 0x100 + box.outline
end

local game, effective_delay

local globals = {
	game_phase       = 0,
	left_screen_edge = 0,
	top_screen_edge  = 0,
}
local player       = {}
local projectiles  = {}
local frame_buffer = {}
if fba then
	DRAW_DELAY = DRAW_DELAY + 1
end


--------------------------------------------------------------------------------
-- prepare the hitboxes

local function adjust_delay(address)
	if not address or not mame then
		return DRAW_DELAY
	end
	local stage = memory.readbyte(address)
	for _, val in ipairs({
		0xA, --Boxer
		0xC, --Cammy
		0xD, --T.Hawk
		0xF, --Dee Jay
	}) do
		if stage == val then
			return DRAW_DELAY + 1 --these stages have an extra frame of lag
		end
	end
	return DRAW_DELAY
end



local get_status = {
	["normal"] = function()
		if bit.band(memory.readword(0xFF8008), 0x08) > 0 then
			return true
		end
	end,

	["hsf2"] = function()
		if memory.readword(0xFF8004) == 0x08 then
			return true
		end
	end,
}

local function update_globals()
	globals.left_screen_edge = memory.readword(game.address.left_screen_edge)
	globals.top_screen_edge  = memory.readword(game.address.left_screen_edge + 0x4)
	globals.game_playing     = get_status[game.status_type]()
end


local function get_x(x)
	return x - globals.left_screen_edge
end


local function get_y(y)
	return emu.screenheight() - (y - 15) + globals.top_screen_edge
end


local get_box_parameters = {
	[1] = function(box)
		box.hval   = memory.readbytesigned(box.address + 0)
		box.hval2  = memory.readbyte(box.address + 5)
		if box.hval2 >= 0x80 and box.type == "attack" then
			box.hval = -box.hval2
		end
		box.vval   = memory.readbytesigned(box.address + 1)
		box.hrad   = memory.readbyte(box.address + 2)
		box.vrad   = memory.readbyte(box.address + 3)
	end,

	[2] = function(box)
		box.hval   = memory.readwordsigned(box.address + 0)
		box.vval   = memory.readwordsigned(box.address + 2)
		box.hrad   = memory.readword(box.address + 4)
		box.vrad   = memory.readword(box.address + 6)
	end,
}


local process_box_type = {
	["vulnerability"] = function(obj, box)
	end,

	["attack"] = function(obj, box)
		if obj.projectile then
			box.type = "proj. attack"
		elseif memory.readbyte(obj.base + 0x03) == 0 then
			return false
		end
	end,

	["push"] = function(obj, box)
		if obj.projectile then
			box.type = "proj. vulnerability"
		elseif not DRAW_PUSHBOXES then
			return false
		end
	end,

	["weak"] = function(obj, box)
		if (game.char_mode and memory.readbyte(obj.base + game.char_mode) ~= 0x4)
			or memory.readbyte(obj.animation_ptr + 0x15) ~= 2 then
			return false
		end
	end,

	["throw"] = function(obj, box)
		get_box_parameters[2](box)
		if box.hval == 0 and box.vval == 0 and box.hrad == 0 and box.vrad == 0 then
			return false
		end

		for offset = 0,6,2 do
			memory.writeword(box.address + offset, 0) --bad
		end

		box.hval   = obj.pos_x + box.hval * (obj.facing_dir == 1 and -1 or 1)
		box.vval   = obj.pos_y - box.vval
		box.left   = box.hval - box.hrad
		box.right  = box.hval + box.hrad
		box.top    = box.vval - box.vrad
		box.bottom = box.vval + box.vrad
	end,

	["throwable"] = function(obj, box)
		if not DRAW_THROWABLE_BOXES or
			(memory.readbyte(obj.animation_ptr + 0x8) == 0 and
			memory.readbyte(obj.animation_ptr + 0x9) == 0 and
			memory.readbyte(obj.animation_ptr + 0xA) == 0) or
			memory.readbyte(obj.base + 0x3) == 0x0E or
			memory.readbyte(obj.base + 0x3) == 0x14 or
			memory.readbyte(obj.base + 0x143) > 0 or
			memory.readbyte(obj.base + 0x1BF) > 0 or
			memory.readbyte(obj.base + 0x1A1) > 0 then
			return false
		elseif memory.readbyte(obj.base + 0x181) > 0 then
			box.type = "air throwable"
		end

		box.hrad = memory.readword(box.address + 0)
		box.vrad = memory.readword(box.address + 2)
		box.hval = obj.pos_x
		box.vval = obj.pos_y - box.vrad/2
		box.left   = box.hval - box.hrad
		box.right  = box.hval + box.hrad
		box.top    = obj.pos_y - box.vrad
		box.bottom = obj.pos_y
	end,
}


local function define_box(obj, entry)
	local box = {
		type = game.box_list[entry].type,
		id = memory.readbyte(obj.animation_ptr + game.box_list[entry].id_ptr),
	}

	if box.id == 0 or process_box_type[box.type](obj, box) == false then
		return nil
	end

	local addr_table = obj.hitbox_ptr + memory.readwordsigned(obj.hitbox_ptr + game.box_list[entry].addr_table)
	box.address = addr_table + box.id * game.box_list[entry].id_space
	get_box_parameters[game.box_parameter_size](box)

	box.hval   = obj.pos_x + box.hval * (obj.facing_dir == 1 and -1 or 1)
	box.vval   = obj.pos_y - box.vval
	box.left   = box.hval - box.hrad
	box.right  = box.hval + box.hrad
	box.top    = box.vval - box.vrad
	box.bottom = box.vval + box.vrad

	return box
end

local function returnBoxType(obj, entry)
	local box = {
		type = game.box_list[entry].type,
		id = memory.readbyte(obj.animation_ptr + game.box_list[entry].id_ptr),
	}

	if box.id == 0 or process_box_type[box.type](obj, box) == false then
		return nil
	end
	return box
end

local function define_throw_box(obj, entry)
	local box = {
		type = game.throw_box_list[entry].type,
		address = obj.base + game.throw_box_list[entry].param_offset,
	}

	if process_box_type[box.type](obj, box) == false then
		return nil
	end

	return box
end


local function update_game_object(obj)
	obj.facing_dir    = memory.readbyte(obj.base + 0x12)
	obj.pos_x         = get_x(memory.readwordsigned(obj.base + 0x06))
	obj.pos_y         = get_y(memory.readwordsigned(obj.base + 0x0A))
	obj.animation_ptr = memory.readdword(obj.base + 0x1A)
	obj.hitbox_ptr    = memory.readdword(obj.base + 0x34)

	for entry in ipairs(game.box_list) do
		table.insert(obj, define_box(obj, entry))
	end
end

function updateGameObjectBoxes(_player_obj)
	_player_obj.animation_ptr = memory.readdword(_player_obj.base + 0x1A)
	_player_obj.boxes = {}
	for i = 1, #_player_obj.boxes do
		player_obj.boxes[i] = nil
	end
	for entry in ipairs(game.box_list) do
		table.insert(_player_obj.boxes, returnBoxType(_player_obj, entry))
	end
end

local function read_projectiles()
	local current_projectiles = {}

	for i = 1, MAX_GAME_PROJECTILES do
		local obj = {base = game.address.projectile + (i-1) * 0xC0}
		if memory.readword(obj.base) == 0x0101 then
			obj.projectile = true
			update_game_object(obj)
			table.insert(current_projectiles, obj)
		end
	end

	for i = 1, MAX_BONUS_OBJECTS do
		local obj = {base = game.address.projectile + (MAX_GAME_PROJECTILES + i-1) * 0xC0}
		if bit.band(0xff00, memory.readword(obj.base)) == 0x0100 then
			update_game_object(obj)
			table.insert(current_projectiles, obj)
		end
	end

	return current_projectiles
end


local function update_sf2_hitboxes()
	if not game then
		return
	end
	effective_delay = adjust_delay(game.address.stage)
	update_globals()

	for f = 1, effective_delay do
		frame_buffer[f].status = frame_buffer[f+1].status
		for p = 1, NUMBER_OF_PLAYERS do
			frame_buffer[f][player][p] = copytable(frame_buffer[f+1][player][p])
		end
		frame_buffer[f][projectiles] = copytable(frame_buffer[f+1][projectiles])
	end

	frame_buffer[effective_delay+1].status = globals.game_playing
	for p = 1, NUMBER_OF_PLAYERS do
		player[p] = {base = game.address.player + (p-1) * game.player_space}
		if memory.readword(player[p].base) > 0x0100 then
			update_game_object(player[p])
		end
		frame_buffer[effective_delay+1][player][p] = player[p]

		local prev_frame = frame_buffer[effective_delay][player][p]
		if prev_frame and prev_frame.pos_x then
			for entry in ipairs(game.throw_box_list) do
				table.insert(prev_frame, define_throw_box(prev_frame, entry))
			end
		end

	end
	frame_buffer[effective_delay+1][projectiles] = read_projectiles()
end


--------------------------------------------------------------------------------
-- draw the hitboxes

local function draw_hitbox(obj, entry)
	local hb = obj[entry]

	if DRAW_MINI_AXIS then
		gui.drawline(hb.hval, hb.vval-MINI_AXIS_SIZE, hb.hval, hb.vval+MINI_AXIS_SIZE, boxes[hb.type].outline)
		gui.drawline(hb.hval-MINI_AXIS_SIZE, hb.vval, hb.hval+MINI_AXIS_SIZE, hb.vval, boxes[hb.type].outline)
	end

	gui.box(hb.left, hb.top, hb.right, hb.bottom, boxes[hb.type].fill, boxes[hb.type].outline)
end


local function draw_axis(obj)
	if not obj or not obj.pos_x then
		return
	end
	
	gui.drawline(obj.pos_x, obj.pos_y-AXIS_SIZE, obj.pos_x, obj.pos_y+AXIS_SIZE, AXIS_COLOR)
	gui.drawline(obj.pos_x-AXIS_SIZE, obj.pos_y, obj.pos_x+AXIS_SIZE, obj.pos_y, AXIS_COLOR)
end


local function render_sf2_hitboxes()
	if not game or not frame_buffer[1].status or not draw_hitboxes then
		return
	end

	if BLANK_SCREEN then
		gui.box(0, 0, emu.screenwidth(), emu.screenheight(), BLANK_COLOR)
	end

	for entry = 1, game.box_number do
		for i in ipairs(frame_buffer[1][projectiles]) do
			local obj = frame_buffer[1][projectiles][i]
			if obj[entry] then
				draw_hitbox(obj, entry)
			end
		end

		for p = 1, NUMBER_OF_PLAYERS do
			local obj = frame_buffer[1][player][p]
			if obj and obj[entry] then
				draw_hitbox(obj, entry)
			end
		end
	end

	if DRAW_AXIS then
		for p = 1, NUMBER_OF_PLAYERS do
			draw_axis(frame_buffer[1][player][p])
		end
		for i in ipairs(frame_buffer[1][projectiles]) do
			draw_axis(frame_buffer[1][projectiles][i])
		end
	end
end

--------------------------------------------------------------------------------
-- initialize on game startup

local function whatgame()
	game = nil
	for n, module in ipairs(profile) do
		for m, shortname in ipairs(module.games) do
			if emu.romname() == shortname or emu.parentname() == shortname then
				--print("drawing " .. shortname .. " hitboxes")
				game = module
				for p = 1, NUMBER_OF_PLAYERS do
					player[p] = {}
				end
				for f = 1, DRAW_DELAY + 2 do
					frame_buffer[f] = {}
					frame_buffer[f][player] = {}
					frame_buffer[f][projectiles] = {}
				end
				return
			end
		end
	end
	print("not prepared for " .. emu.romname() .. " hitboxes")
end


--emu.registerstart( function()
--	whatgame()
--end)

----------------------------------------------------------------------------------------------------
--Main loop
----------------------------------------------------------------------------------------------------
--while true do
--	-- Draw these functions on the same frame data is read
--	gui.register(function()
--		--Hitbox rendering
--		update_sf2_hitboxes()
--		render_sf2_hitboxes()
--
--	end)
--	--Pause the script until the next frame
--	emu.frameadvance()
--end


----------------------------------------------------------------------------------------------------
--End Hit box script by: Dammit, MZ, Felineki
--Homepage: http://code.google.com/p/mame-rr/
----------------------------------------------------------------------------------------------------


whatgame()

function hitboxesReg()
	if hitboxes.enabled then
		render_sf2_hitboxes()
	end
end

function hitboxesRegAfter()
	update_sf2_hitboxes()
end
