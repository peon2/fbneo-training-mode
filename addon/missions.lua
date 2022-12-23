---------------------------------------------------------------------
--	Add-on allowing to save a savestate with one or multiple actions
--	to be performed by the dummy. Those scenarios can then be selected
--	in a menu called "Missions".
--	I hope this word is not too misleading : it was my first idea
--	since this project is inspired by TRUST, a former project of
--	Shoryuken's forum which used this terminolgy.
--	We could change this later anyway if someone comes with a better
--	option.
--
--	Made by Asunaro
---------------------------------------------------------------------

---------------------------------------------------------------------
--	To be improved/added :
--	- Insert new pages in characters' sections if more than
--	30 missions are created
--	- Visual bug : Fix the "disappearing" of save_frame's textfield
--	and slot buttons when you enter name edition
--	- Lua hotkey 5 is not really intuitive
--	- Accept numbers in save_name only if they follow a character
---------------------------------------------------------------------

---------------------------------------------------------------------
-- 	Changes made by pof to make it generic for all games:
-- 	- removed ssf2x character detection, paths...
--	- added replay takeover (for P1 only so far)
--	- changed ST specific stuff like gamestate, frameCount, etc.
---------------------------------------------------------------------

------------------------------------------
--	Initialization
------------------------------------------
local DEBUG = false

if REPLAY then print "For replay takeover, press Alt+5 to record a mission" end

function back() -- Should be modified since "back" could be mapped to another button
	if guiinputs.P1["button6"] and not guiinputs.P1.previousinputs["button6"] then
		return true
	else
		return false
	end
end

if dirname == "" then
	dirname = emu.romname()
end

--------------------------------------------------
--	Textfield : adaptation of Grouflon's work
-- 	https://github.com/Grouflon/3rd_training_lua
--------------------------------------------------
local available_characters = {
	" ",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
--	"0",
--	"1",
--	"2",
--	"3",
--	"4",
--	"5",
--	"6",
--	"7",
--	"8",
--	"9",
	"_",
}

local numbers = {
	" ",
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
}

createTextfield = function(BaseMenu, name, x, y, max_length, characters_set, text)
	-------------------------------------------------------------
	-- Create a duplicata of BaseMenu with unselectable buttons
	-------------------------------------------------------------
	local menu = {}
	for i, v in pairs(BaseMenu) do
		menu["a"..i] = v
	end
	-------------------------
	-- Create the textfield
	-------------------------
	BaseMenu[name] = { x = x - 4 , y = y, text = "",}
	menu.tf_help = { text = "Right: Next  Left: Prev  Up/Down: Change character", x = -5, y = 100}	-- to be modified if this function is used out of this script

	local tf = {}
	tf.x = x*1000 -- this way the button automatically created should be hidden (maybe there's a cleaner way)
	tf.y = y*1000

	tf.max_length = max_length
	tf.content = {}	-- stocks the characters in decimal values
	tf.string = ""	-- stocks the string
	tf.edition_index = 1 -- trace wich character will be modified
	tf.in_edition = false

	local _available_characters = {}
	if characters_set then
		_available_characters = characters_set
	else
		_available_characters = available_characters
	end

	if text then
		tf.string = text
	end
	-------------------------------
	-- Functions used for edition
	-------------------------------
	function tf:enter_edition()
		if not tf.in_edition then
			tf:sync_from_var()
			if #tf.content < tf.max_length then
				table.insert(tf.content, 1)
			end
			tf.edition_index = #tf.content
			tf.in_edition = true
		end
	end

	function tf:sync_from_var()
		tf.content = {}
		for i = 1, #tf.string do
			local _c = string.sub(tf.string, i, i)
			for j = 1, #_available_characters do
				if _available_characters[j] == _c then
					table.insert(tf.content, j)
					break
				end
			end
		end
		return tf.content
	end

	function tf:sync_to_var()
		local _str = ""
		for i = 1, #tf.content do
			_str = _str.._available_characters[tf.content[i]]
		end
		tf.string = _str
	end

	function tf:draw()
		local _c = 0xFFFF00FF
		local _cycle = 100
		if ((emu.framecount() % _cycle) / _cycle) < 0.5 then
			gui.text(interactivegui.boxx + x - 3 + (#tf.content - 1) * 4, interactivegui.boxy + y + 4, "_", _c)
		end
		gui.text(interactivegui.boxx + x - 3, interactivegui.boxy + y + 2, tf.string, _c)
	end

	function tf:crop_char_table()
		local _last_empty_index = 0
		for i = 1, #tf.content do
			if tf.content[i] == 1 then
				_last_empty_index = i
			else
				_last_empty_index = 0
			end
		end
		if _last_empty_index > 0 then
			for i = _last_empty_index, #tf.content do
				table.remove(tf.content, _last_empty_index)
			end
		end
		tf:sync_to_var()
	end

	function tf:left()
		if guiinputs.P1.left and not guiinputs.P1.previousinputs.left then
			tf:reset()
		end
	end

	function tf:right()
		if guiinputs.P1.right and not guiinputs.P1.previousinputs.right then
			tf:validate()
		end
	end

	function tf:up()
		if guiinputs.P1.up and not guiinputs.P1.previousinputs.up then
			tf.content[tf.edition_index] = tf.content[tf.edition_index] + 1
			if tf.content[tf.edition_index] > #_available_characters then
				tf.content[tf.edition_index] = 1
			end
			tf:sync_to_var()
			return true
		else
			return false
		end
	end

	function tf:down()
		if guiinputs.P1.down and not guiinputs.P1.previousinputs.down then
			tf.content[tf.edition_index] = tf.content[tf.edition_index] - 1
			if tf.content[tf.edition_index] == 0 then
				tf.content[tf.edition_index] = #_available_characters
			end
			tf:sync_to_var()
			return true
		else
			return false
		end
	end

	function tf:validate()
		if tf.content[tf.edition_index] ~= 1 then
			if #tf.content < tf.max_length then
				table.insert(tf.content, 1)
				tf.edition_index = #tf.content
			end
			tf:sync_to_var()
		end
	end

	function tf:reset()
		if #tf.content > 1 then
			table.remove(tf.content, #tf.content)
			tf.edition_index = #tf.content
		else
			tf.content[1] = 1
		end
		tf:sync_to_var()
	end

	function tf:exit()
		tf:crop_char_table()
		tf.in_edition = false
		BaseMenu[name].text = tf.string
	end

	function tf:clear()
		tf.content = {}
		if text then
			tf.string = text
		else
			tf.string = ""
		end
		tf.edition_index = 1
		tf.in_edition = false
		BaseMenu[name].text = tf.string
	end

	tf:sync_from_var()
	tf:sync_to_var()
	BaseMenu[name].text = tf.string
	---------------------------------------
	-- Functions runned by the textfield
	---------------------------------------
	tf.autofunc = 	function(this)
		tf:enter_edition()
		tf:draw()
		tf:left()
		tf:right()
		tf:up()
		tf:down()
		if back() then
			tf:exit()
		end
	end
	tf.func = function()
		tf:exit()
		CIG(interactivegui.previouspage, interactivegui.previousselection)
	end

	menu[1] = tf
	return menu
end
-----------------------------
--	Guipages
-----------------------------
-----------------------------
--	Mission menu
-----------------------------
local missions_button = {
		text = "Missions",
		olcolour = "black",
		info = {
			"A mission is a savestate coupled with one or more replay files.",
			"When you select a mission, its savestate is loaded regularly",
			"and the dummy performs the actions saved in the replay"
		},
		func = 	function() CIG("missions_hub", 1) end,
	}
insertAddonButton(missions_button)
------------------------------------------
local missions_hub = {
	title = {
		text = "Missions",
		x = interactivegui.boxxlength/2 - 25,
		y = 1,
	},
	infos = {
		text = "In-game press Alt+5 to create a new mission",
		x = 55,
		y = 110,
	},
	{
		text = "<",
		olcolour = "black",
		info = "Back",
		func =  function() CIG("addonpage1",1) end,
	},
	{
		text = "Delete the selected missions",
		x = 150,
		y = 150,
		olcolour = "black",
		func =  function() end,
	},
}

local missions_hub_characters = {}
if (emu.romname() == 'ssf2xjr1') then
	missions_hub_characters = {
		{
			text = "Blanka",
			x = 35,
			y = 35,
			olcolour = "black",
			handle = 1,
			func = 	function() CIG("blanka_missions_page", 1) end,
		},
		{
			text = "Boxer",
			x = 35,
			y = 50,
			olcolour = "black",
			handle = 2,
			func = 	function() CIG("boxer_missions_page", 1) end,
		},
		{
			text = "Cammy",
			x = 35,
			y = 65,
			olcolour = "black",
			handle = 3,
			func = 	function() CIG("cammy_missions_page", 1) end,
		},
		{
			text = "Chun Li",
			x = 35,
			y = 80,
			olcolour = "black",
			handle = 4,
			func = 	function() CIG("chunli_missions_page", 1) end,
		},
		{
			text = "Claw",
			x = 95,
			y = 35,
			olcolour = "black",
			handle = 5,
			func = 	function() CIG("claw_missions_page", 1) end,
		},
		{
			text = "Dhalsim",
			x = 95,
			y = 50,
			olcolour = "black",
			handle = 6,
			func = 	function() CIG("dhalsim_missions_page", 1) end,
		},
		{
			text = "Dictator",
			x = 95,
			y = 65,
			olcolour = "black",
			handle = 7,
			func = 	function() CIG("dictator_missions_page", 1) end,
		},
		{
			text = "Dee Jay",
			x = 95,
			y = 80,
			olcolour = "black",
			handle = 8,
			func = 	function() CIG("deejay_missions_page", 1) end,
		},
		{
			text = "Fei Long",
			x = 155,
			y = 35,
			olcolour = "black",
			handle = 9,
			func = 	function() CIG("feilong_missions_page", 1) end,
		},
		{
			text = "Guile",
			x = 155,
			y = 50,
			olcolour = "black",
			handle = 10,
			func = 	function() CIG("guile_missions_page", 1) end,
		},
		{
			text = "Honda",
			x = 155,
			y = 65,
			olcolour = "black",
			handle = 11,
			func = 	function() CIG("ehonda_missions_page", 1) end,
		},
		{
			text = "Ken",
			x = 155,
			y = 80,
			olcolour = "black",
			handle = 12,
			func = 	function() CIG("ken_missions_page", 1) end,
		},
		{
			text = "Ryu",
			x = 215,
			y = 35,
			olcolour = "black",
			handle = 13,
			func = 	function() CIG("ryu_missions_page", 1) end,
		},
		{
			text = "Sagat",
			x = 215,
			y = 50,
			olcolour = "black",
			handle = 14,
			func = 	function() CIG("sagat_missions_page", 1) end,
		},
		{
			text = "T-Hawk",
			x = 215,
			y = 65,
			olcolour = "black",
			handle = 15,
			func = 	function() CIG("thawk_missions_page", 1) end,
		},
		{
			text = "Zangief",
			x = 215,
			y = 80,
			olcolour = "black",
			handle = 16,
			func = 	function() CIG("zangief_missions_page", 1) end,
		},
	}
else
	missions_hub_characters = {
		{
			text = dirname,
			x = 35,
			y = 35,
			olcolour = "black",
			handle = 1,
			func = 	function() CIG("game_missions_page", 1) end,
		},
	}
end
for i = 1, #missions_hub_characters do
	table.insert(missions_hub, missions_hub_characters[i])
end
guipages.missions_hub = missions_hub
-------------------------------
--	Characters' folders
-------------------------------
local function makeCharacterPage(character)
	return {
		title = {
			text = "Missions for "..character,
			x = interactivegui.boxxlength/2 - 25,
			y = 1,
		},
		{
			text = "<",
			olcolour = "black",
			info = "Back",
			func =  function() CIG("missions_hub",1) end,
		},
	}
end

local characters_name = { dirname };
local characters = characters_name;
if (emu.romname() == 'ssf2xjr1') then
	characters =
	{
		"blanka",
		"boxer",
		"cammy",
		"chunli",
		"claw",
		"deejay",
		"dhalsim",
		"dictator",
		"ehonda",
		"feilong",
		"guile",
		"ken",
		"ryu",
		"sagat",
		"thawk",
		"zangief",
	}
	characters_name = {
		"Blanka",
		"Boxer",
		"Cammy",
		"Chun Li",
		"Claw",
		"Dee Jay",
		"Dhalsim",
		"Dictator",
		"Honda",
		"Fei Long",
		"Guile",
		"Ken",
		"Ryu",
		"Sagat",
		"T-hawk",
		"Zangief",
	}
end

local missions_page = {}
for i = 1, #characters do
	missions_page[characters[i]] = makeCharacterPage(characters_name[i])
end

-- Inserting character specific pages
if (emu.romname() == 'ssf2xjr1') then
	guipages.blanka_missions_page = missions_page["blanka"]
	guipages.boxer_missions_page = missions_page["boxer"]
	guipages.cammy_missions_page = missions_page["cammy"]
	guipages.chunli_missions_page = missions_page["chunli"]
	guipages.claw_missions_page = missions_page["claw"]
	guipages.deejay_missions_page = missions_page["deejay"]
	guipages.dhalsim_missions_page = missions_page["dhalsim"]
	guipages.dictator_missions_page = missions_page["dictator"]
	guipages.feilong_missions_page = missions_page["feilong"]
	guipages.guile_missions_page = missions_page["guile"]
	guipages.ehonda_missions_page = missions_page["ehonda"]
	guipages.ken_missions_page = missions_page["ken"]
	guipages.ryu_missions_page = missions_page["ryu"]
	guipages.sagat_missions_page = missions_page["sagat"]
	guipages.thawk_missions_page = missions_page["thawk"]
	guipages.zangief_missions_page = missions_page["zangief"]
else
	guipages.game_missions_page = missions_page[dirname]
end

-- Inserting buttons in those pages
missions_list = {}
local function insertMissionsButtons(character) -- should be modified to allow more than 30 missions
	table.sort(missions_list[character], function(a,b) return a["text"] < b["text"] end)
	local _x = 20
	local _y = 20
	for k in pairs(missions_list[character]) do
		if k == 11 then
			_x = 110
		elseif k == 21 then
			_x = 200
		end
		missions_list[character][k].x = _x
		if k > 1 and k ~= 11 and k ~= 21 then
			missions_list[character][k].y = missions_list[character][k-1].y+15
		else
			missions_list[character][k].y = _y
		end
		table.insert(missions_page[character], missions_list[character][k])
	end
end

local function createMissionsFile(character)
	-- Create empty missions_list.lua file if one does not exist
	if not fexists("games/"..dirname.."/missions_saved/"..character.."/missions_list.lua") then
		os.execute("mkdir games\\"..dirname.."\\missions_saved\\"..character) -- windows
		os.execute("mkdir games/"..dirname.."/missions_saved/"..character) -- posix
		local file = io.open("games/"..dirname.."/missions_saved/"..character.."/missions_list.lua", "w")
		file:write("missions_list[\""..character.."\"] = {}\n---------------------------------------------------------")
		file:close()
	end
end

for i = 1, #characters do
	createMissionsFile(characters[i])
	dofile("games/"..dirname.."/missions_saved/"..characters[i].."/missions_list.lua")
	insertMissionsButtons(characters[i])
end

-------------------------------
--	Save pop-up
-------------------------------
interactivegui.boxxlength = 2*(emu.screenwidth()/4) -- a temporary modification since the next page will be smaller than usual
local save_mission = {
		title = {
			text = "Save Mission",
			x = interactivegui.boxxlength/2 - 25,
			y = 1,
		},
		infos = {
			text = "",
			x = 53,
			y = 82,
		},
		{
			text = "Name : ",
			x = 20,
			y = 20,
			fillpercent = 0,
			olcolour = "white",
			info = {
				"Name of your mission",
				"Use Up and Down to select a character, Right to validate"
			},
			func = 	function()
						CIG("save_name")
					end,
		},
		slots = {
			text = "Replay slots : ",
			x = 20,
			y = 35,
			fillpercent = 0,
			olcolour = "white",
			info = "",
		},
		{
			text = "Frames between two replays : ",
			x = 20,
			y = 50,
			fillpercent = 0,
			olcolour = "white",
			info = {
				"Controls how many frames should be left after a replay end and before",
				"the savestate is loaded again"
			},
			func = 	function()
						CIG("save_frame")
					end,
		},
		{
			text = "Save",
			x = 80,
			y = 68,
			fillpercent = 0,
			olcolour = "black",
			info = {
				"Saves your mission in your game's directory"
			},
		},
}

local slot_buttons = {}
local function createSlotButtons()
	local horizontal_length = 73
	for i = 1, 5 do
		horizontal_length = horizontal_length + 14
		slot_buttons[i] = {
			text = tostring(i),
			x = horizontal_length,
			y = 35,
			olcolour = "black",
			slot = true,
			fillpercent = 0,
			checked = false,
			func = function() end,
			autofunc = function(this)
				if this.checked then
					this.fillpercent = 1
				elseif not this.checked then
					this.fillpercent = 0
				end
			end,
		}
	end
end
createSlotButtons()

local function createSlotsFunctions()
	local newfunction = nil
	for i = 1, #slot_buttons do
		if i == 1 then
		newfunction = function()
				slot_buttons[1].checked = not slot_buttons[1].checked
				end
		elseif i == 2 then
			newfunction = function()
				slot_buttons[2].checked = not slot_buttons[2].checked
				end
		elseif i == 3 then
			newfunction = function()
				slot_buttons[3].checked = not slot_buttons[3].checked
				end
		elseif i == 4 then
			newfunction = function()
				slot_buttons[4].checked = not slot_buttons[4].checked
				end
		elseif i == 5 then
			newfunction = function()
				slot_buttons[5].checked = not slot_buttons[5].checked
				end
		end
		slot_buttons[i].func = newfunction
	end
end
createSlotsFunctions()

local function insertSlotButtons()
	if #save_mission ~= 3 then -- if one or more slot buttons has been inserted
		for i = 1, #save_mission-3 do
			table.remove(save_mission)
		end
	end
	local framesrecorded = 0
	for i = 1, #slot_buttons do
		framesrecorded = #recording[i]
		if framesrecorded > 0 then
			table.insert(save_mission, slot_buttons[i])
		end
	end
	formatGuiTables()
end

local slots_checked = {}
local function stockSlotsChecked()
	for k in pairs(slots_checked) do
		slots_checked[k] = nil
	end
	for i = 1, #slot_buttons do
		if slot_buttons[i].checked then
			table.insert(slots_checked, tonumber(slot_buttons[i].text))
		end
	end
end

guipages.save_mission = save_mission
interactivegui.boxxlength = 6*(emu.screenwidth()/8) -- fix the precedent modification
----------------------------------
-- Would need a fix : since save_frame is created after save_name, the first createTextfield() doesn't reproduce it. Thus save_frame's textfield seems to disappear when you enter in name edition
-- We have the same problem with slot buttons which seem to disappear when you enter in a textfield
guipages.save_name = createTextfield(guipages.save_mission, "name", 60, 20, 17)
guipages.save_frame = createTextfield(guipages.save_mission, "frame", 145, 50, 3, numbers, "150")
----------------------------------
--	Displaying help in the menu
----------------------------------
local ERROR_MSG_FRAMELIMIT = 600
local error_msg_fcount = 0

local function resetErrorMsg()
	guipages.missions_hub.infos.text = "In-game press Alt+5 to create a new mission"
	guipages.save_mission.infos.text = ""
	error_msg_fcount = 0
end

local function drawErrorMsg()
	if error_msg_fcount >= ERROR_MSG_FRAMELIMIT then
		resetErrorMsg()
	elseif error_msg_fcount > 0 then
		error_msg_fcount = error_msg_fcount + 1
	end
end

local mission_text1=""
local mission_text2=""
local TXT_FRAMELIMIT = 600
local txt_fcount = 0

local function showTxt(frames, txt1, txt2)
	mission_text1 = txt1
	mission_text2 = txt2
	txt_fcount = TXT_FRAMELIMIT-frames
end

local function drawTxt()
        if txt_fcount >= TXT_FRAMELIMIT then
		mission_text1=""
		mission_text2=""
		txt_fcount=0
        elseif txt_fcount > 0 then
                txt_fcount = txt_fcount + 1
        end
	gui.text(92,76,mission_text1)
	gui.text(92,84,mission_text2)
end

if REPLAY then showTxt(240, "For replay takeover, press Alt+5 to record a mission", "") end
-----------------------------------
-----------------------------------
--		Main
-----------------------------------
-----------------------------------

-----------------------------
--	Save a mission
-----------------------------
local backup_page = 1
local backup_previouspage = 1
local backup_selection = 1
local backup_previousselection = 1

local function closePopUp()
	guipages.save_name[1]:clear()
	guipages.save_frame[1]:clear()
	if fexists("./new_savestate") then
		os.remove("./new_savestate")
	end
	for i = 1, #slot_buttons do
		slot_buttons[i].checked = false
	end
	toggleInteractiveGUI(false, {})
	if backup_page ~= nil then
		interactivegui.page = backup_page
	else
		interactivegui.page = 1
	end
	if backup_selection ~= nil then
		interactivegui.selection = backup_selection
	else
		interactivegui.selection = 1
	end
	if backup_previouspage ~= nil then
		interactivegui.previouspage = backup_previouspage
	else
		interactivegui.previouspage = 1
	end
	if backup_previousselection ~= nil then
		interactivegui.previousselection = backup_previousselection
	else
		interactivegui.previousselection = 1
	end
end

local function handlePopUp()
	if interactivegui.page == "save_mission" or interactivegui.page == "save_name" or interactivegui.page == "save_frame" then
		-- Guipage size
		interactivegui.boxx = emu.screenwidth()/4
		interactivegui.boxy = emu.screenheight()/3-10
		interactivegui.boxx2 = 3*(emu.screenwidth()/4)
		interactivegui.boxy2 = 4*(emu.screenheight()/6)+9
	else
		-- restaures default values
		interactivegui.boxx = emu.screenwidth()/8
		interactivegui.boxy = emu.screenheight()/10-10
		interactivegui.boxx2 = 7*(emu.screenwidth()/8)
		interactivegui.boxy2 = 9*(emu.screenheight()/10)-10
	end
	-- Back option
	if (interactivegui.page == "save_mission" and back()) or ((interactivegui.previouspage == "save_mission" or interactivegui.previouspage == "save_name" or interactivegui.previouspage == "save_frame") and not interactivegui.enabled) then
		-- if back has been pressed outside of a textfield or if coin has been pressed
		closePopUp()
	end
end

local mission_path = "games/"..dirname.."/missions_saved/"

local function makeMissionButton(_mission_name, _mission_frame_delay)
	if (emu.romname() == 'ssf2xjr1') then
		return "\n".._mission_name.." = {\n".."\t\ttext = \"".._mission_name.."\",\n".."\t\tolcolour = \"black\",\n".."\t\tfillpercent = 0,\n".."\t\tchecked = false,\n".."\t\tslots_nb = "..#slots_checked..",\n".."\t\tframe_delay = ".._mission_frame_delay..",\n".."\t\tautoblock = "..autoblock_selector..",\n".."\t\tmission_text = \"\",\n".."\t\tfunc = function() ".._mission_name..".checked = not ".._mission_name..".checked end,\n".."\t\tautofunc = function(this)\n\t\t\tif this.checked then\n\t\t\t\tthis.fillpercent = 1\n\t\t\telseif not this.checked then\n\t\t\t\tthis.fillpercent = 0\n\t\t\tend\n\t\tend,\n}\ntable.insert(missions_list[\""..readCharacterName(gamestate.P1).."\"], ".._mission_name..")".."\n--END"
	else
		return "\n".._mission_name.." = {\n".."\t\ttext = \"".._mission_name.."\",\n".."\t\tolcolour = \"black\",\n".."\t\tfillpercent = 0,\n".."\t\tchecked = false,\n".."\t\tslots_nb = "..#slots_checked..",\n".."\t\tframe_delay = ".._mission_frame_delay..",\n".."\t\tmission_text = \"\",\n".."\t\tfunc = function() ".._mission_name..".checked = not ".._mission_name..".checked end,\n".."\t\tautofunc = function(this)\n\t\t\tif this.checked then\n\t\t\t\tthis.fillpercent = 1\n\t\t\telseif not this.checked then\n\t\t\t\tthis.fillpercent = 0\n\t\t\tend\n\t\tend,\n}\ntable.insert(missions_list[\""..dirname.."\"], ".._mission_name..")".."\n--END"
	end
end

local r_frame = 0
local function loadMissionTakeover()
	local character = dirname
	if (emu.romname() == 'ssf2xjr1') then
		character = readCharacterName(gamestate.P1)
	end
	return {character = character, name = "REPLAY_"..r_frame, slots_nb = 1, frame_delay = 150, block = -1, mission_text = ''}
end

local function saveMission()
	-- reading the save popup inputs
	local character = dirname
	if (emu.romname() == 'ssf2xjr1') then
		character = readCharacterName(gamestate.P1)
	end
	local mission_name = guipages.save_mission.name.text
	if guipages.save_mission.frame.text == "" then
		guipages.save_mission.frame.text = 0
	end
	local mission_frame_delay = tonumber(guipages.save_mission.frame.text)
	local mission_savestate = nil
	-- checking if everything is correct
	stockSlotsChecked()
	if guipages.save_mission.name.text == "" then
		guipages.save_mission.infos.text = "Please enter a name"
		error_msg_fcount = ERROR_MSG_FRAMELIMIT-120
	elseif guipages.save_mission.name.text == "_" then
		guipages.save_mission.infos.text = "Please enter a valid name"
		error_msg_fcount = ERROR_MSG_FRAMELIMIT-120
	elseif #slots_checked == 0 then
		guipages.save_mission.infos.text = "Please select a slot"
		error_msg_fcount = ERROR_MSG_FRAMELIMIT-120
	else
		-- Saving one or more replay files for the new mission.
		for i = 1, #slots_checked do
			assert(table.save(recording[slots_checked[i]], mission_name.."_"..i..".lua")==nil, "Can't save replay file")
		end
		-- Both savestate and lua files are moved in the correct folder
		os.rename("./new_savestate","./"..mission_path..character.."/"..mission_name..".fs")
		for i = 1, #slots_checked do
			os.rename("./"..mission_name.."_"..i..".lua","./"..mission_path..character.."/"..mission_name.."_"..i..".lua")
		end
		-- A new button is written in the lua file
		createMissionsFile(character)
		local file = io.open("./"..mission_path..character.."/missions_list.lua", "a")
		file:write(makeMissionButton(mission_name, mission_frame_delay))
		file:close()
		-- Success : we display a message onscreen
		local debug_msg = ""
		if DEBUG then
			debug_msg = "(./"..mission_path..character.."/"..mission_name..".fs)"
		end
		showTxt(480, "    Mission succesfully saved", debug_msg)
		-- We reload the missions
		for i = 1, #missions_page[character]-1 do
			table.remove(missions_page[character])
		end
		for i = 1, #missions_list[character] do
			missions_list[character][i] = nil
		end
		dofile("games/"..dirname.."/missions_saved/"..character.."/missions_list.lua")
		insertMissionsButtons(character)
		formatGuiTables()
		closePopUp()
	end
end
guipages.save_mission[3].func = saveMission

-------------------------------
--	Play a mission
-------------------------------
local frame_delay = 0
local timer = 0
local random_slot = 1

local function playMission(mission) -- mission[1] = dirname / [2] = mission's name
	if frame_delay < 3 then frame_delay = 3 end -- to be sure that we can reroll a mission
	if not recording.playback then
		timer = timer + 1
	end
	if timer > frame_delay then
		savestate.load(mission_path..mission.character.."/"..mission.name..".fs") -- savestate
		if mission.mission_text then
			local txt1 = mission.mission_text
			showTxt(900, txt1, "")
		end
		random_slot = math.random(1, mission.slots_nb)
		if fexists(mission_path..mission.character.."/"..mission.name.."_"..random_slot..".lua") then -- replay
			recording[recording.recordingslot]=table.load(mission_path..mission.character.."/"..mission.name.."_"..random_slot..".lua")
		end
		togglePlayBack(nil, {})
		timer = 0
		frame_delay = mission.frame_delay
	end
end

local missions_checked = {} -- for loading
local mission_selector = 0

input.registerhotkey(5, function()
	if (not REPLAY) then
		--open the popup saving a mission
		if not interactivegui.enabled then
			local mission_savestate = savestate.create("new_savestate")
			savestate.save(mission_savestate)
			insertSlotButtons()
			if #save_mission > 3 then -- at least one slot button has been inserted
				-- backup
				backup_page = interactivegui.page
				backup_selection = interactivegui.selection
				backup_previouspage = interactivegui.previouspage
				backup_previousselection = interactivegui.previousselection
				-- Opening the popup
				interactivegui.page = "save_mission"
				interactivegui.previouspage = "save_mission"
				interactivegui.selection = 1
				toggleInteractiveGUI(true, {})
			else
				local txt1 = "In order to create a mission you have to record an action."
				local txt2 = "Double tap coin or go to Replay Editor"
				showTxt(360, txt1, txt2)
			end
		end
		return

	else
		-- auto-save a mission from a replay
		if (r_frame == 0) then
			local mission_savestate = savestate.create("new_savestate")
			savestate.save(mission_savestate)
			recording.replayP1 = true
			toggleRecording(nil, {})
			recording.replayP1 = false
			local txt1 = "RECORDING STARTED..."
			local txt2 = "Press Alt+5 to stop recording and save the mission."
			showTxt(480, txt1, txt2)
			r_frame = emu.framecount()
		else
			toggleRecording(nil, {})
			frame_end = emu.framecount()
			local recorded = frame_end - r_frame
			guipages.save_mission.frame.text = 150
			guipages.save_mission.name.text = "REPLAY_"..r_frame
			slot_buttons[1].text=1
			slot_buttons[1].checked = true
			saveMission()
			emu.takeover()
			REPLAY=false
			mission_selector = 1
			missions_checked[1] = loadMissionTakeover()
			playMission(missions_checked[1])
			local txt1 = "RECORDED "..recorded.." frames."
			local txt2 = "To take over load: Add-On > Missions > REPLAY_"..r_frame
			showTxt(480, txt1, txt2)
			--r_frame = 0
		end
	end
end)

local missions_checked_deletion = {} -- for deleting. Maybe I'm being overcautious for not merging the two tables though

local function deleteMission()
	if #missions_checked_deletion > 0 then
		for i = 1, #missions_checked_deletion do
			if fexists(mission_path..missions_checked_deletion[i].character.."/"..missions_checked_deletion[i].name..".fs") then
				os.remove(mission_path..missions_checked_deletion[i].character.."/"..missions_checked_deletion[i].name..".fs")
			end
			for j = 1, missions_checked_deletion[i].slots_nb do
				if fexists(mission_path..missions_checked_deletion[i].character.."/"..missions_checked_deletion[i].name.."_"..j..".lua") then
					os.remove(mission_path..missions_checked_deletion[i].character.."/"..missions_checked_deletion[i].name.."_"..j..".lua")
				end
			end
			local in_file = io.open("./"..mission_path..missions_checked_deletion[i].character.."/missions_list.lua", "r")
			local file_text = in_file:read("*a")
			in_file:close()

			local out_text = string.gsub(file_text, "(\n"..missions_checked_deletion[i].name.." = {.-%-%-END)", "")
			local out_file = io.open("./"..mission_path..missions_checked_deletion[i].character.."/missions_list.lua", "w+")
			out_file:write(out_text)
			out_file:close()
		end
		-- We reload the missions
		for i = 1, #characters do
			for j = 1, #missions_page[characters[i]]-1 do
				table.remove(missions_page[characters[i]])
			end
			for j = 1, #missions_list[characters[i]] do
				missions_list[characters[i]][j] = nil
			end
			dofile("games/"..dirname.."/missions_saved/"..characters[i].."/missions_list.lua")
			insertMissionsButtons(characters[i])
		end
		toggleInteractiveGUI(false, {})
		formatGuiTables()
		local s = ""
		if #missions_checked_deletion > 1 then
			s = "s"
		end
		local txt1 = "\t    Mission"..s.." succesfully deleted"
		showTxt(480, txt1, "")
	else
		guipages.missions_hub.infos.text = "\tNo missions were selected"
		error_msg_fcount = ERROR_MSG_FRAMELIMIT-120
	end
	for k in pairs(missions_checked_deletion) do
		missions_checked_deletion[k] = nil
	end
end

local function clearMissionsCheckedForDeletion()
	for k in pairs(missions_checked_deletion) do
		missions_checked_deletion[k] = nil
	end
end

local function stockMissionsCheckedForDeletion()
	clearMissionsCheckedForDeletion()
	for i = 1, #characters do
		if missions_list[characters[i]] ~= nil then
			for k in pairs(missions_list[characters[i]]) do
				if missions_list[characters[i]][k].checked then
					table.insert(missions_checked_deletion, {character = characters[i], name = missions_list[characters[i]][k].text, slots_nb = missions_list[characters[i]][k].slots_nb})
				end
			end
		end
	end
end

local Elements = {
	{text = "No", releasefunc = function() return function()  CIG(interactivegui.previouspage, interactivegui.previousselection) interactivegui.previouspage = interactivegui.page interactivegui.previousselection = interactivegui.selection clearMissionsCheckedForDeletion() resetErrorMsg() end end},
	{text = "Yes", releasefunc = function() return function() CIG(interactivegui.previouspage, interactivegui.previousselection) interactivegui.previouspage = interactivegui.page interactivegui.previousselection = interactivegui.selection deleteMission() resetErrorMsg() end end},
}
guipages.delete = createPopUpMenu(guipages.missions_hub, nil, nil, nil, Elements, 125, 125)
guipages.delete[2].x = guipages.delete[1].x + 15
guipages.delete[2].y = guipages.delete[1].y

guipages.missions_hub[2].func = function()
	stockMissionsCheckedForDeletion()
	if #missions_checked_deletion < 1 then
		guipages.missions_hub.infos.text = "\tNo missions were selected"
		error_msg_fcount = ERROR_MSG_FRAMELIMIT-120
	else
		local s = ""
		if #missions_checked_deletion > 1 then
			s = "s"
		end
		guipages.missions_hub.infos.text = #missions_checked_deletion.." mission"..s.." will be deleted, are you sure ?"
		CIG("delete",1)
	end
end

-------------------------------
--	Mission selector
-------------------------------

local listenMissionsSettingsModfications = false
local mission_reroll = true

local function stockMissionsChecked()
	if interactivegui.enabled and not listenMissionsSettingsModfications then
		showTxt(1,"", "")
		for k in pairs(missions_checked) do
			missions_checked[k] = nil
		end
		mission_selector = 0
		listenMissionsSettingsModfications = true
	end
	if not interactivegui.enabled and listenMissionsSettingsModfications then
		for i = 1, #characters do
			if missions_list[characters[i]] ~= nil then
				for k in pairs(missions_list[characters[i]]) do
					if missions_list[characters[i]][k].checked then
						table.insert(missions_checked, {character = characters[i], name = missions_list[characters[i]][k].text, slots_nb = missions_list[characters[i]][k].slots_nb, frame_delay = missions_list[characters[i]][k].frame_delay, block = missions_list[characters[i]][k].autoblock, mission_text = missions_list[characters[i]][k].mission_text})
					end
				end
			end
		end
		if #missions_checked == 0 then
			mission_selector = 0
		elseif #missions_checked == 1 then
			mission_selector = 1
		elseif #missions_checked > 1 then
			mission_selector = 2
		end
		listenMissionsSettingsModfications = false
		mission_reroll = true
		timer = 1000
	end
end

local random_mission = 1
local was_playback = false

local function playMissionLogic()
	if mission_selector > 0 and guiinputs.P1.coin then
		return
	end
	stockMissionsChecked()
	if mission_selector == 1 then
		playMission(missions_checked[1])
	elseif mission_selector == 2 then
		if mission_reroll then
			random_mission = math.random(1,#missions_checked)
		end
		playMission(missions_checked[random_mission])
		mission_reroll = false
		if not mission_reroll and (not recording.playback and was_playback) then
			mission_reroll = true
		end
		was_playback = recording.playback
	end
end

local function missions()
	handlePopUp()
	drawErrorMsg()
	drawTxt()
	playMissionLogic()
end

table.insert(registers.registerbefore, missions)
