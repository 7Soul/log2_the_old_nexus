defineObject{
	name = "dagger",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/dagger.fbx",
		},
		{
			class = "Item",
			uiName = "Dagger",
			gfxIndex = 10,
			gfxIndexPowerAttack = 415,
			impactSound = "impact_blade",
			weight = 0.8,
			projectileRotationX = 90,
			projectileRotationY = 90,
			secondaryAction = "dagger_throw",
			description = "A vicious looking dagger, which is effective in close combat as well as from a distance. The dagger is the favorite weapon of many a rogue.",
			traits = { "light_weapon", "dagger", "dismantle", "upgradable", "weapon", "dagger_throw" },
		},
		{
			class = "MeleeAttack",
			attackPower = 7,
			accuracy = 5,
			cooldown = 2.5,
			swipe = "vertical",
			attackSound = "swipe_light",
		},
		{
			class = "MeleeAttack",
			name = "dagger_throw",
		},
	},
	tags = { "weapon", "weapon_light", "weapon_dagger" },
}

defineObject{
	name = "venom_edge",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/dagger.fbx",
		},
		{
			class = "Item",
			uiName = "Venom Edge",
			description = "Noxious fumes rise from the blade of this dagger.",
			gameEffect = [[Adds 15% chance to poison if the monster is above 50% health.]],
			gfxIndex = 213,
			gfxIndexPowerAttack = 415,
			impactSound = "impact_blade",
			weight = 0.8,
			secondaryAction = "poisonBolt",
			traits = { "light_weapon", "dagger", "dismantle", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 10,
			accuracy = 0,
			cooldown = 2.5,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "poison_mastery", 1 },
		},
		{
			class = "CastSpell",
			name = "poisonBolt",
			uiName = "Poison Bolt",
			cooldown = 5,
			spell = "poison_bolt",
			energyCost = 25,
			power = 3,
			charges = 9,
			fullGfxIndex = 213,
			emptyGfxIndex = 214,
			requirements = { "poison_mastery", 1 },
		},
		{
			class = "Script",
			name = "effects_script",
			source = [[data = { ["poison_chance_50hp_multi"] = 0.15 } function getData(self) return data end]],
		}
	},
	tags = { "weapon", "weapon_light", "weapon_dagger" },
}

defineObject{
	name = "backbiter",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/backbiter.fbx",
		},
		{
			class = "Item",
			uiName = "Backbiter",
			description = "A vicious little blade tainted by unholy rites.",
			gfxIndex = 228,
			gfxIndexPowerAttack = 202,
			impactSound = "impact_blade",
			weight = 2.4,
			secondaryAction = "leech",
			traits = { "light_weapon", "dagger", "leech", "dismantle", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 10,
			accuracy = 5,
			cooldown = 3,
			swipe = "vertical",
			attackSound = "swipe_light",
		},
		{
			class = "MeleeAttack",
			name = "leech",
		},
	},
	tags = { "weapon", "weapon_light", "weapon_dagger" },
}

defineObject{
	name = "fist_dagger",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/fist_dagger.fbx",
		},
		{
			class = "Item",
			uiName = "Fist Dagger",
			gfxIndex = 159,
			gfxIndexPowerAttack = 461,
			impactSound = "impact_blade",
			weight = 1.5,
			traits = { "light_weapon", "dagger", "dismantle", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 18,
			accuracy = 0,
			cooldown = 2.7,
			swipe = "vertical",
			attackSound = "swipe_light",
			requirements = { "light_weapons_c", 3 },
			powerAttackTemplate = "thrust",
		},
	},
	tags = { "weapon", "weapon_light", "weapon_dagger" },
}

defineObject{
	name = "moonblade",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/moonblade.fbx",
		},
		{
			class = "Item",
			uiName = "Moonblade",
			description = "Symbolizing death and rebirth, this blade is held in high esteem by the Xafi priests and priestesses.",
			gfxIndex = 229,
			gfxIndexPowerAttack = 458,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "light_weapon", "dagger", "flurry", "dismantle", "upgradable" },
			secondaryAction = "flurry"
		},
		{
			class = "MeleeAttack",
			attackPower = 21,
			accuracy = 10,
			cooldown = 2.8,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "light_weapons_c", 4 },
		},
		{
			class = "MeleeAttack",
			name = "flurry",
		},
	},
	tags = { "weapon", "weapon_light", "weapon_dagger" },
}

defineObject{
	name = "assassin_dagger",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/assassin_dagger.fbx",
		},
		{
			class = "Item",
			uiName = "Assassin's Dagger",
			description = "A slender, wave-bladed dagger that only the most vile of the lizardmen assassins dare to use.",
			traits = { "light_weapon", "dagger", "base_leech", "dismantle", "upgradable" },
			gfxIndex = 402,
			impactSound = "impact_blade",
			gameEffect = "Life Leech: Successful hit drains life from target and heals you",
			weight = 1.0,
		},
		{
			class = "MeleeAttack",
			attackPower = 25,
			accuracy = 10,
			cooldown = 2.8,
			swipe = "vertical",
			attackSound = "swipe_light",
			requirements = { "light_weapons_c", 4 },
		},
	},
	tags = { "weapon", "weapon_light", "weapon_dagger" },
}

defineObject{
	name = "serpent_blade",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/serpent_blade.fbx",
		},
		{
			class = "Item",
			uiName = "Serpent Blade",
			description = "A brass snake crawls along the back edge of the dagger. Vicious venom seeps from its teeth, covering the blade.",
			gameEffect = [[Adds 15% chance to poison if the monster is above 50% health.]],
			gfxIndex = 329,
			impactSound = "impact_blade",
			weight = 3.2,
			traits = { "light_weapon", "dagger", "dismantle", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 22,
			accuracy = 15,
			cooldown = 3.5,
			swipe = "horizontal",
			requirements = { "light_weapons_c", 5, "poison_mastery", 1 },
		},
		{
			class = "Script",
			name = "effects_script",
			source = [[data = { ["poison_chance_50hp_multi"] = 0.15 } function getData(self) return data end]],
		}
	},
	tags = { "weapon", "weapon_light", "weapon_dagger" },
}

defineObject{
	name = "ethereal_blade",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/ethereal_blade_handle.fbx",
		},
		{
			class = "Item",
			uiName = "Ethereal Blade",
			description = "The brightly glowing blade of the dagger passes through solid matter with ease and it even leaves living tissue completely unharmed.",
			gfxIndex = 455,
			impactSound = "impact_blade",
			weight = 0.2,
			traits = { "light_weapon", "dagger", "upgradable" },
		},
		{
			class = "MeleeAttack",
			attackPower = 20,
			accuracy = 15,
			cooldown = 4,
			damageType = "dispel",
			swipe = "horizontal",
		},
		{
			class = "Particle",
			particleSystem = "ethereal_blade",
			emitterMesh = "assets/models/items/ethereal_blade.fbx"
		},
		{
			class = "Light",
			offset = vec(0, 0.12, 0),
			range = 1,
			color = vec(1, 1, 1.2),
			brightness = 10,
			castShadow = false,
			fillLight = true,
		},
	},
	tags = { "weapon", "weapon_light", "weapon_dagger" },
}
