-- -----------------------------------------------------------------------------
-- Debug.lua
-- -----------------------------------------------------------------------------

local CC = CruxCounter
local M  = {}

--- @type integer Current debug level
---               0: Off    - No debug messages
--                1: Low    - Basic debug info, show core functionality
--                2: Medium - More information about skills and addon details
--                3: High   - Everything
M.level  = 0

--- Write a message to game chat
--- @param ... any Message to output
--- @return nil
function M:Say(...)
    local prefix = "[" .. CC.Addon.name .. "] "
    d(prefix .. zo_strformat(...))
end

--- Output a trace if the level is within the current debug level.
--- @param level integer Level to debug
--- @param ... any Information to trace
--- @return nil
function M:Trace(level, ...)
    if level <= self.level then
        self:Say(...)
    end
end

--- Write a message to game chat later
--- @param delayMs integer Milliseconds to delay output
--- @param ... any Message to output
--- @return nil
function M:SayLater(delayMs, ...)
    local args = ...
    zo_callLater(function()
        self:Say(args)
    end, delayMs)
end

CC.Debug = M
