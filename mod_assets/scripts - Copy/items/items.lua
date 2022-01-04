defineObject{
	name = "skull",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skull.fbx",
		},
		{
			class = "Item",
			uiName = "Skull",
			traits = { "skull" },
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 31,
			weight = 1.0,
		}
	},
}

defineObject{
	name = "tome_fire",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Tome of Fire",
			description = "The cover of this book feels as hot as embers. Chants and fire rituals are written on the pages.",
			gfxIndex = 30,
			weight = 1.0,
			gameEffect = "Resist Fire +20",
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." gained Resist Fire +20 and Health + 5.")				
				champion:modifyBaseStat("max_health", 5)
				champion:modifyBaseStat("health", 5)
				champion:modifyBaseStat("resist_fire", 20)
				return true
			end,
		},
	},
}

defineObject{
	name = "tome_earth",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Tome of Earth",
			description = "Centipedes and beetles crawl from beneath the covers of this book. A thick smell of mold fills the air when the book is opened.",
			gfxIndex = 30,
			weight = 1.0,
			gameEffect = "Resist Poison +20",
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." gained Resist Poison +20 and Health + 5.")				
				champion:modifyBaseStat("max_health", 5)
				champion:modifyBaseStat("health", 5)
				champion:modifyBaseStat("resist_poison", 20)
				return true
			end,
		},
	},
}

defineObject{
	name = "tome_water",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Tome of Water",
			description = "A layer of frost covers the tome and water seeps out from between the pages.",
			gfxIndex = 30,
			weight = 1.0,
			gameEffect = "Resist Cold +20",
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." gained Resist Cold +20 and Energy + 5.")
				champion:modifyBaseStat("max_energy", 5)
				champion:modifyBaseStat("energy", 5)
				champion:modifyBaseStat("resist_cold", 20)
				return true
			end,
		},
	},
}

defineObject{
	name = "tome_air",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Tome of Air",
			description = "A stiff breeze blows from within this book once it is opened. The pages flutter around wildly but settle into place once the first rune is read aloud.",
			gfxIndex = 30,
			weight = 1.0,
			gameEffect = "Resist Shock +20",
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." gained Resist Shock +20 and Energy + 5.")
				champion:modifyBaseStat("max_energy", 5)
				champion:modifyBaseStat("energy", 5)
				champion:modifyBaseStat("resist_shock", 20)
				return true
			end,
		},
	},
}