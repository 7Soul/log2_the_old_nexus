defineObject{
	name = "coldspike_bracelet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/metal_bracelet.fbx",
			material = "coldspike_bracelet",
		},
		{
			class = "Item",
			uiName = "Coldspike Bracelet",
			description = "A spiked bracer that mantains itself under freezing temperatures. This cold can unly be withstood by a powerful magic user.\n\nCan be upgraded with a Aquamarine Gem.",
			gameEffect = [[Cold damage +20%
			Increases base freezing chance of Frost Gust by 5%]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 39,
			weight = 0.5,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			resistFire = -25,
		},
		{
			class = "Particle",
			particleSystem = "coldspike_bracelet",
		}
	},
	tags = { "accessory" },
}

defineParticleSystem{
	name = "coldspike_bracelet",
	emitters = {
		-- smoke
		{
			emissionRate = 4,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,30},
			velocity = {0.01,0.1},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.9, 1.25, 1.5},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.3},
			gravity = {0,-0.2,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},

		-- cold
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.1, 0,  -0.1},
			boxMax = { 0.1, 0.1, 0.1},
			sprayAngle = {0,10},
			velocity = {0.1, 0.1},
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.25, 0.85},
			colorAnimation = true,
			color0 = {0.25, 1, 2},
			color1 = {0.25, 1.0, 2.0},
			color2 = {0.25, 0.5, 1.0},
			color3 = {0.1, 0.3, 1.0},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.035, 0.01},
			gravity = {0,0.5,0},
			airResistance = 1.0,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.1,
		},
	}
}

defineObject{
	name = "forestfire_bracer",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bracelet_tirin.fbx",
			material = "forestfire_bracer",
		},
		{
			class = "Item",
			uiName = "Forestfire Bracer",
			description = "An everburning enchanted bracer made with the bark of an ancient tree.",
			gameEffect = [[Fire damage +20%
			Increases base burn chance of Fireburst by 20%]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 40,
			weight = 0.3,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			resistCold = -25,
		},
		{
			class = "Particle",
			particleSystem = "forestfire_bracer",
		}
	},
	tags = { "accessory" },
}

defineParticleSystem{
	name = "forestfire_bracer",
	emitters = {
		-- fog
		{
			emissionRate = 2,
			emissionTime = 0,
			maxParticles = 20,
			boxMin = {-0.05, -0.05,-0.05},
			boxMax = { 0.05, 0.15, 0.05},
			sprayAngle = {0,360},
			velocity = {0.1,0.2},
			--objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {2,2},
			color0 = {0.2, 0.2, 0.2},
			opacity = 0.9,
			fadeIn = 1.3,
			fadeOut = 1.9,
			size = {0.05, 0.5},
			gravity = {0,0.5,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Translucent",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},

		-- flames
		{
			emissionRate = 2,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {-0.05, -0.05,-0.05},
			boxMax = { 0.05, 0.15, 0.05},
			sprayAngle = {0,360},
			velocity = {0.1,0.3},
			texture = "assets/textures/particles/flame.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.5,1},
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.05, 0.2},
			gravity = {0,0.1,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},

		-- sparks
		{
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 5,
			boxMin = {-0.05, -0.05,-0.05},
			boxMax = { 0.05, 0.05, 0.05},
			sprayAngle = {0,360},
			velocity = {0.1,0.5},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {1,3},
			colorAnimation = true,
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.01, 0.08},
			gravity = {0,0.9,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}

defineObject{
	name = "torment_bracer",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/brace_fortitude.fbx",
			material = "torment_bracer",
		},
		{
			class = "Item",
			uiName = "Torment Bracer",
			description = "An electrically charged device that constantly shocks the user.",
			gameEffect = [[Shock damage +20%
			Increases base arc chance of the Shock Rift spell by 10%]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 41,
			weight = 0.75,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			evasion = -15,
		},
		
		{
			class = "Particle",
			particleSystem = "torment_bracer",
		}
	},
	tags = { "accessory" },
}

defineParticleSystem{
	name = "torment_bracer",
	emitters = {
		-- smoke bright
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,30},
			velocity = {0.01,0.1},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.9, 1.25, 1.5},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.3},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},
		
		-- smoke dark
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,30},
			velocity = {0.01,0.1},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.25, 0.25, 0.25},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.3},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},

		-- shock
		{
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 2,
			boxMin = {-0.05, 0,  -0.05},
			boxMax = { 0.05, 0, 0.05},
			sprayAngle = {0,360},
			velocity = {0.3, 0.6},
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.25, 1.0},
			colorAnimation = true,
			color0 = {0.7, 2, 1},
			color1 = {0.25, 2, 1},
			color2 = {0.25, 1.5, 1},
			color3 = {0.1, 1.3, 1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.1, 0.2},
			gravity = {0,0.0,0},
			airResistance = 1.0,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.1,
		},
	}
}

defineObject{
	name = "serpent_bracer",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/serpent_bracer.fbx",
		},
		{
			class = "Item",
			uiName = "Serpent Bracer",
			description = "A bracer fashioned after a venomous tropical snake. The teeth of the snake bite into the forearm of its wearer.",
			gameEffect = [[Poison damage +20%.
			Adds 10% chance to poison enemies with melee and ranged attacks.]],
			gfxIndex = 29,
			weight = 0.5,
			traits = { "bracers", "upgradable", "venomancer" },
		},
		{
			class = "EquipmentItem",
			protection = -15,
		},
	},
	tags = { "accessory" },
}

defineObject{
	name = "frostbite_necklace",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/frostbite_necklace.fbx",
		},
		{
			class = "Item",
			uiName = "Frostbite Necklace",
			description = "This necklace, made out of Ice Lizard teeth, freezes everything it lays on but feels warm to touch.",
			gameEffect = [[+15 cold resistance to the entire party.]],
			gfxIndex = 26,
			weight = 0.2,
			traits = { "necklace", "upgradable" },
		},
		{
			class = "EquipmentItem",
			resistCold = 15,
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "fire_torc",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/fire_torc.fbx",
		},
		{
			class = "Item",
			uiName = "Fire Torc",
			description = "Two metal bands that clamp tightly around the neck. A faint sound of crackling embers can be heard emanating from it.",
			gameEffect = [[+15 fire resistance to the entire party.]],
			gfxIndex = 67,
			weight = 0.2,
			traits = { "necklace"  },
		},
		{
			class = "EquipmentItem",
			resistFire = 15,
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "storm_amulet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/storm_amulet.fbx",
		},
		{
			class = "Item",
			uiName = "Storm Amulet",
			description = "",
			gameEffect = [[+15 shock resistance to the entire party.]],
			gfxIndex = 302,
			weight = 0.4,
			traits = { "necklace", "upgradable" },
		},
		{
			class = "EquipmentItem",
			resistShock = 15,
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "bone_amulet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bone_amulet.fbx",
		},
		{
			class = "Item",
			uiName = "Bone Amulet",
			description = "A primitive amulet made out of bones that are bound together with string.",
			gameEffect = [[5% chance to recover a pellet when firing with firearms.]],
			gfxIndex = 65,
			weight = 0.2,
			traits = { "necklace", "upgradable" },
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "spirit_mirror_pendant",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/spirit_mirror_pendant.fbx",
		},
		{
			class = "Item",
			uiName = "Spirit Mirror Pendant",
			description = "The memories of countless heroes, long since dead, have been captured in this shiny pendant.",
			gfxIndex = 74,
			weight = 0.2,
			traits = { "necklace", "upgradable" },
		},
		{
			class = "EquipmentItem",
			expRate = 20,
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "hardstone_bracelet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/hardstone_bracelet.fbx",
		},
		{
			class = "Item",
			uiName = "Hardstone Bracelet",
			description = "A bracelet that the warriors of the hill tribes pass on from generation to generation.",
			gameEffect = [[Adds a 20% chance to gain +3 Strength +30 Protection for 10 seconds when you get hit.]],
			gfxIndex = 27,
			weight = 0.3,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
		},
	},
	tags = { "accessory" },
}

defineObject{
	name = "bracelet_tirin",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bracelet_tirin.fbx",
		},
		{
			class = "Item",
			uiName = "Bracelet of Tirin",
			description = "A bracelet that is only awarded to the few who can pass the initiation rites of the cult of Tirin.",
			gfxIndex = 68,
			weight = 0.5,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			strength = 1,
			willpower = 1,
			cooldownRate = 15,
		},
	},
	tags = { "accessory" },
}

defineObject{
	name = "brace_fortitude",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/brace_fortitude.fbx",
		},
		{
			class = "Item",
			uiName = "Brace of Fortitude",
			description = "This brace is made out of a single solid piece of metal but it feels exceptionally light.",
			gfxIndex = 75,
			weight = 0.15,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			strength = 2,
			foodRate = 20,
			healthRegenerationRate = 20,
		},
	},
	tags = { "accessory" },
}


defineObject{
	name = "leafbond_bracelet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/leafbond_bracelet.fbx",
		},
		{
			class = "Item",
			uiName = "Leafbond Bracelet",
			gfxIndex = 311,
			weight = 0.3,
			traits = { "bracers", "upgradable" },
			description = "The roots of this bracelet dig into the arm of its wearer, feeding from its host.",
			gameEffect = "Food Consumption Rate + 25%",
		},
		{
			class = "EquipmentItem",
			energyRegenerationRate = 40,
			foodRate = 25,
		},
	},
	tags = { "accessory" },
}

defineObject{
	name = "steel_armband",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/metal_bracelet.fbx",
		},
		{
			class = "Item",
			uiName = "Steel Armband",
			gfxIndex = 312,
			weight = 0.6,
			traits = { "bracers", "upgradable" },
			description = "This simple armband is commonly worn on the battlefield by professional warriors.",
			gameEffect = "+10 Protection and +10% Damage with Power Attacks for each piece of armor (Head, Body, Legs and Feet) that you're not wearing.",
		},
		{
			class = "EquipmentItem",
			strength = -1,
			protection = -5,
			onRecomputeStats = function(self, champion)
				local bonus = 4
				if champion:getItem(ItemSlot.Head) then bonus = bonus - 1 end
				if champion:getItem(ItemSlot.Chest) then bonus = bonus - 1 end
				if champion:getItem(ItemSlot.Legs) then bonus = bonus - 1 end
				if champion:getItem(ItemSlot.Feet) then bonus = bonus - 1 end
				if bonus > 0 then
					champion:addStatModifier("protection", bonus * 10)
				end
			end
		},
	},
	tags = { "accessory" },
}

defineObject{
	name = "bronze_brace",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bronze_brace.fbx",
		},
		{
			class = "Item",
			uiName = "Bronze Brace",
			gfxIndex = 313,
			weight = 0.6,
			traits = { "bracers", "upgradable" },
			description = "The surface of this wristband is covered with tiny runes which are almost too faint to be seen with the naked eye.",
			gameEffect = "Critical Chance +6%",
		},
		{
			class = "EquipmentItem",
			criticalChance = 6,
			resistShock = -20,
		},
	},
	tags = { "accessory" },
}

-- Necklaces

defineObject{
	name = "gear_necklace",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/gear_necklace.fbx",
		},
		{
			class = "Item",
			uiName = "Gear Necklace",
			gfxIndex = 219,
			weight = 1.0,
			traits = { "necklace", "upgradable" },
			description = "A heavy, metal machine part from distant past."
		},
		{
		class = "EquipmentItem",
		energy = 15,
		health = 15,
		healthRegenerationRate = 10,
		energyRegenerationRate = 10,
		resistFire = 2,
		resistCold = 2,
		resistShock = 2,
		resistPoison = 2,
		},
	},
	tags = { "necklace" },	
}

defineObject{
	name = "ring_string",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/string_and_ring.fbx",
		},
		{
			class = "Item",
			uiName = "Ring on a String",
			gfxIndex = 300,
			weight = 2,
			traits = { "necklace", "level_up" },
			description = "A golden ring hanging in a simple leather wound string. Gravity seems to have an unnaturally strong pull on the ring. Faint writing of some unknown language has been masterfully engraved on the outer surface of the ring. You hear ominous whispers seducing you with its power."
		},
		{
			class = "Particle",
			particleSystem = "glitter_gold",
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "crystal_amulet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_amulet.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Amulet",
			gfxIndex = 301,
			weight = 0.4,
			traits = { "necklace", "upgradable" },
			description = "This amulet was precisely cut from a living crystal. When you place it close to your ear, you can hear a soothing humming sound. The amulet protects its wearer with great magics.",
			gameEffect = "Wearer gains immunity to poison, disease, paralysis, slow, blindness and petrify conditions.",
		},
		{
			class = "EquipmentItem",
			immunities = { "poison", "diseased", "paralyzed", "slow", "blind", "petrified" },
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "runestone_necklace",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/runestone_necklace.fbx",
		},
		{
			class = "Item",
			uiName = "Runestone Necklace",
			gfxIndex = 303,
			weight = 0.1,
			traits = { "necklace", "upgradable" },
		},
		{
			class = "EquipmentItem",
			willpower = 2,
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "neck_chain",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/neck_chain.fbx",
		},
		{
			class = "Item",
			uiName = "Neck Chain",
			gfxIndex = 304,
			weight = 2.6,
			traits = { "necklace", "upgradable" },
			description = "The master craftsmen who built the great pyramids in the Xafi Desert wore these heavy chains around their necks. It is said that the chains were the source of their inhuman constitution.",
			gameEffect = "Wearer gains immunity to starvation and burdened conditions.",
		},
		{
			class = "EquipmentItem",
			immunities = { "burdened", "starving" },
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "nergal_amulet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/nergal_amulet.fbx",
		},
		{
			class = "Item",
			uiName = "Amulet of Nergal",
			gfxIndex = 305,
			weight = 0.4,
			traits = { "necklace", "upgradable" },
			description = "This powerful amulet is imbued with dark forces. The spirits within grant the wearer uncanny powers over death itself.",
		},
		{
			class = "EquipmentItem",
			health = 50,
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "jewel_pendant",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/jewel_pendant.fbx",
		},
		{
			class = "Item",
			uiName = "Jewel Pendant",
			gfxIndex = 306,
			weight = 0.7,
			traits = { "necklace", "upgradable" },
			description = "The golden necklace itself would be worth a fortune. The huge amethyst attached to it makes you rich beyond your wildest dreams.",
		},
		{
			class = "EquipmentItem",
			willpower = 4,
		},
	},
	tags = { "necklace" },
}

defineObject{
	name = "spiritwalker_pendant",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/spiritwalker_pendant.fbx",
		},
		{
			class = "Item",
			uiName = "Spiritwalker Pendant",
			gfxIndex = 307,
			weight = 0.3,
			traits = { "necklace", "upgradable" },
		},
		{
			class = "EquipmentItem",
			energy = 50,
			dexterity = 2,
		},
	},
	tags = { "necklace" },
}

-- Cloaks

defineObject{
	name = "huntsman_cloak",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/huntsman_cloak.fbx",
		},
		{
			class = "Item",
			uiName = "Huntsman Cloak",
			gfxIndex = 28,
			weight = 0.8,
			traits = { "cloak" },
			description = "",
			gameEffect = [[Increases damage with Missile Weapons by 10%.]],
		},
		{
			class = "EquipmentItem",
			evasion = 4,
			dexterity = 1,
			vitality = 1,
		},
	},
	tags = { "cloak" },
}

defineObject{
	name = "tattered_cloak",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/peasant_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Tattered Cloak",
			gfxIndex = 66,
			weight = 0.4,
			traits = { "cloak" },
		},
		{
			class = "EquipmentItem",
			evasion = 2,
		},
	},
	tags = { "cloak" },
}

defineObject{
	name = "scaled_cloak",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/scaled_cloak.fbx",
		},
		{
			class = "Item",
			uiName = "Scaled Cloak",
			gfxIndex = 72,
			weight = 2.5,
			gameEffect = [[10% chance to shield the party from fire when taking fire damage.]],
			traits = { "cloak" },
		},
		{
			class = "EquipmentItem",
			protection = 5,
			evasion = -10,
			resistFire = 15,
		},
	},
	tags = { "cloak" },
}

defineObject{
	name = "diviner_cloak",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/diviner_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Diviner's Cloak",
			description = "A fine cloak, woven with fibers that resonate with the faint arcane energies of the surrounding nature.",
			gameEffect = [[You recover 20 Energy when drinking any potion.]],
			gfxIndex = 167,
			weight = 0.6,
			traits = { "cloak" },
		},
		{
			class = "EquipmentItem",
			energyRegenerationRate = 20,
		},
	},
	tags = { "cloak" },
}

defineObject{
	name = "shaman_cloak",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/cloak_of_leaves.fbx",
		},
		{
			class = "Item",
			uiName = "Shaman's Cloak",
			gfxIndex = 319,
			weight = 1.5,
			traits = { "cloak" },
			description = "The leaves that adorn this cloak emit a soothing sound when they flutter in the breeze.",
			gameEffect = [[Poison spells cost 20% less energy.]],
		},
		{
			class = "EquipmentItem",
			energy = 20,
			evasion = -2,
		},
	},
	tags = { "cloak" },
}

defineObject{
	name = "bear_pelt",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bear_pelt.fbx",
		},
		{
			class = "Item",
			uiName = "Bear Pelt",
			gfxIndex = 320,
			weight = 2.5,
			traits = { "cloak" },
			description = "This cloak, made of bear skin, has a musty smell.",
			gameEffect = [[
			
			[Bearclaw Gauntlets and Bear Pelt Set Bonus]
			While in bear form you gain +10.
			Extends bear form duration.]],
		},
		{
			class = "EquipmentItem",
			vitality = 2,
			resistCold = 20,
			onRecomputeStats = function(self, champion)
				if champion:hasCondition("bear_form") then
					if champion:getItem(ItemSlot.Gloves) and champion:getItem(ItemSlot.Gloves).go.name == "bearclaw_gauntlets" then
						champion:addStatModifier("strength", 10)
						if not champion:hasCondition("bear_bonus") then champion:setConditionValue("bear_bonus", 2) end
					end
				end
			end
		},
	},
	tags = { "cloak" },
}

defineObject{
	name = "spidersilk_cloak",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/spidersilk_cloak.fbx",
		},
		{
			class = "Item",
			uiName = "Spidersilk Cloak",
			gfxIndex = 321,
			weight = 0.1,
			traits = { "cloak" },
			description = "The fine threads of this cloak seem to blend into the surrounding shadows.",
			gameEffect = [[Invisibility lasts 10 more seconds (affects entire party).
			You gain +40 Cold Resist for 30 seconds after leaving invisibility.]],
		},
		{
			class = "EquipmentItem",
			evasion = 8,
			strength = -2,
		},
	},
	tags = { "cloak" },
}

-- Gloves

defineObject{
	name = "bearclaw_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bear_claw.fbx",
		},
		{
			class = "Item",
			uiName = "Bearclaw Gauntlets",
			description = "These powerful enchanted gauntlets are rumored to be made from the severed paws of a polymorphed bear cult shaman.",
			gameEffect = [[Melee power attacks deal 15% more damage.

			[Bearclaw Gauntlets and Bear Pelt Set Bonus]
			While in bear form you gain +10 Strength.
			Extends bear form duration.]],
			gfxIndex = 325,
			weight = 0.9,
			traits = { "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			strength = 4,
		},
	},
	tags = { "gloves" },
}

defineObject{
	name = "steel_knuckles",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/gauntlet_of_power.fbx",
		},
		{
			class = "Item",
			uiName = "Knuckles of Steel",
			description = "These gauntlets seem to enhance and strengthen every movement of your hands.",
			gameEffect = [[6% chance to attack twice with Light Weapons and Staves.]],
			gfxIndex = 324,
			weight = 0.9,
			traits = { "gloves" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
			strength = 1,
			dexterity = 1,
		},
	},
	tags = { "gloves" },
}

defineObject{
	name = "fire_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/fire_gauntlets.fbx",
		},
		{
			class = "Item",
			uiName = "Gauntlets of Fire",
			description = "These gauntlets will slowly burn a hole into anything that they touch. Strangely enough, their wearer is always left unharmed.",
			gfxIndex = 327,
			weight = 0.4,
			traits = { "gloves", "fire_gauntlets" },
			gameEffect = "Turns damage type of melee attacks to fire damage."
		},
		{
			class = "EquipmentItem",
			protection = 5,
			resistFire = 15,
		},
	},
	tags = { "gloves" },
}

defineObject{
	name = "pit_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/pit_gauntlets.fbx",
		},
		{
			class = "Item",
			uiName = "Pit Fighter Gauntlets",
			description = "A type of glove usually worn by slaves pitted to fight to the death.",
			gameEffect = [[Adds 25% resistance to hand injuries and bleeding.]],
			gfxIndex = 18,
			weight = 0.9,
			traits = { "gloves" },
		},
		{
			class = "EquipmentItem",
			strength = 2,
			protection = 3,
		},
	},
	tags = { "gloves" },
}

defineObject{
	name = "nomad_mittens",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/nomad_clothes_small.fbx",
		},
		{
			class = "Item",
			uiName = "Nomad Mittens",
			description = "Thick mittens worn by the tribesmen who live and travel with horned beasts in the far away tundras.",
			gameEffect = [[Cold damage +5%
			Cold spells freeze for 1 more second.]],
			gfxIndex = 52,
			weight = 0.4,
			traits = { "gloves" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
			resistCold = 5,
		},
	},
	tags = { "gloves" },
}