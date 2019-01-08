defineObject{
	name = "flask",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Flask (empty)",
			gfxIndex = 143,
			weight = 0.1,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "water_flask",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Water Flask",
			gfxIndex = 144,
			weight = 0.3,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_healing",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Healing Potion",
			gfxIndex = 146,
			weight = 0.6,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				local mult = iff(champion:hasTrait("fast_metabolism"), 2, 1)
				champion:regainHealth(75*mult)
				champion:removeCondition("head_wound")
				champion:removeCondition("chest_wound")
				champion:removeCondition("leg_wound")
				champion:removeCondition("feet_wound")
				champion:removeCondition("right_hand_wound")
				champion:removeCondition("left_hand_wound")
				champion:playHealingIndicator()
				if champion:hasTrait("refreshed") then
					champion:setConditionValue("refreshed", 30)
				end
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_greater_healing",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/big_potion.fbx",
		},
		{
			class = "Item",
			uiName = "Greater Healing Potion",
			gfxIndex = 409,
			weight = 1.1,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				champion:regainHealth(150)
				champion:removeCondition("head_wound")
				champion:removeCondition("chest_wound")
				champion:removeCondition("leg_wound")
				champion:removeCondition("feet_wound")
				champion:removeCondition("right_hand_wound")
				champion:removeCondition("left_hand_wound")
				champion:playHealingIndicator()
				if champion:hasTrait("refreshed") then
					champion:setConditionValue("refreshed", 30)
				end
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_energy",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Energy Potion",
			gfxIndex = 145,
			weight = 0.6,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				local mult = iff(champion:hasTrait("arcane_extraction"), 2, 1)
				champion:regainHealth(75*mult)
				champion:playHealingIndicator()
				if champion:hasTrait("refreshed") then
					champion:setConditionValue("refreshed", 30)
				end
				champion:regainEnergy(75*mult)
				champion:playHealingIndicator()
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_greater_energy",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/big_potion.fbx",
		},
		{
			class = "Item",
			uiName = "Greater Energy Potion",
			gfxIndex = 410,
			weight = 1.1,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				champion:regainEnergy(150)
				champion:playHealingIndicator()
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_poison",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Poignant Potion",
			gfxIndex = 147,
			weight = 0.4,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				champion:setCondition("poison")
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_shield",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Shield Potion",
			gfxIndex = 151,
			weight = 0.4,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				champion:setCondition("protective_shield")
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_cure_poison",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Antivenom",
			gfxIndex = 149,
			weight = 0.4,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				champion:removeCondition("poison")
				champion:playHealingIndicator()
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_cure_disease",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Antidote",
			gfxIndex = 148,
			weight = 0.4,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			canBeUsedByDeadChampion = true,
			sound = "consume_potion",
			onUseItem = function(self, champion)
				-- can't be used by dead champion but can be used to cure petrification
				if not champion:isAlive() and not champion:hasCondition("petrified") then
					return false
				end
				champion:removeCondition("diseased")
				champion:removeCondition("paralyzed")
				champion:removeCondition("petrified")
				champion:playHealingIndicator()
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_rage",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Rage Potion",
			gfxIndex = 152,
			weight = 0.4,
			stackable = true,
			traits = { "potion" },
			description = "This potion has a sulphurous stench.",
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				champion:setConditionValue("rage", champion:getConditionValue("rage") + 20)
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_speed",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Speed Potion",
			gfxIndex = 153,
			weight = 0.4,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				champion:setCondition("haste")
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_bear_form",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Potion of Bear Form",
			gfxIndex = 154,
			weight = 0.4,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "polymorph_bear",
			onUseItem = function(self, champion)
				champion:setCondition("bear_form", 1)
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_resurrection",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Item",
			uiName = "Potion of Resurrection",
			gfxIndex = 150,
			weight = 0.4,
			stackable = true,
			gameEffect = "Restores dead character to full health and energy.",
			description = "This potion has a foul stench.",
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			sound = "none",
			canBeUsedByDeadChampion = true,
			onUseItem = function(self, champion)
				-- can't be used on alive champion
				if champion:isAlive() then return false end

				playSound("heal_party")
				champion:setBaseStat("health", champion:getCurrentStat("max_health"))
				champion:setBaseStat("energy", champion:getCurrentStat("max_energy"))
				champion:playHealingIndicator()
			end,
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_strength",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask_large.fbx",
		},
		{
			class = "Item",
			uiName = "Potion of Strength",
			gfxIndex = 414,
			weight = 0.7,
			stackable = true,
			gameEffect = "Permanently increases strength by 1.",
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				champion:upgradeBaseStat("strength", 1)
			end,
		},
		{
			class = "Particle",
			particleSystem = "potion_of_strength",
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_dexterity",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask_large.fbx",
		},
		{
			class = "Item",
			uiName = "Potion of Dexterity",
			gfxIndex = 413,
			weight = 0.7,
			stackable = true,
			gameEffect = "Permanently increases dexterity by 1.",
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				champion:upgradeBaseStat("dexterity", 1)
			end,
		},
		{
			class = "Particle",
			particleSystem = "potion_of_dexterity",
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_vitality",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask_large.fbx",
		},
		{
			class = "Item",
			uiName = "Potion of Vitality",
			gfxIndex = 411,
			weight = 0.7,
			stackable = true,
			gameEffect = "Permanently increases vitality by 1.",
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				champion:upgradeBaseStat("vitality", 1)
			end,
		},
		{
			class = "Particle",
			particleSystem = "potion_of_vitality",
		},
	},
	tags = { "potion" }
}

defineObject{
	name = "potion_willpower",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask_large.fbx",
		},
		{
			class = "Item",
			uiName = "Potion of Willpower",
			gfxIndex = 412,
			weight = 0.7,
			stackable = true,
			gameEffect = "Permanently increases willpower by 1.",
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				champion:upgradeBaseStat("willpower", 1)
			end,
		},
		{
			class = "Particle",
			particleSystem = "potion_of_willpower",
		},
	},
	tags = { "potion" }
}
