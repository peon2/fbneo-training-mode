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
					if not combovars.p1.refillmeterenabled then
						changeConfig("p1", "refillmeterenabled", true, combovars.p1) 
						changeConfig("p1", "instantrefillmeter", true, combovars.p1) 
					elseif combovars.p1.refillmeterenabled and combovars.p1.instantrefillmeter then
						changeConfig("p1", "instantrefillmeter", false, combovars.p1) 
					else
						changeConfig("p1", "refillmeterenabled", false, combovars.p1) 
					end
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
		func = 	function()
					changeInteractiveGuiPage("scrollingtextsettings")
					changeInteractiveGuiSelection(2)
				end,
	},
	scrollinginputsize = {
		main = {
			text = "Scrolling input text size ",
			x = 4,
			y = 70,
			info = {
				"Sets the size of the scrolling input text images",
			},
			olcolour = "black",
			func = 		function()
							changeInteractiveGuiPage("scrollinginputsize")
							changeInteractiveGuiSelection(inputs.properties.scrollinginput.iconsize-7)
						end,
			autofunc = 	function(this)
							this.text = "Scrolling input text size "..(inputs.properties.scrollinginput.iconsize-7)
						end,
		},
		{
			text = "1",
			x = 108,
			y = 10,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 8, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "2",
			x = 108,
			y = 20,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 9, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "3",
			x = 108,
			y = 30,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 10, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "4",
			x = 108,
			y = 40,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 11, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "5",
			x = 108,
			y = 50,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 12, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "6",
			x = 108,
			y = 60,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 13, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "7",
			x = 108,
			y = 70,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 14, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "8",
			x = 108,
			y = 80,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 15, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "9",
			x = 108,
			y = 90,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 16, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "10",
			x = 108,
			y = 100,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 17, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "11",
			x = 108,
			y = 110,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 18, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "12",
			x = 108,
			y = 120,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 19, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
		{
			text = "13",
			x = 108,
			y = 130,
			func =	function()
						changeInteractiveGuiPage("scrollingtextsettings")
						changeInteractiveGuiSelection(2)
					end,
			selectfunc =	function()
								changeConfig("inputs", "iconsize", 20, inputs.properties.scrollinginput)
								scrollingInputReload()
							end,
		},
	},
	scrollinginputstate = {
		text = "Set the state of the scrolling input",
		x = 76,
		y = 50,
		info = {
			"Controls which player inputs are displayed",
		},
		olcolour = "black",
		func = 	function()
					if inputs.properties.scrollinginput.state+1 < 5 then
						inputs.properties.scrollinginput.state = inputs.properties.scrollinginput.state+1
						changeConfig("inputs","state",inputs.properties.scrollinginput.state)
						scrollingInputReload()
					else
						inputs.properties.scrollinginput.state = 1
						changeConfig("inputs","state",inputs.properties.scrollinginput.state)
						scrollingInputReload()
					end
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
		main = {
			text = "Coin leniency",
			x = 64,
			y = 30,
			olcolour = "black",
			info = {
				"This controls how many frames you have between each coin input",
				"10 frames allows for faster usage",
				"but 15 might be easier for slow fingers",
			},
			func = 		function()
							changeInteractiveGuiPage("coininputleniency")
							changeInteractiveGuiSelection(inputs.properties.coinleniency - 9)
						end,
			autofunc = 	function(this)
							this.text = "Coin leniency "..(inputs.properties.coinleniency)
						end,
		},
		{
			text = "10",
			x = 120,
			y = 30,
			func =	function()
						changeInteractiveGuiPage(1)
						changeInteractiveGuiSelection(3)
						changeConfig("inputs", "coinleniency", 10, inputs.properties)
					end,
		},
		{
			text = "11",
			x = 120,
			y = 40,
			func =	function()
						changeInteractiveGuiPage(1)
						changeInteractiveGuiSelection(3)
						changeConfig("inputs", "coinleniency", 11, inputs.properties)
					end,
		},
		{
			text = "12",
			x = 120,
			y = 50,
			func =	function()
						changeInteractiveGuiPage(1)
						changeInteractiveGuiSelection(3)
						changeConfig("inputs", "coinleniency", 12, inputs.properties)
					end,
		},
		{
			text = "13",
			x = 120,
			y = 60,
			func =	function()
						changeInteractiveGuiPage(1)
						changeInteractiveGuiSelection(3)
						changeConfig("inputs", "coinleniency", 13, inputs.properties)
					end,
		},
		{
			text = "14",
			x = 120,
			y = 70,
			func =	function()
						changeInteractiveGuiPage(1)
						changeInteractiveGuiSelection(3)
						changeConfig("inputs", "coinleniency", 14, inputs.properties)
					end,
		},
		{
			text = "15",
			x = 120,
			y = 80,
			func =	function()
						changeInteractiveGuiPage(1)
						changeInteractiveGuiSelection(3)
						changeConfig("inputs", "coinleniency", 15, inputs.properties)
					end,
		},
	},
	slotselection = {
		title = {
			text = "Recording Menu",
			x = interactivegui.boxxlength/2 - 28,
			y = 1,
		},
		slotselection = {
			text = "Slot",
			x = 41,
			y = 45,
		},
		{
			text = "1",
			x = 61,
			y = 25,
			func = 	function()
				recording.recordingslot = 1
				changeInteractiveGuiPage(3)
				changeInteractiveGuiSelection(3)
			end,
			autofunc =	function(this)
							if recording[1][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
		{
			text = "2",
			x = 61,
			y = 35,
			func = 	function()
				recording.recordingslot = 2
				changeInteractiveGuiPage(3)
				changeInteractiveGuiSelection(3)
			end,
			autofunc =	function(this)
							if recording[2][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
		{
			text = "3",
			x = 61,
			y = 45,
			func = 	function()
				recording.recordingslot = 3
				changeInteractiveGuiPage(3)
				changeInteractiveGuiSelection(3)
			end,
			autofunc =	function(this)
							if recording[3][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
		{
			text = "4",
			x = 61,
			y = 55,
			func = 	function()
				recording.recordingslot = 4
				changeInteractiveGuiPage(3)
				changeInteractiveGuiSelection(3)
			end,
			autofunc =	function(this)
							if recording[4][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
		{
			text = "5",
			x = 61,
			y = 65,
			func = 	function()
				recording.recordingslot = 5
				changeInteractiveGuiPage(3)
				changeInteractiveGuiSelection(3)
			end,
			autofunc =	function(this)
							if recording[5][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
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
			func = 	function()
						changeInteractiveGuiPage("hitplayback")
						changeInteractiveGuiSelection(1)
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
		{
			text = "None",
			x = 61,
			y = 75,
			func = 	function()
						recording.hitslot = nil
						changeInteractiveGuiPage(3)
						changeInteractiveGuiSelection(3)
					end,
		},
		{
			text = "1",
			x = 61,
			y = 85,
			func = 	function()
						recording.hitslot = 1
						changeInteractiveGuiPage(3)
						changeInteractiveGuiSelection(3)
					end,
			autofunc =	function(this)
							if recording[1][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
		{
			text = "2",
			x = 61,
			y = 95,
			func = 	function()
						recording.hitslot = 2
						changeInteractiveGuiPage(3)
						changeInteractiveGuiSelection(3)
					end,
			autofunc =	function(this)
							if recording[2][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
		{
			text = "3",
			x = 61,
			y = 105,
			func = 	function()
						recording.hitslot = 3
						changeInteractiveGuiPage(3)
						changeInteractiveGuiSelection(3)
					end,
			autofunc =	function(this)
							if recording[3][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
		{
			text = "4",
			x = 61,
			y = 115,
			func = 	function()
						recording.hitslot = 4
						changeInteractiveGuiPage(3)
						changeInteractiveGuiSelection(3)
					end,
			autofunc =	function(this)
							if recording[4][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
		{
			text = "5",
			x = 61,
			y = 125,
			func = 	function()
						recording.hitslot = 5
						changeInteractiveGuiPage(3)
						changeInteractiveGuiSelection(3)
					end,
			autofunc =	function(this)
							if recording[5][1] then -- if something is in the slot 
								this.textcolour = "yellow"
							else
								this.textcolour = "white"
							end
						end,
		},
	},
	hitboxsettings = {
		text = "Change hitbox settings",
		x = 40,
		y = 110,
		olcolour = "black",
		func = 	function()
					changeInteractiveGuiPage("hitboxsettings")
					changeInteractiveGuiSelection(2)
				end,
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
		guielements.coininputleniency.main,
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
			func = function() interactivegui.selection = 1 changeInteractiveGuiPage("setdirectionp2") end,
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
			func = 	function()
				changeInteractiveGuiPage("slotselection")
				changeInteractiveGuiSelection(recording.recordingslot)
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
	slotselection = { -- move these into guielements
		left = guielements.falseleftarrow,
		right = guielements.falserightarrow,
		title = guielements.slotselection.title,
		text = guielements.slotselection.slotselection,
		guielements.slotselection[1],
		guielements.slotselection[2],
		guielements.slotselection[3],
		guielements.slotselection[4],
		guielements.slotselection[5],
	},
	coininputleniency = {
		main = {
			text = "Coin leniency",
			x = 64,
			y = 30,
		},
		guielements.coininputleniency[1],
		guielements.coininputleniency[2],
		guielements.coininputleniency[3],
		guielements.coininputleniency[4],
		guielements.coininputleniency[5],
		guielements.coininputleniency[6],
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
			func =	function()
						changeInteractiveGuiPage(1)
						changeInteractiveGuiSelection(3)
					end,
		},
		guielements.scrollinginputstate,
		guielements.scrollinginputsize.main,
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
			func =	function()
						changeInteractiveGuiPage(1)
						changeInteractiveGuiSelection(3)
					end,
		},
		guielements.hitboxstate,
	},
	scrollinginputsize = {
		left = guielements.falseleftarrow,
		right = guielements.falserightarrow,
		title = {
			text = "Basic Settings",
			x = interactivegui.boxxlength/2 - 28,
			y = 1,
		},
		main = {
			text = "Scrolling input text size",
			x = 4,
			y = 70,
		},
		guielements.scrollinginputsize[1],
		guielements.scrollinginputsize[2],
		guielements.scrollinginputsize[3],
		guielements.scrollinginputsize[4],
		guielements.scrollinginputsize[5],
		guielements.scrollinginputsize[6],
		guielements.scrollinginputsize[7],
		guielements.scrollinginputsize[8],
		guielements.scrollinginputsize[9],
		guielements.scrollinginputsize[10],
		guielements.scrollinginputsize[11],
		guielements.scrollinginputsize[12],
		guielements.scrollinginputsize[13],
	},
	hitplayback = {
		left = guielements.falseleftarrow,
		right = guielements.falserightarrow,
		guielements.hitplayback[1],
		guielements.hitplayback[2],
		guielements.hitplayback[3],
		guielements.hitplayback[4],
		guielements.hitplayback[5],
		guielements.hitplayback[6],
		title = {
			text = "Hit Slot",
			x = 25,
			y = 105,
		},
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
