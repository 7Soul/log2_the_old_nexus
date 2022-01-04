-- defineObject{
-- 	name = "flask",
-- 	baseObject = "base_item",
-- 	components = {
-- 		{
-- 			class = "Model",
-- 			model = "assets/models/items/flask.fbx",
-- 		},
-- 		{
-- 			class = "Item",
-- 			uiName = "Flask (empty)",
-- 			gfxIndex = 143,
-- 			weight = 0.1,
-- 		},
-- 	},
-- 	tags = { "potion" }
-- }

-- defineObject{
-- 	name = "water_flask",
-- 	baseObject = "base_item",
-- 	components = {
-- 		{
-- 			class = "Model",
-- 			model = "assets/models/items/flask.fbx",
-- 		},
-- 		{
-- 			class = "Item",
-- 			uiName = "Water Flask",
-- 			gfxIndex = 144,
-- 			weight = 0.3,
-- 			traits = { "potion" },
-- 		},
-- 		{
-- 			class = "UsableItem",
-- 			--emptyItem = "flask",
-- 			sound = "consume_potion",
-- 		},
-- 	},
-- 	tags = { "potion" }
-- }

defineObject{
	name = "potion_healing",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flask.fbx",
		},
		{
			class = "Script",
			name = "potion_stack",
			source = [[data = {}
function getTop(self)	return self.data[#data] end
function getData(self)	return data end
function set(self,id,value)	self.data[id] = value end
function print_data(self)
	for i=1,#data do
		print(data[i])
	end
end
function insert(self,value)	table.insert(data, value) table.sort(data) end
function remove(self)	table.remove(data) end
]],
		},
		{
			class = "Item",
			uiName = "Healing Potion",
			description = "Heals 50 Health over 16 seconds, healing cuts and wounds over time.",
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
				champion:playHealingIndicator()
				local duration = 16
				if self.go.potion_stack:getTop() == "perfect" then
					duration = 20
					champion:setConditionValue("healing_potion", duration)
				else
					champion:setConditionValue("healing_potion", duration)
				end
				
				functions.script.drinkPotion(self, champion, duration)
				
				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
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
			class = "Script",
			name = "potion_stack",
			source = [[data = {}
function getTop(self)	return self.data[#data] end
function getData(self)	return data end
function set(self,id,value)	self.data[id] = value end
function print_data(self)
	for i=1,#data do
		print(data[i])
	end
end
function insert(self,value)	table.insert(data, value) table.sort(data) end
function remove(self)	table.remove(data) end
]],
		},
		{
			class = "Item",
			uiName = "Greater Healing Potion",
			description = "Heals 150 Health over 8 seconds, healing cuts and wounds over time.",
			gfxIndex = 409,
			weight = 1.0,
			stackable = true,
			traits = { "potion" },
		},
		{
			class = "UsableItem",
			--emptyItem = "flask",
			sound = "consume_potion",
			onUseItem = function(self, champion)
				champion:playHealingIndicator()

				local duration = 8
				if self.go.potion_stack:getTop() == "perfect" then
					duration = 10
					champion:setConditionValue("healing_potion2", duration)
				else
					champion:setConditionValue("healing_potion2", duration)
				end
				
				functions.script.drinkPotion(self, champion, duration)

				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
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
			class = "Script",
			name = "potion_stack",
			source = [[data = {}
function getTop(self)	return self.data[#data] end
function getData(self)	return data end
function set(self,id,value)	self.data[id] = value end
function print_data(self)
	for i=1,#data do
		print(data[i])
	end
end
function insert(self,value)	table.insert(data, value) table.sort(data) end
function remove(self)	table.remove(data) end
]],
		},
		{
			class = "Item",
			uiName = "Energy Potion",
			description = "Recovers 60 Energy over 16 seconds.",
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
				champion:playHealingIndicator()

				local duration = 16
				if self.go.potion_stack:getTop() == "perfect" then
					duration = 20
					champion:setConditionValue("energy_potion", duration)
				else
					champion:setConditionValue("energy_potion", duration)
				end
				
				functions.script.drinkPotion(self, champion, duration)

				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
				end
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
			class = "Script",
			name = "potion_stack",
			source = [[data = {}
function getTop(self)	return self.data[#data] end
function getData(self)	return data end
function set(self,id,value)	self.data[id] = value end
function print_data(self)
	for i=1,#data do
		print(data[i])
	end
end
function insert(self,value)	table.insert(data, value) table.sort(data) end
function remove(self)	table.remove(data) end
]],
		},
		{
			class = "Item",
			uiName = "Greater Energy Potion",
			description = "Recovers 120 Energy over 8 seconds.",
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
				champion:playHealingIndicator()

				local duration = 8
				if self.go.potion_stack:getTop() == "perfect" then
					duration = 10
					champion:setConditionValue("energy_potion2", duration)
				else
					champion:setConditionValue("energy_potion2", duration)
				end
				
				functions.script.drinkPotion(self, champion, duration)
				
				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
				end
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
				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
				end
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
				champion:setConditionValue("protective_shield", 50)
				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
				end
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
				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
				end
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
				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
				end
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
				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
				end
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
				local duration = 50
				if champion:getItem(ItemSlot.Cloak) and champion:getItem(ItemSlot.Cloak).go.name == "diviner_cloak" then
					champion:regainEnergy(champion:getItem(ItemSlot.Cloak):hasTrait("upgraded") and 40 or 20)
				end
				if champion:getItem(ItemSlot.Feet) and champion:getItem(ItemSlot.Feet).go.name == "rogue_boots_2" then
					duration = duration * 2
				end
				if functions.script.isArmorSetEquipped(champion, "rogue") then
					duration = duration * 2
				end
				champion:setConditionValue("haste", duration)
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
				if champion:getClass() == "monk" then
					hudPrint("Can't be used by a Champion.")
					return false
					--local stat = functions.script.get_c("monkstrength", champion:getOrdinal()) and functions.script.get_c("monkstrength", champion:getOrdinal()) or 0
					--functions.script.set_c("monkstrength", champion:getOrdinal(), stat + 1)
				end
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
				if champion:getClass() == "monk" then
					hudPrint("Can't be used by a Champion.")
					return false
					-- local stat = functions.script.get_c("monkdexterity", champion:getOrdinal()) and functions.script.get_c("monkdexterity", champion:getOrdinal()) or 0
					-- functions.script.set_c("monkdexterity", champion:getOrdinal(), stat + 1)
				end
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
				if champion:getClass() == "monk" then
					hudPrint("Can't be used by a Champion.")
					return false
					-- local stat = functions.script.get_c("monkvitality", champion:getOrdinal()) and functions.script.get_c("monkvitality", champion:getOrdinal()) or 0
					-- functions.script.set_c("monkvitality", champion:getOrdinal(), stat + 1)
				end
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
				if champion:getClass() == "monk" then
					hudPrint("Can't be used by a Champion.")
					return false
					-- local stat = functions.script.get_c("monkwillpower", champion:getOrdinal()) and functions.script.get_c("monkwillpower", champion:getOrdinal()) or 0
					-- functions.script.set_c("monkwillpower", champion:getOrdinal(), stat + 1)
				end
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
