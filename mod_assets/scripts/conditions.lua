defineCondition{
	name = "berserker_rage",
	uiName = "Berserker Frenzy",
	description = [[
	Gains combat stats that fade slowly over 20 seconds.
	- Protection up to +4 per level (+6 per 3 levels).
	- Strength up to +2 (+1 per 3 levels).]],
	icon = 21,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		--playSound("dark_bolt")
	end,
	onStop = function(self, champion)
		--hudPrint(champion:getName().."'s Berserk Rage is over.")
	end,
	onRecomputeStats = function(self, champion)
		local level = champion:getLevel()
		local level2 = math.floor((champion:getLevel()-1)/ 3)
		local dur = math.max(champion:getConditionValue("berserker_rage"), 5 + math.floor(level / 5)) -- every 5 levels it clamps to a higher time
		dur = math.min(dur * dur / 324, 1) -- 324 to give 2 seconds where the stats stay at max
		if level > 0 then
			champion:addStatModifier("protection", math.ceil(((level * 4) + (level2 * 6)) * dur))
			champion:addStatModifier("strength", math.ceil((2 + level2) * 1 * dur))
		end
	end,
	onTick = function(self, champion)
		
	end,	
}

defineCondition{
	name = "berserker_revenge",
	uiName = "Berserker Reprisal",
	description = [[
	Gains combat stats that fade slowly over 60 seconds.
	- Protection up to +6 per level (+8 per 3 levels).
	- Strength up to +4 (+1 per 3 levels).
	- Health Regeneration +500%.]],
	icon = 22,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		--playSound("dark_bolt")
	end,
	onStop = function(self, champion)
		--hudPrint(champion:getName().."'s Berserk Rage is over.")
	end,
	onRecomputeStats = function(self, champion)
		local level = champion:getLevel()
		local level2 = math.floor(champion:getLevel() / 3)
		local dur = math.max(champion:getConditionValue("berserker_revenge"), 12 + math.floor(level / 5)) -- every 5 levels it clamps to a higher time
		dur = math.min(dur * dur / 3136, 1) -- 3136 to give 4 seconds where the stats stay at max
		if level > 0 then
			champion:addStatModifier("protection",  math.ceil(((level * 6) + (level2 * 8)) * dur))
			champion:addStatModifier("strength", math.ceil((4 + level2) * 1 * dur))
			champion:addStatModifier("health_regeneration_rate", math.ceil(500 * dur))
		end
	end,
	onTick = function(self, champion)
		local missing = 1 - (champion:getHealth() / champion:getMaxHealth())
		if missing > 0.5 then
			champion:regainHealth(missing * missing * 5.0)
		elseif missing <= 0.5 and missing > 0.25 then
			if math.random() < 0.5 then
				champion:regainHealth(missing * missing * 5.0)
			end
		end
	end,	
}

defineCondition{
	name = "blooddrop_rage",
	uiName = "Blooddrop Fire Rage",
	description = "",
	icon = 1,
	hidden = true,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		--playSound("dark_bolt")
	end,
	onStop = function(self, champion)
		hudPrint(champion:getName().."'s Blooddrop Fire Rage is over.")
		champion:removeTrait("blooddrop_rage")
	end,	
}

defineCondition{
	name = "etherweed_rage",
	uiName = "Etherweed Cold Rage",
	description = "",
	icon = 1,
	hidden = true,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		--playSound("dark_bolt")
	end,
	onStop = function(self, champion)
		hudPrint(champion:getName().."'s Etherweed Cold Rage is over.")
		champion:removeTrait("etherweed_rage")
	end,	
}

defineCondition{
	name = "healing_light",
	uiName = "Healing Light",
	description = [[
	- Big boost to health and energy reneration rate.]],
	icon = 25,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		playSound("light")
	end,
	onStop = function(self, champion)
		if champion:getClass() == "monk" then
			champion:setConditionValue("holy_light", 60 + (math.floor(champion:getLevel() / 4) * 30))
		end
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("health_regeneration_rate", 500)
		champion:addStatModifier("energy_regeneration_rate", 300)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "holy_light",
	uiName = "Holy Light",
	description = [[
	- Random bonus to all stats.]],
	icon = 26,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		playSound("light")
		local bonusS, bonusD, bonusW, bonusV = 0, 0, 0, 0
		local maxBonus = 3 + (math.floor(champion:getLevel() / 3))
		while (bonusS + bonusD + bonusW + bonusV < maxBonus*1.75) or (bonusS + bonusD + bonusW + bonusV > maxBonus*3) do
			bonusS = math.random(0, maxBonus)
			bonusD = math.random(0, maxBonus)
			bonusW = math.random(0, maxBonus)
			bonusV = math.random(0, maxBonus)
		end
		functions.script.set_c("holyLightRandW", champion:getOrdinal(), bonusW)
		functions.script.set_c("holyLightRandS", champion:getOrdinal(), bonusS)
		functions.script.set_c("holyLightRandD", champion:getOrdinal(), bonusD)
		functions.script.set_c("holyLightRandV", champion:getOrdinal(), bonusV)
	end,
	onStop = function(self, champion)
		functions.script.set_c("holyLightRandW", champion:getOrdinal(), nil)
		functions.script.set_c("holyLightRandS", champion:getOrdinal(), nil)
		functions.script.set_c("holyLightRandD", champion:getOrdinal(), nil)
		functions.script.set_c("holyLightRandV", champion:getOrdinal(), nil)
	end,
	onRecomputeStats = function(self, champion)
		if functions.script.get_c("holyLightRandS", champion:getOrdinal()) then
			local bonusS = functions.script.get_c("holyLightRandS", champion:getOrdinal())
			local bonusD = functions.script.get_c("holyLightRandD", champion:getOrdinal())
			local bonusW = functions.script.get_c("holyLightRandW", champion:getOrdinal())
			local bonusV = functions.script.get_c("holyLightRandV", champion:getOrdinal())
			champion:addStatModifier("strength", bonusS)
			champion:addStatModifier("dexterity", bonusD)
			champion:addStatModifier("willpower", bonusW)
			champion:addStatModifier("vitality", bonusV)
		end
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "healing_light2",
	uiName = "Healing Light",
	description = [[
	- Small boost to health and energy reneration rate.]],
	icon = 25,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)		
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("health_regeneration_rate", 250)
		champion:addStatModifier("energy_regeneration_rate", 150)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "invisibility",
	uiName = "Invisibility",
	description = "Enemies can't see you",
	icon = 16,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		
	end,
	onStop = function(self, champion)
		if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "spidersilk_cloak" then
			champion:setConditionValue(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and "spidersilk1" or "spidersilk2" , 30)
		end
	end,
	onRecomputeStats = function(self, champion)
		if champion:getClass() == "stalker" then
			
		end
	end,
	onTick = function(self, champion)
		local dur = math.floor(champion:getLevel() / 4) * 3
		if champion:getClass() == "stalker" then
			champion:setConditionValue("night_stalker", 6 + dur)
		end
	end,	
}

defineCondition{
	name = "night_stalker",
	uiName = "Night Stalker",
	description = "Stalking your prey.",
	icon = 27,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		if champion:hasTrait("night_stalker") then
			champion:removeTrait("night_stalker")
			champion:addTrait("night_stalker2")
		end
	end,
	onStop = function(self, champion)
		champion:removeTrait("night_stalker2")
		champion:addTrait("night_stalker")
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "elemental_balance_fire",
	uiName = "Elemental Balance (Fire)",
	icon = 29,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	description = "Cold and Air spells +40% damage.",
	gameEffect = [[
	- Energy Regeneration Rate +50%.]],
	onRecomputeStats = function(self, champion)
		--champion:addStatModifier("energy_regeneration_rate", 50)
	end,
}

defineCondition{
	name = "elemental_balance_air",
	uiName = "Elemental Balance (Air)",
	icon = 30,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	description = "Fire and Cold spells +40% damage.",
	gameEffect = [[
	- Energy Regeneration Rate +50%.]],
	onRecomputeStats = function(self, champion)
		--champion:addStatModifier("energy_regeneration_rate", 50)
	end,
}

defineCondition{
	name = "elemental_balance_cold",
	uiName = "Elemental Balance (Cold)",
	icon = 31,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	description = "Fire and Air spells +40% damage.",
	gameEffect = [[
	- Energy Regeneration Rate +50%.]],
	onRecomputeStats = function(self, champion)
		--champion:addStatModifier("energy_regeneration_rate", 50)
	end,
}

defineCondition{
	name = "hunter_crit",
	uiName = "Thrill of the Hunt",
	icon = 0,
	description = "Increases critical chance.",
	hidden = true,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
		local stacks = functions.script.hunter_crit[champion:getOrdinal()]
		if stacks > 0 then
			local id = champion:getOrdinal()
			delayedCall("functions", 0.1, "hunterCrit", id, -1, 3)
		end
	end,
}

defineCondition{
	name = "carnivorous",
	uiName = "Carnivorous",
	description = "Eating meat increases your Strength by 4 and Health and Energy regeneration rate by 25% for 1 minute.",
	icon = 28,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("strength", 4)
		champion:addStatModifier("health_regeneration_rate", 25)
		champion:addStatModifier("energy_regeneration_rate", 25)
	end,
	onTick = function(self, champion)
	end,	
}

-- Skills

defineCondition{
	name = "refreshed",
	uiName = "Refreshed",
	icon = 0,
	description = "Increased health regeneration rate.",
	gameEffect = [[
	- Energy Regeneration Rate +125%.]],
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("energy_regeneration_rate", 100)
	end,
}

defineCondition{
	name = "healing_potion",
	uiName = "Healing",
	description = "Healing potion in effect.",
	icon = 33,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		if champion:hasTrait("refreshed") then
			champion:regainHealth(12)
		end
		-- Party Arcane Extraction
		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("arcane_extraction") then
				if c ~= champion then
					champion:regainEnergy(8)
				else
					champion:regainEnergy(25)
				end
				break
			end
		end
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		local heal = champion:hasTrait("refreshed") and 3.9 or 3.125
		champion:regainHealth(heal)
		local cond = { "head_wound", "chest_wound", "leg_wound", "feet_wound", "right_hand_wound", "left_hand_wound", "bleeding" }
		local recoverChance = champion:hasTrait("refreshed") and 0.2 or 0.1
		local recoverStart = champion:hasTrait("refreshed") and 12 or 8
		for i=1,#cond do
			if self:getDuration() <= recoverStart and champion:hasCondition(cond[i]) then
				if math.random() < recoverChance then
					champion:removeCondition(cond[i])
				end
			end
			if self:getDuration() <= 1 and champion:hasCondition(cond[i]) then
				champion:removeCondition(cond[i])
			end
		end
	end,	
}

defineCondition{
	name = "healing_potion2",
	uiName = "Healing",
	description = "Healing potion in effect.",
	icon = 35,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		if champion:hasTrait("refreshed") then
			champion:regainHealth(37)
		end
		-- Party Arcane Extraction
		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("arcane_extraction") then
				if c ~= champion then
					champion:regainEnergy(8)
				else
					champion:regainEnergy(25)
				end
				break
			end
		end
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		local heal = champion:hasTrait("refreshed") and 23.4375 or 18.75
		champion:regainHealth(heal)
		local cond = { "head_wound", "chest_wound", "leg_wound", "feet_wound", "right_hand_wound", "left_hand_wound", "bleeding" }
		local recoverChance = champion:hasTrait("refreshed") and 0.2 or 0.1
		local recoverStart = champion:hasTrait("refreshed") and 12 or 8
		for i=1,#cond do
			if self:getDuration() <= recoverStart and champion:hasCondition(cond[i]) then
				if math.random() < recoverChance then
					champion:removeCondition(cond[i])
				end
			end
			if self:getDuration() <= 1 and champion:hasCondition(cond[i]) then
				champion:removeCondition(cond[i])
			end
		end
	end,	
}

defineCondition{
	name = "energy_potion",
	uiName = "Energy Recovery",
	description = "Energy potion in effect.",
	icon = 34,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		-- Party Arcane Extraction
		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("arcane_extraction") then
				if c ~= champion then
					champion:regainHealth(8)
				else
					champion:regainHealth(25)
				end
				break
			end
		end
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		-- Party Arcane Extraction
		local regen = 3.75
		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("arcane_extraction") then
				if c ~= champion then
					regen = regen + (regen * 0.25 * 0.33)
				else
					regen = regen + (regen * 0.25)
				end
				break
			end
		end
		champion:regainEnergy(regen)
	end,	
}

defineCondition{
	name = "energy_potion2",
	uiName = "Energy Recovery",
	description = "Energy potion in effect.",
	icon = 36,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		-- Party Arcane Extraction
		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("arcane_extraction") then
				if c ~= champion then
					champion:regainHealth(8)
				else
					champion:regainHealth(25)
				end
				break
			end
		end
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		-- Party Arcane Extraction
		local regen = 15
		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("arcane_extraction") then
				if c ~= champion then
					regen = regen + (regen * 0.25 * 0.33)
				else
					regen = regen + (regen * 0.25)
				end
				break
			end
		end
		champion:regainEnergy(regen)
	end,	
}

defineCondition{
	name = "recharging",
	uiName = "Recharging",
	description = "Champion is recharging.",
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	hidden = true,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "drown_sorrows",
	uiName = "Drown Your Sorrows",
	description = "Numb the pain.",
	icon = 37,
	iconAtlas = "mod_assets/textures/gui/conditions.dds", 
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("protection", 5)
	end,
	onTick = function(self, champion)
		local cond = { "head_wound", "chest_wound", "leg_wound", "feet_wound", "right_hand_wound", "left_hand_wound" }
		local recoverChance = 0.1
		for i=1,#cond do
			if champion:hasCondition(cond[i]) then
				if math.random() < recoverChance then
					champion:removeCondition(cond[i])
				end
			end
			if self:getDuration() <= 1 and champion:hasCondition(cond[i]) then
				champion:removeCondition(cond[i])
			end
		end
	end,	
}

defineCondition{
	name = "drown_sorrows_exp",
	uiName = "Reduced Experience Gain",
	description = "Gaining less experience after drinking a little too much.",
	icon = 1,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	hidden = true,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("exp_rate", -15)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "bleeding",
	uiName = "Bleeding",
	description = "Take damage over time, doubled when moving and tripled when attacking.",
	icon = 23,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = false,
	harmful = true,
	tickInterval = 3,
	onStart = function(self, champion)
		champion:setConditionValue("bleeding", 60)
		
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		functions.script.championBleed(champion, "dot")	
	end,	
}

defineCondition{
	name = "chewing",
	uiName = "Chewing",
	description = "You are chewing on a herb.",
	icon = 3,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		champion:addTrait("rodent_chewing")
	end,
	onStop = function(self, champion)
		for slot=13,32 do
			if champion:getItem(slot) == nil then
				champion:insertItem(slot, spawn("fiber_ball_good").item)
				local item = champion:getItem(slot)
				if item.go.data:get("parent") == nil then item.go.data:set("parent", champion:getOrdinal()) end
				break
			end
			if slot == 32 and champion:getItem(slot) ~= nil then
				
			end
		end
		champion:removeTrait("rodent_chewing")
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "sneak_attack",
	uiName = "",
	description = "",
	icon = 1,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("evasion", 100)
	end,
	onTick = function(self, champion)
		champion:setConditionValue("sneak_attack", 100)
	end,	
}

defineCondition{
	name = "ancestral_charge",
	uiName = "Ancestral Boon",
	description = "Heavy Armor and Block skills' base bonuses and perks increased by 50%",
	icon = 1,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "reflective",
	uiName = "Reflective",
	description = "The first attack from an enemy is absorbed as Health and Energy over 5 seconds.",
	icon = 33,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	hidden = true,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		local heal = functions.script.get_c("reflective_damage", champion:getOrdinal())
		champion:regainHealth(heal / 5)
		champion:regainEnergy(heal / 5)
	end,	
}

-- Items

defineCondition{
	name = "hardstone",
	uiName = "Hardstone Bracelet",
	description = "",
	icon = 1,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	hidden = true,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("strength", 3)
		champion:addStatModifier("protection", 30)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "spidersilk",
	uiName = "Spidersilk Cloak",
	description = "",
	icon = 1,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	hidden = true,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("resist_cold", 40)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "spidersilk2",
	uiName = "Spidersilk Cloak",
	description = "",
	icon = 1,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	hidden = true,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("resist_cold", 60)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "bear_bonus",
	uiName = "Spidersilk Cloak",
	description = "",
	icon = 1,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	hidden = true,
	tickInterval = 2,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		champion:regainEnergy(0.5)
	end,	
}