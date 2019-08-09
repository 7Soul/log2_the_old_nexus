defineParticleSystem{
	name = "rc_hit_lever",
	emitters = {
		{
			spawnBurst = true,
			maxParticles = 15,
			sprayAngle = {0,40},
			velocity = {0.5,2},
			objectSpace = false,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.7,1.5},
			color0 = {0.38, 0.26, 0.14},
			opacity = 0.5,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.02, 0.05},
			gravity = {0,-4,0},
			airResistance = 0.2,
			rotationSpeed = 2,
			blendMode = "Translucent",
			clampToGroundPlane = true,
		},

		{
			spawnBurst = true,
			maxParticles = 40,
			sprayAngle = {0,100},
			velocity = {0.25,1},
			objectSpace = false,
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {0.3,1},
			color0 = {0.38, 0.26, 0.14},
			opacity = 0.3*0.5,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.1, 0.175},
			gravity = {0,0,0},
			airResistance = 2,
			rotationSpeed = 2,
			blendMode = "Translucent",
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
			color0 = {0.38, 0.26, 0.14},
			opacity = 0.5*0.5,
			fadeIn = 0.01,
			fadeOut = 0.5,
			size = {0.25, 0.25},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		}
	}
}
