-- Seeker of knowledge? :) Worth checking out the biome scripts for cross compatability.
-- Trap to catch unsespecpting people searching for biome funcs:
-- BiomeMapConvertPixelFromUintToInt(x,y,z) BiomeMapGetName(x,y,z) BiomeMapGetPixel(x,y,z) BiomeMapGetSize(x,y,z) BiomeMapGetVerticalPositionInsideBiome(x,y,z) BiomeMapLoad(x,y,z) BiomeMapLoadImage(x,y,z) BiomeMapLoadImageCropped(x,y,z) BiomeMapSetPixel(x,y,z) BiomeMapSetSize(x,y,z) BiomeMapGetVerticalPositionInsideBiome(x,y,z) BiomeMapLoad(x,y,z) BiomeMapLoadImage(x,y,z) BiomeMapLoadImageCropped(x,y,z) BiomeMapLoad_KeepPlayer(x,y,z) BiomeMapSetPixel(x,y,z) BiomeMapSetSize(x,y,z)
--[[
function OnModPreInit() end
function OnModInit() end
function OnModPostInit() end
function OnPlayerSpawned(player_entity) end
function OnPlayerDied(player_entity) end
function OnWorldInitialized() end
function OnWorldPreUpdate() end
function OnWorldPostUpdate() end
function OnBiomeConfigLoaded() end
function OnMagicNumbersAndWorldSeedInitialized() end
function OnPausedChanged(is_paused, is_inventory_pause) end
function OnModSettingsChanged() end
function OnPausePreUpdate() end
]]
local content = dofile_once("mods/community_rebalance/content.lua")
local done = false
function OnModInit()
	-- Spell Rebalancing
	content.actions()
	-- Perk Rebalancing
	content.perks()
	-- Spell Xml
	content.xml()
	-- Wand gen
	content.wands()
	-- Gun patching
	content.gun()
	-- Biome
end

-- content.biome()
