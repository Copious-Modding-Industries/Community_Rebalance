-- local xml = nxml.parse(ModTextFileGetContent("data/materials.xml"))
-- local cat = ""
-- local to = ""
-- for elem in xml:each_child() do
-- 	if elem.attr.cell_type == "fire" then
-- 		cat = cat .. "," .. elem.attr.name
-- 		to = to .. ",air"
-- 	end 
-- end
local xml = nxml.parse(ModTextFileGetContent("data/entities/particles/freeze_charge.xml"))
for elem in xml:each_child() do
	-- print_any(elem)
	if elem.name == "MagicConvertMaterialComponent" then
		if elem.attr.from_material_array ~= nil then
			-- elem.attr.from_material_array = elem.attr.from_material_array .. cat
			-- elem.attr.to_material_array = elem.attr.to_material_array .. to
		end
	end
end
ModTextFileSetContent("data/entities/particles/freeze_charge.xml",tostring(xml))