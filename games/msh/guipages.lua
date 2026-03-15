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
		changePageAndSelection("mshmusic")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("mshmusicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("mshmusicvolume")/100
	end,
}

guicustompage = {
	title = {
		text = "Marvel Super Heroes Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	music
}

guipages.mshmusic = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("mshmusicvolume")
			changeConfig("mshmusicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("mshmusicvolume", k)
			return k
		end
		return getConfigValue("mshmusicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("mshmusicvolume"))
	end
)