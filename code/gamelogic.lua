assert(rb,"Run fbneo-training-mode.lua")

function setGameConstants() -- use this if constants change
	if p1maxhealth then
		gamevars.P1.constants.maxhealth = p1maxhealth
		gamevars.P1.maxhealth = p1maxhealth
		setConfigDefault("p1maxhealth", p1maxhealth)
	end
	if p2maxhealth then
		gamevars.P2.constants.maxhealth = p2maxhealth
		gamevars.P2.maxhealth = p2maxhealth
		setConfigDefault("p2maxhealth", p2maxhealth)
	end
	if p1maxmeter then
		gamevars.P1.constants.maxmeter = p1maxmeter
		gamevars.P1.maxmeter = p1maxmeter
		setConfigDefault("p1maxmeter", p1maxmeter)
	end
	if p2maxmeter then
		gamevars.P2.constants.maxmeter = p2maxmeter
		gamevars.P2.maxmeter = p2maxmeter
		setConfigDefault("p2maxmeter", p2maxmeter)
	end
	if translationtable then
		gamevars.constants.translationtable = translationtable -- game to script inputs
		gamevars.constants.inversetranslationtable = {} -- script to game inputs
		for i,v in pairs(translationtable) do
			if type(i) == "number" then
				gamevars.constants.inversetranslationtable[v] = i
			elseif type(i) == "string" then
				gamevars.constants.inversetranslationtable[v] = i
			else
				assert("Translation table entry ".. i .. " is malformed")
			end
		end
	end
end

gamefunctions = {}
function checkGameFunctions() -- set gamefunctions table
	-- Training mode functions
	if Run then gamefunctions.run = true end
	if playerOneInHitstun then gamefunctions.playeroneinhitstun = true end
	if playerTwoInHitstun then gamefunctions.playertwoinhitstun = true end
	if readPlayerOneHealth then gamefunctions.readplayeronehealth = true end
	if writePlayerOneHealth and not REPLAY then gamefunctions.writeplayeronehealth = true end
	if readPlayerTwoHealth then gamefunctions.readplayertwohealth = true end
	if writePlayerTwoHealth and not REPLAY then gamefunctions.writeplayertwohealth = true end
	if readPlayerOneMeter then gamefunctions.readplayeronemeter = true end
	if writePlayerOneMeter and not REPLAY then gamefunctions.writeplayeronemeter = true end
	if readPlayerTwoMeter then gamefunctions.readplayertwometer = true end
	if writePlayerTwoMeter and not REPLAY then gamefunctions.writeplayertwometer = true end
	if playerOneFacingLeft then gamefunctions.playeronefacingleft = true end
	if playerTwoFacingLeft then gamefunctions.playertwofacingleft = true end
	--
	-- Hitbox functions
	if hitboxesReg then gamefunctions.hitboxesreg = true end
	if hitboxesRegAfter then gamefunctions.hitboxesregafter = true end
	--
	-- Inputs functions try to get these to load a global input table to avoid multiple joypad.get()'s?
	if inputDisplayReg then gamefunctions.inputdisplayreg = true end
	if scrollingInputReg then gamefunctions.scrollinginputreg = true end
	if scrollingInputRegAfter then gamefunctions.scrollinginputregafter = true end
	if scrollingInputClear then gamefunctions.scrollinginputclear = true end
	if scrollingInputSetInput then gamefunctions.scrollinginputsetinput = true end
	if scrollingInputSetSampleInput then gamefunctions.scrollinginputsetsampleinput = true end
	--
	-- Saving/Loading
	if saveTableToFile then gamefunctions.tablesave = true end
	if loadTableFromFile then gamefunctions.tableload = true end
	--
end

function updategamevars()
	if gamefunctions.playertwoinhitstun then
		gamevars.P2.inhitstun = playerTwoInHitstun()
	end
	if gamefunctions.playeroneinhitstun then
		gamevars.P1.inhitstun = playerOneInHitstun()
	end

	if gamefunctions.readplayeronehealth then
		gamevars.P1.previoushealth = gamevars.P1.health
		gamevars.P1.health = readPlayerOneHealth()
	end

	if gamefunctions.readplayertwohealth then
		gamevars.P2.previoushealth = gamevars.P2.health
		gamevars.P2.health = readPlayerTwoHealth()
	end

	if gamefunctions.playertwofacingleft then
		gamevars.P2.facingleft = playerTwoFacingLeft()
	end
	if gamefunctions.playeronefacingleft then
		gamevars.P1.facingleft = playerOneFacingLeft()
	end

	if gamefunctions.readplayeronemeter then
		gamevars.P1.meter = readPlayerOneMeter()
	end
	if gamefunctions.readplayertwometer then
		gamevars.P2.meter = readPlayerTwoMeter()
	end
end

----------------------------------------------
-- FUNCTIONS RAN EVERY FRAME
----------------------------------------------

function writePlayerHealth(player, health)
	if (player == "P1" and gamefunctions.writeplayeronehealth) then
		writePlayerOneHealth(health)
	elseif(player == "P2" and gamefunctions.writeplayertwohealth) then
		writePlayerTwoHealth(health)
	end
end

function writePlayerMeter(player, health)
	if (player == "P1" and gamefunctions.writeplayeronemeter) then
		writePlayerOneMeter(health)
	elseif(player == "P2" and gamefunctions.writeplayertwometer) then
		writePlayerTwoMeter(health)
	end
end

function comboHandler(player)
	local cvars = combovars[player]
	local gvars = gamevars[player]

	cvars.healthdiff = gvars.previoushealth - gvars.health
	cvars.previouscombo = cvars.combo -- used by other functions to track 'After Combo' logic

	--print(player.." "..fc..": "..tostring(gvars.inhitstun)..", "..cvars.healthdiff) -- debugging command to check if the hitstun and damage are in sync
	if gvars.inhitstun then
		if cvars.healthdiff > 0 then -- player has taken damage
			cvars.combo = cvars.combo+1
		end
		if cvars.combo == 0 then -- default view to be 1 rather than 0, if the player is in hitstun, they've probably been attacked
			cvars.displaycombo = 1
		else
			cvars.displaycombo = cvars.combo
		end
	else
		cvars.combo = 0 -- if player is not in hitstun the combo drops
	end

	if cvars.healthdiff > 0 then -- player has taken damage
		cvars.previousdamage = cvars.healthdiff -- remember how much damage has been taken to display to the user
		if cvars.combo == 1 then -- restart the count of total damage taken if it's the first hit
			cvars.comboDamage=0
		end
		cvars.comboDamage = cvars.comboDamage + cvars.healthdiff
	end
end

function healthHandler(player)
	if not combovars[player].refillhealthenabled or combovars[player].instantrefillhealth then return end
	local cvars = combovars[player]
	local gvars = gamevars[player]

	if gvars.inhitstun then
		cvars.refillhealth = 0
	elseif cvars.combo ~= cvars.previouscombo and cvars.refillhealth == 0 then
		cvars.refillhealth = math.ceil((gvars.maxhealth - gvars.health) / cvars.refillhealthspeed) -- refill speed
	end

	if cvars.refillhealth ~= 0 then
		if (cvars.refillhealth + gvars.health >= gvars.maxhealth) or cvars.instantrefillhealth then
			writePlayerHealth(player, gvars.maxhealth)
			cvars.refillhealth = 0
		else
			writePlayerHealth(player, gvars.health + cvars.refillhealth)
		end
	end
end

function meterHandler(player)
	if not combovars[player].refillmeterenabled or combovars[player].instantrefillmeter then return end
	local otherplayer = otherPlayer(player)
	local cvars = combovars[player]
	local gvars = gamevars[player]

	if gamevars[otherplayer].inhitstun and combovars[otherplayer].previouscombo == 0 then
		cvars.refillmeter = 0
	elseif combovars[otherplayer].combo < combovars[otherplayer].previouscombo then -- if the combo has dropped
		if cvars.refillmeter == 0 then
			cvars.refillmeter = math.ceil((gvars.maxmeter - gvars.meter) / cvars.refillmeterspeed) -- refill speed
		end
	end

	if cvars.refillmeter ~= 0 then
		if (cvars.refillmeter + gvars.meter >= gvars.maxmeter) then
			writePlayerMeter(player, gvars.maxmeter)
			cvars.refillmeter = 0
		else
			writePlayerMeter(player, gvars.meter + cvars.refillmeter)
		end
	end
end

function instantHealth(player)
	if not combovars[player].refillhealthenabled then return end
	if not combovars[player].instantrefillhealth then return end
	writePlayerHealth(player, gamevars[player].maxhealth)
end

function instantMeter(player)
	if not combovars[player].refillmeterenabled then return end
	if not combovars[player].instantrefillmeter then return end
	writePlayerMeter(player, gamevars[player].maxmeter)
end