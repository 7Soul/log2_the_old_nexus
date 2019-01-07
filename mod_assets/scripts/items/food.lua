defineObject{
	name = "snail_slice",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/snail_slice.fbx",
		},
		{
			class = "Item",
			uiName = "Snail Slice",
			gfxIndex = 48,
			weight = 2.4,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 550,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "herder_cap",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/herder_cap.fbx",
		},
		{
			class = "Item",
			uiName = "Herder Cap",
			gfxIndex = 61,
			weight = 1.8,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 525,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "pitroot_bread",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/pitroot_bread.fbx",
		},
		{
			class = "Item",
			uiName = "Pitroot Bread",
			gfxIndex = 58,
			weight = 1.0,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 450,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "rotten_pitroot_bread",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/pitroot_bread.fbx",
		},
		{
			class = "Item",
			uiName = "Rotten Pitroot Bread",
			gfxIndex = 58,
			weight = 1.0,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 250,
			onUseItem = function(self, champion)
				if math.random() < 0.5 then
					champion:setCondition("diseased")
				end
			end,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "rat_shank",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rat_shank.fbx",
		},
		{
			class = "Item",
			uiName = "Burrow Rat Shank",
			gfxIndex = 16,
			weight = 0.8,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 200,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "rat_swarm_shank",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rat_swarm_shank.fbx",
		},
		{
			class = "Item",
			uiName = "Small Rat Shank",
			gfxIndex = 435,
			weight = 0.8,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 100,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "boiled_beetle",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/boiled_beetle.fbx",
		},
		{
			class = "Item",
			uiName = "Boiled Crag Beetle",
			gfxIndex = 59,
			weight = 0.5,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 300,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "baked_maggot",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/baked_maggot.fbx",
		},
		{
			class = "Item",
			uiName = "Baked Maggot",
			gfxIndex = 60,
			weight = 1.1,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 400,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "ice_lizard_steak",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/ice_lizard_steak.fbx",
		},
		{
			class = "Item",
			uiName = "Ice Lizard Steak",
			gfxIndex = 46,
			weight = 2.2,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 750,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "mole_jerky",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mole_jerky.fbx",
		},
		{
			class = "Item",
			uiName = "Mole Jerky",
			gfxIndex = 17,
			weight = 1.4,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 450,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "blueberry_pie",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blueberry_pie.fbx",
		},
		{
			class = "Item",
			uiName = "Blueberry Pie",
			gfxIndex = 217,
			weight = 1.0,
			achievement = "find_pie",
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 1000,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "cheese",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/cheese.fbx",
		},
		{
			class = "Item",
			uiName = "Cheese",
			gfxIndex = 274,
			weight = 1.0,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 350,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "bread",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/bread.fbx",
		},
		{
			class = "Item",
			uiName = "Bread",
			gfxIndex = 275,
			weight = 1.0,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 475,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "sausage",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/sausage.fbx",
		},
		{
			class = "Item",
			uiName = "Salted Sausage",
			gfxIndex = 276,
			weight = 1.0,
			traits = { "consumable", "meat"},
		},
		{
			class = "UsableItem",
			nutritionValue = 400,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "turtle_steak",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/turtle_steak.fbx",
		},
		{
			class = "Item",
			uiName = "Turtle Steak",
			gfxIndex = 277,
			weight = 1.8,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 420,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "smoked_bass",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/smoked_fish.fbx",
		},
		{
			class = "Item",
			uiName = "Smoked Sea Bass",
			gfxIndex = 278,
			weight = 1.0,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 430,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "silver_roach",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/small_fish.fbx",
		},
		{
			class = "Item",
			uiName = "Silver Roach",
			gfxIndex = 355,
			weight = 1.0,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 300,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "turtle_eggs",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/turtle_eggs.fbx",
		},
		{
			class = "Item",
			uiName = "Turtle Egg",
			gfxIndex = 279,
			weight = 1.0,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 460,
		},
	},
	tags = { "food" },
}

defineObject{ 
	name = "horned_fruit",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/horned_fruit.fbx",
		},
		{
			class = "Item",
			uiName = "Horned Fruit",
			gfxIndex = 280,
			projectileRotationSpeed = 10,
			projectileRotationZ = -30,
			weight = 0.7,
			description = "This fruit has a very strong stinging taste and is commonly found in the southern islands. They are covered with needlelike spikes that can easily pierce the skin and cause an irritating rash.",
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 250,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "warg_meat",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/warg_meat.fbx",
		},
		{
			class = "Item",
			uiName = "Warg Meat",
			gfxIndex = 290,
			weight = 1.5,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 420,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "fjeld_warg_meat",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/fjeld_warg_meat.fbx",
		},
		{
			class = "Item",
			uiName = "Fjeld Warg Meat",
			gfxIndex = 436,
			weight = 1,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 350,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "lizard_stick",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/lizzard_onna_stick.fbx",
		},
		{
			class = "Item",
			uiName = "Lizard on a Stick",
			gfxIndex = 323,
			weight = 0.5,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 300,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "snake_tail",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/snake_tail.fbx",
		},
		{
			class = "Item",
			uiName = "Snake Tail",
			gfxIndex = 366,
			weight = 2.4,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 550,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "toad_tongue",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/toad_tongue.fbx",
		},
		{
			class = "Item",
			uiName = "Toad Tongue",
			gfxIndex = 367,
			weight = 2.4,
			traits = { "consumable", "meat" },
		},
		{
			class = "UsableItem",
			nutritionValue = 550,
		},
	},
	tags = { "food" },
}

defineObject{
	name = "borra",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/grimcap.fbx",
		},
		{
			class = "Item",
			uiName = "Borra",
			description = "A delicious mushroom, just waiting to be eaten fresh or dried.",
			gfxIndex = 105,
			weight = 0.1,
			traits = { "consumable" },
		},
		{
			class = "UsableItem",
			nutritionValue = 240,
		},
	},
	tags = { "food" },
}
