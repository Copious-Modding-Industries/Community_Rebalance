--- ### Gets the current card entity.
--- ***
--- @return integer|nil card The *Entity ID* of the card being played.
function CurrentCard(current_action)
    local shooter = GetUpdatedEntityID()
    local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component")
    if inv2comp then
        local activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
        if EntityHasTag(activeitem, "wand") then
            local wand_actions = EntityGetAllChildren(activeitem) or {}
            for j = 1, #wand_actions do
                local itemcomp = EntityGetFirstComponentIncludingDisabled(wand_actions[j], "ItemComponent")
                if itemcomp then
                    if ComponentGetValue2(itemcomp, "mItemUid") == current_action.inventoryitem_id then
                        return wand_actions[j]
                    end
                end
            end
        end
    end
end


--- ### Shakes the mana bar and plays the out of mana sound
function ShakeManaBar()
    local shooter = GetUpdatedEntityID()
    local invguicomp = EntityGetFirstComponentIncludingDisabled(shooter, "InventoryGuiComponent")
    if invguicomp then
        GamePlaySound("data/audio/Desktop/projectiles.items", "magic_wand/not_enough_mana_for_action", GameGetCameraPos())
        ComponentSetValue2(invguicomp, "mFrameShake_ManaBar", GameGetFrameNum())
    end
end