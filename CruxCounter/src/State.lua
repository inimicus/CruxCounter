-- -----------------------------------------------------------------------------
-- State.lua
-- -----------------------------------------------------------------------------

local M     = {}
local CC    = CruxCounter

--- @type integer Current number of Crux stacks
M.stacks    = 0

--- @type integer Maximum number of stacks
M.maxStacks = 3

--- @type boolean True when the player is in combat
M.inCombat  = false

-- -----------------------------------------------------------------------------
-- Stacks State
-- -----------------------------------------------------------------------------

--- Set the number of stacks to the given value
--- @param count integer Number of stacks
--- @param playSound boolean? Optional: True to evaluate sound playback logic, false to force not playing a sound
--- @return nil
function M:SetStacks(count, playSound)
    -- Set default for not provided value
    if playSound == nil then playSound = true end

    local previousStacks = self.stacks
    self.stacks = count

    -- Do nothing if stack count hasn't changed
    if count == previousStacks then
        CC.Debug:Trace(2, "Crux Unchanged: <<1>> -> <<2>>", previousStacks, count)
        return
    end

    CC.Debug:Trace(2, "Updating Crux: <<1>> -> <<2>>", previousStacks, count)
    CruxCounter_Display:UpdateCount(count)

    local soundToPlay
    if count < previousStacks then
        CC.Debug:Trace(1, "Crux Lost: <<1>> -> <<2>>", previousStacks, count)
        soundToPlay = "cruxLost"
    elseif count > previousStacks and count < self.maxStacks then
        CC.Debug:Trace(1, "Crux Gained: <<1>> -> <<2>>", previousStacks, count)
        soundToPlay = "cruxGained"
    else
        CC.Debug:Trace(1, "Max Crux: <<1>> -> <<2>>", previousStacks, count)
        soundToPlay = "maxCrux"
    end

    if playSound then
        CC.UI:PlaySoundForType(soundToPlay)
    end
end

--- Reset stack count to zero
--- @return nil
function M:ClearStacks()
    self:SetStacks(0)
end

-- -----------------------------------------------------------------------------
-- Combat State
-- -----------------------------------------------------------------------------

--- Set the combat state
--- @param inCombat boolean
--- @return nil
function M:SetInCombat(inCombat)
    self.inCombat = inCombat
end

CC.State = M
