-- -----------------------------------------------------------------------------
-- lang/es.lua
-- -----------------------------------------------------------------------------

local M = {}
local CC = CruxCounter

--- Setup translation strings
--- @return nil
function M.Setup()
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK", "Bloquear")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_UNLOCK", "Desbloquear")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_DESC",
        "Alternar el estado de bloqueo/desbloqueo para reposicionar el contador.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_DISPLAY_HEADER", "Pantalla")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_WARNING",
        "Desactiva Bloquear al Retículo para cambiar esta opción.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER", "Mover al Centro")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER_DESC",
        "Centrar la pantalla en el medio de la pantalla. Útil si se ha perdido.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE", "Bloquear al Retículo")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_DESC",
        "Posicionar en el centro de la pantalla sobre la cruz del retículo.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT", "Ocultar fuera de combate")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT_DESC", "Ocultar todo cuando esté fuera de combate.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE", "Tamaño")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE_DESC", "Tamaño de la pantalla del contador.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_HEADER", "Estilo")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_ROTATE", "Rotar")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER", "Número")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_DESC", "Mostrar u ocultar el número de Ejes activos.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES", "Runas de Eje")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_DESC",
        "Mostrar u ocultar las texturas de las runas de Eje.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATE_DESC",
        "Activar o desactivar la rotación de las texturas de las runas de Eje.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND", "Fondo")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_DESC",
        "Mostrar u ocultar la textura de fondo del contador.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_ROTATE",
        "Activar o desactivar la rotación de la textura de fondo del contador.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_HEADER", "Sonidos")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_PLAY", "Reproducir")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED", "Eje Ganado")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED_DESC", "Reproducir un sonido al ganar un Eje.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX", "Máximo de Ejes")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX_DESC",
        "Reproducir un sonido al alcanzar el máximo de Ejes.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST", "Eje Perdido")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST_DESC", "Reproducir un sonido al perder Ejes.")
end

CC.Translation = M
