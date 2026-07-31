assert(rb,"Run fbneo-training-mode.lua")

local P1 = {
	text = "P1:",
	x = 2,
	y = 15
}

local guardbreakdata = {
	[garou_guardsettings.OFF] = {
		text = "Off",
		colour = colour.boolfalse
	},
	[garou_guardsettings.ALWAYS] = {
		text = "Always",
		colour = colour.booltrue
	},
	[garou_guardsettings.AFTER_COMBO] = {
		text = "After Combo",
		colour = colour.option2
	}
}

local p1guard = {
	rawtext = "Guard Bar Control: ",
	rawx = interactivegui.boxxhalflength,
	y = P1.y+15,
	olcolour = colour.olcolour,
	info = "Change how the P1 Guard Bar behaves",
	reset = function()
		resetConfig("garouguardstatep1")
	end,
	func = function()
		changePageAndSelection("garouguardstatep1", getConfigValue("garouguardstatep1"))
	end,
	autofunc = function(this)
		local state = getConfigValue("garouguardstatep1")
		this.text = this.rawtext..guardbreakdata[state].text
		this.bgcolour = guardbreakdata[state].colour
		this.x = this.rawx - #this.text*LETTER_WIDTH
	end
}

local p1maxguard = SHIFT(garou_p1maxguard, 8)

local p1guardbar = {
	rawtext = "Guard: %2d",
	x = interactivegui.boxxhalflength+LETTER_WIDTH,
	y = p1guard.y,
	fillpercent = 0,
	olcolour = "black",
	info = "Controls how much guard damage P1 has",
	reset = function()
		resetConfig("garouguardmaxp1")
	end,
	func = function()
		changePageAndSelection("p1guardbar")
	end,
	autofunc = function(this)
		local guardmax = getConfigValue("garouguardmaxp1")
		this.text = string.format(this.rawtext, guardmax)
		this.fillpercent = guardmax/p1maxguard
	end,
}

local p1jd = {
	text = "Force Just Defend",
	x = interactivegui.boxxhalflength-#"Force Just Defend"*LETTER_WIDTH - LETTER_WIDTH,
	y = p1guard.y+15,
	olcolour = "black",
	info = "Toggle if P1 Just Defends every attack",
	canhotkey = true,
	reset = function()
		resetConfig("garouforcejdp1")
	end,
	func = function()
		changeConfig("garouforcejdp1", not getConfigValue("garouforcejdp1"))
	end,
	autofunc = function(this)
		if getConfigValue("garouforcejdp1") then
			this.bgcolour = colour.booltrue
		else
			this.bgcolour = colour.boolfalse
		end
	end
}

local p1counterhit = {
	text = "Force Counter-hit",
	x = interactivegui.boxxhalflength + LETTER_WIDTH,
	inline = true,
	olcolour = "black",
	info = "Toggle if P1 is counterhit",
	canhotkey = true,
	reset = function()
		resetConfig("garouforcecounterp1")
	end,
	func = function()
		changeConfig("garouforcecounterp1", not getConfigValue("garouforcecounterp1"))
	end,
	autofunc = function(this)
		if getConfigValue("garouforcecounterp1") then
			this.bgcolour = colour.booltrue
		else
			this.bgcolour = colour.boolfalse
		end
	end
}

local P2 = {
	text = "P2:",
	x = 2,
	y = 60
}

local p2guard = {
	rawtext = "Guard Bar Control: ",
	rawx = interactivegui.boxxhalflength,
	y = P2.y+15,
	olcolour = colour.olcolour,
	info = "Change how the P2 Guard Bar behaves",
	reset = function()
		resetConfig("garouguardstatep2")
	end,
	func = function()
		changePageAndSelection("garouguardstatep2", getConfigValue("garouguardstatep2"))
	end,
	autofunc = function(this)
		local state = getConfigValue("garouguardstatep2")
		this.text = this.rawtext..guardbreakdata[state].text
		this.bgcolour = guardbreakdata[state].colour
		this.x = this.rawx - #this.text*LETTER_WIDTH
	end
}

local p2maxguard = SHIFT(garou_p2maxguard, 8)

local p2guardbar = {
	rawtext = "Guard: %2d",
	x = interactivegui.boxxhalflength+LETTER_WIDTH,
	y = p2guard.y,
	fillpercent = 0,
	olcolour = "black",
	info = "Controls how much guard damage P2 has",
	reset = function()
		resetConfig("garouguardmaxp2")
	end,
	func = function()
		changePageAndSelection("p2guardbar")
	end,
	autofunc = function(this)
		local guardmax = getConfigValue("garouguardmaxp2")
		this.text = string.format(this.rawtext, guardmax)
		this.fillpercent = guardmax/p2maxguard
	end,
}

local p2jd = {
	text = "Force Just Defend",
	x = interactivegui.boxxhalflength-#"Force Just Defend"*LETTER_WIDTH - LETTER_WIDTH,
	y = p2guard.y+15,
	olcolour = "black",
	info = "Toggle if P2 Just Defends every attack",
	canhotkey = true,
	reset = function()
		resetConfig("garouforcejdp2")
	end,
	func = function()
		changeConfig("garouforcejdp2", not getConfigValue("garouforcejdp2"))
	end,
	autofunc = function(this)
		if getConfigValue("garouforcejdp2") then
			this.bgcolour = colour.booltrue
		else
			this.bgcolour = colour.boolfalse
		end
	end
}

local p2counterhit = {
	text = "Force Counter-hit",
	x = interactivegui.boxxhalflength + LETTER_HALFWIDTH,
	inline = true,
	olcolour = "black",
	info = "Toggle if P2 is counterhit",
	canhotkey = true,
	reset = function()
		resetConfig("garouforcecounterp2")
	end,
	func = function()
		changeConfig("garouforcecounterp2", not getConfigValue("garouforcecounterp2"))
	end,
	autofunc = function(this)
		if getConfigValue("garouforcecounterp2") then
			this.bgcolour = colour.booltrue
		else
			this.bgcolour = colour.boolfalse
		end
	end
}

local guardcancelplayback = {
	rawtext = "Guard Cancel",
	rawx = interactivegui.boxxhalflength,
	y = p2jd.y+15,
	olcolour = colour.olcolour,
	info = "Plays back the respective replay slot as a Guard Cancel",
	func = function()
		local guardcancelslot = getConfigValue("garouguardcancelslot")
		if guardcancelslot then
			changePageAndSelection("garouguardcancelslot", guardcancelslot+1)
		else
			changePageAndSelection("garouguardcancelslot", REPLAY_SLOTS_COUNT+1)
		end
	end,
	autofunc = function(this)
		local guardcancelslot = getConfigValue("garouguardcancelslot")
		if guardcancelslot == 0 then
			this.text = this.rawtext
			this.bgcolour = nil
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		else
			this.text = this.rawtext.." "..guardcancelslot
			this.bgcolour = colour.option2
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		end
	end
}

local jdbar = {
	text = "Toggle JD Indicator",
	x = interactivegui.boxxhalflength-#"Toggle JD Indicator"*LETTER_HALFWIDTH,
	y = 130,
	olcolour = "black",
	info = "Toggle if the JD indicator shows while defending",
	canhotkey = true,
	reset = function()
		resetConfig("garoujdbarenabled")
	end,
	func = function()
		changeConfig("garoujdbarenabled", not getConfigValue("garoujdbarenabled"))
	end,
	autofunc = function(this)
		if getConfigValue("garoujdbarenabled") then
			this.bgcolour = colour.booltrue
		else
			this.bgcolour = colour.boolfalse
		end
	end
}

local reversalwindow = {
	rawtext = "Reversal Window %2d",
	x = interactivegui.boxxhalflength-40-#"Reversal Window"*LETTER_HALFWIDTH,
	y = jdbar.y+15,
	olcolour = "black",
	info = "Set the number of frames from neutral to start inputting a reversal while being Hit, Blocking, or JDing",
	reset = function()
		resetConfig("garoureversalwindow")
	end,
	func = function()
		changePageAndSelection("garoureversalwindow", getConfigValue("garoureversalwindow"))
	end,
	autofunc = function(this)
		local reversal = getConfigValue("garoureversalwindow")
		this.text = string.format(this.rawtext, reversal)
		this.fillpercent = reversal/12 -- 12 is the max for lights(?)
	end
}

local wakeupwindow = {
	rawtext = "Wakeup Window %2d",
	x = interactivegui.boxxhalflength+40-#"Wakeup Window"*LETTER_HALFWIDTH,
	inline = true,
	olcolour = "black",
	info = "Set the number of frames from neutral to start inputting a reversal when rising from a knockdown",
	reset = function()
		changeConfig("garouwakeupwindow", garou_resetreversalwindow())
	end,
	func = function()
		changePageAndSelection("garouwakeupwindow", getConfigValue("garouwakeupwindow"))
	end,
	autofunc = function(this)
		local wakeup = getConfigValue("garouwakeupwindow")
		this.text = string.format(this.rawtext, wakeup)
		this.fillpercent = wakeup/12 -- 12 is the max for Kain
	end
}

guicustompage = {
	title = {
		text = "Garou: Mark of the Wolves Settings"
	},
	P1 = P1,
	P2 = P2,
	guielements.leftarrow,
	guielements.rightarrow,
	p1guard,
	p1guardbar,
	p1jd,
	p1counterhit,
	p2guard,
	p2guardbar,
	p2jd,
	p2counterhit,
	guardcancelplayback,
	jdbar,
	reversalwindow,
	wakeupwindow
}

do
	local xoffset = p1guard.rawx
	local Elements = { }
	
	for _, data in ipairs(guardbreakdata) do
		table.insert(Elements, {text = data.text, x = xoffset - #data.text*LETTER_WIDTH, bgcolour = data.colour})
	end

	local sf = function(n) return function() changeConfig("garouguardstatep1", n) end end

	guipages.garouguardstatep1 = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		p1guard.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	local xoffset = p2guard.rawx
	local Elements = { }
	
	for _, data in ipairs(guardbreakdata) do
		table.insert(Elements, {text = data.text, x = xoffset - #data.text*LETTER_WIDTH, bgcolour = data.colour})
	end

	local sf = function(n) return function() changeConfig("garouguardstatep2", n) end end

	guipages.garouguardstatep2 = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		p2guard.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	guipages.p1guardbar = createScrollingBar(guicustompage, "Guard: 00", p1guardbar.x, p1guardbar.y, 0, p1maxguard, nil,
		function(n, k)
			if n then
				changeConfig("garouguardmaxp1", getConfigValue("garouguardmaxp1")+n)
			end
			if k then
				changeConfig("garouguardmaxp1", k)
			end
			return getConfigValue("garouguardmaxp1")
		end,
		function(this)
			this.text = string.format(p1guardbar.rawtext, getConfigValue("garouguardmaxp1"))
		end)
end

do
	guipages.p2guardbar = createScrollingBar(guicustompage, "Guard: 00", p2guardbar.x, p2guardbar.y, 0, p2maxguard, nil,
		function(n, k)
			if n then
				changeConfig("garouguardmaxp2", getConfigValue("garouguardmaxp2")+n)
			end
			if k then
				changeConfig("garouguardmaxp2", k)
			end
			return getConfigValue("garouguardmaxp2")
		end,
		function(this)
			this.text = string.format(p2guardbar.rawtext, getConfigValue("garouguardmaxp2"))
		end)
end

do -- guardcancelslot
	local xoffset = guardcancelplayback.rawx+#guardcancelplayback.rawtext*LETTER_HALFWIDTH
	local Elements = {
		{
			text = "NONE",
			x = xoffset+LETTER_WIDTH,
			bgcolour = colour.boolfalse,
		}
	}

	for i = 1, REPLAY_SLOTS_COUNT do
		table.insert(Elements, {text = tostring(i), x = xoffset, bgcolour = colour.option2})
	end

	local sf = function(n) return function() changeConfig("garouguardcancelslot", n-1) end end

	guipages.garouguardcancelslot = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		guardcancelplayback.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	guipages.garoureversalwindow = createScrollingBar(guicustompage, reversalwindow.rawtext, reversalwindow.x, reversalwindow.y, 1, 12, nil,
		function(n, k)
			if n then
				changeConfig("garoureversalwindow", getConfigValue("garoureversalwindow")+n)
			end
			if k then
				changeConfig("garoureversalwindow", k)
			end
			return getConfigValue("garoureversalwindow")
		end,
		function(this)
			this.text = string.format(reversalwindow.rawtext, getConfigValue("garoureversalwindow"))
		end)
end

do
	guipages.garouwakeupwindow = createScrollingBar(guicustompage, wakeupwindow.rawtext, wakeupwindow.x, reversalwindow.y, 1, 12, nil, -- Kain fewest frames at 12
		function(n, k)
			if n then
				local val = getConfigValue("garouwakeupwindow")+n
				changeConfig("garouwakeupwindow", val)
				garou_setwakeupreversalwindow(val)
			end
			if k then
				changeConfig("garouwakeupwindow", k)
				garou_setwakeupreversalwindow(k)
			end
			return getConfigValue("garouwakeupwindow")
		end,
		function(this)
			this.text = string.format(wakeupwindow.rawtext, getConfigValue("garouwakeupwindow"))
		end)
end