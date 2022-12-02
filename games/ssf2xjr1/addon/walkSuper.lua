-- walking super trainig addon for ssf2x
-- Nov 2022 - @pof
walksuper_button = {
		text = "Walk Super Training",
		olcolour = "black",
		func =	function()
				walksuper_selector = walksuper_selector + 1
				if walksuper_selector > 1 then
					walksuper_selector = 0
				end
				reset_msg()
			end,
		autofunc = function(this)
				if walksuper_selector == 0 then
					this.text = "Walk Super Training : Off"
				elseif walksuper_selector == 1 then
					this.text = "Walk Super Training : On"
				end
			end,
	}
insertAddonButton(walksuper_button)

walksuper_selector = 0

local forward1_frames = 0
local forward2_frames = 0
local backward_frames = 0

local walk_forward1_frames = 0
local walk_forward2_frames = 0
local walk_backward_frames = 0

local prev_super_state = 0
local super_state = 0
local tip_displayed = false

local function loadCharValues(character)
	if gamestate.P1.is_old then
		return false
	end
	if character == Boxer then
		super_state = rb(0xFF8522)
		forward1_max_frames = 15
		forward2_max_frames = 11
		return true
	elseif character == Blanka then
		super_state = rb(0xFF850F)
		forward1_max_frames = 8
		forward2_max_frames = 15
		return true
	elseif character == Deejay then
		super_state = rb(0xFF84FD)
		forward1_max_frames = 8
		forward2_max_frames = 13
		return true
	elseif character == Dictator then
		super_state = rb(0xFF8513)
		forward1_max_frames = 8
		forward2_max_frames = 13
		return true
	elseif character == Guile then
		super_state = rb(0xFF84E2)
		forward1_max_frames = 8
		forward2_max_frames = 8
		return true
	elseif character == Claw then
		super_state = rb(0xFF84E7)
		forward1_max_frames = 16
		forward2_max_frames = 16
		return true
	end
	return false
end

local function walkSuperVertical()
	--msg1 = "Super state: "..super_state.." | last_special: "..gamestate.P1.reversal_id
	if ((super_state == 0 or super_state == 2) and not tip_displayed ) then msg1 = "Super state: "..super_state end
	if (super_state == 4 and gamestate.P1.state ~= doing_special_move) then
		tip_displayed = false
		forward1_frames = 0
		forward2_frames = 0
		backward_frames = 0

		walk_forward1_frames = 0
		walk_forward2_frames = 0
		walk_backward_frames = 0
		msg1 = "Super state: "..super_state.." -> SUPER CHARGE READY!"
		msg2 = ""
	end
	if (super_state == 6 or super_state == 8) then
		msg1 = "Super state: "..super_state.." -> PART 1 (HOLD FORWARD)"
		forward1_frames = countFrames(forward1_frames)
		if (isPressed(gamestate.P1, "forward") and not isPressed(gamestate.P1, "down") and not isPressed(gamestate.P1, "up")) then
			walk_forward1_frames = countFrames(walk_forward1_frames)
		end
		if (forward1_frames > 4 and walk_forward1_frames==0) then msg2="HOLD FORWARD!" end
	end
	if ((super_state == 0 or super_state == 2) and (prev_super_state == 8 or prev_super_state == 6)) then
		if (walk_forward1_frames > forward1_max_frames*0.75) then
			msg2="YOU WALKED TOO MUCH FRAMES ON PART1: "..forward1_frames.."f"
		else
			msg2="TOO MUCH TIME ON PART1 ("..forward1_frames.."f) BUT NOT ENOUGH FRAMES WALKING: "..walk_forward1_frames.."f"
		end
	end
	if ((super_state == 0 or super_state == 2) and prev_super_state == 10) then
		if (walk_forward2_frames >= forward2_max_frames) then
			msg2="YOU WALKED TOO MUCH FRAMES ON PART2: "..walk_forward2_frames.."f"
		else
			msg2="YOU SPENT TOO MUCH TIME ON PART2: "..backward_frames.."f"
		end

	end
	if (super_state == 10) then
		if (backward_frames == 0) then
			msg1 = "Super state: "..super_state.." -> PART 2 (BACK)"
		else
			msg1 = "Super state: "..super_state.." -> PART 3 (HOLD FORWARD)"
		end
		backward_frames = countFrames(backward_frames)
		if (isPressed(gamestate.P1, "back")) then
			walk_backward_frames = countFrames(walk_backward_frames)
		end
		if (walk_backward_frames > 3) then msg2="GO FORWARD FASTER!" end
		if (isPressed(gamestate.P1, "forward") and not isPressed(gamestate.P1, "down") and not isPressed(gamestate.P1, "up")) then
			walk_forward2_frames = countFrames(walk_forward2_frames)
		end
	end
	if (super_state == 12) then
		msg1 = "Super state: "..super_state.." -> PART 4 (UP+KICK)"
		forward2_frames = countFrames(forward2_frames)
	end
	if (gamestate.P1.state == doing_special_move and ((gamestate.P1.character == Guile and gamestate.P1.reversal_id == 4) or (gamestate.P1.character == Claw and gamestate.P1.reversal_id == 10)) and super_state < 8) then
		tip_displayed = true
		local part1ok = false
		local part2ok = false
		local part3ok = false
		if (walk_forward1_frames >= forward1_max_frames*0.75) then part1ok = true end
		if (walk_backward_frames < 5) then part2ok = true end
		if (walk_forward2_frames >= forward2_max_frames*0.75) then part3ok = true end

		if (part1ok and part2ok and part3ok) then
			msg1 = "WELL DONE!!! \\o/"
		else
			msg1 = "TIP: "
			if (not part1ok or not part3ok) then
				msg1 = msg1.."Walk more frames on"
				if (not part1ok) then msg1 = msg1.." PART1" end
				if (not part1ok and not part3ok) then msg1 = msg1.." and" end
				if (not part3ok) then msg1 = msg1.." PART3" end
				msg1 = msg1..". "
			end
			if (not part2ok) then msg1 = msg1.."Go forward faster on PART2." end
		end
		msg2="You walked forward "..walk_forward1_frames + walk_forward2_frames.." out of "..forward1_max_frames + forward2_max_frames.." frames (and "..walk_backward_frames.."f back)"
	else
		if ((super_state == 0 or super_state == 2) and prev_super_state == 12) then
			msg2="SUPER NOT ACTIVATED ON TIME ON PART4: "..forward2_frames.."f"
		end
	end
	msg3 = "WALK1 ("..forward1_max_frames.."f): "..walk_forward1_frames.."f | BACK (1f): "..walk_backward_frames.."f | WALK2 ("..( forward2_max_frames - walk_backward_frames ).."f): "..walk_forward2_frames.."f"
end

local function walkSuperHorizontal()
	if ((super_state == 0 or super_state == 2) and not tip_displayed ) then msg1 = "Super state: "..super_state end
	if (super_state == 4 and gamestate.P1.state ~= doing_special_move) then
		tip_displayed = false
		forward1_frames = 0
		forward2_frames = 0
		backward_frames = 0

		walk_forward1_frames = 0
		walk_forward2_frames = 0
		walk_backward_frames = 0
		msg1 = "Super state: "..super_state.." -> SUPER CHARGE READY!"
		msg2 = ""
	end
	if (super_state == 6 or super_state == 8) then
		msg1 = "Super state: "..super_state.." -> PART 1 (HOLD FORWARD)"
		forward1_frames = countFrames(forward1_frames)
		if (isPressed(gamestate.P1, "forward") and not isPressed(gamestate.P1, "down") and not isPressed(gamestate.P1, "up")) then
			walk_forward1_frames = countFrames(walk_forward1_frames)
		end
		if (forward1_frames > 4 and walk_forward1_frames==0) then msg2="HOLD FORWARD!" end
	end
	if ((super_state == 0 or super_state == 2) and (prev_super_state == 8 or prev_super_state == 6)) then
		if (walk_forward1_frames > forward1_max_frames*0.75) then
			msg2="YOU WALKED TOO MUCH FRAMES ON PART1: "..forward1_frames.."f"
		else
			msg2="TOO MUCH TIME ON PART1 ("..forward1_frames.."f) BUT NOT ENOUGH FRAMES WALKING: "..walk_forward1_frames.."f"
		end
	end
	if ((super_state == 0 or super_state == 2) and prev_super_state == 10) then
		msg2="YOU SPENT TOO MUCH TIME BACKWARDS ON PART2: "..backward_frames.."f"
	end
	if (super_state == 10) then
		msg1 = "Super state: "..super_state.." -> PART 2 (BACK)"
		backward_frames = countFrames(backward_frames)
		if (isPressed(gamestate.P1, "back") and not isPressed(gamestate.P1, "down") and not isPressed(gamestate.P1, "up")) then
			walk_backward_frames = countFrames(walk_backward_frames)
		end
		if (backward_frames > 3) then msg2="GO FORWARD FASTER!" end
	end
	if (super_state == 12) then
		msg1 = "Super state: "..super_state.." -> PART 3 (HOLD FORWARD)"
		forward2_frames = countFrames(forward2_frames)
		if (isPressed(gamestate.P1, "forward") and not isPressed(gamestate.P1, "down") and not isPressed(gamestate.P1, "up")) then
			walk_forward2_frames = countFrames(walk_forward2_frames)
		end
	end
	if (gamestate.P1.state == doing_special_move and gamestate.P1.reversal_id == 8 and super_state < 8) then
		tip_displayed = true
		local part1ok = false
		local part2ok = false
		local part3ok = false
		if (walk_forward1_frames >= forward1_max_frames*0.75) then part1ok = true end
		if (backward_frames < 5) then part2ok = true end
		if (walk_forward2_frames >= forward2_max_frames*0.75) then part3ok = true end

		if (part1ok and part2ok and part3ok) then
			msg1 = "WELL DONE!!! \\o/"
		else
			msg1 = "TIP: "
			if (not part1ok or not part3ok) then
				msg1 = msg1.."Walk more frames on"
				if (not part1ok) then msg1 = msg1.." PART1" end
				if (not part1ok and not part3ok) then msg1 = msg1.." and" end
				if (not part3ok) then msg1 = msg1.." PART3" end
				msg1 = msg1..". "
			end
			if (not part2ok) then msg1 = msg1.."Go forward faster on PART2." end
		end
		msg2="You walked forward "..walk_forward1_frames + walk_forward2_frames.." out of ".. forward1_max_frames + forward2_max_frames .." frames (and "..backward_frames.."f back)"
	else
		if ((super_state == 0 or super_state == 2) and prev_super_state == 12) then
			if (walk_forward2_frames >= forward2_max_frames) then
				msg2="YOU WALKED TOO MUCH FRAMES ON PART3: "..forward2_frames.."f"
			else
				msg2="SUPER NOT ACTIVATED ON TIME ON PART3: "..forward2_frames.."f"
			end
		end
	end
	msg3 = "WALK1 ("..forward1_max_frames.."f): "..walk_forward1_frames.."f | BACK (1f): "..backward_frames.."f | WALK2 ("..forward2_max_frames.."f): "..walk_forward2_frames.."f"
end

local function walkSuper()
	if not gamestate.is_in_match then
		return
	end
	if walksuper_selector > 0 and not interactivegui.enabled then
		prev_super_state = super_state
		if not loadCharValues(gamestate.P1.character) then
			msg1 = "Your character is not supported for Walking Super Trainning:"
			msg2 = "Pick New Boxer, New Blanka, New DeeJay or New Dictator."
			return
		end
		if (gamestate.P1.character == Guile or gamestate.P1.character == Claw) then
			walkSuperVertical()
		else
			walkSuperHorizontal()
		end
	end
end

table.insert(ST_functions, walkSuper)
