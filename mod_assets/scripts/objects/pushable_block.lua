defineObject{
	name = "pushable_block",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/pushable_block_01.fbx",
		},
		{
			class = "ProjectileCollider",
		},
		{
			class = "Obstacle",
			hitSound = "$weapon",
		},
		{
			class = "DynamicObstacle",
		},
		{
			class = "PushableBlock",
		},
		{
			class = "Clickable",
			name = "clickNorth",
			offset = vec(0, 1.15, 1.2),
			size = vec(1.2, 1.2, 0.1),
			maxDistance = 1,
			--debugDraw = true,
			onClick = function(self)
				if party.facing == (self.go.facing+2) % 4 then
					self.go.pushableblock:push(party.facing)
				end
			end,
		},
		{
			class = "Clickable",
			name = "clickEast",
			offset = vec(1.2, 1.15, 0),
			size = vec(0.1, 1.2, 1.2),
			maxDistance = 1,
			--debugDraw = true,
			onClick = function(self)
				if party.facing == (self.go.facing+3) % 4 then
					self.go.pushableblock:push(party.facing)
				end
			end,
		},
		{
			class = "Clickable",
			name = "clickSouth",
			offset = vec(0, 1.15, -1.2),
			size = vec(1.2, 1.2, 0.1),
			maxDistance = 1,
			--debugDraw = true,
			onClick = function(self)
				if party.facing == self.go.facing then
					self.go.pushableblock:push(party.facing)
				end
			end,
		},
		{
			class = "Clickable",
			name = "clickWest",
			offset = vec(-1.2, 1.15, 0),
			size = vec(0.1, 1.2, 1.2),
			maxDistance = 1,
			--debugDraw = true,
			onClick = function(self)
				if party.facing == (self.go.facing+1) % 4 then
					self.go.pushableblock:push(party.facing)
				end
			end,
		},
		{
			class = "Light",
			name = "lightNorth",
			offset = vec(0,1.2,1.2),
			range = 1.2,
			color = vec(5,2,2,0.3),
			brightness = 2,
			fadeOut = 0,
			fillLight = true,
		},
		{
			class = "Light",
			name = "lightEast",
			offset = vec(1.2,1.2,0),
			range = 1.2,
			color = vec(5,2,2,0.3),
			brightness = 2,
			fadeOut = 0,
			fillLight = true,
		},
		{
			class = "Light",
			name = "lightSouth",
			offset = vec(0,1.2,-1.2),
			range = 1.2,
			color = vec(5,2,2,0.3),
			brightness = 2,
			fadeOut = 0,
			fillLight = true,
		},
		{
			class = "Light",
			name = "lightWest",
			offset = vec(-1.2,1.2,0),
			range = 1.2,
			color = vec(5,2,2,0.3),
			brightness = 2,
			fadeOut = 0,
			fillLight = true,
		},		
		{
			class = "Sound",
			sound = "pushable_block_hover",
			offset = vec(0, 1.5, 0),
			enabled = false,
		},
	},
	editorIcon = 220,
	tags = {"puzzle"},
}

defineObject{
	name = "pushable_block_floor",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/pushable_block_floor01.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "lightStrip",
			model = "assets/models/env/pushable_block_floor_beam_white.fbx",
			enabled = false,
		},
		{
			class = "Light",
			offset = vec(0, 0, 0),
			range = 3,
			color = vec(0.2, 0.5, 1),
			brightness = 35,
			enabled = false,
			fillLight = true,
		},
		{
			class = "Particle",
			particleSystem = "pushable_block_white",
			emitterMesh = "assets/models/env/pushable_block_floor_light.fbx",
			disableSelf = true,
			enabled = false,
		},
		{
			class = "PushableBlockFloor",
			name = "controller",
		},
	},
	editorIcon = 224,
	tags = {"puzzle"},
	replacesFloor = true,
}

defineObject{
	name = "pushable_block_floor_trigger",
	baseObject = "pushable_block_floor",
	components = {
		{
			class = "Model",
			name = "lightStrip",
			model = "assets/models/env/pushable_block_floor_beam_red.fbx",
			staticShadow = true,
			enabled = false,
		},
		{
			class = "Particle",
			particleSystem = "pushable_block_red",
			emitterMesh = "assets/models/env/pushable_block_floor_light.fbx",
			enabled = false,
		},		
		{
			class = "Light",
			offset = vec(0, 0, 0),
			range = 3,
			color = vec(1, 0.35, 0.2),
			brightness = 35,
			enabled = false,
			fillLight = true,
		},
		{
			class = "FloorTrigger",
			triggeredByParty = false,
			triggeredByMonster = false,
			triggeredByItem = false,
			triggeredByPushableBlock = true,
		},
	},
	editorIcon = 228,
	tags = {"puzzle"},
	replacesFloor = true,
}

defineParticleSystem{
	name = "pushable_block_white",
	emitters = {
		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.3, 0.1,-1.3},
			boxMax = { 1.3, 0.1, 1.3},
			sprayAngle = {0,360},
			velocity = {0.1,0.2},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {3,3},
			color0 = {0.15,0.5,1},
			opacity = 0.25,
			fadeIn = 2.2,
			fadeOut = 2.2,
			size = {0.75, 1.5},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
		},

		-- stars
		{
			emitterShape = "MeshShape",
			emissionRate = 50,
			emissionTime = 0,
			maxParticles = 500,
			boxMin = {-0.1, 0.1,-0.1},
			boxMax = { 0.1, 0.1, 0.1},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {1,2},
			color0 = {3.0,3.0,3.0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.05, 0.13},
			gravity = {0,0.1,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- blobs
		{
			emitterShape = "MeshShape",
			emissionRate = 50,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-1.3,0.75,-1.5},
			boxMax = {1.3,0.75,-1.5},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 1},
			colorAnimation = false,
			color0 = {0.2, 0.5, 1},
			opacity = 0.5,
			fadeIn = 0.5,
			fadeOut = 1,
			size = {0.25, 0.4},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 1,
			blendMode = "Additive",
			depthBias = 0.2,
		},
	}
}

defineParticleSystem{
	name = "pushable_block_red",
	emitters = {
		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.3, 0.1,-1.3},
			boxMax = { 1.3, 0.1, 1.3},
			sprayAngle = {0,360},
			velocity = {0.1,0.2},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {3,3},
			color0 = {1,0.5,0.2},
			opacity = 0.25,
			fadeIn = 2.2,
			fadeOut = 2.2,
			size = {0.75, 1.5},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
		},

		-- stars
		{
			emitterShape = "MeshShape",
			emissionRate = 50,
			emissionTime = 0,
			maxParticles = 500,
			boxMin = {-0.1, 0.1,-0.1},
			boxMax = { 0.1, 0.1, 0.1},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {1,2},
			color0 = {3, 0.5, 0.2},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.05, 0.13},
			gravity = {0,0.1,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- blobs
		{
			emitterShape = "MeshShape",
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-1.3,0.75,-1.5},
			boxMax = {1.3,0.75,-1.5},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1, 2},
			colorAnimation = false,
			color0 = {1, 0.3, 0.15},
			opacity = 0.5,
			fadeIn = 0.5,
			fadeOut = 1,
			size = {0.25, 0.4},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 1,
			blendMode = "Additive",
		},
	}
}
