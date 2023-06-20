-- -----------------------------------------------------------------------------
-- Rune.lua
-- -----------------------------------------------------------------------------

local AM   = ANIMATION_MANAGER

local CC   = CruxCounter
local db   = CruxCounter.Debug
local s    = CruxCounter.Settings

local Rune = ZO_InitializingObject:Subclass()

function Rune:Initialize(control, num)
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
    end)

    self.smoke.timeline:PlayFromStart()

    self.timelines.rotation:GetFirstAnimation():SetDuration(s.settings.elements.runes.rotationSpeed)
    self.timelines.rotation:PlayFromStart()

    control.OnHidden = function()
        db:Trace(0, "Rune OnHidden")
        self.smoke.timeline:Stop()
    end

    control.OnShow = function()
        db:Trace(0, "Rune OnShow")
        self.smoke.timeline:PlayFromStart()
    end
end

function Rune:SetRotation2D(degrees)
    -- TODO: Global orbit radius, 32 below?
    local x, y = ZO_Rotate2D(math.rad(degrees), 0, 32)
    local parent = self.control:GetParent()
    self.control:SetAnchor(CENTER, parent, CENTER, x, y)
end

function Rune:SetDuration(duration)
    self.timelines.rotation:GetFirstAnimation():SetDuration(duration)
end

function Rune:PlayFromStart()
    self.timelines.rotation:PlayFromStart()
end

function Rune:IsShowing()
    return self.control:GetAlpha() == 1
end

CC.elements.Rune = Rune
