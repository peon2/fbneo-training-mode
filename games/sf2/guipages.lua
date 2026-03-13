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
		changePageAndSelection("sf2music")
	end,
	autofunc = function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("sf2musicvolume"))
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = math.abs(getConfigValue("sf2musicvolume")- 100)/100
	end,
}

guicustompage = {
	title = {
		text = "Street Fighter II - The World Warrior Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	music
}
-- CPS1 has 0 as loud and 100 as quiet, spoof the UI to be the other way around
guipages.sf2music = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("sf2musicvolume")
			changeConfig("sf2musicvolume", volume-n)
			return volume-n
		end
		if k then
			local value = math.abs(k - 100)
			changeConfig("sf2musicvolume", value)
			return k
		end
		return math.abs(getConfigValue("sf2musicvolume") - 100)
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", math.abs(getConfigValue("sf2musicvolume") - 100))
	end
)