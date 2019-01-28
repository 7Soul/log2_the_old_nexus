defineCondition{
	name = "berserker_rage",
	uiName = "Berserker Rage",
	description = [[
	Gains combat stats that fade slowly over 20 seconds.
	- Protection up to +4 per level (+8 per 5 levels).
	- Strength up to +2 (+1 per 3 levels).]],
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
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
		local level2 = math.floor(champion:getLevel() / 5)
		local dur = math.max(champion:getConditionValue("berserker_rage"), 5)
		if level > 0 then
			champion:addStatModifier("protection", math.ceil(level * 0.2 * dur) + math.ceil(level2 * 0.4 * dur))
			champion:addStatModifier("strength", math.ceil((level + math.floor(level/3)) * 0.1 * dur))
		end
	end,
	onTick = function(self, champion)
		
	end,	
}

defineCondition{
	name = "berserker_revenge",
	uiName = "Berserker Revenge",
	description = [[
	Gains combat stats that fade slowly over 20 seconds.
	- Protection up to +8 per level (+16 per 5 levels).
	- Strength up to +4 (+1 per 3 levels).]],
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
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
		local level2 = math.floor(champion:getLevel() / 5)
		local dur = math.max(champion:getConditionValue("berserker_rage"), 5)
		if level > 0 then
			champion:addStatModifier("protection", math.ceil(level * 0.4 * dur) + math.ceil(level2 * 0.8 * dur))
			champion:addStatModifier("strength", math.ceil((level + math.floor(level/3)) * 0.2 * dur))
		end
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "blooddrop_rage",
	uiName = "Blood Drop Fire Rage",
	description = [[
	- Attack cooldowns are 15% faster.
	- Lasts 18 seconds.]],
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		playSound("dark_bolt")
		self:setDuration(18)
	end,
	onStop = function(self, champion)
		hudPrint(champion:getName().."'s Blooddrop Fire Rage is over.")
		champion:removeTrait("blooddrop_rage")
	end,	
}

defineCondition{
	name = "healing_light",
	uiName = "Healing Light",
	description = [[
	- Big boost to health and energy reneration rate.]],
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		playSound("light")
	end,
	onStop = function(self, champion)		
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("health_regeneration_rate", 500)
		champion:addStatModifier("energy_regeneration_rate", 250)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "healing_light2",
	uiName = "Healing Light",
	description = [[
	- Small boost to health and energy reneration rate.]],
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
	end,
	onStop = function(self, champion)		
	end,
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("health_regeneration_rate", 200)
		champion:addStatModifier("energy_regeneration_rate", 100)
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
	end,
	onRecomputeStats = function(self, champion)
		if champion:getClass() == "stalker" then
			
		end
	end,
	onTick = function(self, champion)
		local dur = math.floor(champion:getLevel() / 4) * 3
		if champion:getClass() == "stalker" then
			champion:setConditionValue("night_stalker", 8 + dur)
		end
	end,	
}

defineCondition{
	name = "night_stalker",
	uiName = "Night Stalker",
	description = "Stalking your prey.",
	icon = 16,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		if not champion:hasTrait("night_stalker") then
			champion:addTrait("night_stalker")
		end
	end,
	onStop = function(self, champion)
		champion:removeTrait("night_stalker")
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
	end,	
}

defineCondition{
	name = "elemental_balance_fire",
	uiName = "Elemental Balance (Fire)",
	icon = 0,
	description = "Cold and Air spells +40% damage.",
	gameEffect = [[
	- Energy Regeneration Rate +50%.	
	]],
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("energy_regeneration_rate", 50)
	end,
}

defineCondition{
	name = "elemental_balance_air",
	uiName = "Elemental Balance (Air)",
	icon = 0,
	description = "Fire and Cold spells +40% damage.",
	gameEffect = [[
	- Energy Regeneration Rate +50%.	
	]],
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("energy_regeneration_rate", 50)
	end,
}

defineCondition{
	name = "elemental_balance_cold",
	uiName = "Elemental Balance (Cold)",
	icon = 0,
	description = "Fire and Air spells +40% damage.",
	gameEffect = [[
	- Energy Regeneration Rate +50%.	
	]],
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("energy_regeneration_rate", 50)
	end,
}

defineCondition{
	name = "hunter_crit",
	uiName = "Thrill of the Hunt",
	icon = 2,
	description = "Increases critical chance.",
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

-- Skills

defineCondition{
	name = "refreshed",
	uiName = "Refreshed",
	icon = 0,
	description = "Increaed health regeneration rate.",
	gameEffect = [[
	- Energy Regeneration Rate +125%.	
	]],
	onRecomputeStats = function(self, champion)
		champion:addStatModifier("energy_regeneration_rate", 100)
	end,
}

defineCondition{
	name = "carnivorous",
	uiName = "Carnivorous",
	description = "Eating meat increases your Strength by 4 and Health and Energy regeneration rate by 25% for 1 minute.",
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
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

defineCondition{
	name = "healing_potion",
	uiName = "Healing",
	description = "Healing potion in effect.",
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		if champion:hasTrait("arcane_extraction") then
			champion:regainEnergy(25)
		end
		if champion:hasTrait("refreshed") then
			champion:regainHealth(12)
		end
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		local heal = champion:hasTrait("refreshed") and 3.9 or 3.125
		champion:regainHealth(heal)
		local cond = { "head_wound", "chest_wound", "leg_wound", "feet_wound", "right_hand_wound", "left_hand_wound" }
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
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		if champion:hasTrait("arcane_extraction") then
			champion:regainEnergy(25)
		end
		if champion:hasTrait("refreshed") then
			champion:regainHealth(37)
		end
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		local heal = champion:hasTrait("refreshed") and 23.4375 or 18.75
		champion:regainHealth(heal)
		local cond = { "head_wound", "chest_wound", "leg_wound", "feet_wound", "right_hand_wound", "left_hand_wound" }
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
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		if champion:hasTrait("arcane_extraction") then
			champion:regainHealth(25)
		end
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		champion:regainEnergy(champion:hasTrait("arcane_extraction") and 4.6875 or 3.75)
	end,	
}

defineCondition{
	name = "energy_potion2",
	uiName = "Energy Recovery",
	description = "Energy potion in effect.",
	icon = 1,
	--iconAtlas = "mod_assets/textures/conditions.tga",
	beneficial = true,
	harmful = false,
	tickInterval = 1,
	onStart = function(self, champion)
		if champion:hasTrait("arcane_extraction") then
			champion:regainHealth(25)
		end
	end,
	onStop = function(self, champion)
	end,
	onRecomputeStats = function(self, champion)
	end,
	onTick = function(self, champion)
		champion:regainEnergy(champion:hasTrait("arcane_extraction") and 18.75 or 15)
	end,	
}