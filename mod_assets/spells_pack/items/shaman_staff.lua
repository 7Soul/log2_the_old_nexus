defineObject{
  name = "shaman_staff",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/shaman_staff.fbx",
    },
    {
      class = "Item",
      uiName = "Shaman Staff",
      description = "A rune covered staff with a pulsating poison green gem attached to its tip. You can sense great power in it.",
      gfxIndex = 1,
      gfxIndexPowerAttack = 440,
      impactSound = "impact_blunt",
      weight = 3.3,
      secondaryAction = "poisonBolt",
      gameEffect = "Earth spells power +20%",
      onEquipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "earth_magic", slot, 20) -- +20% earth magic spells power
      end,
      onUnequipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "earth_magic", slot) -- 0% earth magic spells power
      end,
    },
    {
      class = "RunePanel",
      requirements = { "concentration", 2 },
    },
    {
      class = "EquipmentItem",
      slot = "Weapon",
      vitality = 2,
      energy = 25,
    },
    {
      class = "CastSpell",
      name = "poisonBolt",
      uiName = "Poison Bolt",
      cooldown = 5,
      spell = "poison_bolt",
      energyCost = 25,
      power = 3,
      requirements = { "concentration", 2 },
    },
  },
}
