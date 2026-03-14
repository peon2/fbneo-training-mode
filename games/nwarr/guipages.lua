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
		changePageAndSelection("nwarrmusic")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("nwarrmusicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("nwarrmusicvolume")/100
	end,
}

guicustompage = {
	title = {
		text = "Night Warriors: Darkstalkers' Revenge Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	music
}

guipages.nwarrmusic = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("nwarrmusicvolume")
			changeConfig("nwarrmusicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("nwarrmusicvolume", k)
			return k
		end
		return getConfigValue("nwarrmusicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("nwarrmusicvolume"))
	end
)