defineSkill{
	name = "athletics",
	uiName = "Athletics",
	priority = 10,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 0,
	description = [[Health +20 and Weight Limit +1kg per point. 

	Perks:
	- Level 2 | Weight Limit +10kg.
	- Level 4 | 25% Resistance to wounds. Heavy Armor triples it for the body part it covers (Gloves protect from hand injuries).
	- Level 5 | Healing potions heal 25% more, with extra healing applied instantly. While you heal, gain +60 Protection.]],
	traits = { [2] = "pack_mule", [4] = "endurance", [5] = "refreshed" },
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("max_health", level * 20)
			champion:addStatModifier("max_load", level)
		end
	end	
}

defineSkill{
	name = "block",
	uiName = "Block",
	priority = 20,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 1,
	description = [[Protection and Block Chance +2 per point.
		
	Perks (when holding a shield):
	- Level 2 | 8% chance to block an attack.
	- Level 4 | When blocking, you bash your attacker, doing damage based on your Protection.
	- Level 5 | After a block, gain +15% Action Speed and 50% Faster Buildup Time for special attacks for 20 seconds.]],
	traits = { [2] = "block", [4] = "shield_bash", [5] = "shield_bearer" },
	onRecomputeStats = function(champion, level)
		local skillLevel = champion:getSkillLevel("block")
		if champion:hasCondition("ancestral_charge") then skillLevel = skillLevel * 1.5 end
		champion:addStatModifier("protection", 2 * math.floor(skillLevel))
	end,
}

defineSkill{
	name = "light_armor",
	uiName = "Light Armor",
	priority = 30,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 2,
	description = [[Each point reduces the evasion penalties from wearing Light Armor by 20%.
	
	Perks (when wearing light armor in all 5 slots):
	- Light Wear | +5 Evasion and +2 Dexterity.
	- Reflective | The first attack from an enemy is absorbed as Health and Energy over 5 seconds.
	- Rush       | Gain +12% Action Speed and -24% Special Attack Cost.]],
	traits = { [2] = "light_wear", [4] = "reflective", [5] = "rush" },
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 2 and functions and functions.script then
			local equip_slots = {3,4,5,6,9}
			for i, v in pairs(equip_slots) do
				if champion:getItem(v) and champion:getItem(v):hasTrait("light_armor") then
					champion:addStatModifier("evasion", champion:getSkillLevel("light_armor"))
					champion:addStatModifier("protection", champion:getItem(v).go.equipmentitem:getProtection() * 0.05 * champion:getSkillLevel("light_armor"))
				end
			end	
		end
	end,
}

defineSkill{
	name = "heavy_armor",
	uiName = "Heavy Armor",
	priority = 40,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 3,
	description = [[Each point reduces the evasion penalties from wearing Heavy Armor by 20% and weight by 10%.
	
	Perks when wearing heavy armor in all 5 slots:
	- Armored Up     | +5 Protection and +2 Strength. Doubled when this skill is maxed.
	- Conditioning   | +40 Health and +6% Protection. Doubled when this skill is maxed.
	- Armor Training | Sets and Heavy Armor perks work even without Helmet and Gloves. Other armor types in those slots gain an extra 20% protection.]],
	traits = { [2] = "armored_up", [4] = "heavy_conditioning", [5]="armor_training" },
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 2 and functions and functions.script then
			local equip_slots = {3,4,5,6,9}
			for i, v in pairs(equip_slots) do
				if champion:getItem(v) and champion:getItem(v):hasTrait("heavy_armor") then
					champion:addStatModifier("evasion", champion:getSkillLevel("heavy_armor") * 2)
					--champion:addStatModifier("protection", champion:getItem(v).go.equipmentitem:getProtection() * 0.05 * champion:getSkillLevel("heavy_armor"))
				elseif champion:getItem(v) and champion:hasTrait("armor_training") and (champion:getItem(v):hasTrait("light_armor") or champion:getItem(v):hasTrait("clothes")) then
					champion:addStatModifier("evasion", champion:getSkillLevel("heavy_armor") * 2)
				end
			end
		end
	end,
}

defineSkill{
	name = "accuracy",
	uiName = "Accuracy",
	priority = 50,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 4,
	description = [[Increases your Accuracy by 10 for each skill point.
	
	Perks:
	- Reach | You can perform melee attacks from the back row.
	- Clutch | Gain up to +10 Dexterity and +50 Accuracy based on how much health the party is missing.
	- Deadly Aim | Melee and Firearm attacks pierce 5 to 15 armor, while Ranged attacks deal 5 to 20 extra damage.]],
	traits = { [1] = "reach",  [4] = "clutch", [5] = "precision" },
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			return level * 10
		end
	end,
}

defineSkill{
	name = "critical",
	uiName = "Critical",
	priority = 60,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 5,
	description = [[Increases critical chance with physical attacks by 3% and spells by 1% for each skill point.
	
	Perks:
	- Level 2 | You can backstab an enemy with a dagger and deal triple damage.
	- Level 4 | You gain double critical chance from items.
	- Level 5 | You can backstab with any Light Weapon.]],
	traits = { [2] = "backstab", [4] = "weapons_specialist", [5] = "assassin" },
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		return level * 3
	end,
}

defineSkill{
	name = "firearms",
	uiName = "Firearms",
	priority = 70,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 6,
	description = [[Each point increases range by 1 and reduces the chance of grazing a shot by 5%.
	
	Perks:
	- Metal Slug | 7% chance to not spend a pellet to fire.
	- Silver Bullet | Every 6th shot does double damage.
	- Fast Fingers | Reload time reduced by 15%. Silver Bullet triggers one shot sooner for every 20 Dexterity.]],
	traits = { [3] = "metal_slug", [4] = "silver_bullet", [5] = "fast_fingers" },
}

defineSkill{
	name = "seafaring",
	uiName = "Seafaring",
	priority = 80,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 7,
	description = [[Each point increases evasion by 3 when fighting multiple foes.
	
	Perks:
	- Sea Dog | Gain 25% more melee damage from the backline and 25% more ranged and firearm damage from the frontline.
	- Freebooter | Ammo in your inventory weight 60% less.
	- Broadside | Shots have a 40% chance to create shrapnel on impact, doing half damage to a 3-tile area behind the target.
	- Lucky Blow | Every 3rd attack gains +50% Crit and attack power equal to 1/5 of your Dexterity.]],
	traits = { [2] = "sea_dog", [3] = "freebooter", [4] = "broadside", [5] = "lucky_blow" },
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 2 and functions and functions.script then
			local stat = functions.script.get("aggroMonsters")
			if not stat then return end
			champion:addStatModifier("evasion", stat * 3)
		end
	end,
}

defineSkill{
	name = "alchemy",
	uiName = "Alchemy",
	priority = 90,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 8,
	description = [[A higher skill level in Alchemy allows you to brew a wider range of potions. To craft potions you also need herbs and a Mortar and Pestle.
	
	Perks:
	- Green Thumb | Herbs multiply while in your inventory.
	- Bomb Multiplication | When throwing a bomb, there's a 10% chance you alchemically clone it on the spot. Chance increases by 2% per 10 Willpower.
	- Bomb Expert | When you craft bombs you get three bombs instead of one.]],
	traits = { [1] = "green_thumb", [4] = "bomb_multiplication", [5] = "bomb_expert" },
	onRecomputeStats = function(champion, level)
		if level > 0 then
		end
	end,
}

defineSkill{
	name = "ranged_weapons",
	uiName = "Ranged Weapons",
	priority = 100,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 9,
	description = [[Increases damage of Ranged Weapons by 20% for each skill point. 
	
	Perks:
	- Bullseye | +15 Accuracy.
	- Magic Missile | You launch a magical projectile with your attacks. It does 1/3 your damage and increases based on the target's protection.
	- Double Shot | You attack twice when using Ranged Weapons.]],
	traits = { [2] = "bullseye", [4] = "magic_missile", [5] = "double_shot" },
}

defineSkill{
	name = "light_weapons_c",
	uiName = "Light Weapons",
	priority = 110,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 10,
	description = [[Increases damage of Light Weapons by 20% for each skill point. 
	
	Perks:
	- Dual Wield | You can dual wield Light Weapons as long one of them is a dagger.
	- Double Attack | You gain 20% chance to attack twice. You can dual wield any Light Weapons.
	- Thunder Fury | Chance to deal 50% of your weapon damage as Shock damage equal to your critical chance.]],
	traits = { [3] = "dual_wield", [4] = "improved_dual_wield", [5] = "thunder_fury" },
}

defineSkill{
	name = "heavy_weapons_c",
	uiName = "Heavy Weapons",
	priority = 120,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 11,
	description = [[Increases damage of Heavy Weapons by 20% for each skill point. 
	
	Perks:
	- Rend | Power attacks have a 30% chance to cause enemies to bleed.
	- Power Grip | Melee attacks gain 1% more damage per 5 points of health you have, plus 10% per 100 health.
	- Heavy Hander | You can wield two-handed weapons in one hand.]],
	traits = { [3] = "rend", [4] = "power_grip", [5] = "two_handed_mastery" },
}

defineSkill{
	name = "spellblade",
	uiName = "Spellblade",
	priority = 130,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 12,
	description = [[Increase Protection and Accuracy by 3 for each skill point when holding a staff.
	
	Perks:
	- Staff Fighter | You can hold a staff in one hand.
	- Spell Slinger | Cast a basic spell to memorize it. Melee attacks have a 10% chance to cast it again.
	- Arcane Warrior | Non-ultimate level spells gain damage equal to 10% of your physical damage and accuracy.
	- Mage Strike | Your spells gain double the bonuses from the Critical skill plus 1% Critical per 10 points in Willpower.]],
	traits = { [1] = "staff_fighter", [2] = "spell_slinger", [4] = "arcane_warrior", [5] = "mage_strike" },
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 2 and party.partycounter:getValue() > 2 then
			local level2 = champion:getSkillLevel("spellblade")
			for i=1,2 do
				local item = champion:getItem(i)
				if item and item:hasTrait("mage_weapon") then
					champion:addStatModifier("protection", level2 * 3)
				end
			end
		end
	end,
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and party.partycounter:getValue() > 2 then
			local level2 = champion:getSkillLevel("spellblade")
			for i=1,2 do
				local item = champion:getItem(i)
				if item and item:hasTrait("mage_weapon") then
					return level2 * 3
				end
			end
		end
	end,
}

defineSkill{
	name = "elemental_magic",
	uiName = "Elemental Magic",
	priority = 140,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 13,
	description = [[Increases all elemental damage by 20% for each skill point.
	
	Perks:
	- Aggregate | Hitting a foe with an element it resists will buff your next hit with that element by 20%.
	- Elemental Armor | +25% Resist Fire, Shock and Cold. You gain 15% of you maximum energy when hit by one of those elements.
	- Exploitation| Deal 25% more damage if the target is vulnerable to that element.]],
	traits = { [2] = "aggregate", [4] = "elemental_armor", [5] = "elemental_exploitation" },
}

defineSkill{
	name = "poison_mastery",
	uiName = "Poison Mastery",
	priority = 150,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 14,
	description = [[Poison damage +20% per skill point.
	
	Perks:
	- Venomancer| 10% chance to poison enemies with melee, missile and throwing attacks.
	- Plague | Poison spreads between enemies. +5% Chance to poison.
	- Bane | Enemies take increased damage from the poison status, an effect which also heals you.]],
	traits = { [2] = "venomancer", [4] = "plague", [5] = "antivenom" },
}

defineSkill{
	name = "concentration",
	uiName = "Magic Training",
	priority = 160,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 15,
	description = [[Increases your Energy by 20 and Energy Regeneration while resting by 5% for each skill point.
	
	Perks:
	- Meditation | +5 Protection. You regain 1% to 5% of you energy when taking damage.
	- Imperium Arcana | Non-elemental and non-poison spells deal 35% more damage.
	- Extraction | Energy potions recover 25% more, while also regenerating 25 health. Healing potions also recover 25 energy. Allies benefit from this at 1/3 the power.]],
	onRecomputeStats = function(champion, level)
		champion:addStatModifier("max_energy", level * 20)
	end,
	traits = { [2] = "meditation", [4] = "imperium_arcana", [5] = "arcane_extraction" },
}

defineSkill{
	-- Level 1 spell > splash (low damage + wet target)
	-- Level 2 spell > fear (lowers monster morale and protection)
	-- Level 3 spell > wicked (smoke cloud that moves around randomly, does poison damage and lowers accuracy)
	-- Level 5 spell > thunderstorm (2x2 shocks area over a period)
	-- Darkness spells?
	name = "witchcraft",
	uiName = "Witchcraft",
	priority = 170,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 16,
	description = [[Increases the damage and effect of witchcraft spells by 20% for each skill point.
	
	Perks:
	- Ritual | Heals the party for 10% of the damage done with spells. You heal for twice as much.
	- Moon Rites | During the night, your Energy regeneration rate is increased by 50% and your spell damage by 10%.
	- Voodoo | Hitting one enemy with a spell also affects nearby enemies* in a range of 2 tiles.]],
	traits = { [1] = "ritual", [4] = "moon_rites", [5] = "voodoo" },
	onRecomputeStats = function(champion, level)
		if level > 0 then			
		end
	end,
}

defineSkill{
	name = "tinkering",
	uiName = "Tinkering",
	priority = 180,
	iconAtlas = "mod_assets/textures/gui/skills.dds",
	icon = 17,
	description = [[Allows you to upgrade equipments, increasing their stats. Requires a Tinkerer's Toolbox and crafting materials.
	- Items can be upgraded 3 times.
	- Each skill point increases the stats by an additional 5%.
	- Upgraded items weight around 30% more, reduced by the skill level.
	
	Perks:
	- Pyrotechnician | +5 Fire and Shock damage dealt per upgraded item you have equipped.
	- Multipurpose | Unlock chests without a lockpick, at the cost of Energy. You gain +1 to a random stat when you do it.
	- Mastersmith | You can upgrade Epic items.]],
	traits = { [3] = "pyrotechnician", [4] = "multipurpose", [5] = "mastersmith" },
	onRecomputeStats = function(champion, level)
		if level > 0 then
			if not champion:hasTrait("dismantler") then
				champion:addTrait("dismantler")
				champion:addTrait("tinkering")
			end
		end
	end,
}