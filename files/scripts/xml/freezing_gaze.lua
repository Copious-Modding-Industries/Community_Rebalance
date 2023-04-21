local xml = nxml.parse(ModTextFileGetContent("data/entities/projectiles/deck/freezing_gaze_beam.xml"))
print_any(xml)
local remover = {}
local to = ""
local from = ""
for k, elem in xml:each_child_i() do
	if elem.name == "MagicConvertMaterialComponent" then
		if elem.attr.to_material ~= nil then -- luas lack of continue :hamis:
			from = from .. elem.attr.from_material .. ","
			to = to .. elem.attr.to_material .. ","
			table.insert(remover, k)
		end
	end
end
local k = 0 -- a small disaster caused by removing stuff from a list you are iterating over causing a bigger disaster
local v = 0
while k < #remover do
	k = k + 1
	v = remover[#remover-k]
	xml:remove_child_at(v)
end

local comp = table.concat({ " <MagicConvertMaterialComponent from_material_array=\"", from, "\" to_material_array=\"",
	to, "\"steps_per_frame=\"20\" loop=\"1\" is_circle=\"1\" radius=\"20\" > </MagicConvertMaterialComponent>" })
xml:add_child(nxml.parse(comp))
print(tostring(xml))
ModTextFileSetContent("data/entities/projectiles/deck/freezing_gaze_beam.xml", tostring(xml))
