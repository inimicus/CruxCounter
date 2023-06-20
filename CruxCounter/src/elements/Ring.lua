-- -----------------------------------------------------------------------------
-- Ring.lua
-- -----------------------------------------------------------------------------

local AM   = ANIMATION_MANAGER

local CC   = CruxCounter
local db   = CruxCounter.Debug

local Ring = ZO_InitializingObject:Subclass()

function Ring:Initialize(control)
    self.control = control

    self.timelines = {
        rotate  = AM:CreateTimelineFromVirtual("CruxCounter_RotateBG", self.control),
        fadeIn  = AM:CreateTimelineFromVirtual("CruxCounter_CruxFadeIn", self.control),
        fadeOut = AM:CreateTimelineFromVirtual("CruxCounter_CruxFadeOut", self.control),
    }

    control.OnHidden = function()
        db:Trace(0, "Ring OnHidden")
        -- TODO: Handle hidden
    end

    control.OnShow = function()
        db:Trace(0, "Ring OnShow")
        -- TODO: Handle show
    end
end

CC.elements.Ring = Ring
