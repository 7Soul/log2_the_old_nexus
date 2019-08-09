-- Doors --
-- Doors - Doorways --
defineObject{
	name = "rc_doorway_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_doorway_01.fbx",
			offset = vec(0, 0, 0),
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "mod_assets/fire_cave/models/env/rc_doorway_02_occluder.fbx",
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_doorway_01_1x3",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			name = "hallway",
			model = "mod_assets/fire_cave/models/env/rc_doorway_01_1x3.fbx",
			offset = vec(0, 0, 0),
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "mod_assets/fire_cave/models/env/rc_doorway_01_1x3_occluder.fbx",
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

				for yy=-1,2 do
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
			end,
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_doorway_02",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_doorway_02.fbx",
			offset = vec(0, 0, 0),
			staticShadow = true,
		},
		{
			class = "Occluder",
			model = "mod_assets/fire_cave/models/env/rc_doorway_02_occluder.fbx",
		},
	},
	minimalSaveState = true,
	tags = { "red cave", "vanblam" },
}

defineObject{
	name = "rc_stone_door_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_stone_door_01.fbx",
			staticShadow = true,
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
			class = "Door",
			openVelocity = 0.75,
			closeVelocity = 0.75,
			closeAcceleration = -3,
			openingDirection = "up",
			maxHeight = 2.4,
			openSound = "gate_open",
			closeSound = "gate_open",
			lockSound = "gate_lock",
			--sparse = true,
			killPillars = false,
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
	editorIcon = 124,
	automapIcon = 84,
	tags = { "red cave", "vanblam", "door"},
}

defineObject{
	name = "rc_portcullis_door",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_portcullis_door_2.fbx",
			staticShadow = true,
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
			class = "Door",
			openVelocity = 2,
			closeVelocity = 0.5,
			closeAcceleration = -6,
			openingDirection = "down",
			maxHeight = 3,
			killPillars = false,
		},
		{
			class = "Model",
			name = "frame",
			model = "mod_assets/fire_cave/models/env/rc_portcullis_door_2_frame.fbx",
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

				for yy=0,1 do
					for xx=0,0 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_ground_tiles_01"	
								or e.name == "rc_ground_tiles_02" 
								or e.name == "rc_ground_tiles_03"
								or e.name == "rc_ground_tiles_04"
								or e.name == "rc_ground_tiles_05"
								or e.name == "rc_ground_tiles_06"
								or e.name == "rc_ground_tiles_07"
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
	placement = "wall",
	editorIcon = 124,
	automapIcon = 84,
	tags = { "red cave", "vanblam", "door"},
}