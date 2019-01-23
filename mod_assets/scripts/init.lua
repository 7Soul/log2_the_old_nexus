-- objects patch for detect spells
import "mod_assets/spells_pack/defineObject.lua"
-- import standard assets
import "mod_assets/scripts/mod_standard_assets.lua"
import "mod_assets/scripts/objects/generic.lua"
import "mod_assets/scripts/objects/beach.lua"
import "mod_assets/scripts/objects/forest.lua"
import "mod_assets/scripts/objects/mine.lua"
import "mod_assets/scripts/objects/stone_philosophers.lua"
import "mod_assets/scripts/objects/sky.lua"
-- import the spells pack
import "mod_assets/spells_pack/init.lua"   -- the spells pack
import "mod_assets/scripts/spells/psionic_arrow.lua"
import "mod_assets/scripts/spells/bite.lua"
-- import custom assets
import "mod_assets/scripts/objects/base.lua"
import "mod_assets/scripts/defineObject.lua"
import "mod_assets/scripts/functions.lua"
import "mod_assets/scripts/level_start.lua"
import "mod_assets/scripts/beach.lua"
import "mod_assets/scripts/monsters.lua"
import "mod_assets/scripts/objects.lua"
import "mod_assets/scripts/tiles.lua"
import "mod_assets/scripts/recipes.lua"
import "mod_assets/scripts/spells.lua"
import "mod_assets/scripts/sounds.lua"
import "mod_assets/scripts/skills.lua"
import "mod_assets/scripts/traits.lua"
import "mod_assets/scripts/conditions.lua"
-- Monsters
import "mod_assets/scripts/monsters/turtle.lua"
import "mod_assets/scripts/monsters/sand_warg.lua"
import "mod_assets/scripts/monsters/twigroot.lua"
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
-- Other
import "mod_assets/scripts/particles/blooddrop.lua"
import "mod_assets/scripts/particles/soundGate.lua"

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
			for i=1,4 do
				local champion = party:getChampionByOrdinal(i)
				local insertHerb = nil
				if champion:getSkillLevel("alchemy") > 0 then
					local herb_items = {["blooddrop_cap"] = 450, ["etherweed"] = 930, ["mudwort"] = 1950, ["falconskyre"] = 2500, ["blackmoss"] = 3700, ["crystal_flower"] = 4500}
					for herb,count in pairs(herb_items) do
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
				for slot=1,32 do
					local item = champion:getItem(slot)
					if item and item:hasTrait("magic_gem") and item.go.data:get("charges") then
						if item.go.data:get("burnout") == nil then item.go.data:set("burnout", 0) end
						item.go.data:set("burnout", math.min(item.go.data:get("burnout") + 1, 4500))
						if item.go.data:get("burnout") == 4500 then
							champion:removeItem(item)
							champion:insertItem(slot, spawn("coal").item)
						end
					end
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
			-- if champion:getClass() == "hunter" then
				-- if action.go.item:hasTrait("missile_weapon") or action.go.name == "crossbow" then
					-- functions.script.hunter_timer[champion:getOrdinal()] = 3
				-- end
			-- end
			-- return spells_functions.script.onAttack(champion, action, slot)
		end,
		-----------------------------------------------------------
		-- On Damage Taken
		-----------------------------------------------------------
		onDamage = function(party, champion, damage, damageType)
			print(party.go.id, champion:getName(), 'received', damage, 'damage,', damageType, 'type') 
			
			for i=1,4 do
				if party:getChampion(i):getClass() == "fighter" and party:getChampion(i):isAlive() and not party:getChampion(i):hasCondition("berserker_revenge") then
					party:getChampion(i):setConditionValue("berserker_rage", 20)
				end
			end
			
			if champion:isAlive() and champion:hasTrait("etherweed") then
				if damageType == "cold" then
					champion:setEnergy(champion:getEnergy() + ((champion:getMaxEnergy() - champion:getEnergy()) * 0.5))
					playSound("heal_party")
				end
			end
			
			if champion:isAlive() and champion:hasTrait("blooddrop_cap") then
				if damageType == "fire" then
					champion:setCondition("blooddrop_rage")
					champion:addTrait("blooddrop_rage")
					playSound("heal_party")
				end
			end
			
			if champion:hasTrait("brutalizer") and damageType ~= "brutalizer" then
				local str = champion:getCurrentStat("strength")
				champion:damage(damage * str * 0.01, "brutalizer")
			end
		end,
		
		-- WORKS
		onProjectileHit = function(party,champion,projectile,damage,damageType)
			print(party.go.id,champion:getName(),'is hit by a', projectile.go.name, damage, damageType) 
		end,
		
		-- WORKS
		onDie = function(party,champion) 
			print(party.go.id,champion:getName(),'died') 
			for i=1,4 do
				if party:getChampion(i):getClass() == "fighter" and party:getChampion(i):isAlive() then
					party:getChampion(i):setConditionValue("berserker_revenge", 20)
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
				if party:getChampionByOrdinal(i):getClass() == "stalker" then
					local night_stalker_charges = functions.script.night_stalker[i]
					print(party.go.partycounter:getValue())
					if night_stalker_charges > 0 then
						print(functions.script.night_stalker[i])
						local bonus = math.min(party:getChampion(i):getLevel() * 2, 22)
						spells_functions.script.addConditionValue("invisibility", 8 + bonus)
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
				local item = champion:getItem(slot)
				if item then
					if champion:getClass() == "tinkerer" then
						if getMouseItem()  and getMouseItem().go.name == "lock_pick" and button == 2 and item:hasTrait("upgradable") then
							functions.script.tinkererUpgrade(self, champion, container, slot, button)
						end
						
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
								
						if button == 5 and dismantle == 9 then
							if slot >= 13 and slot <= 32 then
								local posx = 553 - (((slot-1) % 4) * 63)
								local posy = (297 + ((math.floor((slot-13) / 4)) * 63))
								functions.script.tinkererDismantle(true, posx, posy, slot, champion:getOrdinal())
							end
						end
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

			if champion:getClass() == "tinkerer" then
				if Editor.isRunning() and context.keyDown("T") then 
					functions.script.tinkering_level[champion:getOrdinal()] = functions.script.tinkering_level[champion:getOrdinal()] + 1
				end
				-- Draw "dismantle" icon on items
				local posx, posy = 0, 0
				for i=13,ItemSlot.BackpackLast do
					local item = champion:getItem(i)
					if item then
						if item.go.containeritem then 
							local container = item.go.containeritem 
						end
						
						if champion:getItem(i) and champion:getItem(i):hasTrait("dismantle") then
						posx = (i-1) % 4
						posy = math.floor((i-13) / 4)
						context.drawImage2("mod_assets/textures/gui/dismantle.dds", w - ((553 + 0 - (posx * 63)) * f2), (297 - 0 + (posy * 63)) * f2, 0, 0, 75, 75, 20 * f2, 20 * f2)
						end
					end
				end	
				
				-- Show tinkering level and upgradable icon while lockpick is in hand
				if getMouseItem() and getMouseItem().go.name == "lock_pick" then
					local posx, posy = 0, 0
					for i=13,ItemSlot.BackpackLast do
						if champion:getItem(i) and champion:getItem(i):hasTrait("upgradable") then
						posx = (i-1) % 4
						posy = math.floor((i-13) / 4)
						context.drawImage2("mod_assets/textures/gui/upgradable.dds", w - ((553 - (posx * 63)) * f2), (297 + (posy * 63)) * f2, 0, 0, 64, 64, 55 * f2, 55 * f2)
						end
					end
					local text = "Tinkering Level = ".. math.min((math.floor(functions.script.tinkering_level[champion:getOrdinal()] / 3) + 1), 10)
					context.drawText(text, MX - (context.getTextWidth(text) / 2), MY + 30)					
				end
				
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
			
			if champion:getClass() == "fighter" then
				if getMouseItem() and getMouseItem().go:getComponent("equipmentitem") then
					local item = getMouseItem().go
					local i = nil
					if item.item:hasTrait("helmet") then
						i = 0
					elseif item.item:hasTrait("chest_armor") then
						i = 1
					elseif item.item:hasTrait("leg_armor") then
						i = 2
					elseif item.item:hasTrait("boots") then
						i = 3
					elseif item.item:hasTrait("gloves") then
						i = 4
					end
					if i ~= nil then
						if i < 4 then
							context.drawImage2("mod_assets/textures/gui/berserker_equip_block.dds", w - (208 * f2), (78 * f2 * i) + 293 * f2, 0, 0, 64, 64, 80 * f2, 80 * f2)
						else
							context.drawImage2("mod_assets/textures/gui/berserker_equip_block.dds", w - (300 * f2), 526 * f2, 0, 0, 64, 64, 80 * f2, 80 * f2)
						end
					end
				end
			end
		end, 
		
		onDrawAttackPanel = function(self, champion, context, x, y)
			local w, h, r = context.width, 		context.height, 	context.width / context.height
			local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
			local MX, MY = context.mouseX, context.mouseY
			if f > 0.9 then
				context.font("large")
			elseif f > 0.5 then
				context.font("medium")
			elseif f > 0.2 then
				context.font("small")
			elseif f < 0.2 then
				context.font("tiny")
			end
			if champion:getClass() == "monk" and champion:hasCondition("healing_light") then
				context.drawImage2("mod_assets/textures/gui/healing_light.dds", x-22, y-70, 0, 0, 64, 64, 68, 68)
			end
			if champion:getClass() == "hunter" then
				if functions.script.hunter_crit[champion:getOrdinal()] > 0 then
					context.font("small")
					local x2 = 0
					local posx = 0
					local posy = 0
					context.color(225, 225, 195, 255)
					if champion:getItem(ItemSlot.Weapon) and champion:getItem(ItemSlot.Weapon):hasTrait("missile_weapon") then
						x2 = 0
						posx = (x + 18) + (x2 * 80)
						posy = y + 28
						context.drawText("" .. functions.script.hunter_crit[champion:getOrdinal()], posx, posy)
						context.drawImage2("mod_assets/textures/gui/bar.dds", posx-6, posy+2, 0, 0, 64, 64, champion:getConditionValue("hunter_crit") / functions.script.hunter_max[champion:getOrdinal()] * 24, 3)
					elseif champion:getItem(ItemSlot.OffHand) and champion:getItem(ItemSlot.OffHand):hasTrait("missile_weapon") then
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
		end,
		
		onDrawStats = function(self, context, champion)	
			local w, h, r = context.width, 		context.height, 	context.width / context.height
			local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
			local f2 = (context.height/1080)
			local MX, MY = context.mouseX, context.mouseY
			local mLeft, mRight = context.mouseDown(0), context.mouseDown(2)
			
			if f2 > 0.8 then
				context.font("medium")
			elseif f2 > 0.7 then
				context.font("medium")
			elseif f2 > 0.6 then
				context.font("small")
			elseif f2 < 0.5 then
				context.font("tiny")
			end
			if champion:getClass() == "assassin" then
				context.drawText("Assassinations: " .. functions.script.assassinations[champion:getOrdinal()], w - (530 * f2), 618 * f2)
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
			context.drawImage2("mod_assets/textures/gui/skills_bg.dds", w - (548 * f2), 307 * f2, 0, 0, 510, 261, 510*f2, 261*f2)
			local dummy1, dummy2 = context.button("dummy",w - (556), 307, 510, 261)
			-- Variables
			local skill_x, skill_y = 0, 0
			local val1, val2, valX, valY = {}, {}, {}, {}
			local skill1_p = { 2,4,5 } -- athletics
			local skill2_p = { 2,4,5 } -- block
			local skill3_p = { 2,4,5 } -- light armor
			local skill4_p = { 2,4,5 } -- heavy armor
			local skill5_p = { 2,5 } -- accuracy
			local skill6_p = { 3,4,5 } -- critical
			local skill7_p = { 2,4,5 } -- firearms
			local skill8_p = { 5 } -- throwing
			local skill9_p = { 1,4,5 } -- alchemy
			local skill10_p = { 2,4,5 } -- ranged weapons
			local skill11_p = { 3,5 } -- light weapons
			local skill12_p = { 3,5 } -- heavy weapons
			local skill13_p = { 2,5 } -- spellblade
			local skill14_p = { 4,5 } -- elemental
			local skill15_p = { 2,5 } -- poison
			local skill16_p = { 3,5 } -- concentration
			local skill_perks = { skill1_p, skill2_p, skill3_p, skill4_p, skill5_p, skill6_p, skill7_p, skill8_p, skill9_p, skill10_p, skill11_p, skill12_p, skill13_p, skill14_p, skill15_p, skill16_p }
			-- Draw skills tabs
			for i=1,16 do
				skill_x = math.floor((i-1) / 8)
				skill_y = (i-1) % 8
				context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((369 - (skill_x * 252)) * f2), (316 + (skill_y * 31)) * f2, 1, 1, 70, 21, 70*f2, 21*f2)
				val1[i], val2[i] = context.button("skill_info"..i, w - (548 - (skill_x * 252)), 310 + (skill_y * 31), 252, 31)
				valX[i] = 369 - (skill_x * 252)
				valY[i] = 316 + (skill_y * 31)
			end
			-- Draw skills tabs (hover)
			for i=1,16 do	
				if val2[i] then
					context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((valX[i] + 1) * f2), (valY[i] - 1) * f2, 0, 23, 72, 23, 72*f2, 23*f2)
					break
				end
			end
			-- Draw skill pegs
			for i=1,16 do				
				skill_x = math.floor((i-1) / 8)
				skill_y = (i-1) % 8
				local xpositions = {0,0,0,5,10}
				local tickX = 0				
				-- Draw green pegs
				local skillLevel = champion:getSkillLevel(functions.script.skillNames[i])
				local tempLevel = skillLevel + functions.script.partySkillTemp[champion:getOrdinal()][i]
				if skillLevel < 5 then					
					if tempLevel > 0 and skillLevel < 5 then
						for j=skillLevel+1,tempLevel do
							tickX = ((j-1) * 11) + xpositions[j]
							context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((366 - (skill_x * 252) - tickX) * f2), (319 + (skill_y * 31)) * f2, 10, 46, 10, 15, 10*f2, 15*f2)
						end
					end	
				end
				
				-- Draw yellow pegs
				local skillLevel = champion:getSkillLevel(functions.script.skillNames[i])
				if skillLevel > 0 then
					for j=1,skillLevel do
						tickX = ((j-1) * 11) + xpositions[j]
						context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((366 - (skill_x * 252) - tickX) * f2), (319 + (skill_y * 31)) * f2, 0, 46, 10, 15, 10*f2, 15*f2)
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
						context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((363 - (skill_x * 252) - tickX) * f2), (324 + (skill_y * 31)) * f2, 72, got, 4, 5, 4*f2, 5*f2)
					elseif skill_perks[i][j] == 4 then
						context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((364 - (skill_x * 252) - tickX) * f2), (323 + (skill_y * 31)) * f2, 76, got, 6, 6, 6*f2, 6*f2)
					else
						context.drawImage2("mod_assets/textures/gui/skill_slots.dds", w - ((364 - (skill_x * 252) - tickX) * f2), (323 + (skill_y * 31)) * f2, 82, got, 6, 7, 6*f2, 7*f2)
					end
				end				
			end
			-- Draw confirm and clear buttons
			local confirm1, confirm2 = context.button("confirm", w - (270), 584, 108, 32)
			local clear1, clear2 = context.button("clear", w - (270-125), 584, 108, 32)
			for i=1,16 do
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
			for j=1,16 do
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
					local yAdd = 0
					if MY > 358 then yAdd = -368 else yAdd = 32	end
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
				champion:removeTrait("fireburst_memo")
				champion:removeTrait("frost_burst_memo")
				champion:removeTrait("shock_memo")
				champion:removeTrait("poison_cloud_memo")
				if spellName == "fireburst" or spellName == "frost_burst" or spellName == "shock" or spellName == "poison_cloud" then
					champion:addTrait(spellName.."_memo")
					functions.script.spellSlinger[champion:getOrdinal()] = spellName
				end
			end
		end,
		
		-- UNTESTED

		onUseItem = function(party,champion,item,slot) 
			print(party.go.id,champion:getName(),'is using',item,slot) 
		end,		
		onReceiveCondition = function(party,champ,condition,condNumber) end, 		
		onLevelUp = function(party,champion) 
			--print(party.go.id,champion:getName(),'leveled up!') 
			-- Assassin's gets 'assassination' on level up
			if champion:getClass() == "assassin" then
				if not champion:hasTrait("assassination") then
					champion:addTrait("assassination")
				end
			end
		end,
		onPickUpItem = function(party,item)
			if item.go.model then
				item.go.model:setOffset(vec(0,0,0))
				item.go.model:setRotationAngles(0,0,0)
			end
			functions2.script.checkIronKeyBurn(party,item)
		end
	},
	{
		class = "Counter",
		name = "partycounter",
	},	
	{
		class = "Timer",
		name = "partytimer",
		timerInterval = 200.0,
		triggerOnStart = true,
		onActivate = function(self)
			self.go.partycounter:increment()
			local v = self.go.partycounter:getValue()
			print ("A day has passed.")
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				if champion:getClass() == "stalker" then
					local bonus = math.floor(champion:getLevel() / 4)
					functions.script.night_stalker[i] = 1 + bonus
					hudPrint(champion:getName() .. ", the Stalker, has recovered " .. (1 + bonus) .. " charges of Invisibility")
				end
			end
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
			
			for i=1,4 do
				local champion = party.party:getChampionByOrdinal(i)
				functions.script.set_c("wide_vision", i, nil)
				if champion:hasTrait("wide_vision") then
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
					if monsterCount > 0 then
						functions.script.set_c("wide_vision", i, monsterCount)
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
		timerInterval = 1,
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
				if champion:hasTrait("bite") then
					local biteTimer = functions.script.get_c("bite", champion:getOrdinal())
					if biteTimer and biteTimer > 0 then
						functions.script.set_c("bite", champion:getOrdinal(), math.max(biteTimer - 1, 0))
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