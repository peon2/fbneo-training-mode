--This file is intended to be run by macro.lua
--See macro-readme.html for help and instructions.

--You may adjust these parameters.

--------------------------------------------------------------------------------
-- File handling settings

-- name of the macro to be played
playbackfile = "reversal.mis"

-- where the macro scripts are saved to and loaded from
path = "./macro/__macros/"

--------------------------------------------------------------------------------
-- Hotkey settings (These only apply if the emulator doesn't have Lua hotkeys.)

-- press to start playing the macro, or to cancel a playing macro
playkey = "semicolon"

-- press to start and stop recording a macro
recordkey = "numpad/"

-- press to turn on or off whether it should pause after a macro completes
togglepausekey = "quote"

-- press to turn loop mode on or off, or to switch between increasing, decreasing or no wait incrementation
toggleloopkey = "numpad+"

--------------------------------------------------------------------------------
-- Recording file output settings

-- minimum wait frames to be collapsed into Ws when recording
longwait = 4

-- minimum continuous keypress frames to be collapsed into holds when recording
longpress = 10

-- minimum characters in a line to be broken up when recording
longline = 60

--------------------------------------------------------------------------------
-- look out for and ignore frameMAME audio commands when parsing
-- (This only applies to FBA-rr and MAME-rr.)
framemame = true
