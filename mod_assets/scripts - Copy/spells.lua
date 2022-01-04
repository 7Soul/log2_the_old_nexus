defineObject{
	name = "lightning_bolt",
	baseObject = "base_spell",
	components = {
		{
			class = "Particle",
			particleSystem = "lightning_bolt",
		},
		{
			class = "Light",
			color = vec(0.25, 0.5, 1),
			brightness = 15,
			range = 7,
			castShadow = true,
		},
		{
			class = "Projectile",
			spawnOffsetY = 1.35,
			velocity = 0,
			radius = 0.1,
			hitEffect = "lightning_bolt_blast",
		},
		{
			class = "Sound",
			sound = "lightning_bolt",
		},
		{
			class = "Sound",
			name = "launchSound",
			sound = "lightning_bolt_launch",
		},
	},
}

defineObject{
	name = "lightning_bolt_blast",
	baseObject = "base_spell",
	components = {
		{
			class = "Particle",
			particleSystem = "lightning_bolt_hit",
			destroyObject = true,
		},
		{
			class = "Light",
			color = vec(0.25, 0.5, 1),
			brightness = 40,
			range = 10,
			fadeOut = 0.5,
			disableSelf = true,
		},
		{
			class = "TileDamager",
			attackPower = 35,
			damageType = "shock",
			woundChance = 10,
			sound = "lightning_bolt_hit_small",
		},
	},
}

defineObject{
	name = "lightning_bolt_greater",
	baseObject = "lightning_bolt",
	components = {
		{
			class = "Particle",
			particleSystem = "lightning_bolt_greater",
		},
		{
			class = "Projectile",
			spawnOffsetY = 1.35,
			velocity = 10,
			radius = 0.1,
			hitEffect = "lightning_bolt_greater_blast",
		},
	},
}

defineObject{
	name = "lightning_bolt_greater_blast",
	baseObject = "lightning_bolt_blast",
	components = {
		{
			class = "Particle",
			particleSystem = "lightning_bolt_hit_greater",
			destroyObject = true,
		},
		{
			class = "TileDamager",
			attackPower = 47,
			damageType = "shock",
			woundChance = 30,
			sound = "lightning_bolt_hit",
		},
	},
}

defineParticleSystem{
	name = "lightning_bolt",
	emitters = {
		{
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = { 0,0,0 },
			boxMax = { 0,0,0 },
			sprayAngle = {0,0},
			velocity = {0,0},
			objectSpace = true,
			texture = "mod_assets/textures/particles/lightning02.dds",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {1.0,1.0},
			color0 = {1.5,1.5,1.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {1.0, 1.0},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 0,
			blendMode = "Additive",
		},

		-- core
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { 0,0,0 },
			boxMax = { 0,0,0 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.5,1.5,1.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.2, 0.7},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,0.0},
			boxMax = {0,0,0.0},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.25,0.32,0.5},
			opacity = 0.3,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {1.0, 1.0},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "lightning_bolt_hit",
	emitters = {
		-- sparks
		{
			emissionRate = 80,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {-0.5, -0.5, -0.5},
			boxMax = { 0.5,  0.5,  0.5},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.4},
			color0 = {2.5,2.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.1, 1.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
		},

		-- fog
		{
			spawnBurst = true,
			maxParticles = 30,
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.4,0.6},
			color0 = {0.25, 0.5, 1},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {1, 2},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,-0.1},
			boxMax = {0,0,-0.1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 0.5},
			colorAnimation = false,
			color0 = {1, 1, 1},
			opacity = 1,
			fadeIn = 0.01,
			fadeOut = 0.5,
			size = {1, 1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		}
	}
}

defineParticleSystem{
	name = "lightning_bolt_greater",
	emitters = {
		{
			emissionRate = 25,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { -0.2,-0.2,-0.2 },
			boxMax = { 0.2,0.2,0.2 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.25},
			color0 = {1.5,1.5,1.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.25, 2.5},
			gravity = {0,0,0},
			airResistance = 50,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- core
		{
			emissionRate = 100,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { -0.1,-0.1,-0.1 },
			boxMax = { 0.1,0.1,0.1 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.4},
			color0 = {1.5,1.5,1.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.2, 1.7},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { 0,0,0},
			boxMax = { 0,0,0},
			sprayAngle = {0,360},
			velocity = {0.1,0.2},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.1,0.2},
			color0 = {0.14, 0.352941, 0.803922},
			opacity = 0.5,
			fadeIn = 0.01,
			fadeOut = 0.01,
			size = {0.2, 1.0},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 3,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,0.0},
			boxMax = {0,0,0.0},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.25,0.32,0.5},
			opacity = 0.3,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {1.0, 1.0},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "lightning_bolt_hit_greater",
	emitters = {
		-- sparks
		{
			emissionRate = 80,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {-0.75, -0.75, -0.75},
			boxMax = { 0.75,  0.75,  0.75},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.4},
			color0 = {2.5,2.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.2, 2.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
		},

		-- fog
		{
			spawnBurst = true,
			maxParticles = 50,
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.4,0.6},
			color0 = {0.25, 0.5, 1},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {1, 2},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,-0.1},
			boxMax = {0,0,-0.1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 0.5},
			colorAnimation = false,
			color0 = {1, 1, 1},
			opacity = 1,
			fadeIn = 0.01,
			fadeOut = 0.5,
			size = {1, 1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		}
	}
}

defineSound{
	name = "lightning_bolt",
	filename = "assets/samples/magic/lightning_01.wav",
	loop = true,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "lightning_bolt_launch",
	filename = "assets/samples/magic/lightning_launch_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "lightning_bolt_hit",
	filename = "assets/samples/magic/lightning_hit_01.wav",
	loop = false,
	volume = 1,
	minDistance = 2,
	maxDistance = 10,
}

defineSound{
	name = "lightning_bolt_hit_small",
	filename = "assets/samples/magic/lightning_hit_small_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}
