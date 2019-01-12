defineObject{
	name = "coldspike_bracelet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/metal_bracelet.fbx",
		},
		{
			class = "Item",
			uiName = "Coldspike Bracelet",
			description = "A spiked bracer that never melts, which sends a deep cold energy that only a magic user can withstand.",
			gameEffect = [[Cold damage +20%]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 39,
			weight = 0.3,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			resistFire = -15,
		},
	},
	tags = { "accessory" },
}

defineObject{
	name = "forestfire_bracer",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bronze_brace.fbx",
		},
		{
			class = "Item",
			uiName = "Forestfire Bracer",
			description = "An everburning enchanted bracer made with the bark of an ancient tree.",
			gameEffect = [[Fire damage +20%]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 40,
			weight = 0.3,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			resistCold = -15,
		},
	},
	tags = { "accessory" },
}

defineObject{
	name = "torment_bracer",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/hardstone_bracelet.fbx",
		},
		{
			class = "Item",
			uiName = "Torment Bracer",
			description = "An electrically charged device that constantly shocks the user.",
			gameEffect = [[Shock damage +20%]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 41,
			weight = 0.3,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			evasion = -15,
		},
	},
	tags = { "accessory" },
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
			gameEffect = [[Poison damage +20%
			Adds 10% chance to poison enemies with 
			melee and ranged attacks.]],
			gfxIndex = 29,
			weight = 0.5,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = -8,
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
			gameEffect = [[Cold damage +20%
			Adds cold resistance to the entire party +15%.]],
			gfxIndex = 26,
			weight = 0.2,
			traits = { "necklace", "upgradable" },
		},
		{
			class = "EquipmentItem",
			resistCold = 15,
			resistFire = -10,
		},
	},
	tags = { "accessory" },
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
			gameEffect = [[You gain 5% chance to recover a pellet 
			when firing with firearms.]],
			gfxIndex = 65,
			weight = 0.2,
			traits = { "necklace", "upgradable" },
		},
	},
	tags = { "accessory" },
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
			gameEffect = [[Fire damage +20%
			Adds fire resistance to the entire party +15%.]],
			gfxIndex = 67,
			weight = 0.2,
			traits = { "necklace"  },
		},
		{
			class = "EquipmentItem",
			resistFire = 15,
			resistCold = -10,
		},
	},
	tags = { "accessory" },
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
	tags = { "accessory" },
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
			gameEffect = [[Adds a small chance to gain +35 protection
			for 10 seconds when you get hit.]],
			gfxIndex = 27,
			weight = 0.3,
			traits = { "bracers", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			accuracy = 10,
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
			protection = 2,
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
		},
		{
			class = "EquipmentItem",
			evasion = 4,
			dexterity = 1,
			vitality = 1,
		},
	},
	tags = { "accessory" },
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
	tags = { "accessory" },
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
			weight = 1.5,
			traits = { "cloak" },
		},
		{
			class = "EquipmentItem",
			protection = 5,
		},
	},
	tags = { "accessory" },
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
			gfxIndex = 167,
			weight = 0.6,
			traits = { "cloak" },
		},
		{
			class = "EquipmentItem",
			energyRegenerationRate = 20,
		},
	},
	tags = { "accessory" },
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
	tags = { "accessory" },
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
			gameEffect = [[Cold damage +5%]],
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
	tags = { "accessory" },
}


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
		},
	},
	tags = { "accessory" },	
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
	tags = { "accessory" },
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
	tags = { "accessory" },
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
			gameEffect = [[Shock damage +20%
			Adds shock resistance to the entire party +15%.]],
			gfxIndex = 302,
			weight = 0.4,
			traits = { "necklace", "upgradable" },
		},
		{
			class = "EquipmentItem",
			resistShock = 15,
		},
	},
	tags = { "accessory" },
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
	tags = { "accessory" },
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
	tags = { "accessory" },
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
	tags = { "accessory" },
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
	tags = { "accessory" },
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
			gameEffect = "Food Consumption Rate + 20%",
		},
		{
			class = "EquipmentItem",
			energyRegenerationRate = 20,
			foodRate = 20,
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
			description = "This simple armband is commonly worn on the battlefield by professional warriors."
		},
		{
			class = "EquipmentItem",
			strength = 1,
			protection = 1,
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
			gameEffect = "Critical Chance +3%",
		},
		{
			class = "EquipmentItem",
			criticalChance = 3,
			resistShock = -20,
		},
	},
	tags = { "accessory" },
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
			description = "The leaves that adorn this cloak emit a soothing sound when they flutter in the breeze."
		},
		{
			class = "EquipmentItem",
			energy = 30,
			evasion = -2,
		},
	},
	tags = { "accessory" },
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
			description = "This cloak, made of bear skin, has a musty smell."
		},
		{
			class = "EquipmentItem",
			vitality = 2,
			resistCold = 20,
		},
	},
	tags = { "accessory" },
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
			weight = 0.5,
			traits = { "cloak" },
			description = "The fine threads of this cloak seem to blend into the surrounding shadows.",
		},
		{
			class = "EquipmentItem",
			evasion = 5,
			strength = -2,
		},
	},
	tags = { "accessory" },
}

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
			gfxIndex = 325,
			weight = 0.9,
			traits = { "gloves" },
		},
		{
			class = "EquipmentItem",
			strength = 4,
		},
	},
	tags = { "accessory" },
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
			gfxIndex = 324,
			weight = 0.9,
			traits = { "gloves" },
		},
		{
			class = "EquipmentItem",
			protection = 5,
			strength = 2,
			dexterity = 2,
		},
	},
	tags = { "accessory" },
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
	tags = { "accessory" },
}
