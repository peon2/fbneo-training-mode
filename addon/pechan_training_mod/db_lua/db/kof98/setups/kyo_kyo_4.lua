assert(rb, "Run fbneo-training-mode.lua")
return {
   -- Table: {1}
   {
      ["title"] = "Safe Jump Training (Test)",
      ["description"] =
      [[This is a long test description to verify the wrapping and boundary logic of the new description box in the Managed Replays menu.

This setup focuses on Kyo's safe jump timing against character-specific reversals. It will cycle through different wake-up options including DP, rolls, and backdashes to ensure your pressure is airtight.

Instructions:
1. Perform a knockdown.
2. Time your jump-in to hit as early as possible.
3. If the dummy blocks, continue your pressure.
4. If the dummy performs a reversal, you should land and block automatically if your timing was correct.

Good luck with your training!]],
      ["wakeup"] = true,
      ["recording_var_states"] = { 2 },
      ["WAKEUP_CONFIG"] = { 3 },
      ["recordings"] = { 4 },
      ["RECOVERY_CONFIG"] = { 5 },
      ["base_name"] = "kyo_kyo_4",
      ["p2"] = { 6 },
      ["guard"] = false,
      ["p1"] = { 7 },
   },
   -- Table: {2}
   {
      { 8 },
      { 9 },
      { 10 },
      { 11 },
      { 12 },
   },
   -- Table: {3}
   {
      ["reversal"] = 2,
      ["REVERSAL_OPTIONS"] = { 13 },
      ["dummy_waking_up"] = true,
      ["reversal_moves"] = { 14 },
   },
   -- Table: {4}
   {
      { 15 },
      { 16 },
      { 17 },
      { 18 },
      { 19 },
   },
   -- Table: {5}
   {
      ["dummy_recovering"] = false,
      ["recovery"] = 0,
      ["times"] = 8,
      ["delay"] = 10,
      ["OPTIONS"] = { 20 },
   },
   -- Table: {6}
   {
      ["name"] = "Kyo Kusanagi",
      ["stored_id"] = 0,
   },
   -- Table: {7}
   {
      ["name"] = "Kyo Kusanagi",
      ["stored_id"] = 0,
   },
   -- Table: {8}
   {
      ["value"] = 0,
      ["propagates"] = false,
   },
   -- Table: {9}
   {
      ["value"] = 1,
      ["propagates"] = false,
   },
   -- Table: {10}
   {
      ["value"] = 1,
      ["propagates"] = false,
   },
   -- Table: {11}
   {
      ["value"] = 0,
   },
   -- Table: {12}
   {
      ["value"] = 0,
   },
   -- Table: {13}
   {
      ["RANDOM"] = 2,
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {14}
   {
      "REC_2",
      "REC_3",
   },
   -- Table: {15}
   {
      { 21 },
      { 22 },
      { 23 },
      { 24 },
      { 25 },
      { 26 },
      { 27 },
      { 28 },
      { 29 },
      { 30 },
      { 31 },
      { 32 },
      { 33 },
      { 34 },
      { 35 },
      { 36 },
      { 37 },
      { 38 },
      { 39 },
      { 40 },
      { 41 },
      { 42 },
      { 43 },
      { 44 },
      { 45 },
      { 46 },
      { 47 },
      { 48 },
      { 49 },
      { 50 },
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
      ["constants"] = { 118 },
      ["p2finish"] = 84,
      ["start"] = 1,
      ["_stable"] = { 119 },
      ["p1start"] = 83,
      ["p2start"] = 1,
   },
   -- Table: {16}
   {
      { 120 },
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
      ["p2start"] = 25,
      ["_stable"] = { 195 },
      ["start"] = 25,
      ["p2finish"] = 67,
      ["p1start"] = 65,
      ["constants"] = { 196 },
   },
   -- Table: {17}
   {
      { 197 },
      { 198 },
      { 199 },
      { 200 },
      { 201 },
      { 202 },
      { 203 },
      { 204 },
      { 205 },
      { 206 },
      { 207 },
      { 208 },
      { 209 },
      { 210 },
      { 211 },
      { 212 },
      { 213 },
      { 214 },
      { 215 },
      { 216 },
      { 217 },
      { 218 },
      { 219 },
      { 220 },
      { 221 },
      { 222 },
      { 223 },
      { 224 },
      { 225 },
      { 226 },
      { 227 },
      { 228 },
      { 229 },
      { 230 },
      { 231 },
      { 232 },
      { 233 },
      { 234 },
      { 235 },
      { 236 },
      { 237 },
      { 238 },
      { 239 },
      { 240 },
      { 241 },
      { 242 },
      { 243 },
      { 244 },
      { 245 },
      { 246 },
      { 247 },
      { 248 },
      { 249 },
      { 250 },
      { 251 },
      { 252 },
      { 253 },
      { 254 },
      { 255 },
      ["p2start"] = 1,
      ["_stable"] = { 256 },
      ["start"] = 1,
      ["p2finish"] = 59,
      ["p1start"] = 59,
      ["constants"] = { 257 },
   },
   -- Table: {18}
   {
   },
   -- Table: {19}
   {
   },
   -- Table: {20}
   {
      ["RANDOM"] = 2,
      ["ON"] = 1,
      ["OFF"] = 0,
   },
   -- Table: {21}
   {
      ["serial"] = { 258 },
   },
   -- Table: {22}
   {
      ["serial"] = { 259 },
   },
   -- Table: {23}
   {
      ["serial"] = { 260 },
   },
   -- Table: {24}
   {
      ["serial"] = { 261 },
   },
   -- Table: {25}
   {
      ["serial"] = { 262 },
   },
   -- Table: {26}
   {
      ["serial"] = { 263 },
   },
   -- Table: {27}
   {
      ["serial"] = { 264 },
   },
   -- Table: {28}
   {
      ["serial"] = { 265 },
   },
   -- Table: {29}
   {
      ["serial"] = { 266 },
   },
   -- Table: {30}
   {
      ["serial"] = { 267 },
   },
   -- Table: {31}
   {
      ["serial"] = { 268 },
   },
   -- Table: {32}
   {
      ["serial"] = { 269 },
   },
   -- Table: {33}
   {
      ["serial"] = { 270 },
   },
   -- Table: {34}
   {
      ["serial"] = { 271 },
   },
   -- Table: {35}
   {
      ["serial"] = { 272 },
   },
   -- Table: {36}
   {
      ["serial"] = { 273 },
   },
   -- Table: {37}
   {
      ["serial"] = { 274 },
   },
   -- Table: {38}
   {
      ["serial"] = { 275 },
   },
   -- Table: {39}
   {
      ["serial"] = { 276 },
   },
   -- Table: {40}
   {
      ["serial"] = { 277 },
   },
   -- Table: {41}
   {
      ["serial"] = { 278 },
   },
   -- Table: {42}
   {
      ["serial"] = { 279 },
   },
   -- Table: {43}
   {
      ["serial"] = { 280 },
   },
   -- Table: {44}
   {
      ["serial"] = { 281 },
   },
   -- Table: {45}
   {
      ["serial"] = { 282 },
   },
   -- Table: {46}
   {
      ["serial"] = { 283 },
   },
   -- Table: {47}
   {
      ["serial"] = { 284 },
   },
   -- Table: {48}
   {
      ["serial"] = { 285 },
   },
   -- Table: {49}
   {
      ["serial"] = { 286 },
   },
   -- Table: {50}
   {
      ["serial"] = { 287 },
   },
   -- Table: {51}
   {
      ["serial"] = { 288 },
   },
   -- Table: {52}
   {
      ["serial"] = { 289 },
   },
   -- Table: {53}
   {
      ["serial"] = { 290 },
   },
   -- Table: {54}
   {
      ["serial"] = { 291 },
   },
   -- Table: {55}
   {
      ["serial"] = { 292 },
   },
   -- Table: {56}
   {
      ["serial"] = { 293 },
   },
   -- Table: {57}
   {
      ["serial"] = { 294 },
   },
   -- Table: {58}
   {
      ["serial"] = { 295 },
   },
   -- Table: {59}
   {
      ["serial"] = { 296 },
   },
   -- Table: {60}
   {
      ["serial"] = { 297 },
   },
   -- Table: {61}
   {
      ["serial"] = { 298 },
   },
   -- Table: {62}
   {
      ["serial"] = { 299 },
   },
   -- Table: {63}
   {
      ["serial"] = { 300 },
   },
   -- Table: {64}
   {
      ["serial"] = { 301 },
   },
   -- Table: {65}
   {
      ["serial"] = { 302 },
   },
   -- Table: {66}
   {
      ["serial"] = { 303 },
   },
   -- Table: {67}
   {
      ["serial"] = { 304 },
   },
   -- Table: {68}
   {
      ["serial"] = { 305 },
   },
   -- Table: {69}
   {
      ["serial"] = { 306 },
   },
   -- Table: {70}
   {
      ["serial"] = { 307 },
   },
   -- Table: {71}
   {
      ["serial"] = { 308 },
   },
   -- Table: {72}
   {
      ["serial"] = { 309 },
   },
   -- Table: {73}
   {
      ["serial"] = { 310 },
   },
   -- Table: {74}
   {
      ["serial"] = { 311 },
   },
   -- Table: {75}
   {
      ["serial"] = { 312 },
   },
   -- Table: {76}
   {
      ["serial"] = { 313 },
   },
   -- Table: {77}
   {
      ["serial"] = { 314 },
   },
   -- Table: {78}
   {
      ["serial"] = { 315 },
   },
   -- Table: {79}
   {
      ["serial"] = { 316 },
   },
   -- Table: {80}
   {
      ["serial"] = { 317 },
   },
   -- Table: {81}
   {
      ["serial"] = { 318 },
   },
   -- Table: {82}
   {
      ["serial"] = { 319 },
   },
   -- Table: {83}
   {
      ["serial"] = { 320 },
   },
   -- Table: {84}
   {
      ["serial"] = { 321 },
   },
   -- Table: {85}
   {
      ["serial"] = { 322 },
   },
   -- Table: {86}
   {
      ["serial"] = { 323 },
   },
   -- Table: {87}
   {
      ["serial"] = { 324 },
   },
   -- Table: {88}
   {
      ["serial"] = { 325 },
   },
   -- Table: {89}
   {
      ["serial"] = { 326 },
   },
   -- Table: {90}
   {
      ["serial"] = { 327 },
   },
   -- Table: {91}
   {
      ["serial"] = { 328 },
   },
   -- Table: {92}
   {
      ["serial"] = { 329 },
   },
   -- Table: {93}
   {
      ["serial"] = { 330 },
   },
   -- Table: {94}
   {
      ["serial"] = { 331 },
   },
   -- Table: {95}
   {
      ["serial"] = { 332 },
   },
   -- Table: {96}
   {
      ["serial"] = { 333 },
   },
   -- Table: {97}
   {
      ["serial"] = { 334 },
   },
   -- Table: {98}
   {
      ["serial"] = { 335 },
   },
   -- Table: {99}
   {
      ["serial"] = { 336 },
   },
   -- Table: {100}
   {
      ["serial"] = { 337 },
   },
   -- Table: {101}
   {
      ["serial"] = { 338 },
   },
   -- Table: {102}
   {
      ["serial"] = { 339 },
   },
   -- Table: {103}
   {
      ["serial"] = { 340 },
   },
   -- Table: {104}
   {
      ["serial"] = { 341 },
   },
   -- Table: {105}
   {
      ["serial"] = { 342 },
   },
   -- Table: {106}
   {
      ["serial"] = { 343 },
   },
   -- Table: {107}
   {
      ["serial"] = { 344 },
   },
   -- Table: {108}
   {
      ["serial"] = { 345 },
   },
   -- Table: {109}
   {
      ["serial"] = { 346 },
   },
   -- Table: {110}
   {
      ["serial"] = { 347 },
   },
   -- Table: {111}
   {
      ["serial"] = { 348 },
   },
   -- Table: {112}
   {
      ["serial"] = { 349 },
   },
   -- Table: {113}
   {
      ["serial"] = { 350 },
   },
   -- Table: {114}
   {
      ["serial"] = { 351 },
   },
   -- Table: {115}
   {
      ["serial"] = { 352 },
   },
   -- Table: {116}
   {
      ["serial"] = { 353 },
   },
   -- Table: {117}
   {
      ["serial"] = { 354 },
   },
   -- Table: {118}
   {
      ["P1 Button A"] = false,
      ["P2 Button A"] = false,
      ["P2 Right"] = false,
      ["Debug Dip 2"] = 0,
      ["Service"] = false,
      ["P2 Coin"] = false,
      ["P1 Coin"] = false,
      ["P1 Down"] = false,
      ["Debug Dip 1"] = 0,
      ["P1 Button C"] = false,
      ["P2 Start"] = false,
      ["P1 Start"] = false,
      ["P1 Right"] = false,
      ["P1 Up"] = false,
      ["Test"] = false,
      ["Dip 1"] = 0,
      ["P1 Left"] = false,
      ["Reset"] = false,
      ["P2 Button B"] = false,
      ["P1 Select"] = false,
      ["P2 Button C"] = false,
      ["P2 Button D"] = false,
      ["P1 Button D"] = false,
      ["P2 Select"] = false,
      ["P1 Button B"] = false,
   },
   -- Table: {119}
   {
      ["p2"] = { 355 },
      ["p1"] = { 356 },
   },
   -- Table: {120}
   {
      ["serial"] = { 357 },
   },
   -- Table: {121}
   {
      ["serial"] = { 358 },
   },
   -- Table: {122}
   {
      ["serial"] = { 359 },
   },
   -- Table: {123}
   {
      ["serial"] = { 360 },
   },
   -- Table: {124}
   {
      ["serial"] = { 361 },
   },
}
