-- -----------------------------------------------------------------------------
-- Init.lua
-- -----------------------------------------------------------------------------

local CC     = CruxCounter
local EM     = EVENT_MANAGER

--- @type string Namespace for addon init event
local initNs = CC.Addon.name .. "_Init"

--- Is the player's current class an Arcanist?
--- @return boolean
local function isArcanist()
    local arcanistClassId = 117
    return GetUnitClassId("player") == arcanistClassId
end

--- Unregister the addon
--- @see EVENT_ADD_ON_LOADED
--- @return nil
local function unregister()
    EM:UnregisterForEvent(initNs, EVENT_ADD_ON_LOADED)
end

--- Initialize the addon
--- @param addonName string Name of the addon loaded
--- @return nil
local function init(_, addonName)
    -- Skip non-Arcanist classes
    if not isArcanist() then
        -- Unregister event to prevent being called again
        unregister()
        return
    end

    -- Skip addons that aren't this one
    if addonName ~= CC.Addon.name then return end

    -- Ready to go
    unregister()

    CC.Language:Setup()
    CC.Settings:Setup()
    CC.Events:RegisterEvents()

    CruxCounter_Display:ApplySettings()
end

-- Make the magic happen
EM:RegisterForEvent(initNs, EVENT_ADD_ON_LOADED, init)
