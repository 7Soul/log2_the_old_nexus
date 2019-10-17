for i=0,3 do
	local str = function(str) return (string.gsub(str, "?", iff(i > 0, i, ""))) end
	defineObject{
		name = str("mummy?"),
		baseObject = "base_monster",
		components = {
			{
				class = "Model",
				model = str("assets/models/monsters/mummy?.fbx"),
				storeSourceData = true,
			},
			{
				class = "Animation",
				animations = {
					idle = str("assets/animations/monsters/mummy/mummy?_idle.fbx"),
					moveForward = str("assets/animations/monsters/mummy/mummy?_walk.fbx"),
					turnLeft = str("assets/animations/monsters/mummy/mummy?_turn_left.fbx"),
					turnRight = str("assets/animations/monsters/mummy/mummy?_turn_right.fbx"),
					attack = str("assets/animations/monsters/mummy/mummy?_attack.fbx"),
					getHitFrontLeft = str("assets/animations/monsters/mummy/mummy?_get_hit_front_left.fbx"),
					getHitFrontRight = str("assets/animations/monsters/mummy/mummy?_get_hit_front_right.fbx"),
					getHitBack = str("assets/animations/monsters/mummy/mummy?_get_hit_back.fbx"),
					getHitLeft = str("assets/animations/monsters/mummy/mummy?_get_hit_left.fbx"),
					getHitRight = str("assets/animations/monsters/mummy/mummy?_get_hit_right.fbx"),
					fall = str("assets/animations/monsters/mummy/mummy?_get_hit_front_left.fbx"),
				},
				currentLevelOnly = true,
				onAnimationEvent = function(self, event)
					local brain = self.go.brain

					if event == "idle" and brain.seesParty then
						if not self.go.swarm_particle:isEnabled() and math.random() < 1.0 then	
							self.go.monster:performAction("summon")
						end
					end
				end
			},
			{
				class = "Monster",
				meshName = "mummy_mesh",
				hitSound = "mummy_hit",
				dieSound = "mummy_die",
				footstepSound = "mummy_footstep",
				hitEffect = "hit_dust",
				capsuleHeight = 0.2,
				capsuleRadius = 0.7,
				collisionRadius = 0.7,
				health = 150,
				evasion = 0,
				exp = 105,
				immunities = { "sleep", "blinded" },
				resistances = {
					["fire"] = "weak",
					["poison"] = "immune",
				},
				traits = { "undead" },
				headRotation = vec(0, 0, 90),
				onInit = function(self)
					self.go.swarm_particle:disable()
					self.go.swarm_parent:disable()
					self.go.sound_swarm:disable()
					self.go.swarm_counter:setValue(math.random(1,7))
				end,
			},
			{
				class = "Counter",
				name = "swarm_counter",
			},
			{
				class = "Timer",
				name = "swarm_timer",
				timerInterval = 0.05,
				triggerOnStart = true,
				onActivate = function(self)
					if self.go.swarm_particle:isEnabled() and self.go.monster:isAlive() then
						self.go.swarm_counter:increment()
						local v = self.go.swarm_counter:getValue()
						local swarm = self.go.swarm_particle
						swarm:setOffset( vec(math.sin(v/25) * 3, math.cos((v+0.5)/8) * 0.1 , math.cos(v/25) * 3) )
						self.go.sound_swarm:setOffset( vec(math.sin(v/25) * 3, math.cos((v+0.5)/8) * 0.1 , math.cos(v/25) * 3) )
						
						-- Swarm damage	
						if math.floor(v) % 8 == 0 then
							self.go.swarm_spawner:increment()
						end
						if math.floor(v) % 8 == 4 then
							self.go.swarm_spawner:decrement()
						end
						
						-- End swarm effect
						if math.floor(v / 20) >= 30 then
							self.go.swarm_particle:fadeOut(0.5)
							self.go.swarm_parent:fadeOut(0.5)
							self.go.sound_swarm:fadeOut(1.0)
						end

						if (v / 20) >= 31 then
							self.go.swarm_particle:disable()
							self.go.swarm_parent:disable()
							self.go.sound_swarm:disable()
						end
					end
				end
			},
			{
				class = "Controller",
				name = "swarm_spawner",
				onIncrement = function(self)
					if self.go.swarm_particle:isEnabled() and self.go.monster:isAlive() then
						local v = self.go.swarm_counter:getValue()
						local swarm_pos = math.floor((v+10)/20) % 8
						local posX = { 1, 1, 0,-1,-1,-1,  0, 1 }
						local posY = { 0, 1, 1, 1, 0,-1, -1,-1 }
						local i = (((self.go.facing*2) - 1 + swarm_pos) % 8) + 1
						local dx = posX[i]
						local dy = posY[i]
						-- spawn("red_aoe", self.go.level, self.go.x + dx, self.go.y + dy, self.go.facing, self.go.elevation)
						damageTile(self.go.level, self.go.x + dx, self.go.y + dy, 0, self.go.elevation, 0, "poison", math.random(1,2) + (GameMode.getTimeOfDay() > 1.01 and math.random(1,2) or 0) )
					end
				end,
				onDecrement = function(self)
					if self.go.swarm_particle:isEnabled() and self.go.monster:isAlive() then
						local v = self.go.swarm_counter:getValue()
						local swarm_pos = math.floor((v+0)/20) % 8
						local posX = { 1, 1, 0,-1,-1,-1,  0, 1 }
						local posY = { 0, 1, 1, 1, 0,-1, -1,-1 }
						local i = (((self.go.facing*2) - 1 + swarm_pos) % 8) + 1
						local dx = posX[i]
						local dy = posY[i]
						-- spawn("red_aoe", self.go.level, self.go.x + dx, self.go.y + dy, self.go.facing, self.go.elevation)
						damageTile(self.go.level, self.go.x + dx, self.go.y + dy, 0, self.go.elevation, 0, "poison", math.random(1,2) + (GameMode.getTimeOfDay() > 1.01 and math.random(1,2) or 0) )
					end
				end,
			},
			{
				class = "Light",
				name = "swarm_parent",
				parentNode = "capsule",
				range = 9.0,
				color = vec(0.2, 0.7, 0.2),
				brightness = 3,
				enabled = false,
				castShadow = false,
				fillLight = true,
				fadeOut = 0,
				onUpdate = function(self)
					local v = self.go.swarm_counter:getValue()
					self:setOffset( vec(math.sin(v/25) * 3, 0.25 + math.cos((v+0.5)/8) * 0.25 , math.cos(v/25) * 3) )
				end,
			},
			{
				class = "Sound",
				name = "sound_swarm",
				sound = "locust_swarm_loop",
				enabled = false,
			},
			{
				class = "Particle",
				name = "swarm_particle",
				particleSystem = "locust_swarm",
				parentNode = "capsule",
				offset = vec(0, 0.0, 0),
			},
			{
				class = "MeleeBrain",
				name = "brain",
				sight = 5,
				morale = 100,
			},
			{
				class = "MonsterMove",
				name = "move",
				sound = "mummy_walk",
				cooldown = 4.5,
				animationSpeed = 0.8,
			},
			{
				class = "MonsterTurn",
				name = "turn",
				sound = "mummy_walk",
			},
			{
				class = "MonsterAttack",
				name = "basicAttack",
				attackPower = 14,
				cooldown = 3.75,
				animationSpeed = 0.8,
			},
			{
				class = "MonsterAction",
				name = "summon",
				cooldown = 60,
				sound = "mummy_attack_01",
				animation = "attack",
				animationSpeed = 0.5,
				onBeginAction = function(self)
					spawn("red_aoe", self.go.level, self.go.x, self.go.y, self.go.facing, self.go.elevation)
				end,
				onAnimationEvent = function(self, event)
					if event == "summon" then
						self.go.swarm_counter:reset()
						self.go.swarm_counter:setValue(4*20)
						self.go.swarm_particle:enable()
						self.go.swarm_particle:fadeIn(0.5)
						self.go.swarm_parent:enable()	
						self.go.swarm_parent:fadeIn(0.5)
						self.go.sound_swarm:enable()
						self.go.sound_swarm:fadeIn(0.5)
					end
				end
			},
		},
	}
end

defineObject{
	name = "mummy_patrol",
	baseObject = "base_monster_group",	
	components = {
		{
			class = "MonsterGroup",
			monsterType = { "mummy", "mummy1", "mummy3", "mummy2" },
			count = 4,
		}
	},
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_idle.fbx",
	event = "idle",
	frame = 1,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy_attack.fbx",
	event = "attack",
	frame = 7,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy_attack.fbx",
	event = "summon",
	frame = 16,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_attack.fbx",
	event = "summon",
	frame = 16,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_attack.fbx",
	event = "attack",
	frame = 7,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy2_attack.fbx",
	event = "attack",
	frame = 7,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy2_attack.fbx",
	event = "summon",
	frame = 16,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy3_attack.fbx",
	event = "attack",
	frame = 7,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy_walk.fbx",
	event = "footstep",
	frame = 14,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy_walk.fbx",
	event = "footstep",
	frame = 26,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy_walk.fbx",
	event = "footstep",
	frame = 36,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy_walk.fbx",
	event = "footstep",
	frame = 46,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_walk.fbx",
	event = "footstep",
	frame = 15,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_walk.fbx",
	event = "footstep",
	frame = 27,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_walk.fbx",
	event = "footstep",
	frame = 39,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy2_walk.fbx",
	event = "footstep",
	frame = 12,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy2_walk.fbx",
	event = "footstep",
	frame = 26,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy2_walk.fbx",
	event = "footstep",
	frame = 37,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy2_walk.fbx",
	event = "footstep",
	frame = 48,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy2_walk.fbx",
	event = "footstep",
	frame = 55,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy3_walk.fbx",
	event = "footstep",
	frame = 14,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy3_walk.fbx",
	event = "footstep",
	frame = 24,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy3_walk.fbx",
	event = "footstep",
	frame = 36,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy3_walk.fbx",
	event = "footstep",
	frame = 45,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy_attack.fbx",
	event = "playSound:mummy_attack_01",
	frame = 0,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_attack.fbx",
	event = "playSound:mummy_attack_02",
	frame = 0,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy2_attack.fbx",
	event = "playSound:mummy_attack_03",
	frame = 0,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy3_attack.fbx",
	event = "playSound:mummy_attack_04",
	frame = 0,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_turn_left.fbx",
	event = "swarm_left",
	frame = 0,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/mummy/mummy1_turn_right.fbx",
	event = "swarm_right",
	frame = 0,
}

defineSound{
	name = "mummy_walk",
	filename = {
		"assets/samples/monsters/mummy_walk_01.wav",
		"assets/samples/monsters/mummy_walk_02.wav",
		"assets/samples/monsters/mummy_walk_02.wav",
		"assets/samples/monsters/mummy_walk_02.wav",
		"assets/samples/monsters/mummy_walk_02.wav",
		"assets/samples/monsters/mummy_walk_02.wav",
		},
	loop = false,
	volume = 0.35,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "mummy_footstep",
	filename = "assets/samples/monsters/mummy_footstep_01.wav",
	loop = false,
	volume = 0.45,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

for i=1,4 do
	defineSound{
		name = "mummy_attack_0"..i,
		filename = "assets/samples/monsters/mummy_attack_0"..i..".wav",
		loop = false,
		volume = 1,
		minDistance = 1,
		maxDistance = 10,
	}
end

defineSound{
	name = "mummy_hit",
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
	name = "mummy_die",
	filename = "assets/samples/monsters/mummy_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "locust_swarm_loop",
	filename = "mod_assets/sounds/swarm.wav",
	loop = true,
	volume = 1.25,
	minDistance = 1,
	maxDistance = 5,
}

defineParticleSystem{
	name = "locust_swarm",
	emitters = {
		-- dark clouds
		{
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-0.8, -0.6,-0.8},
			boxMax = { 0.8,  0.6, 0.8},
			sprayAngle = {0,360},
			velocity = {0.1,0.2},
			objectSpace = false,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,3},
			color0 = {0.0, 0.10, 0.0},
			opacity = 0.75,
			fadeIn = 0.2,
			fadeOut = 2.2,
			size = {0.3, 0.8},
			gravity = {0,-0.1,0},
			airResistance = 0.1,
			rotationSpeed = 1,
			blendMode = "Translucent",
		},
		-- dark clouds (larger mass)
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-0.8, -0.6,-0.8},
			boxMax = { 0.8,  0.6, 0.8},
			sprayAngle = {0,360},
			velocity = {0.1,0.2},
			objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {0.4,0.5},
			color0 = {0.0, 0.05, 0.0},
			opacity = 0.8,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.3, 0.6},
			gravity = {0,-0.1,0},
			airResistance = 0.1,
			rotationSpeed = 1,
			blendMode = "Translucent",
		},
		-- bugs (fast)
		{
			emissionRate = 500,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-0.5, -0.5,-0.5},
			boxMax = { 0.5,  0.5, 0.5},
			sprayAngle = {0,360},
			velocity = {0.9,1.5},
			objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {0.05,0.19},
			color0 = {0.5, 0.9, 0.5},
			opacity = 0.9,
			fadeIn = 0.01,
			fadeOut = 0.01,
			size = {0.02, 0.05},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 1,
			blendMode = "Translucent",
		},
		-- bugs
		{
			emissionRate = 100,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-0.5, -0.5,-0.5},
			boxMax = { 0.5,  0.5, 0.5},
			sprayAngle = {0,360},
			velocity = {0.7,1.0},
			objectSpace = true,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {0.5, 1.0},
			color0 = {0.5, 0.9, 0.5},
			opacity = 0.9,
			fadeIn = 0.01,
			fadeOut = 0.01,
			size = {0.02, 0.04},
			gravity = {0,0.2,0},
			airResistance = 0.1,
			rotationSpeed = 1,
			blendMode = "Translucent",
		},
	}
}