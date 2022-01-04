secondary = 0
spellSlinger = {}
stepCount = 0
skillNames = { "block", "light_armor", "heavy_armor", "accuracy", "critical", "firearms", "seafaring", "tinkering", "alchemy", "ranged_weapons", "throwing_weapons", "light_weapons_c", "heavy_weapons_c", "spellblade", "elemental_magic", "poison_mastery", "concentration", "witchcraft" }
metalSlugList = { 250, 900, 20, 1550, 900, 900, 1550, 20, 900, 900, 250, 1550 }
metalSlug = 0
assassin_multi = { 0,0.05,0.15,0.25,0.5 }

data = {}
function get(name) return data[name] end
function set(name,value) data[name] = value end
function add(name,value) data[name] = data[name] and data[name] + value or value end

champion_1_Data, champion_2_Data, champion_3_Data, champion_4_Data = {}, {}, {}, {}
championData = { champion_1_Data, champion_2_Data, champion_3_Data, champion_4_Data }
function get_c(name, id) return championData[id][name] end
function set_c(name, id, value) championData[id][name] = value end
function add_c(name, id, value) championData[id][name] = championData[id][name] and championData[id][name] + value or value end

--------------------------------------------------------------------------
-- Misc Functions                                                       --
--------------------------------------------------------------------------

function metalSlugListIncrease()
	metalSlug = metalSlug + 1
end

function stepCountIncrease()
	stepCount = stepCount + 1
end

function getStepCount()
	return stepCount
end

function addTables(t1, t2)
	for entry, value in pairs(t1) do
		if t2[entry] then
			t1[entry] = t1[entry] + t2[entry]
		end
	end
	return t1
end

function printTable(t1)
	local output = ""
	for i = 1, #t1 do
		for j = 1, #t1[1] do
			output = output .. t1[i][j] .. " / "
		end
	end
	print( output )
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

function teststart()
	-- spawn("script_entity", self.level, self.x, self.y, 0, 0, "test_1").script:loadFile("mod_assets/scripts/test.lua")
	-- if test_1.script then test_1.script.derp() end

	print("functions initiated")
	functions2.script.start()
	defaultPartyCheck = {"barbarian", "wizard", "alchemist", "knight", "rogue", "battle_mage", "farmer"}
	for i=1,#defaultPartyCheck do
		for c=1,4 do
			local champion = party.party:getChampionByOrdinal(c)
			if champion:getClass() == defaultPartyCheck[i] then
				setDefaultParty()
			end
		end
	end

	if Editor.isRunning() and false then
		party.party:getChampionByOrdinal(1):setClass("assassin_class")
		party.party:getChampionByOrdinal(2):setClass("tinkerer")
		party.party:getChampionByOrdinal(3):setClass("hunter")
		party.party:getChampionByOrdinal(4):setClass("monk")
		party.party:getChampionByOrdinal(1):setRace("human")
		party.party:getChampionByOrdinal(2):setRace("minotaur")
		party.party:getChampionByOrdinal(3):setRace("ratling")
		party.party:getChampionByOrdinal(4):setRace("human")

		for i=1,4 do
			local champion = party.party:getChampionByOrdinal(i)
			if not champion:getItem(32) then champion:insertItem(32,spawn("torch").item) end
			--champion:addSkillPoints(1)
			if i == 1 then
				champion:removeItemFromSlot(31)
				champion:insertItem(31,spawn("enchanted_timepiece").item)
				functions2.script.setGotDevice()
			end
			-- Classes
			if champion:getClass() == "assassin_class" then
				for s=13,16 do champion:removeItemFromSlot(s) end
				champion:insertItem(13,spawn("short_bow").item)
				champion:insertItem(14,spawn("arrow").item)
				champion:getItem(14):setStackSize(20)
				champion:insertItem(15,spawn("dagger").item)
				champion:insertItem(16,spawn("throwing_knife").item)
				champion:getItem(16):setStackSize(20)
			end

			if champion:getClass() == "fighter" then
				for s=13,15 do champion:removeItemFromSlot(s) end
				champion:insertItem(13,spawn("hand_axe").item)
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
				-- for s=ItemSlot.Weapon, ItemSlot.Bracers do
				-- 	champion:removeItemFromSlot(s)
				-- end
				champion:insertItem(13,spawn("blooddrop_cap").item)
				champion:getItem(13):setStackSize(10)
				champion:insertItem(14,spawn("etherweed").item)
				champion:getItem(14):setStackSize(5)
				champion:insertItem(15,spawn("mudwort").item)
				champion:getItem(15):setStackSize(5)
				champion:insertItem(16,spawn("falconskyre").item)
				champion:getItem(16):setStackSize(5)
				champion:insertItem(17,spawn("blackmoss").item)
				champion:insertItem(18,spawn("crystal_flower").item)
				champion:insertItem(19,spawn("mortar").item)
				-- champion:insertItem(ItemSlot.Gloves, spawn("leather_gloves").item)
				-- champion:insertItem(ItemSlot.Feet, spawn("leather_boots").item)
				-- champion:insertItem(ItemSlot.Legs, spawn("leather_pants").item)
				-- champion:insertItem(ItemSlot.Chest, spawn("doublet").item)
				-- champion:insertItem(ItemSlot.Head, spawn("peasant_cap").item)
				-- champion:insertItem(ItemSlot.Bracers, spawn("leafbond_bracelet").item)
				-- champion:insertItem(ItemSlot.Necklace, spawn("runestone_necklace").item)
				-- champion:insertItem(ItemSlot.Cloak, spawn("shaman_cloak").item)
				-- champion:insertItem(ItemSlot.Weapon, spawn("hand_axe").item)				
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
				champion:addTrait("body_and_mind")
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
		if champion:getClass() == "stalker" then
			local bonus = 1 + math.floor(party.party:getChampionByOrdinal(i):getLevel() / 3)
			set_c("night_stalker", i, bonus)
		end

		if champion:getClass() == "monk" then
			local bonus = champion:getMaxEnergy()
			set_c("focus", i, bonus)
		end

		if not champion:hasTrait("common") then champion:addTrait("common") end
	end
	findCrystalArea()
end

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
		-- Remove traits
		local invalid_traits = { "fighter","barbarian","knight","rogue","wizard","battle_mage","alchemist","farmer","human",
		"minotaur","lizardman","insectoid","ratling","skilled","fast_learner","head_hunter","rage",
		"fast_metabolism","endure_elements","poison_immunity","chitin_armor","quick","mutation","athletic",
		"agile","healthy","strong_mind","tough","aura","aggressive","evasive","fire_resistant","cold_resistant",
		"poison_resistant","natural_armor","endurance","weapon_specialization","pack_mule","meditation",
		"two_handed_mastery","light_armor_proficiency","heavy_armor_proficiency","armor_expert","shield_expert",
		"staff_defence","improved_alchemy","bomb_expert","backstab","assassin","firearm_mastery","dual_wield",
		"improved_dual_wield","piercing_arrows","double_throw","reach","uncanny_speed","fire_mastery","air_mastery",
		"earth_mastery","water_mastery","leadership","nightstalker" }
		for t = 1,#invalid_traits do
			if champion:hasTrait(invalid_traits[t]) then
				champion:removeTrait(invalid_traits[t])
			end
		end
	end

	champion = party.party:getChampionByOrdinal(1)
	champion:setRace("insectoid")
	champion:setClass("monk")
	champion:addTrait("body_and_mind")
	champion:trainSkill("heavy_weapons_c", 1, false)
	champion:trainSkill("accuracy", 1, false)

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
	champion:insertItem(ItemSlot.BackpackFirst, spawn("whitewood_wand").item)

	for c=1,4 do
		champion = party.party:getChampionByOrdinal(c)
		champion:setHealth(champion:getMaxHealth() * 0.9)
		champion:setEnergy(champion:getMaxEnergy() * 0.9)
	end
end

crystal_area = {}

function findCrystalArea()
	for entity in Dungeon.getMap(party.level):allEntities() do
		if entity.name == "crystal_area" then
			crystal_area = {entity.x-2, entity.y-2, entity.x+2, entity.y+2}
		end
	end
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

b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b20 = {}, {}, {}, {}, {}, {}, { {},{},{},{} }, { {},{},{},{},{},{} }, { {},{},{} }, {}, {}, {}, {{},{},{}}, {}
supertable = { b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b20  }

function onEquipItem(self, champion, slot)	
	local name = self.go.id
	local item = champion:getItem(slot)

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
		if champion:getClass() == "fighter" then
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
						hudPrint(champion:getName() .. ", the Berserker, refuses to wear armor.")
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
	if self.go.item:hasTrait("throwing_weapon") then reset_attack(self.go.throwattack, champion, slot, 0, self.go.item) end
	--if self.go.item:getSecondaryAction("throw") then reset_attack(self.go.meleeattack, champion, slot, 0, self.go.item) end
	local name = self.go.id
	local slots = {2,1}
	local otherslot = slots[slot]
	
	if self.go.name == "quarterstaff" and champion:getSkillLevel("spellblade") >= 1 then
		self.go.item:addTrait("two_handed")
	end
	
	resetItem(self, name)
	clearSupertable(self, name)
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
	local secondary = self.go:getComponent(self.go.item:getSecondaryAction() and self.go.item:getSecondaryAction() or "") or nil

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
	
	-- When using secondary attack, we still want to use the main melee action
	if self.go.item:getSecondaryAction() and self == self.go:getComponent(self.go.item:getSecondaryAction()) then
		self = self.go.meleeattack
	end

	resetItem(self, self.go.id)
	supertable[1][self.go.id] = self:getAttackPower()
	supertable[2][self.go.id] = self:getCooldown()
	supertable[4][self.go.id] = self:getPierce() or 0
	
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
		self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "light_weapons", 1))
	elseif getTrait(champion, item, "heavy_weapon") then
		self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "heavy_weapons", 1))
	end

	-- Dual Wielding bonuses
	if champion:isDualWielding() then
		self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "dual_wielding", 1))
	end

	-- Pierce bonuses
	if supertable[4][name] ~= nil then
		local real_pierce = tinker_item[4][name] and tinker_item[4][name] or (supertable[4][name] and supertable[4][name] or 0)
		self:setPierce(real_pierce)
	end

	-- Tinkerer conversion (don't do in empowerAttack to not show in stats screen)
	if champion:getClass() == "tinkerer" then
		self:setAttackPower(self:getAttackPower() * 0.5)
	end

	-- Druid's Mudwort attack bonus against poisoned enemies
	if champion:getClass() == "druid" then
		local poisonedMonster = get_c("poisonedMonster", c)
		if poisonedMonster then
			local monster = findEntity(poisonedMonster).monster
			self:setAttackPower(self:getAttackPower() * 1.15 )
		end
	end

	if item:hasTrait("poison_mace") and champion:getSkillLevel("poison_mastery") == 5 then
		local poisonedMonster = get_c("poisonedMonster", c)
		if poisonedMonster then
			self:setAttackPower(self:getAttackPower() * 1.4 )
		end
	end
	
	-- Attack Power Bonuses for Special Attacks
	if secondary and secondary ~= self then
		local attackPower = secondary:getAttackPower()
		local itemPowerAttackBonus = 1
		-- Items
		itemPowerAttackBonus = itemPowerAttackBonus + getEquippedMultiBonus(champion, "power_attack_multi", false)

		if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "bearclaw_gauntlets" then
			local amount = (champion:getItem(ItemSlot.Gloves):hasTrait("upgraded") and 0.30 or 0.15)
			itemPowerAttackBonus = itemPowerAttackBonus + amount
		end
		-- Armor Sets
		if isArmorSetEquipped(champion, "reed") then
			itemPowerAttackBonus = itemPowerAttackBonus + 0.2
		end

		attackPower = attackPower * itemPowerAttackBonus
		secondary:setAttackPower(attackPower)
	end
	
	-- Corsair fires gun with light weapon melee attack
	if champion:getClass() == "corsair" and getTrait(champion, item, "light_weapon") then
		local item2 = champion:getOtherHandItem(slot)
		if item2 and item2:hasTrait("firearm") then
			self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "dual_wielding", 1))
			delayedCall("functions", 0.25, "duelistSword", c, item.go.name, slot)
		end
	end
	
	-- Double attack
	if get_c("double_attack", c) == nil then
		processSecondAttack(self, champion, "melee", slot)
	else
		set_c("double_attack", c, nil)
	end

	-- Critical boosts
	if not item.go.equipmentitem then item.go:createComponent("EquipmentItem", "equipmentitem") end	
	local real_crit = tinker_item[6][name] and tinker_item[6][name] or (supertable[6][name] and supertable[6][name] or 0)
	if item.go.equipmentitem then 
		item.go.equipmentitem:setCriticalChance(real_crit)
		
		-- Banish critical bonus
		if secondary and secondary ~= self and secondary:getName() == "banish" then
			local bonus = champion:hasTrait("weapons_specialist") and 18 or 9
			self.go.equipmentitem:setCriticalChance(self.go.equipmentitem:getCriticalChance() + bonus)
		end
		-- Harvest time critical bonus
		if secondary and secondary ~= self and secondary:getName() == "reap" then
			local bonus = champion:hasTrait("weapons_specialist") and 20 or 10
			self.go.equipmentitem:setCriticalChance(self.go.equipmentitem:getCriticalChance() + bonus)
		end
		-- Rogue set bonus
		local target = functions.script.get("monsterInFront")
		if target and isArmorSetEquipped(champion, "rogue") then
			local e = findEntity(target)
			if e and party.facing == e.facing then
				self.go.equipmentitem:setCriticalChance(self.go.equipmentitem:getCriticalChance() + 25)
			end
		end
	end

	delayedCall("functions", 0.01, "resetItem", self, self.go.id)
end

-------------------------------------------------------------------------------------------------------
-- Throw Attack Functions                                                                            -- 
-------------------------------------------------------------------------------------------------------

function onThrowAttack(self, champion, slot, chainIndex, item)
	local c = champion:getOrdinal()
	supertable[1][item.go.id] = self:getAttackPower()
	supertable[2][item.go.id] = self:getCooldown()
	
	-- Increases to base damage
	-- All physical attack boosts
	self:setAttackPower(self:getAttackPower() * empowerElement(champion, "physical", 1))
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "ranged", 1))
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "throwing", 1))

	-- Tinkerer conversion (don't do in empowerAttack to not show in stats screen)
	if champion:getClass() == "tinkerer" then
		self:setAttackPower(self:getAttackPower() * 0.5)
	end
	
	-- Trigger psionic missile
	local id = champion:getOrdinal()
	if champion:hasTrait("magic_missile") then
		delayedCall("functions", 0.1, "psionicArrow", id)
	end
	
	if not item.go.equipmentitem then item.go:createComponent("EquipmentItem", "equipmentitem") end	
	local real_crit = tinker_item[6][name] and tinker_item[6][name] or (supertable[6][name] and supertable[6][name] or 0)
	if self.go.equipmentitem then
		self.go.equipmentitem:setCriticalChance(real_crit)

		-- Rogue set bonus
		local target = functions.script.get("monsterInFront")
		if target and isArmorSetEquipped(champion, "rogue") then
			local e = findEntity(target)
			if e and party.facing == e.facing then
				self.go.equipmentitem:setCriticalChance(self.go.equipmentitem:getCriticalChance() + 25)
			end
		end	
	end
	
	-- Throwing Double shot	
	if get_c("double_attack", c) == nil then
		processSecondAttack(self, champion, "throwing", slot)		
	else
		set_c("double_attack", c, nil)
	end
end

-------------------------------------------------------------------------------------------------------
-- Missile Attack Functions                                                                          -- 
-------------------------------------------------------------------------------------------------------

function onMissileAttack(self, champion, slot, chainIndex, item)
	local c = champion:getOrdinal()
	supertable[1][self.go.id] = self:getAttackPower()
	supertable[2][self.go.id] = self:getCooldown()
	
	local secondaryAction = self.go.item:getSecondaryAction()
	local secondary = nil
	if secondaryAction ~= nil and self.go:getComponent(secondaryAction):getClass() ~= "CastSpellComponent" then
		secondary = self.go:getComponent(secondaryAction)
	end
	
	-- Increases to base damage
	-- All physical attack boosts
	self:setAttackPower(self:getAttackPower() * empowerElement(champion, "physical", 1))
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "ranged", 1))
	self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "missile", 1))

	-- Tinkerer conversion (don't do in empowerAttack to not show in stats screen)
	if champion:getClass() == "tinkerer" then
		self:setAttackPower(self:getAttackPower() * 0.5)
	end

	if champion:hasTrait("magic_missile") then
		delayedCall("functions", 0.1, "psionicArrow", c)
	end

	if not item.go.equipmentitem then item.go:createComponent("EquipmentItem", "equipmentitem") end	
	local real_crit = tinker_item[6][name] and tinker_item[6][name] or (supertable[6][name] and supertable[6][name] or 0)
	if self.go.equipmentitem then
		self.go.equipmentitem:setCriticalChance(real_crit)

		-- Rogue set bonus
		local target = functions.script.get("monsterInFront")
		if target and isArmorSetEquipped(champion, "rogue") then
			local e = findEntity(target)
			if e and party.facing == e.facing then
				self.go.equipmentitem:setCriticalChance(self.go.equipmentitem:getCriticalChance() + 25)
			end
		end	
	end
	
	-- Missile Double shot
	if self ~= secondary then
		if get_c("double_attack", c) == nil then
			processSecondAttack(self, champion, "missile", slot)		
		else
			set_c("double_attack", c, nil)
		end
	end
end


corsairItem = nil
corsairItemId = nil

-------------------------------------------------------------------------------------------------------
-- Firearm Attack Functions                                                                          -- 
-------------------------------------------------------------------------------------------------------

function onFirearmAttack(self, champion, slot)
	supertable[1][self.go.id] = self:getAttackPower()
	supertable[2][self.go.id] = self:getCooldown()
	supertable[4][self.go.id] = self:getPierce() or 0
	local c = champion:getOrdinal()

	set_c("grazed_bullet", champion:getOrdinal(), false)
	if math.random() < 0.25 - (champion:getSkillLevel("firearms") * 0.05) then
		self:setAttackPower(self:getAttackPower() * 0.2)
		set_c("grazed_bullet", champion:getOrdinal(), true)
	end
	
	-- Pierce bonuses --
	local real_pierce = tinker_item[4][name] and tinker_item[4][name] or (supertable[4][name] and supertable[4][name] or 0)
	self:setPierce(real_pierce)

	-- All physical attack boosts
	self:setAttackPower(self:getAttackPower() * empowerElement(champion, "physical", 1))
	
	-- Silver Bullet trait - Double damage on 6th shot
	if champion:hasTrait("silver_bullet") then
		local count = get_c("silver_bullet", champion:getOrdinal()) or 0
		local trigger = 6 - (champion:hasTrait("fast_fingers") and math.floor(champion:getCurrentStat("dexterity") / 20) or 0)
	
		if (count % trigger) + 1 == trigger then
			-- print("before", self:getAttackPower())
			self:setAttackPower(self:getAttackPower() * 2.0)
			-- print("after", self:getAttackPower())
		elseif (count % trigger) + 1 == 0 then
			self:setAttackPower(self:getAttackPower() * 3.0)
		end
		
		add_c("silver_bullet", champion:getOrdinal(), 1)
	end

	-- Lucky Blow trait - 3rd shot
	if champion:hasTrait("lucky_blow") then
		local count = get_c("lucky_blow", champion:getOrdinal()) or -1
		local trigger = 3
		local bonus = math.floor(champion:getCurrentStat("dexterity") / 5)

		if count == trigger then
			self:setAttackPower(self:getAttackPower() + bonus)
		end

		add_c("lucky_blow", champion:getOrdinal(), 1)
	end
	
	-- Sea Dog Trait - Firearm damage increase in the front
	if champion:hasTrait("sea_dog") and (champion:getOrdinal() == 1 or champion:getOrdinal() == 2) then
		self:setAttackPower(self:getAttackPower() * 1.25)
	end	

	-- Tinkerer's reduction to damage before conversion
	-- if champion:getClass() == "tinkerer" then
	-- 	self:setAttackPower(self:getAttackPower() * 0.5 )
	-- end
	
	if champion:getClass() == "corsair" then
		local item = champion:getItem(slot)
		local item2 = champion:getOtherHandItem(slot)
		local slots = {2, 1}
		local otherslot = slots[slot]
		local pellets = nil
		local pelletsSlot = nil
		
		if (item and item:hasTrait("firearm")) and (item2 and item2:hasTrait("firearm")) then
			-- self:setAttackPower(math.floor(self:getAttackPower() * (1.1 + ((champion:getLevel()-1) * 0.1))))
			self:setAttackPower(self:getAttackPower() * empowerAttackType(champion, "dual_wielding", 1))
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

	delayedCall("functions", 0.01, "resetItem", self, self.go.id)
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
	-- if champion:hasTrait("metal_slug") and item.go.name ~= "revolver" then
	-- 	saveChance = saveChance + 0.07
	-- end

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
	resetItem(self, self.go.id)
end

-------------------------------------------------------------------------------------------------------
-- Monster hooks                                                                                     --    
-------------------------------------------------------------------------------------------------------
-- MonsterComponent - champion takes damage

function onMonsterDealDamage(self, champion, damage)
	local item1 = champion:getItem(ItemSlot.Weapon)
	local item2 = champion:getOtherHandItem(ItemSlot.Weapon)
	local monster = self
	local c = champion:getOrdinal()

	-- Shield bash and blocking
	if damage > 1 and ((item1 and item1:hasTrait("shield")) or (item2 and item2:hasTrait("shield")) or isArmorSetEquipped(champion, "chitin")) then
		local chance = getBlockChance(champion)
		local blockAmount = isArmorSetEquipped(champion, "valor") and 0.26 or 0.51
		-- print("chance", chance)
		-- print("amount", blockAmount)

		if math.random() <= chance then			
			champion:setHealth(champion:getHealth() + math.ceil(damage * blockAmount))

			if champion:hasTrait("shield_bash") then
				local dx,dy = getForward(party.facing)
				local flags = DamageFlags.CameraShake
				local damageBase = math.min(champion:getProtection() + damage, 50) + math.max((champion:getProtection() + damage - 50) / 4, 0) -- get up to 50 prot, anything over 50 is divided by 4
				local damageBonus = 1 + (1 - (100 / (math.min(champion:getProtection(), 100) + 150))) -- 1.0 to 1.4 from 0 prot to 100 prot
				champion:playDamageSound()
				if champion:hasCondition("ancestral_charge") then damageBonus = damageBonus * 1.5 end
				delayedCall("functions", 0.15, "hitMonster", monster.go.id, math.ceil(damageBase * damageBonus), "Shield Bash!", "physical", champion:getOrdinal())
				--context.drawImage2("mod_assets/textures/gui/block.dds", x+48, y-68, 0, 0, 128, 75, 128, 75)
			end

			if champion:hasTrait("shield_bearer") then
				champion:setConditionValue("shield_bearer", 20)
			end

			if isArmorSetEquipped(champion, "valor") then
				for i=1,4 do
					local champ = party.party:getChampionByOrdinal(i)
					champ:setConditionValue("valor_set", 6)
				end
			end
		end
	end
	
	-- Reflective Light Armor trait - recover hp and en on first hit from a monster
	if champion:hasTrait("reflective") then
		local all_light = wearingAll(champion, "light_armor", "clothes")
		if all_light and not get_c("reflective_monster_" .. monster.go.id, champion:getOrdinal()) then
			set_c("reflective_damage", champion:getOrdinal(), damage)
			set_c("reflective_monster_" .. monster.go.id, champion:getOrdinal(), true)
			champion:setConditionValue("reflective", 5)
		end
	end
end

function changeResistances(monster, newResistances)
	local damageTypes = {"fire","cold","shock","poison","physical","dispel","neutral"}
	local resists = {}
	for _,type in ipairs(damageTypes) do
		resists[type] = newResistances[type] or monster:getResistance(type)
		if newResistances[type] == "normal" then
			resists[type] = nil
		end
	end
	monster:setResistances(resists)
end

-------------------------------------------------------------------------------------------------------
-- Player Hits Monster Functions                                                                     --    
-------------------------------------------------------------------------------------------------------

-- Melee/Firearms
function onHitMonster(self, monster, tside, damage, champion) -- self = meleeattack or firearmattack
	local c = champion:getOrdinal()

	-- Melee back attacks
	if tside == 2 then
		-- Assassination -- chance to bleed on back attack melee hit
		if champion:getClass() == "assassin_class" then
			bleedMonster(nil, nil, champion, monster, 0.01 + ((champion:getLevel()-1)*0.01))
			
			local charges = get_c("assassination", c) or 0
			hitMonster(monster.go.id, math.max(damage * assassin_multi[charges+1],1), nil, damageType, c, 0, 1000)
			set_c("assassination", c, 0)
		end
	end
	-- Pickaxe Chip effect
	if self:getUiName() == "Chip" then
		local chip = self.go.item:hasTrait("upgraded") and 2 or 1
		monster:setProtection(monster:getProtection() and monster:getProtection() - chip, 0)
		monster:showDamageText(chip.." Armor", "FFFFFF", "Chip!")
	end

	-- Corsair Dirty Fighting
	if self.go.meleeattack and champion:getClass() == "corsair" then
		local chance = (0.02 + ((champion:getLevel()-1) * 0.01)) * (get("aggroMonsters") and 2 or 1)
		-- print("corsair attack chance", chance)
		if math.random() < chance and monster:isAlive() and champion:isAlive() then
			dirty_fighting(self, champion, monster)
		end
	end

	-- Lizardman Bite
	if self.go.meleeattack and champion:getRace() == "lizardman" and champion:hasTrait("bite") then
		if get_c("bite", c) == nil or get_c("bite", c) == 0 then
			set_c("bite", c, 30 - (math.floor(champion:getLevel() / 5) * 5 ) )
			lizardman_bite(self, champion, monster)
		end
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
		if secondary == self then
			bleedMonster(nil, nil, champion, monster, 0.3)
		end
	end	
	
	-- Hunter
	if champion:getClass() == "hunter" then
		hunterCrit(c, 1, 6 + (champion:getLevel() - 1))
		if monster:hasTrait("animal") then
			functions.script.wisdom_of_the_tribe_heal(champion)
			delayedCall("functions", 0.15, "hitMonster", monster.go.id, math.ceil(damage * wisdom_of_the_tribe(champion) ), "", "physical", champion:getOrdinal())
		end
	end
	
	-- Monk's Healing Light
	if champion:getClass() == "monk" then
		healingLight(champion, monster, damage)
	end
	
	-- Berserker's Frenzy
	if champion:getClass() == "fighter" then
		berserkerFrenzy(c, 1 + math.floor(champion:getLevel() * 0.25), 8)
	end
	
	local poisonChance = 0
	-- Venomancer for melee attacks
	if champion:hasTrait("venomancer") then	
		poisonChance = poisonChance + 0.1
	end
		
	-- Ratling's Sneak Attack
	if get_c("sneak_attack", champion:getOrdinal()) then
		poisonChance = poisonChance + 0.5
		set_c("sneak_attack", champion:getOrdinal(), false)
	end

	-- Items
	poisonChance = poisonChance + getEquippedMultiBonus(champion, "poison_chance", false)

	-- Venomous daggers (venom edge, serpent blade)
	if monster:getHealth() >= monster:getMaxHealth() * 0.5 then
		poisonChance = poisonChance + getEquippedMultiBonus(champion, "poison_chance_50hp", false)
	end

	-- Druid's poison chance from herbs effects
	if champion:getClass() == "druid" then
		local conversion = 0.8
		for slot = 8,10 do
			local druidItem = get_c("druid_item"..slot, champion:getOrdinal())
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
			hitMonster(monster.go.id, damage / conversion * (1 - conversion), nil, "poison", champion:getOrdinal())
		end
		if self.go.meleeattack then
			hitMonster(monster.go.id, damage / conversion * (1 - conversion), nil, "poison", champion:getOrdinal())
		end	
	end

	-- Poison chance
	poisonMonster(self, e, champion, monster, poisonChance)

	-- Lore Master
	if champion:hasTrait("lore_master") then
		local lore_master = get_c("lore_master_15", c)
		local duration = 21
		if lore_master and math.random() <= lore_master then			
			local trigger = math.random(1,3)
			if trigger == 1 then
				setPoisoned(monster, duration, c, lore_master)
			elseif trigger == 2 then
				setBurning(monster, duration, c, lore_master)
			else
				setFreezing(monster, duration, c, lore_master)
			end
		end
	end

	-- Tinkerer's Elemental Surge
	if champion:getClass() == "tinkerer" then
		if self.go.firearmattack then
			hitMonster(monster.go.id, damage, nil, "fire", champion:getOrdinal())
		end
		if self.go.meleeattack then
			hitMonster(monster.go.id, damage, nil, "shock", champion:getOrdinal())
		end
	end

	-- Thunder Fury
	if champion:hasTrait("thunder_fury") and getTrait(champion, self.go.item, "light_weapon") then
		if math.random() < getCrit(champion) * 0.01 then
			local dmg = getDamage(champion)
			delayedCall("functions", 0.15, "hitMonster", monster.go.id, math.random(dmg[1], dmg[2]) * 0.5, "Thunder Fury!", "shock", champion:getOrdinal())
		end
	end
	
	-- OG items effect
	if self.go.item:hasTrait("base_leech") then
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
			regainHealth(c, damage * (1 - champion:getHealth()/champion:getMaxHealth()) * 0.7)
		end
	end

	-- Assassination charges on melee hit
	if champion:getClass() == "assassin_class" then
		local dmg = getDamage(champion)
		local threshold = dmg[2] - math.min(monster:getProtection() - getPierce(champion), dmg[1])
		local charges = get_c("assassination", c) or 0
		if damage > threshold then
			set_c("assassination", c, math.min(charges + 1, 4))
		end
	end
	
	-- -- Melee back attacks
	-- if tside == 2 then
	-- 	-- Assassination -- chance to bleed on back attack melee hit
	-- 	if champion:getClass() == "assassin_class" then
	-- 		bleedMonster(nil, nil, champion, monster, 0.01 + ((champion:getLevel()-1)*0.01))
			
	-- 		local charges = get_c("assassination", c) or 0
	-- 		delayedCall("functions", 0.15, "hitMonster", monster.go.id, damage * (1 + assassin_multi[charges+1]), nil, damageType, c)
	-- 		set_c("assassination", c, 0)
	-- 	end
	-- end

	-- Corsair puts item in enemy on melee and firearm hit
	if champion:getClass() == "corsair" then
		if champion:getClass() == "corsair" and math.random() < (monster:hasTrait("humanoid") and 0.15 or 0.03 ) and not get(monster.go.id .. "_plunder") then -- and monster:hasTrait("humanoid")
			local category = nil
			local randomWeight = 0
			local item = nil
			local levelBonus = math.floor(champion:getLevel() / 3) * 2 -- every 3 levels, low chance items gain a boost
	
			local foodList = { ["borra"] = 50, ["rat_shank"] = 50, ["pitroot_bread"] = 40, ["boiled_beetle"] = 30, ["mole_jerky"] = 20, ["bread"] = 10 * levelBonus, ["snake_tail"] = 5 * levelBonus, ["turtle_eggs"] = 5 * levelBonus }
			local herbList = { ["blooddrop_cap"] = 3500, ["etherweed"] = 3000, ["mudwort"] = 2500, ["falconskyre"] = 1950, ["blackmoss"] = 930 * levelBonus, ["crystal_flower"] = 450 * levelBonus }
			local miscList = { ["pellet_box"] = 3000, ["arrow"] = 200 * levelBonus, ["quarrel"] = 100 * levelBonus, ["dart"] = 500, ["throwing_knife"] = 250, ["shuriken"] = 100 * levelBonus, ["throwing_axe"] = 20 * levelBonus }
			local matsList = { ["metal_nugget"] = 1000, ["metal_bar"] = 500, ["leather"] = 500, ["leather_strips"] = 1000, ["silk"] = 250 * levelBonus, ["gold_bar"] = 100 * levelBonus }
			local potionsList = { ["potion_healing"] = 1000, ["potion_energy"] = 1000, ["potion_greater_healing"] = 300 * levelBonus, ["potion_greater_energy"] = 300 * levelBonus, ["potion_cure_poison"] = 750, ["potion_cure_disease"] = 750, ["potion_bear_form"] = 300, ["potion_speed"] = 300, ["potion_rage"] = 300 }
			local coinsList = { ["doubloon"] = 500 + (250 * (levelBonus / 2)), ["cursed_doubloon"] = 750 - (levelBonus > 4 and 500 or 0) }
			local items = { ["food"] = { foodList, 150 }, ["herbs"] = { herbList, 50 }, ["misc"] = { miscList, 75 }, ["mats"] = { matsList, 50 }, ["potions"] = { potionsList, 10 }, ["coins"] = { coinsList, 75 } }
	
			-- Pick a weighted category
			local total = 0
			for cat, table in pairs(items) do
				total = total + table[2]
			end
	
			randomWeight = math.random(1, total)
			category = nil
			for cat, table in pairs(items) do
				randomWeight = randomWeight - table[2]
				if randomWeight <= 0 then
					category = table[1]
					break
				end
			end
			-- Pick a weighted item from category
			total = 0
			for item, weight in pairs(category) do
				total = total + weight
			end
	
			randomWeight = math.random(1, total)
			for i, weight in pairs(category) do
				randomWeight = randomWeight - weight
				if randomWeight <= 0 then
					item = i
					break
				end
			end

			local spawn = spawn(item).item
			if spawn.go.name == "pellet_box" then spawn:setStackSize(math.random(1 + math.floor(levelBonus/16),5 + math.floor(levelBonus/8))) end
			
			monster:addItem(spawn)
			set(monster.go.id .. "_plunder", true)
		end		
	end

	-- Killing blow effects
	if monster:getHealth() - damage <= 0 then
		if get(monster.go.id .. "_plunder") then 
			hudPrint("Plundered item!")
			set(monster.go.id .. "_plunder", nil) 
		end -- clear plunder variable
	end

	-- Leech power attack effect
	if self.go.name == "leech" then
		local upgrade = self.go.item:hasTrait("upgraded") and 0.5 or 0.4
		if monster:hasTrait("undead") then
			-- draining undeads is not wise
			monster:showDamageText("Backlash", "FF0000")
			champion:damage(damage * 0.7, "physical")
			champion:playDamageSound()
			return false
		elseif monster:hasTrait("elemental") or monster:hasTrait("construct") then
			-- elementals are constructs are immune to leech
			monster:showDamageText("Immune")
			return false
		else
			regainHealth(c, damage * upgrade)
		end
	end

	-- Knockback power attack
	if self.go.name == "knockback" then
		if monster:isAlive() then
			if monster:getResistance("physical") ~= "immune" and monster:getResistance("physical") ~= "absorb" and not monster:isImmuneTo("knockback") then
				monster:knockback(self.go.facing)
			end
		end
	end
end

-- MonsterComponent -- Projectiles
function onProjectileHitMonster(self, item, damage, damageType) -- self = monster, item = projectile
	-- print(item.go.data:get("castByChampion"))
	if item.go.data:get("castByChampion") then -- random thrown items don't get this
		-- print(item.go.data:get("castByChampion"))
		local champion = party.party:getChampionByOrdinal(tonumber(item.go.data:get("castByChampion")))
		local facing = item.go.data:get("castByChampionFacing")
		local specialDamage = item.go.data:get("projectileDamage")
		local c = champion:getOrdinal()
		local backAttack = self.go.facing == facing
		local monster = self
		
		if item.go.rangedattack or item.go.ammoitem or item.go.throwattack then
			-- Assassination chance to bleed on ranged hit
			if champion:getClass() == "assassin_class" then
				bleedMonster(nil, nil, champion, monster, 0.01 + ((champion:getLevel()-1)*0.01))
				-- Back attack spends charges and does bonus damage
				if backAttack then
					local charges = get_c("assassination", c) or 0
					hitMonster(monster.go.id, math.max(damage * assassin_multi[charges+1],1), nil, damageType, c, 0, 1000)
					set_c("assassination", c, 0)
				end
			end
		end

		local poisonChance = 0
		-- Venomancer for melee attacks
		if champion:hasTrait("venomancer") then	
			poisonChance = poisonChance + 0.1
		end	

		-- Items
		poisonChance = poisonChance + getEquippedMultiBonus(champion, "poison_chance", false)
		
		-- Druid's poison chance from herbs effects
		if champion:getClass() == "druid" then
			local conversion = 0.8
			for slot = 8,10 do
				local druidItem = get_c("druid_item"..slot, c)
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
				hitMonster(monster.go.id, damage / conversion * (1 - conversion), nil, "poison", c)
			end
			if self.go.meleeattack then
				hitMonster(monster.go.id, damage / conversion * (1 - conversion), nil, "poison", c)
			end	
		end

		-- Tinkerer's Elemental Surge
		if champion:getClass() == "tinkerer" then
			hitMonster(monster.go.id, damage, nil, "cold", champion:getOrdinal())
		end
		
		-- Ratling's Sneak Attack
		if get_c("sneak_attack", c) then
			poisonChance = poisonChance + 0.5
			set_c("sneak_attack", c, false)
		end
		
		-- Poison chance
		poisonMonster(self, e, champion, monster, poisonChance)

		-- Lore Master
		if champion:hasTrait("lore_master") then
			local lore_master = get_c("lore_master_15", c)
			local duration = 21
			if lore_master and math.random() <= lore_master then			
				local trigger = math.random(1,3)
				if trigger == 1 then
					setPoisoned(monster, duration, c, lore_master)
				elseif trigger == 2 then
					setBurning(monster, duration, c, lore_master)
				else
					setFreezing(monster, duration, c, lore_master)
				end
			end
		end

		-- When monster takes a hit and dies
		if self:getHealth() - damage <= 0 then
			
		end
		
		-- Assassin Assasination charges increase
		if champion:getClass() == "assassin_class" then
			local dmg = getDamage(champion)
			local threshold = dmg[2] - math.min(monster:getProtection() - getPierce(champion), dmg[1])
			local charges = get_c("assassination", c) or 0
			if damage > threshold then
				set_c("assassination", c, math.min(charges + 1, 4))
			end
		end

		-- Hunter's Wisdom of the Tribe
		if champion:getClass() == "hunter" then
			functions.script.hunterCrit(c, 1, 6 + (champion:getLevel() - 1))
			if self:hasTrait("animal") then
				functions.script.wisdom_of_the_tribe_heal(champion)
				delayedCall("functions", 0.15, "hitMonster", self.go.id, math.ceil(damage * wisdom_of_the_tribe(champion) ), "", damageType, champion:getOrdinal())
			end	
		end	
		
		-- Monk's Healing Light
		if champion:getClass() == "monk" then
			healingLight(champion, monster, damage)
		end
		
		-- Berserker's Frenzy
		if champion:getClass() == "fighter" then
			berserkerFrenzy(c, 1 + math.floor(champion:getLevel() * 0.25), 8)
		end

		if item.go.name == "stun_quarrel" then
			local duration = math.random(2,12)
			if duration >= 8 then duration = math.random(2,12) end
			monster:setCondition("stunned", duration)
		end

		if item.go.name == "sleep_dart" then
			local duration = math.random(10,20)
			if duration >= 15 then duration = math.random(10,20) end
			monster:setCondition("sleep", duration)
		end

		if specialDamage then
			hitMonster(monster.go.id, specialDamage, nil, "physical", c)
			return false
		else
			return true
		end
	end
end

-- 

function onHitWithBomb(self,level,x,y,facing,elevation,type)
	local explode = true
	local monster = nil
	-- for entity in self.go.map:entitiesAt(x,y) do
	-- 	if entity.monster then
	-- 		explode = true
	-- 		monster = entity.id
	-- 	end	
	-- end
	
	if explode then -- hits monster
		local c = self.go.data:get("castByChampion")
		if c then
			local type = self:getBombType()
			local champion = party.party:getChampionByOrdinal(c)
			local power = self:getBombPower() + math.floor(champion:getLevel() / 2) + (champion:getSkillLevel("throwing_weapons") * 2) + (champion:getSkillLevel("alchemy") * 2)
			local spl = nil
			if type == "fire" then
				spl = spawn("fireburst", level, x, y, facing, elevation)
				local spl2 = spawn("fire_wall", level, x, y, facing, elevation)
				spl2.tiledamager:setAttackPower(power*0.8)
				spl2.tiledamager:setCastByChampion(c)
				spl2.iceshards:setRange(1)
			elseif type == "shock" then
				spl = spawn("shockburst", level, x, y, facing, elevation)
			elseif type == "cold" then
				spl = spawn("frostburst_bomb", level, x, y, facing, elevation)
			elseif type == "poison" then
				if isArmorSetEquipped(champion, "lurker") then
					spl = spawn("smoke_cloud_bomb", level, x, y, facing, elevation)
				else
					spl = spawn("poison_cloud_bomb", level, x, y, facing, elevation)
				end
			end
			
			power = functions.script.empowerElement(champion, type, power, true)

			if spl.tiledamager then spl.tiledamager:setAttackPower(power) end
			if spl.tiledamager then spl.tiledamager:setCastByChampion(c) end

			if spl.cloudspell then spl.cloudspell:setAttackPower(power) end
			if spl.cloudspell then spl.cloudspell:setCastByChampion(c) end
		else -- Thrown from hand -> Hits monster
			local item = spawn(self.go.name, level, x, y, ((facing + 2) % 4), elevation)
			item.item:setStackSize(self.go.item:getStackSize())
		end
	else -- Doesn't hit monster
		local item = spawn(self.go.name, level, x, y, ((facing + 2) % 4), elevation)
		item.item:setStackSize(self.go.item:getStackSize())
	end
	
	return false
end

-- MonsterComponent - Any damage taken
function onDamageMonster(self, damage, damageType)
	local resistances = self:getResistance(damageType)
	local monster = self
	for i=1,4 do
		local champion = party.party:getChampionByOrdinal(i)
		if functions.script.get_c("championUsedMagic", i) then
			-- Elemental Exploitation
			if functions.script.get_c("elemental_exploitation", i) and champion:hasTrait("elemental_exploitation") and resistances == "weak" then
				delayedCall("functions", 0.25, "hitMonster", self.go.id, math.ceil(damage * 0.25), "", damageType, champion:getOrdinal())
				functions.script.set_c("elemental_exploitation", i, nil)
			end
			
			-- Ritual
			if functions.script.get_c("ritual", i) and champion:hasTrait("ritual") then
				for j=1,4 do
					local c = party.party:getChampionByOrdinal(j)
					if c:isAlive() then
						regainHealth(c:getOrdinal(), math.ceil(damage * 0.05))
					end
				end
				if champion:isAlive() then
					regainHealth(champion:getOrdinal(), math.ceil(damage * 0.05))
				end
				functions.script.set_c("ritual", i, nil)
			end
			
			-- Hunter's Wisdom of the Tribe -- when hit with magic
			if functions.script.get_c("wisdom_of_the_tribe", i) and champion:getClass() == "hunter" then
				functions.script.hunterCrit(champion:getOrdinal(), 1, 6 + (champion:getLevel() - 1))
				if self:hasTrait("animal") then
					functions.script.wisdom_of_the_tribe_heal(champion)
					local bonus = functions.script.wisdom_of_the_tribe(champion)
					delayedCall("functions", 0.15, "hitMonster", self.go.id, math.ceil(damage * bonus), "", damageType, champion:getOrdinal())
				end
				functions.script.set_c("wisdom_of_the_tribe", i, nil)
			end
			
			-- Monk's Healing Light
			if champion:getClass() == "monk" then
				if damage then
					healingLight(champion, monster, damage)
				end
			end
			-- Berserker's Frenzy
			if champion:getClass() == "fighter" then
				if damage then
					berserkerFrenzy(i, 1 + math.floor(champion:getLevel() * 0.25), 8)
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
					regainHealth(champion:getOrdinal(), damage * math.random(health/3,health) * 0.01)
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
	for i=1,4 do
		local champion = party.party:getChampion(i)
		if champion:hasTrait("carnivorous") and self:hasTrait("animal") and math.random() < 0.08 then -- 8% chance
			local common = {"warg_meat", "sausage", "rat_shank", "mole_jerky", "lizard_stick"}
			local rare = {"snake_tail", "toad_tongue", "turtle_steak" }
			if math.random() < 0.75 then
				spawn(common[math.ceil(math.random() * 5)], self.level, self.x, self.y, self.facing, self.elevation)
			else
				spawn(rare[math.ceil(math.random() * 3)], self.level, self.x, self.y, self.facing, self.elevation)
			end
		end
		--
		if isArmorSetEquipped(champion, "rogue") and champion:hasCondition("haste") then
			local duration = champion:getConditionValue("haste")
			champion:setConditionValue("haste", duration + 20)
		end

		-- if champion:getClass() == "tinkerer" then
		-- 	add_c("exp", self.go.monster:getExp())
		-- 	champion:gainExp( self.go.monster:getExp() * -1 )
		-- end
	end
end

function onAnimationEvent(self, event)
	local monster = self.go.monster
	if not monster then return end
end

-------------------------------------------------------------------------------------------------------
-- Hit Monster Function                                                                              --    
-------------------------------------------------------------------------------------------------------

function hitMonster(id, damage, flair, damageType, c, pierce_add, acc_add)
	print(damageType)
	local monster = findEntity(id).monster
	if not c then return false end
	local champion = party.party:getChampionByOrdinal(c)
	if not monster or not champion or not damage then return end
	local color = "BBBBBB"
	if flair == "" then flair = nil end
	if flair then color = "FFFFFF" end
	pierce_add = pierce_add or 0
	acc_add = acc_add or 0
	local pierce = getPierce(champion) + pierce_add
	local accuracy = getAccuracy(champion) + acc_add	

	-- Monster animation and particles --
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

	-- Damage Calculations
	damage = empowerElement(champion, damageType, damage, true)

	if damageType == "physical" then
		local protection = math.max(monster:getProtection() - pierce, 0) * (0.5 + math.random())
		damage = math.max(damage - protection, 0)

		local luck = (get_c("luck", c) or 0) * 3
		local evade =  math.clamp(60 + accuracy + luck - monster:getEvasion(), 5, 95) / 100
		if acc_add > 999 then evade = 1 end
		-- print("evade", evade)
		if monster:getEvasion() < 1000 and math.random() > evade and not monster.go.sleep and not monster.go.frozen then
			damage = 0
			set_c("luck", c, math.min(luck + 1, 5) )
		else
			set_c("luck", c, 0)
		end
	end

	-- Calculate resistances
	local resistances = monster:getResistance(damageType)
	if resistances == "weak" then
		color = "FF0000"
		damage = damage * 2
	elseif resistances == "vulnerable" then
		color = "CC0000"
		damage = damage * 1.5
	elseif resistances == "resist" then
		color = "BBBBBB"
		damage = damage * 0.5
	elseif resistances == "immune" then
		color = "EEEEEE"
		damage = damage * 0
	elseif resistances == "absorb" then
		color = "00FF00"
		damage = damage * -1
	end

	damage = math.ceil(damage)

	-- Show damage text
	if damageType == "physical" and damage == 0 then
		monster.go.monster:showDamageText("miss", "BBBBBB") 
		return false
	else
		if flair then
			monster.go.monster:showDamageText("" .. damage, color, flair) 
		else 
			monster.go.monster:showDamageText("" .. damage, color) 
		end
	end
	
	-- Druid's Herb effects
	if champion:getClass() == "druid" and damageType == "poison" then
		local health = 0
		local energy = 0
		for slot = 8,10 do
			local druidItem = get_c("druid_item"..slot, c)
			if druidItem then
				if druidItem == "blooddrop_cap" then
					health = health + 25
				elseif druidItem == "etherweed" then
					energy = energy + 25
				end
			end
		end
		if health > 0 then
			regainHealth(c, damage * math.random(health/3,health) * 0.01)
		end
		if energy > 0 then
			regainEnergy(c, damage * math.random(health/3,health) * 0.01)
		end
	end
	
	-------
	monster:setHealth(monster:getHealth() - damage)
	
	monster.go.brain:stopGuarding()
	monster.go.brain:pursuit()

	if monster:getHealth() <= 0 then
		monster:die(true) -- true -> awards experience
	end
end


-------------------------------------------------------------------------------------------------------
-- Class/Race Functions                                                                              --    
-------------------------------------------------------------------------------------------------------

-- Class skill
function class_skill(skill, champion)
	if skill == "sneak_attack" then
		--print("skill sneak_attack")
		set_c("sneak_attack", champion:getOrdinal(), false)
		champion:setConditionValue("sneak_attack", 100)
		champion:setConditionValue("recharging", 3)
		
	elseif skill == "ancestral_charge" then
		--print("skill ancestral_charge")
		local spell = spells_functions.script.defByName["ancestral_charge_cast"]
		spell.onCast(champion, party.x, party.y, party.facing, party.elevation, 3)
		champion:setConditionValue("recharging", 3)
	
	elseif skill == "intensify_spell" then
		--print("skill intensify_spell")
		if get_c("lastSpell", champion:getOrdinal()) then
			set_c("intensifySpell", champion:getOrdinal(), get_c("lastSpell", champion:getOrdinal()))
			--print("set intensify_spell to " .. get_c("lastSpell", champion:getOrdinal()))
		else
			--no spell to intensify
		end
		champion:setConditionValue("recharging", 3)
	
	elseif skill == "drinker" then
		--print("skill drinker")
		playSound("consume_potion")
		champion:setConditionValue("recharging", 3)
		champion:setConditionValue("drown_sorrows", 15)
		set_c("drown_sorrows_exp", champion:getOrdinal(), GameMode.getTimeOfDay())
		champion:addTrait("drown_sorrows_exp")
	end
end

-- Lizarman
function lizardman_bite(attack, champion, monster)
	local c = champion:getOrdinal()
	local str = { math.ceil(champion:getCurrentStat("strength") * 0.5), math.ceil(champion:getCurrentStat("strength") * 1.5) }
	local dex = { math.ceil(champion:getCurrentStat("dexterity") * 0.5), math.ceil(champion:getCurrentStat("dexterity") * 1.5) }
	local pierce = 5
	local accuracy = 0
	local damage = math.random((dex[1] + str[1]) / 2, (dex[2] + str[2]) / 2)

	delayedCall("functions", 0.25, "hitMonster", monster.go.id, damage, "Bite", "physical", c, pierce, accuracy)
end

-- Corsair
function dirty_fighting(attack, champion, monster)
	local c = champion:getOrdinal()
	local damageWeapon = getDamage(champion, ItemSlot.OffHand)
	local damageOffhand = getDamage(champion, ItemSlot.OffHand)
	local accuracy = getAccuracy(champion) + 20
	local str = { math.ceil(champion:getCurrentStat("strength") * 0.5), math.ceil(champion:getCurrentStat("strength") * 1.5) }
	local head = champion:getItem(ItemSlot.Head) and champion:getItem(ItemSlot.Head):getProtection() or 0
	local headType = champion:getItem(ItemSlot.Head) and ((champion:getItem(ItemSlot.Head):hasTrait("heavy_armor") and 0.04) or (champion:getItem(ItemSlot.Head):hasTrait("light_armor") and 0.12)) or 0.25
	local dmg1 = math.random(damageWeapon[1], damageWeapon[2])
	local dmg2 = math.random(damageOffhand[1], damageOffhand[2])
	local hasGun = champion:getItem(ItemSlot.OffHand) and champion:getItem(ItemSlot.OffHand):hasTrait("firearm")
	local hasHand = (not champion:getItem(ItemSlot.OffHand))
	local useAttackList = { 
		["haymaker"] 	= 	{ name = "Haymaker", 		canUse = hasHand, 	damage = math.ceil(math.random(str[1], str[2]) + 1), 														pierce = 0, 	proc = "stun" },
		["pistol_whip"] = 	{ name = "Pistol-Whip", 	canUse = hasGun, 	damage = math.ceil(dmg2), 																					pierce = 0, 	proc = nil },
		["headbutt"] 	= 	{ name = "Headbutt", 		canUse = true, 		damage = math.ceil(math.random(str[1] + (head * (0.4 - headType)), str[2] + (head * (1.6 - headType)))), 	pierce = 0, 	proc = "head_injury" },
		["boot_knife"] 	= 	{ name = "Boot Knife", 		canUse = true, 		damage = math.ceil(7 + champion:getLevel() + empowerAttackType(champion, "light_weapons", 7, true, 1) ), 	pierce = 5, 	proc = nil },
		}
	local keys = { "haymaker", "pistol_whip", "headbutt", "boot_knife" }
	local useAttack = math.random(#keys)

	if useAttackList[keys[useAttack]].canUse then
		local useDamage = useAttackList[keys[useAttack]].damage
		local useName = useAttackList[keys[useAttack]].name
		local usePierce = useAttackList[keys[useAttack]].pierce
		local useProc = useAttackList[keys[useAttack]].proc
		if useProc then
			if useProc == "stun" then
				setStunned(monster, math.ceil(math.random(str[1] / 4, str[2] / 4)), c, 1)
			elseif useProc == "head_injury" and math.random() < headType then
				champion:setCondition("head_wound")
			end
		end
		delayedCall("functions", 0.25, "hitMonster", monster.go.id, useDamage, useName, "physical", c, usePierce, accuracy)
	end
end

-- Hunter
function hunterCrit(c, stack, dur)
	local champion = party.party:getChampionByOrdinal(c)
	add_c("hunter_crit", c, stack)
	set_c("hunter_max", c, dur)
	champion:setConditionValue("hunter_crit", dur)
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
	regainHealth(champion:getOrdinal(), missing * 0.05)
end

-- Berserker
function berserkerFrenzy(c, stack, dur)
	local champion = party.party:getChampionByOrdinal(c)
	local curStacks = get_c("berserker_frenzy", c) or 0
	stack = stack > 0 and math.min(stack + 4, 10) or stack
	if curStacks < 100 or (curStacks == 100 and stack < 0) then
		add_c("berserker_frenzy", c, stack)
	end
	set_c("berserker_max", c, dur)
	champion:setConditionValue("berserker_frenzy", dur)
	
	if get_c("berserker_frenzy", c) <= 0 then
		set_c("berserker_frenzy_countdown", c, 0)
		set_c("berserker_frenzy", c, 0)
	end
end

-- Champion of Light
function healingLight(champion, monster, damage)
	local healingLight = get_c("healinglight", champion:getOrdinal())
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
		set_c("healinglight", champion:getOrdinal(), healingMax)
		
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
		set_c("healinglight", champion:getOrdinal(), healingLight)
	end
end

function duelistSword(id, itemName, slot)
	local slots = {2, 1}
	local otherslot = slots[slot]
	local champion = party.party:getChampionByOrdinal(id)
	champion:attack(otherslot, false)
end

-- Elementalist
function elementalistPower(element, champion, return_only)
	local power = 0
	local level = champion:getLevel()
	if return_only then 
		if element == "fire" then
			power = power + ((champion:getResistance("cold") + champion:getResistance("shock")) * 0.33 * 0.01)
			if champion:hasCondition("elemental_balance_cold") or champion:hasCondition("elemental_balance_shock") then
				power = power + 0.25 
				if not return_only then delayedCall("functions", 0.5, "regainEnergy", champion:getOrdinal(), champion:getMaxEnergy() * (0.05 + champion:getCurrentStat("willpower") * 0.001)) end
			elseif champion:hasCondition("elemental_balance_fire")  then
				power = power - 0.05 
			end
			if not return_only then
				champion:setConditionValue("elemental_balance_fire", 9)
				champion:removeCondition("elemental_balance_cold")
				champion:removeCondition("elemental_balance_shock")
			end

		elseif element == "cold" then
			power = power + ((champion:getResistance("fire") + champion:getResistance("shock")) * 0.33 * 0.01)
			if champion:hasCondition("elemental_balance_fire") or champion:hasCondition("elemental_balance_shock") then
				power = power + 0.25
				if not return_only then delayedCall("functions", 0.5, "regainEnergy", champion:getOrdinal(), champion:getMaxEnergy() * (0.05 + champion:getCurrentStat("willpower") * 0.001)) end
			elseif champion:hasCondition("elemental_balance_cold")  then
				power = power - 0.05 
			end
			if not return_only then
				champion:setConditionValue("elemental_balance_cold", 9)
				champion:removeCondition("elemental_balance_fire")
				champion:removeCondition("elemental_balance_shock")
			end

		elseif element == "shock" then
			power = power + ((champion:getResistance("cold") + champion:getResistance("fire")) * 0.33 * 0.01)
			if champion:hasCondition("elemental_balance_cold") or champion:hasCondition("elemental_balance_fire") then
				power = power + 0.25
				if not return_only then delayedCall("functions", 0.5, "regainEnergy", champion:getOrdinal(), champion:getMaxEnergy() * (0.05 + champion:getCurrentStat("willpower") * 0.001)) end
			elseif champion:hasCondition("elemental_balance_shock")  then
				power = power - 0.05 
			end
			if not return_only then
				champion:setConditionValue("elemental_balance_shock", 9)
				champion:removeCondition("elemental_balance_cold")
				champion:removeCondition("elemental_balance_fire")
			end
		end
	end
	print(element, power)
	return power
end


-------------------------------------------------------------------------------------------------------
-- Item/Equipment Functions                                                                          --    
-------------------------------------------------------------------------------------------------------

function onConsumeFood(self, champion)
	local c = champion:getOrdinal()
	if champion:hasTrait("carnivorous") and champion:isAlive() then
		if self.go.item:hasTrait("consumable") and self.go.item:hasTrait("meat") then
			champion:modifyFood(self.go.usableitem:getNutritionValue() * 0.05) -- extra 5% gain

			local meatCounter = get_c("meat_counter", c) or 0
			local meatBonus = get_c("meat_bonus", c) or 0
			set_c("meat_counter", c, meatCounter + 1)
			if meatCounter == ( 3 + math.floor(champion:getLevel() / 5) + (math.floor(champion:getLevel() / 13) * 2) + champion:getLevel() ) then
				set_c("meat_counter", c, 0)
				meatBonus = meatBonus + 1
				set_c("meat_bonus", c, meatBonus)

				local strBonus = math.floor(meatBonus / 2)
				local vitBonus = math.ceil(meatBonus / 2)

				if meatBonus % 2 == 1 then
					set_c("level_up_message_2", c, champion:getName() .. " gained +1 Vitality from the Carnivorous trait.")
				else
					set_c("level_up_message_2", c, champion:getName() .. " gained +1 Strenght from the Carnivorous trait.")
				end
				set_c("level_up_message_2_timer", c, 8)
			end
		else
			hudPrint("This isn't meat...")
			return false
		end
	end

	if champion:getClass() == "monk" then
		local focus = functions.script.get_c("focus", c) or 0
		local focusMax = champion:getMaxEnergy()
		local bonus = self.go.item:hasTrait("meat") and 0.9 or 1.0
		bonus = bonus + (champion:getLevel() * 0.02) + (math.floor(champion:getLevel() / 4) * 0.08)
		functions.script.set_c("focus", c, math.min( focus + (self.go.usableitem:getNutritionValue() / 20 * bonus), focusMax) )
	end
end

-- Item weight effects
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
			setWeight(item, "cannon_ball", 0.6)
			setWeight(item, "pellet_box", 0.6)
			setWeight(item, "ammo", 0.6)
		else
			resetItemWeight(item, "cannon_ball")
			resetItemWeight(item, "pellet_box")
		end	
	end
end

function setWeight(item, trait, multiplier)
	if item and item:hasTrait(trait) then
		if tinker_item[14][item.go.id] ~= nil then
			item.go.item:setWeight(tinker_item[14][item.go.id] * multiplier)
		elseif supertable[14][item.go.id] ~= nil then
			item.go.item:setWeight(supertable[14][item.go.id] * multiplier)
		end
	end
end

function resetItemWeight(item, trait)
	if item and supertable[14][item.go.id] == nil then
		supertable[14][item.go.id] = item.go.item:getWeight()
	end
	if item and item:hasTrait(trait) and supertable[14][item.go.id] ~= nil then
		item.go.item:setWeight(supertable[14][item.go.id])
	end
	if item and item:hasTrait(trait) and tinker_item[14][item.go.id] ~= nil then
		item.go.item:setWeight(tinker_item[14][item.go.id])
	end
end

-- Power attack buildup and energy cost effects
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

-- Returns the multiplier for elemental damage given by equipment
function getEquippedMultiBonus(champion, type, useJoeBonus)
	local multi = 0

	-- local armorSets = { "chitin", "valor", "crystal", "meteor", "bear", "embalmers", "archmage", "rogue", "makeshift", "reed", "mirror", "plate" }

	-- for index, set in ipairs(armorSets) do
	-- 	if isArmorSetEquipped(champion, set) then

	-- 	end
	-- end

	for slot = ItemSlot.Weapon, ItemSlot.Bracers do
		local item = champion:getItem(slot)
		local isHandItem = isHandItem(item, slot)
		if item and isHandItem then
			if item.go.effects_script then
				local effects = item.go.effects_script:getData()
				for i,v in pairs(effects) do
					if i == (type .. "_multi") then
						multi = multi + v
					end
				end
			end
			
			-- Average Joe racial trait
			if item.go.equipmentitem and champion:hasTrait("average_joe") and type ~= "neutral" then
				if useJoeBonus then -- prevents recursion
					local resist = { 
						["poison"] = item.go.equipmentitem:getResistPoison(), 
						["fire"] = item.go.equipmentitem:getResistFire(), 
						["cold"] = item.go.equipmentitem:getResistCold() , 
						["shock"] = item.go.equipmentitem:getResistShock(), 
					}
					multi = multi + ((resist[type] or 0) * 0.01 * 1.1)
				end
			end
		end
	end

	if champion:hasTrait("average_joe") and type ~= "neutral" and useJoeBonus then
		multi = multi * 0.5		
	end
	
	return multi
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

function psionicArrow(id)
	local champion = party.party:getChampionByOrdinal(id)
	local spell = spells_functions.script.defByName["psionic_arrow"]
	spell.onCast(champion, party.x, party.y, party.facing, party.elevation, 3)
end

function drinkPotion(self, champion, duration)
	if self.go.potion_stack and self.go.potion_stack:getTop() == "perfect" then
		champion:setConditionValue("perfect_mix", duration)
	end
end

function droppedItemOnPortrait(mouseItem, champion)
	for slot = 1,ItemSlot.BackpackLast do
		local item = champion:getItem(slot)
		if item then
			if item.go.name == mouseItem.go.name and item:getStackable() and mouseItem.go.item:getStackable() then
				if item:hasTrait("potion") and item:getStackSize() > 1 then
					stackedPotions(champion, slot, item, mouseItem, "increase")
				end
			end
		end
	end
end

function stackedPotions(champion, slot, itemBot, itemTop, op)
	local c = champion:getOrdinal()

	if itemTop.go.potion_stack then
		if op == "increase" then
			if itemTop then 
				local data = itemTop.go.potion_stack:getData()
				-- if data[1] == nil then print("it's nil") end
				for i = 1, #data do
					itemBot.go.potion_stack:insert(data[i]) 
				end
				setPerfectPotionGE(itemBot)
			end

			if itemTop then itemTop.go.potion_stack.remove() end
			setPerfectPotionGE(itemTop)

		elseif op == "decrease" then
			if itemBot then
				if itemTop then -- doesnt trigger when drinking
					itemTop.go.potion_stack:insert(itemBot.go.potion_stack:getTop()) 
					setPerfectPotionGE(itemTop)
				end

				itemBot.go.potion_stack:remove()
				setPerfectPotionGE(itemBot)
			end
		end
	end

	functions.script.set_c("potion_top_item", c, nil)
	functions.script.set_c("potion_bottom_item", c, nil)
	functions.script.set_c("potion_stacks", c, nil)
	functions.script.set_c("potion_slot", c, nil)
end

function setPerfectPotionGE(item)
	if item.go.potion_stack:getTop() == "perfect" then
		item.go.item:setGameEffect("Perfect Mix: Duration +25%, +20 Protection during the effect.")
		local name = item.go.item:getUiName()
		if not string.find(name, "Perfect ") then
			name = "Perfect " .. name
		end
		item.go.item:setUiName(name)
	else
		item.go.item:setGameEffect(nil)
		local name = item.go.item:getUiName()
		local newName, s = string.gsub(name, "Perfect ", "")
		item.go.item:setUiName(newName)
	end
end
-------------------------------------------------------------------------------------------------------
-- Champion Functions                                                                                --    
-------------------------------------------------------------------------------------------------------

function regainHealth(id, amount)
	if not id then return end
	if not amount then return end
	local champion = party.party:getChampionByOrdinal(id)

	-- Diseased cuts health recovery
	local diseased = champion:hasCondition("diseased") and 0 or 1

	amount = math.ceil(amount * diseased)
	champion:regainHealth(amount)
end

function regainEnergy(id, amount)
	if not id then return end
	if not amount then return end
	local champion = party.party:getChampionByOrdinal(id)

	-- Lore Master energy gain bonus
	local lore_master = get_c("lore_master_9", champion:getOrdinal()) or 1

	amount = math.ceil(amount * lore_master)
	champion:regainEnergy(amount)
end

function onChampionTakesDamage(party, champion, damage, damageType) -- champion takes damage from any source -- no reference to monsters
	-- Brutalizer - increases damage taken
	if champion:hasTrait("brutalizer") and damageType ~= "pure" then
		local str = champion:getCurrentStat("strength")
		champion:damage(damage * str * 0.005, "pure")
	end
	
	-- Skills
	-- Heavy Conditioning
	if champion:hasTrait("conditioning") or isArmorSetEquipped(champion, "plate") then
		-- Chance is doubled if champion already has condition
		local chance = champion:hasCondition("conditioning") and 0.2 or 0.1
		if math.random <= chance then
			local duration = (isArmorSetEquipped(champion, "plate") and champion:hasTrait("conditioning")) and 120 or 60
			champion:setConditionValue("conditioning", duration)
		end
	end

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
	-- if champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "hardstone_bracelet" then
	-- 	if math.random() <= 0.2 then
	-- 		champion:setConditionValue("hardstone", 10)
	-- 	end
	-- end

	-- Scaled Cloak
	if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "scaled_cloak" then
		if math.random() <= (champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 0.25 or 0.1) then
			spells_functions.script.elementalShields(30, champion, damageType == "fire", false, false, false)
		end
	end
end

function isArmorSetEquipped(champion, set)
	if champion:isArmorSetEquipped(set) then
		return true
	end

	local armorSetPieces = { ["chitin"] = 5, ["valor"] = 6, ["crystal"] = 6, ["meteor"] = 6, ["bear"] = 3, ["embalmers"] = 4, ["archmage"] = 4, ["rogue"] = 5, ["makeshift"] = 5, ["reed"] = 5, ["mirror"] = 5, ["plate"] = 5, ["lurker"] = 4 }
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
			if champion:hasTrait("armor_training") and (secondarySlots[i] == 3 or secondarySlots[i] == 9) then
				setCount = setCount + 1
			end
		end
	end
	
	return setCount == armorSetPieces[set]
end

function isArmorSetEquippedByAnyone(set)
	local result = false
	for i=1,4 do
		local champion = party.party:getChampionByOrdinal(i)
		if isArmorSetEquipped(champion, set) then
			result = true
			break
		end
	end
	return result
end

-- returns true if a held item is in the appropriate slot, so you don't gain a bonus if an armor is in the hand, etc
function isHandItem(item, slot)
	if item then
		if slot == ItemSlot.Weapon or slot == ItemSlot.OffHand then
			if item.go.meleeattack or item.go.rangedattack or item.go.throwattack or item.go.firearmattack or item:hasTrait("orb") or item:hasTrait("shield") then
				return true -- item in hand is a weapon, staff, shield, etc
			else
				return false -- item in hand is not a weapon
			end
		elseif slot ~= ItemSlot.Weapon2 and slot ~= ItemSlot.OffHand2 then
			return true -- slot isn't a hand slot and not a swapped slot
		else 
			return true
		end
	else
		return false
	end
end

-- For item traits that can be converted, we check with this function instead of item:hasTrait()
function getTrait(champion, item, trait)
	if item then
		if item:hasTrait(trait) then
			return true
		else
			-- if champion:getClass() == "assassin_class" then
			-- 	if trait == "light_weapon" and item:hasTrait("heavy_weapon") then
			-- 		return true
			-- 	elseif trait == "heavy_weapon" and item:hasTrait("light_weapon") then
			-- 		return true
			-- 	end
			-- end
			return false
		end	
	end
end

function anyChampionTrait(trait)
	for i=1,4 do
		local champion = party.party:getChampionByOrdinal(i)
		if champion:hasTrait(trait) then
			return true
		end
	end
	return false
end

function anyChampionItem(name)
	for i=1,4 do
		local champion = party.party:getChampionByOrdinal(i)
		for j=1,ItemSlot.Bracers do
			local item = champion:getItem(j)
			local isHandItem = isHandItem(item, j)
			if item and isHandItem then
				if item.go.name == name then return true end
			end
		end
	end
	return false
end

function championItemExtraEffects(champion)
	local effects = { }

	-- Add effects for champion
	for j=1,ItemSlot.Bracers do
		local item = champion:getItem(j)
		local isHandItem = isHandItem(item, j)
		if item and isHandItem and item.go.effects_script then
			local item_effects = item.go.effects_script:getData()
			effects = merge(effects, item_effects)
		end
	end

	-- Add party effects
	for i=1,4 do
		champion = party.party:getChampionByOrdinal(i)
		for j=1,ItemSlot.Bracers do
			local item = champion:getItem(j)
			local isHandItem = isHandItem(item, j)
			if item and isHandItem and item:hasTrait("party_effect") and item.go.effects_script then
				local item_effects = item.go.effects_script:getData()
				effects = merge(effects, item_effects)
			end
		end
	end

	return effects
end

-------------------------------------------------------------------------------------------------------
-- Status Effects Functions                                                                          --    
-------------------------------------------------------------------------------------------------------

-- Bleeding
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

function bleedMonster(self, e, champion, monster, bleedChance) -- self = projectile, e = tiledamager
	local c = champion:getOrdinal()
	bleedChance = bleedChance or 0
	if champion:getClass() == "assassin_class" then set_c("assassin_bleed", c, nil) end

	if bleedChance > 0 and math.random() <= bleedChance then	
		setBleeding(monster, c)
	end
end

function setBleeding(monster, c)
	if monster:isAlive() and not monster:isImmuneTo("physical") then	
		monster:addTrait("bleeding")
		set(monster.go.id .. "bleeding", c)
	end
end

function takeBleedDamage(monster, action) -- Called by monsters within their MonsterMove object
	if monster:hasTrait("bleeding") and monster:isAlive() and not monster:isImmuneTo("physical") then
		local causedByChampion = get(monster.go.id .. "bleeding")
		if math.random() < 0.05 then -- 5% chance to stop bleeding
			monster:removeTrait("bleeding")
			monster.go.model:setEmissiveColor(vec(0,0,0))
		end

		if math.random() <= 0.5 then
			if action == "walk" then
				hitMonster(monster.go.id, math.random(monster:getHealth() * 0.015, monster:getHealth() * 0.03), nil, "pure", causedByChampion)
			elseif action == "dot" then
				hitMonster(monster.go.id, math.random(monster:getHealth() * 0.005, monster:getHealth() * 0.01), nil, "pure", causedByChampion)
			end
			monster.go:createComponent("Particle", "splatter")
			monster.go.splatter:setOffset(vec(math.random() - 0.4, math.random() - 0.4 + 1, math.random() - 0.4))
			monster.go.splatter:setParticleSystem("hit_blood")
			monster.go.splatter:setDestroySelf(true)
		end
	end
end

-- Poison
function poisonMonster(self, e, champion, monster, poisonChance)
	local c = champion:getOrdinal()
	local duration = 21 + champion:getSkillLevel("poison_mastery") + champion:getSkillLevel("witchcraft")
	poisonChance = poisonChance or 0

	if poisonChance > 0 and math.random() <= poisonChance then	
		setPoisoned(monster, duration, c, poisonChance)
	end
end

function setPoisoned(monster, duration, c, chance)
	if monster:isAlive() and monster:getResistance("poison") ~= "immune" and monster:getResistance("poison") ~= "absorb" and not monster:isImmuneTo("poisoned") then
		monster:setCondition("poisoned", duration)
		if monster.go.poisoned and c then monster.go.poisoned:setCausedByChampion(c)  end
	end
end

-- Burn
function burnMonster(self, e, champion, monster) -- self = projectile, e = tiledamager
	monster = monster.monster
	local c = champion:getOrdinal()
	local baseChance = 0.2
	-- At 100 Fire Multiplier you gain 50% burn chance
	local chance = baseChance + (empowerElement(champion, "fire", 0.1, true) * 0.5)
	chance = chance + getEquippedMultiBonus(champion, "burn_chance", false)

	if e.go.name == "fireburst"  then
		chance = chance + getEquippedMultiBonus(champion, "burn_chance_basic", false)
	end
	
	local duration = math.min(math.max(math.random() * (10 + (champion:getSkillLevel("elemental_magic")*2) + (champion:getSkillLevel("witchcraft")*2)), 10), 30)
	duration = duration + getEquippedMultiBonus(champion, "burn_duration", false)

	if chance > 0 and math.random() <= chance then
		setBurning(monster, duration, c, chance)
	end
end

function setBurning(monster, duration, c, chance)
	if monster:isAlive() and monster:getResistance("fire") ~= "immune" and monster:getResistance("fire") ~= "absorb" and not monster:isImmuneTo("burning") then
		if chance > 1 then -- duration increses if chance over 100%
			duration = duration * chance
		end
		monster:setCondition("burning", duration)
		if  monster.go.burning and c then  monster.go.burning:setCausedByChampion(c) end
	end
end

-- Freeze
function freezeMonster(self, e, champion, monster) -- self = projectile, e = tiledamager
	monster = monster.monster
	local c = champion:getOrdinal()
	local skillLevel = champion:getSkillLevel("elemental_magic")
	-- Chance
	local baseChance = 0.2
	-- At 100 Cold Multiplier you gain 10% freeze chance
	local chance = baseChance + (empowerElement(champion, "cold", 0.1, true) * 0.1)
	chance = chance + getEquippedMultiBonus(champion, "freeze_chance", false)

	if e.go.name == "frostburst_cast" then
		chance = chance + getEquippedMultiBonus(champion, "freeze_chance_basic", false)
	end

	if e.go.name == "frostburst_bomb" then
		chance = 1
	end
	-- Duration
	local duration = math.min(math.max(math.random() * (2 + champion:getSkillLevel("elemental_magic") + champion:getSkillLevel("witchcraft")), 2), 10)	

	if e.go.name == "frostburst_bomb" then
		duration = math.max((duration * 1.5) + 1, 15)
	end

	duration = duration + getEquippedMultiBonus(champion, "freeze_duration", false)

	if chance > 0 and math.random() <= chance then	
		setFreezing(monster, duration, c, chance)
	end
end

function setFreezing(monster, duration, c, chance)
	if monster:isAlive() and monster:getResistance("cold") ~= "immune" and monster:getResistance("cold") ~= "absorb" and not monster:isImmuneTo("freezing") then
		monster:setCondition("frozen", duration)
	end
end

-- Shock damage bounce
function shock_arc(self, e, champion, monster) -- self = projectile, e = tiledamager
	monster = monster.monster
	if e.go.name == "shockburst_noarc" then return end
	local skillLevel = champion:getSkillLevel("witchcraft")

	-- Damage
	local damage = e and e:getAttackPower() * (0.75 + skillLevel / 20) or 0
	damage = damage + getEquippedMultiBonus(champion, "arc_damage", false)

	-- Chance
	local baseChance = 0.1
	-- At 100 Shock Multiplier you gain 40% arc chance
	local chance = baseChance + (empowerElement(champion, "shock", 0.1, true) * 0.4)
	chance = chance + getEquippedMultiBonus(champion, "arc_chance", false)
	if e.go.name == "shockburst" then
		chance = chance + getEquippedMultiBonus(champion, "arc_chance_basic", false)
	end

	-- Find monster within range
	if math.random() > chance then return end
	local mList = {}
	local range = (3 + (getEquippedMultiBonus(champion, "arc_range", false) * 2 )) ^ 2
	for d=0,range-1 do
		local dx = math.floor(d / 3) - ((math.sqrt(range)-1) / 2)
		local dy = ((d-1) % 3) - ((math.sqrt(range)-1) / 2)
		for ent in Dungeon.getMap(party.level):entitiesAt(monster.go.x + dx, monster.go.y + dy) do
			if ent.monster and ent.go ~= monster.go then
				table.insert(mList, ent.monster)
			end
		end
	end

	-- Perform arc
	if #mList > 0 then
		local newMonster = mList[ math.random( #mList ) ]
		if newMonster and newMonster ~= monster then
			local a = spawn("shockburst_noarc", party.level, newMonster.go.x, newMonster.go.y, newMonster.go.facing, newMonster.go.elevation)
			if a.tiledamager then 
				a.tiledamager:setCastByChampion(champion:getOrdinal()) 
				a.tiledamager:setAttackPower(damage)
			end
		end
	end
end
	
-- Stunned
function setStunned(monster, duration, c, chance)
	if monster:isAlive() and duration then
		if chance > 1 then -- duration increses if chance over 100%
			duration = duration * chance
		end
		monster:setCondition("stunned", duration)
	end
end

-------------------------------------------------------------------------------------------------------
-- Empower Functions                                                                                 -- 
-------------------------------------------------------------------------------------------------------

function empowerElement(champion, element, base, return_only, tier, spell)
	f = base
	return_only = return_only and return_only or false
	tier = tier and tier or 0
	spell = spell and spell or false -- defines if it's a spell or attack
	local ord = champion:getOrdinal()
	
	if spell then -- it's a spell
		
	else -- it's an attack

	end
	
	if element ~= "physical" then -- non physical
		if champion:getClass() == "elementalist" then
			f = f + (elementalistPower(element, champion, return_only) * base)
		end
		
		if champion:hasTrait("moon_rites") and GameMode.getTimeOfDay() > 1.01 then
			f = f + (0.1 * base)
		end
		
		-- Body and Mind bonus based on vitality
		if champion:hasTrait("body_and_mind") then
			local vitality = champion:getCurrentStat("vitality")
			local addVitality = ((vitality+1)^(1-0.95) - 1) / (1-0.95) * 0.95	
			addVitality = addVitality + (champion:getCurrentStat("vitality") * 0.005)			
			f = f + ((addVitality * 0.1) * base)
		end
	end
	
	if element == "poison" then	
		-- Items
		local itemPoisonBonus = getEquippedMultiBonus(champion, "poison", true)
		f = f + (itemPoisonBonus * base)

		-- Races
		
		-- Classes
		if champion:getClass() == "druid" then
			local multi = 0
			for slot = 8,10 do
				local druidItem = get_c("druid_item"..slot, ord)
				if druidItem then
					if druidItem == "crystal_flower" then
						multi = multi + 0.04
					elseif druidItem == "blackmoss" then
						multi = multi + 0.10
					end
				end
			end
			f = f + (multi * base)
		end

		-- Skills
		f = f + ((champion:getSkillLevel("poison_mastery") * 0.02) * base)
		
		-- Sets
		if isArmorSetEquipped(champion, "embalmers") then
			f = f + (0.15 * base)
		end
		
	elseif element == "fire" then
		-- Items
		local itemFireBonus = getEquippedMultiBonus(champion, "fire", true)
		f = f + (itemFireBonus * base)

		-- Races
		if champion:hasTrait("lizard_blood") then
			local fire = champion:getCurrentStat("resist_fire")
			local bonus = iff(fire >= 100, 0.3, 0)
			f = f + (bonus * base)
		end

		-- Classes
		if champion:getClass() == "tinkerer" then
			local bonus = (champion:getResistance("fire") * 0.01)
			f = f + (bonus * base) 
		end

		-- Skills
		f = f + ((champion:getSkillLevel("elemental_magic") * 0.2) * base)
				
		-- Fire Ruby
		local gem_charges = get_c("ruby_charges", ord)
		if gem_charges and gem_charges > 0 then
			f = f + (get_c("ruby_power", ord) * base)
			set_c("ruby_charges", ord, gem_charges - 1)
		elseif gem_charges == 0 then
			set_c("ruby_charges", ord, nil)
		end

	elseif element == "cold" then
		-- Items
		local itemColdBonus = getEquippedMultiBonus(champion, "cold", true)
		f = f + (itemColdBonus * base)

		-- Races
		if champion:hasTrait("lizard_blood") then
			local cold = champion:getCurrentStat("resist_cold")
			local bonus = iff(cold >= 100, 0.3, 0)
			f = f + (bonus * base)
		end

		-- Classes
		if champion:getClass() == "tinkerer" then
			local bonus = champion:getResistance("cold") * 0.01
			f = f + (bonus * base)
		end

		-- Cold Aquamarine
		local gem_charges = get_c("aquamarine_charges", ord)
		if gem_charges and gem_charges > 0 then
			f = f + (get_c("aquamarine_power", ord) * base)
			set_c("aquamarine_charges", ord, gem_charges - 1)
		elseif gem_charges == 0 then
			set_c("aquamarine_charges", ord, nil)
		end

		-- Skills
		f = f + ((champion:getSkillLevel("elemental_magic") * 0.2) * base)
		
	elseif element == "shock" then
		-- Items
		local itemShockBonus = getEquippedMultiBonus(champion, "shock", true)
		f = f + (itemShockBonus * base)
		
		-- Races
		if champion:hasTrait("lizard_blood") then
			local shock = champion:getCurrentStat("resist_shock")
			local bonus = iff(shock >= 100, 0.3, 0)
			f = f + (bonus * base)
		end

		-- Classes
		if champion:getClass() == "tinkerer" then
			local bonus = champion:getResistance("shock") * 0.01
			f = f + (bonus * base)
		end
		
		-- Skills
		f = f + ((champion:getSkillLevel("elemental_magic") * 0.2) * base)

		-- Shock Topaz
		local gem_charges = get_c("topaz_charges", ord)
		if gem_charges and gem_charges > 0 then
			f = f + (get_c("topaz_power", ord) * base)
			set_c("topaz_charges", ord, gem_charges - 1)
		elseif gem_charges == 0 then
			set_c("topaz_charges", ord, nil)
		end

	elseif element == "neutral" then
		-- Items
		local itemNeutralBonus = getEquippedMultiBonus(champion, "neutral", true)
		f = f + (itemNeutralBonus * base)
		
		-- Classes
		if champion:getClass() == "stalker" then
			local bonus = champion:hasTrait("night_stalker") and 2 or 1
			f = f + ((champion:getCurrentStat("dexterity") * 0.01 * bonus) + (math.floor(champion:getCurrentStat("dexterity") / 7) * 0.1 * bonus) * base)
		end
		
		-- Skills
		if champion:hasTrait("imperium_arcana") then
			local bonus = champion:getMaxEnergy() / 100 * 30 * 0.01
			f = f + (bonus * base)
		end

	elseif element == "physical" then -- Physical Spells
		-- Races
		-- Body and Mind bonus based on vitality
		if champion:hasTrait("body_and_mind") then
			local vitality = champion:getCurrentStat("vitality")
			local addVitality = ((vitality+1)^(1-0.95) - 1) / (1-0.95) * 0.95	
			addVitality = addVitality + (champion:getCurrentStat("vitality") * 0.005)			
			f = f + ((addVitality * 0.1) * base)
		end
		
		-- Skills
		if champion:hasTrait("imperium_arcana") then
			local bonus = champion:getMaxEnergy() / 100 * 35 * 0.01
			f = f + (bonus * base)
		end

		-- Items
		local itemPhysicalBonus = getEquippedMultiBonus(champion, "physical", false)
		f = f + (itemPhysicalBonus * base)
	end
	
	return f
end

function empowerAttackType(champion, attackType, base, return_only, tier)
	local f = base
	local ord = champion:getOrdinal()
	tier = tier and tier or 0

	-- Items
	local itemPhysicalBonus = getEquippedMultiBonus(champion, "physical", false)
	f = f + (itemPhysicalBonus * base)

	-- Deadly Aim trait bonus from 10% of accuracy
	if champion:hasTrait("deadly_aim") then
		local acc = get_c("deadly_aim", ord)
		f = f + (acc * 0.1 * base)
	end

	if attackType ~= "spell" then
		-- Assassin's charges
		if champion:getClass() == "assassin_class" then
			local charges = get_c("assassination", ord) or 0
			if charges > 0 then
				f = f + (0.04 * base * charges)
			end
		end

		-- Corsair doubloons
		if champion:getClass() == "corsair" then
			local coins = 0
			for i=1,ItemSlot.MaxSlots do
				local item = champion:getItem(i)
				if item then
					if item.go.name == "doubloon" then
						coins = coins + 1
					else
						local container = item.go.containeritem
						if container then
							local capacity = container:getCapacity()
							for j=1,capacity do
								local item2 = container:getItem(j)
								if item2 and item2.go.name == "doubloon" then
									coins = coins + 1
								end
							end
						end
					end
				end
			end
			f = f + (coins + math.min(coins/10) * 0.01 * base)
		end

		-- Classes
		-- Druid conversion
		if champion:getClass() == "druid" then
			local conversion = 0.2
			for slot = 8,10 do
				local druidItem = get_c("druid_item"..slot, ord)
				if druidItem and druidItem == "blackmoss" then
					conversion = conversion + 0.1
				end
			end
			f = f - (conversion * base)
		end
	end

	if attackType == "melee" then
		-- Class bonuses
		-- Race bonuses
		-- Brutalizer
		if champion:hasTrait("brutalizer") then
			f = f + ((champion:getCurrentStat("strength") * 0.01) * base)	
		end

		-- Skill bonuses
		if champion:hasTrait("sea_dog") and (champion == party.party:getChampion(3) or champion == party.party:getChampion(4)) then
			f = f + (0.25 * base)
		end

		-- Item bonuses
		-- Steel Armband
		-- if champion:getItem(ItemSlot.Bracers) and champion:getItem(ItemSlot.Bracers).go.name == "steel_armband" then
		-- 	local bonus = 4
		-- 	if champion:getItem(ItemSlot.Head) then bonus = bonus - 1 end
		-- 	if champion:getItem(ItemSlot.Chest) then bonus = bonus - 1 end
		-- 	if champion:getItem(ItemSlot.Legs) then bonus = bonus - 1 end
		-- 	if champion:getItem(ItemSlot.Feet) then bonus = bonus - 1 end
		-- 	if bonus > 0 then
		-- 		if secondary ~= self then
		-- 			-- secondary:setAttackPower(secondary:getAttackPower() * (1 + (bonus * 0.1)))
		-- 		end
		-- 	end
		-- end
		
		local itemMeleeBonus = getEquippedMultiBonus(champion, "melee", false)
		f = f + (itemMeleeBonus * base)

	elseif attackType == "spell" then
		f = f * ((champion:getCurrentStat("willpower") * 0.02) + 1)
		
		-- Items
		local itemSpellBonus = getEquippedMultiBonus(champion, "spell", false)
		f = f + (itemSpellBonus * base)

		-- if isArmorSetEquipped(champion, "mirror") then
		-- 	if champion:getProtection() > 36 then
		-- 		f = f - (0.1 * base)
		-- 	end
		-- end

		-- Arcane Warrior
		if tier < 3 then
			if champion:hasTrait("arcane_warrior") then
				local acc, dmg, avg = 0, 0
				dmg = getDamage(champion)
				avg = (dmg[1] + dmg[2]) / 2 * 0.002
				acc = getAccuracy(champion) * 0.001
				f = f + ((avg + acc) * base)
			end
		end
		
	
	elseif attackType == "ranged" then
		-- Class bonuses

		-- Skill bonuses
		if champion:hasTrait("sea_dog") and (champion == party.party:getChampion(1) or champion == party.party:getChampion(2)) then
			f = f + (0.25 * base)
		end

		-- Items
		local itemRangedBonus = getEquippedMultiBonus(champion, "ranged", false)
		f = f + (itemRangedBonus * base)

	elseif attackType == "missile" then
		-- Skill bonuses
		f = f + ((champion:getSkillLevel("ranged_weapons") * 0.2) * base)

		-- Item bonuses
		local itemMissileBonus = getEquippedMultiBonus(champion, "missile", false)
		f = f + (itemMissileBonus * base)

	elseif attackType == "throwing" then
		-- Skill bonuses
		f = f + ((champion:getSkillLevel("throwing_weapons") * 0.2) * base)

		-- Item bonuses
		local itemThrowingBonus = getEquippedMultiBonus(champion, "throwing", false)
		f = f + (itemThrowingBonus * base)


	elseif attackType == "light_weapons" then
		-- Skill bonuses
		f = f + ((champion:getSkillLevel("light_weapons_c") * 0.2) * base)

		-- Items
		local itemLightBonus = getEquippedMultiBonus(champion, "light_weapons", false)
		f = f + (itemLightBonus * base)

	elseif attackType == "heavy_weapons" then
		-- Skill bonuses
		f = f + ((champion:getSkillLevel("heavy_weapons_c") * 0.2) * base)

		-- Items
		local itemHeavyBonus = getEquippedMultiBonus(champion, "heavy_weapons", false)
		f = f + (itemHeavyBonus * base)

		-- Power Grip
		if champion:hasTrait("power_grip") and getTrait(champion, item, "heavy_weapon") then
			local bonus = (math.floor(champion:getHealth() / 5) + (math.floor(champion:getHealth() / 100) * 10)) * 0.01
			self:setAttackPower(self:getAttackPower() * (bonus + 1))
		end	

	elseif attackType == "firearms" then
		-- Items
		local itemFirearmBonus = getEquippedMultiBonus(champion, "firearms", false)
		f = f + (itemFirearmBonus * base)

	elseif attackType == "dual_wielding" then
		if champion:getClass() == "assassin_class" then
			f = f * 0.75
		else
			f = f * 0.6
		end

		-- Items
		local itemDualBonus = getEquippedMultiBonus(champion, "dual_wielding", false)
		f = f + (itemDualBonus * base)
	end
	
	return f
end

-------------------------------------------------------------------------------------------------------
-- Get Champion Stats Functions                                                                      -- 
-------------------------------------------------------------------------------------------------------

-- Returns the multiplier for a weapon's damage
function getDamage(champion, slot)
	local c = champion:getOrdinal()
	if slot == nil then slot = ItemSlot.Weapon end
	local item = champion:getItem(slot)
	
	local dmg = { 0, 0 }
	if champion:hasCondition("bear_form") then
		ap = 14
		dmg[1] = math.floor(ap * 0.5)
		dmg[2] = math.ceil(ap * 1.5)
		dmg[1] = math.floor(dmg[1] + math.max((math.ceil(champion:getCurrentStat("strength") - 10) * 0.5), 1))
		dmg[2] = math.floor(dmg[2] + math.max(((champion:getCurrentStat("strength") - 10) * 1.0), 2))
		return dmg
	end

	if item then
		local ap = 0
		local itemComp = nil
		local damage = 0
		if item.go.rangedattack then
			itemComp = item.go.rangedattack
			ap = itemComp:getAttackPower() or 0		
			damage = ap	
			damage = empowerAttackType(champion, "ranged", damage, true)
			damage = empowerAttackType(champion, "missile", damage, true)		
		elseif item.go.throwattack then
			itemComp = item.go.throwattack
			ap = itemComp:getAttackPower() or 0
			damage = ap
			damage = empowerAttackType(champion, "ranged", damage, true)
			damage = empowerAttackType(champion, "throwing", damage, true)	
		elseif item.go.firearmattack then
			itemComp = item.go.firearmattack
			ap = itemComp:getAttackPower() or 0
			damage = ap
			damage = empowerAttackType(champion, "firearms", damage, true)
			damage = empowerAttackType(champion, "missile", damage, true)
		elseif item.go.meleeattack then
			itemComp = item.go.meleeattack
			ap = itemComp:getAttackPower() or 0
			damage = ap
			damage = empowerAttackType(champion, iff(getTrait(champion, item, "heavy_weapon"), "heavy_weapons", "light_weapons"), damage, true)
			damage = empowerAttackType(champion, "melee", damage, true)
		else
			dmg[1] = 0
			dmg[2] = 0
			return dmg
		end

		if champion:isDualWielding() then
			damage = empowerAttackType(champion, "dual_wielding", damage, true)
		end

		damage = empowerElement(champion, "physical", damage, true)

		dmg[1] = math.floor(damage * 0.5)
		dmg[2] = math.floor(damage * 1.5)

		if itemComp:getBaseDamageStat() then
			dmg[1] = math.floor(dmg[1] + math.max((math.ceil(champion:getCurrentStat(itemComp:getBaseDamageStat()) - 10) * 0.5), 0))
			dmg[2] = math.floor(dmg[2] + math.max(((champion:getCurrentStat(itemComp:getBaseDamageStat()) - 10) * 1.0), 0))
		end
	else
		dmg[1] = 1 + math.max((math.ceil(champion:getCurrentStat("strength") - 10) * 0.5), 1)
		dmg[2] = 1 + math.max(((champion:getCurrentStat("strength") - 10) * 1.0), 2)
	end
	-- print("final dmg", dmg[1], dmg[2])
	return dmg
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
		add = get_c("wide_vision", champion:getOrdinal())
		acc = add and acc + (add * 5) or acc

		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("wide_vision") and not c:hasTrait("wide_vision_minor") then
				add = get_c("wide_vision", c:getOrdinal())
				acc = add and acc + (add * 2) or acc
			end
		end
	end
	
	-- Corsair +10 acc vs single foe
	-- if champion:getClass() == "corsair" and get("aggroMonsters") <= 1 then
	-- 	acc = acc + 10
	-- end

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

	-- Penalties
	if champion:hasCondition("head_wound") or champion:hasCondition("blind") then
		acc = acc - 50
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
		if item and item.go.equipmentitem then
			local itemCrit = item.go.equipmentitem:getCriticalChance() or 0
			add = itemCrit * (champion:hasTrait("weapons_specialist") and 2 or 1)
			crit = add and crit + add or crit
		end
	end

	-- Get crit from weapon used
	local item = champion:getItem(slot)
	if item then 
		if item.go.equipmentitem then
			local itemCrit = item.go.equipmentitem:getCriticalChance() or 0
			add = itemCrit * (champion:hasTrait("weapons_specialist") and 2 or 1)
			crit = add and crit + add or crit
		end

		if (item.go.rangedattack or item.go.throwattack) and champion:hasTrait("bullseye") then
			crit = crit + 5
		end
	end

	-- Corsair's +5 crit vs single foe
	if champion:getClass() == "corsair" and functions.script.get("aggroMonsters") == 1 then
		crit = crit + 5
	end

	-- Stalker's crit bonus
	if champion:getClass() == "stalker" then
		crit = crit + ((2 + (champion:getLevel() - 1)) * (champion:hasTrait("night_stalker") and 2 or 1))
	end

	-- Hunter's Thrill of the Hunt stacks
	if get_c("hunter_crit", c) then
		add = get_c("hunter_crit", c)
		crit = add and crit + add or crit
	end

	-- Ratling's Sneak Attack
	if champion:hasTrait("sneak_attack") and champion:hasCondition("sneak_attack") then
		add = 15
		crit = add and crit + add or crit
	end

	-- Deadly Aim trait
	if champion:hasTrait("deadly_aim") then
		add = get_c("deadly_aim", c)
		crit = add and crit + add or crit
	end

	-- Critical skill +3 per point
	crit = crit + (champion:getSkillLevel("critical") * 3)

	return crit
end

function getPierce(champion, slot)
	local c = champion:getOrdinal()
	local pierce = 0
	local add = 0
	slot = slot or ItemSlot.Weapon

	-- Get pierce from weapon used
	local item = champion:getItem(slot)
	if item then 
		if item.go.meleeattack then
			add = item.go.meleeattack:getPierce()
			pierce = add and pierce + add or pierce
		end

		if item.go.firearmattack then
			add = item.go.firearmattack:getPierce()
			pierce = add and pierce + add or pierce
		end
	end

	return pierce
end

function getActionSpeed(champion)	
	local speed = champion:getCurrentStat("cooldown_rate")
	local multi = speed

	if champion:hasCondition("drown_sorrows") then
		multi = multi + (speed * 0.5)
	end

	if champion:hasTrait("chewing") then
		multi = multi + (speed * 0.1)
	end

	if champion:hasCondition("shield_bearer") then
		multi = multi + (speed * 0.15)
	end

	if champion:hasTrait("chemical_processing") then
		local food = (champion:getFood()-500) / 500
		multi = multi + (speed * (0.15 * food))
	end

	-- if champion:hasTrait("rush") then
	-- 	local all_light = wearingAll(champion, "light_armor", "clothes")
	-- 	if all_light then
	-- 		multi = multi + (speed * 0.12)
	-- 	end	
	-- end

	if champion:hasTrait("fast_fingers") then
		local item1 = champion:getItem(ItemSlot.Weapon)
		local item2 = champion:getOtherHandItem(ItemSlot.Weapon)
		if (item1 and item1:hasTrait("firearm")) or (item2 and item2:hasTrait("firearm")) then
			multi = multi + (speed * 0.15)
		end
	end

	if champion:getClass() == "corsair" then
		local item1 = champion:getItem(ItemSlot.Weapon)
		local item2 = champion:getItem(ItemSlot.OffHand)
		if (item1 and item1:hasTrait("firearm")) or (item2 and item2:hasTrait("firearm")) then
			local level = champion:getLevel() - 1
			multi = multi + (speed * (-0.4 + (level * 0.015)))
		end
	end

	-- print("multi", multi, "speed", speed, "cd", champion:getCurrentStat("cooldown_rate") / 100)

	return multi
end

function getBlockChance(champion)
	local chance = 0.0
	local item1 = champion:getItem(ItemSlot.Weapon)
	local item2 = champion:getOtherHandItem(ItemSlot.Weapon)
	if (item1 and item1:hasTrait("shield")) or (item2 and item2:hasTrait("shield")) or isArmorSetEquipped(champion, "chitin") then
		chance = chance + 0.02
		chance = chance + champion:getSkillLevel("block") / 50

		-- Items
		local itemBlockBonus = getEquippedMultiBonus(champion, "block", false)
		chance = chance + itemBlockBonus

		if isArmorSetEquipped(champion, "chitin") then
			chance = chance + 0.04
		end

		if isArmorSetEquipped(champion, "valor") then
			chance = chance + 0.2
		end

		-- Skills
		if champion:hasTrait("block") then chance = chance + 0.08 end
		if champion:hasCondition("ancestral_charge") then chance = chance * 1.5 end
		
	end

	return chance
end

function getMiscResistance(champion, name)
	local c = champion:getOrdinal()
	local resist = 0
	local add = 0

	-- Items
	local itemResistanceBonus = getEquippedMultiBonus(champion, name, false)
	resist = resist + itemResistanceBonus

	if name == "disease" then
		if champion:getRace() == "ratling" then
			return 1
		end
		-- Armor Sets
		if isArmorSetEquipped(champion, "embalmers") then
			resist = resist + 0.5
		end

	elseif name == "bleeding" then
		
	elseif name == "poisoned" then
		-- Armor Sets
		if isArmorSetEquipped(champion, "embalmers") then
			resist = resist + 0.5
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

	if champion:getClass() == "fighter" then
		local bonus = math.floor((champion:getCurrentStat("strength") + champion:getCurrentStat("vitality")) / 5) * 5
		for i=1,6 do
			resist[i] = resist[i] + bonus
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

-------------------------------------------------------------------------------------------------------
-- UI Functions                                                                                      -- 
-------------------------------------------------------------------------------------------------------

function drawCounterOnHand(context, champion, x, y, value, tooltipTitle, tooltipText, lineCount, counters)
	local c = champion:getOrdinal()
	local posx, posy = x + 18, y + 28
	local MX, MY = context.mouseX, context.mouseY
	-- print("counters", counters)
	posy = posy + (counters * 24)

	if value and value ~= 0 then
		context.font("small")
		context.color(225, 225, 195, 255)
		local item1 = champion:getItem(ItemSlot.Weapon)
		local item2 = champion:getItem(ItemSlot.OffHand)
		if item1 and (item1.go.meleeattack or item1.go.rangedattack or item1.go.throwattack or item1.go.firearmattack) then
			context.drawText("" .. value, posx, posy)

		elseif item2 and (item2.go.meleeattack or item2.go.rangedattack or item2.go.throwattack or item2.go.firearmattack) then
			posx = posx + 78
			context.drawText("" .. value, posx, posy)
		end

		local val1, val2 = context.button("tooltip"..tooltipTitle, posx - 5, posy - 20, 20, 24)
		if val2 then
			functions.script.tooltipWithTitle(context, tooltipTitle, tooltipText, math.floor(MX - (math.min((context.getTextWidth(tooltipText)+21),250) / 2)), math.floor(MY - 24), lineCount)
		end
	end
end

function drawBarOnHand(context, champion, x, y, value, valueMax)
	local c = champion:getOrdinal()
	local posx, posy = x + 18, y + 28
	local MX, MY = context.mouseX, context.mouseY

	if value and value ~= 0 then
		context.color(225, 225, 195, 255)
		if champion:getItem(ItemSlot.Weapon) then
			drawBar(context, posx - 6, posy + 3, value, valueMax, 24, 3)

		elseif champion:getItem(ItemSlot.OffHand) then
			posx = posx + 78
			drawBar(context, posx - 6, posy + 3, value, valueMax, 24, 3)
		end
	end
end

function drawBarOnPortrait(context, champion, x, y, value, valueMax)
	local c = champion:getOrdinal()
	local posx, posy = x - 19, y - 9
	local MX, MY = context.mouseX, context.mouseY

	if value > 0 then
		context.color(225, 225, 195, 255)
		drawBar(context, posx, posy, value, valueMax, 59, 3)
	end
end

function drawBar(context, x, y, value, valueMax, width, height)
	context.drawImage2("mod_assets/textures/gui/bar.dds", x, y, 0, 0, 64, 64, math.min(value / valueMax * width, width), height)
end

function tooltipWithTitle(context, text1, text2, x, y, lineCount)
	local f2 = (context.height/1080)
	y = y - 24
	local backX = x - 7
	local backY = y - 80
	
	local width = math.min(context.getTextWidth(string.len(text1) > string.len(text2) and text1 or text2) + 21, 250)
	local height = (lineCount * 26) + 24

	tooltip(context, backX, backY, width, height)

	context.font("medium")
	context.color(255, 255, 255, 255)
	context.drawParagraph(text1, x, backY + 20, width - 7)
	context.font("small")
	context.drawParagraph(text2, x, backY + 44, width - 7)
end

function commonTooltip(context, text, x, y, lineCount)
	local f2 = (context.height/1080)
	y = y - 24
	local backX = x - 7
	local backY = y - 30
	local width = context.getTextWidth(text) + 21
	local height = lineCount * 26

	tooltip(context, backX, backY, width, height)

	context.font("small")
	context.color(255, 255, 255, 255)	
	context.drawParagraph(text1, x, y - 13, width - 7)
end

function statToolTip(context, hoverTxt1, hoverTxt2, x, y, lineCount) -- Draws the tooltip text and background for the Stats tab
	local f2 = (context.height/1080)
	y = y - 18 - (lineCount * 26)
	if x > 1500 then x = 1500 end -- window right margin
	local backX = x - 7
	local backY = y - 30
	local width = 412
	local height = 41 + (lineCount * 26)

	tooltip(context, backX, backY, width, height)

	context.font("large")
	context.color(255, 255, 255, 255)
	context.drawParagraph(hoverTxt1, x, y, width - 7)
	context.font("medium")
	context.drawParagraph(hoverTxt2, x, y + 28, width - 7)
end

function tooltip(context, backX, backY, width, height)
	context.color(0, 0, 0, 220)
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
								if item3 and item3.go.name == mat then
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
										if item3 and item3.go.name == mat then
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
				bonus = getBonus(champion:getSkillLevel("throwing_weapons"), 0.05)
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
					expertise = get_c("crafting_expertise", champion:getOrdinal())
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
						set_c("crafting_expertise", champion:getOrdinal(), expertise - 1)
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

-------------------------------------------------------------------------------------------------------
-- Dismantle Functions                                                                               -- 
-------------------------------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------------------------------
-- Secondary Attack Update/Setup Functions                                                           -- 
-------------------------------------------------------------------------------------------------------
function updateSecondary(meleeAttack, secondary, name, upgradeLevel)
	local item = meleeAttack.go.item
	if name == "banish" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 40 + math.floor(upgradeLevel * 12 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 2)
		secondary:setGameEffect("An extremely powerful attack. Deals 2.5x damage and has +9% critical chance.")
		secondary:setPierce(meleeAttack:getPierce() or 0)
		secondary:setBuildup(1.5)
		secondary:setSwipe("horizontal")
		secondary:setAttackSound("swipe_heavy")
		secondary:setCameraShake(true)
		secondary:setUiName("Banish")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+level,5), "critical", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+level,5), "critical", 1 })
		end
		secondary.go.item:setSecondaryAction("banish")

	elseif name == "bash" then	
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 12), 5)
		secondary:setEnergyCost( 15 + math.floor(upgradeLevel * 5 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A bone shattering blow that deals double damage and pierces 10 armor.")
		secondary:setPierce((meleeAttack:getPierce() or 0) + 10)
		secondary:setSwipe("vertical")
		secondary:setAttackSound("swipe")
		secondary:setBuildup(1.0)
		secondary:setUiName("Bash")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({ "light_weapons_c", math.min(upgradeLevel+level,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({ "heavy_weapons_c", math.min(upgradeLevel+level,5) })
		end
		secondary.go.item:setSecondaryAction("bash")

	elseif name == "bite" then	
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 30 + math.floor(upgradeLevel * 10 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 0.5)
		secondary:setAccuracy(50)
		secondary:setBaseDamageStat("none")
		secondary:setCooldown(meleeAttack:getCooldown())
		secondary:setGameEffect("A sting that injects poison into victim's bloodstream.")
		secondary:setPierce(meleeAttack:getPierce() or 0)
		secondary:setCauseCondition("poisoned")
		secondary:setConditionChance(100)
		secondary:setSwipe("vertical")
		secondary:setAttackSound("swipe")
		secondary:setBuildup(1.0)
		secondary:setUiName("Bite")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({ "light_weapons_c", math.min(upgradeLevel+level,5), "poison_mastery", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({ "heavy_weapons_c", math.min(upgradeLevel+level,5), "poison_mastery", 1 })
		end
		secondary.go.item:setSecondaryAction("bite")

	elseif name == "chop" then	
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 13), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A useful technique for chopping firewood and splitting the heads of your enemies. Deals double damage.")
		secondary:setPierce(meleeAttack:getPierce() or 0)
		secondary:setSwipe("vertical")
		secondary:setAttackSound("swipe")
		secondary:setBuildup(1.0)
		secondary:setUiName("Chop")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({ "light_weapons_c", math.min(upgradeLevel+level,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({ "heavy_weapons_c", math.min(upgradeLevel+level,5) })
		end
		secondary.go.item:setSecondaryAction("chop")

	elseif name == "chip" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 21 + math.floor(upgradeLevel * 7 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 2.0)
		secondary:setPierce(meleeAttack:getPierce() or 0)
		secondary:setBuildup(1.0)
		secondary:setGameEffect("This attack chips away 1 armor from the enemy with each hit.")		
		secondary:setSwipe("vertical")
		secondary:setAttackSound("swipe")
		secondary:setUiName("Chip")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({ "light_weapons_c", math.min(upgradeLevel+level,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({ "heavy_weapons_c", math.min(upgradeLevel+level,5) })
		end
		secondary.go.item:setSecondaryAction("chip")

	elseif name == "cleave" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A mighty blow that does 2.5 times damage and ignores 10 points of armor.")
		secondary:setPierce((meleeAttack:getPierce() or 0) + 10)
		secondary:setSwipe("vertical")
		secondary:setAttackSound("swipe_heavy")
		secondary:setUiName("Cleave")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+level,5)})
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+level,5)})
		end
		secondary.go.item:setSecondaryAction("cleave")

	elseif name == "dagger_throw" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 16), 5)
		secondary:setEnergyCost( 6 + math.floor(upgradeLevel * 6 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1.8)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.0)
		secondary:setBuildup(0.75)
		secondary:setGameEffect("Throws an item quickly at an enemy.")
		secondary:setUiName("Throw")
		--secondary:setSwipe("thrust")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({ "light_weapons_c", math.min(upgradeLevel+level,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({ "heavy_weapons_c", math.min(upgradeLevel+level,5) })
		end
		secondary.go.item:setSecondaryAction("dagger_throw")
		
	elseif name == "devastate" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 10), 5)
		secondary:setEnergyCost( 30 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.8)
		secondary:setGameEffect("An extremely powerful attack. Deals 2.5x damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setSwipe("vertical")
		secondary:setAttackSound("swipe_heavy")
		secondary:setCameraShake(true)
		secondary:setBuildup(1.25)
		secondary:setUiName("Devastate")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+level,5), "critical", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+level,5), "critical", 1 })
		end
		secondary.go.item:setSecondaryAction("devastate")

	elseif name == "flurry" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 7), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAccuracy(12 + (upgradeLevel * 2))
		secondary:setAttackPower(meleeAttack:getAttackPower() / 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.8)
		secondary:setGameEffect("A series of three quick slashes with deadly accuracy. Does 1.5x times damage.")
		secondary:setPierce(meleeAttack:getPierce() or 0)
		secondary:setRepeatCount(3)
		secondary:setRepeatDelay(0.2)
		secondary:setSwipe("flurry")
		secondary:setAttackSound("swipe")
		secondary:setUiName("Flurry of Slashes")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+level,5), "accuracy", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+level,5), "accuracy", 1 })
		end
		secondary.go.item:setSecondaryAction("flurry")

	elseif name == "knockback" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 7), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAccuracy(0)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A powerful blow that deals 1.5x damage and knocks enemies back.")
		secondary:setPierce(meleeAttack:getPierce() or 0)
		secondary:setSwipe("vertical")
		secondary:setBuildup(1.25)
		secondary:setAttackSound("swipe_heavy")
		secondary:setUiName("Knockback")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+level,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+level,5) })
		end
		secondary.go.item:setSecondaryAction("knockback")

	elseif name == "leech" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 25 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAccuracy(20 + (upgradeLevel * 5))
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1.25)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("Successful hit drains life from target and heals you.")
		secondary:setPierce(meleeAttack:getPierce() or 0)
		secondary:setSwipe("vertical")
		secondary:setAttackSound("swipe_light")
		secondary:setUiName("Leech")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+level,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+level,5) })
		end
		secondary.go.item:setSecondaryAction("leech")

	elseif name == "reap" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 7), 5)
		secondary:setEnergyCost( 40 + math.floor(upgradeLevel * 15 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower())
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown())
		secondary:setGameEffect("A deadly swing that has a chance of scoring x10 damage on a critical hit.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setSwipe("horizontal")
		secondary:setBuildup(1.25)
		secondary:setUiName("Harvest Time")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(level+level,5), "critical", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(level+level,5), "critical", 1 })
		end
		secondary.go.item:setSecondaryAction("reap")

	elseif name == "stun" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 7), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A powerful blow that has a ".. 18 + upgradeLevel * 6 .."% chance to stun an enemy. Deals double damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setCauseCondition("stunned")
		secondary:setConditionChance(18 + level * 6)
		secondary:setSwipe("vertical")
		secondary:setAttackSound("swipe")
		secondary:setUiName("Stun")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(level+level2,5)})
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(level+level,5)})
		end
		secondary.go.item:setSecondaryAction("stun")
		
	elseif name == "thrust" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(upgradeLevel * 8 / 3) * 3)
		secondary:setAccuracy(12 + (upgradeLevel * 2))
		secondary:setAttackPower(meleeAttack:getAttackPower() / 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.8)
		secondary:setGameEffect("A series of three quick slashes with deadly accuracy. Does 1.5x times damage.")
		secondary:setPierce(meleeAttack:getPierce() or 0)
		secondary:setAccuracy(50)
		secondary:setSwipe("thrust")
		secondary:setAttackSound("swipe")
		secondary:setUiName("Thrust")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons_c", math.min(upgradeLevel+level,5), "accuracy", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons_c", math.min(upgradeLevel+level,5), "accuracy", 1 })
		end
		secondary.go.item:setSecondaryAction("thrust")

	elseif name == "volley" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 13), 5)
		secondary:setEnergyCost( 12 + math.floor(upgradeLevel * 12 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("Fires three times in quick succession.")
		secondary:setUiName("Volley")
		secondary:setAmmo("arrow")
		secondary:setRepeatCount(3)
		secondary:setRepeatDelay(0.2)
		secondary:setBuildup(1.0)
		secondary:setAttackSound("swipe_bow")
		secondary:setRequirements({ "ranged_weapons", math.min(upgradeLevel+level, 5) })
		secondary.go.item:setSecondaryAction("volley")

	elseif name == "power_bolt" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 13), 5)
		secondary:setEnergyCost( 35 + math.floor(upgradeLevel * 15 / 3) * 3)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("Use a secondary firing function to launch quarrels with extra power, stunning enemies and doing 1.5x damage.")
		secondary:setAmmo("quarrel")
		secondary:setAttackSound("swipe_bow")
		secondary:setUiName("Power Bolt")
		secondary:setRequirements({ "ranged_weapons", math.min(upgradeLevel+level, 5) })
		secondary.go.item:setSecondaryAction("power_bolt")
	end
end
