defineObject{
	name = "rapier",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rapier.fbx",
		},
		{
			class = "Item",
			uiName = "Rapier",
			gfxIndex = 338,
			gfxIndexPowerAttack = 429,
			impactSound = "impact_blade",
			weight = 3.2,
			traits = { "light_weapon", "sword", "thrust" },
		},
		{
			class = "MeleeAttack",
			attackPower = 9,
			accuracy = 10,
			cooldown = 3.4,
			swipe = "thrust",
			requirements = { "light_weapons_c", 1 },
			powerAttackTemplate = "thrust",
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}

defineObject{
	name = "machete",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/machete.fbx",
		},
		{
			class = "Item",
			uiName = "Machete",
			gfxIndex = 23,
			impactSound = "impact_blade",
			weight = 2.2,
			traits = { "light_weapon", "sword" },
		},
		{
			class = "MeleeAttack",
			attackPower = 12,
			accuracy = 0,
			cooldown = 4.5,
			pierce = 0,
			swipe = "horizontal",			
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}

defineObject{
	name = "long_sword",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/long_sword.fbx",
		},
		{
			class = "Item",
			uiName = "Longsword",
			gfxIndex = 84,
			gfxIndexPowerAttack = 430,
			impactSound = "impact_blade",
			weight = 3.2,
			description = "A mighty weapon, the longsword is the weapon of choice for Theareonan Knights. It is renowned for its ability to impale even well-armored foes.",
			traits = { "light_weapon", "sword", "thrust" },
		},
		{
			class = "MeleeAttack",
			attackPower = 16,
			accuracy = 0,
			cooldown = 3.7,
			swipe = "horizontal",
			requirements = { "light_weapons_c", 1 },
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}

defineObject{
	name = "lightning_blade",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/long_sword.fbx",
		},
		{
			class = "Item",
			uiName = "Lightning Blade",
			description = "A rolling thunder can be heard every time the blade of this sword moves through the air.",
			gfxIndex = 210,
			gfxIndexPowerAttack = 431,
			impactSound = "impact_blade",
			weight = 3.2,
			secondaryAction = "lightningBolt",
			traits = { "light_weapon", "sword" },
		},
		{
			class = "MeleeAttack",
			attackPower = 16,
			accuracy = 0,
			damageType = "shock",
			cooldown = 3.7,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "light_weapons_c", 1 },
		},
		{
			class = "CastSpell",
			uiName = "Lightning Bolt",
			name = "lightningBolt",
			cooldown = 5,
			spell = "lightning_bolt",
			energyCost = 25,
			power = 4,
			charges = 9,
			fullGfxIndex = 210,
			emptyGfxIndex = 308,
			requirements = { "concentration", 1 },
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}

defineObject{
	name = "fire_blade",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/long_sword.fbx",
		},
		{
			class = "Item",
			uiName = "Fireblade",
			description = "A magical fire flickers on the glowing hot steel of this blade.",
			gfxIndex = 215,
			gfxIndexPowerAttack = 432,
			impactSound = "impact_blade",
			weight = 3.2,
			secondaryAction = "fireball",
			traits = { "light_weapon", "sword" },
		},
		{
			class = "MeleeAttack",
			attackPower = 16,
			damageType = "fire",
			accuracy = 0,
			cooldown = 3.7,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "light_weapons_c", 1 },
		},
		{
			class = "CastSpell",
			name = "fireball",
			uiName = "Fireball",
			cooldown = 5,
			spell = "fireball",
			energyCost = 25,
			power = 4,
			charges = 9,
			fullGfxIndex = 215,
			emptyGfxIndex = 216,
			requirements = { "concentration", 1 },
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}

defineObject{
	name = "two_handed_sword",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skeleton_knight_longsword.fbx",
		},
		{
			class = "Item",
			uiName = "Two-handed Sword",
			gfxIndex = 293,
			gfxIndexPowerAttack = 463,
			impactSound = "impact_blade",
			weight = 4.5,
			traits = { "heavy_weapon", "two_handed", "sword", "cleave" },
		},
		{
			class = "MeleeAttack",
			attackPower = 28,
			accuracy = 0,
			cooldown = 6,
			swipe = "vertical",
			attackSound = "swipe_heavy",
			requirements = { "heavy_weapons_c", 3 },
		},
	},
	tags = { "weapon_sword", "weapon_heavy" },
}

defineObject{
	name = "cutlass",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/cutlass.fbx",
		},
		{
			class = "Item",
			uiName = "Cutlass",
			gfxIndex = 221,
			gfxIndexPowerAttack = 200,
			impactSound = "impact_blade",
			weight = 3.5,
			traits = { "light_weapon", "sword", "flurry" },
		},
		{
			class = "MeleeAttack",
			attackPower = 24,
			accuracy = 0,
			cooldown = 3.3,
			swipe = "horizontal",
			requirements = { "light_weapons_c", 1 },
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}


defineObject{
	name = "bone_blade",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bone_blade.fbx",
		},
		{
			class = "Item",
			uiName = "Boneblade",
			description = "The handle of this weapon feels deathly cold to touch.",
			gfxIndex = 317,
			gfxIndexPowerAttack = 433,
			impactSound = "impact_blade",
			weight = 3.2,
			traits = { "light_weapon", "sword", "leech" },
			secondaryAction = "leech",
		},
		{
			class = "MeleeAttack",
			attackPower = 25,
			accuracy = 10,
			cooldown = 3.4,
			swipe = "horizontal",
			requirements = { "light_weapons_c", 2 },
		},
		{
			class = "MeleeAttack",
			name = "leech",
			uiName = "Leech",
			attackPower = 35,
			accuracy = 20,
			cooldown = 4.5,
			energyCost = 25,
			swipe = "vertical",
			attackSound = "swipe_light",
			requirements = { "light_weapons_c", 4 },
			onHitMonster = function(self, monster, side, dmg, champion)
				if monster:hasTrait("undead") then
					-- draining undeads is not wise
					monster:showDamageText("Backlash", "FF0000")
					champion:damage(dmg*0.7, "physical")
					champion:playDamageSound()
					return false
				elseif monster:hasTrait("elemental") or monster:hasTrait("construct") then
					-- elementals are constructs are immune to leech
					monster:showDamageText("Immune")
					return false
				else
					champion:regainHealth(dmg*0.5)
				end
			end,
			gameEffect = "Successful hit drains life from target and heals you.",
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}

defineObject{
	name = "sickle_sword",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/sickle_sword.fbx",
		},
		{
			class = "Item",
			uiName = "Sickle Sword",
			description = "This nasty looking curved blade seems like the perfect tool for disemboweling your enemies.",
			gfxIndex = 232,
			gfxIndexPowerAttack = 457,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "light_weapon", "sword" },
		},
		{
			class = "MeleeAttack",
			attackPower = 31,
			accuracy = 5,
			cooldown = 4.3,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "light_weapons_c", 3 },
			powerAttackTemplate = "flurry",
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}

defineObject{
	name = "sabre",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/sabre.fbx",
		},
		{
			class = "Item",
			uiName = "Sabre",
			description = "Unlike most weapons found on the Isle, this elegant sword looks brand new.",
			gfxIndex = 233,
			gfxIndexPowerAttack = 462,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "heavy_weapon", "sword" },
		},
		{
			class = "MeleeAttack",
			attackPower = 33,
			accuracy = 0,
			critChance = 5,
			cooldown = 4.5,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "heavy_weapons_c", 3 },
			powerAttackTemplate = "flurry",
		},
	},
	tags = { "weapon_sword", "weapon_heavy" },
}

defineObject{
	name = "ancient_claymore",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/claymore.fbx",
		},
		{
			class = "Item",
			uiName = "Ancient Claymore",
			description = "This frozen steel blade still remains sharp, even though it has been wielded by a thousand different warriors.",
			gfxIndex = 401,
			gfxIndexPowerAttack = 464,
			impactSound = "impact_blade",
			weight = 4.2,
			traits = { "heavy_weapon", "two_handed", "sword", "epic", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 45,
			accuracy = 0,
			cooldown = 5,
			damageType = "cold",
			swipe = "vertical",
			attackSound = "swipe_heavy",
			requirements = { "heavy_weapons_c", 5 },
			powerAttackTemplate = "cleave",
		},
	},
	tags = { "weapon_sword", "weapon_heavy" },
}

defineObject{
	name = "ice_sword",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/claymore.fbx",
		},
		{
			class = "Item",
			uiName = "Ice Fang",
			description = "This enchanted ice blade is so cold, only a master of ice can yield it and not be killed.",
			gameEffect = [[You get frostburn your Cold Resist is under 50.]],
			gfxIndex = 401,
			gfxIndexPowerAttack = 464,
			impactSound = "impact_blade",
			weight = 1.5,
			traits = { "light_weapon", "sword" },
		},
		{
			class = "MeleeAttack",
			attackPower = 1,
			accuracy = 10,
			cooldown = 5,
			damageType = "cold",
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "light_weapons_c", 1 },
			powerAttackTemplate = "cleave",
		},
	},
	tags = { "weapon_sword", "weapon_light" },
}
