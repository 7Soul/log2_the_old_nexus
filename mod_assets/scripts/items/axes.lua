defineObject{
	name = "hand_axe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/hand_axe.fbx",
		},
		{
			class = "Item",
			uiName = "Hand Axe",
			gfxIndex = 25,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "light_weapon", "axe", "upgradable", "dismantle" },
			onEquipItem = function(self, champion, slot)
				
			end
		},
		{
			class = "MeleeAttack",
			attackPower = 10,
			accuracy = 0,
			cooldown = 4.5,
			swipe = "horizontal",
			attackSound = "swipe",
		},
	},
	tags = { "weapon", "weapon_light", "weapon_axe" },
}

defineObject{
	name = "pickaxe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/pickaxe.fbx",
		},
		{
			class = "Item",
			uiName = "Pickaxe",
			gfxIndex = 260,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "light_weapon", "axe", "upgradable", "dismantle" },
			secondaryAction = "chip",
		},
		{
			class = "MeleeAttack",
			attackPower = 13,
			accuracy = 0,
			cooldown = 4.5,
			swipe = "vertical",
			attackSound = "swipe",
		},
		{
			class = "MeleeAttack",
			name = "chip",
			uiName = "Chip",
			energyCost = 20,
			attackPower = 20,
			cooldown = 5,
			swipe = "vertical",
			requirements = { "light_weapons_c", 1 },
			gameEffect = "This attack chips away 1 armor from the enemy with each hit.",
		},
	},
	tags = { "weapon", "weapon_light", "weapon_axe" },
}

defineObject{
	name = "skullcleave",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skeleton_knight_axe.fbx",
		},
		{
			class = "Item",
			uiName = "Skullcleave",
			gfxIndex = 294,
			gfxIndexPowerAttack = 476,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "heavy_weapon", "axe", "upgradable", "dismantle", "chop" },
			secondaryAction = "chop",
		},
		{
			class = "MeleeAttack",
			attackPower = 15,
			accuracy = 0,
			cooldown = 4.5,
			swipe = "vertical",
			attackSound = "swipe"
		},
		{
			class = "MeleeAttack",
			name = "chop",
		-- 	-- onHitMonster = function(self, monster, tside, damage, champion)
		-- 	-- 	local secondary2 = functions.script.secondary
		-- 	-- 	local item = self.go.item
		-- 	-- 	functions.script.monster_attacked(self, monster, tside, damage, champion)
		-- 	-- 	functions.script.reset_attack(self, champion, slot, secondary2, item) -- (when hit)
		-- 	-- end
			
		},
	},
	tags = { "weapon", "weapon_heavy", "weapon_axe" },
}

defineObject{
	name = "battle_axe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/battle_axe.fbx",
		},
		{
			class = "Item",
			uiName = "Battle Axe",
			gfxIndex = 86,
			gfxIndexPowerAttack = 460,
			impactSound = "impact_blade",
			weight = 4.0,
			traits = { "heavy_weapon", "axe", "upgradable", "dismantle", "chop" },
		},
		{
			class = "MeleeAttack",
			attackPower = 20,
			accuracy = 0,
			cooldown = 5.2,
			swipe = "horizontal",
			attackSound = "swipe",
		},
	},
	tags = { "weapon", "weapon_heavy", "weapon_axe" },
}

defineObject{
	name = "poleaxe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/poleaxe.fbx",
		},
		{
			class = "Item",
			uiName = "Poleaxe",
			gfxIndex = 230,
			gfxIndexPowerAttack = 416,
			impactSound = "impact_blade",
			weight = 4.5,
			traits = { "heavy_weapon", "two_handed", "axe", "upgradable", "dismantle", "cleave" },
		},
		{
			class = "MeleeAttack",
			attackPower = 26,
			accuracy = 0,
			cooldown = 4.5,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "heavy_weapons_c", 2 },
		},
	},
	tags = { "weapon", "weapon_heavy", "weapon_axe" },
}

defineObject{
	name = "ax",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/ax.fbx",
		},
		{
			class = "Item",
			uiName = "Ax",
			description = "Despite its size, the Ax is an elegant and nimble weapon in the hands of a well trained warrior.",
			gfxIndex = 231,
			gfxIndexPowerAttack = 205,
			impactSound = "impact_blade",
			weight = 2.4,
			traits = { "heavy_weapon", "axe", "upgradable", "dismantle", "flurry" },
		},
		{
			class = "MeleeAttack",
			attackPower = 29,
			accuracy = 0,
			cooldown = 4.2,
			swipe = "vertical",
			attackSound = "swipe",
			requirements = { "heavy_weapons_c", 3 },
		},
	},
	tags = { "weapon", "weapon_heavy", "weapon_axe" },
}

defineObject{
	name = "great_axe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/great_axe.fbx",
		},
		{
			class = "Item",
			uiName = "Great Axe",
			gfxIndex = 11,
			gfxIndexPowerAttack = 201,
			impactSound = "impact_blade",
			weight = 8.0,
			traits = { "heavy_weapon", "two_handed", "axe", "upgradable", "dismantle", "cleave" },
		},
		{
			class = "MeleeAttack",
			requirements = { "heavy_weapons_c", 3 },
			attackPower = 37,
			accuracy = 0,
			cooldown = 6,
			swipe = "vertical",
			attackSound = "swipe_heavy",
		},
	},
	tags = { "weapon", "weapon_heavy", "weapon_axe" },
}

defineObject{
	name = "bane",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bane.fbx",
		},
		{
			class = "Item",
			uiName = "Bane",
			description = "This axe was gifted to Orul and Xarant Wormbound upon their arrival to the Isle of Nex.",
			gfxIndex = 400,
			gfxIndexPowerAttack = 465,
			impactSound = "impact_blade",
			weight = 7.3,
			achievement = "find_bane",
			traits = { "heavy_weapon", "two_handed", "axe", "epic", "dismantle", "banish", "upgradable" },
			secondaryAction = "banish",
		},
		{
			class = "MeleeAttack",
			attackPower = 55,
			cooldown = 6.3,
			swipe = "horizontal",
			attackSound = "swipe_heavy",
			requirements = { "heavy_weapons_c", 5 },
		},
		{
			class = "MeleeAttack",
			name = "banish",
			uiName = "Banish",
			energyCost = 80,
			attackPower = 55*2.5,
			critChance = 9,
			cooldown = 12.6,
			cameraShake = true,
			swipe = "horizontal",
			requirements = { "heavy_weapons_c", 5, "critical", 1 },
			gameEffect = "An extremely powerful attack. Deals 2.5x damage and has +9% critical chance.",
		},
	},
	tags = { "weapon", "weapon_heavy", "weapon_axe" },
}
