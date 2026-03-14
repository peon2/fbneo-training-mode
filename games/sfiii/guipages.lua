assert(rb,"Run fbneo-training-mode.lua")

local p1stun = {
	text = "Stun settings",
	rawx = 100,
	x = 0,
	y = 40,
	olcolour = colour.olcolour,
	info = "Controls how P1 stun is handled",
	func = function()
		changePageAndSelection("p1stun", 1)
	end,
	autofunc = function(this)
		if not getConfigValue("sfiiistunenabledp1") then
			this.text = "No Stun control"
			this.x = this.rawx-#this.text*LETTER_WIDTH
			this.bgcolour = colour.boolfalse
		elseif getConfigValue("sfiiistunenabledp1") and not getConfigValue("sfiiistunaftercombop1") then
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
	olcolour = colour.olcolour,
	info = "Controls how much stun P1 has",
	func = 	function()
		changePageAndSelection("p1stunbar")
	end,
	autofunc = function(this)
		this.text = string.format("Stun: %2d", getConfigValue("sfiiistunp1"))
		this.x = this.rawx-#this.text*LETTER_WIDTH
		this.fillpercent = getConfigValue("sfiiistunp1")/p1maxstun
	end,
}

local p2stun = {
	text = "Stun settings",
	rawx = 100,
	x = 0,
	y = 120,
	olcolour = colour.olcolour,
	info = "Controls how P2 stun is handled",
	func = function()
		changePageAndSelection("p2stun", 1)
	end,
	autofunc = function(this)
		if not getConfigValue("sfiiistunenabledp2") then
			this.text = "No Stun control"
			this.x = this.rawx-#this.text*LETTER_WIDTH
			this.bgcolour = colour.boolfalse
		elseif getConfigValue("sfiiistunenabledp2") and not getConfigValue("sfiiistunaftercombop2") then
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
	olcolour = colour.olcolour,
	info = "Controls how much stun P2 has",
	func = function()
		changePageAndSelection("p2stunbar")
	end,
	autofunc = function(this)
		this.text = string.format("Stun: %2d", getConfigValue("sfiiistunp2"))
		this.x = this.rawx-#this.text*LETTER_WIDTH
		this.fillpercent = getConfigValue("sfiiistunp2")/p2maxstun
	end,
}

local p1gill = {
	text = "P1 Gill Off",
	rawx = interactivegui.boxxhalflength,
	olcolour = colour.olcolour,
	info = "Forces SFIII to pick Gill at Character Select",
	func = function()
		changeConfig("sfiiip1gill", not getConfigValue("sfiiip1gill"))
	end,
	autofunc = function(this)
		if getConfigValue("sfiiip1gill") then
			this.text = "P1 Gill On"
			this.bgcolour = colour.booltrue
		else
			this.text = "P1 Gill Off"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end
}

local p2gill = {
	text = "P2 Gill Off",
	rawx = interactivegui.boxxhalflength,
	olcolour = colour.olcolour,
	info = "Forces SFIII to pick Gill at Character Select",
	func = function()
		changeConfig("sfiiip2gill", not getConfigValue("sfiiip2gill"))
	end,
	autofunc = function(this)
		if getConfigValue("sfiiip2gill") then
			this.text = "P2 Gill On"
			this.bgcolour = colour.booltrue
		else
			this.text = "P2 Gill Off"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end
}

local musicmaxvolume = 100

local music = {
	text = "Music Volume",
	rawx = interactivegui.boxxhalflength,
	x = 10,
	y = 150,
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "Controls how loud the music is",
	func = function()
		changePageAndSelection("sfiiimusic")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("sfiiimusicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("sfiiimusicvolume")/musicmaxvolume
	end,
}

guicustompage = {
	title = {
		text = "New Generation Settings"
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
	p1gill,
	p2stun,
	p2stunbar,
	p2gill,
	music
}


guipages.p1stun = createPopUpMenu(guicustompage,
	{
		{
			text = "No Stun control",
			x = p1stun.rawx - #"No Stun control"*LETTER_WIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
			changeConfig("sfiiistunenabledp1", false)
			end end
		},
		{
			text = "Always set Stun",
			x = p1stun.rawx - #"Always set Stun"*LETTER_WIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				changeConfig("sfiiistunenabledp1", true)
				changeConfig("sfiiistunaftercombop1", false)
			end end
		},
		{
			text = "Set Stun outside combo",
			x = p1stun.rawx - #"Set Stun outside combo"*LETTER_WIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("sfiiistunenabledp1", true)
				changeConfig("sfiiistunaftercombop1", true)
			end end
		} 
	},
nil, p1stun.y, nil, nil, nil, nil, true)

guipages.p1stunbar = createScrollingBar(guicustompage, "Stun: 00", p1stunbar.rawx-#"Stun: 00"*LETTER_WIDTH, p1stunbar.y, 0, p1maxstun, nil,
	function(n)
		if n then
			changeConfig("sfiiistunp1", getConfigValue("sfiiistunp1")+n)
		end
		return getConfigValue("sfiiistunp1")
	end,
	function(this)
		this.text = string.format("Stun: %2d", getConfigValue("sfiiistunp1"))
	end)

guipages.p2stun = createPopUpMenu(guicustompage,
	{
		{
			text = "No Stun control",
			x = p2stun.rawx - #"No Stun control"*LETTER_WIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				changeConfig("sfiiistunenabledp2", false)
			end end
		},
		{
			text = "Always set Stun",
			x = p2stun.rawx - #"Always set Stun"*LETTER_WIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				changeConfig("sfiiistunenabledp2", true)
				changeConfig("sfiiistunaftercombop2", false)
			end end
		},
		{
			text = "Set Stun outside combo",
			x = p2stun.rawx - #"Set Stun outside combo"*LETTER_WIDTH,
			bgcolour = colour.option2,
			selectfunc = function() return function()
				changeConfig("sfiiistunenabledp2", true)
				changeConfig("sfiiistunaftercombop2", true)
			end end
		}
	},
nil, p2stun.y, nil, nil, nil, nil, true)

guipages.p2stunbar = createScrollingBar(guicustompage, "Stun: 00", p2stunbar.rawx-#"Stun: 00"*LETTER_WIDTH, p2stunbar.y, 0, p2maxstun, nil,
	function(n)
		if n then
			changeConfig("sfiiistunp2", getConfigValue("sfiiistunp2")+n)
		end
		return getConfigValue("sfiiistunp2")
	end,
	function(this)
		this.text = string.format("Stun: %2d", getConfigValue("sfiiistunp2"))
	end)

guipages.sfiiimusic = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, musicmaxvolume, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("sfiiimusicvolume")+n
			changeConfig("sfiiimusicvolume", volume)
			return volume
		end
		if k then
			changeConfig("sfiiimusicvolume", k)
			return k
		end
		return getConfigValue("sfiiimusicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("sfiiimusicvolume"))
	end)