# Copilot Instructions — fbneo-training-mode

Purpose: short, actionable guide for an AI coding assistant to be immediately productive in this repo.

1) Big picture
- Single-file Lua plugin designed to run inside the FBNeo/MAME-like emulator: entry point is `fbneo-training-mode.lua`.
- Runtime glues together: a per-ROM game memory module (`games/<slug>/<slug>.lua`), optional game `config.lua`, common GUI (`guipages.lua`), addons (`addon/` and `games/<slug>/addon/`) and hitbox modules (`hitboxes/`).
- The script runs inside the emulator process and uses emulator APIs (`emu.*`, `gui.*`, `memory.*`, `savestate.*`). Expect heavy coupling to the live emulator state.

2) Quick start (how to run and test)
- Launch FBNeo/Fightcade and load a ROM.
- Menu: Game > Lua Scripting > New Lua Script Window > Browse > select `fbneo-training-mode.lua` and hit Run.
- Use the in-emulator GUI and the documented coin-button shortcuts (see README.md) to exercise features.
- For debugging, `mobdebug.lua` is available. You can `require "mobdebug"` and call `mobdebug.start()` during local debugging sessions (remove or gate before committing long-lived debug hooks).

3) Important files & patterns (what to inspect first)
- `fbneo-training-mode.lua` — main runtime, configuration merging, registration system (`registers.registerbefore/registerafter/guiregister`), addon loading, CIG helper for GUI navigation.
- `games/<slug>/<slug>.lua` — per-game memory mapping; must define a `translationtable` (input names -> indices) and memory offsets used by game-specific logic.
- `games/<slug>/config.lua` — optional gamedefaultconfig merged into runtime `config` via `tableio.lua`.
- `guipages.lua` — the interactive GUI pages and common `guielements` used across games and addons.
- `addon/` — place global addons in `addon/` and list them in `addon/addons.lua` for automatic loading; game-specific addons live in `games/<slug>/addon/`.
- `hitboxes/` — hitbox parsing modules referenced from the main `games` table (e.g. `hitboxes = "kof-hitboxes"`).
- `tableio.lua` — canonical persistence helper: `table.save(tbl, path)` and `table.load(path)`. Saved tables include the safety header (`assert(rb,"Run fbneo-training-mode.lua")`).

4) Conventions & gotchas (repo-specific)
- Files intended to be run inside the emulator should begin with: `assert(rb, "Run fbneo-training-mode.lua")`.
- Memory helpers are aliased at top-level: `rb/rw/wb/ww/wdw` and may be stubbed during replay mode; be careful when writing memory during `REPLAY` mode (writes may be disabled).
- Use the registration tables to attach runtime behavior instead of scheduling ad-hoc globals: insert into `registers.guiregister`, `registers.registerbefore`, or `registers.registerafter` depending on ordering needs.
- GUI navigation uses `changeInteractiveGuiPage`, `changeInteractiveGuiSelection`, and the `CIG(page, selection)` macro (call `CIG("page_name", 1)` to switch pages).
- Addons: list the filename in `addon/addons.lua` to make it run automatically; per-game addon overrides found in `games/<slug>/addon/addons.lua`.
- Hitbox modules are plain Lua under `hitboxes/` and are referenced by name from the main `games` table. Add new files there and update the `games` table entry if needed.
- Persistence: the repo uses `table.save`/`table.load` (not JSON). The file format expects Lua table data; follow `tableio.lua` semantics when producing save files.

5) Adding a new game — minimal steps (example)
- Create directory `games/<slug>/`.
- Add `games/<slug>/<slug>.lua` containing at least:
  - `translationtable = { ... }` mapping input names to indices (see `games/xmvsf/xmvsf.lua` for an example).
  - memory offsets and helper functions used by training code.
- Optional: `games/<slug>/config.lua` to set `gamedefaultconfig` keys.
- Optional: `games/<slug>/addon/` for game-specific addons and `games/<slug>/guipages.lua` to customize GUI pages.
- If you add hitbox parsing, drop `hitboxes/<name>.lua` and reference it in the `games` index in `fbneo-training-mode.lua`.

6) Debugging & runtime checks
- Use `gui.text`, `emu.message` and `print` for quick in-emulator diagnostics.
- Use `mobdebug.lua` for remote stepping; remember to remove or gate the start call before committing.
- Expect many globals: changing global names or removing expectations (e.g., `interactivegui`, `inputs`, `modulevars`) can break multiple modules.

7) Tests / CI / Build
- There is no automated test suite or CI configuration in the repo. Testing is manual inside the emulator.
- When changing runtime behavior: provide a short PR description showing how to manually exercise the change in-emulator (which game, which menu, expected visual changes).

8) Small stylistic notes for PRs
- Prefix new files that are intended to be executed by the emulator with the `assert(rb, "Run fbneo-training-mode.lua")` header.
- Keep long-running / blocking work out of top-level loops; prefer the registered hooks and `emu.frameadvance()` if you need to throttle.
- When adding persistence files, use `table.save` so the saved files are loadable with `table.load` and include the `assert` header.

9) Where to look for examples
- Game module: `games/xmvsf/xmvsf.lua`
- Hitboxes: `hitboxes/kof-hitboxes.lua` and `hitboxes/sf2-hitboxes.lua`
- An addon: `addon/missions.lua` and `addon/addons.lua`
- GUI patterns: `guipages.lua`
- Persistence: `tableio.lua`

If anything here is unclear or you'd like examples expanded (e.g. a concrete "add-a-game" skeleton), tell me which sections to expand and I'll iterate. ✅
