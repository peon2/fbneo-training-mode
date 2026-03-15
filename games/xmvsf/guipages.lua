assert(rb,"Run fbneo-training-mode.lua")

local p1character = {
	text = "Character: Off",
	rawx = interactivegui.boxxhalflength,
	y = 30,
	olcolour = colour.olcolour,
	info = "Forces Street Fighter vs X-Men to pick a character at Character Select",
	func = function()
		local selection = 4
		if p1characterpick == character.APOCALYPSE then
			selection = 1
		elseif p1characterpick == character.AKUMA then
			selection = 2
		elseif p1characterpick == character.ALPHA_CHUN_LI then
			selection = 3
		end
		changePageAndSelection("p1character", selection)
	end,
	autofunc = function(this)
		if p1characterpick == character.APOCALYPSE then
			this.text = "Character: Apocalypse"
			this.bgcolour = colour.booltrue
		elseif p1characterpick == character.AKUMA then
			this.text = "Character: Akuma"
			this.bgcolour = colour.booltrue
		elseif p1characterpick == character.ALPHA_CHUN_LI then
			this.text = "Character: Alpha Chun-Li"
			this.bgcolour = colour.booltrue
		else
			this.text = "Character: Off"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end
}

local p2character = {
	text = "Character: Off",
	rawx = interactivegui.boxxhalflength,
	y = 110,
	olcolour = colour.olcolour,
	info = "Forces Street Fighter vs X-Men to pick a character at Character Select",
	func = function()
		local selection = 4
		if p2characterpick == character.APOCALYPSE then
			selection = 1
		elseif p2characterpick == character.AKUMA then
			selection = 2
		elseif p2characterpick == character.ALPHA_CHUN_LI then
			selection = 3
		end
		changePageAndSelection("p2character", selection)
	end,
	autofunc = function(this)
		if p2characterpick == character.APOCALYPSE then
			this.text = "Character: Apocalypse"
			this.bgcolour = colour.booltrue
		elseif p2characterpick == character.AKUMA then
			this.text = "Character: Akuma"
			this.bgcolour = colour.booltrue
		elseif p2characterpick == character.ALPHA_CHUN_LI then
			this.text = "Character: Alpha Chun-Li"
			this.bgcolour = colour.booltrue
		else
			this.text = "Character: Off"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end
}

local music = {
	text = "Music Volume",
	rawx = interactivegui.boxxhalflength,
	x = 10,
	y = 150,
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "Controls how loud the music is",
	func = function()
		changePageAndSelection("xmvsfmusic")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("xmvsfmusicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("xmvsfmusicvolume")/100
	end,
}

guicustompage = {
	title = {
		text = "Street Fighter vs X-Men Settings"
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
	p1character,
	p2character,
	music
}

local xoffset = p1character.rawx + #"Character: "*LETTER_HALFWIDTH
guipages.p1character = createPopUpMenu(guicustompage,
	{
		{
			text = "Apocalypse",
			x = xoffset - #"Apocalypse"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p1characterpick = character.APOCALYPSE
			end end
		},
		{
			text = "Akuma",
			x = xoffset - #"Akuma"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p1characterpick = character.AKUMA
			end end
		},
		{
			text = "Alpha Chun-Li",
			x = xoffset - #"Alpha Chun-Li"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p1characterpick = character.ALPHA_CHUN_LI
			end end
		},
		{
			text = "Off",
			x = xoffset - #"Off"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				p1characterpick = nil
			end end
		}
	},
nil, p1character.y, nil, nil, nil, nil, true)

xoffset = p2character.rawx + #"Character: "*LETTER_HALFWIDTH
guipages.p2character = createPopUpMenu(guicustompage,
	{
		{
			text = "Apocalypse",
			x = xoffset - #"Apocalypse"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p2characterpick = character.APOCALYPSE
			end end
		},
		{
			text = "Akuma",
			x = xoffset - #"Akuma"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p2characterpick = character.AKUMA
			end end
		},
		{
			text = "Alpha Chun-Li",
			x = xoffset - #"Alpha Chun-Li"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p2characterpick = character.ALPHA_CHUN_LI
			end end
		},
		{
			text = "Off",
			x = xoffset - #"Off"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				p2characterpick = nil
			end end
		}
	},
nil, p2character.y, nil, nil, nil, nil, true)

guipages.xmvsfmusic = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("xmvsfmusicvolume")
			changeConfig("xmvsfmusicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("xmvsfmusicvolume", k)
			return k
		end
		return getConfigValue("xmvsfmusicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("xmvsfmusicvolume"))
	end
)