-- -----------------------------------------------------------------------------
-- Interface.lua
-- -----------------------------------------------------------------------------

local M           = {}
local AM          = ANIMATION_MANAGER
local WM          = WINDOW_MANAGER
local CC          = CruxCounter

local db
local s

-- -----------------------------------------------------------------------------
-- Local XML Globals
-- Update globals in .luarc.json
-- -----------------------------------------------------------------------------

local aura        = CruxCounter_Aura
local orbit       = CruxCounter_AuraOrbit
local count       = CruxCounter_AuraCount

--- @type table Shorthand animation names
local animations  = {
    cruxFadeIn       = "CruxCounter_CruxFadeIn",
    cruxFadeOut      = "CruxCounter_CruxFadeOut",
    cruxSmoke        = "CruxCounter_CruxSmokeDontBreatheThis",
    rotateControlCCW = "CruxCounter_RotateControlCCW",
    rotateControlCW  = "CruxCounter_RotateControlCW",
    rotateBG         = "CruxCounter_RotateBG",
}

-- -----------------------------------------------------------------------------
-- Defaults
-- -----------------------------------------------------------------------------

--- @type number Distance from center of rotation
local orbitRadius = 32

--- @type table|nil Scene fragment
local fragment

--- Set the rotation around the orbit
--- @param control any Degrees of rotation
--- @param degrees number Degrees of rotation
--- @return nil
local function setRuneRotation2D(control, degrees)
    local x, y = ZO_Rotate2D(math.rad(degrees), 0, orbitRadius)
    control:SetAnchor(CENTER, orbit, CENTER, x, y)
end

--- Setup scenes the addon should appear
--- @return nil
function M:AddSceneFragments()
    fragment = ZO_SimpleSceneFragment:New(aura)
    HUD_UI_SCENE:AddFragment(fragment)
    HUD_SCENE:AddFragment(fragment)
end

function M:RemoveSceneFragments()
    HUD_UI_SCENE:RemoveFragment(fragment)
    HUD_SCENE:RemoveFragment(fragment)
end

--- Initialize Crux runes and associated functionality
--- @param num integer Index of the rune to init
--- @return nil
local function initCrux(num)
    local control = orbit:GetNamedChild("Crux" .. num)

    local rune = {
        isShowing        = function()
            return control:GetAlpha() == 1
        end,
        control          = control,
        startingRotation = 360 - (360 / num),
        timelines        = {
            fadeIn   = AM:CreateTimelineFromVirtual(animations.cruxFadeIn, control),
            fadeOut  = AM:CreateTimelineFromVirtual(animations.cruxFadeOut, control),
            smoke    = AM:CreateTimelineFromVirtual(animations.cruxSmoke, control:GetNamedChild("Smoke")),
            rotation = AM:CreateTimelineFromVirtual(animations.rotateControlCW, control)
        },
    }

    setRuneRotation2D(control, rune.startingRotation)

    local swoopAnimation, swoopTimeline = CreateSimpleAnimation(ANIMATION_CUSTOM, control)
    if swoopAnimation and swoopTimeline then
        swoopAnimation:SetEasingFunction(ZO_EaseOutQuadratic)
        swoopAnimation:SetUpdateFunction(function(_, progress)
            local rotation = rune.startingRotation - 60 * progress
            setRuneRotation2D(control, rotation)
        end)
        swoopAnimation:SetDuration(250)
    end

    rune.timelines.swoop = swoopTimeline

    rune.timelines.fadeOut:SetHandler("OnStop", function()
        setRuneRotation2D(control, rune.startingRotation)
    end)

    rune.timelines.smoke:PlayFromStart()

    M.runes[num] = rune
end

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

--- Setup move/drag handlers
--- @return nil
local function setHandlers()
    -- Update cursor when unlocked
    aura:SetHandler("OnMouseEnter", function()
        showMoveCursor(true)
    end)
    aura:SetHandler("OnMouseExit", function()
        showMoveCursor(false)
    end)
    aura:SetHandler("OnDragStart", function()
        db:Trace(3, "OnDragStart")
    end)
    aura:SetHandler("OnDragEnd", function()
        db:Trace(3, "OnDragEnd")
    end)
    aura:SetHandler("OnReceiveDrag", function(control)
        db:Trace(3, "OnReceiveDrag")
        local centerX, centerY = control:GetCenter()
        local parentCenterX, parentCenterY = control:GetParent():GetCenter()
        local top, left = centerY - parentCenterY, centerX - parentCenterX
        s:SavePosition(top, left)
    end)
end

-- -----------------------------------------------------------------------------
-- Module
-- -----------------------------------------------------------------------------

M.runes      = {}
M.orbit      = {}
M.background = {}

--- Set if the number element should display
--- @param show boolean True to show number
--- @return nil
function M:ShowNumber(show)
    count:SetHidden(not show)
end

--- Set if the rune elements should display
--- @param show boolean True to show runes
--- @return nil
function M:ShowRunes(show)
    orbit:SetHidden(not show)
end

--- Set if the background element should display
--- @param show boolean True to show the background element
--- @return nil
function M:ShowBackground(show)
    aura:GetNamedChild("BG"):SetHidden(not show)
end

--- Set if the rune elements should rotate
--- @param rotate boolean True to rotate the rune elements
--- @return nil
function M:RotateRunes(rotate)
    if rotate then
        self:StartOrbit()
    else
        self:StopOrbit()
    end
end

--- Set if the background element should rotate
--- @param rotate boolean True to rotate the background
--- @return nil
function M:RotateBackground(rotate)
    if rotate then
        self:StartBackground()
    else
        self:StopBackground()
    end
end

--- Set if the counter is locked
--- @param isLocked boolean True to lock the counter
--- @return nil
function M:SetLocked(isLocked)
    db:Trace(2, "Setting movable <<1>>", isLocked)
    aura:SetMovable(not isLocked)
end

--- Start the orbit animation
--- @return nil
function M:StartOrbit()
    for _, rune in ipairs(M.runes) do
        rune.timelines.rotation:PlayFromStart()
    end

    self.orbit:PlayFromStart()
end

--- Stop the orbit animation
--- @return nil
function M:StopOrbit()
    for _, rune in ipairs(M.runes) do
        rune.timelines.rotation:PlayInstantlyToStart(false)
        rune.timelines.rotation:Stop()
    end

    self.orbit:PlayInstantlyToStart(false)
    self.orbit:Stop()
end

--- Start the background animation
--- @return nil
function M:StartBackground()
    self.background:PlayFromStart(0)
end

--- Stop the background animation
--- @return nil
function M:StopBackground()
    self.background:Stop()
end

--- Stop the counter position
--- @param top number Top position
--- @param left number Left position
--- @return nil
function M:SetPosition(top, left)
    aura:ClearAnchors()
    aura:SetAnchor(CENTER, GuiRoot, CENTER, left, top)
end

--- Move the counter to the middle of the screen (over the target reticle)
--- @return nil
function M:MoveToCenter()
    self:SetPosition(0, 0)
end

--- Hide the counter display
--- @return nil
function M:Hide()
    if not aura:IsHidden() then
        aura:SetHidden(true)
    end
end

--- Show/unhide the counter display
--- @return nil
function M:Unhide()
    if aura:IsHidden() then
        aura:SetHidden(false)
    end
end

--- Set the counter display size
--- @param size number Counter size in (roughly) pixels, is divided by the default size to set the float scale amount
--- @return nil
function M:SetSize(size)
    self:SetScale(size / s.defaults.size)
end

--- Set the scale of the counter display
--- @param scale number Float scaling value
--- @return nil
function M:SetScale(scale)
    aura:SetScale(scale)
end

--- Play a sound at a specific volume
--- @param sound string Name of the sound
--- @param volume number Playback volume from 0-100%
--- @return nil
function M:PlaySound(sound, volume)
    db:Trace(3, "Playing sound <<1>> at volume <<2>>", sound, volume)

    --- Use variable for loop purposes only
    --- @diagnostic disable:unused-local
    for i = 0, volume, 10 do
        PlaySound(SOUNDS[sound])
    end
end

--- Play the sound for the given playback condition
--- @param type string Playback event type
--- @return nil
function M:PlaySoundForType(type)
    if s.settings.sounds[type].enabled then
        local sound, volume = s:GetSoundForType(type)
        self:PlaySound(sound, volume)
    end
end

--- Setup the addon interface
--- @return nil
function M:Setup()
    db = CC.Debug
    s = CC.Settings

    -- Setup Crux runes
    local numCrux = orbit:GetNumChildren();
    for i = 1, numCrux, 1 do
        initCrux(i)
    end

    M:SetPosition(s.settings.top, s.settings.left)
    setHandlers()

    -- Create default animations
    self.orbit = AM:CreateTimelineFromVirtual(animations.rotateControlCCW, orbit)
    M.background = AM:CreateTimelineFromVirtual(animations.rotateBG, aura:GetNamedChild("BG"))

    local settingsNumber = s.settings.elements.number
    local settingsRunes = s.settings.elements.runes
    local settingsBackground = s.settings.elements.background
    local hideOutOfCombat = s.settings.hideOutOfCombat

    if settingsRunes.enabled and settingsRunes.rotate then
        M:StartOrbit()
    end

    if settingsBackground.enabled and settingsBackground.rotate then
        M:StartBackground()
    end

    self:SetLocked(s.settings.locked)
    self:SetSize(s.settings.size)
    self:ShowNumber(settingsNumber.enabled)
    self:ShowRunes(settingsRunes.enabled)
    self:ShowBackground(settingsBackground.enabled)

    if not hideOutOfCombat then
        self:Unhide()
        self:AddSceneFragments()
    end
end

--- Perform update to the UI when stacks change
--- @param stackCount number Number of Crux currently active
--- @return nil
function M.UpdateStacks(stackCount)
    -- Skip updates if stacks are the same
    if count:GetText() == tostring(stackCount) then
        return
    end

    count:SetText(stackCount)

    -- Fade out all
    if stackCount == 0 then
        for _, rune in ipairs(M.runes) do
            if rune.isShowing() then
                rune.timelines.fadeOut:PlayFromStart()
            else
                rune.timelines.fadeOut:PlayInstantlyToEnd()
            end
        end

        return
    end

    -- Make sure to show as many as there are stacks
    for i = 1, stackCount, 1 do
        if not M.runes[i].isShowing() then
            M.runes[i].timelines.fadeIn:PlayFromStart()
        end
    end

    -- Move 2nd rune to make room for the third
    if stackCount == 3 then
        M.runes[2].timelines.swoop:PlayFromStart()
    end
end

CC.UI = M
