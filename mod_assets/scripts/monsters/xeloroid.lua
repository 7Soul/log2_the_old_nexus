defineObject{
	name = "xeloroid",
	baseObject = "base_monster",
	components = {
		{
			class = "Script",
			name = "data",
			source = [[data = {}
function get(self,name)
	return self.data[name]
end
function set(self,name,value)
	self.data[name] = value
end]],
		},
		{
			class = "Model",
			model = "assets/models/monsters/xeloroid.fbx",
			storeSourceData = true,
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
				moveForward = "assets/animations/monsters/xeloroid/xeloroid_fly.fbx",
				turnLeft = "assets/animations/monsters/xeloroid/xeloroid_turn_left.fbx",
				turnRight = "assets/animations/monsters/xeloroid/xeloroid_turn_right.fbx",
				attack = "assets/animations/monsters/xeloroid/xeloroid_attack.fbx",
				rangedAttack = "assets/animations/monsters/xeloroid/xeloroid_ranged_attack.fbx",
				getHitFrontLeft = "assets/animations/monsters/xeloroid/xeloroid_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/xeloroid/xeloroid_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/xeloroid/xeloroid_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/xeloroid/xeloroid_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/xeloroid/xeloroid_get_hit_right.fbx",
				fall = "assets/animations/monsters/xeloroid/xeloroid_get_hit_front_left.fbx",
			},
			currentLevelOnly = true,
			onAnimationEvent = function(self, event)
				if event == "grapple" then
					party.party:grapple(1)
				end
			end,
		},
		{
			class = "Monster",
			meshName = "xeloroid_mesh",
			footstepSound = "xeloroid_footstep",
			hitSound = "xeloroid_hit",
			dieSound = "xeloroid_die",
			hitEffect = "hit_blood",
			capsuleHeight = 0.5,
			capsuleRadius = 0.2,
			collisionRadius = 0.7,
			health = 400,
			protection = 4,
			evasion = 10,
			flying = true,
			exp = 250,
			immunities = { "sleep", "frozen" },
			resistances = {
				["fire"] = "resist",
				["cold"] = "resist",
				["poison"] = "resist",
				["shock"] = "immune"
			},
		},
		{
			class = "XeloroidBrain",
			name = "brain",
			sight = 5,
		},
		{
			class = "MonsterMove",
			name = "move",
			sound = "xeloroid_walk",
			cooldown = 3,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "xeloroid_walk",
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 33,
			pierce = 5,
			accuracy = 50,
			cooldown = 5,
			causeCondition = "paralyzed",
			animation = "attack",
			sound = "xeloroid_attack",
		},
		{
			class = "MonsterAttack",
			name = "rangedAttack",
			attackType = "projectile",
			attackPower = 23,
			cooldown = 10,
			animation = "rangedAttack",
			sound = "xeloroid_lightning",
			shootProjectile = "lightning_bolt_greater_cast",
		},
		{
			class = "MonsterChangeAltitude",
			name = "changeAltitude",
			sound = "xeloroid_walk",
		},
	},
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_attack.fbx",
	event = "grapple",
	frame = 3,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_attack.fbx",
	event = "attack",
	frame = 12,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_ranged_attack.fbx",
	event = "attack",
	frame = 12,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 8,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 20,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 40,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 60,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 80,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 100,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 120,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 140,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 160,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_idle.fbx",
	event = "footstep",
	frame = 180,
}

--[[
defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_turn_right.fbx",
	event = "footstep",
	frame = 10,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_turn_left.fbx",
	event = "footstep",
	frame = 10,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/xeloroid/xeloroid_fly.fbx",
	event = "footstep",
	frame = 8,
}
--]]

defineSound{
	name = "xeloroid_walk",
	filename = {
		"assets/samples/monsters/xeloroid_walk_01.wav",
		"assets/samples/monsters/xeloroid_walk_01.wav",
		"assets/samples/monsters/xeloroid_walk_01.wav",
		"assets/samples/monsters/xeloroid_walk_01.wav",
		"assets/samples/monsters/xeloroid_walk_01.wav",
		"assets/samples/monsters/xeloroid_walk_02.wav",
		"assets/samples/monsters/xeloroid_walk_03.wav",
	},
	loop = false,
	volume = 0.7,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "xeloroid_footstep",
	filename = {
		"assets/samples/monsters/xeloroid_footstep_01.wav",
	},
	loop = false,
	volume = 0.4,
	minDistance = 1,
	maxDistance = 8,
	clipDistance = 5,
}

defineSound{
	name = "xeloroid_attack",
	filename = "assets/samples/monsters/xeloroid_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "xeloroid_lightning",
	filename = "assets/samples/monsters/xeloroid_lightning_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}

defineSound{
	name = "xeloroid_hit",
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
	name = "xeloroid_die",
	filename = "assets/samples/monsters/xeloroid_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}