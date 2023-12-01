assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0xFF
p2maxhealth = 0xFF
p1barhealth = {0x1009B7, 0x100AB7, 0x100BB7, 0x100CB7, 0x100DB7, 0x100EB7, 0x100FB7, 0x1010B7, 0x1011B7, 0x1012B7}
p2barhealth = {0x1009B9, 0x100AB9, 0x100BB9, 0x100CB9, 0x100DB9, 0x100EB9, 0x100FB9, 0x1010B9, 0x1011B9, 0x1012B9}

local p1health = 0x109089
local p1stock1 = 0x1090A9
local p1stock2 = 0x1090AA
local p1elem1 = 0x1090A0
local p1elem2 = 0x1090A1

local p2health = 0x109361
local p2stock1 = 0x109381
local p2stock2 = 0x109382
local p2elem1 = 0x109378
local p2elem2 = 0x109379

local stall = 0
local stallmax = 7

function gamemsg()
	print "Known issues with ragnagrd:"
	print "GUI not working"
	print "Life Bar does not accurately reflect life when not set to max"
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
	combogui = {
		combotextx=146,
		combotexty=37,
		comboenabled=true,
		p1healthx=25,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=50,
		p2healthy=21,
		p2healthenabled=true,
	},
}

function roundStart()
	return rb(0x109373) == 0 and rb(0x109393) == 1
end

function playerOneFacingLeft()
	return rb(0x10915E)==1
end
	
function playerTwoFacingLeft()
	return rb(0x109436)==1
end


function playerOneInHitstun()
	return rb(0x109175)~=0
end

function playerTwoInHitstun()
	return rb(0x10944D)~=0 or rb(0x10943A)==0x20
end

function readPlayerOneHealth()
	return rb(0x109089)
end


function writePlayerOneHealth(health)
	if stall >= stallmax then
		wb(p1health, p1maxhealth)
		wb(0x10908A, 0x00)
		for i, v in ipairs(p1barhealth) do
			if v>0 and roundStart() then wb(v, 0x60) end
		end		
	end
end

function readPlayerTwoHealth()
	return rb(0x109361)
end

function writePlayerTwoHealth()
	if stall >= stallmax then
		wb(p2health, p2maxhealth)
		wb(0x109363, 0x00)
		for j, w in ipairs(p2barhealth) do
			if w>0 then wb(w, 0x60) end
		end
	end
end

function readPlayerOneMeter()
	return rb(p1stock1)
end

function writePlayerOneMeter(meter)
	if not playerTwoInHitstun() then
		wb(p1stock1, rb(p1elem1))
		wb(p1stock2, rb(p1elem2))
	end
end

function readPlayerTwoMeter()
	return rb(p2stock1)
end

function writePlayerTwoMeter(meter)
	if not playerOneInHitstun() then
		wb(p2stock1, rb(p2elem1))
		wb(p2stock2, rb(p2elem2))
	end
end

function infiniteTime()
	ww(0x10022E, 0x0601)
end


function Run() -- runs every frame
	
	if roundStart() then
		if stall < stallmax then stall = stall + 1 end
	else stall = 0
	end
	if stall >= stallmax then
		infiniteTime() 
		writePlayerOneMeter()
		writePlayerTwoMeter()
	end

end
