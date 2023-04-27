-- -----------------------------------------------------------------------------
-- Init.lua
-- -----------------------------------------------------------------------------

local EM     = EVENT_MANAGER
local CC     = CruxCounter

local addon  = CC.Addon
local events
local lang
local settings
local ui

--- @type string Namespace for addon init event
local initNs = addon.name .. "Init"

--- Is the player's current class an Arcanist?
--- @return boolean
local function isArcanist()
    local arcanistClassId = 117
    return GetUnitClassId("player") == arcanistClassId
end

--- Setup the addon
--- @return nil
local function setup()
    lang.Setup()
    settings:Setup()
    ui:Setup()
    events:RegisterEvents()
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
    if addonName ~= addon.name then return end

    events   = CC.Events
    lang     = CC.Language
    settings = CC.Settings
    ui       = CC.UI

    -- Ready to go
    unregister()
    setup()
end

EM:RegisterForEvent(initNs, EVENT_ADD_ON_LOADED, init)
