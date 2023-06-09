---@diagnostic disable: lowercase-global
-- # Make VSC shut up about globals

add_projectile = add_projectile ---@type function
draw_actions = draw_actions ---@type function
c = c ---@type table
ACTION_DRAW_RELOAD_TIME_INCREASE = ACTION_DRAW_RELOAD_TIME_INCREASE ---@type number

-- # Import useful functions
dofile_once("mods/community_rebalance/files/scripts/gun/library.lua")


--[[
# SEE CONTRIBUTING.MD (TODO!)
Format is:

-- English Action Name
["ACTION_ID"] = {
	property = value,
},

]]
local actions_to_edit = {
	-- Chainsaw
	["CHAINSAW"] = {
		mana = 5,
		action = function(recursion_level, iteration)
			local mana_per_cd_frame = 1 -- change this to control how much mana each frame of cast delay costs
			local amount_to_remove = math.min(mana * mana_per_cd_frame, c.fire_rate_wait)
			mana = mana - amount_to_remove * mana_per_cd_frame
			add_projectile("data/entities/projectiles/deck/chainsaw.xml")
			-- Tweak:  mana reduction proportional to cast delay reduced, need feedback on scaling
			c.fire_rate_wait = c.fire_rate_wait - amount_to_remove
			c.spread_degrees = c.spread_degrees + 6.0
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
				10 -- this is a hack to get the digger reload time back to 0
		end
	},
	["MANA_REDUCE"] = {
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end,
	},
	["LUMINOUS_DRILL"] = {
		mana = 20,
	},
	["LASER_LUMINOUS_DRILL"] = {
		mana = 40,
	},
	["FIREBALL_RAY"] = {
		mana = 40,
	},
	["FIREBALL_RAY_LINE"] = {
		mana = 60,
	},
	["LASER_EMITTER_RAY"] = {
		mana = 80,
	},
	["LIGHTNING_RAY"] = {
		mana = 80,
	},
	["TENTACLE_RAY"] = {
		mana = 100,
	},
	["FIREBALL_RAY_ENEMY"] = {
		mana = 140,
	},
	["LIGHT_BULLET_TRIGGER"] = {
		mana = 25,
	},
	["LIGHT_BULLET_TRIGGER_2"] = {
		mana = 35,
	},
	["FREEZE"] = {
		mana = 15,
		action = function()
			c.damage_ice_add = c.damage_ice_add + 0.2
			c.game_effect_entities = c.game_effect_entities ..
				"mods/community_rebalance/files/entities/freeze_shorter.xml,"
			c.extra_entities = c.extra_entities .. "data/entities/particles/freeze_charge.xml,"
			draw_actions(1, true)
		end,
	},
	["ADD_TRIGGER"] = {
		action = function()
			local data = {}

			local how_many = 1

			if (#deck > 0) then
				data = deck[1]
			else
				data = nil
			end

			if (data ~= nil) then
				while (#deck >= how_many) and ((data.type == ACTION_TYPE_MODIFIER) or (data.type == ACTION_TYPE_PASSIVE) or (data.type == ACTION_TYPE_OTHER) or (data.type == ACTION_TYPE_DRAW_MANY)) do
					if ((data.uses_remaining == nil) or (data.uses_remaining ~= 0)) and (data.id ~= "ADD_TRIGGER") and (data.id ~= "ADD_TIMER") and (data.id ~= "ADD_DEATH_TRIGGER") then
						if (data.type == ACTION_TYPE_MODIFIER) then
							dont_draw_actions = true
							if mana >= data.mana then
								mana = mana - data.mana
								data.action()
							end
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[how_many]
				end

				if (data ~= nil) and (data.related_projectiles ~= nil) and ((data.uses_remaining == nil) or (data.uses_remaining ~= 0)) then
					local target = data.related_projectiles[1]
					local mana_target = data.mana
					local count = data.related_projectiles[2] or 1


					for i = 1, how_many do
						data = deck[1]
						table.insert(discarded, data)
						table.remove(deck, 1)
					end

					local valid = false

					for i = 1, #deck do
						local check = deck[i]

						if (check ~= nil) and ((check.type == ACTION_TYPE_PROJECTILE) or (check.type == ACTION_TYPE_STATIC_PROJECTILE) or (check.type == ACTION_TYPE_MATERIAL) or (check.type == ACTION_TYPE_UTILITY)) then
							valid = true
							break
						end
					end

					if (data.uses_remaining ~= nil) and (data.uses_remaining > 0) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged(data.inventoryitem_id, data.uses_remaining)
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end

					if valid then
						for i = 1, count do
							if mana >= mana_target then
								mana = mana - mana_target
								add_projectile_trigger_hit_world(target, 1)
							end
						end
					else
						dont_draw_actions = true
						if mana >= data.mana then
							mana = mana - data.mana
							data.action()
						end
						dont_draw_actions = false
					end
				end
			end
		end,
	},
	["ADD_TIMER"] = {
		action = function()
			local data = {}

			local how_many = 1

			if (#deck > 0) then
				data = deck[1]
			else
				data = nil
			end

			if (data ~= nil) then
				while (#deck >= how_many) and ((data.type == ACTION_TYPE_MODIFIER) or (data.type == ACTION_TYPE_PASSIVE) or (data.type == ACTION_TYPE_OTHER) or (data.type == ACTION_TYPE_DRAW_MANY)) do
					if ((data.uses_remaining == nil) or (data.uses_remaining ~= 0)) and (data.id ~= "ADD_TRIGGER") and (data.id ~= "ADD_TIMER") and (data.id ~= "ADD_DEATH_TRIGGER") then
						if (data.type == ACTION_TYPE_MODIFIER) then
							dont_draw_actions = true
							if mana >= data.mana then
								mana = mana - data.mana
								data.action()
							end
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[how_many]
				end

				if (data ~= nil) and (data.related_projectiles ~= nil) and ((data.uses_remaining == nil) or (data.uses_remaining ~= 0)) then
					local target = data.related_projectiles[1]
					local mana_target = data.mana
					local count = data.related_projectiles[2] or 1


					for i = 1, how_many do
						data = deck[1]
						table.insert(discarded, data)
						table.remove(deck, 1)
					end

					local valid = false

					for i = 1, #deck do
						local check = deck[i]

						if (check ~= nil) and ((check.type == ACTION_TYPE_PROJECTILE) or (check.type == ACTION_TYPE_STATIC_PROJECTILE) or (check.type == ACTION_TYPE_MATERIAL) or (check.type == ACTION_TYPE_UTILITY)) then
							valid = true
							break
						end
					end

					if (data.uses_remaining ~= nil) and (data.uses_remaining > 0) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged(data.inventoryitem_id, data.uses_remaining)
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end

					if valid then
						for i = 1, count do
							if mana >= mana_target then
								mana = mana - mana_target
								add_projectile_trigger_timer(target, 20, 1)
							end
						end
					else
						dont_draw_actions = true
						if mana >= data.mana then
							mana = mana - data.mana
							data.action()
						end
						dont_draw_actions = false
					end
				end
			end
		end,
	},
	["ADD_DEATH_TRIGGER"] = {
		action = function()
			local data = {}

			local how_many = 1

			if (#deck > 0) then
				data = deck[1]
			else
				data = nil
			end

			if (data ~= nil) then
				while (#deck >= how_many) and ((data.type == ACTION_TYPE_MODIFIER) or (data.type == ACTION_TYPE_PASSIVE) or (data.type == ACTION_TYPE_OTHER) or (data.type == ACTION_TYPE_DRAW_MANY)) do
					if ((data.uses_remaining == nil) or (data.uses_remaining ~= 0)) and (data.id ~= "ADD_TRIGGER") and (data.id ~= "ADD_TIMER") and (data.id ~= "ADD_DEATH_TRIGGER") then
						if (data.type == ACTION_TYPE_MODIFIER) then
							dont_draw_actions = true
							if mana >= data.mana then
								mana = mana - data.mana
								data.action()
							end
							dont_draw_actions = false
						end
					end
					how_many = how_many + 1
					data = deck[how_many]
				end

				if (data ~= nil) and (data.related_projectiles ~= nil) and ((data.uses_remaining == nil) or (data.uses_remaining ~= 0)) then
					local target = data.related_projectiles[1]
					local mana_target = data.mana
					local count = data.related_projectiles[2] or 1


					for i = 1, how_many do
						data = deck[1]
						table.insert(discarded, data)
						table.remove(deck, 1)
					end

					local valid = false

					for i = 1, #deck do
						local check = deck[i]

						if (check ~= nil) and ((check.type == ACTION_TYPE_PROJECTILE) or (check.type == ACTION_TYPE_STATIC_PROJECTILE) or (check.type == ACTION_TYPE_MATERIAL) or (check.type == ACTION_TYPE_UTILITY)) then
							valid = true
							break
						end
					end

					if (data.uses_remaining ~= nil) and (data.uses_remaining > 0) then
						data.uses_remaining = data.uses_remaining - 1

						local reduce_uses = ActionUsesRemainingChanged(data.inventoryitem_id, data.uses_remaining)
						if not reduce_uses then
							data.uses_remaining = data.uses_remaining + 1 -- cancel the reduction
						end
					end

					if valid then
						for i = 1, count do
							if mana >= mana_target then
								mana = mana - mana_target
								add_projectile_trigger_death(target, 1)
							end
						end
					else
						dont_draw_actions = true
						if mana >= data.mana then
							mana = mana - data.mana
							data.action()
						end
						dont_draw_actions = false
					end
				end
			end
		end,
	},
	["LONG_DISTANCE_CAST"] = {
		mana = 10,
	},
	["TELEPORT_CAST"] = {
		mana = 35,
	},
	["WARP_CAST"] = {
		mana = 10,
	},
	["FREEZING_GAZE"] = {
		max_uses = 8,
	},
	["HEAVY_SHOT"] = {
		mana = 12,
		action = function()
			c.damage_projectile_add       = c.damage_projectile_add + 0.8
			c.fire_rate_wait              = c.fire_rate_wait + 10
			c.gore_particles              = c.gore_particles + 10
			c.speed_multiplier            = c.speed_multiplier * 0.45
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 50.0
			c.extra_entities              = c.extra_entities .. "data/entities/particles/heavy_shot.xml,"

			if (c.speed_multiplier >= 20) then
				c.speed_multiplier = math.min(c.speed_multiplier, 20)
			elseif (c.speed_multiplier < 0) then
				c.speed_multiplier = 0
			end

			draw_actions(1, true)
		end,
	},
	["LIGHT_SHOT"] = {
		action = function()
			c.damage_projectile_add       = c.damage_projectile_add - 0.3
			c.fire_rate_wait              = c.fire_rate_wait - 3
			c.speed_multiplier            = c.speed_multiplier * 7.5
			c.spread_degrees              = c.spread_degrees - 6
			shot_effects.recoil_knockback = shot_effects.recoil_knockback - 10.0
			c.extra_entities              = c.extra_entities .. "data/entities/particles/light_shot.xml,"

			if (c.speed_multiplier >= 20) then
				c.speed_multiplier = math.min(c.speed_multiplier, 20)
			elseif (c.speed_multiplier < 0) then
				c.speed_multiplier = 0
			end

			draw_actions(1, true)
		end,
	},
	["KNOCKBACK"] = {
		mana = 2,
		price = 40, -- make cheaper so it isnt an investment to buy garbage spells
	},
	["RECOIL"] = {
		mana = 3,
		price = 30,
		action = function()
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 200.0
			c.fire_rate_wait = c.fire_rate_wait - 3 -- make this encourage usage for transport otherwise its literally useless in every way
			current_reload_time = current_reload_time - 1
			draw_actions(1, true)
		end,
	},
	-- buff these three and make them more common so they're not dogwater (as much)
	["FLAMETHROWER"] = {
		spawn_level = "0,1,2,3,4,6",
		spawn_probability = "0.5,0.5,1,1,1,1",
		max_uses = -1,
	},
	["FIREBALL"] = {
		spawn_level = "0,1,2,3,4,6",
		spawn_probability = "0.5,0.5,1,1,1,1",
		mana = 20, -- from 70
		max_uses = 25, -- from 15
		action 		= function()
			add_projectile("data/entities/projectiles/deck/fireball.xml")
			c.spread_degrees = c.spread_degrees + 4.0
			c.fire_rate_wait = c.fire_rate_wait + 20 -- from 50
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
		end,
	},
	["ICEBALL"] = {
		spawn_level = "0,1,2,3,4,6",
		spawn_probability = "0.5,0.5,1,1,1,1",
		mana = 30, -- from 90
		max_uses = 25, -- from 15
		action 		= function()
			add_projectile("data/entities/projectiles/deck/iceball.xml")
			c.spread_degrees = c.spread_degrees + 8.0
			c.fire_rate_wait = c.fire_rate_wait + 40 -- from 80
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
		end,
	},
	-- lost cause tbh
	["PURPLE_EXPLOSION_FIELD"] = {
		max_uses = -1,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/purple_explosion_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 10
		end,
	},
	-- why were these not modifiers before (controversial?)
	--[[
	["MONEY_MAGIC"] = {
		type 		= ACTION_TYPE_MODIFIER,
	},
	["BLOOD_TO_POWER"] = {
		type 		= ACTION_TYPE_MODIFIER,
	},
	]]--
	-- make these goobers add damage and lifetime
	["CHAOTIC_ARC"] = {
		action 		= function()
			c.extra_entities = c.extra_entities .. "data/entities/misc/chaotic_arc.xml,"
			c.speed_multiplier = c.speed_multiplier * 2
			c.lifetime_add = c.lifetime_add + 40
			c.damage_slice_add = c.damage_slice_add + 0.4
			
			if ( c.speed_multiplier >= 20 ) then
				c.speed_multiplier = math.min( c.speed_multiplier, 20 )
			elseif ( c.speed_multiplier < 0 ) then
				c.speed_multiplier = 0
			end
			
			draw_actions( 1, true )
		end,
	},
	["SINEWAVE"] = {
		action 		= function()
			c.extra_entities = c.extra_entities .. "data/entities/misc/sinewave.xml,"
			c.speed_multiplier = c.speed_multiplier * 2
			c.lifetime_add = c.lifetime_add + 15
			c.damage_projectile_add = c.damage_projectile_add + 0.2
			
			if ( c.speed_multiplier >= 20 ) then
				c.speed_multiplier = math.min( c.speed_multiplier, 20 )
			elseif ( c.speed_multiplier < 0 ) then
				c.speed_multiplier = 0
			end
			
			draw_actions( 1, true )
		end,
	}
}

return actions_to_edit
