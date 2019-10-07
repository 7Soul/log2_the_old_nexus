defineObject{
	name = "ring_mail",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/ring_mail.fbx",
		},
		{
			class = "Item",
			uiName = "Ring Mail",
			armorSet = "ring",
			armorSetPieces = 5,
			gfxIndex = 88,
			weight = 11.0,
			traits = { "heavy_armor", "dismantle", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 6,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "ring_mail_bp",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/ring_mail.fbx",
		},
		{
			class = "Item",
			uiName = "Ring Mail",
			armorSet = "ring",
			armorSetPieces = 5,
			gfxIndex = 88,
			weight = 11.0,
			traits = { "heavy_armor", "dismantle", "chest_armor", "upgradable" },
			fitContainer = false,
		},
		{
			class = "EquipmentItem",
			protection = 6,
		},
		{
			class = "ContainerItem",
			containerType = "sack",
			openSound = "container_sack_open",
			closeSound = "container_sack_close",
			onInit = function(self)
				if self:getItemCount() > 0 then
					self.go.item:setFitContainer(true)
				end
			end,			
			onInsertItem = function(self, item)
				-- convert to full sack
				if self:getItemCount() > 0 then
					self.go.item:setFitContainer(false)
				end
			end,
			onRemoveItem = function(self, item)
				-- convert to empty sack when last item is removed
				if self:getItemCount() == 0 then
					self.go.item:setFitContainer(true)
				end
			end,
		},
		{
			class = "UsableItem",
			onUseItem = function(self, champion)
				return false
			end,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "ring_cuisse",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/ring_cuisse.fbx",
		},
		{
			class = "Item",
			uiName = "Ring Cuisse",
			armorSet = "ring",
			gfxIndex = 89,
			weight = 8.0,
			traits = { "heavy_armor", "dismantle", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 6,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "ring_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/ring_gauntlets.fbx",
		},
		{
			class = "Item",
			uiName = "Ring Gauntlets",
			armorSet = "ring",
			gfxIndex = 90,
			weight = 3.5,
			traits = { "heavy_armor", "dismantle", "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 6,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "ring_greaves",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/ring_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Ring Greaves",
			armorSet = "ring",
			gfxIndex = 140,
			weight = 4.8,
			traits = { "heavy_armor", "dismantle", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 6,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "legionary_helmet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skeleton_helmet.fbx",
		},
		{
			class = "Item",
			uiName = "Phalanx Helmet",
			gfxIndex = 209,
			weight = 3.4,
			traits = { "heavy_armor", "dismantle", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 6,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "iron_basinet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/iron_basinet.fbx",
		},
		{
			class = "Item",
			uiName = "Iron Basinet",
			gfxIndex = 4,
			weight = 3.1,
			traits = { "heavy_armor", "dismantle", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 8,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "plate_cuirass",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/plate_cuirass.fbx",
		},
		{
			class = "Item",
			uiName = "Plate Cuirass",
			armorSet = "plate",
			armorSetPieces = 5,
			gfxIndex = 91,
			weight = 17.0,
			traits = { "heavy_armor", "dismantle", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 12,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "plate_cuisse",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/plate_cuisse.fbx",
		},
		{
			class = "Item",
			uiName = "Leg Plate",
			armorSet = "plate",
			gfxIndex = 92,
			weight = 11.0,
			traits = { "heavy_armor", "dismantle", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 12,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "full_helmet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/full_helmet.fbx",
		},
		{
			class = "Item",
			uiName = "Full Helmet",
			armorSet = "plate",
			gfxIndex = 93,
			weight = 5.0,
			traits = { "heavy_armor", "dismantle", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 12,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "plate_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/plate_gauntlets.fbx",
		},
		{
			class = "Item",
			uiName = "Plate Gauntlets",
			armorSet = "plate",
			gfxIndex = 95,
			weight = 4.0,
			traits = { "heavy_armor", "dismantle", "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 12,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "plate_greaves",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/plate_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Plate Greaves",
			armorSet = "plate",
			gfxIndex = 94,
			weight = 6.0,
			traits = { "heavy_armor", "dismantle", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 12,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "skeleton_knight_helmet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skeleton_knight_helmet.fbx",
		},
		{
			class = "Item",
			uiName = "Ancient Helm",
			gfxIndex = 296,
			weight = 3.5,
			traits = { "heavy_armor", "dismantle", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 5,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "bear_skull_helm",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skull_helmet.fbx",
		},
		{
			class = "Item",
			uiName = "Bear Skull Helmet",
			gfxIndex = 322,
			weight = 0.8,
			armorSet = "bear",
			armorSetPieces = 3,
			traits = { "light_armor", "helmet", "upgradable" },
			description = "The most bloodthirsty of the fjord dwellers wore helmets crafted out of bear skulls.",
			gameEffect = [[[Bear Set] While in bear form you gain +10 Strength.
			Extends bear form duration.]],
		},
		{
			class = "EquipmentItem",
			protection = 5,
			strength = 2,
		},
	},
	tags = { "armor_light" },
}

-- Valor set

defineObject{
	name = "cuirass_valor",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/cuirass_valor.fbx",
		},
		{
			class = "Item",
			uiName = "Cuirass of Valor",
			description = "A plate cuirass forged of strips of shiny golden metal. It was thought to be forever lost on the battlefields of Malan Tael",
			armorSet = "valor",
			armorSetPieces = 5,
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 91,
			gfxIndexArmorSet = 97,	
			weight = 13.0,
			traits = { "heavy_armor", "dismantle", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 15,
			onRecomputeStats = function(self, champion)
				if functions.script.isArmorSetEquipped(champion, "valor") then
					champion:addStatModifier("max_health", 50)
				end
			end,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "cuisse_valor",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/cuisse_valor.fbx",
		},
		{
			class = "Item",
			uiName = "Cuisse of Valor",
			description = "Leg armor made out of strange, ornate metal. Light dances across its surface.",
			armorSet = "valor",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 92,
			gfxIndexArmorSet = 98,
			weight = 9.5,
			traits = { "heavy_armor", "dismantle", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 15,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "helmet_valor",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/helmet_valor.fbx",
		},
		{
			class = "Item",
			uiName = "Helmet of Valor",
			description = "Even though this helmet looks ceremonial, it is forged to last even the mightiest of blows.",
			armorSet = "valor",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 93,
			gfxIndexArmorSet = 99,
			weight = 4.5,
			traits = { "heavy_armor", "dismantle", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 15,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "gauntlets_valor",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/gauntlets_valor.fbx",
		},
		{
			class = "Item",
			uiName = "Gauntlets of Valor",
			description = "These gauntlets were worn by the emperor of Malan Tael.",
			armorSet = "valor",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 95,
			gfxIndexArmorSet = 101,
			weight = 3.5,
			traits = { "heavy_armor", "dismantle", "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 15,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "greaves_valor",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/boots_valor.fbx",
		},
		{
			class = "Item",
			uiName = "Greaves of Valor",
			description = "These greaves, fashioned of almost impenetrable metal, are lighter to wear than the fine steel sabatons of the royal regiments.",
			armorSet = "valor",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 94,
			gfxIndexArmorSet = 100,
			weight = 5.5,
			traits = { "heavy_armor", "dismantle", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 15,
		},
	},
	tags = { "armor_heavy" },
}

-- Crystal set

defineObject{
	name = "crystal_cuirass",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_armor_cuirass.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Cuirass",
			description = "Putting on this crystal covered cuirass refreshes the spirits like a good night's sleep.",
			gameEffect=[[[Crystal Set] +50 Health. Once after using a Healing Crystal, if you fall under 50 health you quickly heal back to full.]],
			armorSet = "crystal",
			armorSetPieces = 6,
			gfxIndex = 350,
			gfxIndexArmorSet = 99,
			weight = 13.0,
			traits = { "heavy_armor", "dismantle", "epic", "chest_armor", "upgradable" }
		},
		{
			class = "EquipmentItem",
			health = 5,
			protection = 16,
			onRecomputeStats = function(self, champion)
				if functions.script.isArmorSetEquipped(champion, "crystal") then
					champion:addStatModifier("max_health", 50)
				end
			end,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "crystal_helmet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_armor_helmet.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Helmet",
			description = "This helmet covers its wearer with a veil of pale blue light.",
			gameEffect=[[[Crystal Set] +50 Health. Once after using a Healing Crystal, if you fall under 50 health you quickly heal back to full.]],
			armorSet = "crystal",
			gfxIndex = 352,
			gfxIndexArmorSet = 101,
			weight = 3.8,
			traits = { "heavy_armor", "dismantle", "helmet", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			health = 5,
			protection = 14,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "crystal_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_armor_gauntlets.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Gauntlets",
			armorSet = "crystal",
			description = "A faint, soothing hum can be heard emanating from the crystals.",
			gameEffect=[[[Crystal Set] +50 Health. Once after using a Healing Crystal, if you fall under 50 health you quickly heal back to full.]],
			gfxIndex = 354,
			gfxIndexArmorSet = 103,
			weight = 2.5,
			traits = { "heavy_armor", "dismantle", "gloves", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			health = 5,
			protection = 10,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "crystal_greaves",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_armor_cuisse.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Greaves",
			description = "The Crystal Armor was rumored to be the source of the immortality of Iliar Foulhart, the self-crowned king of Conwyn.",
			gameEffect=[[[Crystal Set] +50 Health. Once after using a Healing Crystal, if you fall under 50 health you quickly heal back to full.]],
			armorSet = "crystal",
			gfxIndex = 351,
			gfxIndexArmorSet = 100,
			weight = 7.0,
			traits = { "heavy_armor", "dismantle", "leg_armor", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			health = 5,
			protection = 15,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "crystal_boots",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_armor_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Boots",
			description = "You can feel magical energy flowing from the blue shards of crystal in these boots.",
			gameEffect=[[[Crystal Set] +50 Health. Once after using a Healing Crystal, if you fall under 50 health you quickly heal back to full.]],
			armorSet = "crystal",
			gfxIndex = 353,
			gfxIndexArmorSet = 102,
			weight = 3.2,
			traits = { "heavy_armor", "dismantle", "boots", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			health = 5,
			protection = 10,
		},
	},
	tags = { "armor_heavy" },
}

-- Meteor set

defineObject{
	name = "meteor_cuirass",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_cuirass.fbx",
		},
		{
			class = "Item",
			uiName = "Meteor Plate",
			description = "The origins of this armor is a mystery. Many master blacksmiths have tried to forge meteorstone but all have failed.",
			armorSet = "meteor",
			armorSetPieces = 6,
			gfxIndex = 265,
			gfxIndexArmorSet = 467,	
			weight = 15.0,
			gameEffect = [[Meteor Set: +50 Fire Resist.]],
			traits = { "heavy_armor", "dismantle", "chest_armor", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 18,
			onRecomputeStats = function(self, champion)
				if champion:isArmorSetEquipped("meteor") then
					champion:addStatModifier("resist_fire", 50)

					if champion:hasTrait("average_joe") then
						champion:addStatModifier("resist_fire", -50)
					end					
				end
			end,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "meteor_cuisse",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_cuisse.fbx",
		},
		{
			class = "Item",
			uiName = "Meteor Leg Plate",
			description = "A massive looking piece of armor. The strange black metal feels harder than any material you have encountered.",
			armorSet = "meteor",
			gfxIndex = 266,
			gfxIndexArmorSet = 468,
			weight = 11.5,
			traits = { "heavy_armor", "dismantle", "leg_armor", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 18,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "meteor_helmet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_helmet.fbx",
		},
		{
			class = "Item",
			uiName = "Meteor Helm",
			description = "This dark metal helmet seems to be shaped from a single block of meteorstone.",
			armorSet = "meteor",
			gfxIndex = 267,
			gfxIndexArmorSet = 469,
			weight = 4.2,
			traits = { "heavy_armor", "dismantle", "helmet", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 18,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "meteor_boots",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Meteor Greaves",
			description = "These massive boots are clumsy but the thick metal will protect its wearer from almost anything.",
			armorSet = "meteor",
			gfxIndex = 268,
			gfxIndexArmorSet = 470,
			weight = 3.8,
			traits = { "heavy_armor", "dismantle", "boots", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 18,
		},
	},
	tags = { "armor_heavy" },
}

defineObject{
	name = "meteor_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_gauntlets.fbx",
		},
		{
			class = "Item",
			uiName = "Meteor Gauntlets",
			description = "The bulky joints and thick metal sheets make it difficult to bend your fingers but the protection these gauntlets offer is almost unbeatable.",
			armorSet = "meteor",
			gfxIndex = 269,
			gfxIndexArmorSet = 471,
			weight = 3.8,
			traits = { "heavy_armor", "dismantle", "gloves", "epic", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 18,
		},
	},
	tags = { "armor_heavy" },
}

------------- Light armor

defineObject{
	name = "hide_vest",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/leather_clothes.fbx",
		},
		{
			class = "Item",
			uiName = "Sandmole Hide Vest",
			description = "During times of drought, farmers often resort to hunting sandmoles for their meat and thick hides.",
			gfxIndex = 34,
			weight = 3.0,
			traits = { "light_armor", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "leather_brigandine",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/leather_brigandine.fbx",
		},
		{
			class = "Item",
			uiName = "Leather Brigandine",
			armorSet = "leather",
			armorSetPieces = 4,
			gfxIndex = 19,
			weight = 8.0,
			traits = { "light_armor", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "leather_cuisse",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/leather_cuisse.fbx",
		},
		{
			class = "Item",
			uiName = "Leather Cuisse",
			armorSet = "leather",
			gfxIndex = 20,
			weight = 5.0,
			traits = { "light_armor", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "leather_cap",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/leather_cap.fbx",
		},
		{
			class = "Item",
			uiName = "Leather Cap",
			armorSet = "leather",
			gfxIndex = 21,
			weight = 0.8,
			traits = { "light_armor", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
		},
	},
	tags = { "armor_light" },
}

-- Makeshift Set

defineObject{
	name = "makeshift_chestplate",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/makeshift_chest.fbx",
		},
		{
			class = "Item",
			uiName = "Thraelm Tribal Chestplate",
			description = "Powerful runes, painted with the excretions of wormbug larvae, adorn the chestplate.",
			armorSet = "makeshift",
			armorSetPieces = 4,
			gfxIndex = 283,
			weight = 4.0,
			traits = { "light_armor", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			energy = 5,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "makeshift_mask",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/makeshift_mask.fbx",
		},
		{
			class = "Item",
			uiName = "Thraelm Tribal Mask",
			description = "A grotesque mask used in the rites of the Thraelm tribesmen.",
			armorSet = "makeshift",
			armorSetPieces = 4,
			gfxIndex = 284,
			weight = 1.2,
			traits = { "light_armor", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			energy = 5,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "makeshift_legplates",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/makeshift_legplates.fbx",
		},
		{
			class = "Item",
			uiName = "Thraelm Tribal Legplates",
			description = "Thraelm tribesmen are widely feared due to their fighting style which combines magic with ruthless hand-to-hand combat.",
			armorSet = "makeshift",
			armorSetPieces = 4,
			gfxIndex = 285,
			weight = 2.0,
			traits = { "light_armor", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 3,
			energy = 5,
		},
	},
	tags = { "armor_light" },
}

-- Reed set

defineObject{
	name = "reed_cuirass",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/reed_cuirass.fbx",
		},
		{
			class = "Item",
			uiName = "Reed Cuirass",
			description = "This cuirass, crafted out of reeds grown on the banks of the Serpent River, can withstand far more powerful strikes and slashes than one would expect from its looks.",
			armorSet = "reed",
			armorSetPieces = 5,
			gfxIndex = 254,
			weight = 8.0,
			traits = { "light_armor", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
			evasion = 2,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "reed_legmail",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/reed_legmail.fbx",
		},
		{
			class = "Item",
			uiName = "Reed Legmail",
			description = "This legmail is very flexible despite its thick construction.",
			armorSet = "reed",
			gfxIndex = 255,
			weight = 5.0,
			traits = { "light_armor", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
			evasion = 2,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "reed_helmet",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/reed_helmet.fbx",
		},
		{
			class = "Item",
			uiName = "Reed Helmet",
			description = "This helmet is skillfully bound from hundreds of reeds of varying sizes.",
			armorSet = "reed",
			gfxIndex = 256,
			weight = 0.8,
			traits = { "light_armor", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
			evasion = 2,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "reed_sabaton",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/reed_sabaton.fbx",
		},
		{
			class = "Item",
			uiName = "Reed Sabatons",
			description = "These sabatons are thick and durable but almost as comfortable to wear as a pair of loafers.",
			armorSet = "reed",
			gfxIndex = 257,
			weight = 2.6,
			traits = { "light_armor", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
			evasion = 2,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "reed_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/reed_gauntlets.fbx",
		},
		{
			class = "Item",
			uiName = "Reed Gauntlets",
			description = "When clenched to a fist, the reeds wrap around the wearer's hand tightly and improve its grip.",
			armorSet = "reed",
			gfxIndex = 258,
			weight = 0.5,
			traits = { "light_armor", "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
			evasion = 2,
		},
	},
	tags = { "armor_light" },
}

-- Mirror set

defineObject{
	name = "mirror_chestplate",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mirror_armor_chestplate.fbx",
		},
		{
			class = "Item",
			uiName = "Mirror Chestplate",
			description = "Light reflected off the polished metal discs on this chest plate shimmers and dances around in a strange fashion.",
			gameEffect = [[[Mirror Set]:  ]],
			armorSet = "mirror",
			armorSetPieces = 5,
			gfxIndex = 239,
			weight = 8.0,
			traits = { "light_armor", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 8,
			resistAll = 5,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "mirror_greaves",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mirror_armor_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Mirror Greaves",
			description = "Thick armored boots that can keep the freezing winds of a tundra at bay.",
			armorSet = "mirror",
			gfxIndex = 242,
			weight = 3.5,
			traits = { "light_armor", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 8,
			resistAll = 5,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "mirror_gauntlets",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mirror_armor_gauntlets.fbx",
		},
		{
			class = "Item",
			uiName = "Mirror Gauntlets",
			description = "These gauntlets are bulky but surprisingly nimble when worn.",
			armorSet = "mirror",
			gfxIndex = 243,
			weight = 0.8,
			traits = { "light_armor", "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 8,
			resistAll = 5,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "mirror_tagelmust",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mirror_armor_tagelmust.fbx",
		},
		{
			class = "Item",
			uiName = "Mirror Tagelmust",
			description = "The multiple layers of cloth and leather protect its wearer from extreme cold and heat.",
			armorSet = "mirror",
			gfxIndex = 241,
			weight = 3.5,
			traits = { "light_armor", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 8,
			resistAll = 5,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "mirror_cuisse",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mirror_armor_cuisse.fbx",
		},
		{
			class = "Item",
			uiName = "Mirror Cuisse",
			description = "Comfortable to wear on even longer journeys, the mirror armors are highly sought after by traveling mercenaries.",
			armorSet = "mirror",
			gfxIndex = 240,
			weight = 3.5,
			traits = { "light_armor", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 8,
			resistAll = 5,
		},
	},
	tags = { "armor_light" },
}

-- Chitin set

defineObject{
	name = "chitin_mail",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/chitin_mail.fbx",
		},
		{
			class = "Item",
			uiName = "Chitin Breastplate",
			description = "A chestplate crafted from parts of a giant beetle carapace.",
			gameEffect = [[[Chitin Set]: Bonuses and Perks from the Block skill work without you holding a shield.]],
			armorSet = "chitin",
			armorSetPieces = 5,
			gfxIndex = 49,
			weight = 7.0,
			traits = { "light_armor", "chest_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 9,
			resistFire = 3,
			resistCold = 3,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "chitin_cuisse",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/chitin_cuisse.fbx",
		},
		{
			class = "Item",
			uiName = "Chitin Cuisse",
			description = "Numerous pieces of chitinous shells are fixed together to form a primitive but efficient leg armor.",
			gameEffect = [[[Chitin Set]: Bonuses and Perks from the Block skill work without you holding a shield.]],
			armorSet = "chitin",
			gfxIndex = 50,
			weight = 4.0,
			traits = { "light_armor", "leg_armor", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 6,
			resistFire = 3,
			resistCold = 3,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "chitin_greaves",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/chitin_boots.fbx",
		},
		{
			class = "Item",
			uiName = "Chitin Greaves",
			description = "The many layers of insect shells provide good protection for the feet.",
			gameEffect = [[[Chitin Set]: Bonuses and Perks from the Block skill work without you holding a shield.]],
			armorSet = "chitin",
			gfxIndex = 73,
			weight = 3.0,
			traits = { "light_armor", "boots", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 5,
			resistFire = 3,
			resistCold = 3,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "chitin_mask",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/chitin_mask.fbx",
		},
		{
			class = "Item",
			uiName = "Chitin Mask",
			description = "The pod of a giant beetle larva is carved into a primitive face mask.",
			gameEffect = [[[Chitin Set]: Bonuses and Perks from the Block skill work without you holding a shield.]],
			armorSet = "chitin",
			gfxIndex = 51,
			weight = 2.0,
			traits = { "light_armor", "helmet", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 5,
			resistFire = 3,
			resistCold = 3,
		},
	},
	tags = { "armor_light" },
}

defineObject{
	name = "chitin_gloves",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/items/chitin_gloves.fbx",
		},
		{
			class = "Item",
			uiName = "Chitin Gloves",
			description = "",
			gameEffect = [[[Chitin Set]: Bonuses and Perks from the Block skill work without you holding a shield.]],
			armorSet = "chitin",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 82,
			weight = 2.1,
			traits = { "light_armor", "gloves", "upgradable" },
		},
		{
			class = "EquipmentItem",
			protection = 4,
			resistFire = 2,
			resistCold = 2,
		},
	},
	tags = { "armor_light" },
}
