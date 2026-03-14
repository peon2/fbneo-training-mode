assert(rb,"Run fbneo-training-mode.lua")
return {
-- Table: {1}
{
   ["title"] = "neutral drill",
   ["description"] = [[
      Practice thre situations with Iori
      1. React to jump-ins
      2. Check opponent run ins
      3. do nothing or attack if opponent does nothing
      
   ]],
   ["GUARD_CONFIG"]={2},
   ["HIT_CONFIG"]={3},
   ["WAKEUP_CONFIG"]={4},
   ["PLAYERS_CONFIG"]={5},
   ["RECOVERY_CONFIG"]={6},
   ["base_name"]="replay_1",
   ["guard"]=false,
   ["DIZZY_CONFIG"]={7},
   ["recording_propagation"]={8},
   ["recording_var_states"]={9},
   ["UI_CONFIG"]={10},
   ["MOVES_VAR_NAMES"]={11},
   ["recordings"]={12},
   ["savestate_path"]="addon/pechan_training_mod/db_lua/db/kof98/replay_savestates/replay_1.fs",
   ["wakeup"]=false,
   ["ENABLE_INPUT_SWAP"]=false,
   ["CPU_CONFIG"]={13},
   ["p2"]={14},
   ["DEBUG_CONFIG"]={15},
   ["RECORDING_CONFIG"]={16},
   ["p1"]={17},
},
-- Table: {2}
{
   ["ACTION_OPTIONS"]={18},
   ["MODE_OPTIONS"]={19},
   ["dummy_guarding"]=false,
   ["guard_mode"]=0,
   ["reversal"]=0,
   ["REVERSAL_OPTIONS"]={20},
   ["dummy_action"]=0,
   ["reversal_moves"]={21},
},
-- Table: {3}
{
   ["reversal"]=0,
   ["REVERSAL_OPTIONS"]={22},
   ["dummy_hit_reversal"]=false,
   ["reversal_moves"]={23},
},
-- Table: {4}
{
   ["reversal"]=0,
   ["REVERSAL_OPTIONS"]={24},
   ["dummy_waking_up"]=false,
   ["reversal_moves"]={25},
},
-- Table: {5}
{
   ["PLAYER2"]={26},
   ["PLAYER1"]={27},
},
-- Table: {6}
{
   ["dummy_recovering"]=false,
   ["recovery"]=0,
   ["times"]=8,
   ["delay"]=10,
   ["OPTIONS"]={28},
},
-- Table: {7}
{
   ["enabled"]=1,
   ["dummy_can_dizzy"]=true,
   ["OPTIONS"]={29},
},
-- Table: {8}
{
},
-- Table: {9}
{
},
-- Table: {10}
{
   ["curent_background_music_selected"]=1,
   ["ENABLE_COIN_SWAP"]=false,
   ["MODES"]={30},
   ["CHARACTERS_HAS_CHANGED"]=false,
   ["INFINITE_STRIKERS"]=0,
   ["PLAYER2_STRIKER_MODE"]=0,
   ["PLAYER1_STRIKER_MODE"]=0,
   ["PLAYER1_EX"]=false,
   ["INITIAL_START"]=false,
   ["PLAYER1_MODE"]=1,
   ["current_stage_selected"]=1,
   ["APPLIED"]={31},
   ["PLAYER2_MODE"]=1,
   ["PLAYER2_EX"]=false,
   ["MODE_HAS_CHANGED"]=false,
   ["CURRENT_PLAYER1"]={32},
   ["CURRENT_PLAYER2"]={33},
},
-- Table: {11}
{
   ["WAKEUP"]={34},
   ["HIT"]={35},
   ["GUARD"]={36},
},
-- Table: {12}
{
   {37},
   {38},
   {39},
   {40},
   {41},
},
-- Table: {13}
{
   ["HAS_CHANGED"]=false,
   ["dummy_can_fight"]=false,
   ["OPTIONS"]={42},
   ["current_dificulty"]=0,
   ["vs_enabled"]=0,
   ["GCCD"]={43},
   ["DIFFICULTY"]={44},
   ["GCAB"]={45},
},
-- Table: {14}
{
   ["name"]="Iori Yagami",
   ["stored_id"]=27,
},
-- Table: {15}
{
   ["ADVANTAGE"]=0,
   ["DISTANCE"]=0,
   ["ACTION"]=0,
   ["FRAMEDATA"]=0,
   ["OPTIONS"]={46},
   ["BLOCK"]=0,
   ["POSITION"]=0,
   ["STUN"]=0,
   ["METER"]=0,
   ["GUARD"]=0,
   ["STATE"]=0,
},
-- Table: {16}
{
   ["loop"]=false,
   ["cooldown"]=30,
   ["slots"]={47},
},
-- Table: {17}
{
   ["name"]="Iori Yagami",
   ["stored_id"]=27,
},
-- Table: {18}
{
   ["STANDING"]=0,
   ["CROUCHING"]=1,
},
-- Table: {19}
{
   ["RANDOM"]=2,
   ["ALL_GUARD"]=3,
   ["OFF"]=0,
   ["ONE_HIT_GUARD"]=4,
   ["ON"]=1,
},
-- Table: {20}
{
   ["RANDOM"]=2,
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {21}
{
   "ALT_GUARD",
},
-- Table: {22}
{
   ["RANDOM"]=2,
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {23}
{
   "ALT_GUARD",
},
-- Table: {24}
{
   ["RANDOM"]=2,
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {25}
{
   "ALT_GUARD",
},
-- Table: {26}
{
   ["ID"]=2,
   ["NAME"]="P2",
   ["GUARD_BREAK"]={48},
   ["COUNTER"]={49},
},
-- Table: {27}
{
   ["ID"]=1,
   ["NAME"]="P1",
   ["DUMMY_CTRL"]={50},
},
-- Table: {28}
{
   ["RANDOM"]=2,
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {29}
{
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {30}
{
   ["EXTRA"]=0,
   ["ADVANCED"]=1,
},
-- Table: {31}
{
   ["PLAYER1_EX"]=false,
   ["INFINITE_STRIKERS"]=0,
   ["PLAYER2_MODE"]=1,
   ["PLAYER2_STRIKER_MODE"]=0,
   ["PLAYER1_MODE"]=1,
   ["PLAYER2_EX"]=false,
   ["PLAYER1_STRIKER_MODE"]=0,
},
-- Table: {32}
{
   ["name"]="Kyo Kusanagi",
   ["has_ex"]=true,
   ["short_name"]="kyo",
   ["code"]="0x00",
},
-- Table: {33}
{
   ["name"]="Kyo Kusanagi",
   ["has_ex"]=true,
   ["short_name"]="kyo",
   ["code"]="0x00",
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
   ["DNEUTRALJ"]=0,
   ["ST_D"]=0,
   ["QCF_HCB"]=0,
   ["INS_SJ_B"]=0,
   ["R_DP"]=0,
   ["SJ_F"]=0,
   ["BACK_B"]=0,
   ["CR_GUARD"]=0,
   ["LONG_AB"]=0,
   ["DNEUTRALH"]=0,
   ["ST_B"]=0,
   ["CR_C"]=0,
   ["QCF_QCF"]=0,
   ["PRETZEL"]=0,
   ["HCB_F"]=0,
   ["DSJ_F"]=0,
   ["DF_C"]=0,
   ["QCB_HCF"]=0,
   ["QCB_F"]=0,
   ["DH_F"]=0,
   ["ST_C"]=0,
   ["HH_F"]=0,
   ["AB"]=0,
   ["CD"]=0,
   ["THROW_C"]=0,
   ["D_F_DF"]=0,
   ["CR_B"]=0,
   ["BACKDASH"]=0,
   ["FWD_A"]=0,
   ["DHJ_F"]=0,
   ["DF_B"]=0,
   ["HCF"]=0,
   ["REC_5"]=0,
   ["REC_1"]=0,
   ["CR_A"]=0,
   ["ST_A"]=0,
   ["BACK_A"]=0,
   ["CR_D"]=0,
   ["QCB"]=0,
   ["QCF"]=0,
   ["MASH_CRB"]=0,
   ["DF_D"]=0,
   ["C_GUARD"]=0,
   ["STAND_A"]=0,
   ["REC_4"]=0,
   ["HCB"]=0,
   ["ALT_GUARD"]=1,
   ["DP"]=0,
   ["SJ_B"]=0,
   ["REC_3"]=0,
   ["FWD_B"]=0,
   ["REC_2"]=0,
   ["SUPER_JUMP_BACK"]=0,
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
   ["DNEUTRALJ"]=0,
   ["ST_D"]=0,
   ["QCF_HCB"]=0,
   ["INS_SJ_B"]=0,
   ["R_DP"]=0,
   ["SJ_F"]=0,
   ["BACK_B"]=0,
   ["CR_GUARD"]=0,
   ["LONG_AB"]=0,
   ["DNEUTRALH"]=0,
   ["ST_B"]=0,
   ["CR_C"]=0,
   ["QCF_QCF"]=0,
   ["PRETZEL"]=0,
   ["HCB_F"]=0,
   ["DSJ_F"]=0,
   ["DF_C"]=0,
   ["QCB_HCF"]=0,
   ["QCB_F"]=0,
   ["DH_F"]=0,
   ["ST_C"]=0,
   ["HH_F"]=0,
   ["AB"]=0,
   ["CD"]=0,
   ["THROW_C"]=0,
   ["D_F_DF"]=0,
   ["CR_B"]=0,
   ["BACKDASH"]=0,
   ["FWD_A"]=0,
   ["DHJ_F"]=0,
   ["DF_B"]=0,
   ["HCF"]=0,
   ["REC_5"]=0,
   ["REC_1"]=0,
   ["CR_A"]=0,
   ["ST_A"]=0,
   ["BACK_A"]=0,
   ["CR_D"]=0,
   ["QCB"]=0,
   ["QCF"]=0,
   ["MASH_CRB"]=0,
   ["DF_D"]=0,
   ["C_GUARD"]=0,
   ["STAND_A"]=0,
   ["REC_4"]=0,
   ["HCB"]=0,
   ["ALT_GUARD"]=1,
   ["DP"]=0,
   ["SJ_B"]=0,
   ["REC_3"]=0,
   ["FWD_B"]=0,
   ["REC_2"]=0,
   ["SUPER_JUMP_BACK"]=0,
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
   ["DNEUTRALJ"]=0,
   ["ST_D"]=0,
   ["QCF_HCB"]=0,
   ["INS_SJ_B"]=0,
   ["R_DP"]=0,
   ["SJ_F"]=0,
   ["BACK_B"]=0,
   ["CR_GUARD"]=0,
   ["LONG_AB"]=0,
   ["DNEUTRALH"]=0,
   ["ST_B"]=0,
   ["CR_C"]=0,
   ["QCF_QCF"]=0,
   ["PRETZEL"]=0,
   ["HCB_F"]=0,
   ["DSJ_F"]=0,
   ["DF_C"]=0,
   ["QCB_HCF"]=0,
   ["QCB_F"]=0,
   ["DH_F"]=0,
   ["ST_C"]=0,
   ["HH_F"]=0,
   ["AB"]=0,
   ["CD"]=0,
   ["THROW_C"]=0,
   ["D_F_DF"]=0,
   ["CR_B"]=0,
   ["BACKDASH"]=0,
   ["FWD_A"]=0,
   ["DHJ_F"]=0,
   ["DF_B"]=0,
   ["HCF"]=0,
   ["REC_5"]=0,
   ["REC_1"]=0,
   ["CR_A"]=0,
   ["ST_A"]=0,
   ["BACK_A"]=0,
   ["CR_D"]=0,
   ["QCB"]=0,
   ["QCF"]=0,
   ["MASH_CRB"]=0,
   ["DF_D"]=0,
   ["C_GUARD"]=0,
   ["STAND_A"]=0,
   ["REC_4"]=0,
   ["HCB"]=0,
   ["ALT_GUARD"]=1,
   ["DP"]=0,
   ["SJ_B"]=0,
   ["REC_3"]=0,
   ["FWD_B"]=0,
   ["REC_2"]=0,
   ["SUPER_JUMP_BACK"]=0,
},
-- Table: {37}
{
   {51},
   {52},
   {53},
   {54},
   {55},
   {56},
   {57},
   {58},
   {59},
   {60},
   {61},
   {62},
   {63},
   {64},
   {65},
   {66},
   {67},
   {68},
   {69},
   {70},
   {71},
   {72},
   {73},
   {74},
   {75},
   {76},
   {77},
   {78},
   {79},
   {80},
   {81},
   {82},
   {83},
   {84},
   {85},
   {86},
   {87},
   {88},
   {89},
   {90},
   {91},
   {92},
   {93},
   {94},
   {95},
   {96},
   {97},
   {98},
   {99},
   {100},
   {101},
   {102},
   {103},
   {104},
   {105},
   {106},
   {107},
   {108},
   {109},
   {110},
   {111},
   {112},
   {113},
   {114},
   {115},
   {116},
   {117},
   {118},
   {119},
   {120},
   {121},
   {122},
   {123},
   {124},
   {125},
   {126},
   {127},
   {128},
   {129},
   {130},
   {131},
   {132},
   {133},
   {134},
   {135},
   {136},
   {137},
   {138},
   {139},
   {140},
   {141},
   {142},
   {143},
   {144},
   {145},
   {146},
   ["p2start"]=1,
   ["_stable"]={147},
   ["start"]=1,
   ["p2finish"]=78,
   ["p1start"]=96,
   ["constants"]={148},
},
-- Table: {38}
{
   {149},
   {150},
   {151},
   {152},
   {153},
   {154},
   {155},
   {156},
   {157},
   {158},
   {159},
   {160},
   {161},
   {162},
   {163},
   {164},
   {165},
   {166},
   {167},
   {168},
   {169},
   {170},
   {171},
   {172},
   {173},
   {174},
   {175},
   {176},
   {177},
   {178},
   {179},
   {180},
   {181},
   {182},
   {183},
   {184},
   {185},
   {186},
   {187},
   {188},
   {189},
   {190},
   {191},
   {192},
   {193},
   {194},
   {195},
   {196},
   {197},
   {198},
   {199},
   {200},
   {201},
   {202},
   {203},
   {204},
   {205},
   {206},
   {207},
   {208},
   {209},
   {210},
   {211},
   {212},
   {213},
   {214},
   {215},
   {216},
   {217},
   {218},
   {219},
   {220},
   {221},
   {222},
   {223},
   {224},
   {225},
   {226},
   {227},
   {228},
   {229},
   {230},
   {231},
   {232},
   {233},
   {234},
   {235},
   {236},
   {237},
   {238},
   {239},
   {240},
   {241},
   {242},
   {243},
   {244},
   {245},
   {246},
   {247},
   {248},
   {249},
   {250},
   {251},
   {252},
   {253},
   {254},
   {255},
   {256},
   ["p2start"]=1,
   ["_stable"]={257},
   ["start"]=1,
   ["p2finish"]=99,
   ["p1start"]=108,
   ["constants"]={258},
},
-- Table: {39}
{
   {259},
   {260},
   {261},
   {262},
   {263},
   {264},
   {265},
   {266},
   {267},
   {268},
   {269},
   {270},
   {271},
   {272},
   {273},
   {274},
   {275},
   {276},
   {277},
   {278},
   {279},
   {280},
   {281},
   {282},
   {283},
   {284},
   {285},
   {286},
   {287},
   {288},
   {289},
   {290},
   {291},
   {292},
   {293},
   {294},
   {295},
   {296},
   {297},
   {298},
   {299},
   {300},
   {301},
   {302},
   {303},
   {304},
   {305},
   {306},
   {307},
   {308},
   {309},
   {310},
   {311},
   {312},
   {313},
   {314},
   {315},
   {316},
   {317},
   {318},
   {319},
   {320},
   {321},
   {322},
   {323},
   {324},
   {325},
   {326},
   {327},
   {328},
   {329},
   {330},
   {331},
   {332},
   {333},
   {334},
   {335},
   {336},
   {337},
   {338},
   {339},
   {340},
   {341},
   {342},
   {343},
   {344},
   {345},
   {346},
   {347},
   {348},
   {349},
   {350},
   {351},
   {352},
   {353},
   {354},
   {355},
   {356},
   {357},
   {358},
   {359},
   {360},
   {361},
   {362},
   {363},
   {364},
   {365},
   {366},
   {367},
   {368},
   {369},
   {370},
   {371},
   {372},
   {373},
   {374},
   {375},
   {376},
   {377},
   {378},
   {379},
   {380},
   {381},
   ["p2start"]=1,
   ["_stable"]={382},
   ["start"]=1,
   ["p2finish"]=123,
   ["p1start"]=123,
   ["constants"]={383},
},
-- Table: {40}
{
},
-- Table: {41}
{
},
-- Table: {42}
{
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {43}
{
   ["current_gccd"]=0,
   ["dummy_can_gccd"]=false,
   ["OPTIONS"]={384},
},
-- Table: {44}
{
   ["EXPERT"]=7,
   ["EASY"]=1,
   ["NORMAL"]=2,
   ["HARDEST"]=6,
   ["HARD"]=4,
   ["MVS"]=3,
   ["VERYHARD"]=5,
   ["BEGINNER"]=0,
},
-- Table: {45}
{
   ["current_gcab"]=0,
   ["dummy_can_gcab"]=false,
   ["OPTIONS"]={385},
},
-- Table: {46}
{
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {47}
{
   {386},
   {387},
   {388},
   {389},
   {390},
},
-- Table: {48}
{
   ["STATE"]=0,
   ["state_toggled"]=false,
   ["OPTIONS"]={391},
},
-- Table: {49}
{
   ["can_be_countered"]=false,
   ["ENABLED"]=0,
   ["OPTIONS"]={392},
},
-- Table: {50}
{
   ["PLAYER"]=2,
   ["OPTIONS"]={393},
},
-- Table: {51}
{
   ["serial"]={394},
},
-- Table: {52}
{
   ["serial"]={395},
},
-- Table: {53}
{
   ["serial"]={396},
},
-- Table: {54}
{
   ["serial"]={397},
},
-- Table: {55}
{
   ["serial"]={398},
},
-- Table: {56}
{
   ["serial"]={399},
},
-- Table: {57}
{
   ["serial"]={400},
},
-- Table: {58}
{
   ["serial"]={401},
},
-- Table: {59}
{
   ["serial"]={402},
},
-- Table: {60}
{
   ["serial"]={403},
},
-- Table: {61}
{
   ["serial"]={404},
},
-- Table: {62}
{
   ["serial"]={405},
},
-- Table: {63}
{
   ["serial"]={406},
},
-- Table: {64}
{
   ["serial"]={407},
},
-- Table: {65}
{
   ["serial"]={408},
},
-- Table: {66}
{
   ["serial"]={409},
},
-- Table: {67}
{
   ["serial"]={410},
},
-- Table: {68}
{
   ["serial"]={411},
},
-- Table: {69}
{
   ["serial"]={412},
},
-- Table: {70}
{
   ["serial"]={413},
},
-- Table: {71}
{
   ["serial"]={414},
},
-- Table: {72}
{
   ["serial"]={415},
},
-- Table: {73}
{
   ["serial"]={416},
},
-- Table: {74}
{
   ["serial"]={417},
},
-- Table: {75}
{
   ["serial"]={418},
},
-- Table: {76}
{
   ["serial"]={419},
},
-- Table: {77}
{
   ["serial"]={420},
},
-- Table: {78}
{
   ["serial"]={421},
},
-- Table: {79}
{
   ["serial"]={422},
},
-- Table: {80}
{
   ["serial"]={423},
},
-- Table: {81}
{
   ["serial"]={424},
},
-- Table: {82}
{
   ["serial"]={425},
},
-- Table: {83}
{
   ["serial"]={426},
},
-- Table: {84}
{
   ["serial"]={427},
},
-- Table: {85}
{
   ["serial"]={428},
},
-- Table: {86}
{
   ["serial"]={429},
},
-- Table: {87}
{
   ["serial"]={430},
},
-- Table: {88}
{
   ["serial"]={431},
},
-- Table: {89}
{
   ["serial"]={432},
},
-- Table: {90}
{
   ["serial"]={433},
},
-- Table: {91}
{
   ["serial"]={434},
},
-- Table: {92}
{
   ["serial"]={435},
},
-- Table: {93}
{
   ["serial"]={436},
},
-- Table: {94}
{
   ["serial"]={437},
},
-- Table: {95}
{
   ["serial"]={438},
},
-- Table: {96}
{
   ["serial"]={439},
},
-- Table: {97}
{
   ["serial"]={440},
},
-- Table: {98}
{
   ["serial"]={441},
},
-- Table: {99}
{
   ["serial"]={442},
},
-- Table: {100}
{
   ["serial"]={443},
},
-- Table: {101}
{
   ["serial"]={444},
},
-- Table: {102}
{
   ["serial"]={445},
},
-- Table: {103}
{
   ["serial"]={446},
},
-- Table: {104}
{
   ["serial"]={447},
},
-- Table: {105}
{
   ["serial"]={448},
},
-- Table: {106}
{
   ["serial"]={449},
},
-- Table: {107}
{
   ["serial"]={450},
},
-- Table: {108}
{
   ["serial"]={451},
},
-- Table: {109}
{
   ["serial"]={452},
},
-- Table: {110}
{
   ["serial"]={453},
},
-- Table: {111}
{
   ["serial"]={454},
},
-- Table: {112}
{
   ["serial"]={455},
},
-- Table: {113}
{
   ["serial"]={456},
},
-- Table: {114}
{
   ["serial"]={457},
},
-- Table: {115}
{
   ["serial"]={458},
},
-- Table: {116}
{
   ["serial"]={459},
},
-- Table: {117}
{
   ["serial"]={460},
},
-- Table: {118}
{
   ["serial"]={461},
},
-- Table: {119}
{
   ["serial"]={462},
},
-- Table: {120}
{
   ["serial"]={463},
},
-- Table: {121}
{
   ["serial"]={464},
},
-- Table: {122}
{
   ["serial"]={465},
},
-- Table: {123}
{
   ["serial"]={466},
},
-- Table: {124}
{
   ["serial"]={467},
},
-- Table: {125}
{
   ["serial"]={468},
},
-- Table: {126}
{
   ["serial"]={469},
},
-- Table: {127}
{
   ["serial"]={470},
},
-- Table: {128}
{
   ["serial"]={471},
},
-- Table: {129}
{
   ["serial"]={472},
},
-- Table: {130}
{
   ["serial"]={473},
},
-- Table: {131}
{
   ["serial"]={474},
},
-- Table: {132}
{
   ["serial"]={475},
},
-- Table: {133}
{
   ["serial"]={476},
},
-- Table: {134}
{
   ["serial"]={477},
},
-- Table: {135}
{
   ["serial"]={478},
},
-- Table: {136}
{
   ["serial"]={479},
},
-- Table: {137}
{
   ["serial"]={480},
},
-- Table: {138}
{
   ["serial"]={481},
},
-- Table: {139}
{
   ["serial"]={482},
},
-- Table: {140}
{
   ["serial"]={483},
},
-- Table: {141}
{
   ["serial"]={484},
},
-- Table: {142}
{
   ["serial"]={485},
},
-- Table: {143}
{
   ["serial"]={486},
},
-- Table: {144}
{
   ["serial"]={487},
},
-- Table: {145}
{
   ["serial"]={488},
},
-- Table: {146}
{
   ["serial"]={489},
},
-- Table: {147}
{
   ["p2"]={490},
   ["p1"]={491},
},
-- Table: {148}
{
   ["P1 Button A"]=false,
   ["P2 Button A"]=false,
   ["Debug Dip 2"]=0,
   ["Service"]=false,
   ["P2 Coin"]=false,
   ["P1 Coin"]=false,
   ["Debug Dip 1"]=0,
   ["P1 Button C"]=false,
   ["P2 Start"]=false,
   ["Slots"]=1,
   ["P1 Start"]=false,
   ["P1 Right"]=false,
   ["P1 Up"]=false,
   ["Test"]=false,
   ["Dip 1"]=0,
   ["P1 Left"]=false,
   ["System"]=159,
   ["Reset"]=false,
   ["P2 Button B"]=false,
   ["P1 Select"]=false,
   ["P2 Button C"]=false,
   ["P1 Button D"]=false,
   ["P2 Select"]=false,
   ["P1 Button B"]=false,
},
-- Table: {149}
{
   ["serial"]={492},
},
-- Table: {150}
{
   ["serial"]={493},
},
-- Table: {151}
{
   ["serial"]={494},
},
-- Table: {152}
{
   ["serial"]={495},
},
-- Table: {153}
{
   ["serial"]={496},
},
-- Table: {154}
{
   ["serial"]={497},
},
-- Table: {155}
{
   ["serial"]={498},
},
-- Table: {156}
{
   ["serial"]={499},
},
-- Table: {157}
{
   ["serial"]={500},
},
-- Table: {158}
{
   ["serial"]={501},
},
-- Table: {159}
{
   ["serial"]={502},
},
-- Table: {160}
{
   ["serial"]={503},
},
-- Table: {161}
{
   ["serial"]={504},
},
-- Table: {162}
{
   ["serial"]={505},
},
-- Table: {163}
{
   ["serial"]={506},
},
-- Table: {164}
{
   ["serial"]={507},
},
-- Table: {165}
{
   ["serial"]={508},
},
-- Table: {166}
{
   ["serial"]={509},
},
-- Table: {167}
{
   ["serial"]={510},
},
-- Table: {168}
{
   ["serial"]={511},
},
-- Table: {169}
{
   ["serial"]={512},
},
-- Table: {170}
{
   ["serial"]={513},
},
-- Table: {171}
{
   ["serial"]={514},
},
-- Table: {172}
{
   ["serial"]={515},
},
-- Table: {173}
{
   ["serial"]={516},
},
-- Table: {174}
{
   ["serial"]={517},
},
-- Table: {175}
{
   ["serial"]={518},
},
-- Table: {176}
{
   ["serial"]={519},
},
-- Table: {177}
{
   ["serial"]={520},
},
-- Table: {178}
{
   ["serial"]={521},
},
-- Table: {179}
{
   ["serial"]={522},
},
-- Table: {180}
{
   ["serial"]={523},
},
-- Table: {181}
{
   ["serial"]={524},
},
-- Table: {182}
{
   ["serial"]={525},
},
-- Table: {183}
{
   ["serial"]={526},
},
-- Table: {184}
{
   ["serial"]={527},
},
-- Table: {185}
{
   ["serial"]={528},
},
-- Table: {186}
{
   ["serial"]={529},
},
-- Table: {187}
{
   ["serial"]={530},
},
-- Table: {188}
{
   ["serial"]={531},
},
-- Table: {189}
{
   ["serial"]={532},
},
-- Table: {190}
{
   ["serial"]={533},
},
-- Table: {191}
{
   ["serial"]={534},
},
-- Table: {192}
{
   ["serial"]={535},
},
-- Table: {193}
{
   ["serial"]={536},
},
-- Table: {194}
{
   ["serial"]={537},
},
-- Table: {195}
{
   ["serial"]={538},
},
-- Table: {196}
{
   ["serial"]={539},
},
-- Table: {197}
{
   ["serial"]={540},
},
-- Table: {198}
{
   ["serial"]={541},
},
-- Table: {199}
{
   ["serial"]={542},
},
-- Table: {200}
{
   ["serial"]={543},
},
-- Table: {201}
{
   ["serial"]={544},
},
-- Table: {202}
{
   ["serial"]={545},
},
-- Table: {203}
{
   ["serial"]={546},
},
-- Table: {204}
{
   ["serial"]={547},
},
-- Table: {205}
{
   ["serial"]={548},
},
-- Table: {206}
{
   ["serial"]={549},
},
-- Table: {207}
{
   ["serial"]={550},
},
-- Table: {208}
{
   ["serial"]={551},
},
-- Table: {209}
{
   ["serial"]={552},
},
-- Table: {210}
{
   ["serial"]={553},
},
-- Table: {211}
{
   ["serial"]={554},
},
-- Table: {212}
{
   ["serial"]={555},
},
-- Table: {213}
{
   ["serial"]={556},
},
-- Table: {214}
{
   ["serial"]={557},
},
-- Table: {215}
{
   ["serial"]={558},
},
-- Table: {216}
{
   ["serial"]={559},
},
-- Table: {217}
{
   ["serial"]={560},
},
-- Table: {218}
{
   ["serial"]={561},
},
-- Table: {219}
{
   ["serial"]={562},
},
-- Table: {220}
{
   ["serial"]={563},
},
-- Table: {221}
{
   ["serial"]={564},
},
-- Table: {222}
{
   ["serial"]={565},
},
-- Table: {223}
{
   ["serial"]={566},
},
-- Table: {224}
{
   ["serial"]={567},
},
-- Table: {225}
{
   ["serial"]={568},
},
-- Table: {226}
{
   ["serial"]={569},
},
-- Table: {227}
{
   ["serial"]={570},
},
-- Table: {228}
{
   ["serial"]={571},
},
-- Table: {229}
{
   ["serial"]={572},
},
-- Table: {230}
{
   ["serial"]={573},
},
-- Table: {231}
{
   ["serial"]={574},
},
-- Table: {232}
{
   ["serial"]={575},
},
-- Table: {233}
{
   ["serial"]={576},
},
-- Table: {234}
{
   ["serial"]={577},
},
-- Table: {235}
{
   ["serial"]={578},
},
-- Table: {236}
{
   ["serial"]={579},
},
-- Table: {237}
{
   ["serial"]={580},
},
-- Table: {238}
{
   ["serial"]={581},
},
-- Table: {239}
{
   ["serial"]={582},
},
-- Table: {240}
{
   ["serial"]={583},
},
-- Table: {241}
{
   ["serial"]={584},
},
-- Table: {242}
{
   ["serial"]={585},
},
-- Table: {243}
{
   ["serial"]={586},
},
-- Table: {244}
{
   ["serial"]={587},
},
-- Table: {245}
{
   ["serial"]={588},
},
-- Table: {246}
{
   ["serial"]={589},
},
-- Table: {247}
{
   ["serial"]={590},
},
-- Table: {248}
{
   ["serial"]={591},
},
-- Table: {249}
{
   ["serial"]={592},
},
-- Table: {250}
{
   ["serial"]={593},
},
-- Table: {251}
{
   ["serial"]={594},
},
-- Table: {252}
{
   ["serial"]={595},
},
-- Table: {253}
{
   ["serial"]={596},
},
-- Table: {254}
{
   ["serial"]={597},
},
-- Table: {255}
{
   ["serial"]={598},
},
-- Table: {256}
{
   ["serial"]={599},
},
-- Table: {257}
{
   ["p2"]={600},
   ["p1"]={601},
},
-- Table: {258}
{
   ["P1 Button A"]=false,
   ["P2 Right"]=false,
   ["Debug Dip 2"]=0,
   ["Service"]=false,
   ["Slots"]=1,
   ["P1 Coin"]=false,
   ["P1 Up"]=false,
   ["P1 Select"]=false,
   ["P2 Select"]=false,
   ["P1 Button C"]=false,
   ["P1 Start"]=false,
   ["P1 Right"]=false,
   ["Dip 1"]=0,
   ["P2 Coin"]=false,
   ["Debug Dip 1"]=0,
   ["P1 Left"]=false,
   ["System"]=159,
   ["P2 Start"]=false,
   ["Test"]=false,
   ["Reset"]=false,
   ["P2 Button D"]=false,
   ["P1 Button D"]=false,
   ["P2 Button C"]=false,
   ["P1 Button B"]=false,
},
-- Table: {259}
{
   ["serial"]={602},
},
-- Table: {260}
{
   ["serial"]={603},
},
-- Table: {261}
{
   ["serial"]={604},
},
-- Table: {262}
{
   ["serial"]={605},
},
-- Table: {263}
{
   ["serial"]={606},
},
-- Table: {264}
{
   ["serial"]={607},
},
-- Table: {265}
{
   ["serial"]={608},
},
-- Table: {266}
{
   ["serial"]={609},
},
-- Table: {267}
{
   ["serial"]={610},
},
-- Table: {268}
{
   ["serial"]={611},
},
-- Table: {269}
{
   ["serial"]={612},
},
-- Table: {270}
{
   ["serial"]={613},
},
-- Table: {271}
{
   ["serial"]={614},
},
-- Table: {272}
{
   ["serial"]={615},
},
-- Table: {273}
{
   ["serial"]={616},
},
-- Table: {274}
{
   ["serial"]={617},
},
-- Table: {275}
{
   ["serial"]={618},
},
-- Table: {276}
{
   ["serial"]={619},
},
-- Table: {277}
{
   ["serial"]={620},
},
-- Table: {278}
{
   ["serial"]={621},
},
-- Table: {279}
{
   ["serial"]={622},
},
-- Table: {280}
{
   ["serial"]={623},
},
-- Table: {281}
{
   ["serial"]={624},
},
-- Table: {282}
{
   ["serial"]={625},
},
-- Table: {283}
{
   ["serial"]={626},
},
-- Table: {284}
{
   ["serial"]={627},
},
-- Table: {285}
{
   ["serial"]={628},
},
-- Table: {286}
{
   ["serial"]={629},
},
-- Table: {287}
{
   ["serial"]={630},
},
-- Table: {288}
{
   ["serial"]={631},
},
-- Table: {289}
{
   ["serial"]={632},
},
-- Table: {290}
{
   ["serial"]={633},
},
-- Table: {291}
{
   ["serial"]={634},
},
-- Table: {292}
{
   ["serial"]={635},
},
-- Table: {293}
{
   ["serial"]={636},
},
-- Table: {294}
{
   ["serial"]={637},
},
-- Table: {295}
{
   ["serial"]={638},
},
-- Table: {296}
{
   ["serial"]={639},
},
-- Table: {297}
{
   ["serial"]={640},
},
-- Table: {298}
{
   ["serial"]={641},
},
-- Table: {299}
{
   ["serial"]={642},
},
-- Table: {300}
{
   ["serial"]={643},
},
-- Table: {301}
{
   ["serial"]={644},
},
-- Table: {302}
{
   ["serial"]={645},
},
-- Table: {303}
{
   ["serial"]={646},
},
-- Table: {304}
{
   ["serial"]={647},
},
-- Table: {305}
{
   ["serial"]={648},
},
-- Table: {306}
{
   ["serial"]={649},
},
-- Table: {307}
{
   ["serial"]={650},
},
-- Table: {308}
{
   ["serial"]={651},
},
-- Table: {309}
{
   ["serial"]={652},
},
-- Table: {310}
{
   ["serial"]={653},
},
-- Table: {311}
{
   ["serial"]={654},
},
-- Table: {312}
{
   ["serial"]={655},
},
-- Table: {313}
{
   ["serial"]={656},
},
-- Table: {314}
{
   ["serial"]={657},
},
-- Table: {315}
{
   ["serial"]={658},
},
-- Table: {316}
{
   ["serial"]={659},
},
-- Table: {317}
{
   ["serial"]={660},
},
-- Table: {318}
{
   ["serial"]={661},
},
-- Table: {319}
{
   ["serial"]={662},
},
-- Table: {320}
{
   ["serial"]={663},
},
-- Table: {321}
{
   ["serial"]={664},
},
-- Table: {322}
{
   ["serial"]={665},
},
-- Table: {323}
{
   ["serial"]={666},
},
-- Table: {324}
{
   ["serial"]={667},
},
-- Table: {325}
{
   ["serial"]={668},
},
-- Table: {326}
{
   ["serial"]={669},
},
-- Table: {327}
{
   ["serial"]={670},
},
-- Table: {328}
{
   ["serial"]={671},
},
-- Table: {329}
{
   ["serial"]={672},
},
-- Table: {330}
{
   ["serial"]={673},
},
-- Table: {331}
{
   ["serial"]={674},
},
-- Table: {332}
{
   ["serial"]={675},
},
-- Table: {333}
{
   ["serial"]={676},
},
-- Table: {334}
{
   ["serial"]={677},
},
-- Table: {335}
{
   ["serial"]={678},
},
-- Table: {336}
{
   ["serial"]={679},
},
-- Table: {337}
{
   ["serial"]={680},
},
-- Table: {338}
{
   ["serial"]={681},
},
-- Table: {339}
{
   ["serial"]={682},
},
-- Table: {340}
{
   ["serial"]={683},
},
-- Table: {341}
{
   ["serial"]={684},
},
-- Table: {342}
{
   ["serial"]={685},
},
-- Table: {343}
{
   ["serial"]={686},
},
-- Table: {344}
{
   ["serial"]={687},
},
-- Table: {345}
{
   ["serial"]={688},
},
-- Table: {346}
{
   ["serial"]={689},
},
-- Table: {347}
{
   ["serial"]={690},
},
-- Table: {348}
{
   ["serial"]={691},
},
-- Table: {349}
{
   ["serial"]={692},
},
-- Table: {350}
{
   ["serial"]={693},
},
-- Table: {351}
{
   ["serial"]={694},
},
-- Table: {352}
{
   ["serial"]={695},
},
-- Table: {353}
{
   ["serial"]={696},
},
-- Table: {354}
{
   ["serial"]={697},
},
-- Table: {355}
{
   ["serial"]={698},
},
-- Table: {356}
{
   ["serial"]={699},
},
-- Table: {357}
{
   ["serial"]={700},
},
-- Table: {358}
{
   ["serial"]={701},
},
-- Table: {359}
{
   ["serial"]={702},
},
-- Table: {360}
{
   ["serial"]={703},
},
-- Table: {361}
{
   ["serial"]={704},
},
-- Table: {362}
{
   ["serial"]={705},
},
-- Table: {363}
{
   ["serial"]={706},
},
-- Table: {364}
{
   ["serial"]={707},
},
-- Table: {365}
{
   ["serial"]={708},
},
-- Table: {366}
{
   ["serial"]={709},
},
-- Table: {367}
{
   ["serial"]={710},
},
-- Table: {368}
{
   ["serial"]={711},
},
-- Table: {369}
{
   ["serial"]={712},
},
-- Table: {370}
{
   ["serial"]={713},
},
-- Table: {371}
{
   ["serial"]={714},
},
-- Table: {372}
{
   ["serial"]={715},
},
-- Table: {373}
{
   ["serial"]={716},
},
-- Table: {374}
{
   ["serial"]={717},
},
-- Table: {375}
{
   ["serial"]={718},
},
-- Table: {376}
{
   ["serial"]={719},
},
-- Table: {377}
{
   ["serial"]={720},
},
-- Table: {378}
{
   ["serial"]={721},
},
-- Table: {379}
{
   ["serial"]={722},
},
-- Table: {380}
{
   ["serial"]={723},
},
-- Table: {381}
{
   ["serial"]={724},
},
-- Table: {382}
{
   ["p2"]={725},
   ["p1"]={726},
},
-- Table: {383}
{
   ["P1 Button A"]=false,
   ["P2 Button A"]=false,
   ["P2 Right"]=false,
   ["Debug Dip 2"]=0,
   ["Service"]=false,
   ["Debug Dip 1"]=0,
   ["P1 Coin"]=false,
   ["P1 Button C"]=false,
   ["P2 Button C"]=false,
   ["Dip 1"]=0,
   ["P1 Start"]=false,
   ["P1 Right"]=false,
   ["P1 Up"]=false,
   ["Slots"]=1,
   ["P1 Select"]=false,
   ["P2 Left"]=false,
   ["P1 Left"]=false,
   ["System"]=159,
   ["P2 Select"]=false,
   ["P2 Start"]=false,
   ["Test"]=false,
   ["P2 Button D"]=false,
   ["P1 Button D"]=false,
   ["Reset"]=false,
   ["P1 Button B"]=false,
},
-- Table: {384}
{
   ["RANDOM"]=2,
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {385}
{
   ["RANDOM"]=2,
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {386}
{
   ["enabled"]=true,
   ["savestate_reload_path"]="../savestates/kof98 slot 01.fs",
   ["savestate_reload_slot"]=1,
   ["weight"]=1,
},
-- Table: {387}
{
   ["enabled"]=true,
   ["savestate_reload_path"]="../savestates/kof98 slot 01.fs",
   ["savestate_reload_slot"]=1,
   ["weight"]=1,
},
-- Table: {388}
{
   ["enabled"]=true,
   ["savestate_reload_path"]="../savestates/kof98 slot 01.fs",
   ["savestate_reload_slot"]=1,
   ["weight"]=1,
},
-- Table: {389}
{
   ["enabled"]=false,
   ["savestate_reload_slot"]=-1,
   ["weight"]=1,
},
-- Table: {390}
{
   ["enabled"]=false,
   ["savestate_reload_slot"]=-1,
   ["weight"]=1,
},
-- Table: {391}
{
   ["NEVER"]=1,
   ["NORMAL"]=0,
   ["ALWAYS"]=2,
},
-- Table: {392}
{
   ["ON"]=1,
   ["OFF"]=0,
},
-- Table: {393}
{
   ["P2"]=2,
   ["P1"]=1,
},
-- Table: {394}
{
   ["other"]={727},
   ["player"]=130,
},
-- Table: {395}
{
   ["other"]={728},
   ["player"]=130,
},
-- Table: {396}
{
   ["other"]={729},
   ["player"]=130,
},
-- Table: {397}
{
   ["other"]={730},
   ["player"]=130,
},
-- Table: {398}
{
   ["other"]={731},
   ["player"]=130,
},
-- Table: {399}
{
   ["other"]={732},
   ["player"]=130,
},
-- Table: {400}
{
   ["other"]={733},
   ["player"]=128,
},
-- Table: {401}
{
   ["other"]={734},
   ["player"]=128,
},
-- Table: {402}
{
   ["other"]={735},
   ["player"]=128,
},
-- Table: {403}
{
   ["other"]={736},
   ["player"]=136,
},
-- Table: {404}
{
   ["other"]={737},
   ["player"]=136,
},
-- Table: {405}
{
   ["other"]={738},
   ["player"]=136,
},
-- Table: {406}
{
   ["other"]={739},
   ["player"]=136,
},
-- Table: {407}
{
   ["other"]={740},
   ["player"]=136,
},
-- Table: {408}
{
   ["other"]={741},
   ["player"]=136,
},
-- Table: {409}
{
   ["other"]={742},
   ["player"]=136,
},
-- Table: {410}
{
   ["other"]={743},
   ["player"]=136,
},
-- Table: {411}
{
   ["other"]={744},
   ["player"]=136,
},
-- Table: {412}
{
   ["other"]={745},
   ["player"]=136,
},
-- Table: {413}
{
   ["other"]={746},
   ["player"]=136,
},
-- Table: {414}
{
   ["other"]={747},
   ["player"]=136,
},
-- Table: {415}
{
   ["other"]={748},
   ["player"]=136,
},
-- Table: {416}
{
   ["other"]={749},
   ["player"]=136,
},
-- Table: {417}
{
   ["other"]={750},
   ["player"]=136,
},
-- Table: {418}
{
   ["other"]={751},
   ["player"]=136,
},
-- Table: {419}
{
   ["other"]={752},
   ["player"]=136,
},
-- Table: {420}
{
   ["other"]={753},
   ["player"]=136,
},
-- Table: {421}
{
   ["other"]={754},
   ["player"]=136,
},
-- Table: {422}
{
   ["other"]={755},
   ["player"]=128,
},
-- Table: {423}
{
   ["other"]={756},
   ["player"]=128,
},
-- Table: {424}
{
   ["other"]={757},
   ["player"]=128,
},
-- Table: {425}
{
   ["other"]={758},
   ["player"]=128,
},
-- Table: {426}
{
   ["other"]={759},
   ["player"]=128,
},
-- Table: {427}
{
   ["other"]={760},
   ["player"]=128,
},
-- Table: {428}
{
   ["other"]={761},
   ["player"]=128,
},
-- Table: {429}
{
   ["other"]={762},
   ["player"]=130,
},
-- Table: {430}
{
   ["other"]={763},
   ["player"]=130,
},
-- Table: {431}
{
   ["other"]={764},
   ["player"]=130,
},
-- Table: {432}
{
   ["other"]={765},
   ["player"]=130,
},
-- Table: {433}
{
   ["other"]={766},
   ["player"]=130,
},
-- Table: {434}
{
   ["other"]={767},
   ["player"]=130,
},
-- Table: {435}
{
   ["other"]={768},
   ["player"]=130,
},
-- Table: {436}
{
   ["other"]={769},
   ["player"]=130,
},
-- Table: {437}
{
   ["other"]={770},
   ["player"]=130,
},
-- Table: {438}
{
   ["other"]={771},
   ["player"]=130,
},
-- Table: {439}
{
   ["other"]={772},
   ["player"]=130,
},
-- Table: {440}
{
   ["other"]={773},
   ["player"]=130,
},
-- Table: {441}
{
   ["other"]={774},
   ["player"]=130,
},
-- Table: {442}
{
   ["other"]={775},
   ["player"]=128,
},
-- Table: {443}
{
   ["other"]={776},
   ["player"]=128,
},
-- Table: {444}
{
   ["other"]={777},
   ["player"]=128,
},
-- Table: {445}
{
   ["other"]={778},
   ["player"]=144,
},
-- Table: {446}
{
   ["other"]={779},
   ["player"]=152,
},
-- Table: {447}
{
   ["other"]={780},
   ["player"]=152,
},
-- Table: {448}
{
   ["other"]={781},
   ["player"]=152,
},
-- Table: {449}
{
   ["other"]={782},
   ["player"]=128,
},
-- Table: {450}
{
   ["other"]={783},
   ["player"]=128,
},
-- Table: {451}
{
   ["other"]={784},
   ["player"]=132,
},
-- Table: {452}
{
   ["other"]={785},
   ["player"]=128,
},
-- Table: {453}
{
   ["other"]={786},
   ["player"]=128,
},
-- Table: {454}
{
   ["other"]={787},
   ["player"]=128,
},
-- Table: {455}
{
   ["other"]={788},
   ["player"]=128,
},
-- Table: {456}
{
   ["other"]={789},
   ["player"]=128,
},
-- Table: {457}
{
   ["other"]={790},
   ["player"]=128,
},
-- Table: {458}
{
   ["other"]={791},
   ["player"]=128,
},
-- Table: {459}
{
   ["other"]={792},
   ["player"]=128,
},
-- Table: {460}
{
   ["other"]={793},
   ["player"]=128,
},
-- Table: {461}
{
   ["other"]={794},
   ["player"]=128,
},
-- Table: {462}
{
   ["other"]={795},
   ["player"]=128,
},
-- Table: {463}
{
   ["other"]={796},
   ["player"]=128,
},
-- Table: {464}
{
   ["other"]={797},
   ["player"]=160,
},
-- Table: {465}
{
   ["other"]={798},
   ["player"]=160,
},
-- Table: {466}
{
   ["other"]={799},
   ["player"]=160,
},
-- Table: {467}
{
   ["other"]={800},
   ["player"]=160,
},
-- Table: {468}
{
   ["other"]={801},
   ["player"]=160,
},
-- Table: {469}
{
   ["other"]={802},
   ["player"]=160,
},
-- Table: {470}
{
   ["other"]={803},
   ["player"]=160,
},
-- Table: {471}
{
   ["other"]={804},
   ["player"]=160,
},
-- Table: {472}
{
   ["other"]={805},
   ["player"]=128,
},
-- Table: {473}
{
   ["other"]={806},
   ["player"]=128,
},
-- Table: {474}
{
   ["other"]={807},
   ["player"]=128,
},
-- Table: {475}
{
   ["other"]={808},
   ["player"]=128,
},
-- Table: {476}
{
   ["other"]={809},
   ["player"]=128,
},
-- Table: {477}
{
   ["other"]={810},
   ["player"]=128,
},
-- Table: {478}
{
   ["other"]={811},
   ["player"]=128,
},
-- Table: {479}
{
   ["other"]={812},
   ["player"]=128,
},
-- Table: {480}
{
   ["other"]={813},
   ["player"]=128,
},
-- Table: {481}
{
   ["other"]={814},
   ["player"]=128,
},
-- Table: {482}
{
   ["other"]={815},
   ["player"]=128,
},
-- Table: {483}
{
   ["other"]={816},
   ["player"]=128,
},
-- Table: {484}
{
   ["other"]={817},
   ["player"]=128,
},
-- Table: {485}
{
   ["other"]={818},
   ["player"]=128,
},
-- Table: {486}
{
   ["other"]={819},
   ["player"]=128,
},
-- Table: {487}
{
   ["other"]={820},
   ["player"]=128,
},
-- Table: {488}
{
   ["other"]={821},
   ["player"]=128,
},
-- Table: {489}
{
   ["other"]={822},
   ["player"]=128,
},
-- Table: {490}
{
   "Down",
   "Right",
   "Up",
   "Left",
   "Button D",
   ["Up"]=3,
   ["Right"]=2,
   ["Left"]=4,
   ["Button D"]=5,
   ["Down"]=1,
   ["len"]=5,
},
-- Table: {491}
{
   "Down",
   ["Down"]=1,
   ["len"]=1,
},
-- Table: {492}
{
   ["other"]={823},
   ["player"]=132,
},
-- Table: {493}
{
   ["other"]={824},
   ["player"]=132,
},
-- Table: {494}
{
   ["other"]={825},
   ["player"]=132,
},
-- Table: {495}
{
   ["other"]={826},
   ["player"]=128,
},
-- Table: {496}
{
   ["other"]={827},
   ["player"]=128,
},
-- Table: {497}
{
   ["other"]={828},
   ["player"]=128,
},
-- Table: {498}
{
   ["other"]={829},
   ["player"]=136,
},
-- Table: {499}
{
   ["other"]={830},
   ["player"]=136,
},
-- Table: {500}
{
   ["other"]={831},
   ["player"]=136,
},
-- Table: {501}
{
   ["other"]={832},
   ["player"]=136,
},
-- Table: {502}
{
   ["other"]={833},
   ["player"]=136,
},
-- Table: {503}
{
   ["other"]={834},
   ["player"]=136,
},
-- Table: {504}
{
   ["other"]={835},
   ["player"]=136,
},
-- Table: {505}
{
   ["other"]={836},
   ["player"]=136,
},
-- Table: {506}
{
   ["other"]={837},
   ["player"]=136,
},
-- Table: {507}
{
   ["other"]={838},
   ["player"]=136,
},
-- Table: {508}
{
   ["other"]={839},
   ["player"]=136,
},
-- Table: {509}
{
   ["other"]={840},
   ["player"]=136,
},
-- Table: {510}
{
   ["other"]={841},
   ["player"]=136,
},
-- Table: {511}
{
   ["other"]={842},
   ["player"]=136,
},
-- Table: {512}
{
   ["other"]={843},
   ["player"]=136,
},
-- Table: {513}
{
   ["other"]={844},
   ["player"]=128,
},
-- Table: {514}
{
   ["other"]={845},
   ["player"]=128,
},
-- Table: {515}
{
   ["other"]={846},
   ["player"]=128,
},
-- Table: {516}
{
   ["other"]={847},
   ["player"]=128,
},
-- Table: {517}
{
   ["other"]={848},
   ["player"]=128,
},
-- Table: {518}
{
   ["other"]={849},
   ["player"]=128,
},
-- Table: {519}
{
   ["other"]={850},
   ["player"]=128,
},
-- Table: {520}
{
   ["other"]={851},
   ["player"]=128,
},
-- Table: {521}
{
   ["other"]={852},
   ["player"]=128,
},
-- Table: {522}
{
   ["other"]={853},
   ["player"]=132,
},
-- Table: {523}
{
   ["other"]={854},
   ["player"]=132,
},
-- Table: {524}
{
   ["other"]={855},
   ["player"]=132,
},
-- Table: {525}
{
   ["other"]={856},
   ["player"]=132,
},
-- Table: {526}
{
   ["other"]={857},
   ["player"]=132,
},
-- Table: {527}
{
   ["other"]={858},
   ["player"]=132,
},
-- Table: {528}
{
   ["other"]={859},
   ["player"]=132,
},
-- Table: {529}
{
   ["other"]={860},
   ["player"]=132,
},
-- Table: {530}
{
   ["other"]={861},
   ["player"]=132,
},
-- Table: {531}
{
   ["other"]={862},
   ["player"]=132,
},
-- Table: {532}
{
   ["other"]={863},
   ["player"]=128,
},
-- Table: {533}
{
   ["other"]={864},
   ["player"]=144,
},
-- Table: {534}
{
   ["other"]={865},
   ["player"]=144,
},
-- Table: {535}
{
   ["other"]={866},
   ["player"]=144,
},
-- Table: {536}
{
   ["other"]={867},
   ["player"]=144,
},
-- Table: {537}
{
   ["other"]={868},
   ["player"]=144,
},
-- Table: {538}
{
   ["other"]={869},
   ["player"]=144,
},
-- Table: {539}
{
   ["other"]={870},
   ["player"]=144,
},
-- Table: {540}
{
   ["other"]={871},
   ["player"]=128,
},
-- Table: {541}
{
   ["other"]={872},
   ["player"]=128,
},
-- Table: {542}
{
   ["other"]={873},
   ["player"]=128,
},
-- Table: {543}
{
   ["other"]={874},
   ["player"]=128,
},
-- Table: {544}
{
   ["other"]={875},
   ["player"]=144,
},
-- Table: {545}
{
   ["other"]={876},
   ["player"]=144,
},
-- Table: {546}
{
   ["other"]={877},
   ["player"]=144,
},
-- Table: {547}
{
   ["other"]={878},
   ["player"]=144,
},
-- Table: {548}
{
   ["other"]={879},
   ["player"]=144,
},
-- Table: {549}
{
   ["other"]={880},
   ["player"]=144,
},
-- Table: {550}
{
   ["other"]={881},
   ["player"]=144,
},
-- Table: {551}
{
   ["other"]={882},
   ["player"]=144,
},
-- Table: {552}
{
   ["other"]={883},
   ["player"]=144,
},
-- Table: {553}
{
   ["other"]={884},
   ["player"]=144,
},
-- Table: {554}
{
   ["other"]={885},
   ["player"]=148,
},
-- Table: {555}
{
   ["other"]={886},
   ["player"]=148,
},
-- Table: {556}
{
   ["other"]={887},
   ["player"]=148,
},
-- Table: {557}
{
   ["other"]={888},
   ["player"]=148,
},
-- Table: {558}
{
   ["other"]={889},
   ["player"]=180,
},
-- Table: {559}
{
   ["other"]={890},
   ["player"]=180,
},
-- Table: {560}
{
   ["other"]={891},
   ["player"]=180,
},
-- Table: {561}
{
   ["other"]={892},
   ["player"]=180,
},
-- Table: {562}
{
   ["other"]={893},
   ["player"]=180,
},
-- Table: {563}
{
   ["other"]={894},
   ["player"]=180,
},
-- Table: {564}
{
   ["other"]={895},
   ["player"]=180,
},
-- Table: {565}
{
   ["other"]={896},
   ["player"]=180,
},
-- Table: {566}
{
   ["other"]={897},
   ["player"]=148,
},
-- Table: {567}
{
   ["other"]={898},
   ["player"]=148,
},
-- Table: {568}
{
   ["other"]={899},
   ["player"]=148,
},
-- Table: {569}
{
   ["other"]={900},
   ["player"]=148,
},
-- Table: {570}
{
   ["other"]={901},
   ["player"]=148,
},
-- Table: {571}
{
   ["other"]={902},
   ["player"]=148,
},
-- Table: {572}
{
   ["other"]={903},
   ["player"]=148,
},
-- Table: {573}
{
   ["other"]={904},
   ["player"]=148,
},
-- Table: {574}
{
   ["other"]={905},
   ["player"]=148,
},
-- Table: {575}
{
   ["other"]={906},
   ["player"]=148,
},
-- Table: {576}
{
   ["other"]={907},
   ["player"]=148,
},
-- Table: {577}
{
   ["other"]={908},
   ["player"]=148,
},
-- Table: {578}
{
   ["other"]={909},
   ["player"]=148,
},
-- Table: {579}
{
   ["other"]={910},
   ["player"]=150,
},
-- Table: {580}
{
   ["other"]={911},
   ["player"]=150,
},
-- Table: {581}
{
   ["other"]={912},
   ["player"]=150,
},
-- Table: {582}
{
   ["other"]={913},
   ["player"]=150,
},
-- Table: {583}
{
   ["other"]={914},
   ["player"]=150,
},
-- Table: {584}
{
   ["other"]={915},
   ["player"]=148,
},
-- Table: {585}
{
   ["other"]={916},
   ["player"]=148,
},
-- Table: {586}
{
   ["other"]={917},
   ["player"]=148,
},
-- Table: {587}
{
   ["other"]={918},
   ["player"]=148,
},
-- Table: {588}
{
   ["other"]={919},
   ["player"]=148,
},
-- Table: {589}
{
   ["other"]={920},
   ["player"]=148,
},
-- Table: {590}
{
   ["other"]={921},
   ["player"]=144,
},
-- Table: {591}
{
   ["other"]={922},
   ["player"]=128,
},
-- Table: {592}
{
   ["other"]={923},
   ["player"]=128,
},
-- Table: {593}
{
   ["other"]={924},
   ["player"]=128,
},
-- Table: {594}
{
   ["other"]={925},
   ["player"]=128,
},
-- Table: {595}
{
   ["other"]={926},
   ["player"]=128,
},
-- Table: {596}
{
   ["other"]={927},
   ["player"]=128,
},
-- Table: {597}
{
   ["other"]={928},
   ["player"]=128,
},
-- Table: {598}
{
   ["other"]={929},
   ["player"]=128,
},
-- Table: {599}
{
   ["other"]={930},
   ["player"]=128,
},
-- Table: {600}
{
   "Button A",
   "Down",
   "Up",
   "Left",
   "Button B",
   ["Button B"]=5,
   ["Up"]=3,
   ["Left"]=4,
   ["Button A"]=1,
   ["Down"]=2,
   ["len"]=5,
},
-- Table: {601}
{
   "Down",
   ["Down"]=1,
   ["len"]=1,
},
-- Table: {602}
{
   ["other"]={931},
   ["player"]=68,
},
-- Table: {603}
{
   ["other"]={932},
   ["player"]=68,
},
-- Table: {604}
{
   ["other"]={933},
   ["player"]=68,
},
-- Table: {605}
{
   ["other"]={934},
   ["player"]=68,
},
-- Table: {606}
{
   ["other"]={935},
   ["player"]=64,
},
-- Table: {607}
{
   ["other"]={936},
   ["player"]=64,
},
-- Table: {608}
{
   ["other"]={937},
   ["player"]=72,
},
-- Table: {609}
{
   ["other"]={938},
   ["player"]=72,
},
-- Table: {610}
{
   ["other"]={939},
   ["player"]=72,
},
-- Table: {611}
{
   ["other"]={940},
   ["player"]=72,
},
-- Table: {612}
{
   ["other"]={941},
   ["player"]=72,
},
-- Table: {613}
{
   ["other"]={942},
   ["player"]=72,
},
-- Table: {614}
{
   ["other"]={943},
   ["player"]=72,
},
-- Table: {615}
{
   ["other"]={944},
   ["player"]=72,
},
-- Table: {616}
{
   ["other"]={945},
   ["player"]=72,
},
-- Table: {617}
{
   ["other"]={946},
   ["player"]=72,
},
-- Table: {618}
{
   ["other"]={947},
   ["player"]=72,
},
-- Table: {619}
{
   ["other"]={948},
   ["player"]=72,
},
-- Table: {620}
{
   ["other"]={949},
   ["player"]=72,
},
-- Table: {621}
{
   ["other"]={950},
   ["player"]=72,
},
-- Table: {622}
{
   ["other"]={951},
   ["player"]=72,
},
-- Table: {623}
{
   ["other"]={952},
   ["player"]=72,
},
-- Table: {624}
{
   ["other"]={953},
   ["player"]=72,
},
-- Table: {625}
{
   ["other"]={954},
   ["player"]=72,
},
-- Table: {626}
{
   ["other"]={955},
   ["player"]=72,
},
-- Table: {627}
{
   ["other"]={956},
   ["player"]=72,
},
-- Table: {628}
{
   ["other"]={957},
   ["player"]=72,
},
-- Table: {629}
{
   ["other"]={958},
   ["player"]=72,
},
-- Table: {630}
{
   ["other"]={959},
   ["player"]=72,
},
-- Table: {631}
{
   ["other"]={960},
   ["player"]=64,
},
-- Table: {632}
{
   ["other"]={961},
   ["player"]=64,
},
-- Table: {633}
{
   ["other"]={962},
   ["player"]=64,
},
-- Table: {634}
{
   ["other"]={963},
   ["player"]=64,
},
-- Table: {635}
{
   ["other"]={964},
   ["player"]=64,
},
-- Table: {636}
{
   ["other"]={965},
   ["player"]=64,
},
-- Table: {637}
{
   ["other"]={966},
   ["player"]=68,
},
-- Table: {638}
{
   ["other"]={967},
   ["player"]=68,
},
-- Table: {639}
{
   ["other"]={968},
   ["player"]=68,
},
-- Table: {640}
{
   ["other"]={969},
   ["player"]=68,
},
-- Table: {641}
{
   ["other"]={970},
   ["player"]=68,
},
-- Table: {642}
{
   ["other"]={971},
   ["player"]=68,
},
-- Table: {643}
{
   ["other"]={972},
   ["player"]=68,
},
-- Table: {644}
{
   ["other"]={973},
   ["player"]=68,
},
-- Table: {645}
{
   ["other"]={974},
   ["player"]=68,
},
-- Table: {646}
{
   ["other"]={975},
   ["player"]=68,
},
-- Table: {647}
{
   ["other"]={976},
   ["player"]=68,
},
-- Table: {648}
{
   ["other"]={977},
   ["player"]=68,
},
-- Table: {649}
{
   ["other"]={978},
   ["player"]=68,
},
-- Table: {650}
{
   ["other"]={979},
   ["player"]=68,
},
-- Table: {651}
{
   ["other"]={980},
   ["player"]=68,
},
-- Table: {652}
{
   ["other"]={981},
   ["player"]=68,
},
-- Table: {653}
{
   ["other"]={982},
   ["player"]=68,
},
-- Table: {654}
{
   ["other"]={983},
   ["player"]=68,
},
-- Table: {655}
{
   ["other"]={984},
   ["player"]=68,
},
-- Table: {656}
{
   ["other"]={985},
   ["player"]=68,
},
-- Table: {657}
{
   ["other"]={986},
   ["player"]=68,
},
-- Table: {658}
{
   ["other"]={987},
   ["player"]=68,
},
-- Table: {659}
{
   ["other"]={988},
   ["player"]=68,
},
-- Table: {660}
{
   ["other"]={989},
   ["player"]=68,
},
-- Table: {661}
{
   ["other"]={990},
   ["player"]=68,
},
-- Table: {662}
{
   ["other"]={991},
   ["player"]=68,
},
-- Table: {663}
{
   ["other"]={992},
   ["player"]=68,
},
-- Table: {664}
{
   ["other"]={993},
   ["player"]=68,
},
-- Table: {665}
{
   ["other"]={994},
   ["player"]=68,
},
-- Table: {666}
{
   ["other"]={995},
   ["player"]=68,
},
-- Table: {667}
{
   ["other"]={996},
   ["player"]=68,
},
-- Table: {668}
{
   ["other"]={997},
   ["player"]=68,
},
-- Table: {669}
{
   ["other"]={998},
   ["player"]=68,
},
-- Table: {670}
{
   ["other"]={999},
   ["player"]=68,
},
-- Table: {671}
{
   ["other"]={1000},
   ["player"]=68,
},
-- Table: {672}
{
   ["other"]={1001},
   ["player"]=68,
},
-- Table: {673}
{
   ["other"]={1002},
   ["player"]=68,
},
-- Table: {674}
{
   ["other"]={1003},
   ["player"]=68,
},
-- Table: {675}
{
   ["other"]={1004},
   ["player"]=68,
},
-- Table: {676}
{
   ["other"]={1005},
   ["player"]=68,
},
-- Table: {677}
{
   ["other"]={1006},
   ["player"]=68,
},
-- Table: {678}
{
   ["other"]={1007},
   ["player"]=68,
},
-- Table: {679}
{
   ["other"]={1008},
   ["player"]=68,
},
-- Table: {680}
{
   ["other"]={1009},
   ["player"]=68,
},
-- Table: {681}
{
   ["other"]={1010},
   ["player"]=68,
},
-- Table: {682}
{
   ["other"]={1011},
   ["player"]=68,
},
-- Table: {683}
{
   ["other"]={1012},
   ["player"]=68,
},
-- Table: {684}
{
   ["other"]={1013},
   ["player"]=68,
},
-- Table: {685}
{
   ["other"]={1014},
   ["player"]=68,
},
-- Table: {686}
{
   ["other"]={1015},
   ["player"]=68,
},
-- Table: {687}
{
   ["other"]={1016},
   ["player"]=68,
},
-- Table: {688}
{
   ["other"]={1017},
   ["player"]=68,
},
-- Table: {689}
{
   ["other"]={1018},
   ["player"]=68,
},
-- Table: {690}
{
   ["other"]={1019},
   ["player"]=84,
},
-- Table: {691}
{
   ["other"]={1020},
   ["player"]=84,
},
-- Table: {692}
{
   ["other"]={1021},
   ["player"]=84,
},
-- Table: {693}
{
   ["other"]={1022},
   ["player"]=84,
},
-- Table: {694}
{
   ["other"]={1023},
   ["player"]=84,
},
-- Table: {695}
{
   ["other"]={1024},
   ["player"]=84,
},
-- Table: {696}
{
   ["other"]={1025},
   ["player"]=84,
},
-- Table: {697}
{
   ["other"]={1026},
   ["player"]=84,
},
-- Table: {698}
{
   ["other"]={1027},
   ["player"]=84,
},
-- Table: {699}
{
   ["other"]={1028},
   ["player"]=84,
},
-- Table: {700}
{
   ["other"]={1029},
   ["player"]=84,
},
-- Table: {701}
{
   ["other"]={1030},
   ["player"]=68,
},
-- Table: {702}
{
   ["other"]={1031},
   ["player"]=68,
},
-- Table: {703}
{
   ["other"]={1032},
   ["player"]=68,
},
-- Table: {704}
{
   ["other"]={1033},
   ["player"]=68,
},
-- Table: {705}
{
   ["other"]={1034},
   ["player"]=68,
},
-- Table: {706}
{
   ["other"]={1035},
   ["player"]=68,
},
-- Table: {707}
{
   ["other"]={1036},
   ["player"]=68,
},
-- Table: {708}
{
   ["other"]={1037},
   ["player"]=68,
},
-- Table: {709}
{
   ["other"]={1038},
   ["player"]=68,
},
-- Table: {710}
{
   ["other"]={1039},
   ["player"]=68,
},
-- Table: {711}
{
   ["other"]={1040},
   ["player"]=68,
},
-- Table: {712}
{
   ["other"]={1041},
   ["player"]=68,
},
-- Table: {713}
{
   ["other"]={1042},
   ["player"]=68,
},
-- Table: {714}
{
   ["other"]={1043},
   ["player"]=68,
},
-- Table: {715}
{
   ["other"]={1044},
   ["player"]=68,
},
-- Table: {716}
{
   ["other"]={1045},
   ["player"]=68,
},
-- Table: {717}
{
   ["other"]={1046},
   ["player"]=68,
},
-- Table: {718}
{
   ["other"]={1047},
   ["player"]=68,
},
-- Table: {719}
{
   ["other"]={1048},
   ["player"]=68,
},
-- Table: {720}
{
   ["other"]={1049},
   ["player"]=68,
},
-- Table: {721}
{
   ["other"]={1050},
   ["player"]=68,
},
-- Table: {722}
{
   ["other"]={1051},
   ["player"]=68,
},
-- Table: {723}
{
   ["other"]={1052},
   ["player"]=68,
},
-- Table: {724}
{
   ["other"]={1053},
   ["player"]=68,
},
-- Table: {725}
{
   "Coin",
   "Down",
   "Up",
   "Button B",
   ["Button B"]=4,
   ["Coin"]=1,
   ["Up"]=3,
   ["Down"]=2,
   ["len"]=4,
},
-- Table: {726}
{
   "Down",
   ["Down"]=1,
   ["len"]=1,
},
-- Table: {727}
{
   ["Dip 2"]=0,
},
-- Table: {728}
{
   ["Dip 2"]=0,
},
-- Table: {729}
{
   ["Dip 2"]=0,
},
-- Table: {730}
{
   ["Dip 2"]=0,
},
-- Table: {731}
{
   ["Dip 2"]=0,
},
-- Table: {732}
{
   ["Dip 2"]=0,
},
-- Table: {733}
{
   ["Dip 2"]=0,
},
-- Table: {734}
{
   ["Dip 2"]=0,
},
-- Table: {735}
{
   ["Dip 2"]=0,
},
-- Table: {736}
{
   ["Dip 2"]=0,
},
-- Table: {737}
{
   ["Dip 2"]=0,
},
-- Table: {738}
{
   ["Dip 2"]=0,
},
-- Table: {739}
{
   ["Dip 2"]=0,
},
-- Table: {740}
{
   ["Dip 2"]=0,
},
-- Table: {741}
{
   ["Dip 2"]=0,
},
-- Table: {742}
{
   ["Dip 2"]=0,
},
-- Table: {743}
{
   ["Dip 2"]=0,
},
-- Table: {744}
{
   ["Dip 2"]=0,
},
-- Table: {745}
{
   ["Dip 2"]=0,
},
-- Table: {746}
{
   ["Dip 2"]=0,
},
-- Table: {747}
{
   ["Dip 2"]=0,
},
-- Table: {748}
{
   ["Dip 2"]=0,
},
-- Table: {749}
{
   ["Dip 2"]=0,
},
-- Table: {750}
{
   ["Dip 2"]=0,
},
-- Table: {751}
{
   ["Dip 2"]=0,
},
-- Table: {752}
{
   ["Dip 2"]=0,
},
-- Table: {753}
{
   ["Dip 2"]=0,
},
-- Table: {754}
{
   ["Dip 2"]=0,
},
-- Table: {755}
{
   ["Dip 2"]=0,
},
-- Table: {756}
{
   ["Dip 2"]=0,
},
-- Table: {757}
{
   ["Dip 2"]=0,
},
-- Table: {758}
{
   ["Dip 2"]=0,
},
-- Table: {759}
{
   ["Dip 2"]=0,
},
-- Table: {760}
{
   ["Dip 2"]=0,
},
-- Table: {761}
{
   ["Dip 2"]=0,
},
-- Table: {762}
{
   ["Dip 2"]=0,
},
-- Table: {763}
{
   ["Dip 2"]=0,
},
-- Table: {764}
{
   ["Dip 2"]=0,
},
-- Table: {765}
{
   ["Dip 2"]=0,
},
-- Table: {766}
{
   ["Dip 2"]=0,
},
-- Table: {767}
{
   ["Dip 2"]=0,
},
-- Table: {768}
{
   ["Dip 2"]=0,
},
-- Table: {769}
{
   ["Dip 2"]=0,
},
-- Table: {770}
{
   ["Dip 2"]=0,
},
-- Table: {771}
{
   ["Dip 2"]=0,
},
-- Table: {772}
{
   ["Dip 2"]=0,
},
-- Table: {773}
{
   ["Dip 2"]=0,
},
-- Table: {774}
{
   ["Dip 2"]=0,
},
-- Table: {775}
{
   ["Dip 2"]=0,
},
-- Table: {776}
{
   ["Dip 2"]=0,
},
-- Table: {777}
{
   ["Dip 2"]=0,
},
-- Table: {778}
{
   ["Dip 2"]=0,
},
-- Table: {779}
{
   ["Dip 2"]=0,
},
-- Table: {780}
{
   ["Dip 2"]=0,
},
-- Table: {781}
{
   ["Dip 2"]=0,
},
-- Table: {782}
{
   ["Dip 2"]=0,
},
-- Table: {783}
{
   ["Dip 2"]=0,
},
-- Table: {784}
{
   ["Dip 2"]=0,
},
-- Table: {785}
{
   ["Dip 2"]=0,
},
-- Table: {786}
{
   ["Dip 2"]=0,
},
-- Table: {787}
{
   ["Dip 2"]=0,
},
-- Table: {788}
{
   ["Dip 2"]=0,
},
-- Table: {789}
{
   ["Dip 2"]=0,
},
-- Table: {790}
{
   ["Dip 2"]=0,
},
-- Table: {791}
{
   ["Dip 2"]=0,
},
-- Table: {792}
{
   ["Dip 2"]=0,
},
-- Table: {793}
{
   ["Dip 2"]=0,
},
-- Table: {794}
{
   ["Dip 2"]=0,
},
-- Table: {795}
{
   ["Dip 2"]=0,
},
-- Table: {796}
{
   ["Dip 2"]=0,
},
-- Table: {797}
{
   ["Dip 2"]=0,
},
-- Table: {798}
{
   ["Dip 2"]=0,
},
-- Table: {799}
{
   ["Dip 2"]=0,
},
-- Table: {800}
{
   ["Dip 2"]=0,
},
-- Table: {801}
{
   ["Dip 2"]=0,
},
-- Table: {802}
{
   ["Dip 2"]=0,
},
-- Table: {803}
{
   ["Dip 2"]=0,
},
-- Table: {804}
{
   ["Dip 2"]=0,
},
-- Table: {805}
{
   ["Dip 2"]=0,
},
-- Table: {806}
{
   ["Dip 2"]=0,
},
-- Table: {807}
{
   ["Dip 2"]=0,
},
-- Table: {808}
{
   ["Dip 2"]=0,
},
-- Table: {809}
{
   ["Dip 2"]=0,
},
-- Table: {810}
{
   ["Dip 2"]=0,
},
-- Table: {811}
{
   ["Dip 2"]=0,
},
-- Table: {812}
{
   ["Dip 2"]=0,
},
-- Table: {813}
{
   ["Dip 2"]=0,
},
-- Table: {814}
{
   ["Dip 2"]=0,
},
-- Table: {815}
{
   ["Dip 2"]=0,
},
-- Table: {816}
{
   ["Dip 2"]=0,
},
-- Table: {817}
{
   ["Dip 2"]=0,
},
-- Table: {818}
{
   ["Dip 2"]=0,
},
-- Table: {819}
{
   ["Dip 2"]=0,
},
-- Table: {820}
{
   ["Dip 2"]=0,
},
-- Table: {821}
{
   ["Dip 2"]=0,
},
-- Table: {822}
{
   ["Dip 2"]=0,
},
-- Table: {823}
{
   ["Dip 2"]=0,
},
-- Table: {824}
{
   ["Dip 2"]=0,
},
-- Table: {825}
{
   ["Dip 2"]=0,
},
-- Table: {826}
{
   ["Dip 2"]=0,
},
-- Table: {827}
{
   ["Dip 2"]=0,
},
-- Table: {828}
{
   ["Dip 2"]=0,
},
-- Table: {829}
{
   ["Dip 2"]=0,
},
-- Table: {830}
{
   ["Dip 2"]=0,
},
-- Table: {831}
{
   ["Dip 2"]=0,
},
-- Table: {832}
{
   ["Dip 2"]=0,
},
-- Table: {833}
{
   ["Dip 2"]=0,
},
-- Table: {834}
{
   ["Dip 2"]=0,
},
-- Table: {835}
{
   ["Dip 2"]=0,
},
-- Table: {836}
{
   ["Dip 2"]=0,
},
-- Table: {837}
{
   ["Dip 2"]=0,
},
-- Table: {838}
{
   ["Dip 2"]=0,
},
-- Table: {839}
{
   ["Dip 2"]=0,
},
-- Table: {840}
{
   ["Dip 2"]=0,
},
-- Table: {841}
{
   ["Dip 2"]=0,
},
-- Table: {842}
{
   ["Dip 2"]=0,
},
-- Table: {843}
{
   ["Dip 2"]=0,
},
-- Table: {844}
{
   ["Dip 2"]=0,
},
-- Table: {845}
{
   ["Dip 2"]=0,
},
-- Table: {846}
{
   ["Dip 2"]=0,
},
-- Table: {847}
{
   ["Dip 2"]=0,
},
-- Table: {848}
{
   ["Dip 2"]=0,
},
-- Table: {849}
{
   ["Dip 2"]=0,
},
-- Table: {850}
{
   ["Dip 2"]=0,
},
-- Table: {851}
{
   ["Dip 2"]=0,
},
-- Table: {852}
{
   ["Dip 2"]=0,
},
-- Table: {853}
{
   ["Dip 2"]=0,
},
-- Table: {854}
{
   ["Dip 2"]=0,
},
-- Table: {855}
{
   ["Dip 2"]=0,
},
-- Table: {856}
{
   ["Dip 2"]=0,
},
-- Table: {857}
{
   ["Dip 2"]=0,
},
-- Table: {858}
{
   ["Dip 2"]=0,
},
-- Table: {859}
{
   ["Dip 2"]=0,
},
-- Table: {860}
{
   ["Dip 2"]=0,
},
-- Table: {861}
{
   ["Dip 2"]=0,
},
-- Table: {862}
{
   ["Dip 2"]=0,
},
-- Table: {863}
{
   ["Dip 2"]=0,
},
-- Table: {864}
{
   ["Dip 2"]=0,
},
-- Table: {865}
{
   ["Dip 2"]=0,
},
-- Table: {866}
{
   ["Dip 2"]=0,
},
-- Table: {867}
{
   ["Dip 2"]=0,
},
-- Table: {868}
{
   ["Dip 2"]=0,
},
-- Table: {869}
{
   ["Dip 2"]=0,
},
-- Table: {870}
{
   ["Dip 2"]=0,
},
-- Table: {871}
{
   ["Dip 2"]=0,
},
-- Table: {872}
{
   ["Dip 2"]=0,
},
-- Table: {873}
{
   ["Dip 2"]=0,
},
-- Table: {874}
{
   ["Dip 2"]=0,
},
-- Table: {875}
{
   ["Dip 2"]=0,
},
-- Table: {876}
{
   ["Dip 2"]=0,
},
-- Table: {877}
{
   ["Dip 2"]=0,
},
-- Table: {878}
{
   ["Dip 2"]=0,
},
-- Table: {879}
{
   ["Dip 2"]=0,
},
-- Table: {880}
{
   ["Dip 2"]=0,
},
-- Table: {881}
{
   ["Dip 2"]=0,
},
-- Table: {882}
{
   ["Dip 2"]=0,
},
-- Table: {883}
{
   ["Dip 2"]=0,
},
-- Table: {884}
{
   ["Dip 2"]=0,
},
-- Table: {885}
{
   ["Dip 2"]=0,
},
-- Table: {886}
{
   ["Dip 2"]=0,
},
-- Table: {887}
{
   ["Dip 2"]=0,
},
-- Table: {888}
{
   ["Dip 2"]=0,
},
-- Table: {889}
{
   ["Dip 2"]=0,
},
-- Table: {890}
{
   ["Dip 2"]=0,
},
-- Table: {891}
{
   ["Dip 2"]=0,
},
-- Table: {892}
{
   ["Dip 2"]=0,
},
-- Table: {893}
{
   ["Dip 2"]=0,
},
-- Table: {894}
{
   ["Dip 2"]=0,
},
-- Table: {895}
{
   ["Dip 2"]=0,
},
-- Table: {896}
{
   ["Dip 2"]=0,
},
-- Table: {897}
{
   ["Dip 2"]=0,
},
-- Table: {898}
{
   ["Dip 2"]=0,
},
-- Table: {899}
{
   ["Dip 2"]=0,
},
-- Table: {900}
{
   ["Dip 2"]=0,
},
-- Table: {901}
{
   ["Dip 2"]=0,
},
-- Table: {902}
{
   ["Dip 2"]=0,
},
-- Table: {903}
{
   ["Dip 2"]=0,
},
-- Table: {904}
{
   ["Dip 2"]=0,
},
-- Table: {905}
{
   ["Dip 2"]=0,
},
-- Table: {906}
{
   ["Dip 2"]=0,
},
-- Table: {907}
{
   ["Dip 2"]=0,
},
-- Table: {908}
{
   ["Dip 2"]=0,
},
-- Table: {909}
{
   ["Dip 2"]=0,
},
-- Table: {910}
{
   ["Dip 2"]=0,
},
-- Table: {911}
{
   ["Dip 2"]=0,
},
-- Table: {912}
{
   ["Dip 2"]=0,
},
-- Table: {913}
{
   ["Dip 2"]=0,
},
-- Table: {914}
{
   ["Dip 2"]=0,
},
-- Table: {915}
{
   ["Dip 2"]=0,
},
-- Table: {916}
{
   ["Dip 2"]=0,
},
-- Table: {917}
{
   ["Dip 2"]=0,
},
-- Table: {918}
{
   ["Dip 2"]=0,
},
-- Table: {919}
{
   ["Dip 2"]=0,
},
-- Table: {920}
{
   ["Dip 2"]=0,
},
-- Table: {921}
{
   ["Dip 2"]=0,
},
-- Table: {922}
{
   ["Dip 2"]=0,
},
-- Table: {923}
{
   ["Dip 2"]=0,
},
-- Table: {924}
{
   ["Dip 2"]=0,
},
-- Table: {925}
{
   ["Dip 2"]=0,
},
-- Table: {926}
{
   ["Dip 2"]=0,
},
-- Table: {927}
{
   ["Dip 2"]=0,
},
-- Table: {928}
{
   ["Dip 2"]=0,
},
-- Table: {929}
{
   ["Dip 2"]=0,
},
-- Table: {930}
{
   ["Dip 2"]=0,
},
-- Table: {931}
{
   ["Dip 2"]=0,
},
-- Table: {932}
{
   ["Dip 2"]=0,
},
-- Table: {933}
{
   ["Dip 2"]=0,
},
-- Table: {934}
{
   ["Dip 2"]=0,
},
-- Table: {935}
{
   ["Dip 2"]=0,
},
-- Table: {936}
{
   ["Dip 2"]=0,
},
-- Table: {937}
{
   ["Dip 2"]=0,
},
-- Table: {938}
{
   ["Dip 2"]=0,
},
-- Table: {939}
{
   ["Dip 2"]=0,
},
-- Table: {940}
{
   ["Dip 2"]=0,
},
-- Table: {941}
{
   ["Dip 2"]=0,
},
-- Table: {942}
{
   ["Dip 2"]=0,
},
-- Table: {943}
{
   ["Dip 2"]=0,
},
-- Table: {944}
{
   ["Dip 2"]=0,
},
-- Table: {945}
{
   ["Dip 2"]=0,
},
-- Table: {946}
{
   ["Dip 2"]=0,
},
-- Table: {947}
{
   ["Dip 2"]=0,
},
-- Table: {948}
{
   ["Dip 2"]=0,
},
-- Table: {949}
{
   ["Dip 2"]=0,
},
-- Table: {950}
{
   ["Dip 2"]=0,
},
-- Table: {951}
{
   ["Dip 2"]=0,
},
-- Table: {952}
{
   ["Dip 2"]=0,
},
-- Table: {953}
{
   ["Dip 2"]=0,
},
-- Table: {954}
{
   ["Dip 2"]=0,
},
-- Table: {955}
{
   ["Dip 2"]=0,
},
-- Table: {956}
{
   ["Dip 2"]=0,
},
-- Table: {957}
{
   ["Dip 2"]=0,
},
-- Table: {958}
{
   ["Dip 2"]=0,
},
-- Table: {959}
{
   ["Dip 2"]=0,
},
-- Table: {960}
{
   ["Dip 2"]=0,
},
-- Table: {961}
{
   ["Dip 2"]=0,
},
-- Table: {962}
{
   ["Dip 2"]=0,
},
-- Table: {963}
{
   ["Dip 2"]=0,
},
-- Table: {964}
{
   ["Dip 2"]=0,
},
-- Table: {965}
{
   ["Dip 2"]=0,
},
-- Table: {966}
{
   ["Dip 2"]=0,
},
-- Table: {967}
{
   ["Dip 2"]=0,
},
-- Table: {968}
{
   ["Dip 2"]=0,
},
-- Table: {969}
{
   ["Dip 2"]=0,
},
-- Table: {970}
{
   ["Dip 2"]=0,
},
-- Table: {971}
{
   ["Dip 2"]=0,
},
-- Table: {972}
{
   ["Dip 2"]=0,
},
-- Table: {973}
{
   ["Dip 2"]=0,
},
-- Table: {974}
{
   ["Dip 2"]=0,
},
-- Table: {975}
{
   ["Dip 2"]=0,
},
-- Table: {976}
{
   ["Dip 2"]=0,
},
-- Table: {977}
{
   ["Dip 2"]=0,
},
-- Table: {978}
{
   ["Dip 2"]=0,
},
-- Table: {979}
{
   ["Dip 2"]=0,
},
-- Table: {980}
{
   ["Dip 2"]=0,
},
-- Table: {981}
{
   ["Dip 2"]=0,
},
-- Table: {982}
{
   ["Dip 2"]=0,
},
-- Table: {983}
{
   ["Dip 2"]=0,
},
-- Table: {984}
{
   ["Dip 2"]=0,
},
-- Table: {985}
{
   ["Dip 2"]=0,
},
-- Table: {986}
{
   ["Dip 2"]=0,
},
-- Table: {987}
{
   ["Dip 2"]=0,
},
-- Table: {988}
{
   ["Dip 2"]=0,
},
-- Table: {989}
{
   ["Dip 2"]=0,
},
-- Table: {990}
{
   ["Dip 2"]=0,
},
-- Table: {991}
{
   ["Dip 2"]=0,
},
-- Table: {992}
{
   ["Dip 2"]=0,
},
-- Table: {993}
{
   ["Dip 2"]=0,
},
-- Table: {994}
{
   ["Dip 2"]=0,
},
-- Table: {995}
{
   ["Dip 2"]=0,
},
-- Table: {996}
{
   ["Dip 2"]=0,
},
-- Table: {997}
{
   ["Dip 2"]=0,
},
-- Table: {998}
{
   ["Dip 2"]=0,
},
-- Table: {999}
{
   ["Dip 2"]=0,
},
-- Table: {1000}
{
   ["Dip 2"]=0,
},
-- Table: {1001}
{
   ["Dip 2"]=0,
},
-- Table: {1002}
{
   ["Dip 2"]=0,
},
-- Table: {1003}
{
   ["Dip 2"]=0,
},
-- Table: {1004}
{
   ["Dip 2"]=0,
},
-- Table: {1005}
{
   ["Dip 2"]=0,
},
-- Table: {1006}
{
   ["Dip 2"]=0,
},
-- Table: {1007}
{
   ["Dip 2"]=0,
},
-- Table: {1008}
{
   ["Dip 2"]=0,
},
-- Table: {1009}
{
   ["Dip 2"]=0,
},
-- Table: {1010}
{
   ["Dip 2"]=0,
},
-- Table: {1011}
{
   ["Dip 2"]=0,
},
-- Table: {1012}
{
   ["Dip 2"]=0,
},
-- Table: {1013}
{
   ["Dip 2"]=0,
},
-- Table: {1014}
{
   ["Dip 2"]=0,
},
-- Table: {1015}
{
   ["Dip 2"]=0,
},
-- Table: {1016}
{
   ["Dip 2"]=0,
},
-- Table: {1017}
{
   ["Dip 2"]=0,
},
-- Table: {1018}
{
   ["Dip 2"]=0,
},
-- Table: {1019}
{
   ["Dip 2"]=0,
},
-- Table: {1020}
{
   ["Dip 2"]=0,
},
-- Table: {1021}
{
   ["Dip 2"]=0,
},
-- Table: {1022}
{
   ["Dip 2"]=0,
},
-- Table: {1023}
{
   ["Dip 2"]=0,
},
-- Table: {1024}
{
   ["Dip 2"]=0,
},
-- Table: {1025}
{
   ["Dip 2"]=0,
},
-- Table: {1026}
{
   ["Dip 2"]=0,
},
-- Table: {1027}
{
   ["Dip 2"]=0,
},
-- Table: {1028}
{
   ["Dip 2"]=0,
},
-- Table: {1029}
{
   ["Dip 2"]=0,
},
-- Table: {1030}
{
   ["Dip 2"]=0,
},
-- Table: {1031}
{
   ["Dip 2"]=0,
},
-- Table: {1032}
{
   ["Dip 2"]=0,
},
-- Table: {1033}
{
   ["Dip 2"]=0,
},
-- Table: {1034}
{
   ["Dip 2"]=0,
},
-- Table: {1035}
{
   ["Dip 2"]=0,
},
-- Table: {1036}
{
   ["Dip 2"]=0,
},
-- Table: {1037}
{
   ["Dip 2"]=0,
},
-- Table: {1038}
{
   ["Dip 2"]=0,
},
-- Table: {1039}
{
   ["Dip 2"]=0,
},
-- Table: {1040}
{
   ["Dip 2"]=0,
},
-- Table: {1041}
{
   ["Dip 2"]=0,
},
-- Table: {1042}
{
   ["Dip 2"]=0,
},
-- Table: {1043}
{
   ["Dip 2"]=0,
},
-- Table: {1044}
{
   ["Dip 2"]=0,
},
-- Table: {1045}
{
   ["Dip 2"]=0,
},
-- Table: {1046}
{
   ["Dip 2"]=0,
},
-- Table: {1047}
{
   ["Dip 2"]=0,
},
-- Table: {1048}
{
   ["Dip 2"]=0,
},
-- Table: {1049}
{
   ["Dip 2"]=0,
},
-- Table: {1050}
{
   ["Dip 2"]=0,
},
-- Table: {1051}
{
   ["Dip 2"]=0,
},
-- Table: {1052}
{
   ["Dip 2"]=0,
},
-- Table: {1053}
{
   ["Dip 2"]=0,
},
}