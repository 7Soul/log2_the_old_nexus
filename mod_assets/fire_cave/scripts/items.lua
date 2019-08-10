
defineObject{
	name = "aged_key",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/items/rc_old_key_01.fbx",
		},
		{
			class = "Item",
			uiName = "Aged Key",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 65,
			weight = 0.2,
			traits = { "key" },
		},
		
		{
			class = "Particle",
			particleSystem = "glitter_gold",
		},
	},
	tags = {  },
}

defineObject{
	name = "rigid_key",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/items/rc_old_key_02.fbx",
		},
		{
			class = "Item",
			uiName = "Rigid Key",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 66,
			weight = 0.2,
			traits = { "key" },
		},
		
		{
			class = "Particle",
			particleSystem = "glitter_gold",
		},
	},
	tags = {  },
}

defineObject{
	name = "fair_key",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "mod_assets/fire_cave/models/items/rc_old_key_03.fbx",
		},
		{
			class = "Item",
			uiName = "Fair Key",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 67,
			weight = 0.2,
			traits = { "key" },
		},
		
		{
			class = "Particle",
			particleSystem = "glitter_gold",
		},
	},
	tags = { },
}