assert(rb,"Run fbneo-training-mode.lua")
-- edit of a flabcaptain script to work with the fbneo-training-mode

local music = getConfigTable("addon_music", "config") -- addons are loaded after the config is read in, grab the table that already exists.

local machines = {
	cps1 = {
		{
			'sf2', 'sf2ce', 'sf2hf'
		}
	},
	cps2 = {
		{
			'19xx', 'armwar', 'avsp', 'cybots', 'dstlk', 'ddtod', 'ecofghtr', 'hsf2', 'msh', 'mmancp2u', 'nwarr', 'ringdest', 'sfa',
			'sfa2', 'sfz2al', 'ssf2', 'ssf2t', 'xmcota', address = 0xF019
		},
		{
			'mmatrix', 'spf2t', address = 0xF020
		},
		{
			'1944', 'batcir', 'choko', 'csclub', 'ddsom', 'dimahoo', 'gigawing', 'jyangoku', 'mpang', 'mshvsf', 'mvsc', 'megaman2',
			'progear', 'pzloop2', 'qndream', 'sfa3', 'sgemf', 'vhunt2', 'vsav', 'vsav2', 'xmvsf', address = 0xF027
		}
	},
	cps3 = {
		{
			'redearth', address = 0x207BD0E
		},
		{
			'sfiii', address = 0x206CE16
		},
		{
			'sfiii2', address = 0x20731D6
		},
		{
			'sfiii3', address = 0x2078D06
		},
		{
			'jojo', address = 0x206B90E
		},
		{
			'jojoba', address = 0x205CC1A
		}
	},
	neogeo = {
		{
			'fatfursp', 'fatfury2', 'fatfury3', 'kabukikl', 'kof94', 'samsho', 'samsho2', address = 0xFE2D
		},
		{
			'kof95', 'rbff1', 'samsho3', 'wakuwak7', address = 0xFE1A
		},
		{
			'kizuna', 'kof96', 'kof97', 'lastblad', 'rbff2', 'rbffspec', 'samsho4', address = 0xFDE0
		},
		{
			'garou', 'kof98', 'kof99', 'kof2000', 'kof2001', 'kof2002', 'kof2003', 'lastbld2', 'samsh5sp', 'samsho5', 'svc', address = 0xFD89
		}
	}
}

local function getGameInfo()
	for machine, v in pairs(machines) do
		for group, k in ipairs(v) do
			for _, gamename in ipairs(k) do
				if (gamename == PARENT_NAME or gamename == ROM_NAME) then
					return machine, group
				end
			end
		end
	end
end

local machine, group = getGameInfo()

local function cps1volumecontrol()
	local music_address = 0xD04B
	local maxvolume = 0x3F
	local defaultvolume = 50
	createConfigItem("addon_musicvolume", defaultvolume, music, "volume")
	initConfigItem("addon_musicvolume") -- we need to manually init, this config item is created after a game lua is loaded
	
	local music_button = {
		text = "Music Volume",
		rawx = interactivegui.boxxhalflength,
		fillpercent = 0,
		olcolour = colour.olcolour,
		info = "Controls how loud the music is",
		reset = function()
			resetConfig("addon_musicvolume")
		end,
		func = function()
			changePageAndSelection("addon_music")
		end,
		autofunc = function(this)
			local value = math.abs(music.volume - 100)
			this.text = string.format("Music Volume: %3d", value)
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.fillpercent = value/100
		end,
	}
	
	table.insert(guipages[guipagenames.Main], music_button)
	formatGUITables()
	
	-- CPS1 has 0 as loud and 100 as quiet, spoof the UI to be the other way around
	guipages.addon_music = createScrollingBar(guipages[guipagenames.Main], "Music Volume: 00", music_button.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music_button.y, 0, 100, nil,
		function(n, k)
			if n then
				local volume = music.volume
				changeConfig("addon_musicvolume", volume-n)
				return volume-n
			end
			if k then
				local value = math.abs(k - 100)
				changeConfig("addon_musicvolume", value)
				return k
			end
			return math.abs(music.volume - 100)
		end,
		function(this)
			this.text = string.format("Music Volume: %3d", math.abs(music.volume - 100))
		end
	)
	
	table.insert(registers.interactiveguiregister, function()
		local volume = math.floor( (music.volume*maxvolume)/100 )
		memory.writebyte_audio(music_address, volume)
	end)
end

local function cps2volumecontrol(group)
	local music_address = machines.cps2[group].address
	local maxvolume = 0xFF
	local defaultvolume = 50
	createConfigItem("addon_musicvolume", defaultvolume, music, "volume")
	initConfigItem("addon_musicvolume") -- we need to manually init, this config item is created after a game lua is loaded
	
	local music_button = {
		text = "Music Volume",
		rawx = interactivegui.boxxhalflength,
		fillpercent = 0,
		olcolour = colour.olcolour,
		info = "Controls how loud the music is",
		reset = function()
			resetConfig("addon_musicvolume")
		end,
		func = function()
			changePageAndSelection("addon_music")
		end,
		autofunc = function(this)
			local value = music.volume
			this.text = string.format("Music Volume: %3d", value)
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.fillpercent = value/100
		end,
	}
	
	table.insert(guipages[guipagenames.Main], music_button)
	formatGUITables()
	
	guipages.addon_music = createScrollingBar(guipages[guipagenames.Main], "Music Volume: 00", music_button.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music_button.y, 0, 100, nil,
		function(n, k)
			if n then
				local volume = music.volume
				changeConfig("addon_musicvolume", volume+n)
				return volume
			end
			if k then
				changeConfig("addon_musicvolume", k)
				return k
			end
			return music.volume
		end,
		function(this)
			this.text = string.format("Music Volume: %3d", music.volume)
		end
	)
	
	table.insert(registers.interactiveguiregister, function()
		local volume = math.floor( (music.volume*maxvolume)/100 )
		memory.writebyte_audio(music_address, volume)
	end)
end

local function cps3volumecontrol(group)
	local music_address = machines.cps3[group].address
	local maxvolume = 0x80
	local defaultvolume = 50
	createConfigItem("addon_musicvolume", defaultvolume, music, "volume")
	initConfigItem("addon_musicvolume") -- we need to manually init, this config item is created after a game lua is loaded
	
	local music_button = {
		text = "Music Volume",
		rawx = interactivegui.boxxhalflength,
		fillpercent = 0,
		olcolour = colour.olcolour,
		info = "Controls how loud the music is",
		reset = function()
			resetConfig("addon_musicvolume")
		end,
		func = function()
			changePageAndSelection("addon_music")
		end,
		autofunc = function(this)
			local value = music.volume
			this.text = string.format("Music Volume: %3d", value)
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
			this.fillpercent = value/100
		end,
	}
	
	table.insert(guipages[guipagenames.Main], music_button)
	formatGUITables()
	
	guipages.addon_music = createScrollingBar(guipages[guipagenames.Main], "Music Volume: 00", music_button.rawx - #"Music Volume: 000"*LETTER_HALFWIDTH, music_button.y, 0, 100, nil,
		function(n, k)
			if n then
				local volume = music.volume
				changeConfig("addon_musicvolume", volume+n)
				return volume
			end
			if k then
				changeConfig("addon_musicvolume", k)
				return k
			end
			return music.volume
		end,
		function(this)
			this.text = string.format("Music Volume: %3d", music.volume)
		end
	)
	
	table.insert(registers.interactiveguiregister, function()
		local volume = math.floor( (music.volume*maxvolume)/100 )
		memory.writebyte(music_address, volume)
	end)
end

local function neogeomute(group)
	local music_address = machines.neogeo[group].address
	createConfigItem("addon_musicenabled", true, music, "enabled")
	initConfigItem("addon_musicenabled") -- we need to manually init, this config item is created after a game lua is loaded
	createConfigItem("addon_musictrack", 0, music, "track")
	initConfigItem("addon_musictrack")
	
	local music_button = {
		text = "Music On",
		rawx = interactivegui.boxxhalflength,
		fillpercent = 0,
		olcolour = "black",
		bgcolour = colour.boolfalse,
		info = "Enable or Disable the music. Note: this tells the sound CPU to hold the current note. Some notes will stop playing, others won't. You may have to turn this on and off again a few times to successfully mute the music.",
		func = function()
			changeConfig("addon_musicenabled", not music.enabled)
		end,
		autofunc = function(this)
			if music.enabled then
				this.text = "Music On"
				this.bgcolour = colour.booltrue
			else
				this.text = "Music Off"
				this.bgcolour = colour.boolfalse
			end
			this.x = this.rawx-#this.text*LETTER_HALFWIDTH
		end,
	}
	
	table.insert(guipages[guipagenames.Main], music_button)
	formatGUITables()
	
	table.insert(registers.interactiveguiregister, function()
		local track = memory.readbyte_audio(music_address)
		if track~=0 then
			changeConfig("addon_musictrack", track) -- a new track has loaded
		end
		if not music.enabled then
			memory.writebyte_audio(music_address, 0)
		else
			if track == 0 then -- we were probably the ones to disable the music, re-enable
				memory.writebyte_audio(music_address, music.track)
			end
		end
	end)
end

local setupup = {
	cps1 = cps1volumecontrol,
	cps2 = cps2volumecontrol,
	cps3 = cps3volumecontrol,
	neogeo = neogeomute
}

if machine then
	setupup[machine](group)
	formatGUITables()
end