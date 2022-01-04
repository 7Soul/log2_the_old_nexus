defineObject{
	name = "undead",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/undead.fbx",
			storeSourceData = true, -- must be enabled for mesh particles to work
		},
		{
			class = "Animation",
			animations = {
				rise = "assets/animations/monsters/undead/undead_rise.fbx",
				idle = "assets/animations/monsters/undead/undead_idle.fbx",
				moveForward = "assets/animations/monsters/undead/undead_walk.fbx",
				turnLeft = "assets/animations/monsters/undead/undead_turn_left.fbx",
				turnRight = "assets/animations/monsters/undead/undead_turn_right.fbx",
				attack = "assets/animations/monsters/undead/undead_attack.fbx",
				getHitFrontLeft = "assets/animations/monsters/undead/undead_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/undead/undead_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/undead/undead_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/undead/undead_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/undead/undead_get_hit_right.fbx",
				fall = "assets/animations/monsters/undead/undead_get_hit_front_left.fbx",
			},
			currentLevelOnly = true,
		},
		{
			class = "Monster",
			meshName = "undead_mesh",
			footstepSound = "skeleton_footstep",
			hitSound = "skeleton_hit",
			dieSound = "undead_die",
			hitEffect = "hit_dust",
			capsuleHeight = 0.7,
			capsuleRadius = 0.25,
			collisionRadius = 0.6,
			health = 475,
			immunities = { "sleep" },
			resistances = { ["poison"] = "immune" },
			traits = { "undead" },
			evasion = 0,
			exp = 200,
			onInit = function(self)
				self:performAction("rise")
			end,
			headRotation = vec(0, 0, 90),
		},
		{
			class = "MeleeBrain",
			name = "brain",
			sight = 5,
			morale = 100,
		},
		{
			class = "MonsterAction",
			name = "rise",
			animation = "rise",
		},
		{
			class = "MonsterMove",
			name = "move",
			sound = "undead_walk",
			cooldown = 6,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "undead_walk",
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 19,
			pierce = 7,
			cooldown = 4,
			sound = "undead_attack",
		},
		{
			class = "Particle",
			particleSystem = "undead_rise",
			disableSelf = true,
		},
	},
}

defineAnimationEvent{
	animation = "assets/animations/monsters/undead/undead_attack.fbx",
	event = "attack",
	frame = 10,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/undead/undead_attack.fbx",
	event = "attack",
	frame = 15,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/undead/undead_attack.fbx",
	event = "attack",
	frame = 20,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/undead/undead_attack.fbx",
	event = "attack",
	frame = 25,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/undead/undead_rise.fbx",
	event = "playSound:undead_rise",
	frame = 1,
}

defineSound{
	name = "undead_attack",
	filename = "assets/samples/monsters/undead_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "undead_walk",
	filename = {
		"assets/samples/monsters/undead_walk_01.wav",
		"assets/samples/monsters/undead_walk_02.wav",
		"assets/samples/monsters/undead_walk_02.wav",
		},
	loop = false,
	volume = 0.7,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "undead_die",
	filename = "assets/samples/monsters/undead_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "undead_rise",
	filename = "assets/samples/monsters/undead_rise_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}

defineParticleSystem{
	name = "undead_rise",
	emitters = {
		{
			emissionTime = 1.8,
			emissionRate = 500,
			maxParticles = 500,
			sprayAngle = {0,40},
			boxMin = {-0.7, -0.1, -0.7},
			boxMax = { 0.7, -0.1,  0.7},
			velocity = {2,2},
			objectSpace = false,
			texture = "assets/textures/particles/dirt.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.7,0.7},
			colorAnimation = false,
			color0 = {2, 2, 2},
			opacity = 0.7,
			fadeIn = 0.01,
			fadeOut = 0.3,
			size = {0.05, 0.3},
			gravity = {0,-10,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Translucent",
			clampToGroundPlane = true,
		},
		-- small dirt
		{
			emissionTime = 1.8,
			emissionRate = 300,
			maxParticles = 300,
			sprayAngle = {0,40},
			boxMin = {-0.7, -0.1, -0.7},
			boxMax = { 0.7, -0.1,  0.7},
			velocity = {2,5},
			objectSpace = false,
			texture = "assets/textures/particles/dirt.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.7,0.7},
			colorAnimation = false,
			color0 = {2, 2, 2},
			opacity = 0.7,
			fadeIn = 0.01,
			fadeOut = 0.3,
			size = {0.05, 0.15},
			gravity = {0,-10,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Translucent",
			clampToGroundPlane = true,
		},
		-- dust
		{
			emissionTime = 1,
			emissionRate = 20,
			maxParticles = 40,
			boxMin = {-0.7, 0.1, -0.7},
			boxMax = { 0.7, 0.1,  0.7},
			sprayAngle = {0,100},
			velocity = {0.5,2},
			objectSpace = false,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {0.3,3},
			color0 = {1.1, 0.9, 0.8},
			opacity = 0.4,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.4, 1},
			gravity = {0,0,0},
			airResistance = 2,
			rotationSpeed = 2,
			blendMode = "Translucent",
		},
	}
}
