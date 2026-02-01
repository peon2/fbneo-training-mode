-- tests/test_guard.lua
local luaunit = require("addon.kof_training.tests.luaunit")
local harness = require("addon.kof_training.tests.test_harness")

-- Globals expected by kof_training
-- We assume kof_training has already been required once to load its globals (KOF_CONFIG, functions)
-- But we need to make sure we are testing the logic with OUR mocks.

TestGuard = {}

function TestGuard:setUp()
    harness.setup()

    -- Reset KOF_CONFIG to defaults
    KOF_CONFIG.GUARD.guard_mode = 0
    KOF_CONFIG.GUARD.dummy_action = 0 -- Standing

    -- Reset state machine if exposed, or ensure transitionToState works via mocks
    -- Since state variables are local to kof_training.lua, we might need to reset them
    -- if we can't access them directly.
    -- A workaround is to trigger a transition to "start" via logic.
    -- Or just rely on the fact that we are mocking memory, so internal state might drift
    -- but input/output should be deterministic based on memory.

    -- Important: Addresses used in kof_training.lua (must match the file)
    self.p1hitstatus = 0x108172
    self.p2hitstatus = 0x108372
    self.p2blockstun = 0x1083E3
    self.p2move = 0x108373
end

function TestGuard:tearDown()
    harness.teardown()
end

function TestGuard:testOneHitGuard_Trigger()
    -- Config: 1 Hit Guard
    KOF_CONFIG.GUARD.guard_mode = 4

    -- Setup: P2 is NOT being hit initially
    harness.set_memory(self.p2hitstatus, 0)
    harness.advance_frame()

    -- Run logic (we need access to the loop function, usually 'block' or 'Run')
    -- Since 'block' is local, we must test 'Run()' or whatever public function calls it.
    -- Looking at kof_training.lua: Run() calls checkFrameAdvantage and infiniteTime,
    -- but the STATE MACHINE loop ('start' -> 'blocking') is inside Run() (lines 1976+) based on state.

    -- We assume current state is 'start'.
    -- To test 'block()', we need to be in 'blocking' state.
    -- But '1 Hit Guard' logic is inside 'block()'? No, let's check the code.
    -- Line 1191: "if KOF_CONFIG.GUARD.guard_mode == 4 then" is inside block().
    -- So we need to transition to 'blocking' state first.
    -- In 'start' state (Run, line 2044), it transitions to blocking if guard_mode > 0.

    -- Step 1: Execute Run() to transition to 'blocking'
    -- Mock 'isOnWakeUp' (0x108321) to 0
    harness.set_memory(0x108321, 0)

    -- Execute Run
    Run()

    -- Expectation: Should be in 'blocking' state now.
    -- We can verify by checking if 'block' behavior executes next frame.

    -- Step 2: Simulate HIT
    harness.set_memory(self.p2hitstatus, 1) -- P2 is being hit
    harness.advance_frame()
    Run()

    -- In 1 Hit Guard:
    -- "Detect hit -> arm the guard"
    -- If wasHit is true, one_hit_guard_triggered = true.

    -- Step 3: Simulate Hit Over (now we should guard)
    harness.set_memory(self.p2hitstatus, 0) -- Hit ended

    -- We need P1 to ATTACK to trigger the actual guard execution in "one_hit_guard_triggered" state?
    -- Line 1200: "local isAttackTriggered = P1ActionIsExecuting() or isBlocking"
    -- If trigger is sustained, it executes.

    -- Let's simulate P1 attacking
    -- P1ActionIsExecuting checks base_action_adress (p1hitstatus + 1)
    harness.set_memory(self.p1hitstatus + 1, 10) -- Arbitrary action code (not 0)

    harness.advance_frame()
    Run()

    -- Verify Joypad has "Back" input
    -- For P2, getBlockingDirection depends on facing.
    -- Default 0 = facing right? -> Back is Left?
    -- Let's check 'P2 Left' or 'P2 Right'
    local p2_left = harness.get_joypad("P2 Left")
    local p2_right = harness.get_joypad("P2 Right")

    -- We expect SOME guarding.
    luaunit.assertTrue(p2_left == 1 or p2_right == 1, "P2 should be holding back/block")
end

function TestGuard:testOneHitGuard_NoTrigger_IfNoHit()
    -- Config: 1 Hit Guard
    KOF_CONFIG.GUARD.guard_mode = 4

    -- Setup: P2 never hit
    harness.set_memory(self.p2hitstatus, 0)
    harness.set_memory(0x108321, 0) -- Not wakeup

    -- Transition to blocking
    Run()
    harness.advance_frame()

    -- Simulate P1 attacking (but P2 wasn't hit yet)
    harness.set_memory(self.p1hitstatus + 1, 10)

    Run()

    local p2_left = harness.get_joypad("P2 Left")
    local p2_right = harness.get_joypad("P2 Right")

    -- Should NOT block yet
    luaunit.assertNil(p2_left, "P2 should not block before hit")
    luaunit.assertNil(p2_right, "P2 should not block before hit")
end

return TestGuard
