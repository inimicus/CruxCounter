-- -----------------------------------------------------------------------------
-- lang/de.lua
-- -----------------------------------------------------------------------------

local M = {}
local CC = CruxCounter

--- Setup translation strings
--- @return nil
function M.Setup()
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK", "Sperren")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_UNLOCK", "Entsperren")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_DESC",
        "Umschalten des Sperr-/Entsperrzustands der Anzeige des Zählers zur Neupositionierung.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_DISPLAY_HEADER", "Anzeige")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_WARNING",
        "Schalte 'Sperren am Fadenkreuz' aus, um diese Einstellung zu ändern.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER", "In die Mitte bewegen")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER_DESC",
        "Anzeige in der Mitte des Bildschirms zentrieren. Nützlich, wenn sie verschwunden ist.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE", "Sperren am Fadenkreuz")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_DESC",
        "Positionieren Sie die Anzeige im Zentrum des Bildschirms über dem Fadenkreuz.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT", "Außerhalb des Kampfes ausblenden")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT_DESC", "Alles ausblenden, wenn außerhalb des Kampfes.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE", "Größe")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE_DESC", "Anzeigegröße des Zählers.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_HEADER", "Stil")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_ROTATE", "Drehen")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER", "Nummer")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_DESC",
        "Anzeige der Anzahl der aktiven Crux ein- oder ausblenden.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES", "Crux Runen")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_DESC",
        "Anzeige der Crux-Runentexturen ein- oder ausblenden.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATE_DESC",
        "Drehen der Crux-Runentexturen ein- oder ausschalten.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND", "Hintergrund")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_DESC",
        "Anzeige der Textur des Zählerhintergrunds ein- oder ausblenden.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_ROTATE",
        "Drehen der Textur des Zählerhintergrunds ein- oder ausschalten.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_HEADER", "Geräusche")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_PLAY", "Wiedergeben")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED", "Crux erlangt")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED_DESC", "Einen Ton abspielen, wenn Crux erlangt wird.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX", "Maximales Crux")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX_DESC",
        "Spielt einen Ton ab, wenn der maximale Crux erreicht wurde.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST", "Crux verloren")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST_DESC", "Spielt einen Ton ab, wenn man Crux verliert.")
end

CC.Translation = M
