defineObject{
	name = "ice_crab",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			name = "model",
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
			onAnimationEvent = function(self, event)
				-- if event == "cave_crab_walk_step1" then
					-- self.go.step1:enable()
					-- self.go.step1:restart()
				-- elseif event == "cave_crab_walk_step2" then	
					-- self.go.step2:enable()
					-- self.go.step2:restart()
				-- end
			end,
			onAnimationEvent = function(self, event)
				if event == "spawn_blizzard1" or event == "spawn_blizzard2" or event == "spawn_blizzard3" then
					local dx,dy = getForward(self.go.facing)
					local a = spawn("blizzard_small", self.go.level, self.go.x, self.go.y, self.go.facing, self.go.elevation)
					a.tiledamager:setAttackPower(10)
					a.iceshards:setRange(1)
					a.iceshards:grantTemporaryImmunity(self.go, 2.4)
					playSoundAt("icewind", self.go.level, self.go.x, self.go.y)
				end
			end
		},
		{
			class = "Monster",
			meshName = "crab_mesh",
			hitSound = "crab_hit",
			dieSound = "crab_die",
			hitEffect = "hit_dust",
			capsuleHeight = 0.4,
			capsuleRadius = 0.6,
			health = 650,
			protection = 30,
			evasion = 10,
			exp = 475,
			traits = { "elemental" },
			deathEffect = "turtle",
			immunities = { "sleep", "frozen", "blinded" },
			resistances = {
				cold = "absorb",
				fire = "vulnerable",
				poison = "immune",
			},
			onInit = function(self)
				--self.go.model:setEmissiveColor(vec(1,1,1))
				self.go.model:setMaterial("ice_crab")
				self.go.shieldback:setMaterial("heavy_shield")
				self.go.crystalleg:setMaterial("metal_bracelet")
			end,
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
				functions.script.bleed(self.go.monster)
			end,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "crab_walk",
			animationSpeed = 1.1,
			onEndAction = function(self)
				local dx,dy = getForward(self.go.facing)
				for i = 2,5 do
					local x,y = self.go.x + (dx * i), self.go.y + (dy * i)
					for e in self.go.map:entitiesAt(x, y) do
						if e.party then
							self.go.monster:performAction("frostbolt")
							self.go.castLight:enable()
							self.go.castLight:setBrightness(20)
							local dust = self.go:spawn("particle_system")
							dust.particle:setParticleSystem("frostbolt_hit")
							dust.particle:setOffset(vec(0, 1, 0))
						end
					end
				end
			end,
		},
		{
			class = "MonsterAction",
			name = "frostbolt",
			animation = "attack",
			cooldown = 2,
			onAnimationEvent = function(self, event)
				if event == "cast_frostbolt" then
					local dx,dy = getForward(self.go.facing)
					local a = spawn("frostbolt_cast", self.go.level, self.go.x + dx, self.go.y + dy, self.go.facing, self.go.elevation - 0.1)
					a.data:set("attackPower", 31)
					
				end
			end,
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 32,
			accuracy = 10,
			woundChance = 33,
			cooldown = 4,
			animationSpeed = 1.2,
			sound = "crab_attack",
			onAttack = function(self)
				if math.random() < 0.93 then
					local dx,dy = getForward(self.go.facing)
					local x,y = self.go.x + dx, self.go.y + dy
					local obj = spawn("frostbolt_blast", self.go.level, x, y, 0, self.go.elevation)
					obj.tiledamager:setAttackPower(18)
					obj.particle:setOffset(vec(0, 0.75, 0))
				end
			end,
		},
		{
			class = "Particle",
			name = "step1",
			particleSystem = "turtle",
			offset = vec(0.5, 0.06, 0),
			enabled = false,
		},
		{
			class = "Particle",
			name = "step2",
			particleSystem = "turtle",
			offset = vec(-0.5, 0.06, 0),
			enabled = false,
		},
		
		{
			class = "Particle",
			particleSystem = "ice_crab",
			offset = vec(0, 0.06, 0),
		},
		{
			class = "Model",
			name = "shieldback",
			parentNode = "body",
			model = "assets/models/items/shield_valor.fbx",
			offset = vec(0.0, 0.22, -0.0),
			rotation = vec(0, 90, 0),
		},
		{
			class = "Model",
			name = "crystalleg",
			parentNode = "leg2",
			model = "assets/models/items/metal_bracelet.fbx",
			offset = vec(0.65, -0.07, 0),
			rotation = vec(16, -49.6, -1.6),
		},
		{
			class = "Light",
			parentNode = "capsule",
			name = "castLight",
			color = vec(0.4, 0.45, 0.9),
			offset = vec(0, 0.5, 0),
			brightness = 20,
			range = 6.5,
			fillLight = true,
			enabled = false,
			onUpdate = function(self)
				self:setBrightness(self:getBrightness() * 0.9)
				if self:getBrightness() < 0.1 then
					self:disable()
				end	
			end,
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

defineAnimationEvent{
	animation = "assets/animations/monsters/cave_crab/cave_crab_walk.fbx",
	event = "cave_crab_walk_step1",
	normalizedTime = 0.5,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/cave_crab/cave_crab_walk.fbx",
	event = "cave_crab_walk_step2",
	normalizedTime = 1,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/cave_crab/cave_crab_attack.fbx",
	event = "cast_frostbolt",
	normalizedTime = 0.25,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/cave_crab/cave_crab_walk.fbx",
	event = "spawn_blizzard1",
	normalizedTime = 0.6,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/cave_crab/cave_crab_strafe_left.fbx",
	event = "spawn_blizzard2",
	normalizedTime = 0.6,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/cave_crab/cave_crab_strafe_right.fbx",
	event = "spawn_blizzard3",
	normalizedTime = 0.6,
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

defineParticleSystem{
	name = "turtle",
	emitters = {
		-- fog
		{
			emitterShape = "MeshShape",
			spawnBurst = true,
			maxParticles = 75,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,1},
			--objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {3,3},
			color0 = {0.15, 0.22, 0.40},
			opacity = 0.9,
			fadeIn = 1.3,
			fadeOut = 1.9,
			size = {0.1, 1.5},
			gravity = {0,1,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Translucent",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},
		
		-- fog2
		{
			emitterShape = "MeshShape",
			spawnBurst = true,
			maxParticles = 20,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,0.8},
			--objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {3,3},
			color0 = {0.7, 0.8, 1},
			opacity = 0.5,
			fadeIn = 1.3,
			fadeOut = 1.9,
			size = {0.1, 1.5},
			gravity = {0,3,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Translucent",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},

		-- crystals
		{
			emitterShape = "MeshShape",
			spawnBurst = true,
			maxParticles = 80,
			sprayAngle = {85,95},
			velocity = {0.2,5},
			texture = "assets/textures/particles/ice_shard.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 32,
			lifetime = {0.8,1.5},
			color0 = {1, 1, 1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.01, 0.2},
			gravity = {0,-7,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Additive",
			clampToGroundPlane = true,
			depthBias = 0.2,
		},

		-- crystals_smaller
		{
			emitterShape = "MeshShape",
			spawnBurst = true,
			maxParticles = 250,
			sprayAngle = {85,95},
			velocity = {0.2,5},
			texture = "assets/textures/particles/ice_shard.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 32,
			lifetime = {0.8,3},
			color0 = {1, 1, 1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.01, 0.05},
			gravity = {0,-5,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Additive",
			clampToGroundPlane = true,
			depthBias = 0.2,
		},

		-- sparks
		{
			emitterShape = "MeshShape",
			spawnBurst = true,
			maxParticles = 10,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,2},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {1,5},
			color0 = {0.25, 0.5, 2},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.1},
			gravity = {0,0.2,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},

		-- sparks2
		{
			emitterShape = "MeshShape",
			spawnBurst = true,
			maxParticles = 5,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.2,2},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {1,5},
			color0 = {0.25, 0.5, 1.1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.1},
			gravity = {0,1,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}

defineParticleSystem{
	name = "turtle_temp",
	emitters = {
		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 200,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,0.4},
			--objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {3,3},
			color0 = {0.15, 0.22, 0.40},
			opacity = 0.9,
			fadeIn = 1.3,
			fadeOut = 1.9,
			size = {0.25, 1.5},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Translucent",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},
		
		-- fog2
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 200,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,0.8},
			--objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {3,3},
			color0 = {0.7, 0.8, 1},
			opacity = 0.5,
			fadeIn = 1.3,
			fadeOut = 1.9,
			size = {0.25, 1.5},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Translucent",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},

		-- flames
		{
			emissionRate = 20,
			emissionTime = 0,
			maxParticles = 300,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,0.9},
			texture = "assets/textures/particles/ice_shard.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 32,
			lifetime = {1,3},
			color0 = {1, 1, 1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.2},
			gravity = {0,-0.2,0},
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
			maxParticles = 5,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,2},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {1,5},
			color0 = {0.25, 0.5, 2},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.1},
			gravity = {0,0.2,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},

		-- sparks2
		{
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 5,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.2,2},
			--objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {1,5},
			color0 = {0.25, 0.5, 1.1},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.1},
			gravity = {0,1,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}

defineParticleSystem{
	name = "ice_crab",
	emitters = {
		-- fog
		{
			emissionRate = 100,
			emissionTime = 0,
			maxParticles = 500,
			boxMin = {-1.0, 0.5,-1.0},
			boxMax = { 1.0, 0.5, 1.0},
			sprayAngle = {0,360},
			velocity = {0.1,0.4},
			--objectSpace = true,
			texture = "assets/textures/particles/ice_guardian_smoke.tga",
			lifetime = {0.1,0.5},
			color0 = {0.5, 0.5, 0.6},
			opacity = 0.8,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {1.0, 2.0},
			gravity = {0,-1.5,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
			clampToGroundPlane = true,
			depthBias = 0.5,
		},
		
		-- fog2
		{
			emissionRate = 100,
			emissionTime = 0,
			maxParticles = 500,
			boxMin = {-1.0, 0.5,-1.0},
			boxMax = { 1.0, 0.5, 1.0},
			sprayAngle = {0,360},
			velocity = {0.1,0.8},
			--objectSpace = true,
			texture = "assets/textures/particles/ice_guardian_smoke.tga",
			lifetime = {0.1,0.5},
			color0 = {0.5, 0.5, 0.5},
			opacity = 0.8,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.25, 1.5},
			gravity = {0,-2,0},
			airResistance = 0.1,
			rotationSpeed = 0.5,
			blendMode = "Additive",
			clampToGroundPlane = true,
			depthBias = 0.5,
		},

		-- ice shards
		{
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 300,
			boxMin = {-1.0, 0.5,-1.0},
			boxMax = { 1.0, 0.5, 1.0},
			sprayAngle = {0,360},
			velocity = {0.1,0.9},
			texture = "assets/textures/particles/ice_shard.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 32,
			lifetime = {0.5,1},
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.05, 0.1},
			gravity = {0,-1,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
			clampToGroundPlane = true,
			depthBias = 0.1,
		},

		-- sparks
		{
			emissionRate = 2,
			emissionTime = 0,
			maxParticles = 7,
			boxMin = {-1.0, 0.1,-1.0},
			boxMax = { 1.0, 0.5, 1.0},
			sprayAngle = {0,360},
			velocity = {0.1,2},
			--objectSpace = true,
			texture = "assets/textures/particles/ice_guardian_smoke.tga",
			lifetime = {1,5},
			colorAnimation = true,
			color0 = {2.0, 2.0, 2.0},
			color1 = {1.0, 1.0, 1.0},
			color2 = {0.25, 0.5, 1.0},
			color3 = {0.1, 0.3, 1.0},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.1},
			gravity = {0,-1,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}