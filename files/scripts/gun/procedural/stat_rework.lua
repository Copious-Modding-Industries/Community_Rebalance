dofile_once("mods/community_rebalance/files/scripts/lib/injection.lua")
list = {
	{"-- prob_draw_many",[[
gun_probs = { }

gun_probs[ "deck_capacity" ] = 
	{
		name = "deck_capacity",
		total_prob = 0,
		{
			-- name = "normal",
			prob = 1,
			min = 3,
			max = 10,
			mean = 6,
			sharpness = 2,
		},
		{
			-- name = "unshuffled",
			prob = 0.1,
			min = 2,
			max = 7,
			mean = 4,
			sharpness = 4,
			extra = function( gun ) gun["prob_unshuffle"] = gun["prob_unshuffle"] + 0.7 end
		},
		{
			-- name = "unshuffled tiny",
			prob = 0.05,
			min = 1,
			max = 5,
			mean = 3,
			sharpness = 4,
			extra = function( gun ) gun["prob_unshuffle"] = gun["prob_unshuffle"] + 0.7 end
		},
		{
			-- name = "machine gun",
			prob = 0.15,
			min = 5,
			max = 11,
			mean = 8,
			sharpness = 2,
		},
		{
			-- name = "everything goes",
			prob = 0.12,
			min = 2,
			max = 20,
			mean = 8,
			sharpness = 4,
		},
		{
			-- name = "shotgun",
			prob = 0.15,
			min = 3,
			max = 12,
			mean = 6,
			sharpness = 6,
			extra = function( gun ) gun["prob_draw_many"] = gun["prob_draw_many"] + 0.4 end
		},
		{
			-- name = "linear_crazy",
			prob = 1,
			min = 1,
			max = 20,
			mean = 6,
			sharpness = 0,
		},
	}

-------------------------------------------------------------------------------

gun_probs[ "reload_time" ] =
	{
		name = "reload_time",
		total_prob = 0,
		{
			-- pudy248: Made slower
			-- name = "normal",
			prob = 1,
			min = 10,
			max = 80,
			mean = 40,
			sharpness = 2,
		},
		{
			-- pudy248: Made slower and added 20% extra non-shuffle chance
			-- name = "normal",
			prob = 0.5,
			min = 1,
			max = 100,
			mean = 50,
			sharpness = 2,
			extra = function( gun ) gun["prob_unshuffle"] = gun["prob_unshuffle"] + 0.1 end 
		},
		{
			-- name = "linear",
			prob = 0.02,
			min = 1,
			max = 100,
			mean = 40,
			sharpness = 0,
		},
		{
			-- pudy248: Made slower and increased unshuffle chance
			-- name = "linear_crazy",
			prob = 0.15,
			min = 1,
			max = 240,
			mean = 80,
			sharpness = 0,
			extra = function( gun ) gun["prob_unshuffle"] = gun["prob_unshuffle"] + 0.3 end 
		},
	}

-------------------------------------------------------------------------------

gun_probs[ "fire_rate_wait" ] =
	{
		-- 5 = machine gun
		-- 24 = shotgun 
		-- 1 = submachinegun
		-- 50 = rocket launcher
		name = "fire_rate_wait",
		total_prob = 0,
		{
			-- name = "machine gun",
			prob = 0.5,
			min = 1,
			max = 30,
			mean = 5,
			sharpness = 2,
		},
		{
			-- name = "shotgun",
			prob = 0.5,
			min = 10,
			max = 50,
			mean = 30,
			sharpness = 3,
		},
		{
			-- name = "sniper",
			prob = 0.2,
			min = 40,
			max = 100,
			mean = 60,
			sharpness = 2,
		},
		{
			-- name = "linear_anything goes",
			prob = 0.1,
			min = -22,
			max = 50,
			mean = 5,
			sharpness = 0,
		},
	}

-------------------------------------------------------------------------------

gun_probs[ "spread_degrees" ] =
	{
		-- -35 - 35
		-- 0 = pistol
		-- 5 = machine gun
		-- 1 = shotgun
		name = "spread_degrees",
		total_prob = 0,
		{
			-- name = "pistol",
			prob = 1,
			min = -5,
			max = 10,
			mean = 0,
			sharpness = 3,
		},
		{
			-- name = "linear_crazy",
			prob = 0.1,
			min = -35,
			max = 35,
			mean = 0,
			sharpness = 0,
		},
	}


-------------------------------------------------------------------------------

gun_probs[ "speed_multiplier" ] =
	{
		-- 0.8 - 1.2
		name = "speed_multiplier",
		total_prob = 0,
		{
			-- name = "standard",
			prob = 1,
			min = 0.8,
			max = 1.2,
			mean = 1,
			sharpness = 6,
		},
		{
			-- name = "faster bullets",
			prob = 0.05,
			min = 1,
			max = 2,
			mean = 1.1,
			sharpness = 3,
		},
		{
			-- name = "slow bullets",
			prob = 0.05,
			min = 0.5,
			max = 1,
			mean = 0.9,
			sharpness = 3,
		},
		{
			-- name = "linear",
			prob = 1,
			min = 0.8,
			max = 1.2,
			mean = 1,
			sharpness = 0,
		},
		{
			-- name = "easter_egg",
			prob = 0.001,
			min = 1,
			max = 10,
			mean = 5,
			sharpness = 2,
		},
	}

-------------------------------------------------------------------------------

gun_probs[ "actions_per_round" ] =
	{
		-- 1 - 5
		name = "actions_per_round",
		total_prob = 0,
		{
			-- name = "standard",
			-- sharpness: 4
			-- 1: 92%
			-- 2: 7.8%
			-- 3: 0.08%
			prob = 1,
			min = 1,
			max = 3,
			mean = 1,
			sharpness = 3,
		},
		{
			-- name = "shotgun",
			prob = 0.2,
			min = 2,
			max = 4,
			mean = 2,
			sharpness = 8,
		},
		{
			-- name = "crazy",
			prob = 0.05,
			min = 1,
			max = 5,
			mean = 2,
			sharpness = 2,
		},
		{
			-- name = "linear",
			prob = 0.1, -- pudy248: Changed from 1 to 0.1, making high multicast wands just a bit rarer
			min = 1,
			max = 5,
			mean = 2,
			sharpness = 0,
		},
	}

-- prob_draw_many
	]]},

	{"if( variable == \"shuffle_deck_when_empty\") then\r\n		local random = Random",
	[[if( variable == "shuffle_deck_when_empty") then
		local random = Randomf]]},

	{[[if( random == 1 and cost >= (15+deck_capacity*5) and deck_capacity <= 9 ) then]],
	 [[if( random > t_gun["prob_unshuffle"] and cost >= (15+deck_capacity*5) and deck_capacity <= 9 ) then]]},
	
	{[[gun["prob_unshuffle"] = 0.1]], [[gun["prob_unshuffle"] = 0.3]]},
	
	{[[gun["mana_charge_speed"] = 50*level + Random(-5,5*level)]],[[gun["mana_charge_speed"] = RandomDistributionf(20 * level, 80 * level, 50 * level, 5)]]},
	{[[gun["mana_max"] = 50 + (150 * level) + (Random(-5,5)*10)]],[[gun["mana_max"] = 50 + RandomDistributionf(100 * level, 200 * level, 150 * level, 5)]]},
	

	{[[gun["mana_charge_speed"] = ( 50*level + Random(-5,5*level) ) / 5]],[[gun["mana_charge_speed"] = RandomDistributionf(10 * level, 60 * level, 15 * level, 2.5)]]},
	{[[gun["mana_max"] = ( 50 + (150 * level) + (Random(-5,5)*10) ) * 3]],[[gun["mana_max"] = 50 + RandomDistributionf(400 * level, 600 * level, 450 * level, 3)]]},

	{[[gun["mana_charge_speed"] = ( 50*level + Random(-5,5*level) ) * 5]],[[gun["mana_charge_speed"] =  RandomDistributionf(80 * level, 300 * level, 150 * level, 2)]]},
	{[[gun["mana_max"] = ( 50 + (150 * level) + (Random(-5,5)*10) ) / 3]],[[gun["mana_max"] = 50 + RandomDistributionf(30 * level, 90 * level, 50 * level, 3)]]},

	{[[if( gun["reload_time"] >= 60 ) then]], [[if( gun["shuffle_deck_when_empty"] == 1 and Random(1, 100) <= 40) then]]},
}

list_2 = {
	{"-- prob_draw_many",[[gun_probs[ "reload_time" ] =
{
	name = "reload_time",
	total_prob = 0,
	{
		-- name = "normal",
		prob = 1,
		min = 5,
		max = 60,
		mean = 30,
		sharpness = 2,
	},
}

-- prob_draw_many]]},

	{"if( variable == \"shuffle_deck_when_empty\") then\r\n		local random = Random",
	[[if( variable == "shuffle_deck_when_empty") then
		local random = Randomf]]},

	{"if( random == 1 and cost >= (15+deck_capacity*5) and deck_capacity <= 9 ) then",
	 "if( random > t_gun[\"prob_unshuffle\"] and cost >= (15+deck_capacity*5) and deck_capacity <= 9 ) then"},
	
	{"gun[\"prob_unshuffle\"] = 0.1", "gun[\"prob_unshuffle\"] = 0.3"},
	
	{[[gun["mana_charge_speed"] = 50*level + Random(-5,5*level)]],[[gun["mana_charge_speed"] = RandomDistributionf(20 * level, 80 * level, 50 * level, 5)]]},
	{[[gun["mana_max"] = 50 + (150 * level) + (Random(-5,5)*10)]],[[gun["mana_max"] = 50 + RandomDistributionf(100 * level, 200 * level, 150 * level, 5)]]},
	

	{[[gun["mana_charge_speed"] = ( 50*level + Random(-5,5*level) ) / 5]],[[gun["mana_charge_speed"] = RandomDistributionf(10 * level, 60 * level, 15 * level, 2.5)]]},
	{[[gun["mana_max"] = ( 50 + (150 * level) + (Random(-5,5)*10) ) * 3]],[[gun["mana_max"] = 50 + RandomDistributionf(400 * level, 600 * level, 450 * level, 3)]]},

	{[[if( gun["reload_time"] >= 60 ) then]], [[if( gun["shuffle_deck_when_empty"] == 1 and Random(1, 100) <= 40) then]]},
}

list_3 = {
    {"gun.deck_capacity = {2,3}", "gun.deck_capacity = 3"},
    {"local deck_capacity = get_random_between_range( gun.deck_capacity )","local deck_capacity = gun.deck_capacity"},
}

for k,v in ipairs(list) do
	replace("data/scripts/gun/procedural/gun_procedural.lua",v[1],v[2])
end

for k,v in ipairs(list_2) do
	replace("data/scripts/gun/procedural/gun_procedural_better.lua",v[1],v[2])
end

for k,v in ipairs(list_3) do
	replace("data/scripts/gun/procedural/starting_wand.lua",v[1],v[2])
end