defineObject{
	name = "beach_puzzle_statue",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/forest_statue_pillar_03.fbx",
			offset = vec(0, -1, 0),
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(-0.02, 1.45, -0.4),
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
		},
		{
			class = "ItemConstrainBox",
			offset = vec(0, 1.5, 0),
			size = vec(0.9, 3, 0.9),
			--debugDraw = true,
		},
		{
			class = "ProjectileCollider",
			size = vec(1.1, 3, 0.8),
			--debugDraw = true,
		},
	},
	placement = "wall",
}