defineObject{
	name = "sack",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/sack_empty.fbx",
		},
		{
			class = "Item",
			uiName = "Sack",
			gfxIndex = 82,
			gfxIndexContainer = 482,
			weight = 0.4,
			fitContainer = false,
		},
		{
			class = "ContainerItem",
			containerType = "sack",
			openSound = "container_sack_open",
			closeSound = "container_sack_close",
			onInit = function(self)
				if self:getItemCount() > 0 then
					self.go.model:setModel("assets/models/items/sack_full.fbx")
					self.go.item:setGfxIndex(81)
					self.go.item:updateBoundingBox()
				end
			end,			
			onInsertItem = function(self, item)
				-- convert to full sack
				if self.go.item:getGfxIndex() == 82 then
					self.go.model:setModel("assets/models/items/sack_full.fbx")
					self.go.item:setGfxIndex(81)
					self.go.item:updateBoundingBox()
				end
			end,
			onRemoveItem = function(self, item)
				-- convert to empty sack when last item is removed
				if self:getItemCount() == 0 and self.go.item:getGfxIndex() == 81 then
					self.go.model:setModel("assets/models/items/sack_empty.fbx")
					self.go.item:setGfxIndex(82)
					self.go.item:updateBoundingBox()
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
}

defineObject{
	name = "wooden_box",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/wooden_box.fbx",
		},
		{
			class = "Item",
			uiName = "Wooden Box",
			gfxIndex = 83,
			gfxIndexContainer = 483,
			weight = 3.0,
			fitContainer = false,
		},
		{
			class = "ContainerItem",
			containerType = "chest",
			openSound = "container_box_open",
			closeSound = "container_box_close",
		},
	},
}
