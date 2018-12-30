-- objects patch for detect spells
import "mod_assets/spells_pack/defineObject.lua"
-- import standard assets
import "mod_assets/scripts/mod_standard_assets.lua"
-- import the spells pack
import "mod_assets/spells_pack/init.lua"   -- the spells pack
-- import custom assets
import "mod_assets/scripts/defineObject.lua"
import "mod_assets/scripts/functions.lua"
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
import "mod_assets/scripts/items/accessories.lua"
import "mod_assets/scripts/items/armors.lua"
import "mod_assets/scripts/items/axes.lua"
import "mod_assets/scripts/items/clothes.lua"
import "mod_assets/scripts/items/containers.lua"
import "mod_assets/scripts/items/daggers.lua"
import "mod_assets/scripts/items/items.lua"
import "mod_assets/scripts/items/food.lua"
import "mod_assets/scripts/items/herbs.lua"
import "mod_assets/scripts/items/swords.lua"
import "mod_assets/scripts/items/potions.lua"
import "mod_assets/scripts/items/maces.lua"
import "mod_assets/scripts/items/firearms.lua"
import "mod_assets/scripts/items/shields.lua"
import "mod_assets/scripts/items/throwing_weapons.lua"
import "mod_assets/scripts/items/misc_weapons.lua"
import "mod_assets/scripts/materials.lua"


-- defineObject{
  -- name = "attack",
  -- baseObject = "base_spell",
  -- components = {
    -- {
      -- class = "TileDamager",
      -- attackPower = 10,
      -- castByChampion = 1,
      -- damageType = "physical",
      -- damageFlags = DamageFlags.NoLingeringEffects,
    -- },
  -- },
-- }

defineObject{
	name = "chest",
	components = {
		{
			class = "Model",
			model = "assets/models/env/treasure_chest.fbx",
		},
		{
			class = "Model",
			name = "lock",
			model = "assets/models/env/treasure_chest_lock.fbx",
			offset = vec(0, 0.41406, 0.54883),
			enabled = false,
		},
		{
			class = "Animation",
			animations = {
				open = "assets/animations/env/treasure_chest_open.fbx",
				close = "assets/animations/env/treasure_chest_close.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0,0.5,0),
			size = vec(1.5, 1.0, 1.0),
			maxDistance = 1,
			--debugDraw = true,
			onClick = function(self)
				local champion = nil
				for i=1,4 do
					champion = party.party:getChampion(i)
					if champion:getClass() == "tinkerer" and self.go.chest:getLocked() then
						if champion:isAlive() then				
							champion:regainEnergy(champion:getEnergy() * -0.25)
							self.go.chest:setLocked(false)
							break
						else
							-- if tinkerer is dead and you're trying to use a lock pick, use it normally
							if getMouseItem() and getMouseItem().go.name == "lock_pick" then
								local stacksize = getMouseItem().go.item:getStackSize()
								local lock = getMouseItem()
								if stacksize > 1 then
									lock:setStackSize(stacksize - 1)
									setMouseItem(lock)
								else
									setMouseItem(nil)
								end
							end		
						end
					end
				end
			end
		},
		{
			class = "Obstacle",
			hitSound = "barrel_hit",
		},
		{
			class = "ProjectileCollider",
		},
		{
			class = "Surface",
			offset = vec(0,0.153,0),
			size = vec(1.5, 0.85),
			--debugDraw = true,
		},		
		{
			class = "Chest",
		},
	},
	placement = "floor",
	editorIcon = 216,
	automapIcon = 124,
	automapIconLayer = 1,
}

defineObject{
	name = "party",
	baseObject = "party",
	components = {
    {
        class = "Party",
		-----------------------------------------------------------
		-- On Move
		-----------------------------------------------------------
		onMove = function(party, dir, arg1) 
			--print(party.go.id, "moving to", dir)
			-- Herb multiply
			for i=1,4 do
				local champion = party:getChampionByOrdinal(i)
				--print("herb timer ", functions.script.herb_timer[i])
				if champion:getSkillLevel("alchemy") >= 1 then
					if functions.script.herb_timer[i] > 0 then functions.script.herb_timer[i] = functions.script.herb_timer[i] - 1 end
					if functions.script.herb_timer[i] == 0 then
					local chance = math.random() * 1000
						if chance >= 995 then	
							local herb_items = {"blooddrop_cap", "etherweed", "mudwort", "falconskyre", "blackmoss"}
							local crystal_chance = math.random() * 100
							local herb_list = {}
							local list_size = 5
							if crystal_chance >= 50 then --half the chance to double crystal flowers
								table.insert(herb_items, "crystal_flower")
								list_size = list_size + 1
							end
							for i=1,list_size do
								if party:isCarrying(herb_items[i]) then
									table.insert(herb_list, herb_items[i])
								end
							end
							local herb = herb_list[math.random(#herb_list)]
							if herb ~= nil and party:isCarrying(herb) then
								for slot=13,32 do
									if champion:getItem(slot, herb) == nil then
										champion:insertItem(slot, spawn(herb).item)
										functions.script.herb_timer[i] = 20
										break
									end
								end
							end
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
		onAttack = function(party, champion, weapon)
			if weapon == nil then
				print("no weapon") --doesn't work
			end
			print(champion:getName(), "is attacking with", weapon.go.name)
			if champion:getClass() == "hunter" then
				if weapon.go.item:hasTrait("missile_weapon") or weapon.go.name == "crossbow" then
					functions.script.hunter_timer[champion:getOrdinal()] = 3
				end
			end
		end,
		-----------------------------------------------------------
		-- On Damage Taken
		-----------------------------------------------------------
		onDamage = function(party, champion, damage, damageType)
			print(party.go.id, champion:getName(), 'received damage', damage, damageType) 
			
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
								
						if button == 2 and dismantle == 9 then
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
			local MX, MY = context.mouseX, context.mouseY
			local mLeft, mRight = context.mouseDown(0), context.mouseDown(2)

			--print(MX, " ", MY)
			if Editor.isRunning() and context.keyDown("I") and context.mouseDown(0) then 
				context.font("large")
				context.color(225, 125, 125, 255)
				local text = "TEST DRAW TEXT"
				context.drawText(text, 	w - f * (w / 2  + context.getTextWidth(text)), h - f * h / 2)
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
			-- local w, h, r = context.width, 		context.height, 	context.width / context.height
			-- local f = (r < 1.3 and 0.8 or r < 1.4 and 0.9 or 1) * context.height/1080
			-- local f2 = (context.height/1080)
			-- local MX, MY = context.mouseX, context.mouseY
			-- local skill_x, skill_y = 0, 0
			-- local val1, val2 = {}, {}
			-- local skill1_p = { 3,4,5 }
			-- local skill2_p = { 2,5 }
			-- local skill3_p = { 2,5 }
			-- local skill4_p = { 2,5 }
			-- local skill_perks = { skill1_p, skill2_p, skill2_p, skill2_p }
			-- for i=1,16 do
				-- skill_x = math.floor((i-1) / 8)
				-- skill_y = (i-1) % 8
				-- if i > 4 then break end
				-- context.drawGuiItem2("SkillSlots", w - ((369 - (skill_x * 252)) * f2), (316 + (skill_y * 31)) * f2, 0, 0, 60, 21, 60 * f2, 21 * f2)
				-- val1[i], val2[i] = context.button("skill_info", w - (369 - (skill_x * 252)), 316 + (skill_y * 31), 60, 21)
				-- local tickX = 0
				-- for j=1,#skill_perks[i] do
					-- tickX = (skill_perks[i][j] - 1) * 11
					-- context.drawGuiItem2("SkillTickUpgrade", w - ((367 - (skill_x * 252) - tickX) * f2), (319 + (skill_y * 31)) * f2, 0, 0, 10, 15, 10*f2, 15*f2)
				-- end
			-- end
			-- if val1[1] or val2[1] then
				-- context.drawText("ok", MX, MY)
			-- end
		end, 
		
		--onDrawTraits = function(g,champion) print('traits') end, 
		
		-- WORKS
		onCastSpell = function(party, champion, spellName) 
			print(champion:getName(),'is using',spellName) 
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
		onPickUpItem = function(party,item) end
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
				if party.party:getChampionByOrdinal(i):getClass() == "stalker" then
					local bonus = math.floor(party.party:getChampionByOrdinal(i):getLevel() / 4)
					functions.script.night_stalker[i] = 1 + bonus
					hudPrint(party.party:getChampionByOrdinal(i):getName() .. ", the Stalker, has recovered " .. (1 + bonus) .. " charges of Invisibility")
				end
			end
			--return hudPrint("Time = "..v.."")
		end
	},
	},
}