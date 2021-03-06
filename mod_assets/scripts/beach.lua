defineObject{
	name = "beach_high_rock_wall_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_01.fbx",
			dissolveStart = 5,
			dissolveEnd = 7,
			staticShadow = true,
			rotation = vec(0, 0, 180),
			offset = vec(0, 5, 0),
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_wall_01_occluder.fbx",
		},
	},
	editorIcon = 160,
	minimalSaveState = true,
}

defineObject{
	name = "beach_high_rock_pillar_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_pillar_01.fbx",
			dissolveStart = 6,
			dissolveEnd = 9,
			staticShadow = true,
			rotation = vec(0, 0, 180),
			offset = vec(0, 5, 0),
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}