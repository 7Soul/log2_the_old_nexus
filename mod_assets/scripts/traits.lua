defineTrait{
	name = "assassin_class",
	uiName = "Assassin",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 26,
	description = "A contract killer who can improve their technique with each kill.",
	gameEffect = [[
	- Health 44 (+4 per level)
	- Energy 30 (+7 per level)
	- Dual Wielding damage penalty reduced to 25% (normally 40%)
	
	Assassination: Once per level, when you kill an enemy from behind you get an Assassination stack.
	- Increases a random stat by 1 and gives extra scaling exp.
	- Dual Wield and Ranged Damage increased by 5% per assassination.
	- Attacking from behind saps 2% of a target's health (+0.5% per assassination).]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 44 + (level-1) * 4)
			champion:addStatModifier("max_energy", 30 + (level-1) * 7)
		end	
	end,
}

defineTrait{
	name = "fighter",
	uiName = "Berserker",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 27,
	description = "A prideful warrior of the Red Hills.",
	gameEffect = [[
	- Health 80 (+5 per level, +15 per 10 Strength)
	- Energy 20 (+5 per level)
	- Can't wear armor, except for light helmets, boots and gloves.
	
	Berserker Frenzy: Gain a buff that fades over 20 seconds if party gets attacked.
	- Protection up to +4 per level (+6 per 3 levels).
	- Strength up to +2 (+1 per 3 levels).
	
	Berserker Reprisal: Gain a buff that fades over 60 seconds if a party member dies.
	- Increased Frenzy effects and extra healing at low health.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			--local str_add = math.floor(champion:getCurrentStat("strength") / 5) * 5
			local str_add_more = math.floor(champion:getCurrentStat("strength") / 10) * 15
			champion:addStatModifier("max_health", 80 + ((level-1) * 5) + str_add_more)
			champion:addStatModifier("max_energy", 20 + (level-1) * 5)
		end
	end,
}

defineTrait{
	name = "monk",
	uiName = "Champion",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 28,
	description = "A monk who has trained in the path of light to achieve inner balance.",
	gameEffect = [[
	- Health 70 (+1 per level)
	- Energy 60 (+1 per level)
	- Starts with every stat at 9 and gain +1 to all stats per level.
	
	Healing Light: Damaging enemies charge a 500% Health Regen and 300% Energy Regen buff. It affects the party at half the effect.
	- Duration is 12 seconds (+3 seconds per 4 levels).
	- Deal the killing blow for a bonus charge.
	
	Holy Light: You gain a random bonus of 0 to 3 to all stats (+1 max per 3 levels, 1 minute duration).
	- It begins when Healing Light ends. Duration +30 seconds per 4 levels.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 70 + (level-1) * 1)
			champion:addStatModifier("max_energy", 60 + (level-1) * 1)
			--champion:addStatModifier("food_rate", -25)
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
	name = "corsair",
	uiName = "Corsair",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 29,
	description = "A sailor of the Serpent Sea, a master duelist and firearms specialist.",
	gameEffect = [[
	- Health 70 (+7 per level)
	- Energy 30 (+4 per level)
	- Flintlock Pistols do 10% more damage (+10% per level).
	
	Pistolero: Your reloading times are 40% slower (-1.5% per level) when dual wielding with a pistol.
	- Can dual wield Pistols, firing both in quick succession.
	- Can dual wield a Light Weapon and a Pistol, attacking with both.
	
	Duelist: Melee attacks gain +10 Accuracy and +5% Critical Chance when fighting a single foe.]],
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 and attackType == "melee" then 
			if not functions then return end
			if functions.script.get_c("duelist", champion:getOrdinal()) == 1 then
				level = champion:getLevel() - 1
				return 10
			end
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 and attackType == "melee" then 
			if not functions then return end
			if functions.script.get_c("duelist", champion:getOrdinal()) == 1 then
				level = champion:getLevel() - 1
				return 5
			end
		end
	end,
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			local item1 = champion:getItem(ItemSlot.Weapon)
			local item2 = champion:getItem(ItemSlot.OffHand)
			if (item1 and item1.go.firearmattack) and (item2 and item2.go.firearmattack) then
				level = champion:getLevel()
				return 1.4 - (level * 0.015)
			end
		end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 70 + (level-1) * 7)
			champion:addStatModifier("max_energy", 30 + (level-1) * 4)
		end	
	end,
}

defineTrait{
	name = "druid",
	uiName = "Druid",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 30,
	description = "The caretaker of the most ancient forests unknown to man.",
	gameEffect = [[
	- Health 50 (+5 per level)
	- Energy 50 (+6 per level)
	
	Herbologist: You can attach a herb to your accessory slot, gaining unique effects.
	- All herbs convert 20% of your physical damage to Poison.
	
	- Blooddrop Cap: Strength +2. Gain health by dealing poison damage.
	- Etherweed: Willpower +2. Gain energy by dealing poison damage.
	- Mudwort: Vitality + 2. Conversion rate 40%. Chance to poison. More damage to poisoned foes.
	- Falconskyre: Dexterity + 2. Chance to poison. Poison and Disease resistance.
	- Blackmoss: Chance to poison. Bonus to all poison damage (high).
	- Crystal Flower: Converts all spells to poison. Bonus to all poison damage. ]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 50 + ((level-1) * 5))
			champion:addStatModifier("max_energy", 50 + (level-1) * 6)
			if not functions then return end
			local druidItem = functions.script.get_c("druid_item", champion:getOrdinal())
			if druidItem then
				if druidItem == "blooddrop_cap" then
					champion:addStatModifier("strength", 2)
				elseif druidItem == "etherweed" then
					champion:addStatModifier("willpower", 2)
				elseif druidItem == "mudwort" then
					champion:addStatModifier("vitality", 2)
				elseif druidItem == "falconskyre" then
					champion:addStatModifier("dexterity", 2)
					champion:addStatModifier("resist_poison", 10 + (level - 1))
				end
			end
		end			
	end,
	
	onReceiveCondition = function(champion, cond, level)
		if level > 0 then
			if not functions then return end
			local druidItem = functions.script.get_c("druid_item", champion:getOrdinal())
			if druidItem and druidItem == "falconskyre" then
				if cond == "diseased" or cond == "poisoned" then
					return false
				end
			end
		end
	end,
}

defineTrait{
	name = "elementalist",
	uiName = "Elementalist",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 31,
	description = "Sage of the elements who can control Fire, Ice and Thunder.",
	gameEffect = [[
	- Health 35 (+5 per level)
	- Energy 60 (+9 per level)
	
	Trine Aegis: Casting elemental magic will shield the user from that element for 10 seconds (+3 per 3 levels).
	
	Elemental Balance: Casting one element increases damage with other elements by 25% for 10 seconds.
	- You regain 5% Max Energy (+1% per 10 Willpower) when using this bonus.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 35 + (level-1) * 5)
			champion:addStatModifier("max_energy", 60 + (level-1) * 9)
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
	- Energy 40 (+9 per level)
	
	Wisdom of the Tribe: Gain bonuses when fighting animals, beasts and insects.
	- Your attacks and spells are empowered by your Willpower (with diminishing returns).
	- You heal 5% missing health per attack.
	
	Thrill of the Hunt: Stack a temporary buff after hitting an enemy (6 seconds duration).
	- Critical Chance and Willpower +1 per stack.
	- Stacks go away every 3 seconds after initial buff duration.
	- Duration +1 second per level.]],
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			level = champion:getLevel()
			if not functions then return end
			if functions.script.hunter_crit[champion:getOrdinal()] > 0 then
				return functions.script.hunter_crit[champion:getOrdinal()]
			end
		end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 35 + (level-1) * 5)
			champion:addStatModifier("max_energy", 40 + (level-1) * 9)
			
			if not functions then return end
			if functions.script.hunter_crit[champion:getOrdinal()] > 0 then
				champion:addStatModifier("willpower", functions.script.hunter_crit[champion:getOrdinal()])
			end
		end	
	end,
}

defineTrait{
	name = "stalker",
	uiName = "Spell Thief",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 33,
	description = "A rogue-ish spell-caster specialist in covert attacks.",
	gameEffect = [[
	- Health 50 (+4 per level)
	- Energy 60 (+4 per level)
	- Evasion, Accuracy and Critical Chance +2 (+1 per level).
	- Energy Regeneration Rate -99%.
	
	Shadow Magicks: Neutral spells cost 33% less energy.
	- Neutral spells gain 1% damage per Dexterity (+10% per 7 points).
	- Once per day you may cast Invisibility for free. Gain more casts every 3 levels.
	
	Night Stalker: Gains a buff while invisible and for a few seconds after. Duration is 6 seconds (+4 per 3 levels).
	- Doubles all your class bonuses.]],
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			level = champion:getLevel() - 1
			return level + 2
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			level = champion:getLevel() - 1
			return level + 2
		end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 50 + (level - 1) * 4)
			champion:addStatModifier("max_energy", 60 + (level - 1) * 4)
			champion:addStatModifier("energy_regeneration_rate", -99)
			champion:addStatModifier("evasion", 2 + (level - 1))
			--champion:addTrait("shadow_magicks")
		end	
	end	
}

defineTrait{
	name = "tinkerer",
	uiName = "Tinkerer",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 34,
	description = "A technician capable of weaving magic into their tools through use of thaumaturgy.",
	gameEffect = [[
	- Health 70 (+5 per level)
	- Energy 40 (+5 per level)
	
	Craftsman Expertise: Apply extra bonus effects when you upgrade an item.
	- You gain one craft bonus usage per level.
	
	Elemental Surge: Fire and Shock damage is increased based on your Fire and Shock resistances.
	- Converts 50% of your Firearm damage to Fire.
	- Converts 50% of your Melee damage to Shock.]],
	-- todo: all the things
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 70 + (level-1) * 5)
			champion:addStatModifier("max_energy", 40 + (level-1) * 5)
			-- local upgItems = 0
			-- for i=1,ItemSlot.Bracers do
				-- local item = champion:getItem(i)
				-- if item and item:hasTrait("upgraded") then upgItems = upgItems + 1 end
			-- end
			-- champion:addStatModifier("strength", upgItems)
			-- champion:addStatModifier("dexterity", upgItems)
			-- champion:addStatModifier("vitality", upgItems)
			-- champion:addStatModifier("willpower", upgItems)
			champion:addStatModifier("protection", 2 + level)
			champion:addTrait("elemental_surge")
		end	
	end,
}

---------------------------------------------------------------------------------
-- Class traits
---------------------------------------------------------------------------------

defineTrait{
	name = "assassination",
	uiName = "Assassination",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 130,
	description = "You're looking for your target...",
	gameEffect = [[Kill an enemy from the back to complete the assassination.]],
	onRecomputeStats = function(champion, level)
	end,
}

defineTrait{
	name = "night_stalker",
	uiName = "Night Stalker",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 131,
	description = "You are stalking your prey",
	gameEffect = [[Evasion, Accuracy and Critical Chance +2 (+1 per level)]],
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			level = champion:getLevel() - 1
			return level + 2
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			level = champion:getLevel() - 1
			return level + 2
		end
	end,
	onRecomputeStats = function(champion, level)
		level = champion:getLevel()
		champion:addStatModifier("evasion", 2 + level - 1)
	end,
}

defineTrait{
	name = "blooddrop_cap",
	uiName = "Blooddrop Boon",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 132,
	description = "The Druid draws from the earth by carrying a Blooddrop Cap.",
	gameEffect = [[- Strength +1 per 2 levels.
	- Fire resistance +5 (+2 per level).
	- Fire damage increased by 20%.
	- Gain extra strength, action speed and accuracy when hit 
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
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 133,
	description = "Fire damage causes you to attack with burning strength.",
	gameEffect = [[- Strength +4, Melee Accuracy + 6, 
	- Action Cooldowns are 15% Faster.
	- Lasts 18 seconds.]],
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then return 0.85 end
	end,
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 and attackType == "melee" then return 6 end
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
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 134,
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
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 135,
	description = "Cold damage causes you to cast spells with a refreshed mind.",
	gameEffect = [[- Willpower +4, Ranged Accuracy + 6.
	- Action Cooldowns are 15% Faster.
	- Lasts 18 seconds.]],
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then return 0.85 end
	end,
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 and (attackType == "missile" or attackType == "thrown" or attackType == "firearm") then return 6 end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("willpower", 4)
		end
	end,
}

defineTrait{
	name = "mudwort",
	uiName = "Mudwort Boon",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 136,
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
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 137,
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
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 138,
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
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 140,
	description = "The Druid draws from the earth by carrying a Blackmoss.",
	gameEffect = [[- Doubles Bomb damage.
	- Bombs in your inventory multiply.]],
}

defineTrait{
	name = "crystal_flower",
	uiName = "Crystal Flower Boon",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 142,
	description = "The Druid draws from the earth by carrying a Crystal Flower.",
	gameEffect = [[- Protection +2 (+2 per level).
	- All resistances +2 per level.
	- Increases Health Regeneration by 25%.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("protection", 2 + (level * 2))
			champion:addStatModifier("resist_fire", level * 2)
			champion:addStatModifier("resist_poison", level * 2)
			champion:addStatModifier("resist_cold", level * 2)
			champion:addStatModifier("resist_shock", level * 2)
			champion:addStatModifier("health_regeneration_rate", 25)
		end	
	end,
}

defineTrait{
	name = "elemental_surge",
	uiName = "Elemental Surge",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 132,	
	description = "Fire and Shock damage is increased based on your Fire and Shock resistances.",
	gameEffect = [[- Firearm attacks have 50% of their damage converted to Fire.
	- Melee attacks have 50% of their damage converted to Shock.]],
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
					if item.go.equipmentitem:getResistPoison() then champion:addStatModifier("resist_poison", item.go.equipmentitem:getResistPoison()) end
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
					if item.go.equipmentitem:getResistPoison() then champion:addStatModifier("resist_poison", item.go.equipmentitem:getResistPoison()) end
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
					if item.go.equipmentitem:getResistPoison() then champion:addStatModifier("resist_poison", item.go.equipmentitem:getResistPoison()) end
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
					if item.go.equipmentitem:getResistPoison() then champion:addStatModifier("resist_poison", item.go.equipmentitem:getResistPoison()) end
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
					if item.go.equipmentitem:getResistPoison() then champion:addStatModifier("resist_poison", item.go.equipmentitem:getResistPoison()) end
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
	description = "Carrying Spell Scrolls give you +1% Increased Experience Gain per scroll, plus 1 Willpower for every 4 scrolls.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			-- count scrolls
			local scrolls = 0
			for i=1,ItemSlot.MaxSlots do
				local item = champion:getItem(i)
				if item then
					if item:hasTrait("spell_scroll") then
						scrolls = scrolls + 1
					else
						local container = item.go.containeritem
						if container then
							local capacity = container:getCapacity()
							for j=1,capacity do
								local item2 = container:getItem(j)
								if item2 and item2:hasTrait("spell_scroll") then
									scrolls = scrolls + 1
								end
							end
						end
					end
				end
			end
			champion:addStatModifier("exp_rate", scrolls)
			champion:addStatModifier("willpower", math.floor(scrolls/4))
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
	uiName = "Drown Your Sorrows",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 41,
	charGen = true,
	requiredRace = "human",
	description = [[When you activate this skill, you drink from a small flask, kept hidden under your vest.
	
	- Gain +5 Protection and recover all wounds over a period of 15 seconds.
	- Reduces Experience Gain by 15% for 1 day.]],
	onRecomputeStats = function(champion, level)
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
	description = [[Increases chances of finding meat when defeating beasts. 
	- Eating red meat increases your Strength by 4 and Health and Energy regeneration rate by 25% for 1 minute (+1 minute at levels 8 and 12).
	
	- You can't eat non-meat foods, like bread, bugs or even fish.	
	- Your food consumption rate is 15% higher.]],
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
	description = "All melee attacks deal an extra 1% damage per Strength point but you also take 0.5% more damage per point. Every 2 levels you gain +1 to Strength.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("strength", math.floor(level/2))
		end
	end,
}

defineTrait{
	name = "ancestral_charge",
	uiName = "Ancestral Charge",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 44,
	charGen = true,
	requiredRace = "minotaur",
	description = [[You can summon a warrior spirit to charge and stun an enemy. This is a neutral type, ultimate tier spell.
	- Costs 25 Energy to use and has a range of 6 tiles.
	- Base damage equal double your level plus your attack power.	
	- Hitting an enemy boosts your Heavy Armor and Block skills' base bonuses and perks by 50% for 20 seconds.]],
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
	description = "Increases physical damage by 4% for each point in Willpower.\nIncreases magic damage by 4% for each point in Strength.",
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
	name = "intensify_spell",
	uiName = "Intensify Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 50,
	charGen = true,
	requiredRace = "insectoid",
	description = [[After casting a spell, you can choose to empower it, so that the next time it is cast it does increased damage while costing more energy.
	
	- Damage +25% (+10% per 4 levels).
	- Energy cost +40% (-10% per 4 levels).	]],
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
	name = "sneak_attack",
	uiName = "Sneak Attack",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 52,
	charGen = true,
	requiredRace = "ratling",
	description = [[Activate your class ability to gain 100 Evasion, losing it upon performing an action.
	
	- Costs 15 Energy to use.
	- Your first physical attack will do 5% extra damage (+10% at levels 8 and 12), with a 50% chance to poison the target.]],
}

defineTrait{
	name = "built_resistance",
	uiName = "Built Resistance",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 53,
	charGen = true,
	requiredRace = "ratling",
	description = "Poison resistance +50%, other resistances -10%. You gain 1 Maximum Health for each extra point of poison resistance (goes past 100).",
	onRecomputeStats = function(champion, level)
		--if level > 0 then
			champion:addStatModifier("resist_poison", 50)
			champion:addStatModifier("resist_fire", -10)
			champion:addStatModifier("resist_cold", -10)
			champion:addStatModifier("resist_shock",-10)
			local health = math.max(champion:getCurrentStat("resist_poison") - 50, 0) + math.max((champion:getCurrentStat("vitality") - 10) * 2, 0)
			champion:addStatModifier("max_health", health)
			champion:addStatModifier("health", health)
		--end
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
	description = "Weight Limit +10kg.",
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
	description = "25% Resistance to feet and leg wounds. Wearing Heavy boots doubles that effect.",
	onReceiveCondition = function(champion, cond, level)
		if level > 0 then
			local bonus = 0.25
			local item = champion:getItem(6)
			if item and item:hasTrait("heavy_armor") then
				bonus = 0.5
			end
			
			if cond == ("leg_wound" or cond == "feet_wound") and math.random() <= bonus then
				return false
			end
		end
	end,
}

defineTrait{
	name = "refreshed",
	uiName = "Refreshed",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 67,
	description = "Healing potions heal 25% more, with extra healing applied instantly.",
}

-- Block
defineTrait{
	name = "block",
	uiName = "Block",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 69,
	description = "Gain 10% chance to block a physical attack with a shield.",
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
	description = "Gain +5 Evasion and +2 Dexterity if wearing light armor in all 5 slots",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local all_light = functions.script.wearingAll(champion, "light_armor", "clothes")
			if all_light then
				champion:addStatModifier("evasion", 5)
				champion:addStatModifier("dexterity", 2)
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
	description = "+5% Protection and +2 Strength.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			local all_heavy = functions.script.wearingAll(champion, "heavy_armor")
			if all_heavy then
				local multi = champion:hasTrait("armor_training") and 2 or 1
				if champion:hasCondition("ancestral_charge") then multi = multi + 0.5 end
				champion:addStatModifier("strength", math.floor(2 * multi))
				
				local bonusProt = 0
				local equip_slots = {3,4,5,6,9}
				for i, v in pairs(equip_slots) do
					if champion:getItem(v) then
						bonusProt = bonusProt + champion:getItem(v):getProtection()
					end
				end
				bonusProt = bonusProt * 0.1
				champion:addStatModifier("protection", math.ceil(bonusProt * multi))
			end
		end
	end,
}

defineTrait{
	name = "heavy_conditioning",
	uiName = "Heavy Conditioning",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 76,
	description = "+40 Health and +10% Protection.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			local all_heavy = functions.script.wearingAll(champion, "heavy_armor")
			if all_heavy then
				local multi = champion:hasTrait("armor_training") and 2 or 1
				if champion:hasCondition("ancestral_charge") then multi = multi + 0.5 end
				champion:addStatModifier("max_health", math.ceil(40 * multi))
				
				local bonusProt = 0
				local equip_slots = {3,4,5,6,9}
				for i, v in pairs(equip_slots) do
					if champion:getItem(v) then
						bonusProt = bonusProt + champion:getItem(v):getProtection()
					end
				end
				bonusProt = bonusProt * 0.1
				champion:addStatModifier("protection", math.ceil(bonusProt * multi))
			end
		end
	end,
}

defineTrait{
	name = "armor_training",
	uiName = "Armor Training",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 77,
	description = [[Bonuses are doubled and work even if your Helmet and Gloves are not heavy armor. Other armor in those slots gain an extra 25% protection.]],
}

-- Accuracy
defineTrait{
	name = "reach",
	uiName = "Reach",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 78,
	description = "You can use melee attacks from the backline.",
}

defineTrait{
	name = "clutch",
	uiName = "Clutch",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 79,
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
			functions.script.set_c("clutch", champion:getOrdinal(), 100 * hpRate)
			return 100 * hpRate
		end
	end,
}

defineTrait{
	name = "precision",
	uiName = "Precision",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 80,
	description = "25% Chance to pierce 5 to 15 armor with melee and firearm attacks.",
}

-- Critical
defineTrait{
	name = "backstab",
	uiName = "Backstab",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 81,
	description = "You do triple damage when you successfully backstab an enemy with a dagger.",
	-- hardcoded skill
}

defineTrait{
	name = "weapons_specialist",
	uiName = "Slayer",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 82,
	description = "You gain double critical chance from items.",
}

defineTrait{
	name = "assassin",
	uiName = "Assassin",
	icon = 83,
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

defineTrait{
	name = "silver_bullet",
	uiName = "Silver Bullet",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 85,
	description = "Every 6th shot does double damage.",
}

defineTrait{
	name = "fast_fingers",
	uiName = "Fast Fingers",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 86,
	description = "Reload time reduced by 15%. Silver Bullet triggers one shot sooner for every 20 Dexterity.",
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 and weapon ~= nil and weapon:hasTrait("firearm") then
			return 0.85
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
	icon = 90,
	description = "You deal 30% more melee damage from the backline and 30% more firearm damage from the frontline."
}

defineTrait{
	name = "freebooter",
	uiName = "Freebooter",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 91,
	description = "Cannon balls in your inventory weight 80% less.",
}

defineTrait{
	name = "broadside",
	uiName = "Broadside",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 92,
	description = "Pellets and cannon balls have a 40% chance to create shrapnel on impact, doing half damage to a 3-tile area behind the target.",
}

-- Alchemy
defineTrait{
	name = "green_thumb",
	uiName = "Green Thumb",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 93,
	description = "Herbs multiply while in your inventory. Spreading the herbs out or having multiple alchemists don't affect the multiplication.",
}

defineTrait{
	name = "bomb_multiplication",
	uiName = "Bomb Multiplication",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 94,
	description = "When throwing a bomb, there's a 10% chance you alchemically clone it on the spot.\n\n- Chance increases by 0.5% per Dexterity per point.",
}

defineTrait{
	name = "bomb_expert",
	uiName = "Bomb Expert",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 95,
	description = "When crafting bombs you get three bombs instead of one.",
}

-- Light Weapons
defineTrait{
	name = "dual_wield",
	uiName = "Dual Wield",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 96,
	description = "You can attack separately with Light Weapons in either hand. One of the weapons must be a dagger. Both weapons suffer a 40% penalty to the items' base damage when dual wielding.",
	-- hardcoded skill
}

defineTrait{
	name = "double_attack",
	uiName = "Double Attack",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 97,
	description = "You gain 25% chance to attack twice with Light Weapons.",
}

defineTrait{
	name = "improved_dual_wield",
	uiName = "Dextrous",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 98,
	description = "You can dual wield any two Light Weapons. Both weapons still suffer a 40% penalty to the items' base damage when dual wielding.",
	-- hardcoded skill
}

-- Heavy Weapons
defineTrait{
	name = "rend",
	uiName = "Rend",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 99,
	description = "Power attacks have a 30% chance to cause enemies to bleed.",
}

defineTrait{
	name = "power_grip",
	uiName = "Power Grip",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 100,
	description = "Heavy Weapon attacks gain 1% more damage per 5 points of health you have, plus 10% per 100 health.",
}

defineTrait{
	name = "two_handed_mastery",
	uiName = "Heavy Hander",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 101,
	description = "You can wield two-handed weapons in one hand.",
}

-- Spellblade
defineTrait{ -- to do
	name = "staff_fighter",
	uiName = "Staff Fighter",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 102,
	description = "You can hold a staff in one hand.",
}

defineTrait{
	name = "spell_slinger",
	uiName = "Spell Slinger",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 103,
	description = "Cast a basic spell to memorize it. You'll automatically cast this spell with melee attacks at 10% chance.",
}

defineTrait{
	name = "mage_spark_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 104,
	description = "You memorized the Mage Spark spell.",
}

defineTrait{
	name = "fireburst_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 105,
	description = "You memorized the Fireburst spell.",
}

defineTrait{
	name = "frost_burst_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 106,
	description = "You memorized the Frost Burst spell.",
}

defineTrait{
	name = "shock_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 107,
	description = "You memorized the Shock spell.",
}

defineTrait{
	name = "poison_cloud_memo",
	uiName = "Memorized Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 108,
	description = "You memorized the Poison Cloud spell.",
}

defineTrait{
	name = "arcane_warrior",
	uiName = "Arcane Warrior",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 109,
	description = "Non-ultimate level spells gain damage equal to 10% of your melee weapon damage and accuracy.",
}

defineTrait{
	name = "mage_strike",
	uiName = "Mage Strike",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 110,
	description = "Your spells gain double the critical chance from the Critical skill and a flat +6%.",
}

-- Elemental Magic
defineTrait{
	name = "aggregate",
	uiName = "Aggregate",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 111,
	description = "Hitting a monster with an element it resists will buff your next hit of that element by 20%.",
}

defineTrait{
	name = "elemental_exploitation",
	uiName = "Elemental Exploitation",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 112,
	description = "Deal 25% more damage if the enemy is vulnerable to that element.",
}

defineTrait{
	name = "elemental_armor",
	uiName = "Elemental Armor",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 113,
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
	icon = 114,
	description = "10% chance to poison enemies with melee, missile and throwing attacks.",
}
defineTrait{ -- to do
	name = "plague",
	uiName = "Plague",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 115,
	description = "Poison spreads between enemies. +5% Chance to poison.",
}

defineTrait{
	name = "antivenom",
	uiName = "Bane",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 116,
	description = "Enemies take increased damage from the poison status, an effect which also heals you.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("resist_poison", 35)
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
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 117,
	description = "Your Energy regeneration rate is increased by 25% while resting.",
}

defineTrait{ -- to do
	name = "imperium_arcana",
	uiName = "Imperium Arcana",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 118,
	description = "For every 100 Max Energy, neutral spells deal 30% more damage and others deal 15% more.",
}

defineTrait{
	name = "arcane_extraction",
	uiName = "Extraction",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 119,
	description = "Energy potions recover 25% more, while also regenerating 25 health. At the same time, healing potions recover 25 energy.",
}

-- Witchcraft
defineTrait{
	name = "ritual",
	uiName = "Ritual",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 120,
	description = "Heals the party for 10% of the damage done with spells.", -- (not dot)
}

defineTrait{ -- to do
	name = "moon_rites",
	uiName = "Moon Rites",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 121,
	description = "Energy regeneration rate increased by 50% during the night.",
}

defineTrait{ -- to do
	name = "voodoo",
	uiName = "Voodoo",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 122,
	description = "You can obtain voodoo dolls of monsters by slaying them.",
}

-- Tinkering
defineTrait{
	name = "tinkering",
	uiName = "Tinkering",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 123,
	description = "All upgrades require 1 Lockpick.",
	gameEffect = [[
	~ 1-Handed Weapons and Missile ~
	2 Common Metal
	
	~ 2-Handed Weapons ~
	3 All-Purpose Metal
	
	~ Firearms ~
	2 Explosive Core
	
	~ Light Armor ~
	2 Leather Strip
	
	~ Heavy Armor and Shields ~
	2 All-Purpose Metal ]],
}

defineTrait{
	name = "dismantler",
	uiName = "Dismantler",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 124,
	description = "You can dismantle items into extra lockpicks.",
	gameEffect = [[
	- Put 9 dismantle-able items into a container and right-click the container.
	- Dismantle-able items have a red hammer icon on them (when in the Tinkerer's inventory).]],
}

defineTrait{
	name = "pyrotechnician",
	uiName = "Pyrotechnician",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 125,
	description = "You can craft bombs and pellets.",
}

defineTrait{
	name = "multipurpose",
	uiName = "Multipurpose",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 126,
	description = "Unlock chests without a lockpick, at the cost of Energy.",
}

defineTrait{ -- to do
	name = "mastersmith",
	uiName = "Mastersmith",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 127,
	description = "You can upgrade Epic items.",
}

defineTrait{ 
	name = "bleeding",
	uiName = "Bleeding",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}