-- quick and dirty port of jedpossum's script (https://github.com/jedpossum/EmuLuaScripts/blob/master/jchan2.lua)

local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

hurtcolor = 0xFFFF0000

local scale = function(var)
	var = var*(0x140/rw(0x200184))
	return var
end

local colbox = function(boxadr,plx,ply,flip,yflip,color)
	if yflip == 0 then
		x = scale(rws(boxadr + 0x0)) * flip + plx 
		w = x + scale(rws(boxadr+ 0x2)) * flip
		y = (scale(rws(boxadr + 0x4)) + ply)
		h = y + scale(rws(boxadr + 0x6))
	else 
		x = scale(rws(boxadr + 0x0)) * flip + plx 
		w = x + scale(rws(boxadr+ 0x2)) * flip
		y = ply - scale(rws(boxadr + 0x4))--Only part messed up maybe calculation for player y changes
		h = y - scale(rws(boxadr + 0x6))
	end
	--gui.drawline(plx,ply,x,y) Debug
	gui.box(x,y,w,h,color)
end

local drawaxis = function(x,y,axis,color)
	gui.line(x+axis,y,x-axis,y,color)
	gui.line(x,y+axis,x,y-axis,color)
end

local hexval = function(val)
	val = string.format("%X",val)
	return val
end

local player = function()
	proadr = 0x2017F0 - 0x7A
	for proj = 0,15,1 do
		proadr = proadr + 0x7A
		local projx = scale(rws(proadr+0x06))
		local projy = scale(rws(proadr+0x0A)) - 16
		drawaxis(projx,projy,8,0xEE00DDFF)
		if proj == 0 then
		--ww(proadr+0x26,0x017C)
		--ww(proadr+0x2A,0x071C)
		end

	end
	dmgscaler = rw(0x200128)

	padr = 0x200F82 - 0x28C
	for p = 0,1,1 do
		padr = padr + 0x28C
		local px = scale(rws(padr + 0x06))
		local flag1 = rb(padr + 0x04)
		local flag2 = rb(padr + 0x0E)
		local flag3 = bit.bxor(flag2,flag1)
		local active = bit.band(flag2,0x40)/0x40
		local pyflip = bit.band(flag3,0x01)
		local pxflip = bit.band(flag3,0x02)
		--Hurt boxes Data
		local id = rw(padr + 0x190)
		local id2 = rw(padr + 0x60)
		local address = rd(0xD6164 + (id*4))
		local address2 = rd(address + (id2*4))
		local loop = rws(address2)
		local boxes = (address2 + 2) -8
		--Attack Boxes
		local atkmath = (loop+1)*8
		local atkaddr = atkmath + address2+4
	
		if pxflip == 0x02 then
			pflip = -1
		else
			pflip = 1
		end
		if pyflip == 1 then
			py = scale(rws(padr + 0x0A)) - scale(210)
		else
			py = scale(rws(padr + 0x0A)) - 16
		end
		
		if active == 0 then
			drawaxis(px,py,scale(8))
	
--Hurt
			if loop >= 0 then 
				for b = 0,loop,1 do
					boxes = boxes + 8
					colbox(boxes,px,py,pflip,pyflip,hurtcolor)
				end
			end
		
--Attack
			if p == 0 then
				if rw(0x2000E6) ~= 0 then
					colbox(atkaddr,px,py,pflip,pyflip,0xFF000000)
				end
			else
				if rw(0x2000E4) ~=0 then
					colbox(atkaddr,px,py,pflip,pyflip,0xFF000000)
				end
			end
		end
	end
end

function hitboxesReg()
	if hitboxes.enabled then
		player()
	end
end

function hitboxesRegAfter()
end
