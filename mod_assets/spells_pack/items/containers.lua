defineObject{
  name = "bottomless_sack",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/sack_empty.fbx",
    },
    {
      class = "Particle",
      particleSystem = "magic_sack",
    },
    {
      class = "Item",
      uiName = "Bottomless Sack",
      gfxIndex = 82,
      gfxIndexContainer = 482,
      weight = 0.4,
      fitContainer = false,
    },
    {
      class = "ContainerItem",
      containerType = "chest",
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
        if self.go.data.get then
          self.go.data:set(item.go.id, item:getWeight())
          item:setWeight(item:getWeight()*self.go.data:get("factor"))
        end
      end,
      onRemoveItem = function(self, item)
        -- convert to empty sack when last item is removed
        if self:getItemCount() == 0 and self.go.item:getGfxIndex() == 81 then
          self.go.model:setModel("assets/models/items/sack_empty.fbx")
          self.go.item:setGfxIndex(82)
          self.go.item:updateBoundingBox()
        end
        if self.go.data.get then
          local w = self.go.data:get(item.go.id)
          if w then item:setWeight(w) self.go.data:set(item.go.id, nil) end
        end
      end,
    },
    { class = "Script",
      name = "data",
      source = [[
        data = {factor=1}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
        function intSize(self) return #self.data end
      ]],      
    },
  },
}

defineObject{
  name = "sack",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/sack_empty.fbx",
    },
    {
      class = "Particle",
      particleSystem = "magic_sack",
      onInit = function(self) self:disable() end,
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
        if self.go.data.get then
          self.go.data:set(item.go.id, item:getWeight())
          item:setWeight(item:getWeight()*self.go.data:get("factor"))
        end
      end,
      onRemoveItem = function(self, item)
        -- convert to empty sack when last item is removed
        if self:getItemCount() == 0 and self.go.item:getGfxIndex() == 81 then
          self.go.model:setModel("assets/models/items/sack_empty.fbx")
          self.go.item:setGfxIndex(82)
          self.go.item:updateBoundingBox()
        end
        if self.go.data.get then
          local w = self.go.data:get(item.go.id)
          if w then item:setWeight(w) self.go.data:set(item.go.id, nil) end
        end
      end,
    },
    { class = "Script",
      name = "data",
      source = [[
        data = {factor=1}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
        function intSize(self) return #self.data end
      ]],      
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
      class = "Particle",
      particleSystem = "magic_box",
      onInit = function(self) self:disable() end,
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
      onInsertItem = function(self, item)
        if self.go.data.get then
          self.go.data:set(item.go.id, item:getWeight())
          item:setWeight(item:getWeight()*self.go.data:get("factor"))
        end
      end,
      onRemoveItem = function(self, item)
        if self.go.data.get then
          local w = self.go.data:get(item.go.id)
          if w then item:setWeight(w) self.go.data:set(item.go.id, nil) end
        end
      end,
    },
    { class = "Script",
      name = "data",
      source = [[
        data = {factor=1}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
        function intSize(self) return #self.data end
      ]],      
    },
  },
}

defineParticleSystem{
  name = "magic_sack",
  emitters = {
    -- stars
    {
      emissionRate = 20,
      emissionTime = 0,
      maxParticles = 20,
      boxMin = {-0.3, 0.0,-0.3},
      boxMax = { 0.3, 0.3, 0.3},
      sprayAngle = {0,360},
      velocity = {0,0},
      objectSpace = true,
      texture = "assets/textures/particles/firefly_dif.tga",
      lifetime = {0.5,1.0},
      color0 = {0.2, 0.4, 4},
      opacity = 1,
      fadeIn = 0.1,
      fadeOut = 1.0,
      size = {0.05, 0.1},
      gravity = {0,0.5,0},
      airResistance = 0.1,
      rotationSpeed = 5,
      blendMode = "Additive",
    },
    -- smoke
    {
      emissionRate = 4,
      emissionTime = 0,
      maxParticles = 4,
      boxMin = {-0.3, 0, -0.3},
      boxMax = { 0.3, 0.3, 0.3},
      sprayAngle = {0,20},
      velocity = {0, 0},
      objectSpace = true,
      texture = "assets/textures/particles/smoke_01.tga",
      lifetime = {0.5,1.0},
      color0 = {0.25, 0.20, 3.17},
      opacity = 0.25,
      fadeIn = 0.3,
      fadeOut = 0.9,
      size = {0.25, 0.5},
      gravity = {0,0.5,0},
      airResistance = 0.1,
      rotationSpeed = 0.5,
      blendMode = "Translucent",
    },
  }
}

defineParticleSystem{
  name = "magic_box",
  emitters = {
    -- stars
    {
      emissionRate = 20,
      emissionTime = 0,
      maxParticles = 20,
      boxMin = {-0.6, 0.0,-0.6},
      boxMax = { 0.6, 0.6, 0.6},
      sprayAngle = {0,360},
      velocity = {0,0},
      objectSpace = true,
      texture = "assets/textures/particles/firefly_dif.tga",
      lifetime = {0.5,1.0},
      color0 = {0.2, 0.4, 4},
      opacity = 1,
      fadeIn = 0.1,
      fadeOut = 1.0,
      size = {0.05, 0.1},
      gravity = {0,0.5,0},
      airResistance = 0.1,
      rotationSpeed = 5,
      blendMode = "Additive",
    },
    -- smoke
    {
      emissionRate = 4,
      emissionTime = 0,
      maxParticles = 4,
      boxMin = {-0.6, 0, -0.6},
      boxMax = { 0.6, 0.6, 0.6},
      sprayAngle = {0,20},
      velocity = {0, 0},
      objectSpace = true,
      texture = "assets/textures/particles/smoke_01.tga",
      lifetime = {0.5,1.0},
      color0 = {0.25, 0.20, 3.17},
      opacity = 0.25,
      fadeIn = 0.3,
      fadeOut = 0.9,
      size = {0.25, 0.5},
      gravity = {0,0.5,0},
      airResistance = 0.1,
      rotationSpeed = 0.5,
      blendMode = "Translucent",
    },
  }
}