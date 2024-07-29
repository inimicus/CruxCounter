-- -----------------------------------------------------------------------------
-- Ring.lua
-- -----------------------------------------------------------------------------

local AM         = ANIMATION_MANAGER
local CC         = CruxCounter

--- @class CruxCounter_Ring
--- @field New fun(self, control: any)
CruxCounter_Ring = ZO_InitializingObject:Subclass()

--- Initialize the Aura
--- @param control any Element control
--- @return nil
function CruxCounter_Ring:Initialize(control)
    self.control = control

    local settings = CC.Settings:GetElement("background")
    self.enabled = settings.enabled
    self.rotationEnabled = settings.rotate
    self.hideZeroStacks = settings.hideZeroStacks

    self.timelines = {
        rotate  = AM:CreateTimelineFromVirtual("CruxCounter_RotateBG", self.control),
        fadeIn  = AM:CreateTimelineFromVirtual("CruxCounter_CruxFadeIn", self.control),
        fadeOut = AM:CreateTimelineFromVirtual("CruxCounter_CruxFadeOut", self.control),
    }
end

--- Apply settings to the Ring background
--- @return nil
function CruxCounter_Ring:ApplySettings()
    local ring = CC.Settings:GetElement("background")

    self:SetEnabled(ring.enabled)
    self:SetRotationEnabled(ring.rotate)
    self:SetHideZeroStacks(ring.hideZeroStacks)
    self:SetColor(ZO_ColorDef:New(ring.color))
end

--- Start the Ring rotation animation
--- @return nil
function CruxCounter_Ring:StartRotation()
    self.timelines.rotate:PlayFromStart()
end

--- Stop the Ring rotation animation
--- @return nil
function CruxCounter_Ring:StopRotation()
    self.timelines.rotate:Stop()
end

--- Is the Ring background currently hidden?
--- @return boolean hidden True when the background Ring is hidden
function CruxCounter_Ring:IsHidden()
    return self.control:GetAlpha() == 0 or self.control:IsHidden()
end

--- Set whether or not the Ring background should show
--- @param shouldShow boolean True to show the Ring background
--- @return nil
function CruxCounter_Ring:SetShowing(shouldShow)
    local hidden = self:IsHidden()
    local animation = shouldShow and "fadeIn" or "fadeOut"

    -- Skip animation when already in preferred state
    -- Play instantly to ensure a known playback position
    if (not shouldShow and hidden) or (shouldShow and not hidden) then
        self.timelines[animation]:PlayInstantlyToEnd()
    else
        self.timelines[animation]:PlayFromStart()
    end
end

--- Set whether or not the Ring background is enabled
--- @param enabled boolean True to enable the Ring background
--- @return nil
function CruxCounter_Ring:SetEnabled(enabled)
    self.enabled = enabled
    self.control:SetHidden(not enabled)
    self:UpdateRotation()
end

--- Set the Ring background color
--- @param color ZO_ColorDef
--- @return nil
function CruxCounter_Ring:SetColor(color)
    self.control:SetColor(color:UnpackRGBA())
end

--- Set whether or not the Ring background animation is enabled
--- @param rotationEnabled boolean True to enable the Ring background animation
--- @return nil
function CruxCounter_Ring:SetRotationEnabled(rotationEnabled)
    self.rotationEnabled = rotationEnabled
    self:UpdateRotation()
end

--- Set whether or not to hide the Ring background on zero stacks
--- @param hideZero boolean True to hide the Ring background on zero stacks
--- @return nil
function CruxCounter_Ring:SetHideZeroStacks(hideZero)
    self.hideZeroStacks = hideZero
    if hideZero then
        self:SetShowing(CC.State.stacks > 0)
    else
        self:SetShowing(true)
    end
end

--- Update the Ring background rotation
--- Ensures it's playing when it should and isn't when it shouldn't
--- @return nil
function CruxCounter_Ring:UpdateRotation()
    local timeline = self.timelines.rotate

    if not timeline then return end

    if self.enabled and self.rotationEnabled then
        if not timeline:IsPlaying() then
            timeline:PlayFromStart()
        end
    else
        if timeline:IsPlaying() then
            timeline:Stop()
        end
    end
end

--- Update the count for use with the hideZeroStacks option
--- @param count number Number of stacks
--- @return nil
function CruxCounter_Ring:UpdateCount(count)
    if self.hideZeroStacks then
        self:SetShowing(count > 0)
    else
        self:SetShowing(true)
    end
end
