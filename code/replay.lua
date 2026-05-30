assert(rb,"Run fbneo-training-mode.lua")

-- load images
local savestateslot_icon=gd.createFromPng("resources/replay/savestateslot.png"):gdStr()
local hitplayback_icon=gd.createFromPng("resources/replay/hitplayback.png"):gdStr()
local savestateslotselected_icon=gd.createFromPng("resources/replay/savestateslotselected.png"):gdStr()
local hitplaybackselected_icon=gd.createFromPng("resources/replay/hitplaybackselected.png"):gdStr()

function drawReplayInfo(x, y)
	local selectcolour = interactivegui.page == "recordingslot" and colour.recordingselected or colour.recordingselect
	local savestateslot = interactivegui.page == "savestateslot" and savestateslotselected_icon or savestateslot_icon
	local hitplayback = interactivegui.page == "hitslot" and hitplaybackselected_icon or hitplayback_icon

	for i = 1, REPLAY_SLOTS_COUNT do
		if recording.recordingslot == i then
			gui.text(x+23,y+LETTER_HEIGHT*i, "Slot "..i, selectcolour)
		else
			gui.text(x+23,y+LETTER_HEIGHT*i, "Slot "..i)
		end
		if recording.savestateslot == i then
			gui.gdoverlay(x+11, y+LETTER_HEIGHT*i-2, savestateslot)
		end
		if recording.hitslot == i then
			gui.gdoverlay(x, y+LETTER_HEIGHT*i-2, hitplayback)
		end
		-- check if anything is recorded in that slot
		if (recording[i].p1start~=recording[i].p1finish and recording[i].p1finish and recording[i].p2start~=recording[i].p2finish and recording[i].p2finish) then
			gui.text(x+49, y+LETTER_HEIGHT*i, "P1&2")
		elseif (recording[i].p1start~=recording[i].p1finish and recording[i].p1finish) then
			gui.text(x+49, y+LETTER_HEIGHT*i, "P1")
		elseif (recording[i].p2start~=recording[i].p2finish and recording[i].p2finish) then
			gui.text(x+49, y+LETTER_HEIGHT*i, "P2")
		end
	end
end

-- Const
local SERIALISETABLE = {}
SERIALISETABLE.P1 = {}
SERIALISETABLE.P2 = {}

for i,v in pairs(joypad.get()) do -- assemble table in proper order
	local input
	if i:sub(1,2) == "P1" then -- P1 and P2 should have the same inputs
		input = i:sub(4)
		SERIALISETABLE.P1[#SERIALISETABLE.P1+1] = input
		SERIALISETABLE.P1[input] = #SERIALISETABLE.P1
		SERIALISETABLE.P2[#SERIALISETABLE.P2+1] = input
		SERIALISETABLE.P2[input] = #SERIALISETABLE.P2
	end
end

SERIALISETABLE.P1.len = #SERIALISETABLE.P1 -- used for cleaning up inputs
SERIALISETABLE.P2.len = SERIALISETABLE.P1.len

local function serialiseInit(recordslot) -- set up compression, reduce the size of _stable to make the numbers actually smaller
	-- prep for serialising
	recordslot._stable = {}
	recordslot._stable.P1 = copytable(SERIALISETABLE.P1)
	recordslot._stable.P2 = copytable(SERIALISETABLE.P2)
	local player, input, num
	for i,_ in pairs(recordslot.constants) do
		player = i:sub(1,2)
		input = i:sub(4)
		if player == "P1" and recordslot._stable.P1[input] then
			num = recordslot._stable.P1[input]
			for i = num+1, recordslot._stable.P1.len do
				recordslot._stable.P1[input] = nil -- remove
				recordslot._stable.P1[i-1] = recordslot._stable.P1[i]
				recordslot._stable.P1[ recordslot._stable.P1[i] ] = i-1
			end
			recordslot._stable.P1.len = recordslot._stable.P1.len-1
			for i = 1, #recordslot._stable.P1-recordslot._stable.P1.len do table.remove(recordslot._stable.P1) end-- remove garbage
			for i, v in pairs(recordslot._stable.P1) do if recordslot._stable.P1[v]==nil and i~="len" then recordslot._stable.P1[i]=nil end end
		elseif player == "P2" and recordslot._stable.P2[input] then
			num = recordslot._stable.P2[input]
			for i = num+1, recordslot._stable.P2.len do
				recordslot._stable.P2[input] = nil -- remove
				recordslot._stable.P2[i-1] = recordslot._stable.P2[i]
				recordslot._stable.P2[ recordslot._stable.P2[i] ] = i-1
			end
			recordslot._stable.P2.len = recordslot._stable.P2.len-1
			for i = 1, #recordslot._stable.P2-recordslot._stable.P2.len do table.remove(recordslot._stable.P2) end-- remove garbage
			for i, v in pairs(recordslot._stable.P2) do if recordslot._stable.P2[v]==nil and i~="len" then recordslot._stable.P2[i]=nil end end -- final check
		end
	end
end

local function serialise(recordslot) -- serialise and remove uncompressed data
	recordslot.serial_player = {}
	recordslot.serial_other = {}
	for i = 1, #recordslot do
		local num = 0
		recordslot.serial_player[i] = 0 -- player
		recordslot.serial_other[i] = {} -- other
		for j, v in pairs(recordslot[i].raw.P1 or {}) do
			if v and recordslot.constants["P1 "..j]==nil then num = bit.bor(num, bit.lshift(1, recordslot._stable.P1[j]-1)) end
		end
		for j, v in pairs(recordslot[i].raw.P2 or {}) do
			if v and recordslot.constants["P2 "..j]==nil then num = bit.bor(num, bit.lshift(1, recordslot._stable.P2[j]-1+recordslot._stable.P1.len)) end
		end
		for j, v in pairs(recordslot[i].raw.other or {}) do -- dipswitches aren't boolean so they can't be serialised
			if recordslot.constants[j]==nil then recordslot.serial_other[i][j] = v end -- only put in the ones we need. TODO keep a reference of names so these can be referred to as an index?
		end
		--final bit to track direction
		if recordslot[i].p1facingleft then num = bit.bor(num, bit.lshift(1, recordslot._stable.P1.len+recordslot._stable.P2.len)) end
		if recordslot[i].p2facingleft then num = bit.bor(num, bit.lshift(1, recordslot._stable.P1.len+recordslot._stable.P2.len+1)) end
		
		recordslot.serial_player[i] = num -- combined P1 & P2 inputs
		if isEmpty(recordslot.serial_other[i]) then recordslot.serial_other[i] = nil end -- more often than not dipswitches won't change
		
		recordslot[i].p1facingleft = nil -- we don't want to save these values
		recordslot[i].p2facingleft = nil
		recordslot[i].raw = nil
		recordslot[i] = nil
	end
end

local function unserialise(recordslot) -- takes inputs , _stable and constants to unserialise
	for frame = 1, #recordslot.serial_player do
		local serial, other = recordslot.serial_player[frame], recordslot.serial_other[frame] or {}
		local _stable, constants = recordslot._stable, recordslot.constants

		recordslot[frame] = {}

		recordslot[frame].raw = {} -- initialise
		for _, player in pairs({"P1", "P2"}) do
			recordslot[frame].raw[player] = {}
			for i = 1, #_stable[player] do
				recordslot[frame].raw[player][ _stable[player][i] ] = bit.band(serial,1)==1 -- unserialise
				serial = bit.rshift(serial,1)
			end
		end
		recordslot[frame].p1facingleft = bit.band(serial,1)==1 -- set direction flag
		recordslot[frame].p2facingleft = bit.band(serial,2)==2 -- set direction flag
		recordslot[frame].raw.other = {}
		for i, v in pairs(other) do
			recordslot[frame].raw.other[i] = v
		end

		for i, v in pairs(constants) do -- apply constants
			local player = i:sub(1,2)
			local input = i:sub(4)
			if player == "P1" then
				recordslot[frame].raw.P1[input] = v
			elseif player == "P2" then
				recordslot[frame].raw.P2[input] = v
			else
				recordslot[frame].raw.other[i] = v
			end
		end
	end
	recordslot.serial_player = nil
end

local savepackname = "save.replaypack"

function replaySave()
	for j = 1, #recording do -- try to serialise each recordslot
		local recordslot = recording[j]
		if not recordslot[1] or not recordslot[1].raw or not recordslot[1].raw.P1 or not recordslot[1].raw.P2 then -- nothing to do past here
		else
			if not recordslot.p1start and not recordslot.p2start then -- if nothing is recorded
				recording[j] = {}
			else
				recordslot.p1start = recordslot.p1start or #recordslot
				recordslot.p2start = recordslot.p2start or #recordslot
				for i=#recordslot,recordslot.p1start,-1 do
					if recordslot[i].raw.P1 then recordslot[i].raw.P1.Coin = false end -- clear coin
				end
				for i=#recordslot,recordslot.p2start,-1 do
					if recordslot[i].raw.P2 then recordslot[i].raw.P2.Coin = false end -- clear coin
				end
				serialiseInit(recordslot)
				serialise(recordslot)
			end
		end
	end
	local filename = gamepath
	if gamename~="" then
		filename = filename..savepackname
	else
		filename = filename..ROM_NAME..savepackname
	end
	saveTableToFile({gamename = gamename, version = FBNEO_TRAINING_MODE_VERSION}, recording, filename)
	write("Saving replaypack to: "..filename)
	-- unserialise each recordslot to make them functional again in the training mode
	for _, recordslot in ipairs(recording) do
		if recordslot.serial_player then
			unserialise(recordslot)
		end
	end
end

function replayLoad()
	local filename = gamepath
	if gamename~="" then
		filename = filename..savepackname
	else
		filename = filename..ROM_NAME..savepackname
	end
	if fexists(filename) then
		local metadata = loadMetaDataFromFile(filename)
		if metadata.gamename~=gamename then
			write("Tried to load replaypack for game: "..metadata.gamename)
			return
		end
		local newrecording = loadDataFromFile(filename)
		for i, recordslot in ipairs(newrecording) do -- copy over replayslots
			recording[i] = recordslot
		end
		updateReplayConfig(newrecording.config)
	else
		return
	end
	for _, recordslot in ipairs(recording) do -- ready the replays for use
		if recordslot.serial_player then
			unserialise(recordslot)
		end
	end
end

function toggleRecording(bool, vargs)
	if interactivegui.movehud.enabled then return end

	local swp = vargs and vargs.swapinputs

	if vargs then vargs.recording = false end
	toggleStates(vargs)

	vargs = vargs or {}

	if bool==nil then recording.enabled = not recording.enabled
	else recording.enabled = bool end

	recording.swapplayers = not recording.replayP1

	if swp~=false then -- we only want to toggle the inputs when toggleSwapInputs is not originally called
		if recording.swapplayers then
			toggleSwapInputs(recording.enabled, vargs)
		else
			toggleSwapInputs(false, vargs)
		end
	end

	if recording.enabled then -- start recording
		recording[recording.recordingslot] = {}
		recording[recording.recordingslot].constants = copytable(inputs.raw)
		recording.framestart = fc
	else -- stop recording
		local noRecordingP1 = not recording[recording.recordingslot].p1start
		local noRecordingP2 = not recording[recording.recordingslot].p2start
		local canRemoveP1 = recording.replayP1 and noRecordingP1
		local canRemoveP2 = recording.replayP2 and noRecordingP2
		if (recording.replayP1 and recording.replayP2 and canRemoveP1 and canRemoveP2) then
			recording[recording.recordingslot] = {} -- if nothing is recorded (P1 and P2), clear recording
		elseif (canRemoveP1 or canRemoveP2) then
			recording[recording.recordingslot] = {} -- if nothing is recorded (P1 or P2), clear recording
		end
		recording.framestart = nil -- stop recording
	end
end

local function processInputFrameForRecording(recordslot, frameinputs)
	for i, v in pairs(frameinputs.raw.P1 or {}) do
		if recordslot.constants["P1 "..i]~=v then recordslot.constants["P1 "..i]=nil end -- remove non-duping values from table
	end
	for i, v in pairs(frameinputs.raw.P2 or {}) do
		if recordslot.constants["P2 "..i]~=v then recordslot.constants["P2 "..i]=nil end -- remove non-duping values from table
	end
	for i, v in pairs(frameinputs.raw.other or {}) do
		if recordslot.constants[i]~=v then recordslot.constants[i]=nil end -- remove non-duping values from table
	end

	if not recordslot.p1start then -- move start forward to first frame that something happens on
		if orTable(frameinputs.raw.P1) and not frameinputs.raw.P1.Coin then
			recordslot.p1start = fc - recording.framestart
		end
	end

	if not recordslot.p2start then -- move start forward to first frame that something happens on
		if orTable(frameinputs.raw.P2) and not frameinputs.raw.P2.Coin then
			recordslot.p2start = fc - recording.framestart
		end
	end

	if orTable(frameinputs.raw.P1) and not frameinputs.raw.P1.Coin then  -- put finish on the last frame that something happens
		recordslot.p1finish = fc - recording.framestart
	end

	if orTable(frameinputs.raw.P2) and not frameinputs.raw.P2.Coin then  -- put finish on the last frame that something happens
		recordslot.p2finish = fc - recording.framestart
	end

	frameinputs.p1facingleft = gamevars.P1.facingleft
	frameinputs.p2facingleft = gamevars.P2.facingleft
	return frameinputs
end

function logRecording()
	if not recording.enabled then return end
	recording[recording.recordingslot] = recording[recording.recordingslot] or {}

	local recordslot = recording[recording.recordingslot]
	local frameinputs = {
		raw = {
			P1 = copytable(inputs.P1),
			P2 = copytable(inputs.P2),
			other = copytable(inputs.other)
		}
	}

	table.insert(recordslot, processInputFrameForRecording(recordslot, frameinputs))
	gui.text(1,1,"Slot "..recording.recordingslot.." (0/"..#recordslot..")","red")
end

local function randomiseSlot()
	if recording.randomise then
		local isSlotSaved = false
		for i = 1, REPLAY_SLOTS_COUNT do isSlotSaved = isSlotSaved or recording[i][1] end
		if not isSlotSaved then return end
		local pos
		_playbackslot = nil
		while _playbackslot==nil do -- keep running until we get a valid slot
			pos = math.random(REPLAY_SLOTS_COUNT)
			if recording[pos][1] then -- check if there's something in here
				_playbackslot = pos
			end
		end
		recording.playbackslot = _playbackslot
	else
		recording.playbackslot = recording.recordingslot -- otherwise we should playback whatever we last recorded
	end
end

function togglePlayBack(bool, vargs)
	if interactivegui.movehud.enabled then return end
	recording.playbackslot = nil

	local _rs = recording.recordingslot

	if vargs then vargs.playback = false end
	toggleStates(vargs)

	recording.recordingslot = _rs -- restore recordingslot after serialise (through toggleRecord)

	randomiseSlot() -- randomise slot if the that option is set

	local recordslot = recording[recording.playbackslot]
	if not recordslot then return end -- if the slot doesn't exist
	
	if not recordslot[1] then return end -- if nothing is recorded

	if bool==nil then recording.playback = not recording.playback
	else recording.playback = bool end

	if not recording.replayP1 and not recording.replayP2 then
		recording.replayP2 = true
	end

	for _, _recordslot in ipairs(recording) do -- reset all recordslots
		_recordslot.framestart = nil
	end
	
	if recording.playback then
		if recording.replayP1 and recording.replayP2 then
			recordslot.start = recordslot.p1start
			if (recordslot.start==nil and recordslot.p2start~=nil) or (recordslot.start>recordslot.p2start) then recordslot.start = recordslot.p2start end
		elseif recording.replayP1 then
			toggleSwapInputs(true)
			recordslot.start = recordslot.p1start
		else
			recordslot.start = recordslot.p2start
		end
		if recordslot.start==recordslot.finish then toggleSwapInputs(false) return end -- nothing recorded

		recording.startcounter = 0 -- randomise starting playback
		if recording.randomisedelay then
			recording.starttime = math.random(recording.delay+1)-1 -- [0,delay]
		else
			recording.starttime = recording.delay
		end
	end
end

function playBack()
	if not recording.playback then return end
	recording.playbackslot = recording.playbackslot or recording.recordingslot
	local recordslot = recording[recording.playbackslot]
	if not recordslot then return end

	recordslot.framestart = recordslot.framestart or fc - 1
	local recording_length = #recordslot

	local start = recording.skiptostart and recordslot.start or 0
	local finish = recording.skiptofinish and recordslot.finish or #recordslot

	if recording.delay>0 then gui.text(72,1,"Delay: "..recording.starttime) end -- show delay

	if recording.starttime > recording.startcounter then -- delay until replay starts
		gui.text(1,1,"Slot "..recording.playbackslot.." ("..fc-recordslot.framestart.."/"..recording_length..")")
		recording.startcounter = recording.startcounter+1
		recordslot.framestart = recordslot.framestart+1
		return
	end

	if (fc - recordslot.framestart + start) > finish then -- finished replaying
		if not recording.loop then -- totally finished replaying, reset everything
			recordslot.framestart = nil
			recording.playback = false
			recording.playbackslot = nil
			return
		else -- loop, reset the framestart so we play again
			randomiseSlot() -- randomise slot if the option is set
			recordslot = recording[recording.playbackslot]
			recordslot.framestart = fc-1
			if recording.delay>0 and recording.randomisedelay then
				recording.starttime = math.random(recording.delay+1)-1 -- [0,delay]
			end
		end
	end

	gui.text(1,1,"Slot "..recording.playbackslot.." ("..fc-recordslot.framestart.."/"..recording_length..")")

	local frame = fc - recordslot.framestart + start
	local recordframe = recordslot[frame]
	local raw = copytable(recordframe.raw)

	if gamevars.P1.facingleft ~= recordframe.p1facingleft and recording.autoturn then
		raw.P1 = swapPlayerDirection(raw.P1)
	end
	if gamevars.P2.facingleft ~= recordframe.p2facingleft and recording.autoturn then
		raw.P2 = swapPlayerDirection(raw.P2)
	end
	if recording.replayP1 and recording.replayP2 then
		inputs.setinputs = combinePlayerInputs(raw.P1, raw.P2, raw.other)
	elseif recording.replayP1 then
		inputs.setinputs = combinePlayerInputs(raw.P1, inputs.P2, raw.other)
	else
		inputs.setinputs = combinePlayerInputs(inputs.P1, raw.P2, raw.other)
	end
	raw = nil
end

function hitPlayBack()
	if recording.hitslot < 1 or recording.hitslot > REPLAY_SLOTS_COUNT then return end
	if combovars.P2.previouscombo <= combovars.P2.combo then return end
	recording.playbackslot = recording.hitslot
	togglePlayBack(true)
end

function savestatePlayBack()
	if recording.savestateslot < 1 or recording.savestateslot > REPLAY_SLOTS_COUNT then return end
	recording.playbackslot = recording.savestateslot
	togglePlayBack(true)
end

----------------------------------------------
-- REPLAY EDITOR
----------------------------------------------

function toggleReplayEditor(bool, vargs)
	-- need state switching
	
	local re = interactivegui.replayeditor

	if bool==nil then re.enabled = not re.enabled
	else re.enabled=bool end

	if vargs then vargs.replayeditor = false end
	toggleStates(vargs)

	if re.enabled then -- set up for display
		re.inputs = {}
		for j = 1, #recording do
			re.inputs[j] = {}
			local recordslot = recording[j]
			for i = 1, #recordslot do
				re.inputs[j][i] = recordslot[i]
			end
		end
	else -- save the recordslots with the new inputs
		if not re.changed then return end
		for k, _ in pairs(re.changed) do
			local recordslot = recording[k]
			recordslot.constants = copytable(inputs.raw)
			recording.framestart = fc-1
			for i, _ in ipairs(re.inputs[k]) do
				recordslot[i] = nil
				recordslot[i] = processInputFrameForRecording(recordslot, re.inputs[k][i])
			end
		end
		re.changed = {}
	end
end

-- move everything up one, starting at frame
local function replayEditorMoveUp(reinputs, frame)
	for i = frame, #reinputs-1 do
		reinputs[i] = {
			raw = {
				P1 = copytable(reinputs[i+1].raw.P1),
				P2 = copytable(reinputs[i+1].raw.P2),
				other = copytable(reinputs[i+1].raw.other)
			},
			p1facingleft = reinputs[i+1].p1facingleft,
			p2facingleft = reinputs[i+1].p2facingleft
		}
	end
end

-- move everything down one, starting at frame
local function replayEditorMoveDown(reinputs, frame)
	for i = #reinputs, frame, -1 do
		reinputs[i+1] = {
			raw = {
				P1 = copytable(reinputs[i].raw.P1),
				P2 = copytable(reinputs[i].raw.P2),
				other = copytable(reinputs[i].raw.other)
			},
			p1facingleft = reinputs[i].p1facingleft,
			p2facingleft = reinputs[i].p2facingleft
		}
	end
end

local drawReplayEditorFuncs = {
	function(but) -- set
		if interactivegui.replayeditor.framestart then -- countdown to taking input
			local timer = 30
			gui.text(1,1,timer-(fc-interactivegui.replayeditor.framestart),"red")
			if fc >= interactivegui.replayeditor.framestart+timer or interactivegui.replayeditor.framestart>fc then -- half second timer
				local recordslot = recording[recording.recordingslot]
				local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]
				local frame = interactivegui.replayeditor.editframe

				reinputs[frame] = {
					raw = {
						P1 = {},
						P2 = copytable(inputs.P1),
						other = copytable(inputs.other)
					},
					p1facingleft = gamevars.P1.facingleft,
					p2facingleft = gamevars.P2.facingleft
				}

				if (orTable(inputs.P1)) then -- if an input has been passed temp update start/finish for visuals
					if not recordslot.p2start then recordslot.p2start = frame end
					if frame<recordslot.p2start then
						recordslot.p2start = frame
					end
					if not recordslot.p2finish then recordslot.p2finish = frame end
					if frame>recordslot.p2finish then
						recordslot.p2finish = frame
					end
				end

				interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {} -- this slot has updated
				interactivegui.replayeditor.changed[recording.recordingslot] = true

				interactivegui.replayeditor.editframe=frame+1
				interactivegui.replayeditor.framestart=nil
			end
		elseif guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then -- starts the timer
			interactivegui.replayeditor.framestart = fc
		end
	end,
	function(but) -- duplicate
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			if interactivegui.replayeditor.framestart or not interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] then return end -- something to copy
			local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]

			replayEditorMoveDown(reinputs, interactivegui.replayeditor.editframe)

			local recordslot = recording[recording.recordingslot] -- update start/finish for visuals
			if (recordslot.p2start and interactivegui.replayeditor.editframe<recordslot.p2start) then -- plus one
				recordslot.p2start = recordslot.p2start+1
			end
			if (recordslot.p2finish and interactivegui.replayeditor.editframe<=recordslot.p2finish) then -- plus one
				recordslot.p2finish = recordslot.p2finish+1
			end

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
			interactivegui.replayeditor.editframe=interactivegui.replayeditor.editframe+1
		end
	end,
	function(but) -- clear
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local prev_p2facingleft = interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] and interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p2facingleft
			interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] = {raw={P1={}, P2={}}, p2facingleft = prev_p2facingleft}

			local recordslot = recording[recording.recordingslot]

			local temp = true -- update start/finish for visuals
			if recordslot.p2start == interactivegui.replayeditor.editframe then -- iterate forward
				for i = recordslot.p2start+1, #interactivegui.replayeditor.inputs[recording.recordingslot] do
					if orTable(interactivegui.replayeditor.inputs[recording.recordingslot][i].raw.P2) and temp then
						recordslot.p2start = i
						temp = false -- found start
					end
				end
			end
			temp = true
			if recordslot.p2finish == interactivegui.replayeditor.editframe then -- iterate backwards
				for i = recordslot.p2finish-1, 1, -1 do
					if orTable(interactivegui.replayeditor.inputs[recording.recordingslot][i].raw.P2) and temp then
						recordslot.p2finish = i
						temp = false -- found finish
					end
				end
			end

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
		end
	end,
	function(but) -- delete
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]
			if #reinputs==0 then return end -- nothing to delete

			replayEditorMoveUp(reinputs, interactivegui.replayeditor.editframe)

			reinputs[#reinputs] = nil -- remove one

			local recordslot = recording[recording.recordingslot]

			local temp = true -- update start/finish for visuals
			if recordslot.p2start == interactivegui.replayeditor.editframe then -- If we deleted the start frame, find the next start frame
				for i = recordslot.p2start+1, #interactivegui.replayeditor.inputs[recording.recordingslot] do
					if orTable(interactivegui.replayeditor.inputs[recording.recordingslot][i].raw.P2) and temp then
						recordslot.p2start = i
						temp = false -- found start
					end
				end
			elseif (recordslot.p2start and interactivegui.replayeditor.editframe<recordslot.p2start) then -- minus 1
				recordslot.p2start = recordslot.p2start-1
			end
			temp = true
			if recordslot.p2finish == interactivegui.replayeditor.editframe then -- If we deleted the end frame, find the new end frame
				for i = recordslot.p2finish-1, 1, -1 do
					if orTable(interactivegui.replayeditor.inputs[recording.recordingslot][i].raw.P2) and temp then
						recordslot.p2finish = i
						temp = false -- found finish
					end
				end
			elseif (recordslot.p2finish and interactivegui.replayeditor.editframe<recordslot.p2finish) then -- minus 1
				recordslot.p2finish = recordslot.p2finish-1
			end

			recordslot[#recordslot] = nil -- remove one

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
		end
	end,
	function(but) -- blank
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			if (interactivegui.replayeditor.editframe==#interactivegui.replayeditor.inputs[recording.recordingslot]+1) then
				local prev_p2facingleft = interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe-1] and interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe-1].p2facingleft
				interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] = {raw={P1={}, P2={}}, p2facingleft = prev_p2facingleft}
			else
				local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]
				replayEditorMoveDown(reinputs, interactivegui.replayeditor.editframe)
				local prev_p2facingleft = interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] and interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p2facingleft
				reinputs[interactivegui.replayeditor.editframe+1] = {raw={P1={}, P2={}}, p2facingleft = prev_p2facingleft}
			end

			local recordslot = recording[recording.recordingslot] -- update for visuals
			if (recordslot.p2start and interactivegui.replayeditor.editframe<recordslot.p2start) then -- plus one
				recordslot.p2start = recordslot.p2start+1
			end
			if (recordslot.p2finish and interactivegui.replayeditor.editframe<recordslot.p2finish) then -- plus one
				recordslot.p2finish = recordslot.p2finish+1
			end

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
		end
	end,
	function(but) -- dec slot
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local slot = getConfigValue("recordingslot")
			if slot <= 1 then
				changeConfig("recordingslot", REPLAY_SLOTS_COUNT)
			else
				changeConfig("recordingslot", slot-1)
			end
		end
	end,
	function(but) -- inc slot
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			local slot = getConfigValue("recordingslot")
			if slot >= REPLAY_SLOTS_COUNT then
				changeConfig("recordingslot", 1)
			else
				changeConfig("recordingslot", slot+1)
			end
		end
	end,
	function(but) -- swap player side
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then -- invert direction
			if not interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe] then return end -- bad input
			interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p1facingleft = not interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p1facingleft
			interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p2facingleft = not interactivegui.replayeditor.inputs[recording.recordingslot][interactivegui.replayeditor.editframe].p2facingleft

			interactivegui.replayeditor.changed = interactivegui.replayeditor.changed or {}
			interactivegui.replayeditor.changed[recording.recordingslot] = true
		end
	end,
	back = function(but) -- return to main menu
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1[but] and not guiinputs.P1.previousinputs[but] then
			toggleInteractiveGUI(true, {})
		end
	end,
	coin = function()
		if guiinputs.P1.coin and not guiinputs.P1.previousinputs.coin then
			interactivegui.replayeditor.framestart = nil -- disable timer
		end
	end,
	more = function(but)
		if interactivegui.replayeditor.framestart then return end
		if not (guiinputs.P1[but] and not guiinputs.P1.previousinputs[but]) then return end
		if nbuttons+helpElements.block*(nbuttons-2) >= #helpElements then helpElements.block = 0 end
		for i = 1, nbuttons-2 do -- space for more and back
			local temp = helpElements[i]
			local offset = helpElements.block*(nbuttons-2) + i + nbuttons
			helpElements[i] = {} -- clear
			if not (offset > #helpElements) and next(helpElements[offset]) then
				helpElements[i] = helpElements[offset]
				helpElements[i].button = i -- make sure the buttons are set up right
				helpElements[i].buttonnum = "button"..i
				helpElements.len = i+2
			end
			helpElements[offset] = temp
		end
		helpElements.block = helpElements.block+1
	end,
	other = function()
		if interactivegui.replayeditor.framestart then return end
		if guiinputs.P1.upframecount ~= 0 then interactivegui.replayeditor.editframe=interactivegui.replayeditor.editframe-scaleinputnum(guiinputs.P1.upframecount) end
		if guiinputs.P1.downframecount ~= 0 then interactivegui.replayeditor.editframe=interactivegui.replayeditor.editframe+scaleinputnum(guiinputs.P1.downframecount) end
	end,
	name = "drawReplayEditorFuncs",
}

function drawReplayEditor()
	if not interactivegui.replayeditor.enabled then return end
	local length = SERIALISETABLE.P1.len-1 -- don't want to include start or coin
	local recordslot = recording[recording.recordingslot]
	local reinputs = interactivegui.replayeditor.inputs[recording.recordingslot]

	--use these to control how a grid is drawn, boxes are 16x16
	local boxsize = 16
	local x,y = interactivegui.sw/2 - (length)*(boxsize/2),1
	local frames = math.floor((interactivegui.sh-27-y)/boxsize)-1 -- Tooltips are 27px high, avoid drawing under them

	helpElements.buttons = {
		{name="SET"},
		{name="DUPE"},
		{name="CLR"},
		{name="DEL"},
		{name="BLNK"},
		{name="<NUM"},
		{name="NUM>"},
		{name="SIDE"},
		funcs = drawReplayEditorFuncs
	}

	-- draw in frame numbers
	if not interactivegui.replayeditor.editframe or interactivegui.replayeditor.editframe<1 then interactivegui.replayeditor.editframe = 1 end -- failsafe
	local startframe = interactivegui.replayeditor.editframe -- first frame to draw
	startframe = startframe-math.floor(frames/2)
	if not reinputs[startframe+frames] then startframe = #reinputs-frames+2 end -- display only one frame out of bounds
	if startframe<1 then startframe = 1 end -- failsafe
	if interactivegui.replayeditor.editframe>=#reinputs+1 then interactivegui.replayeditor.editframe = #reinputs+1 end -- keep selection in bounds
	for i = 0, frames-1 do
		if startframe+i == interactivegui.replayeditor.editframe then
			gui.box(x, y+boxsize*(i+1), x+length*boxsize, y+boxsize*(i+2), "gray") -- highlight selected
		end
		if startframe+i == recordslot.p2start then -- highlight start frame
			gui.box(x, y+boxsize*(i+1), x+boxsize, y+boxsize*(i+2), "green")
		end
		if startframe+i == recordslot.p2finish then -- highlight end frame
			gui.box(x, y+boxsize*(i+1), x+boxsize, y+boxsize*(i+2), "orange")
		end
		gui.text(x + boxsize - #tostring(startframe+i)*LETTER_WIDTH, y+6+boxsize*(i+1), tostring(startframe+i))
	end

	-- draw grid
	gui.box(x,y,x+length*boxsize,y+boxsize, "blue") -- blue background
	gui.line(x,y,x+length*boxsize,y) -- top line of top
	gui.line(x,y+boxsize,x+length*boxsize,y+boxsize) -- underline of top
	gui.line(x,y,x,y+boxsize+boxsize*frames) -- first vertical line
	gui.line(x+length*boxsize,y,x+length*boxsize,y+boxsize+boxsize*frames) -- last vertical line
	gui.text(x+1,y+1,"SLOT")
	gui.text(x+7,y+8,recording.recordingslot)
	for i = 1,length-1 do
		gui.line(x+i*boxsize,y,x+i*boxsize,y+boxsize+boxsize*frames) -- vertical lines
		gui.gdoverlay(x+i*boxsize, y, helpIcons[boxsize][i])
	end
	for i = 1, frames do -- should be the length of frames shown
		gui.line(x,y+boxsize+i*boxsize,x+length*boxsize,y+boxsize+i*boxsize) -- horizontal lines
	end

	if startframe+frames>#reinputs+1 then -- make sure end of replay is on screen
		gui.line(x,y+2*boxsize+(#reinputs-startframe)*boxsize,x+length*boxsize,y+2*boxsize+(#reinputs-startframe)*boxsize,"red") -- red line marking end of replay
	end

	gui.box(x,y+boxsize+frames*boxsize,x+boxsize,y+2*boxsize+frames*boxsize, "blue") -- draw box with the number of inputs
	gui.box(x,y+boxsize+frames*boxsize,x+boxsize,y+2*boxsize+frames*boxsize)
	gui.text(x+7-(#tostring(#reinputs)-1)*2,y+22+frames*boxsize,#reinputs,"red")

	gui.box(x+length*boxsize-boxsize,y+boxsize+frames*boxsize,x+length*boxsize,y+2*boxsize+frames*boxsize, "blue") -- draw box with the orientation of the input
	gui.box(x+length*boxsize-boxsize,y+boxsize+frames*boxsize,x+length*boxsize,y+2*boxsize+frames*boxsize)
	if reinputs[interactivegui.replayeditor.editframe] and reinputs[interactivegui.replayeditor.editframe].p2facingleft == true then
		gui.text(x+length*boxsize-9,y+22+frames*boxsize,"L", "red")
	elseif reinputs[interactivegui.replayeditor.editframe] and reinputs[interactivegui.replayeditor.editframe].p2facingleft == false then
		gui.text(x+length*boxsize-9,y+22+frames*boxsize,"R", "red")
	else
		gui.text(x+length*boxsize-13,y+22+frames*boxsize,"N/A")
	end

	--deserialise and images
	--make sure that it does need to display images
	if not reinputs or not reinputs[1] then return end
	if not recordslot or not reinputs[1].raw.P2 then return end

	for i = 0, frames-1 do
		if not reinputs[startframe+i] then break end
		for k, v in pairs(reinputs[startframe+i].raw.P2) do
			if v and k~="Coin" then -- Never display Coin
				gui.gdoverlay(
					x+boxsize*gamevars.constants.translationtable[k],
					y+boxsize*(i+1),
					helpIcons[boxsize][gamevars.constants.translationtable[k]]
				)
			end
		end
	end
end