assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Known issues with kof98:"
	print "Doesn't activate MAX properly"
	print "Only partial support for advance with refilling max meter"
end

p1maxhealth = 0x68
p2maxhealth = 0x68

p1maxmeter = 0x80
p2maxmeter = 0x80

local p1health = 0x108239
local p2health = 0x108439

local p1meter = 0x1081e8
local p2meter = 0x1083e8

local p1direction = 0x108131
local p2direction = 0x108331

local p1combocounter = 0x1084b0
local p2combocounter = 0x1082b0

local p1hitstatus = 0x108172
local p2hitstatus = 0x108372

translationtable = {
	"left",
	"right",
	"up",
	"down",
	"button1",
	"button2",
	"button3",
	"button4",
	"coin",
	"start",
	"select",
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Button A"] = 5,
	["Button B"] = 6,
	["Button C"] = 7,
	["Button D"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
	["Select"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotextx=138,
		combotexty=38,
		comboenabled=true,
		p1healthx=33,
		p1healthy=20,
		p1healthenabled=true,
		p2healthx=260,
		p2healthy=20,
		p2healthenabled=true,
		p1meterx=107,
		p1metery=204,
		p1meterenabled=true,
		p2meterx=186,
		p2metery=204,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function playerOneIsBeingHit()
	return rb(p1hitstatus)~=0
end

function playerTwoIsBeingHit()
	return rb(p2hitstatus)~=0
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health-1)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health-1)
end

function readPlayerOneMeter()
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
	if meter==p1maxmeter then
		wb(0x1082e3, 3) -- advance
		ww(p1meter+4, 0x4000) -- set up the timer
		wb(p1meter+8, 0x10) -- activate
	end
end

function readPlayerTwoMeter()
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
	if meter==p2maxmeter then
		wb(0x1084e3, 3) -- advance
		ww(p2meter+4, 0x4000)
		wb(p2meter+8, 0x10)
	end
end


function infiniteTime()
	ww(0x10A83a, 0x6000)
end
local reversal = false
local reversal_move =0x62 -- 0x63 --standing punch
local p2move_adress = 0x108373
local p2blockstun_address = 0x1083E3
local p2blockstun_value = 0xA0
function playerTwoInBlockstun()
	return rb(p2blockstun_address) == p2blockstun_value
end
function playerTwoReversalActive()
	return rb(p2move_adress) == reversal_move
end
--emu.registerbefore(reverSal)
reversalState = 1
function doReversal()
	if reversalState  == 1 then 
		local tbl = {}
		tbl["P2 Left"] = 1		
		joypad.set(tbl)
		reversalState = reversalState + 1
		return
	elseif reversalState == 2 then
		local tbl = {}
		tbl["P2 Left"] = 1		
		joypad.set(tbl)
		reversalState = reversalState + 1
		return
	elseif reversalState == 3 then
		local tbl = {}
		tbl["P2 Down"] = 1	
		joypad.set(tbl)
		reversalState = reversalState + 1
		return
	elseif reversalState == 4 then
		local tbl = {}
		tbl["P2 Down"] = 1
		joypad.set(tbl)
		reversalState = reversalState + 1
		return
	elseif reversalState == 5 then
		local tbl = {}
		tbl["P2 Down"] = 1	
		tbl["P2 Left"] = 1	
		tbl["P2 Button C"] = 1
		joypad.set(tbl)
		reversalState = reversalState + 1
		return
	elseif reversalState == 6 then
		local tbl = {}
		tbl["P2 Down"] = 1	
		tbl["P2 Left"] = 1	
		tbl["P2 Button C"] = 1
		joypad.set(tbl)
		reversalState = reversalState + 1
		return
	elseif reversalState == 7 then
		local tbl = {}
		tbl["P2 Button C"] = 1
		joypad.set(tbl)
		reversalState = reversalState + 1
		return
	else
		reversalState = 1
		reversal = false		
		reversalframestarter = 0
		
	end
end
function p2Block()
	local tbl = {}
	tbl["P2 Right"] = 1
	-- make it crouching block randomly...
	--if(randomGen()) then tbl["P2 Down"] = 1 end
	tbl["P2 Down"] = 1
	
	joypad.set(tbl)
	print("p2 block!")
end


function randomGen()
	math.randomseed(math.random() * 10000)
	local c = math.random()
	math.random()
	math.random()
	local b = (c > 0.5)
	print(emu.framecount().." : "..os.time().." "..c)
	return b
end
reversalframestarter = 0
blocking =  true
function Run() -- runs every frame
	
	--if playerTwoIsBeingHit() then
	--if rb(0x10837E) == 1  then player 2 is in proximity block
	--wb(0x108102,44)
	--wb(0x108103,46)
	--wb(0x10DA5E,0x0A))
	if blocking == true then
		p2Block()
	end
	if playerTwoInBlockstun()   then
		trigger_reversal = true
	elseif (playerTwoInBlockstun() == false) and trigger_reversal == true then
		reversal = true
		trigger_reversal = false
	end
	
	if reversal == true then
		doReversal()		
		--reversalframestarter = reversalframestarter + 1
		--if reversalframestarter == 15 then
			--doReversal()
			--print("reversed!!")
		--end	
	end
	
		--reversal = false

	
	infiniteTime()
end

