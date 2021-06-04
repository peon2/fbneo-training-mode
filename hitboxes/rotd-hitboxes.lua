-- based on the following trading mode by an unknown author that seems to be based off jed's training mode (https://github.com/jedpossum/EmuLuaScripts/blob/master/Rotd.lua)
--[[
print("rotd script")
print("Lua hotkey 1: toggle endless")
print("Lua hotkey 2: toggle health recover")
print("Lua hotkey 3: recover health")
print("Lua hotkey 4: power stock max")
print("Lua hotkey 5: toggle ") print()

-----------------------------------------------------------

local read1  = memory.readbyte
local read1s = memory.readbytesigned
local read2  = memory.readword
local read2s = memory.readwordsigned
local read4  = memory.readdword
local read4s = memory.readdwordsigned

-----------------------------------------------------------

local dumpLines = 0

function dump(str, x)
	gui.text( x or 4, 4 + dumpLines * 8, str )
  dumpLines = dumpLines + 1
end

function memstr(addr)
	format = "0x%08x : %08x"
	return format:format( addr, read4(addr) )
end

function memdump(addr, x)
	dump( memstr(addr), x or 4 )
end

function boolstr(flag)
	if flag then return "ON" else return "OFF" end
end

-----------------------------------------------------------

local playerAddress = { 0x1023D2, 0x1023D2 - 0x178 }
local partnerOffset = 0x2F0
local playerState = {
  posx       = 0x016,
  posy       = 0x01A,
	flip       = 0x055,
	life       = 0x0FC,
	redlife    = 0x100,
	maxlife    = 0x104,
	guard      = 0x106,
	piyo       = 0x10A,
	powerStock = 0x110,
	tagtime    = 0x112,
}

local players = {{},{}}

function get_player_state(player)
	local baseAddress = playerAddress[player]
	players[player].head       = baseAddress
	players[player].life       = read2( baseAddress + playerState.life )
	players[player].redlife    = read2( baseAddress + playerState.redlife )
	players[player].maxlife    = read2( baseAddress + playerState.maxlife )
	players[player].guard      = read2( baseAddress + playerState.guard )
	players[player].piyo       = read2( baseAddress + playerState.piyo )
	players[player].powerStock = read2( baseAddress + playerState.powerStock )
	players[player].tagtime    = read2( baseAddress + playerState.tagtime )
	players[player].posx       = read2( baseAddress + playerState.posx )
	players[player].posy       = read2( baseAddress + playerState.posy )

	local partnerAddress = baseAddress + partnerOffset
	players[player].partnerLife    = read2( partnerAddress + playerState.life )
	players[player].partnerRedlife = read2( partnerAddress + playerState.redlife )
	players[player].partnerMaxlife = read2( partnerAddress + playerState.maxlife )

	-- 向き
	if bit.band( read1( baseAddress + playerState.flip ), 0x01 ) == 1 then
		players[player].flip = 1
	else
		players[player].flip = -1
	end
end

-----------------------------------------------------------

local stopTimer = true
local healthRecover = true

-- タイムを設定
function set_timer(time)
	local timerAddress = 0x106B11
	memory.writebyte( timerAddress, time )
end

-- 体力がrefill以下で自動全回復
function healthcheat(player, refill)
	local state = players[player]
	if state.life <= refill then
		memory.writeword( state.head + playerState.life , state.maxlife )
		memory.writeword( state.head + playerState.redlife, state.maxlife )
	end
end

-- パワーゲージ設定
function set_powerstock(player, val)
	memory.writeword( players[player].head + playerState.powerStock, val )
end

-----------------------------------------------------------

input.registerhotkey(1, function()
	stopTimer = not stopTimer
end)

input.registerhotkey(2, function()
	healthRecover = not healthRecover
end)

input.registerhotkey(3, function()
	healthcheat( 1, 300 )
	healthcheat( 2, 300 )
end)

input.registerhotkey(4, function()
	set_powerstock( 1, 6 * 72 )
	set_powerstock( 2, 6 * 72 )
end)

-----------------------------------------------------------

-- プレイヤー情報表示
function disp_player_info(player)
	local state = players[player]
	local xoffset = (player-1) * 200

	-- life
	local lifeFormat = "life: %d/%d"
	gui.text( 36 + xoffset       ,  2, lifeFormat:format( state.life, state.maxlife ) )
	gui.text( 36 + xoffset + 4*14,  2, state.redlife - state.life, 'red')
	gui.text( 36 + xoffset       , 32, lifeFormat:format( state.partnerLife, state.partnerMaxlife ) )
	gui.text( 36 + xoffset + 4*14, 32, state.partnerRedlife - state.partnerLife, 'red')

	-- piyo
	gui.text( 36 + xoffset, 10, "piyo: " .. state.piyo )
	-- guard
	gui.text( 36 + xoffset, 18, "guard: " .. state.guard )
	-- tagtime
	gui.text( 147 - (47 * state.flip), 42 , " " .. state.tagtime .. "/40" )

	-- powerstock
	local powerFormat = "power: %d.%d"
	local stock = math.floor(state.powerStock / 72)
	local gauge = state.powerStock % 72
	gui.text( 36 + xoffset, 200, powerFormat:format( stock, gauge ) )
end

-----------------------------------------------------------

-- プレイヤー情報ダンプ
function dump_player(player)
	local addr = players[player].head
	local x = 4 + (player-1) * 240
	for i = 0, 26 do
		gui.text( x, 4+i*8, string.format("%08X", read4s(addr+i*4)) )
	end
	for i = 0, 26 do
		gui.text( x + 36, 4+i*8, string.format("%08X", read4(addr+i*4+26*4)) )
	end
end

-----------------------------------------------------------

-- BOX表示
function colbox(addr, x, y, flip, color)
	x1 = x  - read2s( addr + 0x00 ) * flip
	x2 = x1 - read2s( addr + 0x04 ) * flip
	y1 = y  + read2s( addr + 0x02 )
	y2 = y1 + read2s( addr + 0x06 )	
	gui.box( x1, y1, x2, y2, color )
end

-- プレイヤーHitBox表示
function disp_hitbox(player)
	local state = players[player]

	local cameraX = read2s( 0x106B9C )
	local cameraY = 236 - read2s( 0x106BA0 )
	local x = state.posx - cameraX
	local y = cameraY - state.posy
	
	-- axis
	gui.line( x + 6, y, x - 6, y, 0xFFFF00FF )
	gui.line( x, y - 12, x, y + 12, 0x770000FF )

	-- box
	local addr = players[player].head
	local box = read4( read4( addr + 0x60 ) + read2( addr + 0x44 ) * 4 )
	
	for i = 1, 1 do
		local box1 = read1s( box + 0 )
		local box2 = read1s( box + 1 )
		local box3 = read1s( box + 2 )
		local box4 = read1s( box + 3 )
		box = box + 4

		--dump( string.format("%d,%d,%d,%d", box1, box2, box3, box4 ), 200 )

		for iBox = 1, box1 do colbox( box, x, y, state.flip, 0x66666600 ); box = box + 8 end
		for iBox = 1, box2 do colbox( box, x, y, state.flip, 0xFF000000 ); box = box + 8 end
		for iBox = 1, box3 do colbox( box, x, y, state.flip, 0x0000FF00 ); box = box + 8 end
		for iBox = 1, box4 do colbox( box, x, y, state.flip, 0x00FF0000 ); box = box + 8 end
	end
end

-----------------------------------------------------------

function display()

	dumpLines = 0
	get_player_state( 1 )
	get_player_state( 2 )

	gui.text(130, 4, "time endless: " .. boolstr(stopTimer))
	if stopTimer then set_timer(99) end

	gui.text(130, 12, "life recover: " .. boolstr(healthRecover))
	if healthRecover then		
		healthcheat( 1, 32 )
		healthcheat( 2, 32 )
	end

	disp_player_info( 1 )
	disp_player_info( 2 )
	--dump_player( 1 )
	--dump_player( 2 )
	disp_hitbox( 1 )
	disp_hitbox( 2 )

end

-----------------------------------------------------------

emu.registerafter(function()
	display()
end)
--]]

local read1  = memory.readbyte
local read1s = memory.readbytesigned
local read2  = memory.readword
local read2s = memory.readwordsigned
local read4  = memory.readdword
local read4s = memory.readdwordsigned

local playerAddress = { 0x1023D2, 0x1023D2 - 0x178 }
local partnerOffset = 0x2F0
local playerState = {
	posx       = 0x016,
	posy       = 0x01A,
	flip       = 0x055,
}

local players = {{},{}}

local get_player_state = function(player)
	local baseAddress = playerAddress[player]
	players[player].head       = baseAddress
	players[player].posx       = read2( baseAddress + playerState.posx )
	players[player].posy       = read2( baseAddress + playerState.posy )

	-- 向き
	if bit.band( read1( baseAddress + playerState.flip ), 0x01 ) == 1 then
		players[player].flip = 1
	else
		players[player].flip = -1
	end
end

function colbox(addr, x, y, flip, color)
	x1 = x  - read2s( addr + 0x00 ) * flip
	x2 = x1 - read2s( addr + 0x04 ) * flip
	y1 = y  + read2s( addr + 0x02 )
	y2 = y1 + read2s( addr + 0x06 )	
	gui.box( x1, y1, x2, y2, color )
end

local disp_hitbox = function(player)
	local state = players[player]

	local cameraX = read2s( 0x106B9C )
	local cameraY = 236 - read2s( 0x106BA0 )
	local x = state.posx - cameraX
	local y = cameraY - state.posy
	
	-- axis
	gui.line( x + 6, y, x - 6, y, 0xEE00DDFF )
	gui.line( x, y - 12, x, y + 12, 0xEE00DDFF )

	-- box
	local addr = players[player].head
	local box = read4( read4( addr + 0x60 ) + read2( addr + 0x44 ) * 4 )
	
	for i = 1, 1 do
		local box1 = read1s( box + 0 )
		local box2 = read1s( box + 1 )
		local box3 = read1s( box + 2 )
		local box4 = read1s( box + 3 )
		box = box + 4

		for iBox = 1, box1 do colbox( box, x, y, state.flip, 0x66666600 ); box = box + 8 end
		for iBox = 1, box2 do colbox( box, x, y, state.flip, 0xFF000000 ); box = box + 8 end
		for iBox = 1, box3 do colbox( box, x, y, state.flip, 0x0000FF00 ); box = box + 8 end
		for iBox = 1, box4 do colbox( box, x, y, state.flip, 0x00FF0000 ); box = box + 8 end
	end
end

function hitboxesReg()
	if hitboxes.enabled then
		get_player_state(1)
		get_player_state(2)
		disp_hitbox(1)
		disp_hitbox(2)
	end
end

function hitboxesRegAfter()
end