defineObject{
  name = "magic_orb",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/apprentice_orb.fbx",
    },
    {
      class = "Item",
      uiName = "Orb of Radiance",
      description = "A smooth orb that radiates shimmering blue light. A tingling sensation passes through your body when you touch it.",
      gfxIndex = 69,
      gfxIndexPowerAttack = 452,
      impactSound = "impact_blunt",
      weight = 2.0,
      secondaryAction = "light",
      gameEffect = "Concentration spells power +20%",
      onEquipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "concentration", slot, 20) -- +20% concentration spells power
      end,
      onUnequipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "concentration", slot) -- 0% concentration spells power
      end,
    },
    {
      class = "RunePanel",
      requirements = { "concentration", 1 },
    },
    {
      class = "EquipmentItem",
      slot = "Weapon",
      energy = 15,
    },
    {
      class = "CastSpell",
      name = "light",
      uiName = "Light",
      spell = "light",
      energyCost = 25,
      power = 3,
      requirements = { "concentration", 1 },
    },
  },
}
