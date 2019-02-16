defineObject{
	name = "tomb_floor_01",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_floor_01.fbx",
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
	name = "tomb_floor_02",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_floor_02.fbx",
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
	name = "tomb_wall_01",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_02",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_02.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_03",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_03.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_04",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_04.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_ornament",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_ornament.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_pillar",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_pillar_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_ceiling_01",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_ceiling_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/catacomb_ceiling_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_alcove",
	baseObject = "base_alcove",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_alcove.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "tomb_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_pressure_plate.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/tomb_pressure_plate_down.fbx",
				deactivate = "assets/animations/env/tomb_pressure_plate_up.fbx",	
			},
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		},
	},
}

defineObject{
	name = "tomb_secret_button_small",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_secret_button_small.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/tomb_secret_button_small_press.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(-0.36, 1.31, 0),
			size = vec(0.15, 0.15, 0.15),
			--debugDraw = true,
		},
	},
	replacesWall = true,
}

defineObject{
	name = "tomb_secret_door",
	baseObject = "base_secret_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_secret_door.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "tomb_pit",
	baseObject = "base_pit",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		},
	},
}

defineObject{
	name = "tomb_pit_trapdoor",
	baseObject = "base_pit_trapdoor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "trapDoorModel",
			model = "assets/models/env/tomb_pit_trapdoor.fbx",
		},
		{
			class = "Animation",
			model = "trapDoorModel",
			animations = {
				open = "assets/animations/env/tomb_pit_trapdoor_open.fbx",
				close = "assets/animations/env/tomb_pit_trapdoor_close.fbx",
			},
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		},
	},
}

defineObject{
	name = "tomb_ceiling_shaft",
	baseObject = "base_ceiling_shaft",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_ceiling_pit.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_door_portcullis",
	baseObject = "base_door_sparse",
	components = {
		{
			class = "Model",
			model = "assets/models/env/door_portcullis.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/tomb_door_frame.fbx",
		},
	},
}

defineObject{
	name = "tomb_stairs_down",
	baseObject = "base_stairs_down",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_stairs_down.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "tomb_stairs_up",
	baseObject = "base_stairs_up",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_stairs_up.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "tomb_wall_text",
	baseObject = "base_wall_text",
	components = {
		{
			class = "WallText",
			height = 0.435,
		},
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_text_short.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
}

defineObject{
	name = "tomb_wall_text_long",
	baseObject = "base_wall_text",
	components = {
		{
			class = "WallText",
			height = 0.435,
		},
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_text_long.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
}

defineObject{
	name = "tomb_door_stone",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/door_stone.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/tomb_door_frame.fbx",
		},
	},
}

defineObject{
	name = "tomb_iron_gate",
	baseObject = "tomb_door_portcullis",
	components = {
		{
			class = "Model",
			model = "assets/models/env/door_metal_2.fbx",
		},
		{
			class = "Door",
			doubleDoor = true,
			killPillars = true,
			openVelocity = 1.1,
			closeVelocity = -1.1,
			closeAcceleration = 0,
		},
	},
}

defineObject{
	name = "tomb_door_serpent",
	baseObject = "tomb_door_portcullis",
	components = {
		{
			class = "Model",
			model = "assets/models/env/door_serpent.fbx",
		},
		{
			class = "Door",
			doubleDoor = true,
			killPillars = true,
			openVelocity = 1.1,
			closeVelocity = -1.1,
			closeAcceleration = 0,
		},
	},
}

defineObject{
	name = "sarcophagus",
	baseObject = "base_altar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/sarcophagus.fbx",
			staticShadow = true,
		},
		{
			class = "Obstacle",
		},
		{
			class = "Surface",
			offset = vec(0.08, 0.84, 0),
			size = vec(0.7, 1),
			--debugDraw = true,
		},
	},
	placement = "floor",
	automapIcon = 152,
	editorIcon = 52,
}

defineObject{
	name = "tomb_wall_sarcophagus",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/sarcophagus_wall_closed.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_sarcophagus_empty",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/sarcophagus_wall_empty.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_sarcophagus_mummy",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/sarcophagus_wall_mummy.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_face",
	baseObject = "base_wall",
	components = {
		class = "Model",
		model = "assets/models/env/tomb_wall_face.fbx",
		staticShadow = true,
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "snake_statue",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/snake_statue.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "snake_statue_3",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/env/snake_statue_3.fbx",
			staticShadow = true,
			rotation = vec(-90,0,0),
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "snake_pillar",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/snake_pillar.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "gold_mask_statue_wall",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/gold_mask_statue_wall.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "gold_mask_statue_floor",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/gold_mask_statue_floor.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_torch_holder",
	baseObject = "torch_holder",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_torch_holder.fbx",
			staticShadow = true,
		}
	},
}

defineObject{
	name = "tomb_wall_lever",
	baseObject = "lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_lever.fbx",
			offset = vec(0, 1.375, 0),
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/tomb_wall_lever_down.fbx",
				deactivate = "assets/animations/env/tomb_wall_lever_up.fbx",
			}
		},
	},
}

defineObject{
	name = "tomb_floor_dirt",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_floor_dirt.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_grating",
	baseObject = "base_wall_grating",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_grating.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "tomb_ceiling_lamp",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_ceiling_light.fbx",
		},
		{
			class = "Light",
			type = "spot",
			spotAngle = 50,
			spotSharpness = 0.1,
			offset = vec(0, 8, 0),
			rotation = vec(-90, 0, 0),
			range = 15,
			color = vec(1, 1, 1.25),
			brightness = 30,
			castShadow = true,
			shadowMapSize = 128,
			staticShadows = true,
		},
		{
			class = "Light",
			name = "bounceLight",
			offset = vec(0, 0.5, 0),
			range = 10,
			color = vec(1, 1, 1),
			brightness = 1,
		},
		{
			class = "Particle",
			particleSystem = "prison_ceiling_lamp",
			offset = vec(0, 4, 0),
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.light:enable()
				self.go.light:fadeIn(0.1)
				self.go.bounceLight:enable()
				self.go.bounceLight:fadeIn(0.1)
				self.go.particle:enable()
				self.go.model:enable()
			end,
			onDeactivate = function(self)
				self.go.light:fadeOut(0.5)
				self.go.bounceLight:fadeOut(0.5)
				self.go.particle:disable()
				self.go.model:disable()
			end,
			onToggle = function(self)
				if self.go.light:isEnabled() then
					self.go.light:fadeOut(0.5)
					self.go.bounceLight:fadeOut(0.5)
					self.go.particle:disable()
					self.go.model:disable()
				else
					self.go.light:enable()
					self.go.light:fadeIn(0.1)
					self.go.bounceLight:enable()
					self.go.bounceLight:fadeIn(0.1)
					self.go.particle:enable()
					self.go.model:enable()
				end
			end,
		},
	},
	placement = "floor",
	editorIcon = 88,
}

defineObject{
	name = "tomb_wall_lantern",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_lantern.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.55, -0.12),
			range = 10,
			color = vec(0.25, 0.6, 0.5),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			onInit = function(self)
				-- optimization: disable casting light behind the wall
				local face
				if self.go.facing == 2 then
					-- disable -Z
					face = 5
				elseif self.go.facing == 3 then
					-- disable -X
					face = 1
				elseif self.go.facing == 0 then
					-- disable +Z
					face = 4
				elseif self.go.facing == 1 then
					-- disable +X
					face = 0
				end
				self:setClipDistance(face, 0)
			end,
		},
		{
			class = "Particle",
			particleSystem = "tomb_wall_lantern",
			offset = vec(0, 1.55, -0.12),
		},
	},
	placement = "wall",
	editorIcon = 88,
}

defineObject{
	name = "tomb_wall_painting_1",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_painting_1.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_painting_2",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_painting_2.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_painting_3",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_painting_3.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_painting_4",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_painting_4.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "tomb_wall_spiketrap",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_spiketrap.fbx",
		}
	},
}

defineObject{
	name = "lock_gold_mask_statue",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_lock.fbx",
			offset = vec(0, 1.0, 0.7),
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.0, 0.65),
			size = vec(0.4, 0.4, 0.4),
			--debugDraw = true,
		},
	},
}

defineObject{
	name = "tomb_pyramid_top",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_pyramid_top.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 256,
	minimalSaveState = true,
}

defineObject{
	name = "tomb_pyramid_side",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_pyramid_side.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 256,
	minimalSaveState = true,
}

defineObject{
	name = "tomb_inside_top_ceiling",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_inside_top_ceiling.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 256,
	minimalSaveState = true,
}

defineObject{
	name = "lock_tomb",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_wall_lock.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.375, 0),
			size = vec(0.4, 0.4, 0.4),
			--debugDraw = true,
		},
		{
			class = "Lock",
			sound = "key_lock",
		},
	},
	placement = "wall",
	editorIcon = 20,
}

