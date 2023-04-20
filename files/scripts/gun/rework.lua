---@diagnostic disable: lowercase-global
-- # Make VSC shut up about globals

actions = actions                                                   ---@type table

-- load in the list
local actions_to_edit = dofile_once("mods/community_rebalance/files/scripts/gun/rework_list.lua")

-- apply the changes
for actions_index = 1,#actions do
    for edit_id, edit_contents in pairs(actions_to_edit) do
        if actions[actions_index].id == edit_id then
			-- print("doing "..edit_id)
            for key, value in pairs(edit_contents) do
                actions[actions_index][key] = value
            end
            actions[actions_index].community_rebalanced = true
            actions_to_edit[edit_id] = nil
            break
        end
    end
end