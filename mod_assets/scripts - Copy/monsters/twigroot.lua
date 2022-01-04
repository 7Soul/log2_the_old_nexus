defineObject{
	name = "twigroot",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/twigroot.fbx",
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
			hitEffect = "hit_goo",
			capsuleHeight = 0.2,
			capsuleRadius = 0.7,
			health = 120,
			evasion = 10,
			exp = 90,
			--lootDrop = { 50, "branch", 50, "branch" },
			immunities = { "sleep", "blinded", "frozen" },
			resistances = { ["fire"] = "weak" },
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
			cooldown = 3,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "twigroot_walk",
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 12,
			accuracy = 10,
			cooldown = 2,
			sound = "twigroot_attack",
			onBeginAction = function(self)
				-- randomize animation
				if math.random() < 0.5 then
					self:setAnimation("attack")
				else
					self:setAnimation("attack2")
				end
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