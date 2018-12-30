defineObject{
  name = "crystal_shard_protection",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/crystal_shard.fbx",
      material = "crystal_shard_protection",
    },
    {
      class = "Item",
      uiName = "Crystal Shard of Protection",
      gfxIndex = 439,
      weight = 0.3,
      stackable = true,
      gameEffect = "Protects the party against physical damage. Protection +25 for 40 seconds.\n\n[Battle Mage or Knight]:\nThis shield increases your Protection by 50 instead.",
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
        spells_functions.script.addConditionValue("protective_shield", 40)
        spells_functions.script.setConditionIcons("protective_shield", "shield")
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
      model = "assets/models/items/crystal_shard.fbx",
      material = "crystal_shard_recharge",
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

defineObject{
  name = "crystal_shard_enchantment",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/crystal_shard.fbx",
      material = "crystal_shard_enchantment",
    },
    {
      class = "Item",
      uiName = "Crystal Shard of Enchantment",
      gfxAtlas = path.."textures/gui/crystal_shard_enchantment.tga",
      gfxIndex = 0,
      weight = 0.3,
      stackable = true,
      gameEffect = "Needed to cast enchantment spells. Can also be used to randomly get +50% to Concentration, Fire, Air, Water or Earth spell power for 5 minutes.",
    },
    {
      class = "Light",
      offset = vec(0, 0.02, 0),
      range = 0.5,
      color = vec(2.55,1, 0),
      brightness = 10,
      castShadow = false,
      fillLight = true,
    },
    {
      class = "UsableItem",
      sound = "heal_party",
      onUseItem = function(self, champion)
        local tab = {"concentration", "fire_magic", "air_magic", "water_magic", "earth_magic"}
        spells_functions.script.addSkillPower(champion, tab[math.random(#tab)], 50, 300)
      end,
    },
  },
}

defineMaterial{
	name = "crystal_shard_enchantment",
	diffuseMap = "assets/textures/env/healing_crystal_dif.tga",
	specularMap = "assets/textures/env/healing_crystal_dif.tga",
	normalMap = "assets/textures/env/healing_crystal_normal.tga",
	doubleSided = false,
	lighting = true,
	ambientOcclusion = false,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
	
	-- custom shader
	shader = "crystal",
	shadeTex = "assets/textures/items/machine_part_orb_dif.tga",
	shadeTexAngle = 0,
	crystalIntensity = 16,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*0.8)
	end,
}

