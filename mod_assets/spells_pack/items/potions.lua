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
      weight = 0.3,
      stackable = true,
      traits = { "potion" },
    },
    {
      class = "UsableItem",
      sound = "consume_potion",
      onUseItem = function(self, champion)
        spells_functions.script.addConditionValue("protective_shield", 40, champion:getOrdinal())
        spells_functions.script.setConditionIcons("protective_shield", "shield", champion:getOrdinal())
      end,
    },
  },
}
