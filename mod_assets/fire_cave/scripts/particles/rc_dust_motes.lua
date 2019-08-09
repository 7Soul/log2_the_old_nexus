defineParticleSystem{
	name = "rc_dust_motes",
	emitters = {
		-- dust
		{
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 550,
			boxMin = {-3,0,-3},
			boxMax = { 3,4.5, 3},
			sprayAngle = {0,360},
			velocity = {0.05,0.2},
			objectSpace = true,
			texture = "mod_assets/fire_cave/textures/particles/rc_dust_mote_dif.tga",
			lifetime = {1,3},
			color0 = {1,0.2,0},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.08, 0.2},
			gravity = {0,0,0},
			airResistance = 0.01,
			rotationSpeed = 2,
			blendMode = "Additive",
		},

	}
}
