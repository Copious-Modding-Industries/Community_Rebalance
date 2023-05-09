dofile_once("mods/community_rebalance/files/scripts/lib/injection.lua")

inject(args.FF, modes.P, "data/scripts/gun/gun.lua", "mods/community_rebalance/files/scripts/gun/gun/func_hook.lua",
	"mods/community_rebalance/files/scripts/gun/gun/func_new.lua")

inject(args.SS,modes.R,"data/scripts/gun/gun.lua", "draw_shot( create", "draw_shot_trigger( create")
inject(args.SS,modes.R,"data/scripts/gun/gun.lua", "draw_shot( create", "draw_shot_trigger( create")
inject(args.SS,modes.R,"data/scripts/gun/gun.lua", "draw_shot( create", "draw_shot_trigger( create")
inject(args.SS,modes.A,"data/scripts/gun/gun.lua", "action.action()",
	"\nif trigger_nesting~=0 then\ncounter[trigger_nesting] = counter[trigger_nesting] + 1\nend\n")
