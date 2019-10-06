defineObject{
	name = "crab",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/cave_crab.fbx",
			storeSourceData = true,
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/monsters/cave_crab/cave_crab_idle.fbx",
				moveForward = "assets/animations/monsters/cave_crab/cave_crab_walk.fbx",
				turnLeft = "assets/animations/monsters/cave_crab/cave_crab_turn_left.fbx",
				turnRight = "assets/animations/monsters/cave_crab/cave_crab_turn_right.fbx",
				strafeLeft = "assets/animations/monsters/cave_crab/cave_crab_strafe_left.fbx",
				strafeRight = "assets/animations/monsters/cave_crab/cave_crab_strafe_right.fbx",
				attack = "assets/animations/monsters/cave_crab/cave_crab_attack.fbx",
				getHitFrontLeft = "assets/animations/monsters/cave_crab/cave_crab_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/cave_crab/cave_crab_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/cave_crab/cave_crab_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/cave_crab/cave_crab_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/cave_crab/cave_crab_get_hit_right.fbx",
				fall = "assets/animations/monsters/cave_crab/cave_crab_get_hit_front_left.fbx",
			},
			currentLevelOnly = true,
		},
		{
			class = "Monster",
			meshName = "crab_mesh",
			hitSound = "crab_hit",
			dieSound = "crab_die",
			hitEffect = "hit_goo",
			capsuleHeight = 0.4,
			capsuleRadius = 0.6,
			health = 650,
			protection = 20,
			evasion = 0,
			exp = 450,
			resistances = { 
				["shock"] = "weak"
			 },
			traits = { "animal" },
		},
		{
			class = "CrabBrain",
			name = "brain",
			sight = 2.5,
		},
		{
			class = "MonsterMove",
			name = "move",
			sound = "crab_walk",
			cooldown = 1.5,
			onBeginAction = function(self)
				functions.script.takeBleedDamage(self.go.monster)
			end,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "crab_walk",
			animationSpeed = 1.1,
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 45,
			accuracy = 10,
			woundChance = 40,
			cooldown = 4,
			animationSpeed = 1.2,
			sound = "crab_attack",
		},
	},
}

defineAnimationEvent{
	animation = "assets/animations/monsters/cave_crab/cave_crab_attack.fbx",
	event = "attack",
	frame = 13,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/cave_crab/cave_crab_attack.fbx",
	event = "attack",
	frame = 23,
}

defineSound{
	name = "crab_attack",
	filename = "assets/samples/monsters/crab_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "crab_walk",
	filename = "assets/samples/monsters/crab_walk_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "crab_hit",
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
	name = "crab_die",
	filename = "assets/samples/monsters/crab_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}
