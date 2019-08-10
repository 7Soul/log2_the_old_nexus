defineObject{
	name = "burnt_twigroot",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/monsters/burnt_twigroot.fbx",
			storeSourceData = true, -- must be enabled for mesh particles to work
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/monsters/twigroot/twigroot_idle.fbx",
				sleep = "assets/animations/monsters/twigroot/twigroot_idle_to_stealth.fbx",
				wakeUp = "assets/animations/monsters/twigroot/twigroot_stealth_to_idle.fbx",
				moveForward = "assets/animations/monsters/twigroot/twigroot_walk.fbx",
				strafeLeft = "assets/animations/monsters/twigroot/twigroot_strafe_left.fbx",
				strafeRight = "assets/animations/monsters/twigroot/twigroot_strafe_right.fbx",
				turnLeft = "assets/animations/monsters/twigroot/twigroot_turn_left.fbx",
				turnRight = "assets/animations/monsters/twigroot/twigroot_turn_right.fbx",
				attack = "assets/animations/monsters/twigroot/twigroot_attack_left.fbx",
				attack2 = "assets/animations/monsters/twigroot/twigroot_attack_right.fbx",
				getHitFrontLeft = "assets/animations/monsters/twigroot/twigroot_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/twigroot/twigroot_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/twigroot/twigroot_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/twigroot/twigroot_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/twigroot/twigroot_get_hit_right.fbx",
				fall = "assets/animations/monsters/twigroot/twigroot_get_hit_front_left.fbx",
			},
			currentLevelOnly = true,
		},
		{
			class = "Monster",
			meshName = "twigroot_mesh",
			hitSound = "twigroot_hit",
			dieSound = "twigroot_die",
			hitEffect = "hit_wood",
			capsuleHeight = 0.2,
			capsuleRadius = 0.7,
			health = 320,
			protection = 15,
			evasion = 10,
			exp = 90,
			--lootDrop = { 50, "branch", 50, "branch" },
			immunities = { "sleep", "frozen", "blinded" },
			resistances = {
				fire = "absorb",
				cold = "vulnerable",
				poison = "immune",
			},
			onInit = function(self)
				self.go.r_hand:stop()
				self.go.l_hand:stop()
			end,
		},
		{
			class = "TwigrootBrain",
			name = "brain",
			sight = 4,
		},
		{
			class = "MonsterMove",
			name = "move",
			sound = "twigroot_walk",
			cooldown = 2,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "twigroot_walk",
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 25,
			accuracy = 10,
			cooldown = 2,
			--repeatChance = 55,
			sound = "twigroot_attack",
			onBeginAction = function(self)
				-- randomize animation
				if math.random() < 0.5 then
					self:setAnimation("attack")
				else
					self:setAnimation("attack2")
				end
			end,
			onEndAction = function(self)
				--randomize animation
				if true then
					self.go.brain:performAction("extraHit", 0)
				end
			end,
		},
		{
			class = "MonsterAttack",
			name = "extraHit",
			attackPower = 17,
			accuracy = 20,
			damageType = "fire",
			cooldown = 1,
			animationSpeed = 1.75,
			sound = "twigroot_attack",
			onBeginAction = function(self)
				-- randomize animation
				if math.random() < 0.5 then
					self:setAnimation("attack")
					self.go.l_hand:restart()
				else
					self:setAnimation("attack2")
					self.go.r_hand:restart()
				end
			end,
		},
		{
			class = "Particle",
			particleSystem = "burnt_twigroot",
			name = "main",
			parentNode = "head",
			offset = vec(0, 0.0, 0),
		},
		{
			class = "Particle",
			particleSystem = "burnt_twigroot_fire_attack",
			name = "r_hand",
			parentNode = "r_hand",
			offset = vec(0, 0.0, 0),
		},
		{
			class = "Particle",
			particleSystem = "burnt_twigroot_fire_attack",
			name = "l_hand",
			parentNode = "l_hand",
			offset = vec(0, 0.0, 0),
		},
		{
			class = "Light",
			name = "mainLight",
			parentNode = "head",
			color = vec(0.7, 0.2, 0.03),
			offset = vec(0, 0.0, 0),
			brightness = 10,
			range = 3.5,
			fillLight = true,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
	},
}

defineObject{
	name = "twigroot_dormant",
	baseObject = "twigroot",
	components = {
		{
			class = "Null",
			onInit = function(self)
				self.go.brain:disable()
				self.go.animation:play("sleep")
			end,
		},
		{
			class = "MonsterAction",
			name = "wakeUp",
			animation = "wakeUp",
			onEndAction = function(self)
				self.go.brain:enable()
			end,
		},
	}
}

defineObject{
	name = "twigroot_pair",
	baseObject = "base_monster_group",
	components = {
		{
			class = "MonsterGroup",
			monsterType = "twigroot",
			count = 2,
		}
	},
}

defineAnimationEvent{
	animation = "assets/animations/monsters/twigroot/twigroot_attack_left.fbx",
	event = "attack",
	frame = 9,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/twigroot/twigroot_attack_right.fbx",
	event = "attack",
	frame = 9,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/twigroot/twigroot_strafe_left.fbx",
	event = "playSound:twigroot_strafe",
	frame = 0,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/twigroot/twigroot_strafe_right.fbx",
	event = "playSound:twigroot_strafe",
	frame = 0,
}

defineSound{
	name = "twigroot_walk",
	filename = "assets/samples/monsters/twigroot_walk_01.wav",
	loop = false,
	volume = 0.5,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "twigroot_strafe",
	filename = "assets/samples/monsters/twigroot_strafe_01.wav",
	loop = false,
	volume = 0.85,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "twigroot_attack",
	filename = "assets/samples/monsters/twigroot_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "twigroot_hit",
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
	name = "twigroot_die",
	filename = "assets/samples/monsters/twigroot_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineParticleSystem{
	name = "burnt_twigroot",
	emitters = {
		-- fog
		{
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 20,
			boxMin = {-0.3, -0.1,-0.3},
			boxMax = { 0.3, 0.1, 0.3},
			sprayAngle = {0,360},
			velocity = {0.1,0.4},
			--objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {2,2},
			color0 = {0.2, 0.2, 0.2},
			opacity = 0.9,
			fadeIn = 1.3,
			fadeOut = 1.9,
			size = {0.25, 1.5},
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
			boxMin = {-0.2, -0.5,-0.2},
			boxMax = { 0.2, 0.5, 0.2},
			sprayAngle = {0,360},
			velocity = {0.1,0.9},
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
			size = {0.1, 0.4},
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
			boxMin = {-0.2, -0.2 ,-0.2},
			boxMax = { 0.2, 0.1, 0.2},
			sprayAngle = {0,360},
			velocity = {0.1,0.5},
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
			size = {0.05, 0.1},
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
			boxMin = {-0.2, -0.2 ,-0.2},
			boxMax = { 0.2, 0.1, 0.2},
			sprayAngle = {0,360},
			velocity = {0.2,0.6},
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
	name = "burnt_twigroot_fire_attack",
	emitters = {
		-- flames
		{
			--spawnBurst = true,
			emissionRate = 50,
			emissionTime = 0.33,
			maxParticles = 50,
			boxMin = {-0.1, -0.1, -0,1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,100},
			velocity = {0.1,0.1},
			--objectSpace = false,
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
			opacity = 0.9,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.2, 0.4},
			gravity = {0,0.5,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- sparks
		{
			--spawnBurst = true,
			emissionRate = 100,
			emissionTime = 0.33,
			maxParticles = 100,
			boxMin = {-0.1, -0.1, -0,1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,100},
			velocity = {0.1,0.1},
			--objectSpace = false,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.1,0.9},
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 0.9,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.03, 0.06},
			gravity = {0,2,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}