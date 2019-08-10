defineParticleSystem{
	name = "rc_lava_splash",
	emitters = {
		
		-- splash
		{
			spawnBurst = true,
			maxParticles = 1,
			boxMin = {-0.75, 3.3, 0.75},
			boxMax = { 0.75, 3.3, -0.75},
			sprayAngle = {0,0},
			velocity = {0, 0},
			texture = "mod_assets/fire_cave/textures/particles/rc_lava_splash_dif.tga",
			frameRate = 18,
			frameSize = 256,
			frameCount = 16,
			lifetime = {0.8, 0.8},
			color0 = {1, 1, 1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {1.5, 2.2},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Translucent",
			depthBias = 0.1,
			objectSpace = true,
			randomInitialRotation = false,
		},

	}
}

defineParticleSystem{
	name = "gen_lava_smoke01",
	emitters = {
		-- smoke
		{
			emissionRate = 3,
			emissionTime = 0,
			emitterShape = "MeshShape",
			maxParticles = 16,
			boxMin = {-0.03, -0.1, -0.03},
			boxMax = { 0.03, -0.1,  0.03},
			sprayAngle = {0,10},
			velocity = {0},
			texture = "mod_assets/fire_cave/textures/particles/gen_smoke01_dif.tga",
			frameRate = 12,
			frameSize = 128,
			frameCount = 64,
			lifetime = {3,5},
			colorAnimation = true,
			color0 = {1.0, 0.5, 0.5},
			color1 = {0.8, 0.35, 0.35},
			color2 = {0.6, 0.3, 0.3},
			color3 = {0.3, 0.3, 0.3},
			opacity = 0.25,
			fadeIn = 0.8,
			fadeOut = 1,
			size = {3, 4},
			gravity = {0,0.1,0},
			airResistance = 0.1,
			rotationSpeed = 0.5,
			blendMode = "Translucent",
		},

	}
}

defineParticleSystem{
	name = "gen_lava_sparks01",
	emitters = {
		{
			spawnBurst = true,
			emitterShape = "MeshShape",
			maxParticles = 40,
			boxMin = {-1.5,-0.5,-0.15},
			boxMax = { 1.5, 2.5, 0.0},
			sprayAngle = {0,360},
			velocity = {4,6},
			objectSpace = true,
			texture = "mod_assets/fire_cave/textures/particles/rc_spark_dif.tga",
			lifetime = {3,5},
			color0 = {1, 0.3, 0},
			opacity = 1,
			fadeIn = 0.05,
			fadeOut = 1,
			size = {0.08, 0.1},
			gravity = {0,-2,0},
			airResistance = 0.8,
			rotationSpeed = 4,
			blendMode = "Additive",
			depthBias = 0.2,
			clampToGroundPlane = true,
		},

	}
}
