-- -----------------------------------------------------------------------------
-- Orbit.lua
-- -----------------------------------------------------------------------------

local AM    = ANIMATION_MANAGER

local CC    = CruxCounter
local db    = CruxCounter.Debug

local Rune  = CC.elements.Rune
local Orbit = ZO_InitializingObject:Subclass()

function Orbit:Initialize(control)
    self.control = control
    self.runes = {}
    self:InitializeCrux()

    self.timeline = AM:CreateTimelineFromVirtual("CruxCounter_RotateControlCCW", self.control)

    control.OnHidden = function()
        db:Trace(0, "Orbit OnHidden")
        -- TODO: Handle hidden
    end

    control.OnShow = function()
        db:Trace(0, "Orbit OnShow")
        -- TODO: Handle show
    end
end

function Orbit:SetDuration(duration)
    for _, rune in ipairs(self.runes) do
        rune:SetDuration(duration)
    end

    self.timeline:GetFirstAnimation():SetDuration(duration)
end

function Orbit:PlayFromStart()
    for _, rune in ipairs(self.runes) do
        rune:PlayFromStart()
    end

    self.timeline:PlayFromStart()
end

function Orbit:InitializeCrux()
    for i = 1, self.control:GetNumChildren(), 1 do
        local child = self.control:GetNamedChild("Crux" .. i)
        self.runes[i] = Rune:New(child, i)
    end
end

CC.elements.Orbit = Orbit
