return {
    actions = function ()
        -- Rework spells
        ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/community_rebalance/files/scripts/gun/rework.lua")
    end,
	perks = function()
		-- Rework perks
		ModLuaFileAppend("data/scripts/perks/perk_list.lua","mods/community_rebalance/files/scripts/perks/rework.lua")
		dofile_once("mods/community_rebalance/files/scripts/perks/extra_mods.lua")
	end,
	xml = function ()
    -- Patch xml
		dofile_once("mods/community_rebalance/files/scripts/xml/rework.lua")
  end,
	wands = function ()
    -- Patch wand gen
		dofile_once("mods/community_rebalance/files/scripts/gun/procedural/stat_rework.lua")
	end,
}