assert(rb,"Run fbneo-training-mode.lua")
-- most of these values came from https://github.com/jedpossum/EmuLuaScripts/blob/master/cybots.lua

p1maxhealth = 152
p2maxhealth = 152

p1maxmeter = 63
p2maxmeter = 63

function gamemsg()
	print "Known issues with cybots:"
	print "Inconsistent combo counter"
end

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
	["Left"] = 1,
	["Right"] = 2,
	["Up"] = 3,
	["Down"] = 4,
	["Low Attack"] = 5,
	["High Attack"] = 6,
	["Boost"] = 7,
	["Weapon"] = 8,
	["Coin"] = 9,
	["Start"] = 10,
}

gamedefaultconfig = {
	hud = {
		combotextx=176,
		combotexty=49,
		comboenabled=true,
		p1healthx=33,
		p1healthy=27,
		p1healthenabled=true,
		p2healthx=340,
		p2healthy=27,
		p2healthenabled=true,
		p1meterx=66,
		p1metery=215,
		p1meterenabled=true,
		p2meterx=311,
		p2metery=215,
		p2meterenabled=true,
	},
}

local p2InHitstun = 0xffe9f7 -- not working right, frame behind, triggers when arm is off. And triggers when p1 is hit.
local p2HealthAddr = 0xFF85E5
local timer = 0xFFEBA0

local p2Health = rb(p2HealthAddr)
local previousP2Health = p2Health

function playerOneFacingLeft()
	return rb(0xFF85A9)==1
end

function playerTwoFacingLeft()
	return rb(0xFF85A9)==0
end

function _playerOneInHitstun()

end

function playerTwoInHitstun()
	return rb(p2InHitstun) ~= 0
end

function readPlayerOneHealth()
	return rb(0xFF81E5)
end

function writePlayerOneHealth(health)
	return wb(0xFF81E5,health)
end

function readPlayerTwoHealth()
	previousP2Health = p2Health
	p2Health = rb(p2HealthAddr)
	return previousP2Health
end

function writePlayerTwoHealth(health)
	wb(p2HealthAddr, health)
end

function readPlayerOneMeter()
	return rb(0xFF8534)
end

function writePlayerOneMeter(meter)
	wb(0xFF8534, meter)
end

function readPlayerTwoMeter()
	return rb(0xFF8934)
end

function writePlayerTwoMeter(meter)
	wb(0xFF8934, meter)
end

function infiniteTime()
	wb(timer,0x9999)
end

function Run()
	infiniteTime()
	wb(0xff470c, 48) -- set arms to max
	wb(0xff870c, 48) -- set arms to max
end