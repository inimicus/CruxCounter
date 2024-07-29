-- -----------------------------------------------------------------------------
-- Aura.lua
-- -----------------------------------------------------------------------------

local WM         = WINDOW_MANAGER
local CC         = CruxCounter
local Orbit      = CruxCounter_Orbit
local Ring       = CruxCounter_Ring

--- @class CruxCounter_Aura
--- @field New fun(self, control: any)
CruxCounter_Aura = ZO_InitializingObject:Subclass()

--- Initialize the Aura
--- @param control any Element control
--- @return nil
function CruxCounter_Aura:Initialize(control)
    self.control = control
    self.fragment = nil
    self.hideOutOfCombat = CC.Settings:Get("hideOutOfCombat")
    self.locked = CC.Settings:Get("locked")

    self.ring = Ring:New(control:GetNamedChild("BG"))
    self.orbit = Orbit:New(control:GetNamedChild("Orbit"))
    self.count = control:GetNamedChild("Count")

    self:SetHandlers()
end

--- Set whether or not the Number element disable is enabled
--- @param enabled boolean True to enable the element
--- @return nil
function CruxCounter_Aura:SetNumberEnabled(enabled)
    self.count:SetHidden(not enabled)
end

--- Set the color of the Number element
--- @param color ZO_ColorDef
--- @return nil
function CruxCounter_Aura:SetNumberColor(color)
    self.count:SetColor(color:UnpackRGBA())
end

--- Apply settings to the Aura
--- @return nil
function CruxCounter_Aura:ApplySettings()
    local settings = CC.Settings:Get()

    -- Aura settings
    self:SetPosition(settings.top, settings.left)
    self:SetMovable(not settings.locked)
    self:SetSize(settings.size)

    -- Combat settings
    CC.Events:UpdateCombatState()

    -- Other control settings
    local number = CC.Settings:GetElement("number")
    self:SetNumberEnabled(number.enabled)
    self:SetNumberColor(ZO_ColorDef:New(number.color))
    self.ring:ApplySettings()
    self.orbit:ApplySettings()
end

--- Hide the counter display
--- @return nil
function CruxCounter_Aura:Hide()
    if not self.control:IsHidden() then
        self.control:SetHidden(true)
    end
end

--- Show/unhide the counter display
--- @return nil
function CruxCounter_Aura:Unhide()
    if self.control:IsHidden() then
        self.control:SetHidden(false)
    end
end

--- Set the Aura position
--- @param top number Top position
--- @param left number Left position
--- @return nil
function CruxCounter_Aura:SetPosition(top, left)
    self.control:ClearAnchors()
    self.control:SetAnchor(CENTER, GuiRoot, CENTER, left, top)
end

--- Move the Aura to center
--- @return nil
function CruxCounter_Aura:MoveToCenter()
    self:SetPosition(0, 0)
end

--- Setup handlers for the Aura
--- @return nil
function CruxCounter_Aura:SetHandlers()
    self.control.OnMoveStop = function()
        CC.Debug:Trace(3, "Aura OnMoveStop")
        local centerX, centerY = self.control:GetCenter()
        local parentCenterX, parentCenterY = self.control:GetParent():GetCenter()
        local top, left = centerY - parentCenterY, centerX - parentCenterX
        CC.Debug:Trace(3, "Top: <<1>> Left: <<2>>", top, left)
        CC.Settings:SavePosition(top, left)
    end

    self.control:SetHandler("OnMouseEnter", function()
        if CC.Settings:Get("locked") then return end
        WM:SetMouseCursor(MOUSE_CURSOR_PAN)
    end)

    self.control:SetHandler("OnMouseExit", function()
        if CC.Settings:Get("locked") then return end
        WM:SetMouseCursor(MOUSE_CURSOR_DO_NOT_CARE)
    end)
end

--- Set the counter display size
--- @param size number Counter size in (roughly) pixels, is divided by the default size to set the float scale amount
--- @return nil
function CruxCounter_Aura:SetSize(size)
    self:SetScale(size / CC.Settings:GetDefault("size"))
end

--- Set the scale of the counter display
--- @param scale number Float scaling value
--- @return nil
function CruxCounter_Aura:SetScale(scale)
    self.control:SetScale(scale)
end

--- Setup scenes the addon should appear
--- @return nil
function CruxCounter_Aura:AddSceneFragments()
    if self.fragment ~= nil then return end

    self.fragment = ZO_SimpleSceneFragment:New(self.control)

    HUD_UI_SCENE:AddFragment(self.fragment)
    HUD_SCENE:AddFragment(self.fragment)
end

--- Remove fragments from scenes
--- @return nil
function CruxCounter_Aura:RemoveSceneFragments()
    if self.fragment == nil then return end

    HUD_UI_SCENE:RemoveFragment(self.fragment)
    HUD_SCENE:RemoveFragment(self.fragment)

    self.fragment = nil
end

--- Update the elements with a new count
--- @return nil
function CruxCounter_Aura:UpdateCount(count)
    CC.Debug:Trace(1, "Updating Aura count to <<1>>", count)
    self.count:SetText(count)
    self.orbit:UpdateCount(count)
    self.ring:UpdateCount(count)
end

--- Set whether or not the Aura can be moved
--- @param movable boolean True enable moving
--- @return nil
function CruxCounter_Aura:SetMovable(movable)
    CC.Debug:Trace(2, "Setting movable <<1>>", movable)
    self.locked = not movable
    self.control:SetMovable(movable)
end

--- Initialization of the Aura display
--- @return nil
function CruxCounter_Aura_OnInitialized(control)
    CruxCounter_Display = CruxCounter_Aura:New(control)
end

--- When the Aura has stopped moving, handle the move
--- @return nil
function CruxCounter_Aura_OnMoveStop(self)
    self.OnMoveStop()
end
