-- -----------------------------------------------------------------------------
-- Interface.lua
-- -----------------------------------------------------------------------------

local CC = CruxCounter
local M  = {}

--- Play a sound at a specific volume
--- @param sound string Name of the sound
--- @param volume number Playback volume from 0-100%
--- @return nil
function M:PlaySound(sound, volume)
    CC.Debug:Trace(3, "Playing sound <<1>> at volume <<2>>", sound, volume)

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
    if CC.Settings:GetSoundEnabled(type) then
        local sound, volume = CC.Settings:GetSoundForType(type)
        self:PlaySound(sound, volume)
    end
end

CC.UI = M
