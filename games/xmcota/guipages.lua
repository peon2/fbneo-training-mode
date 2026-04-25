assert(rb,"Run fbneo-training-mode.lua")

local p1character = {
	text = "Character: Off",
	rawx = interactivegui.boxxhalflength,
	y = 30,
	olcolour = colour.olcolour,
	info = "Forces Children of the Atom to pick a character at Character Select",
	func = function()
		changePageAndSelection("p1character", (p1characterpick or 20)/2-6)
	end,
	autofunc = function(this)
		if p1characterpick == character.JUGGERNAUT then
			this.text = "Character: Juggernaut"
			this.bgcolour = colour.booltrue
		elseif p1characterpick == character.MAGNETO then
			this.text = "Character: Magneto"
			this.bgcolour = colour.booltrue
		elseif p1characterpick == character.AKUMA then
			this.text = "Character: Akuma"
			this.bgcolour = colour.booltrue
		else
			this.text = "Character: Off"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end
}

local p2character = {
	text = "Character: Off",
	rawx = interactivegui.boxxhalflength,
	y = 110,
	olcolour = colour.olcolour,
	info = "Forces Children of the Atom to pick a character at Character Select",
	func = function()
		changePageAndSelection("p2character", (p2characterpick or 20)/2-6)
	end,
	autofunc = function(this)
		if p2characterpick == character.JUGGERNAUT then
			this.text = "Character: Juggernaut"
			this.bgcolour = colour.booltrue
		elseif p2characterpick == character.MAGNETO then
			this.text = "Character: Magneto"
			this.bgcolour = colour.booltrue
		elseif p2characterpick == character.AKUMA then
			this.text = "Character: Akuma"
			this.bgcolour = colour.booltrue
		else
			this.text = "Character: Off"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end
}

guicustompage = {
	title = {
		text = "Children of the Atom Settings"
	},
	guielements.leftarrow,
	guielements.rightarrow,
	p1 = {
			text = "P1",
			x = 2,
			y = 15,
		},
	p2 = {
		text = "P2",
		x = 2,
		y = 95,
	},
	p1character,
	p2character
}

local xoffset = p1character.rawx + #"Character: "*LETTER_HALFWIDTH
guipages.p1character = createPopUpMenu(guicustompage,
	{
		{
			text = "Juggernaut",
			x = xoffset - #"Juggernaut"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p1characterpick = character.JUGGERNAUT
			end end
		},
		{
			text = "Magneto",
			x = xoffset - #"Magneto"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p1characterpick = character.MAGNETO
			end end
		},
		{
			text = "Akuma",
			x = xoffset - #"Akuma"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p1characterpick = character.AKUMA
			end end
		},
		{
			text = "None",
			x = xoffset - #"None"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				p1characterpick = nil
			end end
		}
	},
nil, p1character.y, nil, nil, nil, nil, true)

xoffset = p2character.rawx + #"Character: "*LETTER_HALFWIDTH
guipages.p2character = createPopUpMenu(guicustompage,
	{
		{
			text = "Juggernaut",
			x = xoffset - #"Juggernaut"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p2characterpick = character.JUGGERNAUT
			end end
		},
		{
			text = "Magneto",
			x = xoffset - #"Magneto"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p2characterpick = character.MAGNETO
			end end
		},
		{
			text = "Akuma",
			x = xoffset - #"Akuma"*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function() return function()
				p2characterpick = character.AKUMA
			end end
		},
		{
			text = "None",
			x = xoffset - #"None"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function() return function()
				p2characterpick = nil
			end end
		}
	},
nil, p2character.y, nil, nil, nil, nil, true)
