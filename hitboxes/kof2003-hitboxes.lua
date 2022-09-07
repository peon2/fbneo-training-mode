-- peon2: don't know the original author of this script

local rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

attkcolor = {0xFF,0x00,0x00,0x00}
blckcolor = {0xFF,0xFF,0xFF,0x00}
hurtcolor = {0x77,0x77,0xFF,0x00}
prjecolor = {0xEE,0x00,0xDD,0x00}
pushcolor = {0x00,0xFF,0x00,0x00}
thrwcolor = {0xFF,0xFF,0x10,0x00}

a,g,v,p,u,c = attkcolor,blckcolor,hurtcolor,prjhcolor,pushcolor,throw

boxes = {
--  0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f
	u,v,v,v,v,v,v,v,v,0,v,v,v,0,v,p,
	p,p,0,p,p,p,p,p,p,p,0,0,g,g,g,0,--0x10
	a,a,a,a,0,0,0,0,a,a,a,a,a,a,a,0,--0x20
	0,0,0,a,a,a,a,a,a,a,a,a,a,a,a,a,--0x30
	a,a,a,a,a,a,a,a,a,a,0,a,a,0,0,0,--0x40
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,--0x50
	a,a,a,a,a,0,a,0,0,0,0,0,0,0,0,0,--0x60  60&61 are counter but appear as attack as well
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,--0x70
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,--0x80
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,--0x90
	0,a,0,0,0,0,0,0,a,0,0,0,0,0,0,0,--0xA0
	0,0,0,a,a,a,0,0,0,a,a,a,0,a,a,0,--0xB0
	0,a,0,a,0,0,0,a,a,0,0,a,a,a,0,0,--0xC0
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,--0xD0
	a,a,0,0,0,0,0,0,0,0,0,0,0,0,0,0,--0xE0
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 --0xF0
--  0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f
}



function main()
camx = rw(0x1087bc) + 8
camy = rw(0x1087C0) + 7
pladr = 0x107D1C - 0x04
	for players = 0,15,1 do
	pladr = pladr + 0x04
	if rd(pladr) ~= 0xFFFFFFFF or 0 then
	playerdata(rd(pladr))
	end
	end
end

function playerdata(padr)
	if rw(padr)~=2 and rw(padr)~=3 then return end -- peon2: only show player related hitboxes
	local px = rw(padr + 0x24) - camx
	local py = 200 - rw(padr + 0x28) + camy
	local active = rb(padr + 0x4f)
	local pflip = bit.band(rb(padr + 0x0f),0x02)
	
	if pflip == 2 then
	flip = 1
	else
	flip = -1
	end
	--gui.text(8,8,flip)
	colbox(px,py,padr+0xB8,flip,1)--Push Box
	colbox(px,py,padr+0xA0,flip,bit.band(active,0x1))
	colbox(px,py,padr+0xA6,flip,bit.band(active,0x2)/2)
	colbox(px,py,padr+0xAC,flip,bit.band(active,0x4)/4)
	colbox(px,py,padr+0xB2,flip,bit.band(active,0x8)/8)
	
	drawaxis(px,py,6,"white")
end

function drawaxis(x,y,axis,color)
gui.line(x+axis,y,x-axis,y,color)
gui.line(x,y+axis,x,y-axis,color)

end

function colbox(plx,ply,adr,flp,act)
	id = rb(adr)
	x = (rbs(adr + 0x2)*2)*flip
	y = ply - rbs(adr + 0x3)*2
	w = rb(adr + 0x4)
	h = rb(adr + 0x5)

	lft = plx + (x-w)
	top = (y-h)
	rgt = plx + (x+w)
	btm = (y+h)
	
	if act == 1 then
	gui.box(lft,top,rgt,btm,boxes[id+1])
	--gui.text(plx + x,y,string.format("%X",id))
	end
end

--[[ peon2: original driver for stand-alone
gui.register(function()
main()
end)
--]]

function hitboxesReg()
	if hitboxes.enabled then
		main()
	end
end

function hitboxesRegAfter() -- stub
end