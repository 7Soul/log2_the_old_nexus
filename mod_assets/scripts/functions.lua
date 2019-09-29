hunter_crit = {0,0,0,0}
hunter_timer = {0,0,0,0}
hunter_max = {0,0,0,0}
secondary = 0
spellSlinger = {}
stepCount = 0
keypressDelay = 0
skillNames = { "athletics", "block", "light_armor", "heavy_armor", "accuracy", "critical", "firearms", "seafaring", "alchemy", "ranged_weapons", "light_weapons_c", "heavy_weapons_c", "spellblade", "elemental_magic", "poison_mastery", "concentration", "witchcraft", "tinkering" }

data = {}
function get(name) return data[name] end
function set(name,value) data[name] = value end

champion_1_Data, champion_2_Data, champion_3_Data, champion_4_Data = {}, {}, {}, {}
championData = { champion_1_Data, champion_2_Data, champion_3_Data, champion_4_Data }
function get_c(name, id) return championData[id][name] end
function set_c(name, id, value) championData[id][name] = value end
function add_c(name, id, value) championData[id][name] = championData[id][name] and championData[id][name] + value or value end

function stepCountIncrease()
	stepCount = stepCount + 1
end

-- Allows for key presses
function keypressDelaySet(n)
	keypressDelay = n
end

function keypressDelayGet()
	return keypressDelay
end

--------------------------------------------------------------------------
-- Custom Skill Gui                                                     --
--------------------------------------------------------------------------

champSkillTemp1, champSkillTemp2 = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
champSkillTemp3, champSkillTemp4 = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
partySkillTemp = {champSkillTemp1, champSkillTemp2, champSkillTemp3, champSkillTemp4 } 

function addSkillTemp(champion, skill)
	local champ = champion:getOrdinal()
	partySkillTemp[champ][skill] = math.min(partySkillTemp[champ][skill] + 1, 5)
	champion:setSkillPoints(champion:getSkillPoints() - 1)
end

function removeSkillTemp(champion, skill)
	local champ = champion:getOrdinal()
	partySkillTemp[champ][skill] = math.max(partySkillTemp[champ][skill] - 1, 0)
	champion:setSkillPoints(champion:getSkillPoints() + 1)
end

function clearSkillTemp(champion)
	local champ = champion:getOrdinal()
	for i=1,18 do
		while partySkillTemp[champ][i] > 0 do
			partySkillTemp[champ][i] = partySkillTemp[champ][i] - 1
			champion:addSkillPoints(1)
		end
	end
end

function performSkillTemp(champion)
	local champ = champion:getOrdinal()
	for i=1,18 do
		while partySkillTemp[champ][i] > 0 do
			partySkillTemp[champ][i] = partySkillTemp[champ][i] - 1
			champion:trainSkill(skillNames[i], 1, false)
		end
	end
end

function countAllSkills(champion)
	local champ = champion:getOrdinal()
	local result = 0
	for i=1,18 do
		result = result + champion:getSkillLevel(skillNames[i])
	end
	return result
end

--------------------------------------------------------------------------
-- Test Stuff                                                           --
--------------------------------------------------------------------------

-- Failsafe for if the player loads a party with default classes
function setDefaultParty()
	local champion = nil
	for c=1,4 do
		champion = party.party:getChampionByOrdinal(c)
		-- Reset Level
		champion:resetExp(0)
		-- Reset Skills
		for i=1,#skillNames do
			local s = champion:getSkillLevel(skillNames[i])
			champion:trainSkill(skillNames[i], s * -1, false)
		end
		-- Remove items
		for s=1,32 do champion:removeItemFromSlot(s) end		
	end

	--local defaultChampion = {"human_berserker"}
	champion = party.party:getChampionByOrdinal(1)
	champion:setRace("insectoid")
	champion:setClass("monk")
	champion:addTrait("persistence")
	champion:trainSkill("heavy_weapons_c", 1, false)
	champion:trainSkill("athletics", 1, false)

	champion = party.party:getChampionByOrdinal(2)
	champion:setRace("lizardman")
	champion:setClass("assassin_class")
	champion:addTrait("wide_vision")
	champion:trainSkill("light_weapons_c", 1, false)
	champion:trainSkill("critical", 1, false)

	champion = party.party:getChampionByOrdinal(3)
	champion:setRace("ratling")
	champion:setClass("corsair")
	champion:addTrait("rodent")
	champion:trainSkill("firearms", 1, false)
	champion:trainSkill("alchemy", 1, false)

	champion = party.party:getChampionByOrdinal(4)
	champion:setRace("human")
	champion:setClass("elementalist")
	champion:addTrait("lore_master")
	champion:trainSkill("elemental_magic", 1, false)
	champion:trainSkill("concentration", 1, false)

	for c=1,4 do
		champion = party.party:getChampionByOrdinal(c)
		champion:setHealth(champion:getMaxHealth() * 0.9)
		champion:setEnergy(champion:getMaxEnergy() * 0.9)
	end
end

function teststart()
	functions2.script.start()
	defaultPartyCheck = {"fighter", "barbarian", "wizard", "alchemist", "knight", "rogue", "battle_mage", "farmer"}
	for i=1,#defaultPartyCheck do
		for c=1,4 do
			local champion = party.party:getChampionByOrdinal(c)
			if champion:getClass() == defaultPartyCheck[i] then
				setDefaultParty()
			end
		end
	end

	if Editor.isRunning() then
		party.party:getChampionByOrdinal(1):setClass("berserker")
		party.party:getChampionByOrdinal(2):setClass("hunter")
		party.party:getChampionByOrdinal(3):setClass("tinkerer")
		party.party:getChampionByOrdinal(4):setClass("elementalist")
		party.party:getChampionByOrdinal(1):setRace("human")
		party.party:getChampionByOrdinal(2):setRace("lizardman")
		party.party:getChampionByOrdinal(3):setRace("insectoid")
		party.party:getChampionByOrdinal(4):setRace("ratling")

		for i=1,4 do
			local champion = party.party:getChampionByOrdinal(i)
			if not champion:getItem(32) then champion:insertItem(32,spawn("torch").item) end
			--champion:addSkillPoints(1)
			-- if i == 1 then
			-- 	champion:removeItemFromSlot(31)
			-- 	champion:insertItem(31,spawn("enchanted_timepiece").item)
			-- end
			-- Classes
			if champion:getClass() == "assassin_class" then
				for s=13,18 do champion:removeItemFromSlot(s) end
				champion:insertItem(13,spawn("short_bow").item)
				champion:insertItem(14,spawn("arrow").item)
				champion:getItem(14):setStackSize(20)
				champion:insertItem(15,spawn("dagger").item)
				champion:insertItem(16,spawn("throwing_knife").item)
				champion:getItem(16):setStackSize(20)
			end

			if champion:getClass() == "berserker" then
				for s=13,15 do champion:removeItemFromSlot(s) end
				champion:insertItem(13,spawn("great_axe").item)
				champion:insertItem(14,spawn("potion_strength").item)
				champion:getItem(14):setStackSize(20)
				champion:insertItem(15,spawn("round_shield").item)
			end
			
			if champion:getClass() == "monk" then
				for s=13,18 do champion:removeItemFromSlot(s) end
				champion:insertItem(13,spawn("short_bow").item)
				champion:insertItem(14,spawn("arrow").item)
				champion:getItem(14):setStackSize(20)
				champion:insertItem(15,spawn("dagger").item)
				champion:insertItem(16,spawn("throwing_knife").item)
				champion:getItem(16):setStackSize(20)
			end
			
			if champion:getClass() == "druid" then
				for s=13, 19 do
					champion:removeItemFromSlot(s)
				end
				for s=ItemSlot.Weapon, ItemSlot.Bracers do
					champion:removeItemFromSlot(s)
				end
				champion:insertItem(13,spawn("blooddrop_cap").item)
				champion:getItem(13):setStackSize(5)
				champion:insertItem(14,spawn("etherweed").item)
				champion:getItem(14):setStackSize(5)
				champion:insertItem(15,spawn("mudwort").item)
				champion:getItem(15):setStackSize(5)
				champion:insertItem(16,spawn("falconskyre").item)
				champion:getItem(16):setStackSize(5)
				champion:insertItem(17,spawn("blackmoss").item)
				champion:insertItem(18,spawn("crystal_flower").item)
				champion:insertItem(19,spawn("mortar").item)
				champion:insertItem(ItemSlot.Gloves, spawn("leather_gloves").item)
				champion:insertItem(ItemSlot.Feet, spawn("leather_boots").item)
				champion:insertItem(ItemSlot.Legs, spawn("leather_pants").item)
				champion:insertItem(ItemSlot.Chest, spawn("doublet").item)
				champion:insertItem(ItemSlot.Head, spawn("peasant_cap").item)
				champion:insertItem(ItemSlot.Bracers, spawn("leafbond_bracelet").item)
				champion:insertItem(ItemSlot.Necklace, spawn("runestone_necklace").item)
				champion:insertItem(ItemSlot.Cloak, spawn("shaman_cloak").item)
				champion:insertItem(ItemSlot.Weapon, spawn("hand_axe").item)				
			end
			
			if champion:getClass() == "corsair" then
				for s=13,17 do	champion:removeItemFromSlot(s)	end
				champion:insertItem(13,spawn("flintlock").item)
				champion:insertItem(14,spawn("flintlock").item)
				champion:insertItem(15,spawn("pellet_box").item)
				champion:getItem(15):setStackSize(100)
				champion:insertItem(16,spawn("rapier").item)
				champion:insertItem(17,spawn("throwing_knife").item)
				champion:getItem(17):setStackSize(20)
			end
			
			if champion:getClass() == "elementalist" then
				if champion:getSkillLevel("elemental_magic") == 0 then champion:trainSkill("elemental_magic", 1) end
				for s=13,14 do champion:removeItemFromSlot(s) end
				champion:insertItem(13,spawn("quarterstaff").item)
				champion:insertItem(14,spawn("potion_willpower").item)
				champion:getItem(14):setStackSize(20)
			end
			
			if champion:getClass() == "hunter" then
				for s=13,17 do champion:removeItemFromSlot(s) end
				champion:insertItem(13,spawn("short_bow").item)
				champion:insertItem(14,spawn("arrow").item)
				champion:getItem(14):setStackSize(25)
				champion:insertItem(15,spawn("crossbow").item)
				champion:insertItem(16,spawn("quarrel").item)
				champion:getItem(16):setStackSize(25)
				champion:insertItem(17,spawn("throwing_knife").item)
				champion:getItem(17):setStackSize(20)
			end
			
			if champion:getClass() == "tinkerer" then
				if champion:getSkillLevel("tinkering") == 0 then champion:trainSkill("tinkering", 1) end
				for s=13,25 do champion:removeItemFromSlot(s) end
				champion:insertItem(13,spawn("flintlock").item)
				champion:insertItem(14,spawn("pellet_box").item)
				champion:getItem(14):setStackSize(50)
				champion:insertItem(15,spawn("ring_mail").item)
				champion:insertItem(16,spawn("lock_pick").item)
				champion:getItem(16):setStackSize(25)
				for	d=1,4 do
					champion:insertItem(16+d,spawn("dagger").item)
				end
				champion:insertItem(21,spawn("tinkering_toolbox").item)
				champion:insertItem(22,spawn("metal_bar").item)
				champion:getItem(22):setStackSize(10)
				champion:insertItem(23,spawn("metal_nugget").item)
				champion:getItem(23):setStackSize(5)
				champion:insertItem(24,spawn("leather_strips").item)
				champion:getItem(24):setStackSize(5)
				champion:insertItem(25,spawn("leather").item)
				champion:getItem(25):setStackSize(5)
			end
			
			-- Races
			if champion:getRace() == "human" then
				champion:addTrait("lore_master")
				champion:addTrait("drinker")
				champion:addTrait("average_joe")
			end
			
			if champion:getRace() == "minotaur" then
				champion:addTrait("carnivorous")
				champion:addTrait("brutalizer")
				champion:addTrait("ancestral_charge")
				for s=21,28 do champion:removeItemFromSlot(s) end
				champion:insertItem(21,spawn("warg_meat").item)
				champion:insertItem(22,spawn("sausage").item)
				champion:insertItem(23,spawn("rat_shank").item)
				champion:insertItem(24,spawn("potion_strength").item)
				champion:getItem(24):setStackSize(10)
				champion:insertItem(25,spawn("warg_meat").item)
				champion:insertItem(26,spawn("sausage").item)
				champion:insertItem(27,spawn("rat_shank").item)
				champion:insertItem(28,spawn("rat_shank").item)
			end
			
			if champion:getRace() == "lizardman" then
				champion:addTrait("lizard_blood")
				champion:addTrait("wide_vision")
				champion:addTrait("bite")
				for s=21,28 do champion:removeItemFromSlot(s) end
			end
			
			if champion:getRace() == "insectoid" then
				champion:addTrait("persistence")
				champion:addTrait("chemical_processing")
				champion:addTrait("intensify_spell")
				-- for s=21,28 do champion:removeItemFromSlot(s) end
			end
			
			if champion:getRace() == "ratling" then
				champion:addTrait("rodent")
				champion:addTrait("sneak_attack")
				champion:addTrait("built_resistance")
				for s=21,28 do champion:removeItemFromSlot(s) end
				champion:insertItem(21,spawn("blooddrop_cap").item)
				champion:getItem(21):setStackSize(5)
				champion:insertItem(22,spawn("etherweed").item)
				champion:getItem(22):setStackSize(5)
				champion:insertItem(23,spawn("mudwort").item)
				champion:getItem(23):setStackSize(5)
				champion:insertItem(24,spawn("falconskyre").item)
				champion:getItem(24):setStackSize(5)
			end
			champion:setHealth(champion:getMaxHealth())
			champion:setEnergy(champion:getMaxEnergy())
		end
	end
	for i=1,4 do
		local champion = party.party:getChampionByOrdinal(i)
		if champion:getClass() == "assassin_class" then
			champion:addTrait("assassination")
		end
		if champion:getClass() == "stalker" then
			local bonus = 1 + math.floor(party.party:getChampionByOrdinal(i):getLevel() / 3)
			set_c("night_stalker", i, bonus)
		end
	end
	findCrystalArea()
end

crystal_area = {}

function findCrystalArea()
	for entity in Dungeon.getMap(party.level):allEntities() do
		if entity.name == "crystal_area" then
			crystal_area = {entity.x-2, entity.y-2, entity.x+2, entity.y+2}
		end
	end
end

function hunterCrit(id2, stack, dur)
	local champion = party.party:getChampionByOrdinal(id2)
	local id = champion:getOrdinal()
	hunter_crit[id] = hunter_crit[id] + stack
	hunter_max[id] = dur
	champion:setConditionValue("hunter_crit", dur)
end

function getTimepiece()
	for j=1,4 do
		for i=1,32 do
			if party.party:getChampionByOrdinal(j):getItem(i) and party.party:getChampionByOrdinal(j):getItem(i).go.name == "enchanted_timepiece" then
				local timepiece_champion = party.party:getChampionByOrdinal(j)
				return timepiece_champion:getItem(i)
			end
		end
	end
	if getMouseItem() and getMouseItem().go.name == "enchanted_timepiece" then
		return getMouseItem()
	end
end

-------------------------------------------------------------------------------------------------------
-- Item and equipment events                                                                         --    
-------------------------------------------------------------------------------------------------------

function onConsumeFood(self, champion)
	if champion:hasTrait("carnivorous") and champion:isAlive() then
		if self.go.item:hasTrait("consumable") and self.go.item:hasTrait("meat") then
			-- champion:setConditionValue("carnivorous", 60 + (math.floor(champion:getLevel() / 8 ) * 60) + (math.floor(champion:getLevel() / 12 ) * 60) )
			champion:modifyFood(self.go.usableitem:getNutritionValue() * 0.05) -- extra 5% hunger gain

			local meatCounter = get_c("meat_counter", champion:getOrdinal()) or 0
			local meatBonus = get_c("meat_bonus", champion:getOrdinal()) or 0
			set_c("meat_counter", champion:getOrdinal(), meatCounter + 1)
			if meatCounter == (3 + math.floor(champion:getLevel() / 5) + (math.floor(champion:getLevel() / 13) * 2) + math.floor(champion:getLevel())) then
				set_c("meat_counter", champion:getOrdinal(), 0)
				meatBonus = meatBonus + 1
				set_c("meat_bonus", champion:getOrdinal(), meatBonus)

				local strBonus = math.floor(meatBonus / 2)
				local vitBonus = math.ceil(meatBonus / 2)

				if meatBonus % 2 == 1 then
					functions.script.set_c("level_up_message_2", champion:getOrdinal(), champion:getName() .. " gained +1 Vitality from the Carnivorous trait.")
				else
					functions.script.set_c("level_up_message_2", champion:getOrdinal(), champion:getName() .. " gained +1 Strenght from the Carnivorous trait.")
				end
				functions.script.set_c("level_up_message_2_timer", champion:getOrdinal(), 8)
			end
		else
			hudPrint("This isn't meat...")
			return false
		end
	end
end

function checkWeights(id)
	local champion = party.party:getChampionByOrdinal(id)

	for i=1, ItemSlot.BackpackLast do
		local item = champion:getItem(i)
		if champion:hasTrait("lore_master") then
			setWeight(item, "spell_scroll", 0)
		else
			resetItemWeight(item, "spell_scroll")
		end
		
		if champion:getSkillLevel("heavy_armor") > 0 then
			setWeight(item, "heavy_armor", 1 - (champion:getSkillLevel("heavy_armor") * 0.1)) 
		else
			resetItemWeight(item, "heavy_armor")
		end	
		
		if champion:hasTrait("freebooter") then
			setWeight(item, "cannon_ball", 0.25)
			setWeight(item, "pellet_box", 0.25)
		else
			resetItemWeight(item, "cannon_ball")
			resetItemWeight(item, "pellet_box")
		end	
	end
end

function setWeight(item, trait, multiplier)
	if item and item:hasTrait(trait) then
		-- if supertable[14][item.go.id] == nil then
		-- 	supertable[14][item.go.id] = item.go.item:getWeight()
		-- 	item.go.item:setWeight(item.go.item:getWeight() * multiplier)
		-- end
		if tinker_item[14][item.go.id] ~= nil then
			item.go.item:setWeight(tinker_item[14][item.go.id] * multiplier)
		elseif supertable[14][item.go.id] ~= nil then
			item.go.item:setWeight(supertable[14][item.go.id] * multiplier)
		else
			--item.go.item:setWeight(item.go.item:getWeight() * multiplier)
		end
	end
end

function resetItemWeight(item, trait)
	if item and supertable[14][item.go.id] == nil then
		supertable[14][item.go.id] = item.go.item:getWeight()
	end
	if item and item:hasTrait(trait) and supertable[14][item.go.id] ~= nil then
		item.go.item:setWeight(supertable[14][item.go.id])
		--supertable[14][item.go.id] = nil
	end
	if item and item:hasTrait(trait) and tinker_item[14][item.go.id] ~= nil then
		item.go.item:setWeight(tinker_item[14][item.go.id])
		--supertable[14][item.go.id] = nil
	end
end

b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b20 = {}, {}, {}, {}, {}, {}, { {},{},{},{} }, { {},{},{},{},{},{} }, { {},{},{} }, {}, {}, {}, {{},{},{}}, {}
supertable = { b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b20  }

function onEquipItem(self, champion, slot)	
	local name = self.go.id

	if slot >= ItemSlot.BackpackFirst and slot <= ItemSlot.BackpackLast then
		
	else
		if (slot >= ItemSlot.Head and slot <= ItemSlot.Feet) or slot == ItemSlot.Gloves then
			
		end
			
		if slot == ItemSlot.Weapon or slot == ItemSlot.OffHand then
			local item2 = champion:getOtherHandItem(slot)
			local slots = {2,1}
			local otherslot = slots[slot]
			
			if self.go.firearmattack then
				supertable[1][name] = self.go.firearmattack:getAttackPower()
				supertable[2][name] = self.go.firearmattack:getCooldown()
				supertable[3][name] = self.go.firearmattack:getRange()
				supertable[4][name] = self.go.firearmattack:getPierce() and self.go.firearmattack:getPierce() or 0
			end
			
			if self.go.meleeattack then
				supertable[1][name] = self.go.meleeattack:getAttackPower()
				supertable[2][name] = self.go.meleeattack:getCooldown()
				supertable[4][name] = self.go.meleeattack:getPierce() and self.go.meleeattack:getPierce() or 0
			end
			
			if self.go.equipmentitem then supertable[6][name] = self.go.equipmentitem:getCriticalChance() end
			if self.go.equipmentitem then supertable[7][1][name] = self.go.equipmentitem:getResistFire() end
			if self.go.equipmentitem then supertable[7][2][name] = self.go.equipmentitem:getResistShock() end
			if self.go.equipmentitem then supertable[7][3][name] = self.go.equipmentitem:getResistCold() end
			if self.go.equipmentitem then supertable[7][4][name] = self.go.equipmentitem:getResistPoison() end

			if self.go.equipmentitem then supertable[8][1][name] = self.go.equipmentitem:getStrength() end
			if self.go.equipmentitem then supertable[8][2][name] = self.go.equipmentitem:getDexterity() end
			if self.go.equipmentitem then supertable[8][3][name] = self.go.equipmentitem:getVitality() end
			if self.go.equipmentitem then supertable[8][4][name] = self.go.equipmentitem:getWillpower() end
			if self.go.equipmentitem then supertable[8][5][name] = self.go.equipmentitem:getHealthRegenerationRate() end
			if self.go.equipmentitem then supertable[8][6][name] = self.go.equipmentitem:getEnergyRegenerationRate() end

			if self.go.equipmentitem then supertable[9][1][name] = self.go.equipmentitem:getProtection() end
			if self.go.equipmentitem then supertable[9][2][name] = self.go.equipmentitem:getEvasion() end

			
			local secondaryAction = self.go.item:getSecondaryAction()
			local secondary = nil
			if secondaryAction ~= nil and self.go:getComponent(secondaryAction):getClass() ~= "CastSpellComponent" then
				secondary = self.go:getComponent(secondaryAction)
			end
			if secondary then supertable[13][1][name] = secondary:getAttackPower() end
			if secondary then supertable[13][2][name] = secondary:getBuildup() end
			if secondary then supertable[13][3][name] = secondary:getEnergyCost() end

			-- if champion:hasTrait("weapons_specialist") then
			-- 	self.go.equipmentitem:setCriticalChance(supertable[6][name] * 2)
			-- 	if self.go.name == "scythe" then
			-- 		self.go.equipmentitem:setCriticalChance(5)
			-- 		supertable[6][name] = 5
			-- 	end
			-- end
			
			if self.go.name == "quarterstaff" and champion:getSkillLevel("spellblade") >= 1 then
				self.go.item:removeTrait("two_handed")
				self.go.meleeattack:setAttackPower(math.ceil(self.go.meleeattack:getAttackPower() * (1.1 + (champion:getSkillLevel("spellblade") * 0.1) + (champion:getCurrentStat("willpower") * 0.05))))
			end
		end
		
		-- Berserker unequips armor
		if champion:getClass() == "berserker" then
			local noEquipSlots = { ItemSlot.Head, ItemSlot.Gloves, ItemSlot.Feet, ItemSlot.Chest, ItemSlot.Legs }
			for i=1, #noEquipSlots do
				local lightSlots = false
				if i <= 3 then lightSlots = true end
				
				if slot == noEquipSlots[i] then
					if (lightSlots and self:hasTrait("heavy_armor")) or not lightSlots then
						for j=ItemSlot.BackpackFirst,ItemSlot.BackpackLast do
							if not champion:getItem(j) then champion:insertItem(j, self) break end
							if j == ItemSlot.BackpackLast and champion:getItem(j) then party:spawn(self.go.name) break end
						end
						hudPrint(champion:getName() .. ", the Berserker, refuses to wear heavy armor.")
						champion:removeItemFromSlot(slot)
					end
				end
			end
		end
	end
	if self.go.name == "enchanted_timepiece" then
		getTimepiece()
	end
end

function onUnequipItem(self, champion, slot)
	if self.go.item:hasTrait("throwing_weapon") then functions.script.reset_attack(self.go.throwattack, champion, slot, 0, self.go.item) end
	--if self.go.item:getSecondaryAction("throw") then functions.script.reset_attack(self.go.meleeattack, champion, slot, 0, self.go.item) end
	local name = self.go.id
	local slots = {2,1}
	local otherslot = slots[slot]
	
	if self.go.name == "quarterstaff" and champion:getSkillLevel("spellblade") >= 1 then
		self.go.item:addTrait("two_handed")
	end
	
	functions.script.resetItem(self, name)
	functions.script.clearSupertable(self, name)
end

function resetItem(self, name)
	--print("reset item")
	local item = nil
	if self.go.firearmattack then item = self.go.firearmattack end
	if self.go.meleeattack then item = self.go.meleeattack end
	if self.go.throwattack then item = self.go.throwattack end
	if self.go.rangedattack then item = self.go.rangedattack end

	if supertable[1][name] ~= nil then
		local real_ap = tinker_item[1][name] and tinker_item[1][name] or supertable[1][name]
		item:setAttackPower(real_ap)
	end

	if supertable[2][name] ~= nil then
		local real_cooldown = tinker_item[2][name] and tinker_item[2][name] or supertable[2][name]
		item:setCooldown(real_cooldown)
	end

	if supertable[3][name] ~= nil then
		local real_range = tinker_item[3][name] and tinker_item[3][name] or supertable[3][name]
		if item == self.go.firearmattack then item:setRange(real_range) end
	end

	if supertable[4][name] ~= nil then
		local real_pierce = tinker_item[4][name] and tinker_item[4][name] or supertable[4][name]
		if item == self.go.firearmattack or item == self.go.meleeattack then item:setPierce(real_pierce) end
	end

	if supertable[5][name] ~= nil then
		local real_acc = tinker_item[5][name] and tinker_item[5][name] or supertable[5][name]
		if item == self.go.meleeattack or item == self.go.firearmattack then
			item:setAccuracy(real_acc)
		else
			self.go.equipmentitem:setAccuracy(real_acc)
		end
	end

	if supertable[6][name] ~= nil then
		local real_crit = tinker_item[6][name] and tinker_item[6][name] or supertable[6][name]
		if self.go.equipmentitem then self.go.equipmentitem:setCriticalChance(real_crit) end
	end

	if supertable[7][1][name] ~= nil then
		local real_res = tinker_item[7][1][name] and tinker_item[7][1][name] or supertable[7][1][name]
		if self.go.equipmentitem then self.go.equipmentitem:setResistFire(real_res) end
	end
	if supertable[7][2][name] ~= nil then
		local real_res = tinker_item[7][2][name] and tinker_item[7][2][name] or supertable[7][2][name]
		if self.go.equipmentitem then self.go.equipmentitem:setResistShock(real_res) end
	end
	if supertable[7][3][name] ~= nil then
		local real_res = tinker_item[7][3][name] and tinker_item[7][3][name] or supertable[7][3][name]
		if self.go.equipmentitem then self.go.equipmentitem:setResistCold(real_res) end
	end
	if supertable[7][4][name] ~= nil then
		local real_res = tinker_item[7][4][name] and tinker_item[7][4][name] or supertable[7][4][name]
		if self.go.equipmentitem then self.go.equipmentitem:setResistPoison(real_res) end
	end

	if supertable[8][1][name] ~= nil then
		local real_stat = tinker_item[8][1][name] and tinker_item[8][1][name] or supertable[8][1][name]
		if self.go.equipmentitem then self.go.equipmentitem:setStrength(real_stat) end
	end
	if supertable[8][2][name] ~= nil then
		local real_stat = tinker_item[8][2][name] and tinker_item[8][2][name] or supertable[8][2][name]
		if self.go.equipmentitem then self.go.equipmentitem:setDexterity(real_stat) end
	end
	if supertable[8][3][name] ~= nil then
		local real_stat = tinker_item[8][3][name] and tinker_item[8][3][name] or supertable[8][3][name]
		if self.go.equipmentitem then self.go.equipmentitem:setVitality(real_stat) end
	end
	if supertable[8][4][name] ~= nil then
		local real_stat = tinker_item[8][4][name] and tinker_item[8][4][name] or supertable[8][4][name]
		if self.go.equipmentitem then self.go.equipmentitem:setWillpower(real_stat) end
	end
	if supertable[8][5][name] ~= nil then
		local real_stat = tinker_item[8][5][name] and tinker_item[8][5][name] or supertable[8][5][name]
		if self.go.equipmentitem then self.go.equipmentitem:setHealthRegenerationRate(real_stat) end
	end
	if supertable[8][6][name] ~= nil then
		local real_stat = tinker_item[8][6][name] and tinker_item[8][6][name] or supertable[8][6][name]
		if self.go.equipmentitem then self.go.equipmentitem:setEnergyRegenerationRate(real_stat) end
	end

	if supertable[9][1][name] ~= nil then
		local real_prot = tinker_item[9][1][name] and tinker_item[9][1][name] or supertable[9][1][name]
		if self.go.equipmentitem then self.go.equipmentitem:setProtection(real_prot) end
	end

	if supertable[9][2][name] ~= nil then
		local real_prot = tinker_item[9][2][name] and tinker_item[9][2][name] or supertable[9][2][name]
		if self.go.equipmentitem then self.go.equipmentitem:setProtection(real_prot) end
	end

	-- if supertable[9][3][name] ~= nil then
	-- 	local real_ge = tinker_item[9][3][name] and tinker_item[9][3][name] or supertable[9][3][name]
	-- 	if self.go:getGameEffect() then self.go:setGameEffect(real_ge) end
	-- end

	-- if supertable[9][4][name] ~= nil then
	-- 	local upgrades = tinker_item[9][4][name] and tinker_item[9][4][name] or supertable[9][4][name]
	-- 	supertable[9][4][name] = upgrades
	-- end

	-- if supertable[13][name] ~= nil then
	-- 	local real_weight = 0
	-- 	if tinker_item[13][name] then real_crit = tinker_item[13][name] else real_weight = supertable[13][name] end
	-- 	if self.go.equipmentitem then self:setWeight(real_weight) end
	-- end

	local secondaryAction = self.go.item:getSecondaryAction()
	local secondary = nil
	if secondaryAction ~= nil and self.go:getComponent(secondaryAction):getClass() ~= "CastSpellComponent" then
		secondary = self.go:getComponent(secondaryAction)
	end

	if supertable[13][1][name] ~= nil and secondary then
		local real_ap = 0
		if tinker_item[13][1][name] then real_ap = tinker_item[13][1][name] else real_ap = supertable[13][1][name] end
		secondary:setAttackPower(real_ap)
	end

	if supertable[13][2][name] ~= nil and secondary then
		local real_ap = 0
		if tinker_item[13][2][name] then real_ap = tinker_item[13][2][name] else real_ap = supertable[13][2][name] end
		secondary:setBuildup(real_ap)
	end

	if supertable[13][3][name] ~= nil and secondary then
		local real_ap = 0
		if tinker_item[13][3][name] then real_ap = tinker_item[13][3][name] else real_ap = supertable[13][3][name] end
		secondary:setEnergyCost(real_ap)
	end
end

function clearSupertable(self, name)
	for i=1,13 do
		if i ~= 11 then
			if (i < 7 or i > 9) and i ~= 13 then
				supertable[i][name] = nil
			else
				if i == 7 then
					for j=1,4 do
						supertable[i][j][name] = nil
					end
				elseif i == 8 then
					for j=1,6 do
						supertable[i][j][name] = nil
					end
				elseif i == 9 then
					for j=1,2 do
						supertable[i][j][name] = nil
					end
				elseif i == 13 then
					for j=1,3 do
						supertable[i][j][name] = nil
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------
-- Attacking events                                                                                  --    
-------------------------------------------------------------------------------------------------------
function onMeleeAttack(self, item, champion, slot, chainIndex, secondary2)
	local c = champion:getOrdinal()
	local secondary = self.go:getComponent(self.go.item:getSecondaryAction() and self.go.item:getSecondaryAction() or "")

	if self.go.item:getSecondaryAction() and self == self.go:getComponent(self.go.item:getSecondaryAction()) and self.go.item:getSecondaryAction() == "dagger_throw" then
		champion:removeItem(item)
		addItemToMap(item, party.level, 0, 0, 0, party.elevation, nil)
		local dx, dy = getForward(party.facing)
		item.go:setPosition(party.x, party.y, party.facing, party.elevation + 0.4, party.level)
		item:throwItem(party.facing, 18)
		--item.go:setWorldRotationAngles(90,90,0)
		local sidesX = 0
		local sidesY = 0
		if party.facing == 1 or party.facing == 3 then sidesY = 0.5 end
		if party.facing == 0 or party.facing == 2 then sidesX = 0.5 end
		if (champion == party.party:getChampion(2) or champion == party.party:getChampion(4)) then 
			sidesY = sidesY * -1
			sidesX = sidesX * -1
		end
		item.go:setWorldPosition(item.go:getWorldPosition() + vec(sidesX, 0, sidesY))
		--item.go.projectile:setAttackPower(0)
		--item.go.projectile:setHitEffect("dispel_blast")
		item.go.projectile:setFallingVelocity(0.5)
		item.go.projectile:setAngularVelocity(0)
		item.go.projectile:setGravity(3)
		item.go.projectile:setIgnoreEntity(party, 1)
		set_c("attackedWith", champion:getOrdinal(), item.go.name)
		reset_attack(self.go.meleeattack, champion, slot, 0, self.go.item)
	end
	
	-- When using secondary attack, we update the main melee action
	if self.go.item:getSecondaryAction() and self == self.go:getComponent(self.go.item:getSecondaryAction()) then
		self = self.go.meleeattack		
	end

	functions.script.resetItem(self, self.go.id)
	supertable[1][item.go.id] = self:getAttackPower()
	supertable[2][item.go.id] = self:getCooldown()
	supertable[4][self.go.id] = self:getPierce() ~= nil and self:getPierce() or 0
	-- supertable[6][self.go.id] = self.go.equipmentitem and self.go.equipmentitem:getCriticalChance() or 0
	
	-- All physical attack bonuses	
	if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "fire_gauntlets" then
		-- Fire Gauntlets damage is amplified by other sources of + fire damage
		self:setAttackPower(self:getAttackPower() * empowerElement(champion, "fire", 1))
	else
		self:setAttackPower(self:getAttackPower() * empowerElement(champion, "physical", 1))
	end

	-- All melee bonuses
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "melee", 1))

	-- Light/Heavy Weapons bonuses
	if getTrait(champion, item, "light_weapon") then
		self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "light_weapons_c", 1))
	elseif getTrait(champion, item, "heavy_weapon") then
		self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "heavy_weapons_c", 1))
	end

	-- Dual Wielding bonuses
	if champion:isDualWielding() then
		self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "dual_wield", 1))
	end

	-- Precision Pierce bonus
	if champion:hasTrait("precision") then
		if supertable[4][name] ~= nil then
			local real_pierce = tinker_item[4][name] and tinker_item[4][name] or supertable[4][name]
			real_pierce = real_pierce + (math.random() * 15 + 5)
			self:setPierce(real_pierce)
		end
	end

	-- Druid's Mudwort attack bonus against poisoned enemies
	if champion:getClass() == "druid" then
		local poisonedMonster = functions.script.get_c("poisonedMonster", c)
		if poisonedMonster then
			local monster = findEntity(poisonedMonster).monster
			self:setAttackPower(self:getAttackPower() * 1.15 )
			monster:setCondition("poisoned", 0)
		end
	end

	if item:hasTrait("poison_mace") and champion:getSkillLevel("poison_mastery") == 5 then
		local poisonedMonster = functions.script.get_c("poisonedMonster", c)
		if poisonedMonster then
			self:setAttackPower(self:getAttackPower() * 1.4 )
		end
	end
	
	-- Bearclaw Gauntlets - Increases power attack damage by 15%
	if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "bearclaw_gauntlets" then
		if secondary ~= self then
			local amount = (champion:getItem(ItemSlot.Gloves):hasTrait("upgraded") and 1.30 or 1.15)
			secondary:setAttackPower(secondary:getAttackPower() * amount)
		end
	end
	
	-- Corsair fires gun with light weapon melee attack
	if champion:getClass() == "corsair" and getTrait(champion, item, "light_weapon") then
		local item2 = champion:getOtherHandItem(slot)
		if item2 and item2:hasTrait("firearm") then
			delayedCall("functions", 0.25, "duelistSword", c, item.go.name, slot)
		end
	end
	
	-- Double attack
	if get_c("double_attack", c) == nil then
		processSecondAttack(self, champion, "melee", slot)
	else
		set_c("double_attack", c, nil)
	end

	-- Lizardman Bite
	if champion:hasTrait("bite") then
		if get_c("bite", c) == nil or get_c("bite", c) == 0 then
			set_c("bite", c, 30 - (math.floor(champion:getLevel() / 5) * 5 ) )
			set_c("bite_damage",c, champion:getCurrentStat("dexterity") - 5 )
			set_c("bite_accuracy", c, getAccuracy(champion, ItemSlot.Weapon) )
			delayedCall("functions", 0.1, "bite", c)
		end
	end
	
	if not item.go.equipmentitem then item.go:createComponent("EquipmentItem", "equipmentitem") end	
	local real_crit = tinker_item[6][name] and tinker_item[6][name] or (supertable[6][name] and supertable[6][name] or 0)
	if self.go.equipmentitem then self.go.equipmentitem:setCriticalChance(real_crit) end
	
	delayedCall("functions", 0.01, "resetItem", self, self.go.id)
end

function addItemToMap(item,level,x,y,facing,elevation,wpos)
	if item.go.map then
		Console.warn(string.format("Item %s already has a map, aborting.",item.go.id))
		return false
	else
		local m = spawn("dummy",level,x,y,facing,elevation)
		m.monster:addItem(item)
		m.monster:dropAllItems()
		m:destroy()
	end
end

function onThrowAttack(self, champion, slot, chainIndex, item)
	local c = champion:getOrdinal()
	supertable[1][item.go.id] = self:getAttackPower()
	supertable[2][item.go.id] = self:getCooldown()
	-- supertable[6][self.go.id] = self.go.equipmentitem and self.go.equipmentitem:getCriticalChance() or 0
	
	-- Ranged Weapons skill bonus
	-- self:setAttackPower(self:getAttackPower() * (1 + champion:getSkillLevel("ranged_weapons") * 0.2))
	
	-- All physical attack boosts
	self:setAttackPower(self:getAttackPower() * empowerElement(champion, "physical", 1))	
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "ranged", 1))
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "throwing", 1))
	
	if champion:hasTrait("precision") then
		self:setAttackPower(self:getAttackPower() + (math.random() * 20 + 5))
	end
	
	-- Trigger psionic missile
	local id = champion:getOrdinal()
	if champion:hasTrait("magic_missile") then
		delayedCall("functions", 0.1, "psionicArrow", id)
	end
	
	if not item.go.equipmentitem then item.go:createComponent("EquipmentItem", "equipmentitem") end	
	local real_crit = tinker_item[6][name] and tinker_item[6][name] or (supertable[6][name] and supertable[6][name] or 0)
	if self.go.equipmentitem then self.go.equipmentitem:setCriticalChance(real_crit) end
	
	-- Throwing Double shot	
	if get_c("double_attack", c) == nil then
		processSecondAttack(self, champion, "throwing", slot)		
	else
		set_c("double_attack", c, nil)
	end
end

function onMissileAttack(self, champion, slot, chainIndex, item)
	supertable[1][self.go.id] = self:getAttackPower()
	supertable[2][self.go.id] = self:getCooldown()
	-- supertable[6][self.go.id] = self.go.equipmentitem and self.go.equipmentitem:getCriticalChance() or 0
	local secondaryAction = self.go.item:getSecondaryAction()
	local secondary = nil
	if secondaryAction ~= nil and self.go:getComponent(secondaryAction):getClass() ~= "CastSpellComponent" then
		secondary = self.go:getComponent(secondaryAction)
	end
	
	-- Ranged Weapons skill bonus
	-- self:setAttackPower(self:getAttackPower() * (1 + champion:getSkillLevel("ranged_weapons") * 0.2))
	
	-- All physical attack boosts
	self:setAttackPower(self:getAttackPower() * empowerElement(champion, "physical", 1))	
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "ranged", 1))
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "missile", 1))
	
	if champion:hasTrait("precision") then
		self:setAttackPower(self:getAttackPower() + (math.random() * 20 + 5))
	end
	
	local id = champion:getOrdinal()
	if champion:hasTrait("magic_missile") then
		delayedCall("functions", 0.1, "psionicArrow", id)
	end

	if not item.go.equipmentitem then item.go:createComponent("EquipmentItem", "equipmentitem") end	
	local real_crit = tinker_item[6][name] and tinker_item[6][name] or supertable[6][name]
	if self.go.equipmentitem then self.go.equipmentitem:setCriticalChance(real_crit) end
	
	-- Missile Double shot
	if self ~= secondary then
		if get_c("double_attack", c) == nil then
			processSecondAttack(self, champion, "missile", slot)		
		else
			set_c("double_attack", c, nil)
		end
	end
end

function psionicArrow(id)
	local champion = party.party:getChampionByOrdinal(id)
	local spell = spells_functions.script.defByName["psionic_arrow"]
	spell.onCast(champion, party.x, party.y, party.facing, party.elevation, 3)
end

function duelistSword(id, itemName, slot)
	local slots = {2, 1}
	local otherslot = slots[slot]
	local champion = party.party:getChampionByOrdinal(id)
	champion:attack(otherslot, false)
end

corsairItem = nil
corsairItemId = nil

function onFirearmAttack(self, champion, slot)
	functions.script.set_c("grazed_bullet", champion:getOrdinal(), false)
	if math.random() < 0.25 - (champion:getSkillLevel("firearms") * 0.05) then
		self:setAttackPower(self:getAttackPower() * 0.2)
		functions.script.set_c("grazed_bullet", champion:getOrdinal(), true)
	end
	
	if champion:hasTrait("precision") then
		if not self:getPierce() then
			self:setPierce(supertable[4][self.go.id] + (math.random() * 15 + 5))
		else
			self:setPierce(self:getPierce() + (math.random() * 15 + 5))
		end	
	end
	
	-- All physical attack boosts
	self:setAttackPower(self:getAttackPower() * empowerElement(champion, "physical", 1))
	
	-- Silver Bullet trait - Double damage on 6th shot
	if champion:hasTrait("silver_bullet") then
		if get_c("silver_bullet", champion:getOrdinal()) == nil then
			set_c("silver_bullet", champion:getOrdinal(), -1)
		end
		local trigger = 6
		if champion:hasTrait("fast_fingers") then
			trigger = trigger - math.floor(champion:getCurrentStat("dexterity") / 20)
		end
		set_c("silver_bullet", champion:getOrdinal(), (get_c("silver_bullet", champion:getOrdinal()) + 1) % trigger )
		if get_c("silver_bullet", champion:getOrdinal()) == trigger - 1 then
			self:setAttackPower(self:getAttackPower() * 2.0)
		end
	end
	
	-- Sea Dog Trait - Firearm damage increase in the front
	if champion:hasTrait("sea_dog") and (champion:getOrdinal() == 1 or champion:getOrdinal() == 2) then
		self:setAttackPower(self:getAttackPower() * 1.25)
	end	

	-- Tinkerer's reduction to damage before conversion
	if champion:getClass() == "tinkerer" then
		self:setAttackPower(self:getAttackPower() * 0.5 )
	end
	
	if champion:getClass() == "corsair" then
		local item = champion:getItem(slot)
		local item2 = champion:getOtherHandItem(slot)
		local slots = {2, 1}
		local otherslot = slots[slot]
		local pellets = nil
		local pelletsSlot = nil
		
		-- Firearms power up
		-- if item ~= nil and item:hasTrait("firearm") then
			-- local attackPower = self:getAttackPower()
			-- if tinker_item[1][name] then attackPower = tinker_item[1][name] end
			-- self:setAttackPower(math.floor(attackPower * (1.05 + (champion:getLevel() * 0.02))))
			-- self:setRange(self:getRange() + champion:getSkillLevel("firearms"))
		-- end
		
		if (item and item:hasTrait("firearm")) and (item2 and item2:hasTrait("firearm")) then
			self:setAttackPower(math.floor(self:getAttackPower() * (1.1 + ((champion:getLevel()-1) * 0.1))))
		end
		
		if item.go.name ~= "revolver" then
			for i=1,32 do
				if champion:getItem(i) ~= nil and champion:getItem(i).go.name == "pellet_box" then 
					pellets = champion:getItem(i)
					pelletsSlot = i
				end
			end
			if pelletsSlot ~= nil then
				local stack = pellets:getStackSize()
				if stack > 1 then pellets:setStackSize(stack-1)	else champion:removeItemFromSlot(pelletsSlot) end
				if item2 then -- if other hand has an item
					if item2.go.name ~= "pellet_box" then
						corsairItem = item2.go.name
						
						if item2:hasTrait("upgraded") then
							tinker_item[11][item2.go.id] = item2.go.item:getUiName()
							tinker_item[1][item2.go.id] = supertable[1][item2.go.id]
							tinker_item[2][item2.go.id] = supertable[2][item2.go.id]
							tinker_item[4][item2.go.id] = supertable[4][item2.go.id]
							tinker_item[5][item2.go.id] = supertable[5][item2.go.id]
							tinker_item[6][item2.go.id] = supertable[6][item2.go.id]
							tinker_item[7][1][item2.go.id] = supertable[7][1][item2.go.id]
							tinker_item[7][2][item2.go.id] = supertable[7][2][item2.go.id]
							tinker_item[7][3][item2.go.id] = supertable[7][3][item2.go.id]
							tinker_item[7][4][item2.go.id] = supertable[7][4][item2.go.id]
							tinker_item[8][1][item2.go.id] = supertable[8][1][item2.go.id]
							tinker_item[8][2][item2.go.id] = supertable[8][2][item2.go.id]
							tinker_item[8][3][item2.go.id] = supertable[8][3][item2.go.id]
							tinker_item[8][4][item2.go.id] = supertable[8][4][item2.go.id]
							tinker_item[8][5][item2.go.id] = supertable[8][5][item2.go.id]
							tinker_item[8][6][item2.go.id] = supertable[8][6][item2.go.id]
							tinker_item[14][item2.go.id] = supertable[14][item2.go.id]
							for j=1,18 do
								if item2:hasTrait("upgraded"..j) then tinker_item[12][item2.go.id] = "upgraded"..j end
							end
						end
						
						corsairItemId = item2.go.id
						champion:removeItemFromSlot(otherslot)
						champion:insertItem(otherslot, spawn("pellet_box").item)
					else
						corsairItem = nil
					end
				else -- if other hand is empty
					corsairItem = nil
					champion:insertItem(otherslot, spawn("pellet_box").item)
				end
			end
		end
	end
end

function onPostFirearmAttack(self, champion, slot, secondary2)
	local item = self.go.item
	if champion:getClass() == "corsair" then
		local slots = {2, 1}
		local otherslot = slots[slot]		
		if corsairItem ~= nil and item.go.name ~= "revolver" then
			champion:removeItemFromSlot(otherslot)
			local newItem = spawn(corsairItem).item
			
			if tinker_item[11][corsairItemId] then newItem:setUiName(tinker_item[11][corsairItemId]) end
			if tinker_item[14][corsairItemId] then newItem:setWeight(tinker_item[14][corsairItemId]) end
			if tinker_item[12][corsairItemId] then newItem:addTrait(tinker_item[12][corsairItemId]) newItem:addTrait("upgraded") end
			if tinker_item[1][corsairItemId] then newItem.go.firearmattack:setAttackPower(tinker_item[1][corsairItemId]) end
			if tinker_item[2][corsairItemId] then newItem.go.firearmattack:setCooldown(tinker_item[2][corsairItemId]) end
			if tinker_item[4][corsairItemId] then newItem.go.firearmattack:setPierce(tinker_item[4][corsairItemId]) end
			newItem.go:createComponent("EquipmentItem")
			if tinker_item[5][corsairItemId] then newItem.go.equipmentitem:setAccuracy(tinker_item[5][corsairItemId]) end
			if tinker_item[6][corsairItemId] then newItem.go.equipmentitem:setCriticalChance(tinker_item[6][corsairItemId]) end
			if tinker_item[7][1][corsairItemId] then newItem.go.equipmentitem:setResistFire(tinker_item[7][1][corsairItemId]) end
			if tinker_item[7][2][corsairItemId] then newItem.go.equipmentitem:setResistShock(tinker_item[7][2][corsairItemId]) end
			if tinker_item[7][3][corsairItemId] then newItem.go.equipmentitem:setResistCold(tinker_item[7][3][corsairItemId]) end
			if tinker_item[7][4][corsairItemId] then newItem.go.equipmentitem:setResistPoison(tinker_item[7][4][corsairItemId]) end
			
			champion:insertItem(otherslot, newItem)			
			
			if secondary2 == 0 and champion:getItem(otherslot) and champion:getItem(otherslot):hasTrait("firearm") then
				secondary = 1
				set_c("double_attack", champion:getOrdinal(), otherslot)
				delayedCall("functions", 0.25, "doSecondShot", champion:getOrdinal(), otherslot)
			else
				secondary = 0
			end
		end
	end
	
	-- Pellet saving
	local saveChance = 0
	if champion:hasTrait("metal_slug") and item.go.name ~= "revolver" then
		saveChance = saveChance + 0.07
	end

	for slot = ItemSlot.Weapon, ItemSlot.Bracers do
		local item = champion:getItem(slot)
		local isHandItem = isHandItem(item, slot)
		if item and isHandItem then
			if item:hasTrait("metal_slug1") then -- Items with metal_slug trait
				saveChance = saveChance + 0.03
			elseif item:hasTrait("metal_slug2") then
				saveChance = saveChance + 0.05
			elseif item:hasTrait("metal_slug3") then
				saveChance = saveChance + 0.07
			end
		end	
	end

	if saveChance > 0 then
		local pelletsSlot = nil
		local pellets = nil
		if math.random() < saveChance then
			for i=1, ItemSlot.BackpackLast do
				if champion:getItem(i) ~= nil and champion:getItem(i).go.name == "pellet_box" then
					pellets = champion:getItem(i)
					pelletsSlot = i
					local stack = pellets:getStackSize()
					pellets:setStackSize(stack+1)
					break
				end
			end
		end
	end
end

function processSecondAttack(self, champion, type, slot)
	local c = champion:getOrdinal()
	local chance = 0
	local delay = 0.25
	local otherItem = nil
	local otherSlotList = {2,1}	
	local item = self.go.item

	-- Rogue Set
	if isArmorSetEquipped(champion, "rogue") then
		chance = chance + 0.25
	end

	if type == "melee" then
		delay = 0.3

		-- Double Attack trait
		if champion:hasTrait("improved_dual_wield") and self.go.meleeattack and getTrait(champion, item, "light_weapon") then
			chance = chance + 0.2
		end

		-- Items
		if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "steel_knuckles" then
			if (item and getTrait(champion, item, "light_weapon")) or (item and item:hasTrait("staff")) then
				chance = (champion:getItem(ItemSlot.Gloves):hasTrait("upgraded") and chance + 0.12 or chance + 0.06 )
			end
		end

	elseif type == "throwing" then
		-- Double Shot trait
		if champion:hasTrait("double_shot") and self.go.throwattack then
			chance = 1
		end

		if math.random() <= chance then
			local otherItem = champion:getOtherHandItem(slot)
			
			if otherItem and otherItem.go.throwattack then
				slot = otherSlotList[slot]
			elseif item and item:getStackSize() > 1 then
				slot = slot
			end
		end

	elseif type == "missile" then
		-- Double Shot trait
		if champion:hasTrait("double_shot") and self.go.rangedattack then
			chance = 1
		end
	end
	
	if math.random() <= chance then
		set_c("double_attack", c, slot)
		delayedCall("functions", delay, "doSecondShot", c, slot, chance)
	end
end

function doSecondShot(c, slot, chance)
	local champion = party.party:getChampionByOrdinal(c)
	chance = chance and chance or 1	
	champion:attack(get_c("double_attack", c), false)
	set_c("double_attack", c, nil)

	-- Third attack with ranged attacks when chance is over 1
	chance = math.max(chance - 1, 0)
	if chance > 0 then 
		local item = champion:getItem(slot)
		if math.random() <= chance and item and (item.go.rangedattack or item.go.throwattack) then
			set_c("double_attack", champion:getOrdinal(), slot)
			delayedCall("functions", 0.3, "doSecondShot", champion:getOrdinal(), slot)
		end
	end
end

function reload(self, champion, slot)
	if champion:getClass() == "corsair" then
		local item = champion:getItem(slot)
		local item2 = champion:getOtherHandItem(slot)
		local slots = {2, 1}
		local otherslot = slots[slot]
		local pellets = nil
		local pelletsSlot = nil
		for i=1,32 do
			if champion:getItem(i) ~= nil and champion:getItem(i).go.name == "pellet_box" then 
				pellets = champion:getItem(i)
				pelletsSlot = i
			end
		end
		if pelletsSlot ~= nil then
			local stack = pellets:getStackSize()
			if item2 ~= nil then -- if other hand has an item
				if item2.go.name ~= "pellet_box" then
					corsairItem = item2.go.name
					champion:removeItemFromSlot(otherslot)
					champion:insertItem(otherslot, spawn("pellet_box").item)
					champion:getItem(otherslot):setStackSize(pellets:getStackSize())
					champion:removeItemFromSlot(pelletsSlot)
					delayedCall("functions", 0.0, "reloadAfter", champion:getOrdinal(), corsairItem, slot, pelletsSlot)
				else
					corsairItem = "none"
				end
			else -- if other hand is empty
				corsairItem = "none"
				champion:insertItem(otherslot, spawn("pellet_box").item)
				champion:getItem(otherslot):setStackSize(pellets:getStackSize())
				champion:removeItemFromSlot(pelletsSlot)
				
				delayedCall("functions", 0.0, "reloadAfter", champion:getOrdinal(), corsairItem, slot, pelletsSlot)
			end
		end	
	end
end

function reloadAfter(id, cItem, slot, pelletsSlot)
	local champion = party.party:getChampionByOrdinal(id)
	local slots = {2, 1}
	local otherslot = slots[slot]
	
	local stack = champion:getItem(otherslot):getStackSize()
	if cItem ~= "none" then
		champion:removeItemFromSlot(otherslot)
		champion:insertItem(otherslot, spawn(cItem).item)
		champion:insertItem(pelletsSlot, spawn("pellet_box").item)
		champion:getItem(pelletsSlot):setStackSize(stack)
	else
		champion:removeItemFromSlot(otherslot)
		champion:insertItem(pelletsSlot, spawn("pellet_box").item)
		champion:getItem(pelletsSlot):setStackSize(stack)
	end
end

function changeSecondary(champion, multi, property)
	for i=ItemSlot.Weapon,ItemSlot.OffHand do
		local item = champion:getItem(i)
		local secondary = nil
		if item then
			secondary = item.go:getComponent(item:getSecondaryAction() and item:getSecondaryAction() or "")
			if secondary then
				if property == "buildup" and supertable[13][2][item.go.id] then
					changeSecondaryBuildup(secondary, supertable[13][2][item.go.id], multi)
				elseif property == "energycost" and supertable[13][3][item.go.id] then
					changeSecondaryEnergyCost(secondary, supertable[13][3][item.go.id], multi)
				end
			end
		end
	end
end

function changeSecondaryBuildup(secondary, supertable, multi)
	secondary:setBuildup(supertable * multi)
end

function changeSecondaryEnergyCost(secondary, supertable, multi)
	secondary:setEnergyCost(supertable * multi)
end

-------------------------------------------------------------------------------------------------------
-- Reset Weapon Values                                                                               --    
-------------------------------------------------------------------------------------------------------

function reset_attack(self, champion, slot, secondary2, item)
	--local dx,dy = getForward(party.facing)
	for pos = 0,8 do
		local dx = math.floor(pos / 3) - 1
		local dy = ((pos-1) % 3) - 1
		for entity in Dungeon.getMap(party.level):entitiesAt(party.x + dx, party.y + dy) do
			--if entity.projectile then print(entity.projectile.go.name) end
			if entity.throwattack or entity.rangedattack or entity.meleeattack or entity.equipmentitem or entity.ammoitem then
				local c = champion:getOrdinal()
				local item1 = champion:getItem(ItemSlot.Weapon)
				local item2 = champion:getItem(ItemSlot.OffHand)
				
				--if (item1 and get_c("attackedWith", c) == item1.name) or (item2 and get_c("attackedWith", c) == item2.name) then end
				-- set projectile 'cast by champion' on ammo
				if entity.ammoitem then
					entity.data:set("castByChampion", c)
					entity.data:set("castByChampionFacing", party.facing)
				end
				-- set projectile 'cast by champion' for thrown weapons
				if entity.throwattack then
					if get_c("attackedWith", c) == entity.name then
						entity.data:set("castByChampion", c)
						entity.data:set("castByChampionFacing", party.facing)
					end
				end
				if entity.meleeattack then
					if get_c("attackedWith", c) == entity.name then
						entity.data:set("castByChampion", c)
						entity.data:set("projectileDamage", entity:getComponent(entity.item:getSecondaryAction()):getAttackPower())
						entity.data:set("castByChampionFacing", party.facing)
					end
				end
			end
		end
	end

	-- Reset item stats after attack
	if supertable[1][item.go.id] == nil then return end	
	functions.script.resetItem(self, self.go.id)
end

-- Monster hooks
-- MonsterComponent - champion takes damage

function onMonsterDealDamage(self, champion, damage)
	local item1 = champion:getItem(ItemSlot.Weapon)
	local item2 = champion:getOtherHandItem(ItemSlot.Weapon)
	local monster = self
	local c = champion:getOrdinal()

	-- Shield bash and blocking
	if (item1 and item1:hasTrait("shield")) or (item2 and item2:hasTrait("shield")) or isArmorSetEquipped(champion, "chitin") then
		local chance = getBlockChance(champion)
		if math.random() <= chance then
			champion:setHealth(champion:getHealth() + math.ceil(damage * 0.51))
			if champion:hasTrait("shield_bash") then
				local dx,dy = getForward(party.facing)
				local flags = DamageFlags.CameraShake
				local damageBase = math.min(champion:getProtection() + damage, 50) + math.max((champion:getProtection() + damage - 50) / 4, 0) -- get up to 50 prot, anything over 50 is divided by 4
				local damageBonus = 1 + (1 - (100 / (math.min(champion:getProtection(), 100) + 150))) -- 1.0 to 1.4 from 0 prot to 100 prot
				champion:playDamageSound()
				if champion:hasCondition("ancestral_charge") then damageBonus = damageBonus * 1.5 end
				delayedCall("functions", 0.15, "hitMonster", monster.go.id, math.ceil(damageBase * damageBonus), "CCCCCC", "Shield Bash!", "physical", champion:getOrdinal())
				--context.drawImage2("mod_assets/textures/gui/block.dds", x+48, y-68, 0, 0, 128, 75, 128, 75)
			end
			if champion:hasTrait("shield_bearer") then
				champion:setConditionValue("shield_bearer", 20)
			end
		end
	end
	
	-- Reflective Light Armor trait - recover hp and en on first hit from a monster
	if champion:hasTrait("reflective") then
		local all_light = functions.script.wearingAll(champion, "light_armor", "clothes")
		if all_light and not functions.script.get_c("reflective_monster_" .. monster.go.id, champion:getOrdinal()) then
			functions.script.set_c("reflective_damage", champion:getOrdinal(), damage)
			functions.script.set_c("reflective_monster_" .. monster.go.id, champion:getOrdinal(), true)
			champion:setConditionValue("reflective", 5)
		end
	end
end

function onChampionTakesDamage(party, champion, damage, damageType) -- champion takes damage from any source -- no reference to monsters
	-- Berserker - Berserker Rage
	for i=1,4 do
		if party:getChampion(i):getClass() == "berserker" and party:getChampion(i):isAlive() and not party:getChampion(i):hasCondition("berserker_revenge") then
			party:getChampion(i):setConditionValue("berserker_rage", 20)
		end
	end
	
	-- Brutalizer - increases damage taken
	if champion:hasTrait("brutalizer") and damageType ~= "pure" then
		local str = champion:getCurrentStat("strength")
		--champion:damage(damage * str * 0.005, "pure")
	end
	
	-- Skills
	-- Elemental Armor
	if champion:hasTrait("elemental_armor") then
		if damageType == "fire" or damageType == "cold" or damageType == "shock" then
			regainEnergy(champion:getOrdinal(), math.ceil(champion:getMaxEnergy() * 0.15))
		end
	end
	
	-- Meditation
	if champion:hasTrait("meditation") then
		regainEnergy(champion:getOrdinal(), math.ceil(champion:getMaxEnergy() * math.random(1,5) * 0.01))
	end

	-- Items
	-- Hardstone Bracelet
	if champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "hardstone_bracelet" then
		if math.random() <= 0.2 then
			champion:setConditionValue("hardstone", 10)
		end
	end

	-- Scaled Cloak
	if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "scaled_cloak" then
		if math.random() <= (champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 0.25 or 0.1) then
			spells_functions.script.elementalShields(30, champion, damageType == "fire", false, false, false)
		end
	end
end

-------------------------------------------------------------------------------------------------------
-- Attack events                                                                                     --    
-------------------------------------------------------------------------------------------------------
-- Melee attack hits monster
function monster_attacked(self, monster, tside, damage, champion) -- self = meleeattack or firearmattack
	local c = champion:getOrdinal()
	-- Pickaxe Chip effect
	if self:getUiName() == "Chip" then
		local chip = self.go.item:hasTrait("upgraded") and -2 or -1
		monster:setProtection(monster:getProtection() and monster:getProtection() + chip, 0)
		monster:showDamageText(chip.." Armor", "FFFFFF", "Chip!")
	end
	
	-- Broadside Trait
	if champion:hasTrait("broadside") and math.random() <= 0.4 then
		if self.go.firearmattack then
			local sidesX = 0
			local sidesY = 0
			if party.facing == 1 or party.facing == 3 then sidesY = 1 end
			if party.facing == 0 or party.facing == 2 then sidesX = 1 end
			for i=1,3 do
				local loop = i-2
				local dx,dy = getForward(party.facing)
				local a = spawn("broadside", monster.go.level, monster.go.x + dx + (sidesX*loop), monster.go.y + dy + (sidesY*loop), monster.go.facing, monster.go.elevation)
				if a.tiledamager then a.tiledamager:setCastByChampion(champion:getOrdinal()) a.tiledamager:setAttackPower(damage * 0.5) end
			end
		end
	end

	if champion:hasTrait("rend") and self.go.item:getSecondaryAction() and self.go:getComponent(self.go.item:getSecondaryAction()):getName() == self.go.item:getSecondaryAction() then
		local secondary = self.go:getComponent(self.go.item:getSecondaryAction() and self.go.item:getSecondaryAction() or "")
		if secondary == self and math.random() <= 0.3 then
			monster:addTrait("bleeding")
		end
	end	
		
	-- Ratling's Sneak Attack
	if functions.script.get_c("sneak_attack", champion:getOrdinal()) then
		poisonChance = poisonChance + 0.5
		functions.script.set_c("sneak_attack", champion:getOrdinal(), false)
	end
	
	-- Hunter
	if champion:getClass() == "hunter" then
		hunterCrit(c, 1, 6 + (champion:getLevel() - 1))
		if monster:hasTrait("animal") then
			wisdom_of_the_tribe_heal(champion)
			delayedCall("functions", 0.15, "hitMonster", monster.go.id, math.ceil(damage * wisdom_of_the_tribe(champion) ), "FFFFFF", nil, "physical", c)
		end
	end	
	
	-- Monk's Healing Light
	if champion:getClass() == "monk" then
		healingLight(champion, monster, damage)
	end
	
	local poisonChance = 0
	-- Venomancer for melee attacks
	if champion:hasTrait("venomancer") then	
		poisonChance = poisonChance + 0.1
	end	

	if champion:hasTrait("antivenom") then
		poisonChance = poisonChance + 0.05
	end

	-- Serpent Bracer poison chance
	if champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "serpent_bracer" then
		poisonChance = poisonChance + 0.1
	end

	-- Venomous daggers (venom edge, serpent blade)
	if self.go.item:hasTrait("poison_dagger") and monster:getHealth() >= monster:getMaxHealth() * 0.5 then
		poisonChance = poisonChance + 0.15
	end

	-- Venomfang Pick
	if self.go.item:hasTrait("poison_mace") then
		poisonChance = poisonChance + 0.05
	end

	-- Druid's poison chance from herbs effects
	if champion:getClass() == "druid" then
		local conversion = 0.8
		for slot = 8,10 do
			local druidItem = functions.script.get_c("druid_item"..slot, champion:getOrdinal())
			if druidItem then
				if druidItem == "falconskyre" then
					poisonChance = poisonChance + 0.08
				end
				if druidItem == "blackmoss" then
					conversion = conversion - 0.1
				end
			end
		end

		-- Conversion damage
		if self.go.firearmattack then
			hitMonster(monster.go.id, damage / conversion * (1 - conversion), "33CC33", nil, "poison", champion:getOrdinal())
		end
		if self.go.meleeattack then
			hitMonster(monster.go.id, damage / conversion * (1 - conversion), "33CC33", nil, "poison", champion:getOrdinal())
		end	
	end
	
	-- Tinkerer's Elemental Surge
	if champion:getClass() == "tinkerer" then
		if self.go.firearmattack then
			hitMonster(monster.go.id, damage, "CC3333", nil, "fire", champion:getOrdinal())
		end
		if self.go.meleeattack then
			hitMonster(monster.go.id, damage, "CC3333", nil, "fire", champion:getOrdinal())
		end
	end

	-- Thunder Fury
	if champion:hasTrait("thunder_fury") and getTrait(champion, self.go.item, "light_weapon") then
		if math.random() < getCrit(champion) * 0.01 then
			local dmg = getDamage(champion)
			delayedCall("functions", 0.15, "hitMonster", monster.go.id, math.random(dmg[0], dmg[1]) * 0.5, "FFFFFF", "Thunder Fury!", "shock", champion:getOrdinal())
		end
	end
	
	-- OG items effect
	if self.go.item:hasTrait("leech") then
		if monster:hasTrait("undead") then
			-- draining undeads is not wise
			monster:showDamageText("Backlash", "FF0000")
			champion:damage(damage * 0.7, "physical")
			champion:playDamageSound()
			return false
		elseif monster:hasTrait("elemental") or monster:hasTrait("construct") then
			-- elementals and constructs are immune to leech
			monster:showDamageText("Leech Immune")
			return false
		else
			champion:regainHealth(damage * (1 - champion:getHealth()/champion:getMaxHealth()) * 0.7)
		end
	end
	
	if tside == 2 then
		-- Assassin (class) backstab leech
		if champion:getClass() == "assassin_class" then
			local sap = monster:getMaxHealth() * ((get_c("assassination", c) * 0.005) + 0.02)
			delayedCall("functions", 0.15, "hitMonster", monster.go.id, sap, "CC9999", nil, "physical", c)
			champion:regainHealth(math.max(sap * (1 - (champion:getHealth() / champion:getMaxHealth())) * 0.5, 1))			
		end

		-- Assassin (trait) backstab bleed
		if champion:hasTrait("assassin") and getTrait(champion, self.go.item, "light_weapon") then
			set_c("assassin_bleed", c, true)
		end
	end

	if champion:hasTrait("assassin") and get_c("assassin_bleed", c) and math.random() <= 0.20 then
		monster:addTrait("bleeding")
		set_c("assassin_bleed", c, nil)
	end
	
	-- Killing blow effects
	if monster:getHealth() - damage <= 0 then
		if champion:getClass() == "assassin_class" and champion:hasTrait("assassination") and tside == 2 then
			assassination(champion, monster)
		end
	end

	-- Poison chance
	if poisonChance > 0 and math.random() < poisonChance then	
		monster:setCondition("poisoned", 25)
		if monster.go.poisoned then monster.go.poisoned:setCausedByChampion(champion:getOrdinal())  end
	end
end

-- MonsterComponent - monster hit by projectile
function onProjectileHitMonster(self, item, damage, damageType) -- self = monster, item = projectile
	if item.go.data:get("castByChampion") then -- random thrown items don't get this
		local champion = party.party:getChampionByOrdinal(item.go.data:get("castByChampion"))
		local facing = item.go.data:get("castByChampionFacing")
		local specialDamage = item.go.data:get("projectileDamage")
		local c = champion:getOrdinal()
		local backAttack = self.go.facing == facing
		local monster = self

		local poisonChance = 0
		-- Venomancer for melee attacks
		if champion:hasTrait("venomancer") then	
			poisonChance = poisonChance + 0.1
		end	

		if champion:hasTrait("antivenom") then
			poisonChance = poisonChance + 0.05
		end

		-- Serpent Bracer poison chance
		if champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "serpent_bracer" then
			poisonChance = poisonChance + 0.1
		end
		
		-- Druid's poison chance from herbs effects
		if champion:getClass() == "druid" then
			local conversion = 0.8
			for slot = 8,10 do
				local druidItem = functions.script.get_c("druid_item"..slot, c)
				if druidItem then
					if druidItem == "falconskyre" then
						poisonChance = poisonChance + 0.08
					end
					if druidItem == "blackmoss" then
						conversion = conversion - 0.1
					end
				end
			end

			-- Conversion damage
			if self.go.firearmattack then
				hitMonster(monster.go.id, damage / conversion * (1 - conversion), "33CC33", nil, "poison", c)
			end
			if self.go.meleeattack then
				hitMonster(monster.go.id, damage / conversion * (1 - conversion), "33CC33", nil, "poison", c)
			end	
		end
		
		-- Ratling's Sneak Attack
		if functions.script.get_c("sneak_attack", c) then
			poisonChance = poisonChance + 0.5
			functions.script.set_c("sneak_attack", c, false)
		end
		
		-- Assassination - when monster takes a hit and dies
		if self:getHealth() - damage <= 0 then
			if champion:getClass() == "assassin_class" and champion:hasTrait("assassination") and backAttack then
				assassination(champion, self)
			end
		end
		
		-- Assassin's Backstab health sap
		if champion:getClass() == "assassin_class" and backAttack then
			local sap = self:getMaxHealth() * ((get_c("assassination", c) * 0.005) + 0.02)
			delayedCall("functions", 0.15, "hitMonster", self.go.id, sap, "CC9999", nil, "physical", c)
			champion:regainHealth(math.max(sap * (1 - (champion:getHealth() / champion:getMaxHealth())) * 0.5, 1))
		end	
		
		if champion:getClass() == "hunter" then
			hunterCrit(c, 1, 6 + (champion:getLevel() - 1))
			if self:hasTrait("animal") then
				wisdom_of_the_tribe_heal(champion)
				delayedCall("functions", 0.15, "hitMonster", self.go.id, math.ceil(damage * wisdom_of_the_tribe(champion) ), "339933", nil, damageType, champion:getOrdinal())
			end	
		end	
		
		-- Monk's Healing Light
		if champion:getClass() == "monk" then
			healingLight(champion, monster, damage)
		end

		-- Poison chance
		if poisonChance > 0 and math.random() < poisonChance then	
			monster:setCondition("poisoned", 25)
			if monster.go.poisoned then monster.go.poisoned:setCausedByChampion(c)  end
		end

		if specialDamage then
			hitMonster(monster.go.id, specialDamage, "FFFFFF", nil, "physical", c)
			return false
		else
			return true
		end
	end
end

-- MonsterComponent - monster takes damage from any source
function onDamageMonster(self, damage, damageType)
	local resistances = self:getResistance(damageType)
	local monster = self
	for i=1,4 do
		local champion = party.party:getChampionByOrdinal(i)
		if functions.script.get_c("championUsedMagic", i) then
			-- Elemental Exploitation
			if functions.script.get_c("elemental_exploitation", i) and champion:hasTrait("elemental_exploitation") and resistances == "weak" then
				delayedCall("functions", 0.25, "hitMonster", self.go.id, math.ceil(damage * 0.25), "FF0000", nil, damageType, champion:getOrdinal())
				functions.script.set_c("elemental_exploitation", i, nil)
			end
			
			-- Ritual
			if functions.script.get_c("ritual", i) and champion:hasTrait("ritual") then
				for j=1,4 do
					local c = party.party:getChampionByOrdinal(j)
					if c:isAlive() then
						c:regainHealth(math.ceil(damage * 0.05))
					end
				end
				if champion:isAlive() then
					champion:regainHealth(math.ceil(damage * 0.05))
				end
				functions.script.set_c("ritual", i, nil)
			end
			
			-- Hunter's Wisdom of the Tribe -- when hit with magic
			if functions.script.get_c("wisdom_of_the_tribe", i) and champion:getClass() == "hunter" then
				functions.script.hunterCrit(champion:getOrdinal(), 1, 6 + (champion:getLevel() - 1))
				if self:hasTrait("animal") then
					functions.script.wisdom_of_the_tribe_heal(champion)
					delayedCall("functions", 0.15, "hitMonster", self.go.id, math.ceil(damage * functions.script.wisdom_of_the_tribe(champion)), "339933", nil, damageType, champion:getOrdinal())
				end
				functions.script.set_c("wisdom_of_the_tribe", i, nil)
			end
			
			-- Monk's Healing Light
			if champion:getClass() == "monk" then
				if damage then
				healingLight(champion, monster, damage)
				end
			end
			
			-- Druid's Herb effects
			if champion:getClass() == "druid" then
				local health = 0
				local energy = 0
				for slot = 8,10 do
					local druidItem = functions.script.get_c("druid_item"..slot, champion:getOrdinal())
					if druidItem and damageType == "poison" then
						if druidItem == "blooddrop_cap" then
							health = health + 25
						elseif druidItem == "etherweed" then
							energy = energy + 25
						end
					end
				end
				if health > 0 then
					champion:regainHealth(damage * math.random(health/3,health) * 0.01)
				end
				if energy > 0 then
					regainEnergy(champion:getOrdinal(), damage * math.random(health/3,health) * 0.01)
				end
			end
			
			functions.script.set_c("championUsedMagic", i, nil)
		end	
	end
end

-- MonsterComponent - monster dies
function onMonsterDie(self)
	-- Carnivorous, spawns meat
	if self:hasTrait("animal") and math.random() < 0.08 then -- 8% chance
		for i=1,4 do
			if party.party:getChampion(i):hasTrait("carnivorous") then
				local common = {"warg_meat", "sausage", "rat_shank", "mole_jerky", "lizard_stick"}
				local rare = {"snake_tail", "toad_tongue", "turtle_steak" }
				if math.random() < 0.75 then
					spawn(common[math.ceil(math.random() * 5)], self.level, self.x, self.y, self.facing, self.elevation)
					break
				else
					spawn(common[math.ceil(math.random() * 3)], self.level, self.x, self.y, self.facing, self.elevation)
					break
				end
			end
		end
	end
end

function onAnimationEvent(self, event)
	local monster = self.go.monster
	if not monster then return end
	
end

function hitMonster(id, damage, color, flair, damageType, championId)
	local monster = findEntity(id).monster
	local champion = party.party:getChampionByOrdinal(championId)
	if not monster then return end
	local resistances = monster:getResistance(damageType)
	color = "CCCCCC"
	if monster:getHitEffect() and monster:getCurrentAction() ~= "damaged" then
		local particle = monster.go.hit_effect and monster.go.hit_effect or monster.go:createComponent("Particle", "hit_effect")
		particle:setParticleSystem(monster:getHitEffect())
		particle:restart()
		particle:setOffset(vec(0,monster:getCapsuleHeight() * 2.5,0))
	end
	
	local tside = math.random(1,4) - 1
	local anim = ""
	if monster:getCurrentAction() == nil then
		if tside == 0 then
			if champion == party.party:getChampion(1) or champion == party.party:getChampion(3) then
				anim = "getHitFrontRight"
			else
				anim = "getHitFrontLeft"
			end
		elseif tside == 1 then
			anim = "getHitRight"
		elseif tside == 2 then
			anim = "getHitBack"
		elseif tside == 3 then
			anim = "getHitLeft"
		end
	
		if not monster.go.damaged then
			monster.go:createComponent("MonsterAction","damaged")
		end
		monster.go.damaged:setAnimation(anim)
		monster:performAction("damaged")
	end

	damage = empowerElement(champion, damageType, damage)

	if damageType == "physical" then
		local protection = monster:getProtection() * (0.5 + math.random())
		damage = math.max(damage - protection, 0)
	end

	if resistances == "weak" then
		color = "FF0000"
		damage = damage * 2
	elseif resistances == "vulnerable" then
		color = "CC0000"
		damage = damage * 1.5
	elseif resistances == "resist" then
		color = "CCCCCC"
		damage = damage * 0.5
	elseif resistances == "immune" then
		color = "EEEEEE"
		damage = damage * 0
	elseif resistances == "absorb" then
		color = "00FF00"
		damage = damage * -1
	end

	damage = math.ceil(damage)
	if flair then
		monster.go.monster:showDamageText("" .. damage, color, flair) 
	else 
		monster.go.monster:showDamageText("" .. damage, color) 
	end
	
	-- Druid's Herb effects
	if champion:getClass() == "druid" and damageType == "poison" then
		local health = 0
		local energy = 0
		for slot = 8,10 do
			local druidItem = functions.script.get_c("druid_item"..slot, champion:getOrdinal())
			if druidItem then
				if druidItem == "blooddrop_cap" then
					health = health + 25
				elseif druidItem == "etherweed" then
					energy = energy + 25
				end
			end
		end
		if health > 0 then
			champion:regainHealth(damage * math.random(health/3,health) * 0.01)
		end
		if energy > 0 then
			regainEnergy(champion:getOrdinal(), damage * math.random(health/3,health) * 0.0)
		end
	end
	
	-------
	monster:setHealth(monster:getHealth() - damage)
	
	monster.go.brain:stopGuarding()
	monster.go.brain:pursuit()
	if monster:getHealth() <= 0 then
		monster:die()
	end
end

-------------------------------------------------------------------------------------------------------
-- Misc Functions                                                                                    --    
-------------------------------------------------------------------------------------------------------

function bite(id)
	local champion = party.party:getChampionByOrdinal(id)
	local spell = spells_functions.script.defByName["liz_bite"]
	spell.onCast(champion, party.x, party.y, party.facing, party.elevation)
end

function wisdom_of_the_tribe(champion)
	local willpower = champion:getCurrentStat("willpower")
	local addWillpower = ((willpower+1)^(1-1.5) - 1) / (1-1.5) * 1.5
	addWillpower = addWillpower - 2
	addWillpower = math.max(addWillpower, 0)
	return addWillpower
end

function wisdom_of_the_tribe_heal(champion)
	local missing = champion:getMaxHealth() - champion:getHealth()
	champion:regainHealth(missing * 0.05)
end

function assassination(champion, monster)
	champion:removeTrait("assassination")
	local stat = math.random(1,4)
	local expAdd = math.floor(20 + (champion:getLevel()^1.5 * 50))
	if stat == 1 then
		champion:addStatModifier("strength", 1)
		hudPrint(champion:getName() .. " gained +1 Strength and " .. expAdd .. " Exp after the assassination.")		
	elseif stat == 2 then
		champion:addStatModifier("dexterity", 1)
		hudPrint(champion:getName() .. " gained +1 Dexterity and " .. expAdd .. " Exp after the assassination.")
	elseif stat == 3 then
		champion:addStatModifier("vitality", 1)
		hudPrint(champion:getName() .. " gained +1 Vitality and " .. expAdd .. " Exp after the assassination.")
	elseif stat == 4 then
		champion:addStatModifier("willpower", 1)
		hudPrint(champion:getName() .. " gained +1 Willpower and " .. expAdd .. " Exp after the assassination.")
	end
	champion:gainExp(expAdd)
	add_c("assassination", champion:getOrdinal(), 1)
	monster:showDamageText("Assassination!", "FF7700")
	playSound("assassination")
end

function healingLight(champion, monster, damage)
	local healingLight = functions.script.get_c("healinglight", champion:getOrdinal())
	local healingMax = 500 + ((champion:getLevel() ^ 2) * 75)
	if not healingLight then healingLight = 0 end
	if healingLight >= healingMax then return end -- don't charge if full
	if champion:getConditionValue("healing_light") > 0 then return end -- don't charge if full
	local randAdd = (math.random(20) * 0.01) + 1
	if monster:getHealth() - damage <= 0 then
		healingLight = healingLight + (damage * 2 * randAdd) + (healingMax / 10)
	else
		healingLight = healingLight + (damage * randAdd) + 100
	end
	if healingLight >= healingMax then
		functions.script.set_c("healinglight", champion:getOrdinal(), healingMax)
		
		local bonus = math.floor(champion:getLevel() / 4) * 3
		champion:setConditionValue("healing_light", 12 + bonus)
		playSound("monk_light")
		local pairs = { 2, 1, 4, 3 }
		for j=1,4 do
			if party.party:getChampion(j) == champion then				
				party.party:getChampion(pairs[j]):setConditionValue("healing_light2", 12 + bonus)
			end
		end
	else
		functions.script.set_c("healinglight", champion:getOrdinal(), healingLight)
	end
end

function wearingAll(champion, armor, armor2)
	if armor2 == nil then armor2 = armor end
	local wearing_all = true
	local equip_slots = {3,9,4,5,6}
	for i, v in pairs(equip_slots) do
		if champion:getItem(v) ~= nil then
			if (not champion:getItem(v):hasTrait(armor)) and (not champion:getItem(v):hasTrait(armor2)) then	
				wearing_all = false
				if v == 3 or v == 9 then -- head and gloves
					if armor == "heavy_armor" and champion:hasTrait("armor_training") then
						wearing_all = true
					end
				end
			end
		else
			wearing_all = false
		end
	end
	return wearing_all
end

function elementalistPower(element, champion, power, return_only)
	if champion:getClass() == "elementalist" then
		local level = champion:getLevel()
		local shield_dur = 10 + (math.floor((level - 1) / 3) * 3)
		if return_only then 
			if element == "fire" then
				if champion:hasCondition("elemental_balance_cold") or champion:hasCondition("elemental_balance_air") then
					power = power * 1.25
				end

			elseif element == "cold" then
				if champion:hasCondition("elemental_balance_fire") or champion:hasCondition("elemental_balance_air") then
					power = power * 1.25
				end

			elseif element == "shock" then
				if champion:hasCondition("elemental_balance_cold") or champion:hasCondition("elemental_balance_fire") then
					power = power * 1.25
				end
			end
		else
			if element == "fire" then
				spells_functions.script.addConditionValue("elemental_balance_fire", 15, champion:getOrdinal())
				if champion:hasCondition("elemental_balance_cold") or champion:hasCondition("elemental_balance_air") then
					power = power * 1.25
					delayedCall("functions", 0.5, "regainEnergy", champion:getOrdinal(), champion:getMaxEnergy() * (0.05 + champion:getCurrentStat("willpower") * 0.001))
					champion:removeCondition("elemental_balance_cold")
					champion:removeCondition("elemental_balance_air")
				end
				champion:removeCondition("elemental_balance_cold")
				champion:removeCondition("elemental_balance_air")
				spells_functions.script.elementalShieldSingle(shield_dur, champion, true, false, false, false)
				
			elseif element == "cold" then
				spells_functions.script.addConditionValue("elemental_balance_cold", 15, champion:getOrdinal())
				if champion:hasCondition("elemental_balance_fire") or champion:hasCondition("elemental_balance_air") then
					power = power * 1.25
					delayedCall("functions", 0.5, "regainEnergy", champion:getOrdinal(), champion:getMaxEnergy() * (0.05 + champion:getCurrentStat("willpower") * 0.001))
					champion:removeCondition("elemental_balance_fire")
					champion:removeCondition("elemental_balance_air")
				end
				champion:removeCondition("elemental_balance_fire")
				champion:removeCondition("elemental_balance_air")
				spells_functions.script.elementalShieldSingle(shield_dur, champion, false, false, true, false)
				
			elseif element == "shock" then
				spells_functions.script.addConditionValue("elemental_balance_air", 15, champion:getOrdinal())
				if champion:hasCondition("elemental_balance_cold") or champion:hasCondition("elemental_balance_fire") then
					power = power * 1.25
					delayedCall("functions", 0.5, "regainEnergy", champion:getOrdinal(), champion:getMaxEnergy() * (0.05 + champion:getCurrentStat("willpower") * 0.001))
					champion:removeCondition("elemental_balance_cold")
					champion:removeCondition("elemental_balance_fire")
				end
				champion:removeCondition("elemental_balance_cold")
				champion:removeCondition("elemental_balance_fire")
				spells_functions.script.elementalShieldSingle(shield_dur, champion, false, true, false, false)
			end
		end
		return power
	end
end

function regainEnergy(id, amount)
	if not id then return end
	if not amount then return end
	local champion = party.party:getChampionByOrdinal(id)
	local lore_master = functions.script.get_c("lore_master_9", champion:getOrdinal()) or 1
	amount = math.ceil(amount * lore_master)
	champion:regainEnergy(amount)
end

function championBleed(champion, action)
	local multi = { 0.01, 0.03 }
	if action == "moving" then multi = { 0.03, 0.1 } end
	if action == "attacking" then multi = { 0.05, 0.1 } end
	if action == "dot" then multi = { 0.01, 0.03 } end

	champion:damage(math.random(champion:getMaxHealth() * multi[1], champion:getMaxHealth() * multi[2]), "bleed")
	champion:playDamageSound()
	-- Remove bleeding - 1% chance per tick or 5% if the bleeding duration is below half (30s)
	local chance = champion:getConditionValue("bleeding") < 30 and 0.05 or 0.01	
	if math.random() <= chance then
		champion:removeCondition("bleeding")
	end
end

function bleed(monster, action) -- Called by monsters within their MonsterMove object
	if monster:hasTrait("bleeding") and monster:isAlive() then
		if math.random() < 0.05 then -- 5% chance to stop bleeding
			monster:removeTrait("bleeding")
			monster.go.model:setEmissiveColor(vec(0,0,0))
		end
		if math.random() <= 0.5 then
			if action == "walk" then
				hitMonster(monster.go.id, math.random(monster:getHealth() * 0.015, monster:getHealth() * 0.03), "FF0000", nil, "physical", 1)
			elseif action == "dot" then
				hitMonster(monster.go.id, math.random(monster:getHealth() * 0.005, monster:getHealth() * 0.01), "FF0000", nil, "physical", 1)
			end
			monster.go:createComponent("Particle", "splatter")
			monster.go.splatter:setOffset(vec(math.random() - 0.4, math.random() - 0.4 + 1, math.random() - 0.4))
			monster.go.splatter:setParticleSystem("hit_blood")
			monster.go.splatter:setDestroySelf(true)
		end
	end
end

function burnMonster(self, e, champion, monster) -- self = projectile
	local skillLevel = champion:getSkillLevel("elemental_magic")
	local baseChance = 0.2 + (skillLevel * 0.02)
		if e.name == "fireburst" and champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "forestfire_bracer" then
			baseChance = baseChance + 0.15
		end
	local chance = baseChance * (1 + (champion:getResistance("fire") * 0.02))
	local duration = math.min(math.max(math.random() * (6 + champion:getSkillLevel("elemental_magic") + champion:getSkillLevel("witchcraft")), 6), 18)

	if monster:isAlive() and math.random() <= chance then
		if chance > 1 then -- duration increses if chance over 100%
			duration = duration * chance
		end
		monster:setCondition("burning", duration)
		-- mark condition so that exp is awarded if monster is killed by the condition
		local burning = monster.go.burning
		local ordinal = self:getCastByChampion()
		if burning and ordinal then burning:setCausedByChampion(ordinal) end
	end
end

function freezeMonster(self, e, champion, monster) -- self = projectile
	local skillLevel = champion:getSkillLevel("elemental_magic")
	local baseChance = 0.2
		if e.name == "frostburst_cast" and champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "coldspike_bracelet" then
			baseChance = baseChance + 0.05
		end
	local chance = baseChance * (1 + (champion:getResistance("cold") * 0.02))
	local duration = math.min(math.max(math.random() * (2 + champion:getSkillLevel("elemental_magic") + champion:getSkillLevel("witchcraft")), 2), 10)	
		if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "nomad_mittens" then
			duration = (champion:getItem(ItemSlot.Gloves):hasTrait("upgraded") and duration + 2 or duration + 1)
		end
	--if self.go.name == "frost_burst" then end

	if monster:isAlive() and math.random() <= chance then	
		monster:setCondition("frozen", duration)
	end
end

function shock_arc(self, e, champion, monster) -- self = projectile
	local skillLevel = champion:getSkillLevel("witchcraft")
	local damage = e.tiledamager and e.tiledamager:getAttackPower() * (0.75 + skillLevel / 20) or 0
	local baseChance = 0.1
		if e.name == "shockburst" and champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "torment_bracer" then
			baseChance = baseChance + 0.1
		end
	if math.random() > baseChance * (1 + (champion:getResistance("shock") * 0.02)) then return end
	local mList = {}
	for d=0,8 do
		local dx = math.floor(d / 3) - 1
		local dy = ((d-1) % 3) - 1
		for ent in Dungeon.getMap(party.level):entitiesAt(monster.go.x + dx, monster.go.y + dy) do
			if ent.monster and ent.monster ~= monster then
				table.insert(mList, ent.monster)
			end
		end
	end
	if #mList > 0 then
		local newMonster = mList[ math.random( #mList ) ]
		if newMonster and newMonster ~= monster then
			local a = spawn("shockburst", party.level, newMonster.go.x, newMonster.go.y, newMonster.go.facing, newMonster.go.elevation)
			if a.tiledamager then 
				a.tiledamager:setCastByChampion(champion:getOrdinal()) 
				a.tiledamager:setAttackPower(damage)
			end
		end
	end
end
	
function class_skill(skill, champion)
	if skill == "sneak_attack" then
		--print("skill sneak_attack")
		set_c("sneak_attack", champion:getOrdinal(), false)
		champion:setConditionValue("sneak_attack", 100)
		champion:setConditionValue("recharging", 2)
		
	elseif skill == "ancestral_charge" then
		--print("skill ancestral_charge")
		local spell = spells_functions.script.defByName["ancestral_charge_cast"]
		spell.onCast(champion, party.x, party.y, party.facing, party.elevation, 3)
		champion:setConditionValue("recharging", 2)
	
	elseif skill == "intensify_spell" then
		--print("skill intensify_spell")
		if get_c("lastSpell", champion:getOrdinal()) then
			set_c("intensifySpell", champion:getOrdinal(), get_c("lastSpell", champion:getOrdinal()))
			--print("set intensify_spell to " .. get_c("lastSpell", champion:getOrdinal()))
		else
			--no spell to intensify
		end
		champion:setConditionValue("recharging", 2)
	
	elseif skill == "drinker" then
		--print("skill drinker")
		playSound("consume_potion")
		champion:setConditionValue("recharging", 2)
		champion:setConditionValue("drown_sorrows", 15)
		set_c("drown_sorrows_exp", champion:getOrdinal(), GameMode.getTimeOfDay())
		champion:setConditionValue("drown_sorrows_exp", 9999)
	end
end

function empowerElement(champion, element, f, return_only, tier, spell)
	return_only = return_only and return_only or false
	tier = tier and tier or 0
	spell = spell and spell or false -- defines if it's a spell or attack
	local ord = champion:getOrdinal()
	
	if spell then -- it's a spell
		
	else -- it's an attack

	end

	
	if element ~= "physical" then -- non physical
		if champion:getClass() == "elementalist" then
			f = functions.script.elementalistPower(element, champion, f, return_only)
		end
		
		if champion:hasTrait("moon_rites") and GameMode.getTimeOfDay() > 1.01 then
			f = f * 1.1
		end
	end
	
	if element == "poison" then		
		-- Classes
		if champion:getClass() == "druid" then
			local multi = 0
			for slot = 8,10 do
				local druidItem = functions.script.get_c("druid_item"..slot, ord)
				if druidItem then
					if druidItem == "crystal_flower" then
						multi = multi + 0.04
					elseif druidItem == "blackmoss" then
						multi = multi + 0.10
					end
				end
			end
			f = f * (1 + multi)
		end
		
		-- Skills
		f = f * ((champion:getSkillLevel("poison_mastery") * 0.02) + 1)
		
		-- Items
		for slot = ItemSlot.Weapon, ItemSlot.Bracers do
			local item = champion:getItem(slot)
			local isHandItem = isHandItem(item, slot)
			if item and isHandItem then
				if item:hasTrait("earthbound1") then -- Items with earthbound trait gives poison damage
					f = f * 1.1
				elseif item:hasTrait("earthbound2") then
					f = f * 1.2
				elseif item:hasTrait("earthbound3") then
					f = f * 1.3
				end
			end	
		end
		
		-- Sets
		if isArmorSetEquipped(champion, "embalmers") then
			f = f * 1.15
		end
		
	elseif element == "fire" then
		-- Races
		if champion:hasTrait("lizard_blood") then
			local fire = champion:getCurrentStat("resist_fire")
			local bonus = iff(fire >= 100, 1.3, 1)
			f = f * bonus
		end

		-- Classes
		if champion:getClass() == "tinkerer" then
			f = f * ((champion:getResistance("fire") * 0.01) + 1)
		end

		-- Skills
		f = f * ((champion:getSkillLevel("elemental_magic") * 0.2) + 1)
				
		-- Fire Ruby
		local gem_charges = functions.script.get_c("ruby_charges", ord)
		if gem_charges and gem_charges > 0 then
			f = f * functions.script.get_c("ruby_power", ord)
			functions.script.set_c("ruby_charges", ord, gem_charges - 1)
		elseif gem_charges == 0 then
			functions.script.set_c("ruby_charges", ord, nil)
		end

		-- Items
		for slot = ItemSlot.Weapon, ItemSlot.Bracers do
			local item = champion:getItem(slot)
			local isHandItem = isHandItem(item, slot)
			if item and isHandItem then
				if item:hasTrait("firebound1") then -- Items with firebound trait gives fire damage
					f = f * 1.1
				elseif item:hasTrait("firebound2") then
					f = f * 1.2
				elseif item:hasTrait("firebound3") then
					f = f * 1.3
				end
			end			
		end
		
	elseif element == "cold" then
		-- Races
		if champion:hasTrait("lizard_blood") then
			local cold = champion:getCurrentStat("resist_cold")
			local bonus = iff(cold >= 100, 1.3, 1)
			f = f * bonus
		end

		-- Cold Aquamarine
		local gem_charges = functions.script.get_c("aquamarine_charges", ord)
		if gem_charges and gem_charges > 0 then
			f = f * functions.script.get_c("aquamarine_power", ord)
			functions.script.set_c("aquamarine_charges", ord, gem_charges - 1)
		elseif gem_charges == 0 then
			functions.script.set_c("aquamarine_charges", ord, nil)
		end

		-- Skills
		f = f * ((champion:getSkillLevel("elemental_magic") * 0.2) + 1)

		-- Items
		for slot = ItemSlot.Weapon, ItemSlot.Bracers do
			local item = champion:getItem(slot)
			local isHandItem = isHandItem(item, slot)
			if item and isHandItem then
				if item:hasTrait("frostbound1") then -- Items with frostbound trait gives cold damage
					f = f * 1.1
				elseif item:hasTrait("frostbound2") then
					f = f * 1.2
				elseif item:hasTrait("frostbound3") then
					f = f * 1.3
				end
				if item.go.name == "nomad_mittens" then
					f = item:hasTrait("upgraded") and f * 1.15 or f * 1.05
				end
			end
		end
		
	elseif element == "shock" then
		-- Races
		if champion:hasTrait("lizard_blood") then
			local shock = champion:getCurrentStat("resist_shock")
			local bonus = iff(shock >= 100, 1.3, 1)
			f = f * bonus
		end

		-- Classes
		if champion:getClass() == "tinkerer" then
			f = f * ((champion:getResistance("shock") * 0.01) + 1)
		end
		
		-- Skills
		f = f * ((champion:getSkillLevel("elemental_magic") * 0.2) + 1)

		-- Shock Topaz
		local gem_charges = functions.script.get_c("topaz_charges", ord)
		if gem_charges and gem_charges > 0 then
			f = f * functions.script.get_c("topaz_power", ord)
			functions.script.set_c("topaz_charges", ord, gem_charges - 1)
		elseif gem_charges == 0 then
			functions.script.set_c("topaz_charges", ord, nil)
		end

		-- Items
		for slot = ItemSlot.Weapon, ItemSlot.Bracers do
			local item = champion:getItem(slot)
			local isHandItem = isHandItem(item, slot)
			if item and isHandItem then
				if item:hasTrait("shockbound1") then -- Items with shockbound trait gives shock damage
					f = f * 1.1
				elseif item:hasTrait("shockbound2") then
					f = f * 1.2
				elseif item:hasTrait("shockbound3") then
					f = f * 1.3
				end
			end
		end
		
	elseif element == "neutral" then
		-- Classes
		if champion:getClass() == "stalker" then
			local bonus = champion:hasTrait("night_stalker") and 2 or 1
			f = f * (1 + ((champion:getCurrentStat("dexterity") * 0.01 * bonus) + (math.floor(champion:getCurrentStat("dexterity") / 7) * 0.1 * bonus)))
		end
		
		-- Skills
		if champion:hasTrait("imperium_arcana") then
			local bonus = (champion:getMaxEnergy() / 100 * 30 * 0.01) + 1
			f = f * bonus
		end
		
	elseif element == "physical" then
		-- Races
		-- Ratling's Sneak Attack
		-- if functions.script.get_c("sneak_attack", ord) then
		-- 	f = f * (1.05 + (champion:getLevel() >= 8 and 0.1 or 0) + (champion:getLevel() >= 12 and 0.1 or 0))
		-- end
		
		-- Classes
		-- Druid conversion
		if champion:getClass() == "druid" then
			local conversion = 0.2
			for slot = 8,10 do
				local druidItem = functions.script.get_c("druid_item"..slot, champion:getOrdinal())
				if druidItem and druidItem == "blackmoss" then
					conversion = conversion + 0.1
				end
			end
			f = f * (1 - conversion)
		end

		-- Tinkerer Melee conversion
		if champion:getClass() == "tinkerer" then
			f = f * 0.5
		end

		-- Skills
		if champion:hasTrait("imperium_arcana") then
			local bonus = (champion:getMaxEnergy() / 100 * 35 * 0.01) + 1
			f = f * bonus
		end
	end
	
	return f
end

function empowerAttackType(champion, attackType, multi, return_only, tier)
	local f = multi
	local ord = champion:getOrdinal()
	tier = tier and tier or 0
	if attackType == "melee" then
		-- Race bonuses
		-- Brutalizer
		if champion:hasTrait("brutalizer") then
			f = f * (1.00 + (champion:getCurrentStat("strength") * 0.01))	
		end

		-- Skill bonuses
		if champion:hasTrait("sea_dog") and (champion == party.party:getChampion(3) or champion == party.party:getChampion(4)) then
			f = f * 1.25
		end

		-- Item bonuses
		-- Steel Armband
		if champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "steel_armband" then
			local bonus = 4
			if champion:getItem(ItemSlot.Head) then bonus = bonus - 1 end
			if champion:getItem(ItemSlot.Chest) then bonus = bonus - 1 end
			if champion:getItem(ItemSlot.Legs) then bonus = bonus - 1 end
			if champion:getItem(ItemSlot.Feet) then bonus = bonus - 1 end
			if bonus > 0 then
				if secondary ~= self then
					secondary:setAttackPower(secondary:getAttackPower() * (1 + (bonus * 0.1)))
				end
			end
		end

	elseif attackType == "spell" then
		f = f * ((champion:getCurrentStat("willpower") * 0.02) + 1)

		-- Body and Mind bonus based on vitality
		if champion:hasTrait("persistence") then
			local vitality = champion:getCurrentStat("vitality")
			local addVitality = ((vitality+1)^(1-0.95) - 1) / (1-0.95) * 0.95	
			addVitality = addVitality + (champion:getCurrentStat("vitality") * 0.005)			
			f = f * (1.00 + (addVitality * 0.1))
		end

		-- Arcane Warrior
		if tier < 3 then
			if champion:hasTrait("arcane_warrior") then
				local acc, dmg, avg = 0, 0
				dmg = functions.script.getDamage(champion)
				avg = (dmg[0] + dmg[1]) / 2 * 0.002
				acc = functions.script.getAccuracy(champion) * 0.001
				f = f * (avg + acc + 1)
			end
		end
	
	elseif attackType == "ranged" then
		-- Class bonuses
		if champion:getClass() == "assassin_class" then
			f = f * (1 + (get_c("assassination", ord) * 0.05))
		end	

		-- Skill bonuses
		f = f * ((champion:getSkillLevel("ranged_weapons") * 0.2) + 1)

		if champion:hasTrait("sea_dog") and (champion == party.party:getChampion(1) or champion == party.party:getChampion(2)) then
			f = f * 1.25
		end

		-- Item bonuses

	elseif attackType == "missile" then
		-- Item bonuses
		-- Huntsman Cloak
		if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).name == "huntsman_cloak" then
			self:setAttackPower(self:getAttackPower() * (champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 1.2 or 1.1))
		end

	elseif attackType == "throwing" then

	elseif attackType == "light_weapons" then
		-- Skill bonuses
		f = f * ((champion:getSkillLevel("light_weapons_c") * 0.2) + 1)

	elseif attackType == "heavy_weapons" then
		-- Skill bonuses
		f = f * ((champion:getSkillLevel("heavy_weapons_c") * 0.2) + 1)

		-- Power Grip
		if champion:hasTrait("power_grip") and getTrait(champion, item, "heavy_weapon") then
			local bonus = (math.floor(champion:getHealth() / 5) + (math.floor(champion:getHealth() / 100) * 10)) * 0.01
			self:setAttackPower(self:getAttackPower() * (bonus + 1))
		end	

	elseif attackType == "dual_wielding" then
		if champion:getClass() == "assassin_class" then
			f = f * 0.75
			f = f * (1 + (get_c("assassination", ord) * 0.05))
		else
			f = f * 0.6
		end

	elseif attackType == "firearms" then
		

	end
	
	return f
end

function getAccuracy(champion, slot)
	local acc = 0
	local add = nil
	if slot == nil then slot = ItemSlot.Weapon end
	local c = champion:getOrdinal()
	-- Get acc bonus from equipment
	for s = ItemSlot.Weapon, ItemSlot.Bracers do
		local item = champion:getItem(s)
		if item then
			if item.go.equipmentitem then
				add = item.go.equipmentitem:getAccuracy()
				acc = add and acc + add or acc
			end
		end
	end

	-- Get acc bonus from weapon used
	local item = champion:getItem(slot)
	if item then
		if item.go.meleeattack then
			add = item.go.meleeattack:getAccuracy()
			acc = add and acc + add or acc
		end

		if item.go.firearmattack then
			add = item.go.firearmattack:getAccuracy()
			acc = add and acc + add or acc
		end

		if (item.go.rangedattack or item.go.throwattack) and champion:hasTrait("bullseye") then
			acc = acc + 15
		end

		if item:hasTrait("mage_weapon") then
			acc = acc + (champion:getSkillLevel("spellblade") * 3)
		end
	end

	-- Wide vision
	if champion:hasTrait("wide_vision") then
		add = functions.script.get_c("wide_vision", champion:getOrdinal())
		acc = add and acc + (add * 5) or acc

		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("wide_vision") and not c:hasTrait("wide_vision_minor") then
				add = functions.script.get_c("wide_vision", c:getOrdinal())
				acc = add and acc + (add * 2) or acc
			end
		end
	end
	
	-- Corsair +10 acc vs single foe
	if champion:getClass() == "corsair" and get_c("duelist", c) == 1 then
		acc = acc + 10
	end

	-- Stalker acc bonus
	if champion:getClass() == "stalker" then
		acc = acc + ((2 + (champion:getLevel() - 1)) * (champion:hasTrait("night_stalker") and 2 or 1))
	end

	-- Accuracy skill +10 per point
	acc = acc + (champion:getSkillLevel("accuracy") * 10)

	-- Dexterity +2 per point
	acc = acc + math.max(((champion:getCurrentStat("dexterity") - 10) * 2), 0)

	-- Clutch +50 bonus
	if get_c("clutch", c) then
		acc = acc + get_c("clutch", c)
	end

	return acc
end

function getCrit(champion, slot)
	local c = champion:getOrdinal()
	local crit = 5
	local add = 0
	if slot == nil then slot = ItemSlot.Weapon end

	-- Get crit from body equips
	for s = ItemSlot.Head,ItemSlot.Bracers do
		local item = champion:getItem(s)
		if item and item.equipmentitem then
			add = item.equipmentitem:getCriticalChance() * (champion:hasTrait("weapons_specialist") and 2 or 1)
			crit = add and crit + add or crit
		end
	end

	-- Get crit from weapon used
	local item = champion:getItem(slot)
	if item then 
		if item.equipmentitem then
			add = item.equipmentitem:getCriticalChance() * (champion:hasTrait("weapons_specialist") and 2 or 1)
			crit = add and crit + add or crit
		end

		if (item.rangedattack or item.throwattack) and champion:hasTrait("bullseye") then
			crit = crit + 5
		end
	end

	-- Corsair's +5 crit vs single foe
	if champion:getClass() == "corsair" and get_c("duelist", c) == 1 then
		crit = crit + 5
	end

	-- Stalker's crit bonus
	if champion:getClass() == "stalker" then
		crit = crit + ((2 + (champion:getLevel() - 1)) * (champion:hasTrait("night_stalker") and 2 or 1))
	end

	-- Hunter's Thrill of the Hunt stacks
	if functions.script.hunter_crit[champion:getOrdinal()] then
		add = functions.script.hunter_crit[champion:getOrdinal()]
		crit = add and crit + add or crit
	end

	-- Ratling's Sneak Attack
	if champion:hasTrait("sneak_attack") and get_c("sneak_attack", champion:getOrdinal()) then
		add = get_c("sneak_attack", champion:getOrdinal())
		crit = add and crit + (add * 15) or crit
	end

	-- Critical skill +3 per point
	crit = crit + (champion:getSkillLevel("critical") * 3)

	return crit
end

function getPierce(champion, slot)
	local c = champion:getOrdinal()
	local pierce = 0
	local add = 0
	if slot == nil then slot = ItemSlot.Weapon end

	-- Get pierce from weapon used
	local item = champion:getItem(slot)
	if item then 
		if item.go.meleeattack then
			add = item.go.meleeattack:getPierce()
			pierce = add and pierce + add or pierce

			if champion:hasTrait("precision") then
				pierce = pierce + 10
			end
		end

		if item.go.firearmattack then
			add = item.go.firearmattack:getPierce()
			pierce = add and pierce + add or pierce

			if champion:hasTrait("precision") then
				pierce = pierce + 5
			end
		end
	end

	return pierce
end

-- Returns the multiplier for a weapon's damage
function getDamage(champion, slot)
	local c = champion:getOrdinal()
	if slot == nil then slot = ItemSlot.Weapon end
	local item = champion:getItem(slot)
	
	local dmg = { 0, 0 }
	if champion:hasCondition("bear_form") then
		ap = 14
		dmg[0] = math.floor(ap * 0.5)
		dmg[1] = math.ceil(ap * 1.5)
		dmg[0] = math.floor(dmg[0] + math.max((math.ceil(champion:getCurrentStat("strength") - 10) * 0.5), 1))
		dmg[1] = math.floor(dmg[1] + math.max(((champion:getCurrentStat("strength") - 10) * 1.0), 2))
		return dmg
	end

	if item then
		local ap = 0
		local itemComp = nil
		local skillLevel = 0
		if item.go.rangedattack then
			itemComp = item.go.rangedattack
			ap = itemComp:getAttackPower() or 0
			skillLevel = (champion:getSkillLevel("ranged_weapons") * 0.2) + 1
		elseif item.go.throwattack then
			itemComp = item.go.throwattack
			ap = itemComp:getAttackPower() or 0
			skillLevel = (champion:getSkillLevel("ranged_weapons") * 0.2) + 1
		elseif item.go.firearmattack then
			itemComp = item.go.firearmattack
			ap = itemComp:getAttackPower() or 0
			skillLevel = (champion:getSkillLevel("firearms") * 0.2) + 1
		elseif item.go.meleeattack then
			itemComp = item.go.meleeattack
			ap = itemComp:getAttackPower() or 0
			skillLevel = getTrait(champion, item, "heavy_weapon") and (champion:getSkillLevel("heavy_weapons_c") * 0.2) + 1 or (champion:getSkillLevel("light_weapons_c") * 0.2) + 1
		else
			dmg[0] = 0
			dmg[1] = 0
			return dmg
		end

		dmg[0] = math.floor(ap * 0.5 * skillLevel)
		dmg[1] = math.floor(ap * 1.5 * skillLevel)

		if itemComp:getBaseDamageStat() then
			dmg[0] = math.floor(dmg[0] + math.max((math.ceil(champion:getCurrentStat(itemComp:getBaseDamageStat()) - 10) * 0.5), 0))
			dmg[1] = math.floor(dmg[1] + math.max(((champion:getCurrentStat(itemComp:getBaseDamageStat()) - 10) * 1.0), 0))
		end
	else
		dmg[0] = 1 + math.max((math.ceil(champion:getCurrentStat("strength") - 10) * 0.5), 1)
		dmg[1] = 1 + math.max(((champion:getCurrentStat("strength") - 10) * 1.0), 2)
	end

	-- dmg = empowerElement(champion, "physical", dmg)

	return dmg
end

function getActionSpeed(champion)
	local speed = 1
	if champion:getClass() == "berserker" then
		local bonus = math.floor(champion:getCurrentStat("strength") / 10)
		speed = speed * (1 - (0.02 * bonus))
	end

	if champion:hasCondition("drown_sorrows") then
		speed = speed * 0.5
	end

	if champion:hasTrait("chewing") then
		speed = speed * 0.9
	end

	if champion:hasCondition("shield_bearer") then
		speed = speed * 0.85
	end

	if champion:hasTrait("chemical_processing") then
		local food = (champion:getFood()-500) / 500
		speed = speed * (1 - (0.15 * food))
	end

	if champion:hasTrait("rush") then
		local all_light = wearingAll(champion, "light_armor", "clothes")
		if all_light then
			speed = speed * 0.88
		end	
	end

	if champion:hasTrait("fast_fingers") then
		local item1 = champion:getItem(ItemSlot.Weapon)
		local item2 = champion:getOtherHandItem(ItemSlot.Weapon)
		if (item1 and item1:hasTrait("firearm")) or (item2 and item2:hasTrait("firearm")) then
			speed = speed * 0.85
		end
	end

	if champion:getClass() == "corsair" then
		local item1 = champion:getItem(ItemSlot.Weapon)
		local item2 = champion:getItem(ItemSlot.OffHand)
		if (item1 and item1:hasTrait("firearm")) or (item2 and item2:hasTrait("firearm")) then
			local level = champion:getLevel()
			speed = speed * (1.4 - (level * 0.015))
		end
	end

	if champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "bracelet_tirin" then
		speed = speed * 0.85
	end

	return speed
end

function getBlockChance(champion)
	local chance = 0.0
	local item1 = champion:getItem(ItemSlot.Weapon)
	local item2 = champion:getOtherHandItem(ItemSlot.Weapon)
	if (item1 and item1:hasTrait("shield")) or (item2 and item2:hasTrait("shield")) or isArmorSetEquipped(champion, "chitin") then
		chance = chance + 0.02
		chance = chance + champion:getSkillLevel("block") / 50
		if champion:hasTrait("block") then chance = chance + 0.08 end
		if champion:hasCondition("ancestral_charge") then chance = chance * 1.5 end
	end
	return chance
end

function getMiscResistance(champion, name)
	local c = champion:getOrdinal()
	local resist = 0
	local add = 0

	if name == "disease" then
		if champion:getRace() == "ratling" then
			return 100
		end

		for s = ItemSlot.Head,ItemSlot.Bracers do
			local item = champion:getItem(s)
			if item then
				if item.go.name == "crystal_amulet" then
					return 100
				end
			end
		end
	elseif name == "bleeding" then
		resist = get_c("bleeding_resist", c) and get_c("bleeding_resist", c) or 0
		
		for s = ItemSlot.Head,ItemSlot.Bracers do
			local item = champion:getItem(s)
			if item then
				if item.go.name == "pit_gauntlets" then
					resist = resist + 25
				end
			end
		end	

	elseif name == "poisoned" then
		resist = get_c("poisoned_resist", c) and get_c("poisoned_resist", c) or 0

		for s = ItemSlot.Head,ItemSlot.Bracers do
			local item = champion:getItem(s)
			if item then
				if item.go.name == "crystal_amulet" then
					return 100
				end
			end
		end

	end
	return resist
end

function getWoundResistance(champion)
	local c = champion:getOrdinal()
	local resist = { 0,0,0,0,0,0 }
	local add = 0

	if champion:hasTrait("endurance") then
		local slots = {3,4,5,6,9,9}
		local injuries = {"head_wound","chest_wound","leg_wound","feet_wound","left_hand_wound","right_hand_wound"}
		for index, slot in ipairs(slots) do
			local bonus = 25
			local item = champion:getItem(slot)
			if item and item:hasTrait("heavy_armor") then
				bonus = bonus * 3
			end
			
			resist[index] = resist[index] + bonus
		end
	end

	if champion:getRace() == "insectoid" then
		for i=1,6 do
			resist[i] = resist[i] + 50
		end
	end

	if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "pit_gauntlets" then
		resist[5] = resist[5] + 25
		resist[6] = resist[6] + 25
	end

	return resist
end

function isArmorSetEquipped(champion, set)
	if champion:isArmorSetEquipped(set) then
		return true
	end

	local armorSetPieces = { ["chitin"] = 5, ["valor"] = 5, ["crystal"] = 6, ["meteor"] = 6, ["bear"] = 3, ["embalmers"] = 4, ["archmage"] = 4, ["rogue"] = 5, ["makeshift"] = 5, ["reed"] = 5, ["mirror"] = 5 }
	local mainSlots = {1,2,4,5,6}
	local setCount = 0
	for i = 1,#mainSlots do
		if champion:getItem(mainSlots[i]) and champion:getItem(mainSlots[i]):getArmorSet() == set then
			setCount = setCount + 1
		end
	end

	local secondarySlots = {3,7,8,9,10} -- Head, Gloves and Accessories
	for i = 1,#secondarySlots do
		if champion:getItem(secondarySlots[i]) and champion:getItem(secondarySlots[i]):getArmorSet() == set then
			setCount = setCount + 1
		else
			-- Armor Training counts any glove and helmet as completing a set
			if champion:hasTrait("armor_training") and (secondarySlots == 3 or secondarySlots == 9) then
				setCount = setCount + 1
			end
		end
	end
	
	return setCount == armorSetPieces[set]
end

function isHandItem(item, slot) -- returns true if a held item is in the appropriate slot, so you don't gain a bonus if an armor is in the hand, etc
	if item then
		if slot == ItemSlot.Weapon or slot == ItemSlot.OffHand then
			if item.go.meleeattack or item.go.rangedattack or item.go.throwattack or item.go.firearmattack or item:hasTrait("orb") or item:hasTrait("shield") then
				return true -- item in hand is a weapon, staff, shield, etc
			else
				return false -- item in hand is not a weapon
			end
		else
			if slot ~= ItemSlot.Weapon2 and slot ~= ItemSlot.OffHand2 then
				return true -- slot isn't a hand slot and not a swapped slot
			end
		end
	end
	return true
end

function getTrait(champion, item, trait)
	if item then
		if item:hasTrait(trait) then
			return true
		else
			if champion:getClass() == "assassin_class" then
				if trait == "light_weapon" and item:hasTrait("heavy_weapon") then
					return true
				elseif trait == "heavy_weapon" and item:hasTrait("light_weapon") then
					return true
				end
			end
			return false
		end	
	end
end

function statToolTip(context, hoverTxt1, hoverTxt2, x, y, lineCount) -- Draws the tooltip text and background for the Stats tab
	local f2 = (context.height/1080)

	y = y - 18 - (lineCount * 26)
	context.color(0, 0, 0, 220)
	if x > 1500 then x = 1500 end

	local backX = x - 7
	local backY = y - 30
	local width = 412
	local height = 41 + (lineCount * 26)

	context.drawRect(backX, backY, width, height)
	context.color(255, 255, 255, 255)
	
	context.drawImage2("mod_assets/textures/gui/tooltip_border.dds", backX - 7, backY - 7, 0, 0, 7, 7, 7, 7) -- top left
	context.drawImage2("mod_assets/textures/gui/tooltip_border.dds", backX, backY - 7, 7, 0, 7, 7, width, 7) -- top
	context.drawImage2("mod_assets/textures/gui/tooltip_border.dds", backX + width, backY - 7, 14, 0, 7, 7, 7, 7) -- top right
	context.drawImage2("mod_assets/textures/gui/tooltip_border.dds", backX - 7, backY, 0, 7, 7, 7, 7, height) -- left
	context.drawImage2("mod_assets/textures/gui/tooltip_border.dds", backX - 7, backY + height, 0, 14, 7, 7, 7, 7) -- bot left
	context.drawImage2("mod_assets/textures/gui/tooltip_border.dds", backX, backY + height, 7, 14, 7, 7, width, 7) -- bottom
	context.drawImage2("mod_assets/textures/gui/tooltip_border.dds", backX + width, backY + height, 14, 14, 7, 7, 7, 7) -- bot right
	context.drawImage2("mod_assets/textures/gui/tooltip_border.dds", backX + width, backY, 14, 7, 7, 7, 7, height) -- right

	context.font("large")
	context.color(255, 255, 255, 255)
	context.drawParagraph(hoverTxt1, x, y, width - 7)
	context.font("medium")
	context.drawParagraph(hoverTxt2, x, y + 28, width - 7)
end

function drawStatNumber(context, txt, x, y) -- Draws colored numbers in the Stats tab
	context.color(255,255,255,255)
	if tonumber(txt) < 0 then 
		context.color(255,35,35,255)
	elseif tonumber(txt) == 0 then 
		context.color(255,255,255,190)
	elseif tonumber(txt) >= 100 then 
		context.color(255,255,210,255)
	end
	context.drawText(txt, x - context.getTextWidth(txt), y)
	context.color(255,255,255,255)
end

function intAlignRight(text, x, width) -- Align number right
	x = x - width
	return x
end

-------------------------------------------------------------------------------------------------------
-- Tinkerer Events                                                                                   --    
-------------------------------------------------------------------------------------------------------

tinkering_level = { 0,0,0,0 }
a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a20 = {}, {}, {}, {}, {}, {}, { {},{},{},{} }, { {},{},{},{},{},{} }, { {},{},{},{} }, {}, {}, {}, {{},{},{}}, {}
tinker_item = { a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a20  }

function tinkererUpgrade(self, champion, slot, materials)
	local item = champion:getItem(slot) -- item is in hand
	local level = champion:getSkillLevel("tinkering")
	local canUpgEpic = (champion:hasTrait("mastersmith") and item:hasTrait("epic")) or not item:hasTrait("epic")
	local upgMax = 3

	if not canUpgEpic then
		hudPrint("Only a Master Smith can upgrade Epic items.")
	end

	if item and canUpgEpic then 
		local hasMaterials = true
		for mat, value in pairs(materials) do
			local valueCountdown = value
			local matCount = 0 -- first we count how many of the material we have

			for i=1,ItemSlot.MaxSlots do
				local item2 = champion:getItem(i)
				if item2 then
					if item2.go.name == mat then
						if item2:getStackSize() > 0 then
							matCount = matCount + item2:getStackSize()
						end
					else
						local container = item2.go.containeritem
						if container then
							local capacity = container:getCapacity()
							for j=1,capacity do
								local item3 = container:getItem(j)
								if item3.go.name == mat then
									if item3:getStackSize() > 0 then
										matCount = matCount + item3:getStackSize()
									end
								end
							end
						end
					end
				end
			end

			if matCount >= value then
				while valueCountdown > 0 do
					for i=1,ItemSlot.MaxSlots do
						local item2 = champion:getItem(i)
						if item2 then
							if item2.go.name == mat then
								while item2:getStackSize() > 0 and valueCountdown > 0 do
									valueCountdown = valueCountdown - 1
									if item2:getStackSize() > 1 then
										item2:setStackSize(item2:getStackSize() - 1)
									else
										champion:removeItem(item2)
									end
								end
							else
								local container = item2.go.containeritem
								if container then
									local capacity = container:getCapacity()
									for j=1,capacity do
										local item3 = container:getItem(j)
										if item3.go.name == mat then
											if item3:getStackSize() > 0 and valueCountdown > 0 then
												valueCountdown = valueCountdown - 1
												if item3:getStackSize() > 1 then
													item3:setStackSize(item3:getStackSize() - 1)
												else
													champion:removeItem(item3)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			else
				if mat == "lock_pick" then
					hudPrint("Not enough materials - one Lock Pick is required.")
				else
					hudPrint("Not enough materials.")
				end
				return
			end
		end

		-- Upgrade Item
		local upgradeLevel = 1
		if item:hasTrait("upgraded") then
			for i = 1,upgMax do
				if item:hasTrait("upgraded"..i) then 
					upgradeLevel = i + 1
				end
			end
		end

		if upgradeLevel <= upgMax then
			-- Save base name and base weight
			if supertable[11][item.go.id] == nil then
				supertable[11][item.go.id] = item:getUiName()
				supertable[14][item.go.id] = item:getWeight()
			end

			-- Set new base info
			item:setUiName("Upgraded "..supertable[11][item.go.id].." (Level "..upgradeLevel..")")
			item:setWeight((supertable[14][item.go.id] * (1.25 - (level * 0.04) + (upgradeLevel * 0.13)) + math.floor(supertable[14][item.go.id] / 2) * 0.05) )
			item:addTrait("upgraded" .. upgradeLevel)
			item:addTrait("upgraded")
			playSound("tinker")

			-- Increase tinkering level data
			--tinkering_level[champion:getOrdinal()] = tinkering_level[champion:getOrdinal()] + 1
			
			local equipItem = item.go.equipmentitem
			
			equipType = "weapon"
			-- Upgrade weapons
			if item.go.firearmattack then
				equipItem = item.go.firearmattack
				bonus = getBonus(champion:getSkillLevel("firearms"), 0.05)
			elseif item.go.meleeattack then
				equipItem = item.go.meleeattack
				if item:hasTrait("light_weapon") then bonus = getBonus(champion:getSkillLevel("light_weapons_c"), 0.05) end
				if item:hasTrait("heavy_weapon") then bonus = getBonus(champion:getSkillLevel("heavy_weapons_c"), 0.05) end		
			elseif item.go.rangedattack then
				equipItem = item.go.rangedattack
				bonus = getBonus(champion:getSkillLevel("ranged_weapons"), 0.05)
			elseif item.go.throwattack then
				equipItem = item.go.throwattack
				bonus = getBonus(champion:getSkillLevel("ranged_weapons"), 0.05)
			elseif item.go.equipmentitem then
				equipItem = item.go.equipmentitem
				equipType = "armor"
				bonus = 0
			end
			
			local name = item.go.id .. "tinker"
			if equipItem then
				supertable[1][name] = (item.go.firearmattack or item.go.meleeattack or item.go.rangedattack or item.go.throwattack) and equipItem:getAttackPower() or 0
				supertable[2][name] = (item.go.firearmattack or item.go.meleeattack or item.go.rangedattack or item.go.throwattack) and equipItem:getCooldown() or 0
				supertable[3][name] = equipItem.go.firearmattack and equipItem:getRange() or 0
				supertable[4][name] = (item.go.firearmattack or item.go.meleeattack) and equipItem:getPierce() or 0
				supertable[5][name] = (item.go.firearmattack or item.go.meleeattack) and equipItem:getAccuracy() or (item.go.equipmentitem and item.go.equipmentitem:getAccuracy() or 0)
				supertable[6][name] = item.go.equipmentitem and item.go.equipmentitem:getCriticalChance() or 0
				supertable[7][1][name] = item.go.equipmentitem and item.go.equipmentitem:getResistFire() or 0
				supertable[7][2][name] = item.go.equipmentitem and item.go.equipmentitem:getResistShock() or 0
				supertable[7][3][name] = item.go.equipmentitem and item.go.equipmentitem:getResistCold() or 0
				supertable[7][4][name] = item.go.equipmentitem and item.go.equipmentitem:getResistPoison() or 0
				supertable[8][1][name] = item.go.equipmentitem and item.go.equipmentitem:getStrength() or 0
				supertable[8][1][name] = item.go.equipmentitem and item.go.equipmentitem:getStrength() or 0
				supertable[8][2][name] = item.go.equipmentitem and item.go.equipmentitem:getDexterity() or 0
				supertable[8][3][name] = item.go.equipmentitem and item.go.equipmentitem:getVitality() or 0
				supertable[8][4][name] = item.go.equipmentitem and item.go.equipmentitem:getWillpower() or 0
				supertable[8][5][name] = item.go.equipmentitem and item.go.equipmentitem:getHealthRegenerationRate() or 0
				supertable[8][6][name] = item.go.equipmentitem and item.go.equipmentitem:getEnergyRegenerationRate() or 0
				supertable[9][1][name] = item.go.equipmentitem and item.go.equipmentitem:getProtection() or 0
				supertable[9][2][name] = item.go.equipmentitem and item.go.equipmentitem:getEvasion() or 0
				supertable[9][3][name] = supertable[9][3][name] == nil and (item:getGameEffect() and item:getGameEffect() or "") or supertable[9][3][name]
				supertable[10][name] = supertable[10][name] and supertable[10][name] or {}

				local secondaryAction = item:getSecondaryAction()
				local secondary = nil
				if secondaryAction ~= nil and item.go:getComponent(secondaryAction):getClass() ~= "CastSpellComponent" then
					secondary = item.go:getComponent(secondaryAction)
				end
				if secondary then supertable[13][1][name] = secondary:getAttackPower() end
				if secondary then supertable[13][2][name] = secondary:getBuildup() end
				if secondary then supertable[13][3][name] = secondary:getEnergyCost() end
				
				if not item.go.equipmentitem then
					item.go:createComponent("EquipmentItem")
				end

				-- Crafting expertise bonus
				local expertise = 0
				if champion:getClass() == "tinkerer" then
					expertise = functions.script.get_c("crafting_expertise", champion:getOrdinal())
					expertise = (expertise ~= nil and expertise or 0)
				end

				local bonusList = {}
				if (item:hasTrait("light_armor") or item:hasTrait("clothes")) then
					bonusList = { "resist", "stat", "evasion" }
				elseif item:hasTrait("heavy_armor") then
					bonusList = { "resist", "stat", "protection", "protection_more" }
				elseif item:hasTrait("shield") then
					bonusList = { "resist", "stat", "protection", "protection_more", "evasion", "evasion_more" }
				elseif item:hasTrait("light_weapon") or item:hasTrait("heavy_weapon") or item:hasTrait("missile_weapon") or item:hasTrait("throwing_weapon") or item:hasTrait("firearm") then
					bonusList = { "attackPower", "cooldown", "accuracy", "critical", "resist", "stat" }
				end

				hudPrint("~~ Tinkering Results ~~")
				
				local firstBonus = ""
				firstBonus = bonusList[math.random(#bonusList)]
				local bonus = firstBonus
				for i = 1, 1 + (expertise > 0 and 1 or 0) do
					if bonus == "" then 
						bonus = bonusList[math.random(#bonusList)] 
						while bonus == firstBonus do 
							bonus = bonusList[math.random(#bonusList)] 
						end
					end

					table.insert(supertable[10][name], bonus)

					local result = 0
					if bonus == "cooldown" then
						result = (1 - (math.random(10, 15 + level) * 0.01))
						equipItem:setCooldown(supertable[2][name] * result)
						hudPrint("Cooldown improved by " .. math.abs(result-1) * 100 .. "%")

					elseif bonus == "attackPower" then
						result = (1.05 + (level * 0.05))
						equipItem:setAttackPower(math.ceil(equipItem:getAttackPower() * result))
						hudPrint("Attack Power improved by " .. (result-1) * 100 .. "%")

					elseif bonus == "accuracy" then
						if supertable[5][name] == 0 then
							result = math.random(6,12)
							if (item.go.firearmattack or item.go.meleeattack) then
								equipItem:setAccuracy(result)
							else
								item.go.equipmentitem:setAccuracy(result)
							end
							hudPrint("Gained " .. result .. " Accuracy.")
						else
							result = (1 + (math.random(24,66) * 0.01))		
							if (item.go.firearmattack or item.go.meleeattack) then
								equipItem:setAccuracy(supertable[5][name] * result)
							else
								item.go.equipmentitem:setAccuracy(supertable[5][name] * result)
							end
							hudPrint("Accuracy improved by " .. (result-1) * 100 .. "%")
						end
						
					elseif bonus == "critical" then
						if supertable[6][name] == 0 then
							result = math.random(3,6)
							item.go.equipmentitem:setCriticalChance(result)
							hudPrint("Gained " .. result .. "% Critical Chance.")
						else
							result = (1 + (math.random(75,100) * 0.01))
							item.go.equipmentitem:setCriticalChance(math.floor(supertable[6][name] * result))
							hudPrint("Critical Chance improved by " .. (result-1) * 100 .. "%")
						end
						

					elseif bonus == "resist" then
						local random_element = math.random(1,4)
						local resistMinAdd, resistMaxAdd = 6, 12
						local resistMinMulti, resistMaxMulti = 40, 80
						if random_element == 1 then
							if supertable[7][1][name] == 0 then
								result = math.random(resistMinAdd, resistMaxAdd)
								item.go.equipmentitem:setResistFire(result)
								hudPrint("Gained " .. result .. " Fire Resistance.")
							else
								result = (1 + (math.random(resistMinMulti, resistMaxMulti) * 0.01))
								item.go.equipmentitem:setResistFire(supertable[7][1][name] * result)
								hudPrint("Fire Resistance improved by " .. (result-1) * 100 .. "%")
							end
							
						elseif random_element == 2 then
							if supertable[7][2][name] == 0 then
								result = math.random(resistMinAdd, resistMaxAdd)
								item.go.equipmentitem:setResistShock(result)
								hudPrint("Gained " .. result .. " Shock Resistance.")
							else
								result = (1 + (math.random(resistMinMulti, resistMaxMulti) * 0.01))
								item.go.equipmentitem:setResistShock(supertable[7][2][name] * result)
								hudPrint("Shock Resistance improved by " .. (result-1) * 100 .. "%")
							end

						elseif random_element == 3 then
							if supertable[7][3][name] == 0 then
								result = math.random(resistMinAdd, resistMaxAdd)
								item.go.equipmentitem:setResistCold(result)
								hudPrint("Gained " .. result .. " Cold Resistance.")
							else
								result = (1 + (math.random(resistMinMulti, resistMaxMulti) * 0.01))
								item.go.equipmentitem:setResistCold(supertable[7][3][name] * result)
								hudPrint("Cold Resistance improved by " .. (result-1) * 100 .. "%")
							end

						else
							if supertable[7][4][name] == 0 then
								result = math.random(resistMinAdd, resistMaxAdd)
								item.go.equipmentitem:setResistPoison(result)
								hudPrint("Gained " .. result .. " Poison Resistance.")
							else
								result = (1 + (math.random(resistMinMulti, resistMaxMulti) * 0.01))
								item.go.equipmentitem:setResistPoison(supertable[7][4][name] * result)
								hudPrint("Poison Resistance improved by " .. (result-1) * 100 .. "%")
							end
						end

					elseif bonus == "stat" then
						local stat = math.random(1,6)
						local statMinAdd, statMaxAdd = 2, 4
						local statMinMulti, statMaxMulti = 50, 80
						if stat == 1 then
							if supertable[8][1][name] == 0 then
								result = math.random(statMinAdd, statMaxAdd)
								item.go.equipmentitem:setStrength(result)
								hudPrint("Gained " .. result .. " Strenght.")
							else
								result = (1 + (math.random(statMinMulti, statMaxMulti) * 0.01))
								item.go.equipmentitem:setStrength(supertable[8][1][name] * result)
								hudPrint("Strenght improved by " .. (result-1) * 100 .. "%")
							end

						elseif stat == 2 then						
							if supertable[8][2][name] == 0 then
								result = math.random(statMinAdd, statMaxAdd)
								item.go.equipmentitem:setDexterity(result)
								hudPrint("Gained " .. result .. " Dexterity.")
							else
								result = (1 + (math.random(statMinMulti, statMaxMulti) * 0.01))
								item.go.equipmentitem:setDexterity(supertable[8][2][name] * result)
								hudPrint("Dexterity improved by " .. (result-1) * 100 .. "%")
							end

						elseif stat == 3 then
							if supertable[8][3][name] == 0 then
								result = math.random(statMinAdd, statMaxAdd)
								item.go.equipmentitem:setVitality(result)
								hudPrint("Gained " .. result .. " Vitality.")
							else
								result = (1 + (math.random(statMinMulti, statMaxMulti) * 0.01))
								item.go.equipmentitem:setVitality(supertable[8][3][name] * result)
								hudPrint("Vitality improved by " .. (result-1) * 100 .. "%")
							end

						elseif stat == 4 then
							if supertable[8][4][name] == 0 then
								result = math.random(statMinAdd, statMaxAdd)
								item.go.equipmentitem:setWillpower(result)
								hudPrint("Gained " .. result .. " Willpower.")
							else
								result = (1 + (math.random(statMinMulti, statMaxMulti) * 0.01))
								item.go.equipmentitem:setWillpower(supertable[8][4][name] * result)
								hudPrint("Willpower improved by " .. (result-1) * 100 .. "%")
							end

						elseif stat == 5 then
							if supertable[8][5][name] == 0 then
								result = math.random(statMinAdd*5, statMaxAdd*5)
								item.go.equipmentitem:setHealthRegenerationRate(result)
								hudPrint("Gained " .. result .. "% Health Regeneration Rate.")
							else
								result = (1 + (math.random(statMinMulti*0.66, statMaxMulti*0.66) * 0.01))
								item.go.equipmentitem:setHealthRegenerationRate(supertable[8][5][name] * result)
								hudPrint("Health Regeneration Rate improved by " .. (result-1) * 100 .. "%")
							end

						else
							if supertable[8][6][name] == 0 then
								result = math.random(statMinAdd*5, statMaxAdd*5)
								item.go.equipmentitem:setEnergyRegenerationRate(result)
								hudPrint("Gained " .. result .. "% Energy Regeneration Rate.")
							else
								result = (1 + (math.random(statMinMulti*0.66, statMaxMulti*0.66) * 0.01))
								item.go.equipmentitem:setEnergyRegenerationRate(supertable[8][6][name] * result)
								hudPrint("Energy Regeneration Rate improved by " .. (result-1) * 100 .. "%")
							end
						end

					elseif bonus == "protection" then
						print("protection is " .. supertable[9][1][name])
						if supertable[9][1][name] == 0 then
							result = math.random(2, 7)
							item.go.equipmentitem:setProtection(result)
							hudPrint("Gained " .. result .. " Protection.")
						else
							result = (1 + (math.random(24,32) * 0.01))
							item.go.equipmentitem:setProtection(math.ceil(supertable[9][1][name] * result))
							hudPrint("Protection improved by " .. (result-1) * 100 .. "%")
						end
						print("protection is now " .. item.go.equipmentitem:getProtection())
						
					elseif bonus == "protection_more" then
						if supertable[9][1][name] == 0 then
							result = math.random(4, 10)
							item.go.equipmentitem:setProtection(result)
							hudPrint("Gained " .. result .. " Protection.")
						else
							result = (1 + (math.random(24,48) * 0.01))
							item.go.equipmentitem:setProtection(math.ceil(supertable[9][1][name] * result))
							hudPrint("Protection improved by " .. (result-1) * 100 .. "%")
						end

					elseif bonus == "evasion" then
						if supertable[9][2][name] == 0 then
							result = math.random(2, 7)
							item.go.equipmentitem:setEvasion(result)
							hudPrint("Gained " .. result .. " Evasion.")
						else
							result = (1 + (math.random(24,32) * 0.01))
							item.go.equipmentitem:setEvasion(supertable[9][2][name] * result)
							hudPrint("Evasion improved by " .. (result-1) * 100 .. "%")
						end
						
					elseif bonus == "evasion_more" then
						if supertable[9][2][name] == 0 then
							result = math.random(4, 12)
							item.go.equipmentitem:setEvasion(result)
							hudPrint("Gained " .. result .. " Evasion.")
						else
							result = (1 + (math.random(24,48) * 0.01))
							item.go.equipmentitem:setEvasion(supertable[9][2][name] * result)
							hudPrint("Evasion improved by " .. (result-1) * 100 .. "%")
						end
						
					end

					-- Write item's gameEffect

					local gameEffect = supertable[9][3][name] and supertable[9][3][name] or ""
					local tempTable = supertable[10][name]
					-- Remove duplicates from list of upgrades
					local hash = {}
					local res = {}
					for _,v in ipairs(tempTable) do
						if not hash[v] then
							res[#res+1] = v -- you could print here instead of saving to result table if you wanted
							hash[v] = true
						end
						tempTable = res
					end

					local linesOfTextAdded = 0
					for index, upgrade in ipairs(tempTable) do
						local newText = ""

						if upgrade == "critical" then
							newText = "Critical Chance +" .. item.go.equipmentitem:getCriticalChance() .. "%"
							linesOfTextAdded = linesOfTextAdded + 1
						end

						if newText ~= "" then
							if gameEffect ~= "" then
								item:setGameEffect(gameEffect .. "\n" .. newText)
							else
								if linesOfTextAdded == 1 then
									item:setGameEffect(gameEffect .. newText)
								else
									item:setGameEffect(gameEffect .. "\n" .. newText)
								end
							end
						end
					end	
					--

					bonus = ""
					
					if equipType == "weapon" then
						tinker_item[1][item.go.id] = equipItem:getAttackPower()
						tinker_item[2][item.go.id] = equipItem:getCooldown()
						tinker_item[3][item.go.id] = supertable[3][name]
						tinker_item[4][item.go.id] = supertable[4][name]
					end

					tinker_item[5][item.go.id] = item.go.equipmentitem:getAccuracy()
					tinker_item[6][item.go.id] = item.go.equipmentitem:getCriticalChance()

					tinker_item[7][1][item.go.id] = item.go.equipmentitem:getResistFire()
					tinker_item[7][2][item.go.id] = item.go.equipmentitem:getResistShock()
					tinker_item[7][3][item.go.id] = item.go.equipmentitem:getResistCold()
					tinker_item[7][4][item.go.id] = item.go.equipmentitem:getResistPoison()

					tinker_item[8][1][item.go.id] = item.go.equipmentitem:getStrength()
					tinker_item[8][2][item.go.id] = item.go.equipmentitem:getDexterity()
					tinker_item[8][3][item.go.id] = item.go.equipmentitem:getVitality()
					tinker_item[8][4][item.go.id] = item.go.equipmentitem:getWillpower()
					tinker_item[8][5][item.go.id] = item.go.equipmentitem:getHealthRegenerationRate()
					tinker_item[8][6][item.go.id] = item.go.equipmentitem:getEnergyRegenerationRate()

					tinker_item[9][1][item.go.id] = item.go.equipmentitem:getProtection()
					tinker_item[9][2][item.go.id] = item.go.equipmentitem:getEvasion()
					-- tinker_item[9][3][item.go.id] = item:getGameEffect()

					tinker_item[11][item.go.id] = item:getUiName()
					tinker_item[12][item.go.id] = "upgraded"..upgradeLevel

					local secondaryAction = item:getSecondaryAction()
					local secondary = nil
					if secondaryAction ~= nil and item.go:getComponent(secondaryAction):getClass() ~= "CastSpellComponent" then
						secondary = item.go:getComponent(secondaryAction)
					end

					if secondary then
						-- print(equipItem)
						-- print(secondary)
						-- print(item:getSecondaryAction())
						-- print(upgradeLevel)
						updateSecondary(equipItem, secondary, item:getSecondaryAction(), upgradeLevel)
					end

					if secondary then tinker_item[13][1][name] = secondary:getAttackPower() end
					if secondary then tinker_item[13][2][name] = secondary:getBuildup() end
					if secondary then tinker_item[13][3][name] = secondary:getEnergyCost() end

					tinker_item[14][item.go.id] = item:getWeight()

					if expertise > 0 then
						functions.script.set_c("crafting_expertise", champion:getOrdinal(), expertise - 1)
					end
				end				
			end

			setMouseItem(item)
			champion:removeItem(item)
		else
			hudPrint("Maximum level reached.")
		end
	end
end

function getBonus(skill, perLevel)
	local bonus = 1
	bonus = bonus + math.floor(skill / 5) * (perLevel * 5)
	bonus = bonus + (skill * perLevel)
	return bonus
end

-- Dismantle
dismantlePrompt = false
dismantleChampion = 0
dismantleItemSlot = 0
dismantleX, dismantleY = 0, 0

function tinkererDismantle(on, x, y, slot, id)
	dismantleX, dismantleY = x, y
	dismantlePrompt = on
	dismantleItemSlot = slot
	dismantleChampion = id
end

function tinkererGetMaterialList(item)
	local return_recipe = {["metal_bar"] = 0, ["metal_nugget"] = 0, ["leather_strips"] = 0, ["leather"] = 0, ["silk"] = 0, ["gold"] = 0, ["skull"] = 0, ["crystal_flower"] = 0, ["lock_pick"] = 1 }
	local recipes = { 
		light_weapon = { ["metal_nugget"] = 2, ["leather_strips"] = 1 } ,
		daggers = { ["metal_nugget"] = 1, ["leather_strips"] = 1 } ,
		heavy_weapon = { ["metal_bar"] = 1, ["metal_nugget"] = 1, ["leather_strips"] = 1 } ,
		light_armor = { ["leather"] = 2, ["leather_strips"] = 1 } ,
		heavy_armor = { ["metal_bar"] = 2, ["leather_strips"] = 1 } ,
		shield_metal = { ["metal_bar"] = 1, ["leather"] = 1 } ,
		shield_non_metal = { ["leather"] = 1, ["leather_strips"] = 1 } ,
		clothes = { ["leather"] = 1, ["leather_strips"] = 1 } ,
		firearm = { ["metal_nugget"] = 3 } ,
		missile_weapon = { ["metal_nugget"] = 1, ["leather_strips"] = 2 } ,

		metal_bar = { ["metal_bar"] = 1 } ,
		metal_nugget = { ["metal_nugget"] = 1 } ,
		leather_strips = { ["leather_strips"] = 1 } ,
		leather = { ["leather"] = 1 } ,
		silk = { ["silk"] = 1 } ,
		gold = { ["gold"] = 1 } ,
		skull = { ["skull"] = 1 } ,
		crystal = { ["crystal_flower"] = 1 } ,
		}

	if item:hasTrait("light_weapon") and item:hasTrait("dagger") then
		addTables(return_recipe, recipes.daggers)

	elseif item:hasTrait("light_weapon") and not item:hasTrait("dagger") then
		addTables(return_recipe, recipes.light_weapon)

	elseif item:hasTrait("heavy_weapon")  then
		addTables(return_recipe, recipes.heavy_weapon)
		if item:hasTrait("two_handed") then
			addTables(return_recipe, recipes.metal_bar)
		end
		
	elseif item:hasTrait("light_armor") then
		addTables(return_recipe, recipes.light_armor)

		if item:getArmorSet() ~= nil then
			addTables(return_recipe, recipes.leather)
			addTables(return_recipe, recipes.silk)
		end	
	elseif item:hasTrait("heavy_armor") then
		addTables(return_recipe, recipes.heavy_armor)

	elseif item:hasTrait("shield") then
		if item:hasTrait("metal") then
			addTables(return_recipe, recipes.shield_metal)
		else
			addTables(return_recipe, recipes.shield_non_metal)
		end

	elseif item:hasTrait("clothes") then
		addTables(return_recipe, recipes.clothes)

		if item:getArmorSet() ~= nil then
			addTables(return_recipe, recipes.leather)
			addTables(return_recipe, recipes.silk)
		end	

		if item:getArmorSet() == "archmage" then
			addTables(return_recipe, recipes.crystal)
		end
	elseif item:hasTrait("firearm") then
		addTables(return_recipe, recipes.firearm)

	elseif item:hasTrait("missile_weapon") then
		addTables(return_recipe, recipes.missile_weapon)
	end

	if item:getArmorSet() == "bear" then
		addTables(return_recipe, recipes.skull)
	end

	if item:hasTrait("epic") then
		if item:getArmorSet() == "meteor" then
			addTables(return_recipe, recipes.gold)
		end

		if item:getArmorSet() == "crystal" then
			addTables(return_recipe, recipes.crystal)
		end

		if item.go.meleeattack then
			addTables(return_recipe, recipes.metal_bar)
			addTables(return_recipe, recipes.metal_nugget)
			addTables(return_recipe, recipes.gold)
			addTables(return_recipe, recipes.crystal_flower)
		end
	end

	return return_recipe
end

function addTables(t1, t2)
	for entry, value in pairs(t1) do
		if t2[entry] then
			t1[entry] = t1[entry] + t2[entry]
		end
	end
	return t1
end

function merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end

function tinkererDismantleAction(id, slot)
	local materials = { metal = {"metal_bar", 0}, nugget = {"metal_nugget", 0}, leather_strips = {"leather_strips", 0}, leather = {"leather", 0}, lockpick = {"lock_pick", 0} }
	local container = party.party:getChampionByOrdinal(id):getItem(slot).go.containeritem
	
	for i=1, container:getCapacity() do
		local item = container:getItem(i)
		
		if item:hasTrait("light_weapon") or item:hasTrait("missile_weapon") then
			materials.nugget[2] = materials.nugget[2] + 1
			materials.leather_strips[2] = materials.leather_strips[2] + 1
			
		elseif item:hasTrait("heavy_weapon") or item:hasTrait("heavy_armor") then
			materials.metal[2] = materials.metal[2] + 1
			
		elseif item:hasTrait("shield") then
			materials.nugget[2] = materials.nugget[2] + 1
			materials.leather[2] = materials.leather[2] + 1
			
		elseif item:hasTrait("light_armor") or item:hasTrait("clothes") then
			materials.leather[2] = materials.leather[2] + 1
			materials.leather_strips[2] = materials.leather_strips[2] + 1
			
		elseif item:hasTrait("firearm") then
			materials.nugget[2] = materials.nugget[2] + 1
			
		end
		
		materials.lockpick[2] = 1
		container:removeItemFromSlot(i)
	end	
	
	for mat, value in pairs(materials) do
		local amount = math.ceil(value[2] / 3)
		if amount ~= 0 then
			for i=1, 9 do
				local insert = i
				if container:getItem(insert) == nil then
					container:insertItem(insert, spawn(value[1]).item)
					container:getItem(insert).go.item:setStackSize(amount)
					break
				end			
			end
		end
	end
	
	playSound("generic_spell")
end

-- Tinkerer upgrades for secondary actions
function updateSecondary(meleeAttack, secondary, name, upgradeLevel)
	local item = meleeAttack.go.item
	if name == "chop" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A useful technique for chopping firewood and splitting the heads of your enemies. Deals double damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setSwipe("vertical")
		secondary:setBuildup(1.0)
		secondary:setUiName("Chop")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({ "light_weapons_c", math.min(upgradeLevel+1,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({ "heavy_weapons_c", math.min(upgradeLevel+1,5) })
		end
		secondary.go.item:setSecondaryAction("chop")

	elseif name == "dagger_throw" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 6 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1.8)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.0)
		secondary:setBuildup(0.33)
		secondary:setGameEffect("Throws an item quickly at an enemy.")
		secondary:setUiName("Dagger Throw")
		--secondary:setSwipe("thrust")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({ "light_weapons_c", math.min(upgradeLevel+1,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({ "heavy_weapons_c", math.min(upgradeLevel+1,5) })
		end
		secondary.go.item:setSecondaryAction("dagger_throw")
		
	elseif name == "stun" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A powerful blow that has a ".. 18 + upgradeLevel * 6 .."% chance to stun an enemy. Deals double damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setCauseCondition("stunned")
		secondary:setConditionChance(18 + level * 6)
		secondary:setSwipe("vertical")
		secondary:setUiName("Stun")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(level+2,5)})
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(level+2,5)})
		end
		secondary.go.item:setSecondaryAction("stun")
		
	elseif name == "cleave" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A mighty blow that does 2.5 times damage and ignores 10 points of armor.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() + 10 or 10)
		secondary:setSwipe("vertical")
		secondary:setUiName("Cleave")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+2,5)})
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+2,5)})
		end
		secondary.go.item:setSecondaryAction("cleave")
	
	elseif name == "flurry" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 5) * 5)
		secondary:setAccuracy(12 + (upgradeLevel * 2))
		secondary:setAttackPower(meleeAttack:getAttackPower() / 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.8)
		secondary:setGameEffect("A series of three quick slashes with deadly accuracy. Does 1.5x times damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setRepeatCount(3)
		secondary:setRepeatDelay(0.2)
		secondary:setSwipe("flurry")
		secondary:setUiName("Flurry of Slashes")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+1,5), "accuracy", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+1,5), "accuracy", 1 })
		end
		secondary.go.item:setSecondaryAction("flurry")
		
	elseif name == "devastate" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 30 + math.floor(upgradeLevel * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.8)
		secondary:setGameEffect("An extremely powerful attack. Deals 2.5x damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setSwipe("vertical")
		secondary:setCameraShake(true)
		secondary:setUiName("Devastate")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+1,5), "critical", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+1,5), "critical", 1 })
		end
		secondary.go.item:setSecondaryAction("devastate")
		
	elseif name == "banish" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 40 + math.floor(upgradeLevel * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 2)
		secondary:setGameEffect("An extremely powerful attack. Deals 2.5x damage and has +9% critical chance.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setBuildup(1)
		secondary:setSwipe("horizontal")
		secondary:setCameraShake(true)
		secondary:setUiName("Banish")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+1,5), "critical", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+1,5), "critical", 1 })
		end
		secondary.go.item:setSecondaryAction("banish")
	
	elseif name == "volley" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 12 + math.floor(upgradeLevel * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.2)
		secondary:setGameEffect("Fires three shots in quick succession.")
		secondary:setUiName("Volley")
		secondary:setRequirements({ "ranged_weapons", math.min(upgradeLevel + 1,3) })
		secondary.go.item:setSecondaryAction("volley")
		secondary:setAmmo("arrow")
		secondary:setRepeatCount(3 + math.floor(upgradeLevel / 3))
		secondary:setRepeatDelay(0.2)
		secondary:setAttackSound("swipe_bow")
	end
	-- secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
	-- secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
	-- if item.go.name == "pickaxe" then
		-- secondary:setGameEffect("This attack chips away 2 armor from the enemy with each hit.")
	-- end
end