-- Should be moved outside of add-ons once it'll be finished
local framedata_bar_selector = 0

framedata_bar_button = {
		text = "Framedata Bar",
		olcolour = "black",
		func =	function()
				framedata_bar_selector = framedata_bar_selector + 1
				if framedata_bar_selector > 1 then
					framedata_bar_selector = 0
				end
			end,
		autofunc = function(this)
				if framedata_bar_selector == 0 then
					this.text = "Framedata Bar : Off"
				elseif framedata_bar_selector == 1 then
					this.text = "Framedata Bar : On"
				end
			end,
	}
insertAddonButton(framedata_bar_button)
------------------------
-- Initialization
------------------------
-- Colors (0xRRGGBBTT)
local black = 0x000000FF
local white = 0xFFFFFFFF
local green = 0x00FF00FF
local red = 0xFF0000FF
local yellow = 0xFFFF00FF
local orange = 0xF28C28FF

local blank = 0x00000000
local transparency = "60"
-- Framedata Bar
local bar_length = 70
local hatching_nb = 4
local bar_x = {55, 55}
local bar_y = {165, 180}
--
local p1_bar = {}
local p2_bar = {}
local framedata_bar = {p1_bar, p2_bar}
--
local p1_hatching = {}
local p2_hatching = {}
local hatching = {p1_hatching, p2_hatching}
--
local startup = {"--","--"}
local total = {"--","--"}
local recovery = {"--","--"}
local infos = {"",""}

for i = 1, 2 do
	for k = 1, bar_length do
		-- Bar sections
		framedata_bar[i][k] = {
			x1 = bar_x[i], 
			y1 = bar_y[i], 
			x2 = bar_x[i] + 4,
			y2 = bar_y[i] + 10,
			fill = blank, 
			outline = black,
			transparent = false,
			stressed = false,
			frame_count = 0,
			display_frame_count = false,
			frame_id = 0
		}
		-- Hatching
		local new_hatching = {{x1 = 0, x2 = 0, y = 0, fill = blank}}
		table.insert(hatching[i], new_hatching)
		for h = 1, hatching_nb do
			hatching[i][k][h] = {
				x1 = bar_x[i] + 1,
				x2 = bar_x[i] + 3,
				y = bar_y[i] + 2*h, 
				fill = blank, 
			}
		end
		bar_x[i] = bar_x[i] + 4
	end
end
-- Frame count
local curr_frame = 1
local curr_bar = 1
local last_non_idle_frame = {0,0}
-----------------------
-- Color Functions
-----------------------
local function colorFrame(_player_obj, frame, fill_color, hatching_color)
	local transparency_value = string.sub(tostring(string.format("%x",fill_color)),-2)
	if color ~= blank and transparency_value ~= transparency then
		framedata_bar[_player_obj.id][frame].transparent = false
	end
	framedata_bar[_player_obj.id][frame].fill = fill_color
	if hatching_color then
		for h = 1, hatching_nb do
			hatching[_player_obj.id][frame][h].fill = hatching_color
		end
	end
end

local function highlightFrame(id, frame, bool) -- maybe we should modify the color of the highlighted frame. Make it brighter ?
	if bool then
		framedata_bar[id][frame].y1 = bar_y[id] - 1
		framedata_bar[id][frame].y2 = bar_y[id] + 11
	else
		framedata_bar[id][frame].y1 = bar_y[id]
		framedata_bar[id][frame].y2 = bar_y[id] + 10
	end
end

local function makeFramesTransparent() -- When we reach the end of the bar. Isolate RRGGBB//TT// and replace it by transparency
	for i = 1, 2 do
		for k = 1, #framedata_bar[i] do
			if framedata_bar[i][k].fill ~= blank then
				local new_fill = tostring(string.format("%x", framedata_bar[i][k].fill))
				while string.len(new_fill) < 8 do
					new_fill = "0"..new_fill
				end
				framedata_bar[i][k].fill = tonumber(string.sub(new_fill,1,6)..transparency, 16)
				for h = 1, hatching_nb do
					if hatching[i][k][h].fill ~= 0 then
						new_fill = tostring(string.format("%x", hatching[i][k][h].fill))
						while string.len(new_fill) < 8 do
							new_fill = "0"..new_fill
						end
						hatching[i][k][h].fill = tonumber(string.sub(new_fill,1,6)..transparency, 16)
						hatching[i][k][h].transparent = true
					end
				end
				framedata_bar[i][k].transparent = true
			end
		end
	end
end

local function stressActiveFrame(_curr_frame)
	for i = 1, 2 do
		for k = 1, _curr_frame do
			if k ~= bar_length then
				if framedata_bar[i][k+1].fill ~= blank and not framedata_bar[i][k+1].transparent then
					framedata_bar[i][k].stressed = false
				elseif framedata_bar[i][k].fill ~= blank and not framedata_bar[i][k].transparent then -- if the current frame is followed by a blank one
					framedata_bar[i][k].stressed = true
				end
			else
				if framedata_bar[i][k].fill ~= blank and not framedata_bar[i][k].transparent then -- if the current frame is the last of the bar and is a non-idle frame
					framedata_bar[i][k].stressed = true
				end
			end
			if framedata_bar[i][k].stressed then
				highlightFrame(i, k, true)
				last_non_idle_frame[i] = framedata_bar[i][k].frame_id
			else
				highlightFrame(i, k, false)
			end
		end
	end
end

local function getColor(_player_obj, frame)
	local has_vulnerability = false
	local has_attack = false
	
	if _player_obj.is_attacking or _player_obj.state == jumping then -- If the player is performing a move
		if _player_obj.prev.projectile_ready and not _player_obj.projectile_ready then
			colorFrame(_player_obj, frame, orange)
			return
		end
		for i = 1, #_player_obj.boxes do
			if _player_obj.boxes[i].type == "vulnerability" then
				has_vulnerability = true
			end
			if _player_obj.boxes[i].type == "attack" or (_player_obj.prev.throw_flag == 0x00 and _player_obj.throw_flag == 0x01) or _player_obj.in_hitfreeze then -- If we don't check for hitfreeze then the bar doesn't display a hit on cancels
				has_attack = true
			end
		end
		if has_vulnerability then
			if has_attack then
				colorFrame(_player_obj, frame, red)
				return
			else
				colorFrame(_player_obj, frame, green)
				return
			end
		else
			if has_attack then
				colorFrame(_player_obj, frame, white, red)
				return
			else
				colorFrame(_player_obj, frame, white)
				return
			end
		end
	elseif _player_obj.in_hitstun or _player_obj.is_knockdown or _player_obj.in_hitfreeze then -- if the player is being hit
		colorFrame(_player_obj, frame, yellow)
		return
	else
		local current_color = framedata_bar[_player_obj.id][frame].fill
		local current_hatching = hatching[_player_obj.id][frame][1].fill
		colorFrame(_player_obj, frame, current_color, current_hatching)
		return
	end
end
---------------------
-- Frame Count
---------------------
local counter_end = {0,0}

local function writeFrameCount(_curr_frame)
	local counter = {counter_end[1], counter_end[2]}
	for i = 1, 2 do
		framedata_bar[i][_curr_frame].display_frame_count = false
		for k = 1, _curr_frame do			
			if framedata_bar[i][k].fill ~= blank then
				counter[i] = counter[i] + 1
				framedata_bar[i][k].frame_count = counter[i]
				if k ~= bar_length then
					if framedata_bar[i][k].fill ~= framedata_bar[i][k+1].fill then
						counter[i] = 0
						if framedata_bar[i][k].frame_count > 3 then
							framedata_bar[i][k].display_frame_count = true
							if k ~= 1 then
								framedata_bar[i][k-1].display_frame_count = false
							else
								framedata_bar[i][bar_length].display_frame_count = false
							end
						end
					end
				else
					if framedata_bar[i][k].frame_count > 3 then
						framedata_bar[i][k].display_frame_count = true
						framedata_bar[i][k-1].display_frame_count = false
					end
					counter_end[i] = framedata_bar[i][k].frame_count
				end
			end
		end
	end
end

local is_startup = {false,false}
local startup_counter = {0,0}

local function getStartup(_player_obj)
	local id = _player_obj.id
	if not is_startup[id] then
		if _player_obj.hurting_move and not _player_obj.prev.hurting_move then
			startup_counter[id] = 0
			is_startup[id] = true
		 end
		 if _player_obj.prev.state ~= doing_special_move and _player_obj.state == doing_special_move then
			startup_counter[id] = 0
			is_startup[id] = true
		end
	end
	if is_startup[id] then
		if type(startup_counter[id]) == "number" then
			startup_counter[id] = countFrames(startup_counter[id])
		else
			startup_counter[id] = countFrames(0)
		end
		if _player_obj.prev.projectile_ready and not _player_obj.projectile_ready then
			is_startup[id] = false
		else
			for i = 1, #_player_obj.boxes do
				if _player_obj.boxes[i].type == "attack" then
					is_startup[id] = false
				end
			end
		end
	end
	if startup_counter[id] == 0 then
		startup_counter[id] = "--"
	end
	return startup_counter[id]
end

local function getTotal(_player_obj) -- I'm not really sure how it should work
	local id = _player_obj.id
end

local function getRecovery()
	if last_non_idle_frame[1] == 0 or last_non_idle_frame[2] == 0 then
		return
	end
	recovery[1] = last_non_idle_frame[2]-last_non_idle_frame[1]
	recovery[2] = last_non_idle_frame[1]-last_non_idle_frame[2]
	for i = 1, 2 do
		if recovery[i] > 0 then
			recovery[i] = "+"..recovery[i].."F"
		else
			recovery[i] = recovery[i].."F"
		end
	end
end

local function deleteFrameCount()
	for i =1, 2 do
		for k = 1, bar_length do
			framedata_bar[i][k].frame_count = 0
		end
	end
end
-------------------------
-- Manage Framedata Bar
-------------------------
local function prepareNewBar()
	curr_frame = 1
	curr_bar = curr_bar + 1
	for i = 1, 2 do
		if framedata_bar[i][bar_length].stressed then
			framedata_bar[i][bar_length].stressed = false
			highlightFrame(i, bar_length, false)
		end
	end
	makeFramesTransparent()
end

local function resetBar()
	deleteFrameCount()
	curr_bar = 1
	counter_end = {0,0}
	last_non_idle_frame = {0,0}
	startup_counter = {0,0}
	
	for i = 1, 2 do
		for k = 1, #framedata_bar[i] do
			framedata_bar[i][k].fill = blank
			framedata_bar[i][k].stressed = false
			framedata_bar[i][k].display_frame_count = false
			framedata_bar[i][k].frame_id = 0
			highlightFrame(i, k, false)
		end
		for k = 1, #hatching[i] do
			for h = 1, #hatching[i][k] do
				hatching[i][k][h].fill = blank
			end
		end
	end
end
----------------------------
-- Main
----------------------------
local function displayFrameData()
	local player = {gamestate.P1, gamestate.P2}
	for i = 1, 2 do
		if character_specific[readCharacterName(player[i])].infos.has_projectile then
			if not player[i].projectile_ready then
				return true
			end
		end
		if player[i].is_attacking or player[i].in_hitstun or player[i].is_knockdown or player[i].state == jumping then
			return true
		end
	end
	return false
end

local function defineFrame(_player_obj, frame)
	getColor(_player_obj, frame)
	if not framedata_bar[_player_obj.id][frame].transparent then
		framedata_bar[_player_obj.id][frame].frame_id = curr_frame + 70*(curr_bar-1)
	end
	stressActiveFrame(frame)
	writeFrameCount(frame)
end

local function frameDataBar()
	if framedata_bar_selector > 0 then
		if gamestate.is_in_match then
			-- Should be moved in ssf2xjr1 once finished
			updateGameObjectBoxes(gamestate.P1)
			updateGameObjectBoxes(gamestate.P2)
			-- Draw Framedata Bar
			for i = 1, 2 do
				for k = 1, bar_length do
					gui.box(framedata_bar[i][k].x1, framedata_bar[i][k].y1, framedata_bar[i][k].x2, framedata_bar[i][k].y2, framedata_bar[i][k].fill, framedata_bar[i][k].outline)
					for h = 1, hatching_nb do
						gui.line(hatching[i][k][h].x1, hatching[i][k][h].y, hatching[i][k][h].x2, hatching[i][k][h].y, hatching[i][k][h].fill)
					end
					if framedata_bar[i][k].display_frame_count then
						if i == 1 then
							gui.text(framedata_bar[i][k].x2-3,framedata_bar[i][k].y1-7.5,framedata_bar[i][k].frame_count)
						elseif i == 2 then
							gui.text(framedata_bar[i][k].x2-3,framedata_bar[i][k].y2+2,framedata_bar[i][k].frame_count)
						end
					end
				end
			end
			-- Get informations
			if not gamestate.P1.prev.in_hitfreeze and not gamestate.P2.prev.in_hitfreeze then -- We want to detect one frame of hitfreeze to know if a hit happened
				if displayFrameData() then
					if curr_frame == 0 then
						resetBar()
					end
					if gamestate.prev.frame_number ~= gamestate.frame_number then
						local increment = 0
						if was_frameskip then increment = 2 else increment = 1 end
						for i = 1, increment do
							curr_frame = curr_frame + 1
							if curr_frame > bar_length then
								prepareNewBar()
							end
							defineFrame(gamestate.P1, curr_frame)
							defineFrame(gamestate.P2, curr_frame)
						end
					end
					for i = 1, 2 do
						total[i] = "--"
						recovery[i] = "--"
					end
				else
					curr_frame = 0
					for i = 1, 2 do
						-- Total
						total[i] = last_non_idle_frame[i]
						if total[i] == 0 then
							total[i] = "--"
						else
							total[i] = total[i].."F"
						end
						-- Recovery
						getRecovery()
					end
				end
			end
		end
					-- Draw informations
			startup[1] = getStartup(gamestate.P1)
			startup[2] = getStartup(gamestate.P2)
			for i = 1, 2 do
				if startup[i] ~= "--" then
					startup[i] = startup[i].."F"
				end
			end
			
			gui.text(300,147,"Player 1")
			gui.text(300,200,"Player 2")
			
			infos = {"Startup "..startup[1].." / Total "..total[1].." / Recovery "..recovery[1], "Startup "..startup[2].." / Total "..total[2].." / Recovery "..recovery[2]}
			gui.text(60,147,infos[1])
			gui.text(60,200,infos[2])
		-- DEBUG
		local DEBUG = false
		if DEBUG then
			gui.text(100,100,"Last non idle frame P1 : "..last_non_idle_frame[1])
			gui.text(100,110,"Last non idle frame P2 : "..last_non_idle_frame[2])
		end
	end
end

table.insert(ST_functions, frameDataBar)
