-- -----------------------------------------------------------------------------
-- Rune.lua
-- -----------------------------------------------------------------------------

local AM          = ANIMATION_MANAGER
local orbitRadius = 32

--- @class CruxCounter_Rune
--- @field New fun(self, control: any, index: number)
CruxCounter_Rune  = ZO_InitializingObject:Subclass()

--- Initialize the Aura
--- @param control any Element control
--- @param num number Rune index
--- @return nil
function CruxCounter_Rune:Initialize(control, num)
    self.control = control
    self.number = num
    self.startingRotation = 360 - (360 / num)

    self.smoke = {
        control = self.control:GetNamedChild("Smoke"),
        timeline = AM:CreateTimelineFromVirtual("CruxCounter_CruxSmokeDontBreatheThis",
            self.control:GetNamedChild("Smoke")),
    }

    self:SetRotation2D(self.startingRotation)

    local swoopAnimation, swoopTimeline = CreateSimpleAnimation(ANIMATION_CUSTOM, self.control)
    if swoopAnimation and swoopTimeline then
        swoopAnimation:SetEasingFunction(ZO_EaseOutQuadratic)
        swoopAnimation:SetUpdateFunction(function(_, progress)
            local rotation = self.startingRotation - 60 * progress
            self:SetRotation2D(rotation)
        end)
        swoopAnimation:SetDuration(250)
    end

    self.timelines = {
        fadeIn   = AM:CreateTimelineFromVirtual("CruxCounter_CruxFadeIn", self.control),
        fadeOut  = AM:CreateTimelineFromVirtual("CruxCounter_CruxFadeOut", self.control),
        rotation = AM:CreateTimelineFromVirtual("CruxCounter_RotateControlCW", self.control),
        swoop    = swoopTimeline,
    }

    self.timelines.fadeOut:SetHandler("OnStop", function()
        self:SetRotation2D(self.startingRotation)
        self.smoke.timeline:Stop()
    end)

    self.timelines.fadeIn:SetHandler("OnPlay", function()
        self.smoke.timeline:PlayFromStart()
    end)

    control.OnHidden = function()
        self.smoke.timeline:Stop()
    end

    control.OnShow = function()
        self.smoke.timeline:PlayFromStart()
    end
end

--- Play the Rune rotation animation
--- @return nil
function CruxCounter_Rune:PlayRotation()
    self.timelines.rotation:PlayFromStart()
end

--- Stop the Rune rotation animation
--- @return nil
function CruxCounter_Rune:StopRotation()
    self.timelines.rotation:PlayInstantlyToStart(false)
    self.timelines.rotation:Stop()
end

--- Show the Rune via the fadeIn animation
--- @return nil
function CruxCounter_Rune:Show()
    self.timelines.fadeIn:PlayFromStart()
end

--- Hide the Rune via the fadeOut animation
--- @return nil
function CruxCounter_Rune:Hide()
    self.timelines.fadeOut:PlayFromStart()
end

--- Hide the Rune instantly via the fadeOut animation
--- @return nil
function CruxCounter_Rune:HideInstantly()
    self.timelines.fadeOut:PlayInstantlyToEnd()
end

--- Play the position shift swoop animation
--- @return nil
function CruxCounter_Rune:PlayPositionShift()
    self.timelines.swoop:PlayFromStart()
end

--- Set the position of the Rune
--- @param degrees number Amount to rotate the Rune in degrees
--- @return nil
function CruxCounter_Rune:SetRotation2D(degrees)
    local x, y = ZO_Rotate2D(math.rad(degrees), 0, orbitRadius)
    local parent = self.control:GetParent()
    self.control:SetAnchor(CENTER, parent, CENTER, x, y)
end

--- Set the Rune rotation animation duration
--- @return nil
function CruxCounter_Rune:SetDuration(duration)
    self.timelines.rotation:GetFirstAnimation():SetDuration(duration)
end

--- Is the Rune element showing?
--- @return boolean showing True when the Rune is showing
function CruxCounter_Rune:IsShowing()
    return self.control:GetAlpha() == 1
end
