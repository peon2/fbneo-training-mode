--========================================--
--       Sako Tick Training Script        --
--             by Born2SPD                --
--                V 1.0                   --
--========================================--

--How I detected the inputs:
--
--	The game saves in the memory the "current state" of
--p1's typhoon in the address 0xFF84E0. Each needed
-- direction/nput is perfomed the game adds 2 to this address.
--When this has a value of 8, it waits a punch input.
--
--I also used Double Typhoon orientation bit which works
--like this:
--	If first Direction is Left: 2, if Right: 0
--		If next direction is Up, +0, if is Down, +1
--	Else, if first Direction is Up: 4, if Down: 6
--		If next direction is Left, + 1, if it's Right: +0
--	Tiis way it knows not only the first direction the player
--	used to spin but also the direction (clockwise or
--	counterclockwise). This is why the script only works with
--	N.Hawk, I didnt needed to implement such detection.
--
--To detect punches I used the lua function joypad.get()
--
--Input Display and Hitbox Viewer were not coded by me,
--	I'm just borrowing them since you can't use more than
--	one Lua script at the same time.
--
--The rest of the code is coded by me though (Born2SPD).
--It's not the most beautiful code you'll see on your life,
--	I just wanted this shit to work.
--
--You may modify or use any part of the code as you wish,
--	just make sure you "remember" who coded it on the first place!
--
-- add permisive mode modification by @pof (June 2014)
-- script modified by @asunaro to fit in the fbneo training mode as an add-on (May 2022). 
-- Input Display and Hitbox Viewer are loaded in a different place now

local backup_comboenabled = hud.comboenabled

local sako_training_button = {
		text = "Sako Training",
		olcolour = "black",
		info = {
			"Script by Born2SPD - Print instructions on screen",
			"to help you perform a Sako Tick"
		},
		func =	function()
				sako_training = sako_training + 1
				if sako_training == 1 then
					permissive = true
					backup_comboenabled = hud.comboenabled
					hud.comboenabled = false
				elseif sako_training == 2 then
					permissive = false
					hud.comboenabled = false
				elseif sako_training > 2 then
					sako_training = 0
					hud.comboenabled = backup_comboenabled
				end
			end,
		autofunc = function(this)
				if sako_training == 0 then
					this.text = "Sako Training : Off"
				elseif sako_training == 1 then
					this.text = "Sako Training : On (Permissive)"
				elseif sako_training == 2 then
					this.text = "Sako Training : On (Non-Permissive)"
				end
			end,
	}
insertAddonButton(sako_training_button)


--## Constants ##--

local SAKO_MSG_FRAMELIMIT = 600
local STATE_FRAMELIMIT = 30

--## Vars ##--

sako_training = 0
permissive = true
local sako_analysis = true
local show_debug = false
local initial_dist = 0

local sako_msg1 = ""
local sako_msg2 = ""
local sako_msg3 = ""
local state = 0
local state_fcount = 0
local sako_msg_fcount = 0
local min_dist = 0
local target_msg = ""
local target_msg_align = 0

--These are the global vars that will hold the frames addreses for the Neutral Standing Jab, varies from N to O Hawk
local jab_startup_frame = 0x0
local jab_hitting_frame = 0x0
local jab_recovery_frame = 0x0
local jab_last_frame = 0x0
local jab_first_walking_frame = 0x0

--## FUNCTIONS ##--

--Checks which character the player 2 is set to and set ups some stuff directly related to it
local function p2_check()	

	if memory.readbyte(0xFF8DD2) == 0x01 then -- 01 = round is over, after the last round the p2_char memory region is always setted to 0, and would produce wrong message for a fraction of time, so this is just a little bugfix...
		return
	end

	if memory.readbyte(0xFF8C0B) == 0x01 then
		min_dist = 94
		target_msg = "Akuma. Minimal Distance: " .. min_dist .. " (Safe from Jab DP and throw range)"
		target_msg_align = 56
		return
	end
	
	if (gamestate.P2.character == Ryu) then
		min_dist = 94
		target_msg = "Ryu. Minimal Distance: " .. min_dist .. " (Safe from Jab DP and throw range)"
		target_msg_align = 56
		
	elseif (gamestate.P2.character == Honda) then
		if memory.readbyte(0xFF8C04) == 0x00 then -- 0x00 = New, 0x01 = Old
			min_dist = 105
			target_msg = "E.Honda. Minimal Distance: " .. min_dist .. " (Safe from Oicho throw)"
			target_msg_align = 72
		else
			min_dist = 100
			target_msg = "Old E.Honda. Minimal Distance: " .. min_dist .. " (Safe from his throw range)"
			target_msg_align = 56
		end

	elseif (gamestate.P2.character == Blanka) then
		min_dist = 100
		target_msg = "Blanka. Minimal Distance: " .. min_dist .. " (Safe from Bite Range. Also beats his Beast Rolls)"
		target_msg_align = 16
		
	elseif (gamestate.P2.character == Guile) then
		min_dist = 84 --110 is safe against FK first active frames and still viable
		target_msg = "Guile. Minimal Distance: " .. min_dist .. " (Safe from his throw range only)"
		target_msg_align = 56
				
	elseif (gamestate.P2.character == Ken) then
		min_dist = 97
		target_msg = "Ken. Minimal Distance: " .. min_dist .. " (Safe from Jab DP and throw range)"
		target_msg_align = 56
		
	elseif (gamestate.P2.character == Chun) then
		min_dist = 84 --Safe from her RH Upkick, but you'll only hit her if shes crouching.(84 = safe from throw, 96 = max range to hit her standing)
		target_msg = "Chun Li. Minimal Distance: " .. min_dist .. " (Safe from her throw range. Also beats her UpKicks)"
		target_msg_align = 16
		
	elseif (gamestate.P2.character == Zangief) then
		min_dist = 119 --At 147, its the ONLY range (yeah only 1 pixel) where you can hit a crouching gief while being out of his SPD range
		target_msg = "Zangief. Minimal Distance: " .. min_dist .. " (Safe from Suplex range only. SPD outranges T.Hawk's Jab)"
		target_msg_align = 1
		
	elseif (gamestate.P2.character == Dhalsim) then
		min_dist = 100
		target_msg = "Dhalsim. Minimal Distance: ".. min_dist .. " (Safe from his throw range)"
		target_msg_align = 56
		
	elseif (gamestate.P2.character == Dictator) then
		min_dist = 88
		target_msg = "Dictator. Minimal Distance: " .. min_dist .. " (Safe from his throw range)"
		target_msg_align = 56
		
	elseif (gamestate.P2.character == Sagat) then
		min_dist = 101
		target_msg = "Sagat. Minimal Distance: " .. min_dist .. " (Safe from Tiger Uppercut 1st active part and throw range)"
		target_msg_align = 2
		
	elseif (gamestate.P2.character == Boxer) then
		min_dist = 87
		target_msg = "Boxer. Minimal Distance: " .. min_dist .. " (Safe from his throw range)"
		target_msg_align = 64
		
	elseif (gamestate.P2.character == Claw) then
		min_dist = 96 --107 = safe from 1st rh flip kick hit, 84= safe from his throw range
		target_msg = "Claw. Minimal Distance: " .. min_dist .. " (Safe from Scarlet Terror's first frames and throw range)"
		target_msg_align = 8
		
	elseif (gamestate.P2.character == Cammy) then
		min_dist = 78 --78 = safe from her throw range, 100 is somewhat safe against her thrust kicks
		target_msg = "Cammy. Minimal Distance: " .. min_dist .. " (Safe from her throw only. Unsafe against her Thrust Kicks)"
		target_msg_align = 2		
		
	elseif (gamestate.P2.character == Hawk) then
		min_dist = 84
		target_msg = "T.Hawk. Minimal Distance: " .. min_dist .. " (Safe from his normal throw only. Typhoon outranges Jab)"
		target_msg_align = 8
				
	elseif (gamestate.P2.character == Fei) then
		min_dist = 76
		target_msg = "Fei Long. Minimal Distance: " .. min_dist .. " (Safe from throw only. Short Flame Kick outranges Jab)"
		target_msg_align = 8
		
	elseif (gamestate.P2.character == Deejay) then
		min_dist = 84
		target_msg = "Dee Jay. Minimal Distance: " .. min_dist .. " (Safe from his throw only. UpKicks outrange T.Hawk's Jab)"
		target_msg_align = 2
	end	
	return
end

--Returns true if too close, false if not, character dependent
local function too_close()	
	if permissive and (getDistanceBetweenPlayers() < min_dist-5) then
		return true
	elseif not permissive and (getDistanceBetweenPlayers() < min_dist) then
		return true
	else
		return false
	end
end

--Function that checks if P1 is using T.Hawk and sets some stuff
--that depends directly on the character version (Old/New)

local function thawk_check()
	if gamestate.P1.character ~= Hawk then -- 0x0D = T.Hawk
		sako_msg1 = "Pick T.Hawk, Dumbass."
		sako_msg2 = ""
		sako_msg3 = ""
		return false
	elseif not gamestate.P1.is_old then -- 0x00 = New, 0x01 = Old
		jab_startup_frame = 0x00177b4a		--3 frames of duration
		jab_hitting_frame = 0x00177b62		--4 frames of duration
		jab_recovery_frame = 0x00177b92		--3 frames of duration
		jab_last_frame = 0x00177b92			--1 frame  of duration
		jab_first_walking_frame = 0x00179686
		return true
	else				--Frame data is the same for O.Hawk
		sako_msg1 = "Only New Hawk is supported by this script"
		sako_msg2 = "However the technique remains the same for"
		sako_msg3 = "both New and Old versions"
		return false
		--jab_startup_frame = 0x0020772E
		--jab_hitting_frame = 0x00207746
		--jab_recovery_frame = 0x0020775E
		--jab_last_frame = 0x00207776
		--jab_first_walking_frame = 0x00209002
		--return true
	end
end

--Updates the Error Message
local function sako_update_msg(er_code)
	sako_msg2 = ""
	sako_msg3 = ""	
	sako_msg_fcount = 1
	if er_code == 0 then --resets
		sako_msg1 = "Waiting for a Sako tick attempt from the propper range. "
		sako_msg2 = "Do the Jab and right after it hold the other punches, "
		sako_msg3 = "wait a bit, and then start the 270 from up to forward."
		sako_msg_fcount = 0
	elseif er_code == 1 then
		sako_msg1 = "You're too close to the opponent, you must tick "
		sako_msg2 = "him from far enough."
		sako_msg_fcount = SAKO_MSG_FRAMELIMIT-1
	elseif er_code == 2 then
		sako_msg1 = "You wont hit him from that distance..."
		sako_msg_fcount = SAKO_MSG_FRAMELIMIT-90
	elseif er_code == 3 then
		sako_msg1 = "You must complete the motion before the Jab animation "
		sako_msg2 = "ends. T.Hawk is crouching for a moment: you're doing "
		sako_msg3 = "the motion too slow or you're starting it too late."
	elseif er_code == 31 then
		sako_msg1 = "You began the 270 motion too late. Hawk would have   "
		sako_msg2 = "jumped if the jab had whiffed."
	elseif er_code == 41 then --Thawk on left side
		sako_msg1 = "Input must be ^ < v >, you messed it somewhere. "
		sako_msg2 = "Check it on the input display."
	elseif er_code == 42 then --Thawk on the right side
		sako_msg1 = "Input must be ^ > v <, you messed it somewhere. "
		sako_msg2 = "Check it in the input display."
	elseif er_code == 51 then --Thawk on left side
		sako_msg1 = "The first input was detected as > instead of ^. "
		sako_msg1 = "The first input was detected as > instead of ^. "
		sako_msg2 = "It can still work but it will limit the grabbable "
		sako_msg3 = "walking frames so try to delay the Typhoon a bit."
	elseif er_code == 52 then --Thawk on the right side
		sako_msg1 = "The first input was detected as < instead of ^. "
		sako_msg2 = "It can still work but it will limit the grabbable "
		sako_msg3 = "walking frames so try to delay the Typhoon a bit."
	elseif er_code == 6 then
		sako_msg1 = "Why are you not holding PPP? Press and hold Strong "
		sako_msg2 = "and Fierce right after you pressed Jab for the tick. "
		sako_msg3 = "You'll only release them for the Typhoon."
	elseif er_code == 7 then
		sako_msg1 = "You must be walking after the Jab's last frame, and "
		sako_msg2 = "only stop when the opponent gets out of hitstun."
	elseif er_code == 81 then
		sako_msg1 = "Two punch buttons were released too soon. "
		sako_msg2 = "The opponent is still in hitstun, this also means that "
		sako_msg3 = "is invulnerable to throws."
	elseif er_code == 82 then
		sako_msg1 = "You're releasing punches too soon AND in the wrong order. "
		sako_msg2 = "Must be Fierce first, Jab last."
	elseif er_code == 9 then --does this ever happen?
		sako_msg1 = "The Typhoon input has vanished from the motion buffer. "
		sako_msg2 = "Are you doing the 270 motion too fast?"
	elseif er_code == 10 then
		sako_msg1 = "You're taking too long to release the Punch buttons, "
		sako_msg2 = "the typhoon input already vanished from the motion buffer."
	elseif er_code == 11 then
		sako_msg1 = "T.Hawk is too far for you to release the buttons. Delay the "
		sako_msg2 = "button releases a little."
	elseif er_code == 12 then
		sako_msg1 = "Good, you did it well. The only mistake is that you're "
		sako_msg2 = "taking too long to block after releasing the Punch buttons."
		if (initial_dist < min_dist) then
			sako_msg3 = "Now try again from a bit farther."
		end
	else
		sako_msg1 = "Well done."
		if (initial_dist < min_dist) then
			sako_msg2 = "Now try again from a bit farther."
		end
		sako_msg_fcount = SAKO_MSG_FRAMELIMIT-60
	end
	return
end

--Resets the state and its frame counter
local function reset_state()
	state = 0
	state_fcount = 0
	return
end

--Resets the error message and its frame counter
local function sako_reset_msg()
	sako_update_msg(0)
	return
end

--Increments state
local function inc_state()
	state = state + 1
	state_fcount = 1
	return
end

local function p2_is_on_hitfreeze()
	if gamestate.P2.hitfreeze_counter ~= 0x00 then --hitfreeze counter
		return true
	else return false
	end
end

local function p2_is_on_hitstun()
	if memory.readbyte(0xFF8851) >= 0x0E then --not a counter
		return true
	else return false
	end
end

local function p2_was_thrown()
	if memory.readbyte(0xFF88b1) == 0xFF then
		return true
	else return false
	end
end

--Checks if the animation frame passed as argument is the current one
local function p1_curr_anim_frame_is(anim_frame)
	if memory.readdword(0xFF8468) == anim_frame then
		return true
	else
		return false
	end
end

--If P1 is attacking with a Ground normal
local function p1_is_attacking()
	if memory.readbyte(0xFF8451) == 0xA then
		return true
	else return false
	end
end

local function p1_is_on_left_side()
	if memory.readbyte(0xFF860c) == 0x1 then
		return true
	else return false
	end
end

local function p1_is_on_air()
	if memory.readbyte(0xFF85cf) == 0x1 then
		return true
	else return false
	end
end

--If P1 is currently on the typhoon animation
local function p1_typhoon()
	local curr_anim = memory.readdword(0xFF8468)
	--                  (N.Hawk Typhoon frames)                                      (O.Hawk Typhoon frames)
	if ((curr_anim >= 0x0017922e) and (curr_anim <= 0x0017939e)) or ((curr_anim >= 0x00208e12) and (curr_anim <= 0x00208f6a)) then
		return true
	else return false
	end
end

local function p1_is_holding_forward_direction()
	local keytable = joypad.get()
	if p1_is_on_left_side() then
		if keytable["P1 Right"] then
			return true
		else
			return false
		end
	else
		if keytable["P1 Left"] then
			return true
		else
			return false
		end
	end
end

local function p1_is_blocking()
	local keytable = joypad.get()
	if p1_is_on_left_side() then
		if ((keytable["P1 Left"]) and (keytable["P1 Down"])) then
			return true
		else
			return false
		end
	else
		if ((keytable["P1 Right"]) and (keytable["P1 Down"])) then
			return true
		else
			return false
		end
	end
end

--Returns how much frames are left for the the current animation
--when this goes to 0 the next animation is activated by the game itself
local function p1_frames_left_of_curr_anim()
	return memory.readbyte(0xFF8467)
end

--Returns the Typhoon Input bit value
local function p1_typhoon_input_code()
	--if gamestate.P1.is_old then 
		--return memory.readbyte(0xFF84E8)
	--else
		return memory.readbyte(0xFF84E0)
	--end
end

--Returns the Double Typhoon Input Direction bit value (Thank god this exists, made everything easier...)
local function p1_super_input_direction_code()
	return memory.readbyte(0xFF84ED)
end

local function p1_punches_are_being_held()
	local punchbit = 0
	local keytable = joypad.get()
	if keytable["P1 Weak Punch"] then
		punchbit = punchbit + 1
	end
	if keytable["P1 Medium Punch"] then
		punchbit = punchbit + 2
	end
	if keytable["P1 Strong Punch"] then
		punchbit = punchbit + 4
	end
	return punchbit
end

local p1_doing_jab = false
local jab_framecount = 0
local jump_error = false

-- Main function
local function sako_logic()

	if not(thawk_check()) then
		return
	end
	p2_check()
	
	if not p1_doing_jab then
		if gamestate.P1.prev.animation_id == jab_startup_frame then
			p1_doing_jab = true
			jab_framecount = 1
		elseif gamestate.P1.animation_id == jab_startup_frame then
			p1_doing_jab = true
		end
	else
		jab_framecount = countFrames(jab_framecount)
		if not p1_is_attacking() then
			p1_doing_jab = false
			jab_framecount = 0
			jump_error = false
		end
	end

--##### STATE 0: Waiting for Jab #####--
	if state == 0 then
		if ((too_close()) and not(p1_typhoon())) then
			if (p1_curr_anim_frame_is(jab_hitting_frame)) then
				initial_dist=getDistanceBetweenPlayers()
			end
			reset_state()
			sako_update_msg(1)	--too close, no point in training sakos from this range
			return
		elseif p1_curr_anim_frame_is(jab_hitting_frame) and not jump_error then
			if p2_is_on_hitfreeze() then
				initial_dist=getDistanceBetweenPlayers()
				inc_state()
				sako_reset_msg()	--jab hit the opponent from far enough, sends to next state
				return
			end
		elseif (p1_curr_anim_frame_is(jab_recovery_frame)) and not(p2_is_on_hitstun()) then
			initial_dist=getDistanceBetweenPlayers()
			reset_state()
			sako_update_msg(2) --jab didnt hit the opponent, he is too far for it
		end
		return
	end

--###### STATE 1: Jab OK, waiting for other punches to be held as well as the next inputs ######--
	if state == 1 then
		if not(p1_is_attacking()) then --T.Hawk Jab animation is complete, if you didnt passed to the next state yet, something is wrong
			reset_state()
			sako_update_msg(3)
			return
		elseif jab_framecount >= 9 and isPressed(gamestate.P1, "up") and not permissive then
			reset_state()
			sako_update_msg(31)
			jump_error = true
			return
		elseif ((p1_is_on_left_side()) and (p1_typhoon_input_code() == 8)) then -- If the player already did the Typhoon
			if p1_super_input_direction_code() == 5 or (p1_super_input_direction_code() == 0 and permissive) then --if first direction was up and the second was left
				if p1_punches_are_being_held() == 7 then --go to next state		
					inc_state()
					sako_reset_msg()
					return
				else					-- not holding PPP
					reset_state()
					sako_update_msg(6)
					return
				end
			elseif p1_super_input_direction_code() == 0 and not permissive then --the direction thawk used to walk was registered in the tphoon input, wrong
				reset_state()
				sako_update_msg(51)
				return
			else			
				reset_state()
				sako_update_msg(41)	--input is wrong
				return
			end
		elseif (not(p1_is_on_left_side()) and (p1_typhoon_input_code() == 8)) then -- If the player already did the Typhoon
			if p1_super_input_direction_code() == 4 or (p1_super_input_direction_code() == 2 and permissive) then --if first direction was up and the second was right
				if p1_punches_are_being_held() == 7 then --go to next state		
					inc_state()
					sako_reset_msg()
					return
				else					-- not holding PPP
					reset_state()
					sako_update_msg(6)
					return
				end
			elseif p1_super_input_direction_code() == 2 and not permissive then --the direction thawk used to walk was registered in the tphoon input, wrong
				reset_state()
				sako_update_msg(52)
				return
			else
				reset_state()
				sako_update_msg(42)	--input is wrong
				return
			end
		end
		return --goes here if he didnt started the 270 yet
	end

--###### STATE 2: p2 is on hit stun. p1 must continue walking forward and continue holding PPP, to only release them when P2 is throwable ######--
	if state == 2 then
		if not(p1_is_holding_forward_direction()) then --not walking
			reset_state()
			sako_update_msg(7)
			return
		elseif p1_punches_are_being_held() < 3 and not permissive then --releasing PPP too soon, fierce is ignored for leniency
			reset_state()
			sako_update_msg(81)
			return
		elseif (p1_punches_are_being_held() == 6) or (p1_punches_are_being_held() == 4) then -- releasing jab first, totally wrong
			reset_state()
			sako_update_msg(82)
			return
		elseif p1_typhoon_input_code() == 0 then --the typhoon input has vanished from the input buffer
			reset_state()
			sako_update_msg(9)
			return		
		end
		if p2_is_on_hitstun() then
			return --p1 is walking and holding punches, but p2 still on hitstun, rechecks everything till he gets out of it
		else
			inc_state()
			sako_reset_msg()
			return
		end
	end
	
--###### STATE 3: p1 is holding PPP and walking forward. p2 is now throwable, time to release punches and go to defense ######--
	if state == 3 then
		if p1_typhoon() then
			if not(p1_is_on_air()) then
				if p1_is_blocking() then
					inc_state()
					sako_reset_msg()
					return
				else
					return --he is not blocking yet, will check if he will in the next frame
				end
			else
				reset_state()
				sako_update_msg(12)
				return	
			end

		--need to find another way to detect punch releases done too soon.
			
		elseif (p1_punches_are_being_held() == 0) then
--			reset_state()
			sako_update_msg(11) --buttons released too soon
			return		
		elseif (p1_typhoon_input_code() == 0) and (p1_punches_are_being_held() > 0) then
			reset_state()
			sako_update_msg(10) --took too long to release the punch buttons, the typhoon input vanished from the motion buffer
			return	
		end	
	end

--###### STATE 4: Just tells the player that he did it well ######--
	if state == 4 then
		sako_update_msg(-1)
	end
	return
end

local function sako_draw_messages()

	if memory.readword(0xFF847F) == 0 then --if not in match
		return
	end
	
	if not sako_analysis then
		return
	end
	
	--Updates the messages
	if sako_msg_fcount >= SAKO_MSG_FRAMELIMIT then
		sako_reset_msg()
	elseif sako_msg_fcount > 0 then
		sako_msg_fcount = sako_msg_fcount + 1
	end
	
	if state_fcount >= STATE_FRAMELIMIT then
		reset_state()
	elseif state_fcount > 0 then
		state_fcount = state_fcount + 1
	end

	--Draw Stuff
	if show_debug then		
		gui.text(112,10,"State: " .. state .. "  Input: " .. p1_typhoon_input_code() .. "  Direction: " .. p1_super_input_direction_code() .. " Dist: " .. initial_dist)
	end

	--Sako tips
	gui.text(92,56,sako_msg1)
	gui.text(92,64,sako_msg2)
	gui.text(92,72,sako_msg3)

	--Distance stuff
	gui.text(160,208,"Distance: " .. getDistanceBetweenPlayers())
	gui.text(target_msg_align,216,"Target: " .. target_msg)	

	return
end

local function sako()
	if sako_training > 0 then
		sako_logic()
		sako_draw_messages()
	end
end
table.insert(ST_functions, sako)