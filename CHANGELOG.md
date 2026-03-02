# KOF Training Mode Changelog

## Bug Fixes

- **Input Coupling & P1 Disconnection Fix (`init.lua`, `helpers.lua`)**
  - Resolved a critical issue where dummy actions (P2) would overwrite the entire input state, causing Player 1 to become unresponsive ("disconnect").
  - Implemented `pechanJoypadSet` to merge addon inputs into the global `inputs.setinputs` table instead of using `joypad.set` directly.
  - Relocated training loop logic to `registers.registerbefore` to ensure atomic input merging before the main script applies inputs to the emulator.
- **1-Hit Guard Crouching Fix (`init.lua`)**
  - Fixed a bug where the dummy would stand up while waiting for a hit in 1-hit guard mode even if set to crouching.
  - Decoupled dummy stance logic from Player 1's action state to ensure independent behavior.

## Features & Enhancements

- **Configurable Game Options Architecture (`config.lua`, `guipages.lua`, `init.lua`)**
  - Shifted hardcoded memory addresses for EX characters and mode settings directly into `config.lua` to properly facilitate per-game configurations.
  - Refactored UI logic inside `guipages.lua` to dynamically evaluate the active game's capabilities, conditionally rendering or hiding EX limits and Mode toggles based on native engine support.
  - Scaled compatibility to flawlessly accommodate older or restricted titles that fundamentally lack EX variations or alternative routing modes without UI clutter.

- **KOF 2001 4-Slot Striker System Logic (`config.lua`)**
  - Restored and formalized internal tracking for `INFINITE_STRIKERS` and `STRIKER_MODE`, routing their logic appropriately for the KOF 2001 engine.
  - Engineered new memory offset mappings (`P1_STRIKER2`, `P1_STRIKER3`, `P2_STRIKER2`, `P2_STRIKER3`) to fully accommodate up to 3 dedicated striker profiles per player.
  - Successfully laid the infrastructural groundwork to implement a true 4-slot Active Striker selection system across both P1 and P2 seamlessly.

- **Frame Data Accuracy & Display Improvements (`frame_data.lua`)**
  - **"Startup 1" Accuracy Fixed:** Startup frames are now measured correctly, specifically ensuring accuracy for subsequent chained moves.
  - **Display Persistence:** Improved the duration that frame data remains visible on-screen, preventing it from vanishing too quickly while testing.
  - **Whiff Handling:** Moves that start but do not become active (whiffs) are now correctly tracked, registered, and displayed in the frame data output.
  - **Air Time Tracking:** Added Air Time logic to the frame data readout to measure jump/airborne duration in addition to standard grounded frame advantages!
  - **Advantage Calculation Sync:** Bypassed the separate frame advantage calculation logic inside `frame_data` entirely, securely binding its UI directy to `init.lua`'s proven block/hitstun math counter outputs so both visuals perfectly mirror one another.
  - **Free Advantage Overhaul:** Rewrote the "Free Advantage" logic (number in parentheses on the UI) so its math algorithm calculates perfectly from the hit frame itself. It explicitly calculates the opponent's total stun duration minus the attacker's recovery frames that occurred during that specific stun span.
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
