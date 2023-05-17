-- -----------------------------------------------------------------------------
-- lang/fr.lua
-- -----------------------------------------------------------------------------

local M = {}
local CC = CruxCounter or {}

--- Setup translation strings
--- @return nil
function M.Setup()
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK", "Verrouiller")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_UNLOCK", "Déverrouiller")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_DESC",
        "Basculer l'état verrouillé/déverrouillé de l'affichage du compteur pour le repositionnement.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_DISPLAY_HEADER", "Affichage")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_WARNING",
        "Désactivez le verrouillage sur le réticule pour changer ce paramètre.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER", "Déplacer au centre")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER_DESC",
        "Centre l'affichage au milieu de l'écran. Utile s'il a disparu.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE", "Verrouiller sur le réticule")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_DESC",
        "Positionne l'affichage au centre de l'écran sur le réticule de ciblage.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT", "Masquer hors combat")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT_DESC", "Masque tout lorsqu'hors combat.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE", "Taille")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE_DESC", "Taille de l'affichage du compteur.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_HEADER", "Style")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_ROTATE", "Rotation")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER", "Nombre")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_DESC",
        "Afficher ou masquer l'affichage du nombre d'Interprétations actives.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES", "Runes d'Interprétation")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_DESC",
        "Afficher ou masquer l'affichage des textures de Rune d'Interprétation.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATE_DESC",
        "Activer ou désactiver la rotation des textures de Rune d'Interprétation.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND", "Fond")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_DESC",
        "Afficher ou masquer l'affichage de la texture de fond du compteur.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_ROTATE",
        "Activer ou désactiver la rotation de la texture de fond du compteur.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_HEADER", "Sons")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_PLAY", "Jouer")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED", "Interprétation obtenue")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED_DESC",
        "Jouer un son lorsqu'une Interprétation est obtenue.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX", "Interprétations maximales")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX_DESC",
    "Jouer un son lorsqu'on atteint le maximum d'Interprétation.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST", "Perte d'Interprétation")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST_DESC", "Jouer un son lorsqu'on perd de l'Interprétation.")
end

CC.Translation = M
