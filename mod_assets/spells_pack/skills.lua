-- defineSkill{
  -- name = "concentration",
  -- uiName = "Concentration",
  -- priority = 200,
  -- icon = 26,
  -- description = "Increases your energy by 20 for each skill point. At 3rd skill level your Energy regeneration rate is increased by 25% while resting. At 5th skill level your Energy regenerates 25% faster and all critical spells generate arcanic power.",
  -- onRecomputeStats = function(champion, level)
    -- champion:addStatModifier("max_energy", level*20)
  -- end,
  -- traits = { [3] = "meditation", [5] = "spirit" },
-- }

-- defineSkill{
  -- name = "critical",
  -- uiName = "Critical",
  -- priority = 200,
  -- icon = 10,
  -- description = "Improves your chance of scoring a critical hit with spells and melee, ranged, throwing or firearm attacks by 3% for each skill point. At 3rd level you can backstab an enemy with a dagger and deal triple damage. At 5th level you can backstab with any Light Weapon.",
  -- onComputeCritChance = function(champion, weapon, attack, attackType, level)
    -- return level * 3
  -- end,
  -- traits = { [3] = "backstab", [5] = "assassin" },
-- }

-- defineSkill{
  -- name = "fire_magic",
  -- uiName = "Fire Magic",
  -- priority = 200,
  -- icon = 29,
  -- description = "Increases damage of fire spells by 20% for each skill point. At 3rd skill level your sword melee attacks have 5% chance to launch the fireburst spell per cooldown second. At 5th skill level you gain up to Resist Fire +50 and 15% critical spells chance.",
  -- traits = { [3] = "fire_sword", [5] = "fire_mastery" },
-- }

-- defineSkill{
  -- name = "air_magic",
  -- uiName = "Air Magic",
  -- priority = 200,
  -- icon = 30,
  -- description = "Increases damage of air spells by 20% for each skill point. At 3rd skill level your mace melee attacks have 5% chance to launch the shockburst spell per cooldown second. At 5th skill level you gain up to Resist Shock +50 and critical spells get 200% power instead of 150%.",
  -- traits = { [3] = "thunder_hammer", [5] = "air_mastery" },
-- }

-- defineSkill{
  -- name = "earth_magic",
  -- uiName = "Earth Magic",
  -- priority = 200,
  -- icon = 31,
  -- description = "Increases damage of earth spells by 20% for each skill point. At 3rd skill level your dagger melee attacks have 5% chance to launch the poison cloud spell per cooldown second. At 5th skill level you gain up to Resist Poison +50 and critical spells heal you for 20% of their energy cost.",
  -- traits = { [3] = "poisoned_dagger", [5] = "earth_mastery" },
-- }

-- defineSkill{
  -- name = "water_magic",
  -- uiName = "Water Magic",
  -- priority = 200,
  -- icon = 32,
  -- description = "Increases damage of water spells by 20% for each skill point. At 3rd skill level your axe melee attacks have 5% chance to launch the frostburst spell per cooldown second. At 5th skill level you gain up to Resist Cold +50 and critical spells restore 20% of their energy cost.",
  -- traits = { [3] = "frost_axe", [5] = "water_mastery" },
-- }