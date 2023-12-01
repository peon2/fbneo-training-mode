---------------------------------------------------------------------------
--Most of this comes from the current HFTF training mode written by Maxie. 
--https://github.com/maximusmaxy/JoJoban-Training-Mode-Menu-FBNeo

local boxCache = {}

local rb = memory.readbyte
local rbs = memory.readbytesigned
local rw = memory.readword
local rws = memory.readwordsigned

local hitboxOffsets = {
	0x61DEE9E, --Jotaro
	0x61E0FCA, --Kakyoin
	0x61E52DC, --Avdol
	0x61E73A2, --Pol
	0x61EA1EA, --Old Joseph
	0x61EF37E, --Iggy
	0x61F18B2, --Alessi
	0x61F45D2, --Chaka
	0x61F66EA, --Devo
	0x61F9372, --Ndoul
	0x61FC7B8, --Midler
	0x61FDB7E, --DIO
	0x61FFE3E, --Ice
	0x62014E2, --Death13
	0x62023EE, --SDio
	0x62043BA, --Young Joseph
	0x620608E, --Hol Horse
	0x6208702, --Iced
	0x620B042, --NKak
	0x620D986, --BPol
	0x620F196, --Petshop
	0x0000000, --???
	0x62104BE, --Mariah
	0x621125C, --Hoingo
	0x6212418, --Rubber
	0x62145B6  --Khan
}

local p1 = {
	character,
	facing,
	stand,
	standFacing,
	standActive,
	hitbox,
	standHitbox,
	x,
	y,
	standX,
	standY,
}

p1.memory = {  --0x203488C
	character = 0x203489F,
	facing = 0x2034899,
	stand = 0x2034A1F,
	standFacing = 0x20350D9,
	standActive = 0x02034A20,
}

p1.memory2 = {
	hitbox = 0x02034938, --AC
	standHitbox = 0x2035178,
	x = 0x20348E8,
	y = 0x20348EC,
	standX = 0x2035128,
	standY = 0x203512C
}

local p2 = {
	character,
	facing,
	stand,
	standFacing,
	standActive,
	hitbox,
	standHitbox,
	x,
	y,
	standX,
	standY,
}

p2.memory = { 
	character = 0x2034CBF,
	facing = 0x2034CB9,
	stand = 0x02034E3F,
	standFacing = 0x020354F9,
	standActive = 0x02034E40,
}

p2.memory2 = {
	hitbox = 0x02034D58,
	standHitbox = 0x02035598,
	x = 0x2034D08,
	y = 0x2034D0C,
	standX = 0x2035548,
	standY = 0x203554C,
}

function updateMemory()
	for i, v in pairs(p1.memory) do -- assign memory values to p1
		p1[i] = rb(v)
	end
	
	for i, v in pairs(p1.memory2) do -- assign memory values to p1
		p1[i] = rws(v)
	end
	
	for i, v in pairs(p2.memory) do -- assign memory values to p2
		p2[i] = rb(v)
	end
	
	for i, v in pairs(p2.memory2) do -- assign memory values to p1
		p2[i] = rws(v)
	end
end

local colours = {
	collisionbox = 0x00FF0000,
	hurtbox = 0x0000FF00,
	hitbox = 0xFF000000,
}

local function updateHitboxes()
	updateMemory()
	boxCache = getHitboxes()
end

function getHitboxes()
	local boxData = {{}, {}, {}}

	--local zoomX = rws(0x0205DBAA) / 384
	--local zoomY = rws(0x0205DBAE) / 224
	local screenX = rws(0x0203145C)
	local screenY = rws(0x02031470)

	-- Player 1	
	if p1.stand ~= 1 then
		drawPlayerHitboxes(p1.hitbox, p1.x - screenX, p1.y + screenY, p1.facing, p1.character, boxData)
	end
	if p1.standActive == 1 then
		drawPlayerHitboxes(p1.standHitbox, p1.standX - screenX, p1.standY + screenY, p1.standFacing, p1.character, boxData)
	end

	-- Player 2
	if p2.stand ~= 1 then
		drawPlayerHitboxes(p2.hitbox, p2.x - screenX, p2.y + screenY, p2.facing, p2.character, boxData)
	end
	if p2.standActive == 1 then
		drawPlayerHitboxes(p2.standHitbox, p2.standX - screenX, p2.standY + screenY, p2.standFacing, p2.character, boxData)
	end

	--Projectiles
	for i = 0, 63 do
		local projectile = rb(0x0203848C + i * 0x420 + 0x00)
		if projectile > 0 then
			local pFacing = rb(0x0203848C + i * 0x420 + 0x0D)
			local pChar = rb(0x0203848C + i * 0x420 + 0x13)
			local pHitbox = rw(0x0203848C + i * 0x420 + 0xAC)
			local pX = rws(0x0203848C + i * 0x420 + 0x5C)
			local pY = rws(0x0203848C + i * 0x420 + 0x60)
			drawPlayerHitboxes(pHitbox, pX - screenX, pY + screenY, pFacing, pChar, boxData)
		end
	end

	return boxData
end

function drawPlayerHitboxes(hitbox, x, y, facing, character, data)
	if hitbox == 0 then return end

	

	local hitboxOffset = hitboxOffsets[character + 1] + hitbox * 0x10
	
	local atk1 = rws(hitboxOffset)
	local atk2 = rws(hitboxOffset + 0x02)
	local head = rws(hitboxOffset + 0x04)
	local torso = rws(hitboxOffset + 0x06)
	local legs = rws(hitboxOffset + 0x08)
	local col = rws(hitboxOffset + 0x0A)
	
	local flip = facing == 1 and -1 or 1

	y = 460 - y

	local boxOffset = 0x6700000 + character * 0x1002

	drawbox2(atk1, boxOffset, x, y, flip, colours.hitbox, data, 3)
	drawbox2(head, boxOffset, x, y, flip, colours.hurtbox, data, 2)
	drawbox2(torso, boxOffset, x, y, flip, colours.hurtbox, data, 2)
	drawbox2(legs, boxOffset, x, y, flip, colours.hurtbox, data, 2)
	drawbox2(col, boxOffset, x, y, flip, colours.collisionbox, data, 1)
end

function drawbox(adr, x, y, flip, color)
	local boxx1 = x + rws(adr) * flip
	local boxxrad = boxx1 + rw(adr + 0x02) * flip
	local boxy1 = y - rws(adr + 0x04)
	local boxyrad = boxy1 - rw(adr + 0x06)
	gui.box(boxx1,boxy1,boxxrad,boxyrad,color)
end

function drawbox2(i, offset, x, y, flip, color, data, layer)
	if i == 0 then return end
	
	local scale = rws(0x0205DDC2) -- scaling factor for sprites and stuff
	scale = 0x40/(scale or 0x40)
	
	if (scale~=1) then
		x = x*scale+200-(200*scale) -- 0.8 is the final scaling factor
		y = y*scale+250-(250*scale) -- needs these offsets to scale slower so the hitboxes don't jump
	end
	
	local boxx1 = x + rws(offset + i * 0x08 + 0x02)*scale * flip
	local boxxrad = boxx1 + rw(offset + i * 0x08 + 0x04)*scale * flip
	local boxy1 = y - rws(offset + i * 0x08 + 0x06)*scale
	local boxyrad = boxy1 - rw(offset + i * 0x08 + 0x08)*scale
	table.insert(data[layer], { boxx1, boxy1, boxxrad, boxyrad, color })
end

local display = true

togglehitboxdisplay = function() display = not display end

input.registerhotkey(3, togglehitboxdisplay) -- Has to be here or script crashes

function drawHitboxes()
	if not display then return end
	
	for layer = 1, 3 do
		local dataLayer = boxCache[layer]
		for i = 1, #dataLayer do
			gui.box(dataLayer[i][1], dataLayer[i][2], dataLayer[i][3], dataLayer[i][4], dataLayer[i][5])
		end
	end
end

function hitboxesReg() 
	if hitboxes.enabled then
		drawHitboxes()
	end
end

function hitboxesRegAfter()
	updateHitboxes()
end
