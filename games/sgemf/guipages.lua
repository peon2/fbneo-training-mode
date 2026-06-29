assert(rb,"Run fbneo-training-mode.lua")

-- purposefully leaving out reset functions because of how few buttons sgemf has

local items = {
	{name = "NONE", colour = 0xFF0000FF},
	{name = "Fire", colour = 0xF07000FF},
	{name = "Ice", colour = 0x70C0D0FF},
	{name = "Lightning", colour = 0xF0E000FF},
	{name = "Poison", colour = 0xA060A0FF},
	{name = "Banana", colour = 0xFFFF64FF},
	{name = "Bomb", colour = 0x404050FF},
	{name = "Petrify", colour = 0x8C8C9CFF}
}

local P1 = {
	text = "P1:",
	x = 20,
	y = 20
}

local p1items = {
	rawtext = "Item: ",
	rawx = interactivegui.boxxhalflength,
	y = P1.y,
	info = "Forceably set the first Item held by P1",
	olcolour = colour.olcolour,
	func = function()
		changePageAndSelection("sgemfitemsp1", getConfigValue("sgemfitemp1")+2)
	end,
	autofunc = function(this)
		local item = items[getConfigValue("sgemfitemp1")+2]
		this.text = this.rawtext..item.name
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.bgcolour = item.colour
	end
}

local P2 = {
	text = "P2:",
	x = 20,
	y = 120
}

local p2items = {
	rawtext = "Item: ",
	rawx = interactivegui.boxxhalflength,
	y = P2.y,
	info = "Forceably set the first Item held by P2",
	olcolour = colour.olcolour,
	func = function()
		changePageAndSelection("sgemfitemsp2", getConfigValue("sgemfitemp2")+2)
	end,
	autofunc = function(this)
		local item = items[getConfigValue("sgemfitemp2")+2]
		this.text = this.rawtext..item.name
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.bgcolour = item.colour
	end
}

local specialsbuttons = { P1 = {}, P2 = {}}

for button = 1, 3 do
	local name = "sgemfp1special"..button
	local text = "Special "..button
	specialsbuttons.P1[button] = {
		rawtext = text..":   ",
		x = P1.x + 20+(#"Special 1: OFF"+2)*LETTER_WIDTH*(button-1),
		y = P1.y + 15,
		info = "Forceably sets the level of P1 "..text,
		olcolour = colour.olcolour,
		func = function()
			changePageAndSelection(name, getConfigValue(name)+1)
		end,
		autofunc = function(this)
			local val = getConfigValue(name)
			if val == 0 then
				this.text = text..": OFF"
				this.bgcolour = nil
			else
				this.text = this.rawtext..val
				this.bgcolour = colour.booltrue
			end
		end
	}
end

for button = 1, 3 do
	local name = "sgemfp2special"..button
	local text = "Special "..button
	specialsbuttons.P2[button] = {
		rawtext = text..":   ",
		x = P2.x + 20+(#"Special 1: OFF"+2)*LETTER_WIDTH*(4-button-1),
		y = P2.y + 15,
		info = "Forceably sets the level of P2 "..text,
		olcolour = colour.olcolour,
		func = function()
			changePageAndSelection(name, getConfigValue(name)+1)
		end,
		autofunc = function(this)
			local val = getConfigValue(name)
			if val == 0 then
				this.text = text..": OFF"
				this.bgcolour = nil
			else
				this.text = this.rawtext..val
				this.bgcolour = colour.booltrue
			end
		end
	}
end

local stunsettingdata = {
	[sgemf_stunsettings.OFF] = {
		text = "Off",
		colour = colour.boolfalse
	},
	[sgemf_stunsettings.ALWAYS] = {
		text = "Always",
		colour = colour.booltrue
	},
	[sgemf_stunsettings.AFTER_COMBO] = {
		text = "After Combo",
		colour = colour.option2
	}
}

local p1stun = {
	rawtext = "Stun Bar Control: ",
	rawx = interactivegui.boxxhalflength,
	y = specialsbuttons.P1[1].y+15,
	olcolour = colour.olcolour,
	info = "Change how Guard Bar behaves",
	func = function()
		changePageAndSelection("stunsettingp1", getConfigValue("sgemfstunsettingp1"))
	end,
	autofunc = function(this)
		local setting = getConfigValue("sgemfstunsettingp1")
		this.text = this.rawtext..stunsettingdata[setting].text
		this.bgcolour = stunsettingdata[setting].colour
		this.x = this.rawx - #this.text*LETTER_WIDTH
	end
}

local p1stunbar = {
	rawtext = "Stun: %2d",
	x = interactivegui.boxxhalflength+LETTER_WIDTH,
	y = p1stun.y,
	fillpercent = 0,
	olcolour = "black",
	info = "Controls how much stun P1 has",
	func = function()
		changePageAndSelection("p1stunbar")
	end,
	autofunc = function(this)
		local stun = getConfigValue("sgemfstunvaluep1")
		this.text = string.format(this.rawtext, stun)
		this.fillpercent = stun/0x28
	end,
}

local p2stun = {
	rawtext = "Stun Bar Control: ",
	rawx = interactivegui.boxxhalflength,
	y = specialsbuttons.P2[1].y+15,
	olcolour = colour.olcolour,
	info = "Change how Guard Bar behaves",
	func = function()
		changePageAndSelection("stunsettingp2", getConfigValue("sgemfstunsettingp2"))
	end,
	autofunc = function(this)
		local setting = getConfigValue("sgemfstunsettingp2")
		this.text = this.rawtext..stunsettingdata[setting].text
		this.bgcolour = stunsettingdata[setting].colour
		this.x = this.rawx - #this.text*LETTER_WIDTH
	end
}

local p2stunbar = {
	rawtext = "Stun: %2d",
	x = interactivegui.boxxhalflength+LETTER_WIDTH,
	y = p2stun.y,
	fillpercent = 0,
	olcolour = "black",
	info = "Controls how much stun P2 has",
	func = function()
		changePageAndSelection("p2stunbar")
	end,
	autofunc = function(this)
		local stun = getConfigValue("sgemfstunvaluep2")
		this.text = string.format(this.rawtext, stun)
		this.fillpercent = stun/0x28
	end,
}

guicustompage = {
	title = {
		text = "Super Gem Fighter Mini Mix Settings"
	},
	P1 = P1,
	P2 = P2,
	guielements.leftarrow,
	guielements.rightarrow,
	p1items,
	specialsbuttons.P1[1],
	specialsbuttons.P1[2],
	specialsbuttons.P1[3],
	p1stun,
	p1stunbar,
	p2items,
	specialsbuttons.P2[1],
	specialsbuttons.P2[2],
	specialsbuttons.P2[3],
	p2stun,
	p2stunbar
}

do
	local xoffset = p1items.rawx + #p1items.rawtext*LETTER_HALFWIDTH 

	local Elements = {}

	for i, v in ipairs(items) do
		table.insert(Elements, {text = v.name, x = xoffset-#v.name*LETTER_HALFWIDTH, bgcolour = v.colour})
	end

	local sf = function(n) return function() changeConfig("sgemfitemp1", n-2) end end

	guipages.sgemfitemsp1 = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		p1items.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	local xoffset = p2items.rawx + #p2items.rawtext*LETTER_HALFWIDTH 

	local Elements = {}

	for i, v in ipairs(items) do
		table.insert(Elements, {text = v.name, x = xoffset-#v.name*LETTER_HALFWIDTH, bgcolour = v.colour})
	end

	local sf = function(n) return function() changeConfig("sgemfitemp2", n-2) end end

	guipages.sgemfitemsp2 = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		p2items.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	for player = 1, 2 do
		for buttonnumber, button in ipairs(specialsbuttons["P"..player]) do
			local name = "sgemfp"..player.."special"..buttonnumber
			local xoffset = button.x + #button.rawtext*LETTER_WIDTH - LETTER_WIDTH*2
			local Elements = { {text = "OFF", x = xoffset, bgcolour = colour.boolfalse} }
			for level = 1, 3 do
				table.insert(Elements, {text = tostring(level), x = xoffset + LETTER_WIDTH*2, bgcolour = colour.booltrue})
			end
			local sf = function(n) return function() changeConfig(name, n-1) end end
			guipages[name] = createPopUpMenu(
				guicustompage,
				Elements,
				nil,
				button.y,
				nil,
				sf,
				nil,
				nil,
				true
			)
		end
	end
end

do
	local xoffset = p1stun.rawx
	local Elements = { }
	
	for _, data in ipairs(stunsettingdata) do
		table.insert(Elements, {text = data.text, x = xoffset - #data.text*LETTER_WIDTH, bgcolour = data.colour})
	end

	local sf = function(n) return function() changeConfig("sgemfstunsettingp1", n) end end

	guipages.stunsettingp1 = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		p1stun.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	guipages.p1stunbar = createScrollingBar(guicustompage, "Stun: 00", p1stunbar.x, p1stunbar.y, 0, 0x28, nil,
		function(n, k)
			if n then
				changeConfig("sgemfstunvaluep1", getConfigValue("sgemfstunvaluep1")+n)
			end
			if k then
				changeConfig("sgemfstunvaluep1", k)
			end
			return getConfigValue("sgemfstunvaluep1")
		end,
		function(this)
			this.text = string.format(p1stunbar.rawtext, getConfigValue("sgemfstunvaluep1"))
		end)
end

do
	local xoffset = p2stun.rawx
	local Elements = { }
	
	for _, data in ipairs(stunsettingdata) do
		table.insert(Elements, {text = data.text, x = xoffset - #data.text*LETTER_WIDTH, bgcolour = data.colour})
	end

	local sf = function(n) return function() changeConfig("sgemfstunsettingp2", n) end end

	guipages.stunsettingp2 = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		p2stun.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	guipages.p2stunbar = createScrollingBar(guicustompage, "Stun: 00", p2stunbar.x, p2stunbar.y, 0, 0x28, nil,
		function(n, k)
			if n then
				changeConfig("sgemfstunvaluep2", getConfigValue("sgemfstunvaluep2")+n)
			end
			if k then
				changeConfig("sgemfstunvaluep2", k)
			end
			return getConfigValue("sgemfstunvaluep2")
		end,
		function(this)
			this.text = string.format(p2stunbar.rawtext, getConfigValue("sgemfstunvaluep2"))
		end)
end