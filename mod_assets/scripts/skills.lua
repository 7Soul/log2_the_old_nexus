defineSkill{
	name = "athletics",
	uiName = "Athletics",
	priority = 10,
	icon = 12,
	description = [[Increases your health by 20 and carrying capacity by 1kg for each skill point. 

	Perks:
	- Level 2 | Your carrying capacity is increased by 10 kg.
	- Level 4 | Increases resistance to leg wounds by 10%, plus 10% if wearing Light Armor boots or 20% if wearing Heavy Armor boots.
	- Level 5 | You gain +100% Health Regeneration Rate for 30 seconds after drinking a healing potion.]],
	traits = { [2] = "pack_mule", [4] = "endurance", [5] = "refreshed" },
	onRecomputeStats = function(champion, level)
		if level > 0 then
			champion:addStatModifier("max_health", level * 20)
			champion:addStatModifier("max_load", level)
		end
	end,
	onReceiveCondition = function(champion, cond, level)
		if level > 0 then
			local bonus = 0
			local item = champion:getItem(6)
			if item then
				if item:hasTrait("heavy_armor") then
					bonus = 0.2
				else
					bonus = 0.1
				end				
			end
			if cond == "leg_wound" and math.random() <= 0.1 + bonus then
				return false
			end
		end
	end,
}

defineSkill{
	name = "block",
	uiName = "Block",
	priority = 20,
	icon = 12,
	description = [[Increases all resistances by 2 per skill level when holding a shield. 
		
	Perks:
	- Level 2 | Gain 10% chance to block an attack.
	- Level 4 | Immunity against hand and chest wounds.
	- Level 5 | Bashes the enemy for 150% of the damage received when you block an attack.]],
	traits = { [2] = "block", [4] = "shield_bearer", [5] = "shield_bash" },
	onRecomputeStats = function(champion, level)
		local skillLevel = champion:getSkillLevel("block")
		champion:addStatModifier("resist_fire", 2 * skillLevel)
		champion:addStatModifier("resist_cold", 2 * skillLevel)
		champion:addStatModifier("resist_poison", 2 * skillLevel)
		champion:addStatModifier("resist_shock", 2 * skillLevel)
	end,
}

defineSkill{
	name = "light_armor",
	uiName = "Light Armor",
	priority = 30,
	icon = 12,
	description = [[Each point reduces the evasion penalties from wearing Light Armor by 20% and increases the protection they provide by 5% per level.
	
	Perks:
	- Level 2 | Gain +5 Evasion if wearing light armor in all 5 slots.
	- Level 4 | Gain +20 resist all if wearing all light armor.
	- Level 5 | Reduces action timers by 15% if wearing all light armor.]],
	traits = { [2] = "light_wear", [4] = "reflective", [5] = "nimble" },
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and functions ~= nil and Time.currentTime() > 3 then
			local armor = "light_armor"
			local armor2 = "clothes"
			if armor2 == nil then armor2 = armor end
			local all_light = true
			local equip_slots = {3,4,5,6,9}
			for i, v in pairs(equip_slots) do
				if champion:getItem(v) ~= nil then
					if (not champion:getItem(v):hasTrait(armor)) and (not champion:getItem(v):hasTrait(armor2)) then	
						all_light = false
					end
				else
					all_light = false
				end
			end
	
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
	icon = 12,
	description = [[Each point reduces the evasion penalties from wearing Heavy Armor by 20% and increases the protection they provide by 5% per level.
	
	Perks:
	- Level 2 | Gain +5 Protection if wearing heavy armor in all 5 slots.
	- Level 4 | Heavy Armor weights 75% less while in your inventory.
	- Level 5 | Heavy Armor weights nothing if wearing all heavy armor.]],
	traits = { [2] = "armored_up", [4] = "heavy_conditioning", [5]="armor_training" },
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and functions ~= nil and Time.currentTime() > 3 then
			local armor = "heavy_armor"
			local armor2 = "heavy_armor"
			local all_light = true
			local equip_slots = {3,4,5,6,9}
			for i, v in pairs(equip_slots) do
				if champion:getItem(v) ~= nil then
					if (not champion:getItem(v):hasTrait(armor)) and (not champion:getItem(v):hasTrait(armor2)) then	
						all_light = false
					end
				else
					all_light = false
				end
			end
			
			local equip_slots = {3,4,5,6,9}
			for i, v in pairs(equip_slots) do
				if champion:getItem(v) and champion:getItem(v):hasTrait("heavy_armor") then
					champion:addStatModifier("evasion", champion:getSkillLevel("heavy_armor") * 2)
					champion:addStatModifier("protection", champion:getItem(v).go.equipmentitem:getProtection() * 0.05 * champion:getSkillLevel("heavy_armor"))
				end
			end
		end
	end,
}

defineSkill{
	name = "accuracy",
	uiName = "Accuracy",
	priority = 50,
	icon = 86,
	description = [[Increases your Accuracy by 10 for each skill point.
	
	Perks:
	- Level 1 | You can perform melee attacks from the back row.
	- Level 4 | Gain up to +100 accuracy based on how much health the party is missing.
	- Level 5 | 25% Chance to pierce 5 to 15 armor with melee and firearm attacks.]],
	onComputeAccuracy = function(champion, weapon, attack, attackType, level)
		if level > 0 then
			return level * 10
		end
	end,
	traits = { [1] = "reach",  [4] = "clutch", [5] = "precision" },
}

defineSkill{
	name = "critical",
	uiName = "Critical",
	priority = 60,
	icon = 10,
	description = [[Increases critical chance with physical attacks by 3% and spells by 1% for each skill point.
	
	Perks:
	- Level 2 | You can backstab an enemy with a dagger and deal triple damage.
	- Level 4 | You gain double critical chance from items.
	- Level 5 | You can backstab with any Light Weapon.]],
	onComputeCritChance = function(champion, weapon, attack, attackType, level)
		return level * 3
	end,
	traits = { [2] = "backstab", [5] = "assassin", [4] = "weapons_specialist" },
}

defineSkill{
	name = "firearms",
	uiName = "Firearms",
	priority = 70,
	icon = 90,
	description = [[Increases range of firearm attacks by 1 square for each skill point, decreases the chance of a firearm malfunctioning and gives 10% chance per level to pierce 5 armor.
	
	Perks:
	- Level 3 | 7% chance to not spend a pellet to fire.
	- Level 4 | Every 6th shot does double damage.
	- Level 5 | Reload time reduced by 25%.]],
	traits = { [3] = "metal_slug", [5] = "fast_fingers" },
}

defineSkill{
	name = "seafaring",
	uiName = "Seafaring",
	priority = 80,
	icon = 20,
	description = [[Increases melee and ranged damage when fighting multiple foes by 20% for each skill point.
	
	Perks:
	- Level 2 | You deal 30% more melee damage from the backline and 30% more firearm damage from the frontline.
	- Level 4 | Pellets and cannon balls have a 40% chance to create shrapnel on impact, doing half damage to the enemy behind your target.
	- Level 5 | Cannon balls in your inventory weight 80% less.]],
	traits = { [2] = "sea_dog", [4] = "broadside", [5] = "baller" },
	onRecomputeStats = function(champion, level)
		if level > 0 then			
		end
	end,
}

defineSkill{
	name = "alchemy",
	uiName = "Alchemy",
	priority = 90,
	icon = 20,
	description = [[A higher skill level in Alchemy allows you to brew a wider range of potions. To craft potions you also need herbs and a Mortar and Pestle.
	
	Perks:
	- Level 1 | Herbs multiply while in your inventory.
	- Level 4 | 
	- Level 5 | When you craft bombs you get three bombs instead of one.]],
	traits = { [1] = "green_thumb", [4] = "", [5] = "bomb_expert" },
	onRecomputeStats = function(champion, level)
		if level > 0 then
		end
	end,
}

defineSkill{
	name = "ranged_weapons",
	uiName = "Ranged Weapons",
	priority = 100,
	icon = 17,
	description = [[Increases damage of Missiles and Throwing Weapons attacks by 20% for each skill point. 
	
	Perks:
	- Level 2 | Gain 15 accuracy with Ranged Weapons.
	- Level 4 | You launch a magical projectile with your attacks. It does 1/3 the damage of your attack and pierces half the target's protection.
	- Level 5 | You attack twice when using Ranged Weapons.]],
	traits = { [2] = "bullseye", [4] = "magic_missile", [5] = "double_shot" },
}

defineSkill{
	name = "light_weapons",
	uiName = "Light Weapons",
	priority = 110,
	icon = 106,
	description = [[Increases damage of Light Weapons by 20% for each skill point. 
	
	Perks:
	- Level 3 | You can dual wield Light Weapons as long one of them is a dagger.
	- Level 4 | You gain 25% chance to attack twice.
	- Level 5 | You can dual wield any Light Weapons. When dual wielding you suffer a 40% penalty to weapon damage.]],
	traits = { [3] = "dual_wield", [4] = "double_attack", [5] = "improved_dual_wield" },
}

defineSkill{
	name = "heavy_weapons",
	uiName = "Heavy Weapons",
	priority = 120,
	icon = 105,
	description = [[Increases damage of Heavy Weapons by 20% for each skill point. 
	
	Perks:
	- Level 3 | Power attacks have a 30% chance to cause enemies to bleed.
	- Level 4 | Attacks gain 1% more damage per 5 points of health you have, plus 10% per 60 health.
	- Level 5 | You can wield two-handed weapons in one hand.]],
	traits = { [3] = "", [4] = "power_grip", [5] = "two_handed_mastery" },
}

defineSkill{
	name = "spellblade",
	uiName = "Spellblade",
	priority = 130,
	icon = 12,
	description = [[Increase Protection and Accuracy by 3 for each skill point when holding a staff.
	
	Perks:
	- Level 1 | You can hold a staff in one hand.
	- Level 2 | Cast a basic spell to memorize it. You'll automatically cast this spell with melee attacks at 10% chance.
	- Level 4 | Non-ultimate level spells gain damage equal to 10% of the current weapon damage plus 10% of your accuracy.
	- Level 5 | Your spells gain double the critical chance from the Critical skill plus a flat +6%.]],
	traits = { [1] = "staff_fighter", [2] = "spell_slinger", [4] = "arcane_warrior", [5] = "mage_strike" },
	onRecomputeStats = function(champion, level)
		if level > 0 and Dungeon.getMaxLevels() ~= 0 and Time.currentTime() > 3 then
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
		if level > 0 and Dungeon.getMaxLevels() ~= 0 then
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
	icon = 29,
	description = [[Increases damage of elemental spells by 20% for each skill point.
	
	Perks:
	- Level 4 | Deal 25% more damage if the enemy is vulnerable to that element.
	- Level 5 | You gain +25% Resist Fire, Shock and Cold.]],
	traits = { [4] = "elemental_exploitation", [5] = "elemental_armor" },
}

defineSkill{
	name = "poison_mastery",
	uiName = "Poison Mastery",
	priority = 150,
	icon = 31,
	description = [[Increases damage of poison spells by 20% for each skill point.
	
	Perks:
	- Level 2 | 10% chance to poison enemies with melee, missile and throwing attacks.
	- Level 4 | Your poison spells have a larger area of effect and can't damage your party.
	- Level 5 | +50% Resist Poison.]],
	traits = { [2] = "venomancer", [4] = "plague", [5] = "antivenom" },
}

defineSkill{
	name = "concentration",
	uiName = "Magic Training",
	priority = 160,
	icon = 26,
	description = [[Increases your energy by 20 for each skill point. 
	
	Perks:
	- Level 3 | Your Energy regeneration rate is increased by 25% while resting.
	- Level 4 | Non-elemental and non-poison spells deal 35% more damage.
	- Level 5 | Energy Potions have double the effect.]],
	onRecomputeStats = function(champion, level)
		champion:addStatModifier("max_energy", level * 20)
	end,
	traits = { [3] = "meditation", [4] = "imperium_arcana", [5] = "arcane_extraction" },
}

defineSkill{
	-- Level 1 spell > splash (low damage + wet target)
	-- Level 2 spell > fear (lowers monster morale and protection)
	-- Level 3 spell > wicked (smoke cloud that moves around randomly, does poison damage and lowers accuracy)
	-- Level 5 spell > thunderstorm (2x2 shocks area over a period)
	name = "witchcraft",
	uiName = "Witchcraft",
	priority = 170,
	icon = 20,
	description = [[Increases the damage and effect of witchcraft spells by 20% for each skill point.
	
	Perks:
	- Level 1 | Heals the party for 10% of the damage done with spells.
	- Level 4 | Your Energy regeneration rate is increased by 50% during the night.
	- Level 5 | You can obtain voodoo dolls of monsters by slaying them.]],
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
	icon = 20,
	description = [[Allows you to upgrade equipments, increasing their stats. Requires a Tinkerer's Toolbox and crafting materials.
	- Raises your tinkering level after 3 successful upgrades and after leveling this skill.
	- Each skill point increases the stats by an additional 5%.
	- Upgraded items weight 5kg more (-0.5kg per level).
	
	Perks:
	- Level 3 | You can dismantle items into materials.
	- Level 4 | You can craft bombs and pellets.
	- Level 5 | Upgraded items gain extra stats based on your skill levels.]],
	traits = { [3] = "dismantler", [4] = "metalworks", [5] = "mastersmith" },
	onRecomputeStats = function(champion, level)
		if level > 0 then
		end
	end,
}

-- defineSkill{
	-- name = "explosives",
	-- uiName = "Explosives",
	-- priority = 105,
	-- icon = 20,
	-- description = [[Increases the damage of bombs by 20% per skill level.
	
	-- Perks:
	-- - Level 2 | Melee, throwing and firearm attacks deal 10% of their attack power as fire damage, with a 10% chance to burn.
	-- - Level 4 | 50% better chances of generating bombs and pellets by activating Explosive Cores and 5% chance of gaining double the items.
	-- - Level 5 | Bombs do 50% damage to enemies in a 2x3 area behind and besides your main target.]],
	-- traits = { [2] = "", [4] = "", [5] = "" },
	-- onRecomputeStats = function(champion, level)
		-- if level > 0 then
		-- end
	-- end,
-- }
