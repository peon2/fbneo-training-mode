assert(rb,"Run fbneo-training-mode.lua")

local music = {
	text = "Music Volume",
	rawx = interactivegui.boxxhalflength,
	x = 10,
	y = 150,
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "Controls how loud the music is",
	func = function()
		changePageAndSelection("mshvsfmusic")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("mshvsfmusicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("mshvsfmusicvolume")/100
	end,
}

guicustompage = {
	title = {
		text = "Marvel Super Heroes vs Street Fighter Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	music
}

guipages.mshvsfmusic = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("mshvsfmusicvolume")
			changeConfig("mshvsfmusicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("mshvsfmusicvolume", k)
			return k
		end
		return getConfigValue("mshvsfmusicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("mshvsfmusicvolume"))
	end
)