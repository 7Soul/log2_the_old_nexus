defineObject{
	name = "scroll",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/scroll.fbx",
		},
		{
			class = "Item",
			uiName = "Scroll",
			gfxIndex = 112,
			weight = 0.3,
		},
		{
			class = "ScrollItem",
		},
	},
}

defineObject{
	name = "scroll_recipe",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/scroll_recipe.fbx",
		},
		{
			class = "Item",
			uiName = "Recipe",
			gfxIndex = 456,
			weight = 0.3,
		},
		{
			class = "ScrollItem",
		},
	},
}

defineObject{
	name = "note",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/note.fbx",
		},
		{
			class = "Item",
			uiName = "Note",
			gfxIndex = 114,
			weight = 0.1,
		},
		{
			class = "ScrollItem",
		},
	},
}

defineObject{
	name = "treasure_map",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/note.fbx",
		},
		{
			class = "Item",
			uiName = "Map",
			gfxIndex = 454,
			weight = 0.1,
		},
		{
			class = "ScrollItem",
		},
	},
}

defineObject{
	name = "letter",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/waxseal_note.fbx",
		},
		{
			class = "Item",
			uiName = "Letter",
			gfxIndex = 235,
			weight = 0.1,
		},
		{
			class = "ScrollItem",
			textAlignment = "left",
		},
	},
}

defineObject{
	name = "island_map",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/waxseal_note.fbx",
		},
		{
			class = "Item",
			uiName = "Island Map",
			gfxIndex = 454,
			weight = 0.1,
			traits = { "readable" },
		},
		{
			class = "UsableItem",
			onUseItem = function(self)
				GameMode.showImage("assets/textures/gui/scroll_images/sleet_island_map.tga")
				return false
			end,
		},
	},
}

defineObject{
	name = "timenote_1",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/note.fbx",
		},
		{
			class = "Item",
			uiName = "Note",
			gfxIndex = 114,
			weight = 0.1,
		},
		{
			class = "UsableItem",
			onUseItem = function(self)
				GameMode.showImage("mod_assets/textures/gui/paper_1.dds")
				return false
			end,
		},
	},
}

defineObject{
	name = "note_1",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/note.fbx",
		},
		{
			class = "Item",
			uiName = "Note",
			gfxIndex = 114,
			weight = 0.1,
		},
		{
			class = "UsableItem",
			onUseItem = function(self)
				GameMode.showImage("mod_assets/textures/gui/paper_2.dds")
				return false
			end,
		},
	},
}