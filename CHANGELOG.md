# KOF Training Mode Changelog

## Features & Enhancements

- **Frame Data Accuracy & Display Improvements (`frame_data.lua`)**
  - **"Startup 1" Accuracy Fixed:** Startup frames are now measured correctly, specifically ensuring accuracy for subsequent chained moves.
  - **Display Persistence:** Improved the duration that frame data remains visible on-screen, preventing it from vanishing too quickly while testing.
  - **Whiff Handling:** Moves that start but do not become active (whiffs) are now correctly tracked, registered, and displayed in the frame data output.
  - **Air Time Tracking:** Added Air Time logic to the frame data readout to measure jump/airborne duration in addition to standard grounded frame advantages!
  - **Options Menu Integration:** Frame data is now fully integrated into the interactive UI menu, allowing it to be permanently disabled or re-enabled at will.

- **Dynamic Paginated Character Layout (`guipages.lua`)**
  - Completely erased 1,800 lines of hardcoded button coordinates!
  - `guipages.lua` now mathematically generates the character layout directly from the `characters` table loaded out of `config.lua`.
  - Characters are automatically paginated: 2 columns (max 28 characters) per screen.
  - Automatically injects **<< Prev Page** and **Next Page >>** buttons when rosters exceed 28 slots.
  - The third column is permanently dedicated strictly to **EX Flags**, **Mode Toggles**, and the **Apply Changes** button, eliminating overlapping menus forever.

- **Pending Changes Indicator (`guipages.lua`, `init.lua`, `config.lua`)**
  - The "Apply Changes" button now actively references an `APPLIED` object stored in `config.lua`.
  - Upon a successful ROM load, `init.lua` synchronizes exactly what mode/character is active.
  - If a user changes a menu toggle (like picking a new opponent) without loading it, the "Apply Changes" button now warns them by turning Light Orange.

- **Multi-Engine Roster Support: KOF '96 & KOF '97 (`config.lua`)**
  - Added new KOF '96 and KOF '97 dictionary blocks into `config.lua`.
  - Mapped all `p1_stored_index`, `hitstatus`, `blockstun`, and memory offsets for the '96 and '97 engines so they now natively hook into the training tool.
  - Characters from both games are now fully selectable from the dynamic training screen menu without any overlapping bugs.
  - Added support for 97's Advanced and Extra mode switching.

- **EX Character Restrictions (`config.lua`, `guipages.lua`, `init.lua`)**
  - Added a `has_ex` boolean flag to all characters across the KOF engines.
  - If a character lacks an EX version (e.g., Goro Daimon), the EX button changes to `---` and does nothing.
  - `init.lua` now double-checks on startup and forces the EX flags to `false` if an invalid EX character is somehow requested.

- **KOF 2002 EX Support and Engine Syncing (`config.lua`, `init.lua`)**
  - Added full character roster mapping for KOF 2002 to `config.lua` alongside offset mapping for P1 and P2 selection nodes (`0x2704` and `0x272A`).
  - Added explicit KOF 2002 handling to write `0x10` to the EX byte block for EX versions of Shermie, Chris, and Yashiro, and dynamically restore `0x00` when turned off.
  - Built an architecture to actively fight the KOF 2002 memory engine exclusively whenever EX states are formally "Applied" by continuously clamping `0x02` into the character palette blocks (`0x10A7E3` and `0x10A809`).
  - Updated `INITIAL_START` savestate loading logic to dynamically assign the `CURRENT_PLAYER` configs directly from the `.fs` memory readout, keeping the UI perfectly in sync with the physical engine loadout instead of overriding it.

## Bug Fixes

- **Player 2 Character Defaulting to Iori (`init.lua`)**
  - Fixed a memory address offset miscalculation where `p2_stored_index_location` was pointing to the wrong variable.
  - P2 correctly respects the user's manual selection now instead of overwriting it with Iori (index 28).

## Technical Metrics
- Refactored `guipages.lua` file size from **2,813 lines** down to **1,195 lines**.
- Net change across today's final UI refactoring: **+472 insertions, -1,965 deletions**.
