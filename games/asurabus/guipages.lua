assert(rb,"Run fbneo-training-mode.lua")

local P1PreviousCharacter = 0
local P2PreviousCharacter = 0

local p1vebel = {
	text = "Select Vebel",
	rawx = interactivegui.boxxhalflength,
	x = 15,
	y = 25,
	olcolour = colour.olcolour,
	info = "Force Select Vebel for P1 at Character Select",
	func = function()
		P1SelectVebel = not P1SelectVebel
		if P1SelectVebel then -- to avoid getting caught out if this is used outside of char select
			P1PreviousCharacter = rb(p1character)
		else
			wb(p1character, P1PreviousCharacter)
		end
	end,
	autofunc = function(this)
		if P1SelectVebel then
			this.bgcolour = colour.booltrue
		else
			this.bgcolour = colour.boolfalse
		end
	end,
}

local p2vebel = {
	text = "Select Vebel",
	rawx = interactivegui.boxxhalflength,
	x = 15,
	y = 85,
	olcolour = colour.olcolour,
	info = "Force Select Vebel for P2 at Character Select",
	func = function()
		P2SelectVebel = not P2SelectVebel
		if P2SelectVebel then -- to avoid getting caught out if this is used outside of char select
			P2PreviousCharacter = rb(p2character)
		else
			wb(p2character, P2PreviousCharacter)
		end
	end,
	autofunc = function(this)
		if P2SelectVebel then
			this.bgcolour = colour.booltrue
		else
			this.bgcolour = colour.boolfalse
		end
	end,
}

guicustompage = {
	title = {
		text = "Asura Buster - The Eternal Warriors Settings"
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
	p1vebel,
	p2vebel
}
