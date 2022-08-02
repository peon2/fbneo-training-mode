missions_list["ryu"] = {}
---------------------------------------------------------
WHIFF_PUNISH_CRHK = {
		text = "WHIFF_PUNISH_CRHK",
		olcolour = "black",
		fillpercent = 0,
		checked = false,
		slots_nb = 3,
		frame_delay = 0,
		autoblock = -1,
		dizzy = -1,
		func = function() WHIFF_PUNISH_CRHK.checked = not WHIFF_PUNISH_CRHK.checked end,
		autofunc = function(this)
			if this.checked then
				this.fillpercent = 1
			elseif not this.checked then
				this.fillpercent = 0
			end
		end,
}
table.insert(missions_list["ryu"], WHIFF_PUNISH_CRHK)
---