---@diagnostic disable: lowercase-global
-- # Make VSC shut up about globals

local perks_to_edit = dofile_once("mods/community_rebalance/files/scripts/perks/rework_list.lua")

-- apply the changes
for perk_index,perk in ipairs(perk_list) do
    local edits = perks_to_edit[perk.id] or {}
	for k,v in pairs(edits) do
		perk[k] = v
	end
	perk.community_rebalanced = true
end