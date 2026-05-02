assert(rb,"Run fbneo-training-mode.lua")
local stun = {
	text = "Stun Control:",
	x = 20,
	y = 20,
}

local p1stun = {
	text = "P1 Disabled",
	x = stun.x + 60,
	y = stun.y,
	olcolour = colour.olcolour,
	func = function()
		changeConfig("samshodisablestunp1", not getConfigValue("samshodisablestunp1"))
	end,
	autofunc = function(this)
		if not getConfigValue("samshodisablestunp1") then
			this.text = "P1 Enabled"
			this.bgcolour = colour.booltrue
		else
			this.text = "P1 Disabled"
			this.bgcolour = colour.boolfalse
		end
	end
}

local p2stun = {
	text = "P2 Disabled",
	x = stun.x + 120,
	y = stun.y,
	olcolour = colour.olcolour,
	func = function()
		changeConfig("samshodisablestunp2", not getConfigValue("samshodisablestunp2"))
	end,
	autofunc = function(this)
		if not getConfigValue("samshodisablestunp2") then
			this.text = "P2 Enabled"
			this.bgcolour = colour.booltrue
		else
			this.text = "P2 Disabled"
			this.bgcolour = colour.boolfalse
		end
	end
}

guicustompage = {
	title = {
		text = "Samurai Shodown Settings"
	},
	stun = stun,
	guielements.leftarrow,
	guielements.rightarrow,
	p1stun,
	p2stun
}
