defineObject{
	name = "beach_ground_01",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_ground_01.fbx",
			staticShadow = true,		
		}
	},
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "beach_rock_wall_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_01.fbx",
			dissolveStart = 5,
			dissolveEnd = 7,
			staticShadow = true,
			rotation = vec(0, 0, -3),
			offset = vec(0,0.01,0),
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_wall_01_occluder.fbx",
		},
	},
	editorIcon = 120,
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "beach_rock_wall_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_02.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_wall_02_occluder.fbx",
		},
	},
	editorIcon = 120,
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "beach_rock_wall_04",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_04.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_wall_04_occluder.fbx",
		},
	},
	editorIcon = 120,
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "beach_rock_pillar_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_pillar_01.fbx",
			dissolveStart = 6,
			dissolveEnd = 9,
			staticShadow = true,
		},
	},
	editorIcon = 108,
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_wall_button_01",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_button_01.fbx",
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/beach_rock_wall_button_01_press.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(-0.06, 1.61, 0.3),
			size = vec(0.25, 0.15, 0.13),
			--debugDraw = true,
		},
	},
	replacesWall = false,
	tags = { "puzzle" },
}

defineObject{
	name = "beach_rock_blocker_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_blocker_01.fbx",
			staticShadow = true,
		},
	},
	automapTile = "rocky_wall",
	minimalSaveState = true,
}

defineObject{
	name = "beach_rock_blocker_02",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_blocker_02.fbx",
			staticShadow = true,
		},
	},
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_cattail_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_cattail_wall.fbx",
			castShadow = false,
			dissolveStart = 7,
			dissolveEnd = 10,
			
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/beach_cattail_wall_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	placement = "wall",
	editorIcon = 244,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "grass_planes_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/grass_planes_01.fbx",
			castShadow = false,
			dissolveStart = 4,
			dissolveEnd = 6,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/grass_planes_01_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	editorIcon = 240,
	reflectionMode = "never",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_statue_01",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_statue_01.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_statue_02",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_statue_02.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_statue_03",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_statue_03.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_door_portcullis",
	baseObject = "base_double_door_sparse",
	components = {	
		{
			class = "Model",
			model = "assets/models/env/beach_gate_portcullis.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/beach_gate.fbx",			
			staticShadow = true,
		},
		-- {
		-- 	class = "Particle",
		-- 	particleSystem = "portcullis",
		-- 	emitterMesh = "assets/models/env/beach_gate_portcullis.fbx",
		-- },	
		{
			class = "Door",
			doubleDoor = true,
			killPillars = true,
			openVelocity = 1.1,
			closeVelocity = -1.1,
			closeAcceleration = -2,
			sparse = true,
			onOpen = function(self)
				-- self.go.particle:stop()
			end,
			onClose = function(self)
				-- self.go.particle:start()
			end,
		},
		{
			class = "Controller",
			onOpen = function(self)
				self.go.door:open()
			end,
			onClose = function(self)
				self.go.door:close()
			end,
			onToggle = function(self)
				self.go.door:toggle()
			end,
		},
		{
			class = "Light",
			range = 0,
			color = vec(1, 1, 1),
			brightness = 0,
			castShadow = false,
			staticShadows = false,
			fadeOut = 0,
			onUpdate = function(self)
				if self.go.door:isOpening() or self.go.door:isClosing() then
					--self.go.particle:restart()
				end
			end,
		},
	},
	tags = { "puzzle" },
}

defineParticleSystem{
	name = "portcullis",
	emitters = {
		-- fog
		{
			emitterShape = "MeshShape",
			emissionRate = 800,
			emissionTime = 0,
			maxParticles = 1000,
			--boxMin = {-1.5,-0.5,-0.15},
			--boxMax = { 1.5, 2.5, 0.0},
			sprayAngle = {0,360},
			--velocity = {0.05, 0.25},
			velocity = {0, 0},
			objectSpace = false,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {1,3},
			color0 = {0.5, 1, 1.5},
			opacity = 0.55,
			fadeIn = 0.2,
			fadeOut = 0.2,
			size = {0.01, 0.3},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.1,
		},
	}
}

defineObject{
	name = "beach_door_wood",
	baseObject = "base_double_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_door_wood.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/beach_gate.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			doubleDoor = true,
			killPillars = true,
			openVelocity = 1.1,
			closeVelocity = -1.1,
			closeAcceleration = 0,
			hitSound = "impact_blunt",
		},
	},
	tags = { "puzzle" },
}

defineObject{
	name = "beach_wall_text",
	baseObject = "base_wall_text",
	components = {
		{
			class = "WallText",
			height = 0.48,
		},
		{
			class = "Model",
			model = "assets/models/env/beach_wall_text.fbx",
			staticShadow = true,
		}
	},
	replacesWall = false,
	tags = { "puzzle" }
}

defineObject{
	name = "beach_secret_door",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_secret_door.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				open = "assets/animations/env/beach_secret_door_open.fbx",
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
	automapTile = "rocky_wall",
	tags = { "puzzle" }
}

defineAnimationEvent{
	animation = "assets/animations/env/beach_secret_door_open.fbx",
	event = "open",
	frame = 35,
}

defineAnimationEvent{
	animation = "assets/animations/env/beach_secret_door_open.fbx",
	event = "lock",
	normalizedTime = 1,
}

defineObject{
	name = "beach_rock_arch",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_arch_01.fbx",
			dissolveStart = 7,
			dissolveEnd = 10,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_arch_01_occluder.fbx",
		},
	},
	editorIcon = 236,
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_spire",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_spire_01.fbx",
			staticShadow = true,
			dissolveStart = 5,
			dissolveEnd = 8,
		}
	},
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_spire_pillar",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_spire_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_2x1",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_2x1_01.fbx",
			dissolveStart = 6,
			dissolveEnd = 9,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_2x1_01_occluder.fbx",
		},
	},
	editorIcon = 236,
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_3x1",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_3x1_01.fbx",
			dissolveStart = 4,
			dissolveEnd = 7,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_3x1_01_occluder.fbx",
		},
	},
	editorIcon = 236,
	minimalSaveState = true,
	reflectionMode = "aways",
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_3x2",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_rock_3x2_01.fbx",
			staticShadow = true,
			offset = vec(0.75,0,0),
		},
		{
			class = "Occluder",
			model = "assets/models/env/forest_rock_3x2_01_occluder.fbx",
		},
	},
	editorIcon = 236,
	--automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_outside_wall_low",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_outside_wall_low.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 236,
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_outside_wall_high",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_outside_wall_high.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 236,
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_1x1",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_1x1_01.fbx",
			staticShadow = true,
		}
	},
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_1x1_low",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_03.fbx",
			staticShadow = true,
		},
	},
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_boulder",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_boulder_01.fbx",
			staticShadow = true,
		}
	},
	automapTile = "rocky_wall",
	minimalSaveState = true,
	tags = { "level_design" },
}

defineObject{
	name = "beach_rock_arch_small",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_arch_small.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/beach_rock_arch_small_occluder.fbx",
		},
	},
	editorIcon = 236,
	automapTile = "rocky_wall",
	minimalSaveState = true,	
	tags = { "level_design" },
}

defineObject{
    name = "turtle_nest",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/turtle_nest.fbx",
			offset = vec(0,0.01,0),
		}
	},
	minimalSaveState = true,	
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_puzzle_statue",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_pillar_03.fbx",
			offset = vec(0, -1, 0),
			staticShadow = true,
			--debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.45, -0.4),
			size = vec(0.6, 0.2, 0.2),
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(-0.1, 1.37, -0.37),
			rotation = vec(0, 0, -3),
			onAcceptItem = function(self, item)
				if item.go.name ~= "rapier" then
					hudPrint("The item does not fit well into the statue's hands.")
					return false
				else
					playSound("key_lock")
					return true
				end
			end,
			--debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			offset = vec(0, 1.5, 0),
			size = vec(0.9, 3, 0.9),
			debugDraw = true,
		},
		{
			class = "ProjectileCollider",
			size = vec(1.1, 3, 0.8),
			--debugDraw = true,
		},
	},
	placement = "wall",
	tags = { "puzzle" }
}

defineObject{
	name = "beach_lock_gold",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock_golden.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
		{
			name = "stand",
			class = "Model",
			model = "assets/models/env/beach_lock_support.fbx",
			staticShadow = true,
		}
	},
	tags = { "puzzle" }
}

defineObject{
	name = "beach_lock_round",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock_round.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
		{
			name = "stand",
			class = "Model",
			model = "assets/models/env/beach_lock_support.fbx",
			staticShadow = true,
		}
	},
	tags = { "puzzle" }
}

defineObject{
	name = "beach_lock_ornate",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock_ornament.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
		{
			name = "stand",
			class = "Model",
			model = "assets/models/env/beach_lock_support.fbx",
			staticShadow = true,
		},
		{
			class = "Script",
			name = "data",
			source = [[data = { ["amateria"] = true }
function get(name)	return self.data[name] end
function set(name,value)	self.data[name] = value end]],
			onInit = function(self)
				if self.get("amateria") then
					local particles = self.go:createComponent("Particle", "amateria")
					particles:setParticleSystem("amateria")
					particles:setEmitterMesh( self.go.stand:getModel() )

					local broken_model = self.go:createComponent("Model", "broken_model")
					broken_model:setModel( self.go.stand:getModel() )
					broken_model:setStaticShadow( self.go.stand:getStaticShadow() )
					local broken_lock = self.go:createComponent("Model", "broken_lock")
					broken_lock:setModel( self.go.model:getModel() )
					broken_lock:setStaticShadow( self.go.stand:getStaticShadow() )

					broken_model:setOffset( self.go.stand:getOffset() + vec(0.12,-0.64,0.32)  )
					broken_model:setRotationAngles( 16, 25, 9 )
					broken_lock:setOffset( self.go.stand:getOffset() + vec(0.12,-0.64,0.32)  )
					broken_lock:setRotationAngles( 16, 25, 9 )
					self.go.stand:setMaterial( "beach_lock_support_amateria" )
					-- self.go.model:setMaterial( "ornament_lock_amateria" )
					self.go.stand:setEmissiveColor( vec(-0.4,-0.4,-0.4) )
					-- self.go.model:setEmissiveColor( vec(-0.4,-0.4,-0.4) )
					-- self.go.stand:setOffset( vec(0,10,0) )
					-- self.go.model:setOffset( vec(0,10,0) )
				end
			end,
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "beach_wall_button",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_button.fbx",
			offset = vec(0,1.375,0),
		},
		{
			name = "stand",
			class = "Model",
			model = "assets/models/env/beach_lock_support.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/beach_button_press.fbx",
			}
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "beach_lever",
	baseObject = "lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_lever.fbx",
			offset = vec(0,1.375,0),
		},
		{
			class = "Model",
			name = "stand",
			model = "assets/models/env/beach_lock_support.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/beach_lever_down.fbx",
				deactivate = "assets/animations/env/beach_lever_up.fbx",
			}
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "beach_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_pressure_plate.fbx",
			materialOverrides = { ["forest_ground_01"] = "beach_ground_01" },
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/forest_pressure_plate_down.fbx",
				deactivate = "assets/animations/env/forest_pressure_plate_up.fbx",
			},
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "beach_grass_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_pressure_plate.fbx",
			materialOverrides = { ["forest_ground_01"] = "beach_ground_grass_01" },
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/forest_pressure_plate_down.fbx",
				deactivate = "assets/animations/env/forest_pressure_plate_up.fbx",
			},
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "pressure_plate_grass",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/pressure_plate_grass.fbx",
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/pressure_plate_grass.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 5,
		},
	},
	minimalSaveState = true,
	tags = { "puzzle" }
}

defineObject{
	name = "beach_crab",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_crab.fbx",
			dissolveStart = 6,
			dissolveEnd = 8,
		},
		{
			class = "TinyCritterController",
			speed = 1.0,
			fleeSpeed = 2.0;
			strafing = true,
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/env/beach_crab_idle.fbx",
				moveForward = "assets/animations/env/beach_crab_walk.fbx",
				strafeLeft = "assets/animations/env/beach_crab_walk_left.fbx",
				strafeRight = "assets/animations/env/beach_crab_walk_right.fbx",
			},
			playOnInit = "idle",
			loop = true,
		},
	},
	placement = "floor",
	editorIcon = 252,
	reflectionMode = "never",
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_master_gate",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_master_gate.fbx",
		},
		{
			class = "Particle",
			particleSystem = "torch",
			offset = vec(2.05, 2.85, -0.3),
		},
		{
			class = "Light",
			range = 6,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 128,
			fillLight = true,
			offset = vec(2, 2.9, -0.45),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			name = "particle_2",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(-2.05, 2.85, -0.3),
		},
		{
			name = "light_2",
			class = "Light",
			range = 6,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 128,
			fillLight = true,
			offset = vec(-2, 2.9, -0.45),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Sound",
			sound = "torch_burning",
		},
		{
			class = "Animation",
			animations = {
				open = "assets/animations/env/beach_master_gate_open.fbx",
			},
			onAnimationEvent = function(self, event)
				if event == "open" then
					self.go.door:disable()
				end
			end,
		},
		{
			class = "Controller",
			onOpen = function(self)
				self.go.animation:play("open")
				self.go:playSound("master_gate_open")
				self:disable()
			end,
		},
	},
	tags = { "puzzle", "level_design" }
}

defineAnimationEvent{
	animation = "assets/animations/env/beach_master_gate_open.fbx",
	event = "open",
	frame = 35,
}

defineObject{
	name = "beach_shipwreck",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_shipwreck.fbx",
			staticShadow = true,
		},
	},
	editorIcon = 56,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_shipwreck_land_hull",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/shipwreck_land_hull.fbx",
			staticShadow = true, 
		},
		{
			class = "MapGraphics",
			image = "assets/textures/gui/automap/shipwreck_land_hull.tga",
			rotate = true,
			offset0 = vec(-1, -1),
			offset1 = vec(0, 0),
			offset2 = vec(-2, -1),
			offset3 = vec(-1, -2),
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/shipwrek_land_hull_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 10,
		},
	},
	editorIcon = 56,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_shipwreck_land_mast",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/shipwreck_land_mast.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				sway = "assets/animations/env/shipwrek_land_mast_idle.fbx",
			},
			playOnInit = "sway",
			loop = true,
			maxUpdateDistance = 10,
		},
	},
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_shipwreck_land_parts",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/shipwreck_land_parts.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_rock_shore",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_shore.fbx",
			staticShadow = true,
			rotation = vec(0,45,0),
			offset = vec(0,-1,0),
		},
	},
	editorIcon = 56,
	placement = "floor",
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_rock_border",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_border.fbx",
			staticShadow = true,
		},
	},
	placement = "wall",
	editorIcon = 160,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_seaweed_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_seaweed_01.fbx",
		},
	},
	placement = "wall",
	editorIcon = 120,
	minimalSaveState = true,	
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_stone_ring",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_stonering.fbx",
			staticShadow = true,
		},
	},
	--editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "beach_sandpile",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_sandpile.fbx",
			dissolveStart = 4,
			dissolveEnd = 6,
			staticShadow = true,
		},
	},
	editorIcon = 56,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "prison_cage",
	components = {
		{
			class = "Model",
			model = "assets/models/env/prison_cage.fbx",
			offset = vec(0, 0.2, 0),
			rotation = vec(4, 0, 0),
			boundBox = { pos = vec(0, 1.5, 0), size = vec(8,3,8) },
			staticShadow = true,
			--debugDraw = true,
		},
		{
			class = "Animation",
			animations = {
				shake = "assets/animations/env/prison_door_shake.fbx",
				open = "assets/animations/env/prison_door_open.fbx",
			},
		},
		{
			class = "MapGraphics",
			image = "assets/textures/gui/automap/prison_cage.tga",
		},
	},
	placement = "floor",
	editorIcon = 56,
}

defineObject{
	name = "prison_cage_door",
	baseObject = "base_door_sparse",
	components = {
		{
			-- collision shape
			class = "Model",
			model = "assets/models/env/castle_door_porticullis.fbx",
			enabled = false,
		},
	},
	automapIcon = -1,
}

defineObject{
	name = "prison_cage_door_breakable",
	baseObject = "base_door_sparse",
	components = {
		{
			-- collision shape
			class = "Model",
			model = "assets/models/env/castle_door_porticullis.fbx",
			enabled = false,
		},
		{
			class = "Door",
			openVelocity = 1.3,
			closeVelocity = 0,
			closeAcceleration = -10,
			sparse = true,
			onAttackedByChampion = function(self, champion, weapon, attack, slot)
				local cage = prison_cage_1
				if weapon then
					if cage then cage.animation:play("open") end
					self.go:playSound("cage_open")
					self.go:destroyDelayed()
					champion:showAttackResult(math.random(5,10), "HitSplash")
				else
					if cage then cage.animation:play("shake") end
					self.go:playSound("cage_rattle")
					champion:showAttackResult(0, "HitSplash")
				end
				return false
			end,
		},
	},
	automapIcon = -1,
}

defineObject{
	name = "beach_ocean",
	components = {
		{
			class = "Model",
			name = "surface",
			model = "assets/models/env/ocean_water.fbx",
			offset = vec(0, -1.2, 0),
			rotation = vec(0, 0, 0),
			renderHack = "ForceZWrite",
			sortOffset = 100000,	-- force water rendering before other transparent surfaces
		},
		{
			class = "Model",
			name = "bottom",
			model = "assets/models/env/water_bottom.fbx",
			offset = vec(0, -2, 0),
			rotation = vec(0, 0, 0),
		},
		{
			class = "WaterSurface",
			reflectionColor = vec(0.77, 0.9, 1.0) * 0.9,
			refractionColor = vec(1,1,1),
		},
	},
	placement = "floor",
	dontAdjustHeight = true,-----
	editorIcon = 264,
	reflectionMode = "never",
}

defineObject{
	name = "beach_rock_1x1_lowest",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_wall_03.fbx",
			offset = vec(-1.3,-0.9,0),
			staticShadow = true,
		},
		{	
			class = "ProjectileCollider",
			--offset = vec(-1.5,-1.0,0),
			size = vec(4,3,3),
		},
	},
	automapTile = false,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_rock_pillar_decoration",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_blocker_01.fbx",
			offset = vec(0.0,-0.6,0.4),
			staticShadow = true,
		},
	},
	automapIcon = 92,
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_rock_floor_decoration",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_rock_blocker_02.fbx",
			offset = vec(-0,-0.7,0),
			staticShadow = true,
		},
	},
	minimalSaveState = true,
	tags = { "level_decoration" },
}

defineObject{
	name = "beach_oar_boat",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/env/wood_boat.fbx",
			offset = vec(0,0.5,0),
			staticShadow = true,
		},
		{
			class = "MapGraphics",
			image = "mod_assets/textures/automap/boat.dds",
			rotate = true,
			offset0 = vec(0, 0),
			offset1 = vec(0, 0),
			offset2 = vec(0, 0),
			offset3 = vec(0, 0),
		},
	},
	editorIcon = 56,
	minimalSaveState = true,
	tags = { "level_decoration" },
}