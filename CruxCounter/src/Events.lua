-- -----------------------------------------------------------------------------
-- Init.lua
-- -----------------------------------------------------------------------------

local EM    = EVENT_MANAGER
local CC    = CruxCounter
local M     = {}

--- @type integer Crux ability ID
M.abilityId = 184220

--- Build namespace for events
--- @param event string Name of the event
--- @return string namespace Addon-specific event namespace
local function getEventNamespace(event)
    return CC.Addon.name .. event
end

--- Respond to effect changes.
--- @see EVENT_EFFECT_CHANGED
--- @param changeType integer Type of effect change, see EffectResult enum for possible values
--- @param stackCount integer Number of stacks at the time of the event
--- @return nil
local function onEffectChanged(_, changeType, _, _, _, _, _, stackCount)
    if changeType == EFFECT_RESULT_FADED then
        CC.State:ClearStacks()
        return
    end

    CC.State:SetStacks(stackCount)
end

--- Update combat state
--- @param inCombat boolean Whether or not the player is in combat
--- @return nil
local function onCombatChanged(_, inCombat)
    CC.State:SetInCombat(inCombat)

    if CC.Settings:Get("hideOutOfCombat") and not inCombat then
        CruxCounter_Display:RemoveSceneFragments()
    else
        CruxCounter_Display:AddSceneFragments()
    end
end

--- Respond to player life/death/zone/load changes.
--- Note: Sound playback skipped for these stack transitions
--- @return nil
local function onPlayerChanged()
    M:UpdateCombatState()

    for i = 1, GetNumBuffs("player") do
        --- buffIndex wants luaindex so passing integer emits a warning
        --- @diagnostic disable-next-line: param-type-mismatch
        local _, _, _, _, stackCount, _, _, _, _, _, abilityId = GetUnitBuffInfo("player", i)
        if abilityId == M.abilityId then
            -- stackCount is seen as type `stackCount`, but should be `integer`
            -- fix in annotation
            CC.State:SetStacks(stackCount --[[@as integer]], false)

            return
        end
    end

    -- No Crux in player buffs
    CC.State:SetStacks(0, false)
end

--- Update combat state with current value
--- @return nil
function M:UpdateCombatState()
    onCombatChanged(nil, IsUnitInCombat("player") --[[@as boolean]])
end

--- Wrap EVENT_MANAGER:RegisterForEvent function
--- @param namespace string Unique event namespace
--- @param event any Event to filter
--- @param callbackFunc function Execute function on event trigger
--- @return nil
function M:Listen(namespace, event, callbackFunc)
    EM:RegisterForEvent(getEventNamespace(namespace), event, callbackFunc)
end

--- Wrap EVENT_MANAGER:UnregisterForEvent function
--- @param namespace string Unique event namespace
--- @param event any Event to filter
--- @return nil
function M:Unlisten(namespace, event)
    EM:RegisterForEvent(getEventNamespace(namespace), event)
end

--- Wrap EVENT_MANAGER:AddFilterForEvent function
--- @param namespace string Unique event namespace
--- @param event any Event to filter
--- @param filterType integer Type of filter
--- @param filterValue any Value to filter
--- @param ... any Additional filters
--- @return nil
function M:AddFilter(namespace, event, filterType, filterValue, ...)
    EM:AddFilterForEvent(getEventNamespace(namespace), event, filterType, filterValue, ...)
end

--- Register to receive combat state transitions
--- @return nil
function M:RegisterForCombat()
    self:UpdateCombatState()
    self:Listen("CombatState", EVENT_PLAYER_COMBAT_STATE, onCombatChanged)
end

--- Unregister listening for combat state transitions
--- @return nil
function M:UnregisterForCombat()
    self:Unlisten("CombatState", EVENT_PLAYER_COMBAT_STATE)
    self:UpdateCombatState()
end

--- Registers event manager events.
--- @return nil
function M:RegisterEvents()
    CC.Debug:Trace(2, "Registering events...")

    -- Ability updates
    self:Listen("EffectChanged", EVENT_EFFECT_CHANGED, onEffectChanged)
    self:AddFilter(
        "EffectChanged",
        EVENT_EFFECT_CHANGED,
        REGISTER_FILTER_ABILITY_ID, self.abilityId,
        REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER
    )

    -- Life or death
    self:Listen("PlayerDead", EVENT_PLAYER_DEAD, onPlayerChanged)
    self:Listen("PlayerAlive", EVENT_PLAYER_ALIVE, onPlayerChanged)

    -- Zone change or load
    self:Listen("PlayerActivated", EVENT_PLAYER_ACTIVATED, onPlayerChanged)
    self:Listen("ZoneUpdated", EVENT_ZONE_UPDATE, onPlayerChanged)

    -- Combat state
    if CC.Settings:Get("hideOutOfCombat") then
        self:RegisterForCombat()
    end
end

CC.Events = M
