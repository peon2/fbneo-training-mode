--[[ Adapted from https://github.com/ViviMayoi/fbneo-training-asurabus/blob/frame-data-viewer/hitboxes/asurabus-hitboxes.lua
	Credits to ViviMayoi and Xenn
	Added Asura Blade support
	Edited to work with https://github.com/peon2/fbneo-training-mode/
--]]
-- Used by Asura Buster
local YASHAOU = 0
local CHEN_MAO = 3
local ZAM_B = 4
local SITTARA = 8
local ALICE = 6
local ALICE_OLD = 11

local axisColour = 0xFFFFFFFF
local pushboxBGColour  = 0x00FF0030
local pushboxOLColour = 0x00FF00FF
local hurtboxBGColour  = 0x7777FF30
local hurtboxOLColour = 0x7777FFFF
local hitboxBGColour  = 0xFF000030
local hitboxOLColour = 0xFF0000FF
local clashboxBGColour  = 0xFFFF0030
local clashboxOLColour = 0xFFFF00FF

local pCameraX = 0x00400024

local function drawAxis(xpos, ypos)
	gui.drawline((xpos - 3), ypos, (xpos + 3), ypos, axisColour)
	gui.drawline(xpos, (-3 + ypos), xpos, (3 + ypos), axisColour)
end

local function drawPushbox(xpos, ypos, pPushbox)
	local x1, x2 = rws(pPushbox+0), rws(pPushbox+4)
	if x1==x2 then return end
	local y1, y2 = rws(pPushbox+2), rws(pPushbox+6)
	gui.box(
		xpos + x1,
		ypos + y1,
		xpos + x2,
		ypos + y2,
		pushboxBGColour,
		pushboxOLColour
	)
end

local function drawHurtbox(xpos, ypos, pHurtbox)
	local x1, x2 = rws(pHurtbox+0), rws(pHurtbox+4)
	if x1==x2 then return end
	local y1, y2 = rws(pHurtbox+2), rws(pHurtbox+6)
	gui.box(
		xpos + x1,
		ypos + y1,
		xpos + x2,
		ypos + y2,
		hurtboxBGColour,
		hurtboxOLColour
	)
end

local function drawHitbox(xpos, ypos, pHitbox)
	local x1, x2 = rws(pHitbox+0), rws(pHitbox+4)
	if x1==x2 then return end
	local y1, y2 = rws(pHitbox+2), rws(pHitbox+6)
	gui.box(
		xpos + x1,
		ypos + y1 - 1,
		xpos + x2,
		ypos + y2 - 1,
		hitboxBGColour,
		hitboxOLColour
	)
end

local function drawClashbox(xpos, ypos, pClashbox)
	local x1 = rws(pClashbox+0)
	local y1 = rws(pClashbox+2)
	local x2 = rws(pClashbox+4)
	local y2 = rws(pClashbox+6)
	gui.box(
		xpos + x1,
		ypos + y1 - 1,
		xpos + x2,
		ypos + y2 - 1,
		clashboxBGColour,
		clashboxOLColour
	)
end

local function drawProjectile(character, pHitbox, pData)
	local On     = rbs(pData + 0x0)==1
	local Type   = rbs(pData + 0x1)
	local ID     = rws(pData + 0x2)
	local XPos   = rws(pData + 0x4)
	local YPos   = rws(pData + 0x6)
	local Facing = rbs(pData + 0x8)
	local Time   = rbs(pData + 0xB)
	local Hit    = rbs(pData + 0xF)==1

	if (On and Hit and Type > 0) then
		local drawProjectile = true
		-- Handle special cases for Asura Buster
		if (character == ALICE_OLD) then -- Alice!
			if (ID == 92 and Time > 60) then -- skip 214X inactive frames
				drawProjectile = false
			elseif ((ID == 51 or ID == 95) and (Time < 13 or Time > 21)) then -- 623X is only active on frames 13 to 21 of being on screen
				drawProjectile = false
			elseif (ID == 94 and (Time < 19 or Time > 27)) then -- 623EX and boost 623C final hits are only active on frames 19 to 27 of being on screen
				drawProjectile = false
			end
		elseif (character == ZAM_B and ID == 15) then -- Zam-B 236X ground puddle
			drawProjectile = false
		end
		if drawProjectile then
			drawHitbox(XPos - CameraX + Facing, YPos, pHitbox)
			drawAxis(XPos - CameraX, YPos)
		end
	end
end

local function drawAliceSkulls(alice) -- Asura Buster: Alice! Boost Mode
	for i = 0, 0x20*3, 0x20 do
		local XPos		= rws(alice.pXPos + i)
		local YPos		= rws(alice.pYPos + i)
		local ATK		= rws(alice.pATK + i)
		local Active	= rws(alice.pActive + i)
	
		local axisColor = 0x00000080

		if Active > 0 then
			if ATK > 0 then
				if ATK == 1 then
					if Facing == 0 then
						gui.box(
							XPos - CameraX - 15,
							YPos - 7,
							XPos - CameraX + 15,
							YPos + 6,
							hitboxBGColour,
							hitboxOLColour
						)
					else
						gui.box(
							XPos - CameraX - 16,
							YPos - 7,
							XPos - CameraX + 14,
							YPos + 6,
							hitboxBGColour,
							hitboxOLColour
						)
					end
					axisColor = 0xFFFFFFFF;
				else
					axisColor = 0xFFFF00FF;
				end
				gui.drawline((XPos - CameraX - 3), YPos, (XPos - CameraX + 3), YPos, axisColor)
				gui.drawline(XPos - CameraX, (-3 + YPos), XPos - CameraX, (3 + YPos), axisColor)
			elseif (i <= 0x20) then
				gui.drawline((XPos - CameraX - 3), YPos, (XPos - CameraX + 3), YPos, axisColor)
				gui.drawline(XPos - CameraX, (-3 + YPos), XPos - CameraX, (3 + YPos), axisColor)
			end
		end
	end
end

local function drawCharacter(Character)
	local xpos = rws(Character.pXPos)
	local ypos = rws(Character.pYPos)
	local facing = rws(Character.pFacing)
	local ATKState = rws(Character.pATKState)
	
	if Character.Boxes.pPush then
		drawPushbox(xpos, ypos, Character.Boxes.pPush)
		drawHurtbox(xpos, ypos, Character.Boxes.pPush+0x08)
		drawHurtbox(xpos, ypos, Character.Boxes.pPush+0x10)
	end
	if ATKState > 0 then
		drawHitbox(xpos-facing, ypos, Character.Boxes.pAttack)
		drawHitbox(xpos-facing, ypos, Character.Boxes.pAttack+0x08)
		drawClashbox(xpos-facing, ypos, Character.Boxes.pAttack+0x10)
	end

	drawAxis(xpos, ypos)
end

local AsuraBladeData = {
	P1 = {
		pCharacter = 0x403DD1,
		Player = {
			pXPos = 0x4037EC,
			pYPos = 0x4037EE,
			pFacing = 0x4037F8,
			pATKState = 0x403812,
			Boxes = {
				pAttack = 0x403818,
				pPush = 0x403928
			}
		},
		Projectile = {
			pData = 0x403DDA,
			Boxes = {
				pAttack = 0x404562
			}
		},
	},
	P2 = {
		pCharacter = 0x404B85,
		Player = {
			pXPos = 0x4045A0,
			pYPos = 0x4045A2,
			pFacing = 0x4045AC,
			pATKState = 0x4045C6,
			Boxes = {
				pAttack = 0x4045CC,
				pPush = 0x4046DC
			}
		},
		Projectile = {
			pData = 0x0404B8E,
			Boxes = {
				pAttack = 0x405316
			}
		},
	}
}

local function DrawAsuraBladeHitboxes()
	CameraX = rws(pCameraX)
	for _, player in pairs(AsuraBladeData) do
		for i = 0, 31 do
			drawProjectile(99, player.Projectile.Boxes.pAttack, player.Projectile.pData+i*0x10) -- only Buster has projectile exceptions
		end

		drawCharacter(player.Player)
	end
end

 -- These addresses are hardcoded in Program ROM rather than calculated
local AsuraBusterData = {
	P1 = {
		pCharacter = 0x4039A6,
		pBoost = 0x403F56,
		Player = {
			pXPos = 0x4033CE,
			pYPos = 0x4033D0,
			pFacing = 0x4033DA,
			pATKState = 0x4033F0,
			Boxes = {
				pAttack = 0x4033F6,
				pPush = 0x403504,
			}
		},
		DMW = {
			pXPos = 0x404D42,
			pYPos = 0x404D44,
			pFacing = 0x404D4E,
			pATKState = 0x404D64,
			Boxes = {
				pAttack = 0x404D6A,
			}
		},
		Projectile = {
			pData = 0x4039B0,
			DataSize = 0x10,
			DataCount = 32,
			Boxes = {
				pAttack = 0x404030
			}
		},
		Alice = {
			pXPos = 0x403E74,
			pYPos = 0x403E76,
			pATK = 0x403E7C,
			pActive = 0x403E92,
		}
	},
	P2 = {
		pCharacter = 0x404666,
		pBoost = 0x404C16,
		Player = {
			pXPos = 0x404084,
			pYPos = 0x404086,
			pFacing = 0x404090,
			pATKState = 0x4040A8,
			Boxes = {
				pAttack = 0x4040AE,
				pPush = 0x4041BE,
			}
		},
		DMW = {
			pXPos = 0x4059E2,
			pYPos = 0x4059E4,
			pFacing = 0x4059EE,
			pATKState = 0x405A04,
			Boxes = {
				pAttack = 0x405A0A,
			}
		},
		Projectile = {
			pData = 0x404670,
			DataSize = 0x10,
			DataCount = 32,
			Boxes = {
				pAttack = 0x404CF0
			}
		},
		Alice = {
			pXPos = 0x404B34,
			pYPos = 0x404B36,
			pATK = 0x404B3C,
			pActive = 0x404B52,
		}
	}
}

local function DrawAsuraBusterHitboxes()
	CameraX = rws(pCameraX)
	for _, player in pairs(AsuraBusterData) do
		local Character = rws(player.pCharacter)
		local InBoost = rws(player.pBoost) ~= 0

		for i = 0, 31 do
			drawProjectile(Character, player.Projectile.Boxes.pAttack, player.Projectile.pData+i*0x10)
		end

		--Alice! Boost Mode Skulls
		if (InBoost and Character == ALICE_OLD) then
			drawAliceSkulls(player.Alice)
		end

		drawCharacter(player.Player)

		-- Draw DMW/Afterimages Boxes
		if Character == ALICE or ((Character == YASHAOU or Character == CHEN_MAO or Character == SITTARA) and InBoost) then
			drawCharacter(player.DMW)
		end
	end
end

local ROM = emu.parentname()
if (not ROM or ROM == "0") then
	ROM = emu.romname()
end
if ROM == "asurabld" then
	drawHitboxes = DrawAsuraBladeHitboxes
elseif ROM == "asurabus" then
	drawHitboxes = DrawAsuraBusterHitboxes
else
	assert(false, "This script is only designed to work with Asura Blade and Asura Buster not "..ROM)
end