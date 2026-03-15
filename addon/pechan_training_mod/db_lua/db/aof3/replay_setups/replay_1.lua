assert(rb, "Run fbneo-training-mode.lua")
return {
   -- Table: {1}
   {

      ["description"] =
      "Configuración de entrenamiento diseñada para practicar la capacidad de reacción ante las herramientas principales de Ryo Sakazaki. El objetivo es identificar visualmente el inicio de su proyectil (Ko-Ou Ken) para castigarlo o bloquear adecuadamente, así como reaccionar a sus ataques de aproximación como su patada giratoria o combinaciones rápidas para mejorar la defensa y el contraataque en situaciones reales de combate.",
      ["title"] = "Reacción Proyectil/Tatsu de Ryo",
      ["GUARD_CONFIG"] = { 2 },
      ["HIT_CONFIG"] = { 3 },
      ["WAKEUP_CONFIG"] = { 4 },
      ["PLAYERS_CONFIG"] = { 5 },
      ["RECOVERY_CONFIG"] = { 6 },
      ["base_name"] = "replay_1",
      ["guard"] = false,
      ["DIZZY_CONFIG"] = { 7 },
      ["recording_propagation"] = { 8 },
      ["recording_var_states"] = { 9 },
      ["UI_CONFIG"] = { 10 },
      ["MOVES_VAR_NAMES"] = { 11 },
      ["recordings"] = { 12 },
      ["savestate_path"] = "addon/pechan_training_mod/db_lua/db/aof3/replay_savestates/replay_1.fs",
      ["wakeup"] = false,
      ["ENABLE_INPUT_SWAP"] = false,
      ["CPU_CONFIG"] = { 13 },
      ["p2"] = { 14 },
      ["DEBUG_CONFIG"] = { 15 },
      ["RECORDING_CONFIG"] = { 16 },
      ["p1"] = { 17 },
   },
   -- Table: {2}
   {
      ["ACTION_OPTIONS"] = { 18 },
      ["MODE_OPTIONS"] = { 19 },
      ["dummy_guarding"] = false,
      ["guard_mode"] = 0,
      ["reversal"] = 0,
      ["REVERSAL_OPTIONS"] = { 20 },
      ["dummy_action"] = 0,
      ["reversal_moves"] = { 21 },
   },
   -- Table: {3}
   {
      ["reversal"] = 0,
      ["REVERSAL_OPTIONS"] = { 22 },
      ["dummy_hit_reversal"] = false,
      ["reversal_moves"] = { 23 },
   },
   -- Table: {4}
   {
      ["reversal"] = 0,
      ["REVERSAL_OPTIONS"] = { 24 },
      ["dummy_waking_up"] = false,
      ["reversal_moves"] = { 25 },
   },
   -- Table: {5}
   {
      ["PLAYER2"] = { 26 },
      ["PLAYER1"] = { 27 },
   },
   -- Table: {6}
   {
      ["dummy_recovering"] = false,
      ["recovery"] = 0,
      ["times"] = 8,
      ["delay"] = 10,
      ["OPTIONS"] = { 28 },
   },
   -- Table: {7}
   {
      ["enabled"] = 1,
      ["dummy_can_dizzy"] = true,
      ["OPTIONS"] = { 29 },
   },
   -- Table: {8}
   {
   },
   -- Table: {9}
   {
   },
   -- Table: {10}
   {
      ["curent_background_music_selected"] = 1,
      ["ENABLE_COIN_SWAP"] = false,
      ["MODES"] = { 30 },
      ["CHARACTERS_HAS_CHANGED"] = false,
      ["INFINITE_STRIKERS"] = 0,
      ["PLAYER2_STRIKER_MODE"] = 0,
      ["PLAYER1_STRIKER_MODE"] = 0,
      ["PLAYER1_EX"] = false,
      ["INITIAL_START"] = false,
      ["PLAYER1_MODE"] = 1,
      ["current_stage_selected"] = 1,
      ["APPLIED"] = { 31 },
      ["PLAYER2_MODE"] = 1,
      ["PLAYER2_EX"] = false,
      ["MODE_HAS_CHANGED"] = false,
      ["CURRENT_PLAYER1"] = { 32 },
      ["CURRENT_PLAYER2"] = { 33 },
   },
   -- Table: {11}
   {
      ["WAKEUP"] = { 34 },
      ["HIT"] = { 35 },
      ["GUARD"] = { 36 },
   },
   -- Table: {12}
   {
      { 37 },
      { 38 },
      { 39 },
      { 40 },
      { 41 },
   },
   -- Table: {13}
   {
      ["HAS_CHANGED"] = false,
      ["dummy_can_fight"] = false,
      ["OPTIONS"] = { 42 },
      ["current_dificulty"] = 0,
      ["vs_enabled"] = 0,
      ["GCCD"] = { 43 },
      ["DIFFICULTY"] = { 44 },
      ["GCAB"] = { 45 },
   },
   -- Table: {14}
   {
      ["name"] = "Ryo Sakazaki",
      ["stored_id"] = 1,
   },
   -- Table: {15}
   {
      ["ADVANTAGE"] = 0,
      ["DISTANCE"] = 0,
      ["ACTION"] = 0,
      ["FRAMEDATA"] = 0,
      ["OPTIONS"] = { 46 },
      ["BLOCK"] = 0,
      ["POSITION"] = 0,
      ["STUN"] = 0,
      ["METER"] = 0,
      ["GUARD"] = 0,
      ["STATE"] = 0,
   },
   -- Table: {16}
   {
      ["loop"] = false,
      ["cooldown"] = 65,
      ["slots"] = { 47 },
   },
   -- Table: {17}
   {
      ["name"] = "Robert Garcia",
      ["stored_id"] = 0,
   },
   -- Table: {18}
   {
      ["STANDING"] = 0,
      ["CROUCHING"] = 1,
   },
   -- Table: {19}
   {
      ["RANDOM"] = 2,
      ["ALL_GUARD"] = 3,
      ["OFF"] = 0,
      ["ONE_HIT_GUARD"] = 4,
      ["ON"] = 1,
   },
   -- Table: {20}
   {
      ["RANDOM"] = 2,
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {21}
   {
      "ALT_GUARD",
   },
   -- Table: {22}
   {
      ["RANDOM"] = 2,
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {23}
   {
      "ALT_GUARD",
   },
   -- Table: {24}
   {
      ["RANDOM"] = 2,
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {25}
   {
      "ALT_GUARD",
   },
   -- Table: {26}
   {
      ["ID"] = 2,
      ["NAME"] = "P2",
      ["GUARD_BREAK"] = { 48 },
      ["COUNTER"] = { 49 },
   },
   -- Table: {27}
   {
      ["ID"] = 1,
      ["NAME"] = "P1",
      ["DUMMY_CTRL"] = { 50 },
   },
   -- Table: {28}
   {
      ["RANDOM"] = 2,
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {29}
   {
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {30}
   {
      ["EXTRA"] = 0,
      ["ADVANCED"] = 1,
   },
   -- Table: {31}
   {
      ["PLAYER1_EX"] = false,
      ["INFINITE_STRIKERS"] = 0,
      ["PLAYER2_MODE"] = 1,
      ["PLAYER2_STRIKER_MODE"] = 0,
      ["PLAYER1_MODE"] = 1,
      ["PLAYER2_EX"] = false,
      ["PLAYER1_STRIKER_MODE"] = 0,
   },
   -- Table: {32}
   {
      ["short_name"] = "robert",
      ["name"] = "Robert Garcia",
      ["code"] = "0x00",
   },
   -- Table: {33}
   {
      ["short_name"] = "ryo",
      ["name"] = "Ryo Sakazaki",
      ["code"] = "0x01",
   },
   -- Table: {34}
   {
      "DNEUTRALJ",
      "ST_D",
      "QCF_HCB",
      "INS_SJ_B",
      "R_DP",
      "SJ_F",
      "BACK_B",
      "CR_GUARD",
      "LONG_AB",
      "REC_2",
      "ST_B",
      "CR_C",
      "QCF_QCF",
      "PRETZEL",
      "HCB_F",
      "DSJ_F",
      "DF_C",
      "QCB_HCF",
      "QCB_F",
      "DH_F",
      "ST_C",
      "DP",
      "BACKDASH",
      "CD",
      "CR_A",
      "D_F_DF",
      "CR_B",
      "AB",
      "THROW_C",
      "DHJ_F",
      "DF_B",
      "DF_D",
      "REC_5",
      "REC_1",
      "FWD_A",
      "FWD_B",
      "BACK_A",
      "CR_D",
      "QCB",
      "QCF",
      "MASH_CRB",
      "ST_A",
      "C_GUARD",
      "STAND_A",
      "REC_4",
      "HCB",
      "ALT_GUARD",
      "REC_3",
      "HCF",
      "DNEUTRALH",
      "HH_F",
      "SJ_B",
      "SUPER_JUMP_BACK",
      ["DNEUTRALJ"] = 0,
      ["ST_D"] = 0,
      ["QCF_HCB"] = 0,
      ["INS_SJ_B"] = 0,
      ["R_DP"] = 0,
      ["SJ_F"] = 0,
      ["BACK_B"] = 0,
      ["CR_GUARD"] = 0,
      ["LONG_AB"] = 0,
      ["DNEUTRALH"] = 0,
      ["ST_B"] = 0,
      ["CR_C"] = 0,
      ["QCF_QCF"] = 0,
      ["PRETZEL"] = 0,
      ["HCB_F"] = 0,
      ["DSJ_F"] = 0,
      ["DF_C"] = 0,
      ["QCB_HCF"] = 0,
      ["QCB_F"] = 0,
      ["DH_F"] = 0,
      ["ST_C"] = 0,
      ["HH_F"] = 0,
      ["AB"] = 0,
      ["CD"] = 0,
      ["THROW_C"] = 0,
      ["D_F_DF"] = 0,
      ["CR_B"] = 0,
      ["BACKDASH"] = 0,
      ["FWD_A"] = 0,
      ["DHJ_F"] = 0,
      ["DF_B"] = 0,
      ["HCF"] = 0,
      ["REC_5"] = 0,
      ["REC_1"] = 0,
      ["CR_A"] = 0,
      ["ST_A"] = 0,
      ["BACK_A"] = 0,
      ["CR_D"] = 0,
      ["QCB"] = 0,
      ["QCF"] = 0,
      ["MASH_CRB"] = 0,
      ["DF_D"] = 0,
      ["C_GUARD"] = 0,
      ["STAND_A"] = 0,
      ["REC_4"] = 0,
      ["HCB"] = 0,
      ["ALT_GUARD"] = 1,
      ["DP"] = 0,
      ["SJ_B"] = 0,
      ["REC_3"] = 0,
      ["FWD_B"] = 0,
      ["REC_2"] = 0,
      ["SUPER_JUMP_BACK"] = 0,
   },
   -- Table: {35}
   {
      "DNEUTRALJ",
      "ST_D",
      "QCF_HCB",
      "INS_SJ_B",
      "R_DP",
      "SJ_F",
      "BACK_B",
      "CR_GUARD",
      "LONG_AB",
      "REC_2",
      "ST_B",
      "CR_C",
      "QCF_QCF",
      "PRETZEL",
      "HCB_F",
      "DSJ_F",
      "DF_C",
      "QCB_HCF",
      "QCB_F",
      "DH_F",
      "ST_C",
      "DP",
      "BACKDASH",
      "CD",
      "CR_A",
      "D_F_DF",
      "CR_B",
      "AB",
      "THROW_C",
      "DHJ_F",
      "DF_B",
      "DF_D",
      "REC_5",
      "REC_1",
      "FWD_A",
      "FWD_B",
      "BACK_A",
      "CR_D",
      "QCB",
      "QCF",
      "MASH_CRB",
      "ST_A",
      "C_GUARD",
      "STAND_A",
      "REC_4",
      "HCB",
      "ALT_GUARD",
      "REC_3",
      "HCF",
      "DNEUTRALH",
      "HH_F",
      "SJ_B",
      "SUPER_JUMP_BACK",
      ["DNEUTRALJ"] = 0,
      ["ST_D"] = 0,
      ["QCF_HCB"] = 0,
      ["INS_SJ_B"] = 0,
      ["R_DP"] = 0,
      ["SJ_F"] = 0,
      ["BACK_B"] = 0,
      ["CR_GUARD"] = 0,
      ["LONG_AB"] = 0,
      ["DNEUTRALH"] = 0,
      ["ST_B"] = 0,
      ["CR_C"] = 0,
      ["QCF_QCF"] = 0,
      ["PRETZEL"] = 0,
      ["HCB_F"] = 0,
      ["DSJ_F"] = 0,
      ["DF_C"] = 0,
      ["QCB_HCF"] = 0,
      ["QCB_F"] = 0,
      ["DH_F"] = 0,
      ["ST_C"] = 0,
      ["HH_F"] = 0,
      ["AB"] = 0,
      ["CD"] = 0,
      ["THROW_C"] = 0,
      ["D_F_DF"] = 0,
      ["CR_B"] = 0,
      ["BACKDASH"] = 0,
      ["FWD_A"] = 0,
      ["DHJ_F"] = 0,
      ["DF_B"] = 0,
      ["HCF"] = 0,
      ["REC_5"] = 0,
      ["REC_1"] = 0,
      ["CR_A"] = 0,
      ["ST_A"] = 0,
      ["BACK_A"] = 0,
      ["CR_D"] = 0,
      ["QCB"] = 0,
      ["QCF"] = 0,
      ["MASH_CRB"] = 0,
      ["DF_D"] = 0,
      ["C_GUARD"] = 0,
      ["STAND_A"] = 0,
      ["REC_4"] = 0,
      ["HCB"] = 0,
      ["ALT_GUARD"] = 1,
      ["DP"] = 0,
      ["SJ_B"] = 0,
      ["REC_3"] = 0,
      ["FWD_B"] = 0,
      ["REC_2"] = 0,
      ["SUPER_JUMP_BACK"] = 0,
   },
   -- Table: {36}
   {
      "DNEUTRALJ",
      "ST_D",
      "QCF_HCB",
      "INS_SJ_B",
      "R_DP",
      "SJ_F",
      "BACK_B",
      "CR_GUARD",
      "LONG_AB",
      "REC_2",
      "ST_B",
      "CR_C",
      "QCF_QCF",
      "PRETZEL",
      "HCB_F",
      "DSJ_F",
      "DF_C",
      "QCB_HCF",
      "QCB_F",
      "DH_F",
      "ST_C",
      "DP",
      "BACKDASH",
      "CD",
      "CR_A",
      "D_F_DF",
      "CR_B",
      "AB",
      "THROW_C",
      "DHJ_F",
      "DF_B",
      "DF_D",
      "REC_5",
      "REC_1",
      "FWD_A",
      "FWD_B",
      "BACK_A",
      "CR_D",
      "QCB",
      "QCF",
      "MASH_CRB",
      "ST_A",
      "C_GUARD",
      "STAND_A",
      "REC_4",
      "HCB",
      "ALT_GUARD",
      "REC_3",
      "HCF",
      "DNEUTRALH",
      "HH_F",
      "SJ_B",
      "SUPER_JUMP_BACK",
      ["DNEUTRALJ"] = 0,
      ["ST_D"] = 0,
      ["QCF_HCB"] = 0,
      ["INS_SJ_B"] = 0,
      ["R_DP"] = 0,
      ["SJ_F"] = 0,
      ["BACK_B"] = 0,
      ["CR_GUARD"] = 0,
      ["LONG_AB"] = 0,
      ["DNEUTRALH"] = 0,
      ["ST_B"] = 0,
      ["CR_C"] = 0,
      ["QCF_QCF"] = 0,
      ["PRETZEL"] = 0,
      ["HCB_F"] = 0,
      ["DSJ_F"] = 0,
      ["DF_C"] = 0,
      ["QCB_HCF"] = 0,
      ["QCB_F"] = 0,
      ["DH_F"] = 0,
      ["ST_C"] = 0,
      ["HH_F"] = 0,
      ["AB"] = 0,
      ["CD"] = 0,
      ["THROW_C"] = 0,
      ["D_F_DF"] = 0,
      ["CR_B"] = 0,
      ["BACKDASH"] = 0,
      ["FWD_A"] = 0,
      ["DHJ_F"] = 0,
      ["DF_B"] = 0,
      ["HCF"] = 0,
      ["REC_5"] = 0,
      ["REC_1"] = 0,
      ["CR_A"] = 0,
      ["ST_A"] = 0,
      ["BACK_A"] = 0,
      ["CR_D"] = 0,
      ["QCB"] = 0,
      ["QCF"] = 0,
      ["MASH_CRB"] = 0,
      ["DF_D"] = 0,
      ["C_GUARD"] = 0,
      ["STAND_A"] = 0,
      ["REC_4"] = 0,
      ["HCB"] = 0,
      ["ALT_GUARD"] = 1,
      ["DP"] = 0,
      ["SJ_B"] = 0,
      ["REC_3"] = 0,
      ["FWD_B"] = 0,
      ["REC_2"] = 0,
      ["SUPER_JUMP_BACK"] = 0,
   },
   -- Table: {37}
   {
      { 51 },
      { 52 },
      { 53 },
      { 54 },
      { 55 },
      { 56 },
      { 57 },
      { 58 },
      { 59 },
      { 60 },
      { 61 },
      { 62 },
      { 63 },
      { 64 },
      { 65 },
      { 66 },
      { 67 },
      { 68 },
      { 69 },
      { 70 },
      { 71 },
      { 72 },
      { 73 },
      { 74 },
      { 75 },
      { 76 },
      { 77 },
      { 78 },
      { 79 },
      { 80 },
      { 81 },
      { 82 },
      { 83 },
      { 84 },
      { 85 },
      { 86 },
      { 87 },
      { 88 },
      { 89 },
      { 90 },
      { 91 },
      { 92 },
      { 93 },
      { 94 },
      { 95 },
      { 96 },
      { 97 },
      { 98 },
      { 99 },
      { 100 },
      { 101 },
      { 102 },
      { 103 },
      { 104 },
      { 105 },
      { 106 },
      { 107 },
      { 108 },
      { 109 },
      { 110 },
      { 111 },
      { 112 },
      { 113 },
      { 114 },
      { 115 },
      { 116 },
      { 117 },
      { 118 },
      ["p2start"] = 1,
      ["_stable"] = { 119 },
      ["start"] = 1,
      ["p2finish"] = 35,
      ["p1start"] = 68,
      ["constants"] = { 120 },
   },
   -- Table: {38}
   {
      { 121 },
      { 122 },
      { 123 },
      { 124 },
      { 125 },
      { 126 },
      { 127 },
      { 128 },
      { 129 },
      { 130 },
      { 131 },
      { 132 },
      { 133 },
      { 134 },
      { 135 },
      { 136 },
      { 137 },
      { 138 },
      { 139 },
      { 140 },
      { 141 },
      { 142 },
      { 143 },
      { 144 },
      { 145 },
      { 146 },
      { 147 },
      { 148 },
      { 149 },
      { 150 },
      { 151 },
      { 152 },
      { 153 },
      { 154 },
      { 155 },
      { 156 },
      { 157 },
      { 158 },
      { 159 },
      { 160 },
      { 161 },
      { 162 },
      { 163 },
      { 164 },
      { 165 },
      { 166 },
      { 167 },
      { 168 },
      { 169 },
      { 170 },
      { 171 },
      { 172 },
      { 173 },
      { 174 },
      { 175 },
      { 176 },
      { 177 },
      { 178 },
      { 179 },
      { 180 },
      { 181 },
      { 182 },
      { 183 },
      { 184 },
      { 185 },
      { 186 },
      { 187 },
      { 188 },
      { 189 },
      { 190 },
      { 191 },
      { 192 },
      { 193 },
      { 194 },
      { 195 },
      { 196 },
      { 197 },
      { 198 },
      { 199 },
      { 200 },
      { 201 },
      { 202 },
      ["p2start"] = 1,
      ["_stable"] = { 203 },
      ["start"] = 1,
      ["p2finish"] = 71,
      ["p1start"] = 82,
      ["constants"] = { 204 },
   },
   -- Table: {39}
   {
   },
   -- Table: {40}
   {
   },
   -- Table: {41}
   {
   },
   -- Table: {42}
   {
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {43}
   {
      ["current_gccd"] = 0,
      ["dummy_can_gccd"] = false,
      ["OPTIONS"] = { 205 },
   },
   -- Table: {44}
   {
      ["EXPERT"] = 7,
      ["EASY"] = 1,
      ["NORMAL"] = 2,
      ["HARDEST"] = 6,
      ["HARD"] = 4,
      ["MVS"] = 3,
      ["VERYHARD"] = 5,
      ["BEGINNER"] = 0,
   },
   -- Table: {45}
   {
      ["current_gcab"] = 0,
      ["dummy_can_gcab"] = false,
      ["OPTIONS"] = { 206 },
   },
   -- Table: {46}
   {
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {47}
   {
      { 207 },
      { 208 },
      { 209 },
      { 210 },
      { 211 },
   },
   -- Table: {48}
   {
      ["STATE"] = 0,
      ["state_toggled"] = false,
      ["OPTIONS"] = { 212 },
   },
   -- Table: {49}
   {
      ["can_be_countered"] = false,
      ["ENABLED"] = 0,
      ["OPTIONS"] = { 213 },
   },
   -- Table: {50}
   {
      ["PLAYER"] = 2,
      ["OPTIONS"] = { 214 },
   },
   -- Table: {51}
   {
      ["serial"] = { 215 },
   },
   -- Table: {52}
   {
      ["serial"] = { 216 },
   },
   -- Table: {53}
   {
      ["serial"] = { 217 },
   },
   -- Table: {54}
   {
      ["serial"] = { 218 },
   },
   -- Table: {55}
   {
      ["serial"] = { 219 },
   },
   -- Table: {56}
   {
      ["serial"] = { 220 },
   },
   -- Table: {57}
   {
      ["serial"] = { 221 },
   },
   -- Table: {58}
   {
      ["serial"] = { 222 },
   },
   -- Table: {59}
   {
      ["serial"] = { 223 },
   },
   -- Table: {60}
   {
      ["serial"] = { 224 },
   },
   -- Table: {61}
   {
      ["serial"] = { 225 },
   },
   -- Table: {62}
   {
      ["serial"] = { 226 },
   },
   -- Table: {63}
   {
      ["serial"] = { 227 },
   },
   -- Table: {64}
   {
      ["serial"] = { 228 },
   },
   -- Table: {65}
   {
      ["serial"] = { 229 },
   },
   -- Table: {66}
   {
      ["serial"] = { 230 },
   },
   -- Table: {67}
   {
      ["serial"] = { 231 },
   },
   -- Table: {68}
   {
      ["serial"] = { 232 },
   },
   -- Table: {69}
   {
      ["serial"] = { 233 },
   },
   -- Table: {70}
   {
      ["serial"] = { 234 },
   },
   -- Table: {71}
   {
      ["serial"] = { 235 },
   },
   -- Table: {72}
   {
      ["serial"] = { 236 },
   },
   -- Table: {73}
   {
      ["serial"] = { 237 },
   },
   -- Table: {74}
   {
      ["serial"] = { 238 },
   },
   -- Table: {75}
   {
      ["serial"] = { 239 },
   },
   -- Table: {76}
   {
      ["serial"] = { 240 },
   },
   -- Table: {77}
   {
      ["serial"] = { 241 },
   },
   -- Table: {78}
   {
      ["serial"] = { 242 },
   },
   -- Table: {79}
   {
      ["serial"] = { 243 },
   },
   -- Table: {80}
   {
      ["serial"] = { 244 },
   },
   -- Table: {81}
   {
      ["serial"] = { 245 },
   },
   -- Table: {82}
   {
      ["serial"] = { 246 },
   },
   -- Table: {83}
   {
      ["serial"] = { 247 },
   },
   -- Table: {84}
   {
      ["serial"] = { 248 },
   },
   -- Table: {85}
   {
      ["serial"] = { 249 },
   },
   -- Table: {86}
   {
      ["serial"] = { 250 },
   },
   -- Table: {87}
   {
      ["serial"] = { 251 },
   },
   -- Table: {88}
   {
      ["serial"] = { 252 },
   },
   -- Table: {89}
   {
      ["serial"] = { 253 },
   },
   -- Table: {90}
   {
      ["serial"] = { 254 },
   },
   -- Table: {91}
   {
      ["serial"] = { 255 },
   },
   -- Table: {92}
   {
      ["serial"] = { 256 },
   },
   -- Table: {93}
   {
      ["serial"] = { 257 },
   },
   -- Table: {94}
   {
      ["serial"] = { 258 },
   },
   -- Table: {95}
   {
      ["serial"] = { 259 },
   },
   -- Table: {96}
   {
      ["serial"] = { 260 },
   },
   -- Table: {97}
   {
      ["serial"] = { 261 },
   },
   -- Table: {98}
   {
      ["serial"] = { 262 },
   },
   -- Table: {99}
   {
      ["serial"] = { 263 },
   },
   -- Table: {100}
   {
      ["serial"] = { 264 },
   },
   -- Table: {101}
   {
      ["serial"] = { 265 },
   },
   -- Table: {102}
   {
      ["serial"] = { 266 },
   },
   -- Table: {103}
   {
      ["serial"] = { 267 },
   },
   -- Table: {104}
   {
      ["serial"] = { 268 },
   },
   -- Table: {105}
   {
      ["serial"] = { 269 },
   },
   -- Table: {106}
   {
      ["serial"] = { 270 },
   },
   -- Table: {107}
   {
      ["serial"] = { 271 },
   },
   -- Table: {108}
   {
      ["serial"] = { 272 },
   },
   -- Table: {109}
   {
      ["serial"] = { 273 },
   },
   -- Table: {110}
   {
      ["serial"] = { 274 },
   },
   -- Table: {111}
   {
      ["serial"] = { 275 },
   },
   -- Table: {112}
   {
      ["serial"] = { 276 },
   },
   -- Table: {113}
   {
      ["serial"] = { 277 },
   },
   -- Table: {114}
   {
      ["serial"] = { 278 },
   },
   -- Table: {115}
   {
      ["serial"] = { 279 },
   },
   -- Table: {116}
   {
      ["serial"] = { 280 },
   },
   -- Table: {117}
   {
      ["serial"] = { 281 },
   },
   -- Table: {118}
   {
      ["serial"] = { 282 },
   },
   -- Table: {119}
   {
      ["p2"] = { 283 },
      ["p1"] = { 284 },
   },
   -- Table: {120}
   {
      ["P1 Button A"] = false,
      ["Debug Dip 2"] = 0,
      ["Service"] = false,
      ["P2 Coin"] = false,
      ["P1 Coin"] = false,
      ["P1 Down"] = false,
      ["Debug Dip 1"] = 0,
      ["P1 Button C"] = false,
      ["P2 Start"] = false,
      ["Slots"] = 1,
      ["P1 Start"] = false,
      ["P2 Up"] = false,
      ["P1 Up"] = false,
      ["Test"] = false,
      ["Dip 1"] = 0,
      ["P1 Left"] = false,
      ["System"] = 158,
      ["Reset"] = false,
      ["P2 Button B"] = false,
      ["P1 Select"] = false,
      ["P2 Button C"] = false,
      ["P2 Button D"] = false,
      ["P1 Button D"] = false,
      ["P2 Select"] = false,
      ["P1 Button B"] = false,
   },
   -- Table: {121}
   {
      ["serial"] = { 285 },
   },
   -- Table: {122}
   {
      ["serial"] = { 286 },
   },
   -- Table: {123}
   {
      ["serial"] = { 287 },
   },
   -- Table: {124}
   {
      ["serial"] = { 288 },
   },
   -- Table: {125}
   {
      ["serial"] = { 289 },
   },
   -- Table: {126}
   {
      ["serial"] = { 290 },
   },
   -- Table: {127}
   {
      ["serial"] = { 291 },
   },
   -- Table: {128}
   {
      ["serial"] = { 292 },
   },
   -- Table: {129}
   {
      ["serial"] = { 293 },
   },
   -- Table: {130}
   {
      ["serial"] = { 294 },
   },
   -- Table: {131}
   {
      ["serial"] = { 295 },
   },
   -- Table: {132}
   {
      ["serial"] = { 296 },
   },
   -- Table: {133}
   {
      ["serial"] = { 297 },
   },
   -- Table: {134}
   {
      ["serial"] = { 298 },
   },
   -- Table: {135}
   {
      ["serial"] = { 299 },
   },
   -- Table: {136}
   {
      ["serial"] = { 300 },
   },
   -- Table: {137}
   {
      ["serial"] = { 301 },
   },
   -- Table: {138}
   {
      ["serial"] = { 302 },
   },
   -- Table: {139}
   {
      ["serial"] = { 303 },
   },
   -- Table: {140}
   {
      ["serial"] = { 304 },
   },
   -- Table: {141}
   {
      ["serial"] = { 305 },
   },
   -- Table: {142}
   {
      ["serial"] = { 306 },
   },
   -- Table: {143}
   {
      ["serial"] = { 307 },
   },
   -- Table: {144}
   {
      ["serial"] = { 308 },
   },
   -- Table: {145}
   {
      ["serial"] = { 309 },
   },
   -- Table: {146}
   {
      ["serial"] = { 310 },
   },
   -- Table: {147}
   {
      ["serial"] = { 311 },
   },
   -- Table: {148}
   {
      ["serial"] = { 312 },
   },
   -- Table: {149}
   {
      ["serial"] = { 313 },
   },
   -- Table: {150}
   {
      ["serial"] = { 314 },
   },
   -- Table: {151}
   {
      ["serial"] = { 315 },
   },
   -- Table: {152}
   {
      ["serial"] = { 316 },
   },
   -- Table: {153}
   {
      ["serial"] = { 317 },
   },
   -- Table: {154}
   {
      ["serial"] = { 318 },
   },
   -- Table: {155}
   {
      ["serial"] = { 319 },
   },
   -- Table: {156}
   {
      ["serial"] = { 320 },
   },
   -- Table: {157}
   {
      ["serial"] = { 321 },
   },
   -- Table: {158}
   {
      ["serial"] = { 322 },
   },
   -- Table: {159}
   {
      ["serial"] = { 323 },
   },
   -- Table: {160}
   {
      ["serial"] = { 324 },
   },
   -- Table: {161}
   {
      ["serial"] = { 325 },
   },
   -- Table: {162}
   {
      ["serial"] = { 326 },
   },
   -- Table: {163}
   {
      ["serial"] = { 327 },
   },
   -- Table: {164}
   {
      ["serial"] = { 328 },
   },
   -- Table: {165}
   {
      ["serial"] = { 329 },
   },
   -- Table: {166}
   {
      ["serial"] = { 330 },
   },
   -- Table: {167}
   {
      ["serial"] = { 331 },
   },
   -- Table: {168}
   {
      ["serial"] = { 332 },
   },
   -- Table: {169}
   {
      ["serial"] = { 333 },
   },
   -- Table: {170}
   {
      ["serial"] = { 334 },
   },
   -- Table: {171}
   {
      ["serial"] = { 335 },
   },
   -- Table: {172}
   {
      ["serial"] = { 336 },
   },
   -- Table: {173}
   {
      ["serial"] = { 337 },
   },
   -- Table: {174}
   {
      ["serial"] = { 338 },
   },
   -- Table: {175}
   {
      ["serial"] = { 339 },
   },
   -- Table: {176}
   {
      ["serial"] = { 340 },
   },
   -- Table: {177}
   {
      ["serial"] = { 341 },
   },
   -- Table: {178}
   {
      ["serial"] = { 342 },
   },
   -- Table: {179}
   {
      ["serial"] = { 343 },
   },
   -- Table: {180}
   {
      ["serial"] = { 344 },
   },
   -- Table: {181}
   {
      ["serial"] = { 345 },
   },
   -- Table: {182}
   {
      ["serial"] = { 346 },
   },
   -- Table: {183}
   {
      ["serial"] = { 347 },
   },
   -- Table: {184}
   {
      ["serial"] = { 348 },
   },
   -- Table: {185}
   {
      ["serial"] = { 349 },
   },
   -- Table: {186}
   {
      ["serial"] = { 350 },
   },
   -- Table: {187}
   {
      ["serial"] = { 351 },
   },
   -- Table: {188}
   {
      ["serial"] = { 352 },
   },
   -- Table: {189}
   {
      ["serial"] = { 353 },
   },
   -- Table: {190}
   {
      ["serial"] = { 354 },
   },
   -- Table: {191}
   {
      ["serial"] = { 355 },
   },
   -- Table: {192}
   {
      ["serial"] = { 356 },
   },
   -- Table: {193}
   {
      ["serial"] = { 357 },
   },
   -- Table: {194}
   {
      ["serial"] = { 358 },
   },
   -- Table: {195}
   {
      ["serial"] = { 359 },
   },
   -- Table: {196}
   {
      ["serial"] = { 360 },
   },
   -- Table: {197}
   {
      ["serial"] = { 361 },
   },
   -- Table: {198}
   {
      ["serial"] = { 362 },
   },
   -- Table: {199}
   {
      ["serial"] = { 363 },
   },
   -- Table: {200}
   {
      ["serial"] = { 364 },
   },
   -- Table: {201}
   {
      ["serial"] = { 365 },
   },
   -- Table: {202}
   {
      ["serial"] = { 366 },
   },
   -- Table: {203}
   {
      ["p2"] = { 367 },
      ["p1"] = { 368 },
   },
   -- Table: {204}
   {
      ["P1 Button A"] = false,
      ["P2 Button A"] = false,
      ["Debug Dip 2"] = 0,
      ["Service"] = false,
      ["P2 Coin"] = false,
      ["P1 Coin"] = false,
      ["Debug Dip 1"] = 0,
      ["P1 Button C"] = false,
      ["P2 Start"] = false,
      ["Slots"] = 1,
      ["P1 Start"] = false,
      ["P2 Up"] = false,
      ["P1 Up"] = false,
      ["Test"] = false,
      ["Dip 1"] = 0,
      ["P1 Left"] = false,
      ["System"] = 158,
      ["Reset"] = false,
      ["P1 Select"] = false,
      ["P2 Button C"] = false,
      ["P2 Button D"] = false,
      ["P1 Button D"] = false,
      ["P2 Select"] = false,
      ["P1 Button B"] = false,
   },
   -- Table: {205}
   {
      ["RANDOM"] = 2,
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {206}
   {
      ["RANDOM"] = 2,
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {207}
   {
      ["enabled"] = true,
      ["savestate_reload_path"] = "../savestates/aof3 slot 01.fs",
      ["savestate_reload_slot"] = 1,
      ["weight"] = 1,
   },
   -- Table: {208}
   {
      ["enabled"] = true,
      ["savestate_reload_path"] = "../savestates/aof3 slot 01.fs",
      ["savestate_reload_slot"] = 1,
      ["weight"] = 1,
   },
   -- Table: {209}
   {
      ["enabled"] = false,
      ["savestate_reload_slot"] = -1,
      ["weight"] = 1,
   },
   -- Table: {210}
   {
      ["enabled"] = false,
      ["savestate_reload_slot"] = -1,
      ["weight"] = 1,
   },
   -- Table: {211}
   {
      ["enabled"] = false,
      ["savestate_reload_slot"] = -1,
      ["weight"] = 1,
   },
   -- Table: {212}
   {
      ["NEVER"] = 1,
      ["NORMAL"] = 0,
      ["ALWAYS"] = 2,
   },
   -- Table: {213}
   {
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {214}
   {
      ["P2"] = 2,
      ["P1"] = 1,
   },
   -- Table: {215}
   {
      ["other"] = { 369 },
      ["player"] = 72,
   },
   -- Table: {216}
   {
      ["other"] = { 370 },
      ["player"] = 76,
   },
   -- Table: {217}
   {
      ["other"] = { 371 },
      ["player"] = 76,
   },
   -- Table: {218}
   {
      ["other"] = { 372 },
      ["player"] = 76,
   },
   -- Table: {219}
   {
      ["other"] = { 373 },
      ["player"] = 68,
   },
   -- Table: {220}
   {
      ["other"] = { 374 },
      ["player"] = 68,
   },
   -- Table: {221}
   {
      ["other"] = { 375 },
      ["player"] = 68,
   },
   -- Table: {222}
   {
      ["other"] = { 376 },
      ["player"] = 84,
   },
   -- Table: {223}
   {
      ["other"] = { 377 },
      ["player"] = 84,
   },
   -- Table: {224}
   {
      ["other"] = { 378 },
      ["player"] = 80,
   },
   -- Table: {225}
   {
      ["other"] = { 379 },
      ["player"] = 82,
   },
   -- Table: {226}
   {
      ["other"] = { 380 },
      ["player"] = 82,
   },
   -- Table: {227}
   {
      ["other"] = { 381 },
      ["player"] = 82,
   },
   -- Table: {228}
   {
      ["other"] = { 382 },
      ["player"] = 66,
   },
   -- Table: {229}
   {
      ["other"] = { 383 },
      ["player"] = 66,
   },
   -- Table: {230}
   {
      ["other"] = { 384 },
      ["player"] = 66,
   },
   -- Table: {231}
   {
      ["other"] = { 385 },
      ["player"] = 66,
   },
   -- Table: {232}
   {
      ["other"] = { 386 },
      ["player"] = 66,
   },
   -- Table: {233}
   {
      ["other"] = { 387 },
      ["player"] = 66,
   },
   -- Table: {234}
   {
      ["other"] = { 388 },
      ["player"] = 66,
   },
   -- Table: {235}
   {
      ["other"] = { 389 },
      ["player"] = 66,
   },
   -- Table: {236}
   {
      ["other"] = { 390 },
      ["player"] = 66,
   },
   -- Table: {237}
   {
      ["other"] = { 391 },
      ["player"] = 66,
   },
   -- Table: {238}
   {
      ["other"] = { 392 },
      ["player"] = 66,
   },
   -- Table: {239}
   {
      ["other"] = { 393 },
      ["player"] = 66,
   },
   -- Table: {240}
   {
      ["other"] = { 394 },
      ["player"] = 66,
   },
   -- Table: {241}
   {
      ["other"] = { 395 },
      ["player"] = 66,
   },
   -- Table: {242}
   {
      ["other"] = { 396 },
      ["player"] = 66,
   },
   -- Table: {243}
   {
      ["other"] = { 397 },
      ["player"] = 66,
   },
   -- Table: {244}
   {
      ["other"] = { 398 },
      ["player"] = 66,
   },
   -- Table: {245}
   {
      ["other"] = { 399 },
      ["player"] = 66,
   },
   -- Table: {246}
   {
      ["other"] = { 400 },
      ["player"] = 66,
   },
   -- Table: {247}
   {
      ["other"] = { 401 },
      ["player"] = 66,
   },
   -- Table: {248}
   {
      ["other"] = { 402 },
      ["player"] = 66,
   },
   -- Table: {249}
   {
      ["other"] = { 403 },
      ["player"] = 66,
   },
   -- Table: {250}
   {
      ["other"] = { 404 },
      ["player"] = 64,
   },
   -- Table: {251}
   {
      ["other"] = { 405 },
      ["player"] = 64,
   },
   -- Table: {252}
   {
      ["other"] = { 406 },
      ["player"] = 64,
   },
   -- Table: {253}
   {
      ["other"] = { 407 },
      ["player"] = 64,
   },
   -- Table: {254}
   {
      ["other"] = { 408 },
      ["player"] = 64,
   },
   -- Table: {255}
   {
      ["other"] = { 409 },
      ["player"] = 64,
   },
   -- Table: {256}
   {
      ["other"] = { 410 },
      ["player"] = 64,
   },
   -- Table: {257}
   {
      ["other"] = { 411 },
      ["player"] = 64,
   },
   -- Table: {258}
   {
      ["other"] = { 412 },
      ["player"] = 64,
   },
   -- Table: {259}
   {
      ["other"] = { 413 },
      ["player"] = 64,
   },
   -- Table: {260}
   {
      ["other"] = { 414 },
      ["player"] = 64,
   },
   -- Table: {261}
   {
      ["other"] = { 415 },
      ["player"] = 64,
   },
   -- Table: {262}
   {
      ["other"] = { 416 },
      ["player"] = 64,
   },
   -- Table: {263}
   {
      ["other"] = { 417 },
      ["player"] = 64,
   },
   -- Table: {264}
   {
      ["other"] = { 418 },
      ["player"] = 64,
   },
   -- Table: {265}
   {
      ["other"] = { 419 },
      ["player"] = 64,
   },
   -- Table: {266}
   {
      ["other"] = { 420 },
      ["player"] = 64,
   },
   -- Table: {267}
   {
      ["other"] = { 421 },
      ["player"] = 64,
   },
   -- Table: {268}
   {
      ["other"] = { 422 },
      ["player"] = 64,
   },
   -- Table: {269}
   {
      ["other"] = { 423 },
      ["player"] = 64,
   },
   -- Table: {270}
   {
      ["other"] = { 424 },
      ["player"] = 64,
   },
   -- Table: {271}
   {
      ["other"] = { 425 },
      ["player"] = 64,
   },
   -- Table: {272}
   {
      ["other"] = { 426 },
      ["player"] = 64,
   },
   -- Table: {273}
   {
      ["other"] = { 427 },
      ["player"] = 64,
   },
   -- Table: {274}
   {
      ["other"] = { 428 },
      ["player"] = 64,
   },
   -- Table: {275}
   {
      ["other"] = { 429 },
      ["player"] = 64,
   },
   -- Table: {276}
   {
      ["other"] = { 430 },
      ["player"] = 64,
   },
   -- Table: {277}
   {
      ["other"] = { 431 },
      ["player"] = 64,
   },
   -- Table: {278}
   {
      ["other"] = { 432 },
      ["player"] = 64,
   },
   -- Table: {279}
   {
      ["other"] = { 433 },
      ["player"] = 64,
   },
   -- Table: {280}
   {
      ["other"] = { 434 },
      ["player"] = 64,
   },
   -- Table: {281}
   {
      ["other"] = { 435 },
      ["player"] = 64,
   },
   -- Table: {282}
   {
      ["other"] = { 436 },
      ["player"] = 64,
   },
   -- Table: {283}
   {
      "Button A",
      "Down",
      "Right",
      "Left",
      ["Right"] = 3,
      ["Left"] = 4,
      ["Button A"] = 1,
      ["Down"] = 2,
      ["len"] = 4,
   },
   -- Table: {284}
   {
      "Right",
      ["Right"] = 1,
      ["len"] = 1,
   },
   -- Table: {285}
   {
      ["other"] = { 437 },
      ["player"] = 140,
   },
   -- Table: {286}
   {
      ["other"] = { 438 },
      ["player"] = 140,
   },
   -- Table: {287}
   {
      ["other"] = { 439 },
      ["player"] = 132,
   },
   -- Table: {288}
   {
      ["other"] = { 440 },
      ["player"] = 132,
   },
   -- Table: {289}
   {
      ["other"] = { 441 },
      ["player"] = 132,
   },
   -- Table: {290}
   {
      ["other"] = { 442 },
      ["player"] = 148,
   },
   -- Table: {291}
   {
      ["other"] = { 443 },
      ["player"] = 148,
   },
   -- Table: {292}
   {
      ["other"] = { 444 },
      ["player"] = 148,
   },
   -- Table: {293}
   {
      ["other"] = { 445 },
      ["player"] = 144,
   },
   -- Table: {294}
   {
      ["other"] = { 446 },
      ["player"] = 144,
   },
   -- Table: {295}
   {
      ["other"] = { 447 },
      ["player"] = 176,
   },
   -- Table: {296}
   {
      ["other"] = { 448 },
      ["player"] = 176,
   },
   -- Table: {297}
   {
      ["other"] = { 449 },
      ["player"] = 160,
   },
   -- Table: {298}
   {
      ["other"] = { 450 },
      ["player"] = 160,
   },
   -- Table: {299}
   {
      ["other"] = { 451 },
      ["player"] = 160,
   },
   -- Table: {300}
   {
      ["other"] = { 452 },
      ["player"] = 160,
   },
   -- Table: {301}
   {
      ["other"] = { 453 },
      ["player"] = 160,
   },
   -- Table: {302}
   {
      ["other"] = { 454 },
      ["player"] = 160,
   },
   -- Table: {303}
   {
      ["other"] = { 455 },
      ["player"] = 160,
   },
   -- Table: {304}
   {
      ["other"] = { 456 },
      ["player"] = 160,
   },
   -- Table: {305}
   {
      ["other"] = { 457 },
      ["player"] = 160,
   },
   -- Table: {306}
   {
      ["other"] = { 458 },
      ["player"] = 160,
   },
   -- Table: {307}
   {
      ["other"] = { 459 },
      ["player"] = 160,
   },
   -- Table: {308}
   {
      ["other"] = { 460 },
      ["player"] = 160,
   },
   -- Table: {309}
   {
      ["other"] = { 461 },
      ["player"] = 160,
   },
   -- Table: {310}
   {
      ["other"] = { 462 },
      ["player"] = 160,
   },
   -- Table: {311}
   {
      ["other"] = { 463 },
      ["player"] = 160,
   },
   -- Table: {312}
   {
      ["other"] = { 464 },
      ["player"] = 160,
   },
   -- Table: {313}
   {
      ["other"] = { 465 },
      ["player"] = 160,
   },
   -- Table: {314}
   {
      ["other"] = { 466 },
      ["player"] = 160,
   },
   -- Table: {315}
   {
      ["other"] = { 467 },
      ["player"] = 160,
   },
   -- Table: {316}
   {
      ["other"] = { 468 },
      ["player"] = 160,
   },
   -- Table: {317}
   {
      ["other"] = { 469 },
      ["player"] = 160,
   },
   -- Table: {318}
   {
      ["other"] = { 470 },
      ["player"] = 160,
   },
   -- Table: {319}
   {
      ["other"] = { 471 },
      ["player"] = 160,
   },
   -- Table: {320}
   {
      ["other"] = { 472 },
      ["player"] = 160,
   },
   -- Table: {321}
   {
      ["other"] = { 473 },
      ["player"] = 160,
   },
   -- Table: {322}
   {
      ["other"] = { 474 },
      ["player"] = 160,
   },
   -- Table: {323}
   {
      ["other"] = { 475 },
      ["player"] = 160,
   },
   -- Table: {324}
   {
      ["other"] = { 476 },
      ["player"] = 160,
   },
   -- Table: {325}
   {
      ["other"] = { 477 },
      ["player"] = 160,
   },
   -- Table: {326}
   {
      ["other"] = { 478 },
      ["player"] = 160,
   },
   -- Table: {327}
   {
      ["other"] = { 479 },
      ["player"] = 160,
   },
   -- Table: {328}
   {
      ["other"] = { 480 },
      ["player"] = 160,
   },
   -- Table: {329}
   {
      ["other"] = { 481 },
      ["player"] = 160,
   },
   -- Table: {330}
   {
      ["other"] = { 482 },
      ["player"] = 160,
   },
   -- Table: {331}
   {
      ["other"] = { 483 },
      ["player"] = 160,
   },
   -- Table: {332}
   {
      ["other"] = { 484 },
      ["player"] = 160,
   },
   -- Table: {333}
   {
      ["other"] = { 485 },
      ["player"] = 160,
   },
   -- Table: {334}
   {
      ["other"] = { 486 },
      ["player"] = 160,
   },
   -- Table: {335}
   {
      ["other"] = { 487 },
      ["player"] = 160,
   },
   -- Table: {336}
   {
      ["other"] = { 488 },
      ["player"] = 160,
   },
   -- Table: {337}
   {
      ["other"] = { 489 },
      ["player"] = 160,
   },
   -- Table: {338}
   {
      ["other"] = { 490 },
      ["player"] = 160,
   },
   -- Table: {339}
   {
      ["other"] = { 491 },
      ["player"] = 160,
   },
   -- Table: {340}
   {
      ["other"] = { 492 },
      ["player"] = 160,
   },
   -- Table: {341}
   {
      ["other"] = { 493 },
      ["player"] = 160,
   },
   -- Table: {342}
   {
      ["other"] = { 494 },
      ["player"] = 160,
   },
   -- Table: {343}
   {
      ["other"] = { 495 },
      ["player"] = 160,
   },
   -- Table: {344}
   {
      ["other"] = { 496 },
      ["player"] = 160,
   },
   -- Table: {345}
   {
      ["other"] = { 497 },
      ["player"] = 160,
   },
   -- Table: {346}
   {
      ["other"] = { 498 },
      ["player"] = 160,
   },
   -- Table: {347}
   {
      ["other"] = { 499 },
      ["player"] = 160,
   },
   -- Table: {348}
   {
      ["other"] = { 500 },
      ["player"] = 160,
   },
   -- Table: {349}
   {
      ["other"] = { 501 },
      ["player"] = 160,
   },
   -- Table: {350}
   {
      ["other"] = { 502 },
      ["player"] = 160,
   },
   -- Table: {351}
   {
      ["other"] = { 503 },
      ["player"] = 160,
   },
   -- Table: {352}
   {
      ["other"] = { 504 },
      ["player"] = 160,
   },
   -- Table: {353}
   {
      ["other"] = { 505 },
      ["player"] = 160,
   },
   -- Table: {354}
   {
      ["other"] = { 506 },
      ["player"] = 160,
   },
   -- Table: {355}
   {
      ["other"] = { 507 },
      ["player"] = 160,
   },
   -- Table: {356}
   {
      ["other"] = { 508 },
      ["player"] = 128,
   },
   -- Table: {357}
   {
      ["other"] = { 509 },
      ["player"] = 128,
   },
   -- Table: {358}
   {
      ["other"] = { 510 },
      ["player"] = 128,
   },
   -- Table: {359}
   {
      ["other"] = { 511 },
      ["player"] = 128,
   },
   -- Table: {360}
   {
      ["other"] = { 512 },
      ["player"] = 128,
   },
   -- Table: {361}
   {
      ["other"] = { 513 },
      ["player"] = 128,
   },
   -- Table: {362}
   {
      ["other"] = { 514 },
      ["player"] = 128,
   },
   -- Table: {363}
   {
      ["other"] = { 515 },
      ["player"] = 128,
   },
   -- Table: {364}
   {
      ["other"] = { 516 },
      ["player"] = 128,
   },
   -- Table: {365}
   {
      ["other"] = { 517 },
      ["player"] = 128,
   },
   -- Table: {366}
   {
      ["other"] = { 518 },
      ["player"] = 128,
   },
   -- Table: {367}
   {
      "Down",
      "Right",
      "Left",
      "Button B",
      ["Button B"] = 4,
      ["Right"] = 2,
      ["Left"] = 3,
      ["Down"] = 1,
      ["len"] = 4,
   },
   -- Table: {368}
   {
      "Down",
      "Right",
      ["Right"] = 2,
      ["Down"] = 1,
      ["len"] = 2,
   },
   -- Table: {369}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {370}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {371}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {372}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {373}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {374}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {375}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {376}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {377}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {378}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {379}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {380}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {381}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {382}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {383}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {384}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {385}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {386}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {387}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {388}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {389}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {390}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {391}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {392}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {393}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {394}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {395}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {396}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {397}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {398}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {399}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {400}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {401}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {402}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {403}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {404}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {405}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {406}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {407}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {408}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {409}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {410}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {411}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {412}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {413}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {414}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {415}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {416}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {417}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {418}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {419}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {420}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {421}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {422}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {423}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {424}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {425}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {426}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {427}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {428}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {429}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {430}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {431}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {432}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {433}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {434}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {435}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {436}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {437}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {438}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {439}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {440}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {441}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {442}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {443}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {444}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {445}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {446}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {447}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {448}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {449}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {450}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {451}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {452}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {453}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {454}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {455}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {456}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {457}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {458}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {459}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {460}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {461}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {462}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {463}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {464}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {465}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {466}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {467}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {468}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {469}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {470}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {471}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {472}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {473}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {474}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {475}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {476}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {477}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {478}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {479}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {480}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {481}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {482}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {483}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {484}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {485}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {486}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {487}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {488}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {489}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {490}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {491}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {492}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {493}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {494}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {495}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {496}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {497}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {498}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {499}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {500}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {501}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {502}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {503}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {504}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {505}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {506}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {507}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {508}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {509}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {510}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {511}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {512}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {513}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {514}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {515}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {516}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {517}
   {
      ["Dip 2"] = 0,
   },
   -- Table: {518}
   {
      ["Dip 2"] = 0,
   },
}
