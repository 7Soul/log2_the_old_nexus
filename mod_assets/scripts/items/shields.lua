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
			traits = { "shield", "bracers", "metal", "upgradable" },
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
	tags = { "shields" },
}

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
	tags = { "shields" },
}

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
			traits = { "shield", "upgradable", "metal" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 4,
		},
	},
	tags = { "shields" },
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
			traits = { "shield", "upgradable", "metal" },
			description = "This shield radiates unholy energy.",
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 5,
			health = -15,
		},
	},
	tags = { "shields" },
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
			traits = { "shield", "upgradable", "metal" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 6,
		},
	},
	tags = { "shields" },
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
			traits = { "shield", "upgradable", "metal" },
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 7,
			resistFire = 15,
			resistCold = 15,
			resistShock = 15,
		},
	},
	tags = { "shields" },
}

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
			traits = { "shield", "upgradable", "metal" },
			gameEffect = [[Special: Heals the party completely.]],
			secondaryAction = "heal",
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 5,
			energy = 25,
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
	tags = { "shields" },
}

-- Set shields

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
			armorSet = "makeshift",
			armorSetPieces = 4,
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
	tags = { "shields" },
}

defineObject{
	name = "shield_valor",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/shield_valor.fbx",
		},
		{
			class = "Item",
			uiName = "Shield of Valor",
			description = "It was rumored that even a dragon could not harm the emperor of Malan Tael when he carried this shield.",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 96,
			gfxIndexArmorSet = 102,
			armorSet = "valor",
			weight = 6.5,
			traits = { "shield", "upgradable", "metal", "epic" },
			gameEffect = [[Special: Increases Strength of the party by 1 (+1 per 2 levels) for 45 seconds.
			
			Valor Set: Duration +45 seconds.]],
			secondaryAction = "valor",
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 10,
			strength = 2,
		},
		{
			class = "CastSpell",
			name = "valor",
			uiName = "Valor",
			charges = 9,
			buildup = 1.5,
			energyCost = 40,
			spell = "valor",
			requirements = { "block", 3 },
		},
	},
	tags = { "shields" },
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
			secondaryAction = "anticurse",
			traits = { "shield", "epic", "metal", "upgradable" },
			gameEffect = [[Wearer gains immunity to petrify condition.
			
			Special: Gives petrify immunity to the entire party for 45 seconds.
			
			[Crystal Set] +50 Health. Once after using a Healing Crystal, if you fall under 50 health you quickly heal back to full.]],
		},
		{
			class = "EquipmentItem",
			slot = "Weapon",
			evasion = 10,
			immunities = { "petrified" },
		},
		{
			class = "CastSpell",
			name = "anticurse",
			uiName = "Anti-Curse",
			charges = 9,
			buildup = 1.25,
			energyCost = 30,
			spell = "anticurse",
			requirements = { "concentration", 2 },
		},
	},
	tags = { "shields" },
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
			armorSetPieces = 6,
			gfxIndex = 472,						
			gfxIndexArmorSet = 473,				
			gfxIndexPowerAttack = 474,			
			weight = 5.5,
			secondaryAction = "fireShield",
			traits = { "shield", "epic", "metal", "upgradable" },
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
			requirements = { "elemental_magic", 2 },
		},
	},
	tags = { "shields" },
}