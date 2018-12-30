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
			traits = { "herb" },
			onEquipItem = function(self, champion, slot)
				if champion:hasTrait("druid") then
					local item1 = champion:getItem(ItemSlot.Weapon)
					local item2 = champion:getItem(ItemSlot.OffHand)
					if (slot == ItemSlot.Weapon and item2 ~= nil and (not item2:hasTrait("herb"))) or (slot == ItemSlot.OffHand and item1 ~= nil and (not item1:hasTrait("herb"))) or (slot == ItemSlot.Weapon and item2 == nil) or (slot == ItemSlot.OffHand and item1 == nil) then
						champion:addTrait("blooddrop_cap")
					end
				end
			end,
			onUnequipItem = function(self, champion, slot)
				if champion:hasTrait("blooddrop_cap") then
					champion:removeTrait("blooddrop_cap")
				end
			end
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
			traits = { "herb" },
			onEquipItem = function(self, champion, slot)
				if champion:hasTrait("druid") then
					local item1 = champion:getItem(ItemSlot.Weapon)
					local item2 = champion:getItem(ItemSlot.OffHand)
					if (slot == ItemSlot.Weapon and item2 ~= nil and (not item2:hasTrait("herb"))) or (slot == ItemSlot.OffHand and item1 ~= nil and (not item1:hasTrait("herb"))) or (slot == ItemSlot.Weapon and item2 == nil) or (slot == ItemSlot.OffHand and item1 == nil) then
						champion:addTrait("etherweed")
					end
				end
			end,
			onUnequipItem = function(self, champion, slot)
				if champion:hasTrait("etherweed") then
					champion:removeTrait("etherweed")
				end
			end
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
			traits = { "herb" },
			onEquipItem = function(self, champion, slot)
				if champion:hasTrait("druid") then
					local item1 = champion:getItem(ItemSlot.Weapon)
					local item2 = champion:getItem(ItemSlot.OffHand)
					if (slot == ItemSlot.Weapon and item2 ~= nil and (not item2:hasTrait("herb"))) or (slot == ItemSlot.OffHand and item1 ~= nil and (not item1:hasTrait("herb"))) or (slot == ItemSlot.Weapon and item2 == nil) or (slot == ItemSlot.OffHand and item1 == nil) then
						champion:addTrait("mudwort")
						for i=1,4 do
							if i ~= champion:getOrdinal() then
								party.party:getChampion(i):addTrait("lesser_mudwort")
							end
						end
					end
				end
			end,
			onUnequipItem = function(self, champion, slot)
				if champion:hasTrait("mudwort") then
					champion:removeTrait("mudwort")
					for i=1,4 do
						if i ~= champion:getOrdinal() then
							party.party:getChampion(i):removeTrait("lesser_mudwort")
						end
					end
				end
			end
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
			onEquipItem = function(self, champion, slot)
				if champion:hasTrait("druid") then
					local item1 = champion:getItem(ItemSlot.Weapon)
					local item2 = champion:getItem(ItemSlot.OffHand)
					if (slot == ItemSlot.Weapon and item2 ~= nil and (not item2:hasTrait("herb"))) or (slot == ItemSlot.OffHand and item1 ~= nil and (not item1:hasTrait("herb"))) or (slot == ItemSlot.Weapon and item2 == nil) or (slot == ItemSlot.OffHand and item1 == nil) then
						champion:addTrait("falconskyre")
					end
				end
			end,
			onUnequipItem = function(self, champion, slot)
				if champion:hasTrait("falconskyre") then
					champion:removeTrait("falconskyre")
				end
			end
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
			traits = { "herb" },
			onEquipItem = function(self, champion, slot)
				if champion:hasTrait("druid") then
					local item1 = champion:getItem(ItemSlot.Weapon)
					local item2 = champion:getItem(ItemSlot.OffHand)
					if (slot == ItemSlot.Weapon and item2 ~= nil and (not item2:hasTrait("herb"))) or (slot == ItemSlot.OffHand and item1 ~= nil and (not item1:hasTrait("herb"))) or (slot == ItemSlot.Weapon and item2 == nil) or (slot == ItemSlot.OffHand and item1 == nil) then
						champion:addTrait("blackmoss")
					end
				end
			end,
			onUnequipItem = function(self, champion, slot)
				if champion:hasTrait("blackmoss") then
					champion:removeTrait("blackmoss")
				end
			end
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
			onEquipItem = function(self, champion, slot)
				if champion:hasTrait("druid") then
					local item1 = champion:getItem(ItemSlot.Weapon)
					local item2 = champion:getItem(ItemSlot.OffHand)
					if (slot == ItemSlot.Weapon and item2 ~= nil and (not item2:hasTrait("herb"))) or (slot == ItemSlot.OffHand and item1 ~= nil and (not item1:hasTrait("herb"))) or (slot == ItemSlot.Weapon and item2 == nil) or (slot == ItemSlot.OffHand and item1 == nil) then
						champion:addTrait("crystal_flower")
					end
				end
			end,
			onUnequipItem = function(self, champion, slot)
				if champion:hasTrait("crystal_flower") then
					champion:removeTrait("crystal_flower")
				end
			end
		},
	},
	tags = { "herb" },
}