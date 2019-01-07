defineTrait{
	name = "fighter",
	uiName = "Berserker",
	icon = 94,
	description = "A prideful warrior of the tribes of the Red Hills.",
	gameEffect = [[
	- Health 80 (+5 per level, +5 per 5 strength and 10 strength)
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
			local str_add_more = math.floor(champion:getCurrentStat("strength") / 10) * 5
			champion:addStatModifier("max_health", 80 + ((level-1) * 5) + str_add + str_add_more)
			champion:addStatModifier("max_energy", 20 + (level-1) * 5)
		end
	end,
}

defineTrait{
	name = "monk",
	uiName = "Champion of Light",
	icon = 93,
	description = "A monk who has trained in the path of light to achieve inner balance.",
	gameEffect = [[
	- Health 70 (+5 per level)
	- Energy 60 (+5 per level)
	- Starts with every stat at 5 and gain +1 to all stats per level (No race bonus).
	- Food consumption reduced by 25%
	
	Healing Light: Gain bonus regeneration when you deliver a killing blow (6 seconds duration).
	- Duration +2 seconds for every 3 levels.
	- The light also touches your companions.
]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 70 + (level-1) * 5)
			champion:addStatModifier("max_energy", 60 + (level-1) * 5)
			local strength = champion:getBaseStat("strength")
			local dexterity = champion:getBaseStat("dexterity")
			local vitality = champion:getBaseStat("vitality")
			local willpower = champion:getBaseStat("willpower")
			champion:addStatModifier("food_rate", -25)
			if champion:getRace() == "ratling" then
				champion:addStatModifier("strength", 4)
				champion:addStatModifier("dexterity", -2)
			end			
			if champion:getRace() == "minotaur" then
				champion:addStatModifier("strength", -5)
				champion:addStatModifier("dexterity", 4)
				champion:addStatModifier("vitality", -4)
				champion:addStatModifier("willpower", 3)
			end
			if champion:getRace() == "insectoid" then
				champion:addStatModifier("strength", -1)
				champion:addStatModifier("dexterity", 2)
				champion:addStatModifier("vitality", 1)
				champion:addStatModifier("willpower", -2)
			end
			if champion:getRace() == "lizardman" then
				champion:addStatModifier("dexterity", -2)
				champion:addStatModifier("willpower", 2)
			end
			champion:addStatModifier("strength", -strength + 5)
			champion:addStatModifier("dexterity", -dexterity + 5)
			champion:addStatModifier("vitality", -vitality + 5)
			champion:addStatModifier("willpower", -willpower + 5)
		end	
	end,
	
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then return 0.95 end
	end,
}

defineTrait{
	name = "druid",
	uiName = "Druid",
	icon = 92,
	description = "The caretaker of the most ancient forests unknown to man.",
	gameEffect = [[
	- Health 50 (+5 per level)
	- Energy 50 (+6 per level)
	- Can turn stale food into herbs by casting poison cloud.
	- Food consumption rate reduced by 25%.
	
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
			champion:addStatModifier("food_rate", -25)
			
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
	uiName = "Stalker",
	icon = 96,
	description = "The most silent and deadly predator, who has become a living shadow.",
	gameEffect = [[
	- Health 50 (+4 per level)
	- Energy 40 (+4 per level)
	- Critical and Accuracy + 2 per level of Concentration
	- Rest to gain Invisibility. Can be used once (+ 1 every 4 levels) per day. Invisibility lasts 10 to 30 seconds based on level.
	
	Night Stalker: Gain Night Stalker buff after leaving invisibility (8 seconds duration).
	- Duration +2 seconds every 3 levels.
	- Evasion + 4 (+2 per level).
	- Melee Critical and Accuracy + 5.
	- Health and Energy regeneration rate increased.	
	]],
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			return champion:getSkillLevel("concentration") * 2
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			return champion:getSkillLevel("concentration") * 2
		end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 50 + (level-1) * 4)
			champion:addStatModifier("max_energy", 40 + (level-1) * 4)
		end	
	end	
}

defineTrait{
	name = "assassin",
	uiName = "Assassin",
	icon = 96,
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
	icon = 33,
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
	icon = 33,
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
	icon = 94,
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
	icon = 94,
	description = "With the simplest set of tools this humble artificer is able to alter the properties of objects to improve on their qualities.",
	gameEffect = [[
	- Health 50 (+5 per level)
	- Energy 40 (+6 per level)
	- Can unlock chests at the cost of 100% max Energy.
	
	Tinkerer's Touch: Use a lockpick on a Firearm, Axe, Shield or Accessory to upgrade it. 
	- Your tinkering level goes up after every 3 upgrades.
	- You gain +1 to all stats per upgraded item equipped.
	- Upgraded items are 5kg heavier (-0.25kg per level).
	
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
	gameEffect = [[ - Deal the killing blow with a backstab.]],
	onRecomputeStats = function(champion, level)
	end,
}

defineTrait{
	name = "blooddrop_cap",
	uiName = "Blooddrop Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Blooddrop Cap.",
	gameEffect = [[
	- Strength +1 per level.
	- Fire resistance +5 per level.
	- Increased Fire damage by 10%.
	- Gain extra action speed and melee accuracy when hit 
	by or when using a Fire attack (Duration 18 seconds).]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("strength", level)
			champion:addStatModifier("resist_fire", level * 5)
		end
	end,
}

defineTrait{
	name = "blooddrop_rage",
	uiName = "Blooddrop Fire Rage",
	icon = 60,
	description = "Fire damage causes you to attack with burning speed",
	gameEffect = [[
	- Accuracy + 6
	- Attack cooldowns are 15% faster.
	- Lasts 18 seconds.]],
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then return 0.85 end
	end,
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 and attackType == "melee" then return 6 end
	end,
	onRecomputeStats = function(champion, level)
	end,
}

defineTrait{
	name = "etherweed",
	uiName = "Etherweed Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying an Etherweed.",
	gameEffect = [[
	- Willpower +1 per level.
	- Cold resistance +5 per level.
	- Increased Cold damage by 20%.
	- Recover 50% of missing Energy when hit by a Cold attack.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("willpower", level)
			champion:addStatModifier("resist_cold", level * 5)
		end	
	end,	
}

defineTrait{
	name = "mudwort",
	uiName = "Mudwort Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Mudwort.",
	gameEffect = [[
	- Poison resistance + 5 per level.
	- Immune to disease.
	- Increased Poison damage by 40%.
	- Also affects party (check their traits).]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("resist_poison", level * 2)
			for i=1,4 do
				party.party:getChampion(i):addStatModifier("resist_poison", level * 3)
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
	gameEffect = [[
	- Poison resistance +3 per level.
	- Disease resistance +50%.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("resist_poison", level * 3)
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
	gameEffect = [[
	- Dexterity +1 per level.
	- Shock resistance +5 per level.
	- Increased Air damage by 20%.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("dexterity", level)
			champion:addStatModifier("resist_shock", level * 5)
		end	
	end,
}

defineTrait{
	name = "blackmoss",
	uiName = "Blackmoss Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Blackmoss.",
	gameEffect = [[
	- Doubles Bomb damage.
	- Bombs in your inventory multiply.]],
}

defineTrait{
	name = "crystal_flower",
	uiName = "Crystal Flower Boon",
	icon = 88,
	description = "The Druid draws from the earth by carrying a Crystal Flower.",
	gameEffect = [[
	- Protection +1 per level.
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
	- Firearms | Increase base damage of Firearms.
	- Heavy Weapons | Adds bleeding chance.
	- Light Weapons | Adds reduced cooldowns.
	
	Shields and Armor:
	- Block | Adds extra evasion to a shield.
	- Heavy Armor | Adds protection.
	- Light Armor | Adds evasion.
	- Elemental Magic | Adds a random elemental resistance.
	
	Accessories:
	- Adds stats based on the relevant skill. Ex: If an item gives Energy, it will be increased based on your Magic Training skill.]],
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
				if item and (item.go.firearmattack or item.go.meleeattack) and item.go.equipmentitem then 
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
	description = "As a minotaur you are bulky, simple and quick to anger. Your incredible stubborness is tolerated by others only because of your incredible prowess in combat.\n- Strength and Vitality +4\n- Dexterity and Willpower -3.\n- Your food consumption rate is 25% higher than normal.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("strength", 4)
			champion:addStatModifier("dexterity", -3)
			champion:addStatModifier("vitality", 4)
			champion:addStatModifier("willpower", -3)
			champion:addStatModifier("food_rate", 25)
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack) and item.go.equipmentitem then 
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
	description = "As a lizardman you are a social outcast and are mistrusted by other races because of your capricious and deceitful nature. What you lack in social skills you greatly make up for in stealth and dexterity.\n- Dexterity +2, Willpower -2.\n- Resist All +20%.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("dexterity", 2)
			champion:addStatModifier("willpower", -2)
			champion:addStatModifier("resist_fire", 20)
			champion:addStatModifier("resist_cold", 20)
			champion:addStatModifier("resist_poison", 20)
			champion:addStatModifier("resist_shock", 20)
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack) and item.go.equipmentitem then 
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
	description = "As an insectoid, your thoughts are completely alien to other races. Your knowledge of the arcane is unrivaled. Insectoids come in many shapes and sizes but most often their bodies are covered with a thick shell.\n- Strength +1, Dexterity -2, Vitality -1, Willpower +2.\n- Your chance of getting body parts injured is reduced by 50%.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("strength", 1)
			champion:addStatModifier("dexterity", -2)
			champion:addStatModifier("vitality", -1)
			champion:addStatModifier("willpower", 2)
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack) and item.go.equipmentitem then 
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
	description = "As a ratling you may seem weak and disease ridden on the surface, but you are actually one of the most adaptable and hardy creatures in the world. You are a hoarder by nature and greatly enjoy fiddling with mechanical contraptions.\n- Strength -4, Dexterity +2.\n- Evasion +2.\n- Max Load +15kg.\n- You are immune to diseases.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("strength", -4)
			champion:addStatModifier("dexterity", 2)
			champion:addStatModifier("evasion", 2)
			champion:addStatModifier("max_load", level * 15)
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack) and item.go.equipmentitem then 
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
	icon = 46,
	charGen = true,
	requiredRace = "human",
	description = "Scrolls weight nothing and you gain +1% Increased Experience Gain per scroll, plus 1 Willpower for every 5 scrolls. Bags and Boxes full of scrolls also weight nothing.",
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
	icon = 46,
	charGen = true,
	requiredRace = "human",
	description = "Gain + 2 to your lowest stat and +25% to your lowest resistance. If two are tied, the on at the bottom takes priority.",
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
		end
	end,
}

defineTrait{
	name = "drinker",
	uiName = "Seasoned Drinker",
	icon = 46,
	charGen = true,
	requiredRace = "human",
	description = "Start the game with a bottle of rum. When you take a drink, you lose a point in Dexterity, Vitality and Willpower (a different stat each time) permanently, but gain 50% extra experience gain for 5 minutes. You regain half those stats back when you empty the bottle, which holds 12 drinks.",
}

defineTrait{
	name = "carnivorous",
	uiName = "Carnivorous",
	icon = 46,
	charGen = true,
	requiredRace = "minotaur",
	description = "Increases chances of finding meat when defeating beasts. Eating red meat increases your Strength by 4 and Health and Energy regeneration rate by 25% for 1 minute. You can't eat non-meat foods, like bread, bugs or even fish.",
}

defineTrait{
	name = "brutalizer",
	uiName = "Brutalizer",
	icon = 46,
	charGen = true,
	requiredRace = "minotaur",
	description = "Melee attacks deal an extra 1% damage per Strength point but you also take 1% more damage. Every 3 levels you gain + 1 to Strength.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("strength", math.floor(level/3))
		end
	end,
}

defineTrait{
	name = "lizard_blood",
	uiName = "Lizard Blood",
	icon = 52,
	charGen = true,
	requiredRace = "lizardman",
	description = "Your blood is warm during the day, giving you +2 Strength and +25% Fire Resist. Your skin is cold during the night, giving you +2 Willpower and +25% Cold Resist.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local curTime = GameMode.getTimeOfDay()
			if curTime > 0 and curTime < 1.01 then
				champion:addStatModifier("strength", 2)
				champion:addStatModifier("resist_fire", 25)
			else
				champion:addStatModifier("willpower", 2)
				champion:addStatModifier("resist_cold", 25)			
			end
		end
	end,
}

defineTrait{
	name = "wide_vision",
	uiName = "Wide Vision",
	icon = 52,
	charGen = true,
	requiredRace = "lizardman",
	description = "You can see attacks coming from all directions, giving you +5 evasion for each monsters that is behind or beside you.",
}

defineTrait{
	name = "persistence",
	uiName = "Persistence",
	icon = 52,
	charGen = true,
	requiredRace = "insectoid",
	description = "Increases melee damage by 4% for each point in Willpower. Increases magic damage by 4% for each point in Strength.",
}

defineTrait{
	name = "chemical_processing",
	uiName = "Chemical Processing",
	icon = 52,
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
	icon = 52,
	charGen = true,
	requiredRace = "insectoid",
	description = "Once per day you heal back to full if you fall below 20%.",
}

defineTrait{
	name = "rodent",
	uiName = "Rodent",
	icon = 52,
	charGen = true,
	requiredRace = "ratling",
	description = "You can eat herbs (but not Crystal Flowers and Blackmoss), which in addition to feeding you, reduces spell costs and cooldowns by 10% for 3 minutes.",
}

defineTrait{
	name = "built_resistance",
	uiName = "Built Resistance",
	icon = 48,
	charGen = true,
	requiredRace = "ratling",
	description = "Poison resistance + 75%, other resistances -10%. You gain 1 Maximum Health for each extra point of poison resistance (goes past 100).",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("resist_poison", 75)
			champion:addStatModifier("resist_fire", -10)
			champion:addStatModifier("resist_cold", -10)
			champion:addStatModifier("resist_shock",-10)
			local health = math.max(champion:getCurrentStat("resist_poison") - 75, 0)
			champion:addStatModifier("max_health", health)
		end
	end,
}

---------------------------------------------------------------------------------
-- Skill traits
---------------------------------------------------------------------------------


defineTrait{
	name = "pack_mule",
	uiName = "Pack Mule",
	icon = 1,
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
	icon = 1,
	description = "Increases resistance to leg wounds by 10%, plus 10% if wearing Light Armor pants or 20% if wearing Heavy Armor pants.",
}


defineTrait{
	name = "refreshed",
	uiName = "Refreshed",
	icon = 1,
	description = "You gain +100% Health Regeneration Rate for 30 seconds after drinking a healing potion.",
}

-- Defensive Skills Traits

defineTrait{
	name = "block",
	uiName = "Block",
	icon = 41,
	description = "Gain +10% chance to block a physical attack with a shield.",
}

defineTrait{
	name = "shield_bearer",
	uiName = "Shield Bearer",
	icon = 41,
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
	icon = 41,
	description = "Bashes the enemy for 150% of the damage received when you block an attack.",
}

defineTrait{
	name = "armored_up",
	uiName = "Armored Up",
	icon = 41,
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
	icon = 41,
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
	icon = 41,
	description = "Heavy Armor weights 75% less while in your inventory.",
}

defineTrait{
	name = "light_wear",
	uiName = "Light Wear",
	icon = 41,
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
	icon = 41,
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
	icon = 41,
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

defineTrait{
	name = "precision",
	uiName = "Precision",
	icon = 1,
	description = "25% Chance to pierce 10 armor with attacks.",
}

-- Ranged Weapons Skills Traits

defineTrait{
	name = "metal_slug",
	uiName = "Metal Slug",
	icon = 41,
	description = "Small chance to not spend a pellet to fire (firing still requires at least 1 pellet in the inventory).",
}

defineTrait{
	name = "fast_fingers",
	uiName = "Fast Fingers",
	icon = 41,
	description = "Reduce firearm reload time.",
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if weapon ~= nil and weapon:hasTrait("firearm") then
			return 0.75
		end
	end
}

defineTrait{
	name = "bullseye",
	uiName = "Bullseye",
	icon = 41,
	description = "Gain 15 accuracy with ranged attacks.",
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			if attackType == "missile" or attackType == "throw" or attackType == "firearm" then
				return 15
			end
		end
	end,
}

defineTrait{
	name = "fleshbore",
	uiName = "Fleshbore",
	icon = 41,
	description = "Ranged attacks ignore 10 points of an enemy's armor.",
}

defineTrait{
	name = "double_shot",
	uiName = "Double Shot",
	icon = 41,
	description = "You attack twice when using Missile Weapons, Throwing Weapons and Firearms.",
}

-- Magic Skills Traits

defineTrait{
	name = "spell_slinger",
	uiName = "Spell Slinger",
	icon = 1,
	description = "Cast a basic spell to memorize it. You'll automatically cast this spell with melee attacks at 10% chance.",
}

defineTrait{
	name = "fireburst_memo",
	uiName = "Memorized Spell",
	icon = 1,
	description = "You memorized the Fireburst spell.",
}

defineTrait{
	name = "frost_burst_memo",
	uiName = "Memorized Spell",
	icon = 1,
	description = "You memorized the Frost Burst spell.",
}

defineTrait{
	name = "shock_memo",
	uiName = "Memorized Spell",
	icon = 1,
	description = "You memorized the Shock spell.",
}

defineTrait{
	name = "poison_cloud_memo",
	uiName = "Memorized Spell",
	icon = 1,
	description = "You memorized the Poison Cloud spell.",
}

defineTrait{
	name = "elemental_exploitation",
	uiName = "Elemental Exploitation",
	icon = 1,
	description = "Deal 25% more damage if the enemy is vulnerable to that element.",
}

defineTrait{
	name = "mage_strike",
	uiName = "Mage Strike",
	icon = 1,
	description = "You can hit critical strikes with your spells.",
}

defineTrait{
	name = "elemental_armor",
	uiName = "Elemental Armor",
	icon = 1,
	description = "+ 25% Resist Fire, Shock and Cold.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("resist_fire", 25)
			champion:addStatModifier("resist_cold", 25)
			champion:addStatModifier("resist_shock", 25)
		end
	end,
}

defineTrait{
	name = "venomancer",
	uiName = "Venomancer",
	icon = 1,
	description = "",
}

defineTrait{
	name = "antivenom",
	uiName = "Anti-venom",
	icon = 1,
	description = "+ 50% Resist Poison",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("resist_poison", 50)
		end
	end,
}

defineTrait{
	name = "meditation",
	uiName = "Meditation",
	icon = 1,
	description = "",
}

defineTrait{
	name = "arcane_extraction",
	uiName = "Arcane Extraction",
	icon = 1,
	description = "",
}

defineTrait{
	name = "green_thumb",
	uiName = "Green Thumb",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 0,
	description = "Herbs multiply while in your inventory. Rate is 0.5% chance per step, with a delay after a multiplication happens. The number of herbs and their stacks doesn't affect the multiplication rate. An empty inventory slot is needed.",
}