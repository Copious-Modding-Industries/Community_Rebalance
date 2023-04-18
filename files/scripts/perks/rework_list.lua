---@diagnostic disable: lowercase-global
-- Make VSC shut up about globals


return
{	-- TODO update translation
	EXTRA_MANA = { -- 2/3 capacity
		func = function( entity_perk_item, entity_who_picked, item_name )
			local wand = find_the_wand_held( entity_who_picked )
			local x,y = EntityGetTransform( entity_who_picked )
			
			SetRandomSeed( entity_who_picked, wand )
			
			if ( wand ~= NULL_ENTITY ) then
				local comp = EntityGetFirstComponentIncludingDisabled( wand, "AbilityComponent" )
				
				if ( comp ~= nil ) then
					local mana_max = ComponentGetValue2( comp, "mana_max" )
					local mana_charge_speed = ComponentGetValue2( comp, "mana_charge_speed" )
					local deck_capacity = ComponentObjectGetValue( comp, "gun_config", "deck_capacity" )
					local deck_capacity2 = EntityGetWandCapacity( wand )
					
					local always_casts = math.max( 0, deck_capacity - deck_capacity2 )
					
					mana_max = math.min( mana_max + Random( 10, 20 ) * Random( 10, 30 ), 20000 )
					mana_charge_speed = math.min( math.min( mana_charge_speed * Random( 200, 350 ) * 0.01, mana_charge_speed + Random( 100, 300 ) ), 20000 )
					
					deck_capacity2 = math.max( 1, math.floor( deck_capacity2 * 2 / 3 ) )
					
					ComponentSetValue2( comp, "mana_max", mana_max )
					ComponentSetValue2( comp, "mana_charge_speed", mana_charge_speed )
					ComponentObjectSetValue( comp, "gun_config", "deck_capacity", deck_capacity2 + always_casts )
					
					local c = EntityGetAllChildren( wand )
					
					if ( c ~= nil ) and ( #c > deck_capacity2 + always_casts ) then
						for i=always_casts+1,#c do
							local v = c[i]
							local comp2 = EntityGetFirstComponentIncludingDisabled( v, "ItemActionComponent" )
							
							if ( comp2 ~= nil ) and ( i > deck_capacity2 + always_casts ) then
								EntityRemoveFromParent( v )
								EntitySetTransform( v, x, y )
								
								local all = EntityGetAllComponents( v )
								
								for a,b in ipairs( all ) do
									EntitySetComponentIsEnabled( v, b, true )
								end
							end
						end
					end
				end
			end
		end,
	},
	GENOME_MORE_HATRED = { -- 5% chance of blood money
		func = function( entity_perk_item, entity_who_picked, item_name )
			-- TODO - impl

			local world_entity_id = GameGetWorldStateEntity()
			if( world_entity_id ~= nil ) then
				local comp_worldstate = EntityGetFirstComponent( world_entity_id, "WorldStateComponent" )
				if( comp_worldstate ~= nil ) then
					local perk_hp_drop_chance = tonumber( ComponentGetValue2( comp_worldstate, "perk_hp_drop_chance" ) )
					perk_hp_drop_chance = perk_hp_drop_chance + 5
					ComponentSetValue2( comp_worldstate, "perk_hp_drop_chance", perk_hp_drop_chance )
					local global_genome_relations_modifier = tonumber( ComponentGetValue( comp_worldstate, "global_genome_relations_modifier" ) )
					global_genome_relations_modifier = global_genome_relations_modifier - 25
					ComponentSetValue( comp_worldstate, "global_genome_relations_modifier", tostring( global_genome_relations_modifier ) )
				end
			end

			add_halo_level(entity_who_picked, -1)
		end,
		func_remove = function( entity_who_picked )
			local world_entity_id = GameGetWorldStateEntity()
			if( world_entity_id ~= nil ) then
				local comp_worldstate = EntityGetFirstComponent( world_entity_id, "WorldStateComponent" )
				if( comp_worldstate ~= nil ) then
					ComponentSetValue( comp_worldstate, "global_genome_relations_modifier", "0" )
				end
			end
		end,
	}
}
