-- Lexicon, Encyclopedia, Codex, Atlas, Opus, Tract

defineObject{
	name = "tome_health",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Tome of Health",
			description = "A thick tome that thoroughly describes the diet and excercises of the hermits of Basabua.",
			gfxIndex = 30,
			weight = 1.0,
			gameEffect = "Health +25",
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." gained Health +25.")
				champion:modifyBaseStat("max_health", 25)
				champion:modifyBaseStat("health", 25)
				return true
			end,
		},
	},
}

defineObject{
	name = "tome_energy",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Tome of Energy",
			description = "Each page of this tome contains a single, large rune that pulsates with power.",
			gfxIndex = 30,
			weight = 1.0,
			gameEffect = "Energy +25",
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." gained Energy +25.")
				champion:modifyBaseStat("max_energy", 25)
				champion:modifyBaseStat("energy", 25)
				return true
			end,
		},
	},
}

defineObject{
	name = "tome_wisdom",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Tome of Knowledge",
			description = "The keepers of the sunken library record the knowledge of all their visitors in these journals.",
			gfxIndex = 30,
			weight = 1.0,
			gameEffect = "Gain 1 skillpoint",
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." gained a skillpoint.")
				champion:addSkillPoints(1)
				return true
			end,
		},
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
				hudPrint(champion:getName().." gained Resist Fire +20.")
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
				hudPrint(champion:getName().." gained Resist Poison +20.")
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
				hudPrint(champion:getName().." gained Resist Cold +20.")
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
				hudPrint(champion:getName().." gained Resist Shock +20.")
				champion:modifyBaseStat("resist_shock", 20)
				return true
			end,
		},
	},
}

defineObject{
	name = "tome_leadership",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Tome of Leadership",
			description = "This thick book is filled with the teachings of legendary generals, enlightened spiritual leaders and wise sages.",
			gfxIndex = 30,
			weight = 1.0,
			gameEffect = "Gain Party Leader trait. Other party members receive +1 bonus to all attributes as long as the party leader is alive.",
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." gained Party Leader trait!")
				champion:addTrait("leadership")
				return true
			end,
		},
	},
}

defineObject{
	name = "tome_moon",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/tome.fbx",
		},
		{
			class = "Item",
			uiName = "Rites of the Moon",
			description = "The pages of this book are scribbled full of unknown ancient runes and vivid descriptions of dark rituals.",
			gfxIndex = 30,
			weight = 1.0,
			traits = { "tome" },
		},
		{
			class = "UsableItem",
			sound = "level_up",
			onUseItem = function(self, champion)
				hudPrint(champion:getName().." is somehow changed.")
				champion:addTrait("nightstalker")
				return true
			end,
		},
	},
}

-- Tome of Knowing
-- Tome of Body Building
-- Tome of Agility
-- Encyclopedia of Armors
-- Knights & Chivalry
-- Book of Bucklers
-- Handbook for Tavern Brawlers
