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
	p1health = {
		text = "Health settings",
		x = 40,
		y = 25,
		olcolour = "black",
		info = {
			"Controls how P1 health is handled",
		},
		func = 	function()
					CIG("p1health", inputs.properties.scrollinginput.state)			-- SHOULDNT BE LIKE THIS???
				end,
		autofunc = 	function(this)
						if not combovars.p1.refillhealthenabled then
							this.text = "No Health Refill"
							this.x = 136-#this.text*4
						elseif combovars.p1.refillhealthenabled and combovars.p1.instantrefillhealth then
							this.text = "Health Always Full"
							this.x = 136-#this.text*4
						else
							this.text = "Fill Health after Combo"
							this.x = 136-#this.text*4
						end
					end,
	},
	p1healthmax = {
		text = "Max Health",
		x = 80,
		y = 40,
		fillpercent = 0,
		olcolour = "black",
		info = {
			"Controls how much health P1 gains",
		},
		func = 		function()
						CIG("p1maxhealth")
					end,
		autofunc = 	function(this)
						this.text = "Max Health: "..modulevars.p1.maxhealth
						this.x = 136-#this.text*4
						this.fillpercent = modulevars.p1.maxhealth/modulevars.p1.constants.maxhealth
					end,
	},
	p1meter = {
		text = "Meter settings",
		x = 40,
		y = 55,
		olcolour = "black",
		info = {
			"Controls how P1 meter is handled",
		},
		func = 	function()
					CIG("p1meter", inputs.properties.scrollinginput.state)
				end,
		autofunc = 	function(this)
						if not combovars.p1.refillmeterenabled then
							this.text = "No Meter Refill"
							this.x = 136-#this.text*4
						elseif combovars.p1.refillmeterenabled and combovars.p1.instantrefillmeter then
							this.text = "Meter Always Full"
							this.x = 136-#this.text*4
						else
							this.text = "Fill Meter after Combo"
							this.x = 136-#this.text*4
						end
					end,
	},
	p1metermax = {
		text = "Max Meter",
		x = 80,
		y = 70,
		fillpercent = 0,
		olcolour = "black",
		info = {
			"Controls how much meter P1 gains",
		},
		func = 		function()
						CIG("p1maxmeter")
					end,
		autofunc = 	function(this)
						this.text = "Max Meter: "..modulevars.p1.maxmeter
						this.x = 136-#this.text*4
						this.fillpercent = modulevars.p1.maxmeter/modulevars.p1.constants.maxmeter
					end,
	},
	p2health = {
		text = "Health settings",
		x = 40,
		y = 105,
		olcolour = "black",
		info = {
			"Controls how P2 health is handled",
		},
		func = 	function()
					CIG("p2health", inputs.properties.scrollinginput.state)
				end,
		autofunc = 	function(this)
						if not combovars.p2.refillhealthenabled then
							this.text = "No Health Refill"
							this.x = 136-#this.text*4
						elseif combovars.p2.refillhealthenabled and combovars.p2.instantrefillhealth then
							this.text = "Health Always Full"
							this.x = 136-#this.text*4
						else
							this.text = "Fill Health after Combo"
							this.x = 136-#this.text*4
						end
					end,
	},
	p2healthmax = {
		text = "Max Health",
		x = 80,
		y = 120,
		fillpercent = 0,
		olcolour = "black",
		info = {
			"Controls how much health P2 gains",
		},
		func = 		function()
						CIG("p2healthmax")
					end,
		autofunc = 	function(this)
						this.text = "Max Health: "..modulevars.p2.maxhealth
						this.x = 136-#this.text*4
						this.fillpercent = modulevars.p2.maxhealth/modulevars.p2.constants.maxhealth
					end,
	},
	p2meter = {
		text = "Meter settings",
		x = 40,
		y = 135,
		olcolour = "black",
		info = {
			"Controls how P2 meter is handled",
		},
		func = 	function()
					CIG("p2meter", inputs.properties.scrollinginput.state)
				end,
		autofunc = 	function(this)
						if not combovars.p2.refillmeterenabled then
							this.text = "No Meter Refill"
							this.x = 136-#this.text*4
						elseif combovars.p2.refillmeterenabled and combovars.p2.instantrefillmeter then
							this.text = "Meter Always Full"
							this.x = 136-#this.text*4
						else
							this.text = "Fill Meter after Combo"
							this.x = 136-#this.text*4
						end
					end,
	},
	p2metermax = {
		text = "Max Meter",
		x = 80,
		y = 150,
		fillpercent = 0,
		olcolour = "black",
		info = {
			"Controls how much meter P2 gains",
		},
		func = 		function()
						CIG("p2metermax")
					end,
		autofunc = 	function(this)
						this.text = "Max Meter: "..modulevars.p2.maxmeter
						this.x = 136-#this.text*4
						this.fillpercent = modulevars.p2.maxmeter/modulevars.p2.constants.maxmeter
					end,
	},
	simpledisplaytoggle = {
		text = "Simple input display on",
		x = 36,
		y = 45,
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
		y = 60,
		olcolour = "black",
		info = {
			"Change scrolling input settings",
		},
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
		y = 105,
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
	hudsettings = {
		text = "HUD Settings",
		x = 80,
		y = 15,
		olcolour = "black",
		info = {
			"Move and hide parts of the HUD",
		},
		func = 	function()
					toggleMoveHUD(true)
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
						CIG("coininputleniency", inputs.properties.coinleniency-9)
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
			y = 120,
			olcolour = "black",
			info = {
				"Plays back the respective replay slot after hit",
			},
			func = 		function()
							if recording.hitslot then
								CIG("hitslot", recording.hitslot)
							else
								CIG("hitslot", 6)
							end
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
	replayeditortoggle = {
		text = "Replay Editor",
		x = 13,
		y = 135,
		olcolour = "black",
		info = {
			"View and set replay inputs",
		},
		func = 	function() toggleReplayEditor() end,
	},
	hitboxsettings = {
		text = "Change hitbox settings",
		x = 40,
		y = 75,
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
		guielements.hudsettings,
		guielements.coininputleniency,
	},
	{ -- Players
		title = {
			text = "Player Settings",
			x = interactivegui.boxxlength/2 - 30,
			y = 1,
		},
		guielements.leftarrow,
		guielements.rightarrow,
		p1 = {
			text = "P1",
			x = 2,
			y = 15,
		},
		p2 = {
			text = "P2",
			x = 2,
			y = 95,
		},
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
				"Allows you to set the direction P2 is holding",
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
							str = str:sub(1, #str-1)
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
							CIG("recordingslot", recording.recordingslot) 
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
			text = "Snipping Replays", -- clean this up in future
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
		{
			text = "Player Recording",
			x = 5,
			y = 90,
			olcolour = "black",
			info = {
				"Controls which player(s) are recorded and played back",
			},
			func = 	function()
						CIG("playerrecording", 2)
					end,
			autofunc = 	function(this)
							if recording.replayP1 and recording.replayP2 then
								this.text = "Replay P1 and P2"
							elseif recording.replayP1 then
								this.text = "Replay P1"
							elseif recording.replayP2 then
								this.text = "Replay P2"
							end
							this.x = 65 - #this.text*4
						end,
		},
		other_func = drawReplayInfo
	},
	setdirectionp2 = {
		left = guielements.falseleftarrow,
		right = guielements.falserightarrow,
		title = {
			text = "Dummy Settings",
			x = interactivegui.boxxlength/2 - 30,
			y = 1,
		},
		button = {
			text = "Set the direction P2 is holding",
			x = 12,
			y = 70,
		},
		{
			text = "",
			x = -200, -- should be 'invisible'
			y = -200,
			func = 		function()
							local a = function(b) if b then return 1 end return 0 end -- bool to num
							local dir = 5+a(guiinputs.P1["up"])*3 + a(guiinputs.P1["left"])*-1 + a(guiinputs.P1["right"])*1 + a(guiinputs.P1["down"])*-3
							setDirection(2, dir)
							CIG(interactivegui.previouspage, interactivegui.previousselection)
						end,
			autofunc = 	function() displayStick(interactivegui.boxx + 140, interactivegui.boxy + 55) end,
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
			text = "Scrolling input text size ",
			x = 4,
			y = 70,
			info = {
				"Sets the size of the scrolling input text images",
			},
			fillpercent = 0,
			olcolour = "black",
			func = 		function()
							CIG("scrollingtextsettingssizepopup", inputs.properties.scrollinginput.iconsize-7)
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

if inputDisplayReg then -- if input-display.lua is loaded
	table.insert(guipages[1], guielements.simpledisplaytoggle)
end

if scrollingInputReg then -- if scrolling-input-display.lua is loaded
	table.insert(guipages[1], guielements.scrollinginputsettings)
end

if hitboxesReg then -- if a hitbox file is loaded
	table.insert(guipages[1], guielements.hitboxsettings)
end

-- if health is set up in file
if availablefunctions.writeplayeronehealth and modulevars.p1.constants.maxhealth then -- if health is set up in file
	table.insert(guipages[2], guielements.p1health)
	table.insert(guipages[2], guielements.p1healthmax)
end

-- if meter is set up in file
if modulevars.p1.constants.maxmeter and availablefunctions.readplayeronemeter and availablefunctions.writeplayeronemeter then
	table.insert(guipages[2], guielements.p1meter)
	table.insert(guipages[2], guielements.p1metermax)
end

if availablefunctions.writeplayertwohealth and modulevars.p2.constants.maxhealth then -- if health is set up in file
	table.insert(guipages[2], guielements.p2health)
	table.insert(guipages[2], guielements.p2healthmax)
end

if modulevars.p2.constants.maxmeter and availablefunctions.readplayertwometer and availablefunctions.writeplayertwometer then
	table.insert(guipages[2], guielements.p2meter)
	table.insert(guipages[2], guielements.p2metermax)
end

if availablefunctions.playertwofacingleft then
	table.insert(guipages[4], guielements.replayautoturn)
end

if availablefunctions.readplayertwohealth and availablefunctions.playertwoinhitstun then
	table.insert(guipages[4], guielements.hitplayback.main)
end

if modulevars.constants.translationtable then -- replay editor
	table.insert(guipages[4], guielements.replayeditortoggle)
end


if fexists("games/"..dirname.."/guipages.lua") then
	dofile("games/"..dirname.."/guipages.lua")
	table.insert(guipages, guicustompage)
end

-- pop up menus and stuff that can be pre-computed
if availablefunctions.writeplayeronehealth and modulevars.p1.constants.maxhealth then -- p1health
	local Elements = {
		{text = "No Health Refill", selectfunc = function() return function() changeConfig("p1", "refillhealthenabled", false, combovars.p1) end end},
		{text = "Health Always Full", selectfunc = function() return
			function()
				changeConfig("p1", "refillhealthenabled", true, combovars.p1)
				changeConfig("p1", "instantrefillhealth", true, combovars.p1)
			end
		end},
	}
	if availablefunctions.playeroneinhitstun then -- won't always be available
		Elements[3] = 	{text = "Fill Health after Combo", selectfunc = function() return
			function()
				changeConfig("p1", "refillhealthenabled", true, combovars.p1)
				changeConfig("p1", "instantrefillhealth", false, combovars.p1)
			end
		end}
	end
	guipages.p1health = createPopUpMenu(guipages[2], nil, nil, nil, Elements, 144, 25, nil)
end

if availablefunctions.writeplayeronehealth and modulevars.p1.constants.maxhealth then -- p1maxhealth
	local uf = 	function(n) 
		if n then
			modulevars.p1.maxhealth = modulevars.p1.maxhealth+n
		end
		return modulevars.p1.maxhealth
	end
	guipages.p1maxhealth = createScrollingBar(guipages[2], 145, 40, 1, modulevars.p1.constants.maxhealth, uf, interactivegui.boxxlength/2)
end

if modulevars.p1.constants.maxmeter and availablefunctions.readplayeronemeter and availablefunctions.writeplayeronemeter then -- p1meter
	local Elements = {
		{text = "No Meter Refill", selectfunc = function() return function() changeConfig("p1", "refillmeterenabled", false, combovars.p1) end end},
		{text = "Meter Always Full", selectfunc = function() return
			function()
				changeConfig("p1", "refillmeterenabled", true, combovars.p1)
				changeConfig("p1", "instantrefillmeter", true, combovars.p1)
			end
		end},
	}
	if availablefunctions.playertwoinhitstun then -- won't always be available
		Elements[3] = 	{text = "Fill Meter after Combo", selectfunc = function() return
			function()
				changeConfig("p1", "refillmeterenabled", true, combovars.p1)
				changeConfig("p1", "instantrefillmeter", false, combovars.p1)
			end
		end}
	end
	guipages.p1meter = createPopUpMenu(guipages[2], nil, nil, nil, Elements, 144, 55, nil)
end

if modulevars.p1.constants.maxmeter and availablefunctions.readplayeronemeter and availablefunctions.writeplayeronemeter then-- p1maxmeter
	local uf = 	function(n) 
		if n then
			modulevars.p1.maxmeter = modulevars.p1.maxmeter+n
		end
		return modulevars.p1.maxmeter
	end
	guipages.p1maxmeter = createScrollingBar(guipages[2], 144, 70, 0, modulevars.p1.constants.maxmeter, uf, interactivegui.boxxlength/2-4)
end

if availablefunctions.writeplayertwohealth and modulevars.p2.constants.maxhealth then-- p2health
	local Elements = {
		{text = "No Health Refill", selectfunc = function() return function() changeConfig("p2", "refillhealthenabled", false, combovars.p2) end end},
		{text = "Health Always Full", selectfunc = function() return
			function()
				changeConfig("p2", "refillhealthenabled", true, combovars.p2)
				changeConfig("p2", "instantrefillhealth", true, combovars.p2)
			end
		end},
	}
	if availablefunctions.playertwoinhitstun then -- won't always be available
		Elements[3] = 	{text = "Fill Health after Combo", selectfunc = function() return
			function()
				changeConfig("p2", "refillhealthenabled", true, combovars.p2)
				changeConfig("p2", "instantrefillhealth", false, combovars.p2)
			end
		end}
	end
	guipages.p2health = createPopUpMenu(guipages[2], nil, nil, nil, Elements, 144, 105, nil)
end

if availablefunctions.writeplayertwohealth and modulevars.p2.constants.maxhealth then-- p2healthmax
	local uf = 	function(n) 
		if n then
			modulevars.p2.maxhealth = modulevars.p2.maxhealth+n
		end
		return modulevars.p2.maxhealth
	end
	guipages.p2healthmax = createScrollingBar(guipages[2], 145, 120, 1, modulevars.p2.constants.maxhealth, uf, interactivegui.boxxlength/2)
end

if modulevars.p2.constants.maxmeter and availablefunctions.readplayertwometer and availablefunctions.writeplayertwometer then-- p2meter
	local Elements = {
		{text = "No Meter Refill", selectfunc = function() return function() changeConfig("p2", "refillmeterenabled", false, combovars.p2) end end},
		{text = "Meter Always Full", selectfunc = function() return
			function()
				changeConfig("p2", "refillmeterenabled", true, combovars.p2)
				changeConfig("p2", "instantrefillmeter", true, combovars.p2)
			end
		end},
	}
	if availablefunctions.playertwoinhitstun then -- won't always be available
		Elements[3] = 	{text = "Fill Meter after Combo", selectfunc = function() return
			function()
				changeConfig("p2", "refillmeterenabled", true, combovars.p2)
				changeConfig("p2", "instantrefillmeter", false, combovars.p2)
			end
		end}
	end
	guipages.p2meter = createPopUpMenu(guipages[2], nil, nil, nil, Elements, 144, 135, nil)
end

if modulevars.p2.constants.maxmeter and availablefunctions.readplayertwometer and availablefunctions.writeplayertwometer then-- p2metermax
	local uf = 	function(n) 
		if n then
			modulevars.p2.maxmeter = modulevars.p2.maxmeter+n
		end
		return modulevars.p2.maxmeter
	end
	guipages.p2metermax = createScrollingBar(guipages[2], 144, 150, 0, modulevars.p2.constants.maxmeter, uf, interactivegui.boxxlength/2)
end


do -- coininputleniency
	local Elements = {
		{text = "10"},
		{text = "11"},
		{text = "12"},
		{text = "13"},
		{text = "14"},
		{text = "15"},
	}
	local sf = function(n) return function() changeConfig("inputs", "coinleniency", n+9, inputs.properties) end end
	guipages.coininputleniency = createPopUpMenu(guipages[1], nil, sf, nil, Elements, 136, 30, nil)
end

if availablefunctions.readplayertwohealth and availablefunctions.playertwoinhitstun then -- hitslot
	local Elements = {
		{},
		{},
		{},
		{},
		{},
		{y = 75, text = "None", releasefunc = function() return function() recording.hitslot = nil CIG(interactivegui.previouspage, interactivegui.previousselection) end end, autofunc = function() end}
	}
	local rf = function(n) return function() recording.hitslot = n CIG(interactivegui.previouspage, interactivegui.previousselection) end end
	local af = function(n) return
	function(this)
		if recording[n][1] then -- if something is in the slot 
			this.textcolour = "yellow"
		else
			this.textcolour = "white"
		end
	end
	end
	guipages.hitslot = createPopUpMenu(guipages[4], rf, nil, af, Elements, 72, 85, nil)
end

do -- recordingslot
	local rf = function(n) return function() recording.recordingslot = n CIG(interactivegui.previouspage, interactivegui.previousselection) end end
	local af = function(n) return
	function(this)
		if recording[n][1] then -- if something is in the slot 
			this.textcolour = "yellow"
		else
			this.textcolour = "white"
		end
	end
	end					
	guipages.recordingslot = createPopUpMenu(guipages[4], rf, nil, af, nil, 72, 25, 5)
end


if scrollingInputReg then -- scrollingtextsettingsinputpopup
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
		end 
	end
	guipages.scrollingtextsettingsinputpopup = createPopUpMenu(guipages.scrollingtextsettings, rf, nil, nil, Elements, 120, 30, nil)
	-- scrollingtextsettingssizepopup
	local rf = function() return function() CIG("scrollingtextsettings", 2) end end
	local sf = function(n) return function() changeConfig("inputs", "iconsize", n+7, inputs.properties.scrollinginput) scrollingInputReload() end end
	guipages.scrollingtextsettingssizepopup = createPopUpMenu(guipages.scrollingtextsettings, rf, sf, nil, nil, 120, 10, 13)
end

local playerrecelements = {
					{text = "P1", selectfunc = function() return function() recording.replayP1=true recording.replayP2=false end end},
					{text = "P2", selectfunc = function() return function() recording.replayP1=false recording.replayP2=true end end},
					{text = "P1&P2", selectfunc = function() return function() recording.replayP1=true recording.replayP2=true end end},
				}
guipages.playerrecording = createPopUpMenu(guipages[4], nil, nil, nil, playerrecelements, 144, 55, nil)