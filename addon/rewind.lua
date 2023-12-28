-- https://github.com/peon2/Fightcade-Replay-Control/ with edits from Pof

print "Rewind System for Fightcade:"
print "Very unstable, enable with the F key."
print "If you start rewinding/fast-forwarding/pausing, assume future inputs won't work. Any inputs already seen will work though."
print "Rewind with R, Fast-Forward with F, Pause with P."
print "If you have Paused, R and F move back/forward a frame respectively instead."
print "Especially unstable with games that have larger RAM sizes like the cps3 games. These games have a larger distance between each savestate."
print "Because Savestates cant be stored in RAM, a bunch of files are made which should be cleaned up."

local REPLAY_SAVESTATE_INTERVAL = REPLAY_SAVESTATE_INTERVAL or 16 -- frames between each state being saved
local SAVESTATE_INTERVAL = REPLAY_SAVESTATE_INTERVAL
local REWIND_KEY = "R"
local FORWARD_KEY = "F"
local PAUSE_KEY = "P"

local fc -- framecount according to game
local relfc = emu.framecount() -- relative fc according to inputs table, what frame the game SHOULD be at

local earliestfc = relfc -- the earliest frame we've seen
local latestfc = relfc -- the latest frame we've seen

local sstable = {} -- savestate table

local inputs = {}

local clearinputs = {} -- table of dud inputs
for i,_ in pairs(joypad.get()) do clearinputs[i] = false end
local pausetoggle = 0
local pausemove = false
local pauseprevious = false
local pauseframe = nil

local enabled = false

local readInputs = function() -- gets the inputs supplied this frame
	
	inputs[relfc] = {}
	for i,v in pairs(joypad.get()) do
		inputs[relfc][i] = v
	end
	
	kb = input.get()
end

local inputParse = function()
	if not enabled then return end

	joypad.set(clearinputs) -- common case
	joypad.set(inputs[fc])
	if (pausemove) then
		if not sstable[fc] then 
			sstable[fc] = savestate.create(fc)
			savestate.save(sstable[fc])
		end
		pausemove = false
		pauseframe = fc
	elseif pauseframe then
		savestate.load(sstable[pauseframe])
	else
		-- this avoids a lot of desyncs
		if (sstable[fc]) then -- if this savestate exists
			savestate.load(sstable[fc]) -- load
		end
	end

	if (fc%REPLAY_SAVESTATE_INTERVAL==0 and sstable[fc]==nil) then -- we've reached another multiple of the interval, save a state
		sstable[fc] = savestate.create(fc)
		savestate.save(sstable[fc])
	end

	if (fc>latestfc) then latestfc=fc end -- update latestfc

	if (kb[REWIND_KEY]) then
		--load the last savestate saved
		gui.text(1,1,"Savestate slot \("..math.floor((fc-earliestfc)/REPLAY_SAVESTATE_INTERVAL).."/"..math.floor((latestfc-earliestfc)/REPLAY_SAVESTATE_INTERVAL).."\)", "red")
		local newfc = fc-(fc%SAVESTATE_INTERVAL)
		if (fc-newfc <= 10) then -- if theres a small difference we should load the state before this, otherwise we're locked to one state
			newfc=newfc-SAVESTATE_INTERVAL
		end
		if pauseframe then
			pausemove = true
			newfc = fc-2
		end
		if (sstable[newfc]) then -- if this savestate exists
			savestate.load(sstable[newfc]) -- load
		else
			gui.text(1,10,"Can't go any further backwards", "red")
		end
	end
	
	if (kb[FORWARD_KEY]) then
		--load the next savestate saved
		gui.text(1,1,"Savestate slot \("..math.floor((fc-earliestfc)/REPLAY_SAVESTATE_INTERVAL).."/"..math.floor((latestfc-earliestfc)/REPLAY_SAVESTATE_INTERVAL).."\)", "red")
		local newfc = fc+SAVESTATE_INTERVAL-(fc%SAVESTATE_INTERVAL)
		if pauseframe then
			pausemove = true
			newfc = fc+1
		end
		if (sstable[newfc]) then -- if this savestate exists
			savestate.load(sstable[newfc]) -- load
		else
			gui.text(1,10,"Can't go any farther forwards", "red")
		end
	end

	if (kb[PAUSE_KEY] and not pauseprevious) then
		if pauseframe then
			SAVESTATE_INTERVAL = REPLAY_SAVESTATE_INTERVAL
			pauseframe=nil
		else
			pauseframe = fc
			pausemove = false
			SAVESTATE_INTERVAL = 1
			if not sstable[fc] then
				sstable[fc] = savestate.create(fc)
				savestate.save(sstable[fc])
			end
		end
	end
	pauseprevious = kb[PAUSE_KEY]
	joypad.set(inputs[fc])
end

local function rewind()
	if not REPLAY then return end
	fc = emu.framecount()
	relfc = relfc+1
	readInputs()
	if (not enabled and kb[FORWARD_KEY]) then enabled = true end
	inputParse()
end

local function exitprocedure()
	if not enabled then return end
	for i,_ in pairs(sstable) do
		os.remove(i)
	end
end

if REPLAY then
	table.insert(registers.registerbefore, rewind)
	table.insert(registers.emuexit, exitprocedure)
end
