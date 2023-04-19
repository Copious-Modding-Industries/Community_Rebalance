
function draw_shot_trigger(shot, instant_reload_if_empty)
	local c_old = c
	c = shot.state

	shot_structure = {}
	draw_actions(shot.num_of_cards_to_draw, instant_reload_if_empty)
	register_action(shot.state)
	SetProjectileConfigs()

	local trigger_cd = c.fire_rate_wait
	print(trigger_cd)
	c = c_old
	c.fire_rate_wait = c.fire_rate_wait + trigger_cd / 2
end
