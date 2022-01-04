defineObject{
	name = "turtle",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/turtle.fbx",
			storeSourceData = true, -- must be enabled for mesh particles to work
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/monsters/turtle/turtle_idle.fbx",
				moveForward = "assets/animations/monsters/turtle/turtle_walk.fbx",
				turnLeft = "assets/animations/monsters/turtle/turtle_turn_left.fbx",
				turnRight = "assets/animations/monsters/turtle/turtle_turn_right.fbx",
				attack = "assets/animations/monsters/turtle/turtle_attack.fbx",
				attack2 = "assets/animations/monsters/turtle/turtle_attack2.fbx",
				moveAttack = "assets/animations/monsters/turtle/turtle_move_attack.fbx",
				getHitFrontLeft = "assets/animations/monsters/turtle/turtle_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/turtle/turtle_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/turtle/turtle_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/turtle/turtle_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/turtle/turtle_get_hit_right.fbx",
				fall = "assets/animations/monsters/turtle/turtle_get_hit_front_left.fbx",
				alert = "assets/animations/monsters/turtle/turtle_alert.fbx",
			},
			currentLevelOnly = true,
			onAnimationEvent = function(self, event)
				--print(event)
			end,
		},
		{
			class = "Monster",
			meshName = "turtle_mesh",
			hitSound = "turtle_hit",
			dieSound = "turtle_die",
			footstepSound = "turtle_footstep",
			hitEffect = "hit_blood",
			capsuleHeight = 0.2,
			capsuleRadius = 0.7,
			health = 95,
			evasion = -10,
			protection = 0,
			exp = 75,
			lootDrop = { 66, "turtle_steak", 33, "turtle_steak" },
			resistances = { 
				["shock"] = "weak",
				["poison"] = "weak", },
			traits = { "animal" },
			headRotation = vec(90, 0, 0),
			onDie = function(self)
				-- maybe do something?
			end,
		},
		{
			class = "TurtleBrain",
			name = "brain",
			sight = 3,
		},
		{
			class = "MonsterMove",
			name = "move",
			sound = "turtle_walk",
			cooldown = 10,
			dashChance = 50,
			onBeginAction = function(self)
				functions.script.takeBleedDamage(self.go.monster)
			end,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "turtle_walk",
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 12,
			cooldown = 3.85,
			-- sound = "turtle_attack",
			onBeginAction = function(self)
				-- randomize animation
				if math.random() < 0.8 then
					self:setAnimation("attack")
					self.go:playSound("turtle_attack")
				else
					self:setAnimation("attack2")	-- double attack
					self.go:playSound("turtle_double_attack")
				end
			end,
		},
		{
			class = "MonsterMoveAttack",
			name = "moveAttack",
			attackPower = 10,
			cooldown = 10,
			animation = "moveAttack",
			sound = "turtle_move_attack",
		},
		{
			class = "MonsterAction",
			name = "alert",
			cooldown = 100,
			animation = "alert",
		},
	},
}


defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_attack.fbx",
	event = "attack",
	frame = 10,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_attack2.fbx",
	event = "attack",
	frame = 10,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_attack2.fbx",
	event = "attack",
	frame = 22,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_move_attack.fbx",
	event = "move_forward",
	frame = 29,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_move_attack.fbx",
	event = "attack",
	frame = 35,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_walk.fbx",
	event = "footstep",
	frame = 13,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_walk.fbx",
	event = "footstep",
	frame = 23,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_turn_left.fbx",
	event = "footstep",
	frame = 9,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_turn_right.fbx",
	event = "footstep",
	frame = 9,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/turtle/turtle_alert.fbx",
	event = "playSound:turtle_alert",
	frame = 0,
}

defineSound{
	name = "turtle_walk",
	filename = { 
		"assets/samples/monsters/turtle_walk_01.wav",
		"assets/samples/monsters/turtle_walk_02.wav",
		"assets/samples/monsters/turtle_walk_03.wav",
		"assets/samples/monsters/turtle_walk_03.wav",
		"assets/samples/monsters/turtle_walk_03.wav",
	},
	loop = false,
	volume = 0.7,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "turtle_footstep",
	filename = "assets/samples/monsters/turtle_footstep_01.wav",
	loop = false,
	volume = 0.6,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "turtle_attack",
	filename = "assets/samples/monsters/turtle_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "turtle_double_attack",
	filename = "assets/samples/monsters/turtle_double_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "turtle_move_attack",
	filename = "assets/samples/monsters/turtle_move_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}

defineSound{
	name = "turtle_hit",
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
	name = "turtle_die",
	filename = "assets/samples/monsters/turtle_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "turtle_alert",
	filename = "assets/samples/monsters/turtle_alert_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}