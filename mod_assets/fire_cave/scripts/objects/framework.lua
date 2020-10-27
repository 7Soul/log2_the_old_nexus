-- Framework --
-- Walls - Floors - Celings --

defineObject{
	name = "rc_ground_01",
	baseObject = "base_floor",
	components = {
		{
			class = "Null",
			onInit = function(self)
				-- autoDecoFloor01 stuff
				local g = self.go
				local choice = math.random()
				if choice >= 0.6 then
					  spawn("rc_grass_01a",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.4 then
					  spawn("rc_grass_01b",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.2 then
					  spawn("rc_grass_01c",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end
				choice = math.random()
				if choice >= 0.94 then
					  spawn("rc_ground_tiles_01",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.88 then
					  spawn("rc_ground_tiles_02",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.82 then
					  spawn("rc_ground_tiles_03",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.76 then
					  spawn("rc_ground_tiles_04",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.7 then
					  spawn("rc_ground_tiles_05",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end
				choice = math.random()
				if choice >= 0.8 then
					  spawn("rc_ground_pebbles_04",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.6 then
					  spawn("rc_ground_pebbles_01",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.4 then
					  spawn("rc_ground_pebbles_02",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.2 then
					  spawn("rc_ground_pebbles_03",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end

				-- spawn floor object, which destroys this object due to replacesFloor
				g:spawn("rc_ground_01_real")
			end,
		},
	},
	replacesFloor = true,
	tags = {  },
}

defineObject{
	name = "fire_cave_floor1",
	baseObject = "mine_floor_01",
	components = {
		{
			class = "Null",
			onInit = function(self)
				-- autoDecoFloor01 stuff
				local g = self.go
				local choice = math.random()
				if choice >= 0.6 then
					  spawn("rc_grass_01a",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.4 then
					  spawn("rc_grass_01b",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.2 then
					  spawn("rc_grass_01c",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end
				choice = math.random()
				if choice >= 0.94 then
					  spawn("rc_ground_tiles_01",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.88 then
					  spawn("rc_ground_tiles_02",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.82 then
					  spawn("rc_ground_tiles_03",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.76 then
					  spawn("rc_ground_tiles_04",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.7 then
					  spawn("rc_ground_tiles_05",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end
				choice = math.random()
				if choice >= 0.8 then
					  spawn("rc_ground_pebbles_04",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.6 then
					  spawn("rc_ground_pebbles_01",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.4 then
					  spawn("rc_ground_pebbles_02",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.2 then
					  spawn("rc_ground_pebbles_03",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end

				-- spawn floor object, which destroys this object due to replacesFloor
				g:spawn("rc_ground_01_real")
			end,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "fire_cave_fog",
	baseObject = "base_floor_decoration",
	components = {
		-- {
			-- class = "FogParams",
			-- fogMode = "dense",
			-- fogColor = vec(0.5,0.15,0.15) * 0.1,
			-- fogRange = {0,90},
		-- },
		{
			class = "FogParticles",
			texture = "assets/textures/particles/fog_particle.tga",
			particleSize = 6.5,
			color1 = vec(0.45,0.15,0.15)*3*0.55,
			color2 = vec(0.45,0.15,0.15)*3*0.55,
			color3 = vec(0.45,0.15,0.15)*3*0.55,
			opacity = 0.2,
		},
	},
}

defineObject{
	name = "fire_forest_fog",
	baseObject = "base_floor_decoration",
	components = {
		-- {
		-- 	class = "FogParams",
		-- 	fogMode = "dense",
		-- 	fogColor = vec(0.5,0.15,0.15) * 0.5,
		-- 	fogRange = {0,90},
		-- },
		{
			class = "FogParticles",
			texture = "assets/textures/particles/fog_particle.tga",
			particleSize = 6.5,
			color1 = vec(0.15,0.15,0.15)*0,
			color2 = vec(0.17,0.15,0.15)*0,
			color3 = vec(0.19,0.15,0.15)*0,
			opacity = 0.7,
		},
	},
}

defineObject{
	name = "rc_ground_01_real",
	placement = "floor",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_01.fbx",
			staticShadow = true,
			offset = vec(0, -0.05, 0),
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		},
	},
	replacesFloor = true,
	minimalSaveState = true,
}

defineObject{
	name = "rc_ground_02",
	baseObject = "base_floor",
	components = {
		{
			class = "Null",
			onInit = function(self)
				-- autoDecoFloor02 stuff
				local g = self.go
				local choice = math.random()
				if choice >= 0.6 then
					  spawn("rc_grass_01a",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.4 then
					  spawn("rc_grass_01b",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.2 then
					  spawn("rc_grass_01c",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end
				local choice = math.random()
				if choice >= 0.75 then
					  spawn("rc_ground_tiles_06",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.37 then
					  spawn("rc_ground_tiles_07",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end
				local choice = math.random()
				if choice >= 0.8 then
					  spawn("rc_ground_pebbles_04",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.6 then
					  spawn("rc_ground_pebbles_01",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.4 then
					  spawn("rc_ground_pebbles_02",g.level,g.x,g.y,math.random(0,3),g.elevation)
					elseif choice >= 0.2 then
					  spawn("rc_ground_pebbles_03",g.level,g.x,g.y,math.random(0,3),g.elevation)
				end

				-- spawn floor object, which destroys this object due to replacesFloor
				g:spawn("rc_ground_02_real")
			end,
		},
	},
	replacesFloor = true,
	tags = {  },
}

defineObject{
	name = "rc_ground_02_real",
	placement = "floor",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_02.fbx",
			staticShadow = true,
			--offset = vec(0, -0.05, 0),
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		},
	},
	replacesFloor = true,
	minimalSaveState = true,
}

defineObject{
	name = "rc_molten_floor_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_floor_01.fbx",
			staticShadow = true,
			offset = vec(0, -0.05, 0),
			onInit = function(self)
				local g = self.go
				local canBlock = true
				for entity in Dungeon.getMap(g.level):entitiesAt(g.x, g.y) do					
					if entity.platform then canBlock = false end										
				end
				
				if canBlock then
					local b = spawn("blocker", g.level, g.x, g.y, g.facing, g.elevation + 1)				
					b.obstacle:setBlockParty(true)
					b.obstacle:setBlockItems(true)
					b.obstacle:setBlockMonsters(true)
					b.obstacle:setRepelProjectiles(true)
				end	
				
				local f = spawn("floor_trigger", g.level, g.x, g.y, g.facing, g.elevation)
				f.floortrigger:setTriggeredByItem(true)
				f.floortrigger:addConnector("onActivate", "tpItemScript", "tpItem" .. f.elevation+100)
				
				local time = math.random(3,10)
				g.splashestimer:setTimerInterval(time)
				g.splashestimer:enable(true)
				time = math.random(5,20)
				g.sparkstimer:setTimerInterval(time)
				g.sparkstimer:enable(true)
			end,
		},
		{
			class = "Light",
			range = 4,
			offset = vec(0, 3.2, 0),
			color = vec(1, 0.13, 0),
			brightness = 8,
			castShadow = false,
			staticShadows = true,
			shadowMapSize = 256,
		},
		{
			class = "Light",
			name = "dim_light",
			range = 4,
			offset = vec(0, 3.2, 0),
			color = vec(1, 0.12, 0),
			brightness = 2.5,
			castShadow = false,
			staticShadows = true,
			shadowMapSize = 256,
			-- onUpdate = function(self)
				-- local noise = math.noise(Time.currentTime()*3 + 114) * 0.5 + 0.9
				-- self:setBrightness(noise * 20)
			-- end,
		},
		{
			class = "Particle",
			particleSystem = "gen_lava_smoke01",
			emitterMesh = "mod_assets/fire_cave/models/env/rc_lava_e_mesh.fbx",
		},
		{
			class = "Particle",
			name = "sparks",
			particleSystem = "gen_lava_sparks01",
			emitterMesh = "mod_assets/fire_cave/models/env/rc_lava_e_mesh_sparks.fbx",
			enabled = false,
		},
		{
			class = "Particle",
			name = "splashes",
			particleSystem = "rc_lava_splash",
			enabled = false,
		},
		{
			class = "Timer",
			name = "splashestimer",
			timerInterval = 5.0,
			enabled = false,
			triggerOnStart = false,
			onActivate = function(self)
				local time = math.random(3,10)
				self.go.splashestimer:setTimerInterval(time)
				self.go.splashes:restart()
				self.go.splashsound:play("gen_lava_splash")
			end,
		},
		{
			class = "Timer",
			name = "sparkstimer",
			timerInterval = 5.0,
			enabled = false,
			triggerOnStart = false,
			onActivate = function(self)
				local time = math.random(5,20)
				self.go.sparkstimer:setTimerInterval(time)
				self.go.sparks:restart()
			end,
		},
		{
			class = "Sound",
			sound = "gen_lava",
		},
		{
			class = "Sound",
			name = "splashsound",
			sound = "gen_lava_splash",
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
	tags = {  },
}

defineObject{
	name = "rc_wall_02a",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_wall_02a.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_wall_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
	tags = {  },
}

defineObject{
	name = "rc_wall_02a_standard",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_wall_02a.fbx",
			rotation = vec (0,90,0),
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_wall_01_occluder.fbx",
			rotation = vec (0,90,0),
		},
	},
	minimalSaveState = true,
	tags = {  },
}

defineObject{
	name = "rc_wall_02b",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_wall_02b.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_wall_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
	tags = {  },
}

defineObject{
	name = "rc_wall_brick",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_wall_02b.fbx",
			rotation = vec (0,90,0),
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_wall_01_occluder.fbx",
			rotation = vec (0,90,0),
		},
	},
	minimalSaveState = true,
	tags = {  },
}

defineObject{
	name = "rc_molten_edge_01",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_edge_01.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			sparse = true,
			hitSound = "impact_blunt",
		},
	},
	placement = "wall",
	editorIcon = 160,
	automapIcon = 88,
	minimalSaveState = true,
	tags = {  },
}

defineObject{
	name = "rc_molten_edge_02",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_edge_02.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			sparse = true,
			hitSound = "impact_blunt",
		},
	},
	placement = "wall",
	editorIcon = 160,
	automapIcon = 88,
	minimalSaveState = true,
	tags = {  },
}

defineObject{
	name = "rc_molten_pillar_01",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_pillar_01.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = {  },
}

defineObject{
	name = "rc_elevation_edge_01",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_elevation_edge_01.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			sparse = true,
			hitSound = "impact_blunt",
		},
		{
			class = "Null",
			onInit = function(self)
			local g = self.go
			do
				spawn("rc_elevation_empty", g.level, g.x, g.y,g.facing,g.elevation -1)
			end
					if g.map:getElevation(g.x,g.y) == g.elevation then
						local choice = math.random()
						if choice >= 0.66 then
							g:spawn("rc_rocks_trim_01")
						elseif choice >= 0.33 then
							g:spawn("rc_rocks_trim_02")
						else
							g:spawn("rc_rocks_trim_03")
						end
					end
			end
		},
	},
	placement = "wall",
	editorIcon = 160,
	tags = {  },
}

defineObject{
	name = "rc_elevation_edge_02",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_elevation_edge_02.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			sparse = true,
			hitSound = "impact_blunt",
		},
		{
			class = "Null",
			onInit = function(self)
			local g = self.go
			do
				spawn("rc_elevation_empty", g.level, g.x, g.y,g.facing,g.elevation -1)
			end
					if g.map:getElevation(g.x,g.y) == g.elevation then
						local choice = math.random()
						if choice >= 0.66 then
							g:spawn("rc_rocks_trim_01")
						elseif choice >= 0.33 then
							g:spawn("rc_rocks_trim_02")
						else
							g:spawn("rc_rocks_trim_03")
						end
					end
			end	
		},
	},
	placement = "wall",
	editorIcon = 160,
	tags = {  },
}

defineObject{
	name = "rc_elevation_empty",
	components = {
		{
			class = "Null",
			onInit = function(self)
			self.go:destroy()
			end
		},
	},
	placement = "wall",
	replacesWall = true,
}

defineObject{
	name = "rc_ceiling_02",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_02.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_ceiling_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
	editorIcon = 136,
	tags = {  },
}

defineObject{
	name = "rc_pillar_stone",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_pillar_02a.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	editorIcon = 92,
	tags = {  },
}

defineObject{
	name = "rc_pillar_stone_corner",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_pillar_02a.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	editorIcon = 108,
	tags = {  },
}
