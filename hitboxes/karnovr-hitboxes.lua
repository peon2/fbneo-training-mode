--FHD Hitbox Viewer
--By jedpossum
--https://github.com/jedpossum/EmuLuaScripts/blob/master/FHD%20Hitbox%20Viewer.lua

local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

axis_length = 8
function players()
if rb(0x101003) == 0x03 then 
camx = 8 + rw(0x103424)
camy = 8 - rw(0x106924)

--Timercheat
-- wb(0x103A70,0x63)

adr = 0x103670 - 0x200
for pl = 0,1,1 do
	adr = adr + 0x200
	local cell = rw(adr + 0x22)
	boxtable = 0x37014
	local plife = adr + 0x147
	local plifegfx = adr + 0x148
	local px = rw(adr + 0xc0) - camx
	local py =  224 - rw(adr + 0xC4) - camy
	local flipp = bit.band(rb(adr + 0x21),0x01)
	if flipp == 1 then
		pflip = -1
	else
		pflip = 1
	end

	local life = rb(plife)--Some bug prevents just using rb(plife)	
	
	--gui.text(26+pl*236,30,"Life: " .. life)

--Health Cheat
-- if rb(plife) <= 32 then
-- wb(plife,0xFF)
-- wb(plifegfx,0xFF)
-- end
	
--Boxes
	boxadr = ((cell* 0x30)+boxtable) - 0x04
	
	for i = 0,9,1 do

	boxadr = boxadr + 0x04
	
	if i == 00 then
		colbox(boxadr,px,py,0x00ff0020,pflip)
		elseif i <= 6 and i ~=0 then
		colbox(boxadr,px,py,0x0040ff40,pflip)
		elseif i == 0x07 then
		colbox(boxadr,px,py,0xFF880040,pflip)
		elseif i == 0x08 then
		colbox(boxadr,px,py,0xFF000040,pflip)
		elseif i == 0x09 then
		colbox(boxadr,px,py,0xFFFF0040,pflip)
	end
	
		gui.drawline(px,py+axis_length,px,py-axis_length)
		gui.drawline(px+axis_length,py,px-axis_length,py)
	end
end

	end
end

function projectiles()
--[[
 p1 1037A0 off set p2
 writes what fireball is being written in fireball memory
 
]]

if rb(0x101003) == 0x03 then 
	projmem = 0x1064F0 - 0x40
		for pj = 0,1,1 do
			projmem = projmem + 0x40
			projtable = 0x015CF2
			id = rb(projmem) * 8
			
			local pjx = rw(projmem + 0x10) - camx
			local pjy = 224 - rw(projmem + 0x14) - camy
			
			if rb(projmem + 0x0D) == 1 then
				pf = -1
				else
				pf = 1
			end
			
			--Boxes
			mess = projtable+id
			colbox(mess+pj*4,pjx,pjy,0xee00dd20,pf)
			
			--Axis
			gui.drawline(pjx,pjy+axis_length,pjx,pjy-axis_length)
			gui.drawline(pjx+axis_length,pjy,pjx-axis_length,pjy,0xff0000ff)

		end
	end
end

function hitedit()
--old ass code
if rb(0x101003) == 0x05 then -- If hit editor is active
px = rw(0x1037D0)
py = rw(0x1037D2) - 0x90

	gui.drawline(px,py+axis_length,px,py-axis_length)
	gui.drawline(px+axis_length,py,px-axis_length,py)
adr = 0x1037A4 - 4

for i = 0,9,1 do
adr = adr + 0x04
hrad = rb(adr + 2)
vrad = rb(adr + 3)
hval = rbs(adr + 0)
vval = rbs(adr + 1)

		hval   = px + hval 
        vval   = py + vval
        left   = hval - hrad
        right  = hval + hrad
        top    = vval - vrad
        bottom = vval + vrad

gui.box(left,top,right,bottom,0x00ff0000)
--gui.text(40,120,left .. "," .. top.. "," .. right.. "," .. bottom,0xff800080)
		end
	end
end

function colbox(adr,x,y,color,flip)

local hrad = rb(adr + 2)
local vrad = rb(adr + 3)
local hval = rbs(adr + 0)
local vval = rbs(adr + 1)

		hval   = x + hval * flip
        vval   = y + vval
        left   = hval - hrad
        right  = hval + hrad
        top    = vval - vrad
        bottom = vval + vrad
	
	if vrad ~= 0x00 then
		gui.box(left,top,right,bottom,color)
	end
end

function hex(val)
        val = string.format("%X",val)
        return val
end

function hitboxesReg()
	if hitboxes.enabled then
		players()
		projectiles()
		--hitedit()
	end
end

function hitboxesRegAfter() end
