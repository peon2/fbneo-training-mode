assert(rb,"Run fbneo-training-mode.lua")

guielements = { -- some shorthands/parts of interactiveguipages that can be moved in or out
	leftarrow = {
		text = "<<",
		x = 0,
		y = 0,
		olcolour = "black",
		func = 	function()
					changeInteractiveGuiPage(interactivegui.page-1)
				end,
		info = {
			"Moves back one page"
		},
	},
	rightarrow = {
		text = ">>",
		x = interactivegui.boxx2 - interactivegui.boxx - 12,
		y = 0,
		olcolour = "black",
		func = 	function()
					changeInteractiveGuiPage(interactivegui.page+1)
				end,
		info = {
			"Moves forward one page"
		},
	},
	falseleftarrow = {
		text = "<<",
		x = 0,
		y = 0,
		olcolour = "black",
	},
	falserightarrow = {
		text = ">>",
		x = interactivegui.boxx2 - interactivegui.boxx - 12,
		y = 0,
		olcolour = "black",
	},
	instanthealthrefill = {
			text = "Instant health refill off",
			x = 36,
			y = 85,
			info = {
				"Controls whether p2 health refills gradually or not",
			},
			olcolour = "black",
			func = 	function() changeConfig("p2", "instantrefillhealth", not combovars.p2.instantrefillhealth, combovars.p2) end,
			autofunc = 	function(this)
							if combovars.p2.instantrefillhealth then
								this.text = "Instant health refill on"
								this.x = 40
							else
								this.text = "Instant health refill off"
								this.x = 36
							end
						end,
	},
	p1meter = {
		text = "P1 meter settings",
		x = 40,
		y = 50,
		olcolour = "black",
		info = {
			"Controls how P1 meter is handled",
		},
		func = 	function()
					local Elements = {
						{text = "No Refill", selectfunc = function() return function() changeConfig("p1", "refillmeterenabled", false, combovars.p1) end end},
						{text = "Always Full", selectfunc = function() return
							function()
								changeConfig("p1", "refillmeterenabled", true, combovars.p1)
								changeConfig("p1", "instantrefillmeter", true, combovars.p1)
							end
						end},
						{text = "Fill after Combo", selectfunc = function() return
							function()
								changeConfig("p1", "refillmeterenabled", true, combovars.p1)
								changeConfig("p1", "instantrefillmeter", false, combovars.p1)
							end
						end},
					}
					local rf = function(n) return function()
						CIG(1,3)
					end end
					guipages.temp = createPopUpMenu(guipages[1], rf, nil, nil, Elements, 140, 40, nil)
					CIG("temp", inputs.properties.scrollinginput.state)
				end,
		autofunc = 	function(this)
						if not combovars.p1.refillmeterenabled then
							this.text = "No Refill"
							this.x = 92
						elseif combovars.p1.refillmeterenabled and combovars.p1.instantrefillmeter then
							this.text = "Always Full"
							this.x = 84
						else
							this.text = "Fill after Combo"
							this.x = 64
						end
					end,
	},
	p1meterlesser = {
		text = "P1 meter settings",
		x = 40,
		y = 50,
		olcolour = "black",
		info = {
			"Controls how P1 meter is handled",
		},
		func = 	function() 
					if combovars.p1.refillmeterenabled then
						changeConfig("p1", "refillmeterenabled", false, combovars.p1)
						changeConfig("p1", "instantrefillmeter", false, combovars.p1)
					else
						changeConfig("p1", "refillmeterenabled", true, combovars.p1)
						changeConfig("p1", "instantrefillmeter", true, combovars.p1)
					end
				end,
		autofunc = 	function(this)
						if not combovars.p1.refillmeterenabled then
							this.text = "No Refill"
							this.x = 92
						else
							this.text = "Always Full"
							this.x = 84
						end
					end,
	},
	p2hold = {
		none = {
			text = "None",
			x = 200,
			y = 70,
			func = 	function ()
						setDirection(2)
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3 
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
		up = {
			text = "Up",
			x = 205,
			y = 50,
			func = 	function ()
						setDirection(2, "Up")
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3 
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
		upright = {
			text = "Up-Right",
			x = 228,
			y = 60,
			func = 	function ()
						setDirection(2, "Up", "Right")
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3 
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
		right = {
			text = "Right",
			x = 248,
			y = 70,
			func = 	function ()
						setDirection(2, "Right")
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3 
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
		downright = {
			text = "Down-Right",
			x = 220,
			y = 80,
			func = 	function ()
						setDirection(2, "Down", "Right")
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3 
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
		down = {
			text = "Down",
			x = 200,
			y = 90,
			func = 	function ()
						setDirection(2, "Down")
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3 
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
		downleft = {
			text = "Down-Left",
			x = 160,
			y = 80,
			func = 	function ()
						setDirection(2, "Down", "Left")
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
		left = {
			text = "Left",
			x = 152,
			y = 70,
			func = 	function ()
						setDirection(2, "Left")
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
		upleft = {
			text = "Up-Left",
			x = 160,
			y = 60,
			func = 	function ()
						setDirection(2, "Up", "Left")
						changeInteractiveGuiPage(2)
						interactivegui.selection = 3
					end,
			info = {
				"Allows you to set which of 8 directions player two holds"
			},
		},
	},
	simpledisplaytoggle = {
		text = "Simple input display on",
		x = 36,
		y = 70,
		info = {
			"toggles simple display down the bottom of the screen",
		},
		olcolour = "black",
		func = function() changeConfig("inputs","simpleinputenabled", not inputs.properties.simpleinput.enabled, inputs.properties.simpleinput, "enabled") end,
							
		autofunc =	function(this)
						if inputs.properties.simpleinput.enabled then
							this.text = "Simple input display on"
							this.x = 36
						else
							this.text = "Simple input display off"
							this.x = 32
						end
					end,
	},
	scrollinginputsettings = {
		text = "Change scrolling input settings",
		x = 4,
		y = 90,
		olcolour = "black",
		func = 	function() CIG("scrollingtextsettings", 2) end,
	},
	scrollinginputframestoggle = {
		text = "Display scrolling input frame numbers",
		x = 76,
		y = 90,
		info = {
			"Toggles frame numbers displayed along with scrolling inputs",
		},
		olcolour = "black",
		func = function()
					inputs.properties.scrollinginput.frames = not inputs.properties.scrollinginput.frames
					changeConfig("inputs", "framenumbersenabled", inputs.properties.scrollinginput.frames)
					scrollingInputReload()
				end,
		autofunc =	function(this)
					if inputs.properties.scrollinginput.frames then
						this.text = "Frame number display on"
						this.x = 20
					else
						this.text = "Frame number display off"
						this.x = 16
					end
				end,
	},
	replayautoturn = {
		text = "Auto-Turn",
		x = 29,
		y = 90,
		olcolour = "black",
		info = {
			"Allows you to control whether or not a replay will reverse itself",
			"while playing if they're on a different side to how it was recorded",
		},
		func =	function()
					recording.autoturn = not recording.autoturn
				end,
		autofunc = 	function(this)
						if recording.autoturn then
							this.text = "Auto-Turn"
							this.x = 29
						else
							this.text = "Don't Auto-Turn"
							this.x = 5
						end
					end,
		},
	coininputleniency = {
		text = "Coin leniency",
		x = 64,
		y = 30,
		fillpercent = 0,
		olcolour = "black",
		info = {
			"This controls how many frames you have between each coin input",
			"10 frames allows for faster usage",
			"but 15 might be easier for slow fingers",
		},
		func = 		function()
						local Elements = {
							{text = "10"},
							{text = "11"},
							{text = "12"},
							{text = "13"},
							{text = "14"},
							{text = "15"},
						}
						CIG("coininputleniency", inputs.properties.coinleniency - 10)
						local rf = function() return function() CIG(1, 3) end end
						local sf = function(n) return function() changeConfig("inputs", "coinleniency", n+9, inputs.properties) end end
						guipages.temp = createPopUpMenu(guipages[1], rf, sf, nil, Elements, 136, 30, nil)
						CIG("temp", recording.hitplayback)
					end,
		autofunc = 	function(this)
						this.text = "Coin leniency "..(inputs.properties.coinleniency)
						this.fillpercent = (inputs.properties.coinleniency-10)/5
					end,
	},
	hitplayback = {
		main = {
			text = "Select Hit Slot",
			x = 5,
			y = 105,
			olcolour = "black",
			info = {
				"Plays back the respective replay slot after hit",
			},
			func = 		function()
							local Elements = {
								{},
								{},
								{},
								{},
								{},
								{y = 75, text = "None", releasefunc = function() return function() recording.hitslot = nil CIG(3, 3) end end, autofunc = function() end}
							}
							local rf = function(n) return function() recording.hitslot = n CIG(3, 3) end end
							local af = function(n) return
								function(this)
									if recording[n][1] then -- if something is in the slot 
										this.textcolour = "yellow"
									else
										this.textcolour = "white"
									end
								end
							end
							
							guipages.temp = createPopUpMenu(guipages[3], rf, nil, af, Elements, 72, 85, nil)
							CIG("temp", recording.hitplayback) 
						end,
			autofunc =	function(this)
							if not recording.hitslot then
								this.text = "Select Hit Slot"
								this.x = 5					
							else
								this.text = "Hit Slot "..recording.hitslot
								this.x = 25
							end
						end,
		
		},
	},
	hitboxsettings = {
		text = "Change hitbox settings",
		x = 40,
		y = 110,
		olcolour = "black",
		func = 	function() CIG("hitboxsettings", 2) end,
		info = {
			"Change hitbox settings",
		},
	},
	hitboxstate = {
		text = "Hitboxes On",
		x = 76,
		y = 50,
		func = 	function()
			changeConfig("hitbox", "enabled", not hitboxes.enabled, hitboxes)
		end,
		info = {
			"Toggles hitboxes on and off",
		},
		autofunc = 	function(this)
			if hitboxes.enabled then
				this.text = "Hitboxes On"
				this.x = 76
			else
				this.text = "Hitboxes Off"
				this.x = 72
			end
		end
	},
}

guipages = { -- interactiveguipages
	{ -- Main
		title = {
			text = "Basic Settings",
			x = interactivegui.boxxlength/2 - 28,
			y = 1,
		},
		guielements.leftarrow,
		guielements.rightarrow,
		guielements.coininputleniency,
	},
	{ -- Dummy
		title = {
			text = "Dummy Settings",
			x = interactivegui.boxxlength/2 - 30,
			y = 1,
		},
		guielements.leftarrow,
		guielements.rightarrow,
		{
			text = "Set the direction P2 is holding",
			x = 12,
			y = 70,
			info = {
				"Allows you to set P2 to hold an ordinal point",
			},
			func = function() CIG("setdirectionp2", 1) end,
			olcolour = "black",
			autofunc = 	function(this)
							local str = "P2 holding "
							for i, v in pairs(inputs.properties.p2hold) do
								if v then
									str = str .. i .. " "
								end
							end
							if #str > 11 then
								this.text = str -- 124
								this.x = 12 + (31-#str)*4
							else
								this.text = "Set the direction P2 is holding"
								this.x = 12
							end
						end,
		},
	},
	{ -- Recording
		guielements.leftarrow,
		guielements.rightarrow,
		
		title = {
			text = "Recording Menu",
			x = interactivegui.boxxlength/2 - 28,
			y = 1,
		},
		{
			text = "Don't Loop",
			x = 25,
			y = 30,
			info = {
				"Controls whether or not playback loops until you press play again",
			},
			olcolour = "black",
			func =	function()
						recording.loop = not recording.loop
					end,
			autofunc = 	function(this)
							if recording.loop then
								this.text = "Loop"
								this.x = 49
							else
								this.text = "Don't Loop"
								this.x = 25
							end
						end,
		},
		{
			text = "Slot ",
			x = 41,
			y = 45,
			olcolour = "black",
			func = 		function()
							local rf = function(n) return function() recording.recordingslot = n CIG(3, 3) end end
							local af = function(n) return
								function(this)
									if recording[n][1] then -- if something is in the slot 
										this.textcolour = "yellow"
									else
										this.textcolour = "white"
									end
								end
							end
							
							guipages.temp = createPopUpMenu(guipages[3], rf, nil, af, nil, 72, 25, 5)
							CIG("temp", recording.recordingslot) 
						end,
			autofunc = 	function(this) -- calls every frame this is visible
							this.text = "Slot "..recording.recordingslot
						end,
			info = {
				"Set the current recording slot",
			},
		},
		{
			text = "Don't Randomise",
			x = 5,
			y = 60,
			info = {
				"Random playback between all slots that have been recorded into",
			},
			olcolour = "black",
			func =	function()
						recording.randomise = not recording.randomise
					end,
			autofunc = 	function(this)
							if recording.randomise then
								this.text = "Randomise"
								this.x = 29
							else
								this.text = "Don't Randomise"
								this.x = 5
							end
						end,
		},
		{
			text = "Snipping Replays",
			x = 5,
			y = 75,
			olcolour = "black",
			info = {
				"Controls whether there's a space at the start or end of replays",
			},
			func = 	function()
						if recording.skiptostart and recording.skiptofinish then
							changeConfig("recording","skiptostart", false, recording) -- turn both off
							changeConfig("recording","skiptofinish", false, recording)
						elseif not recording.skiptostart and not recording.skiptofinish then
							changeConfig("recording","skiptostart", true, recording)-- turn skiptostart on
						elseif recording.skiptostart and not recording.skiptofinish then
							changeConfig("recording","skiptostart", false, recording)--turn skiptostart off and skiptofinish on
							changeConfig("recording","skiptofinish", true, recording)
						else
							changeConfig("recording","skiptostart", true, recording) -- turn both on
							changeConfig("recording","skiptofinish", true, recording)
						end
					end,
			autofunc = 	function(this)
							if recording.skiptostart and recording.skiptofinish then
								this.text = "Skip start & end"
								this.x = 1
							elseif recording.skiptostart then
								this.text = "Skip start"
								this.x = 25
							elseif recording.skiptofinish then
								this.text = "Skip end"
								this.x = 33
							else
								this.text = "Snipping Replays"
								this.x = 1
							end
						end,
		},
	},
	setdirectionp2 = {
		guielements.p2hold.none,
		guielements.p2hold.up,
		guielements.p2hold.upright,
		guielements.p2hold.right,
		guielements.p2hold.downright,
		guielements.p2hold.down,
		guielements.p2hold.downleft,
		guielements.p2hold.left,
		guielements.p2hold.upleft,
		
		left = guielements.falseleftarrow,
		right = guielements.falserightarrow,
		button = {
			text = "Set the direction P2 is holding",
			x = 12,
			y = 70,
		},
	},
	scrollingtextsettings = {
		title = {
			text = "Scrolling Input Settings",
			x = interactivegui.boxxlength/2 - 48,
			y = 1,
		},
		{
			text = "<",
			olcolour = "black",
			info = {
				"Back",
			},
			func =	function() CIG(1,3) end,
		},
		{
			text = "Set the state of the scrolling input",
			x = 76,
			y = 50,
			info = {
				"Controls which player inputs are displayed",
			},
			olcolour = "black",
			func = 	function()
						local Elements = {
							{text = "P1 inputs"},
							{text = "P2 inputs"},
							{text = "P1 & P2 inputs"},
							{text = "Off"},
						}
						local rf = function(n) return function()
							changeConfig("inputs","state",n,inputs.properties.scrollinginput)
							scrollingInputReload()
							CIG("scrollingtextsettings",2)
						end end
						guipages.temp = createPopUpMenu(guipages.scrollingtextsettings, rf, nil, nil, Elements, 120, 30, nil)
						CIG("temp", inputs.properties.scrollinginput.state)
					end,
			autofunc =	function(this)
						local state = inputs.properties.scrollinginput.state
						if state == 1 then
							this.text = "P1 inputs"
							this.x = 76
						elseif state == 2 then
							this.text = "P2 inputs"
							this.x = 76
						elseif state == 3 then
							this.text = "P1 & P2 inputs"
							this.x = 56
						else
							this.text = "Off"
							this.x = 100
						end
					end,
		},
		{
			text = "Scrolling input text size ",
			x = 4,
			y = 70,
			info = {
				"Sets the size of the scrolling input text images",
			},
			fillpercent = 0,
			olcolour = "black",
			func = 		function() -- generate a new page and switch to it
							local rf = function() return function() CIG("scrollingtextsettings", 2) end end
							local sf = function(n) return function() changeConfig("inputs", "iconsize", n+7, inputs.properties.scrollinginput) scrollingInputReload() end end
							guipages.temp = createPopUpMenu(guipages.scrollingtextsettings, rf, sf, nil, nil, 120, 10, 13)
							CIG("temp", inputs.properties.scrollinginput.iconsize-7)
						end,
			autofunc = 	function(this)
							this.text = "Scrolling input text size "..(inputs.properties.scrollinginput.iconsize-7)
							this.fillpercent = (inputs.properties.scrollinginput.iconsize-8)/12
						end,
		},
		guielements.scrollinginputframestoggle,
	},
	hitboxsettings = {
		title = {
			text = "Hitbox Settings",
			x = interactivegui.boxxlength/2 - 28,
			y = 1,
		},
		{
			text = "<",
			olcolour = "black",
			info = {
				"Back",
			},
			func =	function() CIG(1,3) end,
		},
		guielements.hitboxstate,
	},
}

if modulevars.p1.constants.maxmeter and availablefunctions.readplayeronemeter and availablefunctions.writeplayeronemeter and availablefunctions.playertwoinhitstun then
	table.insert(guipages[1], guielements.p1meter)
elseif modulevars.p1.constants.maxmeter and availablefunctions.readplayeronemeter and availablefunctions.writeplayeronemeter then
	table.insert(guipages[1], guielements.p1meterlesser)
end

if inputDisplayReg then -- if input-display.lua is loaded
	table.insert(guipages[1], guielements.simpledisplaytoggle)
end

if scrollingInputReg then -- if scrolling-input-display.lua is loaded
	table.insert(guipages[1], guielements.scrollinginputsettings)
end

if hitboxesReg then -- if a hitbox file is loaded
	table.insert(guipages[1], guielements.hitboxsettings)
end

if availablefunctions.writeplayertwohealth and modulevars.p2.constants.maxhealth then -- if input-display.lua is loaded
	table.insert(guipages[2], guielements.instanthealthrefill)
end

if availablefunctions.playertwofacingleft then
	table.insert(guipages[3], guielements.replayautoturn)
end

if availablefunctions.readplayertwohealth and availablefunctions.playertwoinhitstun then
	table.insert(guipages[3], guielements.hitplayback.main)
end

if fexists("games/"..dirname.."/guipages.lua") then
	dofile("games/"..dirname.."/guipages.lua")
	table.insert(guipages, guicustompage)
end
