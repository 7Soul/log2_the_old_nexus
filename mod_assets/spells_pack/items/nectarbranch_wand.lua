defineObject{
  name = "nectarbranch_wand",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/nectarbranch_wand.fbx",
    },
    {
      class = "Item",
      uiName = "Nectarbranch Wand",
      description = "A magic wand made from a branch of the nectartree.",
      gfxIndex = 234,
      impactSound = "impact_blunt",
      weight = 3.5,
      gameEffect = "Water spells power +20%",
      onEquipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "water_magic", slot, 20) -- +20% water magic spells power
      end,
      onUnequipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "water_magic", slot) -- 0% water magic spells power
      end,
    },
    {
      class = "RunePanel",
      requirements = { "concentration", 2 },
    },
    {
      class = "EquipmentItem",
      slot = "Weapon",
      energy = 5,
      willpower = 1,
    },
  },
}