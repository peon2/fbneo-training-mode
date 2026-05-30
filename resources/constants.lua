-- Global Constants

ROM_NAME = emu.romname()
PARENT_NAME = emu.parentname()

BASIC_ICONS_RESOURCEPATH = "resources/icons/"
SCROLLING_INPUT_RESOURCEPATH = "resources/scrolling-input/"

REPLAY_SLOTS_COUNT = 5
MINIMUM_GUI_BUTTONS = 3

LETTER_WIDTH = 4 -- width of a gui.text letter in pixels
LETTER_HALFWIDTH = 2

LETTER_HEIGHT = 8 -- height of a gui.text letter in pixels

-- memory macros
wb = memory.writebyte
ww = memory.writeword
wdw = memory.writedword
rb = memory.readbyte
rbs = memory.readbytesigned
rw = memory.readword
rws = memory.readwordsigned
rdw = memory.readdword
rdws = memory.readdwordsigned

if not memory.writebyte_audio then -- writeword_audio is defined on fightcade, stub otherwise
	memory.writebyte_audio = function() end
	write "memory.writebyte_audio not defined"
end

if not memory.readbyte_audio then
	memory.readbyte_audio = function() end
	write "memory.readbyte_audio not defined"
end

if not memory.writeword_audio then -- writeword_audio is defined on fightcade, stub otherwise
	memory.writeword_audio = function() end
	write "memory.writeword_audio not defined"
end

if not memory.readword_audio then
	memory.readword_audio = function() end
	write "memory.readword_audio not defined"
end
