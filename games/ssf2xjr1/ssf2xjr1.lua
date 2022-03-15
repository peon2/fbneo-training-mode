assert(rb,"Run fbneo-training-mode.lua") -- make sure the main script is being run
-- ssf2x training mode by @pof
require("games/ssf2xjr1/character_specific")

p1maxhealth = 144
p2maxhealth = 144
p1maxmeter = 0x30
p2maxmeter = 0x30

local p1_need_health_refill = false
local p2_need_health_refill = false

local p1health = 0xFF8478
local p1redhealth = 0xff847A
local p1disphealth = 0xff860A
local p2health = 0xFF8878
local p2redhealth = 0xFF887A
local p2disphealth = 0xFF8A0A

local p1meter = 0xFF8702
local p2meter = 0xFF8B02

local p1action = 0
local p2action = 0

local p2inputs = 0
local p1inputs = 0

local prev_p1action = 0
local prev_p2action = 0

local Ryu = 0x00
local Honda = 0x01
local Blanka = 0x02
local Guile = 0x03
local Ken = 0x04
local Chun = 0x05
local Zangief = 0x06
local Dhalsim = 0x07
local Dictator = 0x08
local Sagat = 0x09
local Boxer = 0x0A
local Claw = 0x0B
local Cammy = 0x0C
local Hawk = 0x0D
local Fei = 0x0E
local Deejay = 0x0F

-------------------------------------------------------------
-- Added by Asunaro
-------------------------------------------------------------
----------------------------
-- General
----------------------------

local base_p1 = 0xFF844E
local base_p2 = 0xFF884E

local p1_reversal_address 			= 		base_p1 + 0x169
local p1_boxer_reversal_address		=		base_p1 + 0x16D
local p1_character_address			=		base_p1 + 0x391

local p2_hitfreeze_address  		= 		base_p2 + 0x47
local p2_blockstun_hitstun_counter	=		base_p2 + 0x11D
local p2_reversal_address 			= 		base_p2 + 0x169
local p2_reversal_id_address		=		base_p2 + 0x16A
local p2_special_strength_address 	=		base_p2 + 0x16B
local p2_boxer_reversal_address		=		base_p2 + 0x16D
local p2_character_address			=		base_p2 + 0x391
local p2_curr_input_address			=		base_p2 + 0x392
local p2_prev_input_address			=		base_p2 + 0x394

function readPlayerTwoCharacter() -- Return the correct string sequence used in character_specific.lua
	local p2_character = rb(p2_character_address)
	if p2_character == Ryu then
		return "ryu"
	elseif p2_character == Honda then
		return "ehonda"
	elseif p2_character == Blanka then
		return "blanka"
	elseif p2_character == Guile then
		return "guile"
	elseif p2_character == Ken then
		return "ken"
	elseif p2_character == Chun then
		return "chunli"
	elseif p2_character == Zangief then
		return "zangief"
	elseif p2_character == Dhalsim then
		return "dhalsim"
	elseif p2_character == Dictator then
		return "dictator"
	elseif p2_character == Sagat then
		return "sagat"
	elseif p2_character == Boxer then
		return "boxer"
	elseif p2_character == Claw then
		return "claw"
	elseif p2_character == Cammy then
		return "cammy"
	elseif p2_character == Hawk then
		return "thawk"
	elseif p2_character == Fei then
		return "feilong"
	elseif p2_character == Deejay then
		return "deejay"
	end
end

------------------------------------------
-- Reversal (patch method)
------------------------------------------
local curr_patched = false
local prev_patched = false
local patch_changed = true -- Will determine if the settings have to be reloaded
local first_load = true

function readPatch() -- Will be used anytime the game is reloaded
	prev_patched = curr_patched
	local patch1 = memory.readdword(0x782a2)
	if (patch1 == 0x734AABE4) then
		patch2 = memory.readdword(0x2CC8)
		if (patch2 == 0x3F50A405) then
			patch3 = memory.readdword(0x8e94e)
			if (patch3 == 0x9BF781C3) then
				curr_patched = true
			else
				curr_patched = false
			end
		end
	else
		curr_patched = false
	end
	if first_load then
		prev_patched = curr_patched
	end
	if prev_patched ~= curr_patched then
		patch_changed = true
	else
		patch_changed = false
	end
end
-------------------------------
emu.registerstart(readPatch)
-------------------------------

local reversal_options_checked = {} -- Stocks the relevant values to perform the choosen reversals
local listenReversalSettingsModfications = false

function stockReversalOptionsChecked()
	if interactivegui.enabled and not listenReversalSettingsModfications then -- If the menu has been opened clean the table (maybe there's a cleaner way)
		for k in pairs(reversal_options_checked) do
			reversal_options_checked[k] = nil
		end
		patched_autoreversal_selector = 0
		listenReversalSettingsModfications = true
	end
	if not interactivegui.enabled and listenReversalSettingsModfications then -- If the menu has been closed, check the options selected
		for i = 1, #reversal_options do
			if reversal_options[i].checked then
				table.insert(reversal_options_checked, reversal_options[i].reversal_id)
			end
		end
		if do_not_reversal.checked then
			table.insert(reversal_options_checked, "do_not_reversal")
		end
		if custom_sequence.checked then
			table.insert(reversal_options_checked, "custom_sequence")
		end
		if #reversal_options_checked == 0 then
			patched_autoreversal_selector = 0
		elseif #reversal_options_checked == 1 then
			if do_not_reversal.checked then
				patched_autoreversal_selector = 0
			else
				patched_autoreversal_selector = 1
			end
		elseif #reversal_options_checked > 1 then
			patched_autoreversal_selector = 2
		end
		listenReversalSettingsModfications = false
	end
end
---------------------------------------------------------------------------------------------
-- Special reversal : Uses a patch which NOP the line clearing +0x169 each frame.
-- If +0x169 is set to 0x01 the character will reversal the special defined in +0x16A
---------------------------------------------------------------------------------------------
function p1ClearReversal()
	if rb(p1_boxer_reversal_address) == 0x01 and rb(p1_character_address) == Boxer then
		wb(p1_boxer_reversal_address,0x00)
	elseif rb(p1_reversal_address) == 0x01 then
		wb(p1_reversal_address,0x00)
	end
end

function p2ClearReversal()
	if rb(p2_boxer_reversal_address) == 0x01 and rb(p2_character_address) == Boxer then
		wb(p2_boxer_reversal_address,0x00)
	elseif rb(p2_reversal_address) == 0x01 then
		wb(p2_reversal_address,0x00)
	end
end

function p1SetReversal(_reversal_id)
	if rb(p1_character_address) == Boxer then
		if rb(p1_boxer_reversal_address) == 0x00 then
			wb(p1_boxer_reversal_address,0x01)
		end
	elseif rb(p1_reversal_address) == 0x00 then
		wb(p1_reversal_address,0x01)
	end
	wb(p1_reversal_id_address, _reversal_id[1])
	wb(p1_special_strength_address, _reversal_id[2])
	if rb(p2_character_address) == Hawk then
		if _reversal_id[1] == 0x00 then -- DP
			wb(0xFF84DE,_reversal_id[2])
			wb(0xFF84DD,_reversal_id[2])
		end
	end
end

function p2SetReversal(_reversal_id)
	if rb(p2_character_address) == Boxer then
		if rb(p2_boxer_reversal_address) == 0x00 then
			wb(p2_boxer_reversal_address,0x01)
		end
	elseif rb(p2_reversal_address) == 0x00 then
		wb(p2_reversal_address,0x01)
	end
	wb(p2_reversal_id_address, _reversal_id[1])
	wb(p2_special_strength_address, _reversal_id[2])
	if rb(p2_character_address) == Hawk then
		if _reversal_id[1] == 0x00 then -- DP
			wb(0xFF88DE,_reversal_id[2])
			wb(0xFF88DD,_reversal_id[2])
		end
	end
end
-----------------------------------------------------------------------------------------------
-- Reversal Grab : Uses a patch which NOP the line writing p2 previous input dection (+0x394)
-- If we write 0x0000 in this address each current input will be autofired
-----------------------------------------------------------------------------------------------
local prev_p2inputs = 0x0000
local fixed_inputs = true

local function menuSelection()  -- Just a little fix : without it the cursor in character selection is buggy
	if rw(0xFF8008) == 0x00 then -- In the character selection screen
		if p2inputs ~= 0x0000 then
			ww(p2_prev_input_address, 0xFFFF)
		end
	end
end

local function fixPreviousInputsDetection(_fixed_inputs) -- Restores the previous input detection / Disables the autofire
	if _fixed_inputs then
		prev_p2inputs = p2inputs
		p2inputs = rw(p2_curr_input_address)
		ww(p2_prev_input_address, prev_p2inputs)
	end
	menuSelection()
end

local reversal_throw_ready = false
local iswakeup = false

local function reversalThrow(_throw)
	--if (p2action == 14 and prev_p2action ~= 14) or (p2action == 20 and prev_p2action ~= 20) then
		if (p2action == 20) then
			iswakeup = true
		end
	--end
	if p2action == 14 and prev_p2action == 14 then -- if p2 is hit
		local onair = rb(0xff89cf)
		if onair == 255 then
			iswakeup = true
		end
		local counter = rb(p2_blockstun_hitstun_counter) -- We'll set reversal_throw_ready to true when the timing for a reversal is about to come
		if counter >= 0x69-0x03 and counter <= 0x69 then -- Light
			reversal_throw_ready = true
		elseif iswakeup and counter >= 0x7A-0x0A and counter <= 0x7A then -- Knockdown : the range is voluntarily wider because a knockdown can be interrupted by the corner and thus so does the hitstun counter
			reversal_throw_ready = true
		elseif not iswakeup and counter >= 0x7A-0x03 and counter <=0x7A then -- Medium
			reversal_throw_ready = true
		elseif counter >= 0x90-0x03 and counter <= 0x90 then -- Strong
			reversal_throw_ready = true
		else
			reversal_throw_ready = false
		end
	elseif p2action == 20 and prev_p2action == 20 then -- If p2 is thrown
		reversal_throw_ready = true
	else
		reversal_throw_ready = false
	end

	if reversal_throw_ready then
		fixed_inputs = false -- We disable the fix : the game won't update prev_p2inputs anymore
		ww(0xFF8BE2, 0x0000) -- We stock 0000 in prev_p2inputs : the game will think that the p2 didn't hold anything in the previous frame. Each input will now be interpreted as a new one, basically we're creating an autofire
		if readPlayerTwoCharacter() == "blanka" then
			wb(0xFF88EC, 0x00) -- Disables Blanka HP electricity
		end
		if readPlayerTwoCharacter() == "ehonda" then
			wb(0xFF8916, 0x00) -- Disables Honda MP HHS
			wb(0xFF8918, 0x00) -- 				 HP HHS
			if rb(0xFF8C04) == 0x01 then -- Old Honda
				wb(0xFF88EA, 0x00) -- MP HHS
				wb(0xFF88EC, 0x00) -- HP HHS
			end
		end
		if playerOneFacingLeft() then
				setDirection(2,"Left", determineThrowInput(_throw))
			else
				setDirection(2,"Right",determineThrowInput(_throw))
			end
		return
	else -- we enable the fix
		fixed_inputs = true
	end
	if p2action == 10 then -- if the p2 attempts a throw we release the buttons
		setDirection(2,5)
	end
end

-------------------
-- Custom Sequence
-------------------
local p2_custom_sequence_ready = false

local function customSequence() -- Would need to be improved
	local framesrecorded = #recording[recording.recordingslot]
	if (framesrecorded < 1) then
		gui.text(220,50,"Use the Replay Editor in the")
		gui.text(220,60,"Recording menu (hold coin) to")
		gui.text(220,70,"program the desired reversal action.")
		return
	end
	if rb(p2_hitfreeze_address) ~= 0x00 or (p2action == 20 and prev_p2action ~= 20) then -- If the character has been thrown or if we detect hitfreeze (here it's more reliable than "p2action == 14 and prev_p2action ~= 14" because this expression can't detect combos)
		p2_custom_sequence_ready = true
		if (p2action == 20) then
			iswakeup = true
		end
	end
	if (p2action == 14 and prev_p2action == 14) then
	local onair = rb(0xff89cf)
		if onair == 255 then
			iswakeup = true
		end
	end
	if not iswakeup and p2_custom_sequence_ready then
		local counter = rb(p2_blockstun_hitstun_counter)
		--print("prev_p2action : "..prev_p2action)
		--print("curr_p2action : "..p2action)
		--print("counter : 0x"..string.format("%x",counter))
		if not recording.playback then
			if (counter == 0x68 and autoblock_selector == -1) or counter == 0x69 then -- Light
			togglePlayBack(nil, {})
			--print("Reversal on a Light")
			p2_custom_sequence_ready = false
			elseif (counter == 0x79 and autoblock_selector == -1) or counter == 0x7A then -- Medium
			togglePlayBack(nil, {})
			--print("Reversal on a Medium")
			p2_custom_sequence_ready = false
			elseif (counter == 0x8F and autoblock_selector == -1) or counter == 0x90 then -- Strong
			togglePlayBack(nil, {})
			--print("Reversal on a Strong")
			p2_custom_sequence_ready = false
			end
		end
	elseif iswakeup and ((prev_p2action == 14 and p2action ~= 14) or (prev_p2action == 20 and p2action ~= 20)) then -- Would need to be more precise
		--print(" Reversal on Wakeup")
		togglePlayBack(nil, {})
		iswakeup = false
	end
end
-------------------
-- Reversal Logic
-------------------
math.randomseed(os.time())
math.random(); math.random(); math.random()

local reversal_reroll = true -- Determine if a new reversal has to be selected
local current_recording_state = false

function patchedReversalLogic()
	if custom_sequence.checked then
		local framesrecorded = #recording[recording.recordingslot]
		if (framesrecorded < 1) then
			gui.text(220,50,"Use the Replay Editor in the")
			gui.text(220,60,"Recording menu (hold coin) to")
			gui.text(220,70,"program the desired reversal action.")
			return
		end
	end

	if patched_autoreversal_selector == 1 then -- One option has been checked
		if reversal_options_checked[1][1] == "throw" then
			p2ClearReversal()
			reversalThrow(reversal_options_checked[1][2])
		elseif reversal_options_checked[1] == "custom_sequence" then
			p2ClearReversal()
			customSequence()
		else
			if reversal_reroll then
				p2SetReversal(reversal_options_checked[1])
				reversal_reroll = false
			end
		end

	elseif patched_autoreversal_selector == 2 then -- Multiple options checked
		if reversal_reroll then
			random_reversal = math.random(1,#reversal_options_checked)
		end
		if not recording.playback then
			if reversal_options_checked[random_reversal][1] == "throw" then
				p2ClearReversal()
				reversalThrow(reversal_options_checked[random_reversal][2])
			elseif reversal_options_checked[random_reversal] == "custom_sequence" then
				p2ClearReversal()
				customSequence()
				current_recording_state = recording.playback
			elseif reversal_options_checked[random_reversal] == "do_not_reversal" then
				p2ClearReversal()
			else
				if reversal_reroll then
					p2SetReversal(reversal_options_checked[random_reversal])
				end
			end
			reversal_reroll = false
			if (prev_p2action ~= 0x0C and p2action == 0x0C) or (reversal_options_checked[random_reversal][1] == "throw" and prev_p2action ~= 10 and p2action == 10) or (reversal_options_checked[random_reversal] == "do_not_reversal" and prev_p2action == 14 and p2action ~= 14) or (reversal_options_checked[random_reversal] == "custom_sequence" and current_recording_state == true) then
				-- if p2 finished a special attack / if p2 attempted a throw / if p2 has been hit when "don't reversal" is selected
				-- if a playback has been launched -> reroll a special to be played
				reversal_reroll = true
			end
		end

	else
		p2ClearReversal()
		reversal_reroll = true -- Set to true when you enter the gui
	end
end

function patchedAutoReversal()
	p1ClearReversal()
	stockReversalOptionsChecked()
	patchedReversalLogic()
end

--------------------------------------
--Display relevant reversal options
--------------------------------------
local curr_p2character = readPlayerTwoCharacter()
local prev_p2character = readPlayerTwoCharacter()

function displayReversalSettings()
	if patch_changed or first_load then
		makeReversalSettings(curr_patched)
		patch_changed = false
	end
	if curr_patched then
		prev_p2character = curr_p2character
		curr_p2character = readPlayerTwoCharacter()
		if prev_p2character ~= curr_p2character then
			if #reversal_options_checked > 0 then
				for k in pairs(reversal_options_checked) do
				reversal_options_checked[k] = nil
				end
			end
			patched_autoreversal_selector = 0
			reloadReversalSettings()
		end
	else
		if not fixed_inputs then
			fixed_inputs = true
		end
	end
	if first_load then
		first_load = false
	end
end

-----------------------------------------------
-----------------------------------------------

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"button5",
	"button6",
	"coin",
	"start",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Weak Punch"] = 5,
	["Medium Punch"] = 6,
	["Strong Punch"] = 7,
	["Weak Kick"] = 8,
	["Medium Kick"] = 9,
	["Strong Kick"] = 10,
	["Coin"] = 11,
	["Start"] = 12,
}

gamedefaultconfig = {
	hud = {
		combotextx=178,
		combotexty=48,
		comboenabled=true,
		p1healthx=17,
		p1healthy=22,
		p1healthenabled=true,
		p2healthx=355,
		p2healthy=22,
		p2healthenabled=true,
		p1meterx=82,
		p1metery=207,
		p1meterenabled=false,
		p2meterx=294,
		p2metery=207,
		p2meterenabled=false,
	},
	inputs = {
		iconsize=8,
		framenumbersenabled=true,
		scrollinginputxoffset={2,335},
		scrollinginputyoffset={95,95},
	},
	p1 = {
		instantrefillhealth=false,
		refillhealthenabled=true,
		instantrefillmeter=true,
		refillmeterenabled=true,
	},
	p2 = {
		instantrefillhealth=false,
		refillhealthenabled=true,
		instantrefillmeter=true,
		refillmeterenabled=true,
	},
}

function playerOneFacingLeft()
	return rw(0xFF8454) >= rw(0xFF8854)
end

function playerTwoFacingLeft()
	return rw(0xFF8454) < rw(0xFF8854)
end

function playerOneInHitstun()
	if rb(0xFF863E) > 0 then
		-- false when dizzy
		return false
	end
        if rb(0xFF8451) == 14 then
		return true
	end
	return false
end

function playerTwoInHitstun()
	if rb(0xFF8A3E) > 0 then
		-- false when dizzy
		return false
	end
	if rb(0xFF8851) == 14 then
		return true
	end
	return false
end

function readPlayerOneHealth()
	return rw(p1redhealth)
end

function writePlayerOneHealth(health)
	if not combovars.p1.refillhealthenabled then
		return
	end
	local refill = false
	if readPlayerOneHealth() < 33 then
		-- if health < 33 we refill regardless of the state
		refill = true
	elseif ((p1action ~= 0x14 and p1action ~=0xe and p1action ~= 8) and (p2action==2 or p2action==0)) then
		-- this only refills when p2 is idle or crouching and p1 is not blocking or after being hit/thrown
		refill = true
	elseif (p1action ~= 8) and readPlayerOneHealth() < 50 then
		-- when health is depleting try to refill even if it will cause some small glitches
		refill = true
	end
	if refill then
		ww(p1health, health)
		ww(p1redhealth, health)
		ww(p1disphealth, health)
		p1_need_health_refill=false
	end
end

function readPlayerTwoHealth()
	return rw(p2redhealth)
end

function writePlayerTwoHealth(health)
	if not combovars.p2.refillhealthenabled then
		return
	end
	local refill = false
	if readPlayerTwoHealth() < 33 then
		-- if health < 33 we refill regardless of the state
		refill = true
	elseif ((p2action ~= 0x14 and p2action ~=0xe and p2action ~= 8) and (p1action==2 or p1action==0)) then
		-- this only refills when p1 is idle or crouching and p2 is not blocking or after being hit/thrown
		refill = true
	elseif (p2action ~= 8) and readPlayerTwoHealth() < 50 then
		-- when health is depleting try to refill even if it will cause some small glitches
		refill = true
	end
	if refill then
		ww(p2health, health)
		ww(p2redhealth, health)
		ww(p2disphealth, health)
		p2_need_health_refill=false
	end
end

function readPlayerOneMeter()
	if rw(0xFF8008) == 0xa then
		return rb(p1meter)
	else
		return p1maxmeter
	end
end

function writePlayerOneMeter(meter)
	if rw(0xFF8008) == 0xa then
		wb(p1meter, meter)
	end
end

function readPlayerTwoMeter()
	if rw(0xFF8008) == 0xa then
		return rb(p2meter)
	else
		return p2maxmeter
	end
end

function writePlayerTwoMeter(meter)
	if rw(0xFF8008) == 0xa then
		wb(p2meter, meter)
	end
end

local infiniteTime = function()
	timer = rb(0xff8dce)
	if (timer < 0x98) then
		ww(0xff8dce,0x9928)
	end
end

local neverEnd = function()

	if combovars.p2.refillhealthenabled and combovars.p2.instantrefillhealth then
		p2_need_health_refill = true
	end
	if combovars.p1.refillhealthenabled and combovars.p1.instantrefillhealth then
		p1_need_health_refill = true
	end

	if p2_need_health_refill then
		writePlayerTwoHealth(p2maxhealth)
	end
	if p1_need_health_refill then
		writePlayerOneHealth(p1maxhealth)
	end

	-- try to refill after being thrown, hold or knocked down
	if rb(0xff8853) == 10 or rb(0xff89cf) == 255 then
		p2_need_health_refill=true
		writePlayerTwoHealth(p2maxhealth)
	end
	if rb(0xff8453) == 10 or rb(0xff85cf) == 255 then
		p1_need_health_refill=true
		writePlayerOneHealth(p1maxhealth)
	end

	-- try to refill when health < 33 to avoid round ending
	if readPlayerTwoHealth() < 33 then
		p2_need_health_refill=true
		writePlayerTwoHealth(p2maxhealth)
	end
	if readPlayerOneHealth() < 33 then
		p1_need_health_refill=true
		writePlayerOneHealth(p1maxhealth)
	end
end

stage_selector = -1
local stageSelect = function()
	if stage_selector == -1 then
		return
	end
	if rb(0xff8008) == 0x04 then
		wb(0xff8c4f,stage_selector)
	end
	wb(0xFF8C51,0)
	ww(0xFFE18A,stage_selector)
end

local player1Crouching = function()
	if p1action == 2 then
		return true
	end
	if p1action == 4 or p1action == 6 then
		return false
	end
	if (p1action == 10 or p1action == 12) then
		local ypos = rw(0xFF8458)
		if (ypos <= 40) then
			return bit.band(p1inputs, 0x4) == 0x4
		end
	end
	return false
end

local getDistanceBetweenPlayers = function()
	if playerOneFacingLeft() then
		distance = rw(0xFF8454) - rw(0xFF8854)
	else
		distance = rw(0xFF8854) - rw(0xFF8454)
	end
	return distance
end

local frameskip_currval = 0
local frameskip_prevval = 0
local was_frameskip = false

local function checkFrameskip()
	frameskip_address = 0xFF801D
	frameskip_prevval = frameskip_currval
	frameskip_currval = rb(frameskip_address)
	local x = frameskip_currval - frameskip_prevval
	if x % 2 == 0 then
		was_frameskip = true
	else
		was_frameskip = false
	end
end

local function setFrameskip(status)
	if status then
		local speed = rb(0xFF83A9)
		if speed == 0 then frameskip_value = 0x80
		elseif speed == 1 then frameskip_value = 0x70
		elseif speed == 2 then frameskip_value = 0x60
		elseif speed == 3 then frameskip_value = 0x50
		end
		wb(0xFF8CD3, frameskip_value) -- frameskip enabled
	else
		wb(0xFF8CD3, 0xff) -- frameskip disabled
	end
end

autoreversal_selector = -1
local numframes = 0
local frame_for_reversal = 0
local iswakeup = false
local wakeup_reversal = 35
local counter_for_wakeup_reversal = 0
local frame_for_wakeup_reversal = 35
local framesleft_for_wakeup_reversal = {}
framesleft_for_wakeup_reversal[0] = -1
framesleft_for_wakeup_reversal[1] = -1
local doreversal = false
local reversal_executed = false
local reversal_executed_at = -1
local framesleft = -1
local reversal_guessed = 0
local autoReversal = function()

	local DEBUG=false

	if curr_patched then
		patchedAutoReversal()
	end

	if autoreversal_selector == -1 then
		return
	end

	local framesrecorded = #recording[recording.recordingslot]
	if (framesrecorded < 1) then
		gui.text(220,50,"Use the Replay Editor in the")
		gui.text(220,60,"Recording menu (hold coin) to")
		gui.text(220,70,"program the desired reversal action.")
		gui.text(35,80,"To improve auto-reversal select Game -> Load Game -> Apply IPS patches -> Play")
		return
	end
	if (framesrecorded > 8) then
		gui.text(220,50,"The recorded reversal action")
		gui.text(220,60,"is too long. Please record a")
		gui.text(220,70,"new action shorter than 9 frames.")
		return
	end

	local reversal_flag = rb(0xFF89B7)
	local frameanimation = rb(0xff896b)
	local onair = rb(0xff89cf)
	local prev_framesleft = framesleft
	framesleft = rb(0xff8867)
	if (p2action == 14 and prev_p2action ~= 14) or (p2action == 20 and prev_p2action ~= 20) then
		numframes = 1
		reversal_executed_at = -1
		reversal_executed = false
		counter_for_wakeup_reversal = 0
		if (p2action == 20) then
			iswakeup = true
		end
	end
	if (p2action == 14 and prev_p2action == 14) or (p2action == 20 and prev_p2action == 20) then
		numframes = numframes + 1
		if was_frameskip then
			-- if DEBUG then print ("FRAMESKIP @ "..numframes) end
			numframes=numframes+1
			if prev_framesleft - 1 == framesleft and framesleft > 1 then
				framesleft = framesleft - 1
			end
		end
		if onair == 255 then
			if not iswakeup then
				setFrameskip(true)
			end
			iswakeup = true
		end
		if (onair == 0) then
			if was_frameskip then
				counter_for_wakeup_reversal = counter_for_wakeup_reversal + 2
			else
				counter_for_wakeup_reversal = counter_for_wakeup_reversal + 1
			end
			wakeup_reversal = counter_for_wakeup_reversal - framesrecorded - 1
		else
			counter_for_wakeup_reversal = 0
		end

		if iswakeup and reversal_executed_at > 0 and reversal_executed_at + framesrecorded + 1 < numframes and framesrecorded < 5 then
			if DEBUG then print ("!!! Previous reversal attempt failed, trying again...") end
			framesleft_for_wakeup_reversal[0] = framesrecorded + 2
			framesleft_for_wakeup_reversal[1] = framesrecorded + 1
			frame_for_wakeup_reversal = counter_for_wakeup_reversal
			reversal_executed = false
			reversal_executed_at = -1
		end

		if iswakeup and reversal_guessed==1 and reversal_flag==0 then
			framesleft_for_wakeup_reversal[2]=framesleft
			reversal_guessed=2
		end


		if iswakeup and reversal_guessed==2 and reversal_flag==1 and framesleft_for_wakeup_reversal[1] ~= framesleft_for_wakeup_reversal[2] then
			if DEBUG then print("Adjusting wrong reversal guess from: "..framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1].." to "..framesleft_for_wakeup_reversal[1].."/"..framesleft_for_wakeup_reversal[2]) end
			framesleft_for_wakeup_reversal[0] = framesleft_for_wakeup_reversal[1]
			framesleft_for_wakeup_reversal[1] = framesleft_for_wakeup_reversal[2]
			reversal_guessed=0
		end
	end

	-- local boxer_reversal_flag = rb(0xFF89BB)
	-- if (DEBUG) and (p2action==14 or prev_p2action==14 or p2action==20 or prev_p2action==20) then print("p2action=" .. p2action .. " | numframes=" .. numframes .. " | onair="..onair.." | fa="..frameanimation.." | cfw="..counter_for_wakeup_reversal .. " | fl="..framesleft .. " | rf="..reversal_flag.." | brf="..boxer_reversal_flag) end

	if not iswakeup and (p2action ~= 14 and prev_p2action == 14) then
		setFrameskip(true)
		if (reversal_flag==1) and (p2action == 12) then
			if (DEBUG) then print("=> SUCCESSFUL GROUND REVERSAL AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
		else
			if (DEBUG) then print("=> MISSED GROUND REVERSAL AT FRAME: [" .. frame_for_reversal .. "] / " ..numframes) end
		end
	elseif iswakeup and ( (p2action ~= 14 and prev_p2action == 14) or (p2action ~= 20 and prev_p2action == 20) ) then
		setFrameskip(true)
		if (reversal_flag==1) and (p2action == 12) then
			if (DEBUG) then print("=> SUCCESSFUL WAKEUP REVERSAL PERFORMED AT FRAME: [" .. frame_for_wakeup_reversal .. " / " ..counter_for_wakeup_reversal.. "] | [" .. frame_for_reversal .. " / " ..numframes.."] | rf="..reversal_flag.." framesleft="..framesleft) end
		elseif (counter_for_wakeup_reversal - frame_for_wakeup_reversal == framesrecorded) then
			if (DEBUG) then print("=> MISSED FRAME-PERFECT WAKEUP REVERSAL PERFORMED AT FRAME: [" .. frame_for_wakeup_reversal .. " / " ..counter_for_wakeup_reversal.. "] | [" .. frame_for_reversal .. " / " ..numframes.."] | rf="..reversal_flag.." framesleft="..framesleft) end
			wakeup_reversal = wakeup_reversal + 1
			framesleft_for_wakeup_reversal[0] = -1
			framesleft_for_wakeup_reversal[1] = -1
		elseif (counter_for_wakeup_reversal - frame_for_wakeup_reversal < framesrecorded) then
			if (DEBUG) then print("=> MISSED WAKEUP REVERSAL PERFORMED TOO LATE AT FRAME: [" .. frame_for_wakeup_reversal .. " / " ..counter_for_wakeup_reversal.. "] | [" .. frame_for_reversal .. " / " ..numframes.."] | rf="..reversal_flag.." framesleft="..framesleft) end
			framesleft_for_wakeup_reversal[0] = -1
			framesleft_for_wakeup_reversal[1] = -1
		elseif (counter_for_wakeup_reversal - frame_for_wakeup_reversal > framesrecorded) then
			if (DEBUG) then print("=> MISSED WAKEUP REVERSAL PERFORMED TOO EARLY AT FRAME: [" .. frame_for_wakeup_reversal .. " / " ..counter_for_wakeup_reversal.. "] | [" .. frame_for_reversal .. " / " ..numframes.."] | rf="..reversal_flag.." framesleft="..framesleft) end
			framesleft_for_wakeup_reversal[0] = -1
			framesleft_for_wakeup_reversal[1] = -1
		end
		frame_for_wakeup_reversal = wakeup_reversal
		iswakeup = false
		if (DEBUG) then
			print("=> FRAME FOR NEXT WAKEUP REVERSAL: ["..wakeup_reversal.." / "..counter_for_wakeup_reversal.."] @ framesleft == " .. framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1])
			print(" ")
		end
	end

	if not iswakeup and (p2action == 14) then
		if (frameanimation == 105 - framesrecorded) or (frameanimation == 104 - framesrecorded) or (frameanimation == 122 - framesrecorded) or (frameanimation == 121 - framesrecorded) or (frameanimation == 144 - framesrecorded) or (frameanimation == 143 - framesrecorded) then
			if not recording.playback then
				setFrameskip(false)
				togglePlayBack(nil, {})
				frame_for_reversal = numframes
				if (DEBUG) then print("GROUND REVERSAL! numframes=[" .. numframes .. "]") end
			end
		end
	end
	if iswakeup and (p2action == 14 or p2action == 20) and not reversal_executed then

		if counter_for_wakeup_reversal == frame_for_wakeup_reversal-4 or (counter_for_wakeup_reversal == frame_for_wakeup_reversal-3 and was_frameskip) then
			setFrameskip(false)
		end

		if (framesleft_for_wakeup_reversal[0] == -1 and counter_for_wakeup_reversal == frame_for_wakeup_reversal) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing reversal wakeup: cfwr["..counter_for_wakeup_reversal.."]==ffwr["..frame_for_wakeup_reversal.."]") end
			doreversal = true
		end
		if (framesleft_for_wakeup_reversal[0] ~= -1 and ( prev_framesleft ~= framesleft_for_wakeup_reversal[0] and framesleft == framesleft_for_wakeup_reversal[0]) and counter_for_wakeup_reversal > frame_for_wakeup_reversal - 1) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing EARLY reversal wakeup: prev_framesleft("..prev_framesleft..")!=framesleft_fwr[0]("..framesleft_for_wakeup_reversal[0]..") AND framesleft("..framesleft..")==framesleft_fwr[0]("..framesleft_for_wakeup_reversal[0]..")") end
			doreversal = true
		end
		if (framesleft_for_wakeup_reversal[0] ~= -1 and ( prev_framesleft == framesleft_for_wakeup_reversal[0] and framesleft == framesleft_for_wakeup_reversal[1]) and counter_for_wakeup_reversal > frame_for_wakeup_reversal - 2) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing LATE reversal wakeup: prev_framesleft("..prev_framesleft..")==framesleft_fwr[0]("..framesleft_for_wakeup_reversal[0]..") AND framesleft("..framesleft..")==framesleft_fwr[1]("..framesleft_for_wakeup_reversal[1]..")") end
			doreversal = true
		end

		local p2character = rb(0xFF8BDF)
		if p2character == Honda or p2character == Blanka or p2character == Guile or p2character == Chun or p2character == Dictator or p2character == Boxer or p2character == Claw or p2character == Deejay then
			local p2charge = true
		else
			local p2charge = false
		end

		if p2charge == false and (framesleft_for_wakeup_reversal[0] ~= -1 and ( framesleft == framesrecorded+2 or framesleft == framesrecorded+1) and counter_for_wakeup_reversal >= frame_for_wakeup_reversal) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing DESPERATE reversal wakeup: framesleft("..framesleft..")==framesrecorded("..framesrecorded..")+1or+2 AND cfwr("..counter_for_wakeup_reversal..")>="..frame_for_wakeup_reversal) end
			doreversal = true
		end
		if p2charge == false and counter_for_wakeup_reversal > 30 and framesrecorded < 5 and not doreversal and not recording.playback and (framesleft_for_wakeup_reversal[0] ~= -1 and ( framesleft == framesrecorded+2 or framesleft == framesrecorded+1) and counter_for_wakeup_reversal <= frame_for_wakeup_reversal) then
			if (DEBUG) then print (">>> numframes="..numframes.." - performing EARLY BLIND reversal wakeup: framesleft("..framesleft..")==framesrecorded("..framesrecorded..")+1or+2 AND cfwr("..counter_for_wakeup_reversal..")<="..frame_for_wakeup_reversal) end
			setFrameskip(false)
			togglePlayBack(nil, {})
		end

		if doreversal and not recording.playback then
			setFrameskip(false)
			togglePlayBack(nil, {})
			frame_for_reversal = numframes
			framesleft = rb(0xff8867)
			if framesleft == framesrecorded + 1 then
				framesleft_for_wakeup_reversal[0] = prev_framesleft
				framesleft_for_wakeup_reversal[1] = framesleft
				if (DEBUG) then print ("PERFECT 1 flfwr="..framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1]) end
				reversal_guessed=0
			elseif framesleft > framesrecorded + 1 then
				framesleft_for_wakeup_reversal[0] = framesrecorded + 2
				framesleft_for_wakeup_reversal[1] = framesrecorded + 1
				if (DEBUG) then print ("PERFECT 2 flfwr="..framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1]) end
				reversal_guessed=0
			elseif framesleft_for_wakeup_reversal[0] == -1 then
				framesleft_for_wakeup_reversal[0] = prev_framesleft
				framesleft_for_wakeup_reversal[1] = framesleft
				if (DEBUG) then print ("GUESSED flfwr="..framesleft_for_wakeup_reversal[0].."/"..framesleft_for_wakeup_reversal[1]) end
				reversal_guessed=1
			end
			if (DEBUG) then print("WAKEUP REVERSAL! cfwr="..counter_for_wakeup_reversal.." frame_for_wakeup_reversal=[" .. frame_for_wakeup_reversal .. "] numframes="..numframes.." framesleft="..framesleft) end
			doreversal = false
			reversal_executed = true
			reversal_executed_at = numframes
		end
	end
end

autoblock_selector = -1
local forceblock = false
local inputs_at_jumpstart = 0
local autoblock_skip_counter = 60
local canblock = false
local autoBlock = function()

	if autoblock_selector == -1 then
		return
	end

	local DEBUG=false

	-- neutral when opponent is neutral, crouching or landing
	if (p1action == 0 or p1action == 2 or p1action==6) then
		setDirection(2,5)
		forceblock = false
		if autoblock_selector == 2 and canblock == true then
			canblock = false
		end
		return
	end

	local distance = getDistanceBetweenPlayers()

	-- if opponent is ground attacking, ground block
	if (p1action == 10 or p1action == 12) and distance < 265 then

		-- block: auto
		if autoblock_selector == 2 and canblock == false then
			if p2action == 14 then
				setDirection(2,5)
				canblock = true
			end
			return
		end

		-- block: random
		if autoblock_selector == 3 then
			autoblock_skip_counter = autoblock_skip_counter -1
			if autoblock_skip_counter == 0 then
				autoblock_skip_counter = 60
			end
			if autoblock_skip_counter > 40 then
				return
			end
		end

		local p1crouching = player1Crouching()
		if playerOneFacingLeft() and p1crouching then
			setDirection(2,1)
		end
		if playerTwoFacingLeft() and p1crouching then
			setDirection(2,3)
		end
		if playerOneFacingLeft() and not p1crouching then
			setDirection(2,4)
		end
		if playerTwoFacingLeft() and not p1crouching then
			setDirection(2,6)
		end
		if DEBUG then print("ground block @ p1action=" .. p1action .. " | inputs=" .. p1inputs .. " | distance=" .. distance) end
		return
	end

	-- block jump attacks
	local p1attacking = false
	if autoblock_selector ~= 1 and autoblock_selector ~= 2 and p1action == 4 and distance < 265 then

		if autoblock_selector == 3 then
			autoblock_skip_counter = autoblock_skip_counter -1
			if autoblock_skip_counter == 0 then
				autoblock_skip_counter = 60
			end
			if autoblock_skip_counter > 30 then
				return
			end
		end

		local p1buttons = bit.band(p1inputs, 0x000F)
		if prev_p1action ~= 4 then
			inputs_at_jumpstart = p1inputs-p1buttons
			p1attacking = false
		end
		if p1inputs-p1buttons ~= inputs_at_jumpstart and p1inputs-p1buttons > 10 then
			-- buttons pressed changed during jump, Player one is attacking
			p1attacking = true
			forceblock = true
		end
		if (p2action ~= 6 and p2action ~= 8 and p2action ~= 14) then
			forceblock = false
		end

		if (p1attacking or forceblock) then
			if playerOneFacingLeft() then
				setDirection(2,4)
			else
				setDirection(2,6)
			end
			if DEBUG then print("block high @ p1action=" .. p1action .. " | p2action=" .. p2action .. " | inputs=" .. p1inputs .. "/" .. p1buttons .. " | distance=" .. distance .. " | p1attacking=" .. tostring(p1attacking) .. " | forceblock=" .. tostring(forceblock)) end
			return
		end
		setDirection(2,5)
		if DEBUG then print("neutral @ p1action=" .. p1action .. " | p2action=" .. p2action .. " | inputs=" .. p1inputs .. "/" .. p1buttons .. " | distance=" .. distance .. " | p1attacking=" .. tostring(p1attacking) .. " | forceblock=" .. tostring(forceblock)) end
		forceblock = false
		return
	end

	-- stop blocking
	if (distance >= 265 or p1action == 2) then
		setDirection(2,5)
		if DEBUG then print("neutral-4 @ p1action=" .. p1action .. " | inputs=" .. p1inputs .. " | distance=" .. distance) end
		forceblock = false
		return
	end
	if DEBUG then print("FINAL @ p1action=" .. p1action .. " | inputs=" .. p1inputs .. " | distance=" .. distance) end

end

dizzy_selector = -1
local p2DizzyControl = function()

	local dizzy = 0
	if dizzy_selector == -1 then
		return
	end

	if dizzy_selector == 1 then
		dizzy = 0x40
	end

	ww(0xFF88AA, dizzy) -- timeout
	ww(0xFF88AC, dizzy) -- damage

end

function Run() -- runs every frame
	-- attacker state (ff8451 or +0x400 for p2): 0 idle, 2 crouching, 4 jumping, 10 doing a normal attack or throw, 12 on hitstun (doing an special attack)
	-- attacked state (ff8451 or +0x400 for p2): 6 waking up meaty, 8 blocking, 14 hit (receiving an attack), 20 thrown
	p1action = rb(0xff8451)
	p2action = rb(0xff8851)
	p1inputs = rw(0xFF87E0)

	checkFrameskip()
	displayReversalSettings()
	autoBlock()
	autoReversal()
	fixPreviousInputsDetection(fixed_inputs)
	neverEnd()
	stageSelect()
	p2DizzyControl()
	infiniteTime()

	prev_p1action = p1action
	prev_p2action = p2action
end

