assert(rb,"Run fbneo-training-mode.lua")

local pP1Character = 0x403DD1
local pP2Character = 0x404B85

local P1PreviousCharacter = rb(pP1Character)
local P2PreviousCharacter = rb(pP2Character)
local CURFUE = 8
local S_GEIST = 9

local characterdata = {
	[CURFUE] = "Curfue",
	[S_GEIST] = "S. Geist"
}

local P1 = {
	text = "P1",
	y = 15
}
local P2 = {
	text = "P2",
	y = 75
}

local p1character = {
	rawtext = "Select Boss Character: ",
	rawx = interactivegui.boxxhalflength,
	y = P1.y + 10,
	olcolour = colour.olcolour,
	info = "Force Select a Boss Character for P1 at Character Select",
	func = function()
		if P1SelectCharacter then
			changePageAndSelection("p1character", P1SelectCharacter-CURFUE+2)
		else
			changePageAndSelection("p1character", 1)
		end
	end,
	autofunc = function(this)
		if P1SelectCharacter then
			this.bgcolour = colour.booltrue
			this.text = this.rawtext..characterdata[P1SelectCharacter]
		else
			this.text = this.rawtext.."Off"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end,
}

local p2character = {
	rawtext = "Select Boss Character: ",
	rawx = interactivegui.boxxhalflength,
	y = P2.y + 10,
	olcolour = colour.olcolour,
	info = "Force Select a Boss Character for P2 at Character Select",
	func = function()
		if P2SelectCharacter then
			changePageAndSelection("p2character", P2SelectCharacter-CURFUE+2)
		else
			changePageAndSelection("p2character", 1)
		end
	end,
	autofunc = function(this)
		if P2SelectCharacter then
			this.bgcolour = colour.booltrue
			this.text = this.rawtext..characterdata[P2SelectCharacter]
		else
			this.text = this.rawtext.."Off"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
	end,
}

guicustompage = {
	title = {
		text = "Asura Blade - Sword of Dynasty Settings"
	},
	P1 = P1,
	P2 = P2,
	guielements.leftarrow,
	guielements.rightarrow,
	p1character,
	p2character
}

do
	local xoffset = p1character.rawx + #p1character.rawtext*LETTER_HALFWIDTH
	local Elements = {
		{
			text = "Off",
			x = xoffset-#"Off"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function(n) return function()
				P1SelectCharacter = nil
				if P1PreviousCharacter then
					wb(pP1Character, P1PreviousCharacter)
				end
			end end
		}
	}
	
	for id, text in pairs(characterdata) do
		table.insert(Elements, {
			text = text,
			x = xoffset-#text*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function(n) return function() 
				if not P1SelectCharacter then
					P1PreviousCharacter = rb(pP1Character)
				end
				P1SelectCharacter = id
			end end
		})
	end

	guipages.p1character = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		p1character.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end

do
	local xoffset = p2character.rawx + #p2character.rawtext*LETTER_HALFWIDTH
	local Elements = {
		{
			text = "Off",
			x = xoffset-#"Off"*LETTER_HALFWIDTH,
			bgcolour = colour.boolfalse,
			selectfunc = function(n) return function()
				P2SelectCharacter = nil
				if P2PreviousCharacter then
					wb(pP2Character, P2PreviousCharacter)
				end
			end end
		}
	}
	
	for id, text in pairs(characterdata) do
		table.insert(Elements, {
			text = text,
			x = xoffset-#text*LETTER_HALFWIDTH,
			bgcolour = colour.booltrue,
			selectfunc = function(n) return function() 
				if not P2SelectCharacter then
					P2PreviousCharacter = rb(pP2Character)
				end
				P2SelectCharacter = id
			end end
		})
	end

	guipages.p2character = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		p2character.y,
		nil,
		nil,
		nil,
		nil,
		true
	)
end