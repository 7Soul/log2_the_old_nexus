defineObject{
	name = "dungeon_floor_01",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_floor_01.fbx",
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
	name = "dungeon_floor_dirt_01",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_floor_dirt_01.fbx",
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
	name = "dungeon_wall_01",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_01.fbx",
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
	name = "dungeon_wall_02",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_02.fbx",
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
	name = "dungeon_pillar",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pillar.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_pillar_high",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pillar_high.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_pillar_top",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pillar_top.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_ceiling",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_ceiling.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_ceiling_1111_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

-- ceiling edge variations
do
	for i=1,16 do
		local postfix = bit.tobinary(i, 4)
		defineObject{
			name = "dungeon_ceiling_"..postfix,
			baseObject = "base_ceiling",
			components = {
				{
					class = "Model",
					model = string.format("assets/models/env/dungeon_ceiling_%s.fbx", postfix),
					staticShadow = true,
				},
				{
					class = "Occluder",
					model = string.format("assets/models/env/dungeon_ceiling_%s_occluder.fbx", postfix),
				},
			},
			minimalSaveState = true,
		}
	end
end

defineObject{
	name = "dungeon_ceiling_wall",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_ceiling_wall.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_alcove",
	baseObject = "base_alcove",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_alcove.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_alcove_occluder.fbx",
		}
	},
}

defineObject{
	name = "dungeon_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pressure_plate.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/dungeon_pressure_plate_down.fbx",
				deactivate = "assets/animations/env/dungeon_pressure_plate_up.fbx",	
			},
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		}
	},
}

defineObject{
	name = "dungeon_pressure_plate_dirt_floor",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pressure_plate_dirt_floor.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/dungeon_pressure_plate_dirt_floor_down.fbx",
				deactivate = "assets/animations/env/dungeon_pressure_plate_dirt_floor_up.fbx",	
			},
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		}
	},
}

defineObject{
	name = "dungeon_secret_button_small",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_secret_button_small.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/dungeon_secret_button_small_press.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(-0.35, 1.04, 0),
			size = vec(0.13, 0.13, 0.13),
			--debugDraw = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_secret_button_small_occluder.fbx",
		},
	},
	replacesWall = true,
}

defineObject{
	name = "dungeon_secret_button_large",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_secret_button_large.fbx",
			staticShadow = true,
		},
		{
			class = "Animation",
			animations = {
			press = "assets/animations/env/dungeon_secret_button_large_press.fbx",
						
			},
		},
		{
			class = "Clickable",
			offset = vec(-0.405, 1.375, 0),
			size = vec(0.18, 0.18, 0.18),
			--debugDraw = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_secret_button_small_occluder.fbx",
		},
	},
	replacesWall = true,
}

defineObject{
	name = "dungeon_secret_door",
	baseObject = "base_secret_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_secret_door.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "dungeon_pit",
	baseObject = "base_pit",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		},
	},
}

defineObject{
	name = "dungeon_pit_trapdoor",
	baseObject = "base_pit_trapdoor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "trapDoorModel",
			model = "assets/models/env/dungeon_pit_trapdoor.fbx",
			boundBox = { size = vec(3, 2.5, 3) },
		},
		{
			class = "Animation",
			model = "trapDoorModel",
			animations = {
				open = "assets/animations/env/dungeon_pit_trapdoor_open.fbx",
				close = "assets/animations/env/dungeon_pit_trapdoor_close.fbx",
			},
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		},
	},
}

defineObject{
	name = "dungeon_ceiling_shaft",
	baseObject = "base_ceiling_shaft",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_ceiling_shaft.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

-- ceiling edge variations
do
	for i=1,16 do
		local postfix = bit.tobinary(i, 4)
		defineObject{
			name = "dungeon_ceiling_shaft_"..postfix,
			baseObject = "base_ceiling_shaft",
			components = {
				{
					class = "Model",
					model = string.format("assets/models/env/dungeon_ceiling_shaft_%s.fbx", postfix),
					staticShadow = true,
				}
			},
			minimalSaveState = true,
		}
	end
end

defineObject{
	name = "dungeon_door_portcullis",
	baseObject = "base_door_sparse",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_door_porticullis.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/dungeon_door_frame.fbx",
		},
	},
}

defineObject{
	name = "dungeon_door_iron",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_door_iron.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/dungeon_door_frame.fbx",
		},
	},
}

defineObject{
	name = "dungeon_door_iron_barred",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_door_iron_barred.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/dungeon_door_frame.fbx",
		},
	},
}

defineObject{
	name = "dungeon_door_wooden",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_door_wooden.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/dungeon_door_frame.fbx",
		},
		{
			class = "Door",
			openVelocity = 1.3,
			closeVelocity = 0,
			closeAcceleration = -10,
			--sparse = true,
			killPillars = true,
			hitSound = "impact_blunt",
		},
	},
}

defineObject{
	name = "dungeon_door_wooden_double",
	baseObject = "base_double_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_door_wood.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/dungeon_door_frame.fbx",
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
}

defineObject{
	name = "dungeon_wall_grating",
	baseObject = "base_wall_grating",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_grating.fbx",
			staticShadow = true,
		},
	},
	editorIcon = 132,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_stairs_down",
	baseObject = "base_stairs_down",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_stairs_down.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "dungeon_stairs_up",
	baseObject = "base_stairs_up",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_stairs_up.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "dungeon_wall_text",
	baseObject = "base_wall_text",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_text.fbx",
			staticShadow = true,
		},
	},
	replacesWall = false,
}

defineObject{
	name = "dungeon_wall_text_long",
	baseObject = "base_wall_text",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_text_long.fbx",
			staticShadow = true,
		},
	},
	replacesWall = false,
}

defineObject{
	name = "dungeon_door_stone",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/door_stone.fbx",
		},
	},
}

defineObject{
	name = "dungeon_iron_gate",
	baseObject = "base_double_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/door_metal_2.fbx",
		},
	},
}

defineObject{
	name = "dungeon_wall_ivy_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_ivy_01.fbx",
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_ivy_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_ivy_02.fbx",
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_support_ceiling_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_ceiling_01.fbx",
			offset = vec(0, 0.5, 0),
			staticShadow = true,
		}
	},
	editorIcon = 164,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_pillar_lantern_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pillar_lantern_01.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.6, -0.50),
			range = 6,
			color = vec(1.1, 0.65, 0.3),
			brightness = 7,
			castShadow = true,
			staticShadows = true,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 9)
			end,
		},
		{
			class = "Particle",
			particleSystem = "mine_support_lantern",
			offset = vec(0, 1.56, -0.33),
		},
	},
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "dungeon_wall_lantern",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_lantern.fbx",
			offset = vec(0, 1.5 + 0.2, 0 - 0.2),
			staticShadow = true,
		},
		{
			class = "Light",
			range = 12,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			offset = vec(0, 1.5, -0.4),
			--offset = vec(-0.015, 2.05, -0.45),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Particle",
			particleSystem = "dungeon_wall_lantern",
			offset = vec(0, 1.45 + 0.2, -0.085 - 0.2),
		},
	},
	placement = "wall",
	editorIcon = 84,
}

defineObject{
	name = "dungeon_wall_open",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_open.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_drain",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_drain.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		},
	},
	replacesWall = true,
	minimalSaveState = true,
}

defineObject{
	name = "tiny_spider",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tiny_spider.fbx",
			dissolveStart = 5,
			dissolveEnd = 7,
		},
		{
			class = "TinyCritterController",
			speed = 1.3,
			fleeSpeed = 1.5,
			strafing = false,
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/env/tiny_spider_idle.fbx",
				moveForward = "assets/animations/env/tiny_spider_walk.fbx",
			},
			playOnInit = "idle",
			loop = true,
		},
	},
	placement = "floor",
	editorIcon = 252,
	reflectionMode = "never",
}

defineObject{
	name = "tiny_rat",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tiny_rat.fbx",
		},
		{
			class = "TinyCritterController",
			speed = 1.69,
			fleeSpeed = 2.0,
			strafing = false,
		},
		{
			class = "Animation",
			animations = {
				idle = "assets/animations/env/tiny_rat_idle.fbx",
				moveForward = "assets/animations/env/tiny_rat_walk.fbx",
			},
			playOnInit = "idle",
			loop = true,
		},
	},
	placement = "floor",
	editorIcon = 252,
	reflectionMode = "never",
}


defineObject{
	name = "catacomb_alcove_01",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_alcove_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/catacomb_alcove_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "catacomb_alcove_02",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_alcove_02.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/catacomb_alcove_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "catacomb_alcove_03",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_alcove_03.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/catacomb_alcove_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "catacomb_alcove_candle_01",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_alcove_candle_01.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			range = 3.5,
			color = vec(1.1, 0.68, 0.35),
			brightness = 7,
			castShadow = true,
			staticShadows = true,
			staticShadowDistance = 0,
			shadowMapSize = 256,
			fillLight = true,
			offset = vec(-0.3, 2.25, 0.15),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Particle",
			particleSystem = "catacomb_alcove_candles_01",
		},
		{
			class = "Occluder",
			model = "assets/models/env/catacomb_alcove_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "catacomb_alcove_candle_02",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_alcove_candle_02.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			range = 3.5,
			color = vec(1.1, 0.68, 0.35),
			brightness = 7,
			castShadow = true,
			staticShadows = true,
			staticShadowDistance = 0,
			shadowMapSize = 256,
			fillLight = true,
			offset = vec(-0.5, 1.1, 0.3),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Particle",
			particleSystem = "catacomb_alcove_candles_02",
		},
		{
			class = "Occluder",
			model = "assets/models/env/catacomb_alcove_01_occluder.fbx",
		},
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "catacomb_altar_01",
	baseObject = "base_altar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_altar_01.fbx",
			staticShadow = true,
		},
	},
	automapIcon = 152,
}

defineObject{
	name = "catacomb_altar_02",
	baseObject = "base_altar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_altar_02.fbx",
			staticShadow = true,
		},
	},
	automapIcon = 152,
}

defineObject{
	name = "catacomb_altar_candle_01",
	baseObject = "base_altar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_altar_candle_01.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			range = 3.5,
			color = vec(1.1, 0.68, 0.35),
			brightness = 7,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			fillLight = true,
			offset = vec(-0.62, 1.2, -0.4),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		--{
		--	name = "fill_light",
		--	class = "Light",
		--	range = 1.5,
		--	color = vec(1.1, 0.68, 0.35),
		--	brightness = 7,
		--	--castShadow = false,
		--	staticShadows = true,
		--	shadowMapSize = 256,
		--	offset = vec(0.5, 1.1, 0),
		--	onUpdate = function(self)
		--		local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
		--		self:setBrightness(noise * 10)
		--	end,
		--},
	},
	automapIcon = 152,
}

defineObject{
	name = "catacomb_ceiling",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_ceiling.fbx",
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
	name = "catacomb_pillar_lantern_01",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_lantern.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(-0.65, 2.8, -0.67),
			range = 6,
			color = vec(0.25, 0.5, 0.8),
			brightness = 9,
			castShadow = true,
			staticShadows = true,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 9)
			end,
		},
		{
			class = "Particle",
			particleSystem = "tomb_wall_lantern",
			offset = vec(-0.72, 2.85, -0.72),
		},
	},
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "catacomb_ceiling_shaft",
	baseObject = "base_ceiling_shaft",
	components = {
		{
			class = "Model",
			model = "assets/models/env/catacomb_ceiling_shaft.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_chains_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_chains_01.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_chains_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_chains_02.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_chains_hooks_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_chains_hooks_01.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_overlay_grating_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_overlay_grating_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_pillar_chains_01",
	baseObject = "base_pillar_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pillar_chains_01.fbx",
			staticShadow = true,
		}
	},
	placement = "pillar",
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_pillar_chains_02",
	baseObject = "base_pillar_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_pillar_chains_02.fbx",
			staticShadow = true,
		}
	},
	placement = "pillar",
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_broken_01",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_broken_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		}
	},
	editorIcon = 92,
	replacesWall = true,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_broken_02",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_broken_02.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_01_occluder.fbx",
		}
	},
	editorIcon = 92,
	replacesWall = true,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_wall_height_difference",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_wall_height_difference.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_wall_height_difference_occluder.fbx",
		}
	},
	replacesWall = true,
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_fire_pit",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_fire_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, -1, 0),
			range = 6,
			color = vec(1.3, 0.3, 0.1),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 15)
			end,
		},
		{
			class = "Particle",
			particleSystem = "dungeon_fire_pit",
			offset = vec(0, 0, 0),
		},
		{
			class = "Sound",
			sound = "fire_pit",
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		}
	},
	editorIcon = 136,
	replacesFloor = true,
}

defineObject{
	name = "ceiling_roots_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_ceiling_roots_01.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_cave_in",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_cave_in.fbx",
			staticShadow = true,
		},
	},
	editorIcon = 144,
	automapTile = "rocky_wall",
	minimalSaveState = true,
}

defineObject{
	name = "dungeon_cave_in_small",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/env/dungeon_cave_in_small.fbx",
			staticShadow = true,
			offset = vec(0,-0.86,0),
		},
	},
	editorIcon = 144,
	automapTile = "rocky_wall",
	minimalSaveState = true,
}