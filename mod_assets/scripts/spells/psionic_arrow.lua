defineObject{
	name = "psionic_arrow",
	baseObject = "base_spell",
	components = {
		{
			class = "Particle",
			particleSystem = "psionic_arrow",
		},
		{ 
			class = "Script",
			name = "data",
			source = [[
					data = {hitEffect = "psionic_arrow_blast"}
					function get(self,name) return self.data[name] end
					function set(self,name,value) self.data[name] = value end
					]],      
		},
		{
			class = "Light",
			color = vec(1, 1.0, 1.0),
			brightness = 10,
			range = 2,
			castShadow = true,
		},
		{
			class = "Projectile",
			spawnOffsetY = 1.35,
			velocity = 10,
			radius = 0.1,
			onProjectileHit = function(self, what, entity)
				local hit = self.go:spawn("psionic_arrow_blast")
				hit.tiledamager:setCastByChampion(self:getCastByChampion())
				local damage = self.go.data:get("attackPower")
				damage = damage - (damage * 0.5) + (damage * math.random())
				damage = damage * 0.33
				local protection = 0
				if entity and entity.monster ~= nil then
					protection = entity.monster:getProtection()
					protection = (protection * 0.5) + (protection * math.random())
				end				
				damage = damage - (protection / 2)
				hit.tiledamager:setAttackPower(math.ceil(damage))
			end
		},
		{
			class = "Sound",
			sound = "fireball",
		},
		{
			class = "Sound",
			name = "launchSound",
			sound = "fireball_launch",
		},
	},
}

defineObject{
	name = "psionic_arrow_blast",
	baseObject = "base_spell",
	components = {
		{
			class = "Particle",
			particleSystem = "psionic_arrow_blast",
			destroyObject = true,
		},
		{
			class = "Light",
			color = vec(1, 1, 1),
			brightness = 20,
			range = 3,
			fadeOut = 0.4,
			disableSelf = true,
		},
		{
			class = "TileDamager",
			attackPower = 1,
			damageType = "physical",
			damageFlags = DamageFlags.NoLingeringEffects,
			sound = "fireball_hit",
			screenEffect = "fireball_screen",
			woundChance = 0,
			onHitChampion = function(self, champion)
				return false
			end,
			onHitMonster = function(self, monster)			
				local champion = party.party:getChampionByOrdinal(self:getCastByChampion())
				local accuracy = functions.script.getAccuracy(champion)
				local evasion = monster:getEvasion()
				local hitChance = math.clamp(60 + accuracy - evasion, 5, 95) / 100
				if math.random() > hitChance then
					monster:showDamageText("miss", "AAAAAA")
					return false
				else
					return true
				end
			end
		},
	},
}

defineParticleSystem{
	name = "psionic_arrow",
	emitters = {
		-- smoke
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {0.0, 0.0, 0.1},
			boxMax = {0.0, 0.0, 0.1},
			sprayAngle = {0,0},
			velocity = {0.0,0.0},
			texture = "assets/textures/particles/glow_ring.tga",
			lifetime = {0.4,0.4},
			color0 = {1.0, 1.0, 1.0},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 0.9,
			size = {0.07, 0.07},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 1,
			blendMode = "Additive",
		},
		
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {0.0, 0.0, -0.5},
			boxMax = {0.0, 0.0, -0.5},
			sprayAngle = {0,0},
			velocity = {0.0,0.0},
			texture = "assets/textures/particles/glow_ring.tga",
			lifetime = {0.4,0.4},
			color0 = {1.0, 1.0, 1.0},
			opacity = 0.5,
			fadeIn = 0.1,
			fadeOut = 0.9,
			size = {0.11, 0.11},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 1,
			blendMode = "Additive",
		},
		
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {0.0, 0.0, -1.0},
			boxMax = {0.0, 0.0, -1.0},
			sprayAngle = {0,0},
			velocity = {0.0,0.0},
			texture = "assets/textures/particles/glow_ring.tga",
			lifetime = {0.4,0.4},
			color0 = {1.0, 1.0, 1.0},
			opacity = 0.3,
			fadeIn = 0.1,
			fadeOut = 0.9,
			size = {0.15, 0.15},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- flames
		{
			emissionRate = 50,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = { 0.0, 0.0, 0.0},
			boxMax = { 0.0, 0.0, 0.0},
			sprayAngle = {0,360},
			velocity = {0.01, 0.02},
			texture = "assets/textures/particles/glitter_silver.tga",
			lifetime = {1.0, 1.0},
			colorAnimation = true,
			color0 = {2, 2, 2},
			opacity = 1.0,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.15, 0.28},
			gravity = {0,0.1,0},
			airResistance = 0.9,
			rotationSpeed = 1,
			blendMode = "Additive",
			--objectSpace = true,
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
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.3, 0.3, 0.3},
			opacity = 0.2,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {1.5, 1.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "psionic_arrow_blast",
	emitters = {
		-- smoke
		-- {
			-- emissionRate = 15,
			-- emissionTime = 0.3,
			-- maxParticles = 100,
			-- boxMin = {0.0, 0.0, 0.0},
			-- boxMax = {0.0, 0.0, 0.0},
			-- sprayAngle = {0,100},
			-- velocity = {0.1, 0.5},
			-- texture = "assets/textures/particles/smoke_01.tga",
			-- lifetime = {0.5,1.5},
			-- color0 = {0.25, 0.20, 0.17},
			-- opacity = 0.5,
			-- fadeIn = 0.3,
			-- fadeOut = 0.9,
			-- size = {2, 3},
			-- gravity = {0,0,0},
			-- airResistance = 0.1,
			-- rotationSpeed = 0.5,
			-- blendMode = "Translucent",
		-- },

		-- flames
		{
			spawnBurst = true,
			maxParticles = 10,
			sprayAngle = {0,360},
			velocity = {0,0.6},
			objectSpace = true,
			texture = "assets/textures/particles/glitter_silver.tga",
			lifetime = {0.4,0.6},
			color0 = {1, 1.0, 1.0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.2, 0.6},
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
			color0 = {1.5, 1.5, 1.5},
			opacity = 0.5,
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
	name = "fireball_screen",
	emitters = {
		-- flames
		{
			spawnBurst = true,
			maxParticles = 1700,
			sprayAngle = {0,360},
			velocity = {0,0.3},
			boxMin = {-1.1,-0.9,1},
			boxMax = {1.1,0.9,1},
			objectSpace = true,
			texture = "assets/textures/particles/flame.tga",
			frameRate = 35,
			frameSize = 32,
			frameCount = 50,
			lifetime = {0.3, 0.5},
			color0 = {2, 1, 0.5},
			opacity = 1,
			fadeIn = 0.001,
			fadeOut = 0.15,
			size = {0.005, 0.25},
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
			boxMin = {0,0,1},
			boxMax = {0,0,1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 0.5},
			colorAnimation = false,
			color0 = {0.8, 0.1, 0.05},
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

defineSound{
	name = "fireball",
	filename = "assets/samples/magic/fireball_01.wav",
	loop = true,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "fireball_launch",
	filename = "assets/samples/magic/spell_launch_01.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}

defineSound{
	name = "fireball_hit",
	filename = "assets/samples/magic/fireball_hit_01.wav",
	loop = false,
	volume = 1,
	minDistance = 3,
	maxDistance = 12,
}
