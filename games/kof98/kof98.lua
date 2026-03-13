assert(rb,"Run fbneo-training-mode.lua")

function gamemsg()
	print "Known issues with kof98:"
	print "Doesn't activate MAX properly"
	print "Only partial support for advance with refilling max meter"
end

-------------------------------------------------
--- POSSIBLE MEMORY ADRESSES ----
-------------------------------------------------
--108477 dizzy timer- it stops counting when the oponent is dizzy
--1084b0 combo counter
--1084bb dummy has been grabbed
--1081a6 Player1 is in air = c0, d8 = standing, e0 = crouching
--108318 - 108319 Dummy stage position from 0020 (left corner) to 02e0  (right corner)
--if rb(0x10837E) == 1  then player 2 is in proximity block
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

--[[ local trigger_recovery = true ]]
local function isInAir()
	 return rb(in_air)~=0
end




customconfig = {
	dummy_guard = 0,
	dummy_random_guard = 0,
	dummy_reversal = 0,
	dummy_recovery = 0,
	dummy_reversal_random = 0,
	}

dummy_guard = customconfig.dummy_guard
dummy_random_guard = customconfig.dummy_random_guard
dummy_recovery = customconfig.dummy_recovery
dummy_reversal = customconfig.dummy_reversal
dummy_reversal_random = customconfig.dummy_reversal_random

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
		combotext = {
			x=138,
			y=38,
			enabled=true,
		},
		health = {
			P1 = {
				x = 33,
				y = 20,
				enabled = true,
			},
			P2 = {
				x = 260,
				y = 20,
				enabled = true,
			}
		},
		meter = {
			P1 = {
				x = 107,
				y = 204,
				enabled = true,
			},
			P2 = {
				x = 186,
				y = 204,
				enabled = true,
			}
		}
	},
	gamevars = {
		P1 = {
			maxhealth = p1maxhealth,
			maxmeter = p1maxmeter
		},
		P2 = {
			maxhealth = p2maxhealth,
			maxmeter = p2maxmeter
		}
	},
	combovars = {
		P1 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
		},
		P2 = {
			instantrefillhealth = false,
			refillhealthenabled = true,
			instantrefillmeter = false,
			refillmeterenabled = true,
		}
	}
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

local function playerTwoInBlockstun()
	if (rb(p2blockstun_address) == 0x20) or (rb(p2blockstun_address) == 0xA0) then
		return true
	end
	return false
end

local function getFacingDirection()
	if playerTwoFacingLeft() then
		return "P2 Left"
	end
	return "P2 Right"
end
local function getBlockingDirection()
	if playerTwoFacingLeft() then
		return "P2 Right"
	end
	return "P2 Left"
end


local function transitionToState(newState)
    -- Logic for transitioning to a new state
    currentState = newState
    print("Transitioned to state:", newState)
    -- Additional logic for state transition...
end
local iddle_time_running = false
local iddle_finish_time = 0
local iddle_time = 60
local function recoveryEnabled()
	if iddle_time_running then
		print("current iddle Time is: "..(iddle_finish_time - emu.framecount()))
		if iddle_finish_time == emu.framecount()  then
			iddle_finish_time = 0
			iddle_time_running = false
			return true
		end
		return false
	end	
	return true
end
local function startRecoveryIddleTime()
	iddle_time_running = true
	iddle_finish_time = emu.framecount() + iddle_time
end


local current_move_index_counter = 1
local current_move_time_counter = 1
local function doMove(move, times)
	local seq = move.sequence
	times = times or  move.times
	--[[ can_block = false ]]
	local tbl = {}--[[ 
	print("current_move_time_counter: "..current_move_time_counter) ]]
	if current_move_time_counter > times then
	--[[ print("last time") ]]
		
	
		current_move_time_counter =1
		--[[ can_block = true ]]	
		return false
	end
--[[ 	print(joypad.get()["P1 Button B"]) ]]
	if current_move_index_counter > #seq  then
		current_move_index_counter = 1		
		current_move_time_counter = current_move_time_counter +1
	end
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
	joypad.set(tbl)
	return true
end
local CURRENT_REVERSAL_MOVE = {}
local function getCurrentReversalMove()
	local next = next
	if next(CURRENT_REVERSAL_MOVE) == nil then		
		if dummy_reversal_random == 1 then
			CURRENT_REVERSAL_MOVE =moves[dummy_reversal_moves[math.random(1,  #dummy_reversal_moves)]]
		else
			CURRENT_REVERSAL_MOVE = moves[dummy_reversal_moves[1]]
		end
	end
	return CURRENT_REVERSAL_MOVE
end



local function doReversal()
	if doMove(getCurrentReversalMove()) == false then
		--[[ trigger_reversal = false
		trigger_recovery = false ]]
		CURRENT_REVERSAL_MOVE = {}
		if dummy_guard == 1 then
        	transitionToState("blocking")  -- Transition to the "blocking" state
		else
			transitionToState("start")
			startRecoveryIddleTime()
		end
	end
end
local function doRecovery()
	if doMove(moves['AB'],1)== false then
		startRecoveryIddleTime()
		--[[ trigger_recovery = false ]]
		if dummy_reversal == 1 then
			transitionToState("reversal")
		elseif dummy_guard == 1 then
			transitionToState("blocking")
		else
			transitionToState("start")
		end
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
local function PlayerOnePressedButtons()
	local tbl = joypad.get()
	if (tbl["P1 Button A"] == true) or (tbl["P1 Button B"] == true)  or (tbl["P1 Button C"] == true)  or (tbl["P1 Button D"] == true) then
		return true
	end
	return false
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



function block()
    -- Additional logic for blocking...
	if dummy_random_guard == 1 then
		-- Logic for blocking behavior
		print("Random Blocking!")
		local percentage_of_down = 50
		local randomNumber = math.random(1, 100)
		if(randomNumber <= percentage_of_down )then
			p2Crouch()
		else
			p2Block() 
		end
	else
		-- Logic for blocking behavior
		print("Blocking!")
		p2Block()
	end
end
testsRun = false
if testsRun then
	require('games.kof98.tests_kof98')	
end


function Run() -- runs every frame
	--run tests once
	if testsRun then
		runTests()
	end
	 -- Check the current state and execute corresponding behavior
	 if currentState == "start" then
        -- Logic for the "start" state
        -- Additional logic specific to the "start" state...
		if dummy_guard == 1 then
        	transitionToState("blocking")  -- Transition to the "blocking" state
		elseif dummy_recovery == 1 then
			if (recoveryEnabled()) then
				if isInAir() then
					transitionToState("recovery")
				end
			end
		end
	elseif currentState == "blocking" then
		if  playerTwoInBlockstun() and dummy_reversal == 1 then
			transitionToState("reversal")
		end
		block()
	elseif currentState == "recovery" then
		doRecovery()
	elseif currentState == "reversal" then
		doReversal()
	 end
	
	infiniteTime()
end
