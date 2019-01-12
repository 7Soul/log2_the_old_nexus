defineObject{
	name = "mine_floor_01",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_floor_01.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_wall_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_wall_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_pillar_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pillar_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "mine_pillar_hatless_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pillar_hatless_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "mine_pillar_02",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pillar_02.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "mine_pillar_03",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pillar_03.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "mine_ceiling_01",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_01.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_ceiling_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_ceiling_02",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_02.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_ceiling_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_ceiling_03",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_03.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 2.5, 0),
			range = 6,
			color = vec(0.25, 0.5, 1),
			brightness = 5,
			castShadow = false,
			fillLight = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_ceiling_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_wooden_support",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_wooden_support.fbx",
			staticShadow = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox1",
			size = vec(0.45, 3, 0.35),
			offset = vec(-1.5, 1.5, 0),
		},
		{
			class = "ItemConstrainBox",
			name = "cbox2",
			size = vec(0.45, 3, 0.35),
			offset = vec(1.5, 1.5, 0),
		},
	},
	editorIcon = 188,
	minimalSaveState = true,
}

defineObject{
	name = "mine_pit",
	baseObject = "base_pit",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		},
	},
}

defineObject{
	name = "mine_pit_trapdoor",
	baseObject = "base_pit_trapdoor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "trapDoorModel",
			model = "assets/models/env/mine_pit_trapdoor.fbx",
		},
		{
			class = "Animation",
			model = "trapDoorModel",
			animations = {
				open = "assets/animations/env/mine_pit_trapdoor_open.fbx",
				close = "assets/animations/env/mine_pit_trapdoor_close.fbx",
			},
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		},
	},
}

defineObject{
	name = "mine_chasm_edge",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_big_pit_edge.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_chasm",
	components = {
		{
			class = "Pit",
			onInit = function(self)
				-- place edges
				for i=0,3 do
					local dx,dy = getForward(i)
					local adjacent = false
					for e in self.go.map:entitiesAt(self.go.x + dx, self.go.y + dy) do
						if e.name == "mine_chasm" then
							adjacent = true
							break
						end
					end
					if not adjacent then
						spawn("mine_chasm_edge", self.go.level, self.go.x, self.go.y, i, 0)
					end
				end
			end,
		},
	},
	replacesFloor = true,
	placement = "floor",
	editorIcon = 40,
	automapTile = "chasm",
}

defineObject{
	name = "mine_bridge_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_bridge.fbx",
			staticShadow = true,
		},
		{
			class = "Platform",
		},
	},
	placement = "floor",
	editorIcon = 100,
	automapIcon = 136,
}

defineObject{
	name = "mine_ceiling_shaft_edge",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_big_pit_ceiling_edge.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_ceiling_shaft",
	components = {
		{
			class = "Null",
			onInit = function(self)
				-- replace mine pillars with hatless pillars in adjacent squares
				for i=0,3 do
					local dx,dy = getForward(i)
					local x = self.go.x + dx
					local y = self.go.y + dy
					if x >= 0 and y >= 0 and x < 32 and y < 32 then
						for e in self.go.map:entitiesAt(x, y) do
							if string.match(e.name, "^mine_pillar_%d+") then
								spawn("mine_pillar_hatless_01", self.go.level, x, y, e.facing, self.go.elevation)
								e:destroy()
								break
							end
						end
					end
				end

				-- place edges
				for i=0,3 do
					local dx,dy = getForward(i)
					local adjacent = false
					for e in self.go.map:entitiesAt(self.go.x + dx, self.go.y + dy) do
						if e.name == "mine_ceiling_shaft" then
							adjacent = true
							break
						end
					end
					if not adjacent then
						spawn("mine_ceiling_shaft_edge", self.go.level, self.go.x, self.go.y, i, self.go.elevation)
					end
				end
			end,
		}
	},
	replacesCeiling = true,
	placement = "ceiling",
	editorIcon = 104,
}

defineObject{
	name = "mine_door_spear",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_door_spear.fbx",
		},
		{
			class = "Door",
			openVelocity = 4,
			closeVelocity = -6,
			openingDirection = "down",
			maxHeight = 2,
			sparse = true,
			killPillars = false,
			openSound = "spear_door",
			closeSound = "spear_door",
			--lockSound = "wall_sliding_lock",
		},
	},
}

-- defineObject{
-- 	name = "mine_secret_door",
-- 	baseObject = "base_secret_door",
-- 	components = {
-- 		{
-- 			class = "Model",
-- 			model = "assets/models/env/mine_secret_door.fbx",
-- 			staticShadow = true,
-- 		},
-- 	},
-- 	placement = "floor",
-- }

-- hacked secret door with center placement
-- should fix all known issues with items
-- however, this door can only be opened, not closed
defineObject{
	name = "mine_secret_door",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_secret_door.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				open = "assets/animations/env/mine_secret_door_open.fbx",
			},
			onAnimationEvent = function(self, event)
				if event == "open" then
					self.go.obstacle:disable()
					self.go.projectilecollider:disable()
				elseif event == "lock" then
					self.go.sound:stop()
					self.go.sound:disable()
					self.go:playSound("wall_sliding_lock")
				end
			end,
		},
		{
			class = "Sound",
		},
		{
			class = "Controller",
			onOpen = function(self)
				self.go.animation:play("open")
				self.go.sound:play("wall_sliding")
				self.go.map:setAutomapTile(self.go.x, self.go.y, 0)
				self:disable()
			end,
		},
	},
	placement = "floor",
	editorIcon = 120,
	automapTile = "wall",
}

defineAnimationEvent{
	animation = "assets/animations/env/mine_secret_door_open.fbx",
	event = "open",
	frame = 90,
}

defineAnimationEvent{
	animation = "assets/animations/env/mine_secret_door_open.fbx",
	event = "lock",
	normalizedTime = 1,
}

defineObject{
	name = "mine_lever",
	baseObject = "lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_lever.fbx",
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/mine_lever_open.fbx",
				deactivate = "assets/animations/env/mine_lever_close.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0, 0.8, -0.3),
			size = vec(1.7, 1.0, 0.4),
			debugDraw = false,
		},
	},
}
defineObject{
	name = "mine_lever_corner",
	baseObject = "lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_lever.fbx",
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/mine_lever_open.fbx",
				deactivate = "assets/animations/env/mine_lever_close.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0, 0.8, -0.3),
			size = vec(1.7, 1.0, 0.4),
			debugDraw = false,
		},
	},
	placement = "pillar",
}

defineObject{
	name = "mine_secret_lever",
	baseObject = "lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_secret_lever.fbx",
		},
		{
			class = "Clickable",
			offset = vec(0, 0.8, 0),
			size = vec(0.4, 0.7, 0.4),
			debugDraw = false,
		},
	}
}
	
do
	local lightColor = vec(0.3, 0.7, 1.4)
	local lightBrightness = 5
	local lightRange = 2.5
	local lightScale = 1

	defineObject{
		name = "mine_pillar_crystal",
		baseObject = "base_floor_decoration",
		components = {
			{
				class = "Model",
				model = "assets/models/env/mine_pillar_crystal.fbx",
				staticShadow = true,
			},
			{
				class = "Light",
				name = "crystal_light_01",
				offset = vec(0.509, 0.93, 0.89) * lightScale,
				range = lightRange,
				color = lightColor,
				brightness = lightBrightness,
				fillLight = true,
				--debugDraw = true,
			},		
			{
				class = "Light",
				name = "crystal_light_02",
				offset = vec(1, 0.79, -0.2) * lightScale,
				range = lightRange,
				color = lightColor,
				brightness = lightBrightness,
				fillLight = true,
				--debugDraw = true,
			},	
			{
				class = "Light",
				name = "crystal_light_03",
				offset = vec(0.5, 1.15, -0.64) * lightScale,
				range = lightRange,
				color = lightColor,
				brightness = lightBrightness,
				fillLight = true,
				--debugDraw = true,
			},		
			{
				class = "Light",
				name = "crystal_light_04",
				offset = vec(0.096, 0.9, -0.85) * lightScale,
				range = lightRange,
				color = lightColor,
				brightness = lightBrightness,
				fillLight = true,
				--debugDraw = true,
			},		
			{
				class = "Light",
				name = "crystal_light_05",
				offset = vec(-0.668, 1.59, 0.38) * lightScale,
				range = lightRange,
				color = lightColor,
				brightness = lightBrightness,
				fillLight = true,
				--debugDraw = true,
			},		
			{
				class = "Light",
				name = "crystal_light_06",
				offset = vec(0.33, 1.46, 0.43) * lightScale,
				range = lightRange,
				color = lightColor,
				brightness = lightBrightness,
				fillLight = true,
				--debugDraw = true,
			},		
			{
				class = "Light",
				name = "crystal_light_07",
				offset = vec(-0.8, 0.8, -0.26) * lightScale,
				range = lightRange,
				color = lightColor,
				brightness = lightBrightness,
				fillLight = true,
				--debugDraw = true,
			},		
			{
				class = "Particle",
				particleSystem = "mine_crystal",
				emitterMesh = "assets/models/env/mine_pillar_crystal_emitter.fbx",
				--offset = vec(0.62, 1.41, -0.64),
			},
			{
				class = "Occluder",
				model = "assets/models/env/mine_pillar_01_occluder.fbx",
			},
		},
		minimalSaveState = true,
	}
end

defineObject{
	name = "mine_stairs_up",
	baseObject = "base_stairs_up",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_stairs_up.fbx",
			staticShadow = true,
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

				do				
					local x = self.go.x + fx
					local y = self.go.y + fy
					if x >= 0 and y >= 0 and x < 32 and y < 32 then
						self.go.map:setAutomapTile(x, y, 4)	-- rocky wall
					end
				end

				-- replace pillars in 3x3 area with hatless versions
				for yy=0,2 do
					for xx=-1,1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "mine_pillar_01" or e.name == "mine_pillar_02" or e.name == "mine_pillar_03" then
									e:destroy()
									spawn("mine_pillar_hatless_01", level, x, y, math.random(0,3), self.go.elevation)
								end
							end
						end
					end
				end
			end,
		},
	},
}

defineObject{
	name = "mine_moss_stairs_up",
	baseObject = "mine_stairs_up",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_stairs_up.fbx",
			material = "mine_moss_tile",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "mine_stairs_down",
	baseObject = "base_stairs_down",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_stairs_down.fbx",
			onInit = function(self)
				local dx,dy = getForward(self.go.facing)
				local x = self.go.x + dx
				local y = self.go.y + dy
				if x >= 0 and y >= 0 and x < 32 and y < 32 then
					self.go.map:setAutomapTile(x, y, 4)	-- rocky wall
				end
			end,
			staticShadow = true,
		},
	},
}

defineObject{
	name = "mine_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pressure_plate.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/mine_pressure_plate_down.fbx",
				deactivate = "assets/animations/env/mine_pressure_plate_up.fbx",	
			},
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		},
	},
}

defineObject{
	name = "mine_wooden_support_wall",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_wooden_support_wall.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 160,
	automapIcon = 88,
	minimalSaveState = true,
}

defineObject{
	name = "mine_support_pillar_01",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_pillar_01.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_support_pillar_01_half",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_pillar_01.fbx",
			offset = vec(0,-1.5,0),
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_support_wall_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_wall_01.fbx",
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
}

defineObject{
	name = "mine_support_wall_02",
	baseObject = "mine_support_wall_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_wall_02.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_support_beam_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_beam_01.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 188,
	minimalSaveState = true,
}

defineObject{
	name = "mine_support_beam_01_floor",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			name = "model1",
			model = "assets/models/env/mine_support_beam_01.fbx",
			offset = vec(0,0.2,0),
			staticShadow = true,
		},
	},
	editorIcon = 188,
	minimalSaveState = true,
}

defineObject{
	name = "mine_support_beam_floor_double",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			name = "model1",
			model = "assets/models/env/mine_support_beam_01.fbx",
			offset = vec(0,0.2,0),
			staticShadow = true,
		},
		{
			class = "Model",
			name = "model2",
			model = "assets/models/env/mine_support_beam_01.fbx",
			offset = vec(0,-0.3,0),
			staticShadow = true,
		}
	},
	editorIcon = 188,
	minimalSaveState = true,
}

defineObject{
	name = "mine_support_ceiling_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_ceiling_01.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 164,
	minimalSaveState = true,
}

defineObject{
	name = "mine_alcove",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_alcove_01.fbx",
			staticShadow = true,
		},
		{
			class = "Surface",
			offset = vec(0, 0.85, -0.75),
			size = vec(1.5, 0.65),
			--debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 0.85+0.4, -0.75),
			size = vec(1.3, 0.8, 0.65),
			maxDistance = 1,
			frontFacing = true,
			--debugDraw = true,
		},
		{
			class = "Obstacle",
		},
		{
			class = "ProjectileCollider",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_alcove_01_occluder.fbx",
		},
	},
	placement = "floor",
	editorIcon = 52,
	automapTile = "wall",
}

defineObject{
	name = "mine_floor_sandpile",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_floor_sandpile.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
	},
	editorIcon = 56,
	minimalSaveState = true,
}

defineObject{
	name = "mine_wall_text",
	baseObject = "base_wall_text",
	components = {
		{
			class = "WallText",
			height = 0.435,
		},
		{
			class = "Model",
			model = "assets/models/env/mine_wall_text.fbx",
			staticShadow = true,
		},
	},
	replacesWall = false,
}

defineObject{
	name = "mine_wall_text_long",
	baseObject = "base_wall_text",
	components = {
		{
			class = "WallText",
			height = 0.455,
		},
		{
			class = "Model",
			model = "assets/models/env/mine_wall_text_long.fbx",
			staticShadow = true,
		},
	},
	replacesWall = false,
}

defineObject{
	name = "mine_rockpile_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_rockpile_01.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	automapTile = "rocky_wall",
}

defineObject{
	name = "mine_door_heavy",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_door_heavy.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/mine_door_support_frame.fbx",
		},
	},
}

defineObject{
	name = "mine_door_support",
	baseObject = "base_door_sparse",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_door_support.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/mine_door_support_frame.fbx",
		},
	},
}

defineObject{
	name = "mine_door_camo",
	baseObject = "base_door_sparse",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_door_camo.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/mine_door_support_frame.fbx",
		},
	},
}

defineObject{
	name = "mine_alcove_support",
	baseObject = "base_alcove",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_alcove_support_01.fbx",	
			staticShadow = true,	
		},
		{
			class = "Surface",
			offset = vec(0, 1, 0.2),
			size = vec(1.3, 0.65),
			--debugDraw = true,
		},
	},
	automapIcon = 88,
}

defineObject{
	name = "mine_spell_receptor",
	baseObject = "receptor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_spell_receptor.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "mine_spell_receptor_support",
	baseObject = "receptor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_spell_receptor_support.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			hitSound = "impact_blunt",
		},
		{
			class = "ItemConstrainBox",
			offset = vec(0, 0.5, 0.15),
			size = vec(1.1, 1, 0.5),
			--debugDraw = true,
		},
	},
	automapIcon = 88,
}

defineObject{
	name = "mine_spell_launcher",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_spell_launcher.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "mine_spell_launcher_support",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_spell_launcher_support.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			hitSound = "impact_blunt",
		},
		{
			class = "ItemConstrainBox",
			offset = vec(0, 0.5, 0.15),
			size = vec(1.1, 1, 0.5),
			--debugDraw = true,
		},
	},
	automapIcon = 88,
	editorIcon = 92,
}

defineObject{
	name = "mine_support_pillar_lantern_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_pillar_lantern_01.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.55, -0.25),
			range = 7,
			color = vec(1.1, 0.7, 0.3),
			brightness = 7,
			castShadow = true,
			staticShadows = true,
			onInit = function(self)
				-- optimization: disable casting light behind the pillar
				local face
				if self.go.facing == 0 then
					-- disable -Z
					face = 5
				elseif self.go.facing == 1 then
					-- disable -X
					face = 1
				elseif self.go.facing == 2 then
					-- disable +Z
					face = 4
				elseif self.go.facing == 3 then
					-- disable +X
					face = 0
				end
				self:setClipDistance(face, 0)
			end,
		},
		{
			class = "Particle",
			particleSystem = "mine_support_lantern",
			offset = vec(0, 1.53, -0.17),
		},
	},
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "mine_ceiling_pit_light",
	components = {
		{
			class = "Light",
			type = "spot",
			spotAngle = 65,
			spotSharpness = 0.7,
			offset = vec(0, 7, 0),
			rotation = vec(-90, 0, 0),
			range = 15,
			color = vec(0.75, 1, 1.55),
			brightness = 9,
			castShadow = true,
			shadowMapSize = 128,
			staticShadows = true,
		},
		{
			class = "Light",
			name = "pointlight",
			type = "point",
			offset = vec(0, 7, 0),
			range = 5,
			color = vec(0.75, 1, 1.55),
			brightness = 12,
		},
		{
			class = "Particle",
			particleSystem = "mine_ceiling_pit_light",
			offset = vec(0, 7, 0),
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.light:enable()
				self.go.pointlight:enable()
				self.go.particle:enable()
			end,
			onDeactivate = function(self)
				self.go.light:disable()
				self.go.pointlight:disable()
				self.go.particle:disable()
			end,
			onToggle = function(self)
				if self.go.light:isEnabled() then
					self.go.light:disable()
					self.go.pointlight:disable()
					self.go.particle:disable()
				else
					self.go.light:enable()
					self.go.pointlight:enable()
					self.go.particle:enable()
				end
			end,
		},
	},
	placement = "floor",
	editorIcon = 88,
}

defineObject{
	name = "mine_ceiling_pit_light_bright",
	components = {
		{
			class = "Light",
			type = "spot",
			spotAngle = 70,
			rotation = vec(-90, 0, 0),
			spotSharpness = 0.7,
			offset = vec(0, 10, 0),
			range = 20,
			color = vec(0.75, 1, 1.55),
			brightness = 20,
			castShadow = true,
			shadowMapSize = 1024,
		},
		{
			class = "Light",
			name = "pointlight",
			type = "point",
			offset = vec(0, 10, 0),
			range = 10,
			color = vec(0.75, 1, 1.55),
			brightness = 20,
		},
		{
			class = "Particle",
			particleSystem = "mine_ceiling_pit_light",
			offset = vec(0, 7, 0),
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.light:enable()
				self.go.pointlight:enable()
				self.go.particle:enable()
			end,
			onDeactivate = function(self)
				self.go.light:disable()
				self.go.pointlight:disable()
				self.go.particle:disable()
			end,
			onToggle = function(self)
				if self.go.light:isEnabled() then
					self.go.light:disable()
					self.go.pointlight:disable()
					self.go.particle:disable()
				else
					self.go.light:enable()
					self.go.pointlight:enable()
					self.go.particle:enable()
				end
			end,
		},
	},
	placement = "floor",
	editorIcon = 88,
}

defineObject{
	name = "mine_floor_pit_light",
	components = {
		{
			class = "Light",
			offset = vec(0, -2, 0),
			range = 15,
			color = vec(0.8, 1, 1.55),
			brightness = 4,
			castShadow = true,
		},
		{
			class = "Particle",
			particleSystem = "mine_ceiling_pit_light",
			offset = vec(0, -2, 0),
		},
	},
	placement = "floor",
	editorIcon = 88,
}

defineObject{
	name = "mine_ceiling_lantern",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_lantern.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 2.90, 0),
			range = 10,
			color = vec(1.1, 0.7, 0.3),
			brightness = 7,
			castShadow = true,
			staticShadows = true,
			onInit = function(self)
				-- optimization: disable casting light towards +Y
				self:setClipDistance(2, 0)
			end,
		},
		{
			class = "Particle",
			particleSystem = "mine_support_ceiling_lantern",
			offset = vec(0, 2.90, 0),
		},
	},
	placement = "floor",
	editorIcon = 88,
}

defineObject{
	name = "mine_support_wall_button",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_wall_button.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			hitSound = "impact_blunt",
		},
		{
			class = "ItemConstrainBox",
			offset = vec(0, 0.5, 0.15),
			size = vec(1.1, 1, 0.5),
			--debugDraw = true,
		},
	},
	automapIcon = 88,
}

defineObject{
	name = "mine_support_secret_button",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_secret_button.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/mine_support_secret_button_press.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(-0.5, 1.75, 0),
			size = vec(0.15, 0.23, 0.15),
			--debugDraw = true,
		},
		{
			class = "Door",
			hitSound = "impact_blunt",
		},
	},
	automapIcon = 88,
}

defineObject{
	name = "mine_cave_in",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_cave_in.fbx",
			staticShadow = true,
		},
	},
	editorIcon = 144,
	automapTile = "rocky_wall",
	minimalSaveState = true,
}

defineObject{
	name = "mine_counterweight_chains",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_counterweight_chains_01.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_counterweight_platform",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_counterweight_platform_01.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_elevation_edge",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_elevation_edge.fbx",
			offset = vec(0, 3, 0),
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_elevation_edge_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_ceiling_roots_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_roots_01.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_ceiling_shaft_roots_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_shaft_roots_01.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_wall_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_wall_01.fbx",
			material = "mine_moss_tile",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_pillar_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pillar_01.fbx",
			material = "mine_moss_pillar",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_pillar_hatless_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pillar_hatless_01.fbx",
			material = "mine_moss_pillar",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_pillar_02",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pillar_02.fbx",
			material = "mine_moss_pillar",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_pillar_03",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_pillar_03.fbx",
			material = "mine_moss_pillar",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_ceiling_01",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_01.fbx",
			material = "mine_moss_tile",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_ceiling_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_ceiling_02",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_02.fbx",
			material = "mine_moss_tile",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_ceiling_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_ceiling_03",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_03.fbx",
			material = "mine_moss_tile",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_ceiling_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_rockpile_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_rockpile_01.fbx",
			material = "mine_moss_tile",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_cave_in",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_cave_in.fbx",
			material = "mine_moss_tile",
			staticShadow = true,
		},
	},
	editorIcon = 144,
	automapTile = "rocky_wall",
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_wooden_support",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_wooden_support.fbx",
			materialOverrides = { ["mine_wall_01"] = "mine_moss_tile" },
			staticShadow = true,
		}
	},
	editorIcon = 188,
	minimalSaveState = true,
}

defineObject{
	name = "mine_moss_door_support",
	baseObject = "base_door_sparse",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_door_support.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/mine_door_support_frame.fbx",
			materialOverrides = { ["mine_wall_01"] = "mine_moss_tile" },
		},
	},
}
