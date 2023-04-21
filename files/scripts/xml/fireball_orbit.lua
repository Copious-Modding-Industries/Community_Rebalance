local xml = nxml.parse(ModTextFileGetContent("data/entities/misc/orbit_fireballs_fireball.xml"))
for elem in xml:each_child() do
	-- print_any(elem)
	if elem.name == "ProjectileComponent" then
		elem.children[1].attr.fire = 0.1
		elem.children[2].attr.damage = 0.6
	end
end
ModTextFileSetContent("data/entities/misc/orbit_fireballs_fireball.xml",tostring(xml))