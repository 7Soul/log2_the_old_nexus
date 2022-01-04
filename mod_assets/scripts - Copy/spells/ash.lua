defineObject{
	name = "ash_blast",
	baseObject = "base_spell",
	components = {
		{
			class = "Particle",
			particleSystem = "ash_blast",
			destroyObject = true,
		},
		{
			class = "Light",
			color = vec(1, 0.5, 0.25),
			brightness = 40,
			range = 10,
			fadeOut = 0.5,
			disableSelf = true,
		},
		{
			class = "TileDamager",
			attackPower = 40,
			damageType = "fire",
			sound = "fireball_hit",
			screenEffect = "ash_screen",
			woundChance = 40,
		},
	},
}

defineParticleSystem{
	name = "ash_blast",
	emitters = {
		-- smoke
		{
			emissionRate = 20,
			emissionTime = 0.3,
			maxParticles = 100,
			boxMin = {0.0, 0.0, 0.0},
			boxMax = {0.0, 0.0, 0.0},
			sprayAngle = {0,100},
			velocity = {0.1, 0.5},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,2},
			color0 = {0.25, 0.20, 0.17},
			opacity = 1,
			fadeIn = 0.3,
			fadeOut = 0.9,
			size = {2, 3},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.5,
			blendMode = "Translucent",
		},

		-- flames
		{
			spawnBurst = true,
			maxParticles = 50,
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.4,0.6},
			color0 = {1, 0.5, 0.25},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {1, 2},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 2,
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
			color0 = {1.500000, 0.495000, 0.090000},
			opacity = 1,
			fadeIn = 0.01,
			fadeOut = 0.5,
			size = {4, 4},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		}
	}
}

defineParticleSystem{
	name = "ash_screen",
	emitters = {
		-- flames
		{
			spawnBurst = true,
			maxParticles = 2000,
			sprayAngle = {0,360},
			velocity = {0,0.3},
			boxMin = {-1.2,-0.9,1},
			boxMax = {1.2,0.9,1},
			objectSpace = true,
			texture = "assets/textures/particles/darkness_cloud.tga",
			lifetime = {0.4, 5},
			color0 = {0.1, 0.1, 0.1},
			opacity = 0.9,
			fadeIn = 0.001,
			fadeOut = 1.25,
			size = {0.005, 0.3},
			gravity = {0,-0.25,0},
			airResistance = 0.2,
			rotationSpeed = 1,
			blendMode = "Translucent",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,1},
			boxMax = {0,0,1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 0.5},
			colorAnimation = false,
			color0 = {0.05, 0.05, 0.05},
			opacity = 0.8,
			fadeIn = 0.001,
			fadeOut = 0.1,
			size = {4.5, 4.1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}