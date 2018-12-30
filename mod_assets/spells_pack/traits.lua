defineTrait{
  name = "spirit",
  uiName = "Spirit",
  icon = 26,
  description = "Your Energy regenerates 25% faster. All critical spells generate one additional arcanic power charge.",
  onRecomputeStats = function(champion, level)
    if level > 0 then
      champion:addStatModifier("energy_regeneration_rate", 25)
    end
  end,
}

defineTrait{
  name = "fire_sword",
  uiName = "Fire Sword",
  icon = 3,
  description = "Your sword melee attacks have a chance to launch the fireburst spell for free.",
}

defineTrait{
  name = "fire_mastery",
  uiName = "Fire Mastery",
  icon = 29,
  description = "You gain up to Resist Fire +50. All spells gain 15% additional critical chance.",
  onRecomputeStats = function(champion, level)
    if level > 0 then
      champion:addStatModifier("resist_fire", 50)
    end
  end,
}

defineTrait{
  name = "thunder_hammer",
  uiName = "Thunder Hammer",
  icon = 2,
  description = "Your mace melee attacks have a chance to launch the shockburst spell for free.",
}

defineTrait{
  name = "air_mastery",
  uiName = "Air Mastery",
  icon = 30,
  description = "You gain up to Resist Shock +50. All critical spells get 200% power instead of 150%.",
  onRecomputeStats = function(champion, level)
    if level > 0 then
      champion:addStatModifier("resist_shock", 50)
    end
  end,
}

defineTrait{
  name = "poisoned_dagger",
  uiName = "Poisoned Dagger",
  icon = 88,
  description = "Your dagger melee attacks have a chance to launch the poison cloud spell for free.",
}

defineTrait{
  name = "earth_mastery",
  uiName = "Earth Mastery",
  icon = 31,
  description = "You gain up to Resist Poison +50. All critical spells heal you for 20% of their energy cost.",
  onRecomputeStats = function(champion, level)
    if level > 0 then
      champion:addStatModifier("resist_poison", 50)
    end
  end,
}

defineTrait{
  name = "frost_axe",
  uiName = "Frost Axe",
  icon = 1,
  description = "Your axe melee attacks have a chance to launch the frostburst spell for free.",
}

defineTrait{
  name = "water_mastery",
  uiName = "Water Mastery",
  icon = 32,
  description = "You gain up to Resist Cold +50. All critical spells restore 20% of their energy cost.",
  onRecomputeStats = function(champion, level)
    if level > 0 then
      champion:addStatModifier("resist_cold", 50)
    end
  end,
}
