-- -----------------------------------------------------------------------------
-- Language.lua
-- -----------------------------------------------------------------------------

local M = {}
local CC = CruxCounter or {}
local translation = CC.Translation

M.translationPrefix = "CRUX_COUNTER_"

--- Setup language
--- @return nil
function M.Setup()
    -- Create translation globals
    translation.Setup()
end

--- Wrapper for global GetString function
--- @param shortName string Shortened string name
--- @param contextId integer|nil String context ID, defaults to 0
--- @return string stringValue Translated string value
function M:GetString(shortName, contextId)
    return GetString(_G[self.translationPrefix .. shortName], contextId or 0) --[[@as string]]
end

CC.Language = M
