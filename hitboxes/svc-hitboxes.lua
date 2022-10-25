-- peon2: don't know the original author of this script, but I think it's Mountainmanjed

--SVC script
local rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
local wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

attkcolor = {0xFF,0x00,0x00,0x00}
blckcolor = {0xFF,0xFF,0xFF,0x00}
hurtcolor = {0x77,0x77,0xFF,0x00}
prjecolor = {0xEE,0x00,0xDD,0x00}
pushcolor = {0x00,0xFF,0x00,0x00}

a,g,v,p = attkcolor,blckcolor,hurtcolor,prjecolor

--Table taken from the kof scripts could have some wrong data. Seems right mostly 
boxes = {
	v,v,v,v,v,v,v,v,v,g,g,a,a,a,a,a,
	a,a,a,a,a,a,v,a,a,a,a,a,a,a,a,a,
	a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,
	a,a,a,a,a,a,a,g,g,p,p,p,p,p,p}
--  0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f

function main()
padr = 0x10A100

camx = rw(0x10B4CE) + 8
camy = rw(0x10B4D6)

for test = 0,15,1 do
data(0x101000 + test*0x280)
end

for p = 0,1,1 do
	padr = padr + p*0x280
	
	local px = rw(padr + 0x18) - camx
	local py = 204 - rw(padr + 0x20) + camy
	
	local flipx =  rb(padr + 0x31)
	--[[ peon2: don't need these for the training mode
	local meter = rw(padr + 0xE8)
	local life = rw(padr + 0x138)
	local stun = rw(padr + 0x13E)
	local guard = rw(padr + 0x146)
	--]]
	
	local box0 = padr + 0x262
	local box1 = padr + 0x268
	local box2 = padr + 0x26E
	local box3 = padr + 0x274
	
	local push = padr + 0x27A
	
	pushbox(px,py,push,pushcolor)
	
	local activate = rb(padr + 0x261)
	colbox(px,py,	box3,	flipx,	bit.band(activate,8)/8)
	colbox(px,py,	box2,	flipx,	bit.band(activate,4)/4)
	colbox(px,py,	box1,	flipx,	bit.band(activate,2)/2)
	colbox(px,py,	box0,	flipx,	bit.band(activate,1) )
	
	
	--[[
	{offset = 0x27A, type = "push"},
	{offset = 0x274, type = "undefined", active_bit = 3},
	{offset = 0x26E, type = "undefined", active_bit = 2},
	{offset = 0x268, type = "undefined", active_bit = 1},
	{offset = 0x262, type = "undefined", active_bit = 0},
	]]
	
	
	--Display
	--[[ peon2: don't need these for the training mode
	gui.text(25+p*235,24,"Life: " .. life)
	gui.text(40+p*194,208,"Meter: " .. meter)
	gui.text(88+p*106,40,"Guard: " .. guard)
	gui.text(24+p*236,40,"Stun: " .. stun)
	--]]
		
	drawaxis(px,py,6)
	
--Balrog P Tap padr + 0x1FA
--Balrog K Tap padr + 0x1FC

end
end

function drawaxis(x,y,axis)
gui.line(x+axis,y,x-axis,y,"white")
gui.line(x,y+axis,x,y-axis,"white")

end

function data(dadr)--Quick hack job to get this done
	local px = rw(dadr + 0x18) - camx
	local py = 204 - rw(dadr + 0x20) + camy
	
	local flipx =  rb(dadr + 0x31)
	
	local box0 = dadr + 0x262
	local box1 = dadr + 0x268
	local box2 = dadr + 0x26E
	local box3 = dadr + 0x274
	
	local activate = rb(dadr + 0x261)
	colbox(px,py,	box3,	flipx,	bit.band(activate,8)/8)
	colbox(px,py,	box2,	flipx,	bit.band(activate,4)/4)
	colbox(px,py,	box1,	flipx,	bit.band(activate,2)/2)
	colbox(px,py,	box0,	flipx,	bit.band(activate,1))

end

function colbox(plx,ply,adr,flp,active)
	
	if flp == 1 then
	x = plx + rbs(adr + 0x1) *-2
	else
	x = plx + rbs(adr + 0x1) * 2
	end
	id = rb(adr)
	
	y = rbs(adr + 0x2)*2 + ply
	w = rb(adr + 0x3)
	h = rb(adr + 0x4)
	
	
	color = boxes[id]
		
	lft = x + w
	rgt = x - w
	top = y + h
	btm = y - h
	if active ~= 0 then
	gui.box(lft,top,rgt,btm,color)
	--gui.text(x-8,y,id,0xFFFFFFFF,0x000000FF)
	end
end

function pushbox(plx,ply,adr,color)
	
	x = rbs(adr + 0x1)
	y = rbs(adr + 0x2)
	w = rb(adr + 0x3)
	h = rb(adr + 0x4)
	
	lft = x + plx + w
	rgt = x + plx - w
	top = y + ply + h
	btm = y + ply - h
	
	gui.box(lft,top,rgt,btm,color)
end

--[[ peon2: original driver for stand-alone
gui.register(function()
if rb(0x10B4B7) ~= 0 then
main()
else
gui.clearuncommitted()
end
end)
--]]

function hitboxesReg()
	if rb(0x10B4B7) ~= 0 and hitboxes.enabled then
		main()
	end
end

function hitboxesRegAfter() -- stub
end