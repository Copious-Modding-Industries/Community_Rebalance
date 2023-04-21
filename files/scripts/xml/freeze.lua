local xml = nxml.parse(ModTextFileGetContent("data/entities/particles/freeze_charge.xml"))
for elem in xml:each_child() do
	if elem.name == "MagicConvertMaterialComponent" then
		elem.attr.extinguish_fire = true
	end
end
ModTextFileSetContent("data/entities/particles/freeze_charge.xml", tostring(xml))
