-- dofile_once("mods/community_rebalance/files/scripts/lib/print.lua")
counter = {}
trigger_nesting = 0
function draw_shot_trigger(shot, instant_reload_if_empty)
	trigger_nesting = trigger_nesting + 1
	counter[trigger_nesting] = 0
	local c_old = c
	c = shot.state

	shot_structure = {}
	draw_actions(shot.num_of_cards_to_draw, instant_reload_if_empty)
	register_action(shot.state)
	SetProjectileConfigs()

	local trigger_cd = c.fire_rate_wait
	c = c_old
	if trigger_nesting ~= 1 then
		counter[trigger_nesting - 1] = counter[trigger_nesting - 1] + counter[trigger_nesting]
	end
	-- print_any(counter,0,"count")
	-- print_any(trigger_nesting,0,"trig")
	c.speed_multiplier = c.speed_multiplier / math.max(counter[trigger_nesting], 1) ^ 0.5
	-- print(tostring(counter[trigger_nesting]))
	-- print(tostring(c.speed_multiplier))
	counter[trigger_nesting] = nil
	trigger_nesting = trigger_nesting - 1
	c.fire_rate_wait = c.fire_rate_wait + trigger_cd / 2
end
