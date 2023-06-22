-- -----------------------------------------------------------------------------
-- Settings.lua
-- -----------------------------------------------------------------------------

local M                   = {}
local CC                  = CruxCounter
local LAM                 = LibAddonMenu2

local addon
local db
local events
local lang
local ui

local gameSounds          = SOUNDS
local sounds              = {}

local rotationSpeedFactor = 24000

M.settings                = {}
M.dbVersion               = 0
M.savedVariables          = "CruxCounterData"
M.defaults                = {
    top             = 0,
    left            = 0,
    hideOutOfCombat = false,
    locked          = false,
    lockToReticle   = false,
    size            = 128,
    elements        = {
        number     = {
            enabled = true,
        },
        runes      = {
            enabled       = true,
            rotate        = true,
            rotationSpeed = 9600,
        },
        background = {
            enabled        = true,
            rotate         = true,
            hideZeroStacks = false,
        },
    },
    sounds          = {
        cruxGained = {
            enabled = false,
            name    = "ENCHANTING_POTENCY_RUNE_PLACED",
            volume  = 20,
        },
        cruxLost   = {
            enabled = false,
            name    = "ENCHANTING_WEAPON_GLYPH_REMOVED",
            volume  = 20,
        },
        maxCrux    = {
            enabled = true,
            name    = "DEATH_RECAP_KILLING_BLOW_SHOWN",
            volume  = 20,
        },
    },
}

--- Save counter position
--- @param top number Top position
--- @param left number Left position
--- @return nil
function M:SavePosition(top, left)
    db:Trace(2, "Saving position <<1>> x <<2>>", top, left)
    self.settings.top = top
    self.settings.left = left
end

--- Get the sound settings for a given condition type
--- @param type string Condition type
--- @return string sound The sound name
--- @return number volume The sound volume
function M:GetSoundForType(type)
    local sound = self.settings.sounds[type].name
    local volume = self.settings.sounds[type].volume

    return sound, volume
end

-- -----------------------------------------------------------------------------
-- Settings Panel Data
-- -----------------------------------------------------------------------------

--- @type table Options data
local optionsData = {}

CruxCounter_LockButton = nil
CruxCounter_MoveToCenterButton = nil

-- -----------------------------------------------------------------------------
-- Display
-- -----------------------------------------------------------------------------

--- Move the counter to the center of the screen
--- @return nil
local function moveToCenter()
    ui:Unhide()
    ui:MoveToCenter()
    M:SavePosition(0, 0)
end

--- Set the locked state of the counter
--- @param isLocked boolean True to lock the counter
--- @return nil
local function setLocked(isLocked)
    M.settings.locked = isLocked
    ui:SetLocked(isLocked)
end

--- Get the locked state of the counter
--- @return boolean isLocked True when the counter is locked
local function getLocked()
    return M.settings.locked
end

--- Get the lock to reticle state
--- @return boolean isLocked True when counter is locked to the reticle
local function getLockToReticle()
    return M.settings.lockToReticle
end

--- Get the translated locked/unlocked string
--- @return string buttonText Translated Lock/Unlock text
local function getLockUnlockButtonText()
    if getLocked() or getLockToReticle() then
        return lang:GetString("SETTINGS_UNLOCK")
    else
        return lang:GetString("SETTINGS_LOCK")
    end
end

--- Get the translated lock tooltip based on if lock to reticle is enabled
--- @return string tooltipText Translated lock button tooltip or lock to reticle warning
local function getLockUnlockTooltipText()
    if getLockToReticle() then
        return lang:GetString("SETTINGS_LOCK_TO_RETICLE_WARNING")
    else
        return lang:GetString("SETTINGS_LOCK_DESC")
    end
end

--- Get the translated move to center tooltip based on if lock to reticle is enabled
--- @return string tooltipText Translated move to center button tooltip or lock to reticle warning
local function getMoveToCenterTooltipText()
    if getLockToReticle() then
        return lang:GetString("SETTINGS_LOCK_TO_RETICLE_WARNING")
    else
        return lang:GetString("SETTINGS_MOVE_TO_CENTER_DESC")
    end
end

--- Toggle locked state of the counter
--- @param control any Lock/Unlock button control
--- @return nil
local function toggleLocked(control)
    ui:Unhide()
    setLocked(not getLocked())
    control:SetText(getLockUnlockButtonText())
end

--- Set if the counter is locked to the reticle
--- @param state boolean True to lock to reticle
--- @return nil
local function setLockToReticle(state)
    if state then
        moveToCenter()
    else
        ui.SetPosition(M.settings.top, M.settings.left)
    end

    setLocked(state)
    M.settings.lockToReticle = state

    CruxCounter_LockButton.button.data = {
        tooltipText = LAM.util.GetStringFromValue(getLockUnlockTooltipText())
    }
    CruxCounter_MoveToCenterButton.button.data = {
        tooltipText = LAM.util.GetStringFromValue(getMoveToCenterTooltipText())
    }
    CruxCounter_LockButton.button:SetText(getLockUnlockButtonText())
end

--- Set the lock to reticle state
--- @param hide boolean Set true to lock the counter to the reticle
--- @return nil
local function setHideOutOfCombat(hide)
    M.settings.hideOutOfCombat = hide
    if hide then
        ui.Hide()
        events:RegisterForCombat()
    else
        events:UnregisterForCombat()
        ui.Unhide()
    end
end

--- Get the option to hide out of combat
--- @return boolean
local function getHideOutOfCombat()
    return M.settings.hideOutOfCombat
end

--- Set the counter display size
--- @param value number
--- @return nil
local function setSize(value)
    ui:Unhide()
    M.settings.size = value
    ui:SetSize(value)
end

--- Get the counter display size
--- @return number size Counter display size
local function getSize()
    return M.settings.size
end

--- @type table Options for Display settings
local displayOptions = {
    {
        -- Display
        type = "header",
        name = function() return lang:GetString("SETTINGS_DISPLAY_HEADER") end,
        width = "full",
    },
    {
        -- Lock/Unlock
        type = "button",
        name = getLockUnlockButtonText,
        tooltip = getLockUnlockTooltipText,
        disabled = getLockToReticle,
        func = toggleLocked,
        width = "half",
        reference = "CruxCounter_LockButton"
    },
    {
        -- Move to Center
        type = "button",
        name = function() return lang:GetString("SETTINGS_MOVE_TO_CENTER") end,
        tooltip = getMoveToCenterTooltipText,
        disabled = getLockToReticle,
        func = moveToCenter,
        width = "half",
        reference = "CruxCounter_MoveToCenterButton",
    },
    {
        -- Lock to Reticle
        type = "checkbox",
        name = function() return lang:GetString("SETTINGS_LOCK_TO_RETICLE") end,
        tooltip = function() return lang:GetString("SETTINGS_LOCK_TO_RETICLE_DESC") end,
        getFunc = getLockToReticle,
        setFunc = setLockToReticle,
        width = "full",
    },
    {
        -- Hide out of Combat
        type = "checkbox",
        name = function() return lang:GetString("SETTINGS_HIDE_OUT_OF_COMBAT") end,
        tooltip = function() return lang:GetString("SETTINGS_HIDE_OUT_OF_COMBAT_DESC") end,
        getFunc = getHideOutOfCombat,
        setFunc = setHideOutOfCombat,
        width = "full",
    },
    {
        -- Size
        type = "slider",
        name = function() return lang:GetString("SETTINGS_SIZE") end,
        tooltip = function() return lang:GetString("SETTINGS_SIZE_DESC") end,
        min = 16,
        max = 512,
        step = 16,
        default = M.defaults.size,
        getFunc = getSize,
        setFunc = setSize,
        width = "full",
    },
}

-- -----------------------------------------------------------------------------
-- Style
-- -----------------------------------------------------------------------------

--- Set if a UI element is shown/enabled
--- @param element string Name of the element
--- @param enabled boolean True to enable the element
--- @return nil
local function setElementEnabled(element, enabled)
    if element == "background" then
        ui:ShowBackground(enabled)
        ui:RotateBackground(M.settings.elements.background.rotate)
    elseif element == "runes" then
        ui:ShowRunes(enabled)
        ui:RotateRunes(M.settings.elements.runes.rotate)
    elseif element == "number" then
        ui:ShowNumber(enabled)
    else
        db:Trace(0, "Invalid element '<<1>>' specified for element display setting", element)
        return
    end

    M.settings.elements[element].enabled = enabled
end

--- Get if a UI element is shown/enabled
--- @param element string Name of the element
--- @return boolean enabled True when the element is enabled
--- @return nil
local function getElementEnabled(element)
    return M.settings.elements[element].enabled
end

--- Set if an element plays a rotation animation
--- @param element string Name of the element
--- @param rotate boolean True to rotate the element
--- @return nil
local function setElementRotate(element, rotate)
    if element == "background" then
        ui:RotateBackground(rotate)
    elseif element == "runes" then
        ui:RotateRunes(rotate)
    else
        db:Trace(0, "Invalid element '<<1>>' specified for rotation setting", element)
        return
    end

    M.settings.elements[element].rotate = rotate
end

--- Get if an element plays a rotation animation
--- @param element string Name of the element
--- @return boolean rotate True if the element rotation is enabled
local function getElementRotate(element)
    return M.settings.elements[element].rotate
end

--- Get the Hide for No Crux setting
--- @return boolean hideZeroStacks True to hide when there are zero stacks
local function getBackgroundHideZeroStacks()
    return M.settings.elements.background.hideZeroStacks
end

--- Set the Hide for No Crux setting
--- @param hideZeroStacks boolean True to hide when there are no stacks
--- @return nil
local function setBackgroundHideZeroStacks(hideZeroStacks)
    M.settings.elements.background.hideZeroStacks = hideZeroStacks

    if hideZeroStacks then
        ui:RefreshUI()
    else
        ui:ShowBackground(M.settings.elements.background.enabled)
    end
end

--- Get the rotation speed representation for the settings slider
--- @return number
local function getRotationSpeed()
    local speed = M.settings.elements.runes.rotationSpeed
    local inverted = rotationSpeedFactor - speed
    local percent = inverted / rotationSpeedFactor

    db:Trace(3, "Speed: <<1>>, Inverted: <<2>>, Percent: <<3>>", speed, inverted, percent)

    return percent * 100
end

--- Set the rotation speed translated from the settings slider
--- @param value number Speed slider value
--- @return nil
local function setRotationSpeed(value)
    local percent = value / 100
    local speed = rotationSpeedFactor - (rotationSpeedFactor * percent)
    M.settings.elements.runes.rotationSpeed = speed

    ui:RotateRunes(M.settings.elements.runes.rotate)

    db:Trace(3, "Value: <<1>>, Speed: <<2>>", value, speed)
end

--- @type table Options for Style settings
local styleOptions = {
    {
        type = "header",
        name = function()
            return lang:GetString("SETTINGS_STYLE_HEADER")
        end,
        width = "full",
    },
    {
        -- Number
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_STYLE_NUMBER")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_STYLE_NUMBER_DESC")
        end,
        getFunc = function()
            return getElementEnabled("number")
        end,
        setFunc = function(enabled)
            setElementEnabled("number", enabled)
        end,
        width = "half",
    },
    {
        type = "divider",
    },
    {
        -- Crux Runes
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_STYLE_CRUX_RUNES")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_STYLE_CRUX_RUNES_DESC")
        end,
        getFunc = function()
            return getElementEnabled("runes")
        end,
        setFunc = function(enabled)
            setElementEnabled("runes", enabled)
        end,
        width = "half",
    },
    {
        -- Rotate
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_STYLE_ROTATE")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_STYLE_CRUX_RUNES_ROTATE_DESC")
        end,
        getFunc = function()
            return getElementRotate("runes")
        end,
        setFunc = function(enabled)
            setElementRotate("runes", enabled)
        end,
        width = "half",
        disabled = function()
            return not getElementEnabled("runes")
        end,
    },
    {
        type = "custom",
        width = "half",
    },
    {
        -- Rotation Speed
        type = "slider",
        name = function()
            return lang:GetString("SETTINGS_STYLE_CRUX_RUNES_ROTATION_SPEED")
        end,
        min = 5,
        max = 95,
        step = 5,
        tooltip = function()
            return lang:GetString("SETTINGS_STYLE_CRUX_RUNES_ROTATION_SPEED_DESC")
        end,
        getFunc = getRotationSpeed,
        setFunc = setRotationSpeed,
        width = "half",
        default = M.defaults.elements.runes.rotationSpeed,
        disabled = function()
            return not getElementEnabled("runes") or not getElementRotate("runes")
        end,
    },
    {
        type = "divider",
    },
    {
        -- Background
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_STYLE_BACKGROUND")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_STYLE_BACKGROUND_DESC")
        end,
        getFunc = function()
            return getElementEnabled("background")
        end,
        setFunc = function(enabled)
            setElementEnabled("background", enabled)
        end,
        width = "half",
    },
    {
        -- Rotate
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_STYLE_ROTATE")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_STYLE_BACKGROUND_ROTATE")
        end,
        getFunc = function()
            return getElementRotate("background")
        end,
        setFunc = function(enabled)
            setElementRotate("background", enabled)
        end,
        width = "half",
        disabled = function()
            return not getElementEnabled("background")
        end,
    },
    {
        -- Hide on Zero Stacks
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_STYLE_BACKGROUND_HIDE_ZERO_CRUX")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_STYLE_BACKGROUND_HIDE_ZERO_CRUX_DESC")
        end,
        getFunc = getBackgroundHideZeroStacks,
        setFunc = setBackgroundHideZeroStacks,
        width = "half",
        disabled = function()
            return not getElementEnabled("background")
        end,
    },
}

-- -----------------------------------------------------------------------------
-- Sound
-- -----------------------------------------------------------------------------

--- Set if a sound playback condition should play
--- @param type string Name of the playback condition
--- @param enabled boolean True if the condition should play a sound
--- @return nil
local function setSoundEnabled(type, enabled)
    M.settings.sounds[type].enabled = enabled
end

--- Get if a sound playback condition should play
--- @param type string Name of the playback condition
--- @return boolean enabled True when the condition should play a sound
local function getSoundEnabled(type)
    return M.settings.sounds[type].enabled
end

--- Set the sound for a playback condition
--- @param type string Name of the playback condition
--- @param soundName string Name of the sound to play
--- @return nil
local function setSound(type, soundName)
    M.settings.sounds[type].name = soundName
end

--- Get the sound for a playback condition
--- @param type string Name of the playback condition
--- @return string soundName Name of the sound to play
local function getSound(type)
    return M.settings.sounds[type].name
end

--- Set the sound volume for a playback condition
--- @param type string Name of the playback condition
--- @param volume number Playback volume
--- @return nil
local function setVolume(type, volume)
    M.settings.sounds[type].volume = volume
end

--- Get the sound volume for a playback condition
--- @param type string Name of the playback condition
--- @return number volume Playback volume
local function getVolume(type)
    return M.settings.sounds[type].volume
end

--- @type table Options for Sound settings
local soundOptions = {
    {
        -- Sounds
        type = "header",
        name = function()
            return lang:GetString("SETTINGS_SOUNDS_HEADER")
        end,
        width = "full",
    },
    {
        -- Crux Gained
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_SOUNDS_CRUX_GAINED")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_SOUNDS_CRUX_GAINED_DESC")
        end,
        getFunc = function()
            return getSoundEnabled("cruxGained")
        end,
        setFunc = function(state)
            setSoundEnabled('cruxGained', state)
        end,
        width = "full",
    },
    {
        type = "dropdown",
        name = "",
        choices = sounds,
        getFunc = function()
            return getSound("cruxGained")
        end,
        setFunc = function(soundName)
            setSound("cruxGained", soundName)
        end,
        width = "half",
        -- sort = "name-up",
        scrollable = true,
        disabled = function()
            return not getSoundEnabled("cruxGained")
        end,
    },
    {
        type = "slider",
        name = "",
        min = 0,
        max = 100,
        step = 10,
        getFunc = function()
            return getVolume("cruxGained")
        end,
        setFunc = function(volume)
            setVolume("cruxGained", volume)
        end,
        width = "half",
        default = M.defaults.sounds.cruxGained.volume,
        disabled = function()
            return not getSoundEnabled("cruxGained")
        end,
    },
    {
        type = "button",
        name = function()
            return lang:GetString("SETTINGS_SOUNDS_PLAY")
        end,
        func = function()
            ui:PlaySoundForType("cruxGained")
        end,
        width = "full",
        disabled = function()
            return not getSoundEnabled("cruxGained")
        end,
    },
    {
        type = "divider",
    },
    {
        -- Maximum Crux
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_SOUNDS_MAXIMUM_CRUX")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_SOUNDS_MAXIMUM_CRUX_DESC")
        end,
        getFunc = function()
            return getSoundEnabled("maxCrux")
        end,
        setFunc = function(state)
            setSoundEnabled("maxCrux", state)
        end,
        width = "full",
    },
    {
        type = "dropdown",
        name = "",
        choices = sounds,
        getFunc = function()
            return getSound("maxCrux")
        end,
        setFunc = function(soundName)
            setSound("maxCrux", soundName)
        end,
        width = "half",
        -- sort = "name-up",
        scrollable = true,
        disabled = function()
            return not getSoundEnabled("maxCrux")
        end,
    },
    {
        type = "slider",
        name = "",
        min = 0,
        max = 100,
        step = 10,
        getFunc = function()
            return getVolume("maxCrux")
        end,
        setFunc = function(volume)
            setVolume("maxCrux", volume)
        end,
        width = "half",
        default = M.defaults.sounds.maxCrux.volume,
        disabled = function()
            return not getSoundEnabled("maxCrux")
        end,
    },
    {
        type = "button",
        name = function()
            return lang:GetString("SETTINGS_SOUNDS_PLAY")
        end,
        func = function()
            ui:PlaySoundForType("maxCrux")
        end,
        width = "full",
        disabled = function()
            return not getSoundEnabled("maxCrux")
        end,
    },
    {
        type = "divider",
    },
    {
        -- Crux Lost
        type = "checkbox",
        name = function()
            return lang:GetString("SETTINGS_SOUNDS_CRUX_LOST")
        end,
        tooltip = function()
            return lang:GetString("SETTINGS_SOUNDS_CRUX_LOST_DESC")
        end,
        getFunc = function()
            return getSoundEnabled("cruxLost")
        end,
        setFunc = function(state)
            setSoundEnabled("cruxLost", state)
        end,
        width = "full",
    },
    {
        type = "dropdown",
        name = "",
        choices = sounds,
        getFunc = function()
            return getSound("cruxLost")
        end,
        setFunc = function(soundName)
            setSound("cruxLost", soundName)
        end,
        width = "half",
        -- sort = "name-up",
        scrollable = true,
        disabled = function()
            return not getSoundEnabled("cruxLost")
        end,
    },
    {
        type = "slider",
        name = "",
        min = 0,
        max = 100,
        step = 10,
        getFunc = function()
            return getVolume("cruxLost")
        end,
        setFunc = function(volume)
            setVolume("cruxLost", volume)
        end,
        width = "half",
        default = M.defaults.sounds.cruxLost.volume,
        disabled = function()
            return not getSoundEnabled("cruxLost")
        end,
    },
    {
        type = "button",
        name = function()
            return lang:GetString("SETTINGS_SOUNDS_PLAY")
        end,
        func = function()
            ui:PlaySoundForType("cruxLost")
        end,
        width = "full",
        disabled = function()
            return not getSoundEnabled("cruxLost")
        end,
    },
}

-- -----------------------------------------------------------------------------
-- Setup
-- -----------------------------------------------------------------------------

--- Add an option to the LibAddonMenu settings menu
--- @param options table Menu options
--- @return nil
local function addToMenu(options)
    for _, option in pairs(options) do
        table.insert(optionsData, option)
    end
end

--- Populate sound options list and sort it
--- @return nil
local function populateSounds()
    for sound, _ in pairs(gameSounds) do
        if sound ~= nil and sound ~= "" then
            table.insert(sounds, sound)
        end
    end

    table.sort(gameSounds)
end

--- Setup settings
--- @return nil
function M:Setup()
    addon         = CC.Addon
    db            = CC.Debug
    events        = CC.Events
    lang          = CC.Language
    ui            = CC.UI
    ui            = CC.UI

    self.settings = ZO_SavedVars:NewAccountWide(self.savedVariables, self.dbVersion, nil, self.defaults)

    populateSounds()

    addToMenu(displayOptions)
    addToMenu(styleOptions)
    addToMenu(soundOptions)

    LAM:RegisterAddonPanel(addon.name, {
        type               = "panel",
        name               = "Crux Counter",
        displayName        = "Crux Counter",
        author             = "g4rr3t",
        version            = addon.version,
        registerForRefresh = true,
        slashCommand       = "/cruxcounter",
    })
    LAM:RegisterOptionControls(addon.name, optionsData)

    db:Trace(2, "Finished InitSettings()")
end

CC.Settings = M
