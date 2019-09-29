defineObject{
	name = "sling",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/sling.fbx",
		},
		{
			class = "Item",
			uiName = "Sling",
			gfxIndex = 44,
			impactSound = "impact_blunt",
			weight = 0.5,
			traits = { "missile_weapon" },
		},
		{
			class = "RangedAttack",
			attackPower = 7,
			cooldown = 6,
			attackSound = "swipe",
			ammo = "rock",
		},
	},
	tags = { "weapon", "weapon_missile" },
}

defineObject{
	name = "blowpipe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blowpipe.fbx",
		},
		{
			class = "Item",
			uiName = "Blowpipe",
			description = "The deathly silent hunters in the jungles of Xaae favor this weapon for its stealthiness.",
			gfxIndex = 261,
			gfxIndexPowerAttack = 428,
			impactSound = "impact_blunt",
			secondaryAction = "sleepDart",
			weight = 0.5,
			traits = { "missile_weapon" },
		},
		{
			class = "RangedAttack",
			attackPower = 10,
			cooldown = 6,
			attackSound = "swipe",
			ammo = "dart",
		},
		{
			class = "RangedAttack",
			name = "sleepDart",
			uiName = "Sleep Dart",
			attackPower = 5,
			energyCost = 25,
			cooldown = 6,
			attackSound = "swipe",
			ammo = "dart",
			projectileItem = "sleep_dart",
			requirements = { "ranged_weapons", 2 },
		},
	},
	tags = { "weapon", "weapon_missile" },
}

defineObject{
	name = "short_bow",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/short_bow.fbx",
		},
		{
			class = "Item",
			uiName = "Short Bow",
			gfxIndex = 13,
			gfxIndexPowerAttack = 466,
			impactSound = "impact_blunt",
			weight = 1.0,
			secondaryAction = "volley",
			traits = { "missile_weapon", "bow", "upgradable", "volley" },
		},
		{
			class = "RangedAttack",
			attackPower = 12,
			cooldown = 4,
			attackSound = "swipe_bow",
			ammo = "arrow",
		},
		{
			class = "RangedAttack",
			name = "volley",
			uiName = "Volley",
			energyCost = 12,
			attackPower = 11,
			repeatDelay = 0.2,
			repeatCount = 3,
			cooldown = 6,
			attackSound = "swipe_bow",
			ammo = "arrow",
			requirements = { "ranged_weapons", 2 },
			gameEffect = [[Fires three shots in quick succession.]],
		},
	},
	tags = { "weapon", "weapon_missile" },
}

defineObject{
	name = "longbow",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/longbow.fbx",
		},
		{
			class = "Item",
			uiName = "Crookhorn Longbow",
			description = "A powerful bow made from the horns of a crookhorn ram.",
			gfxIndex = 165,
			gfxIndexPowerAttack = 98,
			impactSound = "impact_blunt",
			weight = 1.6,
			traits = { "missile_weapon", "bow", "upgradable", "volley" },
		},
		{
			class = "RangedAttack",
			attackPower = 16,
			cooldown = 4.5,
			attackSound = "swipe_bow",
			ammo = "arrow",
		},
	},
	tags = { "weapon", "weapon_missile" },
}


defineObject{
	name = "crossbow",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crossbow.fbx",
		},
		{
			class = "Item",
			uiName = "Crossbow",
			gfxIndex = 14,
			impactSound = "impact_blunt",
			weight = 1.5,
			traits = { "missile_weapon" },
		},
		{
			class = "RangedAttack",
			attackPower = 22,
			cooldown = 5.5,
			attackSound = "swipe_bow",
			ammo = "quarrel",
		},
	},
	tags = { "weapon", "weapon_missile" },
}

defineObject{
	name = "lightning_bow",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flame_arc.fbx",
		},
		{
			class = "Item",
			uiName = "Lightning Bow",
			description = "Lightning runes are carved on the limbs of this bow. They glow brightly when the bowstring is pulled taut.",
			gfxIndex = 445,
			gfxIndexPowerAttack = 446,
			impactSound = "impact_blunt",
			secondaryAction = "shockArrow",
			weight = 1.8,
			traits = { "missile_weapon" },
		},
		{
			class = "RangedAttack",
			attackPower = 19,
			cooldown = 4.5,
			attackSound = "swipe_bow",
			ammo = "arrow",
		},
		{
			class = "RangedAttack",
			name = "shockArrow",
			uiName = "Shock Arrow",
			attackPower = 30,
			accuracy = 10,
			damageType = "shock",
			cooldown = 4.5,
			attackSound = "lightning_bolt_launch",
			ammo = "arrow",
			projectileItem = "shock_arrow",	-- converts shot arrows to fire arrows
			energyCost = 30,
			requirements = { "ranged_weapons", 4, "air_magic", 1 },
			gameEffect = "Shoot an arrow enchanted with the energy of storms."
		},
	},
	tags = { "weapon", "weapon_missile" },
}

defineObject{
	name = "arrow",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/arrow.fbx",
		},
		{
			class = "Item",
			uiName = "Broadhead Arrow",
			gfxIndex = 107,
			impactSound = "impact_arrow",
			stackable = true,
			sharpProjectile = true,
			projectileRotationY = 90,
			weight = 0.1,
		},
		{
			class = "AmmoItem",
			ammoType = "arrow",
		},
	},
}

defineObject{
	name = "fire_arrow",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/arrow.fbx",
		},
		{
			class = "Item",
			uiName = "Flaming Broadhead Arrow",
			gfxIndex = 108,
			impactSound = "impact_arrow",
			stackable = true,
			sharpProjectile = true,
			projectileRotationY = 90,
			convertToItemOnImpact = "arrow",	-- convert to normal arrow on impact
			weight = 0.1,
		},
		{
			class = "Particle",
			offset = vec(0.5, 0, 0),
			particleSystem = "fire_arrow",
		},
	},
}

defineObject{
	name = "shock_arrow",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/arrow.fbx",
		},
		{
			class = "Item",
			uiName = "Lightning Arrow",
			gfxIndex = 111,
			impactSound = "impact_arrow",
			stackable = true,
			sharpProjectile = true,
			projectileRotationY = 90,
			convertToItemOnImpact = "arrow",	-- convert to normal arrow on impact
			weight = 0.1,
		},
		{
			class = "Particle",
			offset = vec(0.5, 0, 0),
			particleSystem = "shock_arrow",
		},
	},
}

defineObject{
	name = "cold_arrow",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/arrow.fbx",
		},
		{
			class = "Item",
			uiName = "Frost Arrow",
			gfxIndex = 109,
			impactSound = "impact_arrow",
			stackable = true,
			sharpProjectile = true,
			projectileRotationY = 90,
			convertToItemOnImpact = "arrow",	-- convert to normal arrow on impact
			weight = 0.1,
		},
		{
			class = "AmmoItem",
			ammoType = "arrow",
			attackPower = 1,
		},
		{
			class = "Particle",
			offset = vec(0.5, 0, 0),
			particleSystem = "frost_arrow",
		},
	},
}

--defineObject{
--	name = "poison_arrow",
--	baseObject = "base_item",
--	components = {
--		{
--			class = "Model",
--			model = "assets/models/items/arrow.fbx",
--		},
--		{
--			class = "Item",
--			uiName = "Poison Arrow",
--			gfxIndex = 110,
--			impactSound = "impact_arrow",
--			stackable = true,
--			sharpProjectile = true,
--			projectileRotationY = 90,
--			weight = 0.1,
--		},
--		{
--			class = "AmmoItem",
--			ammoType = "arrow",
--			attackPower = 1,
--		},
--	},
--}

defineObject{
	name = "quarrel",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/quarrel.fbx",
		},
		{
			class = "Item",
			uiName = "Crossbow Quarrel",
			gfxIndex = 120,
			impactSound = "impact_arrow",
			stackable = true,
			sharpProjectile = true,
			projectileRotationY = 90,
			weight = 0.2,
		},
		{
			class = "AmmoItem",
			ammoType = "quarrel",
		},
	},
}

--defineObject{
--	name = "fire_quarrel",
--	baseObject = "base_item",
--	components = {
--		{
--			class = "Model",
--			model = "assets/models/items/quarrel.fbx",
--		},
--		{
--			class = "Item",
--			uiName = "Fire Quarrel",
--			gfxIndex = 121,
--			impactSound = "impact_arrow",
--			stackable = true,
--			sharpProjectile = true,
--			projectileRotationY = 90,
--			weight = 0.2,
--		},
--		{
--			class = "AmmoItem",
--			ammoType = "quarrel",
--		},
--	},
--}

--defineObject{
--	name = "cold_quarrel",
--	baseObject = "base_item",
--	components = {
--		{
--			class = "Model",
--			model = "assets/models/items/quarrel.fbx",
--		},
--		{
--			class = "Item",
--			uiName = "Frost Quarrel",
--			gfxIndex = 122,
--			impactSound = "impact_arrow",
--			stackable = true,
--			sharpProjectile = true,
--			projectileRotationY = 90,
--			weight = 0.2,
--		},
--		{
--			class = "AmmoItem",
--			ammoType = "quarrel",
--		},
--	},
--}

--defineObject{
--	name = "poison_quarrel",
--	baseObject = "base_item",
--	components = {
--		{
--			class = "Model",
--			model = "assets/models/items/quarrel.fbx",
--		},
--		{
--			class = "Item",
--			uiName = "Poison Quarrel",
--			gfxIndex = 123,
--			impactSound = "impact_arrow",
--			stackable = true,
--			sharpProjectile = true,
--			projectileRotationY = 90,
--			weight = 0.2,
--		},
--		{
--			class = "AmmoItem",
--			ammoType = "quarrel",
--		},
--	},
--}

--defineObject{
--	name = "shock_quarrel",
--	baseObject = "base_item",
--	components = {
--		{
--			class = "Model",
--			model = "assets/models/items/quarrel.fbx",
--		},
--		{
--			class = "Item",
--			uiName = "Lightning Quarrel",
--			gfxIndex = 124,
--			impactSound = "impact_arrow",
--			stackable = true,
--			sharpProjectile = true,
--			projectileRotationY = 90,
--			weight = 0.2,
--		},
--		{
--			class = "AmmoItem",
--			ammoType = "quarrel",
--		},
--	},
--}

-- Cold enchanted bow:
-- Every 30 seconds, becomes enchanted with ice. Shots deal 30% of damage as cold to the target, and an AOE with (total damage * 0.3)
-- Willpower +4
-- Cold damage +20
-- Cold resist +20