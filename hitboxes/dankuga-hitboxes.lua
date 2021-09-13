function Hitboxes()
	memory.writebyte(0x412B4A,0x3B)
	memory.writebyte(0x412B4B,0xE4)
end

function hitboxesReg()
	if hitboxes.enabled then
		Hitboxes()
	end
end

function hitboxesRegAfter()
end
