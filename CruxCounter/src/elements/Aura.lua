-- -----------------------------------------------------------------------------
-- Aura.lua
-- -----------------------------------------------------------------------------

local WM    = WINDOW_MANAGER

local CC    = CruxCounter
local db    = CruxCounter.Debug
local s     = CruxCounter.Settings

local Orbit = CC.elements.Orbit
local Ring  = CC.elements.Ring
local Aura  = ZO_InitializingObject:Subclass()

--- When moving/movable, show the move (pan) cursor
--- @param moving boolean Is the counter moving/able to be moved?
--- @return nil
local function showMoveCursor(moving)
    if s.settings.locked then
        return
    end

    if moving then
        WM:SetMouseCursor(MOUSE_CURSOR_PAN)
    else
        WM:SetMouseCursor(MOUSE_CURSOR_DO_NOT_CARE)
    end
end

function Aura:Initialize(control)
    self.control = control
    self.fragment = nil
    self.ring = Ring:New(control:GetNamedChild("BG"))
    self.orbit = Orbit:New(control:GetNamedChild("Orbit"))
    self.count = control:GetNamedChild("Count")

    self:SetHandlers()
    self:AddSceneFragments()
end

function Aura:ApplySettings(settings)

end

function Aura:SetHandlers()
    self.control.OnHidden = function()
        db:Trace(0, "Aura OnHidden")
        -- TODO: Handle hidden
    end

    self.control.OnShow = function()
        db:Trace(0, "Aura OnShow")
        -- TODO: Handle show
    end

    self.control.OnMoveStop = function()
        db:Trace(3, "Aura OnMoveStop")
        local centerX, centerY = self.control:GetCenter()
        local parentCenterX, parentCenterY = self.control:GetParent():GetCenter()
        local top, left = centerY - parentCenterY, centerX - parentCenterX
        db:Trace(3, "Top: <<1>> Left: <<2>>", top, left)
        -- s:SavePosition(top, left)
    end

    self.control.OnMouseEnter = function()
        db:Trace(3, "Aura OnMouseEnter")
        showMoveCursor(true)
    end

    self.control.OnMouseExit = function()
        db:Trace(3, "Aura OnMouseExit")
        showMoveCursor(false)
    end
end

--- Setup scenes the addon should appear
--- @return nil
function Aura:AddSceneFragments()
    if self.fragment ~= nil then return end

    self.fragment = ZO_SimpleSceneFragment:New(self.control)

    HUD_UI_SCENE:AddFragment(self.fragment)
    HUD_SCENE:AddFragment(self.fragment)
end

--- Remove fragments from scenes
--- @return nil
function Aura:RemoveSceneFragments()
    if self.fragment == nil then return end

    HUD_UI_SCENE:RemoveFragment(self.fragment)
    HUD_SCENE:RemoveFragment(self.fragment)

    self.fragment = nil
end

function Aura:PlayFromStart()
end

function Aura:UpdateCount(count)
    self.count:SetText(count)
end

function Aura:SetMovable(movable)
    db:Trace(2, "Setting movable <<1>>", movable)
    self.control:SetMovable(movable)
end

function Aura:GetOrbit()
    return self.orbit
end

function Aura:GetRing()
    return self.ring
end

function CruxCounter_Aura_OnInitialized(self)
    CruxCounter_Aura = Aura:New(self)
end

function CruxCounter_Aura_OnHidden(self)
    self.OnHidden()
end

function CruxCounter_Aura_OnShow(self)
    self.OnShow()
end

function CruxCounter_Aura_OnMoveStop(self)
    self.OnMoveStop()
end

CC.elements.Aura = Aura
