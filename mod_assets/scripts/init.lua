-- objects patch for detect spells
import "mod_assets/spells_pack/defineObject.lua"
-- import standard assets
import "mod_assets/scripts/mod_standard_assets.lua"
import "mod_assets/scripts/objects/generic.lua"
import "mod_assets/scripts/objects/beach.lua"
import "mod_assets/scripts/objects/forest.lua"
import "mod_assets/scripts/objects/mine.lua"
import "mod_assets/scripts/objects/tomb.lua"
import "mod_assets/scripts/objects/breakable.lua"
import "mod_assets/scripts/objects/dungeon.lua"
import "mod_assets/scripts/objects/castle.lua"
import "mod_assets/scripts/objects/stone_philosophers.lua"
import "mod_assets/scripts/objects/sky.lua"
import "mod_assets/scripts/objects/pushable_block.lua"
import "mod_assets/scripts/materials/tomb.lua"
import "mod_assets/scripts/materials/beach.lua"
import "mod_assets/scripts/materials/generic.lua"
import "mod_assets/scripts/materials/monsters.lua"
import "mod_assets/scripts/materials/items.lua"
import "mod_assets/scripts/materials/forest.lua"
-- import the spells pack
import "mod_assets/spells_pack/init.lua"   -- the spells pack
import "mod_assets/scripts/spells/ash.lua"
import "mod_assets/scripts/spells/ancestral_charge.lua"
import "mod_assets/scripts/spells/bite.lua"
import "mod_assets/scripts/spells/psionic_arrow.lua"
import "mod_assets/scripts/spells/red_aoe.lua"
-- import custom assets
import "mod_assets/scripts/objects/base.lua"
import "mod_assets/scripts/defineObject.lua"
import "mod_assets/scripts/test.lua"
import "mod_assets/scripts/functions.lua"
import "mod_assets/scripts/level_start.lua"
import "mod_assets/scripts/beach.lua"
import "mod_assets/scripts/objects.lua"
import "mod_assets/scripts/tiles.lua"
import "mod_assets/scripts/recipes.lua"
import "mod_assets/scripts/spells.lua"
import "mod_assets/scripts/sounds.lua"
import "mod_assets/scripts/skills.lua"
import "mod_assets/scripts/traits.lua"
import "mod_assets/scripts/conditions.lua"
-- Monsters
import "mod_assets/scripts/monsters/dummy.lua"
import "mod_assets/scripts/monsters/ash_elemental.lua"
import "mod_assets/scripts/monsters/turtle.lua"
import "mod_assets/scripts/monsters/mummy.lua"
import "mod_assets/scripts/monsters/sand_warg.lua"
import "mod_assets/scripts/monsters/twigroot.lua"
import "mod_assets/scripts/monsters/burnt_twigroot.lua"
import "mod_assets/scripts/monsters/xeloroid.lua"
import "mod_assets/scripts/monsters/cave_crab.lua"
import "mod_assets/scripts/monsters/lava_crab.lua"
import "mod_assets/scripts/monsters/ice_crab.lua"
import "mod_assets/scripts/monsters/scorched_root.lua"
-- Items
import "mod_assets/scripts/items/accessories.lua"
import "mod_assets/scripts/items/armors.lua"
import "mod_assets/scripts/items/axes.lua"
import "mod_assets/scripts/items/clothes.lua"
import "mod_assets/scripts/items/containers.lua"
import "mod_assets/scripts/items/crystal_shards.lua"
import "mod_assets/scripts/items/daggers.lua"
import "mod_assets/scripts/items/firearms.lua"
import "mod_assets/scripts/items/food.lua"
import "mod_assets/scripts/items/herbs.lua"
import "mod_assets/scripts/items/items.lua"
import "mod_assets/scripts/items/maces.lua"
import "mod_assets/scripts/items/missile_weapons.lua"
import "mod_assets/scripts/items/misc.lua"
import "mod_assets/scripts/items/misc_weapons.lua"
import "mod_assets/scripts/items/potions.lua"
import "mod_assets/scripts/items/scrolls.lua"
import "mod_assets/scripts/items/shields.lua"
import "mod_assets/scripts/items/staves.lua"
import "mod_assets/scripts/items/swords.lua"
import "mod_assets/scripts/items/throwing_weapons.lua"
import "mod_assets/scripts/items/tomes.lua"
import "mod_assets/scripts/items/tinkering.lua"
-- Other
import "mod_assets/scripts/particles/blooddrop.lua"
import "mod_assets/scripts/particles/soundGate.lua"
import "mod_assets/scripts/particles/forest_lantern2.lua"
import "mod_assets/scripts/particles/amateria.lua"
import "mod_assets/fire_cave/scripts/init.lua"

defineObject{
	name = "party",
	baseObject = "party",
	components = {
		{ 
			class = "Script",
			name = "data",
			source = [[
					data = {}
					function get(self,name) return self.data[name] end
					function set(self,name,value) self.data[name] = value end
					]],
		},
		{
        class = "Party",
		-----------------------------------------------------------
		-- On Move
		-----------------------------------------------------------
		onMove = function(party, dir, arg1)
			functions.script.stepCountIncrease()

			local period = party.go.data:get("period") or "present"
			local dx,dy = getForward(dir)
			if period == "past" and functions2.script.travel_mode == "device" then
				local obj1 = party.go
				local obj2 = functions2.script.travel_crystal
				local mx, my, mz = obj1.map:getLevelCoord()
				if #obj2 ~= 0 and obj1 then
					local distance = math.abs(math.sqrt((((obj1.x+dx) - obj2[1]) ^ 2) + (((obj1.y+dy) - obj2[2]) ^ 2)))
					distance = distance + math.abs(obj1.elevation - obj2[3])
					distance = distance + math.abs(mz - obj2[6])
					functions2.script.updateTimeTravelTimer(distance)
				end
			end

			-- Herb multiply
			local fiberBalls = 0
			for i=1,4 do
				local champion = party:getChampionByOrdinal(i)
				
				for slot,item in champion:carriedItems() do
					if item.go.name == "fiber_ball_good" then
						fiberBalls = fiberBalls + 1
					end
				end
				
				local insertHerb = nil
				
				if champion:getSkillLevel("alchemy") > 0 then
					local herb_items = {["blooddrop_cap"] = 450, ["etherweed"] = 930, ["mudwort"] = 1950, ["falconskyre"] = 2500, ["blackmoss"] = 3700, ["crystal_flower"] = 4500}
					for herb,count in pairs(herb_items) do
						if fiberBalls > 0 then
							local multipliers = {1,0.95,0.94,0.93,0.93,0.92,0.92,0.91,0.9,0.88,0.85}
							count = math.floor(count * multipliers[math.min(fiberBalls, 10)])
						end
						if functions.script.stepCount % count == 0 and party:isCarrying(herb) then
							insertHerb = herb
						end
					end
					if insertHerb then
						local herbSlot = 0
						local slotsFilled = 0
						for slot=13,32 do
							if champion:getItem(slot) == nil then
								champion:insertItem(slot, spawn(insertHerb).item)
								break
							else
								if champion:getItem(slot).go.name == insertHerb then
									herbSlot = slot
								end
								slotsFilled = slotsFilled + 1
							end
							if slotsFilled == 20 then
								champion:getItem(herbSlot):setStackSize(champion:getItem(herbSlot):getStackSize() + 1)
							end
						end
					end
					break
				end

				local insertPellet = nil

				if champion:hasTrait("metal_slug") then
					local count = functions.script.metalSlugList[(functions.script.metalSlug % 12) + 1]
					
					if functions.script.stepCount % count == 0 then
						insertPellet = true
						functions.script.metalSlugListIncrease()
					end

					if insertPellet then
						local pelletSlot = 0
						local slotsFilled = 0
						for slot=13,32 do
							if champion:getItem(slot) == nil then
								champion:insertItem(slot, spawn("pellet_box").item)
								break
							else
								if champion:getItem(slot).go.name == "pellet_box" then
									herbSlot = slot
								end
								slotsFilled = slotsFilled + 1
							end
							if slotsFilled == 20 then
								champion:getItem(pelletSlot):setStackSize(champion:getItem(pelletSlot):getStackSize() + 1)
							end
						end
					end
				end
			end
			
			for i=1,4 do
				local champion = party:getChampionByOrdinal(i)
				for slot=1,32 do
					local item = champion:getItem(slot)
					if item and item:hasTrait("magic_gem") and item.go.data:get("charges") then
						if item.go.data:get("burnout") == nil then item.go.data:set("burnout", 0) end
						item.go.data:set("burnout", math.min(item.go.data:get("burnout") + 1, 4500))
						if item.go.data:get("burnout") >= 4500 then
							champion:removeItem(item)
							champion:insertItem(slot, spawn("coal").item)
						end
						if item.go.data:get("burnout") % 450 == 0 then
							-- print("Item", item.go.name, "reached a burnout of", item.go.data:get("burnout"), "out of a max", 4500)
						end
					end

					if item and item.go.name == "fiber_ball_good" then
						if item.go.data:get("burnout") == nil then item.go.data:set("burnout", 0) end
						local parent = party:getChampionByOrdinal(item.go.data:get("parent") or 1)
						local b_timer = 1000 + (parent:getLevel() - 1) * 135
						
						item.go.data:set("burnout", math.min(item.go.data:get("burnout") + 1, b_timer))
						if item.go.data:get("burnout") >= b_timer then
							champion:removeItem(item)
							champion:insertItem(slot, spawn("fiber_ball_bad").item)
						end
						if item.go.data:get("burnout") % 200 == 0 then
							-- print("Item", item.go.name, "reached a burnout of", item.go.data:get("burnout"), "out of a max", b_timer)
						end
					end

					if item and item.go.name == "ice_sword" then
						if item.go.data:get("burnout") == nil then item.go.data:set("burnout", 0) end
						local parent = party:getChampionByOrdinal(item.go.data:get("parent") or 1)
						local b_timer = item.go.data:get("b_timer")
						
						item.go.data:set("burnout", math.min(item.go.data:get("burnout") + 1, b_timer))
						if item.go.data:get("burnout") >= b_timer then
							champion:removeItem(item)
						end
						if item.go.data:get("burnout") > b_timer * 0.5 and item.go.data:get("burnout") < b_timer * 0.9 then
							item:setGameEffect("You get frostburn if your Cold Resist is under 50.\nYou can feel the sword's cold begin to fade.")
						elseif item.go.data:get("burnout") >= b_timer * 0.9  then
							item:setGameEffect("You get frostburn if your Cold Resist is under 50.\nIt's starting to melt.")
						end
					end
				end
				
				if champion:hasCondition("bleeding") and math.random() <= 0.33 then
					functions.script.championBleed(champion, "moving")
				end
			end
		end,
		-----------------------------------------------------------
		-- Turn
		-----------------------------------------------------------
		onTurn = function(party, dir, arg1)
			--print(party.go.id, "turning to", dir) 
		end,
		-----------------------------------------------------------
		-- On Attack
		-----------------------------------------------------------		
		onAttack = function(party, champion, action, slot)
			-- print(champion:getName(), "is attacking with", action.go.name)
			local c = champion:getOrdinal()
			if action.go.name == "mortar" then
				functions.script.set_c("using_mortar", c)
			end

			if action.go.name == "tinkering_toolbox" then
				-- Sets target item to the other hand slot to the toolbox
				local otherSlot = slot == ItemSlot.Weapon and ItemSlot.OffHand or ItemSlot.Weapon								
				if champion:getItem(otherSlot) then
					if champion:getItem(otherSlot):hasTrait("upgradable") then
						functions.script.set_c("tinkering", c, otherSlot)
					else
						hudPrint("Item is not upgradable.")
					end
				else
					hudPrint("Needs target item in other hand.")
				end
			end

			if action.go.item and action.go.item:hasTrait("potion") then
				local item = action.go.item
				if item then
					functions.script.set_c("potion_slot", c, slot)
					functions.script.set_c("potion_bottom_item", c, item.go.id)
					functions.script.set_c("potion_stacks", c, item:getStackSize())
				else
					functions.script.set_c("potion_slot", c, nil)
					functions.script.set_c("potion_bottom_item", c, nil)
					functions.script.set_c("potion_stacks", c, nil)
				end
			end
			
			if action.go.item:getSecondaryAction() == "dagger_throw" and action.go.dagger_throw == action then
				if action.go.meleeattack then
					-- functions.script.onMeleeAttack(action.go.dagger_throw, action.go.item, champion, slot, 0, nil)
				end
			end

			if action.go.bombitem then
				if champion:hasTrait("bomb_multiplication") then
					local item = champion:getItem(slot)
					local chance = 0.1 + (champion:getCurrentStat("dexterity") / 200)
					if item and item == action.go.item and math.random() <= chance then
						item:setStackSize(item:getStackSize() + 1)
					end
				end
			end
			
			if champion:hasCondition("bleeding") then
				functions.script.championBleed(champion, "attacking")
			end
			
			if champion:hasTrait("sneak_attack") and champion:hasCondition("sneak_attack") then
				champion:removeCondition("sneak_attack")
				functions.script.set_c("sneak_attack", champion:getOrdinal(), true)
				--print("sneak_attack set")
			end
			
			for i=1,4 do
				local c = party:getChampionByOrdinal(i)				
				if c ~= champion then
					-- functions.script.set_c("attackedWith", c:getOrdinal(), nil)
					-- functions.script.set_c("attacked", c:getOrdinal(), nil)
				end
			end
			
			functions.script.set_c("attackedWith", champion:getOrdinal(), action.go.name)
			functions.script.set_c("attacked", champion:getOrdinal(), champion:getOrdinal())
			-- functions.script.reset_attack(action.go.meleeattack, champion, slot, 0, action.go.item)
		end,
		-----------------------------------------------------------
		-- On Damage Taken
		-----------------------------------------------------------
		onDamage = function(self, champion, damage, damageType)
			--print(party.go.id, champion:getName(), 'received', damage, 'damage,', damageType, 'type') 
			functions.script.onChampionTakesDamage(self, champion, damage, damageType)

			if GameMode.damageRecurse then
				GameMode.damageRecurse = nil
				return true
			elseif damage > 1 then
				damage = math.max(1,damage - champion:getLevel())
				GameMode.damageRecurse = true
				champion:damage(damage,"pure")
				return false
			end
		end,
		
		-- WORKS
		onProjectileHit = function(party,champion,projectile,damage,damageType)
			print(party.go.id,champion:getName(),'is hit by a', projectile.go.name, damage, damageType) 
		end,
		
		-- WORKS
		onDie = function(party,champion) 
			--print(party.go.id,champion:getName(),'died') 
			-- for i=1,4 do
			-- 	if party:getChampion(i):getClass() == "fighter" and party:getChampion(i):isAlive() then
			-- 		party:getChampion(i):setConditionValue("berserker_revenge", 60)
			-- 		if party:getChampion(i):hasCondition("berserker_rage") then
			-- 			party:getChampion(i):removeCondition("berserker_rage")
			-- 		end
			-- 	end
			-- end
		end,
		
		-- WORKS
		onRest = function(party)
			print(party.go.id,'is resting') 
			
		end,
		
		-- WORKS
		onWakeUp = function(party) 
			print(party.go.id,'woke up') 
			for i=1,4 do
				if party:getChampionByOrdinal(i):getClass() == "stalker____" then
					local night_stalker_charges = functions.script.get_c("night_stalker", i)
					--print(party.go.partycounter:getValue())
					if night_stalker_charges > 0 then
						--print(functions.script.night_stalker[i])
						local bonus = 22 + ((party:getChampion(i):getLevel()-1) * 2)
						spells_functions.script.maxConditionValue("invisibility", 8 + bonus)
						spells_functions.script.maxEffectIcons("invisibility", 8 + bonus)
						functions.script.set_c("night_stalker", i, -1)
						if night_stalker_charges == 1 then
							hudPrint(party:getChampionByOrdinal(i):getName() .. " has run out of casts of Invisibility.")
						end
					else
						--hudPrint(party:getChampionByOrdinal(i):getName() .. " has no casts of Invisibility left.")
					end
				end
			end
		end,
		
		onClickItemSlot = function(self, champion, container, slot, button)
			--if champion:getItem(slot) then print(champion:getItem(slot).go.id) end
			local f = 0
			local MX = 0
			local MY = 0
			local w = 0
			local h = 0

			if party.partycounter:getValue() > 0 then
				f = functions.script.get("f")
				w = functions.script.get("w")
				h = functions.script.get("h")
				MX = functions.script.get("MX")
				MY = functions.script.get("MY")
			end
			
			local attackPanelXYcoords = { {w - (426 * f), 743 * f}, {w - (220 * f), 743 * f}, {w - (426 * f), 943 * f}, {w - (220 * f), 943 * f} } 
			local runePanelWidth, runePanelHeight = 156 * f, 100 * f
			local mouseOverPortraitZone = iff(MX > attackPanelXYcoords[4][1] and MX < attackPanelXYcoords[4][1] + runePanelWidth and MY > attackPanelXYcoords[4][2] and MY < attackPanelXYcoords[4][2] + runePanelHeight, 4, 
								iff(MX > attackPanelXYcoords[3][1] and MX < attackPanelXYcoords[3][1] + runePanelWidth and MY > attackPanelXYcoords[3][2] and MY < attackPanelXYcoords[3][2] + runePanelHeight, 3, 
								iff(MX > attackPanelXYcoords[2][1] and MX < attackPanelXYcoords[2][1] + runePanelWidth and MY > attackPanelXYcoords[2][2] and MY < attackPanelXYcoords[2][2] + runePanelHeight, 2, 
								iff(MX > attackPanelXYcoords[1][1] and MX < attackPanelXYcoords[1][1] + runePanelWidth and MY > attackPanelXYcoords[1][2] and MY < attackPanelXYcoords[1][2] + runePanelHeight, 1, 
								nil))))

								-- print(mouseOverPortraitZone)
			if mouseOverPortraitZone then
				champion = party.party:getChampion(mouseOverPortraitZone)
			end

			if champion then
				local mouseItem = getMouseItem()
				local item = champion:getItem(slot)
				if item and item:hasTrait("potion") then
					functions.script.set_c("potion_slot", champion:getOrdinal(), slot)
					if mouseItem and mouseItem.go.name == item.go.name and mouseItem:hasTrait("potion") then
						functions.script.set_c("potion_top_item", champion:getOrdinal(), mouseItem.go.id)
					else
						functions.script.set_c("potion_top_item", champion:getOrdinal(), nil)
					end
					functions.script.set_c("potion_bottom_item", champion:getOrdinal(), item.go.id)
					functions.script.set_c("potion_stacks", champion:getOrdinal(), item:getStackSize())

				else
					if mouseItem and mouseItem:hasTrait("potion") then
						functions.script.set_c("potion_top_item", champion:getOrdinal(), mouseItem.go.id)
						functions.script.set_c("potion_slot", champion:getOrdinal(), slot)
						functions.script.set_c("potion_stacks", champion:getOrdinal(), nil)
					else
						functions.script.set_c("potion_top_item", champion:getOrdinal(), nil)
						functions.script.set_c("potion_slot", champion:getOrdinal(), nil)
						functions.script.set_c("potion_stacks", champion:getOrdinal(), nil)
					end
				end

				-- Click a slot with a herb in the cursor
				if mouseItem and mouseItem:hasTrait("herb") and champion:getClass() == "druid" then
					if slot == ItemSlot.Bracers or slot == ItemSlot.Necklace or slot == ItemSlot.Gloves then
						local prevItem = functions.script.get_c("druid_item"..slot, champion:getOrdinal())
						functions.script.set_c("druid_item"..slot, champion:getOrdinal(), mouseItem.go.name)
						
						if prevItem then
							if prevItem ~= mouseItem.go.name then
								if mouseItem:getStackSize() > 1 then
									mouseItem:setStackSize(mouseItem:getStackSize() - 1)
									
									for j=13,32 do
										if champion:getItem(j) == nil then 
											champion:insertItem(j, spawn(prevItem).item)
											break 
										end
										if j == 32 and champion:getItem(j) ~= nil then party:spawn(item.go.name) break end
									end
								else
									setMouseItem(spawn(prevItem).item)
								end	
								
							end
						else
							if mouseItem:getStackSize() > 1 then
								mouseItem:setStackSize(mouseItem:getStackSize() - 1)
							else
								setMouseItem(nil)
							end	
						end
					end
				end
				-- Right click the slot to get the herb back
				if not mouseItem and button == 2 and champion:getClass() == "druid" then
					if slot == ItemSlot.Bracers or slot == ItemSlot.Necklace or slot == ItemSlot.Gloves then
						local prevItem = functions.script.get_c("druid_item"..slot, champion:getOrdinal())
						functions.script.set_c("druid_item"..slot, champion:getOrdinal(), nil)
						if prevItem then
							setMouseItem(spawn(prevItem).item)
						else
							setMouseItem(nil)
						end
					end
				end
				
				-- Rodent
				local item = champion:getItem(slot)
				if item and champion:hasTrait("rodent") and item:hasTrait("herb") and item:hasTrait("rodent") then
					if button == 2 then
						if not champion:hasCondition("chewing") then
							hudPrint("The ratling ate the herb.")
							champion:setConditionValue("chewing", 60 * 3)
							if item:getStackSize() > 1 then
								item:setStackSize(item:getStackSize() - 1)
							else
								champion:removeItemFromSlot(slot)
							end
						else
							hudPrint("The ratling is already chewing something.")
						end
					end					
				end
				
				if item then
					if champion:hasTrait("tinkering") then
						-- Cancel if clicking in an equipped item
						if not (slot >= ItemSlot.BackpackFirst and slot <= ItemSlot.BackpackLast) then
							functions.script.set_c("tinkering", champion:getOrdinal(), nil)
						end

						-- Right-Click on tinkering toolbox in hand
						if not getMouseItem() and button == 2 and item.go.name == "tinkering_toolbox" and (slot == ItemSlot.Weapon or slot == ItemSlot.OffHand) then
							-- Sets target item to the other hand slot to the toolbox
							local otherSlot = slot == ItemSlot.Weapon and ItemSlot.OffHand or ItemSlot.Weapon								
							if champion:getItem(otherSlot) then
								if champion:getItem(otherSlot):hasTrait("upgradable") then
									functions.script.set_c("tinkering", champion:getOrdinal(), otherSlot)
								else
									hudPrint("Item is not upgradable.")
								end
							else
								hudPrint("Needs target item in other hand.")
							end
						end

						-- Dismantler
						if champion:hasTrait("dismantler") then
							local dismantle = 0
							local container = item.go.containeritem
							if container then
								local capacity = container:getCapacity()
								for j=1,capacity do
									local item2 = container:getItem(j)
									if item2 and item2:hasTrait("dismantle") then
										dismantle = dismantle + 1
									end
								end
							end
							
							if button == 2 and dismantle == 9 then
								if slot >= 13 and slot <= 32 then
									local posx = 553 - (((slot-1) % 4) * 63)
									local posy = (297 + ((math.floor((slot-13) / 4)) * 63))
									functions.script.tinkererDismantle(true, posx, posy, slot, champion:getOrdinal())
								end
							end
						end
					end
				else
					-- Cancel if clicking an empty slot
					if not getMouseItem() and functions.script.get_c("tinkering", champion:getOrdinal()) then
						functions.script.set_c("tinkering", champion:getOrdinal(), nil)
					end
				end
			end
			if container and container:getItem(slot) then print(champion:getName(), "clicked item", container:getItem(slot).go.name, "with button", button) end
		end,
		
		-- WORKS
		onDrawInventory = function(self, context, champion)
			local w, h, r = context.width, 		context.height, 	context.width / context.height
			local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
			local f2 = (context.height/1080)
			local MX, MY = context.mouseX, context.mouseY

			if champion:hasTrait("tinkering") then
				-- Draw "upgradable" icon on items
				local posx, posy = 0, 0
				for i=13,ItemSlot.BackpackLast do
					local item = champion:getItem(i)
					if item then
						if item.go.containeritem then 
							local container = item.go.containeritem 
						end
						
						if champion:getItem(i) and champion:getItem(i):hasTrait("upgradable") then
						posx = (i-1) % 4
						posy = math.floor((i-13) / 4)
						context.drawImage2("mod_assets/textures/gui/upgradable.dds", w - ((553 + 0 - (posx * 63)) * f2), (297 - 0 + (posy * 63)) * f2, 0, 0, 64, 64, 55 * f2, 55 * f2)
						end
					end
				end	

				-- Show tinkering level and upgradable icon while lock-pick is in hand
				-- if functions.script.get_c("tinkering", champion:getOrdinal()) then
				-- 	local posx, posy = 0, 0
				-- 	for i=13,ItemSlot.BackpackLast do
				-- 		if champion:getItem(i) and champion:getItem(i):hasTrait("upgradable") then
				-- 		posx = (i-1) % 4
				-- 		posy = math.floor((i-13) / 4)
				-- 		context.drawImage2("mod_assets/textures/gui/upgradable.dds", w - ((553 - (posx * 63)) * f2), (297 + (posy * 63)) * f2, 0, 0, 64, 64, 55 * f2, 55 * f2)
				-- 		end
				-- 	end
				-- 	-- local text = "Tinkering Level = ".. champion:getSkillLevel("tinkering")
				-- 	-- context.drawText(text, MX - (context.getTextWidth(text) / 2), MY + 30)
				-- 	if champion:getClass() == "tinkerer" then
				-- 		local count = functions.script.get_c("crafting_expertise", champion:getOrdinal())
				-- 		if count ~= nil and count > 0 then
				-- 			local text2 = "Crafting Bonus = ".. count
				-- 			-- context.drawText(text2, MX - (context.getTextWidth(text2) / 2), MY + 30)
				-- 		end
				-- 	end
				-- end
				
				-- Dismantle prompt
				if functions.script.dismantlePrompt then
					context.drawImage2("mod_assets/textures/gui/tinkerer_dismantle.dds", w - (functions.script.dismantleX + 113 - 25) * f2, (functions.script.dismantleY - 44 + 35) * f2, 0, 0, 226, 88, 226 * f2, 88 * f2)
					local val1, val2 = context.button("dismantle", w - (functions.script.dismantleX + 115), (functions.script.dismantleY - 42 + 35), 222, 84)
					
					context.drawGuiItem2("y-16es", w - (functions.script.dismantleX + 115 - 48) * f2, (functions.script.dismantleY - 42 + 70) * f2, 0, 0, 73, 32, 73 * f2, 32 * f2)
					local yes1, yes2 = context.button("yes", w - (functions.script.dismantleX + 115 - 48), (functions.script.dismantleY - 42 + 70), 73, 32)
					if yes1 or yes2 then
						context.drawGuiItem2("y-16esHover", w - (functions.script.dismantleX + 115 - 48) * f2, (functions.script.dismantleY - 42 + 70) * f2, 0, 0, 73, 32, 73 * f2, 32 * f2)
						if context.mouseDown(0) then
							functions.script.tinkererDismantleAction(functions.script.dismantleChampion, functions.script.dismantleItemSlot)
							functions.script.tinkererDismantle(false, functions.script.dismantleX, functions.script.dismantleY, 0, 0)
						end
					end
					
					context.drawGuiItem2("ButtonNo", w - (functions.script.dismantleX + 115 - 159) * f2, (functions.script.dismantleY - 42 + 70) * f2, 0, 0, 73, 32, 73 * f2, 32 * f2)
					local no1, no2 = context.button("no", w - (functions.script.dismantleX + 115 - 159), (functions.script.dismantleY - 42 + 70), 73, 32)
					if no1 or no2 then
						context.drawGuiItem2("ButtonNoHover", w - (functions.script.dismantleX + 115 - 159) * f2, (functions.script.dismantleY - 42 + 70) * f2, 0, 0, 73, 32, 73 * f2, 32 * f2)
						if context.mouseDown(0) then
							functions.script.tinkererDismantle(false, functions.script.dismantleX, functions.script.dismantleY, 0, 0)
						end
					end
					
					if val1 == nil then
						functions.script.tinkererDismantle(false, functions.script.dismantleX, functions.script.dismantleY, 0, 0)
					end
				end
			end
			
			-- if champion:getClass() == "fighter" then
				-- local item = getMouseItem()				
				-- if item and item.go:getComponent("equipmentitem") then
					-- local i = nil
					-- local slots = { "helmet", "chest_armor", "leg_armor", "boots", "gloves" }
					-- for index, slot in ipairs(slots) do
						-- if item:hasTrait(slot) then
							-- i = index - 1
						-- end
					-- end
					
					-- if i then
						-- if i < 4 then
							-- context.color(255, 255, 255, 168)
							-- context.drawRect(w - (208 * f2), ((78 * i) + 293) * f2, 80 * f2, 80 * f2)
							-- local m1, m2 = context.button("noEquip", w - (208 * f2), ((78 * i) + 293) * f2, 80 * f2, 80 * f2)
						-- else
							-- local m1, m2 = context.button("noEquip", w - (300 * f2), 526 * f2, 80 * f2, 80 * f2)
						-- end
					
						-- if m1 or m2 then
							-- local equipSlots = {3,4,5,6,9}
							-- for j=13,32 do
								-- if champion:getItem(j) == nil then champion:insertItem(j, item) break end
								-- if j == 32 and champion:getItem(j) ~= nil then party:spawn(item.go.name) break end
							-- end
							-- hudPrint(champion:getName() .. ", the Berserker, refuses to wear armor.")
							-- champion:removeItemFromSlot(slot)
						-- end
					-- end
				-- end				
				
			-- end
			
			-- Druid equippable herbs
			-- Display herb over bracers slot
			local slotsX = { 82, 266, 82 }
			local slotsY = { 277, 510, 510 }
			if champion:getClass() == "druid" then
				local slots = { 8, 9, 10 }
				for s = 1,#slots do
					local druidItem = functions.script.get_c("druid_item"..slots[s], champion:getOrdinal())
					if druidItem then
						local icons = { {name = "blooddrop_cap", id=57}, {name = "etherweed", id=76}, {name = "mudwort", id=77}, {name = "falconskyre", id=78}, {name = "blackmoss", id=79}, {name = "crystal_flower", id=80} }
						for i=1,#icons do
							if druidItem == icons[i].name then
								local id = icons[i].id
								local icon_x = (id % 13) * 75
								local icon_y = math.floor(id / 13) * 75
								context.drawImage2("assets/textures/gui/items.dds", w - (slotsX[s] * f2), slotsY[s] * f2, icon_x, icon_y, 75, 75, 60 * f2, 60 * f2)
							end
						end	
					end
				end	
			end
			-- Update herb description
			local item = getMouseItem()
			if item and item:hasTrait("herb") then
				if champion:getClass() == "druid" then
					context.color(255, 255, 255, 40)
					context.drawImage2("mod_assets/textures/gui/slotHighlight.dds", w - ((slotsX[1]+32) * f2), (slotsY[1]+19) * f2, 0, 0, 69, 69, 75 * f2, 75 * f2)
					context.drawImage2("mod_assets/textures/gui/slotHighlight.dds", w - ((slotsX[2]+32) * f2), (slotsY[2]+19) * f2, 0, 0, 69, 69, 75 * f2, 75 * f2)
					context.drawImage2("mod_assets/textures/gui/slotHighlight.dds", w - ((slotsX[3]+32) * f2), (slotsY[3]+19) * f2, 0, 0, 69, 69, 75 * f2, 75 * f2)
					local herbEffects = { 
						{ 
						name = "blooddrop_cap", 
						effect = "- Strength +2.\n- Regain 8 to 25% of poison damage dealt as Health (cloud spells only heal on the initial hit)." 
						},
						{ 
						name = "etherweed", 
						effect = "- Willpower +2.\n- Regain 8 to 25% of poison damage dealt as Energy (cloud spells only heal on the initial hit)." 
						},
						{ 
						name = "mudwort", 
						effect = "- Vitality +2.\n- +15% Melee damage to poisoned foes.\n- +20% Poison Resistance." 
						},
						{ 
						name = "falconskyre", 
						effect = "- Dexterity +2.\n- +8% Chance to poison with attacks."
						},
						{ 
						name = "blackmoss", 
						effect = "- Poison Damage +10%.\n- Physical to Poison conversion rate +10%."
						},
						{ 
						name = "crystal_flower", 
						effect = "- All spell damage is converted to poison.\n- Poison Damage +4%." 
						}
					}
					if not item:hasTrait("druid") then
						item:addTrait("druid")
						local gameEffectString = "Druid bonus:\n"
						for i=1,#herbEffects do
							if item.go.name == herbEffects[i].name then
								gameEffectString = gameEffectString .. herbEffects[i].effect
								item:setGameEffect(gameEffectString)
							end
						end
					end
				else
					if item:hasTrait("druid") then
						item:removeTrait("druid")
						item:setGameEffect(nil)
					end
				end
			end
		end, 
		
		onDrawAttackPanel = function(self, champion, context, x, y)
			local w, h, r = context.width, 		context.height, 	context.width / context.height
			local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
			local MX, MY = context.mouseX, context.mouseY
			local mLeft, mRight = context.mouseDown(0), context.mouseDown(2)
			local c = champion:getOrdinal()
			if f > 0.9 then
				context.font("large")
			elseif f > 0.5 then
				context.font("medium")
			elseif f > 0.2 then
				context.font("small")
			elseif f < 0.2 then
				context.font("tiny")
			end

			if functions and functions.script.get_c("race_skill", c) then
				context.color(255, 255, 255, 40)
				context.drawRect(x - 21, y - 69, 64, 64)
			end

			if champion:getClass() == "tinkerer" then
				local item = champion:getItem(ItemSlot.Weapon)
				local item2 = champion:getItem(ItemSlot.OffHand)
				local slot = 0
				if item and item.go.name == "tinkering_toolbox" then
					slot = 1
				elseif item2 and item2.go.name == "tinkering_toolbox" then
					slot = 2
				end
				if slot ~= 0 then
					local count = functions.script.get_c("crafting_expertise", champion:getOrdinal())
					if count ~= nil and count > 0 then
						context.font("small")
						context.color(205, 255, 255, 255)
						local text2 = "+".. count
						context.drawText(text2, x + 60 + ((slot-1) * 80), y+31)
						context.color(255, 255, 255, 255)
					end
				end
			end

			if functions.script.get_c("tinkering", champion:getOrdinal()) then
				-- Draw tinkering UI
				context.drawImage2("mod_assets/textures/gui/tinker_ui.dds", x, y, 0, 0, 171, 117, 171, 117)
				local item = champion:getItem(functions.script.get_c("tinkering", champion:getOrdinal()))
				local materials = functions.script.tinkererGetMaterialList(item)
				-- Draw item requirements
				context.font("small")
				for mat, value in pairs(materials) do
					if value > 0 then
						if mat == "metal_bar" then
							context.drawImage2("mod_assets/textures/gui/items.dds", x-2, y-2, 225, 300, 75, 75, 50, 50)
							context.drawText("" .. value, x + 31, y + 14)
						elseif mat == "metal_nugget" then
							context.drawImage2("mod_assets/textures/gui/items.dds", x + 35, y-7, 375, 300, 75, 75, 60, 60)
							context.drawText("" .. value, x + 31 + (44*1), y + 14)
						elseif mat == "leather" then
							context.drawImage2("mod_assets/textures/gui/items.dds", x + 82, y-2, 525, 300, 75, 75, 50, 50)
							context.drawText("" .. value, x + 31 + (44*2), y + 14)
						elseif mat == "leather_strips" then
							context.drawImage2("mod_assets/textures/gui/items.dds", x + 124, y-1, 450, 300, 75, 75, 50, 50)
							context.drawText("" .. value, x + 31 + (44*3), y + 14)
						elseif mat == "silk" then
							context.drawImage2("mod_assets/textures/gui/items.dds", x - 8, y+38, 300, 300, 75, 75, 58, 58)
							context.drawText("" .. value, x + 31 + (44*0), y + 58) 
						elseif mat == "gold" then
							context.drawImage2("mod_assets/textures/gui/items.dds", x + 40, y+39, 750, 300, 75, 75, 50, 50)
							context.drawText("" .. value, x + 31 + (44*1), y + 58) 
						elseif mat == "skull" then
							context.drawImage2("assets/textures/gui/items.dds", x + 80, y+35, 375, 150, 75, 75, 55, 55)
							context.drawText("" .. value, x + 31 + (44*2), y + 58) 
						elseif mat == "crystal_flower" then
							context.drawImage2("assets/textures/gui/items.dds", x + 123, y+35, 150, 450, 75, 75, 55, 55)
							context.drawText("" .. value, x + 31 + (44*3), y + 58) 
						end
					end
				end

				-- Exit button
				local val1, val2 = context.button("tinkering_exit", x + 135, y + 89, 34, 25)
				if val1 or val2 then			
					if context.mouseDown(3) then
						functions.script.set_c("tinkering", c, nil)
					end
				end
				-- Upgrade button
				local upg1, upg2 = context.button("tinkering_confirm", x, y + 86, 132, 31)
				if upg1 or upg2 then
					if context.mouseDown(3) then
						functions.script.tinkererUpgrade(self, champion, functions.script.get_c("tinkering", c), materials)
						functions.script.set_c("tinkering", c, nil)
					end
				end

				return false
			end
			
			if champion:getClass() == "monk" then
				local healingLight = functions.script.get_c("healinglight", c) or 0
				local healingMax = 400 + ((champion:getLevel() ^ 2) * 75)
				if healingLight then
					functions.script.drawBarOnPortrait(context, champion, x, y, healingLight, healingMax)				
				end
				-- if champion:hasCondition("healing_light") then
					-- context.drawImage2("mod_assets/textures/gui/healing_light.dds", x-22, y-70, 0, 0, 64, 64, 68, 68)
				-- end

				local focus = functions.script.get_c("focus", c) or 0
				local focusMax = champion:getMaxEnergy()
				if focus then
					functions.script.drawBarOnPortrait(context, champion, x, y-4, focus, focusMax)				
				end
			end

			functions.script.set_c("counterOnHand", c, 0)
			
			-- Draw Berserker's Franzy charge
			if champion:getClass() == "fighter" then
				local stacks = functions.script.get_c("berserker_frenzy", c) or 0
				local frenzyCur = champion:getConditionValue("berserker_frenzy") or 0
				local frenzyMax = functions.script.get_c("berserker_max", c) or 0

				if stacks > 0 then
					functions.script.add_c("counterOnHand", c, 1)
					local counters = functions.script.get_c("counterOnHand", c) or 0
					functions.script.drawCounterOnHand(context, champion, x, y, stacks, "Berserker Frenzy  ", "", 1, counters - 1)
					functions.script.drawBarOnHand(context, champion, x, y, frenzyCur, frenzyMax)
				end
			end	
			
			-- Draw Hunter's Thrill of the Hunt charge
			if champion:getClass() == "hunter" then
				local stacks = functions.script.get_c("hunter_crit", c) or 0
				local hunterCur = champion:getConditionValue("hunter_crit") or 0
				local hunterMax = functions.script.get_c("hunter_max", c) or 0

				if stacks > 0 then
					functions.script.add_c("counterOnHand", c, 1)
					local counters = functions.script.get_c("counterOnHand", c) or 0
					functions.script.drawCounterOnHand(context, champion, x, y, stacks, "Thrill of the Hunt", "+".. stacks .." Willpower\n+".. stacks .."% Crit", 2, counters - 1)
					functions.script.drawBarOnHand(context, champion, x, y, hunterCur, hunterMax)
				end
			end	
			
			if champion:getClass() == "assassin_class" then
				local stacks = functions.script.get_c("assassination", c) or 0
				local item = champion:getItem(ItemSlot.Weapon)
				local desc = " "
				if item and stacks > 0 then 
					if item.go.meleeattack or item.go.firearmattack then
						desc = "+".. stacks * 2 .." Pierce\n+".. stacks * 2 .."% Crit"
					elseif item.go.rangedattack or item.go.throwattack then
						desc = "+".. stacks * 3 .." Attack Power\n+".. stacks * 2 .."% Crit"
					end
					functions.script.add_c("counterOnHand", c, 1)
					local counters = functions.script.get_c("counterOnHand", c) or 0
					functions.script.drawCounterOnHand(context, champion, x, y, stacks, "Assassination", desc, 2, counters - 1)
				end	
			end	
			
			if champion:hasTrait("silver_bullet") then
				local count = functions.script.get_c("silver_bullet", c) or 0
				local trigger = 6 - (champion:hasTrait("fast_fingers") and math.floor(champion:getCurrentStat("dexterity") / 20) or 0)
				count = (count % trigger) + 1

				functions.script.add_c("counterOnHand", c, 1)
				local counters = functions.script.get_c("counterOnHand", c) or 0
				local suffix = iff(trigger == 1, "st", iff(trigger == 2, "nd", iff(trigger == 3, "rd", "th")))
				functions.script.drawCounterOnHand(context, champion, x - 4, y, count .. "/" .. trigger, "Silver Bullet", trigger..suffix.." hit does double damage.\nNext does triple.", 2, counters - 1)
			end	
		end,
		
		onDrawGui = function(self, context)			
			local w, h, r = context.width, 		context.height, 	context.width / context.height
			local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
			local f2 = context.height/1080
			local MX, MY = context.mouseX, context.mouseY
			local mLeft, mRight = context.mouseDown(0), context.mouseDown(2)

			if party.partycounter:getValue() > 0 then
				functions.script.set("f", f)
				functions.script.set("w", w)
				functions.script.set("h", h)
				functions.script.set("MX", MX)
				functions.script.set("MY", MY)
			end
			
			-------------------------

			local dropZoneXYCoords = { {w - (455 * f), 665 * f}, {w - (249 * f), 665 * f}, {w - (455 * f), 865 * f}, {w - (249 * f), 865 * f} } 
			local dropZoneWidth, dropZoneHeight = 192 * f, 62 * f
			local mouseOverPortraitZone = iff(MX > dropZoneXYCoords[4][1] and MX < dropZoneXYCoords[4][1] + dropZoneWidth and MY > dropZoneXYCoords[4][2] and MY < dropZoneXYCoords[4][2] + dropZoneHeight, 4, 
								iff(MX > dropZoneXYCoords[3][1] and MX < dropZoneXYCoords[3][1] + dropZoneWidth and MY > dropZoneXYCoords[3][2] and MY < dropZoneXYCoords[3][2] + dropZoneHeight, 3, 
								iff(MX > dropZoneXYCoords[2][1] and MX < dropZoneXYCoords[2][1] + dropZoneWidth and MY > dropZoneXYCoords[2][2] and MY < dropZoneXYCoords[2][2] + dropZoneHeight, 2, 
								iff(MX > dropZoneXYCoords[1][1] and MX < dropZoneXYCoords[1][1] + dropZoneWidth and MY > dropZoneXYCoords[1][2] and MY < dropZoneXYCoords[1][2] + dropZoneHeight, 1, 
								nil))))

			if getMouseItem() then
				functions.script.set("mouseItem", getMouseItem())
			end

			local mouseItem = functions.script.get("mouseItem")
			
			if mouseOverPortraitZone and context.mouseDown(3) and mouseItem then
				local champion = party.party:getChampion(mouseOverPortraitZone)
				-- print("clicked on champion", champion:getName() )
				
				if mouseItem then
					-- print("with item",mouseItem.go.name )
					functions.script.droppedItemOnPortrait(mouseItem, champion)
					functions.script.set("mouseItem", nil)
				end
			end

			if not mouseOverPortraitZone then
				functions.script.set("mouseItem", nil)
			end

			----------------------------

			local mortarPanelXYcoords = { {w - (305 * f), 759 * f}, {w - (99 * f), 759 * f}, {w - (305 * f), 959 * f}, {w - (99 * f), 959 * f} } 
			local mortarPanelWidth, mortarPanelHeight = 44 * f, 62 * f
			local mouseOverMortarZone = iff(MX > mortarPanelXYcoords[4][1] and MX < mortarPanelXYcoords[4][1] + mortarPanelWidth and MY > mortarPanelXYcoords[4][2] and MY < mortarPanelXYcoords[4][2] + mortarPanelHeight, 4, 
								iff(MX > mortarPanelXYcoords[3][1] and MX < mortarPanelXYcoords[3][1] + mortarPanelWidth and MY > mortarPanelXYcoords[3][2] and MY < mortarPanelXYcoords[3][2] + mortarPanelHeight, 3, 
								iff(MX > mortarPanelXYcoords[2][1] and MX < mortarPanelXYcoords[2][1] + mortarPanelWidth and MY > mortarPanelXYcoords[2][2] and MY < mortarPanelXYcoords[2][2] + mortarPanelHeight, 2, 
								iff(MX > mortarPanelXYcoords[1][1] and MX < mortarPanelXYcoords[1][1] + mortarPanelWidth and MY > mortarPanelXYcoords[1][2] and MY < mortarPanelXYcoords[1][2] + mortarPanelHeight, 1, 
								nil))))

								-- print(mouseOverMortarZone)

			if mouseOverMortarZone then
				functions.script.set("portrait_zone", mouseOverMortarZone)
			else
				functions.script.set("portrait_zone", nil)
			end

			----------------------------

			local attackPanelXYcoords = { {w - (426 * f), 743 * f}, {w - (220 * f), 743 * f}, {w - (426 * f), 943 * f}, {w - (220 * f), 943 * f} } 
			local runePanelWidth, runePanelHeight = 156 * f, 100 * f
			local mouseOverHandsZone = iff(MX > attackPanelXYcoords[4][1] and MX < attackPanelXYcoords[4][1] + runePanelWidth and MY > attackPanelXYcoords[4][2] and MY < attackPanelXYcoords[4][2] + runePanelHeight, 4, 
								iff(MX > attackPanelXYcoords[3][1] and MX < attackPanelXYcoords[3][1] + runePanelWidth and MY > attackPanelXYcoords[3][2] and MY < attackPanelXYcoords[3][2] + runePanelHeight, 3, 
								iff(MX > attackPanelXYcoords[2][1] and MX < attackPanelXYcoords[2][1] + runePanelWidth and MY > attackPanelXYcoords[2][2] and MY < attackPanelXYcoords[2][2] + runePanelHeight, 2, 
								iff(MX > attackPanelXYcoords[1][1] and MX < attackPanelXYcoords[1][1] + runePanelWidth and MY > attackPanelXYcoords[1][2] and MY < attackPanelXYcoords[1][2] + runePanelHeight, 1, 
								nil))))

			local hand1, hand2 = nil, nil
			if mouseOverHandsZone then
				if context.keyDown("control") then
					local n = mouseOverHandsZone
					hand1, hand2 = context.button("quick_potion", attackPanelXYcoords[n][1], attackPanelXYcoords[n][2], runePanelWidth, runePanelHeight)
				else
					hand1, hand2 = nil, nil
				end
			else
				hand1, hand2 = nil, nil
			end

			if hand1 or hand2 then
				-- print("quick potion on")
			else
				-- print("quick potion off")
			end

			local multi = 1
			if context.keyDown("shift") then
				multi = -1
			else
				multi = 1
			end
			
			if context.keyDown("1") and functions.script.keypressDelayGet() == 0 then
				party:setPosition(party.x, party.y, party.facing, party.elevation + 1, party.level)
				functions.script.keypressDelaySet(8)
			end

			if context.keyDown("2") and functions.script.keypressDelayGet() == 0 then
				party:setPosition(party.x, party.y, party.facing, party.elevation - 1, party.level)
				functions.script.keypressDelaySet(8)
			end
			
			if context.keyDown("O") then
				local text = "OFFSETING"
				context.drawText(text, 	w - (f2 * (w / 2  + context.getTextWidth(text))), h - (f2 * h / 2))
				if context.keyDown("X") then
					functions2.script.move(0.01*multi,0,0)
				end
				if context.keyDown("C") then
					functions2.script.move(0,0.01*multi,0)
				end
				if context.keyDown("Z") then
					functions2.script.move(0,0,0.01*multi)
				end
			end
			
			if context.keyDown("P") then
				local text = "ROTATING"
				context.drawText(text, 	w - (f2 * (w / 2  + context.getTextWidth(text))), h - (f2 * h / 2))
				if context.keyDown("X") then
					functions2.script.rotate(0.1*multi,0,0)
				end
				if context.keyDown("C") then
					functions2.script.rotate(0,0.1*multi,0)
				end
				if context.keyDown("Z") then
					functions2.script.rotate(0,0,0.1*multi)
				end
			end

			if context.keyDown("B") then
				for i=1,10 do
					local ent = findEntity("beam_"..i)
					if ent then
						local angle = ent.data:get("angle")
						ent.data:set("angle", angle + (2 * multi))
					end
				end
			end

			if context.keyDown("V") and functions.script.keypressDelayGet() == 0 then
				functions2.script.debug()
				functions.script.keypressDelaySet(20)
			end
			
			if context.keyDown("shift") and functions.script.keypressDelayGet() == 0 then
			-- Shift + U -> Advance day time by 1/6th
			if context.keyDown("U") then
				GameMode.setTimeOfDay((GameMode.getTimeOfDay() + 0.33) % 2)
				print("Time of Day set to " .. GameMode.getTimeOfDay())
				functions.script.keypressDelaySet(20)
			end
			
			-- Shift + M -> Reveal current map
			if context.keyDown("M") then
				functions2.script.revealMap(false)
				print("Map revealed")
				functions.script.keypressDelaySet(20)
			end

			-- Shift + K --> Kill all mobs in map
			if context.keyDown("K") then
				functions2.script.killAllMobs()
				print("Mobs killed")
				functions.script.keypressDelaySet(20)
			end

			-- Shift + L -> Level up
			if context.keyDown("L") then
				for i = 1,4 do
					party.party:getChampion(i):levelUp()
					functions.script.keypressDelaySet(20)
				end
			end

			-- Shift + J -> Moves the party 1 square forward
			if context.keyDown("J") then
				local dx,dy = getForward(party.facing)
				party:setPosition(party.x + dx, party.y + dy, party.facing, party.elevation, party.level)
				functions.script.keypressDelaySet(20)
			end

			-- Shift + K -> Kills monster in front of party
			if context.keyDown("K") then
				local dx,dy = getForward(party.facing)
				for e in Dungeon.getMap(party.level):entitiesAt(party.x + dx, party.y + dy) do
					if e.monster and e.monster:isAlive() then
						e.monster:die()
					end
				end
				functions.script.keypressDelaySet(20)
			end

			-- Shift + Z -> Toggles door in front of party
			if context.keyDown("Z") then
				functions.script.keypressDelaySet(20)
				local dx,dy = getForward(party.facing)
				for e in Dungeon.getMap(party.level):entitiesAt(party.x, party.y) do
					if e.facing == party.facing and e.door then
						e.door:toggle()
					end
				end
				for e in Dungeon.getMap(party.level):entitiesAt(party.x + dx, party.y + dy) do
					if (e.facing + 2) % 4 == party.facing and e.door then
						e.door:toggle()
					end
				end		
			end

			-- Shift + H -> Full Heal party
			if context.keyDown("H") then
				local negative_conditions = { 
					"cursed",
					"diseased",
					"paralyzed",
					"petrified",
					"poison",
					"slow",
					"chest_wound",
					"feet_wound",
					"head_wound",
					"left_hand_wound",
					"leg_wound",
					"right_hand_wound",
					"frozen_champion",
					"blind",
					"silence",
					"bleeding",
				}

				for i = 1,4 do
					local champion = party.party:getChampion(i)
					for _,v in ipairs(negative_conditions) do
						if champion:getConditionValue(v) ~= 0 then
							champion:setConditionValue(v, 0)
							champion:playHealingIndicator()
						end
					end
					champion:setBaseStat("health", champion:getCurrentStat("max_health"))
					champion:setBaseStat("energy", champion:getCurrentStat("max_energy"))
					if champion:getClass() == "monk" then functions.script.set_c("focus", i, champion:getCurrentStat("max_energy")) end
					playSound("heal_party")
					functions.script.keypressDelaySet(20)
				end
			end
			end

			-- if context.keyDown("V") and functions.script.keypressDelayGet() == 0 then
			-- 		party.party:getChampion(1):setConditionValue("shield_bearer", 5)
			-- 		functions.script.keypressDelaySet(10)
			-- end

			-- Display class skill buttons
			
			local area1, area2, areaX, areaY = {}, {}, {}, {}
			local ancestral_charge = { cost = 25, name = "ancestral_charge", uiName = "Ancestral Charge", icon = 44, desc = "Ancient spell that gives you strength." }
			local intensify_spell = { cost = 0, name = "intensify_spell", uiName = "Intensify Spell", icon = 50, desc = "Amplify the last spell cast." }
			local sneak_attack = { cost = 15, name = "sneak_attack", uiName = "Sneak Attack", icon = 52, desc = "Next attack may poison." }
			local drinker = { cost = 0, name = "drinker", uiName = "Drown Your Sorrows", icon = 41, desc = "Recover wounds and gain speed." }
			local skills = { ancestral_charge, intensify_spell, sneak_attack, drinker }
			local champions = { }
			local orderedSkills = { }
			
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				for index, t in pairs(skills) do					
					if champion:hasTrait(t.name) then
						--print("champion = " .. i .. " has skill = " .. index)
						table.insert(champions, i)
						table.insert(orderedSkills, skills[index] )
						break
					end
					if index == 4 and not champion:hasTrait(t.name) then
						--print("champion = " .. i .. " doesnt have any skills")
						table.insert(champions, nil)
						table.insert(orderedSkills, nil)
					end
				end
			end
			
			for index, v in pairs(orderedSkills) do
				if v == nil then
					table.remove(orderedSkills, v)
				end
			end 
			
			for index, v in pairs(champions) do
				if v == nil then
					table.remove(champions, v)
				end
			end 
			
			for index, skill in pairs(orderedSkills) do
				local champion = party.party:getChampionByOrdinal(champions[index])
				-- draw button
				context.color(255, 255, 255, 128)
				context.drawImage2("mod_assets/textures/gui/class_skill_button.dds", w - (524 * f2), (662 + ((index - 1) * 62)) * f2, 52, 0, 52, 52, 52 * f2, 52 * f2)
				local icon_x = (skill.icon % 13) * 75
				local icon_y = math.floor(skill.icon / 13) * 75
				context.drawImage2("mod_assets/textures/gui/skills.dds", w - (524 * f2), (662 + ((index - 1) * 62)) * f2, icon_x, icon_y, 75, 75, 52 * f2, 52 * f2)
				area1[index], area2[index] = context.button("class_skill"..index, w - (524 * f2), (662 + ((index - 1) * 62)) * f2, 52 * f2, 52 * f2)
				
				if skill.name == "intensify_spell" and functions.script.get_c("intensifySpell", champion:getOrdinal()) then
					local defOrdered = spells_functions.script.getDefOrdered()
					local spellIcon = 0
					local spellName = ""
					for i,def in pairs(defOrdered) do
						if def.icon and def.name == functions.script.get_c("intensifySpell", champion:getOrdinal()) then
							spellIcon = def.icon
							spellName = def.uiName
						end
					end
					
					local spellIcon_x = (spellIcon % 13) * 75
					local spellIcon_y = math.floor(spellIcon / 13) * 75
					context.drawImage2("mod_assets/textures/gui/skills.dds", w - (516 * f2), (662 - 8 + ((index - 1) * 62)) * f2, spellIcon_x, spellIcon_y, 75, 75, 48 * f2, 48 * f2)
				end
			end
			
			functions.script.set_c("race_skill", 1, nil) -- used for hover effects
			functions.script.set_c("race_skill", 2, nil)
			functions.script.set_c("race_skill", 3, nil)
			functions.script.set_c("race_skill", 4, nil)
			for index, skill in pairs(orderedSkills) do
				local champion = party.party:getChampionByOrdinal(champions[index])
				if area2[index] then
					--draw hover button
					context.color(255, 255, 255, 255)
					context.drawImage2("mod_assets/textures/gui/class_skill_button.dds", w - (524 * f2), (662 + ((index - 1) * 62)) * f2, 52, 0, 52, 52, 52 * f2, 52 * f2)
					local icon_x = (skill.icon % 13) * 75
					local icon_y = math.floor(skill.icon / 13) * 75
					context.drawImage2("mod_assets/textures/gui/skills.dds", w - (524 * f2), (662 + ((index - 1) * 62)) * f2, icon_x, icon_y, 75, 75, 52 * f2, 52 * f2)

					if context.mouseDown(3) then
						playSound("click_down")
						local waterLevel = -10
						for entity in Dungeon.getMap(party.level):allEntities() do
							if entity and entity.watersurface then
								waterLevel = -0.6
							end
						end
						if party:getWorldPositionY() > waterLevel and champion:isAlive() and champion:isReadyToAttack(0) and not champion:hasCondition("recharging") then
							--draw click button
							context.color(255, 255, 255, 255)
							context.drawImage2("mod_assets/textures/gui/class_skill_button.dds", w - (524 * f2), (662 + ((index - 1) * 62)) * f2, 104, 0, 52, 52, 52 * f2, 52 * f2)
							context.drawImage2("mod_assets/textures/gui/skills.dds", w - (524 * f2), (662 + ((index - 1) * 62)) * f2, icon_x, icon_y, 75, 75, 52 * f2, 52 * f2)
							if champion:getEnergy() > skill.cost then
								functions.script.class_skill(skill.name, champion)
								champion:regainEnergy(skill.cost * -1)
								champion:playHealingIndicator()
								playSound("generic_spell")
							else
								hudPrint("Not enough energy for this action.")
								playSound("spell_out_of_energy")
							end
						else
							hudPrint("Champion is not ready.")
						end
					end
					
					if skill.name == "intensify_spell" and functions.script.get_c("intensifySpell", champion:getOrdinal()) then
						local defOrdered = spells_functions.script.getDefOrdered()
						local spellIcon = 0
						local spellName = ""
						for i,def in pairs(defOrdered) do
							if def.icon and def.name == functions.script.get_c("intensifySpell", champion:getOrdinal()) then
								spellIcon = def.icon
								spellName = def.uiName
							end
						end
						
						local spellIcon_x = (spellIcon % 13) * 75
						local spellIcon_y = math.floor(spellIcon / 13) * 75
						context.drawImage2("mod_assets/textures/gui/skills.dds", w - (516 * f2), (662 - 8 + ((index - 1) * 62)) * f2, spellIcon_x, spellIcon_y, 75, 75, 48 * f2, 48 * f2)
					end
					
					--black rect behind text
					
					-- context.font("medium")
					-- local title = champion:getName() .. "'s " .. skill.uiName
					local title = skill.uiName
					local text = "Cost: " .. tostring(skill.cost) .. " Energy\n" .. skill.desc
					local txt_w = string.len(title) * 6
					for i=1,txt_w do
						text = text .. " "
					end
					local x = math.floor(MX - (math.min((context.getTextWidth(text)+21),250) / 2))

					functions.script.set_c("race_skill", index, true)

					functions.script.tooltipWithTitle(context, title, text, x, MY - 10, 2)
				end
			end

			local textIndex = 0
			for msg=1,3 do
				for i=1,4 do
					local champion = party.party:getChampionByOrdinal(i)
					if functions.script.get_c("level_up_message_" .. msg, champion:getOrdinal()) and functions.script.get_c("level_up_message_" .. msg .. "_timer", champion:getOrdinal()) then
						local text = functions.script.get_c("level_up_message_" .. msg, champion:getOrdinal())
						textIndex = textIndex + 1
						local timer = 3 - (functions.script.get_c("level_up_message_" .. msg .. "_timer", champion:getOrdinal()) or 0)
						timer = math.max(timer, 0)
						context.font("medium")
						context.color(255, 255, 255, 255 - (timer*85))
						context.drawText(text, (w - (w / 2)) - (context.getTextWidth(text) / 2), (f2 * h * 0.01) + (textIndex * 24))
					end	
				end
			end
		end,
		
		onDrawStats = function(self, context, champion)	
			local customStats = true
			if customStats then
				local w, h, r = context.width, 		context.height, 	context.width / context.height
				local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
				local f2 = (context.height/1080)
				local MX, MY = context.mouseX, context.mouseY
				local mLeft, mRight = context.mouseDown(0), context.mouseDown(2)
				
				if f2 > 0.8 then
					context.font("small")
				elseif f2 > 0.7 then
					context.font("small")
				elseif f2 > 0.6 then
					context.font("small")
				elseif f2 < 0.5 then
					context.font("tiny")
				end

				context.drawImage2("mod_assets/textures/gui/stats_background.dds", w - (558 * f2), 280 * f2, 0, 0, 528, 350, 528*f2, 350*f2)
				local dummy1, dummy2 = context.button("dummy",w - 536, 267, 510, 312)
				

				if champion:getClass() == "assassin_class" then
					-- local ass = functions.script.get_c("assassination", champion:getOrdinal()) and functions.script.get_c("assassination", champion:getOrdinal()) or 0
					-- context.drawText("Assassinations: " .. ass, w - (530 * f2), 618 * f2)
				end

				if champion:getClass() == "stalker" then
					context.drawText("Invisibility Casts: " .. functions.script.get_c("night_stalker", champion:getOrdinal()), w - (530 * f2), 618 * f2)
				end

				local hover1, hover2 = {}, {}				
				local txt = ""
				local x, y = 0, 0
				local buttonW, buttonH = 152, 21

				-- ATTRIBUTES
				
				x = 530
				y = 334
				context.drawText("Strength", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("strength")))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[1], hover2[1] = context.button("hover"..1, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Dexterity", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("dexterity")))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[2], hover2[2] = context.button("hover"..2, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Vitality", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("vitality")))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[3], hover2[3] = context.button("hover"..3, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Willpower", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("willpower")))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[4], hover2[4] = context.button("hover"..4, w - (x + 6), y-16, buttonW, buttonH)
				
				-- MISC
				x = 530
				y = 452
				context.drawText("Hp Regen", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("health_regeneration_rate") - 100))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[5], hover2[5] = context.button("hover"..5, w - (x + 6), y-16, buttonW, buttonH)
				
				y = y + 20
				context.drawText("En Regen", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("energy_regeneration_rate") - 100))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[6], hover2[6] = context.button("hover"..6, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Action Speed", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getActionSpeed(champion) * 1) - 100)
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[7], hover2[7] = context.button("hover"..7, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Block", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getBlockChance(champion) * 100))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[8], hover2[8] = context.button("hover"..8, w - (x + 6), y-16, buttonW, buttonH)

				-- RESISTANCES
				x = 365
				y = 334
				context.drawText("Fire", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getResistance("fire")))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[9], hover2[9] = context.button("hover"..9, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Shock", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getResistance("shock")))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[10], hover2[10] = context.button("hover"..10, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Poison", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getResistance("poison")))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[11], hover2[11] = context.button("hover"..11, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Cold", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getResistance("cold")))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[12], hover2[12] = context.button("hover"..12, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Disease", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getMiscResistance(champion, "diseased") * 100))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[13], hover2[13] = context.button("hover"..13, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Bleeding", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getMiscResistance(champion, "bleeding") * 100))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[14], hover2[14] = context.button("hover"..14, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Poisoned", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getMiscResistance(champion, "poisoned") * 100))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[15], hover2[15] = context.button("hover"..15, w - (x + 6), y-16, buttonW, buttonH)

				-- WOUND RESISTS
				x = 365
				y = 334+175
				local wound_res = functions.script.getWoundResistance(champion)				
				txt = tostring(math.floor(wound_res[1]))
				context.drawText(iff(string.len(txt) > 2, "Hea", "Head"), w - (x * f2), y * f2)
				functions.script.drawStatNumber(context, txt, w - ((x-69) * f2), y * f2)
				hover1[27], hover2[27] = context.button("hover"..27, w - (x + 6), y-16, buttonW/2, buttonH)

				y = y + 16
				txt = tostring(math.floor(wound_res[2]))
				context.drawText(iff(string.len(txt) > 2, "Che", "Chest"), w - (x * f2), y * f2)
				functions.script.drawStatNumber(context, txt, w - ((x-69) * f2), y * f2)
				hover1[28], hover2[28] = context.button("hover"..28, w - (x + 6), y-16, buttonW/2, buttonH)

				y = y + 16
				txt = tostring(math.floor(wound_res[3]))
				context.drawText(iff(string.len(txt) > 2, "Leg", "Legs"), w - (x * f2), y * f2)
				functions.script.drawStatNumber(context, txt, w - ((x-69) * f2), y * f2)
				hover1[29], hover2[29] = context.button("hover"..29, w - (x + 6), y-16, buttonW/2, buttonH)
				
				x = 296-4
				y = 334+175
				txt = tostring(math.floor(wound_res[4]))
				context.drawText(iff(string.len(txt) > 2, "Ft", "Feet"), w - (x * f2), y * f2)
				functions.script.drawStatNumber(context, txt, w - ((x-69) * f2), y * f2)
				hover1[30], hover2[30] = context.button("hover"..30, w - (x + 6), y-16, buttonW/2, buttonH)

				y = y + 16
				txt = tostring(math.floor(wound_res[5]))
				context.drawText(iff(string.len(txt) > 2, "L.H.", iff(string.len(txt) > 1, "L.Ha.", "L.Hand")), w - (x * f2), y * f2)
				functions.script.drawStatNumber(context, txt, w - ((x-69) * f2), y * f2)
				hover1[31], hover2[31] = context.button("hover"..31, w - (x + 6), y-16, buttonW/2, buttonH)

				y = y + 16
				txt = tostring(math.floor(wound_res[6]))
				context.drawText(iff(string.len(txt) > 2, "R.H.", iff(string.len(txt) > 1, "R.Ha.", "R.Hand")), w - (x * f2), y * f2)
				functions.script.drawStatNumber(context, txt, w - ((x-69) * f2), y * f2)
				hover1[32], hover2[32] = context.button("hover"..32, w - (x + 6), y-16, buttonW/2, buttonH)

				-- MULTIPLIERS
				x = 198
				y = 334
				context.drawText("Spells", w - (x * f2), (y + 0) * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "spell", 100, true) - 100 ))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[16], hover2[16] = context.button("hover"..16, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				
				local fire = tostring(math.floor( functions.script.empowerElement(champion, "fire", 100, true, 0, true) - 100 ))
				local shock = tostring(math.floor( functions.script.empowerElement(champion, "shock", 100, true, 0, true) - 100 ))
				local cold = tostring(math.floor( functions.script.empowerElement(champion, "cold", 100, true, 0, true) - 100 ))

				context.color(145, 155, 255, 255)
				context.drawText("" .. cold, w - ((x-138) * f2) - context.getTextWidth(cold), y * f2)
				context.color(255, 255, 255, 255)
				context.drawText("/", w - ((x-138) * f2) - context.getTextWidth(cold .. "/"), y * f2)

				context.color(120, 255, 190, 255)
				context.drawText("/" .. shock, w - ((x-138) * f2) - context.getTextWidth(cold .. "/" .. shock .. "/"), y * f2)	
				context.color(255, 255, 255, 255)
				context.drawText("/", w - ((x-138) * f2) - context.getTextWidth(cold .. "/" .. shock .. "/"), y * f2)	

				context.color(255, 120, 100, 255)
				context.drawText("" .. fire, w - ((x-138) * f2) - context.getTextWidth(cold .. "/" .. shock .. "/" .. fire), y * f2)			
				context.color(255, 255, 255, 255)

				if context.getTextWidth(cold .. "/" .. shock .. "/" .. fire) > 40 then
					context.drawText("Ele", w - (x * f2), y * f2)
				else
					context.drawText("Elemental", w - (x * f2), y * f2)
				end
				hover1[17], hover2[17] = context.button("hover"..17, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Poison", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerElement(champion, "poison", 100, true, 0, true) - 100 ))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[18], hover2[18] = context.button("hover"..18, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Neutral", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerElement(champion, "neutral", 100, true, 0, true) - 100 ))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[19], hover2[19] = context.button("hover"..19, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Physical", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerElement(champion, "physical", 100, true, 0, true) - 100 ))				
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[20], hover2[20] = context.button("hover"..20, w - (x + 6), y-16, buttonW, buttonH)
				

				y = y + 24
				context.drawText("Melee", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "melee", 100, true) - 100 ))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[21], hover2[21] = context.button("hover"..21, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				local light = tostring(math.floor( functions.script.empowerAttackType(champion, "light_weapons", 100, true, 0, true) - 100 ))
				local heavy = tostring(math.floor( functions.script.empowerAttackType(champion, "heavy_weapons", 100, true, 0, true) - 100 ))

				context.color(255, 255, 255, 255)
				context.drawText("/" .. heavy, w - ((x-138) * f2) - context.getTextWidth("/" .. heavy), y * f2)

				context.color(255, 255, 255, 255)
				context.drawText("" .. light, w - ((x-138) * f2) - context.getTextWidth(light .. "/" .. heavy), y * f2)

				if context.getTextWidth(light .. "/" .. heavy) > 40 then
					context.drawText("Melee W.", w - (x * f2), y * f2)
				else
					context.drawText("Melee W.", w - (x * f2), y * f2)
				end
				hover1[22], hover2[22] = context.button("hover"..22, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				local ranged = tostring(math.floor( functions.script.empowerAttackType(champion, "ranged", 100, true, 0, true) - 100 ))
				context.drawText("Ranged", w - (x * f2), y * f2)
				functions.script.drawStatNumber(context, ranged, w - ((x-138) * f2), y* f2)
				hover1[23], hover2[23] = context.button("hover"..23, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				local missile = tostring(math.floor( functions.script.empowerAttackType(champion, "missile", 100, true, 0, true) - 100 ))
				local throw = tostring(math.floor( functions.script.empowerAttackType(champion, "throwing", 100, true, 0, true) - 100 ))

				context.color(255, 255, 255, 255)
				context.drawText("/" .. throw, w - ((x-138) * f2) - context.getTextWidth("/" .. throw), y * f2)

				context.color(255, 255, 255, 255)
				context.drawText("" .. missile, w - ((x-138) * f2) - context.getTextWidth(missile .. "/" .. throw), y * f2)

				if context.getTextWidth(missile .. "/" .. throw) > 40 then
					context.drawText("Range W.", w - (x * f2), y * f2)
				else
					context.drawText("Ranged W.", w - (x * f2), y * f2)
				end
				hover1[24], hover2[24] = context.button("hover"..24, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Firearms", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "firearms", 100, true) - 100 ))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[25], hover2[25] = context.button("hover"..25, w - (x + 6), y-16, buttonW, buttonH)

				y = y + 20
				context.drawText("Dual Wield", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "dual_wielding", 100, true) - 100 ))
				functions.script.drawStatNumber(context, txt, w - ((x-138) * f2), y* f2)
				hover1[26], hover2[26] = context.button("hover"..26, w - (x + 6), y-16, buttonW, buttonH)


				-- Left Hand
				x = 530
				y = 592
				context.drawText("Dmg", w - (x * f2), y * f2)
				local dmg = functions.script.getDamage(champion, ItemSlot.Weapon)
				txt = tostring(math.floor(dmg[1])) .. " - " .. tostring(math.floor(dmg[2]))
				context.drawText("" .. txt , w - ((x-116) * f2) - context.getTextWidth(txt), y * f2)
				hover1[33], hover2[33] = context.button("hover"..33, w - (x + 6), y-16, 130, buttonH)

				y = y + 20
				context.drawText("Acc", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getAccuracy(champion, ItemSlot.Weapon) * 1))
				functions.script.drawStatNumber(context, txt, w - ((x-116) * f2), y* f2)
				hover1[34], hover2[34] = context.button("hover"..34, w - (x + 6), y-16, 130, buttonH)

				x = x-128
				y = 592
				context.drawText("Crit", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getCrit(champion, ItemSlot.Weapon) * 1)) .. "%"
				context.drawText("" .. txt, w - ((x-88) * f2) - context.getTextWidth(txt), y * f2)
				hover1[35], hover2[35] = context.button("hover"..35, w - (x + 6), y-16, 100, buttonH)

				y = y + 20
				context.drawText("Pierce", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getPierce(champion, ItemSlot.Weapon) * 1))
				functions.script.drawStatNumber(context, txt, w - ((x-88) * f2), y* f2)
				hover1[36], hover2[36] = context.button("hover"..36, w - (x + 6), y-16, 100, buttonH)

				-- Right Hand
				x = 276
				y = 592
				context.drawText("Dmg", w - (x * f2), y * f2)
				local dmg = functions.script.getDamage(champion, ItemSlot.OffHand)
				txt = tostring(math.floor(dmg[1])) .. " - " .. tostring(math.floor(dmg[2]))
				context.drawText("" .. txt , w - ((x-116) * f2) - context.getTextWidth(txt), y * f2)
				hover1[37], hover2[37] = context.button("hover"..37, w - (x + 6), y-16, 130, buttonH)

				y = y + 20
				context.drawText("Acc", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getAccuracy(champion, ItemSlot.OffHand) * 1))
				functions.script.drawStatNumber(context, txt, w - ((x-116) * f2), y* f2)
				hover1[38], hover2[38] = context.button("hover"..38, w - (x + 6), y-16, 130, buttonH)

				x = x-128
				y = 592
				context.drawText("Crit", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getCrit(champion, ItemSlot.OffHand) * 1)) .. "%"
				context.drawText("" .. txt, w - ((x-88) * f2) - context.getTextWidth(txt), y * f2)
				hover1[39], hover2[39] = context.button("hover"..39, w - (x + 6), y-16, 100, buttonH)

				y = y + 20
				context.drawText("Pierce", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getPierce(champion, ItemSlot.OffHand) * 1))
				functions.script.drawStatNumber(context, txt, w - ((x-88) * f2), y* f2)
				hover1[40], hover2[40] = context.button("hover"..40, w - (x + 6), y-16, 100, buttonH)
				
				for h = 1, 40 do
					local hoverTxt1, hoverTxt2 = "", ""
					local hoverX, hoverY = MX - (370 / 2), MY - 24

					if hover2[h] then
						if h == 1 then
							hoverTxt1 = "Strength"
							hoverTxt2 = "Strength increases your carrying capacity, fire resistance and damage you deal with most melee and throwing weapons."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 2 then
							hoverTxt1 = "Dexterity"
							hoverTxt2 = "Dexterity affects your Accuracy, Evasion, shock resistance and damage you deal with many missile weapons."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 3 then
							hoverTxt1 = "Vitality"
							hoverTxt2 = "Vitality affects the amount of Health points you have and your health regeneration rate. Vitality also increases your poison resistance."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 4 then
							hoverTxt1 = "Willpower"
							hoverTxt2 = "Willpower affects the amount of Energy points you have and your energy regeneration rate. Willpower also increases your cold resistance."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 5 then
							hoverTxt1 = "Health Regeneration Rate"
							hoverTxt2 = "You naturally regenerate 1 HP every 5 seconds. This number speeds up that timer by a percentage."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 6 then
							hoverTxt1 = "Energy Regeneration Rate"
							hoverTxt2 = "You naturally regenerate 1 EN every second. This number speeds up that timer by a percentage."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 7 then
							hoverTxt1 = "Action Speed"
							hoverTxt2 = "Your Action Speed is how fast you recover after attaking or using a spell."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 8 then
							hoverTxt1 = "Block Chance"
							hoverTxt2 = "Your chance to block an attack when holding a shield. Blocking reduces the damage taken by half."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 9 then
							hoverTxt1 = "Fire Resistance"
							hoverTxt2 = "Resist Fire reduces the damage you take from fire, steam and heat based attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 10 then
							hoverTxt1 = "Shock Resistance"
							hoverTxt2 = "Resist Shock reduces damage you take from lightning and electrical attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 11 then
							hoverTxt1 = "Poison Resistance"
							hoverTxt2 = "Resist Poison reduces the damage you take from poisonous attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 12 then
							hoverTxt1 = "Cold Resistance"
							hoverTxt2 = "Resist Cold reduces the damage you take from icy and cold attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 13 then
							hoverTxt1 = "Disease Resistance"
							hoverTxt2 = "Affects how likely you are to get infected with disease. While diseased you don't recover health."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 14 then
							hoverTxt1 = "Bleeding Resistance"
							hoverTxt2 = "Affects how likely you are to start bleeding when attacked. While bleeding you take a lot of damage if you try to move."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 15 then
							hoverTxt1 = "Resistance to being Poisoned"
							hoverTxt2 = "Affects how likely you are to get poisoned and how long it lasts. While poisoned you take damage over time."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 16 then
							hoverTxt1 = "Spell Multi"
							hoverTxt2 = "Increases the damage you deal with all spells. This is affected by Willpower."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 17 then
							hoverTxt1 = "Elemental Multi"
							hoverTxt2 = "The multipliers for Fire, Shock and Cold. Increases the damage you deal with elemental attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 18 then
							hoverTxt1 = "Poison Multi"
							hoverTxt2 = "Increases the damage you deal with poison attacks, but not the \"poisoned\" condition."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 19 then
							hoverTxt1 = "Neutral Multi"
							hoverTxt2 = "Increases the damage you deal with neutral spells."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 20 then
							hoverTxt1 = "Physical Multi"
							hoverTxt2 = "Increases the damage you deal with physical attacks and spells. Affects all weapon types."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 21 then
							hoverTxt1 = "Melee Multi"
							hoverTxt2 = "Increases the damage you deal with melee attacks. Does not affect unnarmed or bear form attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 22 then
							hoverTxt1 = "Melee Weapons Multi"
							hoverTxt2 = "Multipliers for Light Weapons and Heavy Weapons, respectively."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 23 then
							hoverTxt1 = "Ranged Multi"
							hoverTxt2 = "Increases the damage you deal with all long range weapons, except bombs."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 24 then
							hoverTxt1 = "Ranged Weapons Multi"
							hoverTxt2 = "Multipliers for Missile Weapons and Throwing Weapons, respectively."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 25 then
							hoverTxt1 = "Firearms Weapons Multi"
							hoverTxt2 = "Increases the damage you deal with firearms."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 1)
						elseif h == 26 then
							hoverTxt1 = "Dual Wielding Multi"
							hoverTxt2 = "Increases the damage you deal while dual wielding weapons, which by default is -40%."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 27 then
							hoverTxt1 = "Head Injury"
							hoverTxt2 = "No health regeneration."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 1)
						elseif h == 28 then
							hoverTxt1 = "Chest Injury"
							hoverTxt2 = "Accuracy -50. Unable to cast spells."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 1)
						elseif h == 29 then
							hoverTxt1 = "Legs Injury"
							hoverTxt2 = "No energy regeneration."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 1)
						elseif h == 30 then
							hoverTxt1 = "Feet Injury"
							hoverTxt2 = "Reduced movement speed and maximum load."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 1)
						elseif h == 31 then
							hoverTxt1 = "Left Hand Injury"
							hoverTxt2 = "Can't attack with the hand. Unable to block with a shield."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 32 then
							hoverTxt1 = "Right Hand Injury"
							hoverTxt2 = "Can't attack with the hand. Unable to block with a shield."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 33 or h == 37 then
							hoverTxt1 = "Damage"
							hoverTxt2 = "The range of physical damage you deal with attacks. It's affected by your stats, items, skills and the Physical multiplier."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 3)
						elseif h == 34 or h == 38 then
							hoverTxt1 = "Accuracy"
							hoverTxt2 = "The higher your accuracy, the better chance you have of hitting a target. Each point of accuracy translates to 1% chance of hitting a target with no evasion."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 4)
						elseif h == 35 or h == 39 then
							hoverTxt1 = "Critical Chance"
							hoverTxt2 = "Percentile chance of scoring a critical strike with a weapon."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						elseif h == 36 or h == 40 then
							hoverTxt1 = "Piercing"
							hoverTxt2 = "The amount of a target's protection you can pierce with your weapon."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, hoverX, hoverY, 2)
						end
						break
					end
				end
				
			end
		end, 

		onDrawSkills = function(self, context, champion)
			local customSkills = true
			if customSkills then
				local w, h, r = context.width, 		context.height, 	context.width / context.height
				local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
				local f2 = (context.height/1080)
				local MX, MY = context.mouseX, context.mouseY
				-- Cover original skill window up
				context.drawImage2("mod_assets/textures/gui/skills_back.dds", w - (548 * f2), 287 * f2, 0, 0, 510, 292, 510*f2, 292*f2)
				local dummy1, dummy2 = context.button("dummy",w - 536, 267, 510, 312)
				-- -- Variables
				local skill_x, skill_y = 0, 0
				local val1, val2, valX, valY = {}, {}, {}, {}
				-- local skill1_p = { 2,4,5 } -- athletics
				local skill1_p = { 2,4,5 } -- block
				local skill2_p = { 2,4,5 } -- light armor
				local skill3_p = { 2,4,5 } -- heavy armor
				local skill4_p = { 1,4,5 } -- accuracy
				local skill5_p = { 2,4,5 } -- critical
				local skill6_p = { 2,4,5 } -- firearms
				local skill7_p = { 2,3,4,5 } -- seafaring
				local skill8_p = { 1,2,4,5 } -- alchemy
				local skill9_p = { 3,4,5 } -- tinkering
				local skill10_p = { 1,4,5 } -- ranged weapons
				local skill11_p = { 2,4,5 } -- throwing weapons
				local skill12_p = { 3,4,5 } -- light weapons
				local skill13_p = { 3,4,5 } -- heavy weapons
				local skill14_p = { 1,2,4,5 } -- spellblade
				local skill15_p = { 2,4,5 } -- elemental
				local skill16_p = { 2,4,5 } -- poison
				local skill17_p = { 3,4,5 } -- concentration
				local skill18_p = { 1,4,5 } -- witchcraft				
				local skill_perks = { skill1_p, skill2_p, skill3_p, skill4_p, skill5_p, skill6_p, skill7_p, skill8_p, skill9_p, skill10_p, skill11_p, skill12_p, skill13_p, skill14_p, skill15_p, skill16_p, skill17_p, skill18_p }
				-- Draw skills slots
				for i=1,18 do
					skill_x = math.floor((i-1) / 9)
					skill_y = (i-1) % 9
					context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((369 - (skill_x * 252)) * f2), (298 + (skill_y * 31)) * f2, 1, 1, 70, 21, 70*f2, 21*f2)
					val1[i], val2[i] = context.button("skill_info"..i, w - (548 - (skill_x * 252)), 292 + (skill_y * 31), 252, 31)
					valX[i] = 369 - (skill_x * 252)
					valY[i] = 298 + (skill_y * 31)
				end
				-- Draw skills slots (hover)
				for i=1,18 do	
					if val2[i] then
						context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((valX[i] + 1) * f2), (valY[i] - 1) * f2, 0, 23, 72, 23, 72*f2, 23*f2)
						break
					end
				end
				-- Draw skill pegs
				for i=1,18 do
					skill_x = math.floor((i-1) / 9)
					skill_y = (i-1) % 9
					local xpositions = {0,0,0,5,10}
					local tickX = 0				
					-- Draw green pegs
					local skillLevel = champion:getSkillLevel(functions.script.skillNames[i])
					local tempLevel = skillLevel + functions.script.partySkillTemp[champion:getOrdinal()][i]
					if skillLevel < 5 then					
						if tempLevel > 0 and skillLevel < 5 then
							for j=skillLevel+1,tempLevel do
								tickX = ((j-1) * 11) + xpositions[j]
								context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((366 - (skill_x * 252) - tickX) * f2), (301 + (skill_y * 31)) * f2, 10, 46, 10, 15, 10*f2, 15*f2)
							end
						end	
					end
					
					-- Draw yellow pegs
					local skillLevel = champion:getSkillLevel(functions.script.skillNames[i])
					if skillLevel > 0 then
						for j=1,skillLevel do
							tickX = ((j-1) * 11) + xpositions[j]
							context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((366 - (skill_x * 252) - tickX) * f2), (301 + (skill_y * 31)) * f2, 0, 46, 10, 15, 10*f2, 15*f2)
						end
					end
					
					-- Draw trait pegs
					for j=1,#skill_perks[i] do
						tickX = (skill_perks[i][j] - 1) * 11 + xpositions[skill_perks[i][j]]
						local got = 0
						if skillLevel >= skill_perks[i][j] or tempLevel >= skill_perks[i][j] then
							got = 7
						end
						if skill_perks[i][j] < 4 then
							context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((363 - (skill_x * 252) - tickX) * f2), (306 + (skill_y * 31)) * f2, 72, got, 4, 5, 4*f2, 5*f2)
						elseif skill_perks[i][j] == 4 then
							context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((364 - (skill_x * 252) - tickX) * f2), (305 + (skill_y * 31)) * f2, 76, got, 6, 6, 6*f2, 6*f2)
						else
							context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((364 - (skill_x * 252) - tickX) * f2), (305 + (skill_y * 31)) * f2, 82, got, 6, 7, 6*f2, 7*f2)
						end
					end				
				end
				-- Draw confirm and clear buttons
				local confirm1, confirm2 = context.button("confirm", w - (270), 584, 108, 32)
				local clear1, clear2 = context.button("clear", w - (270-125), 584, 108, 32)
				for i=1,18 do
					if functions.script.partySkillTemp[champion:getOrdinal()][i] > 0 then
						context.drawGuiItem2("ButtonAccept", w - (274*f2), 583*f2, 0, 0, 108, 32, 108*f2, 32*f2)
						context.drawGuiItem2("ButtonClear", w - ((274-125)*f2), 583*f2, 0, 0, 108, 32, 108*f2, 32*f2)
						if confirm2 then
							context.drawGuiItem2("ButtonAcceptHover", w - (274*f2), 583*f2, 0, 0, 108, 32, 108*f2, 32*f2)
							if context.mouseDown(3) then
								functions.script.performSkillTemp(champion)
							end
						end
						if clear2 then
							context.drawGuiItem2("ButtonClearHover", w - ((274-125)*f2), 583*f2, 0, 0, 108, 32, 108*f2, 32*f2)
							if context.mouseDown(3) then
								functions.script.clearSkillTemp(champion)
							end
						end
						break
					end
				end
				-- Draw description overlay and icon
				for j=1,18 do
					if val2[j] then	
						-- Click skill --
						local points = champion:getSkillPoints()
						local skillLevel = champion:getSkillLevel(functions.script.skillNames[j])
						local skillLevelTemp = functions.script.partySkillTemp[champion:getOrdinal()][j]
						local totalSkills = functions.script.countAllSkills(champion)
						if context.mouseDown(3) and points > 0 and skillLevelTemp < 5 and skillLevelTemp < 5 - skillLevel then
							if skillLevelTemp + skillLevel == 3 then
								if totalSkills >= 7 then
									functions.script.addSkillTemp(champion, j)
								else
									hudPrint("Need 7 allocated skill points to get Silver tier. You got " .. totalSkills .. ".")
								end						
							elseif skillLevelTemp + skillLevel == 4 then
								if totalSkills >= 11 then
									functions.script.addSkillTemp(champion, j)
								else
									hudPrint("Need 11 allocated skill points to get Gold tier. You got " .. totalSkills .. ".")
								end	
							else
								functions.script.addSkillTemp(champion, j)
							end
						end
						-- Unclick skill --
						if context.mouseDown(5) and functions.script.partySkillTemp[champion:getOrdinal()][j] > 0 then
							functions.script.removeSkillTemp(champion, j)						
						end
						-- Draw description
						local f3 = math.min(f2 + 0.1, 1)
						context.drawImage2("mod_assets/textures/gui/skill_description/skill_" .. j .. ".dds", w - (1170 * f), MY - 230, 0, 0, 556, 500, 556*f, 500*f)
						-- Draw icon
						-- context.drawImage2("mod_assets/textures/gui/skills.dds", w - (1228*f2), MY - 110 + 16, ((j-1)%13)*75, math.floor((j-1)/13)*75, 75, 75, 75*f3, 75*f3)
						break
					end	
				end
			end
		end, 

		--onDrawTraits = function(g,champion) print('traits') end, 
		
		-- WORKS
		onCastSpell = function(party, champion, spellName) 
			print(champion:getName(),'is using',spellName) 
			if champion:hasTrait("spell_slinger") then
				champion:removeTrait("mage_spark_memo")
				champion:removeTrait("fireburst_memo")
				champion:removeTrait("frost_burst_memo")
				champion:removeTrait("shock_memo")
				champion:removeTrait("poison_cloud_memo")
				if spellName == "fireburst" or spellName == "frost_burst" or spellName == "shock" or spellName == "poison_cloud" or spellName == "mage_spark" then
					champion:addTrait(spellName.."_memo")
					functions.script.spellSlinger[champion:getOrdinal()] = spellName
				end
			end
			
			if champion:hasTrait("intensify_spell") then
				functions.script.set_c("lastSpell", champion:getOrdinal(), spellName)
				print("set last spell to "..spellName)
			end
			
			if champion:hasCondition("sneak_attack") then
				champion:removeCondition("sneak_attack")
				functions.script.set_c("sneak_attack", champion:getOrdinal(), nil)
			end

			return spells_functions.script.onCastSpell(champion, spellName)
		end,
		
		-- UNTESTED

		onUseItem = function(party,champion,item,slot) 
			print(party.go.id,champion:getName(),'is using',item,slot) 
		end,

		onReceiveCondition = function(party,champion,condition,condNumber) 
			if condition == "bleeding" then
				if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "pit_gauntlets" then
					if math.random() <= champion:getItem(ItemSlot.Gloves):hasTrait("upgraded") and 0.5 or 0.25 then
						champion:removeCondition("bleeding")
					end
				end
			end
			if condition == "right_hand_wound" then
				if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "pit_gauntlets" then
					if math.random() <= champion:getItem(ItemSlot.Gloves):hasTrait("upgraded") and 0.5 or 0.25 then
						champion:removeCondition("right_hand_wound")
					end
				end
			end
			if condition == "left_hand_wound" then
				if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "pit_gauntlets" then
					if math.random() <= champion:getItem(ItemSlot.Gloves):hasTrait("upgraded") and 0.5 or 0.25 then
						champion:removeCondition("left_hand_wound")
					end
				end
			end
		end, 		

		onLevelUp = function(party,champion) 
			--print(party.go.id,champion:getName(),'leveled up!') 
			if champion:getClass() == "tinkerer" then
				local count = functions.script.get_c("crafting_expertise", champion:getOrdinal())
				functions.script.set_c("crafting_expertise", champion:getOrdinal(), count ~= nil and math.min(count + 1, 3) or 1)
				if count ~= nil and count < 3 then
					hudPrint(champion:getName() .. ", the Tinkerer gained one charge of Crafting Expertise.")
				end
			end

			if champion:getClass() == "assassin_class" and (champion:getLevel()-1) % 3 == 0 then
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), champion:getName() .. " gained +1 maximum armor break with Fleshbore.")
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "assassin_class" and (champion:getLevel()-1) % 6 == 0 then
				functions.script.set_c("level_up_message_2", champion:getOrdinal(), champion:getName() .. " gained +1 armor break with Fleshbore.")
				functions.script.set_c("level_up_message_2_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "fighter" and (champion:getLevel()-1) % 3 == 0 then
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), champion:getName() .. " gained +6 Protection and +1 Strenght to Berserker Frenzy.")
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "monk" and (champion:getLevel()-1) % 4 == 0 then
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), champion:getName() .. " gained +3 seconds duration to Healing Aura and +30 seconds to Holy Light.")
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "hunter" then
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), champion:getName() .. " gained +1 second duration to Thrill of the Hunt.")
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "stalker" and (champion:getLevel()-1) % 3 == 0 then
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), champion:getName() .. " gained +4 seconds duration to Night Stalker.")
				functions.script.set_c("level_up_message_1_timer", champion:getOrdinal(), 8)
			end

			if champion:hasTrait("brutalizer") and (champion:getLevel()-1) % 2 == 0 then
				functions.script.set_c("level_up_message_2", champion:getOrdinal(), champion:getName() .. " gained +1 Strength from the Brutalizer trait.")
				functions.script.set_c("level_up_message_2_timer", champion:getOrdinal(), 8)
			end

			if champion:hasTrait("bite") and (champion:getLevel() == 8 or champion:getLevel() == 12) then
				functions.script.set_c("level_up_message_2", champion:getOrdinal(), champion:getName() .. " gained -5 seconds cooldown to Bite.")
				functions.script.set_c("level_up_message_2_timer", champion:getOrdinal(), 8)
			end
		end,

		onPickUpItem = function(party, item)
			if item.go.model then
				item.go.model:setOffset(vec(0,0,0))
				item.go.model:setRotationAngles(0,0,0)
			end
			functions2.script.checkIronKeyBurn(party,item)
		end,

		onGetPortrait = function(self,champion)
		end,
	},

	{
		class = "Counter",
		name = "partycounter",
	},

	{
		class = "Timer",
		name = "partytimer",
		timerInterval = 2.0,
		triggerOnStart = true,
		onActivate = function(self)
			self.go.partycounter:increment()
			local v = self.go.partycounter:getValue()

			-- Monster Bleeding dot
			for entity in Dungeon.getMap(party.level):allEntities() do
				if entity.monster then
					local monster = entity.monster
					functions.script.takeBleedDamage(monster, "dot")
				end
			end

			-- Ice Sword damage
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				local item = champion:getItem(ItemSlot.Weapon)
				if item and item.go.name == "ice_sword" and champion:getResistance("cold") < 50 then
					local chance = 1 - math.min((champion:getResistance("cold") * 0.02), 0.7)
					if math.random() < chance then
						champion:damage(6 + (math.random() * 12), "cold")
					end
				end
			end

			-- Poison
			for entity in Dungeon.getMap(party.level):allEntities() do
				if entity.monster then
					local monster = entity.monster
					if monster and monster.go.poisoned and monster:isAlive() and monster.go.poisoned:getCausedByChampion() then
						local c = monster.go.poisoned:getCausedByChampion()
						local champion = party.party:getChampionByOrdinal(c)
						if c then
							if champion:hasTrait("antivenom") and math.random() <= 0.45 then
								functions.script.hitMonster(monster.go.id, math.random(monster:getHealth() * 0.005, monster:getHealth() * 0.01), nil, "poison", c)
								champion:regainHealth( math.min(math.random(1,5) * champion:getLevel() * 0.15, 5) )
							end
						end
						
						-- Plague spread
						if c and math.random() <= 0.33 then							
							if champion:hasTrait("plague") then
								local mList = {}
								for d=0,8 do
									local dx = math.floor(d / 3) - 1
									local dy = ((d-1) % 3) - 1
									for e in Dungeon.getMap(party.level):entitiesAt(monster.go.x + dx, monster.go.y + dy) do
										if e.monster and e.monster ~= monster then
											table.insert(mList, e.monster)
										end
									end
								end
								if #mList > 0 then
									local value = mList[ math.random( #mList ) ]
									if value then
										if not value.go.poisoned then
											value:setConditionValue("poisoned", math.random(10,20))
										end
										if value.go.poisoned then 
											value.go.poisoned:setCausedByChampion(champion:getOrdinal())
										end
									end
								end
							end
						end
					end
				end
			end

			
			-- for i=1,4 do
				-- local champion = party.party:getChampionByOrdinal(i)
				-- if champion:getClass() == "stalker" then
					-- local bonus = 1 + math.floor(champion:getLevel() / 3)
					-- functions.script.add_c("night_stalker", i, bonus)
					-- hudPrint(champion:getName() .. ", the Spell Thief, has recovered " .. (1 + bonus) .. " charges of Invisibility")
				-- end
			-- end
			--return hudPrint("Time = "..v.."")
		end
	},

	{
		class = "Counter",
		name = "gametime2",
	},

	{
		class = "Timer",
		name = "partytimer2",
		timerInterval = 0,
		triggerOnStart = true,
		onActivate = function(self)
			self.go.gametime2:increment()
			local t = GameMode.getTimeOfDay()
			local v = party.gametime2:getValue()

			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				local potion_stacks = functions.script.get_c("potion_stacks", i)
				local potion_slot = functions.script.get_c("potion_slot", i)
				local potion_top_item_id = functions.script.get_c("potion_top_item", i) or ""
				local potion_top_item = iff(potion_top_item_id, findEntity(potion_top_item_id), nil)
				local potion_bottom_item_id = functions.script.get_c("potion_bottom_item", i) or ""
				local potion_bottom_item = iff(potion_bottom_item_id, findEntity(potion_bottom_item_id), nil)
				

				if potion_stacks and potion_slot then
					local item = potion_bottom_item
					if item and item:getStackable() then
						if item:getStackSize() > potion_stacks then
							-- print("bot stack was increased")
							-- if potion_top_item and potion_top_item:getStackSize() < potion_bottom_item:getStackSize() then potion_top_item = nil end
							-- print( potion_top_item.go.name )
							-- print( potion_top_item.go.potion_stack:getTop() )
							functions.script.stackedPotions(champion, potion_slot, potion_bottom_item, potion_top_item, "increase")
						elseif item:getStackSize() < potion_stacks then
							-- print("bot stack was decreased")
							local mouseItem = getMouseItem()
							if mouseItem and mouseItem.go.name == potion_bottom_item.go.name then potion_top_item = mouseItem end
							if potion_bottom_item and potion_bottom_item:getStackSize() == 0 then potion_bottom_item = nil end
							functions.script.stackedPotions(champion, potion_slot, potion_bottom_item, potion_top_item, "decrease")
						end
					end
				end

				local zone = functions.script.get("portrait_zone")
				if zone then
					local champion = party.party:getChampion(zone)
					local mouseItem = getMouseItem()
					if mouseItem and champion then
						-- Add "perfect mix" tag to potion
						if mouseItem:hasTrait("potion") and mouseItem.go.potion_stack then
							local data = mouseItem.go.potion_stack:getData()
							if data[1] == nil then
								if champion:hasTrait("perfect_mix") then
									mouseItem.go.potion_stack:insert("perfect")
									functions.script.setPerfectPotionGE(mouseItem)
								else
									mouseItem.go.potion_stack:insert("normal")
								end
							end
						end

						-- -- Add "bomb expert" tag to bomb
						-- if mouseItem:hasTrait("bomb") and mouseItem.go.potion_stack then
						-- 	local data = mouseItem.go.potion_stack:getData()
						-- 	if data[1] == nil then
						-- 		if champion:hasTrait("bomb_expert") then
						-- 			mouseItem.go.potion_stack:insert("expert")
						-- 			functions.script.setPerfectPotionGE(mouseItem)
						-- 		else
						-- 			mouseItem.go.potion_stack:insert("normal")
						-- 		end
						-- 	end
						-- end
					end
				end

				local using_mortar = functions.script.get_c("using_mortar", i)
				if using_mortar then
					local item = getMouseItem()
					if item and item:hasTrait("potion") then

					end
				end				
			end
			

			if v > 10 and v % 2 == 0 then
				functions2.script.updateSky(t) -- updates sky and tides
				functions.script.keypressDelaySet(math.max(functions.script.keypressDelayGet() - 2, 0))
			
				if party.party:isCarrying("enchanted_timepiece") or (getMouseItem() and getMouseItem().go.name == "enchanted_timepiece") then
					local timepiece = functions.script.getTimepiece()
					for entity in Dungeon.getMap(party.level):entitiesAt(party.x, party.y) do
						if timepiece then
							-- if entity.name == "crystal_area_inside" and entity.elevation == party.elevation then
								if functions2.script.timeTravelTimer == 0 then
									timepiece.go.item:setGfxIndex(26) -- charged
								else
									timepiece.go.item:setGfxIndex(39 - functions2.script.timeTravelTimer)
								end
								break
							-- else
							-- 	if functions2.script.timeTravelTimer == 0 then
							-- 		timepiece.go.item:setGfxIndex(13) -- empty
							-- 	else
							-- 		timepiece.go.item:setGfxIndex(26 - functions2.script.timeTravelTimer)
							-- 	end
							-- end
						end
					end
				end
				
				-- Counts monsters that can see the player
				local aggroMonsters = 0
				local aggroMonstersHP = 0
				for entity in Dungeon.getMap(party.level):allEntities() do
					if entity.monster then
						local monster = entity.monster
						if monster and monster:hasTrait("bleeding") then
							local wave = math.abs(math.sin(self.go.gametime2:getValue() * 0.05))
							monster.go.model:setEmissiveColor(vec(0.05,-.02,-.02) * wave)
						end

						if entity.brain.seesParty and entity.brain.partyOnLevel then
							aggroMonsters = aggroMonsters + 1
							aggroMonstersHP = aggroMonstersHP + entity.monster:getHealth()
						end
						-- print(entity.name, "sees party", entity.brain.seesParty)
						-- print(entity.name, "detected timer", entity.detectedtimer)
					end
				end
				-- print("aggro count", aggroMonsters)
				functions.script.set("aggroMonsters", aggroMonsters)
				functions.script.set("aggroMonstersHP", aggroMonstersHP)

				-- Get the first monster that the party can see in front of it
				local dx,dy = getForward(party.facing)
				local monsterInFront = nil
				for i=1,8 do
					for e in Dungeon.getMap(party.level):entitiesAt(party.x + (dx * i), party.y + (dy * i)) do
						if e.monster then
							local canSee = Dungeon.getMap(party.level):checkLineOfSight(party.x, party.y, e.x, e.y, party.elevation)
							if canSee then
								monsterInFront = e.id
								break
							end
						end
					end
					if monsterInFront then
						break
					end
				end
				functions.script.set("monsterInFront", monsterInFront)

				-- Checks a poisoned monster in front of party
				if monsterInFront then
					local monster = findEntity(monsterInFront)
					if monster.monster then
						if monster.poisoned then
							functions.script.set_c("poisonedMonster", i, monster)
						end
					end
				end
				
			end

			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				local dir = party.facing
				local dx,dy = getForward(dir)

				functions.script.checkWeights(i)
				if party:getWorldPositionY() > -0.6 and champion:isReadyToAttack(1) then
					functions.script.set_c("attackedWith", i, nil)
					functions.script.set_c("attacked", i, nil)
				end

				for dist=1,3 do
					for e in Dungeon.getMap(party.level):entitiesAt(party.x + (dx * dist), party.y + (dy * dist)) do
						if e and e.monster and e.monster:hasTrait("undead") then
							if functions.script.isArmorSetEquippedByAnyone("embalmers") and dist < 3 then
								functions.script.changeResistances(e.monster, {poison = "normal"})
							else
								functions.script.changeResistances(e.monster, {poison = "immune"})
							end
						end
					end
				end

				-- Counts monsters adjacent to party				
				if champion:hasTrait("wide_vision") then
					local monsterCount = 0
					for e in Dungeon.getMap(party.level):entitiesAt(party.x + dx, party.y + dy) do
						if e.monster then
							monsterCount = monsterCount + 1
						end
					end
					
					if monsterCount then
						if champion:hasTrait("wide_vision") then
							functions.script.set_c("wide_vision", i, monsterCount)
						end
					else
						functions.script.set_c("wide_vision", i, nil)
					end
				end
				
				if party:getWorldPositionY() > -0.6 and champion:hasTrait("sneak_attack") and (champion:isReadyToAttack(0) or champion:isReadyToAttack(1)) and functions.script.get_c("sneak_attack", champion:getOrdinal()) then
					functions.script.set_c("sneak_attack", champion:getOrdinal(), nil)
				end
				
				local drown_sorrows_exp = functions.script.get_c("drown_sorrows_exp", champion:getOrdinal())
				if champion:hasTrait("drinker") and champion:hasTrait("drown_sorrows_exp") and drown_sorrows_exp then
					local resetTimer = drown_sorrows_exp
					if resetTimer ~= nil and GameMode.getTimeOfDay() < resetTimer and GameMode.getTimeOfDay() >= resetTimer - 0.002 then
						champion:removeTrait("drown_sorrows_exp")
						functions.script.set_c("drown_sorrows_exp", champion:getOrdinal(), nil)
						functions.script.set_c("level_up_message_3", champion:getOrdinal(), champion:getName() .. " drinking EXP Penalty was removed.")
						functions.script.set_c("level_up_message_3_timer", champion:getOrdinal(), 8)
					end
				end
				
				-- Drain the Healing Light charge bar
				if champion:getClass() == "monk" then
					if champion:getConditionValue("healing_light") > 0 then
						local healingLight = functions.script.get_c("healinglight", champion:getOrdinal())
						local healingMax = 400 + ((champion:getLevel() ^ 2) * 75)
						if not healingLight then healingLight = 0 end
						local bonus = math.floor(champion:getLevel() / 4) * 3
						healingLight = healingMax * champion:getConditionValue("healing_light") / (12 + bonus)
						functions.script.set_c("healinglight", champion:getOrdinal(), healingLight)
					end
				end

				for i=1,3 do
					local timer = functions.script.get_c("level_up_message_".. i .."_timer", champion:getOrdinal())
					if timer then
						if timer > 0 then
							functions.script.set_c("level_up_message_".. i .."_timer", champion:getOrdinal(), timer - 0.02)
						else
							functions.script.set_c("level_up_message_".. i .."_timer", champion:getOrdinal(), nil)
						end
					end
				end
			end
		end
	},

	{
		class = "Counter",
		name = "timetraveltimer",
	},

	{
		class = "Timer",
		name = "timetravel",
		timerInterval = 1, -- once per second
		triggerOnStart = true,
		onActivate = function(self)
			self.go.timetraveltimer:increment()
			-- local period = party.data:get("period") or "present"
			-- if period == "past" and functions2.script.travel_mode == "device" then
			-- 	-- local has_area = false
			-- 	-- for entity in Dungeon.getMap(party.level):entitiesAt(party.x, party.y) do
			-- 	-- 	if (entity.name == "crystal_area_inside" or entity.name == "crystal_area") then
			-- 	-- 		has_area = true
			-- 	-- 		break
			-- 	-- 	end
			-- 	-- end
			-- 	-- if not has_area then
			-- 	-- 	functions2.script.updateTimeTravelTimer(-1)
			-- 	-- end
			-- 	local obj1 = party
			-- 	local obj2 = findEntity(functions2.script.travel_crystal)
			-- 	if obj2 and obj1 then
			-- 		local distance = math.abs(math.sqrt(((obj1.x - obj2.x) ^ 2) + ((obj1.y - obj2.y) ^ 2)))
			-- 		distance = (distance)
			-- 		functions2.script.updateTimeTravelTimer(distance)
			-- 	end
			-- end
				
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				local c = champion:getOrdinal()
				if champion:hasTrait("bite") then
					local biteTimer = functions.script.get_c("bite", champion:getOrdinal())
					if biteTimer and biteTimer > 0 then
						functions.script.set_c("bite", champion:getOrdinal(), math.max(biteTimer - 1, 0))
					end
				end

				if champion:hasTrait("crystal_health") and get_c("crystal_health", champion:getOrdinal()) ~= nil then
					if champion:getHealth() <= 50 then
						champion:setConditionValue("crystal_health", 5)
						champion:removeTrait("crystal_health")
						set_c("crystal_health", champion:getOrdinal(), nil)
					end
				end

				if party.party:isResting() then
					if champion:getClass() == "monk" then
						local focus = functions.script.get_c("focus", c) or 0
						local focusMax = champion:getMaxEnergy()
						local bonus = 1 + (champion:getLevel() * 0.02) + (math.floor(champion:getLevel() / 4) * 0.02) + (champion:getCurrentStat("energy_regeneration_rate") * 0.01)
						functions.script.set_c("focus", c, math.min( focus + (1 * bonus), focusMax) )
					end
				end
			end 
			
			functions:setPosition(0, 0, 0, 0, party.level)
			functions2:setPosition(1, 0, 0, 0, party.level)
			spells_functions:setPosition(2, 0, 0, 0, party.level)
		end
	},

	-- {
	-- 	class = "Counter",
	-- 	name = "hours",
	-- },	

	-- {
	-- 	class = "Timer",
	-- 	name = "partyhours",
	-- 	timerInterval = 60, -- will be 8.33 for hours
	-- 	triggerOnStart = true,
	-- 	onActivate = function(self)
	-- 		self.go.hours:increment()
	-- 		local v = self.go.hours:getValue()
	-- 		for i=1,4 do
	-- 			local champion = party.party:getChampionByOrdinal(i)
	-- 			for j=1,32 do
	-- 				local item = champion:getItem(j)
	-- 				if item and item:hasTrait("magic_gem") and item.go.data:get("charges") then
	-- 					local icon = item.go.data:get("icon")
	-- 					if icon == nil then return end
	-- 					item.go.data:set("charges", math.min(item.go.data:get("charges") + 1, 24))						
	-- 					if item.go.data:get("charges") == 23 then
	-- 						item.go.item:setGfxIndex(icon + 1)
	-- 					elseif item.go.data:get("charges") == 24 then
	-- 						item.go.item:setGfxIndex(icon)
	-- 					end
	-- 				end
	-- 			end
	-- 		end
	-- 		-- print ("A day has passed.")
	-- 		functions.script.add("minutes", 1)
	-- 		return hudPrint("Minutes = "..v.."")
	-- 	end
	-- },
	},
}