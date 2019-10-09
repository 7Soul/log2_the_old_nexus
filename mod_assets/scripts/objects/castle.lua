defineObject{
	name = "castle_floor_01",
	baseObject = "base_floor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_floor_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_floor_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

for i=1,3 do
	defineObject{
		name = string.format("castle_wall_%02d", i),
		baseObject = "base_wall",
		components = {
			{
				class = "Model",
				model = string.format("assets/models/env/castle_wall_%02d.fbx", i),
				staticShadow = true,
			},
			{
			class = "Occluder",
			model = "assets/models/env/castle_wall_01_occluder.fbx",
			},
		},
		minimalSaveState = true,
	}
end

defineObject{
	name = "castle_wall_tall_01",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_tall_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/castle_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_wall_bookshelf_01",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_bookself_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/castle_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
	replacesWall = true,
}

defineObject{
	name = "castle_wall_bookshelf_02",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_bookself_02.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/castle_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
	replacesWall = true,
}

defineObject{
	name = "castle_ceiling_light",
	components = {
		{
			class = "Light",
			type = "spot",
			spotAngle = 90,
			rotation = vec(-90, 0, 0),
			spotSharpness = 0.7,
			offset = vec(0, 4.5, 0),
			range = 20,
			--color = vec(0.45, 0.8, 1.55),
			color = math.saturation(vec(0.47, 1.0, 2.5), 0.9),
			brightness = 6,
			castShadow = true,
			shadowMapSize = 1024,
			--debugDraw = true,
		},
		{
			class = "Light",
			name = "pointlight",
			type = "point",
			offset = vec(0, 4.5, 0),
			range = 6,
			--color = vec(0.45, 0.8, 1.55),
			color = math.saturation(vec(0.47, 1.0, 2.5), 0.9),
			brightness = 3,
		},
		
		{
			class = "Particle",
			particleSystem = "castle_ceiling_light",
			offset = vec(0, 4.75, 0),
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
	name = "castle_pillar_01",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_pillar_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_pillar_tall_01",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_pillar_tall_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_ceiling_01",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_ceiling_01.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_ceiling_1111_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_ceiling",
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
for i=1,16 do
	local postfix = bit.tobinary(i, 4)
	defineObject{
		name = "castle_ceiling_"..postfix,
		baseObject = "base_ceiling",
		components = {
			{
				class = "Model",
				model = string.format("assets/models/env/castle_ceiling_%s.fbx", postfix),
				staticShadow = true,
			},
			{
				class = "Occluder",
				model = string.format("assets/models/env/castle_ceiling_%s_occluder.fbx", postfix),
			},
		},
		minimalSaveState = true,
	}
end

defineObject{
	name = "castle_ceiling_tall_01",
	baseObject = "base_ceiling",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_ceiling_01.fbx",
			offset = vec(0, 10, 0),
			staticShadow = true,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_ceiling_strut",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_ceiling_strut.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_wall_arch",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_arch.fbx",
			staticShadow = true,
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_door_wood",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_door_wood.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/castle_door_frame.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			openVelocity = 1.3,
			closeVelocity = 0,
			closeAcceleration = -10,
			--sparse = true,
			killPillars = true,
			pullchainObject = "castle_door_button",
			hitSound = "impact_blunt",
		},
	},
}

defineObject{
	name = "castle_door_portcullis",
	baseObject = "base_door_sparse",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_door_porticullis.fbx",
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/castle_door_frame.fbx",
			staticShadow = true,
		},
		{
			class = "Door",
			openVelocity = 1.3,
			closeVelocity = 0,
			closeAcceleration = -10,
			sparse = true,
			killPillars = true,
			pullchainObject = "castle_door_button",
		},
	},
}

defineObject{
	name = "castle_wall_grating",
	baseObject = "base_wall_grating",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_grating.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/castle_door_frame.fbx",
		},
	},
}

defineObject{
	name = "castle_secret_door",
	baseObject = "base_secret_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_secret_door.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "castle_tall_wall_corridor_end",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_tall_wall_corridor_end_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_pillar_candle_holder",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_pillar_candle_holder.fbx",
			offset = vec(0, -0.1, 0),
			staticShadow = true,
		},
		
		{
			class = "Particle",
			particleSystem = "castle_pillar_candles",
			offset = vec(0, 2.5, -0.6),
		},
		{
			class = "Light",
			range = 3.5,
			color = vec(1.1, 0.68, 0.35),
			brightness = 7,
			--castShadow = false,
			staticShadows = true,
			shadowMapSize = 256,
			fillLight = true,
			offset = vec(0, 2.6, -0.6),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
	},
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "castle_torch_holder",
	baseObject = "torch_holder",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_torch_holder.fbx",
			offset = vec(0, 0, 0.03),
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0.0, 1.4, 0.0),
			size = vec(0.35, 0.6, 0.15),
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(0.05, 1.53, -0.1),
			rotation = vec(0, -30, -90),
			onAcceptItem = function(self, item)
				return (item.go.name == "torch" or item.go.name == "torch_everburning") and self:count() == 0
			end,
			--debugDraw = true,
		},
		{
			class = "Particle",
			particleSystem = "torch",
			offset = vec(-0.015, 1.82, -0.3),
		},
	},
	placement = "wall",
	editorIcon = 84,
}

defineObject{
	name = "castle_pit",
	baseObject = "base_pit",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/dungeon_pit_occluder.fbx",
		},
	},
}

defineObject{
	name = "castle_pit_trapdoor",
	baseObject = "base_pit_trapdoor",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_pit.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "trapDoorModel",
			model = "assets/models/env/castle_pit_doors.fbx",
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
	name = "castle_pressure_plate",
	baseObject = "base_pressure_plate",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_pressure_plate.fbx",
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
	name = "castle_wall_lever",
	baseObject = "lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_lever.fbx",
			offset = vec(0, 1.375, 0.09),
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/castle_wall_lever_down.fbx",
				deactivate = "assets/animations/env/castle_wall_lever_up.fbx",
			}
		},
	},
}

defineObject{
	name = "castle_ceiling_shaft",
	baseObject = "base_ceiling_shaft",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_ceiling_shaft_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_ceiling_shaft_0000",
	baseObject = "base_ceiling_shaft",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_ceiling_shaft_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_wall_grating_ornament",
	baseObject = "base_wall_grating",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_grating_ornament.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "beacon_fire",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/elemental_holder_fire.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.2, -1.1),
			range = 6,
			color = vec(1, 0.4, 0.1),
			brightness = 10,
			castShadow = false,
			staticShadows = false,
			fadeOut = 0,
			onUpdate = function(self)
				local socket = self.go.socket
				if socket:count() > 0 then
					local it = socket:getItem()
					if it.go.name == "essence_fire" then
						it.go:setWorldPositionY(0.85 + math.sin(Time.currentTime()) * 0.05)
					elseif it:hasTrait("essence") then
						it.go:setWorldPositionY(0.75)
					end
				end
			end,
		},
		{
			class = "Sound",
			sound = "essence_ambient",
			fadeOut = 0,
		},
		{
			class = "Clickable",
			offset = vec(0.0, 1.1, -1.1),
			size = vec(0.6, 0.6, 0.1),
			maxDistance = 1,
			frontFacing = true,
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(0, 0.85, -1.1),
			onAcceptItem = function(self, item)
				return self:count() == 0
			end,
			onInsertItem = function(self, item)
				if item.go.name == "essence_fire" then
					self.go.light:fadeIn(1)
					self.go.sound:fadeIn(1)
				end
			end,
			onRemoveItem = function(self, item)
				if item.go.name == "essence_fire" then
					self.go.light:fadeOut(1)
					self.go.sound:fadeOut(1)
				end
			end,
			--debugDraw = true,
		},
	},
	--placement = "wall",
	--editorIcon = 88,
}

defineObject{
	name = "beacon_air",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/elemental_holder_air.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.2, -1.1),
			range = 6,
			color = vec(0.4, 0.5, 1),
			brightness = 8,
			castShadow = false,
			staticShadows = false,
			fadeOut = 0,
			onUpdate = function(self)
				local socket = self.go.socket
				if socket:count() > 0 then
					local it = socket:getItem()
					if it.go.name == "essence_air" then
						it.go:setWorldPositionY(0.85 + math.sin(Time.currentTime()) * 0.05)
					elseif it:hasTrait("essence") then
						it.go:setWorldPositionY(0.75)
					end
				end
			end,
		},
		{
			class = "Sound",
			sound = "essence_ambient",
			fadeOut = 0,
		},
		{
			class = "Clickable",
			offset = vec(0.0, 1.1, -1.1),
			size = vec(0.6, 0.6, 0.1),
			maxDistance = 1,
			frontFacing = true,
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(0, 0.85, -1.1),
			onAcceptItem = function(self, item)
				return self:count() == 0
			end,
			onInsertItem = function(self, item)
				if item.go.name == "essence_air" then
					self.go.light:fadeIn(1)
					self.go.sound:fadeIn(1)
				end
			end,
			onRemoveItem = function(self, item)
				if item.go.name == "essence_air" then
					self.go.light:fadeOut(1)
					self.go.sound:fadeOut(1)
				end
			end,
			--debugDraw = true,
		},
	},
	--placement = "wall",
	--editorIcon = 88,
}

defineObject{
	name = "beacon_earth",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/elemental_holder_earth.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.2, -1.1),
			range = 6,
			color = vec(0.35, 0.45, 0.1),
			brightness = 10,
			castShadow = false,
			staticShadows = false,
			fadeOut = 0,
			onUpdate = function(self)
				local socket = self.go.socket
				if socket:count() > 0 then
					local it = socket:getItem()
					if it.go.name == "essence_earth" then
						it.go:setWorldPositionY(0.85 + math.sin(Time.currentTime()) * 0.05)
					elseif it:hasTrait("essence") then
						it.go:setWorldPositionY(0.75)
					end
				end
			end,
		},
		{
			class = "Sound",
			sound = "essence_ambient",
			fadeOut = 0,
		},
		{
			class = "Clickable",
			offset = vec(0.0, 1.1, -1.1),
			size = vec(0.6, 0.6, 0.1),
			maxDistance = 1,
			frontFacing = true,
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(0, 0.85, -1.1),
			onAcceptItem = function(self, item)
				return self:count() == 0
			end,
			onInsertItem = function(self, item)
				if item.go.name == "essence_earth" then
					self.go.light:fadeIn(1)
					self.go.sound:fadeIn(1)
				end
			end,
			onRemoveItem = function(self, item)
				if item.go.name == "essence_earth" then
					self.go.light:fadeOut(1)
					self.go.sound:fadeOut(1)
				end
			end,
			--debugDraw = true,
		},
	},
	--placement = "wall",
	--editorIcon = 88,
}

defineObject{
	name = "beacon_water",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/elemental_holder_water.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.2, -1.1),
			range = 6,
			color = vec(0.0, 0.1, 1),
			brightness = 8,
			castShadow = false,
			staticShadows = false,
			fadeOut = 0,
			onUpdate = function(self)
				local socket = self.go.socket
				if socket:count() > 0 then
					local it = socket:getItem()
					if it.go.name == "essence_water" then
						it.go:setWorldPositionY(0.85 + math.sin(Time.currentTime()) * 0.05)
					elseif it:hasTrait("essence") then
						it.go:setWorldPositionY(0.75)
					end
				end
			end,
		},
		{
			class = "Sound",
			sound = "essence_ambient",
			fadeOut = 0,
		},
		{
			class = "Clickable",
			offset = vec(0.0, 1.1, -1.1),
			size = vec(0.6, 0.6, 0.1),
			maxDistance = 1,
			frontFacing = true,
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(0, 0.85, -1.1),
			onAcceptItem = function(self, item)
				return self:count() == 0
			end,
			onInsertItem = function(self, item)
				if item.go.name == "essence_water" then
					self.go.light:fadeIn(1)
					self.go.sound:fadeIn(1)
				end
			end,
			onRemoveItem = function(self, item)
				if item.go.name == "essence_water" then
					self.go.light:fadeOut(1)
					self.go.sound:fadeOut(1)
				end
			end,
			--debugDraw = true,
		},
	},
	--placement = "wall",
	--editorIcon = 88,
}

defineObject{
	name = "beacon_balance",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/elemental_holder_balance.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 1.2, -1.1),
			range = 6,
			color = vec(0.4, 0.5, 1),
			brightness = 8,
			castShadow = false,
			staticShadows = false,
			fadeOut = 0,
			onUpdate = function(self)
				local socket = self.go.socket
				if socket:count() > 0 then
					local it = socket:getItem()
					if it.go.name == "essence_balance" then
						it.go:setWorldPositionY(0.85 + math.sin(Time.currentTime()) * 0.05)
					elseif it:hasTrait("essence") then
						it.go:setWorldPositionY(0.75)
					end
				end
			end,
		},
		-- {
		-- 	class = "Sound",
		-- 	sound = "essence_ambient",
		-- 	fadeOut = 0,
		-- },
		{
			class = "Clickable",
			offset = vec(0.0, 1.1, -1.1),
			size = vec(0.6, 0.6, 0.1),
			maxDistance = 1,
			frontFacing = true,
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(0, 0.85, -1.1),
			onAcceptItem = function(self, item)
				return self:count() == 0
			end,
			onInsertItem = function(self, item)
				if item.go.name == "essence_balance" then
					self.go.light:fadeIn(1)
					--self.go.sound:fadeIn(1)
				end
			end,
			onRemoveItem = function(self, item)
				if item.go.name == "essence_balance" then
					self.go.light:fadeOut(1)
					--self.go.sound:fadeOut(1)
				end
			end,
			--debugDraw = true,
		},
	},
	--placement = "wall",
	--editorIcon = 88,
}

defineObject{
	name = "castle_ceiling_lantern",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_lantern.fbx",
			offset = vec(0, 0.8, 0),
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 3.7, 0),
			range = 8,
			color = vec(1.1, 0.7, 0.4),
			brightness = 7,
			castShadow = true,
			staticShadows = true,
		},
		{
			class = "Particle",
			particleSystem = "mine_support_ceiling_lantern",
			offset = vec(0, 3.7, 0),
		},
	},
	placement = "floor",
	editorIcon = 88,
}

defineObject{
	name = "castle_bridge",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_bridge.fbx",
			staticShadow = true,
		},
		{
			class = "Platform",
		},
		{
			class = "Occluder",
			model = "assets/models/env/castle_bridge_occluder.fbx",
		},
	},
	editorIcon = 184,
	automapIcon = 136,
}

defineObject{
	name = "castle_bridge_grating",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_bridge_grating.fbx",
			staticShadow = true,
		},
		{
			class = "Platform",
		},
	},
	editorIcon = 184,
	automapIcon = 136,
}

defineObject{
	name = "castle_pillar_end",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_pillar_end.fbx",
			staticShadow = true,
		},
	},
	placement = "pillar",
	editorIcon = 108,
	minimalSaveState = true,
}

defineObject{
	name = "castle_pillar_light",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_pillar_light.fbx",
			staticShadow = true,
		},
		
		{
			class = "Particle",
			particleSystem = "wizard_lantern",
			offset = vec(0, 1.6, 0),
		},
		{
			class = "Light",
			range = 3.5,
			color = vec(0.5, 1.0, 2.5),
			brightness = 7,
			--castShadow = false,
			staticShadows = true,
			shadowMapSize = 256,
			offset = vec(0, 1.6, 0),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
	},
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "castle_stairs_up",
	baseObject = "base_stairs_up",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_stairs_up.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "castle_stairs_down",
	baseObject = "base_stairs_down",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_stairs_down.fbx",
			staticShadow = true,
		},
	},
}

defineObject{
	name = "castle_alcove",
	baseObject = "base_alcove",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_alcove.fbx",
			staticShadow = true,
		},
		{
			class = "Surface",
			offset = vec(0, 0.82, 0.2),
			size = vec(1.3, 0.65),
			-- debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 0.82+0.4, 0.2),
			size = vec(1.3, 0.8, 0.65),
			-- debugDraw = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/castle_wall_alcove_occluder.fbx",
		},
	},
}

defineObject{
	name = "castle_wall_text",
	baseObject = "base_wall_text",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_text_long.fbx",
			offset = vec(0, 0, -0.1),
		},
		{
			class = "Particle",
			particleSystem = "castle_wall_text",
		},
		{
			class = "Light",
			offset = vec(0, 1.5, -0.2),
			range = 4,
			color = vec(0.5, 1.0, 2.5),
			brightness = 4,
			fillLight = true,
		},
		{
			class = "WallText",
			height = 0.447,
		},
	},
	replacesWall = false,
}

defineObject{
	name = "castle_wall_text_long",
	baseObject = "base_wall_text",
	components = {
				{
			class = "Model",
			model = "assets/models/env/castle_wall_text_huge.fbx",
			offset = vec(0, 0, -0.1),
		},
		
		{
			class = "Particle",
			particleSystem = "castle_wall_text_long",
		},
		{
			class = "Light",
			offset = vec(0, 1.5, -0.2),
			range = 4,
			color = vec(0.5, 1.0, 2.5),
			brightness = 4,
			fillLight = true,
		},
	},
	replacesWall = false,
}

defineObject{
	name = "castle_wall_button",
	baseObject = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_button.fbx",
			offset = vec(0,1.5,0.075),
		},
		--{
		--	class = "Animation",
		--	animations = {
		--		press = "assets/animations/env/beach_rock_wall_button_01_press.fbx",
		--	},
		--},
		{
			class = "Particle",
			particleSystem = "castle_button",
			offset = vec(0, 1.5, 0.1),
		},
		{
			class = "Light",
			offset = vec(0, 1.5, -0.2),
			range = 4,
			color = vec(0.5, 1.0, 2.5),
			brightness = 4,
			fillLight = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.5, -0.05),
			size = vec(0.25, 0.25, 0.25),
			--debugDraw = true,
		},
		{
			class = "Button",
			sound = "castle_button",
		},
	},
	replacesWall = false,
}

defineObject{
	name = "castle_door_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_wall_button.fbx",
			offset = vec(1.5, 1.5, -0.23),
		},
		-- {
		-- 	class = "Animation",
		-- 	animations = {
		-- 		pull = "assets/animations/env/beach_rock_wall_button_01_press.fbx",	-- TODO: animation missing
		-- 	},
		-- },
		{
			class = "Particle",
			particleSystem = "castle_button",
			offset = vec(1.5, 1.5,-0.2),
		},
		{
			class = "Light",
			offset = vec(1.5, 1.5,-0.35),
			range = 4,
			color = vec(0.5, 1.0, 2.5),
			brightness = 4,
			fillLight = true,
		},
		{
			class = "Clickable",
			offset = vec(1.5, 1.5,-0.22),
			size = vec(0.3, 0.25, 0.25),
			onClick = function(self)
				self.go:playSound("castle_button")
			end,
			--debugDraw = true,
		},
		{
			class = "PullChain",
		},
	},
	placement = "wall",
	editorIcon = nil,	-- editor icon not set so that pullchains are not visible in editor
}

defineObject{
	name = "castle_arena_floor",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_arena_floor.fbx",
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
	name = "castle_arena_tower",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_arena_tower.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_arena_merlon",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_arena_merlon.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_arena_merlon_outer_corner",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_arena_merlon_outer_corner.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_arena_merlon_inner_corner",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_arena_merlon_inner_corner.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_arena_stairs_down",
	baseObject = "base_stairs_down",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_arena_stairs_down.fbx",
			staticShadow = true,
		},
		{
			class = "MapGraphics",
			image = "assets/textures/gui/automap/stairs_down.tga",
			rotate = true,
			offset0 = vec(0, -1),
			offset3 = vec(-1, 0),
		},
	},
	automapIcon = -1
}

defineObject{
	name = "castle_wall_outside_01",
	baseObject = "base_wall",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_outside_wall_01.fbx",
			dissolveStart = 6,
			dissolveEnd = 8,
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "assets/models/env/castle_wall_01_occluder.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_gate_outside",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_outside_wall_gate.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_wall_outside_corner_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_outside_wall_corner_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_wall_outside_tall_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_outside_wall_tall_01.fbx",
			staticShadow = true,
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_tower_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_tower_01.fbx",
			castShadow = false,
			staticShadow = true,
		}
	},
	editorIcon = 256,
	minimalSaveState = true,
}

defineObject{
	name = "castle_tower_tall_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_tower_tall_01.fbx",
			castShadow = false,
			staticShadow = true,
		}
	},
	editorIcon = 256,
	minimalSaveState = true,
}

defineObject{
	name = "castle_facade",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_facade.fbx",
			castShadow = false,
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(19, 36.8, 6),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*1.12 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
		{
			name = "light1",
			class = "Light",
			offset = vec(4.32, 32.4, 0.662),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*0.95 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
		{
			name = "light2",
			class = "Light",
			offset = vec(-4.32, 32.4, 0.662),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*1.1 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
		{
			name = "light3",
			class = "Light",
			offset = vec(-10.06, 18.3, 1.159),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*1.2 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
		{
			name = "light4",
			class = "Light",
			offset = vec(-20, 37, 5.19),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*1.06 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
		{
			name = "light5",
			class = "Light",
			offset = vec(-14.39, 23, 5.19),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*1 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
		{
			name = "light6",
			class = "Light",
			offset = vec(23.1, 17.6, 5.19),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*1.03 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
				{
			name = "light7",
			class = "Light",
			offset = vec(10.06, 21.7, -1.4),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*1.05 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
		{
			name = "light8",
			class = "Light",
			offset = vec(-25.6, 35, -9.73),
			range = 10,
			color = vec(1.3, 0.68, 0.35),
			brightness = 2.5,
			castShadow = false,
			fillLight = true,
			onUpdate = function(self)
			local noise = math.noise(Time.currentTime()*0.98 + 123) * 0.5 + 0.9
			self:setBrightness(noise * 10)
			end,
		},
		{
			name = "light9",
			class = "Light",
			offset = vec(-35.6, 3, -5),
			range = 25,
			color = vec(1.3, 0.68, 0.35),
			brightness = 4,
			castShadow = false,
			fillLight = true,
		},
		{
			name = "particle",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(19, 37, 5.2),
		},
		{
			name = "particle1",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(4.32, 32.2, -0.7),
		},
			{
			name = "particle2",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(-4.32, 32.2, -0.7),
			},
			{
			name = "particle3",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(-10.06, 18.1, -1.2),
			},
			{
			name = "particle4",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(-20, 37, 5.19),
			},
			{
			name = "particle5",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(-14.39, 22.75, 5.19),
			},
			{
			name = "particle6",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(23.1, 17.7, 5.19),
			},
			{
			name = "particle7",
			class = "Particle",
			particleSystem = "torch",
			offset = vec(10.06, 21.7, -1.4),
			},
			
	},
	editorIcon = 256,
	minimalSaveState = true,
}

defineObject{
	name = "castle_sidewings_01",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_sidewings.fbx",
			castShadow = false,
		},
	},
	editorIcon = 256,
	minimalSaveState = true,
}

defineObject{
	name = "castle_bridge_outside",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_bridge_outside.fbx",
			staticShadow = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox1",
			size = vec(0.7, 1.5, 0.7),
			offset = vec(-1.5, 0.75, -1.5),
			--debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox2",
			size = vec(0.7, 1.5, 0.7),
			offset = vec(1.5, 0.75, -1.5),
			--debugDraw = true,
		},
	},
	editorIcon = 256,
	minimalSaveState = true,
}

defineObject{
	name = "castle_bridge_outside_middle_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_bridge_outside_middle_01.fbx",
			staticShadow = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox1",
			size = vec(0.7, 4.5, 0.7),
			offset = vec(-1.5, -0.75, 0),
		},
		{
			class = "ItemConstrainBox",
			name = "cbox2",
			size = vec(0.7, 4.5, 0.7),
			offset = vec(1.5, -0.75, 0),
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_bridge_outside_middle_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_bridge_outside_middle_02.fbx",
			staticShadow = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox1",
			size = vec(0.7, 3.5, 0.7),
			offset = vec(-1.5, -1.25, 0),
		},
		{
			class = "ItemConstrainBox",
			name = "cbox2",
			size = vec(0.7, 3.5, 0.7),
			offset = vec(1.5, -1.25, 0),
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "castle_entrance_door",
	baseObject = "base_door",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_entrance_door.fbx",
			staticShadow = true,
		},
		{
			class = "Model",
			name = "frame",
			model = "assets/models/env/castle_entrance_door_frame.fbx",
		},
		{
			class = "Animation",
			animations = {
				hatch = "assets/animations/env/castle_entrance_door.fbx",
			},
		},
		{
			class = "Door",
			openVelocity = 1.3,
			closeVelocity = 0,
			closeAcceleration = -10,
			--sparse = true,
			killPillars = true,
			pullchainObject = "castle_door_button",
		},
	},
}

defineObject{
	name = "castle_outside_stairs_up",
	baseObject = "base_stairs_up",
	components = {
		{
			class = "Model",
			model = "assets/models/env/castle_outside_stairs.fbx",
			staticShadow = true,
		},
	},
}