defineObject{
	name = "summon_stone",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/summon_stone.fbx",
			storeSourceData = true, -- must be enabled for mesh particles to work
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/monsters/summon_stone/summon_stone_idle.fbx",
				sleep = "assets/animations/monsters/summon_stone/summon_stone_pile.fbx",
				wakeUp = "assets/animations/monsters/summon_stone/summon_stone_pile_up.fbx",
				moveForward = "assets/animations/monsters/summon_stone/summon_stone_walk.fbx",
				sprintForward = "assets/animations/monsters/summon_stone/summon_stone_walk_sprint.fbx",
				turnLeft = "assets/animations/monsters/summon_stone/summon_stone_turn_left.fbx",
				turnRight = "assets/animations/monsters/summon_stone/summon_stone_turn_right.fbx",
				attack = "assets/animations/monsters/summon_stone/summon_stone_attack.fbx",
				turnAttackLeft = "assets/animations/monsters/summon_stone/summon_stone_turn_attack_left.fbx",
				turnAttackRight = "assets/animations/monsters/summon_stone/summon_stone_turn_attack_right.fbx",
				getHitFrontLeft = "assets/animations/monsters/summon_stone/summon_stone_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/summon_stone/summon_stone_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/summon_stone/summon_stone_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/summon_stone/summon_stone_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/summon_stone/summon_stone_get_hit_right.fbx",
				fall = "assets/animations/monsters/summon_stone/summon_stone_get_hit_front_left.fbx",
			},
			currentLevelOnly = true,
		},
		{
			class = "Monster",
			meshName = "summon_stone_mesh",
			hitSound = "summon_stone_hit",
			dieSound = "summon_stone_die",
			footstepSound = "summon_stone_footstep",
			hitEffect = "hit_dust",
			capsuleHeight = 0.2,
			capsuleRadius = 0.7,
			collisionRadius = 0.55,
			health = 140,
			protection = 30,
			evasion = -20,
			exp = 380,
			lootDrop = { 100, "rock", 100, "rock", 100, "rock" },
			immunities = { "sleep", "blinded", "backstab" },
			resistances = {
				["poison"] = "resist",
				["fire"] = "resist",
				["cold"] = "resist",
			},
			traits = { "elemental" },
		},
		{
			class = "MeleeBrain",
			name = "brain",
			sight = 4,
			morale = 100,	-- fearless
			onBloodied = function(self)
				local move = self.go.move
				move:setCooldown(2)
				move:setMoveForwardAnimation("sprintForward")
			end,
		},
		{
			class = "MonsterMove",
			name = "move",
			sound = "summon_stone_walk",
			cooldown = 3.75,
			onBeginAction = function(self)
				-- functions.script.takeBleedDamage(self.go.monster)
			end,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "summon_stone_walk",
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 38,
			accuracy = 10,
			woundChance = 25,
			cooldown = 4.5,
			sound = "summon_stone_attack",
		},
		{
			class = "MonsterAttack",
			name = "turnAttack",
			attackPower = 38,
			accuracy = 10,
			woundChance = 25,
			cooldown = 4.5,
			sound = "summon_stone_attack",
			turnToAttackDirection = true,
		},
	},
}

defineObject{
	name = "summon_stone_pile",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/summon_stone_pile.fbx",
		},
		{
			class = "Animation",
			animations = {
				wakeUp = "assets/animations/env/summon_stone_pile.fbx",
			},
		},
	}
}

defineAnimationEvent{
	animation = "assets/animations/env/summon_stone_pile.fbx",
	event = "destroy",
	normalizedTime = 1,
}

defineObject{
	name = "summon_stone_dormant",
	baseObject = "summon_stone",
	components = {
		{
			class = "Null",
			onInit = function(self)
				self.go.brain:disable()
				-- must update animations in other levels, otherwise sleep animation is not played
				self.go.animation:setCurrentLevelOnly(false)
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
		{
			class = "Controller",
			onActivate = function(self)
				self.go.monster:performAction("wakeUp")
				for e in self.go.map:entitiesAt(self.go.x, self.go.y) do
					if e.name == "summon_stone_pile" then
						e.animation:play("wakeUp")
					end
				end
			end,
		},
	}
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_attack.fbx",
	event = "attack",
	frame = 9,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_turn_attack_left.fbx",
	event = "attack",
	frame = 9,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_turn_attack_right.fbx",
	event = "attack",
	frame = 9,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk.fbx",
	event = "footstep",
	frame = 9,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk.fbx",
	event = "footstep",
	frame = 25,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk.fbx",
	event = "footstep",
	frame = 40,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk.fbx",
	event = "footstep",
	frame = 56,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk.fbx",
	event = "footstep",
	frame = 63,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk_sprint.fbx",
	event = "footstep",
	frame = 8,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk_sprint.fbx",
	event = "footstep",
	frame = 17,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk_sprint.fbx",
	event = "footstep",
	frame = 22,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk_sprint.fbx",
	event = "footstep",
	frame = 29,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_walk_sprint.fbx",
	event = "footstep",
	frame = 35,	
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_turn_left.fbx",
	event = "footstep",
	frame = 11,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_turn_right.fbx",
	event = "footstep",
	frame = 10,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_turn_right.fbx",
	event = "footstep",
	frame = 20,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/summon_stone/summon_stone_pile_up.fbx",
	event = "playSound:summon_stone_wake_up",
	frame = 5,
}

defineSound{
	name = "summon_stone_walk",
	filename = {
		"assets/samples/monsters/summon_stone_walk_01.wav",
		"assets/samples/monsters/summon_stone_walk_02.wav",
	},
	loop = false,
	volume = 0.8,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "summon_stone_attack",
	filename = "assets/samples/monsters/summon_stone_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "summon_stone_wake_up",
	filename = "assets/samples/monsters/summon_stone_wake_up_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}

defineSound{
	name = "summon_stone_footstep",
	filename = "assets/samples/monsters/summon_stone_footstep_01.wav",
	loop = false,
	volume = 0.85,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "summon_stone_hit",
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
	name = "summon_stone_die",
	filename = "assets/samples/monsters/summon_stone_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}