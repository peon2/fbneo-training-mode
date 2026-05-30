assert(rb,"Run fbneo-training-mode.lua")

-- MISC UTIL FUNCTIONS

function orTable(t) -- check if at least one value in the table is true/well defined
	for _,v in pairs(t) do
		if v then
			return true
		end
	end

	return false
end

function isEmpty(t)
	return next(t or {}) == nil
end

function notEmpty(t) -- check if a table is not empty
	return next(t or {}) ~= nil
end

function otherPlayer(player) -- returns "P2" when "P1" is given and vice versa
	return player=="P1" and "P2" or "P1"
end

function scaleinputnum(n) -- gets faster the longer it runs
	if (n < 60) then
		if n%10==1 then return 1 end -- maybe tie this to coin input leniency?
		return 0
	elseif (n < 120) then
		return 1
	elseif (n < 150) then
		return 2
	elseif (n < 180) then
		return 3
	elseif (n < 210) then
		return 5
	elseif (n < 240) then
		return 10
	elseif (n < 300) then
		return 10
	end
	return 100
end
