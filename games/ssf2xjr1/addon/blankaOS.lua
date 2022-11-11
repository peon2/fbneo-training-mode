local blanka_os_selector = 0
local begin = false

blanka_os_button = {
		text = "Blanka - OS Training",
		olcolour = "black",
		func =	function()
				blanka_os_selector = blanka_os_selector + 1
				if blanka_os_selector > 1 then
					blanka_os_selector = 0
				end
				reset_msg()
			end,
		autofunc = function(this)
				if blanka_os_selector == 0 then
					this.text = "Blanka - Grab/Dash Training : Off"
					msg_tick_throw = true
				elseif blanka_os_selector == 1 then
					this.text = "Blanka - Grab/Dash Training : On"
					begin = true
					msg_tick_throw = false
				end
			end,
	}
insertAddonButton(blanka_os_button)

local function throwAttemptHP()
	local p1 = gamestate.P1
	local p2 = gamestate.P2
	local p2character = readCharacterName(gamestate.P2)
	local can_throw = false
	
	if p1.flip_input then
		blanka_throw_range = (p1.pos_x + character_specific["blanka"].hitboxes.throw[1][2]) - (p2.pos_x - character_specific[p2character].hitboxes.throwable)
	else
		blanka_throw_range = (p2.pos_x + character_specific[p2character].hitboxes.throwable) - (p1.pos_x - character_specific["blanka"].hitboxes.throw[1][2])
	end
	if blanka_throw_range >= 0 then 
		can_throw = true
	end
		
	return can_throw and not isPressed(p1, "down") and isPressed(p1, "HP") and (isPressed(p1, "forward") or isPressed(p1, "back")) and not wasPressed(p1, "HP") and not (isPressed(p1, "LP") and not wasPressed(p1, "LP")) and not (isPressed(p1, "MP") and not wasPressed(p1, "MP")) and (p1.prev.state == standing or p1.prev.state == doing_normal_move)
end

local function isPressedKKK()
	return isPressed(gamestate.P1, "LK") and isPressed(gamestate.P1, "MK") and isPressed(gamestate.P1, "HK")
end

local function wasPressedKKK()
	return wasPressed(gamestate.P1, "LK") and wasPressed(gamestate.P1, "MK") and wasPressed(gamestate.P1, "HK")
end

local function blankaBackDashAttempt() -- should be improved. Sometimes the back dash is not detected in negative edge
	return (isPressed(gamestate.P1, "back") and not isPressed(gamestate.P1, "up")) and ((isPressedKKK() and not wasPressed(gamestate.P1, "kick")) or (not isPressed(gamestate.P1, "kick") and wasPressedKKK()))
end

local tick_step = 0
local tick_timer = 0
local reset_tick = false

local function blankaTickThrowAttempt()
	if reset_tick then
		tick_step = 0
		tick_timer = 0
		reset_tick = false
	end
	if tick_step == 0 and gamestate.P2.in_hitstun and gamestate.P1.throw_flag == 0x00 then
		tick_step = 1
		tick_timer = 0
	elseif tick_step == 1 then
		if gamestate.P2.state ~= being_hit then
			tick_timer = countFrames(tick_timer)
		end
		if tick_timer > 20 or gamestate.P2.in_hitfreeze then
			reset_tick = true
		end
		if throwAttemptHP() then -- If we detect a throw
			return true
		end
	end
	return false
end

local state = 0
local dash_counter = 0
local reversal_name = ""
local blanka_os_msg_fcount = -1

local function getTiming(character)
	if character == Ken then -- safe fromp DP LP/MP
		reversal_name = "DP (Light/Medium)."
		return 3
	elseif character == Sagat then -- safe from all DP
		reversal_name = "DP (All versions)."
		return 4
	elseif character == Ryu or character == Cammy then -- safe from all DP
		reversal_name = "DP (All versions)."
		return 5
	elseif character == DJ then -- safe from all Upkicks
		reversal_name = "Upkick (All versions)."
		return 5
	elseif character == Chun then
		reversal_name = "Upkick (Light/Medium)."
		return 5
	elseif character == Claw or character == Guile then -- safe from all flashkicks
		reversal_name = "Flashkick (All versions)."
		return 6
	elseif character == Fei then -- safe from all DP
		reversal_name = "DP (All versions)."
		return 7
	elseif character == Boxer then -- safe from all HB
		reversal_name = "Headbutt (All versions)."
		return 12
	end
	-- Reversal startup
	-- Boxer : 11 / 13 / 15
	-- Cammy : 4
	-- Chun : 6 / 4 / 2
	-- DJ : 6 / 5 / 4
	-- Guile : 5
	-- Claw : 5
	-- Sagat : 3
	-- Ryu : 4
	-- Fei : 6
	-- Ken : 2 / 2 / 0
end

local function update_msg_blanka_os(code)
	if code == -1 then
		msg1 = "Please select Blanka to run this script."
		msg2 = "Valid opponents are : Boxer, Cammy, Chun, Claw, DJ, Fei Long,"
		msg3 = "Guile, Ken, Ryu, Sagat."
	elseif code == -10 then
		msg1 = "Please select a valid opponent."
		msg2 = "Valid opponents are : Boxer, Cammy, Chun, Claw, DJ, Fei Long,"
		msg3 = "Guile, Ken, Ryu, Sagat."
	elseif code == 0 then
		msg1 = "Waiting for a Grab/Dash OS attempt."
		msg2 = "Tick your opponent then hold LP and MP down. Grab with HP"
		msg3 = "and slide your fingers down to KKK in order to back dash."
	elseif code == 1 then
		msg1 = "You must tick your opponent before going for the throw."
		msg2 = ""
		msg3 = ""
		blanka_os_msg_fcount = MSG_FRAMELIMIT-240
	elseif code == 2 then
		msg1 = "You did not try to grab your opponent or did not input it"
		msg2 = "correctly."
		msg3 = ""
		blanka_os_msg_fcount = MSG_FRAMELIMIT-240
	elseif code == 3 then
		msg1 = "You're not holding PPP. Hold LP and MP down before going"
		msg2 = "for the throw."
		msg3 = ""
		blanka_os_msg_fcount = MSG_FRAMELIMIT-240
	elseif code == 4 then
		msg1 = "You tried to throw while the opponent was still in"
		msg2 = "blockstun/hitstun."
		msg3 = ""
		blanka_os_msg_fcount = MSG_FRAMELIMIT-240
	elseif code == 5 then
		msg1 = "You threw too late ("..tick_timer.." frames). You wouldn't have been"
		msg2 = "able to back dash because "..printName(gamestate.P2).."'s reversal comes out "
		msg3 = "in "..getTiming(gamestate.P2.character)-1 .." frames."
		blanka_os_msg_fcount = MSG_FRAMELIMIT-360
	elseif code == 6 then
		msg1 = "You did not try to throw quickly enough."
		msg2 = "You threw "..tick_timer.." frames after your tick, leaving you only"
		msg3 = getTiming(gamestate.P2.character)-tick_timer.." frame to back dash."
		blanka_os_msg_fcount = MSG_FRAMELIMIT-360
	elseif code == 10 then
		msg1 = "You did not try to back dash or did not input it correctly."
		msg2 = "Hold PPP and then slide your fingers down to KKK."
		msg3 = ""
		blanka_os_msg_fcount = MSG_FRAMELIMIT-240
	elseif code == 11 then
		msg1 = "Back dash was not possible because you did not slide your fingers"
		msg2 = "quickly enough. The throw attempt couldn't have been kara cancelled."
		msg3 = ""
		blanka_os_msg_fcount = MSG_FRAMELIMIT-240
	elseif code == 12 then
		msg1 = "You did not dash quickly enough. Against "..printName(gamestate.P2).." you should"
		msg2 = "do a throw attempt and kara cancel it within "..getTiming(gamestate.P2.character).." frames."
		msg3 = "You threw "..tick_timer_save.." frames after your tick and dashed "..dash_counter.." frames after -> "..tick_timer_save+dash_counter
		blanka_os_msg_fcount = MSG_FRAMELIMIT-360
	elseif code == 99 then
		msg1 = "Success !"
		msg2 = "You threw "..tick_timer_save.." frames after your tick and dashed "..dash_counter.." frames after -> "..tick_timer_save+dash_counter
		msg3 = "You would have been safe from "..printName(gamestate.P2).."'s "..reversal_name
		blanka_os_msg_fcount = MSG_FRAMELIMIT-300
	end
end

local function blankaOS()
	if blanka_os_selector == 0 then
		return 
	end
	if gamestate.is_in_match then
		if gamestate.P1.character ~= Blanka then 
			update_msg_blanka_os(-1)
		elseif gamestate.P2.character == Blanka or gamestate.P2.character == Dhalsim or gamestate.P2.character == Dictator or gamestate.P2.character == Hawk or gamestate.P2.character == Honda or gamestate.P2.character == Zangief then
			update_msg_blanka_os(-10)
		else
			if begin then
					update_msg_blanka_os(0)
					blanka_os_msg_fcount = -1
					begin = false
			end
			if state == 0 then
				if blanka_os_msg_fcount >= MSG_FRAMELIMIT then
					update_msg_blanka_os(0)
					blanka_os_msg_fcount = -1
				elseif blanka_os_msg_fcount > 0 then
					blanka_os_msg_fcount = countFrames(blanka_os_msg_fcount)
				end
				blankaTickThrowAttempt()
				if tick_timer > 0 and blankaBackDashAttempt() and gamestate.P1.throw_flag == 0x00 then
					state = 0
					tick_timer = 0
					update_msg_blanka_os(2) -- Did not try to grab
					return
				end
				if throwAttemptHP(gamestate.P1) then
					if not blankaTickThrowAttempt() then
						state = 0
						update_msg_blanka_os(1) -- Did not tick
					else
						if not isPressed(gamestate.P1, "LP") or not isPressed(gamestate.P1, "MP") then
							state = 0
							update_msg_blanka_os(3) -- Punches were not held
						else
							if tick_timer == 0 then
								state = 0
								update_msg_blanka_os(4) -- threw too quickly
							elseif tick_timer >= getTiming(gamestate.P2.character) then
								state = 0
								update_msg_blanka_os(5) -- threw far too late
							elseif tick_timer > getTiming(gamestate.P2.character)-2 then
								state = 0
								update_msg_blanka_os(6) -- threw too late
							else
								state = 1 -- Success
								dash_counter = 0
								dash_timing_goal = getTiming(gamestate.P2.character)-tick_timer
								tick_timer_save = tick_timer
							end
						end
					end
				end
			elseif state == 1 then
				dash_counter = countFrames(dash_counter)
				if dash_counter > 14 then -- far too late
					state = 0
					update_msg_blanka_os(10)
				end
				if blankaBackDashAttempt() then
					state = 0
					if dash_counter > 7 then
						update_msg_blanka_os(11)
					elseif dash_counter > dash_timing_goal then
						update_msg_blanka_os(12)
					else
						update_msg_blanka_os(99)
					end
				end
			end
		end
	end
end
table.insert(ST_functions, blankaOS)