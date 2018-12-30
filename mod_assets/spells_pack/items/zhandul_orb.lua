defineObject{
  name = "zhandul_orb",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/zhandul_orb.fbx",
    },
    {
      class = "Item",
      uiName = "Zhandul's Orb",
      description = "The legendary long lost magical orb of archmage Zhandul The Mad. Intense vortex of fire rages inside the artifact.",
      gfxIndex = 157,
      impactSound = "impact_blunt",
      achievement = "find_zhanduls_orb",
      weight = 2.5,
      secondaryAction = "fireball",
      gameEffect = "Fire spells power +20%",
      onEquipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "fire_magic", slot, 20) -- +20% fire magic spells power
      end,
      onUnequipItem = function(self, champion, slot)
        spells_functions.script.setPower(champion, "fire_magic", slot) -- 0% fire magic spells power
      end,
    },
    {
      class = "RunePanel",
      requirements = { "concentration", 3, "fire_magic", 2 },
    },
    {
      class = "EquipmentItem",
      slot = "Weapon",
      willpower = 5,
      energy = 35,
    },
    {
      class = "CastSpell",
      name = "fireball",
      uiName = "Greater Fireball",
      cooldown = 5,
      spell = "fireball",
      power = 5,
    },
  },
}
