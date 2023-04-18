dofile_once("mods/community_rebalance/files/scripts/lib/injection.lua")
list = {
	{"c.spread_degrees = c.spread_degrees - 25","c.spread_degrees = c.spread_degrees - 15"},
	{"c.damage_explosion_add = c.damage_explosion_add + 0.2","c.damage_explosion_add = c.damage_explosion_add + 0.05"}, -- conc spells
	{"c.damage_projectile_add = c.damage_projectile_add + 0.5","c.damage_projectile_add = c.damage_projectile_add + 0.15"} -- conc spells
}
for k,v in ipairs(list) do
	replace("data/scripts/gun/gun_extra_modifiers.lua",v[1],v[2])
end