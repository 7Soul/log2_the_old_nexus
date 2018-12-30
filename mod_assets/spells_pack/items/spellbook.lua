defineObject{
  name = "spellbook",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/tome.fbx",
      material = "spellbook",
    },
    {
      class = "Item",
      uiName = "Spellbook",
      gfxAtlas = path.."textures/gui/spellbook.tga",
      gfxIndex = 0,
      gfxIndexContainer = 0,
      weight = 1.0,
      description = "A thick book with enough space for hundreds of incantations. Whenever a new spell is found, it will be transcribed in the spellbook automatically.",
      traits = {"fixed_container"},
      fitContainer = false,
      onInit = function(self) delayedCall("spells_functions", 0, "initBookId", self.go.id) end
    },
    {
      class = "ContainerItem",
      containerType = "chest",
      openSound = "map_turn_page",
      closeSound = "map_turn_page",
    },
    {
      class = "RunePanel",
    },
  },
}

defineMaterial{
  name = "spellbook",
  diffuseMap = path.."textures/spellbook_dif.tga",
  specularMap = "assets/textures/common/black.tga",
  doubleSided = false,
  lighting = true,
  alphaTest = false,
  blendMode = "Opaque",
  textureAddressMode = "Wrap",
  glossiness = 20,
  depthBias = 0,
}

defineObject{
  name = "spellbook_desc",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarterstaff.fbx",
      enabled = false,
    },
    {
      class = "Item",
      uiName = "IF YOU SEE THIS, IT IS A BUG",
      gfxIndex = 0,
      weight = 0,
    },
    {
      class = "SpellScrollItem",
      spell = "fireburst",
    },
  },
}

defineObject{
  name = "spellbook_rarrow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarterstaff.fbx",
      enabled = false,
    },
    {
      class = "Item",
      uiName = "Next Page",
      gfxAtlas = path.."textures/gui/spellbook.tga",
      gfxIndex = 1,
      weight = 0,
    },
  },
}

defineObject{
  name = "spellbook_larrow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarterstaff.fbx",
      enabled = false,
    },
    {
      class = "Item",
      uiName = "Previous Page",
      gfxAtlas = path.."textures/gui/spellbook.tga",
      gfxIndex = 2,
      weight = 0,
    },
  },
}

-- HACK: store the spells here instead of the main spellbook object, because
-- if player clicks on an object with multipleContainerItems they all open at
-- once
storeDef = {
  name = "spellbook_storageitem",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarterstaff.fbx",
      enabled = false,
    },
  },
}

for i = 1,PAGE_COUNT do
  storeDef.components[#storeDef.components+1] =
  {
    class = "ContainerItem",
    name = "page"..i,
    containerType = "chest",
    openSound = "min_silence",
    closeSound = "min_silence",
  }
end

defineObject(storeDef)