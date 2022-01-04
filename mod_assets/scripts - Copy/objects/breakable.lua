defineObject{
	name = "barrel_crate_block",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/barrel_crate_block.fbx",
		},
		{
			class = "Obstacle",
			hitSound = "barrel_hit",
			hitEffect = "hit_wood",
		},
		{
			class = "Health",
			health = 15,
			immunities = { "poison" },
			spawnOnDeath = "barrel_crate_block_damaged",
		},
	},
	editorIcon = 260,
}

defineObject{
	name = "barrel_crate_block_damaged",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/barrel_crate_block_damaged.fbx",
		},
		{
			class = "Obstacle",
			hitSound = "barrel_hit",
			hitEffect = "hit_wood",
		},
		{
			class = "Health",
			health = 15,
			immunities = { "poison" },
			spawnOnDeath = "barrel_crate_block_broken",
			onDie = function(self)
				self.go:playSound("barrel_die")
			end,
		},
	},
}

defineObject{
	name = "barrel_crate_block_broken",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/barrel_crate_block_broken.fbx",
		},
	},
}

defineObject{
	name = "spider_eggs",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/spider_eggs.fbx",
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/spider_eggs_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "spider_eggs_hit",
			hitEffect = "hit_goo",	
		},
		{
			class = "Light",
			offset = vec(0, 1.5, 0),
			color = vec(1, 0.4, 0),
			brightness = 4,
			range = 3,
			fillLight = true,
		},
		{
			class = "Health",
			health = 160,
			immunities = { "poison" },
			spawnOnDeath = "spider_eggs_broken",
			onDie = function(self)
				for i = 1, math.random(2,7) do
					local obj = self.go:spawn("tiny_spider")
					local pos = obj:getWorldPosition()
					local spread = 1.5
					pos.x = pos.x + (math.random() - 0.5) * spread
					pos.z = pos.z + (math.random() - 0.5) * spread
					obj:setWorldPosition(pos)
				end
			end,
		},
		{
			class = "Sound",
			sound = "spider_eggs_ambient",
		},
	},
	editorIcon = 260,
}

defineObject{
	name = "spider_eggs_broken",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/spider_eggs_broken.fbx",
		},
	},
}

defineObject{
	name = "beach_cattail_blocker",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_cattail_blocker.fbx",
			castShadow = false,
			dissolveStart = 7,
			dissolveEnd = 10,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/beach_cattail_blocker_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
			hitEffect = "hit_wood",
		},
		{
			class = "Health",
			health = 1,
			immunities = { "poison" },
			spawnOnDeath = "beach_cattail_damaged", 
		},
	},
	editorIcon = 260,
}

defineObject{
	name = "beach_cattail_damaged",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_cattail_damaged.fbx",
			castShadow = false,
			dissolveStart = 7,
			dissolveEnd = 10,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/beach_cattail_damaged_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
			hitEffect = "hit_wood",
		},
		{
			class = "Health",
			health = 1,
			immunities = { "poison" },
			spawnOnDeath = "beach_cattail_broken", 
		},
	},
}


defineObject{
	name = "beach_cattail_broken",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_cattail_broken.fbx",
		},
		dissolveStart = 4,
		dissolveEnd = 6,
	},
}

defineObject{
	name = "beach_thicket_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_thicket.fbx",
			dissolveStart = 10,
			dissolveEnd = 11,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
			hitEffect = "hit_wood",
		},
		{
			class = "Health",
			health = 10,
			immunities = { "poison" },
			spawnOnDeath = "beach_thicket_damaged",
		},
	},
	editorIcon = 260,
}

defineObject{
	name = "beach_thicket_damaged",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_thicket_damaged.fbx",
			dissolveStart = 10,
			dissolveEnd = 11,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
			hitEffect = "hit_wood",
		},
		{
			class = "Health",
			health = 5,
			immunities = { "poison" },
			spawnOnDeath = "beach_thicket_broken",
		},
	},
}

defineObject{
	name = "beach_thicket_broken",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_thicket_broken.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
		},
	},
}

defineObject{
	name = "forest_thorn_blocker",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_thorn_blocker.fbx",
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_thorn_blocker_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "spider_eggs_hit",	-- TODO
			hitEffect = "hit_wood",			-- TODO
		},
		{
			class = "Health",
			health = 15,
			immunities = { "poison" },
			spawnOnDeath = "forest_thorn_damaged",
		},
	},
	editorIcon = 260,
}

defineObject{
	name = "forest_thorn_damaged",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_thorn_damaged.fbx",
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_thorn_blocker_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "spider_eggs_hit",	-- TODO
			hitEffect = "hit_wood",			-- TODO
		},
		{
			class = "Health",
			health = 15,
			immunities = { "poison" },
			spawnOnDeath = "forest_thorn_broken",
		},
	},
}

defineObject{
	name = "forest_thorn_broken",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			--model = "assets/models/env/forest_thorn_blocker.fbx",
			model = "assets/models/env/forest_thorn_broken.fbx",
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_thorn_blocker_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
}

defineObject{
	name = "terracotta_jars_block",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/terracotta_jars_block.fbx",
		},
		{
			class = "Obstacle",
			hitSound = "terracotta_jar_hit",
			hitEffect = "hit_terracotta_jar",
		},
		{
			class = "Health",
			health = 15,
			immunities = { "poison" },
			spawnOnDeath = "terracotta_jars_block_damaged",
		},
	},
	editorIcon = 260,
}

defineObject{
	name = "terracotta_jars_block_damaged",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/terracotta_jars_block_damaged.fbx",
		},
		{ 
			class = "Obstacle",
			hitSound = "terracotta_jar_hit",
			hitEffect = "hit_terracotta_jar",
		},
		{
			class = "Health",
			health = 15,
			immunities = { "poison" },
			spawnOnDeath = "terracotta_jars_block_broken",
			onDie = function(self)
				self.go:playSound("terracotta_jar_die")
			end,
		},
	},
	editorIcon = 260,
}


defineObject{
	name = "terracotta_jars_block_broken",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/terracotta_jars_block_broken.fbx",
		},
	},
}

defineObject{
	name = "castle_wall_cloth",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_cloth.fbx",
		},
		-- {
		-- 	class = "Obstacle",
		-- 	hitSound = "barrel_hit",
		-- 	hitEffect = "hit_wood",
		-- },
		{
			class = "Health",
			health = 5,
			immunities = { "poison" },
			spawnOnDeath = "castle_wall_cloth_torn",
		},
	},
}

defineObject{
	name = "castle_wall_cloth_torn",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_cloth_torn.fbx",
		},
	},
}

defineObject{
	name = "barrel_crate_detail",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/env/barrel_crate_block_detail.fbx",
		},
	},
	placement = "wall",
	editorIcon = 160,
	minimalSaveState = true,
	tags = { "level_decoration" },
}