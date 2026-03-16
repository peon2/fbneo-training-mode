KOF_CONFIG = {
    GAMES = {
        ["kof98"] = {
            name = "The King of Fighters '98",
            has_ex = true,
            has_modes = true,
            player1_base = 0x108100,
            player2_base = 0x108300,
            offsets = {
                hitstatus = 0x72,
                action = 0x73,
                status = 0x7C,
                blockstun = 0xE3,
                air_height = 0x21,
                player_stored_index = 0x274E, -- Memory delta: p1 is 0x10A84E, relative to base 0x108100 = 0x274E
                p1_ex_address = 0x10A85A,
                p2_ex_address = 0x10A86B,
                p1_mode_address = 0x10A84C,
                p2_mode_address = 0x10A85D,
                obj_ptr_list = 0x10B094 + 0xE90,
                game_phase = 0x10B094,
                level_address = 0x10FD8E,
                stage_address = 0x10A7EA,
                music_address = 0x10ED5F,
            },
            characters = {
                [1] = { name = "Kyo Kusanagi", code = "0x00", short_name = "kyo", has_ex = true },
                [2] = { name = "Benimaru Nikaido", code = "0x01", short_name = "beni" },
                [3] = { name = "Goro Daimon", code = "0x02", short_name = "goro" },
                [4] = { name = "Terry Bogard", code = "0x03", short_name = "terry", has_ex = true },
                [5] = { name = "Andy Bogard", code = "0x04", short_name = "andy", has_ex = true },
                [6] = { name = "Joe Higashi", code = "0x05", short_name = "joe", has_ex = true },
                [7] = { name = "Ryo Sakazaki", code = "0x06", short_name = "ryo", has_ex = true },
                [8] = { name = "Robert Garcia", code = "0x07", short_name = "robert", has_ex = true },
                [9] = { name = "Yuri Sakazaki", code = "0x08", short_name = "yuri", has_ex = true },
                [10] = { name = "Leona", code = "0x09", short_name = "leona" },
                [11] = { name = "Ralf Jones", code = "0x0A", short_name = "ralf" },
                [12] = { name = "Clark Steel", code = "0x0B", short_name = "clark" },
                [13] = { name = "Athena Asamiya", code = "0x0C", short_name = "athena" },
                [14] = { name = "Sie Kensou", code = "0x0D", short_name = "sie" },
                [15] = { name = "Chin Gentsai", code = "0x0E", short_name = "chin" },
                [16] = { name = "Chizuru Kagura", code = "0x0F", short_name = "chizuru" },
                [17] = { name = "Mai Shiranui", code = "0x10", short_name = "mai", has_ex = true },
                [18] = { name = "King", code = "0x11", short_name = "king" },
                [19] = { name = "Kim Kaphwan", code = "0x12", short_name = "kim" },
                [20] = { name = "Chang Koehan", code = "0x13", short_name = "chang" },
                [21] = { name = "Choi Bounge", code = "0x14", short_name = "choi" },
                [22] = { name = "Yashiro Nanakase", code = "0x15", short_name = "yashiro", has_ex = true },
                [23] = { name = "Shermie", code = "0x16", short_name = "shermie", has_ex = true },
                [24] = { name = "Chris", code = "0x17", short_name = "chris", has_ex = true },
                [25] = { name = "Ryuji Yamazaki", code = "0x18", short_name = "ryuji" },
                [26] = { name = "Blue Mary", code = "0x19", short_name = "mary" },
                [27] = { name = "Billy Kane", code = "0x1A", short_name = "billy", has_ex = true },
                [28] = { name = "Iori Yagami", code = "0x1B", short_name = "iori" },
                [29] = { name = "Mature", code = "0x1C", short_name = "mature" },
                [30] = { name = "Vice", code = "0x1D", short_name = "vice" },
                [31] = { name = "Heidern", code = "0x1E", short_name = "heidern" },
                [32] = { name = "Takuma Sakazaki", code = "0x1F", short_name = "takuma" },
                [33] = { name = "Saisyu Kusanagi", code = "0x20", short_name = "saisyu" },
                [34] = { name = "Heavy D!", code = "0x21", short_name = "heavy" },
                [35] = { name = "Lucky Glauber", code = "0x22", short_name = "lucky" },
                [36] = { name = "Brian Battler", code = "0x23", short_name = "brian" },
                [37] = { name = "Rugal Bernstein", code = "0x24", short_name = "rugal", has_ex = true },
                [38] = { name = "Shingo Yabuki", code = "0x25", short_name = "shingo" },
            }
        },
        ["kof97"] = {
            name = "The King of Fighters '97",
            has_ex = true,
            has_modes = true,
            player1_base = 0x108100,
            player2_base = 0x108300,
            offsets = {
                hitstatus = 0x72,
                action = 0x73,
                status = 0x7C,
                blockstun = 0xE3,
                air_height = 0x21,
                player_stored_index = 0x274B,
                p1_ex_address = 0x10A857, -- Need to verify
                p2_ex_address = 0x10A868, -- Need to verify
                p1_mode_address = 0x10A849,
                p2_mode_address = 0x10A85A,
                obj_ptr_list = 0x10B092 + 0xE90,
                game_phase = 0x10B092,
                level_address = 0x10FD8E, -- Need to verify for kof97
                stage_address = 0x10A7EA, -- Need to verify for kof97
                music_address = 0x10ED5F, -- Need to verify for kof97
            },
            characters = {
                [1] = { name = "Kyo Kusanagi", code = "0x00", short_name = "kyo", has_ex = true },
                [2] = { name = "Benimaru Nikaido", code = "0x01", short_name = "beni" },
                [3] = { name = "Goro Daimon", code = "0x02", short_name = "goro" },
                [4] = { name = "Terry Bogard", code = "0x03", short_name = "terry" },
                [5] = { name = "Andy Bogard", code = "0x04", short_name = "andy" },
                [6] = { name = "Joe Higashi", code = "0x05", short_name = "joe" },
                [7] = { name = "Ryo Sakazaki", code = "0x06", short_name = "ryo" },
                [8] = { name = "Robert Garcia", code = "0x07", short_name = "robert" },
                [9] = { name = "Yuri Sakazaki", code = "0x08", short_name = "yuri" },
                [10] = { name = "Leona", code = "0x09", short_name = "leona" },
                [11] = { name = "Ralf Jones", code = "0x0A", short_name = "ralf" },
                [12] = { name = "Clark Steel", code = "0x0B", short_name = "clark" },
                [13] = { name = "Athena Asamiya", code = "0x0C", short_name = "athena" },
                [14] = { name = "Sie Kensou", code = "0x0D", short_name = "sie" },
                [15] = { name = "Chin Gentsai", code = "0x0E", short_name = "chin" },
                [16] = { name = "Chizuru Kagura", code = "0x0F", short_name = "chizuru" },
                [17] = { name = "Mai Shiranui", code = "0x10", short_name = "mai" },
                [18] = { name = "King", code = "0x11", short_name = "king" },
                [19] = { name = "Kim Kaphwan", code = "0x12", short_name = "kim" },
                [20] = { name = "Chang Koehan", code = "0x13", short_name = "chang" },
                [21] = { name = "Choi Bounge", code = "0x14", short_name = "choi" },
                [22] = { name = "Yashiro Nanakase", code = "0x15", short_name = "yashiro", has_ex = true },
                [23] = { name = "Shermie", code = "0x16", short_name = "shermie", has_ex = true },
                [24] = { name = "Chris", code = "0x17", short_name = "chris", has_ex = true },
                [25] = { name = "Ryuji Yamazaki", code = "0x18", short_name = "ryuji" },
                [26] = { name = "Blue Mary", code = "0x19", short_name = "mary" },
                [27] = { name = "Billy Kane", code = "0x1A", short_name = "billy" },
                [28] = { name = "Iori Yagami", code = "0x1B", short_name = "iori" },
                [29] = { name = "Orochi Iori", code = "0x1C", short_name = "o_iori" },
                [30] = { name = "Orochi Leona", code = "0x1D", short_name = "o_leona" },
                [31] = { name = "Orochi", code = "0x1E", short_name = "orochi" },
                [32] = { name = "Shingo Yabuki", code = "0x1F", short_name = "shingo" },
                [33] = { name = "Orochi EX Test", code = "0x21", short_name = "o_ex_test" },
            }
        },
        ["kof96"] = {
            name = "The King of Fighters '96",
            has_ex = false,
            has_modes = false,
            player1_base = 0x108100,
            player2_base = 0x108300,
            offsets = {
                hitstatus = 0x72,
                action = 0x73,
                status = 0x7C,
                blockstun = 0xE3,
                air_height = 0x21,
                player_stored_index = 0x2746,
                obj_ptr_list = 0x10B094 + 0xE90,
                game_phase = 0x10B094,
                level_address = 0x10FD8E,
                stage_address = 0x10A7EA,
                music_address = 0x10ED5F,
            },
            characters = {
                [1] = { name = "Kyo Kusanagi", code = "0x00", short_name = "kyo" },
                [2] = { name = "Benimaru Nikaido", code = "0x01", short_name = "beni" },
                [3] = { name = "Goro Daimon", code = "0x02", short_name = "goro" },
                [4] = { name = "Terry Bogard", code = "0x03", short_name = "terry" },
                [5] = { name = "Andy Bogard", code = "0x04", short_name = "andy" },
                [6] = { name = "Joe Higashi", code = "0x05", short_name = "joe" },
                [7] = { name = "Ryo Sakazaki", code = "0x06", short_name = "ryo" },
                [8] = { name = "Robert Garcia", code = "0x07", short_name = "robert" },
                [9] = { name = "Yuri Sakazaki", code = "0x08", short_name = "yuri" },
                [10] = { name = "Leona", code = "0x09", short_name = "leona" },
                [11] = { name = "Ralf Jones", code = "0x0A", short_name = "ralf" },
                [12] = { name = "Clark Steel", code = "0x0B", short_name = "clark" },
                [13] = { name = "Athena Asamiya", code = "0x0C", short_name = "athena" },
                [14] = { name = "Sie Kensou", code = "0x0D", short_name = "sie" },
                [15] = { name = "Chin Gentsai", code = "0x0E", short_name = "chin" },
                [16] = { name = "Kasumi Todo", code = "0x0F", short_name = "kasumi" },
                [17] = { name = "Mai Shiranui", code = "0x10", short_name = "mai" },
                [18] = { name = "King", code = "0x11", short_name = "king" },
                [19] = { name = "Kim Kaphwan", code = "0x12", short_name = "kim" },
                [20] = { name = "Chang Koehan", code = "0x13", short_name = "chang" },
                [21] = { name = "Choi Bounge", code = "0x14", short_name = "choi" },
                [22] = { name = "Iori Yagami", code = "0x15", short_name = "iori" },
                [23] = { name = "Mature", code = "0x16", short_name = "mature" },
                [24] = { name = "Vice", code = "0x17", short_name = "vice" },
                [25] = { name = "Geese Howard", code = "0x18", short_name = "geese" },
                [26] = { name = "Wolfgang Krauser", code = "0x19", short_name = "krauser" },
                [27] = { name = "Mr. Big", code = "0x1A", short_name = "mrbig" },
                [28] = { name = "Chizuru Kagura", code = "0x1B", short_name = "chizuru" },
                [29] = { name = "Goenitz", code = "0x1C", short_name = "goenitz" },
            }
        },
        ["kof2002"] = {
            name = "The King of Fighters 2002",
            has_ex = true,
            has_modes = false,
            player1_base = 0x108100,
            player2_base = 0x108300,
            offsets = {
                hitstatus = 0x72,
                action = 0x73,
                status = 0x7C,
                blockstun = 0xE3,
                air_height = 0x21,
                player_stored_index = 0x26EE,
                player2_stored_index = 0x2714,
                p1_ex_address = 0x10821D,
                p2_ex_address = 0x10841D,
                p1_color_address = 0x10A7E3,
                p2_color_address = 0x10A809,
                ex_value = 0x10,
                obj_ptr_list = 0x10B094 + 0xE90,
                game_phase = 0x10B094,
                level_address = 0x10FD8E,
                stage_address = 0x10A7EA,
                music_address = 0x10ED5F,
            },
            characters = {
                [1] = { name = "Kyo", code = "0x00", short_name = "kyo" },
                [2] = { name = "Benimaru", code = "0x01", short_name = "beni" },
                [3] = { name = "Daimon", code = "0x02", short_name = "daimon" },
                [4] = { name = "Terry", code = "0x03", short_name = "terry" },
                [5] = { name = "Andy", code = "0x04", short_name = "andy" },
                [6] = { name = "Joe", code = "0x05", short_name = "joe" },
                [7] = { name = "Kim", code = "0x06", short_name = "kim" },
                [8] = { name = "Chang", code = "0x07", short_name = "chang" },
                [9] = { name = "Choi", code = "0x08", short_name = "choi" },
                [10] = { name = "Athena", code = "0x09", short_name = "athena" },
                [11] = { name = "Kensou", code = "0x0A", short_name = "kensou" },
                [12] = { name = "Chin", code = "0x0B", short_name = "chin" },
                [13] = { name = "Leona", code = "0x0C", short_name = "leona" },
                [14] = { name = "Ralf", code = "0x0D", short_name = "ralf" },
                [15] = { name = "Clark", code = "0x0E", short_name = "clark" },
                [16] = { name = "Ryo", code = "0x0F", short_name = "ryo" },
                [17] = { name = "Robert", code = "0x10", short_name = "robert" },
                [18] = { name = "Takuma", code = "0x11", short_name = "takuma" },
                [19] = { name = "Mai", code = "0x12", short_name = "mai" },
                [20] = { name = "Yuri", code = "0x13", short_name = "yuri" },
                [21] = { name = "May Lee", code = "0x14", short_name = "maylee" },
                [22] = { name = "Iori", code = "0x15", short_name = "iori" },
                [23] = { name = "Mature", code = "0x16", short_name = "mature" },
                [24] = { name = "Vice", code = "0x17", short_name = "vice" },
                [25] = { name = "Yamazaki", code = "0x18", short_name = "yamazaki" },
                [26] = { name = "Mary", code = "0x19", short_name = "mary" },
                [27] = { name = "Billy", code = "0x1A", short_name = "billy" },
                [28] = { name = "Yashiro", code = "0x1B", short_name = "yashiro", has_ex = true },
                [29] = { name = "Shermie", code = "0x1C", short_name = "shermie", has_ex = true },
                [30] = { name = "Chris", code = "0x1D", short_name = "chris", has_ex = true },
                [31] = { name = "K\'", code = "0x1E", short_name = "k" },
                [32] = { name = "Maxima", code = "0x1F", short_name = "maxima" },
                [33] = { name = "Whip", code = "0x20", short_name = "whip" },
                [34] = { name = "Vanessa", code = "0x21", short_name = "vanessa" },
                [35] = { name = "Seth", code = "0x22", short_name = "seth" },
                [36] = { name = "Ramon", code = "0x23", short_name = "ramon" },
                [37] = { name = "Kula", code = "0x24", short_name = "kula" },
                [38] = { name = "K9999", code = "0x25", short_name = "k9999" },
                [39] = { name = "Angel", code = "0x26", short_name = "angel" },
                [40] = { name = "Rugal", code = "0x27", short_name = "rugal" },
                [41] = { name = "Kusanagi", code = "0x28", short_name = "kusanagi" },
            }
        },
        ["kof99"] = {
            name = "The King of Fighters '99",
            has_ex = false,
            has_modes = false,
            has_strikers = true,
            player1_base = 0x108100,
            player2_base = 0x108300,
            offsets = {
                hitstatus = 0x72,
                action = 0x73,
                status = 0x7C,
                blockstun = 0xE3,
                air_height = 0x21,
                player_stored_index = 0x26FA,
                player2_stored_index = 0x270F,
                striker1_stored_index = 0x26FD,
                striker2_stored_index = 0x2712,
                striker_count_address = 0x01E3, -- Relative offset for striker stock
                obj_ptr_list = 0x10B094 + 0xE90,
                game_phase = 0x10B094,
                level_address = 0x10FD8E,
                stage_address = 0x10A7EA,
                music_address = 0x10ED5F,
            },
            characters = {
                [1] = { name = "K\'", code = "0x00", short_name = "k" },
                [2] = { name = "Maxima", code = "0x01", short_name = "maxima" },
                [3] = { name = "Benimaru Nikaido", code = "0x02", short_name = "beni" },
                [4] = { name = "Shingo Yabuki", code = "0x03", short_name = "shingo" },
                [5] = { name = "Terry Bogard", code = "0x04", short_name = "terry" },
                [6] = { name = "Andy Bogard", code = "0x05", short_name = "andy" },
                [7] = { name = "Joe Higashi", code = "0x06", short_name = "joe" },
                [8] = { name = "Mai Shiranui", code = "0x07", short_name = "mai" },
                [9] = { name = "Ryo Sakazaki", code = "0x08", short_name = "ryo" },
                [10] = { name = "Robert Garcia", code = "0x09", short_name = "robert" },
                [11] = { name = "Yuri Sakazaki", code = "0x0A", short_name = "yuri" },
                [12] = { name = "Takuma Sakazaki", code = "0x0B", short_name = "takuma" },
                [13] = { name = "Leona", code = "0x0C", short_name = "leona" },
                [14] = { name = "Ralf Jones", code = "0x0D", short_name = "ralf" },
                [15] = { name = "Clark Steel", code = "0x0E", short_name = "clark" },
                [16] = { name = "Whip", code = "0x0F", short_name = "whip" },
                [17] = { name = "Athena Asamiya", code = "0x10", short_name = "athena" },
                [18] = { name = "Sie Kensou", code = "0x11", short_name = "sie" },
                [19] = { name = "Chin Gentsai", code = "0x12", short_name = "chin" },
                [20] = { name = "Bao", code = "0x13", short_name = "bao" },
                [21] = { name = "King", code = "0x14", short_name = "king" },
                [22] = { name = "Blue Mary", code = "0x15", short_name = "mary" },
                [23] = { name = "Kasumi Todo", code = "0x16", short_name = "kasumi" },
                [24] = { name = "Li Xiangfei", code = "0x17", short_name = "xiangfei" },
                [25] = { name = "Kim Kaphwan", code = "0x18", short_name = "kim" },
                [26] = { name = "Chang Koehan", code = "0x19", short_name = "chang" },
                [27] = { name = "Choi Bounge", code = "0x1A", short_name = "choi" },
                [28] = { name = "Jhun Hoon", code = "0x1B", short_name = "jhun" },
                [29] = { name = "Kyo Kusanagi", code = "0x1C", short_name = "kyo" },
                [30] = { name = "Kyo-1", code = "0x1D", short_name = "kyo1" },
                [31] = { name = "Iori Yagami", code = "0x1E", short_name = "iori" },
                [32] = { name = "Krizalid", code = "0x1F", short_name = "krizalid" },
                [33] = { name = "Krizalid (second form)", code = "0x20", short_name = "krizalid2" },
                [34] = { name = "Kyo-2", code = "0x21", short_name = "kyo2" },
            }
        },
        ["kof2000"] = {
            name = "The King of Fighters 2000",
            has_ex = false,
            has_modes = false,
            has_strikers = true,
            player1_base = 0x108100,
            player2_base = 0x108300,
            offsets = {
                hitstatus = 0x72,
                action = 0x73,
                status = 0x7C,
                blockstun = 0xE3,
                air_height = 0x21,
                player_stored_index = 0x26FA,
                player2_stored_index = 0x270F,
                striker1_stored_index = 0x26FD,
                striker2_stored_index = 0x2712,
                p1_striker_mode_address = 0x270A,
                p2_striker_mode_address = 0x271F,
                striker_count_address = 0x01E3, -- Relative offset for striker stock
                obj_ptr_list = 0x10B094 + 0xE90,
                game_phase = 0x10B094,
                level_address = 0x10FD8E,
                stage_address = 0x10A7EA,
                music_address = 0x10ED5F,
            },
            characters = {
                [1] = { name = "K\'", code = "0x00", short_name = "k" },
                [2] = { name = "Maxima", code = "0x01", short_name = "maxima" },
                [3] = { name = "Benimaru Nikaido", code = "0x02", short_name = "beni" },
                [4] = { name = "Shingo Yabuki", code = "0x03", short_name = "shingo" },
                [5] = { name = "Terry Bogard", code = "0x04", short_name = "terry" },
                [6] = { name = "Andy Bogard", code = "0x05", short_name = "andy" },
                [7] = { name = "Joe Higashi", code = "0x06", short_name = "joe" },
                [8] = { name = "Mai Shiranui", code = "0x07", short_name = "mai" },
                [9] = { name = "Ryo Sakazaki", code = "0x08", short_name = "ryo", has_maniac = true },
                [10] = { name = "Robert Garcia", code = "0x09", short_name = "robert" },
                [11] = { name = "Yuri Sakazaki", code = "0x0A", short_name = "yuri" },
                [12] = { name = "Takuma Sakazaki", code = "0x0B", short_name = "takuma" },
                [13] = { name = "Leona", code = "0x0C", short_name = "leona" },
                [14] = { name = "Ralf Jones", code = "0x0D", short_name = "ralf" },
                [15] = { name = "Clark Steel", code = "0x0E", short_name = "clark" },
                [16] = { name = "Whip", code = "0x0F", short_name = "whip" },
                [17] = { name = "Athena Asamiya", code = "0x10", short_name = "athena" },
                [18] = { name = "Sie Kensou", code = "0x11", short_name = "sie" },
                [19] = { name = "Chin Gentsai", code = "0x12", short_name = "chin" },
                [20] = { name = "Bao", code = "0x13", short_name = "bao" },
                [21] = { name = "King", code = "0x14", short_name = "king" },
                [22] = { name = "Blue Mary", code = "0x15", short_name = "mary" },
                [23] = { name = "Kasumi Todo", code = "0x16", short_name = "kasumi", has_maniac = true },
                [24] = { name = "Hinako Shijou", code = "0x17", short_name = "hinako" },
                [25] = { name = "Kim Kaphwan", code = "0x18", short_name = "kim" },
                [26] = { name = "Chang Koehan", code = "0x19", short_name = "chang", has_maniac = true },
                [27] = { name = "Choi Bounge", code = "0x1A", short_name = "choi", has_maniac = true },
                [28] = { name = "Jhun Hoon", code = "0x1B", short_name = "jhun" },
                [29] = { name = "Kyo Kusanagi", code = "0x1C", short_name = "kyo", has_maniac = true },
                [30] = { name = "Ramon", code = "0x1D", short_name = "ramon", has_maniac = true },
                [31] = { name = "Iori Yagami", code = "0x1E", short_name = "iori", has_maniac = true },
                [32] = { name = "Vanessa", code = "0x1F", short_name = "vanessa" },
                [33] = { name = "Lin", code = "0x20", short_name = "lin" },
                [34] = { name = "Seth", code = "0x21", short_name = "seth" },
                [35] = { name = "Kula Diamond", code = "0x22", short_name = "kula", has_maniac = true },
                [36] = { name = "Zero", code = "0x23", short_name = "zero" },
            }
        },
        ["kof2001"] = {
            name = "The King of Fighters 2001",
            has_ex = false,
            has_modes = false,
            has_strikers = true,
            has_3_strikers = true,
            player1_base = 0x108100,
            player2_base = 0x108300,
            offsets = {
                hitstatus = 0x72,
                action = 0x73,
                status = 0x7C,
                blockstun = 0xE3,
                air_height = 0x21,
                player_stored_index = 0x26E6,
                player2_stored_index = 0x2704,
                striker1_stored_index = 0x26E7,
                p1_striker2_stored_index = 0x26E8, -- P1 S2
                p1_striker3_stored_index = 0x26E9, -- P1 S3
                striker2_stored_index = 0x2705,    -- P2 S1 (Standard P2 Striker)
                p2_striker2_stored_index = 0x2706, -- P2 S2
                p2_striker3_stored_index = 0x2707, -- P2 S3
                striker_count_address = 0x01E2,    -- Relative offset for striker stock (1082E2 for P1)
                obj_ptr_list = 0x10B094 + 0xE90,
                game_phase = 0x10B094,
                level_address = 0x10FD8E,
                stage_address = 0x10A7EA,
                music_address = 0x10ED5F,
            },
            characters = {
                [1] = { name = "K\'", code = "0x00", short_name = "k" },
                [2] = { name = "Maxima", code = "0x01", short_name = "maxima" },
                [3] = { name = "Whip", code = "0x02", short_name = "whip" },
                [4] = { name = "Lin", code = "0x03", short_name = "lin" },
                [5] = { name = "Kyo Kusanagi", code = "0x04", short_name = "kyo" },
                [6] = { name = "Benimaru Nikaido", code = "0x05", short_name = "benimaru" },
                [7] = { name = "Goro Daimon", code = "0x06", short_name = "daimon" },
                [8] = { name = "Shingo Yabuki", code = "0x07", short_name = "shingo" },
                [9] = { name = "Iori Yagami", code = "0x08", short_name = "iori" },
                [10] = { name = "Vanessa", code = "0x09", short_name = "vanessa" },
                [11] = { name = "Seth", code = "0x0A", short_name = "seth" },
                [12] = { name = "Ramon", code = "0x0B", short_name = "ramon" },
                [13] = { name = "Leona", code = "0x0C", short_name = "leona" },
                [14] = { name = "Ralf Jones", code = "0x0D", short_name = "ralf" },
                [15] = { name = "Clark Steel", code = "0x0E", short_name = "clark" },
                [16] = { name = "Heidern", code = "0x0F", short_name = "heidern" },
                [17] = { name = "Terry Bogard", code = "0x10", short_name = "terry" },
                [18] = { name = "Andy Bogard", code = "0x11", short_name = "andy" },
                [19] = { name = "Joe Higashi", code = "0x12", short_name = "joe" },
                [20] = { name = "Blue Mary", code = "0x13", short_name = "mary" },
                [21] = { name = "Ryo Sakazaki", code = "0x14", short_name = "ryo" },
                [22] = { name = "Robert Garcia", code = "0x15", short_name = "robert" },
                [23] = { name = "Yuri Sakazaki", code = "0x16", short_name = "yuri" },
                [24] = { name = "Takuma Sakazaki", code = "0x17", short_name = "takuma" },
                [25] = { name = "King", code = "0x18", short_name = "king" },
                [26] = { name = "Mai Shiranui", code = "0x19", short_name = "mai" },
                [27] = { name = "Hinako Shijou", code = "0x1A", short_name = "hinako" },
                [28] = { name = "Li Xiangfei", code = "0x1B", short_name = "xiangfei" },
                [29] = { name = "Kula Diamond", code = "0x1C", short_name = "kula" },
                [30] = { name = "Foxy", code = "0x1D", short_name = "foxy" },
                [31] = { name = "K9999", code = "0x1E", short_name = "k9999" },
                [32] = { name = "Angel", code = "0x1F", short_name = "angel" },
                [33] = { name = "Athena Asamiya", code = "0x20", short_name = "athena" },
                [34] = { name = "Sie Kensou", code = "0x21", short_name = "kensou" },
                [35] = { name = "Chin Gentsai", code = "0x22", short_name = "chin" },
                [36] = { name = "Bao", code = "0x23", short_name = "bao" },
                [37] = { name = "Kim Kaphwan", code = "0x24", short_name = "kim" },
                [38] = { name = "Chang Koehan", code = "0x25", short_name = "chang" },
                [39] = { name = "Choi Bounge", code = "0x26", short_name = "choi" },
                [40] = { name = "May Lee", code = "0x27", short_name = "maylee" },
                [41] = { name = "Zero", code = "0x28", short_name = "zero" },
                [42] = { name = "Igniz", code = "0x29", short_name = "igniz" },
            }
        },
    },
    SUPPORTED_GAMES = {
        ["kof96"] = true,
        ["kof97"] = true,
        ["kof98"] = true,
        ["kof99"] = true,
        ["kof2000"] = true,
        ["kof2001"] = true,
        ["kof2002"] = true,
    },

    GUARD = {
        dummy_guarding = false,
        guard_mode = 0, -- 0: OFF, 1: ON, 2: RANDOM, 3: ALL GUARD, 4: 1 HIT GUARD
        MODE_OPTIONS = {
            OFF = 0,
            ON = 1,
            RANDOM = 2,
            ALL_GUARD = 3,
            ONE_HIT_GUARD = 4,
        },
        dummy_action = 0, -- 0: STANDING, 1: CROUCHING
        -- Deprecated: standing_guard, crouch_guard, random_guard
        ACTION_OPTIONS = {
            STANDING = 0,
            CROUCHING = 1,
        },
        reversal = 0,
        REVERSAL_OPTIONS = {

            OFF = 0,
            ON = 1,
            RANDOM = 2
        },
        reversal_moves = {}
    },
    REVERSAL_MOVES = {
        OPTIONS = {
            OFF = 0,
            ON = 1,
        },

        getCurrentReversalMoves = function(type)
            local tabl = {}

            for index, value in pairs(KOF_CONFIG.MOVES_VAR_NAMES[type]) do
                if (KOF_CONFIG.MOVES_VAR_NAMES[type][index] == KOF_CONFIG.REVERSAL_MOVES.OPTIONS.ON) then
                    local reversalMove = index
                    table.insert(tabl, reversalMove)
                end
            end

            return tabl
        end
        ,
        MOVELIST = nil
    },
    WAKEUP = {
        dummy_waking_up  = false,
        reversal         = 0,
        REVERSAL_OPTIONS = {

            OFF = 0,
            ON = 1,
            RANDOM = 2
        },
        reversal_moves   = {}
    },
    HIT = {
        dummy_hit_reversal = false,
        reversal = 0,
        REVERSAL_OPTIONS = {
            OFF = 0,
            ON = 1,
            RANDOM = 2
        },
        reversal_moves = {}
    },
    RECOVERY = {
        dummy_recovering = false,
        recovery = 0,
        OPTIONS = {
            OFF = 0,
            ON = 1,
            RANDOM = 2,
        },
        delay = 10,
        times = 8
    },
    DIZZY = {
        dummy_can_dizzy = true,
        enabled = 1,
        OPTIONS = {
            OFF = 0,
            ON = 1,
        },

    },
    PLAYERS = {
        PLAYER1 = {
            ID = 1,
            NAME = "P1",
            CROUCH_GUARD = {
                can_crouch_guard = false,
                ENABLED = 0,
                OPTIONS = {
                    OFF = 0,
                    ON = 1,
                }
            },

        },
        PLAYER2 = {
            ID = 2,
            NAME = "P2",
            COUNTER = {
                can_be_countered = false,
                ENABLED = 0,
                OPTIONS = {
                    OFF = 0,
                    ON = 1,
                }
            },
            GUARD_BREAK = {
                state_toggled = false,
                STATE = 0,
                OPTIONS = {
                    NORMAL = 0,
                    NEVER = 1,
                    ALWAYS = 2
                }
            },

        },


    },
    CPU = {
        HAS_CHANGED = false,
        dummy_can_fight = false,
        current_dificulty = 0,
        DIFFICULTY = {
            ["BEGINNER"] = 0,
            ["EASY"] = 1,
            ["NORMAL"] = 2,
            ["MVS"] = 3,
            ["HARD"] = 4,
            ["VERYHARD"] = 5,
            ["HARDEST"] = 6,
            ["EXPERT"] = 7

        },
        getDifficultyString = function(self, value)
            for key, val in pairs(self.DIFFICULTY) do
                if val == value then
                    return tostring(val + 1) .. "-" .. key
                end
            end
            return nil
        end,
        vs_enabled = 0,
        OPTIONS = {
            OFF = 0,
            ON = 1,
        },
        GCCD = {
            dummy_can_gccd = false,
            current_gccd = 0,
            OPTIONS = {
                OFF = 0,
                ON = 1,
                RANDOM = 2,
            },

        },
        GCAB = {
            dummy_can_gcab = false,
            current_gcab = 0,
            OPTIONS = {
                OFF = 0,
                ON = 1,
                RANDOM = 2,
            },

        },
    },
    THROW_OS_ON_JUMP = false,
    MOVES = {

        ['GUARD_BACK'] = {
            ["sequence"] = {
                { 'back' },

            },
            times = 10
        },
        ['THROW_OS'] = {
            ["sequence"] = {
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back' },
                { 'back', 'c' },
                { 'back', 'c' },
                { 'back', 'c' },
                { 'back', 'c' },
                { 'back', 'c' },
                { 'back', 'c' },
                { 'back', 'c' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },
                { 'down', 'back' },

            },
            times = 1
        },
        ['AB'] = {
            ["sequence"] = {
                { '-' },
                { 'a', 'b' },
                { 'a', 'b' },

            },
            times = 3,
            delay = 25
        },
        ['CD'] = {
            ["sequence"] = {
                { '-' },
                { 'c', 'd' },
                { 'c', 'd' },
                { 'c', 'd' },

            },
            times = 3,
            delay = 25
        },
        ["CROUCH"] = {
            ["sequence"] = {
                { "down" },
            }
        },
        ["CROUCH_GUARD"] = {
            ["sequence"] = {
                { "down", "back" }
            },
            times = 10
        }
    },
    MOVES_VAR_NAMES = {
        GUARD = {},
        WAKEUP = {},
        HIT = {},
    },
    TRAINING = {
        current_configuration = -1,
        CONFIGURATIONS = {
            ["None"] = -1,
            ["cd_pressure_1"] = 0,
            ["cd_pressure_2"] = 1,
            ["cd_pressure_3"] = 2,
            ["cd_pressure_4"] = 3,
            ["crouching_frametrap"] = 4,
            ["standing_frametrap"] = 5,
            ["high_confirm_against_CDA"] = 6,
            ["wakeup_whiff_cr_c"] = 7,
            ["wakeup_dpc"] = 8,
            ["shimmy_wakeup"] = 9,
            ["wakeup_delay_OS_basic"] = 10,
            ["wakeup_delay_OS_full"] = 11,

        }
    },

    AI = {
        enabled = false,
        current_state = "idle",
        patterns = {},
        -- Placeholders for memory addresses that the AI might need (custom hitboxes, etc)
        -- To be filled in by the user or through memory searching
        offsets = {
            -- e.g., opponent_is_in_air_address = 0x...,
        }
    },

    TRIAL = {
        active = false,
        current_trial_id = nil,
        score = 0,
        win_condition_met = false,
        loss_condition_met = false,
    },

    CINEMATICS = {
        active = false,
        current_dialogue_index = 1,
        dialogues = {},
    },

    -- Dynamic Game Mapping functions
    get_current_game = function()
        local rname = emu.romname and emu.romname() or "kof98"
        return KOF_CONFIG.GAMES[rname] or KOF_CONFIG.GAMES["kof98"]
    end,

    UI = {
        INITIAL_START = true,
        CURRENT_PLAYER1 = {},
        CURRENT_PLAYER2 = {},
        P1_STRIKER1 = nil,
        P2_STRIKER1 = nil,
        P1_STRIKER2 = nil,
        P1_STRIKER3 = nil,
        P2_STRIKER2 = nil,
        P2_STRIKER3 = nil,
        INFINITE_STRIKERS = 0,    -- 0: Off, 1: P1, 2: P2, 3: Both
        PLAYER1_STRIKER_MODE = 0, -- 0: Regular, 1: Alternate, 2: Maniac
        PLAYER2_STRIKER_MODE = 0, -- 0: Regular, 1: Alternate, 2: Maniac
        PLAYER1_EX = false,
        PLAYER2_EX = false,
        CHARACTERS_HAS_CHANGED = false,
        current_stage_selected = 1,
        curent_background_music_selected = 1,
        MODE_HAS_CHANGED = false,
        PLAYER1_MODE = 1,
        PLAYER2_MODE = 1,
        MODES = {
            EXTRA = 0,
            ADVANCED = 1,
        },
        APPLIED = {
            PLAYER1 = nil,
            PLAYER2 = nil,
            P1_STRIKER1 = nil,
            P2_STRIKER1 = nil,
            P1_STRIKER2 = nil,
            P1_STRIKER3 = nil,
            P2_STRIKER2 = nil,
            P2_STRIKER3 = nil,
            INFINITE_STRIKERS = 0,
            PLAYER1_STRIKER_MODE = 0,
            PLAYER2_STRIKER_MODE = 0,
            PLAYER1_EX = false,
            PLAYER2_EX = false,
            PLAYER1_MODE = 1,
            PLAYER2_MODE = 1,
        }
    },
    DEBUG = {
        OPTIONS = {
            OFF = 0,
            ON = 1,
        },
        BLOCK = 0,
        ADVANTAGE = 0,
        ACTION = 0,
        POSITION = 0,
        STUN = 0,
        GUARD = 0,
        DISTANCE = 0,
        STATE = 0,
        METER = 0,
        FRAMEDATA = 0,
    }

}
KOF_CONFIG.UI.CURRENT_PLAYER1 = KOF_CONFIG.get_current_game().characters[1]
KOF_CONFIG.UI.CURRENT_PLAYER2 = KOF_CONFIG.get_current_game().characters[28]

return KOF_CONFIG
