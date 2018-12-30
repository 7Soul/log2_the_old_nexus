defineCondition{
	name = "berserker_rage",
	uiName = "Berserker Rage",
	description = [[
	Gains combat stats that fade out over 20 seconds.
	- Protection +4 to +1 per level (+bonus per 5 levels).
	- Strength +2 to +1 per level.]],
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
			champion:addStatModifier("strength", math.ceil(level * 0.1 * dur))
		end
	end,
	onTick = function(self, champion)
		
	end,	
}

defineCondition{
	name = "berserker_revenge",
	uiName = "Berserker Revenge",
	description = [[
	Gains combat stats that fade out over 20 seconds.
	- Protection +8 to +2 per level (+bonus per 5 levels).
	- Strength +4 to +2 per level.]],
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
			champion:addStatModifier("strength", math.ceil(level * 0.2 * dur))
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
	- Energy Regeneration Rate +125%.	
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
	- Energy Regeneration Rate +125%.	
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
	- Energy Regeneration Rate +125%.	
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