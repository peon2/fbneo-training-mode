local SAVESTATE_INTERVAL = 16 -- frames between each state being saved
local REWIND_KEY = "R"

local fc -- framecount according to game
local relfc = emu.framecount() -- relative fc according to inputs table, what frame the game SHOULD be at

local earliestfc = relfc -- the earliest frame we've seen
local latestfc = relfc -- the latest frame we've seen

local sstable = {} -- savestate table

local kb = {}
local inputs = {}

local clearinputs = {} -- table of dud inputs
for i,_ in pairs(joypad.get()) do clearinputs[i] = false end

local readInputs = function() -- gets the inputs supplied this frame
	
	inputs[relfc] = {}
	for i,v in pairs(joypad.get()) do
		inputs[relfc][i] = v
	end

	kb = input.get()
end

local inputParse = function()

	local DEBUG = false
	
	joypad.set(clearinputs) -- common case
	joypad.set(inputs[fc])
	
	-- this avoids a lot of desyncs
	if (sstable[fc]) then -- if this savestate exists
		savestate.load(sstable[fc]) -- load
	end

	if (fc%SAVESTATE_INTERVAL==0 and sstable[fc]==nil) then -- we've reached another multiple of the interval, save a state
		sstable[fc] = savestate.create(fc)
		savestate.save(sstable[fc])
	end
	
	if (fc>latestfc) then latestfc=fc end -- update latestfc
	
	if DEBUG then
		gui.text(1,10,"Current frame: ".. fc)
		gui.text(1,20,"Distance from replay: "..relfc-fc)
		gui.text(1,30,"Savestate slot \("..math.floor((fc-earliestfc)/SAVESTATE_INTERVAL).."/"..math.floor((latestfc-earliestfc)/SAVESTATE_INTERVAL).."\)")
	end
		
	if (kb[REWIND_KEY]) then 
		--load the last savestate saved
		local newfc = fc-(fc%SAVESTATE_INTERVAL)
		if (fc-newfc <= 10) then -- if theres a small difference we should load the state before this, otherwise we're locked to one state
			newfc=newfc-SAVESTATE_INTERVAL
		end
		if (sstable[newfc]) then -- if this savestate exists
			savestate.load(sstable[newfc]) -- load
			if (pausetoggle==true) then savestate.save(pause) end
		else
			gui.text(50,50,"Can't go any further backwards", "red")
			kb[REWIND_KEY]=nil -- allows the button to be held
		end
	end

	joypad.set(inputs[fc])
end

local function rewind()
	if not REPLAY then return end
	fc = emu.framecount()
	relfc = relfc+1
	readInputs()
	inputParse()
end

--emu.registerexit(function() -- remove all the savestates
--		for i,_ in pairs(sstable) do
--			os.remove(i)
--		end
--		os.remove("pause")
--		os.remove("p1state")
--	end)

table.insert(registers.registerbefore, rewind)
