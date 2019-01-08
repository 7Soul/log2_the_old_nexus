defineObject{
	name = "crystal_shard_healing",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_shard.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Shard of Healing",
			gfxIndex = 437,
			weight = 0.3,
			stackable = true,
			gameEffect = "Heals all wounds and raises dead champions back to life.",
		},
		{
			class = "Light",
			offset = vec(0, 0.02, 0),
			range = 0.5,
			color = vec(0.8, 1.66, 2.55),
			brightness = 10,
			castShadow = false,
			fillLight = true,
		},
		{
			class = "UsableItem",
			sound = "none",
			canBeUsedByDeadChampion = true,
			onUseItem = function(self, champion)
				party.party:heal()
			end,
		},
	},
}

defineObject{
	name = "crystal_shard_protection",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_shard_protection.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Shard of Protection",
			gfxIndex = 439,
			weight = 0.3,
			stackable = true,
			gameEffect = "Protects the party against physical damage. Protection +25 for 40 seconds.",
		},
		{
			class = "Light",
			offset = vec(0, 0.02, 0),
			range = 0.5,
			color = vec(0,2.55, 0),
			brightness = 10,
			castShadow = false,
			fillLight = true,
		},
		{
			class = "UsableItem",
			sound = "heal_party",
			onUseItem = function(self, champion)
				for i=1,4 do
					local champion = party.party:getChampion(i)
					champion:setCondition("protective_shield", 1)
				end
			end,
		},
	},
}

defineObject{
	name = "crystal_shard_recharging",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/crystal_shard_recharge.fbx",
		},
		{
			class = "Item",
			uiName = "Crystal Shard of Recharging",
			gfxIndex = 438,
			weight = 0.3,
			stackable = true,
			gameEffect = "Recharges a magical item to its full capacity. Works only on items with charges.",
			description = "This crystal shard is loaded with raw energy. It makes your fingertips tingle.",
		},
		{
			class = "Light",
			offset = vec(0, 0.02, 0),
			range = 0.5,
			color = vec(2.55, 0, 0.25),
			brightness = 10,
			castShadow = false,
			fillLight = true,
		},
		{
			class = "UsableItem",
			sound = "heal_party",
			onUseItem = function(self, champion)
				local slot
				if champion:getItem(ItemSlot.Weapon) == self.go.item then slot = 1 end
				if champion:getItem(ItemSlot.OffHand) == self.go.item then slot = 2 end

				if not slot then
					hudPrint(champion:getName().." needs to hold the crystal shard in hand.")
					return false
				end

				local otherItem = champion:getOtherHandItem(slot)
				if not otherItem then
					hudPrint(champion:getName().." needs a rechargeable item in hand.")
					return false
				end
				
				-- find rechargeable component
				local comp
				for _,component in otherItem.go:componentIterator() do
					if component.recharge and component.getCharges then
						comp = component
						break
					end
				end	

				if not comp then
					hudPrint(champion:getName().." needs a rechargeable item in hand.")
					return false
				end

				if comp:getCharges() == comp:getMaxCharges() then
					hudPrint(otherItem:getUiName().." is already fully charged!")
					return false
				end
	
				comp:recharge()
				hudPrint(champion:getName().." recharged "..otherItem:getUiName().." to its full capacity.")
				return true				
			end,
		},
	},
}
