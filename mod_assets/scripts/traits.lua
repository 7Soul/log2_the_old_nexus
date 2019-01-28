defineTrait{
	name = "fighter",
	uiName = "Berserker",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 26,
	description = "A prideful warrior of the tribes of the Red Hills.",
	gameEffect = [[
	- Health 80 (+5 per level, +5 per 5 strength and +15 per 10 strength)
	- Energy 20 (+5 per level)
	- Armor is for babies.
	
	Becomes enraged if the party gets attacked, gaining Protection and Strength per level.
	- Gain 'Berserker Rage' if party gets attacked.
	- Gain 'Berserker Revenge' if a party member dies.
]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			local str_add = math.floor(champion:getCurrentStat("strength") / 5) * 5
			local str_add_more = math.floor(champion:getCurrentStat("strength") / 10) * 15
			champion:addStatModifier("max_health", 80 + ((level-1) * 5) + str_add + str_add_more)
			champion:addStatModifier("max_energy", 20 + (level-1) * 5)
		end
	end,
}

defineTrait{
	name = "monk",
	uiName = "Champion of Light",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 27,
	description = "A monk who has trained in the path of light to achieve inner balance.",
	gameEffect = [[
	- Health 70 (+1 per level)
	- Energy 60 (+1 per level)
	- Starts with every stat at 9 and gain +1 to all stats per level.
	- Food consumption reduced by 25%
	
	Healing Light: Gain bonus regeneration when you deliver a killing blow (6 seconds duration).
	- Duration +2 seconds for every 3 levels.
	- The light also touches your companions.
]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 70 + (level-1) * 1)
			champion:addStatModifier("max_energy", 60 + (level-1) * 1)
			champion:addStatModifier("food_rate", -25)
			local strength = champion:getBaseStat("strength")
			local dexterity = champion:getBaseStat("dexterity")
			local vitality = champion:getBaseStat("vitality")
			local willpower = champion:getBaseStat("willpower")
			champion:addStatModifier("food_rate", -25)
			-- if champion:getRace() == "ratling" then
				-- champion:addStatModifier("strength", 4)
				-- champion:addStatModifier("dexterity", -2)
			-- end			
			-- if champion:getRace() == "minotaur" then
				-- champion:addStatModifier("strength", -5)
				-- champion:addStatModifier("dexterity", 4)
				-- champion:addStatModifier("vitality", -4)
				-- champion:addStatModifier("willpower", 3)
			-- end
			-- if champion:getRace() == "insectoid" then
				-- champion:addStatModifier("strength", -1)
				-- champion:addStatModifier("dexterity", 2)
				-- champion:addStatModifier("vitality", 1)
				-- champion:addStatModifier("willpower", -2)
			-- end
			-- if champion:getRace() == "lizardman" then
				-- champion:addStatModifier("dexterity", -2)
				-- champion:addStatModifier("willpower", 2)
			-- end
			if Dungeon.getMaxLevels() ~= 0 then
				local str = functions.script.get_c("monkstrength", champion:getOrdinal()) and functions.script.get_c("monkstrength", champion:getOrdinal()) or 0
				local dex = functions.script.get_c("monkdexterity", champion:getOrdinal()) and functions.script.get_c("monkdexterity", champion:getOrdinal()) or 0
				local vit = functions.script.get_c("monkvitality", champion:getOrdinal()) and functions.script.get_c("monkvitality", champion:getOrdinal()) or 0
				local wil = functions.script.get_c("monkwillpower", champion:getOrdinal()) and functions.script.get_c("monkwillpower", champion:getOrdinal()) or 0
				champion:addStatModifier("strength", -strength + 9 + str)
				champion:addStatModifier("dexterity", -dexterity + 9 + dex)
				champion:addStatModifier("vitality", -vitality + 9 + vit)
				champion:addStatModifier("willpower", -willpower + 9 + wil)
			else
				champion:addStatModifier("strength", -strength + 9)
				champion:addStatModifier("dexterity", -dexterity + 9)
				champion:addStatModifier("vitality", -vitality + 9)
				champion:addStatModifier("willpower", -willpower + 9)
			end
		end	
	end,
}

defineTrait{
	name = "druid",
	uiName = "Druid",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 28,
	description = "The caretaker of the most ancient forests unknown to man.",
	gameEffect = [[
	- Health 50 (+5 per level)
	- Energy 50 (+6 per level)
	
	Forest Caretaker: Gains unique powers when carrying a herb on your offhand.
	- Blooddrop Cap: Fighting bonuses and Fire damage.
	- Etherweed: Casting bonuses and Cold damage.
	- Mudwort: Poison damage. Resistance to disease and poison for the party.
	- Falconskyre: Dexterity and Shock damage.
	- Blackmoss: Powerful bomb usage.
	- Crystal Flower: Defenses and Regeneration.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 50 + ((level-1) * 5))
			champion:addStatModifier("max_energy", 50 + (level-1) * 6)
			
			local t = GameMode:getTimeOfDay()
			t = math.floor((t*12+9)%24)
			if t >= 6 and t <= 18 then
				champion:addStatModifier("health_regeneration_rate", 10)
				champion:addStatModifier("energy_regeneration_rate", 10)
			end
		end			
	end,
}

defineTrait{
	name = "stalker",
	uiName = "Spell Thief",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 29,
	description = "The most silent and deadly predator, who has become a living shadow.",
	gameEffect = [[
	- Health 50 (+4 per level)
	- Energy 40 (+4 per level)
	- Evasion and Critical Chance +3.
	- Neutral spells gain 1% damage per point in Dexterity (+10% per 7 points).
	- Neutral spells cost 33% less energy.
	- Energy regeneration rate -100%.
	
	Night Stalker: Gain Night Stalker buff after leaving invisibility.
	- 10 seconds duration (+4 per 2 levels).
	- Doubles your class bonuses.]],
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			--return champion:getSkillLevel("concentration") * 2
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			--return champion:getSkillLevel("concentration") * 2
		end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 50 + (level-1) * 4)
			champion:addStatModifier("max_energy", 40 + (level-1) * 4)
			champion:addStatModifier("energy_regeneration_rate", -100)
		end	
	end	
}

defineTrait{
	name = "assassin",
	uiName = "Assassin",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 30,
	description = "The Assassin is always looking for their next target.",
	gameEffect = [[
	- Health 60 (+6 per level)
	- Energy 40 (+5 per level)
	- Dual Wielding damage penalty reduced to 25% (normally 40%)
	
	Assassination: Kill an enemy from the back to complete an assassination. This effect can happen once per level.
	- Assassinations increase a random stat by 1 and give you 50 exp (+150 per level).
	- Thrown Weapon damage increased by 3 points per assassination.
	- Dual wield damage increased by 5% per assassination.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 60 + (level-1) * 6)
			champion:addStatModifier("max_energy", 40 + (level-1) * 5)
		end	
	end,
}

defineTrait{
	name = "elementalist",
	uiName = "Elementalist",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 31,
	description = "Master of the elements, they can control Fire, Ice and Thunder.",
	gameEffect = [[
	- Health 35 (+5 per level)
	- Energy 60 (+8 per level)
	- Casting basic elemental magic will shield the user from that element for 10 seconds (+5 per 5 levels).
	
	Elemental Balance: Casting one element increases damage with other elements by 30%.
	- Duration is 10 seconds.
	- Gain +50% Energy Regeneration Rate.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 35 + (level-1) * 5)
			champion:addStatModifier("max_energy", 60 + (level-1) * 8)
		end	
	end,
}

defineTrait{
	name = "hunter",
	uiName = "Hunter",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 32,
	description = "A member of the hunting tribes of the Xaae Jungle.",
	gameEffect = [[
	- Health 35 (+5 per level)
	- Energy 60 (+8 per level)
	- Attacks with daggers pierce 10 armor.
	
	Thrill of the Hunt: Stack a temporary Crit Chance buff after shooting an enemy (6 seconds duration)
	- Stacks go away every 3 seconds.
	- Critical Chance +2 per stack (+1 every 3 levels).]],
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			level = champion:getLevel()
			if not functions then return end
			local inc = math.floor(level / 3)
			if functions.script.hunter_crit[champion:getOrdinal()] > 0 then
				return functions.script.hunter_crit[champion:getOrdinal()] * (2 + inc)
			end
		end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 35 + (level-1) * 5)
			champion:addStatModifier("max_energy", 60 + (level-1) * 8)
		end	
	end,
}

defineTrait{
	name = "corsair",
	uiName = "Corsair",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 33,
	description = "A sailor of the Serpent Sea, a master duelist and firearms specialist.",
	gameEffect = [[
	- Health 70 (+7 per level)
	- Energy 30 (+4 per level)
	- Firearms can use pellets from the inventory and do +2% damage per level.
	- Flintlock Pistols also do 10% more damage (+10% per level).
	
	Pistolero: Can dual wield Flintlock Pistols, firing both in quick succession.
	- Gain 20% faster actions (+2% per level).
	
	Duelist: Can carry a Light Weapon on one hand and a Firearm on the other. 
	- Attacking with the melee weapon also fires the gun.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 70 + (level-1) * 7)
			champion:addStatModifier("max_energy", 30 + (level-1) * 4)
		end	
	end,
}

defineTrait{
	name = "tinkerer",
	uiName = "Tinkerer",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 34,
	description = "With the simplest set of tools this humble artificer is able to alter the properties of objects to improve on their qualities.",
	gameEffect = [[
	- Health 50 (+5 per level)
	- Energy 40 (+6 per level)
	- Can unlock chests for free.
	
	Tinkerer's Touch: You gain +1 to all stats per upgraded item equipped.
	- Upgraded items' weight is increase by only half the normal amount.
	
	Dismantler: You can dismantle items into extra lockpicks.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 50 + (level-1) * 5)
			champion:addStatModifier("max_energy", 40 + (level-1) * 6)
			local upgItems = 0
			for i=1,ItemSlot.Bracers do
				local item = champion:getItem(i)
				if item and item:hasTrait("upgraded") then upgItems = upgItems + 1 end
			end
			champion:addStatModifier("strength", upgItems)
			champion:addStatModifier("dexterity", upgItems)
			champion:addStatModifier("vitality", upgItems)
			champion:addStatModifier("willpower", upgItems)
			champion:addTrait("tinkerer_toolbox")
			champion:addTrait("dismantler")
		end	
	end,
}

---------------------------------------------------------------------------------
-- Class traits
---------------------------------------------------------------------------------

defineTrait{
	name = "night_stalker",
	uiName = "Night Stalker",
	icon = 74,
	description = "You are stalking your prey",
	gameEffect = [[
	- Evasion + 4 (+2 per level).
	- Melee Critical and Accuracy + 5.
	- Health and Energy regeneration rate increased.	
	]],
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 and attackType == "melee" then return 5 end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 and attackType == "melee" then return 5 end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("evasion", 4 + ((level-1) * 2))
			champion:addStatModifier("health_regeneration_rate", 400)
			champion:addStatModifier("energy_regeneration_rate", 200)
		end
	end,
}

defineTrait{
	name = "assassination",
	uiName = "Assassination",
	icon = 16,
	description = "You're looking for your target...",
	gameEffect = [[- Deal the killing blow with a backstab.]],
	onRecomputeStats = function(champion, level)
	end,
}

defineTrait{
	name = "blooddrop_cap",
	uiName = "Blooddrop Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Blooddrop Cap.",
	gameEffect = [[- Strength +1 per 2 levels.
	- Fire resistance +5 (+2 per level).
	- Fire damage increased by 20%.
	- Gain extra action speed and accuracy when hit 
	by or when using a Fire spell (Duration 18 seconds).]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("strength", math.floor(level/2))
			champion:addStatModifier("resist_fire", 5 + (level * 2))
		end
	end,
}

defineTrait{
	name = "blooddrop_rage",
	uiName = "Blooddrop Fire Rage",
	icon = 60,
	description = "Fire damage causes you to attack with burning strength.",
	gameEffect = [[- Strength +4.
	- Lasts 18 seconds.]],
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then return 0.85 end
	end,
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then return 6 end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("strength", 4)
		end
	end,
}

defineTrait{
	name = "etherweed",
	uiName = "Etherweed Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying an Etherweed.",
	gameEffect = [[- Willpower +1 per 2 levels.
	- Cold resistance +5 (+2 per level).
	- Cold damage increased by 20%.
	- Recover 50% of missing Energy when hit by a Cold spell.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("willpower", math.floor(level/2))
			champion:addStatModifier("resist_cold", 5 + (level * 2))
		end	
	end,	
}

defineTrait{
	name = "etherweed_rage",
	uiName = "Etherweed Cold Rage",
	icon = 60,
	description = "Cold damage causes you to cast spells with a refreshed mind.",
	gameEffect = [[- Willpower +4.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("willpower", 4)
		end
	end,
}

defineTrait{
	name = "mudwort",
	uiName = "Mudwort Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Mudwort.",
	gameEffect = [[- Poison resistance +5 (+2 per level).
	- Immune to disease.
	- Increased Poison damage by 40%.
	- Also affects party (check their traits).]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("resist_poison", 5 + (level * 2))
			for i=1,4 do
				party.party:getChampion(i):addStatModifier("resist_poison", level * 2)
			end
		end	
	end,
	onReceiveCondition = function(champion, cond, level)
		if level > 0 and cond == "diseased" then
			return false
		end
	end,
}

defineTrait{
	name = "lesser_mudwort",
	uiName = "Lesser Mudwort Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Mudwort.",
	gameEffect = [[- Poison resistance +2 per level.
	- Disease resistance +50%.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("resist_poison", level * 2)
		end	
	end,
	onReceiveCondition = function(champion, cond, level)
		local chance = math.random() * 100
		if level > 0 and cond == "diseased" and chance >= 50 then
			return false
		end
	end,
}

defineTrait{
	name = "falconskyre",
	uiName = "Falconskyre Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Falconskyre.",
	gameEffect = [[- Dexterity +1 per level.
	- Shock resistance +5 (+2 per level).
	- Shock damage increased by 20%.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("dexterity", level)
			champion:addStatModifier("resist_shock", 5 + (level * 2))
		end	
	end,
}

defineTrait{
	name = "blackmoss",
	uiName = "Blackmoss Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Blackmoss.",
	gameEffect = [[- Doubles Bomb damage.
	- Bombs in your inventory multiply.]],
}

defineTrait{
	name = "crystal_flower",
	uiName = "Crystal Flower Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Crystal Flower.",
	gameEffect = [[- Protection +1 per level.
	- All resistances +2 per level.
	- Increases Health Regeneration by 20%.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("protection", level)
			champion:addStatModifier("resist_fire", level * 2)
			champion:addStatModifier("resist_poison", level * 2)
			champion:addStatModifier("resist_cold", level * 2)
			champion:addStatModifier("resist_shock", level * 2)
			champion:addStatModifier("health_regeneration_rate", 20)
		end	
	end,
}

defineTrait{
	name = "tinkerer_toolbox",
	uiName = "Tinkerer's Toolbox",
	icon = 88,
	description = "Items can gain effects based on your skills. These bonuses are greater if the skill is level 5.",
	gameEffect = [[
	- Athletics | Final item weight is lower.
	
	Weapons:
	- Accuracy | Weapons gain an accuracy bonus.
	- Critical | Weapons gain a critical chance bonus.
	- Firearms | Increase damage of Firearms.
	- Ranged Weapons | Increase damage of Missile and Throwing weapons.
	- Heavy Weapons | Adds bleeding chance.
	- Light Weapons | Adds reduced cooldowns.
	
	Shields and Armor:
	- Block | Adds extra evasion to a shield.
	- Heavy Armor | Adds protection.
	- Light Armor | Adds evasion.
	- Elemental Magic | Adds a random elemental resistance.]],
}

defineTrait{
	name = "dismantler",
	uiName = "Dismantler",
	iconAtlas = "mod_assets/textures/gui/dismantle.dds",
	icon = 0,
	description = "You can dismantle items into extra lockpicks.",
	gameEffect = [[
	- Put 9 dismantle-able items into a container and right-click the container.
	- Dismantle-able items have a red hammer icon on them (when in the Tinkerer's inventory).]],
}

---------------------------------------------------------------------------------
-- Race traits
---------------------------------------------------------------------------------

defineTrait{
	name = "human",
	uiName = "Human",
	icon = 37,
	description = "As a human you belong to the most populous sentient race in the known world. You are very adaptable and can excel in all professions.\n - You gain experience points 10% faster.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("exp_rate", 10)
			local item = nil
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack or item.go.throwattack) and item.go.equipmentitem then 
					if item.go.equipmentitem:getResistFire() then champion:addStatModifier("resist_fire", item.go.equipmentitem:getResistFire()) end
					if item.go.equipmentitem:getResistShock() then champion:addStatModifier("resist_shock", item.go.equipmentitem:getResistShock()) end
					if item.go.equipmentitem:getResistCold() then champion:addStatModifier("resist_cold", item.go.equipmentitem:getResistCold()) end
				end
			end
		end
	end,	
}

defineTrait{
	name = "minotaur",
	uiName = "Minotaur",
	icon = 38,
	description = "As a minotaur you are bulky, simple and quick to anger. Your incredible stubbornness is tolerated by others only because of your incredible prowess in combat.\n- Your food consumption rate is 25% higher than normal.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			-- champion:addStatModifier("strength", 4)
			-- champion:addStatModifier("dexterity", -3)
			-- champion:addStatModifier("vitality", 4)
			-- champion:addStatModifier("willpower", -3)
			-- champion:addStatModifier("food_rate", 25)
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack or item.go.throwattack) and item.go.equipmentitem then 
					if item.go.equipmentitem:getResistFire() then champion:addStatModifier("resist_fire", item.go.equipmentitem:getResistFire()) end
					if item.go.equipmentitem:getResistShock() then champion:addStatModifier("resist_shock", item.go.equipmentitem:getResistShock()) end
					if item.go.equipmentitem:getResistCold() then champion:addStatModifier("resist_cold", item.go.equipmentitem:getResistCold()) end
				end
			end
		end
	end,
}

defineTrait{
	name = "lizardman",
	uiName = "Lizardman",
	icon = 40,
	description = "As a lizardman you are a social outcast and are mistrusted by other races because of your capricious and deceitful nature. What you lack in social skills you greatly make up for in stealth and dexterity.\n- Resist All +12%.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			-- champion:addStatModifier("dexterity", 2)
			-- champion:addStatModifier("willpower", -2)
			champion:addStatModifier("resist_fire", 12)
			champion:addStatModifier("resist_cold", 12)
			champion:addStatModifier("resist_poison", 12)
			champion:addStatModifier("resist_shock", 12)
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack or item.go.throwattack) and item.go.equipmentitem then 
					if item.go.equipmentitem:getResistFire() then champion:addStatModifier("resist_fire", item.go.equipmentitem:getResistFire()) end
					if item.go.equipmentitem:getResistShock() then champion:addStatModifier("resist_shock", item.go.equipmentitem:getResistShock()) end
					if item.go.equipmentitem:getResistCold() then champion:addStatModifier("resist_cold", item.go.equipmentitem:getResistCold()) end
				end
			end
		end
	end,
}

defineTrait{
	name = "insectoid",
	uiName = "Insectoid",
	icon = 39,
	description = "As an insectoid, your thoughts are completely alien to other races. Your knowledge of the arcane is unrivaled. Insectoids come in many shapes and sizes but most often their bodies are covered with a thick shell.\n- Your chance of getting body parts injured is reduced by 50%.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			-- champion:addStatModifier("strength", 1)
			-- champion:addStatModifier("dexterity", -3)
			-- champion:addStatModifier("vitality", -1)
			-- champion:addStatModifier("willpower", 2)
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack or item.go.throwattack) and item.go.equipmentitem then 
					if item.go.equipmentitem:getResistFire() then champion:addStatModifier("resist_fire", item.go.equipmentitem:getResistFire()) end
					if item.go.equipmentitem:getResistShock() then champion:addStatModifier("resist_shock", item.go.equipmentitem:getResistShock()) end
					if item.go.equipmentitem:getResistCold() then champion:addStatModifier("resist_cold", item.go.equipmentitem:getResistCold()) end
				end
			end
		end
	end,
	onReceiveCondition = function(champion, cond, level)
		if level > 0 and string.match(cond, "_wound$") and math.random() <= 0.5 then
			return false
		end
	end,
}

defineTrait{
	name = "ratling",
	uiName = "Ratling",
	icon = 41,
	description = "As a ratling you may seem weak and disease ridden on the surface, but you are actually one of the most adaptable and hardy creatures in the world. You are a hoarder by nature and greatly enjoy fiddling with mechanical contraptions.\n- You are immune to diseases.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			-- champion:addStatModifier("strength", -4)
			-- champion:addStatModifier("dexterity", 2)
			-- champion:addStatModifier("evasion", 2)
			-- champion:addStatModifier("max_load", 15)
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack or item.go.throwattack) and item.go.equipmentitem then 
					if item.go.equipmentitem:getResistFire() then champion:addStatModifier("resist_fire", item.go.equipmentitem:getResistFire()) end
					if item.go.equipmentitem:getResistShock() then champion:addStatModifier("resist_shock", item.go.equipmentitem:getResistShock()) end
					if item.go.equipmentitem:getResistCold() then champion:addStatModifier("resist_cold", item.go.equipmentitem:getResistCold()) end
				end
			end			
		end
	end,
	onReceiveCondition = function(champion, cond, level)
		if level > 0 and cond == "diseased" then
			return false
		end
	end,
}

---------------------------------------------------------------------------------
-- Char generation traits
---------------------------------------------------------------------------------

-- Race specific
defineTrait{
	name = "lore_master",
	uiName = "Lore Master",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 39,
	charGen = true,
	requiredRace = "human",
	description = "Spell Scrolls weight nothing and you gain +1% Increased Experience Gain per scroll, plus 1 Willpower for every 5 scrolls. Bags and Boxes full of scrolls also weight nothing.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			-- count scrolls
			local scrolls = 0
			for i=1,ItemSlot.MaxSlots do
				local item = champion:getItem(i)
				if item then
					if item:hasTrait("scroll") then
						scrolls = scrolls + 1
					else
						local container = item.go.containeritem
						if container then
							local capacity = container:getCapacity()
							for j=1,capacity do
								local item2 = container:getItem(j)
								if item2 and item2:hasTrait("scroll") then
									scrolls = scrolls + 1
								end
							end
						end
					end
				end
			end
			champion:addStatModifier("exp_rate", scrolls)
			champion:addStatModifier("willpower", math.floor(scrolls/5))
		end
	end,
}

defineTrait{
	name = "average_joe",
	uiName = "Average Joe",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 40,
	charGen = true,
	requiredRace = "human",
	description = "Gain +2 to your lowest stat and +25% to your lowest resistance (If two are tied, the one at the bottom takes priority).\nGain experience 5% slower.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local stats = { "strength", "dexterity", "vitality", "willpower" }
			local lowest = 1
			for i=1,4 do
				if champion:getCurrentStat(stats[i]) <= champion:getCurrentStat(stats[lowest]) then
					lowest = i
				end
			end
			champion:addStatModifier(stats[lowest], 2)			
			stats = { "resist_fire", "resist_cold", "resist_shock", "resist_poison" }
			lowest = 1
			for i=1,4 do
				if champion:getCurrentStat(stats[i]) <= champion:getCurrentStat(stats[lowest]) then
					lowest = i
				end
			end
			champion:addStatModifier(stats[lowest], 25)
			champion:addStatModifier("exp_rate", -5)
		end
	end,
}

defineTrait{
	name = "drinker",
	uiName = "Seasoned Drinker",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 41,
	charGen = true,
	requiredRace = "human",
	description = "Start the game with a bottle of rum. When you take a drink, you lose a point in Dexterity, Vitality or Willpower (in order) permanently, but gain 50% extra experience gain for 5 minutes. You regain half those stats back when you empty the bottle, which holds 12 drinks.",onRecomputeStats = function(champion, level)
		if level > 0 then
			--champion:addStatModifier("dexterity", 15)
		end
	end
}

defineTrait{
	name = "carnivorous",
	uiName = "Carnivorous",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 42,
	charGen = true,
	requiredRace = "minotaur",
	description = "Increases chances of finding meat when defeating beasts. Eating red meat increases your Strength by 4 and Health and Energy regeneration rate by 25% for 1 minute. You can't eat non-meat foods, like bread, bugs or even fish.\nYour food consumption rate is 15% higher.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("food_rate", 15)
		end
	end
}

defineTrait{
	name = "brutalizer",
	uiName = "Brutalizer",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 43,
	charGen = true,
	requiredRace = "minotaur",
	description = "All melee attacks deal an extra 1% damage per Strength point but you also take 1% more damage per point. Every 3 levels you gain +1 to Strength.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("strength", math.floor(level/3))
		end
	end,
}

defineTrait{
	name = "zzz",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 43,
	charGen = true,
	requiredRace = "minotaur",
	description = "",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			
		end
	end,
}

defineTrait{
	name = "lizard_blood",
	uiName = "Lizard Blood",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 45,
	charGen = true,
	requiredRace = "lizardman",
	description = "Your blood is warm during the day, giving you +2 Strength and +25 Fire Resist but -10 Cold Resist.\n\nYour skin is cold during the night, giving you +2 Willpower and +25 Cold Resist but -10 Fire Resist.",
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 then
			local curTime = GameMode.getTimeOfDay()
			if curTime > 0 and curTime < 1.01 then
				champion:addStatModifier("strength", 2)
				champion:addStatModifier("resist_fire", 25)
				champion:addStatModifier("resist_cold", -10)
			else
				champion:addStatModifier("willpower", 2)
				champion:addStatModifier("resist_cold", 25)	
				champion:addStatModifier("resist_fire", -10)
			end
		end
	end,
}

defineTrait{
	name = "wide_vision",
	uiName = "Wide Vision",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 46,
	charGen = true,
	requiredRace = "lizardman",
	description = "You can see attacks coming from all directions, warning your companions of danger.\n\nFor each monster next to you, you gain +5 evasion, and your party gains +3 evasion.",
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 then
			local stat = functions.script.get_c("wide_vision", champion:getOrdinal())
			if not stat then return end
			champion:addStatModifier("evasion", stat * 5)
			for i=1,4 do
				local c = party.party:getChampionByOrdinal(i)
				if c ~= champion then
					c:addTrait("wide_vision_minor")
				end
			end
		end
	end,
}

defineTrait{
	name = "wide_vision_minor",
	uiName = "Wide Vision (Minor)",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 46,
	description = "A companion Lizardman is warning you of danger. You gain +3 evasion for each monster next to you.",
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 then
			for i=1,4 do
				local c = party.party:getChampionByOrdinal(i)
				if c:hasTrait("wide_vision") then
					local stat = functions.script.get_c("wide_vision", c:getOrdinal())
					if not stat then return end
					champion:addStatModifier("evasion", stat * 3)
				end
			end
		end
	end,
}

defineTrait{
	name = "bite",
	uiName = "Bite",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 47,
	charGen = true,
	requiredRace = "lizardman",
	description = "When attacking with a melee weapon, you perform a bite attack. This action has a 16 second cooldown, which goes down with levels.\n\nThe damage is based on your combined Strength and Dexterity.",
	onRecomputeStats = function(champion, level)
	
	end,
}

defineTrait{
	name = "persistence",
	uiName = "Persistence",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 48,
	charGen = true,
	requiredRace = "insectoid",
	description = "Increases melee damage by 4% for each point in Willpower.\nIncreases magic damage by 4% for each point in Strength.",
}

defineTrait{
	name = "chemical_processing",
	uiName = "Chemical Processing",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 49,
	charGen = true,
	requiredRace = "insectoid",
	description = "You are up to 15% faster when well-fed (between 50% and 100% of hunger bar filled), but you get hungry 25% faster if your health is below half.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			if champion:getHealth() < champion:getMaxHealth() * 0.5 then
				champion:addStatModifier("food_rate", 25)		
			end
		end
	end,
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			local food = (champion:getFood()-500) / 500			
			return 1 - (0.15 * food)
		end
	end,
}

defineTrait{
	name = "limb_regeneration",
	uiName = "Limb Regeneration",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 50,
	charGen = true,
	requiredRace = "insectoid",
	description = "Once per day you heal back to full if you fall below 20%.",
}

defineTrait{
	name = "rodent",
	uiName = "Rodent",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 51,
	charGen = true,
	requiredRace = "ratling",
	description = "You can eat herbs (but not Crystal Flowers and Blackmoss), which in addition to feeding you, reduces spell costs and cooldowns by 10% for 3 minutes.",
}

defineTrait{
	name = "collector",
	uiName = "Trinket Collector",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 51,
	charGen = true,
	requiredRace = "ratling",
	description = "",
}

defineTrait{
	name = "built_resistance",
	uiName = "Built Resistance",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 52,
	charGen = true,
	requiredRace = "ratling",
	description = "Poison resistance +50%, other resistances -10%. You gain 1 Maximum Health for each extra point of poison resistance (goes past 100).",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("resist_poison", 50)
			champion:addStatModifier("resist_fire", -10)
			champion:addStatModifier("resist_cold", -10)
			champion:addStatModifier("resist_shock",-10)
			local health = math.max(champion:getResistance("poison") - 50, 0)
			
			champion:addStatModifier("max_health", health)
			champion:addStatModifier("health", health)
			
			local resist = math.max(math.min(champion:getResistance("poison"), 85), 0)
			champion:addStatModifier("resist_poison", (champion:getResistance("poison") * -1) - ((champion:getCurrentStat("vitality") - 10) * 2))
			champion:addStatModifier("resist_poison", resist)
		end
	end,
}

---------------------------------------------------------------------------------
-- Skill traits
---------------------------------------------------------------------------------

-- Athletics
defineTrait{
	name = "pack_mule",
	uiName = "Pack Mule",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 65,
	description = "Increases carrying capacity by 10kg.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("max_load", 10)
		end
	end,
}

defineTrait{
	name = "endurance",
	uiName = "Endurance",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 66,
	description = "Increases resistance to leg wounds by 10%, plus 10% if wearing Light Armor pants or 20% if wearing Heavy Armor pants.",
}

defineTrait{
	name = "refreshed",
	uiName = "Refreshed",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 67,
	description = "Healing potions heal 25% more, with some extra healing applied instantly.",
}

-- Block
defineTrait{
	name = "block",
	uiName = "Block",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 69,
	description = "Gain +10% chance to block a physical attack with a shield.",
}

defineTrait{
	name = "shield_bearer",
	uiName = "Shield Bearer",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 70,
	description = "Immunity against hand and chest wounds.",
	onReceiveCondition = function(champion, cond, level)
		if level > 0 and (cond == "chest_wound" or cond == "left_hand_wound" or cond == "right_hand_wound") then
			return false
		end
	end,
}

defineTrait{
	name = "shield_bash",
	uiName = "Shield Bash",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 71,
	description = "Bashes the enemy for 150% of the damage received when you block an attack.",
}

-- Light Armor
defineTrait{
	name = "light_wear",
	uiName = "Light Wear",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 72,
	description = "Gain +5 Evasion if wearing light armor in all 5 slots",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local all_light = functions.script.wearingAll(champion, "light_armor", "clothes")
			if all_light then
				champion:addStatModifier("evasion", 5)
			end
		end
	end,
}

defineTrait{
	name = "reflective",
	uiName = "Reflective",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 73,
	description = "Gain +20 resist all if wearing all light armor.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local all_light = functions.script.wearingAll(champion, "light_armor", "clothes")
			if all_light then
				champion:addStatModifier("resist_fire", 20)
				champion:addStatModifier("resist_cold", 20)
				champion:addStatModifier("resist_shock", 20)
				champion:addStatModifier("resist_poison", 20)
			end
		end
	end,
}

defineTrait{
	name = "nimble",
	uiName = "Nimble",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 74,
	description = "Reduces action timers by 15% if wearing all light armor.",
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			local all_light = functions.script.wearingAll(champion, "light_armor", "clothes")
			if all_light then
				return 0.85
			end	
		end
	end,
}

-- Heavy Armor
defineTrait{
	name = "armored_up",
	uiName = "Armored Up",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 75, 
	description = "Gain +2 Protection per level if wearing heavy armor in all 5 slots",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			local all_heavy = functions.script.wearingAll(champion, "heavy_armor")
			if all_heavy then
				champion:addStatModifier("protection", level * 2)
			end
		end
	end,
}

defineTrait{
	name = "armor_training",
	uiName = "Armor Training",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 76,
	description = "Heavy Armor weights nothing if wearing all heavy armor.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local all_heavy = functions.script.wearingAll(champion, "heavy_armor")
			if all_heavy then
				local equip_slots = {3,4,5,6,9}
				for i, v in pairs(equip_slots) do
					local item = champion:getItem(v)
					if item ~= nil and item:getWeight() > 0 then
						if item:hasTrait("heavy_armor") then
							functions.script.supertable[5][item.go.id] = item:getWeight()
							item:setWeight(0)
						end
					end
				end
			end
		end
	end,
}

defineTrait{
	name = "heavy_conditioning",
	uiName = "Heavy Conditioning",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 77,
	description = "Heavy Armor weights 75% less while in your inventory.",
}

-- Accuracy
defineTrait{
	name = "reach",
	uiName = "Reach",
	icon = 1,
	description = "",
}

defineTrait{
	name = "clutch",
	uiName = "Clutch",
	icon = 1,
	description = "Gain up to +100 accuracy based on how much health the party is missing.",
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			local hpMaxTotal = 0
			local hpTotal = 0
			for i=1,4 do
				local champ = party.party:getChampionByOrdinal(i)
				hpMaxTotal = hpMaxTotal + champ:getMaxHealth()
				hpTotal = hpTotal + champ:getHealth()
			end
			local hpRate = 1 - (hpTotal / hpMaxTotal)
			print(champion:getName())
			return 100 * hpRate
		end
	end,
}

defineTrait{
	name = "precision",
	uiName = "Precision",
	icon = 1,
	description = "25% Chance to pierce 5 to 15 armor with melee and firearm attacks.",
}

-- Critical
defineTrait{
	name = "backstab",
	uiName = "Backstab",
	icon = 103,
	description = "You do triple damage when you successfully backstab an enemy with a dagger.",
	-- hardcoded skill
}

defineTrait{
	name = "weapons_specialist",
	uiName = "Weapons Specialist",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 68,
	description = "You gain double critical chance from items.",
}

defineTrait{
	name = "assassin",
	uiName = "Assassin",
	icon = 104,
	description = "You can backstab with any Light Weapon.",
	-- hardcoded skill
}

-- Firearms
defineTrait{
	name = "metal_slug",
	uiName = "Metal Slug",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 84,
	description = "7% chance to not spend a pellet to fire.",
}

defineTrait{ -- to do
	name = "quickshot",
	uiName = "Quickshot",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 84,
	description = "Every 6th shot does double damage.",
}

defineTrait{
	name = "fast_fingers",
	uiName = "Fast Fingers",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 86,
	description = "Reload time reduced by 25%.",
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 and weapon ~= nil and weapon:hasTrait("firearm") then
			return 0.75
		end
	end
}

-- Ranged Weapons
defineTrait{
	name = "bullseye",
	uiName = "Bullseye",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 87,
	description = "Gain 15 accuracy with ranged attacks.",
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			if attackType == "missile" or attackType == "throw" then
				return 15
			end
		end
	end,
}

defineTrait{
	name = "magic_missile",
	uiName = "Magic Missile",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 88,
	description = "You launch a magical projectile with your attacks. It does 1/3 the damage of your attack and pierces half the target's protection.",
}

defineTrait{
	name = "double_shot",
	uiName = "Double Shot",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 89,
	description = "You attack twice when using Missile Weapons, Throwing Weapons and Firearms.",
}

-- Seafaring
defineTrait{
	name = "sea_dog",
	uiName = "Sea Dog",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 118,
	description = "You deal 30% more melee damage from the backline and 30% more firearm damage from the frontline.",
}

defineTrait{
	name = "broadside",
	uiName = "Broadside",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 118,
	description = "Pellets and cannon balls have a 40% chance to create shrapnel on impact, doing half damage to the enemy behind your target.",
}

defineTrait{
	name = "",
	uiName = "Sea Dog",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 118,
	description = "Cannon balls in your inventory weight 80% less.",
}

-- Alchemy
defineTrait{
	name = "green_thumb",
	uiName = "Green Thumb",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 118,
	description = "Herbs multiply while in your inventory. Spreading the herbs out or having multiple alchemists don't affect the multiplication.",
}

defineTrait{
	name = "",
	uiName = "",
	icon = 53,
	description = "",
}

defineTrait{
	name = "bomb_expert",
	uiName = "Bomb Expert",
	icon = 22,
	description = "When crafting bombs you get three bombs instead of one.",
}

-- Light Weapons
defineTrait{
	name = "dual_wield",
	uiName = "Dual Wielding",
	icon = 19,
	description = "You can attack separately with Light Weapons in either hand. One of the weapons must be a dagger. Both weapons suffer a 40% penalty to the items' base damage when dual wielding.",
	-- hardcoded skill
}

defineTrait{
	name = "double_attack",
	uiName = "Double Attack",
	icon = 1,
	description = "You gain 25% chance to attack twice with Light Weapons.",
}

defineTrait{
	name = "improved_dual_wield",
	uiName = "Dual Wield Mastery",
	icon = 107,
	description = "You can dual wield any two Light Weapons. Both weapons still suffer a 40% penalty to the items' base damage when dual wielding.",
	-- hardcoded skill
}

-- Heavy Weapons

-- Spellblade
defineTrait{ -- to do
	name = "staff_fighter",
	uiName = "Staff Fighter",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 101,
	description = "You can hold a staff in one hand.",
}

defineTrait{
	name = "spell_slinger",
	uiName = "Spell Slinger",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 101,
	description = "Cast a basic spell to memorize it. You'll automatically cast this spell with melee attacks at 10% chance.",
}

defineTrait{
	name = "fireburst_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 101,
	description = "You memorized the Fireburst spell.",
}

defineTrait{
	name = "frost_burst_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 101,
	description = "You memorized the Frost Burst spell.",
}

defineTrait{
	name = "shock_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 101,
	description = "You memorized the Shock spell.",
}

defineTrait{
	name = "poison_cloud_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 101,
	description = "You memorized the Poison Cloud spell.",
}

defineTrait{ -- to do
	name = "arcane_warrior",
	uiName = "Arcane Warrior",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 102,
	description = "Non-ultimate level spells gain damage equal to 10% of the current weapon damage plus 10% of your accuracy.",
}

defineTrait{
	name = "mage_strike",
	uiName = "Mage Strike",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 102,
	description = "Your spells gain double the critical chance from the Critical skill and a flat +6%.",
}

-- Elemental Magic
defineTrait{
	name = "elemental_exploitation",
	uiName = "Elemental Exploitation",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 104,
	description = "Deal 25% more damage if the enemy is vulnerable to that element.",
}

defineTrait{
	name = "elemental_armor",
	uiName = "Elemental Armor",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 105,
	description = "You gain +20% Resist Fire, Shock and Cold.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("resist_fire", 20)
			champion:addStatModifier("resist_cold", 20)
			champion:addStatModifier("resist_shock", 20)
		end
	end,
}

-- Poison Mastery
defineTrait{
	name = "venomancer",
	uiName = "Venomancer",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 106,
	description = "You gain 20% chance to poison enemies with both melee and ranged attacks.",
}
defineTrait{ -- to do
	name = "plague",
	uiName = "Plague",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 106,
	description = "Your poison spells have a larger area of effect and can't damage your party.",
}

defineTrait{
	name = "antivenom",
	uiName = "Anti-venom",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 107,
	description = "+35% Resist Poison and immunity to being poisoned.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("resist_poison", 45)
		end
	end,
	onReceiveCondition = function(champion, cond, level)
		if level > 0 and cond == "poison" then
			return false
		end
	end,
}

-- Magic Training
defineTrait{
	name = "meditation",
	uiName = "Meditation",
	icon = 1,
	description = "Your Energy regeneration rate is increased by 25% while resting.",
}

defineTrait{ -- to do
	name = "imperium_arcana",
	uiName = "Imperium Arcana",
	icon = 1,
	description = "Non-elemental and non-poison spells deal 35% more damage.",
}

defineTrait{
	name = "arcane_extraction",
	uiName = "Arcane Extraction",
	icon = 1,
	description = "Energy potions recover 25% more, while also regenerating 25 health. At the same time, healing potions recover 25 energy.",
}

-- Witchcraft
defineTrait{ -- to do
	name = "ritual",
	uiName = "Ritual",
	icon = 1,
	description = "Heals the party for 10% of the damage done with spells.",
}

defineTrait{ -- to do
	name = "moon_rites",
	uiName = "Moon Rites",
	icon = 1,
	description = "Energy regeneration rate increased by 50% during the night.",
}

defineTrait{ -- to do
	name = "voodoo",
	uiName = "Voodoo",
	icon = 1,
	description = "You can obtain voodoo dolls of monsters by slaying them.",
}