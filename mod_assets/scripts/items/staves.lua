defineObject{
	name = "whitewood_wand",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/whitewood_wand.fbx",
		},
		{
			class = "Item",
			uiName = "Whitewood Wand",
			description = "A beautifully crafted wooden wand that can be used to channel a wizard's energy.",
			gfxIndex = 56,
			impactSound = "impact_blunt",
			traits = { "orb" },
			weight = 3.5,
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 1 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			energy = 5,
		},
	},
	tags = { "staves" },
}

defineObject{
	name = "magic_orb",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/apprentice_orb.fbx",
		},
		{
			class = "Item",
			uiName = "Orb of Radiance",
			description = "A smooth orb that radiates shimmering blue light. A tingling sensation passes through your body when you touch it.",
			gfxIndex = 69,
			gfxIndexPowerAttack = 452,
			impactSound = "impact_blunt",
			gameEffect = "Neutral spells deal 20% more damage",
			traits = { "orb" },
			weight = 2.0,
			secondaryAction = "light",
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 1 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			energy = 15,
		},
		{
			class = "CastSpell",
			name = "light",
			uiName = "Light",
			spell = "light",
			energyCost = 25,
			power = 3,
			requirements = { "concentration", 1 },
		},
		{
			class = "Script",
			name = "effects_script",
			source = [[data = { ["neutral_multi"] = 0.2 } function getData(self) return data end]],
		}
	},
	tags = { "staves" },
}

defineObject{
	name = "shaman_staff",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/shaman_staff.fbx",
		},
		{
			class = "Item",
			uiName = "Shaman Staff",
			description = "A rune covered staff with a pulsating poison green gem attached to its tip. You can sense great power in it.",
			gfxIndex = 1,
			gfxIndexPowerAttack = 440,
			impactSound = "impact_blunt",
			weight = 3.3,
			gameEffect = "Poison spells deal 20% more damage",
			traits = { "orb" },
			secondaryAction = "poisonBolt",
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 2 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			vitality = 2,
			energy = 25,
		},
		{
			class = "CastSpell",
			name = "poisonBolt",
			uiName = "Poison Bolt",
			cooldown = 5,
			spell = "poison_bolt",
			energyCost = 25,
			power = 3,
			requirements = { "concentration", 2 },
		},
		{
			class = "Script",
			name = "effects_script",
			source = [[data = { ["poison_multi"] = 0.2 } function getData(self) return data end]],
		}
	},
	tags = { "staves" },
}

defineObject{
	name = "zhandul_orb",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/zhandul_orb.fbx",
		},
		{
			class = "Item",
			uiName = "Zhandul's Orb",
			description = "The legendary long lost magical orb of archmage Zhandul The Mad. Intense vortex of fire rages inside the artifact.",
			gfxIndex = 157,
			impactSound = "impact_blunt",
			achievement = "find_zhanduls_orb",
			weight = 2.5,
			traits = { "orb" },
			gameEffect = "Fire spells deal 20% more damage.",
			secondaryAction = "fireball",
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 3, "fire_magic", 2 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			willpower = 5,
			energy = 35,
		},
		{
			class = "CastSpell",
			name = "fireball",
			uiName = "Greater Fireball",
			cooldown = 5,
			spell = "fireball",
			power = 5,
		},
		{
			class = "Script",
			name = "effects_script",
			source = [[data = { ["fire_multi"] = 0.2 } function getData(self) return data end]],
		}
	},
	tags = { "staves" },
}

defineObject{
	name = "spirit_crook",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/spirit_crook.fbx",
		},
		{
			class = "Item",
			uiName = "Spirit Crook",
			description = "This magical item is used by wizards to catch the energy of ghosts and spirits that roam the realms.",
			gfxIndex = 251,
			impactSound = "impact_blunt",
			weight = 3.5,
			traits = { "orb" },
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 2 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			energy = 5,
		},
	},
	tags = { "staves" },
}

defineObject{
	name = "nectarbranch_wand",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/nectarbranch_wand.fbx",
		},
		{
			class = "Item",
			uiName = "Nectarbranch Wand",
			description = "A magic wand made from a branch of the nectartree.",
			gfxIndex = 234,
			impactSound = "impact_blunt",
			weight = 3.5,
			traits = { "orb" },
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 2 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			energy = 5,
			willpower = 1,
		},
	},
	tags = { "staves" },
}

defineObject{
	name = "silver_scepter",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/silver_scepter.fbx",
		},
		{
			class = "Item",
			uiName = "Silver Scepter of Isochronos",
			description = "Isochronos shook the world of arcane academia with his incredible discovery of the fifth element.",
			gfxIndex = 287,
			gfxIndexPowerAttack = 449,
			impactSound = "impact_blunt",
			weight = 3.5,
			traits = { "orb" },
			secondaryAction = "invisibility",
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 2 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			energy = 20,
			resistAll = 10,
		},
		{
			class = "CastSpell",
			name = "invisibility",
			uiName = "Invisibility",
			spell = "invisibility",
			energyCost = 45,
			requirements = { "concentration", 2 },			
		},
	},
	tags = { "staves" },
}

defineObject{
	name = "jeweled_scepter",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/scepter.fbx",
		},
		{
			class = "Item",
			uiName = "Jeweled Scepter of Ruling",
			description = "A powerful scepter, once held by the sorcerer-princes of Harbardar.",
			gfxIndex = 286,
			gfxIndexPowerAttack = 448,
			impactSound = "impact_blunt",
			weight = 3.5,
			traits = { "orb" },
			secondaryAction = "forceField",
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 1 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			willpower = 4,
			immunities = { "paralyzed" },
		},
		{
			class = "CastSpell",
			name = "forceField",
			uiName = "Force Field",
			spell = "force_field",
			charges = 5,
			power = 9,
			energyCost = 35,
			requirements = { "concentration", 1 },
		},
	},
	tags = { "staves" },
}

defineObject{
	name = "stormseed_orb",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_orb.fbx",
		},
		{
			class = "Item",
			uiName = "Stormseed Orb",
			description = "This orb emits an almost inaudible rumble as it shakes in your hands.",
			gfxIndex = 326,
			gfxIndexPowerAttack = 451,
			impactSound = "impact_blunt",
			weight = 2.0,
			traits = { "orb" },
			secondaryAction = "lightningBolt",
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 2 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			dexterity = 2,
			energy = 15,
		},
		{
			class = "CastSpell",
			name = "lightningBolt",
			uiName = "Lightning Bolt",
			spell = "lightning_bolt",
			power = 1,
			energyCost = 25,
			charges = 9,
			requirements = { "concentration", 2 },
		},
	},
	tags = { "staves" },
}

defineObject{
	name = "wand_fear",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/staff_of_fear.fbx",
		},
		{
			class = "Item",
			uiName = "Wand of Fear",
			description = "This wand will strike fear to the hearts of your enemies.",
			gfxIndex = 225,
			gfxIndexPowerAttack = 443,
			impactSound = "impact_blunt",
			weight = 3.5,
			traits = { "orb" },
			secondaryAction = "causeFear",
		},
		{
			class = "MeleeAttack",
			attackPower = 7,
			accuracy = 0,
			cooldown = 3,
			swipe = "vertical",
		},
		{
			class = "CastSpell",
			name = "causeFear",
			uiName = "Cloud of Nightmares",
			spell = "cause_fear",
			energyCost = 30,
			cooldown = 5,
			requirements = { "concentration", 2 },
		},
	},
	tags = { "staves" },
}

defineParticleSystem{
	name = "fear_cloud",
	emitters = {
		{
			spawnBurst = true,
			maxParticles = 30,
			boxMin = {-1.2, -1.25,-1.2},
			boxMax = { 1.2,  0.5, 1.2},
			sprayAngle = {0,360},
			velocity = {0.1,0.7},
			objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {2,2},
			color0 = {0.15, 0.1, 0.15},
			opacity = 0.8,
			fadeIn = 0.2,
			fadeOut = 1,
			size = {1.4, 1.75},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.1,
			blendMode = "Translucent",
		},
		{
			spawnBurst = true,
			maxParticles = 1,
			boxMin = {0,-0.3,0},
			boxMax = {0,-0.3,0},
			sprayAngle = {0,360},
			velocity = {0.01,0.01},
			objectSpace = true,
			texture = "assets/textures/particles/skull.tga",
			lifetime = {2,2},
			color0 = {0.15, 0.1, 0.15},
			opacity = 0.3,
			fadeIn = 0.5,
			fadeOut = 1,
			size = {2.5, 2.5},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0,
			blendMode = "Translucent",
			randomInitialRotation = false,
			depthBias = 1,
		},
	}
}

defineObject{
	name = "acolyte_staff",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/acolyte_staff.fbx",
		},
		{
			class = "Item",
			uiName = "Acolyte Staff",
			description = "The highest of Xafi priests and priestesses who have ascended beyond mortality wield these magical staves.",
			gfxIndex = 340,
			gfxIndexPowerAttack = 450,
			impactSound = "impact_blunt",
			weight = 3.5,
			traits = { "orb" },
			secondaryAction = "dispel",
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 1 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			willpower = 2,
		},
		{
			class = "CastSpell",
			name = "dispel",
			uiName = "Dispel",
			spell = "dispel",
			energyCost = 40,
			power = 3,
			requirements = { "concentration", 1 },
		},
	},
	tags = { "staves" },
}

defineObject{
	name = "wizards_virge",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/wizards_virge.fbx",
		},
		{
			class = "Item",
			uiName = "Wizard's Virge",
			description = "This staff, which has been passed down between generations of Island Masters, is one of the most powerful artifacts known to mankind. The air itself radiates brightly around the staff as raw magical power flows out from the crystal.",
			gfxIndex = 309,
			gfxIndexPowerAttack = 444,
			impactSound = "impact_blunt",
			weight = 3.5,
			secondaryAction = "disintegrate",
			traits = { "epic", "orb" },
		},
		{
			class = "RunePanel",
			requirements = { "concentration", 2 },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			energy = 50,
		},
		{
			class = "CastSpell",
			name = "disintegrate",
			uiName = "Disintegrate",
			spell = "disintegrate",
			energyCost = 80,
			requirements = { "concentration", 3 },
		},
		{
			class = "Particle",
			particleSystem = "wizards_virge",
			offset = vec(0.9, 0, 0.2),
		},
	},
	tags = { "staves" },
}

defineParticleSystem{
	name = "wizards_virge",
	emitters = {
		-- runes
		{
			emissionRate = 4,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.15,  0,-0.2},
			boxMax = { 0.15,  0, 0.2},
			sprayAngle = {0,360},
			velocity = {0.05,0.1},
			texture = "assets/textures/particles/magic_runes.tga",
			frameRate = 2,
			frameSize = 32,
			frameCount = 9,
			lifetime = {1,2},
			colorAnimation = false,
			color0 = {1, 1, 1},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.05, 0.075},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 1,
			blendMode = "Additive",
			depthBias = 0.1,
			objectSpace = true,
		},
	
		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-0.1,-0.1, -0.2},
			boxMax = { 0.1, 0.1, 0.0},
			sprayAngle = {0,360},
			velocity = {0.05,0.1},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {3,3},
			color0 = {0.152941, 0.352941, 0.803922},
			opacity = 0.5,
			fadeIn = 2.2,
			fadeOut = 2.2,
			size = {0.15, 0.5},
			gravity = {0,0,0},
			airResistance = 0.25,
			rotationSpeed = 0.3,
			blendMode = "Additive",
		},

		-- stars
		{
			emissionRate = 25,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.1, 0,-0.2},
			boxMax = { 0.1, 0, 0.0},
			sprayAngle = {0,360},
			velocity = {0.05,0.1},
			objectSpace = true,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {2,2},
			color0 = {3.0,3.0,3.0},
			opacity = 0.8,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.13},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},

		-- glow
		{
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = { 0, 0, 0},
			boxMax = { 0, 0, 0},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/glow.tga",
			lifetime = {3,3},
			color0 = {0.4, 0.7, 1.0},
			opacity = 0.15,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.5, 0.5},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.2,
		},
	}
}

defineObject{
	name = "lightning_rod",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/lightning_rod.fbx",
		},
		{
			class = "Item",
			uiName = "Lightning Rod",
			description = "A rolling thunder can be heard every time this rod moves through the air.",
			gfxIndex = 222,
			gfxIndexPowerAttack = 441,
			impactSound = "impact_blunt",
			weight = 1.7,
			traits = { "orb" },
			secondaryAction = "shock",
		},
		{
			class = "MeleeAttack",
			attackPower = 14,
			accuracy = 0,
			cooldown = 4,
			damageType = "shock",
			swipe = "vertical",
			attackSound = "swipe",
			baseDamageStat = "none",
		},
		{
			class = "CastSpell",
			name = "shock",
			uiName = "Shock",
			cooldown = 5,
			spell = "shock",
			energyCost = 25,
			power = 3,
			charges = 9,
			fullGfxIndex = 222,
			emptyGfxIndex = 223,
			requirements = { "concentration", 1 },
		},
	},
	tags = { "weapon", "staves" },
}

defineObject{
	name = "serpent_staff",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/serpent_staff.fbx",
		},
		{
			class = "Item",
			uiName = "Serpent Staff",
			description = "A staff resembling a golden snake.",
			gfxIndex = 224,
			gfxIndexPowerAttack = 442,
			impactSound = "impact_blunt",
			weight = 2.6,
			traits = { "orb" },
			secondaryAction = "spit",
		},
		{
			class = "MeleeAttack",
			attackPower = 4,
			accuracy = 0,
			cooldown = 3,
			swipe = "vertical",
			causeCondition = "poisoned",
			conditionChance = 20,
		},
		{
			class = "CastSpell",
			name = "spit",
			uiName = "Spit",
			cooldown = 4,
			spell = "open_serpent_door",
			power = 1,
			energyCost = 15,
		},
	},
	tags = { "staves" },
}
