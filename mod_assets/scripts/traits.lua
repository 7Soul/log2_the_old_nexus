defineTrait{
	name = "assassin_class",
	uiName = "Assassin",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 26,
	description = "A contract killer who can pinpoint the weakness of their target.",
	gameEffect = [[
	- Health 44 (+4 per level)
	- Energy 30 (+7 per level)
	- Dual Wielding damage penalty reduced to 25% (normally 40%)
	
	Assassination: Powerful attacks (such as criticals) add a charge to your weapon, up to 4.
	- Gain +4% Physical Damage and +2 Crit per charge.
	- Back attacks spend charges to deal 5, 15, 25, 50% (based on charges) extra damage.
	
	Fleshbore: Ranged attacks and back attacks have a 1% chance (+1% per level) to cause bleeding.
	- You deal 20% extra damage to bleeding enemies.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel() - 1
			champion:addStatModifier("max_health", 44 + (level * 4))
			champion:addStatModifier("max_energy", 30 + (level * 7))
		end	
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then 
			local charges = functions.script.get_c("assassination", champion:getOrdinal()) or 0
			if charges then
				return charges * 2
			end
		end
	end,
}

defineTrait{
	name = "fighter",
	uiName = "Berserker",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 27,
	description = "A prideful warrior of the Red Hills. Berserkers are fueled by rage and prefer to keep their bodies unencumbered by armor.",
	gameEffect = [[
	- Health 80 (+5 per level)
	- Energy 20 (+5 per level)
	- Can't wear any Body Armor or Pants. 
	- Can't wear Heavy Armor.
	
	Berserker Frenzy: Gain Frenzy with each attack. At maximum Frenzy, gain a large Health Regen and Action Speed bonus.
	- You lose 5% Frenzy per second if you don't attack anything for 8 seconds.
		Every 25% Frenzy grants you:
		- Protection +1 (+1 per level).
		- Strength +1 (+1 per 4 levels).
	
	Red Hills Rage High: For every 5 combined points in Strength and Vitality you gain:
	- +2% Action Speed.
	- +5% Resistance to injuries.
	- +10 Health.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel() - 1
			local bonus = math.floor((champion:getCurrentStat("strength") + champion:getCurrentStat("vitality")) / 5)
			champion:addStatModifier("max_health", 80 + (level * 5) + (bonus * 10))
			champion:addStatModifier("max_energy", 20 + (level * 5) )
			champion:addStatModifier("cooldown_rate", bonus * 2)
		end
	end,
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			local bonus = math.floor((champion:getCurrentStat("strength") + champion:getCurrentStat("vitality")) / 5)
			return 1 - (0.02 * bonus)
		end
	end,
	-- wound resistance done in common trait
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
	
	Healing Aura: Damaging enemies charge a Health and Energy Regeneration buff for you and an ally to your side.
	- 1% Health and Energy recovered per second.
	- Duration is 12 seconds (+3 seconds per 4 levels).
	- Deal the killing blow for a bonus charge.
	
	Transcendence: You spend Focus when out of Energy.
	- The amount of Focus you have is equal to your Energy.
	- Loses 20% Damage and 100% Action Speed when using Focus.
	- Regain Focus with Healing Aura, eating food or resting.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel() - 1
			champion:addStatModifier("max_health", 70 + (level * 1))
			champion:addStatModifier("max_energy", 60 + (level * 1))
			local strength = champion:getBaseStat("strength")
			local dexterity = champion:getBaseStat("dexterity")
			local vitality = champion:getBaseStat("vitality")
			local willpower = champion:getBaseStat("willpower")
			if Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
				local str = functions.script.get_c("monkstrength", champion:getOrdinal()) and functions and functions.script.script.get_c("monkstrength", champion:getOrdinal()) or 0
				local dex = functions.script.get_c("monkdexterity", champion:getOrdinal()) and functions and functions.script.script.get_c("monkdexterity", champion:getOrdinal()) or 0
				local vit = functions.script.get_c("monkvitality", champion:getOrdinal()) and functions and functions.script.script.get_c("monkvitality", champion:getOrdinal()) or 0
				local wil = functions.script.get_c("monkwillpower", champion:getOrdinal()) and functions and functions.script.script.get_c("monkwillpower", champion:getOrdinal()) or 0
				champion:addStatModifier("strength", -strength + 9 + str + level)
				champion:addStatModifier("dexterity", -dexterity + 9 + dex + level)
				champion:addStatModifier("vitality", -vitality + 9 + vit + level)
				champion:addStatModifier("willpower", -willpower + 9 + wil + level)
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
	- You plunder items when attacking humanoid enemies and when you dig treasure.
	
	Pistolero: You can dual wield with a pistol, be it another pistol or a melee weapon. You attack with both in quick succession.
	- Your Action Speed becomes 40% slower (+1.5 per level).
	- You automatically use pellets from your inventory.
	
	Dirty Fighting: When using a melee attack, you have a 2% chance (+1% per level) of performing a secondary action with +20 Accuracy.
	- Haymaker: Has a chance to stun. Needs a free hand.
	- Pistol-whip: Does melee damage with your firearm.
	- Headbutt: May cause head injury.
	- Boot Knife: Pierces 5 armor.	
	(Chance is doubled when fighting a single foe.)]],
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			local item1 = champion:getItem(ItemSlot.Weapon)
			local item2 = champion:getItem(ItemSlot.OffHand)
			if ((item1 and item1.go.firearmattack) and (item2 and item2.go.firearmattack)) or ((item1 and item1.go.meleeattack) and (item2 and item2.go.firearmattack)) or ((item1 and item1.go.firearmattack) and (item2 and item2.go.meleeattack)) then
				level = champion:getLevel()
				return 1.4 - (level * 0.015)
			end
		end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			if party then
				if party.party:isCarrying("cursed_doubloon") then
					local coins = 0
					for i=1,ItemSlot.MaxSlots do
						local item = champion:getItem(i)
						if item then
							if item.go.name == "cursed_doubloon" then
								coins = coins + 1
							else
								local container = item.go.containeritem
								if container then
									local capacity = container:getCapacity()
									for j=1,capacity do
										local item2 = container:getItem(j)
										if item2 and item2.go.name == "cursed_doubloon" then
											coins = coins + 1
										end
									end
								end
							end
						end
					end
					local curse = { 5,10,15,20,24,28,29,31,32,33 }
					champion:addStatModifier("evasion", coins > 0 and curse[math.min(coins, 10)] * -1 or 0)
					champion:addStatModifier("health_regeneration_rate", coins > 0 and curse[math.min(coins, 10)] * -1 or 0)
					champion:addStatModifier("energy_regeneration_rate", coins > 0 and curse[math.min(coins, 10)] * -1 or 0)
				end
			end

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
	- 20% of your physical damage is converted to Poison.

	Nature Attunement: Weapons and armor made of wood, bone and leather grant you greater effects.
	- Weapons: +10% Action Speed (+1% per level).
	- Armor: +3% Energy and Health Regen (+0.5% per level).
	- (Basically excludes heavy armor and items made of metal)
	
	Herbologist: You can attach a herb to your Gloves, Bracers and Necklace, gaining its effects.
	
	- Blooddrop Cap: +2 Strength. Gain health by dealing poison damage.
	- Etherweed: +2 Willpower. Gain energy by dealing poison damage.
	- Mudwort: +2 Vitality. +15% Melee damage to poisoned foes. +15% Poison Resistance.
	- Falconskyre: +2 Dexterity. +8% Chance to poison with attacks.
	- Blackmoss: Gain +10% Poison damage. Conversion rate +10%.
	- Crystal Flower: Converts all spells to poison. Gain +4% Poison damage.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 50 + ((level-1) * 5))
			champion:addStatModifier("max_energy", 50 + (level-1) * 6)
			if Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script.script and functions and functions.script.script.getStepCount() > 0 then
				for slot = 8,10 do
					local druidItem = functions.script.get_c("druid_item"..slot, champion:getOrdinal()) or nil
					if druidItem then
						if druidItem == "blooddrop_cap" then
							champion:addStatModifier("strength", 2)
						elseif druidItem == "etherweed" then
							champion:addStatModifier("willpower", 2)
						elseif druidItem == "mudwort" then
							champion:addStatModifier("vitality", 2)
							champion:addStatModifier("resist_poison", 15)
						elseif druidItem == "falconskyre" then
							champion:addStatModifier("dexterity", 2)
						end
					end
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
	Converts 20% of your resistances to elemental damage.

	Spell Echo: Spells you cast have a 2% chance (+1% per level) to echo, being cast a second time at half the power.
	- Gain an extra 1% chance for every 50 points of Health and Energy.
	- All spells cost 10% extra energy.

	Trine Imperium: Casting a spell of one element boosts others by 25% while weakening itself by 5% for 9 seconds.
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
			local stacks = functions.script.get_c("hunter_crit", champion:getOrdinal()) or 0
			if stacks > 0 then
				return stacks
			end
		end
	end,
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 35 + (level-1) * 5)
			champion:addStatModifier("max_energy", 40 + (level-1) * 9)
			
			if functions and functions.script and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 then
				local stacks = functions.script.get_c("hunter_crit", champion:getOrdinal()) or 0
				if stacks > 0 then
					champion:addStatModifier("willpower", stacks)
				end
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
	- Once per day you may cast Invisibility for free. Gain more casts every 3 levels.
	
	- Energy Regeneration Rate -99%.
	
	Shadow Magicks: Neutral spells cost 33% less energy.
	- Neutral spells gain 1% damage per Dexterity (+10% per 7 points).
	- Evasion, Accuracy and Critical Chance +2 (+1 per level).
	
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
	
	Craftsman Expertise: Apply random extra bonus effects when you upgrade an item.
	- You gain one craft bonus usage per level. You can accumulate up to 3 uses at a time.
	
	Elemental Surge: Fire and Shock damage is increased based on your Fire and Shock resistances.
	- Converts 50% of your Firearm damage to Fire.
	- Converts 50% of your Melee damage to Shock.]],
	-- todo: all the things
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			champion:addStatModifier("max_health", 70 + (level-1) * 5)
			champion:addStatModifier("max_energy", 40 + (level-1) * 5)
		end	
	end,
}

---------------------------------------------------------------------------------
-- Class traits
---------------------------------------------------------------------------------

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
		level = champion:getLevel() - 1
		champion:addStatModifier("evasion", 2 + level)
	end,
}

defineTrait{
	name = "night_stalker2",
	uiName = "Night Stalker",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 131,
	description = "You are stalking your prey",
	gameEffect = [[Evasion, Accuracy and Critical Chance +4 (+2 per level)]],
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			level = champion:getLevel() - 1
			return (level * 2) + 4
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			level = champion:getLevel() - 1
			return (level * 2) + 4
		end
	end,
	onRecomputeStats = function(champion, level)
		level = champion:getLevel() - 1
		champion:addStatModifier("evasion", 4 + (level * 2))
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

defineTrait{
	name = "focus_cast",
	uiName = "",
	hidden = true,
	icon = 1,	
	description = "",
	gameEffect = [[]],
	onRecomputeStats = function(champion, level)
		level = champion:getLevel() - 1
		champion:addStatModifier("cooldown_rate", -100)
	end,
}


---------------------------------------------------------------------------------
-- Race traits
---------------------------------------------------------------------------------

defineTrait{
	name = "common",
	uiName = "Common",
	hidden = true,
	description = "",
	icon = 1,
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			local item = nil
			for i=1,2 do
				item = champion:getItem(i)
				if item and (item.go.firearmattack or item.go.meleeattack or item.go.throwattack or item.go.rangedattack) and item.go.equipmentitem then 
					if item.go.equipmentitem:getResistFire() then champion:addStatModifier("resist_fire", item.go.equipmentitem:getResistFire()) end
					if item.go.equipmentitem:getResistShock() then champion:addStatModifier("resist_shock", item.go.equipmentitem:getResistShock()) end
					if item.go.equipmentitem:getResistCold() then champion:addStatModifier("resist_cold", item.go.equipmentitem:getResistCold()) end
					if item.go.equipmentitem:getResistPoison() then champion:addStatModifier("resist_poison", item.go.equipmentitem:getResistPoison()) end
				end
			end

			local effects = functions.script.championItemExtraEffects(champion)
			for i,v in pairs(effects) do
				if not string.match(i, "multi") then
					champion:addStatModifier(i, v)
				end
			end
		end
	end,

	onReceiveCondition = function(champion, cond, level)
		if level > 0 and string.match(cond, "_wound$") then
			local chance = 0

			if champion:getClass() == "fighter" then
				local bonus = math.floor((champion:getCurrentStat("strength") + champion:getCurrentStat("vitality")) / 5) * 0.05
				chance = chance + bonus
			end
		
			if champion:getRace() == "insectoid" then
				chance = chance + 0.5
			end

			if math.random() <= chance then
				return false
			end
		end
	end,

	-- onComputeCooldown = function(champion, weapon, attack, attackType, level)
	-- 	if level > 0 then
			
	-- 		local c = champion:getOrdinal()
	-- 		local cooldown = 5
	-- 		if champion:getClass() == "monk" and champion:hasTrait("focus_cast") then
	-- 			local focus = functions.script.get_c("focus", c) or 0
	-- 			print("ok")
	-- 			cooldown = cooldown * 2
	-- 		end
	-- 		return cooldown
	-- 	end
	-- end,
	
}

defineTrait{
	name = "human",
	uiName = "Human",
	icon = 37,
	description = "As a human you belong to the most populous sentient race in the known world. You are very adaptable and can excel in all professions.\n - You gain experience points 10% faster.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("exp_rate", 10)
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
			champion:addStatModifier("food_rate", 25)
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
			champion:addStatModifier("resist_fire", 12)
			champion:addStatModifier("resist_cold", 12)
			champion:addStatModifier("resist_poison", 12)
			champion:addStatModifier("resist_shock", 12)
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
		end
	end,
	-- wound resistance done in common trait
}

defineTrait{
	name = "ratling",
	uiName = "Ratling",
	icon = 41,
	description = "As a ratling you may seem weak and disease ridden on the surface, but you are actually one of the most adaptable and hardy creatures in the world. You are a hoarder by nature and greatly enjoy fiddling with mechanical contraptions.\n- You are immune to diseases.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
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
	description = [[Carrying Spell Scrolls give you bonuses. For every 3 scrolls you gain a new additional effect.
	
	(3) +1 Willpower.
	(6) +5% Experience gain.
	(9) +10% Energy recovery from every source (+1% per extra scroll).
	(12) +2 Willpower.
	(15) +5% Chance to freeze, burn or poison with spells and attacks (+1% per extra scroll).
	(18) +3 Willpower.]],
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
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

			functions.script.set_c("lore_master", champion:getOrdinal(), scrolls)
			if scrolls == 9 then
				functions.script.set_c("lore_master_9", champion:getOrdinal(), 1.1 + ((scrolls - 9) * 0.01))
			else
				functions.script.set_c("lore_master_9", champion:getOrdinal(), 1)
			end
			if scrolls == 15 then
				functions.script.set_c("lore_master_15", champion:getOrdinal(), 0.05 + ((scrolls - 15) * 0.01))
			else
				functions.script.set_c("lore_master_15", champion:getOrdinal(), 0)
			end
			champion:addStatModifier("exp_rate", scrolls >= 6 and 5 or 0)
			champion:addStatModifier("energy_regeneration_rate", scrolls >= 9 and 10 + scrolls or 0)
			champion:addStatModifier("willpower", scrolls >= 3 and 1 or 0)
			champion:addStatModifier("willpower", scrolls >= 12 and 2 or 0)
			champion:addStatModifier("willpower", scrolls >= 18 and 3 or 0)
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
	description = [[Equipment that increases one stat will be divided into another stat, plus a bonus 10%.
	- Strength <-> Dexterity.
	- Vitality <-> Willpower.
	- Health <-> Energy.
	- Evasion <-> Protection.
	- Resistance <-> Damage Multiplier.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			-- local stats = { "strength", "dexterity", "vitality", "willpower" }
			-- local lowest = 1
			-- for i=1,4 do
			-- 	if champion:getCurrentStat(stats[i]) <= champion:getCurrentStat(stats[lowest]) then
			-- 		lowest = i
			-- 	end
			-- end
			-- champion:addStatModifier(stats[lowest], 2)
			-- stats = { "resist_fire", "resist_cold", "resist_shock", "resist_poison" }
			-- lowest = 1
			-- for i=1,4 do
			-- 	if champion:getCurrentStat(stats[i]) <= champion:getCurrentStat(stats[lowest]) then
			-- 		lowest = i
			-- 	end
			-- end
			-- champion:addStatModifier(stats[lowest], 25)
			-- champion:addStatModifier("exp_rate", -5)
			
			-- local hp = champion:getCurrentStat("max_health")
			-- local en = champion:getCurrentStat("max_energy")
			-- if hp > en then
			-- 	champion:addStatModifier("max_energy", math.floor((hp - en) / 4))
			-- elseif en < hp then
			-- 	champion:addStatModifier("max_health", math.floor((en - hp) / 4))
			-- else
			-- 	champion:addStatModifier("max_health", math.floor(en / 8))
			-- 	champion:addStatModifier("max_energy", math.floor(hp / 8))
			-- end

			if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
				local stats = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
				local replace = { 2, 1, 4, 3, 6, 5, 8, 7 }
				local names = { "strength", "dexterity", "vitality", "willpower", "max_health", "max_energy", "protection", "evasion", "resist_fire", "resist_cold", "resist_shock", "resist_poison" }

				for i=ItemSlot.Weapon, ItemSlot.Bracers do
					local item = champion:getItem(i)
					if item then 
						local isHandItem = functions.script.isHandItem(item, i)
						if item.go.equipmentitem and isHandItem then
							stats[1] = stats[1] + ((item.go.equipmentitem:getStrength() or 0) / 2)
							stats[2] = stats[2] + ((item.go.equipmentitem:getDexterity() or 0) / 2)
							stats[3] = stats[3] + ((item.go.equipmentitem:getVitality() or 0) / 2)
							stats[4] = stats[4] + ((item.go.equipmentitem:getWillpower() or 0) / 2)
							stats[5] = stats[5] + ((item.go.equipmentitem:getHealth() or 0) / 2)
							stats[6] = stats[6] + ((item.go.equipmentitem:getEnergy() or 0) / 2)
							stats[7] = stats[7] + ((item.go.equipmentitem:getProtection() or 0) / 2)
							stats[8] = stats[8] + ((item.go.equipmentitem:getEvasion() or 0) / 2)
							stats[9] = stats[9] + ((item.go.equipmentitem:getResistFire() or 0) / 2)
							stats[10] = stats[10] + ((item.go.equipmentitem:getResistCold() or 0) / 2)
							stats[11] = stats[11] + ((item.go.equipmentitem:getResistShock() or 0) / 2)
							stats[12] = stats[12] + ((item.go.equipmentitem:getResistPoison() or 0) / 2)
						end
					end
				end

				for i=1, #stats do
					if i < 9 then -- replacing resists for damage takes place elsewhere
						champion:addStatModifier( names[i], math.floor( stats[ replace[i] ]  * 1.1 ) )
					end
					champion:addStatModifier( names[i], math.floor( stats[i] ) * -1 )
				end

			
				champion:addStatModifier("resist_fire", math.floor(100 * functions.script.getEquippedMultiBonus(champion, "fire", false) ) )
				champion:addStatModifier("resist_cold", math.floor(100 * functions.script.getEquippedMultiBonus(champion, "cold", false) ) )
				champion:addStatModifier("resist_shock", math.floor(100 * functions.script.getEquippedMultiBonus(champion, "shock", false) ) )
				champion:addStatModifier("resist_poison", math.floor(100 * functions.script.getEquippedMultiBonus(champion, "poison", false) ) )
			end
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
	
	- Gain +5 Protection, +50% Action Speed and recover all wounds over a period of 15 seconds.
	- Reduces Experience Gain by 15% for 1 day.]],
}

defineTrait{
	name = "drown_sorrows_exp",
	uiName = "Exp Penalty",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 41,
	description = "-15% Experience gain. Lasts a day.",
}

defineTrait{
	name = "carnivorous",
	uiName = "Carnivorous",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 42,
	charGen = true,
	requiredRace = "minotaur",
	description = [[Increases chances of finding meat when defeating beasts. 
	- Gain Health Regeneration equal to your Vitality.
	- Gain a point in Strength or Vitality randomly when you eat meat.
	
	- You can't eat non-meat foods, like bread, bugs or even fish.]],
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			champion:addStatModifier("health_regeneration_rate", champion:getCurrentStat("vitality"))

			local meatBonus = functions.script.get_c("meat_bonus", champion:getOrdinal()) or 0
			local strBonus = math.floor(meatBonus / 2)
			local vitBonus = math.ceil(meatBonus / 2)
			champion:addStatModifier("strength", strBonus)
			champion:addStatModifier("vitality", vitBonus)
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
	description = [[Lizardfolk can easily adapt for the hottest days or coldest nights.

	Resist All +8%, plus:
	- During the day, gain +15% Fire Resist.
	- During the night, gain +15% Cold Resist.

	For any Elemental Resist that reaches 100:
	- Gain +30% to that element multiplier.
	- Gain +2 to all stats.]],
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			local curTime = GameMode.getTimeOfDay()
			if curTime > 0 and curTime < 1.01 then
				champion:addStatModifier("resist_fire", 15)
			else
				champion:addStatModifier("resist_cold", 15)
			end
			champion:addStatModifier("resist_fire", 8)
			champion:addStatModifier("resist_cold", 8)
			champion:addStatModifier("resist_shock", 8)
			champion:addStatModifier("resist_poison", 8)
			
			local fire = champion:getCurrentStat("resist_fire")
			local cold = champion:getCurrentStat("resist_cold")
			local shock = champion:getCurrentStat("resist_shock")
			local bonus = iff(fire >= 100, 2, 0) + iff(cold >= 100, 2, 0) + iff(shock >= 100, 2, 0)

			champion:addStatModifier("strength", bonus)
			champion:addStatModifier("willpower", bonus)
			champion:addStatModifier("dexterity", bonus)
			champion:addStatModifier("vitality", bonus)			
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
	description = "You can see attacks coming from all directions, warning your companions of danger.\n\nFor each monster next to you, you gain +10 Evasion, +5 Accuracy and +3% Critical. Your party gains smaller bonuses too.",
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			local stat = functions.script.get_c("wide_vision", champion:getOrdinal())
			if not stat or not party then return end
			champion:addStatModifier("evasion", stat * 10)
			for i=1,4 do
				local c = party.party:getChampionByOrdinal(i)
				if c ~= champion then
					c:addTrait("wide_vision_minor")
				end
			end
		end
	end,
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			local stat = functions.script.get_c("wide_vision", champion:getOrdinal())
			if not stat then return end
			return stat * 5
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			local stat = functions.script.get_c("wide_vision", champion:getOrdinal())
			if not stat then return end
			return stat * 3
		end
	end,
}

defineTrait{
	name = "wide_vision_minor",
	uiName = "Wide Vision (Minor)",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 46,
	description = "A companion Lizardman is warning you of danger. You gain +2 Evasion, +2 Accuracy and +1% Critical for each monster next to you.",
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			for i=1,4 do
				local c = party.party:getChampionByOrdinal(i)
				if c:hasTrait("wide_vision") then
					local stat = functions.script.get_c("wide_vision", c:getOrdinal())
					if not stat then return end
					champion:addStatModifier("evasion", stat * 2)
				end
			end
		end
	end,
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			for i=1,4 do
				local c = party.party:getChampionByOrdinal(i)
				if c:hasTrait("wide_vision") then
					local stat = functions.script.get_c("wide_vision", c:getOrdinal())
					if not stat then return end
					return stat * 2
				end
			end
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			for i=1,4 do
				local c = party.party:getChampionByOrdinal(i)
				if c:hasTrait("wide_vision") then
					local stat = functions.script.get_c("wide_vision", c:getOrdinal())
					if not stat then return end
					return stat * 1
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
	name = "body_and_mind",
	uiName = "Body and Mind",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 48,
	charGen = true,
	requiredRace = "insectoid",
	description = "Increases physical and magical damage by 4% for each point in Vitality (has diminishing returns).\n\nGain +1 Vitality per 50 Energy.\nStarts with -10 Health and -10 Energy.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local addVit = math.floor(champion:getCurrentStat("max_energy") / 50)
			champion:addStatModifier("vitality", addVit)
			champion:addStatModifier("max_health", -10)
			champion:addStatModifier("max_energy", -10)
		end
	end,
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

			local food = (champion:getFood()-500) / 500
			champion:addStatModifier("cooldown_rate", 0.15 * food)
		end
	end,
	-- onComputeCooldown = function(champion, weapon, attack, attackType, level)
	-- 	if level > 0 then 
	-- 		local food = (champion:getFood()-500) / 500
	-- 		return 1 - (0.15 * food)
	-- 	end
	-- end,
}

defineTrait{
	name = "intensify_spell",
	uiName = "Intensify Spell",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 50,
	charGen = true,
	requiredRace = "insectoid",
	description = [[After casting a spell, you can choose to empower the next cast of it, increasing power at the cost of energy and health.
	
	- Damage +50%, Energy cost +20%.
	- Spend Health equal to half of the total Energy cost.]],
}

defineTrait{
	name = "rodent",
	uiName = "Rodent",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 51,
	charGen = true,
	requiredRace = "ratling",
	description = [[You can chew herbs (but not Crystal Flowers and Blackmoss), reducing spell costs and cooldowns by 10% for 3 minutes.
	
	When you are done chewing, you produce a Fermented Fiber Ball, which increases herb multiplication rate and can be used to heal diseases and poisoning.
	The Fiber Ball dries out and loses its properties after a certain number of steps, which is higher based on your level.]],
}


defineTrait{
	name = "rodent_chewing",
	uiName = "Chewing (Rodent)",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 51,
	description = [[Spell costs and cooldowns reduced by 10%.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("cooldown_rate", 10)
		end
	end,
}

defineTrait{
	name = "sneak_attack",
	uiName = "Sneak Attack",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 52,
	charGen = true,
	requiredRace = "ratling",
	description = [[Activate your class ability to blend into the shadows and prepare a deadly attack.
	
	- Costs 15 Energy to use.
	- Gain 100 Evasion and 15% Critical Chance.
	- Your first physical attack has a 50% chance to poison the target.]],
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 1 and functions and functions.script then
			if functions.script.get_c("sneak_attack", champion:getOrdinal()) then
				return 15
			end
		end
	end,
}

defineTrait{
	name = "built_resistance",
	uiName = "Built Resistance",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 53,
	charGen = true,
	requiredRace = "ratling",
	description = "Poison resistance +50%, other resistances -15%. You gain 1 Maximum Health and 0.15kg Carry Limit for each extra point of poison resistance (even if you get more than 100%).",
	onRecomputeStats = function(champion, level)
		-- if level > 0 then
			champion:addStatModifier("resist_poison", 50)
			champion:addStatModifier("resist_fire", -15)
			champion:addStatModifier("resist_cold", -15)
			champion:addStatModifier("resist_shock",-15)
			local health = math.max(champion:getCurrentStat("resist_poison") - 50, 0) + math.max((champion:getCurrentStat("vitality") - 10) * 2, 0)
			champion:addStatModifier("max_health", health)
			champion:addStatModifier("health", health)
			champion:addStatModifier("max_load", health * 0.15)
		-- end
	end,
}

---------------------------------------------------------------------------------
-- Skill traits
---------------------------------------------------------------------------------

-- Athletics
-- defineTrait{
-- 	name = "pack_mule",
-- 	uiName = "Pack Mule",
-- 	iconAtlas = "mod_assets/textures/gui/skills.dds",
-- 	icon = 65,
-- 	description = "Weight Limit +10kg.",
-- 	onRecomputeStats = function(champion, level)
-- 		if level > 0 then
-- 			champion:addStatModifier("max_load", 10)
-- 		end
-- 	end,
-- }

-- defineTrait{
-- 	name = "endurance",
-- 	uiName = "Endurance",
-- 	iconAtlas = "mod_assets/textures/gui/skills.dds",
-- 	icon = 66,
-- 	description = "25% Resistance to wounds. Wearing Heavy Armor triples the resistance for that body part.\n(Gloves protect from hand injuries).",
-- 	onReceiveCondition = function(champion, cond, level)
-- 		if level > 0 then
-- 			local slots = {3,4,5,6,9,9}
-- 			local injuries = {"head_wound","chest_wound","leg_wound","feet_wound","left_hand_wound","right_hand_wound"}
-- 			for index, slot in ipairs(slots) do
-- 				local bonus = 0.25
-- 				local item = champion:getItem(slot)
-- 				if item and item:hasTrait("heavy_armor") then
-- 					bonus = bonus * 3
-- 				end
				
-- 				if cond == injuries[index] and math.random() <= bonus then
-- 					return false
-- 				end
-- 			end
-- 		end
-- 	end,
-- }

-- defineTrait{
-- 	name = "refreshed",
-- 	uiName = "Refreshed",
-- 	iconAtlas = "mod_assets/textures/gui/skills.dds",
-- 	icon = 67,
-- 	description = "Healing potions heal 25% more, with extra healing applied instantly.",
-- }

-- Block
defineTrait{
	name = "block",
	uiName = "Block",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 69,
	description = "Gain 8% chance to block a physical attack with a shield, reducing the damage by 50%.",
}

defineTrait{
	name = "shield_bash",
	uiName = "Shield Bash",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 71,
	description = "When blocking, you bash your attacker, doing damage based on the damage received and on your Protection amount.",
}

defineTrait{
	name = "shield_bearer",
	uiName = "Shield Bearer",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 70,
	description = "After a block, gain +15% Action Speed and 50% Faster Buildup Time for special attacks for 20 seconds.",
	onComputeCooldown = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			if champion:hasCondition("shield_bearer") then
				return 0.85
			end
		end
	end,
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
	description = "The first attack from an enemy is absorbed as Health and Energy over 5 seconds if wearing all light armor.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local all_light = functions.script.wearingAll(champion, "light_armor", "clothes")
			if all_light then
				-- champion:addStatModifier("resist_fire", 20)
				-- champion:addStatModifier("resist_cold", 20)
				-- champion:addStatModifier("resist_shock", 20)
				-- champion:addStatModifier("resist_poison", 20)
			end
		end
	end,
}

defineTrait{
	name = "rush",
	uiName = "Rush",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 74,
	description = "Gain +12% Action Speed and -24% Special Attack Cost if wearing all light armor.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local all_light = functions.script.wearingAll(champion, "light_armor", "clothes")
			if all_light then
			functions.script.changeSecondary(champion, 0.76, "energycost")
				champion:addStatModifier("cooldown_rate", 12)
			end	
			
		end
	end,
	-- onComputeCooldown = function(champion, weapon, attack, attackType, level)
	-- 	if level > 0 then
	-- 		local all_light = functions.script.wearingAll(champion, "light_armor", "clothes")
	-- 		if all_light then
	-- 			return 0.88
	-- 		end	
	-- 	end
	-- end,
}

-- Heavy Armor
defineTrait{
	name = "armored_up",
	uiName = "Armored Up",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 75, 
	description = "+5 Protection and +2 Strength if wearing all heavy armor. Doubled when this skill is maxed",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			local all_heavy = functions.script.wearingAll(champion, "heavy_armor")
			if all_heavy then
				local multi = champion:hasTrait("armor_training") and 2 or 1
				if champion:hasCondition("ancestral_charge") then multi = multi * 1.5 end
				champion:addStatModifier("strength", math.floor(2 * multi))
				champion:addStatModifier("protection", math.ceil(2 * multi))
			end
		end
	end,
}

defineTrait{
	name = "conditioning",
	uiName = "Conditioning",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 76,
	description = "Chance to increase your Health Regeneration and Protection when you take damage.",
}

defineTrait{
	name = "armor_training",
	uiName = "Armor Training",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 77,
	description = [[Sets and Heavy Armor perks work even without Helmet and Gloves. Other armor types in those slots gain an extra 20% protection.]],
	onRecomputeStats = function(champion, level)
		if level > 0 then
			level = champion:getLevel()
			local multi = champion:hasTrait("armor_training") and 2 or 1
			if champion:hasCondition("ancestral_charge") then multi = multi * 1.5 end
			local all_heavy = functions.script.wearingAll(champion, "heavy_armor")
			if all_heavy then				
				local bonusProt = 0
				local equip_slots = {3,9}
				for i, v in pairs(equip_slots) do
					if champion:getItem(v) and champion:getItem(v).go.equipmentitem and champion:getItem(v).go.equipmentitem:getProtection() then
						bonusProt = bonusProt + champion:getItem(v).go.equipmentitem:getProtection()
					end
				end
				bonusProt = bonusProt * 0.2 * multi
				champion:addStatModifier("protection", math.ceil(bonusProt))
			end
		end
	end,
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
	description = "Gain up to +10 Dexterity and +50 Accuracy based on how much health the party is missing.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local hpMaxTotal = 0
			local hpTotal = 0
			for i=1,4 do
				local champ = party.party:getChampionByOrdinal(i)
				hpMaxTotal = hpMaxTotal + champ:getMaxHealth()
				hpTotal = hpTotal + champ:getHealth()
			end
			local hpRate = 1 - (hpTotal / hpMaxTotal)
			champion:addStatModifier("dexterity", math.ceil(10 * hpRate))
		end
	end,
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
			functions.script.set_c("clutch", champion:getOrdinal(), 50 * hpRate)
			return math.ceil(50 * hpRate)
		end
	end,
}

defineTrait{
	name = "deadly_aim",
	uiName = "Deadly Aim",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 80,
	description = "Converts 10% of your accuracy into Critical and Physical Damage.",
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			local acc = math.ceil(functions.script.getAccuracy(champion) * 0.1)
			functions.script.set_c("deadly_aim", champion:getOrdinal(), acc)
			raturn (acc * -1)
		end
	end,
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
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			local crit = 0
			for slot = ItemSlot.Weapon, ItemSlot.Bracers do
				local item = champion:getItem(slot)
				if item and item.go.equipmentitem and item.go.equipmentitem:getCriticalChance() then
					crit = crit + item.go.equipmentitem:getCriticalChance()
				end
			end
			return crit	
		end
	end,
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

-- Missile Weapons
defineTrait{
	name = "bullseye",
	uiName = "Bullseye",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 87,
	description = "Gain +15 accuracy and +3% Critical Chance with missile attacks.",
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			if attackType == "missile" or attackType == "throw" then
				return 15
			end
		end
	end,
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			if attackType == "missile" or attackType == "throw" then
				return 3
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
	description = "You attack twice when using Missile Weapons.",
}

-- Throwing Weapons
defineTrait{
	name = "telekinesis",
	uiName = "Telekinesis",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 132,
	description = "Every 3 throws, the weapon will either be dropped or return to your hand, causing it to do damage again.\nThe chance of it returning is 20% plus 20% per 10 Willpower.",
}

defineTrait{
	name = "twist_and_turn",
	uiName = "Twist and Turn",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 133,
	description = "7% chance to cause bleeding when a weapon lodges into the target.",
}

defineTrait{
	name = "ghost_weapon",
	uiName = "Ghost Weapon",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 134,
	description = "Every other attack, you throw a ghostly version of a weapon you own. It spins around your current position 3 times, dealing 1/4 its damage.",
}

-- Seafaring
defineTrait{
	name = "sea_dog",
	uiName = "Sea Dog",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 90,
	description = "Gain 25% more melee damage from the backline and 25% more ranged and firearm damage from the frontline."
}

defineTrait{
	name = "freebooter",
	uiName = "Freebooter",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 91,
	description = "Ammo in your inventory weights 60% less.",
}

defineTrait{
	name = "broadside",
	uiName = "Broadside",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 92,
	description = "Shots have a 40% chance to create shrapnel on impact, doing half damage to a 3-tile area behind the target.",
}

defineTrait{
	name = "lucky_blow",
	uiName = "Lucky Blow",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 68,
	description = "Every 3rd attack gains +50% Crit and attack power equal to 1/5 of your Dexterity.",
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		if level > 0 then 
			local count = functions.script.get_c("lucky_blow", champion:getOrdinal()) or -1
			local trigger = 3

			if count % trigger == 0 then
				return 50
			end
		end
	end
}
-- every Xth attack with a firearm or sword has +50% critical chance and spends 5 energy
-- Alchemy
defineTrait{
	name = "green_thumb",
	uiName = "Green Thumb",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 93,
	description = "Herbs multiply while in your inventory. Spreading the herbs out or having multiple alchemists don't affect the multiplication.",
}

defineTrait{
	name = "perfect_mix",
	uiName = "Perfect Mix",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 67,
	description = "Potions you mix last 25% longer. Healing and Energy potions give +20 Protection for their duration.",
}

defineTrait{
	name = "bomb_multiplication",
	uiName = "Bomb Multiplication",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 94,
	description = "You may alchemically clone a bomb you throw, at 10% chance plus 6% per 10 Willpower.",
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
	name = "improved_dual_wield",
	uiName = "Double Attack",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 98,
	description = "You gain 20% chance to attack twice with Light Weapons.\nYou can dual wield any Light Weapons.",
}

defineTrait{
	name = "thunder_fury",
	uiName = "Thunder Fury",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 97,
	description = "Chance to deal 50% of your weapon damage as Shock damage equal to your critical chance.",
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
	description = "You can wield a staff in one hand.",
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
	description = "+25% Resist Fire, Shock and Cold. You regain 15% of you maximum energy when hit by one of those elements.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("resist_fire", 25)
			champion:addStatModifier("resist_cold", 25)
			champion:addStatModifier("resist_shock", 25)
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
}

-- Magic Training
defineTrait{
	name = "meditation",
	uiName = "Meditation",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 117,
	description = "+5 Protection. You regain 1% to 5% of you energy when taking damage.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("protection", 5)
		end
	end,
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
	description = "Energy potions recover 25% more, while also regenerating 25 health. Healing potions also recover 25 energy.\nAllies benefit from this at 1/3 the power.",
}

-- Witchcraft
defineTrait{
	name = "ritual",
	uiName = "Ritual",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 120,
	description = "Heals the party for 5% of the damage done with spells. You heal for twice as much.", -- (not dot)
}

defineTrait{
	name = "moon_rites",
	uiName = "Moon Rites",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 121,
	description = "During the night, your Energy regeneration rate is increased by 50% and your spell damage by 10%.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			if GameMode.getTimeOfDay() > 1.01 then
				champion:addStatModifier("energy_regeneration_rate", 50)
			end
		end
	end,
}

defineTrait{
	name = "voodoo",
	uiName = "Voodoo",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 122,
	description = "Hitting one enemy with a spell also damages and bleeds* a random nearby enemy in a range of 2 tiles.",
}

-- Tinkering
defineTrait{
	name = "tinkering",
	uiName = "Tinkering",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 123,
	description = "All upgrades require 1 Lockpick.",
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
	description = "+5 Fire and Shock resistance per upgraded item you have equipped.",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			local upgItems = 0
			for i=1,ItemSlot.Bracers do
				local item = champion:getItem(i)
				if item and item:hasTrait("upgraded") then upgItems = upgItems + 1 end
			end
			champion:addStatModifier("resist_fire", upgItems * 5)
			champion:addStatModifier("resist_shock", upgItems * 5)
		end
	end,
}

defineTrait{
	name = "multipurpose",
	uiName = "Multipurpose",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 126,
	description = "Unlock chests without a lockpick, at the cost of Energy. You gain +1 to a random stat when you do it.",
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

-- item traits

defineTrait{
	name = "crystal_health",
	uiName = "Crystal Set Health",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 0,
	hidden = true,
	description = "",
	onRecomputeStats = function(champion, level)
		if level > 0 then
			
		end
	end,
}

-- Dummy traits

defineTrait{ 
	name = "athletics",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "dodge",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "aggressive",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "head_hunter",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "mutation",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "tough",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "fire_magic",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "aura",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "strong_mind",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}

defineTrait{ 
	name = "agile",
	uiName = "",
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	hidden = true,
	description = "",
}
