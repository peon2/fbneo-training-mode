-- addon/pechan_training_mod/core/player.lua

-- Define the Player class
local Player = {}
Player.__index = Player

-- Constructor for the Player class
function Player:new(id, base_address, offsets, role)
    local self = setmetatable({}, Player)

    self.id = id
    self.base_address = base_address
    self.offsets = offsets
    self.role = role or "Human" -- "Human" or "Dummy"

    -- Calculate memory addresses from offsets
    self.addresses = {
        hitstatus = base_address + offsets.hitstatus,
        blockstun = base_address + offsets.blockstun,
        action = base_address + offsets.action
    }

    -- Frame data tracking state
    self.frame_data = {
        blockstun_value = 0,
        blockstun_last_updated_frame = -1,
        hitstun_value = 0,
        hitstun_last_updated_frame = -1,
        entered_blockstun = false
    }

    -- Advantage calculation state
    self.advantage_state = {
        measuring = false,
        frame_advantage = 0,
        last_checked_frame = -1,
        past_frame_act = 0,
        recovery_frames = 0,
        blockstun_frames = 0,
        adv_type = "Block"
    }

    return self
end

-- Memory Reading Methods
function Player:isBeingHit()
    return rb(self.addresses.hitstatus) ~= 0
end

function Player:getRawActionByte()
    return rb(self.addresses.action)
end

function Player:getExecutingAction()
    return rw(self.addresses.action)
end

function Player:getCurrentBlockstun()
    local blockstun_val = rb(self.addresses.blockstun)
    if blockstun_val == 0x20 or blockstun_val == 0xA0 then
        local current_frame = emu.framecount()
        if current_frame ~= self.frame_data.blockstun_last_updated_frame then
            self.frame_data.blockstun_last_updated_frame = current_frame
            self.frame_data.blockstun_value = self.frame_data.blockstun_value + 1
        end
        return self.frame_data.blockstun_value
    end

    self.frame_data.blockstun_value = 0
    return 0
end

function Player:getCurrentHitstun()
    if self:isBeingHit() then
        local current_frame = emu.framecount()
        if current_frame ~= self.frame_data.hitstun_last_updated_frame then
            self.frame_data.hitstun_last_updated_frame = current_frame
            self.frame_data.hitstun_value = self.frame_data.hitstun_value + 1
        end
        return self.frame_data.hitstun_value
    end

    self.frame_data.hitstun_value = 0
    return 0
end

-- A helper to filter action codes (similar to filterAct in init.lua)
function Player:filterAct(act)
    if act == 258 or act == 0 or act == 259 or act == 514 or act == 515 or act == 770 or act == 768 then
        return 0
    end
    return act
end

-- The main advantage tracking loop that replaces checkFrameAdvantage
function Player:updateAdvantage(opponent)
    local current_frame = emu.framecount()
    if current_frame == self.advantage_state.last_checked_frame then
        return
    end
    self.advantage_state.last_checked_frame = current_frame

    local act = self:getExecutingAction()
    local filtered_act = self:filterAct(act)

    -- Check opponent's stuns to see if we scored a hit/block
    local op_blockstun = opponent:getCurrentBlockstun()
    local op_hitstun = opponent:getCurrentHitstun()

    -- 1. DETECTION
    if op_blockstun == 1 then
        self.advantage_state.measuring = true
        self.advantage_state.adv_type = "Block"
        self.advantage_state.recovery_frames = 0
        self.advantage_state.blockstun_frames = 0
        self.advantage_state.frame_advantage = 0
        self.advantage_state.past_frame_act = filtered_act
    elseif op_hitstun == 1 then
        self.advantage_state.measuring = true
        self.advantage_state.adv_type = "Hit"
        self.advantage_state.recovery_frames = 0
        self.advantage_state.blockstun_frames = 0
        self.advantage_state.frame_advantage = 0
        self.advantage_state.past_frame_act = filtered_act
    end

    if self.advantage_state.measuring then
        -- 2. DYNAMIC TRACKING
        local current_op_stun = (self.advantage_state.adv_type == "Block") and op_blockstun or op_hitstun
        if current_op_stun ~= 0 then
            self.advantage_state.blockstun_frames = self.advantage_state.blockstun_frames + 1
        end

        if filtered_act ~= 0 then
            self.advantage_state.recovery_frames = self.advantage_state.recovery_frames + 1
        end

        -- 3. CANCELLATION DETECTION
        if filtered_act ~= 0 and self.advantage_state.past_frame_act ~= 0 and filtered_act ~= self.advantage_state.past_frame_act then
            self.advantage_state.recovery_frames = 1
            self.advantage_state.blockstun_frames = (current_op_stun > 0) and 1 or 0
        end
        self.advantage_state.past_frame_act = filtered_act

        -- 4. LIVE CALCULATION
        self.advantage_state.frame_advantage = self.advantage_state.blockstun_frames -
        self.advantage_state.recovery_frames

        -- 5. TERMINATION
        if (op_blockstun == 0 and op_hitstun == 0) and act == 0 then
            self.advantage_state.measuring = false
        end
    end
end

return Player
