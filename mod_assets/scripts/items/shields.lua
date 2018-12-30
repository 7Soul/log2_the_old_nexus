-- All shields must be tagged with "shield" for Shield Expert talent!

defineObject{
	name = "tribal_shield",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tribal_shield.fbx",
		},
		{
			class = "Item",
			uiName = "Tribal Shield",
			gfxIndex = 252,
			weight = 3.8,
			traits = { "shield", "upgradable" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 2,
		},
	},
}

defineObject{
	name = "makeshift_buckler",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/makeshift_buckler.fbx",
		},
		{
			class = "Item",
			uiName = "Thraelm Tribal Buckler",
			description = "Judging from the numerous cuts and notches, this otherwise ceremonial-looking simple shield has definitely been used in many battles.",
			gfxIndex = 299,
			weight = 3.0,
			traits = { "shield", "upgradable" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 2,
			energy = 5,
		},
	},
}

-- defineObject{
-- 	name = "legionary_shield",
-- 	baseObject = "base_item",
-- 	components = {
-- 		{
-- 			class = "Model",
-- 			model = "assets/models/items/skeleton_shield.fbx",
-- 		},
-- 		{
-- 			class = "Item",
-- 			uiName = "Legionary Shield",
-- 			gfxIndex = 207,
-- 			weight = 6.5,
-- 			traits = { "shield", "upgradable" },
-- 		},
-- 		{
-- 			class = "EquipmentItem",
-- 			slot = "Weapon",
-- 			evasion = 5,
-- 		},
-- 	},
-- }

defineObject{
	name = "round_shield",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/small_shield.fbx",
		},
		{
			class = "Item",
			uiName = "Round Shield",
			gfxIndex = 55,
			weight = 3.8,
			traits = { "shield", "upgradable" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 4,
		},
	},
}

defineObject{
	name = "skeleton_knight_shield",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skeleton_knight_shield.fbx",
		},
		{
			class = "Item",
			uiName = "Ancient Shield",
			gfxIndex = 295,
			weight = 4.0,
			traits = { "shield", "upgradable" },
			description = "This shield radiates unholy energy.",
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 5,
			health = -15,
		},
	},
}

defineObject{
	name = "heavy_shield",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/heavy_shield.fbx",
		},
		{
			class = "Item",
			uiName = "Heavy Shield",
			gfxIndex = 15,
			weight = 8.0,
			traits = { "shield", "upgradable" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 6,
		},
	},
}

defineObject{
	name = "shield_elements",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/shield_elements.fbx",
		},
		{
			class = "Item",
			uiName = "Shield of the Elements",
			description = "A shiny shield that is embossed with the magical symbols of the four elements.",
			gfxIndex = 2,
			weight = 7.5,
			traits = { "shield", "upgradable" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 7,
			resistAll = 15,
		},
	},
}

-- defineObject{
-- 	name = "shield_valor",
-- 	baseObject = "base_item",
-- 	components = {
-- 		{
-- 			class = "Model",
-- 			model = "assets/models/items/shield_valor.fbx",
-- 		},
-- 		{
-- 			class = "Item",
-- 			uiName = "Shield of Valor",
-- 			description = "It was rumored that even a dragon could not harm the emperor of Malan Tael when he carried this shield.",
-- 			gfxIndex = 106,
-- 			armorSet = "valor",
-- 			weight = 6.5,
-- 			traits = { "shield", "upgradable" },
-- 		},
-- 		{
-- 			class = "EquipmentItem",
-- 			slot = "Weapon",
-- 			evasion = 10,
-- 			strength = 2,
-- 			resistFire = 20,
-- 		},
-- 	},
-- }

defineObject{
	name = "pearl_shield",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/pearl_shield.fbx",
		},
		{
			class = "Item",
			uiName = "Pearl Shield",
			description = "The polished surface of this shield resembles that of a pearl.",
			gfxIndex = 236,
			weight = 4.1,
			traits = { "shield", "upgradable" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 5,
			energy = 25,
		},
	},
}

defineObject{
	name = "crystal_shield",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_shield.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Shield",
			description = "The crystals embedded in this shield radiate with blue light.",
			armorSet = "crystal",
			gfxIndex = 328,
			gfxIndexArmorSet = 475,		
			gfxIndexPowerAttack = 204,
			weight = 3.5,
			secondaryAction = "heal",
			traits = { "shield", "epic" },
			gameEffect = "Wearer gains immunity to petrify condition.",
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 10,
			immunities = { "petrified" },
		},
		{
			class = "CastSpell",
			name = "heal",
			uiName = "Heal",
			charges = 9,
			buildup = 2,
			energyCost = 50,
			spell = "heal",
			requirements = { "concentration", 2 },
		},
	},
}

defineObject{
	name = "meteor_shield",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_shield.fbx",	
		},
		{
			class = "Item",
			uiName = "Meteor Shield",
			description = "This shield is hot as a frying pan but when wielded, the searing heat seems almost enjoyable.",
			armorSet = "meteor",
			gfxIndex = 472,						
			gfxIndexArmorSet = 473,				
			gfxIndexPowerAttack = 474,			
			weight = 5.5,
			secondaryAction = "fireShield",
			traits = { "shield", "epic" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 7,
			resistFire = 10,
		},
		{
			class = "CastSpell",
			name = "fireShield",
			uiName = "Fire Shield",
			charges = 9,
			buildup = 2,
			energyCost = 30,
			spell = "fire_shield",
			requirements = { "concentration", 2 },
		},
	},
}

defineObject{
	name = "buckler",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/buckler_bracelet.fbx",
		},
		{
			class = "Item",
			uiName = "Buckler",
			gfxIndex = 314,
			weight = 2.7,
			traits = { "shield", "bracers" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 2,
		},
		{
			class = "EquipmentItem",
			name = "equipmentitem2",
			slot = "Bracers",
			evasion = 2,
		},
	},
}
