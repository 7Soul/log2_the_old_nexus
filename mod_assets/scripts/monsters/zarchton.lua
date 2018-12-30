defineObject{
	name = "zarchton2",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/zarchton.fbx",
			storeSourceData = true, -- must be enabled for mesh particles to work
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/monsters/zarchton/zarchton_idle.fbx",
				moveForward = "assets/animations/monsters/zarchton/zarchton_walk.fbx",
				moveBackward = "assets/animations/monsters/zarchton/zarchton_move_backward.fbx",
				turnLeft = "assets/animations/monsters/zarchton/zarchton_turn_left.fbx",
				turnRight = "assets/animations/monsters/zarchton/zarchton_turn_right.fbx",
				attack = "assets/animations/monsters/zarchton/zarchton_attack.fbx",
				leapAttack = "assets/animations/monsters/zarchton/zarchton_move_attack.fbx",
				getHitFrontLeft = "assets/animations/monsters/zarchton/zarchton_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/zarchton/zarchton_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/zarchton/zarchton_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/zarchton/zarchton_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/zarchton/zarchton_get_hit_right.fbx",
				fall = "assets/animations/monsters/zarchton/zarchton_get_hit_front_left.fbx",
				riseFromWater = "assets/animations/monsters/zarchton/zarchton_rise_from_water.fbx",
			},
			currentLevelOnly = true,
		},
		{
			class = "Monster",
			meshName = "zarchton_mesh",
			hitSound = "zarchton_hit",
			dieSound = "zarchton_die",
			footstepSound = "zarchton_footstep",
			hitEffect = "hit_blood",
			capsuleHeight = 0.2,
			capsuleRadius = 0.7,
			health = 90,
			evasion = 0,
			exp = 75,
			--lootDrop = { 100, "zarchton_harpoon"},
			resistances = { ["shock"] = "weak" },
		},
		{
			class = "ZarchtonBrain",
			name = "brain",
			sight = 5,
		},
		{
			class = "MonsterMove",
			name = "move",
			sound = "zarchton_walk",
			cooldown = 3,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "zarchton_walk",
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 10,
			accuracy = 15,
			cooldown = 4,
			sound = "zarchton_attack",
		},
		{
			class = "MonsterMoveAttack",
			name = "leapAttack",
			attackPower = 20,
			accuracy = 50,
			cooldown = 10,
			animation = "leapAttack",
			sound = "zarchton_leap_attack",
		},
	},
}

defineObject{
	name = "zarchton_pair",
	baseObject = "base_monster_group",	
	components = {
		{
			class = "MonsterGroup",
			monsterType = "zarchton",
			count = 2,
		}
	},
}

defineObject{
	name = "zarchton_ambush",
	baseObject = "zarchton",
	components = {
		{
			class = "Monster",
			meshName = "zarchton_mesh",
			hitSound = "zarchton_hit",
			dieSound = "zarchton_die",
			footstepSound = "zarchton_footstep",
			hitEffect = "hit_blood",
			capsuleHeight = 0.2,
			capsuleRadius = 0.7,
			health = 90,
			evasion = 0,
			exp = 75,
			--lootDrop = { 100, "zarchton_harpoon"},
			resistances = { ["shock"] = "weak" },
			onInit = function(self)
				self:performAction("riseFromWater")
				self.go:playSound("water_hit_small")
				self.go:playSound("zarchton_walk")
			end,
		},
		{
			class = "MonsterAction",
			name = "riseFromWater",
			animation = "riseFromWater",
		},
	},
}

defineAnimationEvent{
	animation = "assets/animations/monsters/zarchton/zarchton_attack.fbx",
	event = "attack",
	frame = 11,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/zarchton/zarchton_move_attack.fbx",
	event = "move_forward",
	frame = 20,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/zarchton/zarchton_move_attack.fbx",
	event = "attack",
	frame = 22,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/zarchton/zarchton_move_backward.fbx",
	event = "move",	-- move monster backwards very fast so that we can evade most attacks
	frame = 4,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/zarchton/zarchton_walk.fbx",
	event = "footstep",
	frame = 6,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/zarchton/zarchton_move_backward.fbx",
	event = "footstep",
	frame = 20,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/zarchton/zarchton_move_backward.fbx",
	event = "footstep",
	frame = 25,
}

defineSound{
	name = "zarchton_walk",
	filename = {
		"assets/samples/monsters/zarchton_walk_01.wav",
		"assets/samples/monsters/zarchton_walk_02.wav",
		"assets/samples/monsters/zarchton_walk_02.wav",
		},
	loop = false,
	volume = 0.7,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "zarchton_footstep",
	filename = "assets/samples/monsters/zarchton_footstep_01.wav",
	loop = false,
	volume = 0.25,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "zarchton_attack",
	filename = "assets/samples/monsters/zarchton_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "zarchton_leap_attack",
	filename = "assets/samples/monsters/zarchton_leap_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}

defineSound{
	name = "zarchton_hit",
	filename = { 
		"assets/samples/weapons/hit_bone_01.wav",
		"assets/samples/weapons/hit_bone_02.wav",
		"assets/samples/weapons/hit_flesh_01.wav",
	},
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "zarchton_die",
	filename = "assets/samples/monsters/zarchton_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}
