debug_button = {
		text = "Debug",
		x = 8,
		y = determineButtonYPos(addonpage),
		olcolour = "black",
		func =	function()
				debug_selector = debug_selector + 1
				if debug_selector > 1 then
					debug_selector = 0
				end
				reset_msg()
			end,
		autofunc = function(this)
				if debug_selector == 0 then
					this.text = "Debug: Off"
				elseif debug_selector == 1 then
					this.text = "Debug: On"
				end
			end,
	}
table.insert(addonpage, debug_button)

debug_selector = 0

local function DEBUG()
	if debug_selector > 0 then
		gui.text(50,50,"P1 state : 0x"..string.format("%x",gamestate.P1.state))
		gui.text(50,60,"P1 substate : 0x"..string.format("%x",gamestate.P1.substate))
		gui.text(50,70,"P1 air state : 0x"..string.format("%x",gamestate.P1.air_state))
		gui.text(50,80,"P1 jump animation : 0x"..string.format("%x",gamestate.P1.jump_animation))
		gui.text(50,90,"P1 counter hit related : 0x"..string.format("%x",gamestate.P1.counter_hit_related))
		gui.text(50,100,"P1 been air counter hit : 0x"..str(gamestate.P1.been_air_counter_hit))
		
		gui.text(250,50,"P2 state : 0x"..string.format("%x",gamestate.P2.state))
		gui.text(250,60,"P2 substate : 0x"..string.format("%x",gamestate.P2.substate))
		gui.text(250,70,"P2 air state : 0x"..string.format("%x",gamestate.P2.air_state))
		gui.text(250,80,"P2 jump animation : 0x"..string.format("%x",gamestate.P2.jump_animation))
		gui.text(250,90,"P2 counter hit related : 0x"..string.format("%x",gamestate.P2.counter_hit_related))
		gui.text(250,100,"P2 been air counter hit : 0x"..str(gamestate.P2.been_air_counter_hit))
	end
end
table.insert(Z3_functions, DEBUG)