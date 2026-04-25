assert(rb,"Run fbneo-training-mode.lua")

local p1stun = {
	text = "Stun settings",
	rawx = 100,
	x = 0,
	y = 40,
	olcolour = "black",
	info = "Controls how P1 stun is handled",
	func = function()
		changePageAndSelection("p1stun", 1)
	end,
	autofunc = function(this)
		if not getConfigValue("sfiii3stunenabledp1") then
			this.text = "No Stun control"
			this.x = this.rawx-#this.text*LETTER_WIDTH
			this.bgcolour = colour.boolfalse
		elseif getConfigValue("sfiii3stunenabledp1") and not getConfigValue("sfiii3stunaftercombop1") then
			this.text = "Always set Stun"
			this.x = this.rawx-#this.text*LETTER_WIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Set Stun outside combo"
			this.x = this.rawx-#this.text*LETTER_WIDTH
			this.bgcolour = colour.option2
		end
	end,
}

local p1stunbar = {
	text = "Stun",
	rawx = 136,
	x = 10,
	y = 40,
	fillpercent = 0,
	olcolour = "black",
	info = "Controls how much stun P1 has",
	func = 	function()
		changePageAndSelection("p1stunbar")
	end,
	autofunc = function(this)
		this.text = string.format("Stun: %2d", getConfigValue("sfiii3stunp1"))
		this.x = this.rawx-#this.text*LETTER_WIDTH
		this.fillpercent = getConfigValue("sfiii3stunp1")/p1maxstun
	end,
}

local p2stun = {
	text = "Stun settings",
	rawx = 100,
	x = 0,
	y = 120,
	olcolour = "black",
	info = "Controls how P2 stun is handled",
	func = function()
		changePageAndSelection("p2stun", 1)
	end,
	autofunc = function(this)
		if not getConfigValue("sfiii3stunenabledp2") then
			this.text = "No Stun control"
			this.x = this.rawx-#this.text*LETTER_WIDTH
			this.bgcolour = colour.boolfalse
		elseif getConfigValue("sfiii3stunenabledp2") and not getConfigValue("sfiii3stunaftercombop2") then
			this.text = "Always set Stun"
			this.x = this.rawx-#this.text*LETTER_WIDTH
			this.bgcolour = colour.booltrue
		else
			this.text = "Set Stun outside combo"
			this.x = this.rawx-#this.text*LETTER_WIDTH
			this.bgcolour = colour.option2
		end
	end,
}

local p2stunbar = {
	text = "Stun",
	rawx = 136,
	x = 10,
	y = 120,
	fillpercent = 0,
	olcolour = "black",
	info = "Controls how much stun P2 has",
	func = function()
		changePageAndSelection("p2stunbar")
	end,
	autofunc = function(this)
		this.text = string.format("Stun: %2d", getConfigValue("sfiii3stunp2"))
		this.x = this.rawx-#this.text*LETTER_WIDTH
		this.fillpercent = getConfigValue("sfiii3stunp2")/p2maxstun
	end,
}

guicustompage = {
	title = { -- Page-Level elements named 'title' automatically space
		text = "Third Strike Settings"
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
	p1stun,
	p1stunbar,
	p2stun,
	p2stunbar
}

guipages.p1stun = createPopUpMenu(guicustompage,
	{
		{
			text = "No Stun control",
			x = p1stun.rawx - #"No Stun control"*LETTER_WIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
			changeConfig("sfiii3stunenabledp1", false)
			end end
		},
		{
			text = "Always set Stun",
			x = p1stun.rawx - #"Always set Stun"*LETTER_WIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				changeConfig("sfiii3stunenabledp1", true)
				changeConfig("sfiii3stunaftercombop1", false)
			end end
		},
		{
			text = "Set Stun outside combo",
			x = p1stun.rawx - #"Set Stun outside combo"*LETTER_WIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("sfiii3stunenabledp1", true)
				changeConfig("sfiii3stunaftercombop1", true)
			end end
		} 
	},
nil, p1stun.y, nil, nil, nil, nil, true)

guipages.p1stunbar = createScrollingBar(guicustompage, "Stun: 00", p1stunbar.rawx-#"Stun: 00"*LETTER_WIDTH, p1stunbar.y, 0, p1maxstun, nil,
	function(n)
		if n then
			changeConfig("sfiii3stunp1", getConfigValue("sfiii3stunp1")+n)
		end
		return getConfigValue("sfiii3stunp1")
	end,
	function(this)
		this.text = string.format("Stun: %2d", getConfigValue("sfiii3stunp1"))
	end)

guipages.p2stun = createPopUpMenu(guicustompage,
	{
		{
			text = "No Stun control",
			x = p2stun.rawx - #"No Stun control"*LETTER_WIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				changeConfig("sfiii3stunenabledp2", false)
			end end
		},
		{
			text = "Always set Stun",
			x = p2stun.rawx - #"Always set Stun"*LETTER_WIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				changeConfig("sfiii3stunenabledp2", true)
				changeConfig("sfiii3stunaftercombop2", false)
			end end
		},
		{
			text = "Set Stun outside combo",
			x = p2stun.rawx - #"Set Stun outside combo"*LETTER_WIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("sfiii3stunenabledp2", true)
				changeConfig("sfiii3stunaftercombop2", true)
			end end
		}
	},
nil, p2stun.y, nil, nil, nil, nil, true)

guipages.p2stunbar = createScrollingBar(guicustompage, "Stun: 00", p2stunbar.rawx-#"Stun: 00"*LETTER_WIDTH, p2stunbar.y, 0, p2maxstun, nil,
	function(n)
		if n then
			changeConfig("sfiii3stunp2", getConfigValue("sfiii3stunp2")+n)
		end
		return getConfigValue("sfiii3stunp2")
	end,
	function(this)
		this.text = string.format("Stun: %2d", getConfigValue("sfiii3stunp2"))
	end)
