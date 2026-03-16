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
		changePageAndSelection("mvscmusic")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("mvscmusicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = getConfigValue("mvscmusicvolume")/100
	end,
}

guicustompage = {
	title = {
		text = "Marvel vs Capcom - Clash of Superheroes Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	music
}

guipages.mvscmusic = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("mvscmusicvolume")
			changeConfig("mvscmusicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("mvscmusicvolume", k)
			return k
		end
		return getConfigValue("mvscmusicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("mvscmusicvolume"))
	end
)