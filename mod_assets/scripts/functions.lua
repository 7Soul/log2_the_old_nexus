assassinations = {0,0,0,0}
night_stalker = {1,1,1,1}
herb_timer = {0,0,0,0}
hunter_crit = {0,0,0,0}
hunter_timer = {0,0,0,0}
hunter_max = {0,0,0,0}
secondary = 0
spellSlinger = {}
stepCount = 0

function stepCountIncrease()
	stepCount = stepCount + 1
end

champSkillTemp1, champSkillTemp2 = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
champSkillTemp3, champSkillTemp4 = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
partySkillTemp = {champSkillTemp1, champSkillTemp2, champSkillTemp3, champSkillTemp4 } 
skillNames = { "athletics", "block", "light_armor", "heavy_armor", "accuracy", "critical", "firearms", "throwing", "alchemy", "ranged_weapons", "light_weapons", "heavy_weapons", "spellblade", "elemental_magic", "poison_mastery", "concentration" }

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
	for i=1,16 do
		if partySkillTemp[champ][i] > 0 then
			for j=1, partySkillTemp[champ][i] do
				partySkillTemp[champ][i] = partySkillTemp[champ][i] - 1
				champion:addSkillPoints(1)
			end
		end
	end
end

function performSkillTemp(champion)
	local champ = champion:getOrdinal()
	for i=1,16 do
		if partySkillTemp[champ][i] > 0 then
			for j=1, partySkillTemp[champ][i] do
				partySkillTemp[champ][i] = partySkillTemp[champ][i] - 1
				champion:trainSkill(skillNames[i], 1)
				champion:addSkillPoints(1)
			end
		end
	end
end

function countAllSkills(champion)
	local champ = champion:getOrdinal()
	local result = 0
	for i=1,16 do
		result = result + champion:getSkillLevel(skillNames[i])
	end
	return result
end

function teststart()
	functions2.script.start()
	if Editor.isRunning() then
		party.party:getChampionByOrdinal(1):setClass("fighter")
		party.party:getChampionByOrdinal(2):setClass("corsair")
		party.party:getChampionByOrdinal(3):setClass("druid")
		party.party:getChampionByOrdinal(4):setClass("elementalist")
		party.party:getChampionByOrdinal(4):setRace("insectoid")
		for i=1,4 do
			local champion = party.party:getChampionByOrdinal(i)
			if not champion:getItem(32) then champion:insertItem(32,spawn("torch").item) end
			champion:addSkillPoints(10)
			
			if champion:getClass() == "druid" then
				for s=13,32 do
					champion:removeItemFromSlot(s)
				end
				champion:insertItem(13,spawn("blooddrop_cap").item)
				champion:insertItem(14,spawn("etherweed").item)
				champion:insertItem(15,spawn("mudwort").item)
				champion:insertItem(16,spawn("falconskyre").item)
				champion:insertItem(17,spawn("blackmoss").item)
				champion:insertItem(18,spawn("crystal_flower").item)
			end
			if champion:getRace() == "minotaur" then
				champion:addTrait("carnivorous")
			end
			if champion:getRace() == "lizardman" then
				champion:addTrait("lizard_blood")
			end
			if champion:getRace() == "insectoid" then
				champion:addTrait("persistence")
			end
			if champion:getClass() == "wizard" then
				champion:trainSkill("elemental_magic")
			end
		end
	end
	for i=1,4 do
		local champion = party.party:getChampionByOrdinal(i)
		if champion:getClass() == "assassin" then
			champion:addTrait("assassination")
		end
		if champion:getClass() == "stalker" then
			local bonus = math.floor(party.party:getChampionByOrdinal(i):getLevel() / 4)
			night_stalker[i] = 1 + bonus
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
	if champion:getClass() == "hunter" then
		hunter_crit[id] = hunter_crit[id] + stack
		hunter_max[id] = dur
		champion:setConditionValue("hunter_crit", dur)
	end	
end

function checkHunterHit(item)
	for i=1,4 do
		if party.party:getChampionByOrdinal(i):getClass() == "hunter" then
			if functions.script.hunter_timer[i] > 0 then
				if item.go.name == "arrow" or item.go.name == "quarrel" then
					hunterCrit(i, 1, 6)
				end
			end
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

-------------------------------------------------------------------------------------------------------
-- Item and equipment events                                                                         --    
-------------------------------------------------------------------------------------------------------

function onConsumeFood(self, champion)
	if champion:hasTrait("carnivorous") then
		if self.go.item:hasTrait("consumable") and self.go.item:hasTrait("meat") then
			champion:setConditionValue("carnivorous", 60)
			champion:modifyFood(self.go.usableitem:getNutritionValue() * 0.15)
		else
			hudPrint("This isn't meat...")
			return false
		end
	end
end

b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12 = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
supertable = { b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12 }

function onEquipItem(self, champion, slot)
	-- if self:hasTrait(string.match(self.traits, "upgraded")) then
		-- supertable[5][self.go.id] = self.go.item:getWeight()
		-- self.go.item:setWeight(self.go.item:getWeight() + 5)
	-- end
	if champion:hasTrait("druid") then
		local item1 = champion:getItem(ItemSlot.Weapon)
		local item2 = champion:getItem(ItemSlot.OffHand)
		local herbitems = {"blooddrop_cap", "etherweed", "mudwort", "falconskyre", "blackmoss", "crystal_flower"}
		local herbItem = nil
		if (item1 and item1:hasTrait("herb")) then
			if (item2 and not(item2:hasTrait("herb") and true or false)) then
				herbItem = item1.go.name
			end
		end
		if (item2 and item2:hasTrait("herb")) then
			if (item1 and not(item1:hasTrait("herb") and true or false)) then
				herbItem = item2.go.name
			end
		end
		if herbItem ~= nil then
			champion:addTrait(herbItem)
			if herbItem == "mudwort" then
				for i=1,4 do
					if i ~= champion:getOrdinal() then
						party.party:getChampion(i):addTrait("lesser_mudwort")
					end
				end
			end
		end
	end
	
	local name = self.go.id
	if slot >= ItemSlot.BackpackFirst and slot <= ItemSlot.BackpackLast then
		if champion:hasTrait("heavy_conditioning") and self:hasTrait("heavy_armor") then
			supertable[12][self.go.id] = self.go.item:getWeight()
			self.go.item:setWeight(self.go.item:getWeight() * 0.25)
		end
	else
		if (slot >= 3 and slot <= 6) or slot == 9 then
			
		end
		-- Corsair firearms powerup		
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
			if self.go.equipmentitem then supertable[7][name] = self.go.equipmentitem:getResistFire() end
			if self.go.equipmentitem then supertable[8][name] = self.go.equipmentitem:getResistShock() end
			if self.go.equipmentitem then supertable[9][name] = self.go.equipmentitem:getResistCold() end
			
			if champion:getClass() == "corsair" then
				if self ~= nil and self:hasTrait("firearm") then
					local attackPower = self.go.firearmattack:getAttackPower()
					if tinker_item[1][name] then attackPower = tinker_item[1][name] end
					self.go.firearmattack:setAttackPower(math.floor(attackPower * (1.05 + (champion:getLevel() * 0.02))))
					self.go.firearmattack:setRange(self.go.firearmattack:getRange() + champion:getSkillLevel("firearms"))
				end
				if self ~= nil and self.go.name == "flintlock" then
					self.go.firearmattack:setAttackPower(math.floor(self.go.firearmattack:getAttackPower() * (1.1 + (champion:getLevel() * 0.1))))
					local cooldown = self.go.firearmattack:getCooldown()
					if tinker_item[2][name] then cooldown = tinker_item[2][name] end
					self.go.firearmattack:setCooldown(math.floor(cooldown * (0.8 - (champion:getLevel() * 0.02))))
				end				
			end
			
			if champion:hasTrait("weapons_specialist") then
				self.go.equipmentitem:setCriticalChance(supertable[6][name] * 2)
				if self.go.name == "scythe" then
					self.go.equipmentitem:setCriticalChance(5)
					supertable[6][name] = 5
				end
			end
			
			if self.go.name == "quarterstaff" and champion:getSkillLevel("spellblade") >= 1 then
				self.go.item:removeTrait("two_handed")
				self.go.meleeattack:setAttackPower(math.ceil(self.go.meleeattack:getAttackPower() * (1.1 + (champion:getSkillLevel("spellblade") * 0.1) + (champion:getCurrentStat("willpower") * 0.05))))
			end
		end
		-- Berserker unequips armor
		if champion:getClass() == "fighter" then
		local equipSlots = {3,4,5,6,9}
			for i=1,5 do
				if slot == equipSlots[i] then
					for j=13,32 do
						if champion:getItem(j) == nil then champion:insertItem(j, self) break end
						if j == 32 and champion:getItem(j) ~= nil then party:spawn(self.go.name) break end
					end
					hudPrint(champion:getName() .. ", the Berserker, refuses to wear armor.")
					champion:removeItemFromSlot(slot)
				end
			end
		end
	end
	if self.go.name == "enchanted_timepiece" then
		getTimepiece()
	end
end

function onUnequipItem(self, champion, slot)
	local name = self.go.id
	local slots = {2,1}
	local otherslot = slots[slot]
	-- Resets weight for all items when removing heavy armor
	if (slot >= 3 and slot <= 6) or slot == 9 then
		if champion:hasTrait("armor_training") then
			local equip_slots = {3,4,5,6,9}
			for i, v in pairs(equip_slots) do
				local item = champion:getItem(v)
				if item and item ~= self and supertable[12][item.go.id] and item:hasTrait("heavy_armor") then 
					item:setWeight(supertable[12][item.go.id])
					supertable[12][item.go.id] = nil
				end
			end
		end
	end
	
	if champion:hasTrait("druid") then
		local herbitems = {"blooddrop_cap", "etherweed", "mudwort", "falconskyre", "blackmoss", "crystal_flower"}
		for _,e in ipairs(herbitems) do
			champion:removeTrait(e)
			if e == "mudwort" then
				for i=1,4 do
					if i ~= champion:getOrdinal() then
						party.party:getChampion(i):removeTrait("lesser_mudwort")
					end
				end
			end
		end
	end
	
	if self.go.name == "quarterstaff" and champion:getSkillLevel("spellblade") >= 1 then
		self.go.item:addTrait("two_handed")
	end
	
	if supertable[1][name] ~= nil then
		local real_ap = 0
		if tinker_item[1][name] then real_ap = tinker_item[1][name] else real_ap = supertable[1][name] end
		if self.go.firearmattack then self.go.firearmattack:setAttackPower(real_ap) end
		if self.go.meleeattack then self.go.meleeattack:setAttackPower(real_ap) end
		supertable[1][name] = nil		
	end
	if supertable[2][name] ~= nil then
		local real_cooldown = 0
		if tinker_item[2][name] then real_cooldown = tinker_item[2][name] else real_cooldown = supertable[2][name] end
		if self.go.firearmattack then self.go.firearmattack:setCooldown(real_cooldown) end
		if self.go.meleeattack then self.go.meleeattack:setCooldown(real_cooldown) end
		supertable[2][name] = nil
	end
	if supertable[3][name] ~= nil then
		if self.go.firearmattack then self.go.firearmattack:setRange(supertable[3][name]) end
		supertable[3][name] = nil
	end
	if supertable[4][name] ~= nil then
		local real_pierce = 0
		if tinker_item[4][name] then 
			real_pierce = tinker_item[4][name] 
		else 
			if supertable[4][name] then
				real_pierce = supertable[4][name] 
			end
		end
		if self.go.firearmattack then self.go.firearmattack:setPierce(real_pierce) end
		if self.go.meleeattack then self.go.meleeattack:setPierce(real_pierce) end
		supertable[4][name] = nil
	end
	if supertable[5][name] ~= nil then
		if self.go.equipmentitem then self.go.equipmentitem:setAccuracy(supertable[5][name]) end
		supertable[5][name] = nil
	end
	if supertable[6][name] ~= nil then
		local real_crit = 0
		if tinker_item[6][name] then real_crit = tinker_item[6][name] else real_crit = supertable[6][name] end
		if self.go.equipmentitem then self.go.equipmentitem:setCriticalChance(real_crit) end
		supertable[6][name] = nil
	end
	if supertable[7][name] ~= nil then
		if self.go.equipmentitem then self.go.equipmentitem:setResistFire(supertable[7][name]) end
		supertable[7][name] = nil
	end
	if supertable[8][name] ~= nil then
		if self.go.equipmentitem then self.go.equipmentitem:setResistShock(supertable[8][name]) end
		supertable[8][name] = nil
	end
	if supertable[9][name] ~= nil then
		if self.go.equipmentitem then self.go.equipmentitem:setResistCold(supertable[9][name]) end
		supertable[9][name] = nil
	end
	-- if supertable[12][name] ~= nil then
		-- self.go.item:setWeight(supertable[12][name])
		-- supertable[12][name] = nil
	-- end	
end


-------------------------------------------------------------------------------------------------------
-- Attacking events                                                                                  --    
-------------------------------------------------------------------------------------------------------

function onMeleeAttack(self, item, champion, slot, chainIndex)
	supertable[1][item.go.id] = self:getAttackPower()
	supertable[2][item.go.id] = self:getCooldown()
	supertable[4][self.go.id] = self:getPierce() ~= nil and self:getPierce() or 0
	supertable[6][self.go.id] = self.go.equipmentitem and self.go.equipmentitem:getCriticalChance() or 0
	
	if math.random() <= 0.25 and champion:hasTrait("precision") then
		if not self:getPierce() then	
			self:setPierce(supertable[4][self.go.id] + 10)
		else
			self:setPierce(self:getPierce() + 10)
		end		
	end
	if champion:getClass() == "assassin" and champion:isDualWielding() then
		self:setAttackPower(self:getAttackPower() * 1.25 + (assassinations[champion:getOrdinal()] * 0.05) )
	end	
	if champion:getClass() == "hunter" and item:hasTrait("dagger") then
		self:setPierce(self:getPierce() + 10)
	end	
	if champion:getClass() == "corsair" then
		if item:hasTrait("light_weapon") then
			local item2 = champion:getOtherHandItem(slot)
			if item2 and item2:hasTrait("firearm") then
				delayedCall("functions", 0.25, "duelistSword", champion:getOrdinal(), item.go.name, slot)
			end
		end
	end
	if champion:hasTrait("brutalizer") then
		self:setAttackPower(self:getAttackPower() * (1.00 + (champion:getCurrentStat("strength") * 0.01)))
	end	
	if champion:hasTrait("persistence") then
		self:setAttackPower(self:getAttackPower() * (1.00 + (champion:getCurrentStat("willpower") * 0.01)))
	end	
	
	if not item.go.equipmentitem then
		item.go:createComponent("EquipmentItem", "equipmentitem")
	end	
	item.go.equipmentitem:setCriticalChance(supertable[6][self.go.id])
end

function onThrowAttack(self, champion, slot, chainIndex, item)
	supertable[1][item.go.id] = self:getAttackPower()
	supertable[2][item.go.id] = self:getCooldown()
	supertable[6][self.go.id] = self.go.equipmentitem and self.go.equipmentitem:getCriticalChance() or 0
	
	self:setAttackPower(self:getAttackPower() * (1 + champion:getSkillLevel("ranged_weapons") * 0.2))
	
	if champion:getClass() == "assassin" then
		item:setAttackPower(self:getAttackPower() * 1.25 + (assassinations[champion:getOrdinal()] * 0.05))
	end
	
	if champion:hasTrait("magic_missile") then
		delayedCall("functions", 0.1, "psionicArrow", champion:getOrdinal())
	end
	
	if not item.go.equipmentitem then
		item.go:createComponent("EquipmentItem", "equipmentitem")
	end	
	item.go.equipmentitem:setCriticalChance(supertable[6][self.go.id])
end

function onMissileAttack(self, champion, slot, chainIndex, item)
	supertable[1][self.go.id] = self:getAttackPower()
	supertable[2][self.go.id] = self:getCooldown()
	supertable[6][self.go.id] = self.go.equipmentitem and self.go.equipmentitem:getCriticalChance() or 0
	
	self:setAttackPower(self:getAttackPower() * (1 + champion:getSkillLevel("ranged_weapons") * 0.2))
	
	if champion:hasTrait("magic_missile") then
		delayedCall("functions", 0.1, "psionicArrow", champion:getOrdinal())
	end
	
	if not item.go.equipmentitem then
		item.go:createComponent("EquipmentItem", "equipmentitem")
	end	
	item.go.equipmentitem:setCriticalChance(supertable[6][self.go.id])
end

function getAccuracy(id)
	local champion = party.party:getChampionByOrdinal(id)
	local acc = 0
	for slot = 1,ItemSlot.Bracers do
		local item = champion:getItem(slot)
		if item and item.equipmentitem then
			local add = item.equipmentitem:getAccuracy()
			if add and add ~= 0 then acc = acc + add end
		end
	end
	acc = acc + (champion:getSkillLevel("accuracy") * 10)
	acc = acc + ((champion:getCurrentStat("dexterity") - 10) * 2)
	return acc
end

function getCrit(id)
	local champion = party.party:getChampionByOrdinal(id)
	local crit = 0
	for slot = 1,ItemSlot.Bracers do
		local item = champion:getItem(slot)
		if item and item.equipmentitem then
			local add = item.equipmentitem:getCriticalChance()
			if add and add ~= 0 then crit = crit + add end
		end
	end
	crit = crit + (champion:getSkillLevel("critical") * 3)
	return crit
end

function getDamage(id, weapon)
	local champion = party.party:getChampionByOrdinal(id)
	local item = nil
	local item1 = champion:getItem(ItemSlot.Weapon)
	local item2 = champion:getItem(ItemSlot.OffHand)
	if item1 and item1:hasTrait(weapon) then
		item = champion:getItem(ItemSlot.Weapon)
	elseif item2 and item2:hasTrait(weapon) then
		item = champion:getItem(ItemSlot.OffHand)
	end
	local dmg = 0
	if item and item.go.rangedattack then
		dmg = item.go.rangedattack:getAttackPower() or 0
		dmg = dmg * (1 + (champion:getCurrentStat("dexterity") * 0.04))
	elseif item and item.go.throwattack then
		dmg = item.go.throwattack:getAttackPower() or 0	
		dmg = dmg * (1 + (champion:getCurrentStat("dexterity") * 0.04))
	elseif item and item.go.meleeattack then
		dmg = item.go.meleeattack:getAttackPower() or 0	
		dmg = dmg * (1 + (champion:getCurrentStat("strength") * 0.04))
	end
	--dmg = dmg + item.go.data.get("damage")
	dmg = dmg - (dmg * 0.5) + (dmg * math.random() * 1)
	return dmg
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
	if math.random() > 0.75 + champion:getSkillLevel("firearms") * 0.05 then
		if supertable[1][self.go.id] then
			self:setAttackPower(supertable[1][self.go.id] * 0.2)
		else
			self:setAttackPower(self:getAttackPower() * 0.2)
		end
	end
	
	if math.random() <= 0.25 and champion:hasTrait("precision") then
		if not self:getPierce() then	
			self:setPierce(supertable[4][self.go.id] + 10)
		else
			self:setPierce(self:getPierce() + 10)
		end	
	end
	
	if champion:hasTrait("fleshbore") then
		if not self:getPierce() then	
			self:setPierce(supertable[4][self.go.id] + 10)
		else
			self:setPierce(self:getPierce() + 10)
		end	
	end
	
	if champion:getClass() == "corsair" then
		local item = champion:getItem(slot)
		local item2 = champion:getOtherHandItem(slot)
		local slots = {2, 1}
		local otherslot = slots[slot]
		local pellets = nil
		local pelletsSlot = nil
		
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
							tinker_item[10][item2.go.id] = item2.go.item:getUiName()
							tinker_item[1][item2.go.id] = supertable[1][item2.go.id]
							tinker_item[2][item2.go.id] = supertable[2][item2.go.id]
							tinker_item[4][item2.go.id] = supertable[4][item2.go.id]
							tinker_item[5][item2.go.id] = supertable[5][item2.go.id]
							tinker_item[6][item2.go.id] = supertable[6][item2.go.id]
							tinker_item[7][item2.go.id] = supertable[7][item2.go.id]
							tinker_item[8][item2.go.id] = supertable[8][item2.go.id]
							tinker_item[9][item2.go.id] = supertable[9][item2.go.id]
							tinker_item[12][item2.go.id] = supertable[12][item2.go.id]
							for j=1,18 do
								if item2:hasTrait("upgraded"..j) then tinker_item[11][item2.go.id] = "upgraded"..j end
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
	local item = champion:getItem(slot)
	if champion:getClass() == "corsair" then
		local slots = {2, 1}
		local otherslot = slots[slot]		
		if corsairItem ~= nil and item.go.name ~= "revolver" then
			champion:removeItemFromSlot(otherslot)
			local newItem = spawn(corsairItem).item
			
			if tinker_item[10][corsairItemId] then newItem:setUiName(tinker_item[10][corsairItemId]) end
			if tinker_item[12][corsairItemId] then newItem:setWeight(tinker_item[12][corsairItemId]) end
			if tinker_item[11][corsairItemId] then newItem:addTrait(tinker_item[11][corsairItemId]) newItem:addTrait("upgraded") end
			if tinker_item[1][corsairItemId] then newItem.go.firearmattack:setAttackPower(tinker_item[1][corsairItemId]) end
			if tinker_item[2][corsairItemId] then newItem.go.firearmattack:setCooldown(tinker_item[2][corsairItemId]) end
			if tinker_item[4][corsairItemId] then newItem.go.firearmattack:setPierce(tinker_item[4][corsairItemId]) end
			newItem.go:createComponent("EquipmentItem")
			if tinker_item[5][corsairItemId] then newItem.go.equipmentitem:setAccuracy(tinker_item[5][corsairItemId]) end
			if tinker_item[6][corsairItemId] then newItem.go.equipmentitem:setCriticalChance(tinker_item[6][corsairItemId]) end
			if tinker_item[7][corsairItemId] then newItem.go.equipmentitem:setResistFire(tinker_item[7][corsairItemId]) end
			if tinker_item[8][corsairItemId] then newItem.go.equipmentitem:setResistShock(tinker_item[8][corsairItemId]) end
			if tinker_item[9][corsairItemId] then newItem.go.equipmentitem:setResistCold(tinker_item[9][corsairItemId]) end
			
			champion:insertItem(otherslot, newItem)			
			
			if secondary2 == 0 and champion:getItem(otherslot) and champion:getItem(otherslot):hasTrait("firearm") then
				secondary = 1
				delayedCall("functions", 0.25, "secondShot", champion:getOrdinal(), otherslot)
			else
				secondary = 0
			end
		end
	end
	
	if champion:hasTrait("metal_slug") and item.go.name ~= "revolver" then
		local pelletsSlot = nil
		local pellets = nil
		if math.random() >= 0.93 then
			for i=1,32 do
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

function secondShot(id, slot)
	local champion = party.party:getChampionByOrdinal(id)
	champion:attack(slot, false)
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


function reset_attack(self, champion, slot, secondary2)
	-- Attack twice
	local otherItem = nil
	local otherSlotList = {2,1}
	if secondary2 == 0 and champion:hasTrait("double_shot") and (self.go.rangedattack or self.go.throwattack or self.go.firearmattack) then
		secondary = 1
		if champion:getItem(slot):hasTrait("throwing_weapon") then
			local otherItem = champion:getOtherHandItem(slot)
			if otherItem and otherItem:hasTrait("throwing_weapon") then
				slot = otherSlotList[slot]
			end
		end
		delayedCall("functions", 0.25, "secondShot", champion:getOrdinal(), slot)
	else
		secondary = 0
	end
	-- Reset attack power and cooldown
	self:setAttackPower(supertable[1][self.go.id])
	self:setCooldown(supertable[2][self.go.id]) 
	-- Reset pierce for non-missiles
	if not self.go.item:hasTrait("missile_weapon") and not self.go.item:hasTrait("throwing_weapon") then
		self:setPierce(supertable[4][self.go.id])
	end
	-- Reset range for firearms
	if self.go.item:hasTrait("firearm") then 
		self:setRange(supertable[3][self.go.id]) 
	end
	if not self.go.equipmentitem then
		self.go:createComponent("EquipmentItem", "equipmentitem")
		self.go.equipmentitem:setCriticalChance(supertable[6][self.go.id])
	else
		self.go.equipmentitem:setCriticalChance(supertable[6][self.go.id])
	end
end

function wearingAll(champion, armor, armor2)
	if armor2 == nil then armor2 = armor end
	local wearing_all = true
	local equip_slots = {3,4,5,6,9}
	for i, v in pairs(equip_slots) do
		if champion:getItem(v) ~= nil then
			if (not champion:getItem(v):hasTrait(armor)) and (not champion:getItem(v):hasTrait(armor2)) then	
				wearing_all = false
			end
		else
			wearing_all = false
		end
	end
	return wearing_all
end

-------------------------------------------------------------------------------------------------------
-- Attack events                                                                                     --    
-------------------------------------------------------------------------------------------------------
-- Monster attacked by champion

function monster_attacked(self, monster, tside, damage, champion) -- self = meleeComponent
	-- Pickaxe Chip effect
	if self:getUiName() == "Chip" then
		local chip = self.go.item:hasTrait("upgraded") and -2 or -1
		monster:setProtection(monster:getProtection() and monster:getProtection() + chip, 0)
		monster:showDamageText(chip.." Armor", "FFFFFF", "Chip!")
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
	
	-- Killin blow effects
	if monster:getHealth() - damage <= 0 then
		if champion:hasTrait("assassination") and tside == 2 then
			champion:removeTrait("assassination")
			local stat = math.floor(math.random() * 100) % 4
			if stat == 1 then
				champion:addStatModifier("strength", 1)
				champion:gainExp(50 + (champion:getLevel() * 150))
				hudPrint(champion:getName() .. " gained +1 Strength and " .. 50 + (champion:getLevel() * 100) .. " Exp after the assassination.")		
			elseif stat == 2 then
				champion:addStatModifier("dexterity", 1)
				champion:gainExp(50 + (champion:getLevel() * 150))
				hudPrint(champion:getName() .. " gained +1 Dexterity and " .. 50 + (champion:getLevel() * 100) .. " Exp after the assassination.")
			elseif stat == 3 then
				champion:addStatModifier("vitality", 1)
				champion:gainExp(50 + (champion:getLevel() * 150))
				hudPrint(champion:getName() .. " gained +1 Vitality and " .. 50 + (champion:getLevel() * 100) .. " Exp after the assassination.")
			elseif stat == 4 then
				champion:addStatModifier("willpower", 1)
				champion:gainExp(50 + (champion:getLevel() * 150))
				hudPrint(champion:getName() .. " gained +1 Willpower and " .. 50 + (champion:getLevel() * 100) .. " Exp after the assassination.")
			end
			assassinations[champion:getOrdinal()] = assassinations[champion:getOrdinal()] + 1
			monster:showDamageText("Assassination!", "FF7700")
			playSound("assassination")
		end
		
		if champion:getClass() == "monk" then
			local bonus = math.floor(champion:getLevel() / 3) * 2
			champion:setConditionValue("healing_light", 8 + bonus)
			playSound("monk_light")
			for i=1,4 do
				if champion:getOrdinal() ~= i then
					party.party:getChampionByOrdinal(i):setConditionValue("healing_light2", 8 + bonus)
				end
			end
		end
	end
	-- print(tside)
	-- if math.random() < getCrit(champion:getOrdinal()) then
		-- local canStun = false
		-- print(monster:getCurrentAction())
		-- if monster:isIdle() or monster:getCurrentAction() == "basicAttack" or monster:getCurrentAction() == "attack" or monster:getCurrentAction() == "alert" or monster:getCurrentAction() == "turn" then
			-- canStun = true
		-- end
		-- if canStun and monster:isIdle() then	
			-- if tside == 0 then
			-- if math.random() <= 0.5 then 
				-- monster.go.animation:play("getHitFrontRight") 
			-- else 
				-- monster.go.animation:play("getHitFrontLeft") 
			-- end 
			-- elseif  tside == 1 then
				-- monster.go.animation:play("getHitLeft") 
			-- elseif  tside == 3 then
				-- monster.go.animation:play("getHitRight") 
			-- elseif  tside == 2 then
				-- monster.go.animation:play("getHitBehind") 
			-- end
		-- end
		-- monster:setHealth(monster.go.monster:getHealth() - damage)
		-- monster:showDamageText(""..damage, "FFFFFF", "Crit!")
		-- functions.script.wasCrit = true
	-- end
end
wasCrit = false
-- Monster hooks
-- MonsterComponent - champion takes damage

function onMonsterDealDamage(self, champion, damage)
	local item1 = champion:getItem(ItemSlot.Weapon)
	local item2 = champion:getOtherHandItem(ItemSlot.Weapon)
	-- Shield bash and blocking
	if (item1 and item1:hasTrait("shield")) or (item2 and item2:hasTrait("shield")) then
		if champion:hasTrait("block") and math.random() <= 0.1 then
			champion:setHealth(champion:getHealth() + math.ceil(damage * 0.5))
			if champion:hasTrait("shield_bash") then
				local dx,dy = getForward(party.facing)
				local flags = DamageFlags.CameraShake
				champion:playDamageSound()
				if math.random() <= 0.5 then self.go.animation:play("getHitFrontRight") else self.go.animation:play("getHitFrontLeft") end
				self.go.monster:showDamageText("" .. math.ceil(damage * 1.5), "FFFFFF", "Shield Bash!")
				self.go.monster:setHealth(self.go.monster:getHealth() - math.ceil(damage * 1.5))
				party.party:onDrawAttackPanel(self, champion, context, x, y)
				context.drawImage2("mod_assets/textures/gui/block.dds", x+48, y-68, 0, 0, 128, 75, 128, 75)
			end
		end
	end
end

-- MonsterComponent - monster takes damage
function onDamageMonster(self, damage, damageType)
	local resistances = self:getResistance(damageType)
	if resistances == "weak" then
		functions.script.hitMonster(self, math.ceil(damage * 0.25), "FF0000")
	end
	--if functions.script.wasCrit then functions.script.wasCrit = false return false end
end

-- MonsterComponent - monster hit by projectile
function onProjectileHitMonster(self, item, damage, damageType, champion) -- self = monster, item = projectile

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

function hitMonster(self, damage, color, flair)
	if math.random() <= 0.5 then self.go.animation:play("getHitFrontRight") else self.go.animation:play("getHitFrontLeft") end
	if flair then self.go.monster:showDamageText("" .. damage, "FF0000", flair) else self.go.monster:showDamageText("" .. damage, "FF0000") end
	self.go.monster:setHealth(self.go.monster:getHealth() - damage)
end

-------------------------------------------------------------------------------------------------------
-- Tinkerer Events                                                                                   --    
-------------------------------------------------------------------------------------------------------

tinkering_level = { 0,0,0,0 }
a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12 = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
tinker_item = { a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12 }

function tinkererUpgrade(self, champion, container, slot, button)
	local item = champion:getItem(slot)
	local level = math.min(math.floor(tinkering_level[champion:getOrdinal()] / 3) + 1, 10)
	
	if item then 
		-- Clear lower level upgrades
		for i=1,18 do
			if i ~= level and item:hasTrait("upgraded"..i) then
				local name = item.go.id .. "tinker"
				
				if item:hasTrait("firearm") then
					local equipItem = item.go.firearmattack
				elseif item:hasTrait("axe") then
					local equipItem = item.go.meleeattack
				elseif item:hasTrait("necklace") or item:hasTrait("bracers") then
					local equipItem = item.go.equipmentitem
				end
				-- Clear item properties
				if equipItem and supertable[1][name] ~= nil then
					equipItem:setAttackPower(supertable[1][name])
					equipItem:setCooldown(supertable[2][name])
					equipItem:setPierce(supertable[4][name])
					item.go.equipmentitem:setAccuracy(supertable[5][name])
					item.go.equipmentitem:setCriticalChance(supertable[6][name])
					item.go.equipmentitem:setResistFire(supertable[7][name])
					item.go.equipmentitem:setResistShock(supertable[8][name])
					item.go.equipmentitem:setResistCold(supertable[9][name])
					if equipItem:getClass() == "firearm" then equipItem:setRange(supertable[3][name]) end
					for j=1,12 do
						supertable[j][name] = nil
					end
					item:removeTrait("upgraded"..i)
					item:setWeight(supertable[12][item.go.id])
				end				
			end
		end
		
		-- Upgrade Item
		if not item:hasTrait("upgraded"..level) then
			-- Use up lock-pick
			local stacksize = getMouseItem().go.item:getStackSize()
			local lock = getMouseItem()
			if stacksize > 1 then
				lock:setStackSize(stacksize - 1)
				setMouseItem(lock)
			else
				setMouseItem(nil)
			end
			-- Save base name
			if supertable[10][item.go.id] == nil then
				supertable[10][item.go.id] = item:getUiName()
				supertable[12][item.go.id] = item:getWeight()
			end
			-- Set new base info
			item:setUiName("Upgraded "..supertable[10][item.go.id].." (Level "..level..")")
			item:addTrait("upgraded"..level)
			item:addTrait("upgraded")
			playSound("tinker")
			-- Increase tinkering level data
			tinkering_level[champion:getOrdinal()] = tinkering_level[champion:getOrdinal()] + 1
			
			local equipItem = item.go.equipmentitem
			local boost = 0
			
			boost = math.floor(champion:getSkillLevel("athletics") / 5) * 0.12
			item:setWeight(supertable[12][item.go.id] + ((5 - ((level-1) * 0.5)) * (1 - (champion:getSkillLevel("athletics") * 0.12) - boost)))
			if item:hasTrait("shield") then
				
				boost = champion:getSkillLevel("block") + math.floor(champion:getSkillLevel("block") / 5)
				equipItem:setEvasion(math.floor(equipItem:getEvasion() * (1.1 + (level * 0.09))) + boost)
				if equipItem:getDexterity() ~= nil then
					equipItem:setDexterity(math.floor(equipItem:getDexterity() * (1.2 + (level * 0.06))))
				end
				if champion:getSkillLevel("elemental_magic") > 0 then
					local random_element = math.random()
					boost = math.floor(champion:getSkillLevel("elemental_magic")/5) * 3
					if random_element < 0.3 then	
						item.go.equipmentitem:setResistFire(math.ceil(champion:getSkillLevel("elemental_magic") * (2 + (level * 0.1)) + boost))
					elseif random_element >= 0.3 and random_element < 0.6 then
						item.go.equipmentitem:setResistShock(math.ceil(champion:getSkillLevel("elemental_magic") * (2 + (level * 0.1)) + boost))
					else
						item.go.equipmentitem:setResistCold(math.ceil(champion:getSkillLevel("elemental_magic") * (2 + (level * 0.1)) + boost))
					end
				end
				return
			end
			
			-- Upgrade accessories
			if item.go.name == "spirit_mirror_pendant" then -- done
				equipItem:setExpRate(math.ceil(20 * (1.05 + (level * 0.06)) + 1))
				item:setGameEffect("Item is upgraded to grant a total ".. equipItem:getExpRate() .."% more exp.")
				return
			elseif item.go.name == "frostbite_necklace" then
				equipItem:setResistCold(math.ceil(50 * (1.05 + (level * 0.05)) + 1))
				equipItem:setEvasion(math.ceil(2 * (1.05 + (level * 0.05)) + 1))
				return
			elseif item.go.name == "fire_torc" then
				equipItem:setResistFire(math.ceil(50 * (1.05 + (level * 0.05)) + 1))
				equipItem:setEvasion(math.ceil(2 * (1.05 + (level * 0.05)) + 1))
				return
			elseif item.go.name == "hardstone_bracelet" then
				equipItem:setProtection(math.ceil(3 * (1.05 + (level * 0.05)) + 1))
				equipItem:setAccuracy(math.ceil(10 * (1.05 + (level * 0.05)) + 1))
				return
			elseif item.go.name == "bracelet_tirin" then
				equipItem:setProtection(math.ceil(1 * (1.05 + (level * 0.05)) + 1))
				equipItem:setCooldownRate(math.ceil(15 * (1.02 + (level * 0.05)) + 0.5))
				return
			elseif item.go.name == "brace_fortitude" then
				equipItem:setStrength(math.ceil(1 * (1.1 + (level * 0.2)) + 0.5))
				equipItem:setHealthRegenerationRate(math.ceil(20 * (1.02 + (level * 0.05)) + 0.5))
				return
			elseif item.go.name == "serpent_bracer" then
				equipItem:setProtection(math.ceil(2 * (1.05 + (level * 0.05)) + 0.2))
				equipItem:setResistPoison(math.ceil(50 * (1.02 + (level * 0.05)) + 0.2))
				return
			elseif item.go.name == "gear_necklace" then -- done
				bonus = getBonus(champion:getSkillLevel("athletics"), 0.05)
				equipItem:setHealth(math.ceil(15 * (1.05 + (level * 0.05 * bonus)) + 0.5))
				bonus = getBonus(champion:getSkillLevel("concentration"), 0.05)
				equipItem:setEnergy(math.ceil(15 * (1.05 + (level * 0.05 * bonus)) + 0.5))
				return
			elseif item.go.name == "storm_amulet" then -- done
				bonus = getBonus(champion:getSkillLevel("elemental_magic"), 0.5)
				equipItem:setResistShock(math.ceil(50 * (1.05 + (level * 0.025)) + (1 * bonus)))
				equipItem:setWillpower(math.ceil(2 * (1.05 + (level * 0.1)) + 0.5))
				return
			elseif item.go.name == "runestone_necklace" then -- done
				equipItem:setWillpower(math.ceil(1 * (1.1 + (level * 0.2)) + 1))
				return
			elseif item.go.name == "jewel_pendant" then -- done
				equipItem:setWillpower(math.ceil(2 * (1.4 + (level * 0.3)) + 1))
				return
			elseif item.go.name == "spiritwalker_pendant" then
				equipItem:setEnergy(math.ceil(50 * (1.1 + (level * 0.04)) + 1))
				equipItem:setWillpower(math.ceil(2 * (1.4 + (level * 0.3)) + 1))
				return
			elseif item.go.name == "leafbond_bracelet" then
				equipItem:setEnergyRegenerationRate(math.ceil(20 * (1.1 + (level * 0.04)) + 1))
				return
			elseif item.go.name == "steel_armband" then -- done
				equipItem:setStrength(math.ceil(1 * (1.1 + (level * 0.2)) + 0.7))
				equipItem:setProtection(math.ceil(1 * (1.1 + (level * 0.2)) + 0.7))
				return
			elseif item.go.name == "bronze_brace" then -- done
				bonus = getBonus(champion:getSkillLevel("critical"), 0.05)
				equipItem:setCriticalChance((math.ceil(3 * 10 * (1.05 + (level * 0.04 * bonus)) + 0.4)) / 10)
				bonus = getBonus(champion:getSkillLevel("elemental_magic"), 0.2)
				equipItem:setResistShock(math.ceil(-20 + (level * 0.2 * bonus) + 1))
				item:setGameEffect("Critical Chance +" .. equipItem:getCriticalChance() .. "%")
				return
			end
			
			-- Upgrade weapons
			if item:hasTrait("firearm") then
				equipItem = item.go.firearmattack
				bonus = getBonus(champion:getSkillLevel("firearms"), 0.05)
			elseif item:hasTrait("axe") or item:hasTrait("mace") or item:hasTrait("sword") then
				equipItem = item.go.meleeattack
				if item:hasTrait("light_weapon") then bonus = getBonus(champion:getSkillLevel("light_weapons"), 0.05) end
				if item:hasTrait("heavy_weapon") then bonus = getBonus(champion:getSkillLevel("heavy_weapons"), 0.05) end				
			end
			
			local name = item.go.id .. "tinker"
			if equipItem then
				supertable[1][name] = equipItem:getAttackPower()
				supertable[2][name] = equipItem:getCooldown()
				supertable[4][name] = equipItem:getPierce()
				
				equipItem:setAttackPower(math.ceil(equipItem:getAttackPower() * (1.05 + (level * 0.05)) + (boost * 2)))
				local secondary = item.go:getComponent(item:getSecondaryAction() and item:getSecondaryAction() or "")
				if secondary then
					updateSecondary(equipItem, secondary, item:getSecondaryAction())
				end
				
				if champion:getSkillLevel("concentration") > 0 then
					bonus = getBonus(champion:getSkillLevel("concentration"), 0.05)
					equipItem:setCooldown(supertable[2][name] * (1 - ((level * 0.02) + (0.1 * bonus))))
				end
				
				item.go:createComponent("EquipmentItem")
				if champion:getSkillLevel("accuracy") > 0 then
					item.go.equipmentitem:setAccuracy(math.min(champion:getSkillLevel("accuracy"),4) + math.floor(level / 3) * 2)
				end
				if champion:getSkillLevel("critical") > 0 then
					item.go.equipmentitem:setCriticalChance(math.min(champion:getSkillLevel("critical"),4))
					item:setGameEffect("Critical Chance +" .. item.go.equipmentitem:getCriticalChance() .. "%")
				end
				if champion:getSkillLevel("elemental_magic") > 0 then
					local random_element = math.random()
					boost = math.floor(champion:getSkillLevel("elemental_magic")/5) * 2
					if random_element < 0.3 then	
						item.go.equipmentitem:setResistFire(math.ceil(champion:getSkillLevel("elemental_magic") * (1.5 + (level * 0.1)) + boost))
					elseif random_element >= 0.3 and random_element < 0.6 then
						item.go.equipmentitem:setResistShock(math.ceil(champion:getSkillLevel("elemental_magic") * (1.5 + (level * 0.1)) + boost))
					else
						item.go.equipmentitem:setResistCold(math.ceil(champion:getSkillLevel("elemental_magic") * (1.5 + (level * 0.1)) + boost))
					end
				end
				
				tinker_item[1][item.go.id] = equipItem:getAttackPower()
				tinker_item[2][item.go.id] = equipItem:getCooldown()
				tinker_item[3][item.go.id] = 0
				tinker_item[4][item.go.id] = equipItem:getPierce()
				tinker_item[5][item.go.id] = item.go.equipmentitem:getAccuracy()
				tinker_item[6][item.go.id] = item.go.equipmentitem:getCriticalChance()
				tinker_item[7][item.go.id] = item.go.equipmentitem:getResistFire()
				tinker_item[8][item.go.id] = item.go.equipmentitem:getResistShock()
				tinker_item[9][item.go.id] = item.go.equipmentitem:getResistCold()
				tinker_item[10][item.go.id] = item:getUiName()
				tinker_item[11][item.go.id] = "upgraded"..level
				tinker_item[12][item.go.id] = item:getWeight()
			end
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

function tinkererDismantleAction(id, slot)
	local container = party.party:getChampionByOrdinal(id):getItem(slot).go.containeritem
	for i=1, container:getCapacity() do
		container:removeItemFromSlot(i)
	end	
	container:insertItem(5, spawn("lock_pick").item)
	playSound("generic_spell")
end

-- Tinkerer upgrades for secondary actions
function updateSecondary(meleeAttack, secondary, name)
	local item = meleeAttack.go.item
	
	if name == "chop" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(level * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A useful technique for chopping firewood and splitting the heads of your enemies. Deals double damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setSwipe("vertical")
		secondary:setUiName("Chop")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({ "light_weapons", math.min(level+1,5) })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({ "heavy_weapons", math.min(level+1,5) })
		end
		secondary.go.item:setSecondaryAction("chop")
		
	elseif name == "stun" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(level * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A powerful blow that has a ".. 18 + level * 6 .."% chance to stun an enemy. Deals double damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setCauseCondition("stunned")
		secondary:setConditionChance(18 + level * 6)
		secondary:setSwipe("vertical")
		secondary:setUiName("Stun")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons", math.min(level+2,5)})
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons", math.min(level+2,5)})
		end
		secondary.go.item:setSecondaryAction("stun")
		
	elseif name == "cleave" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(level * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
		secondary:setGameEffect("A mighty blow that does 2.5 times damage and ignores 10 points of armor.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() + 10 or 10)
		secondary:setSwipe("vertical")
		secondary:setUiName("Cleave")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons", math.min(level+2,5)})
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons", math.min(level+2,5)})
		end
		secondary.go.item:setSecondaryAction("cleave")
	
	elseif name == "flurry" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 20 + math.floor(level * 8 / 5) * 5)
		secondary:setAccuracy(12 + (level * 2))
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
			secondary:setRequirements({"light_weapons", math.min(level+1,5), "accuracy", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons", math.min(level+1,5), "accuracy", 1 })
		end
		secondary.go.item:setSecondaryAction("flurry")
		
	elseif name == "devastate" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 30 + math.floor(level * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 2.5)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.8)
		secondary:setGameEffect("An extremely powerful attack. Deals 2.5x damage.")
		secondary:setPierce(meleeAttack:getPierce() and meleeAttack:getPierce() or 0)
		secondary:setSwipe("vertical")
		secondary:setCameraShake(true)
		secondary:setUiName("Devastate")
		if secondary.go.item:hasTrait("light_weapon") then
			secondary:setRequirements({"light_weapons", math.min(level+1,5), "critical", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons", math.min(level+1,5), "critical", 1 })
		end
		secondary.go.item:setSecondaryAction("devastate")
		
	elseif name == "banish" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 40 + math.floor(level * 8 / 5) * 5)
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
			secondary:setRequirements({"light_weapons", math.min(level+1,5), "critical", 1 })
		elseif secondary.go.item:hasTrait("heavy_weapon") then
			secondary:setRequirements({"heavy_weapons", math.min(level+1,5), "critical", 1 })
		end
		secondary.go.item:setSecondaryAction("banish")
	
	elseif name == "volley" then
		local level = math.min(math.floor(meleeAttack:getAttackPower() / 9), 5)
		secondary:setEnergyCost( 12 + math.floor(level * 8 / 5) * 5)
		secondary:setAttackPower(meleeAttack:getAttackPower() * 1)
		secondary:setBaseDamageStat(meleeAttack:getBaseDamageStat())
		secondary:setCooldown(meleeAttack:getCooldown() * 1.25)
		secondary:setGameEffect("Fires three shots in quick succession.")
		secondary:setUiName("Volley")
		secondary:setRequirements({ "ranged_weapons", math.min(level+1,5) })
		secondary.go.item:setSecondaryAction("volley")
		secondary:setAmmo("arrow")
		secondary:setRepeatCount(3)
		secondary:setRepeatDelay(0.2)
		secondary:setAttackSound("swipe_bow")
	end
	-- secondary:setAttackPower(meleeAttack:getAttackPower() * 2)
	-- secondary:setCooldown(meleeAttack:getCooldown() * 1.5)
	-- if item.go.name == "pickaxe" then
		-- secondary:setGameEffect("This attack chips away 2 armor from the enemy with each hit.")
	-- end
end