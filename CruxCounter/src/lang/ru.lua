-- -----------------------------------------------------------------------------
-- lang/ru.lua
-- -----------------------------------------------------------------------------

local M = {}
local CC = CruxCounter or {}

--- Setup translation strings
--- @return nil
function M.Setup()
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK", "Заблокировать")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_UNLOCK", "Разблокировать")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_DESC",
        "Переключение состояния блокировки/разблокировки отображения счетчика для переноски.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_DISPLAY_HEADER", "Отображение")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_WARNING",
        "Отключите 'Закрепить на метке' для изменения этой настройки.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER", "Переместить в центр")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER_DESC",
        "Отцентровать отображение по середине экрана. Полезно, если отображение потерялось.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE", "Закрепить на метке")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_DESC",
        "Расположить отображение по центру экрана над меткой в виде перекрестья.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT", "Скрыть вне боя")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT_DESC", "Скрыть все, когда вы не в бою.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE", "Размер")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE_DESC", "Размер отображения счетчика.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_HEADER", "Стиль")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_ROTATE", "Поворот")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER", "Номер")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_DESC",
        "Показать или скрыть отображение количества активных Знаков.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES", "Знаки Ключа")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_DESC",
        "Показать или скрыть отображение текстур Знаков Ключа.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATE_DESC",
        "Включить или выключить вращение текстур Знаков Ключа.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND", "Фон")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_DESC",
        "Показать или скрыть отображение текстуры фона счетчика.")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_ROTATE",
        "Включить или выключить вращение текстуры фона счетчика.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_HEADER", "Звуки")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_PLAY", "Воспроизведение")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED", "Получение Знака")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED_DESC", "Воспроизвести звук при получении кристалла.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX", "Максимальный Знак")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX_DESC",
        "Воспроизвести звук при достижении максимального Знака.")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST", "Потеря Знака")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST_DESC", "Воспроизвести звук при потере Знака.")
end

CC.Translation = M
