-----------------------------------------------------------------------------
-- Made by McMic and Asunaro 
-----------------------------------------------------------------------------
character_specific = {}
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
	
for i = 1, #characters do
  character_specific[characters[i]] = { specials = {}, throw = {}, infos = {}}
end
------------------------------------------------------------------------------
character_specific.blanka.specials = {
  {
    name = "Normal roll",
    memory_map = {
      {0xB9, 0x06}
    },
	id = 0x00,
	charge_address = 0x81,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Vertical Roll",
    memory_map = {
      {0xB0, 0x06}
    },
	id = 0x04,
	charge_address = 0xB4,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Rainbow Roll",
    memory_map = {
      {0xB9, 0x06}
    },
	id = 0x06,
	charge_address = 0xBA,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Electric Thunder",
    memory_map = {
      -- We load all variations
      {0x9A, 0x05},
      {0x9C, 0x05},
      {0x9E, 0x05}
    },
	id = 0x02,
	strength_set = 1,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{}},
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Forward Dash",
    memory_map = {
    },
	id = 0x0A,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"forward"} },
    input_variations = {{"LK", "MK", "HK"}},
  },
  {
    name = "Backward Dash",
    memory_map = {
    },
	id = 0x0C,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"back"} },
    input_variations = {{"LK", "MK", "HK"}},
  },
  {
    name = "Ground Shave Roll",
    memory_map = {
      {0xC1, 0x0A}
    },
	id = 0x08,
	charge_address = 0xC2,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
character_specific.blanka.throw = {"HP"}
character_specific.blanka.hitboxes = {
throw = {{"HP", 64}},
throwable = 30, 
}
character_specific.blanka.infos = {
charge_character = true,
has_projectile	 = false
}
----------------------------------------------------------------------------
character_specific.boxer.specials = {
	{
    name = "Straight",
    memory_map = {
      {0x80, 0x08},
      {0x88, 0x08},
      {0xDD, 0x08},
      {0xD6, 0x08}
    },
	id = 0x00,
	charge_address = 0x81,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Upper Dash",
    memory_map = {
      {0x80, 0x08},
      {0x88, 0x08},
      {0xDD, 0x08},
      {0xD6, 0x08}
    },
	id = 0x02,
	charge_address = 0x89,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Buffalo Headbutt",
    memory_map = {
      {0xC0, 0x06}
    },
	id = 0x06,
	charge_address = 0xC1,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "v_charge"}, {"up"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Ground Straight",
    memory_map = {
      {0x80, 0x06},
      {0x88, 0x06},
      {0xDD, 0x06},
      {0xD6, 0x06}
    },
	id = 0x0A,
	charge_address = 0xD7,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"back", "h_charge"}, {"forward", "down"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Ground Upper",
    memory_map = {
      {0x80, 0x06},
      {0x88, 0x06},
      {0xDD, 0x06},
      {0xD6, 0x06}
    },
	id = 0x0C,
	charge_address = 0xDE,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"back", "h_charge"}, {"forward", "down"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
   name = "TAP", -- Modified to fit makeReversalSettingsButtons()
   memory_map = {
    {0xB6, 0001} -- More values need to be added
    },
	id = 0x04,
	strength_set = -1,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{"LP", "MP", "HP"}},
    input_variations = {{"1"},{"2"},{"3"},{"4"},{"5"},{"6"},{"7"},{"Final"}},
   },
   {
    name = "TAP Punch",
    memory_map = {
      {0xB6, 0001} -- More values need to be added
      },
	id = 0x04,
	strength_set = -1,
	reversal = false,
	new_only = false,
	charge_move = false,
    input = {{}},
    input_variations = {{"LP", "MP", "HP"}},
   },
   {
    name = "TAP Kick",
    memory_map = {
      {0xB8, 0001} -- More values need to be added
      },
	id = 0x04,
	strength_set = -1,
	charge_move = false,
	reversal = false,
	new_only = false,
    input = {{}},
    input_variations = {{"LK", "MK", "HK"}},
   },
  --~ 0001 - One
  --~ 0121 - Two
  --~ 0241 - Three
  --~ 0481 - Four
  --~ 0961 - Five
  --~ 1441 - Six
  --~ 1921 - Seven
  --~ 2401 - Final
  -- MCMic : TAP is gonna be hard because it should be negative edge I guess
  {
    name = "Crazy Buffalo",
    memory_map = {
      {0xD4, 0x0A}
    },
	id = 0x08,
	charge_address = 0xD5,
	strength_set = 0,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}, {"LK"}, {"MK"}, {"HK"}},
  }
}
character_specific.boxer.throw = {"MP","HP"}
character_specific.boxer.hitboxes = {
throw = {}, -- may vary, see below getBoxerThrowDistance()
throwable = 27,
}
character_specific.boxer.infos = {
charge_character = true,
has_projectile	 = false
}
----------------------------------------------------------------------------
character_specific.cammy.specials = {
	{
    name = "Cannon Spike",
    memory_map = {
      {0x92, 0x06}
    },
	id = 0x00,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"forward"}, {"down"}, {"forward", "down"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Spiral Arrow",
    memory_map = {
      {0x96, 0x06}
    },
	id = 0x02,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"forward", "down"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Spin Knuckle",
    memory_map = {
      {0xA2, 0x06}
    },
	id = 0x04,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"back"}, {"back", "down"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }, 
  {
    name = "Hooligan Combination",
    memory_map = {
      {0xA9, 0x06} -- buggy
    },
	id = 0x08,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"back"}, {"down"}, {"forward", "down"}, {"up", "forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Spin Drive Smasher",
    memory_map = {
      {0xA6, 0x08}
    },
	id = 0x06,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"down"}, {"forward", "down"}, {"forward"}, {"down"}, {"forward", "down"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
character_specific.cammy.throw = {"MP", "HP", "MK", "HK"}
character_specific.cammy.hitboxes = {
throw = {{"All Throws",42}},
throwable = 25,
}
character_specific.cammy.infos = {
charge_character = false,
has_projectile	 = false
}
------------------------------------------------------------------------------
character_specific.chunli.specials = {
	{
    name = "Spinning Bird Kick",
    memory_map = {
      {0xB0, 0x06}
    },
	id = 0x00,
	charge_address = 0xC0,
	strength_set = 1,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Hyakuretsu Kyaku",
    memory_map = {
      -- We load all variations
      {0x9A, 0x05},
      {0x9C, 0x05},
      {0x9E, 0x05}
    },
	id = 0x02,
	strength_set = 1,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{}},
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Kikouken",
    memory_map = {
      {0x80, 0x06}, -- Doesn't work
      {0x81, 0x00},
      {0x82, 0x01},
      {0x83, 0x01}
    },
	id = 0x04,
	charge_address = 0x81,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Up Kicks",
    memory_map = {
      {0xBA, 0x06}
    },
	id = 0x06,
	charge_address = 0xBB,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Senretsu Kyaku",
    memory_map = {
      {0xBF, 0x0A}
    },
	id = 0x08,
	charge_address = 0xB1,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
character_specific.chunli.throw = {"MP","HP"}
character_specific.chunli.hitboxes = {
throw = {{"All Throws",48}},
throwable = 25,
}
character_specific.chunli.infos = {
charge_character = true,
has_projectile	 = true
}
----------------------------------------------------------------------------------
character_specific.claw.specials = { 
	{
    name = "Crystal Flash",
    memory_map = {
      {0x88, 0x06}
    },
	id = 0x00,
	charge_address = 0x89,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Wall Dive (Kick)",
    memory_map = {
      {0x8C, 0x06} -- broken
    },
	id = 0x02,
	charge_address = 0x8D,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Wall Dive (Punch)",
    memory_map = {
      {0x90, 0x06}
    },
	id = 0x06,
	charge_address = 0x91,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Flip Kick",
    memory_map = {
      {0x9D, 0x06}
    },
	id = 0x0C,
	charge_address = 0x9E,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"down", "back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Back Flip (Punch)",
    memory_map = {},
    input = {{}},
	id = 0x04,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = false,
    input_variations = {{"LP", "MP", "HP"}},
  },  
  {
    name = "Back Flip (Kick)",
    memory_map = {},
    input = {{}},
	id = 0x08,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = false,
    input_variations = {{"LK", "MK", "HK"}},
  },
  {
    name = "Rolling Izuna Drop",
    memory_map = {
      {0x99, 0x0A}
    },
	id = 0x0A,
	charge_address = 0x9A,
	strength_set = 0,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"down", "h_charge"}, {"forward"}, {"back"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
character_specific.claw.throw = {"MP","HP"}
character_specific.claw.hitboxes = {
throw = {{"All Throws",48}},
throwable = 28,
}
character_specific.claw.infos = {
charge_character = true,
has_projectile	 = false
}
---------------------------------------------------------------------------------
character_specific.deejay.specials = { 
  {
    name = "Sobat Kick",
    memory_map = {
      {0xA6, 0x06}
    },
	id = 0x00,
	charge_address = 0x93,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }, 
  {
    name = "Machine Gun Upper",
    memory_map = {
      {0xAB, 0x06}
    },
	id = 0x02,
	charge_address = 0x97,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Air Slasher",
    memory_map = {
      {0xA7, 0x01}
    },
	id = 0x04,
	charge_address = 0xA7,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Jack Knife",
    memory_map = {
      {0x96, 0x06}
    },
	id = 0x06,
	charge_address = 0xAC,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Sobat Carnival",
    memory_map = {
      {0xAF, 0x0A}
    },
	id = 0x08,
	charge_address = 0xB0,
	strength_set = 0,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
character_specific.deejay.throw = {"MP","HP","MK","HK"}
character_specific.deejay.hitboxes = {
throw = {{"All Throws",48}},
throwable = 30,
}
character_specific.deejay.infos = {
charge_character = true,
has_projectile	 = true
}
--------------------------------------------------------------------------------
character_specific.dhalsim.specials = { 
  {
    name = "Yoga Fire",
    memory_map = {
      {0x80, 0x04}
    },
	id = 0x00,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"forward", "down"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Yoga Flame",
    memory_map = {
      {0x84, 0x08}
    },
	id = 0x02,
	strength_set = 2,
	reversal = true,
	new_only = false,
	charge_move = false,
    input = { {"back"}, {"back", "down"}, {"down"}, {"forward", "down"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Yoga Blast",
    memory_map = {
      {0x9A, 0x08}
    },
	id = 0x08,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"back"}, {"forward", "down"}, {"down"}, { "forward", "down"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
   {
    name = "Yoga Teleport", -- Modified to fit makeReversalSettingsButtons()
    memory_map = {
      {0xE0, 0x06} -- More values need to be added
    },
	id = 0x04,
	strength_set = -1,
	charge_move = false,
	reversal = true,
	new_only = false,
    input_variations = {{"F+P"},{"F+K"},{"B+P"},{"B+K"}},
  },
  {
    name = "Yoga Teleport (Forward)",
    memory_map = {
     {0xE0, 0x06} -- More values need to be added (see at the very bottom of the document)
    },
	id = 0x04,
	strength_set = 2,
	charge_move = false,
	reversal = false,
	new_only = false,
    input = { {"forward"}, {"down"}, {"forward", "down"} },
    input_variations = {{"LP", "MP", "HP"},{"LK", "MK", "HK"}},
  },
  {
    name = "Yoga Teleport (Back)",
    memory_map = {
     {0xE0, 0x05} -- More values need to be added
    },
	id = 0x04,
	strength_set = 2,
	charge_move = false,
	reversal = false,
	new_only = false,
    input = { {"back"}, {"down"}, {"back", "down"} },
    input_variations = {{"LP", "MP", "HP"},{"LK", "MK", "HK"}},
  },
  {
    name = "Yoga Inferno",
    memory_map = {
     {0x96, 0x10}
    },
    id = 0x06,
    strength_set = 0,
	charge_move = false,
	reversal = false,
	new_only = true,
    input = { {"back"},{"back", "down"},{"down"},{"forward", "down"},{"back"},{"back", "down"},{"down"},{"forward", "down"},{"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
character_specific.dhalsim.throw = {"MP","HP"}
character_specific.dhalsim.hitboxes = {
throw = {{"All Throws",64}},
throwable = 35,
}
character_specific.dhalsim.infos = {
charge_character = false,
has_projectile	 = true
}
--------------------------------------------------------------------------------------------------
character_specific.dictator.specials = {
  {
    name = "Psycho Crusher",
    memory_map = {
      {0x80, 0x06}
    },
	id = 0x00,
	charge_address = 0x81,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Scissor Kick",
    memory_map = {
      {0x88, 0x06}
    },
	id = 0x02,
	charge_address = 0x89,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Head Stomp",
    memory_map = {
      {0x91, 0x06}
    },
	id = 0x04,
	charge_address = 0x92,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Devil's Reverse",
    memory_map = {
      {0xAC, 0x06}
    },
	id = 0x06,
	charge_address = 0xAD,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Knee Press Knightmare",
    memory_map = {
      {0xC5, 0x0A}
    },
	id = 0x08,
	charge_address = 0xC6,
	strength_set = 0,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
character_specific.dictator.throw = {"MP","HP"}
character_specific.dictator.hitboxes = {
throw = {{"All Throws",52}},
throwable = 28,
}
character_specific.dictator.infos = {
charge_character = true,
has_projectile	 = false
}
---------------------------------------------------------------------------------
character_specific.feilong.specials = {
  {
    name = "Rekka", -- Should be tested if chained rekka works
    memory_map = {
      {0x90, 0x04},
      {0xA0, 0x04}
    },
	id = 0x00,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  --~ {
    --~ name = "Rekka 2",
    --~ memory_map = {
      --~ {0xA0, 0x04}
    --~ },
    --~ input = { {"down"}, {"down", "forward"}, {"forward"} },
    --~ input_variations = {{"LP"}, {"MP"}, {"HP"}},
  --~ },
  {
    name = "Flame Kick",
    memory_map = {
      {0x94, 0x04}
    },
	id = 0x02,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"back"}, {"down"}, {"down", "back"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Chicken Wing", -- Seems buggy
    memory_map = {
      {0xB4, 0x06}
    },
	id = 0x06,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"back"}, {"down"}, {"forward", "down"}, {"forward", "up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}} -- only lk works
  },
  {
    name = "Rekka Sinken",
    memory_map = {
      {0xB0, 0x0A}
    },
	id = 0x04,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
     input = { {"down"}, {"down", "forward"}, {"forward"}, {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
character_specific.feilong.throw = {"MP","HP","MK","HK"}
character_specific.feilong.hitboxes = {
throw = {{"All Throws",40}},
throwable = 29,
}
character_specific.feilong.infos = {
charge_character = false,
has_projectile	 = false
}
-------------------------------------------------------------------------------------------
character_specific.guile.specials = {
  {
    name = "Sonic Boom",
    memory_map = {
      {0x80, 0x06}
    },
	id = 0x00,
	charge_address = 0x81,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Flash Kick",
    memory_map = {
      {0x86, 0x06}
    },
	id = 0x02,
	charge_address = 0x87,
	strength_set = 1,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "v_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Double Somersault",
    memory_map = {
      {0x94, 0x0A}
    },
	id = 0x04,
	charge_address = 0x95,
	strength_set = 0,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"down", "v_charge"}, {"forward"}, {"back"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
character_specific.guile.throw = {"MP","HP"}
character_specific.guile.hitboxes = {
throw = {{"All Throws",48}},
throwable = 30,
}
character_specific.guile.infos = {
charge_character = true,
has_projectile	 = true
}
----------------------------------------------------------------------
character_specific.ehonda.specials = {
  {
    name = "Flying Headbutt",
    memory_map = {
      {0x88, 0x06}
    },
	id = 0x00,
	charge_address = 0x89,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
     input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Hundred Hands Slap",
    memory_map = {
      -- We load all variations
      {0xC6, 0x05},
      {0xC8, 0x05},
      {0xCA, 0x05}
    },
	id = 0x02,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{}},
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Butt Drop",
    memory_map = {
      {0x90, 0x06}
    },
	id = 0x04,
	charge_address = 0x91,
	strength_set = 2,
	charge_move = true,
	reversal = true,
	new_only = false,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Oichio Throw",
    memory_map = {
      {0x96, 0x06}
    },
	id = 0x08,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"forward"}, {"forward", "down"}, {"down"}, {"back"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Double Headbutt",
    memory_map = {
      {0x94, 0x0A}
    },
	id = 0x06,
	charge_address = 0x95,
	strength_set = 0,
	charge_move = true,
	reversal = true,
	new_only = true,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
character_specific.ehonda.throw = {"MP","HP","HK"}
character_specific.ehonda.hitboxes = {
throw = {{"Oicho",69},{"Normal throws",64}},
throwable = 28,
}
character_specific.ehonda.infos = {
charge_character = true,
has_projectile	 = false
}
-----------------------------------------------------------------------
character_specific.thawk.specials = { 
 {
    name = "Tomahawk",
    memory_map = {
      {0x8D, 0x04}
    },
	id = 0x00,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
	input = { {"forward"}, {"down"}, {"down", "forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Mexican Typhoon", -- To be fixed : works only on one side
    memory_map = {
      {0x91,0x04}, -- or 5 if other side
      {0x92,0x06},
      {0x93,0x08},
      {0x94,0x00}
    },
	id = 0x04,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{"back"}}, -- fixme
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Double Typhoon", -- To be fixed : works only on one side
    memory_map = {
    },
	id = 0x06,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = {{}},
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
character_specific.thawk.throw = {"MP","HP","HK"}
character_specific.thawk.hitboxes = {
throw = {{"Mexican Typhoon",83},{"Normal throws",48}},
throwable = 35,
}
character_specific.thawk.infos = {
charge_character = false,
has_projectile	 = false
}
--------------------------------------------------------------------
character_specific.ken.specials = {
  {
    name = "Hadouken",
    memory_map = {
      {0x94, 0x04}
    },
	id = 0x00,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },  
  {
    name = "Hurricane Kick",
    memory_map = {
      {0x90, 0x04}
    },
	id = 0x02,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"down", "back"}, {"back"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Shoryuken",
    memory_map = {
      {0x98, 0x04}
    },
	id = 0x04,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"forward"}, {"down"}, {"down", "forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Crazy Kick 1",
    memory_map = {
      {0xE6, 0x04}
    },
	id = 0x08,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Crazy Kick 2",
    memory_map = {
      {0xE8, 0x04}
    },
	id = 0x0A,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"forward"}, {"down", "forward"}, {"down"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Crazy Kick 3",
    memory_map = {
      {0xEA, 0x08}
    },
	id = 0x0C,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"down"}, {"down", "forward"}, {"forward"}, {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Shoryureppa",
    memory_map = {
     {0xA0, 0x08}
    },
	id = 0x06,
	strength_set = 0,
	charge_move = false,
	reversal = false,
	new_only = true,
    input = { {"down"}, {"down", "forward"}, {"forward"}, {"down"}, {"down", "forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
character_specific.ken.throw = {"MP","HP","MK","HK"}
character_specific.ken.hitboxes = {
throw = {{"All Throws",48}},
throwable = 29,
}
character_specific.ken.infos = {
charge_character = false,
has_projectile	 = true
}
----------------------------------------------------------------------
character_specific.ryu.specials = {
  {
    name = "Hadouken",
    memory_map = {
      {0x94, 0x04}
    },
	id = 0x00,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Hurricane Kick",
    memory_map = {
      {0x90, 0x04}
    },
	id = 0x02,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"down", "back"}, {"back"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Shoryuken",
    memory_map = {
      {0x98, 0x04}
    },
	id = 0x04,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"forward"}, {"down"}, {"down", "forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Red Hadouken",
    memory_map = {
      {0xE0, 0x08}
    },
	id = 0x06,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"back"}, {"back", "forward"}, {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Shinku Hadouken",
    memory_map = {
      {0xA0, 0x0A}
    },
	id = 0x08,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"down"}, {"down", "forward"}, {"forward"}, {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
character_specific.ryu.throw = {"MP","HP","MK","HK"}
character_specific.ryu.hitboxes = {
throw = {{"All Throws",48}},
throwable = 29,
}
character_specific.ryu.infos = {
charge_character = false,
has_projectile	 = true
}
----------------------------------------------------------------------------------------
character_specific.sagat.specials = {
  {
    name = "Tiger Shot Up",
    memory_map = {
      {0x88, 0x06}
    },
	id = 0x00,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Tiger Shot Low",
    memory_map = {
      {0x8C, 0x06}
    },
	id = 0x04,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Tiger Uppercut",
    memory_map = {
      {0x80, 0x06}
    },
	id = 0x02,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
	input = { {"forward"}, {"down"}, {"down", "forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Tiger Knee",
    memory_map = {
      {0x84, 0x06}
    },
	id = 0x06,
	strength_set = 2,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = { {"down"}, {"forward"}, {"forward", "up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Tiger Genocide",
    memory_map = {
     {0x9E, 0x0A}
    },
    id = 0x08,
    strength_set = 0,
	charge_move = false,
	reversal = false,
	new_only = true,
    input = { {"down"}, {"forward", "down"}, {"forward"}, {"down"}, {"forward", "down"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}, {"LK"}, {"MK"}, {"HK"}},
  }
}
character_specific.sagat.throw = {"MP","HP"}
character_specific.sagat.hitboxes = {
throw = {{"All Throws",48}},
throwable = 32,
}
character_specific.sagat.infos = {
charge_character = false,
has_projectile	 = true
}
------------------------------------------------------------------------
character_specific.zangief.specials = { 
  {
    name = "Spinning Pile Driver", -- To be fixed : works only on one side
    memory_map = {
      {0x80,0x08},
      {0x81,0x01},
      {0x82,0x0E},
      {0x83,0x00}
    },
	id = 0x02,
	strength_set = 1,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{}}, -- fixme
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Bear Grab",
    memory_map = {
      {0x9B,0x06},
      {0x9C,0x06},
      {0x9D,0x08},
      {0x9E,0x00}
    },
	id = 0x04,
	strength_set = 1,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{"back"}}, -- fixme
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
 
  {
    name = "Banishing Flat",
    memory_map = {
      {0xB3, 0x06}
    },
	id = 0x0A,
	strength_set = 1,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = { {"forward"}, {"forward", "down"}, {"down"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Lariat (Punch)",
    memory_map = {},
	id = 0x00,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{}},
    input_variations = {{"LP","MP","HP"}, {"LK","MK","HK"}},
  },
   {
    name = "Lariat (Kick)",
    memory_map = {},
	id = 0x0,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = false,
    input = {{}},
    input_variations = {{"LP","MP","HP"}, {"LK","MK","HK"}},
  },
  {
    name = "Final Atomic Buster", -- A voir
    memory_map = {
      -- TODO
    },
	id = 0x08,
	strength_set = 0,
	charge_move = false,
	reversal = true,
	new_only = true,
    input = {{}},
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
character_specific.zangief.throw = {"MP","HP","MK","HK"}
character_specific.zangief.hitboxes = {
throw = {{"SPD",111},{"HK Suplex",83},{"Normal Throws",69},{"MK Suplex",69},{"LK Suplex",66},{"720",64}},--, {138}, {147}, {155}},
throwable = 45,
}
character_specific.zangief.infos = {
charge_character = false,
has_projectile	 = false
}
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
function determineStrengthValue(_variation, _strength_set)
	if _variation == "LP" or _variation == "LK" then
			return 0x00
	elseif _variation == "MP" or _variation == "MK" then 
		if _strength_set == 1 then 
			return 0x01
		elseif _strength_set == 2 then 
			return 0x02
		end 
	elseif _variation == "HP" or _variation == "HK" then 
		if _strength_set == 1 then 
			return 0x02
		elseif _strength_set == 2 then 
			return 0x04
		end 
	end 
	if _strength_set == 0 then 
			return 0x00
	end
	if _strength_set == -1 then -- Dhalsim TP or Boxer TAP
		if _variation == "B+K" then
			return 0x00
		elseif _variation == "B+P" then
			return 0x02
		elseif _variation == "F+P"then
			return 0x04
		elseif _variation == "F+K"then 
			return 0x06
		--------------------------------
		elseif _variation == "1" then 
			return 0x00
		elseif _variation == "2" then 
			return 0x01
		elseif _variation == "3" then 
			return 0x02
		elseif _variation == "4" then 
			return 0x03
		elseif _variation == "5" then 
			return 0x04
		elseif _variation == "6" then 
			return 0x05
		elseif _variation == "7" then 
			return 0x06
		elseif _variation == "Final" then 
			return 0x07
		end 
	end
end

function getBoxerThrowDistance(opponent)
	local throw = {}
	if opponent == Dhalsim then
		throw = {{"MP",40},{"HP",30}}
	elseif opponent == Zangief then
		throw = {{"MP",41},{"HP",31}}
	elseif opponent == Guile then
		throw = {{"MP",50},{"HP",40}}
	elseif opponent == Chun or opponent == Cammy or opponent == Fei or opponent == Hawk or opponent == Ken or opponent == Ryu then
		throw = {{"MP",51},{"HP",41}}
	elseif opponent == Claw or opponent == Deejay or opponent == Dictator or opponent == Sagat then
		throw = {{"MP",52},{"HP",42}}
	elseif opponent == Boxer then
		throw = {{"MP",53},{"HP",43}}
	elseif opponent == Blanka then
		throw = {{"MP",63},{"HP",53}}
	elseif opponent == Honda then
		throw = {{"MP",64},{"HP",58}}
	end
	character_specific.boxer.hitboxes.throw = throw
end 

function determineThrowInput(_throw)
	if _throw == "MP" then 
		return "Medium Punch"
	elseif _throw == "HP" then 
		return "Strong Punch"
	elseif _throw == "MK" then 
		return "Medium Kick"
	elseif _throw == "HK" then 
		return "Strong Kick"
	end 
end

function updateForOldChar(_player_obj)
	local character = _player_obj.character
	if _player_obj.is_old then
		if character == Dictator then
			character_specific.dictator.specials[4].reversal = false -- Devil's Reverse 
		elseif character == Honda then
			for i = 1, 3 do
				character_specific.ehonda.specials[i].strength_set = 1
			end
		end
	else
		if character == Dictator then
			character_specific.dictator.specials[4].reversal = true
		elseif character == Honda then
			for i = 1, 3 do
				character_specific.ehonda.specials[i].strength_set = 2
			end
		end
	end
end

local player_keys = {
	"Up",
	"Down",
	"Left",
	"Right",
	"Weak Punch",
	"Medium Punch",
	"Strong Punch",
	"Weak Kick",
	"Medium Kick",
	"Strong Kick",
}

local player_keys_extra = {
	"Start",
	"Coin",
}

local sequence_to_key_mapping = {
	up = "Up",
	down = "Down",
	LP = "Weak Punch",
	MP = "Medium Punch",
	HP = "Strong Punch",
	LK = "Weak Kick",
	MK = "Medium Kick",
	HK = "Strong Kick",
}

key_to_sequence_mapping = {}
for k, v in pairs(sequence_to_key_mapping) do
	key_to_sequence_mapping[v] = k
end

function sequence_input_to_key(_key, _flip_input)
	if _key == "forward" then
		if _flip_input then
			return "Right"
		else
			return "Left"
		end
	elseif _key == "back" then
		if _flip_input then
			return "Left"
		else
			return "Right"
		end
	else
		return sequence_to_key_mapping[_key]
	end
end

function clearInputSet(player)
	inputs.properties.enableinputset = true 
	if player == 1 then
		for i = 1, #player_keys do
			inputs.setinputs["P1 "..player_keys[i]] = false
		end
	elseif player == 2 then
		for i = 1, #player_keys do
			--print(player_keys[i])
			inputs.setinputs["P2 "..player_keys[i]] = false
		end
	end
	setInputs()
end 

function modifyInputSet(player, ...)
	inputs.properties.enableinputset = true 
	local dir1, dir2, button1, button2, button3, button4, button5, button6 = ...
	if type(dir1)=="number" then
		local a = {{"Down", "Left"}, {"Down"}, {"Down", "Right"}, {"Left"}, {}, {"Right"}, {"Up", "Left"}, {"Up"}, {"Up", "Right"}} -- numpad
		dir2 = a[dir1][2]
		dir1 = a[dir1][1]
	end
	local a = {{"Weak Punch"}, {"Medium Punch"}, {"Strong Punch"}, {"Weak Kick"}, {"Medium Kick"}, {"Strong Kick"}}
	if type(button1) =="number" then
		button1 = a[button1][1]
	end
	if type(button2) =="number" then
		button2 = a[button2][1]
	end
	if type(button3) =="number" then
		button3 = a[button3][1]
	end
	if type(button4) =="number" then
		button4 = a[button4][1]
	end
	if type(button5) =="number" then
		button5 = a[button5][1]
	end
	if type(button6) =="number" then
		button6 = a[button6][1]
	end
	
	
	if player == 1 then 
		if dir1 then inputs.setinputs["P1 "..dir1] = true end
		if dir2 then inputs.setinputs["P1 "..dir2] = true end
		if button1 then inputs.setinputs["P1 "..button1] = true end
		if button2 then inputs.setinputs["P1 "..button2] = true end
		if button3 then inputs.setinputs["P1 "..button3] = true end
		if button4 then inputs.setinputs["P1 "..button4] = true end
		if button5 then inputs.setinputs["P1 "..button5] = true end
		if button6 then inputs.setinputs["P1 "..button6] = true end
	end

	if player == 2 then
		if dir1 then inputs.setinputs["P2 "..dir1] = true end
		if dir2 then inputs.setinputs["P2 "..dir2] = true end
		if button1 then inputs.setinputs["P2 "..button1] = true end
		if button2 then inputs.setinputs["P2 "..button2] = true end
		if button3 then inputs.setinputs["P2 "..button3] = true end
		if button4 then inputs.setinputs["P2 "..button4] = true end
		if button5 then inputs.setinputs["P2 "..button5] = true end
		if button6 then inputs.setinputs["P2 "..button6] = true end
	end
	
	setInputs()
end

function do_special_move(_player_obj, _special, _variation, easy_special_status)
	local dir1 = 5 -- numpad neutral
	local dir2 = 5
	local button1 = ""
	local button2 = ""
	local button3 = ""
	
  -- Toggle easy special
	if easy_special_status == true then
		for i, byte in pairs(_special.memory_map) do
			wb(_player_obj.base + byte[1], byte[2])
		end
	end

  -- Cancel all input
	clearInputSet(_player_obj.id)

	if #_special.input ~= 1 then -- If not PPP or KKK then
		for i, _stick in pairs(_special.input[#_special.input]) do
			if i == 1 then
				dir1 = sequence_input_to_key(_stick, _player_obj.flip_input)
			elseif i == 2 then
				dir2 = sequence_input_to_key(_stick, _player_obj.flip_input)
			end
		end
		for i, _button in pairs(_special.input_variations[_variation]) do
			if i == 1 then
				button1 = sequence_input_to_key(_button, _player_obj.flip_input)
			elseif i == 2 then
				button2 = sequence_input_to_key(_button, _player_obj.flip_input)
			elseif i == 3 then
				button3 = sequence_input_to_key(_button, _player_obj.flip_input)
			end
		end
	else
		for i, _button in pairs(_special.input[1]) do
			if i == 1 then
				button1 = sequence_input_to_key(_button, _player_obj.flip_input)
			elseif i == 2 then
				button2 = sequence_input_to_key(_button, _player_obj.flip_input)
			elseif i == 3 then
				button3 = sequence_input_to_key(_button, _player_obj.flip_input)
			end
		end
	end
	modifyInputSet(_player_obj.id, dir1, dir2, button1, button2, button3)
end