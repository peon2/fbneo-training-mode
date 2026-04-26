assert(rb,"Run fbneo-training-mode.lua")

local force32 = {
	text = "Force Level 32 Password",
	rawx = interactivegui.boxxhalflength,
	fillpercent = 0,
	olcolour = "black",
	bgcolour = colour.boolfalse,
	info = "Forces any password you input at char select to be a lvl32 password. Doesn't work if you don't input a password.",
	func = function()
		changeConfig("redearthforce32", not getConfigValue("redearthforce32"))
	end,
	autofunc = function(this)
		if getConfigValue("redearthforce32") then
			this.text = "Force Level 32 Password"
			this.bgcolour = colour.booltrue
		else
			this.text = "Don't Force Level 32 Password"
			this.bgcolour = colour.boolfalse
		end
		this.x = this.rawx-#this.text*LETTER_HALFWIDTH
	end,
}

local orbstr = {"Ice", "Meteor", "Poison", "Fire", "Wind", "Lightning"}
local orbcolours = {0x70C0D0FF, 0x604060FF, 0xA060A0FF, 0xF07000FF, 0x70D050FF, 0xF0E000FF}
local orb = {
	text = "Orb: ",
	rawx = interactivegui.boxxhalflength,
	x = 80,
	y = 45,
	info = "Selects what colour new orbs will be",
	olcolour = colour.olcolour,
	func = function()
		changePageAndSelection("redearthorb", getConfigValue("redearthorb"))
	end,
	autofunc = function(this)
		local orb = getConfigValue("redearthorb")
		this.text = "Orb: "..orbstr[orb]
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
		this.bgcolour = orbcolours[orb]
	end
}

local leo = {
	text = "Leo:",
	x = 2,
	y = 60
}

local swordstr = {"Old Sword", "Bronze Sword", "Steel Sword", "Fire sword", "Ice Sword", "Lightning Sword", "Diamond Sword", "Battleaxe", "Legendary Sword"}
local swordcolours = {0xE08050FF, 0xD0F0E0FF, 0xC8C8C8FF, 0xF09030FF, 0x3030FFFF, 0xE0DB00FF, 0x70D0D0FF, 0x9090A0FF, 0x4A4A4AFF}
local sword = {
	text = "Sword: ",
	rawx = 80,
	x = 60,
	y = leo.y,
	olcolour = colour.olcolour,
	info = "Changes Leo's Sword",
	func = function()
		changePageAndSelection("redearthsword", getConfigValue("redearthsword")+1)
	end,
	autofunc = function(this)
		local sword = getConfigValue("redearthsword") + 1
		this.text = "Sword: "..swordstr[sword]
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
		this.bgcolour = swordcolours[sword]
	end
}

local shieldstr = {"Old Shield", "Wooden Shield", "Steel Shield", "Diamond Shield", "Legendary Shield"}
local shieldcolours = {0x806020FF, 0xFFE040FF, 0xA0C0D0FF, 0x70D0D0FF, 0xFFE040FF, 0xFFFFFFFF}
local shield = {
	text = "Shield: ",
	rawx = 200,
	x = 120,
	y = leo.y,
	olcolour = colour.olcolour,
	info = "Changes Leo's Shield",
	func = function()
		changePageAndSelection("redearthshield", getConfigValue("redearthshield")+1)
	end,
	autofunc = function(this)
		local shield = getConfigValue("redearthshield") + 1
		this.text = "Shield: "..shieldstr[shield]
		this.x = this.rawx - #this.text*LETTER_HALFWIDTH
		this.bgcolour = shieldcolours[shield]
	end
}

guicustompage = {
	title = {
		text = "Red Earth Settings"
	},
	leo = leo,
	guielements.leftarrow,
	guielements.rightarrow,
	force32,
	orb,
	sword,
	shield
}

do
	local xoffset = orb.rawx + #"Orb: "*LETTER_HALFWIDTH
	local Elements = { }
	
	for i, name in ipairs(orbstr) do
		table.insert(Elements, {text = name, x = xoffset - #name*LETTER_HALFWIDTH, bgcolour = orbcolours[i]})
	end

	local sf = function(n) return function() changeConfig("redearthorb", n) end end

	guipages.redearthorb = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		orb.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	local xoffset = sword.rawx + #"Sword: "*LETTER_HALFWIDTH
	local Elements = { }
	
	for i, name in ipairs(swordstr) do
		table.insert(Elements, {text = name, x = xoffset - #name*LETTER_HALFWIDTH, bgcolour = swordcolours[i]})
	end

	local sf = function(n) return function() changeConfig("redearthsword", n-1) end end

	guipages.redearthsword = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		sword.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end

do
	local xoffset = shield.rawx + #"Shield: "*LETTER_HALFWIDTH
	local Elements = { }
	
	for i, name in ipairs(shieldstr) do
		table.insert(Elements, {text = name, x = xoffset - #name*LETTER_HALFWIDTH, bgcolour = shieldcolours[i]})
	end

	local sf = function(n) return function() changeConfig("redearthshield", n-1) end end

	guipages.redearthshield = createPopUpMenu(
		guicustompage,
		Elements,
		nil,
		shield.y,
		nil,
		sf,
		nil,
		nil,
		true
	)
end
