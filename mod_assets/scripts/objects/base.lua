defineObject{
	name = "base_floor",
	components = {},
	replacesFloor = true,
	killHeightmap = true,
	placement = "floor",
	editorIcon = 100,
}

defineObject{
	name = "base_wall",
	components = {},
	replacesWall = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "base_ceiling",
	components = {},
	replacesCeiling = true,
	placement = "ceiling",
	editorIcon = 100,
}

defineObject{
	name = "base_pillar",
	components = {},
	placement = "pillar",
	editorIcon = 108,
	automapIcon = 92,
}

defineObject{
	name = "base_alcove",
	components = {
		{
			class = "Surface",
			offset = vec(0, 0.85, 0.2),
			size = vec(1.3, 0.65),
			--debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 0.85+0.4, 0.2),
			size = vec(1.3, 0.8, 0.65),
			--debugDraw = true,
		},
	},
	replacesWall = true,
	placement = "wall",
	editorIcon = 8,
}

defineObject{
	name = "base_altar",
	components = {
		{
			class = "Surface",
			offset = vec(0, 0.88, 0),
			size = vec(2.1, 1.2),
			--debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 0.88, 0),
			size = vec(2.1, 0.88*2, 1.2),
			maxDistance = 1,
			--debugDraw = true,
		},
		{
			class = "Obstacle",
		},
		{
			class = "ProjectileCollider",
		},
	},
	placement = "floor",
	editorIcon = 52,
}

defineObject{
	name = "base_pressure_plate",
	components = {
		{
			class = "FloorTrigger",
			activateSound = "pressure_plate_pressed",
			deactivateSound = "pressure_plate_released",
			pressurePlate = true,	-- indicates a real pressure plate (camera is tilted down and items are constrained on the plate)
		},
	},
	replacesFloor = true,
	killHeightmap = true,
	placement = "floor",
	editorIcon = 0,
	automapIcon = 112,
}

defineObject{
	name = "base_wall_decoration",
	components = {},
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "base_floor_decoration",
	components = {},
	placement = "floor",
	editorIcon = 100,
}

defineObject{
	name = "base_pillar_decoration",
	components = {},
	placement = "pillar",
	editorIcon = 120,
}

defineObject{
	name = "base_wall_text",
	components = {
		{
			class = "WallText",
		},
		{
			class = "Clickable",
			offset = vec(0, 1.5, 0),
			size = vec(1.2, 0.8, 0.2),
			frontFacing = true,
			--debugDraw = true,
		},
	},
	placement = "wall",
	replacesWall = true,
	editorIcon = 28,
}

defineObject{
	name = "base_stairs_down",
	components = {
		{
			class = "Stairs",
			direction = "down",
		},
		{
			class = "Obstacle",
			blockMonsters = true,
			blockParty = false,
			blockItems = false,
		},
	},
	placement = "floor",
	killHeightmap = true,
	editorIcon = 48,
	automapIcon = 100,
}

defineObject{
	name = "base_stairs_up",
	components = {
		{
			class = "Stairs",
			direction = "up",
		},
		{
			class = "Obstacle",
			blockMonsters = true,
			blockParty = false,
			blockItems = false,
		},
	},
	placement = "floor",
	killHeightmap = true,
	editorIcon = 44,
	automapIcon = 96,
}

defineObject{
	name = "base_pit",
	components = {
		{
			class = "Pit",
		},
	},
	replacesFloor = true,
	killHeightmap = true,
	placement = "floor",
	editorIcon = 40,
	automapIcon = 108,
}

defineObject{
	name = "base_pit_trapdoor",
	components = {
		{
			class = "Pit",
		},
		{
			class = "Platform",
		},
		{
			class = "Controller",
			onOpen = function(self)
				self.go.pit:open()
			end,
			onClose = function(self)
				self.go.pit:close()
			end,
			onToggle = function(self)
				self.go.pit:toggle()
			end,
		},
	},
	replacesFloor = true,
	killHeightmap = true,
	placement = "floor",
	editorIcon = 40,
	automapIcon = 108,
}

defineObject{
	name = "base_ceiling_shaft",
	components = {},
	replacesCeiling = true,
	placement = "ceiling",
	editorIcon = 104,
}

defineObject{
	name = "base_obstacle",
	components = {
		{
			class = "Obstacle",
			hitSound = "impact_blunt",
		},
		{
			class = "ProjectileCollider",
		},
	},
	placement = "floor",
	editorIcon = 56,
	tags = { "obstacle" },
}

defineObject{
	name = "base_door",
	components = {
		{
			class = "Door",
			openVelocity = 1.3,
			closeVelocity = 0,
			closeAcceleration = -10,
			--sparse = true,
			killPillars = true,
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
			class = "ItemConstrainBox",
			name = "cbox1",
			size = vec(0.7, 3, 0.7),
			offset = vec(-1.5, 1.5, 0),
			--debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			name = "cbox2",
			size = vec(0.7, 3, 0.7),
			offset = vec(1.5, 1.5, 0),
			--debugDraw = true,
		},
	},
	placement = "wall",
	tags = { "door" },
	editorIcon = 124,
	automapIcon = 84,
}

defineObject{
	name = "base_door_sparse",
	baseObject = "base_door",
	components = {
		{
			class = "Door",
			openVelocity = 1.3,
			closeVelocity = 0,
			closeAcceleration = -10,
			sparse = true,
			killPillars = true,
		},
	},
}

defineObject{
	name = "base_double_door",
	baseObject = "base_door",
	components = {
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
	name = "base_double_door_sparse",
	baseObject = "base_door",
	components = {
		{
			class = "Door",
			doubleDoor = true,
			killPillars = true,
			openVelocity = 1.1,
			closeVelocity = -1.1,
			closeAcceleration = -2,
			sparse = true,
		},
	},
}

defineObject{
	name = "base_secret_door",
	baseObject = "base_door",
	components = {
		{
			class = "Door",
			openVelocity = 0.5,
			closeVelocity = -0.5,
			secretDoor = true,
			openSound = "wall_sliding",
			closeSound = "wall_sliding",
			lockSound = "wall_sliding_lock",
		},
	},
	editorIcon = 120,
	automapIcon = -1,
}

defineObject{
	name = "base_wall_grating",
	components = {
		{
			class = "Door",
			openVelocity = 1.3,
			closeVelocity = 0,
			closeAcceleration = -10,
			sparse = true,
		},
	},
	placement = "wall",
	tags = { "door" },
	editorIcon = 124,
	automapIcon = 84,
}

defineObject{
	name = "base_item",
	placement = "floor",
	tags = { "item" },
	editorIcon = 24,
	reflectionMode = "never",
	components = {
		{
			class = "Script",
			name = "data",
			source = [[
				data = {}
				function get(name)
					return self.data[name]
				end
				function set(name,value)
					self.data[name] = value
				end
			]],
		},
	},
}

defineObject{
	name = "base_monster",
	components = {
		{
			class = "Gravity",
		},
	},
	placement = "floor",
	tags = { "monster" },
	editorIcon = 4,
	reflectionMode = "always",
}

defineObject{
	name = "base_monster_group",
	components = {},
	placement = "floor",
	tags = { "monster" },
	editorIcon = 156,
}

defineObject{
	name = "base_spell",
	placement = "floor",
	tags = { "spell" },
	editorIcon = 100,
}
