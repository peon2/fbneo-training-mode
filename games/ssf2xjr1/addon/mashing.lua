mashing_button = {
		text = "Mashing Training",
		olcolour = "black",
		func =	function()
				mashing_selector = mashing_selector + 1
				if mashing_selector > 1 then
					mashing_selector = 0
				end
				reset_msg()
			end,
		autofunc = function(this)
				if mashing_selector == 0 then
					this.text = "Mashing Training : Off"
				elseif mashing_selector == 1 then
					this.text = "Mashing Training : On"
				end
			end,
	}
insertAddonButton(mashing_button)

mashing_selector = 0


local counter = 0
local goal = 100
local begin_mash = false
local countdown = 0
local mashing_count = 0

local function mashing()
	if mashing_selector > 0 and not interactivegui.enabled then
		if not begin_mash then
			countdown = countFrames(countdown)
			if countdown >= 180 then
				msg1 = "\t\t      Mash !"
				begin_mash = true
			elseif countdown >= 120 then 
				msg1 = "\t\t\t 1"
			elseif countdown >= 60 then
				msg1 = "\t\t\t 2"
			elseif countdown >= 0 then
				msg1 = "\t\t\t 3"
			end
		end
		if begin_mash then
			mashing_count = countFrames(mashing_count)
			if counter < goal then
					gui.box(185,(200-counter),195,200, 0xFF0000B0,0x00000000)
					gui.box(185,100,195,200,0x00000000, 0x000000FF)
				gui.text(181,205,counter.."/100")
			else
				msg1 = "\t You reached "..goal.." points in "..mashing_count.." frames."
				countdown = -180
				begin_mash = false
				counter = 0
				mashing_count = 0
			end
			if wasPressed(gamestate.P1, "direction") and not isPressed(gamestate.P1, "direction") then
				counter = counter + 3
			end
			if isPressed(gamestate.P1, "button") then
				if bit.band(gamestate.P1.curr_input, 0x0FF0) > bit.band(gamestate.P1.prev_input, 0x0FF0) then
					counter = counter + 1
				end
			end
		end
	end
end

table.insert(ST_functions, mashing)