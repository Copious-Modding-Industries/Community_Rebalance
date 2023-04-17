return {
    actions = function ()
        -- Rework spells
        ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/community_rebalance/files/scripts/gun/rework.lua")
    end,
}