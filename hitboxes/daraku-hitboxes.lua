-- quick and dirty port of jedpossum's script (https://github.com/jedpossum/EmuLuaScripts/blob/master/Daraku.lua)

local rb, rbs, rw, rws, rd = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword

local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

local axis_length = 8

local scale = function(val) return val*(rw(0x602ddb0)/0x003F) end

local player = function()
	local adr = 0x602DDA0 - 0x200

	for player = 0,1,1 do
		adr = adr + 0x200
		local px = rws(adr + 0xAC)
		local py = rws(adr + 0xAE)

		if rb(adr + 0xB2) == 8 then
			flip = 1
		else
			flip = -1
		end 

		local boxact = rb(adr + 0xF7)

		local pushcheck = bit.band(boxact,0x80)
		local hrt0check = bit.band(boxact,0x40)
		local hrt1check = bit.band(boxact,0x20)
		local hrt2check = bit.band(boxact,0x10)
		local hrt3check = bit.band(boxact,0x08)
		local atk0check = bit.band(boxact,0x04)
		local atk1check = bit.band(boxact,0x02)
		local atk2check = bit.band(boxact,0x01)

		local boxadr = (adr + 0x100) - 8

		for cbox = 0,7,1 do

			boxadr = boxadr + 8

			hrad = scale(rb(boxadr + 6))
			vrad = scale(rb(boxadr + 7))
			hval = scale(rws(boxadr + 2))
			vval = scale(rws(boxadr + 4))

			hval   = px + hval * flip
			vval   = py + vval
			left   = hval - hrad
			right  = hval + hrad
			top    = vval - vrad
			bottom = vval + vrad

			if cbox == 7 then
				if pushcheck == 0x80 then
					gui.box(left,top,right,bottom,0,0x00FF00FF)
				end
			elseif cbox == 6 then
				if hrt0check == 0x40 then
					gui.box(left,top,right,bottom,0,0x0040FFFF)
				end
			elseif cbox == 5 then
				if hrt1check == 0x20 then
					gui.box(left,top,right,bottom,0,0x0040FFFF)
				end
			elseif cbox == 4 then
				if hrt2check == 0x10 then
					gui.box(left,top,right,bottom,0,0x0040FFFF)
				end
			elseif cbox == 3 then
				if hrt3check == 0x08 then
					gui.box(left,top,right,bottom,0,0x0040FFFF)
				end		
			elseif cbox == 2 then
				if atk0check == 0x04 then
					gui.box(left,top,right,bottom,0,0xFF0000FF)
				end		
			elseif cbox == 1 then
				if atk1check == 0x02 then
					gui.box(left,top,right,bottom,0,0xFF0000FF)
				end		
			elseif cbox == 0 then
				if atk2check == 0x01 then
					gui.box(left,top,right,bottom,0,0xFF0000FF)
				end		
			end
		end

		gui.drawline(px,py+axis_length,px,py-axis_length)
		gui.drawline(px+axis_length,py,px-axis_length,py)

	end
end


function hitboxesReg()
	if hitboxes.enabled then
		player()
	end
end

function hitboxesRegAfter()
end
