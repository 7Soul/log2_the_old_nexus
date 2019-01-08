defineObject{
	name = "torch",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/torch.fbx",
		},
		{
			class = "Item",
			uiName = "Torch",
			gfxIndex = 130,
			impactSound = "impact_blunt",
			weight = 1.2,
		},
		{
			class = "TorchItem",
			fuel = 1100,
		},
		{
			class = "MeleeAttack",
			attackPower = 4,
			accuracy = 0,
			damageType = "fire",
			cooldown = 3,
			swipe = "vertical",
		},
	},
	tags = { "weapon" },
}

defineObject{
	name = "torch_everburning",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/torch.fbx",
		},
		{
			class = "Item",
			uiName = "Everburning Torch",
			gfxIndex = 130,
			impactSound = "impact_blunt",
			weight = 1.2,
		},
		{
			class = "TorchItem",
			fuel = math.huge,
		},
		{
			class = "MeleeAttack",
			attackPower = 4,
			accuracy = 0,
			damageType = "fire",
			cooldown = 3,
			swipe = "vertical",
		},
	},
	tags = { "weapon" },
}

defineObject{
	name = "legionary_spear",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skeleton_spear.fbx",
		},
		{
			class = "Item",
			uiName = "Legionary Spear",
			gfxIndex = 208,
			impactSound = "impact_blade",
			weight = 3.0,
			fitContainer = false,
			traits = { "light_weapon", "two_handed", "spear", "aquatic" },
		},
		{
			class = "MeleeAttack",
			attackPower = 10,
			accuracy = 0,
			cooldown = 5,
			swipe = "thrust",
			attackSound = "swipe",
			reachWeapon = true,
		},
	},
	tags = { "weapon" },
}

defineObject{
	name = "tribal_spear",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tribal_spear.fbx",
		},
		{
			class = "Item",
			uiName = "Tribal Spear",
			gfxIndex = 253,
			gfxIndexPowerAttack = 426,
			impactSound = "impact_blade",
			weight = 1.0,
			projectileRotationY = 90,
			traits = { "light_weapon", "two_handed", "spear", "aquatic" },
		},
		{
			class = "MeleeAttack",
			attackPower = 10,
			accuracy = 0,
			cooldown = 3.5,
			swipe = "thrust",
			attackSound = "swipe",
			reachWeapon = true,
			powerAttackTemplate = "throw",
		},
	},
	tags = { "weapon" },
}

defineObject{
	name = "zarchton_harpoon",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/zarchton_harpoon.fbx",
		},
		{
			class = "Item",
			uiName = "Zarchton Harpoon",
			description = "This polearm has two serrated prongs and is a common sight among the aquatic Zarchton warriors since it can be used comfortably both on dry land and while underwater.",
			gfxIndex = 292,
			gfxIndexPowerAttack = 427,
			impactSound = "impact_blade",
			weight = 3.0,
			projectileRotationY = 90,
			traits = { "light_weapon", "two_handed", "spear", "aquatic" },
		},
		{
			class = "MeleeAttack",
			attackPower = 15,
			accuracy = 10,
			cooldown = 5,
			swipe = "thrust",
			attackSound = "swipe",
			reachWeapon = true,
			powerAttackTemplate = "thrust",
		},
	},
	tags = { "weapon" },
}

defineObject{
	name = "quarterstaff",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/quarterstaff.fbx",
		},
		{
			class = "Item",
			uiName = "Quarterstaff",
			gfxIndex = 291,
			impactSound = "impact_blunt",
			weight = 2.4,
			traits = { "light_weapon", "two_handed", "mage_weapon" },
		},
		{
			class = "MeleeAttack",
			attackPower = 8,
			accuracy = 0,
			cooldown = 4,
			swipe = "horizontal",
			attackSound = "swipe",
			reachWeapon = true,
		},
	},
	tags = { "weapon" },
}

defineObject{
	name = "scythe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/scythe.fbx",
		},
		{
			class = "Item",
			uiName = "Scythe",
			gfxIndex = 315,
			gfxIndexPowerAttack = 459,
			impactSound = "impact_blade",
			weight = 3.2,
			secondaryAction = "reap",
			traits = { "heavy_weapon", "two_handed" },
		},
		{
			class = "MeleeAttack",
			attackPower = 23,
			cooldown = 3.5,
			critChance = 5,
			critMultiplier = 3,
			swipe = "horizontal",
			requirements = { "heavy_weapons", 2 },
		},
		{
			class = "EquipmentItem",
			criticalChance = 0
		},
		{
			class = "MeleeAttack",
			name = "reap",
			uiName = "Harvest Time",
			energyCost = 40,
			attackPower = 23,
			critChance = 10,
			critMultiplier = 10,
			cooldown = 3.5,
			swipe = "horizontal",
			requirements = { "heavy_weapons", 4, "critical", 2 },
			gameEffect = "A deadly swing that has a chance of scoring x10 damage on a critical hit.",
		},
	},
	tags = { "weapon" },
}
