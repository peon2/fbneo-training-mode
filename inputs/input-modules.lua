--[[
This file is intended to be run by input-display.lua

Define input abbreviations and on-screen positions for each module.
You may add new modules and comment out any inputs you never want displayed.

Format:
games = rom, parent, or driver names that the module applies to
x,y = offset in pixels of the upper left corner of the first player's symbols
dx,dy = offset in pixels to shift the next player's symbols
i = array containing a subarray for each symbol to be drawn
i[player..symbol] = {
	[1] = x position to draw the symbol
	[2] = y position to draw the symbol
	[3] = name of the input in FBA or MAME
	[4] = name of the input in MAME (if different from FBA)
	[5] = x position to draw the value (for analog controls only)
	[6] = y position to draw the value (for analog controls only)
}
table.insert(inp,{games,i}) = command to add the module
]]

--[[	TO BE DONE
	
	COLOURS AS A CONFIG OPTION

--]]


col = { --colors:
	on1  = 0xffff00ff, --pressed: yellow inside
	on2  = 0x000000ff, --pressed: black border
	off1 = 0x00000000, --unpressed: clear inside
	off2 = 0x00000033  --unpressed: mostly clear black border
}

local games,x,dx,y,dy,i
--------------------------------------------------------------------------------
--Capcom 6-button fighters (CPS systems)

games = {"sf2","sf2ce","sf2hf",
	"ssf2","ssf2t","ssf2tnl","hsf2","sfa","sfa2","sfa3","sfz2al",
	"sfiii","sfiii2","sfiii3","redearth",
	"xmcota","xmvsf","msh","mshvsf","mvsc","dstlk","nwarr","vsav","vhunt2","vsav2"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."LP"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x0, "P"..n.." Weak Punch",   "P"..n.." Button 1"}
	i[n.."MP"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x0, "P"..n.." Medium Punch", "P"..n.." Button 2"}
	i[n.."HP"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x0, "P"..n.." Strong Punch", "P"..n.." Button 3"}
	i[n.."LK"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x8, "P"..n.." Weak Kick",    "P"..n.." Button 4"}
	i[n.."MK"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x8, "P"..n.." Medium Kick",  "P"..n.." Button 5"}
	i[n.."HK"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x8, "P"..n.." Strong Kick",  "P"..n.." Button 6"}
	i[n.."S" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",        n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",         "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Heritage for the Future 4-button (CPS3 system)
games = {"jojo","jojoba", "jojobanr1"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."A"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Weak Attack",   "P"..n.." Button 1"}
	i[n.."B"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x4, "P"..n.." Medium Attack", "P"..n.." Button 2"}
	i[n.."C"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x4, "P"..n.." Strong Attack", "P"..n.." Button 3"}
	i[n.."S"] = {x+dx*(n-1)+0x48, y+dy*(n-1)+0x4, "P"..n.." Stand",    "P"..n.." Button 4"}
	i[n.."St" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",        n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",         "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Cyberbots (CPS2 system)
games = {"cybots"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."L"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Low Attack",   "P"..n.." Button 1"}
	i[n.."H"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x4, "P"..n.." High Attack", "P"..n.." Button 2"}
	i[n.."B"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x4, "P"..n.." Boost", "P"..n.." Button 3"}
	i[n.."W"] = {x+dx*(n-1)+0x48, y+dy*(n-1)+0x4, "P"..n.." Weapon","P"..n.." Button 4"}
	i[n.."S" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start", n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin", "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Super Gem Fighter (CPS2 system)
games = {"sgemf"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."P"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Punch",   "P"..n.." Button 1"}
	i[n.."K"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x4, "P"..n.." Kick", "P"..n.." Button 2"}
	i[n.."S"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x4, "P"..n.." Special", "P"..n.." Button 3"}
	i[n.."St" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start", n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin", "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Slam Masters

games = {"slammast"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."A"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x0, "P"..n.." Attack"}
	i[n.."J"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x0, "P"..n.." Jump"}
	i[n.."P"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x0, "P"..n.." Pin"}
	i[n.."S" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start", n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin"}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Capcom 6-button fighters (non-CPS systems)

games = {"sf", "sftm", "sfex", "sfexp", "sfex2", "sfex2p"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."LP"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x0, "P"..n.." Button 1"}
	i[n.."MP"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x0, "P"..n.." Button 2"}
	i[n.."HP"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x0, "P"..n.." Button 3"}
	i[n.."LK"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x8, "P"..n.." Button 4"}
	i[n.."MK"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x8, "P"..n.." Button 5"}
	i[n.."HK"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x8, "P"..n.." Button 6"}
	i[n.."S" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start", n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "Coin "..n}
end
table.insert(inp,{games,i})

games = {"ringdest"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."H"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x0, "P"..n.." Hold"}
	i[n.."LP"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x0, "P"..n.." Weak punch"}
	i[n.."HP"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x0, "P"..n.." Strong punch"}
	i[n.."LK"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x8, "P"..n.." Weak kick"}
	i[n.."HK"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x8, "P"..n.." Strong kick"}
	i[n.."S" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start", n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--NeoGeo

games = {"neodrvr.c","neogeo"}
x,dx = 0x10,0xe0
y,dy = 0xc8,0
i = {}
for n=1,2 do
	i[n.."^"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x08, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."A"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Button A", "P"..n.." Button 1"}
	i[n.."B"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0x4, "P"..n.." Button B", "P"..n.." Button 2"}
	i[n.."C"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Button C", "P"..n.." Button 3"}
	i[n.."D"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x4, "P"..n.." Button D", "P"..n.." Button 4"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",    n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",     "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Kaneko

games = {"jchan2"}
x,dx = 0x10,0xe0
y,dy = 0xc8,0
i = {}
for n=1,2 do
	i[n.."^"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x08, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."LP"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Button 1", "P"..n.." Button 1"}
	i[n.."HP"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0x4, "P"..n.." Button 2", "P"..n.." Button 2"}
	i[n.."LK"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Button 3", "P"..n.." Button 3"}
	i[n.."HK"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x4, "P"..n.." Button 4", "P"..n.." Button 4"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",    n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",     "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------

--martmast

games = {"martmast"}
x,dx = 0x10,0xe0
y,dy = 0xc8,0
i = {}
for n=1,2 do
	i[n.."^"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x08, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."LP"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Button 1", "P"..n.." Button 1"}
	i[n.."LK"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Button 2", "P"..n.." Button 2"}
	i[n.."HP"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0x4, "P"..n.." Button 3", "P"..n.." Button 3"}
	i[n.."HK"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x4, "P"..n.." Button 4", "P"..n.." Button 4"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",    n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",     "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Psikyo

games = {"daraku"}
x,dx = 0x10,0xe0
y,dy = 0xc8,0
i = {}
for n=1,2 do
	i[n.."^"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x08, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."LP"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Button 1", "P"..n.." Button 1"}
	i[n.."HP"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0x4, "P"..n.." Button 2", "P"..n.." Button 2"}
	i[n.."LK"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0xC, "P"..n.." Button 3", "P"..n.." Button 3"}
	i[n.."HK"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0xC, "P"..n.." Button 4", "P"..n.." Button 4"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",    n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",     "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Mighty Warriors

games = {"mwarr"}
x,dx = 0x10,0xe0
y,dy = 0xc8,0
i = {}
for n=1,2 do
	i[n.."^"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x08, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."A"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Button 1", "P"..n.." Button 1"}
	i[n.."B"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0x4, "P"..n.." Button 2", "P"..n.." Button 2"}
	i[n.."C"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Button 3", "P"..n.." Button 3"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",    n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",     "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Banpresto & Rabbit

games = {"dbz2","gundamex","tkdensho","rabbit"}
x,dx = 0x10,0xe0
y,dy = 0xc8,0
i = {}
for n=1,2 do
	i[n.."^"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x08, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."A"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Button 1", "P"..n.." Button 1"}
	i[n.."B"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0x4, "P"..n.." Button 2", "P"..n.." Button 2"}
	i[n.."C"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Button 3", "P"..n.." Button 3"}
	i[n.."D"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x4, "P"..n.." Button 4", "P"..n.." Button 4"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",    n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",     "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Taito

games = {"dinorex"}
x,dx = 0x10,0xe0
y,dy = 0xc8,0
i = {}
for n=1,2 do
	i[n.."^"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x08, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."1"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Fire 1", "P"..n.." Button 1"}
	i[n.."2"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0x4, "P"..n.." Fire 2", "P"..n.." Button 2"}
	i[n.."3"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Fire 3", "P"..n.." Button 3"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",    n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",     "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--IGS

games = {"aliencha"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."LP"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x0, "P"..n.." Button 1",   "P"..n.." Button 1"}
	i[n.."MP"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x0, "P"..n.." Button 2", "P"..n.." Button 2"}
	i[n.."HP"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x0, "P"..n.." Button 3", "P"..n.." Button 3"}
	i[n.."LK"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x8, "P"..n.." Button 4",    "P"..n.." Button 4"}
	i[n.."MK"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x8, "P"..n.." Button 5",  "P"..n.." Button 5"}
	i[n.."HK"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x8, "P"..n.." Button 6",  "P"..n.." Button 6"}
	i[n.."S" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",        n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",         "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--IGS

games = {"dankuga"}
x,dx = 0x8,0xE8
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."LP"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x0, "P"..n.." Weak Punch",   "P"..n.." Button 1"}
	i[n.."MP"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x0, "P"..n.." Medium Punch", "P"..n.." Button 2"}
	i[n.."HP"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x0, "P"..n.." Strong Punch", "P"..n.." Button 3"}
	i[n.."LK"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x8, "P"..n.." Weak Kick",    "P"..n.." Button 4"}
	i[n.."MK"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x8, "P"..n.." Medium Kick",  "P"..n.." Button 5"}
	i[n.."HK"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x8, "P"..n.." Strong Kick",  "P"..n.." Button 6"}
	i[n.."S" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",        n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",         "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--PGM

games = {"pgm.c","pgm"}
x,dx = 0x10,0x70
y,dy = 0xc0,0
i = {}
for n=1,4 do
	i[n.."^"] = {x+dx*(n-1)+0x14, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x14, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x0c, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x1c, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."1"] = {x+dx*(n-1)+0x2c, y+dy*(n-1)+0x4, "P"..n.." Button 1"}
	i[n.."2"] = {x+dx*(n-1)+0x34, y+dy*(n-1)+0x4, "P"..n.." Button 2"}
	i[n.."3"] = {x+dx*(n-1)+0x3c, y+dy*(n-1)+0x4, "P"..n.." Button 3"}
	i[n.."4"] = {x+dx*(n-1)+0x44, y+dy*(n-1)+0x4, "P"..n.." Button 4"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start", n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",  "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Dungeons & Dragons (Capcom)

games = {"ddtod","ddsom"}
x,dx = 0x24,0xc0
y,dy = 0,0xd0
i = {}
for n=1,4 do
	i[n.."^"] = {x+(n-1)%2*dx+0x18, y+math.floor((n-1)/2)*dy+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+(n-1)%2*dx+0x18, y+math.floor((n-1)/2)*dy+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+(n-1)%2*dx+0x10, y+math.floor((n-1)/2)*dy+0x4, "P"..n.." Left"}
	i[n..">"] = {x+(n-1)%2*dx+0x20, y+math.floor((n-1)/2)*dy+0x4, "P"..n.." Right"}
	i[n.."A"] = {x+(n-1)%2*dx+0x30, y+math.floor((n-1)/2)*dy+0x8, "P"..n.." Attack", "P"..n.." Button 1"}
	i[n.."J"] = {x+(n-1)%2*dx+0x38, y+math.floor((n-1)/2)*dy+0x8, "P"..n.." Jump",   "P"..n.." Button 2"}
	i[n.."S"] = {x+(n-1)%2*dx+0x30, y+math.floor((n-1)/2)*dy+0x0, "P"..n.." Select", "P"..n.." Button 3"}
	i[n.."U"] = {x+(n-1)%2*dx+0x38, y+math.floor((n-1)/2)*dy+0x0, "P"..n.." Use",    "P"..n.." Button 4"}
	i[n.."s"] = {x+(n-1)%2*dx+0x00, y+math.floor((n-1)/2)*dy+0x8, "P"..n.." Start",  n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+(n-1)%2*dx+0x00, y+math.floor((n-1)/2)*dy+0x0, "P"..n.." Coin",   "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--TMNT games (Konami)

games = {"tmnt","tmnt2"}
x,dx = 0x10,0x48
y,dy = 0x20,0
i = {}
for n=1,4 do
	i[n.."^"] = {x+dx*(n-1)+0x14, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x14, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x0c, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x1c, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."1"] = {x+dx*(n-1)+0x2c, y+dy*(n-1)+0x4, "P"..n.." Fire 1", "P"..n.." Button 1"}
	i[n.."2"] = {x+dx*(n-1)+0x34, y+dy*(n-1)+0x4, "P"..n.." Fire 2", "P"..n.." Button 2"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x4, "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--After Burner (Sega)

games = {"aburner2"}
x,dx = 0x80,0x10
y,dy = 0xc8,0
i = {
	["1X"] = {x+0x10, y+0x00, "Left/Right", "AD Stick X", dx, dy},
	["1Y"] = {x+0x10, y+0x08, "Up/Down",    "AD Stick Y", dx, dy},
	["1T"] = {x+0x10, y+0x10, "Throttle",   "AD Stick Z", dx, dy},
	["1V"] = {x+0x30, y+0x04, "Vulcan"},
	["1M"] = {x+0x30, y+0x0c, "Missile"},
	["1C"] = {x+0x00, y+0x00, "Coin 1"},
	["1S"] = {x+0x00, y+0x10, "Start 1",    "1 Player Start"},
}
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Fuuki FG-3

games = {"asurabld","asurabus"}
x,dx = 0x10,0xe0
y,dy = 0xc8,0
i = {}
for n=1,2 do
	i[n.."^"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v"] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<"] = {x+dx*(n-1)+0x08, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">"] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."A"] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Button 1", "P"..n.." Button 1"}
	i[n.."B"] = {x+dx*(n-1)+0x28, y+dy*(n-1)+0x4, "P"..n.." Button 2", "P"..n.." Button 2"}
	i[n.."C"] = {x+dx*(n-1)+0x30, y+dy*(n-1)+0x4, "P"..n.." Button 3", "P"..n.." Button 3"}
	i[n.."S"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",    n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c"] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",     "Coin "..n}
end
table.insert(inp,{games,i})

--------------------------------------------------------------------------------
--Ultimate Mortal Kombat 3
games = {"umk3"}
x,dx = 0x8,0x128
y,dy = 0xd0,0
i = {}
for n=1,2 do
	i[n.."^" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x0, "P"..n.." Up"}
	i[n.."v" ] = {x+dx*(n-1)+0x18, y+dy*(n-1)+0x8, "P"..n.." Down"}
	i[n.."<" ] = {x+dx*(n-1)+0x10, y+dy*(n-1)+0x4, "P"..n.." Left"}
	i[n..">" ] = {x+dx*(n-1)+0x20, y+dy*(n-1)+0x4, "P"..n.." Right"}
	i[n.."1"] =  {x+dx*(n-1)+0x30, y+dy*(n-1)+0x0, "P"..n.." Low Punch",   "P"..n.." Button 1"}
	i[n.."2"] =  {x+dx*(n-1)+0x38, y+dy*(n-1)+0x0, "P"..n.." High Punch",  "P"..n.." Button 2"}
	i[n.."3"] =  {x+dx*(n-1)+0x40, y+dy*(n-1)+0x0, "P"..n.." Low Kick",    "P"..n.." Button 3"}
	i[n.."4"] =  {x+dx*(n-1)+0x30, y+dy*(n-1)+0x8, "P"..n.." High Kick",   "P"..n.." Button 4"}
	i[n.."BL"] = {x+dx*(n-1)+0x38, y+dy*(n-1)+0x8, "P"..n.." Block",       "P"..n.." Button 5"}
	i[n.."RN"] = {x+dx*(n-1)+0x40, y+dy*(n-1)+0x8, "P"..n.." Run",         "P"..n.." Button 6"}
	i[n.."S" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x0, "P"..n.." Start",        n..(n==1 and " Player" or " Players").." Start"}
	i[n.."c" ] = {x+dx*(n-1)+0x00, y+dy*(n-1)+0x8, "P"..n.." Coin",         "Coin "..n}
end
table.insert(inp,{games,i})
