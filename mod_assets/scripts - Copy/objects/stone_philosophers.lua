defineObject{
	name = "forest_statue_wall_1",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_wall_1.fbx",
			offset = vec(0, 0, -1.5),
			staticShadow = true,
		},
		{
			class = "Model",
			name = "eyesModel",
			model = "assets/models/env/forest_statue_wall_eyes_1.fbx",
			offset = vec(0, 0, -1.5),
			staticShadow = true,
		},
		{
			class = "Light",
			name = "leftEyeLight",
			offset = vec(0.4, 1.55, 0),
			range = 0.7,
			--debugDraw = true,
		},
		{
			class = "Light",
			name = "rightEyeLight",
			offset = vec(-0.4, 1.55, 0),
			range = 0.7,
			--debugDraw = true,
		},
		{
			class = "Light",
			name = "bounceLight",
			offset = vec(0, 0.7, -1),
			range = 3,
			--debugDraw = true,
		},
		{
			class = "Sound",
			sound = "stone_philosopher_speak",
			soundType = "ambient",
			enabled = false,
			fadeOut = 0,
		},
		{
			class = "Sound",
			name = "eyesSound",
			sound = "stone_philosopher_eyes",
			enabled = false,
		},
		{
			class = "StonePhilosopherController",
		},
		{
			class = "WallText",
			style = "writer",
		},
		{
			class = "Clickable",
			offset = vec(0, 1.5, 1.2),
			size = vec(1.2, 1.5, 0.2),
			frontFacing = true,
			--debugDraw = true,
		},
	},
	editorIcon = 92,
}

defineObject{
	name = "forest_statue_wall_center",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_wall_1.fbx",
			offset = vec(0, 0, -3),
			staticShadow = true,
		},
		{
			class = "Model",
			name = "eyesModel",
			model = "assets/models/env/forest_statue_wall_eyes_1.fbx",
			offset = vec(0, 0, -3),
			staticShadow = true,
		},
		{
			class = "Light",
			name = "leftEyeLight",
			offset = vec(0.4, 1.55, -1.5),
			range = 0.7,
			--debugDraw = true,
		},
		{
			class = "Light",
			name = "rightEyeLight",
			offset = vec(-0.4, 1.55, -1.5),
			range = 0.7,
			--debugDraw = true,
		},
		{
			class = "Light",
			name = "bounceLight",
			offset = vec(0, 0.7, -2.5),
			range = 3,
			--debugDraw = true,
		},
		{
			class = "Sound",
			sound = "stone_philosopher_speak",
			soundType = "ambient",
			enabled = false,
			fadeOut = 0,
		},
		{
			class = "Sound",
			name = "eyesSound",
			sound = "stone_philosopher_eyes",
			enabled = false,
		},
		{
			class = "StonePhilosopherController",
		},
		{
			class = "WallText",
			style = "writer",
		},
		{
			class = "Clickable",
			offset = vec(0, 1.5, -2.2),
			size = vec(1.2, 1.5, 0.2),
			--frontFacing = false,
			--debugDraw = true,
		},
	},
	editorIcon = 92,
}

defineObject{
	name = "mine_statue_wall",
	baseObject = "forest_statue_wall_1",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_statue_wall.fbx",
			offset = vec(0, 0, -1.55),
			staticShadow = true,
		},
		{
			class = "Model",
			name = "eyesModel",
			model = "assets/models/env/mine_statue_wall_eyes.fbx",
			offset = vec(0, 0, -1.55),
			staticShadow = true,
		},
	},
}

defineObject{
	name = "beacon_furnace_head",
	baseObject = "forest_statue_wall_1",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beacon_furnace_head.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "eyesModel",
			model = "assets/models/env/beacon_furnace_head_eyes.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			name = "leftEyeLight",
			offset = vec(0.4, 1.85, -0.3),
			range = 0.7,
			--debugDraw = true,
		},
		{
			class = "Light",
			name = "rightEyeLight",
			offset = vec(-0.4, 1.85, -0.3),
			range = 0.7,
			--debugDraw = true,
		},
		{
			class = "Light",
			name = "bounceLight",
			offset = vec(0, 1, -1.3),
			range = 3,
			--debugDraw = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/castle_wall_01_occluder.fbx",
		},
	},
}
