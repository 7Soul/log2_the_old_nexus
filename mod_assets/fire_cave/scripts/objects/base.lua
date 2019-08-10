do
local autoDecoEdgeCave = function(self)
		local g = self.go
		if g.map:getElevation(g.x,g.y) == g.elevation then
			local choice = math.random()
			if choice >= 0.85 then
				g:spawn("rc_edge_support_01")
			elseif choice >= 0.7 then
				g:spawn("rc_edge_support_02")
			elseif choice >= 0.55 then
				g:spawn("rc_edge_support_03")
			elseif choice >= 0.4 then
				g:spawn("rc_edge_support_04")
			end
		end
		if g.map:getElevation(g.x,g.y) == g.elevation then
			local choice = math.random()
			if choice >= 0.85 then
				g:spawn("rc_edge_support_01b")
			elseif choice >= 0.7 then
				g:spawn("rc_edge_support_02b")
			elseif choice >= 0.55 then
				g:spawn("rc_edge_support_03b")
			elseif choice >= 0.4 then
				g:spawn("rc_edge_support_04b")
			end
		end
end	

defineObject{
	name = "fire_moss_wall_01",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Null",
			onInit = autoDecoEdgeCave,
		},
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
	placement = "wall",
	replacesWall = true,
	minimalSaveState = true,
}

defineObject{
	name = "rc_wall_stone",
	components = {
		{
			class = "Null",
			onInit = autoDecoEdgeStone,
		},
	},
	placement = "wall",
	replacesWall = true,
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_support_01", --I strongly recommend you DO NOT place these, there meant for auto creation ONLY, use rc_support_small a-h if want more supports.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_support_01.fbx",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
		
	},
	placement = "wall",
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_support_02", --I strongly recommend you DO NOT place these, there meant for auto creation ONLY, use rc_support_small a-h if want more supports.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_support_02.fbx",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
		
	},
	placement = "wall",
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_support_03", --I strongly recommend you DO NOT place these, there meant for auto creation ONLY, use rc_support_small a-h if want more supports.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_support_03.fbx",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
		
	},
	placement = "wall",
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_support_04", --I strongly recommend you DO NOT place these, there meant for auto creation ONLY, use rc_support_small a-h if want more supports.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_support_04.fbx",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
		
	},
	placement = "wall",
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_support_01b", --I strongly recommend you DO NOT place these, there meant for auto creation ONLY, use rc_support_small a-h if want more supports.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_support_01b.fbx",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
		
	},
	placement = "wall",
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_support_02b", --I strongly recommend you DO NOT place these, there meant for auto creation ONLY, use rc_support_small a-h if want more supports.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_support_02b.fbx",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
		
	},
	placement = "wall",
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_support_03b", --I strongly recommend you DO NOT place these, there meant for auto creation ONLY, use rc_support_small a-h if want more supports.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_support_03b.fbx",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
		
	},
	placement = "wall",
	minimalSaveState = true,
}

defineObject{
	name = "rc_edge_support_04b", --I strongly recommend you DO NOT place these, there meant for auto creation ONLY, use rc_support_small a-h if want more supports.
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/env/rc_edge_support_04b.fbx",
		},
		{
			class = "Occluder",
			model = "assets/models/env/mine_pillar_01_occluder.fbx",
		},
		
	},
	placement = "wall",
	minimalSaveState = true,
}

defineObject{
	name = "rc_remove_supports",
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
				-- desroys supports in 3x3 area
				for yy=-1,1 do
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
				self.go:destroy()
			end,
		},
		
	},
	--minimalSaveState = true,
	placement = "floor",
	editorIcon = 96,
	tags = { },
}

defineObject{
	name = "rc_remove_pillars",
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
				-- desroys supports in 3x3 area
				for yy=-1,1 do
					for xx=-1,1 do
						local x = x + rx * xx + fx * yy
						local y = y + ry * xx + fy * yy
						if x >= 0 and y >= 0 and x < 32 and y < 32 then
							for e in self.go.map:entitiesAt(x, y) do
								if e.name == "rc_pillar_02a"							
								then e:destroy()
								end
							end
						end
					end
				end
				self.go:destroy()
			end,
		},
		
	},
	--minimalSaveState = true,
	placement = "floor",
	editorIcon = 96,
	tags = {  },
}

defineObject{
	name = "rc_remove_all_extras",
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
				-- desroys supports in 3x3 area
				for yy=-1,1 do
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
								or e.name == "rc_pillar_02a"
								then e:destroy()
								end
							end
						end
					end
				end
				self.go:destroy()
			end,
		},
		
	},
	--minimalSaveState = true,
	placement = "floor",
	editorIcon = 96,
	tags = { },
}
end