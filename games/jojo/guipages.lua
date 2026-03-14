assert(rb,"Run fbneo-training-mode.lua")

local music = {
	text = "Music Volume",
	rawx = interactivegui.boxxhalflength,
	x = 10,
	y = 150,
	fillpercent = 0,
	olcolour = "black",
	info = "Controls how loud the music is",
	func = function()
		changePageAndSelection("jojomusic")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("jojomusicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("jojomusicvolume")/100
	end,
}

guicustompage = {
	title = {
		text = "JoJo's Venture Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	music
}

guipages.jojomusic = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("jojomusicvolume")
			changeConfig("jojomusicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("jojomusicvolume", k)
			return k
		end
		return getConfigValue("jojomusicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("jojomusicvolume"))
	end
)