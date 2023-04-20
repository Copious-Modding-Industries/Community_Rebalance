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
			print("chest")
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
			print("chest")
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
	["ADD_TIMER"] = {
		action = function()
			print("chest")
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
}

return actions_to_edit
