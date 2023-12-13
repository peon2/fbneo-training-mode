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

local in_air = 0x108322

local currentState = "start"
function isInAir()
	 return rb(in_air)~=0
end
moves = {
	['DPC'] = {
		["sequence"] = {
			{'_'},
			{'_'},
			{ 'forward'},
			{ 'forward'},
			{'_'},
			{'_'},
			{'down'},
			{'down'},
			{'down', 'forward','a'},
			{'down', 'forward','a'},
			{'a'},
			{'a'},
			{'a'}},
			times = 13
	},
	['THROW_C']={
		["sequence"] = {		
			{'_'},
			{'_'},
			{'back', 'c'} 
		},
		times = 50
	}
}

local training_config = {
	["dummy_random_guard"] = false,
	["dummy_guard"] = true,
	['reversal'] = true,
	['reversal_move'] = moves['DPC'],
}

local reversal = false
--local reversal_move =0x62 -- 0x63 --standing punch
--local p2move_adress = 0x108373
local p2blockstun_address = 0x1083E3
local p2blockstun_value = 0xA0
local trigger_reversal = true
local can_block = true
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

function playerTwoInBlockstun()
	return rb(p2blockstun_address) == p2blockstun_value
end

function getFacingDirection()
	if playerTwoFacingLeft() then
		return "P2 Left"
	end
	return "P2 Right"
end
function getBlockingDirection()
	if playerTwoFacingLeft() then
		return "P2 Right"
	end
	return "P2 Left"
end

function doRecovery()
	local tbl = {}
	tbl["P2 Button A"] = 1
	tbl["P2 Button B"] = 1
	joypad.set(tbl)
end

local current_move_index_counter = 1
local current_move_time_counter = 1
function doMove(move)
	local seq = move.sequence
	local times = move.times
	can_block = false
	local tbl = {}
	print(times)
	print(current_move_time_counter)
	if current_move_time_counter > times then
		current_move_time_counter =0
		can_block = true
		currentState = "start" 	
		return false
	end
	if current_move_index_counter > #seq  then
		current_move_index_counter = 1
	end
	print(seq)
	for index, value in ipairs(seq[current_move_index_counter]) do
		if value == 'forward' then
			tbl[getFacingDirection()] = 1
		elseif value == 'back' then
			tbl[getBlockingDirection()] = 1
		elseif value == 'down' then
			tbl["P2 Down"] = 1
		elseif value == 'up' then
			tbl["P2 Up"] = 1
		elseif value == 'a' then
			tbl["P2 Button A"] = 1
		elseif value == 'b' then
			tbl["P2 Button B"] = 1
		elseif value == 'c' then
			tbl["P2 Button C"] = 1
		elseif value == 'd' then
			tbl["P2 Button D"] = 1
		end
	end
	current_move_index_counter = current_move_index_counter +1
	current_move_time_counter = current_move_time_counter +1
	print(tbl)
	joypad.set(tbl)
	return true
end
function doReversal()
	if doMove(training_config['reversal_move']) == false then
		trigger_reversal = false		
	end
end
function p2Block()
	local tbl = {}	
	tbl[getBlockingDirection()] = 1
	tbl["P2 Down"] = 1
	joypad.set(tbl)
end
function p2Crouch()
	local tbl = {}
	tbl["P2 Down"] = 1
	joypad.set(tbl)
end


function randomGen()
	math.randomseed(math.random() * 10000)
	local c = math.random()
	math.random()
	math.random()
	local b = (c > 0.5)
	--print(emu.framecount().." : "..os.time().." "..c)
	return b
end

function Run() -- runs every frame
	
	--if playerTwoIsBeingHit() then
	--if rb(0x10837E) == 1  then player 2 is in proximity block
	--wb(0x108102,44)
	--wb(0x108103,46)
	--wb(0x10DA5E,0x0A))
	--[[ detect which state is the dummy on ]]
	if isInAir() then
		if training_config["recovery"] == true then			
			currentState = "recovery"
		end		
	elseif playerTwoInBlockstun()   then		
		if training_config["reversal"] == true then			
			currentState = "reversal"
		end	
	elseif playerTwoInBlockstun() and trigger_reversal == false   then
		if currentState == "reversal" then
			currentState = "start"
		end
	end
	--[[ execute things based on the current state]]
	
	--[[ print("current state is "..currentState) ]]
	if currentState == "reversal" then			
			doReversal()
	elseif currentState == "recovery" then				
		doRecovery()
	elseif currentState == "start" then
		can_block = true
		trigger_reversal = true
	end
	--[[ this applies the guard or the random guard ]]
	if (training_config["dummy_guard"] == true) and  can_block == true then
		if training_config["dummy_random_guard"] == true then
			if(randomGen() == true)then
				 p2Block() 
			else
				p2Crouch()
			end
		else
			p2Block()
		end
	end

	
	infiniteTime()
end

