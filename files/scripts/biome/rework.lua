local nxml = dofile_once("mods/community_rebalance/files/scripts/lib/nxml.lua")

local xml = nxml.parse(ModTextFileGetContent("data/biome/_biomes_all.xml"))
xml:add_child(nxml.parse([[<Biome 
biome_filename="mods/community_rebalance/files/scripts/biome/gold_tox.xml" 
height_index="10"
color="ff17f04a" >
</Biome>]])) -- random colour i made up today
ModTextFileSetContent("data/biome/_biomes_all.xml",tostring(xml))
-- print(ModTextFileGetContent("data/biome/_biomes_all.xml"))
-- BiomeMapLoad("data/biome_impl/biome_map.png")
-- BiomeMapSetSize( 64, 48 )
-- BiomeMapLoadImage( 0, 0, "data/biome_impl/biome_map_newgame_plus.png" )
-- for x = 1,40 do
-- 	for y = 1,40 do
-- 		BiomeMapSetPixel(x,y,0xff3d3e3c)
-- 	end
-- end
-- BiomeMapLoad_KeepPlayer( "mods/files/scripts/biome/biome.lua", "data/biome/_pixel_scenes.xml" )
-- SessionNumbersSave()
local exists = ModTextFileGetContent("data/scripts/biomes/new/map_append.lua") ~= nil
print(tostring(exists))
if not exists then
	ModTextFileSetContent("data/scripts/biomes/new/map_append.lua","BiomeMapSetSize(70,48)\nBiomeMapLoadImage(0, 0, \"data/biome_impl/biome_map.png\")\n")
end
-- idk append wasnt working pls fix this coper or puder
ModTextFileSetContent("data/scripts/biomes/new/map_append.lua",ModTextFileGetContent("data/scripts/biomes/new/map_append.lua")..ModTextFileGetContent("mods/community_rebalance/files/scripts/biome/map_append.lua"))
print(ModTextFileGetContent("data/scripts/biomes/new/map_append.lua"))

ModMagicNumbersFileAdd("mods/community_rebalance/files/scripts/biome/magic.xml")