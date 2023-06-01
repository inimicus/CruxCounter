-- -----------------------------------------------------------------------------
-- lang/zh.lua
-- -----------------------------------------------------------------------------

local M = {}
local CC = CruxCounter or {}

--- Setup translation strings
--- @return nil
function M.Setup()
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK", "锁定")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_UNLOCK", "解锁")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_DESC", "切换魔核显示的锁定/解锁状态以便重新定位。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_DISPLAY_HEADER", "显示")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_WARNING", "关闭锁定到瞄准镜以更改此设置。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER", "居中移动")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER_DESC", "将显示居中在屏幕中央。如果它不见了，则很有用。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE", "锁定到瞄准镜")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_DESC", "在目标瞄准镜十字线上方的屏幕中心位置。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT", "隐藏非战斗状态")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT_DESC", "在非战斗状态下隐藏所有内容。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE", "大小")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE_DESC", "显示魔核计数器的大小。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_HEADER", "样式")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_ROTATE", "旋转")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER", "数字")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_DESC", "显示或隐藏活动魔核数量的显示。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES", "魔核符文")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_DESC", "显示或隐藏魔核符文纹理的显示。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATE_DESC", "开启或关闭魔核符文纹理的旋转。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND", "背景")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_DESC", "显示或隐藏计数器背景纹理的显示。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_ROTATE", "开启或关闭计数器背景纹理的旋转。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_HEADER", "音效")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_PLAY", "播放")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED", "获得魔核")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED_DESC", "获得魔核时播放音效。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX", "最大魔核")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX_DESC", "达到最大魔核时播放声音。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST", "魔核消失音效")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST_DESC", "失去魔核时播放音效。")
end

CC.Translation = M
