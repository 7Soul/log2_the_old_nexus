defineObject{
  name = "stormseed_orb",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/meteor_orb.fbx",
    },
    {
      class = "Item",
      uiName = "Stormseed Orb",
      description = "This orb emits an almost inaudible rumble as it shakes in your hands.",
      gfxIndex = 326,
      gfxIndexPowerAttack = 451,
      impactSound = "impact_blunt",
      weight = 2.0,
      secondaryAction = "lightningBolt",
      gameEffect = "Air spells power +20%",
      onEquipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "air_magic", slot, 20) -- +20% air magic spells power
      end,
      onUnequipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "air_magic", slot) -- 0% air magic spells power
      end,
    },
    {
      class = "RunePanel",
      requirements = { "concentration", 2 },
    },
    {
      class = "EquipmentItem",
      slot = "Weapon",
      dexterity = 2,
      energy = 15,
    },
    {
      class = "CastSpell",
      name = "lightningBolt",
      uiName = "Lightning Bolt",
      spell = "lightning_bolt",
      power = 1,
      energyCost = 25,
      charges = 9,
      requirements = { "concentration", 2 },
    },
  },
}