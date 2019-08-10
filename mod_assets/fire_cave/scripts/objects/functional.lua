-- Functional --
-- Pressure Plates - Contraptions - Buttons - Levers - Shafts - Stairs --

defineObject{
	name = "rc_molten_floaty_move_to_surface", -- animation to bring to serface, no idle.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_floaty.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
			startpoint = "mod_assets/fire_cave/animations/rc_molten_floaty_start.fbx",
			move = "mod_assets/fire_cave/animations/rc_molten_floaty_move.fbx",
			},
			loop = false,
			playOnInit = "startpoint",
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.animation:play("move")
			end,
		},
	},
	placement = "floor",
	editorIcon = 80,
	tags = {  },
}

defineObject{
	name = "rc_molten_floaty_idle_no_effect",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_molten_floaty.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
			idle = "mod_assets/fire_cave/animations/rc_molten_floaty_idle.fbx",
			},
			loop = true,
			playOnInit = "idle",
		},
		{
			class = "Platform",
		},
	},
	placement = "floor",
	automapIcon = 136,
	editorIcon = 276,
	tags = {  },
	minimalSaveState = true,
}

defineObject{
	name = "rc_stone_lock_01",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_lock_01.fbx",
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.3, 0),
			size = vec(0.3, 0.3, 0.3),
			--debugDraw = true,
		},
		{
			class = "Lock",
			sound = "key_lock",
		},
		
	},
	placement = "wall",
	editorIcon = 20,
	tags = {  },
}
defineObject{
	name = "rc_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_floor_plate.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/forest_pressure_plate_down.fbx",
				deactivate = "assets/animations/env/forest_pressure_plate_up.fbx",
			},
		},
		{
			class = "Model",
			name = "base",
			model = "mod_assets/fire_cave/models/env/rc_floor_plate_base.fbx",
			staticShadow = true,
		},
	},
	tags = {  },
}

defineObject{
	name = "rc_stone_ceiling_shaft",
	baseObject = "base_ceiling_shaft",
	components = {
		{
			class = "Null",
			name = "auto_destroy_objects",
			onInit = function(self)
				local x = self.go.x
				local y = self.go.y
				local facing = self.go.facing
				local level = self.go.level
				
				local fx,fy = getForward(facing)
				local rx,ry = getForward((facing+1)%4)

				-- destroy other ceilings in a 3x3 area
				for yy=0,0 do
					for xx=-1,1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_edge_support_01"
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
				self.go:spawn("rc_stone_ceiling_shaft_real")
			end,
		},
		
	},
	tags = {  },
}

defineObject{
	name = "rc_stone_ceiling_shaft_real",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_ceiling_shaft.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	replacesCeiling = true,
	placement = "ceiling",
}

defineObject{
	name = "rc_floor_shaft",
	components = {
		{
			class = "Pit",
		},
		{
			class = "Null",
			name = "auto_destroy_objects",
			onInit = function(self)
				local x = self.go.x
				local y = self.go.y
				local facing = self.go.facing
				local level = self.go.level
				
				local fx,fy = getForward(facing)
				local rx,ry = getForward((facing+1)%4)

				-- destroy other ceilings in a 3x3 area
				self.go:spawn("rc_floor_shaft_real")
			end,
		},
		
	},
	replacesFloor = true,
	killHeightmap = true,
	placement = "floor",
	editorIcon = 40,
	automapIcon = 108,
	tags = {  },
}

defineObject{
	name = "rc_floor_shaft_real",
	components = {
		{
			class = "Model",
			offset = vec(0, -0.09, 0),
			model = "mod_assets/fire_cave/models/env/rc_floor_shaft.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	replacesFloor = true,
	placement = "floor",
	automapIcon = 108,
}

defineObject{
	name = "rc_stone_floor_shaft",
	components = {
		{
			class = "Pit",
		},
		{
			class = "Null",
			name = "auto_destroy_objects",
			onInit = function(self)
				local x = self.go.x
				local y = self.go.y
				local facing = self.go.facing
				local level = self.go.level
				
				local fx,fy = getForward(facing)
				local rx,ry = getForward((facing+1)%4)

				-- destroy other ceilings in a 3x3 area
				self.go:spawn("rc_stone_floor_shaft_real")
			end,
		},
		
	},
	replacesFloor = true,
	killHeightmap = true,
	placement = "floor",
	editorIcon = 40,
	automapIcon = 108,
	tags = {  },
}

defineObject{
	name = "rc_stone_floor_shaft_real",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_floor_shaft.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	replacesFloor = true,
	placement = "floor",
	automapIcon = 108,
}

defineObject{
	name = "rc_stone_floor_trap_door",
	baseObject = "base_pit_trapdoor",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_floor_trap_door.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				open = "mod_assets/fire_cave/animations/rc_stone_floor_trap_door_open.fbx",
				close = "mod_assets/fire_cave/animations/rc_stone_floor_trap_door_close.fbx",
			},
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		},
	},
	tags = {  },
}

defineObject{
	name = "rc_stone_stairs_up",
	baseObject = "base_stairs_up",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_stairs_up.fbx",
			staticShadow = true,
		},
		{
			class = "Null",
			name = "auto_destroy_objects",
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

				-- destroy all pillars and slopes
				for e in self.go.map:entitiesAt(x, y) do				
				spawn("rc_ground_01", level, x, y, math.random(0,3), self.go.elevation)			
				end
				for yy=0,4 do
					for xx=-0,0 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_pillar_02a"  
						    	then
								e:destroy()
								end
							end
						end
					end
				end
				for yy=1,4 do
					for xx=-1,1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_wall_02a"
								or e.name == "rc_wall_02b"								
						    	then
								e:destroy()
								end
							end
						end
					end
				end
			for yy=0,4 do
					for xx=-1,1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_edge_support_01" 
								or e.name == "rc_edge_support_02" 
								or e.name == "rc_edge_support_03"
								or e.name == "rc_edge_support_04"
								or e.name == "rc_edge_support_01b"
								or e.name == "rc_edge_support_02b"
								or e.name == "rc_edge_support_03b"
								or e.name == "rc_edge_support_04b"
								or e.name == "rc_ceiling_01a" 
								or e.name == "rc_ceiling_01b" 
								or e.name == "rc_ceiling_01c"
								or e.name == "rc_ceiling_01d"
								or e.name == "rc_ceiling_01e"
								or e.name == "rc_wall_slope"
						    	then
								e:destroy()
								end
							end
						end
					end
				end
			end
		},
	},
	tags = {  },
}

defineObject{
	name = "rc_stone_stairs_down",
	baseObject = "base_stairs_down",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_stairs_down.fbx",
			staticShadow = true,
		},
		{
			class = "Null",
			name = "auto_destroy_objects",
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

				-- destroy all pillars and slopes
				-- for e in self.go.map:entitiesAt(x, y) do				
				-- spawn("rc_ground_01", level, x, y, math.random(0,3), self.go.elevation)			
				-- end
				for yy=0,3 do
					for xx=-0,0 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_pillar_02a"  
						    	then
								e:destroy()
								end
							end
						end
					end
				end
				for yy=1,3 do
					for xx=-1,1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_wall_02a"
								or e.name == "rc_wall_02b"
								or e.name == "rc_ground_01"
								or e.name == "rc_ground_02"
								or e.name == "rc_ground_01_real"
								or e.name == "rc_ground_02_real"								
						    	then
								e:destroy()
								end
							end
						end
					end
				end
			for yy=0,3 do
					for xx=-1,1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_edge_support_01" 
								or e.name == "rc_edge_support_02" 
								or e.name == "rc_edge_support_03"
								or e.name == "rc_edge_support_04"
								or e.name == "rc_edge_support_01b"
								or e.name == "rc_edge_support_02b"
								or e.name == "rc_edge_support_03b"
								or e.name == "rc_edge_support_04b"
								or e.name == "rc_ground_pebbles_01" 
								or e.name == "rc_ground_pebbles_02"
								or e.name == "rc_ground_pebbles_03"
								or e.name == "rc_ground_pebbles_04"
								or e.name == "rc_ground_tiles_01"	
								or e.name == "rc_ground_tiles_02" 
								or e.name == "rc_ground_tiles_03"
								or e.name == "rc_ground_tiles_04"
								or e.name == "rc_ground_tiles_05"
								or e.name == "rc_ground_tiles_06"
								or e.name == "rc_ground_tiles_07"
								or e.name == "rc_grass_01a"
								or e.name == "rc_grass_01b"
								or e.name == "rc_grass_01c"
						    	then
								e:destroy()
								end
							end
						end
					end
				end
			end
		},
	},
	tags = {  },
}

defineObject{
	name = "rc_lever",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_lever.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "mod_assets/fire_cave/animations/rc_lever_down.fbx",
				deactivate = "mod_assets/fire_cave/animations/rc_lever_up.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0,1.50,0.5),
			size = vec(0.15, 0.9, 0.4),
			maxDistance = 0,
			--debugDraw = true,
		},
		{
			class = "Lever",
			sound = "lever",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = {  },
}

defineObject{
	name = "rc_stone_ground_lever",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_ground_lever.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "mod_assets/fire_cave/animations/rc_stone_ground_lever_activate.fbx",
				deactivate = "mod_assets/fire_cave/animations/rc_stone_ground_lever_deactivate.fbx",
			},
			onAnimationEvent = function(self, event)
				if event == "rc_sgl_activate" then
					self.go.lever_hit1:restart()
				elseif event == "rc_sgl_deactivate" then
					self.go.lever_hit2:restart()
				end
			end,
		},
		{
			class = "Clickable",
			offset = vec(0,0.9,-0.7),
			size = vec(1, 0.6, 0.2),
			maxDistance = 0,
			--debugDraw = true,
		},
		{
			class = "Lever",
			sound = "lever",
			enabled = false,
		},
		{
			class = "Particle",
			name = "lever_hit1",
			offset = vec(-0.158,0.54,-0.7),
			particleSystem = "rc_hit_lever",
		},
		{
			class = "Particle",
			name = "lever_hit2",
			offset = vec(0.155,0.54,-0.7),
			particleSystem = "rc_hit_lever",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = {  },
}

defineAnimationEvent{
		animation = "mod_assets/fire_cave/animations/rc_stone_ground_lever_activate.fbx",
		event = "rc_sgl_activate",
		frame = 19,
}
defineAnimationEvent{
		animation = "mod_assets/fire_cave/animations/rc_stone_ground_lever_deactivate.fbx",
		event = "rc_sgl_deactivate",
		frame = 19,
}


defineObject{
	name = "rc_button",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_button.fbx",
		},
		{
			class = "Animation",
			animations = {
				press = "mod_assets/fire_cave/animations/rc_button_press.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0,1.385,0),
			size = vec(0.25, 0.25, 0.25),
			maxDistance = 0,
			--debugDraw = true,
		},
		{
			class = "Button",
			sound = "button",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = { },
}

defineObject{
	name = "rc_stone_button",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_button.fbx",
		},
		{
			class = "Animation",
			animations = {
				press = "mod_assets/fire_cave/animations/rc_stone_button_press.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0,1.3,0),
			size = vec(0.35, 0.35, 0.35),
			maxDistance = 0,
			--debugDraw = true,
		},
		{
			class = "Button",
			sound = "button",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = { },
}

defineObject{
	name = "rc_secret_button",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_secret_button.fbx",
		},
		{
			class = "Animation",
			animations = {
			press = "assets/animations/env/dungeon_secret_button_large_press.fbx",
						
			},
		},
		{
			class = "Clickable",
			offset = vec(-0.38,1.23,0),
			size = vec(0.25, 0.25, 0.25),
			maxDistance = 0,
			--debugDraw = true,
		},
		{
			class = "Button",
			sound = "button",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = { },
}