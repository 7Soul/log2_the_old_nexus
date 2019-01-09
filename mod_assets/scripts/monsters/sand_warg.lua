defineObject{
	name = "sand_warg",
	baseObject = "base_monster",
	components = {
		{
			class = "Model",
			model = "assets/models/monsters/sand_warg.fbx",
			storeSourceData = true,
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/monsters/sand_warg/sand_warg_idle.fbx",
				moveForward = "assets/animations/monsters/sand_warg/sand_warg_walk.fbx",
				turnLeft = "assets/animations/monsters/sand_warg/sand_warg_turn_left.fbx",
				turnRight = "assets/animations/monsters/sand_warg/sand_warg_turn_right.fbx",
				moveForwardTurnLeft = "assets/animations/monsters/sand_warg/sand_warg_walk_turn_left.fbx",
				moveForwardTurnRight = "assets/animations/monsters/sand_warg/sand_warg_walk_turn_right.fbx",
				attack = "assets/animations/monsters/sand_warg/sand_warg_attack.fbx",
				getHitFrontLeft = "assets/animations/monsters/sand_warg/sand_warg_get_hit_front_left.fbx",
				getHitFrontRight = "assets/animations/monsters/sand_warg/sand_warg_get_hit_front_right.fbx",
				getHitBack = "assets/animations/monsters/sand_warg/sand_warg_get_hit_back.fbx",
				getHitLeft = "assets/animations/monsters/sand_warg/sand_warg_get_hit_left.fbx",
				getHitRight = "assets/animations/monsters/sand_warg/sand_warg_get_hit_right.fbx",
				fall = "assets/animations/monsters/sand_warg/sand_warg_get_hit_front_left.fbx",
				howl = "assets/animations/monsters/sand_warg/sand_warg_howl.fbx",
			},
			currentLevelOnly = true,
		},
		{
			class = "Monster",
			meshName = "sand_warg_mesh",
			hitSound = "warg_hit",
			dieSound = "warg_die",
			hitEffect = "hit_blood_black",
			capsuleHeight = 0.2,
			capsuleRadius = 0.7,
			health = 400,
			exp = 350,
			lootDrop = { 75, "warg_meat", 10, "warg_meat" },
			resistances = { ["poison"] = "weak" },
			traits = { "animal" },
			headRotation = vec(90, 0, 0),
		},
		{
			class = "WargBrain",
			name = "brain",
			sight = 5,
		},
		{
			class = "Brain",
			name = "sbrain",
			sight = 5,
			seeInvisible = true,
			allAroundSight = true,
			onThink = function(self)
				-- call brain script
				local script = self.go.brainScript
				if script and script:isEnabled() and script.think then script.think(self) end
			end,
		},
		{
			class = "Script",
			name = "brainScript",
			source = "function think(s) return s:wait() end",
		},
		{
			class = "MonsterMove",
			name = "move",
			sound = "warg_walk",
			cooldown = 0.5,
		},
		{
			class = "MonsterTurn",
			name = "turn",
			sound = "warg_walk",
			resetBasicAttack = true,
		},
		{
			class = "MonsterMove",
			name = "moveForwardAndTurnRight",
			animations = { forward="moveForwardTurnRight" },
			sound = "warg_walk",
			turnDir = 1,
			cooldown = 2,
			resetBasicAttack = true,
		},
		{
			class = "MonsterMove",
			name = "moveForwardAndTurnLeft",
			animations = { forward="moveForwardTurnLeft" },
			sound = "warg_walk",
			turnDir = -1,
			cooldown = 2,
			resetBasicAttack = true,
		},
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 35,
			pierce = 5,
			accuracy = 15,
			cooldown = 3,
			woundChance = 30,
			sound = "warg_attack",
			screenEffect = "damage_screen",
		},
		{
			class = "MonsterAction",
			name = "howl",
			animation = "howl",
			cooldown = 60,
			-- sound = "warg_howl",
		},
	},
}

defineObject{
	name = "sand_warg_boss",
	baseObject = "sand_warg",
	components = {
		{
			class = "MonsterAttack",
			name = "basicAttack",
			attackPower = 35,
			pierce = 0,
			accuracy = 15,
			cooldown = 3,
			woundChance = 0,
			sound = "warg_attack",
			screenEffect = "damage_screen",
		},
	},
}

defineAnimationEvent{
	animation = "assets/animations/monsters/sand_warg/sand_warg_attack.fbx",
	event = "attack",
	frame = 7,
}

defineAnimationEvent{
	animation = "assets/animations/monsters/sand_warg/sand_warg_howl.fbx",
	event = "playSound:warg_howl",
	frame = 0,
}

defineSound{
	name = "warg_walk",
	filename = {
		"assets/samples/monsters/warg_walk_01.wav",
		"assets/samples/monsters/warg_walk_01.wav",
		"assets/samples/monsters/warg_walk_02.wav",
		"assets/samples/monsters/warg_walk_03.wav",
		},
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
	clipDistance = 5,
}

defineSound{
	name = "warg_attack",
	filename = "assets/samples/monsters/warg_attack_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "warg_howl",
	filename = "assets/samples/monsters/warg_howl_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 20,
}

defineSound{
	name = "warg_hit",
	filename = { 
		"assets/samples/weapons/hit_bone_01.wav",
		"assets/samples/weapons/hit_bone_01.wav",
		"assets/samples/weapons/hit_bone_01.wav",
		"assets/samples/weapons/hit_bone_02.wav",
		"assets/samples/weapons/hit_bone_02.wav",
		"assets/samples/weapons/hit_bone_02.wav",
		"assets/samples/weapons/hit_flesh_01.wav",
		"assets/samples/weapons/hit_flesh_01.wav",
		"assets/samples/monsters/warg_hit_01.wav",
		"assets/samples/monsters/warg_hit_02.wav",
	},
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "warg_die",
	filename = "assets/samples/monsters/warg_die_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}
