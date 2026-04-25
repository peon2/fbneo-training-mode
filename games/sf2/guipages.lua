assert(rb,"Run fbneo-training-mode.lua")

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
	p2stun
}
