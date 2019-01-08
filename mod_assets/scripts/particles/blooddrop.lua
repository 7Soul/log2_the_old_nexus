do
	local pos = {
		vec(0.06, 0.15, 0.06),
		vec(0.04, 0.15, 0.04),
		vec(0.01, 0.15, 0.01),
	}
	local pos2 = {
		vec(-0.06, 0.15, -0.06),
		vec(-0.04, 0.15, -0.04),
		vec(-0.01, 0.15, -0.01),
	}

	local rates = { 0.5, 1.0, 5.0 }

	local emitters = {}
	for i=1,#pos do
		emitters[#emitters+1] = {
			emissionRate = rates[i]*5,
			emissionTime = 0,
			maxParticles = 20,
			boxMin = pos[i]*vec(2,1,2),
			boxMax = pos2[i]*vec(2,1,2),
			sprayAngle = {0,360},
			velocity = {0.05, 0.12},
			texture = "assets/textures/particles/candle_glow.tga",
			lifetime = {0.5, 1},
			color = {1.5, 0.2, 0.3},
			opacity = 0.15,
			fadeIn = 1,
			fadeOut = 1,
			size = {0.1, 0.2},
			gravity = {0,0.25,0},
			airResistance = 1.0,
			rotationSpeed = 0.1,
			blendMode = "Additive",
			depthBias = 0.1,
			objectSpace = true,			
		}
	end

	defineParticleSystem{
		name = "blooddrop",
		emitters = emitters
	}
end
