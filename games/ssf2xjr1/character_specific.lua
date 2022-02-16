-----------------------------------------------------------------------------
-- Made by McMic and Asunaro
-----------------------------------------------------------------------------
character_specific = {}
characters =
    {
      "ryu",
      "ehonda",
      "blanka",
      "guile",
      "ken",
      "chunli",
      "zangief",
      "dhalsim",
      "dictator",
      "sagat",
      "boxer",
      "claw",
      "cammy",
      "thawk",
      "feilong",
      "deejay",
    }

for i = 1, #characters do
  character_specific[characters[i]] = { specials = {}}
end
------------------------------------------------------------------------------
character_specific.blanka.specials = {
  {
    name = "Normal roll",
    memory_map = {
      {0xB9, 0x06}
    },
	id = 0x00,
	strength_set = 1,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Vertical Roll",
    memory_map = {
      {0xB0, 0x06}
    },
	id = 0x04,
	strength_set = 1,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Rainbow Roll",
    memory_map = {
      {0xB9, 0x06}
    },
	id = 0x06,
	strength_set = 1,
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
    input = {{}},
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Forward Dash",
    memory_map = {
    },
	id = 0x0A,
	strength_set = 0,
    input = { {"forward"} },
    input_variations = {{"LK", "MK", "HK"}},
  },
  {
    name = "Backward Dash",
    memory_map = {
    },
	id = 0x0C,
	strength_set = 0,
    input = { {"back"} },
    input_variations = {{"LK", "MK", "HK"}},
  },
  {
    name = "Ground Shave Roll",
    memory_map = {
      {0xC1, 0x0A}
    },
	id = 0x08,
	strength_set = 0,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
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
	strength_set = 1,
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
	strength_set = 1,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Buffalo Headbutt",
    memory_map = {
      {0xC0, 0x06}
    },
	id = 0x06,
	strength_set = 1,
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
	strength_set = 1,
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
	strength_set = 1,
    input = { {"back", "h_charge"}, {"forward", "down"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
   --~ 0001 - One
  --~ 0121 - Two
  --~ 0241 - Three
  --~ 0481 - Four
  --~ 0961 - Five
  --~ 1441 - Six
  --~ 1921 - Seven
  --~ 2401 - Final
  -- TAP is gonna be hard because it should be negative edge I guess
  {
   name = "TAP",
   memory_map = {
    {0xB6, 0001} -- A voir
    },
	id = 0x04,
	strength_set = 0,
    input = {{}},
   input_variations = {{"LP", "MP", "HP"}},
	},
  --~ {
    --~ name = "TAP Kick",
    --~ memory_map = {
      --~ {0xB8, 0001} -- A voir
    --~ },
    --~ input = {{}},
    --~ input_variations = {{"LK", "MK", "HK"}},
  --~ },
  {
    name = "Crazy Buffalo", -- Voir comment intégrer les différentes phases de la super ?
    memory_map = {
      {0xD4, 0x0A}
    },
	id = 0x08,
	strength_set = 0,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}, {"LK"}, {"MK"}, {"HK"}},
  }
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
    input = { {"back"}, {"back", "down"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Hooligan Combination", -- Compléter pour avoir les deux variations
    memory_map = {
      {0xA9, 0x06} -- buggy
    },
	id = 0x08,
	strength_set = 2,
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
    input = { {"down"}, {"forward", "down"}, {"forward"}, {"down"}, {"forward", "down"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
------------------------------------------------------------------------------
character_specific.chunli.specials = {
	{
    name = "Spinning Bird Kick",
    memory_map = {
      {0xB0, 0x06}
    },
	id = 0x00,
	strength_set = 2,
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
    input = {{}},
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Kikouken",
    memory_map = {
      {0x80, 0x06}, -- Ne fonctionne pas
      {0x81, 0x00},
      {0x82, 0x01},
      {0x83, 0x01}
    },
	id = 0x04,
	strength_set = 2,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Up Kicks",
    memory_map = {
      {0xBA, 0x06}
    },
	id = 0x06,
	strength_set = 2,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Senretsu Kyaku",
    memory_map = {
      {0xBF, 0x0A}
    },
	id = 0x08,
	strength_set = 0,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
----------------------------------------------------------------------------------
character_specific.claw.specials = {
	{
    name = "Crystal Flash",
    memory_map = {
      {0x88, 0x06}
    },
	id = 0x00,
	strength_set = 2,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Wall Dive (Kick)",
    memory_map = {
      {0x8C, 0x06} -- broken
    },
	id = 0x02,
	strength_set = 2,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Wall Dive (Punch)",
    memory_map = {
      {0x90, 0x06}
    },
	id = 0x06,
	strength_set = 2,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Flip Kick",
    memory_map = {
      {0x9D, 0x06}
    },
	id = 0x0C,
	strength_set = 2,
    input = { {"down", "back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Back Flip (Punch)",
    memory_map = {},
    input = {{}},
	id = 0x04,
	strength_set = 0,
    input_variations = {{"LP", "MP", "HP"}},
  },
  {
    name = "Back Flip (Kick)",
    memory_map = {},
    input = {{}},
	id = 0x08,
	strength_set = 0,
    input_variations = {{"LK", "MK", "HK"}},
  },
  {
    name = "Rolling Izuna Drop",
    memory_map = {
      {0x99, 0x0A}
    },
	id = 0x0A,
	strength_set = 0,
    input = { {"down", "h_charge"}, {"forward"}, {"back"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
---------------------------------------------------------------------------------
character_specific.deejay.specials = {
  {
    name = "Sobat Kick",
    memory_map = {
      {0xA6, 0x06}
    },
	id = 0x00,
	strength_set = 2,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Machine Gun Upper",
    memory_map = {
      {0xAB, 0x06}
    },
	id = 0x02,
	strength_set = 2,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Air Slasher",
    memory_map = {
      {0x92, 0x06}
    },
	id = 0x04,
	strength_set = 2,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Jack Knife",
    memory_map = {
      {0x96, 0x06}
    },
	id = 0x06,
	strength_set = 2,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Sobat Carnival",
    memory_map = {
      {0xAF, 0x0A}
    },
	id = 0x08,
	strength_set = 0,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
--------------------------------------------------------------------------------
character_specific.dhalsim.specials = {
  {
    name = "Yoga Fire",
    memory_map = {
      {0x80, 0x08}
    },
	id = 0x00,
	strength_set = 2,
    input = { {"down"}, {"forward", "down"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Yoga Flame",
    memory_map = {
      {0x9A, 0x04}
    },
	id = 0x02,
	strength_set = 2,
    input = { {"back"}, {"back", "down"}, {"down"}, {"forward", "down"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Yoga Blast",
    memory_map = {
      {0x84, 0x08}
    },
	id = 0x08,
	strength_set = 2,
    input = { {"back"}, {"forward", "down"}, {"down"}, { "forward", "down"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
   {
    name = "Yoga Teleport", -- Modified to fit makeReversalSettingsButtons()
    memory_map = {
      {0xE0, 0x06}
    },
	id = 0x04,
	strength_set = -1,
    input_variations = {{"F+P"},{"F+K"},{"B+P"},{"B+K"}},
  },
  --{
    --name = "Yoga Teleport (Forward)",
    --memory_map = {
     -- {0xE0, 0x06} -- Autre valeur à rajouter
    --},
	--id = 0x04,
	--strength_set = 2,
    --input = { {"forward"}, {"down"}, {"forward", "down"} },
    --input_variations = {{"LP", "MP", "HP"},{"LK", "MK", "HK"}},
  --},
  --{
   -- name = "Yoga Teleport (Back)",
    --memory_map = {
     -- {0xE0, 0x05} -- Autre valeur à rajouter
    --},
	--id = 0x04,
	--strength_set = 2,
    --input = { {"back"}, {"down"}, {"back", "down"} },
    --input_variations = {{"LP", "MP", "HP"},{"LK", "MK", "HK"}},
  --},
  {
    name = "Yoga Inferno",
    memory_map = {
      {0x96, 0x10}
    },
	id = 0x06,
	strength_set = 0,
    input = { {"back"},{"back", "down"},{"down"},{"forward", "down"},{"back"},{"back", "down"},{"down"},{"forward", "down"},{"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
--------------------------------------------------------------------------------------------------
character_specific.dictator.specials = {
  {
    name = "Psycho Crusher",
    memory_map = {
      {0x80, 0x06}
    },
	id = 0x00,
	strength_set = 1,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Scissor Kick",
    memory_map = {
      {0x88, 0x06}
    },
	id = 0x02,
	strength_set = 1,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Head Stomp",
    memory_map = {
      {0x91, 0x06}
    },
	id = 0x04,
	strength_set = 1,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Devil's Reverse",
    memory_map = {
      {0xAC, 0x06}
    },
	id = 0x06,
	strength_set = 2,
    input = { {"down", "h_charge"}, {"up"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Knee Press Knightmare",
    memory_map = {
      {0xC5, 0x0A}
    },
	id = 0x08,
	strength_set = 0,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
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
     input = { {"down"}, {"down", "forward"}, {"forward"}, {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
-------------------------------------------------------------------------------------------
character_specific.guile.specials = {
  {
    name = "Sonic Boom",
    memory_map = {
      {0x80, 0x06}
    },
	id = 0x00,
	strength_set = 1,
    input = { {"back", "h_charge"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Flash Kick",
    memory_map = {
      {0x86, 0x06}
    },
	id = 0x02,
	strength_set = 1,
    input = { {"down", "v_charge"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  },
  {
    name = "Double Somersault",
    memory_map = {
      {0x94, 0x0A}
    },
	id = 0x04,
	strength_set = 0,
    input = { {"down", "v_charge"}, {"forward"}, {"back"}, {"up"} },
    input_variations = {{"LK"}, {"MK"}, {"HK"}},
  }
}
----------------------------------------------------------------------
character_specific.ehonda.specials = {
  {
    name = "Flying Headbutt",
    memory_map = {
      {0x88, 0x06}
    },
	id = 0x00,
	strength_set = 2,
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
    input = {{}},
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Butt Drop",
    memory_map = {
      {0x90, 0x06}
    },
	id = 0x04,
	strength_set = 2,
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
    input = { {"forward"}, {"forward", "down"}, {"down"}, {"back"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Double Headbutt", -- ne s'affiche pas
    memory_map = {
      {0x94, 0x0A}
    },
	id = 0x06,
	strength_set = 0,
    input = { {"back", "h_charge"}, {"forward"}, {"back"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
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
	input = { {"forward"}, {"down"}, {"down", "forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Mexican Typhoon", -- A voir
    memory_map = {
      {0x91,0x04}, -- or 5 if other side
      {0x92,0x06},
      {0x93,0x08},
      {0x94,0x00}
    },
	id = 0x04,
	strength_set = 2,
    input = {{"back"}}, -- fixme
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Double Typhoon", -- A voir
    memory_map = {
    },
	id = 0x06,
	strength_set = 0,
    input = {{}},
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
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
    input = { {"down"}, {"down", "forward"}, {"forward"}, {"down"}, {"down", "forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
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
    input = { {"down"}, {"down", "forward"}, {"forward"}, {"down"}, {"down", "forward"}, {"forward"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
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
    input = { {"down"}, {"forward", "down"}, {"forward"}, {"down"}, {"forward", "down"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}, {"LK"}, {"MK"}, {"HK"}},
  }
}
------------------------------------------------------------------------
character_specific.zangief.specials = {
  {
    name = "Spinning Pile Driver", -- A voir
    memory_map = {
      {0x80,0x08},
      {0x81,0x01},
      {0x82,0x0E},
      {0x83,0x00}
    },
	id = 0x02,
	strength_set = 1,
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
    input = { {"forward"}, {"forward", "down"}, {"down"} },
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  },
  {
    name = "Lariat (Punch)",
    memory_map = {},
	id = 0x00,
	strength_set = 0,
    input = {{}},
    input_variations = {{"LP","MP","HP"}, {"LK","MK","HK"}},
  },
   {
    name = "Lariat (Kick)",
    memory_map = {},
	id = 0x0,
	strength_set = 0,
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
    input = {{}},
    input_variations = {{"LP"}, {"MP"}, {"HP"}},
  }
}
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
function determineStrengthValue(_variation, _strength_set)
	if _variation == "LP" or _variation == "LK" then
			return 0x0
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
	if _strength_set == -1 then -- Dhalsim TP
		if _variation == "B+K" then
			return 0x00
		elseif _variation == "B+P" then
			return 0x02
		elseif _variation == "F+P"then
			return 0x04
		elseif _variation == "F+K"then
			return 0x06
		end
	end
end

function do_special_move (_input, _player_obj, _special, _variation)
  print(_special.name)
  for i, byte in pairs(_special.memory_map) do
    memory.writebyte(_player_obj.base + byte[1], byte[2])
  end

  -- Cancel all input
  clear_player_input(_input, _player_obj.id, false)

  for i, _move in pairs(_special.input[#_special.input]) do
    _input[_player_obj.prefix .. " " .. sequence_input_to_key(_move, _player_obj.flip_input)] = true
  end

  for i, _move in pairs(_special.input_variations[_variation]) do
    _input[_player_obj.prefix .. " " .. sequence_input_to_key(_move, _player_obj.flip_input)] = true
  end
end
-------------------------------------------------------------------------------------------------
