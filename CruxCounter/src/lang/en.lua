-- -----------------------------------------------------------------------------
-- lang/en.lua
-- -----------------------------------------------------------------------------

local M = {}
local CC = CruxCounter

--- Setup translation strings
--- @return nil
function M.Setup()
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK", "Lock")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_UNLOCK", "Unlock")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_DESC", "Toggle lock/unlock state of counter display for repositioning.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_DISPLAY_HEADER", "Display")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_WARNING", "Turn off Lock to Reticle to change this setting.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER", "Move to Center")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER_DESC",
        "Center display in the middle of the screen. Useful if it's gone missing.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE", "Lock to Reticle")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_DESC",
        "Position at the center of the screen over the targeting reticle crosshairs.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT", "Hide out of Combat")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT_DESC", "Hide everything when out of combat.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE", "Size")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE_DESC", "Display size of the counter.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_HEADER", "Style")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_ROTATE", "Rotate")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER", "Number")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_DESC", "Show or hide display of the number of active Crux.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_COLOR", "Color")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_COLOR_DESC", "Color of display of the number of active Crux.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_COLOR_RESET", "Reset Color")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_COLOR_RESET_DESC", "Reset number color to the default.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES", "Crux Runes")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_DESC", "Show or hide display of the Crux rune textures.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATE_DESC",
        "Turn on or off rotation of the Crux rune textures.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATION_SPEED", "Speed")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATION_SPEED_DESC",
        "Speed to rotate the Crux rune textures. Higher is faster.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_COLOR", "Color")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_COLOR_DESC", "Color of crux rune textures.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_COLOR_RESET", "Reset Color")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_COLOR_RESET_DESC", "Reset rune texture color to the default.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND", "Background")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_DESC",
        "Show or hide display of the counter background texture.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_ROTATE",
        "Turn on or off rotation of the counter background texture.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_HIDE_ZERO_CRUX", "Hide Without Crux")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_HIDE_ZERO_CRUX_DESC",
        "Hide background when there are no Crux active.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_COLOR", "Color")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUNDOLOR_DESC", "Color of the counter background texture.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_COLOR_RESET", "Reset Color")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_COLOR_RESET_DESC",
        "Reset counter background texture color to the default.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_HEADER", "Sounds")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_PLAY", "Play")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED", "Crux Gained")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED_DESC", "Play a sound when gaining Crux.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX", "Maximum Crux")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX_DESC", "Play a sound upon reaching maximum Crux.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST", "Crux Lost")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST_DESC", "Play a sound when losing Crux.")
end

CC.Translation = M
