defineObject{
	name = "force_field",
	components = {
		{
			class = "Model",
			model = "assets/models/effects/force_field.fbx",
			offset = vec(0, 0.05, 0),
		},
		{
			class = "Light",
			offset = vec(0, 1.75, 0),
			range = 6,
			color = vec(0.2, 0.5, 1),
			brightness = 20,
			castShadow = false,
			fillLight = true,
		},
		{
			class = "Particle",
			particleSystem = "force_field",
		},
		{
			class = "Sound",
			sound = "force_field_ambient",
		},
		{
			class = "ForceField",
			hitSound = "impact_blunt",
		},
		{
			class = "ProjectileCollider",
			size = vec(3, 3, 3),
		},
		{
			class = "Clickable",
			offset = vec(0, 1.5, 0),
			size = vec(2.75,3,2.75),
			maxDistance = 1,
			--debugDraw = true,
		},
		{
			class = "Controller",
			onInitialActivate = function(self)
				self.go.model:enable()
				self.go.forcefield:enable()
				self.go.projectilecollider:enable()
				self.go.clickable:enable()
			end,
			onInitialDeactivate = function(self)
				self.go.model:disable()
				self.go.forcefield:disable()
				self.go.particle:fadeOut(0)
				self.go.sound:fadeOut(0)
				self.go.light:fadeOut(0)
				self.go.projectilecollider:disable()
				self.go.clickable:disable()
			end,
			onActivate = function(self)
				self.go.model:enable()
				self.go.forcefield:enable()
				self.go.particle:fadeIn(0.1)
				self.go.sound:fadeIn(0.25)
				self.go.light:fadeIn(0.1)
				self.go.projectilecollider:enable()
				self.go.clickable:enable()
				--self.go:playSound("force_field_cast")
			end,
			onDeactivate = function(self)
				if self.go.model:isEnabled() then
					self.go:playSound("force_field_cast")
				end
				self.go.model:disable()
				self.go.forcefield:disable()
				self.go.particle:fadeOut(0.1)
				self.go.sound:fadeOut(0.5)
				self.go.light:fadeOut(0.5)
				self.go.projectilecollider:disable()
				self.go.clickable:disable()
			end,
			onToggle = function(self)
				if self.go.forcefield:isEnabled() then
					self:deactivate()
				else
					self:activate()
				end
			end,
		},
	},
	placement = "floor",
	editorIcon = 272,
	tags = { "obstacle" },
}

defineParticleSystem{
	name = "force_field",
	emitters = {
		-- fog1
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.32, 0, 1.32},
			boxMax = {1.32, 3, 1.32},
			sprayAngle = {0,360},
			velocity = {0.01,0.01},
			objectSpace = true,
			texture = "assets/textures/particles/force_field_particle.tga",
			lifetime = {0.5,2},
			color0 = { 0.5, 1, 2},
			opacity = 2,
			fadeIn = 0.5,
			fadeOut = 2,
			size = {0.5, 1},
			gravity = {0,0.1,0},
			airResistance = 0.1,
			rotationSpeed = 0.1,
			blendMode = "Additive",
		},
		
		-- fog2
			{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {1.32, 0, -1.32},
			boxMax = {1.32, 3, 1.32},
			sprayAngle = {0,360},
			velocity = {0.01,0.01},
			objectSpace = true,
			texture = "assets/textures/particles/force_field_particle.tga",
			lifetime = {0.5,2},
			color0 = { 0.5, 1, 2},
			opacity = 2,
			fadeIn = 0.5,
			fadeOut = 2,
			size = {0.5, 1},
			gravity = {0,0.1,0},
			airResistance = 0.1,
			rotationSpeed = 0.1,
			blendMode = "Additive",
		},
		
		-- fog3
			{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.32, 0, -1.32},
			boxMax = {1.32, 3, -1.32},
			sprayAngle = {0,360},
			velocity = {0.01,0.01},
			objectSpace = true,
			texture = "assets/textures/particles/force_field_particle.tga",
			lifetime = {0.5,2},
			color0 = { 0.5, 1, 2},
			opacity = 2,
			fadeIn = 0.5,
			fadeOut = 2,
			size = {0.5, 1},
			gravity = {0,0.1,0},
			airResistance = 0.1,
			rotationSpeed = -0.1,
			blendMode = "Additive",
		},
		
		-- fog4
			{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.32, 0, -1.32},
			boxMax = {-1.32, 3, 1.32},
			sprayAngle = {0,360},
			velocity = {0.01,0.01},
			objectSpace = true,
			texture = "assets/textures/particles/force_field_particle.tga",
			lifetime = {0.5,2},
			color0 = { 0.5, 1, 2},
			opacity = 2,
			fadeIn = 0.5,
			fadeOut = 2,
			size = {0.5, 1},
			gravity = {0,0.1,0},
			airResistance = 0.1,
			rotationSpeed = -0.1,
			blendMode = "Additive",
		},
	}
}

defineSound{
	name = "force_field_ambient",
	filename = "assets/samples/env/force_field_ambient_01.wav",
	loop = true,
	volume = 0.8,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "force_field_ambient_quiet",
	filename = "assets/samples/env/force_field_ambient_01.wav",
	loop = true,
	volume = 0.2,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "force_field_cast",
	filename = "assets/samples/magic/force_field_cast_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}
