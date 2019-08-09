-- Decorations --
-- Slopes - Supports - Obstacles - Chasms - Ruins - Effects - Grass - Portcullis --

defineObject{
	name = "rc_lava_surface", -- I highly recommend you place this in the center of the map. You can move it closer to edges to hide the lava surface. But the fog will still take place.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_lava_plane.fbx",
			offset = vec(0,-0.2,0),			
		},
		{
			class = "Animation",
			animations = {
				move = "mod_assets/fire_cave/animations/rc_lava_plane_move.fbx",
			},
			playOnInit = "move",
			loop = true,
		},	
		{
			class = "FogParams",
			fogMode = "dense",
			fogColor = vec(1, 0.3, 0)* 0.8,
			fogRange = {0,10},
		},
		{
			class = "Timer",
			timerInterval = 0,
			currentLevelOnly = true,
			onActivate = function(self)
				local y = party:getWorldPositionY()
				if y < -1.4 then
					self.go.fogparams:enable()
					-- "fade in" the fog a little as the party falls into the lava
					self.go.fogparams:setFogRange({0,4/math.min(1,-1.3-y)})
					self.go.fogparams:setFogColor(vec(0.9, 0.07, 0.05)* 0.8)
				else
					self.go.fogparams:setFogRange({0,90})
					self.go.fogparams:setFogColor(vec(0.5,0.15,0.15) * 0.1)
				end
			end,
		},
	},
	placement = "pillar",
	editorIcon = 264,
	dontAdjustHeight = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_molten_edge_round_full",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_edge_round_full.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
	},
	minimalSaveState = true,
	editorIcon = 56,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_molten_edge_round_full_low",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_edge_round_full_low.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
	},
	minimalSaveState = true,
	editorIcon = 56,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_molten_edge_round_corner",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_edge_round_corner.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
	},
	minimalSaveState = true,
	editorIcon = 56,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_molten_edge_round_corner_low",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_edge_round_corner_low.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
	},
	minimalSaveState = true,
	editorIcon = 56,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_molten_edge_extra_x2",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_edge_extra_x2.fbx",
			staticShadow = true,
			offset = vec(-0.5,-0.05,-0.2)
		},
	},
	minimalSaveState = true,
	editorIcon = 160,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_molten_edge_extra_x1",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_edge_extra_x1.fbx",
			staticShadow = true,
			offset = vec(-0.1,-0.05,0.1)
		},
	},
	minimalSaveState = true,
	editorIcon = 160,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_molten_shard_01",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_shard_01.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_molten_shard_01_center",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_shard_01.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
	},
	editorIcon = 56,
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ceiling_02_edge",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ceiling_02_edge.fbx",
		},
	},
	replacesCeiling = true,
	minimalSaveState = true,
	editorIcon = 92,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_effect_dust_motes",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Null",
		},
		{
				class = "Particle",
				particleSystem = "rc_dust_motes",
		},
	},
	minimalSaveState = true,
	editorIcon = 272,
	tags = { "red cave", "vanblam"},
}

defineObject{
	name = "rc_rock_pile",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_rock_pile.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 56,
	automapTile = "rocky_wall",
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_spire",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_spire.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 56,
	automapTile = "rocky_wall",
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_stone_table",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_table.fbx",
			staticShadow = true,
		},
		{
			class = "Surface",
			offset = vec(0, 0.85, -0.275),
			size = vec(1.1, 1.1),
			--debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 0.85+0.4, -0.275),
			size = vec(1.1, 0.8, 1.1),
			--debugDraw = true,
		},
	},
	placement = "wall",
	editorIcon = 52,
	automapIcon = 112,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_altar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_alter.fbx",
			staticShadow = true,
		},
		{
			class = "Surface",
			offset = vec(0, 0.85, -0.46),
			size = vec(2.3, 0.9),
			--debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 0.85+0.4, -0.46),
			size = vec(2.3, 0.8, 0.9),
			--debugDraw = true,
		},
	},
	placement = "wall",
	editorIcon = 52,
	automapIcon = 152,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_floor_grate",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_floor_grate.fbx",
			staticShadow = true,
		},
	},
	placement = "floor",
	replacesFloor = true,
	killHeightmap = true,
	minimalSaveState = "true",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_rock_chasm_1x6",
	-- Works better if placed in the midddle of a long hallway that is atleast 8 sections long.
	components = {
		{
			class = "Null",
			onInit = function(self)
				local x = self.go.x
				local y = self.go.y
				local facing = self.go.facing
				local level = self.go.level
				
				local fx,fy = getForward(facing)
				local rx,ry = getForward((facing+1)%4)

				for yy=-3,3 do
					for xx=-2,-1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						local choice = math.random()
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_pillar_01a" 
								or e.name == "rc_pillar_01b" 								
								then e:destroy()
									if choice >= 0.66 then
											spawn("rc_pillar_01a_hatless", level, x, y,math.random(0,3), self.go.elevation)
										elseif choice >= 0.33 then
											spawn("rc_pillar_01b_hatless", level, x, y,math.random(0,3), self.go.elevation)
										else
											spawn("rc_pillar_01b_hatless", level, x, y,math.random(0,3), self.go.elevation)
									end
								end
							end
						end
					end
				end
				for yy=-3,3 do
					for xx=1,2 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						local choice = math.random()
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_pillar_01a"
								or e.name == "rc_pillar_01b"							
								then e:destroy()
									if choice >= 0.66 then
											spawn("rc_pillar_01a_hatless", level, x, y,math.random(0,3), self.go.elevation)
										elseif choice >= 0.33 then
											spawn("rc_pillar_01b_hatless", level, x, y,math.random(0,3), self.go.elevation)
										else
											spawn("rc_pillar_01b_hatless", level, x, y,math.random(0,3), self.go.elevation)
									end
								end
							end
						end
					end
				end
				for yy=-3,3 do
					for xx=-1,1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						local choice = math.random()
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_ceiling_01a"		
								or e.name == "rc_ceiling_01b"
								or e.name == "rc_ceiling_01c"
								or e.name == "rc_ceiling_01d"
								or e.name == "rc_ceiling_01e"
								or e.name == "rc_edge_support_01"
								or e.name == "rc_edge_support_02"
								or e.name == "rc_edge_support_03"
								or e.name == "rc_edge_support_04"
								or e.name == "rc_edge_support_01b"
								or e.name == "rc_edge_support_02b"
								or e.name == "rc_edge_support_03b"
								or e.name == "rc_edge_support_04b"				
								then e:destroy()
								end
							end
						end
					end
				end
				self.go:spawn("rc_rock_chasm_1x6_real")
				self.go:destroy()
			end,
		},
	},
	placement = "floor",
	editorIcon = 56,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_rock_chasm_1x6_real",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_rock_chasm_1x6.fbx",
			staticShadow = true,
		},
	},
	placement = "floor",
}

defineObject{
	name = "rc_ruined_wall_full_edge",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ruined_wall_full.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "wall",
	editorIcon = 120,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ruined_wall_full_center",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ruined_wall_full.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 120,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ruined_wall_left_edge",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ruined_wall_left.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "wall",
	editorIcon = 120,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ruined_wall_left_center",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ruined_wall_left.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 120,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ruined_wall_right_edge",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ruined_wall_right.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "wall",
	editorIcon = 120,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ruined_wall_right_center",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ruined_wall_right.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 120,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_grass_01a",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_grass_01a.fbx",
			castShadow = false,
			offset = vec(0, -0.06, 0),
			dissolveStart = 5,
			dissolveEnd = 7,
		},
		{
			class = "Animation",
			animations = {
				sway = "mod_assets/fire_cave/animations/rc_grasses_sway.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	minimalSaveState = true,
	placement = "floor",
	reflectionMode = "never",
	editorIcon = 240,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_grass_01b",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_grass_01b.fbx",
			castShadow = false,
			offset = vec(0, -0.06, 0),
			dissolveStart = 5,
			dissolveEnd = 7,
		},
		{
			class = "Animation",
			animations = {
				sway = "mod_assets/fire_cave/animations/rc_grasses_sway.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	minimalSaveState = true,
	placement = "floor",
	reflectionMode = "never",
	editorIcon = 240,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_grass_01c",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_grass_01c.fbx",
			castShadow = false,
			offset = vec(0, -0.06, 0),
			dissolveStart = 5,
			dissolveEnd = 7,
		},
		{
			class = "Animation",
			animations = {
				sway = "mod_assets/fire_cave/animations/rc_grasses_sway.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	minimalSaveState = true,
	placement = "floor",
	reflectionMode = "never",
	editorIcon = 240,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_tiles_01",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_tiles_01.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_tiles_02",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_tiles_02.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_tiles_03",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_tiles_03.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_tiles_04",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_tiles_04.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_tiles_05",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_tiles_05.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_tiles_06",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_tiles_06.fbx",
			castShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_tiles_07",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_tiles_07.fbx",
			castShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_pebbles_01",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_pebbles_01.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_pebbles_02",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_pebbles_02.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_pebbles_03",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_pebbles_03.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_ground_pebbles_04",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_ground_pebbles_04.fbx",
			castShadow = true,
			offset = vec(0, -0.06, 0),
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_rocks_trim_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_rocks_trim_01.fbx",
		},
	},
	minimalSaveState = true,
	editorIcon = 244,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_rocks_trim_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_rocks_trim_02.fbx",
		},
	},
	minimalSaveState = true,
	editorIcon = 244,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_rocks_trim_03",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_rocks_trim_03.fbx",
		},
	},
	minimalSaveState = true,
	editorIcon = 244,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_large_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_large_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 56,
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_buttonlever_surface", -- bl = button/lever, these objects are used to place levers, buttons or locks on there surface.
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_bl_surface_01.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "trim_01",
			model = "mod_assets/fire_cave/models/env/rc_bl_surface_01_trim01.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "trim_02",
			model = "mod_assets/fire_cave/models/env/rc_bl_surface_01_trim02.fbx",
			staticShadow = true,
		},
	},
	editorIcon = 92,
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_small_01a",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_small_01a.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_small_01b",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_small_01b.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_small_01c",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_small_01c.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_small_01d",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_small_01d.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_small_01e",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_small_01e.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_small_01f",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_small_01f.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_small_01g",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_small_01g.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_support_small_01h",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_support_small_01h.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_portcullis_gate",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_portcullis_gate.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			sparse = true,
			hitSound = "impact_blunt",
		},
	},
	minimalSaveState = true,
	placement = "wall",
	editorIcon = 132,
	automapIcon = 84,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_portcullis_gate_end",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_portcullis_gate_end.fbx",
			offset = vec(-1.275, 0, 0),
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "wall",
	editorIcon = 188,
	automapIcon = 84,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_portcullis_gate_both_ends",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_portcullis_gate_end_both.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	placement = "wall",
	editorIcon = 188,
	automapIcon = 84,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_stone_tablet",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_tablet.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			sparse = true,
			hitSound = "impact_blunt",
		},
	},
	minimalSaveState = true,
	placement = "wall",
	editorIcon = 8,
	tags = { "red cave", "vanblam" },
}
