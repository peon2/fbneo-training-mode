assert(rb,"Run fbneo-training-mode.lua")
dofile("games/sf2/guipages.lua")
guicustompage.title.text = "Super Street Fighter II - The New Challengers Settings"

local music = {
	text = "Music Volume",
	rawx = interactivegui.boxxhalflength,
	x = 10,
	y = 150,
	fillpercent = 0,
	olcolour = colour.olcolour,
	info = "Controls how loud the music is",
	reset = function()
		resetConfig("sf2musicvolume")
	end,
	func = function()
		changePageAndSelection("sf2music")
	end,
	autofunc = function(this)
		local value = getConfigValue("sf2musicvolume")
		this.text = string.format("Music Volume: %3d", value)
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = value/100
	end,
}
guicustompage[#guicustompage] = music -- bgm volume control is the last option
guipages.sf2music = createScrollingBar(guicustompage, "Music Volume: 00", music.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music.y, 0, 100, nil,
	function(n, k)
		if n then
			local volume = getConfigValue("sf2musicvolume")
			changeConfig("sf2musicvolume", volume+n)
			return volume
		end
		if k then
			changeConfig("sf2musicvolume", k)
			return k
		end
		return getConfigValue("sf2musicvolume")
	end,
	function(this)
		this.text = string.format("Music Volume: %3d", getConfigValue("sf2musicvolume"))
	end
)