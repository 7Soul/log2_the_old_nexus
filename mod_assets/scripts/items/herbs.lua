defineObject{
	name = "blooddrop_cap",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blooddrop_cap.fbx",
		},
		{
			class = "Item",
			uiName = "Blooddrop Cap",
			description = "Blooddrop Cap is a potent ingredient used in many kinds of healing potions.",
			gfxIndex = 57,
			stackable = true,
			weight = 0.05,
			traits = { "herb", "rodent" },
		},
		{
			class = "Particle",
			particleSystem = "blooddrop",
		},
	},
	tags = { "herb" },
}

defineObject{
	name = "etherweed",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/milkreed.fbx",
		},
		{
			class = "Item",
			uiName = "Etherweed",
			description = "This delicate underwater plant is commonly found on shores and riverbeds and sometimes even in the depths of underground lakes. Etherweed is much sought after for the beautiful blue glow of its buds.",
			gfxIndex = 76,
			stackable = true,
			weight = 0.05,
			traits = { "herb", "rodent" },
		},
		{
			class = "Particle",
			particleSystem = "etherweed",
		},
	},
	tags = { "herb" },
}

defineObject{
	name = "mudwort",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mudwort.fbx",
		},
		{
			class = "Item",
			uiName = "Mudwort",
			description = "This uncommon herb can be found underground and sometimes in damp, shadowy places above ground. The roots of Mudwort have an exceptionally strong grip and they are used to treat snake bites. Warriors commonly chew the roots as it is said to improve their vitality.",
			gfxIndex = 77,
			stackable = true,
			weight = 0.05,
			traits = { "herb", "rodent" },
		},
	},
	tags = { "herb" },
}

defineObject{
	name = "falconskyre",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/falconskyre.fbx",
		},
		{
			class = "Item",
			uiName = "Falconskyre",
			description = "The feathery leaves of Falconskyre reflect the color of the sun in yellow, red and orange hues. Falconskyre is associated with the element of air and dexterity. It prefers to grow in large open spaces.",
			gfxIndex = 78,
			stackable = true,
			weight = 0.05,
			traits = { "herb" },
		},
	},
	tags = { "herb" },
}

defineObject{
	name = "blackmoss",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blackmoss.fbx",
		},
		{
			class = "Item",
			uiName = "Blackmoss",
			description = "This cancerous mass of darkness feeds on living things. It reeks of death and chaos. Only the most potent alchemists dare to handle it.",
			gfxIndex = 79,
			stackable = true,
			weight = 0.05,
			traits = { "herb", "rodent" },
		},
	},
	tags = { "herb" },
}

defineObject{
	name = "crystal_flower",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_flower.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Flower",
			description = "A mythical living thing, the Crystal Flower is half plant, half mineral formation. It is extremely fortunate to find even one in a lifetime. Alchemists value them very highly.",
			gfxIndex = 80,
			stackable = true,
			weight = 0.05,
			traits = { "herb" },
		},
	},
	tags = { "herb" },
}

defineObject{
	name = "fiber_ball_good",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/falconskyre.fbx",
		},
		{
			class = "Item",
			uiName = "Fermented Fiber Ball",
			description = "A herb fermented with a certain kind of Ratling digestive enzyme. Its vapors help other herbs grow faster, and can be used to cure disease and poisons. It will dry out with time, becoming useless.",
			gameEffect = [[- Keep in your inventory to increase herb growth. 
			- Consume to cure poison and disease.]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 63,
			stackable = true,
			weight = 0.01,
		},
		{
			class = "UsableItem",
			onUseItem = function(self, champion)
				champion:removeCondition("poison")
				champion:removeCondition("diseased")
				champion:playHealingIndicator()
				return false
			end
		},
	},
}

defineObject{
	name = "fiber_ball_bad",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/falconskyre.fbx",
		},
		{
			class = "Item",
			uiName = "Dry Fiber Ball",
			description = "A dry ball of fiber. Can be used as ignition material on the creation of bombs.",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 64,
			stackable = true,
			weight = 0.01,
		},
	},
}