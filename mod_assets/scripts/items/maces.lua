defineObject{
	name = "branch",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/branch.fbx",
		},
		{
			class = "Item",
			uiName = "Branch",
			gfxIndex = 273,
			impactSound = "impact_blunt",
			weight = 1.2,
			traits = { "light_weapon", "mace", "dismantle", "upgradable", "weapon" },
		},
		{
			class = "MeleeAttack",
			attackPower = 3,
			accuracy = 0,
			cooldown = 3,
			swipe = "vertical",
			attackSound = "swipe",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_light" },
}

defineObject{
	name = "bone_club",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bone_club.fbx",
		},
		{
			class = "Item",
			uiName = "Bone Club",
			description = "A makeshift club made from the leg bone of an unknown beast.",
			gfxIndex = 298,
			impactSound = "impact_blunt",
			weight = 1.2,
			traits = { "heavy_weapon", "mace", "dismantle", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 4,
			accuracy = 0,
			cooldown = 3,
			swipe = "vertical",
			attackSound = "swipe",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_heavy" },
}

defineObject{
	name = "baton",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/baton.fbx",
		},
		{
			class = "Item",
			uiName = "Baton",
			description = "A lightweight club covered with nasty looking metal studs.",
			gfxIndex = 227,
			gfxIndexPowerAttack = 419,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "light_weapon", "mace", "dismantle", "upgradable", "bash" },
		},
		{
			class = "MeleeAttack",
			attackPower = 10,
			accuracy = 0,
			cooldown = 4.5,
			swipe = "vertical",
			attackSound = "swipe",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_light" },
}

defineObject{
	name = "cudgel",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/cudgel.fbx",
		},
		{
			class = "Item",
			uiName = "Cudgel",
			gfxIndex = 24,
			gfxIndexPowerAttack = 420,
			impactSound = "impact_blunt",
			weight = 3.8,
			traits = { "heavy_weapon", "mace", "dismantle", "upgradable", "bash" },
		},
		{
			class = "MeleeAttack",
			attackPower = 12,
			cooldown = 5,
			swipe = "vertical",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_heavy" },
}

defineObject{
	name = "warhammer",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/warhammer.fbx",
		},
		{
			class = "Item",
			uiName = "Warhammer",
			gfxIndex = 220,
			gfxIndexPowerAttack = 421,
			impactSound = "impact_blunt",
			weight = 5.7,
			traits = { "heavy_weapon", "mace", "dismantle", "upgradable", "stun" },
		},
		{
			class = "MeleeAttack",
			attackPower = 18,
			pierce = 5,
			accuracy = 0,
			cooldown = 4.5,
			swipe = "vertical",
			requirements = { "heavy_weapons", 1 },
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_heavy" },
}

defineObject{
	name = "morning_star",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/morning_star.fbx",
		},
		{
			class = "Item",
			uiName = "Morning Star",
			gfxIndex = 3,
			gfxIndexPowerAttack = 203,
			impactSound = "impact_blunt",
			weight = 5.0,
			traits = { "heavy_weapon", "mace", "dismantle", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 23,
			accuracy = 0,
			pierce = 5,
			cooldown = 4.5,
			swipe = "vertical",
			requirements = { "heavy_weapons", 1 },
			powerAttackTemplate = "stun",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_heavy" },
}

defineObject{
	name = "venomfang_pick",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/venomfang_pick.fbx",
		},
		{
			class = "Item",
			uiName = "Venomfang Pick",
			description = "A tooth from a venomfang lizard is attached to a pole, which makes for a simple but effective weapon.",
			gfxIndex = 226,
			gfxIndexPowerAttack = 422,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "light_weapon", "mace", "dismantle", "upgradable" },
			secondaryAction = "bite",
		},
		{
			class = "MeleeAttack",
			attackPower = 18,
			accuracy = 0,
			pierce = 20,
			cooldown = 4.5,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "light_weapons", 2 },
		},
		{
			class = "MeleeAttack",
			name = "bite",
			uiName = "Bite",
			energyCost = 30,
			attackPower = 10,
			damageType = "poison",
			baseDamageStat = "none",
			accuracy = 50,
			causeCondition = "poisoned",
			conditionChance = 100,
			cooldown = 4.5,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "light_weapons", 3, "earth_magic", 1 },
			gameEffect = "A sting that injects poison into victim's bloodstream.",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_light" },
}

defineObject{
	name = "flail",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flail.fbx",
		},
		{
			class = "Item",
			uiName = "Flail",
			gfxIndex = 87,
			gfxIndexPowerAttack = 423,
			impactSound = "impact_blunt",
			weight = 6.5,
			traits = { "heavy_weapon", "mace", "dismantle", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 24,
			pierce = 10,
			cooldown = 5,
			swipe = "vertical",
			attackSound = "swipe_heavy",
			requirements = { "heavy_weapons", 3 },
			powerAttackTemplate = "stun",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_heavy" },
}

defineObject{
	name = "maul",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/maul.fbx",
		},
		{
			class = "Item",
			uiName = "Maul",
			description = "A powerful hammer that you always thought was merely a myth. It looks almost too massive for a human to use.",
			gfxIndex = 403,
			gfxIndexPowerAttack = 424,
			impactSound = "impact_blunt",
			weight = 6.0,
			traits = { "heavy_weapon", "two_handed", "mace", "dismantle", "upgradable", "epic" },
		},
		{
			class = "MeleeAttack",
			attackPower = 29,
			pierce = 25,
			cooldown = 6,
			swipe = "vertical",
			attackSound = "swipe_heavy",
			requirements = { "heavy_weapons", 3 },
			powerAttackTemplate = "knockback",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_heavy" },
}

defineObject{
	name = "spiked_club",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/forest_ogre_club.fbx",
		},
		{
			class = "Item",
			uiName = "Spiked Club",
			gfxIndex = 160,
			gfxIndexPowerAttack = 425,
			impactSound = "impact_blunt",
			weight = 13.0,
			traits = { "heavy_weapon", "two_handed", "mace", "dismantle", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 41,
			accuracy = -20,
			cooldown = 8,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "heavy_weapons", 3 },
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_heavy" },
}

defineObject{
	name = "meteor_hammer",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_hammer.fbx",
		},
		{
			class = "Item",
			uiName = "Meteor Hammer",
			gfxIndex = 259,
			gfxIndexPowerAttack = 206,
			description = "The head of this weapon is made of an actual meteorite which has been imbibed with permanency magicks. The meteorite still radiates heat.",
			impactSound = "impact_blunt",
			weight = 6.5,
			secondaryAction = "meteorStorm",
			achievement = "find_meteor_hammer",
			traits = { "heavy_weapon", "two_handed", "mace", "dismantle", "upgradable", "epic" },
		},
		{
			class = "MeleeAttack",
			attackPower = 48,
			damageType = "fire",
			accuracy = 20,
			cooldown = 4.5,
			swipe = "vertical",
			attackSound = "swipe_heavy",
			requirements = { "heavy_weapons", 5 },
		},
		{
			class = "CastSpell",
			name = "meteorStorm",
			uiName = "Meteor Storm",
			energyCost = 50,
			cooldown = 10,
			spell = "meteor_storm",
			power = 5,
			charges = 9,
			requirements = { "heavy_weapons", 5, "fire_magic", 1 },
		},
		{
			class = "Particle",
			particleSystem = "meteor_hammer",
		},
	},
	tags = { "weapon", "weapon_mace", "weapon_heavy" },
}
