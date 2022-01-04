defineObject{
	name = "dummy",
	placement = "floor",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/snail.fbx", -- simplest existing valid monster model (would be easy to make a new one though)
			storeSourceData = true,
			enabled = false,
		},
		{
			class = "Animation",
			animations = {idle = "assets/animations/monsters/snail/snail_idle.fbx"},
			currentLevelOnly = true,
			enabled = false,
		},
		{
			class = "Monster",
			meshName = "snail_mesh",
			hitSound = "snail_hit",
			dieSound = "snail_die",
			hitEffect = "hit_goo",
			health = 100,
			capsuleHeight = 0,
			capsuleRadius = 0,
			collisionRadius = 0,
			exp = 0,
		},
	}
}