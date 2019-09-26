defineObject{
	name = "forest_ground_01",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ground_01.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "forest_heightmap",
	components = {
		{
			class = "Heightmap",
		}
	},
	placement = "floor",
	editorIcon = 0,
	reflectionMode = "always",
	tags = { "base" },
}

defineObject{
	name = "forest_wall_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "forest_wall_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_02.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_wall_02_occluder.fbx",
		},
	},
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "forest_hedge_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_wood_wall_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			shadowLod = 1,
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "forest_pillar_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_pillar_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "forest_grass_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_grass_01.fbx",
			castShadow = false,
			dissolveStart = 2,
			dissolveEnd = 4,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_grass_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		
	},
	editorIcon = 240,
	reflectionMode = "never",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_heather",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_heather.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_heather_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		
	},
	editorIcon = 240,
	reflectionMode = "never",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "swamp_heather",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/swamp_heather.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_heather_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		
	},
	editorIcon = 240,
	reflectionMode = "never",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "swamp_heather_low",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/swamp_heather.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			offset = vec(0, -0.25, 0),
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_heather_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		
	},
	editorIcon = 240,
	reflectionMode = "never",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "swamp_grass_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/swamp_grass.fbx",
			castShadow = false,
			dissolveStart = 4,
			dissolveEnd = 6,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/grass_planes_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	editorIcon = 240,
	reflectionMode = "never",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_oak",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_oak.fbx",
			dissolveStart = 2,
			dissolveEnd = 5,
			shadowLod = 1,
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_oak_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	placement = "pillar",
	editorIcon = 180,
	minimalSaveState = true,
	tags = { "level_decoration", "level_design" },
}

defineObject{
	name = "forest_oak_cluster",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_oak_cluster.fbx",
			dissolveStart = 2,
			dissolveEnd = 5,
			shadowLod = 1,
			staticShadow = true,
			--debugDraw = true,
			-- bounding box fix: automatically computed bounding box is too small because the model is built incorrectly
			-- (without skinning all the trees in the cluster are in one place)
			boundBox = { pos = vec(0, 5, 0), size = vec(8, 10, 8) },
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_oak_cluster_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	editorIcon = 168,
	automapTile = "trees",
	minimalSaveState = true,
	tags = { "level_design" }
}

defineObject{
	name = "forest_oak_cluster_noicon",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_oak_cluster.fbx",
			dissolveStart = 2,
			dissolveEnd = 5,
			shadowLod = 1,
			staticShadow = true,
			--debugDraw = true,
			-- bounding box fix: automatically computed bounding box is too small because the model is built incorrectly
			-- (without skinning all the trees in the cluster are in one place)
			boundBox = { pos = vec(0, 5, 0), size = vec(8, 10, 8) },
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_oak_cluster_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	editorIcon = 168,
	automapIcon = -1,
	automapTile = "ground",
	minimalSaveState = true,
	tags = { "level_design" }
}

defineObject{
	name = "forest_oak_stump",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_oak_stump.fbx",
			staticShadow = true,
		},
	},
	placement = "pillar",
	editorIcon = 180,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_oak_trunk",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_oak_trunk.fbx",
			staticShadow = true,
			dissolveStart = 7,
			dissolveEnd = 9,
			staticShadow = true,
		},
	},
	placement = "wall",
	editorIcon = 244,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_spruce_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_spruce_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_spruce_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
		},
	},
	editorIcon = 172,
	automapTile = "trees",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_spruce_small_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_spruce_small_01.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_spruce_small_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
		},
	},
	editorIcon = 172,
	automapTile = "trees",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_spruce_smallest_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_spruce_smallest_01.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_spruce_smallest_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
		},
	},
	editorIcon = 172,
	automapTile = "trees",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_spruce_sapling_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_spruce_sapling_01.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_spruce_sapling_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
		},
	},
	editorIcon = 172,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_spruce_sapling_02",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_spruce_sapling_02.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_spruce_sapling_02_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
		},
	},
	editorIcon = 172,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_spruce_sapling_pillar",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_spruce_sapling_02.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_spruce_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_plant_cluster_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_plant_cluster_01.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_plant_cluster_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Obstacle",
			hitSound = "impact_plant",
		},
	},
	editorIcon = 176,
	automapTile = "trees",
	minimalSaveState = true,
	tags = { "level_decoration", "level_design" },
}

defineObject{
	name = "forest_blocker_stone",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_blocker_stone.fbx",
			staticShadow = true,
			dissolveStart = 5,
			dissolveEnd = 7,
			staticShadow = true,
		},
	},
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" }
}

defineObject{
	name = "forest_cage_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_cage_01.fbx",
			staticShadow = true,
		},
	},
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_cage_02",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_cage_02.fbx",
			staticShadow = true,
		},
	},
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_exit",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_level_gate.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
			blockParty = false,
		},
		{
			class = "ProjectileCollider",
		},
		{
			class = "Exit",
			onInit = function(self)
				local dx,dy = getForward(self.go.facing)
				local x = self.go.x - dx
				local y = self.go.y - dy
				--spawn("blocker", self.go.level, x, y, 0, self.go.elevation)
			end,
		},
	},
	placement = "floor",
	editorIcon = 48,
	tags = { "level_design" }
}

defineObject{
	name = "forest_exit_rock_tunnel",
	baseObject = "forest_exit",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_level_gate_tunnel.fbx",
			staticShadow = true,
		},
	},
	placement = "floor",
	editorIcon = 48,
	tags = { "level_design" }
}

defineObject{
	name = "forest_exit_underwater",
	baseObject = "forest_exit",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_level_gate_tunnel_underwater.fbx",
			staticShadow = true,
		},
	},
	placement = "floor",
	editorIcon = 48,
	tags = { "level_design" }
}

defineObject{
	name = "forest_ruins_ceiling",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_ceiling.fbx",
			staticShadow = true,
		},
	},
	editorIcon = 164,
	minimalSaveState = true,
	tags = { "level_design" }
}

defineObject{
	name = "forest_ruins_ceiling_flat",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_ceiling_flat.fbx",
			staticShadow = true,
		},
	},
	editorIcon = 164,
	minimalSaveState = true,
	tags = { "level_design" }
}

defineObject{
	name = "forest_ruins_wall_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_wall_01.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
		},
		{
			class = "Occluder",
			model = "assets/models/env/forest_ruins_wall_01_occluder.fbx",
		},
	},
	placement = "wall",
	editorIcon = 160,
	automapIcon = 88,
	minimalSaveState = true,
	tags = { "level_design" }
}

defineObject{
	name = "forest_ruins_wall_02",
	baseObject = "forest_ruins_wall_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_wall_02.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/forest_ruins_wall_02_occluder.fbx",
		},
	},
	automapIcon = 88,
	minimalSaveState = true,
	tags = { "level_design" }
}

defineObject{
	name = "forest_ruins_secret_door",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_wall_02.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			openVelocity = 1,
			closeVelocity = -1,
			openingDirection = "down",
			maxHeight = 2.88,
			killPillars = false,
			secretDoor = true,
			openSound = "wall_sliding",
			closeSound = "wall_sliding",
			lockSound = "wall_sliding_lock",
		},
	},
	editorIcon = 120,
	automapIcon = -1,
	tags = { "puzzle", "level_design" }
}

defineObject{
	name = "forest_ruins_wall_ivy_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_ivy_01.fbx",
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_ruins_wall_ivy_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_ivy_02.fbx",
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_ruins_wall_end_right",
	baseObject = "forest_ruins_wall_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_wall_end_right.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/forest_ruins_wall_end_right_occluder.fbx",
		},
	},
	tags = { "level_design" }
}

defineObject{
	name = "forest_ruins_wall_end_left",
	baseObject = "forest_ruins_wall_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_wall_end_left.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/forest_ruins_wall_end_left_occluder.fbx",
		},
	},
	tags = { "level_design" }
}

defineObject{
	name = "forest_ruins_pillar_01",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_pillar_01.fbx",
			staticShadow = true,
			dissolveStart = 3,
			dissolveEnd = 5,
			staticShadow = true,
		}
	},
	automapIcon = 92,
	minimalSaveState = true,
	tags = { "level_decoration", "level_design" },
}

defineObject{
	name = "forest_ruins_pillar_02",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_pillar_02.fbx",
			staticShadow = true,
			dissolveStart = 3,
			dissolveEnd = 5,
			staticShadow = true,
		}
	},
	automapIcon = 92,
	minimalSaveState = true,
	tags = { "level_decoration", "level_design" },
}

defineObject{
	name = "forest_ruins_pillar_03",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_pillar_03.fbx",
			staticShadow = true,
			dissolveStart = 3,
			dissolveEnd = 5,
			staticShadow = true,
		}
	},
	automapIcon = 92,
	minimalSaveState = true,
	tags = { "level_decoration", "level_design" },
}

defineObject{
	name = "forest_ruins_arch",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_arch.fbx",
			staticShadow = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox1",
			size = vec(0.7, 3, 0.7),
			offset = vec(-1.5, 1.5, 0),
			--debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox2",
			size = vec(0.7, 3, 0.7),
			offset = vec(1.5, 1.5, 0),
			--debugDraw = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_decoration", "level_design" },
}

defineObject{
	name = "daemon_head_ruins",
	baseObject = "daemon_head",
	components = {
		{
			class = "Model",
			model = "assets/models/env/demon_head.fbx",
			offset = vec(0, 0, -0.25),
			staticShadow = true,
		}
	},
	minimalSaveState = true,
	tags = { "puzzle" }
}

defineObject{
	name = "receptor_ruins",
	baseObject = "receptor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/spell_receptor.fbx",
			offset = vec(0, 0, -0.10),
			staticShadow = true,
		}
	},
	tags = { "puzzle" }
}

defineObject{
	name = "lever_ruins",
	baseObject = "lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lever.fbx",
			offset = vec(0, 1.375, -0.18),
		}
	},
	tags = { "puzzle" }
}

defineObject{
	name = "forest_statue_pillar_01",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_pillar_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_statue_pillar_02",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_pillar_02.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_statue_pillar_03",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_pillar_03.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_ruins_pillar_fallen",	
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_pillar_fallen.fbx",
			staticShadow = true,
			dissolveStart = 3,
			dissolveEnd = 5,
			staticShadow = true,
		},
		{
			class = "Obstacle",
		},
		{
			class = "ProjectileCollider",
		},
	},
	placement = "floor",
	editorIcon = 56,
	minimalSaveState = true,
	tags = { "level_decoration", "level_design" },
}

defineObject{
	name = "forest_ruins_dome",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_dome.fbx",
			staticShadow = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox1",
			size = vec(0.7, 3, 0.7),
			offset = vec(-1.5, 1.5, 1.5),
			--debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox2",
			size = vec(0.7, 3, 0.7),
			offset = vec(1.5, 1.5, 1.5),
			--debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox3",
			size = vec(0.7, 3, 0.7),
			offset = vec(-1.5, 1.5, -1.5),
			--debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox4",
			size = vec(0.7, 3, 0.7),
			offset = vec(1.5, 1.5, -1.5),
			--debugDraw = true,
		},
	},
	editorIcon = 100,
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "forest_ruins_fallen_bricks",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_fallen_bricks.fbx",
			castShadow = false,
		}
	},
	editorIcon = 136,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_ruins_ground_tile_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_ground_tile_01.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			castShadow = false,
		}
	},
	editorIcon = 136,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_ruins_ground_tile_02",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_ground_tile_02.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			castShadow = false,
		}
	},
	editorIcon = 136,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_ruins_ground_tile_03",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_ground_tile_03.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			castShadow = false,
		}
	},
	editorIcon = 136,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_ruins_ground_tile_balance",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_ground_tile_balance.fbx",
			castShadow = false,
		}
	},
	editorIcon = 136,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_bridge",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_bridge.fbx",
			staticShadow = true,
		},
		{
			class = "Platform",
		},
	},
	editorIcon = 184,
	automapIcon = 136,
	tags = { "level_design" },
}

defineObject{
	name = "forest_bridge_end",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_bridge_end.fbx",
			staticShadow = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox1",
			size = vec(0.3, 1.25, 0.3),
			offset = vec(-1.27, 0.525, -0.2),
		},
		{
			class = "ItemConstrainBox",
			name = "cbox2",
			size = vec(0.3, 1.25, 0.3),
			offset = vec(1.27, 0.525, -0.2),
		},
	},
	editorIcon = 92,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_bridge_middle_pillar",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_bridge_middle_pillar.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_bridge_pillar",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_bridge_pillar.fbx",
			staticShadow = true,
		},
	},
	placement = "pillar",
	editorIcon = 180,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_old_oak",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_old_oak.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
	},
	placement = "floor",
	editorIcon = 172,
	automapTile = "trees",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "forest_stairs_down",
	baseObject = "base_stairs_down",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_stairs_down.fbx",
			staticShadow = true,
			onInit = function(self)
				local dx,dy = getForward(self.go.facing)
				local x = self.go.x + dx
				local y = self.go.y + dy
				if x >= 0 and y >= 0 and x < 32 and y < 32 then
					self.go.map:setAutomapTile(x, y, 4)	-- rocky wall
				end
			end,
			staticShadow = true,
		},
	},
	tags = { "level_design" },
}

defineObject{
	name = "forest_statue_1",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_1.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "forest_statue_2",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_2.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "forest_statue_3",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_3.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_statue_3_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "forest_fountain",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_fountain.fbx",
			staticShadow = true,
		},
		{
			class = "MapGraphics",
			image = "assets/textures/gui/automap/fountain.tga",
			offset0 = vec(0, -1),
			offset2 = vec(-1, 0),
			offset3 = vec(-1, -1),
		},
	},
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "forest_falling_leaves",
	components = {
		{
			class = "Particle",
			particleSystem = "forest_falling_leaves"
		},
	},
	placement = "floor",
	editorIcon = 88,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_fireflies",
	components = {
		{
			class = "Particle",
			particleSystem = "forest_fireflies",
			offset = vec(0, 1.8, 0),
		},
		{
			class = "Light",
			offset = vec(0, 1.8, 0),
			range = 5,
			color = vec(0.2, 0.75, 0.5),
			brightness = 4,
			fillLight = true,
		},
			{
			class = "Controller",
			onActivate = function(self)
				self.go.light:enable()
				self.go.particle:enable()
			end,
			onDeactivate = function(self)
				self.go.light:disable()
				self.go.particle:disable()
			end,
			onToggle = function(self)
				if self.go.light:isEnabled() then
					self.go.light:disable()
					self.go.particle:disable()
				else
					self.go.light:enable()
					self.go.particle:enable()
				end
			end,
		},	
	},
	placement = "floor",
	editorIcon = 88,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_chasm_edge",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_pit_edge.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_chasm_corner",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_pit_edge_corner.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_chasm",
	components = {
		{
			class = "Pit",
			onInit = function(self)
				-- spawn edges
				local adj = {}
				for i=0,3 do
					local dx,dy = getForward(i)
					local adjacent = false
					for e in self.go.map:entitiesAt(self.go.x + dx, self.go.y + dy) do
						if e.name == "forest_chasm" then
							adjacent = true
							break
						end
					end
					adj[i] = adjacent
					if not adjacent then
						spawn("forest_chasm_edge", self.go.level, self.go.x, self.go.y, i, 0)
					end
				end
				
				-- spawn corners
				for i=0,3 do
					if not adj[i] and not adj[(i+3)%4] then
						spawn("forest_chasm_corner", self.go.level, self.go.x, self.go.y, i, 0)
					end
				end
			end,
		},
	},
	replacesFloor = true,
	placement = "floor",
	killHeightmap = true,
	editorIcon = 40,
	tags = { "level_design" },
}

defineObject{
	name = "forest_elevation_edge",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_elevation_edge.fbx",
			dissolveStart = 5,
			dissolveEnd = 9,
			staticShadow = true,
		},		
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_elevation_ledge",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_elevation_ledge.fbx",
			staticShadow = true,
		},
	},
	placement = "wall",
	editorIcon = 160,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_pit_fog",
	components = {
		{
			class = "Particle",
			particleSystem = "forest_pit_fog",
		},
	},
	placement = "floor",
	editorIcon = 88,
	tags = { "level_decoration" },
}


defineObject{
	name = "forest_darkness",
	components = {
		{
			class = "Particle",
			particleSystem = "forest_darkness",
		},
	},
	placement = "floor",
	editorIcon = 88,
	tags = { "level_decoration" },
}

defineParticleSystem{
	name = "forest_darkness",
	emitters = {
		-- fog
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 500,
			boxMin = {-9.0, -1.0,-9.0},
			boxMax = { 9.0,  0.0, 9.0},
			sprayAngle = {0,360},
			velocity = {0.1,0.3},
			--objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {5,5},
			color0 = {0,0,0},
			opacity = 0.3,
			fadeIn = 0.5,
			fadeOut = 2,
			size = {1.5, 2.5},
			gravity = {0,0.25,0},
			airResistance = 0.1,
			rotationSpeed = 0.1,
			blendMode = "Translucent",
			depthBias = 1.0,
		},

		-- fog
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 500,
			boxMin = {-9.0, -1.0,-9.0},
			boxMax = { 9.0,  0.0, 9.0},
			sprayAngle = {0,360},
			velocity = {0.1,0.3},
			--objectSpace = true,
			texture = "assets/textures/particles/darkness_cloud.tga",
			lifetime = {5,5},
			color0 = {0.0,0.0,0.0},
			opacity = 0.3,
			fadeIn = 0.5,
			fadeOut = 2,
			size = {1.5, 2.5},
			gravity = {0,0.25,0},
			airResistance = 0.1,
			rotationSpeed = 0.1,
			blendMode = "Translucent",
			depthBias = 1.0,
		},

		-- fog
		{
			emissionRate = 500,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-9.0, -2.0,-9.0},
			boxMax = { 9.0, -2.0, 9.0},
			sprayAngle = {0,0},
			velocity = {0.1,0.3},
			--objectSpace = true,
			texture = "assets/textures/particles/darkness_cloud.tga",
			lifetime = {10,10},
			color0 = {0.0,0.0,0.0},
			opacity = 1.0,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {2.5, 3.5},
			gravity = {0,0.0,0},
			airResistance = 0.1,
			rotationSpeed = 0.1,
			blendMode = "Translucent",
			depthBias = 1.0,
		},
	}
}

defineObject{
	name = "forest_wall_text_short",
	baseObject = "base_wall_text",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_wall_text_short.fbx",
			staticShadow = true,
		},
	},
	replacesWall = false,
	tags = { "puzzle" }
}

defineObject{
	name = "forest_wall_text_long",
	baseObject = "base_wall_text",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_wall_text_long.fbx",
			staticShadow = true,
		},
	},
	replacesWall = false,
	tags = { "puzzle" }
}

defineObject{
	name = "forest_lantern",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_lantern.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.1, 0),
			range = 6,
			color = math.saturation(vec(1, 0.5, 0.1), 0.8),
			brightness = 8,
			castShadow = true,
			shadowMapSize = 64,
			staticShadows = true,
			staticShadowDistance = 0,	-- use static shadows always
			onInit = function(self)
				-- optimization: disable casting light towards -Y
				self:setClipDistance(3, 0)
			end,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Particle",
			particleSystem = "forest_lantern",
			offset = vec(0, 1.18, 0),
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.light:enable()
				self.go.particle:enable()
			end,
			onDeactivate = function(self)
				self.go.light:disable()
				self.go.particle:disable()
			end,
			onToggle = function(self)
				if self.go.light:isEnabled() then
					self.go.light:disable()
					self.go.particle:disable()
				else
					self.go.light:enable()
					self.go.particle:enable()
				end
			end,
		},
	},
	placement = "wall",
	editorIcon = 88,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_lantern_blue",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_lantern.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.1, 0),
			range = 6,
			color = math.saturation(vec(0.1, 0.5, 1.0), 0.8),
			brightness = 8,
			castShadow = true,
			shadowMapSize = 64,
			staticShadows = true,
			staticShadowDistance = 0,	-- use static shadows always
			onInit = function(self)
				-- optimization: disable casting light towards -Y
				self:setClipDistance(3, 0)
			end,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Particle",
			particleSystem = "forest_lantern_blue",
			offset = vec(0, 1.18, 0),
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.light:enable()
				self.go.particle:enable()
			end,
			onDeactivate = function(self)
				self.go.light:disable()
				self.go.particle:disable()
			end,
			onToggle = function(self)
				if self.go.light:isEnabled() then
					self.go.light:disable()
					self.go.particle:disable()
				else
					self.go.light:enable()
					self.go.particle:enable()
				end
			end,
		},
	},
	placement = "wall",
	editorIcon = 88,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_pit",
	baseObject = "base_pit",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_pit.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
	},
	tags = { "level_design" },
}

defineObject{
	name = "forest_pit_trapdoor",
	baseObject = "base_pit_trapdoor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_pit.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Model",
			name = "trapDoorModel",
			model = "assets/models/env/mine_pit_trapdoor.fbx",
		},
		{
			class = "Animation",
			model = "trapDoorModel",
			animations = {
				open = "assets/animations/env/mine_pit_trapdoor_open.fbx",
				close = "assets/animations/env/mine_pit_trapdoor_close.fbx",
			},
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "forest_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_pressure_plate.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/forest_pressure_plate_down.fbx",
				deactivate = "assets/animations/env/forest_pressure_plate_up.fbx",
			},
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "forest_underwater_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_pressure_plate.fbx",
			materialOverrides = { ["forest_ground_01"] = "swamp_ground_01" },
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/forest_pressure_plate_down.fbx",
				deactivate = "assets/animations/env/forest_pressure_plate_up.fbx",
			},
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "forest_ruins_secret_button_small",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_secret_button_small.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/forest_ruins_secret_button_small_press.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(0.45, 1.05, 0),
			size = vec(0.3, 0.25, 0.45),
			-- debugDraw = true,
		},
		{
			class = "Door",
		},
		{
			class = "Occluder",
			model = "assets/models/env/forest_ruins_wall_02_occluder.fbx",
		},
	},
	replacesWall = true,
	automapIcon = 88,
	tags = { "puzzle" }
}

defineObject{
	name = "forest_ruins_secret_button_big",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_ruins_secret_button_big.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/forest_ruins_secret_button_big_press.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(0.05, 1.63, -0.2),
			size = vec(0.35, 0.2, 0.15),
			--debugDraw = true,
		},
		{
			class = "Door",
		},
		{
			class = "Occluder",
			model = "assets/models/env/forest_ruins_wall_02_occluder.fbx",
		},
	},
	replacesWall = true,
	automapIcon = 88,
	tags = { "puzzle" }
}

defineObject{
	name = "forest_border_rocks_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_border_rocks_01.fbx",
			dissolveStart = 7,
			dissolveEnd = 9,
			staticShadow = true,
		},
	},
	placement = "wall",
	editorIcon = 160,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_willow",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_willow.fbx",
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_willow_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
		},
	},
	placement = "floor",
	editorIcon = 172,
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "background_mountain",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/background_mountain.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "background_hill_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/background_hill_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "forest_seaweed_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_seaweed_pillar.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_seaweed_pillar_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	placement = "pillar",
	editorIcon = 180,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_seaweed_wall_decoration_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_seaweed_wall_decoration_01.fbx",
			dissolveStart = 5,
			dissolveEnd = 7,
		}
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_seaweed_floor_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_seaweed_floor_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_seaweed_floor_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	editorIcon = 240,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_seaweed_floor_02",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_seaweed_floor_02.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_seaweed_floor_02_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	editorIcon = 240,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_seaweed_wall_decoration_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_seaweed_wall_decoration_02.fbx",
			dissolveStart = 5,
			dissolveEnd = 7,
		}
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_underwater_bubbles",
	components = {
		{
			class = "Particle",
			particleSystem = "forest_underwater_bubbles"
		},
	},
	placement = "floor",
	editorIcon = 88,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_underwater_plankton",
	components = {
		{
			class = "Particle",
			particleSystem = "forest_underwater_plankton"
		},
	},
	placement = "floor",
	editorIcon = 88,
	tags = { "level_decoration" },
}

defineObject{
	name = "forest_elevation_edge_overhang",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_elevation_edge_overhang.fbx",
			staticShadow = true,
		},
	},
	placement = "pillar",
	editorIcon = 180,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "crow",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/crow2.fbx",
		},
		{
			class = "CrowController",
		},
		-- {
			-- class = "Animation",
			-- animations = {
				-- idle = "assets/animations/monsters/crow/crow_idle.fbx",
				-- peck = "assets/animations/monsters/crow/crow_peck.fbx",
				-- fly = "assets/animations/monsters/crow/crow_fly.fbx",
				-- glide = "assets/animations/monsters/crow/crow_glide.fbx",
			-- },
			-- playOnInit = "idle",
			-- loop = true,
		-- },
	},
	placement = "floor",
	editorIcon = 252,
	reflectionMode = "never",
	tags = { "level_decoration" },
}

defineObject{
	name = "small_fish",
	components = {
		{
			class = "Model",
			model = "assets/models/env/small_fish.fbx",
		},
		{
			class = "SmallFishController",
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/env/small_fish_idle.fbx",
				move = "assets/animations/env/small_fish_swim.fbx",
			},
			playOnInit = "idle",
			loop = true,
			maxUpdateDistance = 5,
		},
		{
			class = "Clickable",
			maxDistance = 0,
		}
	},
	editorIcon = 252,
	placement = "floor",
	reflectionMode = "never",
	tags = { "level_decoration" },
}

defineObject{
	name = "crows_flying",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/crow.fbx",
			castShadow = true,
			--dissolveStart = 2,
			--dissolveEnd = 4,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/monsters/crow/crow_circle_fly.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 10,
		},
		
	},
	editorIcon = 252,
}

defineObject{
	name = "forest_statue_pillar_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_pillar_01.fbx",
			offset = vec(0, -1, 0),			
			rotation = vec(0, 38, 0),
			staticShadow = true,
			--debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(-0.12, 1.5, -0.5),
			size = vec(0.2, 0.2, 0.2),
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(-0.14, 1.46, -0.55),
			rotation = vec(0, 1.5, 12),
			onAcceptItem = function(self, item)
				if item.go.name ~= "blue_gem" then
					hudPrint("The item does not fit well into the fish's mouth.")
					return false
				else
					playSound("key_lock")
					return true
				end
			end,
			--debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			offset = vec(0.0, 1.5, 0.0),
			size = vec(0.9, 3, 0.9),
			--debugDraw = true,
		},
		{
			class = "ProjectileCollider",
			size = vec(1.1, 3, 0.8),
			--debugDraw = true,
		},
	},
	minimalSaveState = true,
	tags = { "puzzle" }
}

defineObject{
	name = "forest_bridge_no_icon",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_bridge.fbx",
			staticShadow = true,
		},
		{
			class = "Platform",
		},
	},
	editorIcon = 184,
	automapIcon = -1,
	tags = { "level_decoration" }
}

defineObject{
	name = "forest_altar",
	baseObject = "base_altar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_altar.fbx",
			staticShadow = true,
		},
		{
			class = "Surface",
			offset = vec(0, 0.88, 0),
			size = vec(2.1, 1.2),
			onRemoveItem = function(self, item)
				if item.go.name == "enchanted_timepiece" then
					functions2.script.setGotDevice()
				end
			end,
		},
	},
	automapIcon = 152,
	tags = { "level_decoration" },
}

defineObject{
	name = "burnt_oak",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/env/burnt_oak.fbx",
			dissolveStart = 2,
			dissolveEnd = 5,
			shadowLod = 1,
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/forest_oak_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	placement = "pillar",
	editorIcon = 180,
	minimalSaveState = true,
	tags = { "level_decoration", "level_design" },
}

-- Waterfall
defineObject{
	name = "sx_forest_waterfall",
	components = {
		 {
		 class = "Model",
		  model = "mod_assets/models/env/sx_forest_waterfall.fbx",
		  offset = vec(0, -0.7,-0.2),
		  materialOverrides = { sx_forest_waterfall_01 = "sx_forest_waterfall_02" },
	   },
		 {
		 class = "Model",
		  model = "mod_assets/models/env/sx_forest_waterfall.fbx",
		  name = "second_water_plane",
		  offset = vec(0, -0.7,-0.2),
	   },
		 {
		  class = "Model",
		  name = "rock_base",
		  model = "mod_assets/models/env/sx_forest_waterfall_base.fbx",
		  offset = vec(0, -0.7, 0),
	   },		
	   {
		  class = "Particle",
		  emitterMesh = "mod_assets/models/env/sx_forest_waterfall_particle_rim.fbx",
		  particleSystem = "sx_waterspray",
		  offset = vec(0, -0.6, -2),
	   },
 },
	placement = "pillar",
	editorIcon = 108,
	dontAdjustHeight = true,
	minimalSaveState = true,
 }
 
 defineObject{
	name = "sx_forest_waterfall_01_base",
	components = {
		 {
		  class = "Model",
		  model = "mod_assets/models/env/sx_forest_waterfall_base.fbx",
		  offset = vec(0, 0, 0),
	   },		
 },
	placement = "pillar",
	editorIcon = 108,
	dontAdjustHeight = true,
	minimalSaveState = true,
 }

 defineParticleSystem{
	name = "sx_waterspray",
	emitters = {
	
		-- waterspay effect
		{
			emitterShape = "MeshShape",
			emissionRate = 50,
			emissionTime = 0,
			maxParticles = 1000,
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,5},
			color0 = {1, 1, 1},
			opacity = 0.9,
			fadeIn = 1,
			fadeOut = 4,
			size = {1, 2},
			gravity = {0,0.5,-0.2},
			airResistance = 0.5,
			rotationSpeed = 0.5,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineObject{
   name = "sx_waterspray_particles",
   components = {
		{
         class = "Model",
         model = "mod_assets/models/env/sx_forest_waterfall_particle_rim.fbx",
		 castShadow = false,
		 debugDraw = true,
      },
      {
		 class = "Particle",
		 emitterMesh = "mod_assets/models/env/sx_forest_waterfall_particle_rim.fbx",
		 offset = vec(0, -0.3, -0.3),
		 particleSystem = "sx_waterspray",
		 debugDraw = true,
	  },
     {
		 class = "Particle",
		 name = "secondplane",
		 emitterMesh = "mod_assets/models/env/sx_forest_waterfall_particle_rim.fbx",
		 offset = vec(0, -0.3, -0.5),
		 particleSystem = "sx_waterspray",
		 debugDraw = true,
	  },
     {
		 class = "Particle",
		 name = "thirdplane",
		 emitterMesh = "mod_assets/models/env/sx_forest_waterfall_particle_rim.fbx",
		 offset = vec(0, -0.3, -0.7),
		 particleSystem = "sx_waterspray",
		 debugDraw = true,
	  },
},
   placement = "pillar",
   editorIcon = 108,
   dontAdjustHeight = true,
   minimalSaveState = true,
}