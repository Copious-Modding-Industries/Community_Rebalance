---@diagnostic disable: lowercase-global
-- # Make VSC shut up about globals

add_projectile = add_projectile                                     ---@type function
draw_actions = draw_actions                                         ---@type function
c = c                                                               ---@type table
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
		action = function ( recursion_level, iteration )
			local mana_per_cd_frame = 1 -- change this to control how much mana each frame of cast delay costs
			local amount_to_remove = math.min(mana * mana_per_cd_frame, c.fire_rate_wait)
			mana = mana - amount_to_remove * mana_per_cd_frame
			add_projectile("data/entities/projectiles/deck/chainsaw.xml")
			-- Tweak: mana reduction proportional to cast delay reduced, need feedback on scaling
			c.fire_rate_wait = c.fire_rate_wait - amount_to_remove
			c.spread_degrees = c.spread_degrees + 6.0
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the digger reload time back to 0
		end
	},

	["MANA_REDUCE"] = {
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 12
			draw_actions( 1, true )
		end,
	},

	["LUMINOUS_DRILL"] = {
		mana = 30,
	},

	["LASER_LUMINOUS_DRILL"] = {
		mana = 45,
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

}

return actions_to_edit