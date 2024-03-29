defineObject{
	name = "scorched_root",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/monsters/scorched_root.fbx",
			storeSourceData = true, -- must be enabled for mesh particles to work
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/monsters/viper_root/viper_root_idle.fbx",
				rise = "assets/animations/monsters/viper_root/viper_root_rise.fbx",
				descend = "assets/animations/monsters/viper_root/viper_root_descend.fbx",
				attack = "assets/animations/monsters/viper_root/viper_root_attack.fbx",
				attackFromBehind = "assets/animations/monsters/viper_root/viper_root_attack_from_behind.fbx",
				spit = "assets/animations/monsters/viper_root/viper_root_spit.fbx",
				getHitFrontLeft = "assets/animations/monsters/viper_root/viper_root_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/viper_root/viper_root_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/viper_root/viper_root_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/viper_root/viper_root_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/viper_root/viper_root_get_hit_right.fbx",
				fall = "assets/animations/monsters/viper_root/viper_root_get_hit_front_left.fbx",
			},
			currentLevelOnly = true,
		},
		{
			class = "Monster",
			meshName = "viper_root_mesh",
			hitSound = "viper_root_hit",
			dieSound = "viper_root_die",
			hitEffect = "hit_wood",
			capsuleHeight = 0.2,
			capsuleRadius = 0.7,
			health = 500,
			protection = 9,
			evasion = 0,
			exp = 350,
			immunities = { "sleep", "frozen", "blinded" },
			resistances = {
				fire = "absorb",
				cold = "vulnerable",
				poison = "immune",
			},
			onInit = function(self)
				local dir = getDirection(party.x - self.go.x, party.y - self.go.y)
				self.go:setPosition(self.go.x, self.go.y, dir, self.go.elevation, self.go.level)
				self:performAction("rise")
			end,
			headRotation = vec(90, 0, 0),
		},
		{
			class = "ViperRootBrain",
			name = "brain",
			sight = 5,
			morale = 100,	-- fearless
		},
		{
			class = "MonsterAttack",
			name = "rise",
			attackPower = 22,
			accuracy = 50,
			cooldown = 0,
			animation = "rise",
			--sound = "viper_root_attack",
			cameraShake = true,
			cameraShakeDuration = 0.8,
			onBeginAction = function(self)
				self.go:spawn("particle_system").particle:setParticleSystem("scorched_root_rise")
			end,
		},
		{
			class = "MonsterAction",
			name = "descend",
			animation = "descend",
			onBeginAction = function(self)
				self.go:spawn("particle_system").particle:setParticleSystem("scorched_root_descend")
			end,
			onEndAction = function(self)
				self.go:setPosition(self.go.x, self.go.y, self.go.facing, self.go.elevation - 1, self.go.level)
			end,
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackFromBehindAnimation = "attackFromBehind",
			attackPower = 22,
			accuracy = 12,
			cooldown = 4,
			sound = "viper_root_attack",
			cameraShake = true,
			cameraShakeDuration = 0.8,
		},
		{
			class = "MonsterAttack",
			name = "rangedAttack",
			attackType = "projectile",
			animation = "spit",
			attackPower = 22,
			cooldown = 2,
			sound = "viper_root_ranged_attack",
			shootProjectile = "fireball_medium_cast",
			projectileHeight = 1.3,
		},
		{
			class = "Gravity",
			enabled = false,	-- gravity disabled so that the monster is not lifted above ground when hidden
		},
		{
			class = "Particle",
			name = "p1",
			particleSystem = "scorched_root",
			parentNode = "head",
		},
		{
			class = "Particle",
			name = "p2",
			particleSystem = "scorched_root",
			parentNode = "spine1",
		},
		{
			class = "Particle",
			name = "p3",
			particleSystem = "scorched_root",
			parentNode = "spine2",
		},
		{
			class = "Particle",
			name = "p4",
			particleSystem = "scorched_root_tentacle",
			parentNode = "tendril_ground_bottom4",
		},
		{
			class = "Particle",
			name = "p5",
			particleSystem = "scorched_root_tentacle",
			parentNode = "tendril_ground_bottom5",
		},
		{
			class = "Particle",
			name = "p6",
			particleSystem = "scorched_root_tentacle",
			parentNode = "tendril_ground_bottom6",
		},
		{
			class = "Particle",
			name = "p7",
			particleSystem = "scorched_root_tentacle",
			parentNode = "tendril_ground_bottom7",
		},
		{
			class = "Particle",
			name = "p8",
			particleSystem = "scorched_root_tentacle",
			parentNode = "tendril_ground_bottom8",
		},
	},
	editorIcon = 4,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/viper_root/viper_root_attack.fbx",
	event = "attack",
	frame = 15,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/viper_root/viper_root_attack_from_behind.fbx",
	event = "attack",
	frame = 12,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/viper_root/viper_root_spit.fbx",
	event = "attack", 
	frame = 10,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/viper_root/viper_root_rise.fbx",
	event = "playSound:viper_root_rise",
	frame = 0,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/viper_root/viper_root_rise.fbx",
	event = "playSound:viper_root_attack",
	frame = 15,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/viper_root/viper_root_descend.fbx",
	event = "playSound:viper_root_rise",
	frame = 0,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/viper_root/viper_root_rise.fbx",
	event = "attack",
	frame = 30,
}

defineSound{
	name = "viper_root_attack",
	filename = {
		"assets/samples/monsters/viper_root_attack_01.wav",
		"assets/samples/monsters/viper_root_attack_02.wav",
		"assets/samples/monsters/viper_root_attack_03.wav",
	},
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}

defineSound{
	name = "viper_root_rise",
	filename = "assets/samples/monsters/viper_root_rise_01.wav",
	loop = false,
	volume = 0.8,
	minDistance = 2,
	maxDistance = 10,
}

defineSound{
	name = "viper_root_ranged_attack",
	filename = "assets/samples/monsters/viper_root_ranged_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}

defineSound{
	name = "viper_root_hit",
	filename = { 
		"assets/samples/weapons/hit_bone_01.wav",
		"assets/samples/weapons/hit_flesh_01.wav",
		"assets/samples/monsters/viper_root_hit_01.wav",
		"assets/samples/monsters/viper_root_hit_01.wav",
		},
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "viper_root_die",
	filename = "assets/samples/monsters/viper_root_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}










defineParticleSystem{
	name = "scorched_root_rise",
	emitters = {
		{
			spawnBurst = true,
			maxParticles = 100,
			sprayAngle = {0,40},
			boxMin = {-1.3, 0, -1,3},
			boxMax = { 1.3, 0,  1.3},
			sprayAngle = {0, 100},
			velocity = {1,3},
			objectSpace = false,
			texture = "assets/textures/particles/dirt.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.3,0.7},
			colorAnimation = false,
			color0 = {2, 2, 2},
			opacity = 0.7,
			fadeIn = 0.01,
			fadeOut = 0.3,
			size = {0.05, 0.3},
			gravity = {0,-8,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Translucent",
			clampToGroundPlane = true,
		},
		-- small dirt
		{
			spawnBurst = true,
			maxParticles = 250,
			sprayAngle = {0,40},
			boxMin = {-1.3, 0, -1,3},
			boxMax = { 1.3, 0,  1.3},
			velocity = {2,7},
			objectSpace = false,
			texture = "assets/textures/particles/dirt.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.3,0.7},
			colorAnimation = false,
			color0 = {2, 2, 2},
			opacity = 0.7,
			fadeIn = 0.01,
			fadeOut = 0.3,
			size = {0.05, 0.15},
			gravity = {0,-8,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Translucent",
			clampToGroundPlane = true,
		},
		-- dust
		{
			spawnBurst = true,
			maxParticles = 50,
			boxMin = {-1.3, 0.2, -1,3},
			boxMax = { 1.3, 0.2,  1.3},
			sprayAngle = {0,100},
			velocity = {0.5,2},
			objectSpace = false,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {0.3,3},
			color0 = {1.1, 0.9, 0.8},
			opacity = 0.4,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.4, 1.5},
			gravity = {0,0,0},
			airResistance = 2,
			rotationSpeed = 2,
			blendMode = "Translucent",
		},
		-- flames
		{
			spawnBurst = true,
			maxParticles = 20,
			boxMin = {-1.3, -0.2, -1,3},
			boxMax = { 1.3, 0.2,  1.3},
			sprayAngle = {0,100},
			velocity = {0.1,2},
			objectSpace = false,
			texture = "assets/textures/particles/flame.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.4,2},
			colorAnimation = true,
			color0 = {2.0, 1.0, 1.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.3, 0.5},
			gravity = {0,0.5,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- sparks
		{
			spawnBurst = true,
			maxParticles = 150,
			boxMin = {-1.3, 0.5, -1,3},
			boxMax = { 1.3, 0.5,  1.3},
			sprayAngle = {0,360},
			velocity = {0.1,0.9},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.1,2.5},
			colorAnimation = true,
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.03, 0.06},
			gravity = {0,2,0},
			airResistance = 1.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- sparks faster
		{
			spawnBurst = true,
			maxParticles = 50,
			boxMin = {-1.3, 0.5, -1,3},
			boxMax = { 1.3, 0.5,  1.3},
			sprayAngle = {0,360},
			velocity = {0.1,0.9},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {1,2.9},
			colorAnimation = true,
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.03, 0.06},
			gravity = {0,3,0},
			airResistance = 2,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}

defineParticleSystem{
	name = "scorched_root_descend",
	emitters = {
		{
			emissionTime = 1.3,
			emissionRate = 150,
			maxParticles = 200,
			sprayAngle = {0,40},
			boxMin = {-1.0, 0, -1,0},
			boxMax = { 1.0, 0,  1.0},
			sprayAngle = {0, 100},
			velocity = {1,3},
			objectSpace = false,
			texture = "assets/textures/particles/dirt.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.3,0.7},
			colorAnimation = false,
			color0 = {2, 2, 2},
			opacity = 0.7,
			fadeIn = 0.01,
			fadeOut = 0.3,
			size = {0.05, 0.3},
			gravity = {0,-5,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Translucent",
			clampToGroundPlane = true,
		},
		-- small dirt
		{
			emissionTime = 1.3,
			emissionRate = 300,
			maxParticles = 300,
			sprayAngle = {0,40},
			boxMin = {-1.3, 0, -1,3},
			boxMax = { 1.3, 0,  1.3},
			velocity = {2,6},
			objectSpace = false,
			texture = "assets/textures/particles/dirt.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.3,0.7},
			colorAnimation = false,
			color0 = {2, 2, 2},
			opacity = 0.7,
			fadeIn = 0.01,
			fadeOut = 0.3,
			size = {0.05, 0.15},
			gravity = {0,-5,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Translucent",
			clampToGroundPlane = true,
		},
		-- dust
		{
			emissionTime = 1.3,
			emissionRate = 40,
			maxParticles = 40,
			boxMin = {-1.3, 0.2, -1,3},
			boxMax = { 1.3, 0.2,  1.3},
			sprayAngle = {0,100},
			velocity = {0.5,2},
			objectSpace = false,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {0.3,3},
			color0 = {1.1, 0.9, 0.8},
			opacity = 0.4,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.6, 1.3},
			gravity = {0,0,0},
			airResistance = 2,
			rotationSpeed = 0.5,
			blendMode = "Translucent",
		},
		-- flames
		{
			spawnBurst = true,
			emissionRate = 10,
			maxParticles = 40,
			boxMin = {-1.3, 0.2, -1,3},
			boxMax = { 1.3, 0.2,  1.3},
			sprayAngle = {0,100},
			velocity = {0.1,2},
			objectSpace = false,
			texture = "assets/textures/particles/flame.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.4,0.7},
			colorAnimation = true,
			color0 = {2.0, 1.0, 1.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.2},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.3, 0.5},
			gravity = {0,0.5,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- sparks
		{
			spawnBurst = true,
			emissionRate = 15,
			maxParticles = 20,
			boxMin = {-1.3, 0.2, -1,3},
			boxMax = { 1.3, 0.2,  1.3},
			sprayAngle = {0,100},
			velocity = {0.1,0.5},
			objectSpace = false,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.1,0.7},
			colorAnimation = true,
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.03, 0.06},
			gravity = {0,1,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}

defineParticleSystem{
	name = "scorched_root",
	emitters = {
		-- fog
		{
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 20,
			boxMin = {-0.25, -0.15,-0.25},
			boxMax = { 0.25, 0.15, 0.25},
			sprayAngle = {0,360},
			velocity = {0.1,0.4},
			--objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,3},
			color0 = {0.2, 0.2, 0.2},
			opacity = 0.1,
			fadeIn = 1.0,
			fadeOut = 1.0,
			size = {0.1, 0.7},
			gravity = {0,1,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Translucent",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},
		
		-- flames
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 20,
			boxMin = {-0.25, -0.15,-0.25},
			boxMax = { 0.25, 0.15, 0.25},
			sprayAngle = {0,360},
			velocity = {0.1,0.5},
			--objectSpace = true,
			texture = "assets/textures/particles/flame.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.4,0.7},
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.15, 0.4},
			gravity = {0,0.5,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},

		-- sparks
		{
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 20,
			boxMin = {-0.25, -0.15,-0.25},
			boxMax = { 0.25, 0.15, 0.25},
			sprayAngle = {0,360},
			velocity = {0.1,0.7},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.1,1},
			colorAnimation = true,
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.03, 0.06},
			gravity = {0,1,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},

		-- sparks2
		{
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 20,
			boxMin = {-0.25, -0.15,-0.25},
			boxMax = { 0.25, 0.15, 0.25},
			sprayAngle = {0,360},
			velocity = {0.1,0.7},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.5,1.5},
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.1},
			gravity = {0,2,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}

defineParticleSystem{
	name = "scorched_root_tentacle",
	emitters = {
		-- flames
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 40,
			boxMin = {-0.15, -0.1, -0.15},
			boxMax = {0.15, 0.1, 0.15},
			sprayAngle = {0,100},
			velocity = {0.1,0.3},
			--objectSpace = true,
			texture = "assets/textures/particles/flame.tga",
			frameRate = 40,
			frameSize = 32,
			frameCount = 40,
			lifetime = {0.1,0.5},
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.1, 0.3},
			gravity = {0,0.05,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.2,
		},

		-- sparks
		{
			emissionRate = 6,
			emissionTime = 0,
			maxParticles = 40,
			boxMin = {-0.1, -0.1, -0.1},
			boxMax = {0.1, 0.1, 0.1},
			sprayAngle = {0,100},
			velocity = {0.1,0.4},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.1,2},
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 0.8,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.03, 0.06},
			gravity = {0,1.2,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}