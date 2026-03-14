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
		changePageAndSelection("sfa2music")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("sfa2musicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("sfa2musicvolume")/100
	end,
}

guicustompage = {
	title = {
		text = "Street Fighter Alpha 2 Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	music
}

guipages.sfa2music = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("sfa2musicvolume")
			changeConfig("sfa2musicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("sfa2musicvolume", k)
			return k
		end
		return getConfigValue("sfa2musicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("sfa2musicvolume"))
	end
)