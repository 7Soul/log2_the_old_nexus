defineObject{
	name = "tinkering_toolbox",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mortar_pestle.fbx",
		},
		{
			class = "Item",
            uiName = "Tinkering Toolbox",
            gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 61,
			weight = 3.0,
            description = "Contains a variety of tools and gadgets used for tinkering. It's a priceless tool of the trade.",
            gameEffect = "Requires a Lockpick and crafting materials.",
			traits = { "usable" },
		},
		{
            class = "UsableItem",
            sound = "none",
            canBeUsedByDeadChampion = false,
            requirements = { "tinkering", 1 },
            onUseItem = function(self, champion)
				return false
			end,
		},
	},
	tags = { "item_misc", "tinkering" }
}

defineObject{
	name = "metal_bar",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/items/metal_bar.fbx", --
		},
		{
			class = "Item",
			uiName = "Metal Bar",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 55,
            weight = 0.6,
            stackable = true,
		}
    },
    tags = { "tinkering" }
}

defineObject{
	name = "metal_nugget",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skull.fbx", --
		},
		{
			class = "Item",
			uiName = "Metal Nugget",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 57,
            weight = 0.2,
            stackable = true,
		}
    },
    tags = { "tinkering" }
}

defineObject{
	name = "leather_strips",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skull.fbx", --
		},
		{
			class = "Item",
			uiName = "Leather Strips",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 58,
            weight = 0.05,
            stackable = true,
		}
    },
    tags = { "tinkering" }
}

defineObject{
	name = "leather",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skull.fbx", --
		},
		{
			class = "Item",
			uiName = "Leather",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 59,
            weight = 0.1,
            stackable = true,
		}
    },
    tags = { "tinkering" }
}

defineObject{
	name = "silk",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skull.fbx", --
		},
		{
			class = "Item",
			uiName = "Fabric",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 56,
            weight = 1.5,
            stackable = true,
		}
    },
    tags = { "tinkering" }
}

defineObject{
	name = "gold_bar",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skull.fbx", --
		},
		{
			class = "Item",
			uiName = "Gold Bar",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 62,
            weight = 1.5,
            stackable = true,
		}
    },
    tags = { "tinkering" }
}