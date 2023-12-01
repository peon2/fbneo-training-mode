-- boxer starnding down-charge glitch trainig addon for ssf2x
-- Nov 2022 - @pof
boxerglitch_button = {
		text = "Boxer Glitch Training",
		info = { "Train boxer glitch to have down charge while doing standing LP", },
		olcolour = "black",
		func =	function()
				boxerglitch_selector = boxerglitch_selector + 1
				if boxerglitch_selector > 1 then
					boxerglitch_selector = 0
				end
				reset_msg()
			end,
		autofunc = function(this)
				if boxerglitch_selector == 0 then
					this.text = "Boxer Glitch Training : Off"
				elseif boxerglitch_selector == 1 then
					this.text = "Boxer Glitch Training : On"
				end
			end,
	}
insertAddonButton(boxerglitch_button)

boxerglitch_selector = 0

local glitch_part = 0   -- 0: starting, 1: between st.LP and cr.LK 2: between cr.LK and cr.LP, 3: mashing cr.LP
local frames_between_sLP_and_crLK = 0
local frames_between_crLK_and_crLP = 0
local frames_executing_glitch = 0
local idlecount = 0

local direction_fix = false

local function resetGlitch()
	glitch_part = 0
	frames_between_sLP_and_crLK = 0
	frames_between_crLK_and_crLP = 0
	frames_executing_glitch = 0
	direction_fix = false
	idlecount = 0
end

local function boxerGlitch()
	if not gamestate.is_in_match then
		return
	end
	if boxerglitch_selector > 0 and not interactivegui.enabled then
		if not gamestate.P1.character == Boxer then
			msg1 = "Pick Boxer"
			return
		end
		if (glitch_part == 0) then
			msg2 = "Step 1: Press st.LP"
			direction_fix = false
			idlecount = countFrames(idlecount)
			if (idlecount > 300) then msg1 = "" end
		end
		if (glitch_part == 0 and isPressed(gamestate.P1, "LP") and not isPressed(gamestate.P1, "down") and not isPressed(gamestate.P1, "up") and gamestate.P1.state == 10) then
			msg1=""
			msg2="Step 2: Crouch"
			frames_between_sLP_and_crLK = 0
			glitch_part = 1
		end
		if (glitch_part == 1) then
			frames_between_sLP_and_crLK = countFrames(frames_between_sLP_and_crLK)
			if (isPressed(gamestate.P1, "down")) then
				if (frames_between_sLP_and_crLK > 12) then
					msg2 = "Step 3: Chain cancel cr.LK into cr.LP"
					direction_fix = true
				else
					msg2 = "Step 2: KEEP CROUCHING"
				end
			end
			-- TODO: we can probably make this condition better (eg. you can do a rush or a super between st.LP and cr.LK, but this doesn't allow it)
			if ((gamestate.P1.state == 4 and isPressed(gamestate.P1, "LP")) or isPressed(gamestate.P1, "MK") or isPressed(gamestate.P1, "HK") or isPressed(gamestate.P1, "MP") or isPressed(gamestate.P1, "HP") or (isPressed(gamestate.P1, "LK") and not isPressed(gamestate.P1, "down")) or (direction_fix and isPressed(gamestate.P1, "LP") and isPressed(gamestate.P1, "direction"))) then
				msg1="FAIL! You didn't do cr.LK"
				resetGlitch()
				return
			end
			if (isPressed(gamestate.P1, "LK") and isPressed(gamestate.P1, "down")) then
				if (frames_between_sLP_and_crLK > 12) then
					glitch_part = 2
					msg2 = "Step 4: Mash cr.LP!!!!"
				else
					msg2 = "Step 3: You pressed cr.LK too early, TRY AGAIN"
				end
			end
		end
		if (glitch_part == 2) then
			frames_between_crLK_and_crLP = countFrames(frames_between_crLK_and_crLP)
			if (isPressed(gamestate.P1, "LP") and isPressed(gamestate.P1, "down")) then
				glitch_part = 3
				msg2 = "Step 4: Keep mashing cr.LP!!!!"
			end
			if (frames_between_crLK_and_crLP >= 12) then
				msg1="FAIL! You didn't chain cancel cr.LK into cr.LP quick enough"
				resetGlitch()
				return
			end
		end
		if (glitch_part == 3) then
			local headbutt_state = rb(0xFF850E);
			if (headbutt_state == 4) then
				frames_executing_glitch = countFrames(frames_executing_glitch)
				if frames_executing_glitch > 1 then
					msg1="SUCESS! You executed the glitch successfully during "..frames_executing_glitch.." frames."
				end
			end
		end
		if (glitch_part >= 2 and gamestate.P1.state ~= 10) then
			if glitch_part == 2 then
				msg1="FAIL! You didn't chain cancel cr.LK into cr.LP"
			elseif glitch_part == 3 then
				if frames_executing_glitch > 1 then
					msg1="SUCESS! You executed the glitch successfully during "..frames_executing_glitch.." frames."
				else
					msg1="FAIL! You didn't mash cr.LP quick enough"
				end
			end
			resetGlitch()
		end
		-- msg3 = "GLITCH_PART="..glitch_part.." LP->crLK="..frames_between_sLP_and_crLK.." LK->LP="..frames_between_crLK_and_crLP.." STATE="..gamestate.P1.state
	end
end

table.insert(ST_functions, boxerGlitch)
