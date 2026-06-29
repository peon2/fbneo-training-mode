---------------------------------------------------------------------------
--Most of this comes from the current HFTF training mode written by Maxie. 
--https://github.com/maximusmaxy/JoJoban-Training-Mode-Menu-FBNeo
--JoJo and HFTF now work with the same hitbox script
--Edited to work with https://github.com/peon2/fbneo-training-mode/

local boxCache = {}

local colours = {
	collisionbox = 0x00FF0000,
	hurtbox = 0x0000FF00,
	hitbox = 0xFF000000,
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

local pP1HitboxOffset, pP2HitboxOffset
local pScale
local pScreenX, pScreenY
local pProjectileTable
local ProjectileDataSize

local function updateMemory()
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
	p1.hitboxOffset = rdw(pP1HitboxOffset)
	p2.hitboxOffset = rdw(pP2HitboxOffset)
end

local function drawbox(adr, x, y, flip, color)
	local boxx1 = x + rws(adr) * flip
	local boxxrad = boxx1 + rw(adr + 0x02) * flip
	local boxy1 = y - rws(adr + 0x04)
	local boxyrad = boxy1 - rw(adr + 0x06)
	gui.box(boxx1,boxy1,boxxrad,boxyrad,color)
end

local function drawbox2(i, offset, x, y, flip, color, data, layer)
	if i == 0 then return end
	
	local scale = rws(pScale) -- scaling factor for sprites and stuff
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

local function drawPlayerHitboxes(offset, hitbox, x, y, facing, character, data)
	if hitbox == 0 then return end

	local hitboxOffset = offset + hitbox * 0x10
	
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

local function getHitboxes()
	local boxData = {{}, {}, {}}
	local screenX = rws(pScreenX)
	local screenY = rws(pScreenY)

	-- Player 1
	if p1.stand ~= 1 then
		drawPlayerHitboxes(p1.hitboxOffset, p1.hitbox, p1.x - screenX, p1.y + screenY, p1.facing, p1.character, boxData)
	end
	if p1.standActive == 1 then
		drawPlayerHitboxes(p1.hitboxOffset, p1.standHitbox, p1.standX - screenX, p1.standY + screenY, p1.standFacing, p1.character, boxData)
	end

	-- Player 2
	if p2.stand ~= 1 then
		drawPlayerHitboxes(p2.hitboxOffset, p2.hitbox, p2.x - screenX, p2.y + screenY, p2.facing, p2.character, boxData)
	end
	if p2.standActive == 1 then
		drawPlayerHitboxes(p2.hitboxOffset, p2.standHitbox, p2.standX - screenX, p2.standY + screenY, p2.standFacing, p2.character, boxData)
	end

	--Projectiles
	for i = 0, 63 do
		local pProjectile = pProjectileTable + i * ProjectileDataSize
		local projectile = rb(pProjectile)
		if projectile > 0 then
			local pFacing = rb(pProjectile + 0x0D)
			local pChar = rb(pProjectile + 0x13)
			local pHitbox = rw(pProjectile + 0xAC)
			local pX = rws(pProjectile + 0x5C)
			local pY = rws(pProjectile + 0x60)
			local offset = rdw(pProjectile + 0xCC)
			drawPlayerHitboxes(offset, pHitbox, pX - screenX, pY + screenY, pFacing, pChar, boxData)
		end
	end

	return boxData
end

local ROM = emu.parentname()
if (not ROM or ROM == "0") then
	ROM = emu.romname()
end
if ROM == "jojo" then
	p1.memory = {  --203046C, 2030C7C
		character = 0x203047F,
		facing = 0x2030479,
		stand = 0x20305FF,
		standFacing = 0x2030C89,
		standActive = 0x2030600,
	}

	p1.memory2 = {
		hitbox = 0x2030518,
		standHitbox = 0x2030D28,
		x = 0x20304C8,
		y = 0x20304CC,
		standX = 0x2030CD8,
		standY = 0x2030CDC
	}

	p2.memory = { --2030874, 2031084
		character = 0x2030887,
		facing = 0x2030881,
		stand = 0x2030A07,
		standFacing = 0x2031091,
		standActive = 0x2030A08,
	}

	p2.memory2 = {
		hitbox = 0x2030920,
		standHitbox = 0x2031130,
		x = 0x20308D0,
		y = 0x20308D4,
		standX = 0x20310E0,
		standY = 0x20310E4,
	}
	pP1HitboxOffset = 0x2030538
	pP2HitboxOffset = 0x2030940
	pScale = 0x02058222
	pScreenX = 0x0202D058
	pScreenY = 0x0202D06C
	pProjectileTable = 0x0203400C
	ProjectileDataSize = 0x408
elseif ROM == "jojoba" then
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
	pP1HitboxOffset = 0x2035198
	pP2HitboxOffset = 0x20355B8
	pScale = 0x0205DDC2
	pScreenX = 0x0203145C
	pScreenY = 0x02031470
	pProjectileTable = 0x0203848C
	ProjectileDataSize = 0x420
else
	assert(false, "This script is only designed to work with JoJo's Venture and JoJo's Bizarre Adventure: Heritage for the Future not "..ROM)
end

function drawHitboxes()
	for layer = 1, 3 do
		local dataLayer = boxCache[layer]
		for i = 1, #dataLayer do
			gui.box(unpack(dataLayer[i]))
		end
	end
end

function updateHitboxes()
	updateMemory()
	boxCache = getHitboxes()
end