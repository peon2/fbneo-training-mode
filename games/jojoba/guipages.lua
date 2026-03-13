assert(rb,"Run fbneo-training-mode.lua")

local musicmaxvolume = 100

local music = {
	text = "Music Volume",
	rawx = interactivegui.boxxhalflength,
	x = 10,
	y = 150,
	fillpercent = 0,
	olcolour = "black",
	info = "Controls how loud the music is",
	func = function()
		changePageAndSelection("jojobamusic")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("jojobamusicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("jojobamusicvolume")/musicmaxvolume
	end,
}

local childmode = {
	text = "Child Mode:",
	x = 2,
	y = 15,
}

local p1child = {
	text = "P1 Disabled",
	x = childmode.x + 100,
	y = childmode.y,
	olcolour = colour.olcolour,
	func = function()
		P1ChildMode = not P1ChildMode
		if not P1ChildMode then
			wb(p1childmode, 0x00)
		end
	end,
	autofunc = function(this)
		if P1ChildMode then
			this.text = "P1 Enabled"
			this.bgcolour = colour.booltrue
		else
			this.text = "P1 Disabled"
			this.bgcolour = colour.boolfalse
		end
		this.x = childmode.x + 100 - #this.text*LETTER_HALFWIDTH
	end
}

local p2child = {
	text = "P2 Disabled",
	x = childmode.x + 200,
	y = childmode.y,
	olcolour = colour.olcolour,
	func = function()
		P2ChildMode = not P2ChildMode
		if not P2ChildMode then
			wb(p2childmode, 0x00)
		end
	end,
	autofunc = function(this)
		if P2ChildMode then
			this.text = "P2 Enabled"
			this.bgcolour = colour.booltrue
		else
			this.text = "P2 Disabled"
			this.bgcolour = colour.boolfalse
		end
		this.x = childmode.x + 200 - #this.text*LETTER_HALFWIDTH
	end
}

guicustompage = {
	title = {
		text = "Heritage for the Future Settings"
	},
	childmode = childmode,
	guielements.leftarrow,
	guielements.rightarrow,
	p1child,
	p2child,
	music
}

guipages.jojobamusic = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, musicmaxvolume, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("jojobamusicvolume")
			changeConfig("jojobamusicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("jojobamusicvolume", k)
			return k
		end
		return getConfigValue("jojobamusicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("jojobamusicvolume"))
	end)