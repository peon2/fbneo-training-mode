assert(rb,"Run fbneo-training-mode.lua")

local function getColourDelta(colour, colour2, period)
	local m_red, m_green, m_blue, m_alpha = 0xFF000000, 0x00FF0000, 0x0000FF00, 0x000000FF
	local delta_r = (AND(colour, m_red) - AND(colour2, m_red))/period
	local delta_g = (AND(colour, m_green) - AND(colour2, m_green))/period
	local delta_b = (AND(colour, m_blue) - AND(colour2, m_blue))/period
	local delta_a = (AND(colour, m_alpha) - AND(colour2, m_alpha))/period
	return delta_r, delta_g, delta_b, delta_a
end

local function stub()
end

local function plaingradient()
	local period = interactivegui.boxy2-interactivegui.boxy
	local m_red, m_green, m_blue = 0xFF000000, 0x00FF0000, 0x0000FF00
	local delta_r, delta_g, delta_b = getColourDelta(interactivegui.background.colour5, interactivegui.background.colour1, period)
	for i = interactivegui.boxy+1, interactivegui.boxy2-1 do
		local factor = i - interactivegui.boxy+1
		local red = AND(delta_r * factor, m_red)
		local green = AND(delta_g * factor, m_green)
		local blue = AND(delta_b * factor, m_blue)
		local colour = red + green + blue + 0xFF
		gui.line(interactivegui.boxx+1, i, interactivegui.boxx2-1, i, colour)
	end
end

local function gradienthalfalpha(alpha)
	local period = interactivegui.boxy2-interactivegui.boxy
	local m_red, m_green, m_blue = 0xFF000000, 0x00FF0000, 0x0000FF00
	local delta_r, delta_g, delta_b = getColourDelta(interactivegui.background.colour5, interactivegui.background.colour1, period)
	for i = interactivegui.boxy+1, interactivegui.boxy2-1 do
		local factor = i - interactivegui.boxy+1
		local red = AND(delta_r * factor, m_red)
		local green = AND(delta_g * factor, m_green)
		local blue = AND(delta_b * factor, m_blue)
		local colour = red + green + blue + alpha
		gui.line(interactivegui.boxx+1, i, interactivegui.boxx2-1, i, colour)
	end
end

local function gradientalpha()
	local period = interactivegui.boxy2-interactivegui.boxy
	local m_red, m_green, m_blue, m_alpha = 0xFF000000, 0x00FF0000, 0x0000FF00, 0x000000FF
	local delta_r, delta_g, delta_b, delta_a = getColourDelta(interactivegui.background.colour5, interactivegui.background.colour1, period)
	for i = interactivegui.boxy+1, interactivegui.boxy2-1 do
		local factor = i - interactivegui.boxy+1
		local red = AND(delta_r * factor, m_red)
		local green = AND(delta_g * factor, m_green)
		local blue = AND(delta_b * factor, m_blue)
		local alpha = AND(delta_a * factor, m_alpha)
		local colour = red + green + blue + alpha
		gui.line(interactivegui.boxx+1, i, interactivegui.boxx2-1, i, colour)
	end
end

local function gradient()
	if (interactivegui.background.variant == 1) then
		plaingradient()
	elseif (interactivegui.background.variant <= 4) then
		gradienthalfalpha(0xFF-0x40*(interactivegui.background.variant-1))
	elseif (interactivegui.background.variant == 5) then
		gradientalpha()
	else
		plaingradient()
	end
end

local function onecorner()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	
	for i = 1, interactivegui.boxxmid-interactivegui.boxx do
		local yoffset = math.floor(i*interactivegui.boxfactor)
		gui.line(leftxoffset, topyoffset+yoffset, leftxoffset+i, topyoffset, interactivegui.background.colour1) -- top left
	end

	gui.writepixel(leftxoffset, topyoffset, interactivegui.background.colour1)
end

local function twocorners()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	
	for i = 1, interactivegui.boxxmid-interactivegui.boxx do
		local yoffset = math.floor(i*interactivegui.boxfactor)
		gui.line(leftxoffset, topyoffset+yoffset, leftxoffset+i, topyoffset, interactivegui.background.colour1) -- top left
		gui.line(rightxoffset, bottomyoffset-yoffset, rightxoffset-i, bottomyoffset, interactivegui.background.colour2) -- bottom right
	end
	
	gui.writepixel(leftxoffset, topyoffset, interactivegui.background.colour1) -- top left
	gui.writepixel(rightxoffset, bottomyoffset, interactivegui.background.colour2) -- bottom right
end

local function threecorners()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	
	for i = 1, interactivegui.boxxmid-interactivegui.boxx do
		local yoffset = math.floor(i*interactivegui.boxfactor)
		gui.line(leftxoffset, topyoffset+yoffset, leftxoffset+i, topyoffset, interactivegui.background.colour1) -- top left
		gui.line(rightxoffset, bottomyoffset-yoffset, rightxoffset-i, bottomyoffset, interactivegui.background.colour2) -- bottom right
		gui.line(leftxoffset, bottomyoffset-yoffset, leftxoffset+i, bottomyoffset, interactivegui.background.colour3) -- bottom left
	end
	
	--avoid overlapping
	gui.line(leftxoffset, topyoffset, leftxoffset, interactivegui.boxymid, interactivegui.background.colour1) -- top left
	gui.writepixel(rightxoffset, bottomyoffset, interactivegui.background.colour2) -- bottom right
	gui.line(leftxoffset, bottomyoffset, interactivegui.boxxmid, bottomyoffset, interactivegui.background.colour3) -- bottom left
end

local function fourcorners()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	
	for i = 1, interactivegui.boxxmid-interactivegui.boxx do
		local yoffset = math.floor(i*interactivegui.boxfactor)
		gui.line(leftxoffset, topyoffset+yoffset, leftxoffset+i, topyoffset, interactivegui.background.colour1) -- top left
		gui.line(rightxoffset, bottomyoffset-yoffset, rightxoffset-i, bottomyoffset, interactivegui.background.colour2) -- bottom right
		gui.line(leftxoffset, bottomyoffset-yoffset, leftxoffset+i, bottomyoffset, interactivegui.background.colour3) -- bottom left
		gui.line(rightxoffset, topyoffset+yoffset, rightxoffset-i, topyoffset, interactivegui.background.colour4) -- top right
	end
	
	--avoid overlapping
	gui.line(leftxoffset, topyoffset, leftxoffset, interactivegui.boxymid, interactivegui.background.colour1) -- top left
	gui.line(rightxoffset, bottomyoffset, rightxoffset, interactivegui.boxymid, interactivegui.background.colour2) -- bottom right
	gui.line(leftxoffset, bottomyoffset, interactivegui.boxxmid, bottomyoffset, interactivegui.background.colour3) -- bottom left
	gui.line(rightxoffset, topyoffset, interactivegui.boxxmid, topyoffset, interactivegui.background.colour4) -- top right
end

local function fivecorners()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	
	gui.box(leftxoffset, topyoffset, rightxoffset, bottomyoffset, interactivegui.background.colour5, interactivegui.background.colour5)
	
	for i = 1, interactivegui.boxxmid-interactivegui.boxx do
		local yoffset = math.floor(i*interactivegui.boxfactor)
		gui.line(leftxoffset, topyoffset+yoffset, leftxoffset+i, topyoffset, interactivegui.background.colour1) -- top left
		gui.line(rightxoffset, bottomyoffset-yoffset, rightxoffset-i, bottomyoffset, interactivegui.background.colour2) -- bottom right
		gui.line(leftxoffset, bottomyoffset-yoffset, leftxoffset+i, bottomyoffset, interactivegui.background.colour3) -- bottom left
		gui.line(rightxoffset, topyoffset+yoffset, rightxoffset-i, topyoffset, interactivegui.background.colour4) -- top right
	end
	
	--avoid overlapping
	gui.line(leftxoffset, topyoffset, leftxoffset, interactivegui.boxymid, interactivegui.background.colour1) -- top left
	gui.line(rightxoffset, bottomyoffset, rightxoffset, interactivegui.boxymid, interactivegui.background.colour2) -- bottom right
	gui.line(leftxoffset, bottomyoffset, interactivegui.boxxmid, bottomyoffset, interactivegui.background.colour3) -- bottom left
	gui.line(rightxoffset, topyoffset, interactivegui.boxxmid, topyoffset, interactivegui.background.colour4) -- top right
end

local function corners()
	if (interactivegui.background.variant == 2) then
		twocorners()
	elseif (interactivegui.background.variant == 3) then
		threecorners()
	elseif (interactivegui.background.variant == 4) then
		fourcorners()
	elseif (interactivegui.background.variant == 5) then
		fivecorners()
	else
		onecorner()
	end
end

local function twosections()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	for i = 1, interactivegui.boxx2-interactivegui.boxx-3 do
		local yoffset = math.floor(i*interactivegui.boxfactor)
		gui.line(leftxoffset, topyoffset+yoffset, leftxoffset+i, topyoffset, interactivegui.background.colour1) -- top left
		gui.line(rightxoffset, bottomyoffset-yoffset, rightxoffset-i, bottomyoffset, interactivegui.background.colour2) -- bottom right
	end
	
	gui.writepixel(leftxoffset, topyoffset, interactivegui.background.colour1) -- top left
	gui.writepixel(rightxoffset, bottomyoffset, interactivegui.background.colour2) -- bottom right
	
	gui.line(leftxoffset, bottomyoffset, rightxoffset, topyoffset, interactivegui.background.colour1) -- fill in any missing space
end

local function twosectionsrotate()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	for i = 1, interactivegui.boxx2-interactivegui.boxx-3 do
		local yoffset = math.floor(i*interactivegui.boxfactor)
		gui.line(leftxoffset, bottomyoffset-yoffset, leftxoffset+i, bottomyoffset, interactivegui.background.colour1) -- top left
		gui.line(rightxoffset, topyoffset+yoffset, rightxoffset-i, topyoffset, interactivegui.background.colour2) -- bottom right
	end
	
	gui.writepixel(leftxoffset, topyoffset, interactivegui.background.colour1) -- top left
	gui.writepixel(rightxoffset, bottomyoffset, interactivegui.background.colour2) -- bottom right
	
	gui.line(leftxoffset, topyoffset, rightxoffset, bottomyoffset, interactivegui.background.colour1) -- fill in any missing space
end

local function foursections()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	for i = 1, interactivegui.boxx2-interactivegui.boxx-3 do -- top/bottom
		gui.line(leftxoffset+i, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour1) -- top
		gui.line(leftxoffset+i, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour2) -- bottom
	end
	for i = 1, interactivegui.boxy2-interactivegui.boxy-3 do -- left/right
		gui.line(leftxoffset, topyoffset+i, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour3) -- left
		gui.line(rightxoffset, topyoffset+i, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour4) -- right
	end
	
	gui.line(leftxoffset, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour1) -- top
	gui.line(leftxoffset, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour3) -- left
	gui.line(rightxoffset, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour2) -- bottom
	gui.line(rightxoffset, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour4) -- right
end

local function foursectionsrotate()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	
	gui.box(leftxoffset, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour1, interactivegui.background.colour1)
	gui.box(leftxoffset, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour2, interactivegui.background.colour2)
	gui.box(rightxoffset, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour3, interactivegui.background.colour3)
	gui.box(rightxoffset, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour4, interactivegui.background.colour4)
end

local function sections()
	if (interactivegui.background.variant == 2) then
		twosectionsrotate()
	elseif (interactivegui.background.variant == 3) then
		foursections()
	elseif (interactivegui.background.variant == 4) then
		foursectionsrotate()
	else
		twosections()
	end
end

local function verticalstripes()
	local leftxoffset = interactivegui.boxx+1
	local rightxoffset = interactivegui.boxx2-1
	
	local colours = {
		interactivegui.background.colour1,
		interactivegui.background.colour1,
		interactivegui.background.colour2,
		interactivegui.background.colour2,
		interactivegui.background.colour3,
		interactivegui.background.colour3,
		interactivegui.background.colour4,
		interactivegui.background.colour4,
		interactivegui.background.colour5,
		interactivegui.background.colour5,
	}
	
	local modulo = (interactivegui.background.variant+1)*2
	for i = math.floor(interactivegui.boxy)+1, math.floor(interactivegui.boxy2)-1 do
		local colour = colours[1+i%modulo]
		gui.line(leftxoffset, i, rightxoffset, i, colour)
	end
end

local function horizontalstripes()
	local topyoffset = interactivegui.boxy+1
	local bottomyoffset = interactivegui.boxy2-1

	local colours = {
		interactivegui.background.colour1,
		interactivegui.background.colour1,
		interactivegui.background.colour2,
		interactivegui.background.colour2,
		interactivegui.background.colour3,
		interactivegui.background.colour3,
		interactivegui.background.colour4,
		interactivegui.background.colour4,
		interactivegui.background.colour5,
		interactivegui.background.colour5,
	}

	local modulo = (interactivegui.background.variant-3)*2 -- first one should be variant 5

	for i = interactivegui.boxx+1, interactivegui.boxx2-1 do
		local colour = colours[1+i%modulo]
		gui.line(i, topyoffset, i, bottomyoffset, colour)
	end
end

local function stripes()
	if (interactivegui.background.variant >= 5) then
		horizontalstripes()
	else
		verticalstripes()
	end
end

local function depthextra()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	
	local colours = {
		interactivegui.background.colour1,
		interactivegui.background.colour1,
		interactivegui.background.colour2,
		interactivegui.background.colour2,
		interactivegui.background.colour3,
		interactivegui.background.colour3,
		interactivegui.background.colour4,
		interactivegui.background.colour4,
		interactivegui.background.colour5,
		interactivegui.background.colour5,
	}
	
	local modulo = (interactivegui.background.variant+1)*2
	
	gui.line(leftxoffset, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour1)
	gui.line(leftxoffset, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour1)
	gui.line(rightxoffset, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour1)
	gui.line(rightxoffset, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour1)
	
	for i = 1, interactivegui.boxxmid do
		local colour = colours[1+i%modulo]
		gui.line(leftxoffset+i, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, colour)
		gui.line(leftxoffset+i, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, colour)
		gui.line(rightxoffset-i, topyoffset, interactivegui.boxxmid, interactivegui.boxymid, colour)
		gui.line(rightxoffset-i, bottomyoffset, interactivegui.boxxmid, interactivegui.boxymid, colour)
	end
	
	for i = 1, interactivegui.boxymid do
		local colour = colours[1+i%modulo]
		gui.line(leftxoffset, topyoffset+i, interactivegui.boxxmid, interactivegui.boxymid, colour)
		gui.line(leftxoffset, bottomyoffset-i, interactivegui.boxxmid, interactivegui.boxymid, colour)
		gui.line(rightxoffset, topyoffset+i, interactivegui.boxxmid, interactivegui.boxymid, colour)
		gui.line(rightxoffset, bottomyoffset-i, interactivegui.boxxmid, interactivegui.boxymid, colour)
	end
end

local function moduloextra()
	local leftxoffset = interactivegui.boxx+1
	local topyoffset = interactivegui.boxy+1
	local rightxoffset = interactivegui.boxx2-1
	local bottomyoffset = interactivegui.boxy2-1
	
	local modulo = interactivegui.background.variant+2
	
	for i = leftxoffset, rightxoffset-1 do
		gui.line(i, topyoffset+i%modulo, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour1)
		gui.line(i, bottomyoffset-i%modulo, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour2)
	end
	for i = topyoffset, bottomyoffset-1 do
		gui.line(leftxoffset+i%modulo, i, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour3)
		gui.line(rightxoffset-i%modulo, i, interactivegui.boxxmid, interactivegui.boxymid, interactivegui.background.colour4)
	end
end

local function extras()
	if (interactivegui.background.variant <= 4) then
		depthextra()
	else
		moduloextra()
	end
end

BACKGROUND = { -- Name, function, number of variants available
	{"None", stub, 1},
	{"Gradient", gradient, 5},
	{"Corners", corners, 5},
	{"Sections", sections, 4},
	{"Stripes", stripes, 8},
	{"Extras", extras, 8},
}

for i, v in ipairs(BACKGROUND) do
	BACKGROUND[v[1]] = i
end

MAX_BACKGROUND_VARIANTS = 9

function drawBackground()
	BACKGROUND[interactivegui.background.style][2]()
end