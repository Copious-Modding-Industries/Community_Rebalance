dofile_once("mods/community_rebalance/files/scripts/lib/injection.lua")

prepend_from_file("data/scripts/gun/gun.lua","mods/community_rebalance/files/scripts/gun/gun/func_hook.lua","mods/community_rebalance/files/scripts/gun/gun/func_new.lua")

replace("data/scripts/gun/gun.lua","draw_shot( create","draw_shot_trigger( create")
replace("data/scripts/gun/gun.lua","draw_shot( create","draw_shot_trigger( create")
replace("data/scripts/gun/gun.lua","draw_shot( create","draw_shot_trigger( create")