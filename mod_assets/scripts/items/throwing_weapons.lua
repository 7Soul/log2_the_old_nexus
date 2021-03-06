defineObject{
	name = "rock",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rock.fbx",
		},
		{
			class = "Item",
			uiName = "Rock",
			gfxIndex = 45,
			impactSound = "impact_blunt",
			stackable = true,
			projectileRotationSpeed = 10,
			projectileRotationZ = -30,
			weight = 0.7,
			traits = { "throwing_weapon" },
		},
		{
			class = "ThrowAttack",
			attackPower = 4,
			cooldown = 4,
		},
		{
			class = "AmmoItem",
			ammoType = "rock",
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "dart",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blowpipe_dart.fbx",
		},
		{
			class = "Item",
			uiName = "Dart",
			gfxIndex = 262,
			impactSound = "impact_arrow",
			stackable = true,
			sharpProjectile = true,
			projectileRotationY = 90,
			weight = 0.1,
			traits = { "throwing_weapon" },
		},
		{
			class = "ThrowAttack",
			attackPower = 6,
			cooldown = 4,
		},
		{
			class = "AmmoItem",
			ammoType = "dart",
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "sleep_dart",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blowpipe_dart.fbx",
		},
		{
			class = "Item",
			uiName = "Sleep Dart",
			gfxIndex = 262,
			impactSound = "impact_arrow",
			stackable = true,
			sharpProjectile = true,
			projectileRotationY = 90,
			convertToItemOnImpact = "dart",
			weight = 0.1,
			traits = { "throwing_weapon" },
			onThrowAttackHitMonster = function(self, monster)
		 		monster:setCondition("sleep", 20)
		 	end,
		},
		{
			class = "ThrowAttack",
			attackPower = 6,
			cooldown = 4,
		},
		{
			class = "AmmoItem",
			ammoType = "dart",
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "throwing_knife",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/knife.fbx",
		},
		{
			class = "Item",
			uiName = "Throwing Knife",
			gfxIndex = 47,
			impactSound = "impact_blade",
			stackable = true,
			sharpProjectile = true,
			weight = 0.5,
			projectileRotationSpeed = -20,
			projectileRotationX = 90,
			projectileRotationY = 90,
			traits = { "throwing_weapon" },
		},
		{
			class = "ThrowAttack",
			attackPower = 9,
			cooldown = 4,
		},
	},
	tags = { "weapon", "weapon_throwing" },
}
	
defineObject{
	name = "shuriken",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/shuriken.fbx",
		},
		{
			class = "Item",
			uiName = "Shuriken",
			gfxIndex = 12,
			gfxIndexPowerAttack = 447,
			impactSound = "impact_blade",
			stackable = true,
			sharpProjectile = true,
			projectileRotationSpeed = 12,
			projectileRotationX = 90,
			projectileRotationY = -90,
			weight = 0.1,
			traits = { "throwing_weapon", "volley" },
			secondaryAction = "volley"
		},
		{
			class = "ThrowAttack",
			attackPower = 13,
			cooldown = 3.5,
		},
		{
			class = "ThrowAttack",
			name = "volley",
			spread = 0.4,
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "throwing_axe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/throwing_axe.fbx",
		},
		{
			class = "Item",
			uiName = "Throwing Axe",
			gfxIndex = 43,
			gfxIndexPowerAttack = 477,
			impactSound = "impact_blade",
			stackable = true,
			sharpProjectile = true,
			projectileRotationSpeed = -10,
			projectileRotationZ = 90,
			weight = 0.5,
			traits = { "throwing_weapon" },
			secondaryAction = "powerThrow"
		},
		{
			class = "ThrowAttack",
			attackPower = 18,
			cooldown = 5,
		},
		{
			class = "ThrowAttack",
			name = "powerThrow",
			uiName = "Power Throw",
			attackPower = 36,
			energyCost = 30,
			pierce = 10,
			cooldown = 5,
			requirements = { "throwing", 4 },
			gameEffect = "A powerful throw that deals double damage and ignore's 10 points of enemy's armor.",
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "fire_bomb",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/fire_bomb.fbx",
		},
		{
			class = "Item",
			uiName = "Fire Bomb",
			gfxIndex = 136,
			impactSound = "impact_blunt",
			stackable = true,
			projectileRotationSpeed = 10,
			projectileRotationZ = -30,
			weight = 0.8,
			description = "Creates a blast of flame and sets the ground on fire.",
			traits = { "throwing_weapon" },
		},
		{
			class = "ThrowAttack",
			cooldown = 4,
		},
		{
			class = "BombItem",
			bombType = "fire",
			bombPower = 55,
			onExplode = function(self,level,x,y,facing,elevation)
				functions.script.onHitWithBomb(self,level,x,y,facing,elevation)
				return false
			end,
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "shock_bomb",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/shock_bomb.fbx",
		},
		{
			class = "Item",
			uiName = "Lightning Bomb",
			gfxIndex = 139,
			impactSound = "impact_blunt",
			stackable = true,
			projectileRotationSpeed = 10,
			projectileRotationZ = -30,
			weight = 0.8,
			description = "Shocks an enemy with a chance of arcing to other targets.",
			traits = { "throwing_weapon" },
		},
		{
			class = "ThrowAttack",
			cooldown = 4,
		},
		{
			class = "BombItem",
			bombType = "shock",
			bombPower = 85,
			onExplode = function(self,level,x,y,facing,elevation)
				functions.script.onHitWithBomb(self,level,x,y,facing,elevation)
				return false
			end,
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "frost_bomb",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/cold_bomb.fbx",
		},
		{
			class = "Item",
			uiName = "Frost Bomb",
			gfxIndex = 137,
			impactSound = "impact_blunt",
			stackable = true,
			projectileRotationSpeed = 10,
			projectileRotationZ = -30,
			weight = 0.8,
			traits = { "throwing_weapon" },
		},
		{
			class = "ThrowAttack",
			cooldown = 4,
		},
		{
			class = "BombItem",
			bombType = "cold",
			bombPower = 15,
			onExplode = function(self,level,x,y,facing,elevation)
				functions.script.onHitWithBomb(self,level,x,y,facing,elevation)
				return false
			end,
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "poison_bomb",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/poison_bomb.fbx",
		},
		{
			class = "Item",
			uiName = "Poison Bomb",
			gfxIndex = 138,
			impactSound = "impact_blunt",
			stackable = true,
			projectileRotationSpeed = 10,
			projectileRotationZ = -30,
			weight = 0.8,
			traits = { "throwing_weapon" },
		},
		{
			class = "ThrowAttack",
			cooldown = 4,
		},
		{
			class = "BombItem",
			bombType = "poison",
			bombPower = 20,
			onExplode = function(self,level,x,y,facing,elevation)
				functions.script.onHitWithBomb(self,level,x,y,facing,elevation)
				return false
			end,
		},
	},
	tags = { "weapon", "weapon_throwing" },
}

defineObject{
	name = "vilson_orb",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/orb_of_vilson.fbx",
		}, 
		{
			class = "Item",
			uiName = "Orb of Vilson",
			description = "A spherical object made of strange, elastic substance.",
			gfxIndex = 289,
			impactSound = "impact_blunt",
			weight = 2.0,
			traits = { "throwing_weapon" }
		},
		{
			class = "ThrowAttack",
			attackPower = 3,
			cooldown = 4,
		},
	},
	tags = { "weapon", "weapon_throwing" },
}
