-- defineCondition{
-- 	name = "berserker_rage",
-- 	uiName = "Berserker Frenzy",
-- 	description = [[
-- 	Gains combat stats that fade slowly over 20 seconds.
-- 	- Protection up to +4 per level (+6 per 3 levels).
-- 	- Strength up to +2 (+1 per 3 levels).
-- 	- Heals up to 3% health per second based on current health.]],
-- 	icon = 21,
-- 	iconAtlas = "mod_assets/textures/gui/conditions.dds",
-- 	beneficial = true,
-- 	harmful = false,
-- 	tickInterval = 1,
-- 	onStart = function(self, champion)
-- 	end,
-- 	onStop = function(self, champion)
-- 	end,
-- 	onRecomputeStats = function(self, champion)
-- 		local level = champion:getLevel()
-- 		local level2 = math.floor((champion:getLevel()-1)/ 3)
-- 		local dur = math.max(champion:getConditionValue("berserker_rage"), 5 + math.floor(level / 5)) -- every 5 levels it clamps to a higher time
-- 		dur = math.min(dur * dur / 324, 1) -- 324 to give 2 seconds where the stats stay at max
-- 		if level > 0 then
-- 			champion:addStatModifier("protection", math.ceil(((level * 4) + (level2 * 6)) * dur))
-- 			champion:addStatModifier("strength", math.ceil((2 + level2) * 1 * dur))
-- 		end
-- 	end,
-- 	onTick = function(self, champion)
-- 		local missing = 1 - (champion:getHealth() / champion:getMaxHealth())
-- 		if missing > 0.25 then -- heal under 25% health
-- 			functions.script.regainHealth(champion:getOrdinal(), missing * missing * 5.0 * 0.5)
-- 		elseif missing <= 0.25 and missing > 0.10 then -- extra under 10%
-- 			if math.random() < 0.5 then
-- 				functions.script.regainHealth(champion:getOrdinal(), missing * missing * 5.0 * 0.5)
-- 			end
-- 		end
-- 	end,	
-- }

-- defineCondition{
-- 	name = "berserker_revenge",
-- 	uiName = "Berserker Reprisal",
-- 	description = [[
-- 	Gains combat stats that fade slowly over 60 seconds.
-- 	- Protection up to +6 per level (+8 per 3 levels).
-- 	- Strength up to +4 (+1 per 3 levels).
-- 	- Heals up to 6% health per second based on current health.]],
-- 	icon = 22,
-- 	iconAtlas = "mod_assets/textures/gui/conditions.dds",
-- 	beneficial = true,
-- 	harmful = false,
-- 	tickInterval = 1,
-- 	onStart = function(self, champion)
-- 	end,
-- 	onStop = function(self, champion)
-- 	end,
-- 	onRecomputeStats = function(self, champion)
-- 		local level = champion:getLevel()
-- 		local level2 = math.floor(champion:getLevel() / 3)
-- 		local dur = math.max(champion:getConditionValue("berserker_revenge"), 12 + math.floor(level / 5)) -- every 5 levels it clamps to a higher time
-- 		dur = math.min(dur * dur / 3136, 1) -- 3136 to give 4 seconds where the stats stay at max
-- 		if level > 0 then
-- 			champion:addStatModifier("protection",  math.ceil(((level * 6) + (level2 * 8)) * dur))
-- 			champion:addStatModifier("strength", math.ceil((4 + level2) * 1 * dur))
-- 		end
-- 	end,
-- 	onTick = function(self, champion)
-- 		local missing = 1 - (champion:getHealth() / champion:getMaxHealth())
-- 		if missing > 0.5 then -- heal under 50% health
-- 			functions.script.regainHealth(champion:getOrdinal(), missing * missing * 5.0)
-- 		elseif missing <= 0.5 and missing > 0.25 then
-- 			if math.random() < 0.5 then
-- 				functions.script.regainHealth(champion:getOrdinal(), missing * missing * 5.0)
-- 			end
-- 		end
-- 	end,	
-- }

defineCondition{
	name = "berserker_frenzy",
	uiName = "Berserker Frenzy",
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	icon = 32,
	description = ".",
	hidden = true,
	tickInterval = 1,
	onStop = function(self, champion)
		local stacks = functions.script.get_c("berserker_frenzy", champion:getOrdinal())
		if stacks and stacks > 0 then
			local c = champion:getOrdinal()
			functions.script.add_c("berserker_frenzy_countdown", champion:getOrdinal(), 1)
			local countdown = functions.script.get_c("berserker_frenzy_countdown", champion:getOrdinal()) or 0
			delayedCall("functions", 0.1, "berserkerFrenzy", c, -1 * (math.floor(countdown/5)+1), 1)
		end
	end,
}

defineCondition{
	name = "healing_light",
	uiName = "Healing Aura",
	description = "1% Health, Energy and Focus recovered per second.",
	icon = 25,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 0.5,
	onStart = function(self, champion)
		playSound("light")
	end,
	onStop = function(self, champion)
		-- if champion:getClass() == "monk" then
		-- 	champion:setConditionValue("holy_light", 60 + (math.floor(champion:getLevel() / 4) * 30))
		-- end
	end,
	onRecomputeStats = function(self, champion)		
	end,
	onTick = function(self, champion)
		local c = champion:getOrdinal()
		functions.script.regainHealth(champion:getOrdinal(), champion:getMaxHealth() / 100)
		functions.script.regainEnergy(champion:getOrdinal(), champion:getMaxEnergy() / 100)
		local focus = functions.script.get_c("focus", c) or 0
		local focusMax = champion:getMaxEnergy()
		functions.script.set_c("focus", c, math.min( focus + (focusMax / 100), focusMax) )
	end,	
}

-- defineCondition{
-- 	name = "holy_light",
-- 	uiName = "Holy Light",
-- 	description = "Random bonus to all stats.",
-- 	icon = 26,
-- 	iconAtlas = "mod_assets/textures/gui/conditions.dds",
-- 	beneficial = true,
-- 	harmful = false,
-- 	tickInterval = 1,
-- 	onStart = function(self, champion)
-- 		playSound("light")
-- 		local bonusS, bonusD, bonusW, bonusV = 0, 0, 0, 0
-- 		local maxBonus = 3 + (math.floor(champion:getLevel() / 3))
-- 		while (bonusS + bonusD + bonusW + bonusV < maxBonus*1.75) or (bonusS + bonusD + bonusW + bonusV > maxBonus*3) do
-- 			bonusS = math.random(0, maxBonus)
-- 			bonusD = math.random(0, maxBonus)
-- 			bonusW = math.random(0, maxBonus)
-- 			bonusV = math.random(0, maxBonus)
-- 		end
-- 		functions.script.set_c("holyLightRandW", champion:getOrdinal(), bonusW)
-- 		functions.script.set_c("holyLightRandS", champion:getOrdinal(), bonusS)
-- 		functions.script.set_c("holyLightRandD", champion:getOrdinal(), bonusD)
-- 		functions.script.set_c("holyLightRandV", champion:getOrdinal(), bonusV)
-- 	end,
-- 	onStop = function(self, champion)
-- 		functions.script.set_c("holyLightRandW", champion:getOrdinal(), nil)
-- 		functions.script.set_c("holyLightRandS", champion:getOrdinal(), nil)
-- 		functions.script.set_c("holyLightRandD", champion:getOrdinal(), nil)
-- 		functions.script.set_c("holyLightRandV", champion:getOrdinal(), nil)
-- 	end,
	-- onRecomputeStats = function(self, champion)
	-- 	local bonusS = functions.script.get_c("holyLightRandS", champion:getOrdinal()) or 0
	-- 	local bonusD = functions.script.get_c("holyLightRandD", champion:getOrdinal()) or 0
	-- 	local bonusW = functions.script.get_c("holyLightRandW", champion:getOrdinal()) or 0
	-- 	local bonusV = functions.script.get_c("holyLightRandV", champion:getOrdinal()) or 0
	-- 	if bonusS then
	-- 		champion:addStatModifier("strength", bonusS)
	-- 		champion:addStatModifier("dexterity", bonusD)
	-- 		champion:addStatModifier("willpower", bonusW)
	-- 		champion:addStatModifier("vitality", bonusV)
	-- 	end
	-- end,
-- }

defineCondition{
	name = "healing_light2",
	uiName = "Healing Aura",
	description = "1% Health and Energy recovered per second.",
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
	end,
	onTick = function(self, champion)
		functions.script.regainHealth(champion:getOrdinal(), champion:getMaxHealth() / 100)
		functions.script.regainEnergy(champion:getOrdinal(), champion:getMaxEnergy() / 100)
		
	end,	
}

defineCondition{
	name = "focus_cast",
	uiName = "Focused Casting",
	description = "You spent Focus to cast.",
	icon = 25,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStop = function(self, champion)
		champion:removeTrait("focus_cast")	
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
	description = "Cold and Shock spells +25% damage.",
	onRecomputeStats = function(self, champion)
	end,
}

defineCondition{
	name = "elemental_balance_shock",
	uiName = "Elemental Balance (Shock)",
	icon = 30,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	description = "Fire and Cold spells +25% damage.",
	onRecomputeStats = function(self, champion)
	end,
}

defineCondition{
	name = "elemental_balance_cold",
	uiName = "Elemental Balance (Cold)",
	icon = 31,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	description = "Fire and Shock spells +25% damage.",
	onRecomputeStats = function(self, champion)
	end,
}

defineCondition{
	name = "hunter_crit",
	uiName = "Thrill of the Hunt",
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	icon = 32,
	description = "Increases critical chance.",
	hidden = true,
	tickInterval = 1,
	onStop = function(self, champion)
		local stacks = functions.script.get_c("hunter_crit", champion:getOrdinal())
		if stacks and stacks > 0 then
			local c = champion:getOrdinal()
			delayedCall("functions", 0.1, "hunterCrit", c, -1, 3)
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
	name = "conditioning",
	uiName = "Heavy Conditioning",
	icon = 0,
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	description = "Increases Strength, Protection and Health Regeneration when taking damage.",
	onRecomputeStats = function(self, champion)
		local multi = champion:hasCondition("ancestral_charge") and 1.5 or 1
		local bonus = math.floor((champion:getCurrentStat("vitality")-10) / 5) * 5
		local bonus2 = math.floor((champion:getCurrentStat("vitality")-10) / 5)
		local bonus3 = math.floor((champion:getCurrentStat("vitality")-10) / 10)
		champion:addStatModifier("health_regeneration_rate", math.ceil(bonus * multi))
		champion:addStatModifier("protection", math.ceil(bonus2 * multi))
		champion:addStatModifier("strength", math.ceil(bonus3 * multi))
	end,
}

defineCondition{
	name = "perfect_mix",
	uiName = "Perfect Mix",
	icon = 0,
	description = "Gain +20 protection while a healing or energy potion is in effect.",
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("protection", 20)
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
		-- Party Arcane Extraction
		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("arcane_extraction") then
				if c ~= champion then
					functions.script.regainEnergy(champion:getOrdinal(), 8)
				else
					functions.script.regainEnergy(champion:getOrdinal(), 25)
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
		local heal = 3.125
		functions.script.regainHealth(heal)
		local cond = { "head_wound", "chest_wound", "leg_wound", "feet_wound", "right_hand_wound", "left_hand_wound", "bleeding" }
		local recoverChance = champion:hasTrait("perfect_mix") and 0.2 or 0.1
		local recoverStart = champion:hasTrait("perfect_mix") and 12 or 8
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
		-- Party Arcane Extraction
		for i=1,4 do
			local c = party.party:getChampionByOrdinal(i)
			if c:hasTrait("arcane_extraction") then
				if c ~= champion then
					functions.script.regainEnergy(champion:getOrdinal(), 8)
				else
					functions.script.regainEnergy(champion:getOrdinal(), 25)
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
		local heal = 18.75
		functions.script.regainHealth(heal)
		local cond = { "head_wound", "chest_wound", "leg_wound", "feet_wound", "right_hand_wound", "left_hand_wound", "bleeding" }
		local recoverChance = champion:hasTrait("perfect_mix") and 0.2 or 0.1
		local recoverStart = champion:hasTrait("perfect_mix") and 12 or 8
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
					functions.script.regainHealth(champion:getOrdinal(), 8)
				else
					functions.script.regainHealth(champion:getOrdinal(), 25)
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
		functions.script.regainEnergy(champion:getOrdinal(), regen)
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
					functions.script.regainHealth(champion:getOrdinal(), 8)
				else
					functions.script.regainHealth(champion:getOrdinal(), 25)
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
		functions.script.regainEnergy(champion:getOrdinal(), regen)
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
		functions.script.set_c("drown_your_sorrows", champion:getOrdinal(), true)
	end,
	onStop = function(self, champion)
		functions.script.set_c("drown_your_sorrows", champion:getOrdinal(), nil)
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
		champion:addStatModifier("exp_rate", -15)
	end,
	onTick = function(self, champion)
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
	uiName = "Sneak Attack",
	description = "Gain 100 Evasion and 15% Critical Chance. Your first physical attack has a 50% chance to poison the target.",
	icon = 38,
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
	icon = 39,
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
		functions.script.regainHealth(champion:getOrdinal(), heal / 5)
		functions.script.regainEnergy(champion:getOrdinal(), heal / 5)
	end,	
}

-- Items

-- defineCondition{
-- 	name = "hardstone",
-- 	uiName = "Hardstone Bracelet",
-- 	description = "",
-- 	icon = 1,
-- 	iconAtlas = "mod_assets/textures/gui/conditions.dds",
-- 	beneficial = true,
-- 	harmful = false,
-- 	hidden = true,
-- 	tickInterval = 1,
-- 	onStart = function(self, champion)
-- 	end,
-- 	onStop = function(self, champion)
-- 	end,
-- 	onRecomputeStats = function(self, champion)
-- 		champion:addStatModifier("strength", 3)
-- 		champion:addStatModifier("protection", 30)
-- 	end,
-- 	onTick = function(self, champion)
-- 	end,	
-- }

defineCondition{
	name = "spidersilk1",
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
	uiName = "",
	description = "",
	icon = 0,
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
		functions.script.regainEnergy(champion:getOrdinal(), 0.5)
		if not champion:hasCondition("bear_form") then champion:removeCondition("bear_bonus") end
	end,	
}

defineCondition{
	name = "crystal_health",
	uiName = "Crystal Set Healing",
	description = "",
	icon = 0,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	hidden = true,
	tickInterval = 0.5,
	onStart = function(self, champion)
		champion:removeTrait("crystal_health")
		functions.script.regainHealth(champion:getOrdinal(), champion:getMaxHealth() / 5)
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		functions.script.regainHealth(champion:getOrdinal(), champion:getMaxHealth() / 10)
	end,	
}


defineCondition{
	name = "shield_bearer",
	uiName = "Shield Bearer",
	description = "+15% Action Speed and 50% Faster Buildup Time for special attacks",
	icon = 24,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		functions.script.changeSecondary(champion, 0.5, "buildup")
	end,
	onStop = function(self, champion)
		functions.script.changeSecondary(champion, 1, "buildup")
	end,
	onRecomputeStats = function(self, champion)
		functions.script.changeSecondary(champion, 0.5, "buildup")
	end,
	onTick = function(self, champion)
		functions.script.changeSecondary(champion, 0.5, "buildup")
	end,	
}

defineCondition{
	name = "valor_set",
	uiName = "Valor",
	description = "The Valor Set user is sharing 10% of its Protection.",
	icon = 40,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		local bonus = 0
		for i=1,4 do
			local champ = party.party:getChampionByOrdinal(i)
			if functions.script.isArmorSetEquipped(champ, "valor") then
				bonus = math.floor(champ:getCurrentStat("protection") * 0.1)
			end
		end
		functions.script.set("valor_bonus", bonus)
	end,
	onStop = function(self, champion)
		functions.script.set("valor_bonus", nil)
	end,
	onRecomputeStats = function(self, champion)
		local bonus = functions.script.get("valor_bonus") or 0
		if functions.script.isArmorSetEquipped(champion, "valor") then
			bonus = bonus * -1
		end
		champion:addStatModifier("protection", bonus)
	end,	
}

defineCondition{
	name = "poison",
	uiName = "Poisoned",
	description = "You take poison damage every few seconds. Over time it becomes more severe.",
	icon = 2,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = false,
	harmful = true,
	tickInterval = 1,
	onStart = function(self, champion)
		local c = champion:getOrdinal()
		local resist = functions.script.getMiscResistance(champion, "poisoned") -- 0 to 1
		if math.random() >= resist then	
			local dur = math.floor(math.random(45 + ((champion:getLevel()-1) * 4), 85 + ((champion:getLevel()-1) * 5) ) * math.max(1 - resist, 0.33))
			self:setDuration(dur)
			functions.script.set_c("poisonDurMax", c, dur)
		end
	end,

	onStop = function(self, champion)
		local c = champion:getOrdinal()
		functions.script.set_c("poisonTick", c, nil)
	end,
	
	onTick = function(self, champion)		
		local c = champion:getOrdinal()
		local poisonDurMax = functions.script.get_c("poisonDurMax", c) or 0
		functions.script.add_c("poisonTick", c, 1)
		local tick = functions.script.get_c("poisonTick", c) or 0

		local multi_upper = math.min(math.floor((1 - (self:getDuration() / poisonDurMax)) * 5), champion:getLevel() + 1) -- every 20 seconds raises max damage, upper limit is champion level + 1
		local multi_lower = math.min(math.floor((1 - (self:getDuration() / poisonDurMax)) * 2.5), champion:getLevel())	 -- every 40 seconds raises min damage, upper limit is champion level

		print("multis", multi_lower, multi_upper)
		if (tick >= 5 and math.random() < 0.12 + ((tick-5) * 0.12) ) then -- damages every 5 to 13 ticks
			local damage = math.random( 1 + multi_lower , 5 + multi_upper ) + (champion:getLevel()-1)
			if champion:getHealth() - damage * (1-(champion:getResistance("poison")*0.01)) > 0 then
				champion:damage(damage, "poison")
			end
			functions.script.set_c("poisonTick", c, 0)
		end
	end,	
}

defineCondition{
	name = "diseased",
	uiName = "Diseased",
	description = "Can't get healed from any source. Hunger increased by 25%.",
	icon = 2,
	iconAtlas = "mod_assets/textures/gui/conditions.dds",
	beneficial = false,
	harmful = true,
	tickInterval = 1,
	onStart = function(self, champion)
		local resist = functions.script.getMiscResistance(champion, "diseased") -- 0 to 1
		if math.random() >= resist then
			self:setDuration(math.random(200,400) * math.max(1 - resist, 0.33) )
		end
	end,

	onRecomputeStats = function(self, champion)
		champion:addStatModifier("food_rate", 25)
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
	tickInterval = 1,
	onStart = function(self, champion)
		local resist = functions.script.getMiscResistance(champion, "bleeding") -- 0 to 1
		if math.random() >= resist then
			self:setDuration(math.random(60,90) * math.max(1 - resist, 0.33) )
		end
	end,
	
	onStop = function(self, champion)
		local c = champion:getOrdinal()
		functions.script.set_c("bleedTick", c, nil)
	end,

	onTick = function(self, champion)
		local c = champion:getOrdinal()
		functions.script.add_c("bleedTick", c, 1)
		local tick = functions.script.get_c("bleedTick", c) or 0

		if (tick >= 3 and math.random() < 0.25) or tick >= 6 then
			functions.script.championBleed(champion, "dot")	
			functions.script.set_c("bleedTick", c, 0)
		end
	end,
}