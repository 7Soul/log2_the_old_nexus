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
-- import custom assets
import "mod_assets/scripts/objects/base.lua"
import "mod_assets/scripts/defineObject.lua"
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
							print("Item", item.go.name, "reached a burnout of", item.go.data:get("burnout"), "out of a max", 4500)
						end
					end
					if item and item.go.name == "fiber_ball_good" then
						if item.go.data:get("burnout") == nil then item.go.data:set("burnout", 0) end
						local parent = party:getChampionByOrdinal(item.go.data:get("parent"))
						local b_timer = 1000 + (parent:getLevel() - 1) * 135
						
						item.go.data:set("burnout", math.min(item.go.data:get("burnout") + 1, b_timer))
						if item.go.data:get("burnout") >= b_timer then
							champion:removeItem(item)
							champion:insertItem(slot, spawn("fiber_ball_bad").item)
						end
						if item.go.data:get("burnout") % 200 == 0 then
							print("Item", item.go.name, "reached a burnout of", item.go.data:get("burnout"), "out of a max", b_timer)
						end
					end
					if item and item.go.name == "ice_sword" then
						if item.go.data:get("burnout") == nil then item.go.data:set("burnout", 0) end
						local parent = party:getChampionByOrdinal(item.go.data:get("parent"))
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
			print(champion:getName(), "is attacking with", action.go.name)

			if action.go.name == "tinkering_toolbox" then
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
			
			if action.go.item:getSecondaryAction() == "dagger_throw" and action.go.dagger_throw == action then
				if action.go.meleeattack then
					functions.script.onMeleeAttack(action.go.dagger_throw, action.go.item, champion, slot, 0, nil)
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
					--functions.script.set_c("attackedWith", c:getOrdinal(), nil)
					--functions.script.set_c("attacked", c:getOrdinal(), nil)
				end
			end
			functions.script.set_c("attackedWith", champion:getOrdinal(), action.go.name)
			functions.script.set_c("attacked", champion:getOrdinal(), champion:getOrdinal())
			--functions.script.reset_attack(action.go.meleeattack, champion, slot, 0, action.go.item)
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
			for i=1,4 do
				if party:getChampion(i):getClass() == "berserker" and party:getChampion(i):isAlive() then
					party:getChampion(i):setConditionValue("berserker_revenge", 60)
					if party:getChampion(i):hasCondition("berserker_rage") then
						party:getChampion(i):removeCondition("berserker_rage")
					end
				end
			end
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
					local night_stalker_charges = functions.script.night_stalker[i]
					--print(party.go.partycounter:getValue())
					if night_stalker_charges > 0 then
						--print(functions.script.night_stalker[i])
						local bonus = 22 + ((party:getChampion(i):getLevel()-1) * 2)
						spells_functions.script.maxConditionValue("invisibility", 8 + bonus)
						spells_functions.script.maxEffectIcons("invisibility", 8 + bonus)
						functions.script.night_stalker[i] = functions.script.night_stalker[i] - 1
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
			if champion then
				local mouseItem = getMouseItem()
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
								functions.script.set_c("tinkering", champion:getOrdinal(), otherSlot)
							else
								if champion:getItem(otherSlot):hasTrait("upgradable") then
									functions.script.set_c("tinkering", champion:getOrdinal(), otherSlot)
								else
									hudPrint("Item is not upgradable.")
								end
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
					
					context.drawGuiItem2("ButtonYes", w - (functions.script.dismantleX + 115 - 48) * f2, (functions.script.dismantleY - 42 + 70) * f2, 0, 0, 73, 32, 73 * f2, 32 * f2)
					local yes1, yes2 = context.button("yes", w - (functions.script.dismantleX + 115 - 48), (functions.script.dismantleY - 42 + 70), 73, 32)
					if yes1 or yes2 then
						context.drawGuiItem2("ButtonYesHover", w - (functions.script.dismantleX + 115 - 48) * f2, (functions.script.dismantleY - 42 + 70) * f2, 0, 0, 73, 32, 73 * f2, 32 * f2)
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
			
			-- if champion:getClass() == "berserker" then
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
			local f2 = context.height/1080
			local MX, MY = context.mouseX, context.mouseY
			local mLeft, mRight = context.mouseDown(0), context.mouseDown(2)
			if f > 0.9 then
				context.font("large")
			elseif f > 0.5 then
				context.font("medium")
			elseif f > 0.2 then
				context.font("small")
			elseif f < 0.2 then
				context.font("tiny")
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
						functions.script.set_c("tinkering", champion:getOrdinal(), nil)
					end
				end
				-- Upgrade button
				local upg1, upg2 = context.button("tinkering_confirm", x, y + 86, 132, 31)
				if upg1 or upg2 then
					if context.mouseDown(3) then
						functions.script.tinkererUpgrade(self, champion, functions.script.get_c("tinkering", champion:getOrdinal()), materials)
						functions.script.set_c("tinkering", champion:getOrdinal(), nil)
					end
				end

				return false
			end
			
			if champion:getClass() == "monk" then
				local healingLight = functions.script.get_c("healinglight", champion:getOrdinal())
				local healingMax = 400 + ((champion:getLevel() ^ 2) * 75)
				if healingLight then
					context.drawImage2("mod_assets/textures/gui/bar.dds", x-19, y-9, 0, 0, 64, 64, math.min(healingLight / healingMax * 59, 59), 3)
				end
				-- if champion:hasCondition("healing_light") then
					-- context.drawImage2("mod_assets/textures/gui/healing_light.dds", x-22, y-70, 0, 0, 64, 64, 68, 68)
				-- end
			end
			
			if champion:getClass() == "hunter" then
				if functions.script.hunter_crit[champion:getOrdinal()] > 0 then
					context.font("small")
					local x2 = 0
					local posx = 0
					local posy = 0
					context.color(225, 225, 195, 255)
					if champion:getItem(ItemSlot.Weapon) then
						x2 = 0
						posx = (x + 18) + (x2 * 80)
						posy = y + 28
						context.drawText("" .. functions.script.hunter_crit[champion:getOrdinal()], posx, posy)
						context.drawImage2("mod_assets/textures/gui/bar.dds", posx-6, posy+2, 0, 0, 64, 64, champion:getConditionValue("hunter_crit") / functions.script.hunter_max[champion:getOrdinal()] * 24, 3)
					elseif champion:getItem(ItemSlot.OffHand) then
						x2 = 1
						posx = (x + 18) + (x2 * 80)
						posy = y + 28
						context.drawText("" .. functions.script.hunter_crit[champion:getOrdinal()], posx, posy)
					end
					local val1, val2 = context.button("rectButtoN", posx - 5, posy - 20, 20, 24)
					if val1 or val2 then
						context.color(255, 255, 255, 196)
						local text = "Thrill of the Hunt"
						context.drawText(text, posx - (context.getTextWidth(text) / 2), posy - 20)
					end
				end
			end	
			--return false
		end,
		
		onDrawGui = function(self, context)			
			local w, h, r = context.width, 		context.height, 	context.width / context.height
			local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
			local f2 = context.height/1080
			local MX, MY = context.mouseX, context.mouseY
			local mLeft, mRight = context.mouseDown(0), context.mouseDown(2)
			
			local multi = 1
			if context.keyDown("shift") then
				multi = -1
			else
				multi = 1
			end
			
			
			
			-- local keyset = { "T", "1", "2", "3" }
			-- for i=1, #keyset do
			-- 	if functions.script.getKeydown(keyset[i]) then
			-- 		print("key " .. keyset[i] .. " pressed")
			-- 		functions.script.resetKeydown(keyset[i])
			-- 	end
			
			-- 	if context.keyDown(keyset[i]) and not functions.script.getKeydown(keyset[i]) then
			-- 		functions.script.setKeydown(keyset[i])
			-- 	end
				
			-- 	if not context.keyDown(keyset[i]) then
			-- 		functions.script.resetKeydown(keyset[i])
			-- 	end
			-- end
			
			
			
			
			if context.keyDown("1") then
				party:setPosition(party.x, party.y, party.facing, 0, party.level)
			end
			if context.keyDown("2") then
				party:setPosition(party.x, party.y, party.facing, 1, party.level)
			end
			if context.keyDown("3") then
				party:setPosition(party.x, party.y, party.facing, 2, party.level)
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
			
			if context.keyDown("U") and functions.script.keypressDelayGet() == 0 then
				GameMode.setTimeOfDay((GameMode.getTimeOfDay() + 0.33) % 2)
				print("Time of Day set to " .. GameMode.getTimeOfDay())
				functions.script.keypressDelaySet(10)
			end

			if context.keyDown("L") and functions.script.keypressDelayGet() == 0 then
				for i = 1,4 do
					party.party:getChampion(i):levelUp()
					functions.script.keypressDelaySet(10)
				end
			end

			-- Display class skill buttons
			
			local area1, area2, areaX, areaY = {}, {}, {}, {}
			local ancestral_charge = { cost = 25, name = "ancestral_charge", uiName = "Ancestral Charge", icon = 44 }
			local intensify_spell = { cost = 0, name = "intensify_spell", uiName = "Intensify Spell", icon = 50 }
			local sneak_attack = { cost = 15, name = "sneak_attack", uiName = "Sneak Attack", icon = 52 }
			local drinker = { cost = 0, name = "drinker", uiName = "Drown Your Sorrows", icon = 41 }
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
						if party:getWorldPositionY() > -0.6 and champion:isAlive() and champion:isReadyToAttack(0) and not champion:hasCondition("recharging") then
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
					local title = champion:getName() .. "'s " .. skill.uiName
					local txt_w = string.len(title) * 10
					context.color(0, 0, 0, 168)
					context.drawRect(MX - (txt_w / 2) - 6, MY - 60, string.len(title) * 10, 47)
					
					context.color(255, 255, 255, 255)
					context.drawText(title, MX - (txt_w / 2), MY - 42)
					context.drawText("Cost: " .. tostring(skill.cost) .. " Energy", MX - (txt_w / 2), MY - 20)
				end
			end

			local textIndex = 0
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				if functions.script.get_c("level_up_message_timer", champion:getOrdinal()) then
					local text = functions.script.get_c("level_up_message", champion:getOrdinal())
					textIndex = textIndex + 1
					local timer = 3 - (functions.script.get_c("level_up_message_timer", champion:getOrdinal()) or 0)
					timer = math.max(timer, 0)
					context.font("medium")
					context.color(255, 255, 255, 255 - (timer*85))
					context.drawText(text, (w - (w / 2)) - (context.getTextWidth(text) / 2), (f2 * h * 0.01) + (textIndex * 24))
				end	
			end
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				if functions.script.get_c("level_up_message_2_timer", champion:getOrdinal()) then
					local text = functions.script.get_c("level_up_message_2", champion:getOrdinal())
					textIndex = textIndex + 1
					local timer = 3 - (functions.script.get_c("level_up_message_2_timer", champion:getOrdinal()) or 0)
					timer = math.max(timer, 0)
					context.font("medium")
					context.color(255, 255, 255, 255 - (timer*85))
					context.drawText(text, (w - (w / 2)) - (context.getTextWidth(text) / 2), (f2 * h * 0.01) + (textIndex * 24))
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
				-- context.drawRect(w - 536, 267, 510, 312)
				local dummy1, dummy2 = context.button("dummy",w - 536, 267, 510, 312)

				if champion:getClass() == "assassin_class" then
					context.drawText("Assassinations: " .. functions.script.assassinations[champion:getOrdinal()], w - (530 * f2), 618 * f2)
				end

				if champion:getClass() == "stalker" then
					context.drawText("Invisibility Casts: " .. functions.script.night_stalker[champion:getOrdinal()], w - (530 * f2), 618 * f2)
				end

				local hover1, hover2 = {}, {}
				
				local txt = ""
				local x = 0
				local y = 0
				-- ATTRIBUTES
				x = 530
				y = 334
				context.drawText("Strength", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("strength")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[1], hover2[1] = context.button("hover"..1, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Dexterity", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("dexterity")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[2], hover2[2] = context.button("hover"..2, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Vitality", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("vitality")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[3], hover2[3] = context.button("hover"..3, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Willpower", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("willpower")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[4], hover2[4] = context.button("hover"..4, w - x - 6, y-18, 150, 23)

				-- MISC
				x = 530
				y = 452
				context.drawText("Hp Regen", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("health_regeneration_rate") - 100))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[5], hover2[5] = context.button("hover"..5, w - x - 6, y-18, 150, 23)
				
				y = y + 20
				context.drawText("En Regen", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getCurrentStat("energy_regeneration_rate") - 100))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[6], hover2[6] = context.button("hover"..6, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Action Speed", w - (x * f2), y * f2)
				txt = tostring(100 - math.floor(functions.script.getActionSpeed(champion) * 100))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[7], hover2[7] = context.button("hover"..7, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Block", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getBlockChance(champion) * 100))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[8], hover2[8] = context.button("hover"..8, w - x - 6, y-18, 150, 23)

				-- RESISTANCES
				x = 365
				y = 334
				context.drawText("Fire", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getResistance("fire")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[9], hover2[9] = context.button("hover"..9, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Shock", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getResistance("shock")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[10], hover2[10] = context.button("hover"..10, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Poison", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getResistance("poison")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[11], hover2[11] = context.button("hover"..11, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Cold", w - (x * f2), y * f2)
				txt = tostring(math.floor(champion:getResistance("cold")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[12], hover2[12] = context.button("hover"..12, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Disease", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getMiscResistance(champion, "disease")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[13], hover2[13] = context.button("hover"..13, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Bleeding", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getMiscResistance(champion, "bleeding")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[14], hover2[14] = context.button("hover"..14, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Poisoned", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getMiscResistance(champion, "poisoned")))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[15], hover2[15] = context.button("hover"..15, w - x - 6, y-18, 150, 23)

				-- WOUND RESISTS
				x = 365
				y = 334+175
				local wound_res = functions.script.getWoundResistance(champion)
				context.drawText("Head", w - (x * f2), y * f2)
				txt = tostring(math.floor(wound_res[1]))
				context.drawText("" .. txt, w - ((x-69) * f2) - context.getTextWidth(txt), y * f2)
				context.drawText("Chest", w - (x * f2), (y + 16) * f2)
				txt = tostring(math.floor(wound_res[2]))
				context.drawText("" .. txt, w - ((x-69) * f2) - context.getTextWidth(txt), (y + 16) * f2)
				context.drawText("Legs", w - (x * f2), (y + 32) * f2)
				txt = tostring(math.floor(wound_res[3]))
				context.drawText("" .. txt, w - ((x-69) * f2) - context.getTextWidth(txt), (y + 32) * f2)
				
				x = 296-4
				y = 334+175
				context.drawText("Feet", w - (x * f2), y * f2)
				txt = tostring(math.floor(wound_res[4]))
				context.drawText("" .. txt, w - ((x-69) * f2) - context.getTextWidth(txt), y * f2)
				context.drawText("L.Hand", w - (x * f2), (y + 16) * f2)
				txt = tostring(math.floor(wound_res[5]))
				context.drawText("" .. txt, w - ((x-69) * f2) - context.getTextWidth(txt), (y + 16) * f2)
				context.drawText("R.Hand", w - (x * f2), (y + 32) * f2)
				txt = tostring(math.floor(wound_res[6]))
				context.drawText("" .. txt, w - ((x-69) * f2) - context.getTextWidth(txt), (y + 32) * f2)

				-- MULTIPLIERS
				x = 198
				y = 334
				context.drawText("Spells", w - (x * f2), (y + 0) * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "spell", 100, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), (y + 0) * f2)
				hover1[16], hover2[16] = context.button("hover"..16, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Ele", w - (x * f2), y * f2)
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

				hover1[17], hover2[17] = context.button("hover"..17, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Poison", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerElement(champion, "poison", 100, true, 0, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[18], hover2[18] = context.button("hover"..18, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Neutral", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerElement(champion, "neutral", 100, true, 0, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[19], hover2[19] = context.button("hover"..19, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Physical", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerElement(champion, "physical", 100, true, 0, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y* f2)
				hover1[20], hover2[20] = context.button("hover"..20, w - x - 6, y-18, 150, 23)
				

				y = y + 24
				context.drawText("Melee", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "melee", 100, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[21], hover2[21] = context.button("hover"..21, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("L.Weapons", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "light_weapons", 100, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[22], hover2[22] = context.button("hover"..22, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("H.Weapons", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "heavy_weapons", 100, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[23], hover2[23] = context.button("hover"..23, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Ranged", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "ranged", 100, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[24], hover2[24] = context.button("hover"..24, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Firearms", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "firearms", 100, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[25], hover2[25] = context.button("hover"..25, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Dual Wield", w - (x * f2), y * f2)
				txt = tostring(math.floor( functions.script.empowerAttackType(champion, "dual_wielding", 100, true) - 100 ))
				context.drawText("" .. txt, w - ((x-138) * f2) - context.getTextWidth(txt), y * f2)
				hover1[26], hover2[26] = context.button("hover"..26, w - x - 6, y-18, 150, 23)


				-- Left Hand
				x = 530
				y = 592
				context.drawText("Dmg", w - (x * f2), y * f2)
				local dmg = functions.script.getDamage(champion, ItemSlot.Weapon)
				txt = tostring(math.floor(dmg[0])) .. " - " .. tostring(math.floor(dmg[1]))
				context.drawText("" .. txt , w - ((x-116) * f2) - context.getTextWidth(txt), y * f2)
				hover1[33], hover2[33] = context.button("hover"..33, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Acc", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getAccuracy(champion, ItemSlot.Weapon) * 1))
				context.drawText("" .. txt, w - ((x-116) * f2) - context.getTextWidth(txt), y * f2)
				hover1[34], hover2[34] = context.button("hover"..34, w - x - 6, y-18, 150, 23)

				x = x-128
				y = 592
				context.drawText("Crit", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getCrit(champion, ItemSlot.Weapon) * 1)) .. "%"
				context.drawText("" .. txt, w - ((x-88) * f2) - context.getTextWidth(txt), y * f2)
				hover1[35], hover2[35] = context.button("hover"..35, w - x - 6, y-18, 100, 23)

				y = y + 20
				context.drawText("Pierce", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getPierce(champion, ItemSlot.Weapon) * 1))
				context.drawText("" .. txt, w - ((x-88) * f2) - context.getTextWidth(txt), y * f2)
				hover1[36], hover2[36] = context.button("hover"..36, w - x - 6, y-18, 100, 23)

				-- Right Hand
				x = 276
				y = 592
				context.drawText("Dmg", w - (x * f2), y * f2)
				local dmg = functions.script.getDamage(champion, ItemSlot.OffHand)
				txt = tostring(math.floor(dmg[0])) .. " - " .. tostring(math.floor(dmg[1]))
				context.drawText("" .. txt , w - ((x-116) * f2) - context.getTextWidth(txt), y * f2)
				hover1[37], hover2[37] = context.button("hover"..37, w - x - 6, y-18, 150, 23)

				y = y + 20
				context.drawText("Acc", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getAccuracy(champion, ItemSlot.OffHand) * 1))
				context.drawText("" .. txt, w - ((x-116) * f2) - context.getTextWidth(txt), y * f2)
				hover1[38], hover2[38] = context.button("hover"..38, w - x - 6, y-18, 150, 23)

				x = x-128
				y = 592
				context.drawText("Crit", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getCrit(champion, ItemSlot.OffHand) * 1)) .. "%"
				context.drawText("" .. txt, w - ((x-88) * f2) - context.getTextWidth(txt), y * f2)
				hover1[39], hover2[39] = context.button("hover"..39, w - x - 6, y-18, 100, 23)

				y = y + 20
				context.drawText("Pierce", w - (x * f2), y * f2)
				txt = tostring(math.floor(functions.script.getPierce(champion, ItemSlot.OffHand) * 1))
				context.drawText("" .. txt, w - ((x-88) * f2) - context.getTextWidth(txt), y * f2)
				hover1[40], hover2[40] = context.button("hover"..40, w - x - 6, y-18, 100, 23)
				-- local dummy3, dummy4 = context.button("dummy",w - 536, 267, 510, 312)
				-- hover1[1], hover2[1] = context.button("hover"..1, w - x, y-20, 100, 21)
				for h = 1, 40 do
					local hoverTxt1 = ""
					local hoverTxt2 = ""
					if hover2[h] then
						if h == 1 then
							hoverTxt1 = "Strength"
							hoverTxt2 = "Strength increases your carrying capacity, fire\nresistance and damage you deal with most\nmelee and throwing weapons."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 2 then
							hoverTxt1 = "Dexterity"
							hoverTxt2 = "Dexterity affects your Accuracy, Evasion,\nshock resistance and damage you deal with\nmany missile weapons."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 3 then
							hoverTxt1 = "Vitality"
							hoverTxt2 = "Vitality affects the amount of Health\npoints you have and your health regeneration\nrate. Vitality also increases your poison\nresistance."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 4)
						elseif h == 4 then
							hoverTxt1 = "Willpower"
							hoverTxt2 = "Willpower affects the amount of Energy\npoints you have and your energy regeneration\nrate. Willpower also increases your cold\nresistance."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 4)
						elseif h == 5 then
							hoverTxt1 = "Health Regeneration Rate"
							hoverTxt2 = "Affects how quickly you regain health over\ntime. By default you gain 1 HP every 5 seconds,\nand this number increases that by a\npercentage."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 4)
						elseif h == 6 then
							hoverTxt1 = "Energy Regeneration Rate"
							hoverTxt2 = "Affects how quickly you regain energy over\ntime. By default you gain 1 HP every 5 seconds,\nand this number increases that by a\npercentage."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 4)
						elseif h == 7 then
							hoverTxt1 = "Action Speed"
							hoverTxt2 = "Your Action Speed is how fast you recover\nafter attaking or using a spell."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 8 then
							hoverTxt1 = "Block Chance"
							hoverTxt2 = "Your chance to block an attack when\nholding a shield. Blocking reduces the damage\ntaken by half."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 9 then
							hoverTxt1 = "Fire Resistance"
							hoverTxt2 = "Resist Fire reduces the damage you take from\nfire, steam and heat based attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 10 then
							hoverTxt1 = "Shock Resistance"
							hoverTxt2 = "Resist Shock reduces damage you take from\nlightning and electrical attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 11 then
							hoverTxt1 = "Poison Resistance"
							hoverTxt2 = "Resist Poison reduces the damage you take\nfrom poisonous attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 12 then
							hoverTxt1 = "Cold Resistance"
							hoverTxt2 = "Resist Cold reduces the damage you take from\nicy and cold attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 13 then
							hoverTxt1 = "Disease Resistance"
							hoverTxt2 = "Affects how likely you are to get infected with\ndisease. While diseased you don't recover\nhealth."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 14 then
							hoverTxt1 = "Bleeding Resistance"
							hoverTxt2 = "Affects how likely you are to start bleeding\nwhen attacked. While bleeding you take a lot\nof damage if you try to move."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 15 then
							hoverTxt1 = "Poisoning Resistance"
							hoverTxt2 = "Affects how likely you are to get poisoned.\nWhile poisoned you take damage over time."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 16 then
							hoverTxt1 = "Spell Multi"
							hoverTxt2 = "Increases the damage you deal with all spells."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 1)
						elseif h == 17 then
							hoverTxt1 = "Elemental Multi"
							hoverTxt2 = "The multipliers for Fire, Shock and Cold.\nIncreases the damage you deal with elemental\nattacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 18 then
							hoverTxt1 = "Poison Multi"
							hoverTxt2 = "Increases the damage you deal with poison\nattacks, but not the \"poisoned\" condition."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 19 then
							hoverTxt1 = "Neutral Multi"
							hoverTxt2 = "Increases the damage you deal with neutral\nspells."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 20 then
							hoverTxt1 = "Physical Multi"
							hoverTxt2 = "Increases the damage you deal with physical\nattacks and spells. Affects all weapon\ntypes."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 21 then
							hoverTxt1 = "Melee Multi"
							hoverTxt2 = "Increases the damage you deal with melee\nattacks. Does not affect unnarmed or bear\nform attacks."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 22 then
							hoverTxt1 = "Light Weapons Multi"
							hoverTxt2 = "Increases the damage you deal with light\nweapons."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 23 then
							hoverTxt1 = "Heavy Weapons Multi"
							hoverTxt2 = "Increases the damage you deal with heavy\nweapons."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 24 then
							hoverTxt1 = "Ranged Weapons Multi"
							hoverTxt2 = "Increases the damage you deal with missile\nand throwing weapons."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 25 then
							hoverTxt1 = "Firearms Weapons Multi"
							hoverTxt2 = "Increases the damage you deal with firearms."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 1)
						elseif h == 26 then
							hoverTxt1 = "Dual Wielding Multi"
							hoverTxt2 = "Increases the damage you deal while dual\nwielding weapons, which by default is -40%."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 33 or h == 37 then
							hoverTxt1 = "Damage"
							hoverTxt2 = "The range of physical damage you deal with\nattacks. It's affected by your stats, items, skills\nand the Physical multiplier."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 3)
						elseif h == 34 or h == 38 then
							hoverTxt1 = "Accuracy"
							hoverTxt2 = "The higher your accuracy, the better chance\nyou have of hitting a target. Each point of\naccuracy translates to 1% chance of hitting a\ntarget with no evasion."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 4)
						elseif h == 35 or h == 39 then
							hoverTxt1 = "Critical Chance"
							hoverTxt2 = "Percentile chance of scoring a critical strike\nwith a weapon."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
						elseif h == 36 or h == 40 then
							hoverTxt1 = "Piercing"
							hoverTxt2 = "The amount of a target's protection you can\npierce with your weapon."
							functions.script.statToolTip(context, hoverTxt1, hoverTxt2, MX - (370 / 2), MY - 24, 2)
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
				local skill1_p = { 2,4,5 } -- athletics
				local skill2_p = { 2,4,5 } -- block
				local skill3_p = { 2,4,5 } -- light armor
				local skill4_p = { 2,4,5 } -- heavy armor
				local skill5_p = { 1,4,5 } -- accuracy
				local skill6_p = { 2,4,5 } -- critical
				local skill7_p = { 3,4,5 } -- firearms
				local skill8_p = { 2,4,5 } -- seafaring
				local skill9_p = { 1,4,5 } -- alchemy
				local skill10_p = { 2,4,5 } -- ranged weapons
				local skill11_p = { 3,4,5 } -- light weapons
				local skill12_p = { 3,4,5 } -- heavy weapons
				local skill13_p = { 1,2,4,5 } -- spellblade
				local skill14_p = { 2,4,5 } -- elemental
				local skill15_p = { 2,4,5 } -- poison
				local skill16_p = { 3,4,5 } -- concentration
				local skill17_p = { 1,4,5 } -- witchcraft
				local skill18_p = { 2,4,5 } -- tinkering
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
						context.drawImage2("mod_assets/textures/gui/skill_description.dds", w - (1240 * f2), MY - 110, ((j-1)%4)*569, math.floor((j-1)/4)*337, 569, 337, 569*f3, 337*f3)
						-- Draw icon
						context.drawImage2("mod_assets/textures/gui/skills.dds", w - (1228*f2), MY - 110 + 16, ((j-1)%13)*75, math.floor((j-1)/13)*75, 75, 75, 75*f3, 75*f3)
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
			-- Assassin's gets 'assassination' on level up
			if champion:getClass() == "assassin_class" then
				if not champion:hasTrait("assassination") then
					champion:addTrait("assassination")
				end
			end

			if champion:getClass() == "tinkerer" then
				local count = functions.script.get_c("crafting_expertise", champion:getOrdinal())
				functions.script.set_c("crafting_expertise", champion:getOrdinal(), count ~= nil and math.min(count + 1, 3) or 1)
				if count ~= nil and count < 3 then
					hudPrint(champion:getName() .. ", the Tinkerer gained one charge of Crafting Expertise.")
				end
			end

			if champion:getClass() == "berserker" and (champion:getLevel()-1) % 3 == 0 then
				functions.script.set_c("level_up_message", champion:getOrdinal(), champion:getName() .. " gained +6 Protection and +1 Strenght to Berserker Frenzy.")
				functions.script.set_c("level_up_message_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "monk" and (champion:getLevel()-1) % 4 == 0 then
				functions.script.set_c("level_up_message", champion:getOrdinal(), champion:getName() .. " gained +3 seconds duration to Healing Aura and +30 seconds to Holy Light.")
				functions.script.set_c("level_up_message_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "hunter" then
				functions.script.set_c("level_up_message", champion:getOrdinal(), champion:getName() .. " gained +1 second duration to Thrill of the Hunt.")
				functions.script.set_c("level_up_message_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "elementalist" and (champion:getLevel()-1) % 3 == 0 then
				functions.script.set_c("level_up_message", champion:getOrdinal(), champion:getName() .. " gained +3 seconds duration to Trine Aegis.")
				functions.script.set_c("level_up_message_timer", champion:getOrdinal(), 8)
			end

			if champion:getClass() == "stalker" and (champion:getLevel()-1) % 3 == 0 then
				functions.script.set_c("level_up_message", champion:getOrdinal(), champion:getName() .. " gained +4 seconds duration to Night Stalker.")
				functions.script.set_c("level_up_message_timer", champion:getOrdinal(), 8)
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
					functions.script.bleed(monster, "dot")
				end
			end

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

			for entity in Dungeon.getMap(party.level):allEntities() do
				if entity.monster then
					local monster = entity.monster
					if monster and monster.go.poisoned and monster:isAlive() then
						functions.script.hitMonster(monster.go.id, math.random(monster:getHealth() * 0.005, monster:getHealth() * 0.01), "009900", nil, "poison", 1)
						if monster.go.poisoned:getCausedByChampion() then
							local champion = party.party:getChampionByOrdinal(monster.go.poisoned:getCausedByChampion())
							if champion:hasTrait("venomancer") and math.random() <= 0.45 then
								champion:regainHealth(math.random(1,5))
							end
						end
						-- Plague spread
						if monster.go.poisoned:getCausedByChampion() and math.random() <= 0.33 then
							local champion = party.party:getChampionByOrdinal(monster.go.poisoned:getCausedByChampion())
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
											value:setCondition("poisoned", math.random(10,20))
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
			-- print ("A day has passed.")
			-- for i=1,4 do
				-- local champion = party.party:getChampionByOrdinal(i)
				-- if champion:getClass() == "stalker" then
					-- local bonus = math.floor(champion:getLevel() / 3)
					-- functions.script.night_stalker[i] = 1 + bonus
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
			functions2.script.updateSky(t)

			functions.script.keypressDelaySet(math.max(functions.script.keypressDelayGet() - 1, 0))
			
			if party.party:isCarrying("enchanted_timepiece") or (getMouseItem() and getMouseItem().go.name == "enchanted_timepiece") then
				local timepiece = functions.script.getTimepiece()
				for entity in Dungeon.getMap(party.level):entitiesAt(party.x, party.y) do
					if timepiece then
						if entity.name == "crystal_area_inside" and entity.elevation == party.elevation then
							if functions2.script.timeTravelTimer == 0 then
								timepiece.go.item:setGfxIndex(26) -- charged
							else
								timepiece.go.item:setGfxIndex(39 - functions2.script.timeTravelTimer)
							end
							break
						else
							if functions2.script.timeTravelTimer == 0 then
								timepiece.go.item:setGfxIndex(13) -- empty
							else
								timepiece.go.item:setGfxIndex(26 - functions2.script.timeTravelTimer)
							end
						end
					end
				end
			end
			
			for entity in Dungeon.getMap(party.level):allEntities() do
				if entity.monster then
					local monster = entity.monster
					if monster and monster:hasTrait("bleeding") then
						local wave = math.abs(math.sin(self.go.gametime2:getValue() * 0.05))
						monster.go.model:setEmissiveColor(vec(0.05,-.02,-.02) * wave)
					end
				end
			end
			
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				functions.script.checkWeights(i)
				if party:getWorldPositionY() > -0.6 and champion:isReadyToAttack(1) then
					functions.script.set_c("attackedWith", i, nil)
					functions.script.set_c("attacked", i, nil)
				end
				
				functions.script.set_c("wide_vision", i, nil)
				functions.script.set_c("sea_faring", i, nil)
				functions.script.set_c("duelist", i, nil)
				
				if champion:hasTrait("wide_vision") or champion:getSkillLevel("sea_faring") > 0 or champion:getClass() == "corsair" then
					local monsterCount = 0
					for d=1,4 do
						local dir = (party.facing + d) % 4
						local dx,dy = getForward(dir)
						for e in Dungeon.getMap(party.level):entitiesAt(party.x + dx, party.y + dy) do
							if e.monster then
								monsterCount = monsterCount + 1
							end
						end
					end
					--print(monsterCount)
					if monsterCount then
						if champion:hasTrait("wide_vision") then
							functions.script.set_c("wide_vision", i, monsterCount)
						end
						if champion:getSkillLevel("sea_faring") > 0 then
							functions.script.set_c("sea_faring", i, monsterCount)
						end
						if champion:getClass() == "corsair" then
							functions.script.set_c("duelist", i, monsterCount)
						end
					end
				end
				
				--if champion:getClass() == "druid" then
					local poisonedMonster = nil
					local dir = party.facing
					local dx,dy = getForward(dir)
					for e in Dungeon.getMap(party.level):entitiesAt(party.x + dx, party.y + dy) do
						if e.monster and e.monster.go.poisoned then
							poisonedMonster = e.id
						end
					end
					functions.script.set_c("poisonedMonster", i, poisonedMonster)
				--end
				
				if party:getWorldPositionY() > -0.6 and champion:hasTrait("sneak_attack") and (champion:isReadyToAttack(0) or champion:isReadyToAttack(1)) and functions.script.get_c("sneak_attack", champion:getOrdinal()) then
					functions.script.set_c("sneak_attack", champion:getOrdinal(), nil)
				end
				
				if champion:hasTrait("drinker") and champion:hasCondition("drown_sorrows_exp") then
					local resetTimer = functions.script.get_c("drown_sorrows_exp", champion:getOrdinal())
					if resetTimer ~= nil and GameMode.getTimeOfDay() < resetTimer and GameMode.getTimeOfDay() >= resetTimer - 0.002 then
						champion:removeCondition("drown_sorrows_exp")
						functions.script.set_c("drown_sorrows_exp", champion:getOrdinal(), nil)
						hudPrint(champion:getName().. " drinking EXP Penalty was removed.")
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

				if functions.script.get_c("level_up_message_timer", champion:getOrdinal()) then
					local timer = functions.script.get_c("level_up_message_timer", champion:getOrdinal())
					if timer > 0 then
						functions.script.set_c("level_up_message_timer", champion:getOrdinal(), timer - 0.02)
					else
						functions.script.set_c("level_up_message_timer", champion:getOrdinal(), nil)
					end
				end

				if functions.script.get_c("level_up_message_2_timer", champion:getOrdinal()) then
					local timer = functions.script.get_c("level_up_message_2_timer", champion:getOrdinal())
					if timer > 0 then
						functions.script.set_c("level_up_message_2_timer", champion:getOrdinal(), timer - 0.02)
					else
						functions.script.set_c("level_up_message_2_timer", champion:getOrdinal(), nil)
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
			if functions2.script.timeTravelTimer > 0 then
				local has_area = false
				for entity in Dungeon.getMap(party.level):entitiesAt(party.x, party.y) do
					if (entity.name == "crystal_area_inside" or entity.name == "crystal_area") then
						has_area = true
						break
					end
				end
				if not  has_area then
					functions2.script.updateTimeTravelTimer(-1)
				end
			end
				
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
			end
			
			functions:setPosition(0, 0, 0, 0, party.level)
			functions2:setPosition(1, 0, 0, 0, party.level)
			spells_functions:setPosition(2, 0, 0, 0, party.level)
		end
	},
	{
		class = "Counter",
		name = "hours",
	},	
	{
		class = "Timer",
		name = "partyhours",
		timerInterval = 1.0, -- will be 8.33 for hours
		triggerOnStart = true,
		onActivate = function(self)
			self.go.hours:increment()
			local v = self.go.hours:getValue()
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				for j=1,32 do
					local item = champion:getItem(j)
					if item and item:hasTrait("magic_gem") and item.go.data:get("charges") then
						local icon = item.go.data:get("icon")
						if icon == nil then return end
						item.go.data:set("charges", math.min(item.go.data:get("charges") + 1, 24))						
						if item.go.data:get("charges") == 23 then
							item.go.item:setGfxIndex(icon + 1)
						elseif item.go.data:get("charges") == 24 then
							item.go.item:setGfxIndex(icon)
						end
					end
				end
			end
			--return hudPrint("Time = "..v.."")
		end
	},
	},
}