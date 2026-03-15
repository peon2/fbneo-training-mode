assert(rb,"Run fbneo-training-mode.lua")

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
		local value = math.abs(getConfigValue("sf2musicvolume") - 100)
		this.text = string.format("Music Volume: %3d", value)
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		this.fillpercent = value/100
	end,
}
local p1stun = {
	text = "Stun Off",
	rawx = interactivegui.boxxhalflength,
	x = 10,
	y = 25,
	olcolour = colour.olcolour,
	info = "Enables/Disables stun for P1",
	reset = function()
		resetConfig("sf2disablestunp1")
	end,
	func = function()
		changeConfig("sf2disablestunp1", not getConfigValue("sf2disablestunp1"))
	end,
	autofunc = function(this)
		if getConfigValue("sf2disablestunp1") then
			this.text = "Stun Off"
			this.bgcolour = colour.boolfalse
		else
			this.text = "Stun On"
			this.bgcolour = colour.booltrue
		end
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
	end,
}
local p2stun = {
	text = "Stun Off",
	rawx = interactivegui.boxxhalflength,
	x = 10,
	y = 85,
	olcolour = colour.olcolour,
	info = "Enables/Disables stun for P2",
	reset = function()
		resetConfig("sf2disablestunp2")
	end,
	func = function()
		changeConfig("sf2disablestunp2", not getConfigValue("sf2disablestunp2"))
	end,
	autofunc = function(this)
		if getConfigValue("sf2disablestunp2") then
			this.text = "Stun Off"
			this.bgcolour = colour.boolfalse
		else
			this.text = "Stun On"
			this.bgcolour = colour.booltrue
		end
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
	end,
}

guicustompage = {
	title = {
		text = "Street Fighter II - The World Warrior Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	P1 = {
		text = "P1",
		y = 15
	},
	P2 = {
		text = "P2",
		y = 75
	},
	p1stun,
	p2stun,
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