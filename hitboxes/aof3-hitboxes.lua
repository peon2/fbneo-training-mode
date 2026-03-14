-- Created by Xenn, edited by peon2 for the fbneo-training-mode

local rbs, rd = memory.readbytesigned, memory.readdword

-----------------------------V Misc Data goes here V-----------------------------

--V Dont mess with these!! V--
local NUM_OF_BOXES = 8
local ATK		= {0x00, 0x01, 0x02, 0x04, 0x05, 0x06, 0x08, 0x09, 0x10, 0x11, 0x13, 0x14, 0x15, 0x16, 0x18, 0x19, 0x1A, 0x20, 0x021, 0x23, 0x025, 0x26, 0x28, 0x2A, 0x2B, 0x2C, 0x30, 0x31, 0x33, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x50, 0x52, 0x53, 0x54, 0x57, 0x58, 0x5E, 0x5F, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x6A, 0x6C, 0x6D}
local Counter 	= {0x81, 0x87, 0x91}
local Invun		= {0x9F}
local Hit		= {0x80, 0x82, 0x83, 0x86, 0x88, 0x89, 0x8C, 0x90, 0x94, 0x96, 0x97, 0x99, 0xA4, 0xA6}
local Parry		= {0x5A, 0x5B, 0x5C, 0x5D, 0x8D, 0x9E, 0xA1}
local ParryArea	= {0x9A, 0x9B, 0x9C, 0x9D}
local Throw		= {0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x4A, 0x51, 0x60, 0x67, 0x68}
--^ Dont mess with these!! ^--

local last_input = {}

local Settings	= 	{
					Draw_ATK 		= true,	--Hitboxes
					Draw_Counter 	= true,	--Counterable Hurtboxes
					Draw_Invun 		= true,	--Invincible Hurtboxes
					Draw_Hit 		= true,	--Hurtboxes
					Draw_Parry 		= true,	--Parry Hitbox
					Draw_ParryArea 	= true,	--Parry Area Box
					Draw_Throw		= true,	--Throwbox
					Draw_Size 		= true,	--Size
					Draw_Axis		= true	--Axis
				}

--V You can change these colors if you wish V--
ATK.Col			= {0xFF000000, 0xFF0000FF}
Counter.Col		= {0x42CAFD00, 0x42CAFDFF}
Invun.Col		= {0xB38FD600, 0xB38FD6FF}
Hit.Col			= {0x0000FF00, 0x0000FFFF}
Parry.Col		= {0xF78E6900, 0xF78E69FF}
ParryArea.Col	= {0xFFF8F000, 0xFFF8F0FF}
Throw.Col		= {0xFFFF0000, 0xFFFF00FF}
SizeCol			= {0x00FF0000, 0x00FF00FF}
--^ You can change these colors if you wish ^--

-----------------------------^ Misc Data goes here ^-----------------------------

local function ZoomDisable()
	memory.writeword(0x104A84,0x00FF)
	memory.writeword(0x104A86,0x00FF)
end

local function ReadObjects(offset)
	--List addresses
	local pOBJStatus= 0x100000 + offset
	-- pOBJType = 0x100001
	-- pOBJTime = 0x100014
	local pOBJName1 = 0x100018 + offset
	local pOBJName2 = 0x10001C + offset
	local pOBJXPos 	= 0x100080 + offset
	local pOBJYAxis = 0x100084 + offset
	local pOBJYPos 	= 0x100088 + offset
	local pOBJFacing= 0x10008C + offset
	
	local pOBJBox 	= 0x1000D0 + offset
	local pOBJBoxF	= 0x1000F0 + offset
	
	local pOBJPBox	= 0x1000F8 + offset
	
	-- Read from RAM
	local obj = {}
	
	obj.Status 	= rb(pOBJStatus)
	obj.Name1 	= rd(pOBJName1)
	obj.Name2 	= rd(pOBJName2)
	obj.XPos 	= rw(pOBJXPos)
	obj.YAxis 	= rw(pOBJYAxis)
	obj.YPos 	= rw(pOBJYPos)
	obj.Facing 	= rb(pOBJFacing) -- seems to always be 1 or 0
	
	-- Do boxes
	for i = 0,NUM_OF_BOXES-1 do
		obj[i] = {}
		local pBox = pOBJBox + i*4
		obj[i].X1 = rbs(pBox+0)
		obj[i].Y1 = rbs(pBox+1)
		obj[i].X2 = rbs(pBox+2)
		obj[i].Y2 = rbs(pBox+3)
		
		obj[i].F = rb(pOBJBoxF + i)
	end
	
	obj.PBoxX1 = rbs(pOBJPBox+0)
	obj.PBoxY1 = rbs(pOBJPBox+1)
	obj.PBoxX2 = rbs(pOBJPBox+2)
	obj.PBoxY2 = rbs(pOBJPBox+3)
	
	return obj
end

local function DrawBoxes(hitbox_type, obj, camera)
	for i = 0,NUM_OF_BOXES-1 do
		for _,v in ipairs(hitbox_type) do
			if obj[i].F == v then
				local XPoint = obj.XPos-4096-camera.X2/3-camera.X
				local YPoint = 240-obj.YAxis-obj.YPos+camera.Y
				
				local X1 = XPoint
				local Y1 = YPoint-(obj[i].Y1*2)
				local X2 = XPoint
				local Y2 = YPoint-(obj[i].Y2*2)
				
				if obj.Facing == 1 then
					X1 = X1-(obj[i].X1*2)-8
					X2 = X2-(obj[i].X2*2)-8
				else
					X1 = X1+(obj[i].X1*2)-8
					X2 = X2+(obj[i].X2*2)-8
				end
				
				gui.box(
					X1,
					Y1,
					X2,
					Y2,
					hitbox_type.Col[1],
					hitbox_type.Col[2]
				)
			end
		end
	end
end

local function Objects()
	for i = 0, 63, 1 do
		
		local camera= {}
		camera.Y 	= rw(0x104A52)
		camera.X 	= rw(0x104A58)
		camera.X2	= rw(0x104A60)
		local obj 	= ReadObjects(i*0x100)

		if obj.Status ~= 0xFF then
			if 	   (obj.Name1 == 0x4D414E2D and obj.Name2 == 0x20503120) --MAN- P1
				or (obj.Name1 == 0x4D414E2D and obj.Name2 == 0x20503220) --MAN- P2
				or (obj.Name1 == 0x54414D41 and obj.Name2 == 0x20503120) --TAMA P1
				or (obj.Name1 == 0x54414D41 and obj.Name2 == 0x20503220) --TAMA P2
				or (obj.Name1 == 0x464C5920 and obj.Name2 == 0x544E4641) --FLY TNFA
				or (obj.Name1 == 0x53534F52 and obj.Name2 == 0x4420424D) --SSORD BM
				or (obj.Name1 == 0x53534F52 and obj.Name2 == 0x44204354) --SSORD CT
				or (obj.Name1 == 0x53534F52 and obj.Name2 == 0x44205450) --SSORD TP
			then
-------------------------------------------------------------------------------------------------------------------------------------------
				if Settings["Draw_Size"] then
					local XPoint = obj.XPos-4096-camera.X2/3-camera.X
					local YPoint = 240-obj.YAxis-obj.YPos+camera.Y
					
					local X1 = XPoint
					local Y1 = YPoint-(obj.PBoxY1*2)
					local X2 = XPoint
					local Y2 = YPoint-(obj.PBoxY2*2)
					
					if obj.Facing == 1 then
						X1 = X1-(obj.PBoxX1*2)-8
						X2 = X2-(obj.PBoxX2*2)-8
					else
						X1 = X1+(obj.PBoxX1*2)-8
						X2 = X2+(obj.PBoxX2*2)-8
					end
					gui.box(
						X1,
						Y1,
						X2,
						Y2,
						SizeCol[1],
						SizeCol[2]
					)
				end
-------------------------------------------------------------------------------------------------------------------------------------------				
				if Settings["Draw_Throw"] then
					DrawBoxes(Throw, obj, camera)
				end

				if Settings["Draw_ParryArea"] then
					DrawBoxes(ParryArea, obj, camera)
				end

				if Settings["Draw_Parry"] then
					DrawBoxes(Parry, obj, camera)
				end

				if Settings["Draw_Hit"] then
					DrawBoxes(Hit, obj, camera)
				end
				
				if Settings["Draw_Invun"] then
					DrawBoxes(Invun, obj, camera)
				end
				
				if Settings["Draw_Counter"] then
					DrawBoxes(Counter, obj, camera)
				end
				
				if Settings["Draw_ATK"] then
					DrawBoxes(ATK, obj, camera)
				end
-------------------------------------------------------------------------------------------------------------------------------------------				
				if Settings["Draw_Axis"] then
					local XPoint = obj.XPos-4096-camera.X2/3-camera.X
					local YPoint = 240-obj.YAxis-obj.YPos+camera.Y
					gui.line(XPoint, YPoint-8, XPoint, YPoint+7,0xFFFFFFFF,0xFFFFFFFF)
					gui.line(XPoint-8, YPoint, XPoint+7, YPoint,0xFFFFFFFF,0xFFFFFFFF)
				end
-------------------------------------------------------------------------------------------------------------------------------------------				
			end
		end
	end
end
--[[
local function Read_Hotkeys()

	local inputs = input.get()

	local toggle_atk = inputs.T and inputs.A
	local toggle_counter = inputs.T and inputs.S
	local toggle_invun = inputs.T and inputs.D
	local toggle_hit = inputs.T and inputs.F
	local toggle_parry = inputs.T and inputs.G
	local toggle_parryarea = inputs.T and inputs.H
	local toggle_throw = inputs.T and inputs.J
	local toggle_size = inputs.T and inputs.K
	local toggle_axis = inputs.T and inputs.L
 
--Toggle Hitboxes 
    if toggle_atk ~= last_input["toggle_atk"] and toggle_atk then
        Settings["Draw_ATK"] = not Settings["Draw_ATK"]
    end
	
--Toggle Counter Hurtboxes
    if toggle_counter ~= last_input["toggle_counter"] and toggle_counter then
        Settings["Draw_Counter"] = not Settings["Draw_Counter"]
    end
	
--Toggle Invincible Hurtboxes
    if toggle_invun ~= last_input["toggle_invun"] and toggle_invun then
        Settings["Draw_Invun"] = not Settings["Draw_Invun"]
    end
 
--Toggle Hurtboxes  
    if toggle_hit ~= last_input["toggle_hit"] and toggle_hit then
        Settings["Draw_Hit"] = not Settings["Draw_Hit"]
    end
	
--Toggle Parry Boxes  
    if toggle_parry ~= last_input["toggle_parry"] and toggle_parry then
        Settings["Draw_Parry"] = not Settings["Draw_Parry"]
    end
	
--Toggle Parry Area Boxes  
    if toggle_parryarea ~= last_input["toggle_parryarea"] and toggle_parryarea then
        Settings["Draw_ParryArea"] = not Settings["Draw_ParryArea"]
    end

--Toggle Throw Boxes  
    if toggle_throw ~= last_input["toggle_throw"] and toggle_throw then
        Settings["Draw_Throw"] = not Settings["Draw_Throw"]
    end
	
--Toggle Size Box  
    if toggle_size ~= last_input["toggle_size"] and toggle_size then
        Settings["Draw_Size"] = not Settings["Draw_Size"]
    end
	
--Toggle Axis 
    if toggle_axis ~= last_input["toggle_axis"] and toggle_axis then
        Settings["Draw_Axis"] = not Settings["Draw_Axis"]
    end
	
	last_input["toggle_atk"] = toggle_atk
	last_input["toggle_counter"] = toggle_counter
    last_input["toggle_invun"] = toggle_invun
    last_input["toggle_hit"] = toggle_hit
	last_input["toggle_parry"] = toggle_parry
	last_input["toggle_parryarea"] = toggle_parryarea
	last_input["toggle_throw"] = toggle_throw
	last_input["toggle_size"] = toggle_size
	last_input["toggle_axis"] = toggle_axis

end

print("Hotkeys are...")
print("T+A:	Toggle Attack Boxes")
print("T+S:	Toggle Counter Boxes")
print("T+D:	Toggle Invunerable Boxes")
print("T+F:	Toggle Hurtboxes")
print("T+G:	Toggle Parry Boxes")
print("T+H:	Toggle Parry Area Boxes")
print("T+J:	Toggle Throw Boxes")
print("T+K:	Toggle Size Box")
print("T+L:	Toggle Axis")

while true do
	ZoomDisable()
	Read_Hotkeys()
	Objects()
	emu.frameadvance();
end
--]]
print("A")
function hitboxesReg()
	if hitboxes.enabled then
		ZoomDisable()
		Objects()
	end
end

function hitboxesRegAfter() end -- stub