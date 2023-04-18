xml = nxml.parse(ModTextFileGetContent("data/entities/projectiles/deck/ball_lightning.xml"))
for elem in xml:each_child() do
	print_any(elem)
	if elem.name == "ProjectileComponent" then
		elem.children[1].attr.electricity = 1.2
		elem.attr.on_collision_die = true
		elem.attr.on_death_explode = true
	end
end
ModTextFileSetContent("data/entities/projectiles/deck/ball_lightning.xml",tostring(xml))