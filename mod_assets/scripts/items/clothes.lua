defineObject{
	name = "peasant_breeches",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/peasant_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Peasant's Breeches",
			gfxIndex = 6,
			weight = 0.5,
			traits = { "clothes", "leg_armor" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "peasant_tunic",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/peasant_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Peasant's Tunic",
			gfxIndex = 7,
			weight = 0.5,
			traits = { "clothes", "chest_armor" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "peasant_cap",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/peasant_clothes_small.fbx",
		},
		{
			class = "Item",
			uiName = "Peasant's Cap",
			gfxIndex = 8,
			weight = 0.2,
			traits = { "clothes", "helmet" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "leather_boots",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/leather_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Leather Boots",
			armorSet = "leather",
			gfxIndex = 35,
			weight = 2.6,
			traits = { "clothes", "boots", "dismantle", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "leather_pants",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/leather_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Leather Pants",
			gfxIndex = 54,
			weight = 2.0,
			traits = { "clothes", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "leather_gloves",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/leather_clothes_small.fbx",
		},
		{
			class = "Item",
			uiName = "Leather Gloves",
			gfxIndex = 53,
			weight = 0.2,
			traits = { "clothes", "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "loincloth",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blue_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Loincloth",
			description = "Only the most self confident of warriors can be seen on the battlefield wearing nothing but this garment.",
			gfxIndex = 32,
			weight = 0.4,
			traits = { "clothes", "leg_armor" },
		},
		{
			class = "EquipmentItem",
			willpower = -1,
			protection = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "doublet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/purple_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Doublet",
			gfxIndex = 36,
			weight = 1.0,
			traits = { "clothes", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "silk_hose",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blue_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Silk Hose",
			gfxIndex = 37,
			weight = 0.2,
			traits = { "clothes", "leg_armor" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "tattered_shirt",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/torn_breeches.fbx",
		},
		{
			class = "Item",
			uiName = "Tattered Shirt",
			gfxIndex = 270,
			weight = 0.3,
			traits = { "clothes", "chest_armor" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "torn_breeches",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/torn_breeches.fbx",
		},
		{
			class = "Item",
			uiName = "Torn Breeches",
			gfxIndex = 271,
			weight = 0.3,
			traits = { "clothes", "leg_armor" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "shoes",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/shoes.fbx",
		},
		{
			class = "Item",
			uiName = "Shoes",
			gfxIndex = 272,
			weight = 1.0,
			traits = { "clothes", "boots" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
		},
	},
	tags = { "armor_clothes" },
}


defineObject{
	name = "xafi_khakis",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/xafi_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Xafi Khakis",
			description = "Suitable for desert conditions, these pants are made of a lightweight fabric.",
			gfxIndex = 248,
			weight = 0.5,
			traits = { "clothes", "leg_armor" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "xafi_robe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/xafi_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Xafi Robe",
			description = "This robe protects its wearer from the biting cold and burning heat of the Xafi desert.",
			gfxIndex = 249,
			weight = 0.5,
			traits = { "clothes", "chest_armor" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "xafi_shemagh",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/xafi_clothes_small.fbx",
		},
		{
			class = "Item",
			uiName = "Xafi Shemagh",
			description = "The fabric of the shemagh keeps the all pervasive desert dust out of the mouth and nostrils of Xafi caravan masters.",
			gfxIndex = 250,
			weight = 0.2,
			traits = { "clothes", "helmet" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "sandals",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/sandals.fbx",
		},
		{
			class = "Item",
			uiName = "Sandals",
			gfxIndex = 33,
			weight = 0.8,
			traits = { "clothes", "boots" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
		},
	},
	tags = { "armor_clothes" },
}

-- Clothes with other bonuses

defineObject{
	name = "flarefeather_cap",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flarefeather_cap.fbx",
		},
		{
			class = "Item",
			uiName = "Flarefeather Cap",
			description = "A felt cap that dons a feather of a flarebird.",
			gfxIndex = 38,
			weight = 0.3,
			traits = { "clothes", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
			dexterity = 3,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "circlet_war",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/circlet_war.fbx",
		},
		{
			class = "Item",
			uiName = "Circlet of War",
			description = "The steel from the weapons of a surrendered enemy regiment was melted and forged into a crown for their new king.",
			gfxIndex = 71,
			weight = 1.5,
			traits = { "clothes", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
			strength = 3,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "pointy_shoes",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/pointy_shoes.fbx",
		},
		{
			class = "Item",
			uiName = "Pointy Shoes",
			gfxIndex = 166,
			weight = 1.0,
			traits = { "clothes", "boots" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
			dexterity = 1,
			willpower = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "nomad_boots",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/nomad_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Nomad Boots",
			description = "Thick boots that can keep the freezing winds of a tundra at bay.",
			gfxIndex = 9,
			weight = 3.5,
			traits = { "clothes", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
			resistCold = 10,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "conjurers_hat",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/conjurers_hat.fbx",
		},
		{
			class = "Item",
			uiName = "Conjurer's Hat",
			description = "This old, worn hat has been used by numerous wizards. The felt still has residues of energy and knowledge from its previous owners.",
			gfxIndex = 70,
			weight = 0.5,
			traits = { "clothes", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 1,
			willpower = 3,
			resistAll = 5,
		},
	},
	tags = { "armor_clothes" },
}

-- Lurker set

defineObject{
	name = "lurker_pants",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/lurker_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Lurker Pants",
			description = "A pair of pants woven from fine, lightweight thread.",
			armorSet = "lurker",
			gfxIndex = 39,
			weight = 0.5,
			armorSetPieces = 4,
			gameEffect = [[
			[Lurker Set]
			Invisibility effect and cost halved.
			Poison Bombs create a smoke cloud instead of poison. You gain Invisibility when you walk into the smoke.]],
			traits = { "clothes", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			evasion = 5,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "lurker_vest",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/lurker_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Lurker Vest",
			description = "A vest made from a material that seems to blend into surrounding shadows.",
			armorSet = "lurker",
			armorSetPieces = 4,
			gameEffect = [[
			[Lurker Set]
			Invisibility effect and cost halved.
			Poison Bombs create a smoke cloud instead of poison. You gain Invisibility when you walk into the smoke.]],
			gfxIndex = 40,
			weight = 0.75,
			traits = { "clothes", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			evasion = 5,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "lurker_hood",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/lurker_clothes_small.fbx",
		},
		{
			class = "Item",
			uiName = "Lurker Hood",
			description = "A dark hood that covers the head.",
			armorSet = "lurker",
			gfxIndex = 41,
			gameEffect = [[
			[Lurker Set]
			Invisibility effect and cost halved.
			Poison Bombs create a smoke cloud instead of poison. You gain Invisibility when you walk into the smoke.]],
			weight = 0.25,
			traits = { "clothes", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			evasion = 5,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "lurker_boots",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/lurker_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Lurker Boots",
			description = "A skilled thief can move completely silently when wearing these boots.",
			armorSet = "lurker",
			gfxIndex = 141,
			weight = 0.25,
			gameEffect = [[
			[Lurker Set]
			Invisibility effect and cost halved.
			Poison Bombs create a smoke cloud instead of poison. You gain Invisibility when you walk into the smoke.]],
			traits = { "clothes", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			evasion = 5,
		},
	},
	tags = { "armor_clothes" },
}

-- Embalmer's set

defineObject{
	name = "embalmers_boots",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/embalmers_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Embalmer's Shoes",
			description = "Infused with smelly ointments and herbs, these boots help keep an embalmer's feet from tiring out during lengthy rituals.",
			gfxIndex = 246,
			weight = 1.2,
			armorSet = "embalmers",
			armorSetPieces = 4,
			gameEffect = [[
			[Embalmer's Set (4)]
			Poison Resist +20
			Disease and Poisoned Resist +50.
			Undead near you are vulnerable to poison.]],
			traits = { "clothes", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 2,
			vitality = 1,			
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "embalmers_headpiece",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/embalmers_headpiece.fbx",
		},
		{
			class = "Item",
			uiName = "Embalmer's Headpiece",
			description = "An ornate hat worn by the conclave of Xafi embalmers.",
			gfxIndex = 247,
			weight = 0.5,
			armorSet = "embalmers",
			armorSetPieces = 4,
			gameEffect = [[
			[Embalmer's Set (4)]
			Poison Resist +20
			Disease and Poisoned Resist +50.
			Undead near you are vulnerable to poison.]],
			traits = { "clothes", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			vitality = 1,
		}
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "embalmers_robe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/embalmers_robe.fbx",
		},
		{
			class = "Item",
			uiName = "Embalmer's Robe",
			description = "A ceremonial robe with numerous hidden pockets filled with tiny vials of putrid smelling chemicals.",
			gfxIndex = 244,
			weight = 0.5,
			armorSet = "embalmers",
			armorSetPieces = 4,
			gameEffect = [[
			[Embalmer's Set (4)]
			Poison Resist +20
			Disease and Poisoned Resist +50.
			Undead near you are vulnerable to poison.]],
			traits = { "clothes", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			vitality = 2,
			onRecomputeStats = function(self, champion)
				if functions.script.isArmorSetEquipped(champion, "embalmers") then
					champion:addStatModifier("resist_poison", 20)
				end
			end,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "embalmers_pants",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/embalmers_pants.fbx",
		},
		{
			class = "Item",
			uiName = "Embalmer's Pants",
			description = "Various talismans and fragrant herbs used in secret embalming rituals hang off the belt.",
			gfxIndex = 245,
			weight = 0.5,
			armorSet = "embalmers",
			armorSetPieces = 4,
			gameEffect = [[
			[Embalmer's Set (4)]
			Poison Resist +20
			Disease and Poisoned Resist +50.
			Undead near you are vulnerable to poison.]],
			traits = { "clothes", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			vitality = 1,
		},
	},
	tags = { "armor_clothes" },
}

-- Archmage set

defineObject{
	name = "archmage_scapular",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/archmage_scapular.fbx",
		},
		{
			class = "Item",
			uiName = "Archmage's Scapular",
			description = "The archmages of the Academy of Des are known to weave various mystical enchantments into their robes.",
			gameEffect = [[
			[Archmage's Set] 
			Monsters below 14% health (Max 777 hp) are instantly killed by your spells.]],
			armorSet = "archmage",
			armorSetPieces = 4,
			gfxIndex = 479,
			gfxIndexArmorSet = 342,
			weight = 0.5,
			traits = { "clothes", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
			willpower = 1,
			resistAll = 10,
			onRecomputeStats = function(self, champion)

			end,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "archmage_mantle", -- (pants)
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/archmage_mantle.fbx",
		},
		{
			class = "Item",
			uiName = "Archmage's Mantle",
			description = "Magical runes adorn this mantle, which was worn by a long since forgotten archmage.",
			gameEffect = [[[Archmage's Set] Monsters below 7% health (Max 777 hp) are instantly killed by your spells.]],
			armorSet = "archmage",
			armorSetPieces = 4,
			gfxIndex = 478,			
			gfxIndexArmorSet = 341,
			weight = 0.5,
			traits = { "clothes", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			willpower = 1,
			resistAll = 5,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "archmage_hat",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/archmage_hat.fbx",
		},
		{
			class = "Item",
			uiName = "Archmage's Cap",
			description = "Headwear is of great importance to many mages since the Academy of Des regards the head as the most potent source of magical energy in the body.",
			gameEffect = [[[Archmage's Set] Monsters below 7% health (Max 777 hp) are instantly killed by your spells.]],
			armorSet = "archmage",
			armorSetPieces = 4,
			gfxIndex = 480,	
			gfxIndexArmorSet = 343,
			weight = 0.2,
			traits = { "clothes", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			willpower = 1,
			resistAll = 5,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "archmage_loafers",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/archmage_loafers.fbx",
		},
		{
			class = "Item",
			uiName = "Archmage's Loafers",
			description = "Considerable magical energy has flowed through these well-worn enchanted loafers.",
			gameEffect = [[[Archmage's Set] Monsters below 7% health (Max 777 hp) are instantly killed by your spells.]],
			armorSet = "archmage",
			armorSetPieces = 4,
			gfxIndex = 481,	
			gfxIndexArmorSet = 344,
			weight = 1.0,
			traits = { "clothes", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			willpower = 1,
			resistAll = 5,
		},
	},
	tags = { "armor_clothes" },
}

-- Rogue set

defineObject{
	name = "rogue_vest",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rogue_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Rogue Vest",
			description = "A vest made from a material that seems to blend into the surrounding shadows.",
			gameEffect = [[
			[Rogue Set] 
			Back Attacks gain 25% Critical Chance.
			Speed Potions last twice as long and their duration is extended when an enemy dies.]],
			armorSet = "rogue",
			armorSetPieces = 5,
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 104,
			gfxIndexArmorSet = 109,	
			weight = 0.75,
			traits = { "clothes", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 5,
			dexterity = 1,
			onRecomputeStats = function(self, champion)
			
			end,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "rogue_pants",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rogue_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Rogue Pants",
			description = "A pair of pants woven from fine, lightweight thread.",
			gameEffect = [[
			[Rogue Set] 
			Back Attacks gain 25% Critical Chance.
			Speed Potions last twice as long and their duration is extended when an enemy dies.]],
			armorSet = "rogue",
			armorSetPieces = 5,
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 105,
			gfxIndexArmorSet = 110,	
			weight = 0.5,
			traits = { "clothes", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 5,
			dexterity = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "rogue_hood",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rogue_clothes_small.fbx",
		},
		{
			class = "Item",
			uiName = "Rogue Hood",
			description = "A dark hood that covers the head.",
			gameEffect = [[
			[Rogue Set] 
			Back Attacks gain 25% Critical Chance.
			Speed Potions last twice as long and their duration is extended when an enemy dies.]],
			armorSet = "rogue",
			armorSetPieces = 5,
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 106,
			gfxIndexArmorSet = 111,	
			weight = 0.25,
			traits = { "clothes", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
			dexterity = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "rogue_boots",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rogue_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Rogue Boots",
			description = "A skilled thief can move completely silently when wearing these boots.",
			gameEffect = [[
			[Rogue Set] 
			Back Attacks gain 25% Critical Chance.
			Speed Potions last twice as long and their duration is extended when an enemy dies.]],
			armorSet = "rogue",
			armorSetPieces = 5,
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 108,
			gfxIndexArmorSet = 113,	
			weight = 0.25,
			traits = { "clothes", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			dexterity = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "rogue_boots_2",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rogue_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Merv's Rogue Boots",
			description = "These boots once belonged to the fastest man alive.",
			gameEffect = [[
			[Rogue Set] 
			Back Attacks gain 25% Critical Chance.
			Speed Potions last twice as long and their duration is extended when an enemy dies.]],
			armorSet = "rogue",
			armorSetPieces = 5,
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 108,
			gfxIndexArmorSet = 113,	
			weight = 0.3,
			traits = { "clothes", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			dexterity = 1,
		},
	},
	tags = { "armor_clothes" },
}

defineObject{
	name = "rogue_gloves",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rogue_clothes_small.fbx",
		},
		{
			class = "Item",
			uiName = "Rogue Gloves",
			description = "The fingers of these gloves are covered with a thin layer of gumtree nectar for enhanced grip.",
			gameEffect = [[
			[Rogue Set] 
			Back Attacks gain 25% Critical Chance.
			Speed Potions last twice as long and their duration is extended when an enemy dies.]],
			armorSet = "rogue",
			armorSetPieces = 5,
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 107,
			gfxIndexArmorSet = 112,	
			weight = 0.3,
			traits = { "clothes", "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			dexterity = 1,
		},
	},
	tags = { "armor_clothes" },
}
