-- Lights --
-- Lights, Decorational Lights --

defineObject{
	name = "rc_light_motes",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Light",
			name = "red_light",
			offset = vec(0, 2.25, 0),
			range = 14,
			color = vec(1, 0.08, 0),
			brightness = 12,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.3 + 1
				self:setBrightness(noise * 6)
			end,
		},
		{
			class = "Light",
			name = "orange_light",
			offset = vec(0, 2.25, 0),
			range = 6,
			color = vec(0.7, 0.36, 0.13),
			brightness = 1,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.2 + 1
				self:setBrightness(noise * 5)
			end,
		},
		{
				class = "Particle",
				particleSystem = "rc_dust_motes",
		},
	},
	editorIcon = 88,
	tags = { "red cave", "vanblam" },
	minimalSaveState = true,
}

defineObject{
	name = "rc_ceiling_lamp_fire_high",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_02_lamp.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 3.3, 0.02),
			range = 12,
			--color = vec(1, 0.5, 0.1),
			color = vec(0.5, 0.5, 1.0),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Particle",
			particleSystem = "gen_fire02",
			offset = vec(0, 3.3, 0.02),
		},
		{
			class = "Sound",
			sound = "gen_fire_small",
		},
	},
	minimalSaveState = true,
	editorIcon = 88,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_ceiling_lamp_fire_low",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_02_lamp.fbx",
			offset = vec(0, -0.75, 0),
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 2.55, 0.02),
			range = 12,
			--color = vec(1, 0.5, 0.1),
			color = vec(0.5, 0.5, 1.0),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Particle",
			particleSystem = "gen_fire02",
			offset = vec(0, 2.55, 0.02),
		},
		{
			class = "Sound",
			sound = "gen_fire_small",
		},
	},
	minimalSaveState = true,
	editorIcon = 88,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_ceiling_lamp_crystal_high",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_02_lamp_2.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "crystal",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_02_lamp_2_crystal.fbx",
			staticShadow = false,
			castShadow = false,
		},
		{
			class = "Light",
			offset = vec(0, 3.3, 0.02),
			range = 12,
			color = vec(1, 0.3, 0.1),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
				class = "Particle",
				particleSystem = "rc_crystal_medium",
				emitterMesh = "mod_assets/fire_cave/models/env/rc_ceiling_02_lamp_2_crystal.fbx",
		},
	},
	minimalSaveState = true,
	editorIcon = 88,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_ceiling_lamp_crystal_low",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_02_lamp_2.fbx",
			offset = vec(0, -0.75, 0),
			staticShadow = true,
		},
		{
			class = "Model",
			name = "crystal",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_02_lamp_2_crystal.fbx",
			offset = vec(0, -0.75, 0),
			staticShadow = false,
			castShadow = false,
		},
		{
			class = "Light",
			offset = vec(0, 2.55, 0.02),
			range = 12,
			--color = vec(1, 0.5, 0.1),
			color = vec(1.0, 0.1, 0.1),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
				class = "Particle",
				particleSystem = "rc_crystal_medium",
				emitterMesh = "mod_assets/fire_cave/models/env/rc_ceiling_02_lamp_2_crystal.fbx",
				offset = vec(0, -0.75, 0),
		},
	},
	minimalSaveState = true,
	editorIcon = 88,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_ceiling_crystal",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_crystal_base.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			name = "crystal_light_big",
			offset = vec(0, 2.31, 0.62),
			range = 9,
			color = vec(1, 0.5, 0.25),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Light",
			name = "crystal_light_small01",
			offset = vec(0, 1, 062),
			range = 8,
			color = vec(0.75, 0.09, 0),
			brightness = 6,
			castShadow = true,
			fillLight = true,
		},
		{
			class = "Model",
			name = "crystal",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_crystal.fbx",
			staticShadow = false,
			castShadow = false,
		},
		{
				class = "Particle",
				particleSystem = "rc_crystal",
				emitterMesh = "mod_assets/fire_cave/models/env/rc_ceiling_crystal.fbx",
		},
	},
	editorIcon = 88,
	tags = { "red cave", "vanblam" },
	minimalSaveState = true,
}

defineObject{
	name = "rc_small_crystals_bed_2x2",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_small_crystals_bed_2x2.fbx",
			staticShadow = false,
			castShadow = false,
		},
		{
			class = "Model",
			name = "ground",
			model = "mod_assets/fire_cave/models/env/rc_small_crystals_bed_2x2_ground.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			name = "light01",
			offset = vec(1.96, 0.45, -0.97),
			range = 5,
			color = vec(1, 0.15, 0),
			brightness = 8,
			castShadow = false,
		},
		{
			class = "Light",
			name = "light02",
			offset = vec(1.5, 0.45, 1.96),
			range = 5,
			color = vec(1, 0.15, 0),
			brightness = 8,
			castShadow = false,
		},
		{
			class = "Light",
			name = "light03",
			offset = vec(-1.71, 0.45, 1.64),
			range = 5,
			color = vec(1, 0.15, 0),
			brightness = 8,
			castShadow = false,
		},
		{
			class = "Light",
			name = "light04",
			offset = vec(-1.01, 0.45, -1.27),
			range = 5,
			color = vec(1, 0.15, 0),
			brightness = 8,
			castShadow = false,
		},
		{
			class = "Light",
			name = "light05",
			offset = vec(-0.04, 0.45, 0.26),
			range = 5,
			color = vec(1, 0.15, 0),
			brightness = 8,
			castShadow = false,
		},
		{
			class = "Particle",
			particleSystem = "rc_crystal_bed",
			emitterMesh = "mod_assets/fire_cave/models/env/rc_small_crystals_bed_2x2.fbx",
		},
	},
	placement = "pillar",
	editorIcon = 240,
	tags = { "red cave", "vanblam" },
	minimalSaveState = true,
}

defineObject{
	name = "rc_small_crystals_bed_1x1",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_small_crystals_bed_1x1.fbx",
			staticShadow = false,
			castShadow = false,
		},
		{
			class = "Model",
			name = "ground",
			model = "mod_assets/fire_cave/models/env/rc_small_crystals_bed_1x1_ground.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			name = "light01",
			offset = vec(0.56, 0.45, 0.52),
			range = 5,
			color = vec(1, 0.15, 0),
			brightness = 8,
			castShadow = false,
		},
		{
			class = "Light",
			name = "light02",
			offset = vec(-0.93, 0.45, -0.35),
			range = 5,
			color = vec(1, 0.15, 0),
			brightness = 8,
			castShadow = false,
		},
		{
			class = "Particle",
			particleSystem = "rc_crystal_bed_small",
			emitterMesh = "mod_assets/fire_cave/models/env/rc_small_crystals_bed_1x1.fbx",
		},
	},
	editorIcon = 240,
	tags = { "red cave", "vanblam" },
	minimalSaveState = true,
}

defineObject{
	name = "rc_large_crystal_formation_1x1",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_large_crystals_bed_1x1.fbx",
			staticShadow = false,
			castShadow = false,
		},
		{
			class = "Model",
			name = "ground",
			model = "mod_assets/fire_cave/models/env/rc_large_crystals_bed_1x1_ground.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			name = "light01",
			offset = vec(0, 1, 0),
			range = 7,
			color = vec(1, 0.15, 0),
			brightness = 9,
			castShadow = false,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
		{
				class = "Particle",
				particleSystem = "rc_crystal",
				emitterMesh = "mod_assets/fire_cave/models/env/rc_large_crystals_bed_1x1.fbx",
		},
	},
	editorIcon = 168,
	automapTile = "rocky_wall",
	tags = { "red cave", "vanblam" },
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_crystal",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_crystal_ground.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0.09, 1.52, -0.52),
			range = 7,
			color = vec(0.85, 0.12, 0),
			brightness = 8,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Model",
			name = "crystal",
			model = "mod_assets/fire_cave/models/env/rc_edge_crystal.fbx",
			staticShadow = false,
			castShadow = false,
		},
		{
				class = "Particle",
				particleSystem = "rc_crystal",
				emitterMesh = "mod_assets/fire_cave/models/env/rc_edge_crystal.fbx",
		},
	},
	editorIcon = 88,
	tags = { "red cave", "vanblam" },
	minimalSaveState = true,
}

defineObject{
	name = "rc_rock_skull",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_rock_skull.fbx",
			castShadow = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
		{
			class = "Null",
			onInit = function(self)
				local x = self.go.x
				local y = self.go.y
				local facing = self.go.facing
				local level = self.go.level
				
				local fx,fy = getForward(facing)
				local rx,ry = getForward((facing+1)%4)

				-- destroy all pillars and slopes
				-- for yy=0,0 do
				-- 	for xx=-0,0 do
				-- 		local x = x + rx * xx + fx * yy
				-- 		local y = y + ry * xx + fy * yy
				-- 		if x >= 0 and y >= 0 and x < 32 and y < 32 then
				-- 			for e in self.go.map:entitiesAt(x, y) do
				-- 				if e.name == "rc_pillar_01a_hatless" 
				-- 				or e.name == "rc_pillar_01b_hatless"
				-- 				or e.name == "rc_pillar_01a"
				-- 				or e.name == "rc_pillar_01b"					
				-- 				then e:destroy()
				-- 				spawn("rc_pillar_02a", level, x, y,math.random(0,3), self.go.elevation)
				-- 				end
				-- 			end
				-- 		end
				-- 	end
				-- end
				for yy=0,0 do
					for xx=-0,0 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do								
								if e.name == "rc_wall_slope"
								or e.name == "rc_edge_support_01" 
								or e.name == "rc_edge_support_02" 
								or e.name == "rc_edge_support_03"
								or e.name == "rc_edge_support_04"
								or e.name == "rc_edge_support_01b"
								or e.name == "rc_edge_support_02b"
								or e.name == "rc_edge_support_03b"
								or e.name == "rc_edge_support_04b"	
								or e.name == "rc_rocks_trim_01"
								or e.name == "rc_rocks_trim_02"
								or e.name == "rc_rocks_trim_03"								
								then e:destroy()
								end
							end
						end
					end
				end
			end,
		},
		{
			class = "Particle",
			particleSystem = "rc_crystal_small",
			emitterMesh = "mod_assets/fire_cave/models/env/rc_rock_skull_crystals.fbx",
		},
		{
			class = "Light",
			name = "crystal_light_1",
			offset = vec(0.2, 0.75, 0.025),
			range = 6,
			color = vec(0.75, 0.05, 0),
			brightness = 2,
			castShadow = false,
			
		},
		{
			class = "Light",
			name = "crystal_light_2",
			offset = vec(-0.17, 0.75, 0.025),
			range = 6,
			color = vec(0.75, 0.05, 0),
			brightness = 2,
			castShadow = false,
			
		},
		{
			class = "Model",
			name = "crystals",
			model = "mod_assets/fire_cave/models/env/rc_rock_skull_crystals.fbx",
			castShadow = false,
		},
	},
	editorIcon = 92,
	automapTile = "rocky_wall",
	tags = { "red cave", "vanblam" },
}