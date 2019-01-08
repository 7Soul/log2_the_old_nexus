version = "3.2"

-- Options
path = "mod_assets/spells_pack/" -- The path containing all ressources for the spells pack.
                                 -- If you change it, you must also change it at the beginning of init.lua.
starting_spells_level = 0        -- The maximum total requirements of the starting spells in the spellbook.



defOrdered =
{ 

{
  name = "psionic_arrow",
  uiName = "Psionic Arrow",
  gesture = 0,
  manaCost = 10,
  skill = "missile_weapons",
  requirements = {  },
  icon = 61,
  spellIcon = 7,
  hidden = true,
  description = "",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local power = spells_functions.script.getPower(1, champion, "missile_weapons")	
    local ord = champion:getOrdinal()
    spells_functions.script.missile("psionic_arrow", ord, power, nil, true)
    spells_functions.script.stopInvisibility()
  end
},

-- concentration

{
  name = "shield",
  uiName = "Shield",
  gesture = 456,
  manaCost = 35,
  skill = "concentration",
  requirements = {"concentration", 1},
  icon = 102,
  spellIcon = 19,
  description = "Creates a magical shield around you. The shield protects from physical damage by increasing your Protection by 25. Only duration is cumulative.\n- Cost : 35 energy\n- Duration : 40 seconds\n\n[Accuracy 3]:\nAffects all champions.\n\n[Battle Mage or Knight]:\nThis shield increases your Protection by 50 instead, whoever casts it.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(40, champion, "concentration")
    spells_functions.script.addConditionValue("protective_shield", duration, champion:getSkillLevel("accuracy") < 3 and champion:getOrdinal())
    spells_functions.script.setConditionIcons("protective_shield", "shield")
  end
},

{
  name = "dispel",
  uiName = "Dispel",
  gesture = 4,
  manaCost = 42,
  skill = "concentration",
  requirements = {"concentration", 1},
  icon = 72,
  spellIcon = 13,
  description = "Shoots a ray that damages elementals. \n- Cost : 42 energy\n- Power : 25",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    -- local item = getMouseItem()
    -- if item then
      -- if item:hasTrait("epic") then
        -- playSound("spell_fizzle")
        -- hudPrint("Epic items cannot be disenchanted.")
        -- return false
      -- end
      -- if item.go.equipmentitem or item.go.firearmattack or item.go.meleeattack or item.go.rangedattack then
        -- playSound("generic_spell")
        -- local power = spells_functions.script.quantumPower(1, champion, "concentration")
        -- local item = spawn("crystal_shard_enchantment").item
        -- item:setStackSize(power)
        -- setMouseItem(item)
      -- else
        -- playSound("spell_fizzle")
        -- hudPrint("This item cannot be disenchanted.")
        -- return false
      -- end
    -- else
	local power = spells_functions.script.getPower(25, champion, "concentration")
	spells_functions.script.missile("dispel_cast", champion:getOrdinal(), power)
	spells_functions.script.stopInvisibility()
    -- end
  end
},

{
  name = "force_field",
  uiName = "Force Field",
  gesture = 147896321,
  manaCost = 35,
  skill = "concentration",
  requirements = {"concentration", 2},
  icon = 101,
  spellIcon = 5,
  description = "Creates a magical barrier that blocks all movement.\n- Cost : 35 energy\n- Duration : 12 seconds",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local duration = spells_functions.script.getPower(12, champion, "concentration")
    spells_functions.script.frontAttack("force_field", duration, champion:getOrdinal(), false)
    spells_functions.script.insertEffectIcons("force_field", duration)
  end
},

{
  name = "light",
  uiName = "Light",
  gesture = 25,
  manaCost = 35,
  skill = "concentration",
  requirements = {"concentration", 2},
  icon = 58,
  spellIcon = 18,
  description = "Conjures a dancing ball of light that illuminates your path. The color depends on your magic skills levels, and brightness on Concentration. Stops the Darkness spell effect.\n- Cost : 35 energy\n- Duration : 5 minutes\n\n[Knight]:\nDeals moderate damage, blinds ennemies and force undeads to flee on cast.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("light")
    local duration = spells_functions.script.getPower(300, champion, "concentration")
    GameMode.fadeOut(0xFFFFFF, 0)
    GameMode.fadeIn(0xFFFFFF, 1)
    spells_functions.script.darknessStop()
    local c = 5*spells_functions.script.getSkillPower(champion, "concentration")
    local f = 5*spells_functions.script.getSkillPower(champion, "elemental_magic")
    local a = 5*spells_functions.script.getSkillPower(champion, "elemental_magic")
    local w = 5*spells_functions.script.getSkillPower(champion, "elemental_magic")
    local e = 5*spells_functions.script.getSkillPower(champion, "poison_mastery")
    local r = 1 + c + 88*f + 24*a +  1*w + 19*e
    local g = 1 + c + 10*f + 10*a + 33*w + 79*e
    local b = 1 + c +  1*f + 65*a + 65*w +  1*e
    local m = math.max(r, g, b)
    r=r/m g=g/m b=b/m
    local brightness = 10*(1+c)/(3+c)
    spells_functions.script.partyLight("light_spell", duration, vec(r, g, b), brightness)
    if champion:hasTrait("monk") then
      -- spawns <effects> around entity <centerID> up to <range> tiles on xy plan,
      -- and elevation if <sphere> is true, in <duration> seconds,
      -- with <power> decreasing with squared distance, cast by <ordinal> champion,
      -- checking line of fire if <checkMode> ~= "NA".
      -- function zoneEffects(effects, centerID, range, sphere, duration, power, ordinal, checkMode)
      spells_functions.script.zoneEffects("holy_light", "party", 5*(1+c)/(2+c), false, 0, 5+c, champion:getOrdinal())
      spells_functions.script.partyLight("holy_light", 1, vec(r, g, b), brightness*10)
    end
    spells_functions.script.stopInvisibility()
    spells_functions.script.removeEffectIcons("darkness")
    spells_functions.script.maxEffectIcons("light", duration)
  end
},

{
  name = "darkness",
  uiName = "Darkness",
  gesture = 85,
  manaCost = 25,
  skill = "concentration",
  requirements = {"concentration", 3},
  icon = 59,
  spellIcon = 11,
  description = "Negates all magical and non-magical light sources carried by your party.\n- Cost : 25 energy\n- Duration : 5 minutes",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(300, champion, "concentration")
    GameMode.fadeOut(0, 0)
    GameMode.fadeIn(0, 1)
    spells_functions.script.partyLightStopAll("light_spell")
    spells_functions.script.darknessStart(duration)
    if champion:hasTrait("evasive") then spells_functions.script.addConditionValue("invisibility", duration/10) end
    spells_functions.script.removeEffectIcons("light")
    spells_functions.script.maxEffectIcons("darkness", duration)
  end
},

{
  name = "darkbolt",
  uiName = "Darkbolt",
  gesture = 854,
  manaCost = 25,
  skill = "concentration",
  requirements = {"concentration", 3},
  icon = 100,
  spellIcon = 20,
  description = "Shoots a ray that engulfs the target in magical darkness.\n- Cost : 25 energy\n- Power : 13\n\n[Darkness spell]:\nShoots a ray of light instead, forcing undead to flee and preserving invisibility. Consumes the Darkness spell effect.\n\n[Missile Weapons 3]:\nFor the next 15 seconds, your next missile weapon attack also triggers this spell for free.",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local power = spells_functions.script.getPower(13, champion, "concentration")
    local ord = champion:getOrdinal()
    if champion:getSkillLevel("missile_weapons") > 2 and not trigger then spells_functions.script.maxEffectIcons("darkbolt", 15, ord) end
    if spells_functions.script.darknessUntil then
      spells_functions.script.missile("light_bolt", ord, power)
      spells_functions.script.darknessStop()
      spells_functions.script.removeEffectIcons("darkness")
    else
      spells_functions.script.missile("dark_bolt_andak", ord, power)
      spells_functions.script.stopInvisibility()
      spells_functions.script.darknessStart(1)
    end
  end
},

{
  name = "arcane_storm",
  uiName = "Arcane Storm",
  skill = "concentration",
  requirements = {"concentration", 4},
  gesture = 8,
  manaCost = 0,
  description = "Unleashes slow but devastating arcanic energy on your foes. Generates 1 charge of arcanic power, up to 5 charges lasting 15 seconds. Arcanic Storm costs 100% more energy and deals 50% more damage per arcanic power stacked.\n- Cost : 25 energy\n- Power : 15 per bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local ordinal = champion:getOrdinal()
    local arcane = spells_functions.script.arcanePower[ordinal]
    local cost = (1 + arcane) * 25
    spells_functions.script.paySpellCost(champion, cost)
    local power = (1 + arcane/2) * spells_functions.script.getPower(2.5, champion, "concentration")
    spells_functions.script.missiles(power, {"arcane_bolt"}, ordinal, 5, false)
    spells_functions.script.setArcane(arcane+1, ordinal)
    spells_functions.script.stopInvisibility()
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local ordinal = champion:getOrdinal()
    local arcane = spells_functions.script.arcanePower[ordinal]
    local cost = (1 + arcane) * 25
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

{
  name = "arcane_nova",
  uiName = "Arcane Nova",
  skill = "concentration",
  requirements = {"concentration", 4},
  gesture = 5,
  manaCost = 11,
  description = "Damages enemies around you. Arcane Nova deals 50% more damage and its range increases by one tile per arcanic power stacked. Consumes one charge of arcanic power.\n- Cost : 11 energy\n- Power : 11 on nearest tiles\n- Range : 2",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local ordinal = champion:getOrdinal()
    local arcane = spells_functions.script.arcanePower[ordinal]
    local range = 2 + arcane
    local duration = range/2
    local power = (1 + arcane/2) * spells_functions.script.getPower(11, champion, "concentration")
    GameMode.fadeOut(0xF0E0FF, 0)
    GameMode.fadeIn(0xF0E0FF, duration)
    spells_functions.script.partyLight("concentration", duration, vec(0.94, 0.88, 1), 10, 1, 0.1)
    -- spawns <effects> around entity <centerID> up to <range> tiles on xy plan,
    -- and elevation if <sphere> is true, in <duration> seconds,
    -- with <power> decreasing with squared distance, cast by <ordinal> champion,
    -- checking line of fire if <checkMode> ~= "NA".
    -- function zoneEffects(effects, centerID, range, sphere, duration, power, ordinal, checkMode)
    spells_functions.script.zoneEffects("arcane_nova_blast", "party", range, false, duration, power, ordinal)
    spells_functions.script.setArcane(arcane-1, ordinal)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "arcane_flash",
  uiName = "Arcane Flash",
  skill = "concentration",
  requirements = {"concentration", 5},
  gesture = 2,
  manaCost = 0,
  description = "Unleashes all accumulated arcanic power upon your foes. Consumes all charges of arcanic power, converting them into energy restored and damage.\n- Cost : 0 energy\n- Power : 20 x Arcanic Power\n- Energy gained : 10 x Arcanic Power x Arcanic Power",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local ordinal = champion:getOrdinal()
    local arcane = spells_functions.script.arcanePower[ordinal]
    local power = spells_functions.script.getPower(20*arcane, champion, "concentration")
    spells_functions.script.missile("arcane_flash_bolt", ordinal, power)
    champion:regainEnergy(10*arcane*arcane)
    spells_functions.script.setArcane(0, ordinal)
    spells_functions.script.stopInvisibility()
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local ordinal = champion:getOrdinal()
    local arcane = spells_functions.script.arcanePower[ordinal]
    if arcane == 0 then
      playSound("spell_fizzle")
      hudPrint("You have no arcanic charge.")
      return false
    end
  end,
},

{
  name = "mirror",
  uiName = "Mirror",
  skill = "concentration",
  requirements = {"concentration", 5},
  gesture = 452,
  manaCost = 0,
  description = "Swaps your health and energy in proportion of their maximum.\n- Cost : 0 energy\n\n[Accuracy 3]:\nAffects all champions.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("heal_party")
    spells_functions.script.mirror(champion:getSkillLevel("accuracy") < 3 and champion:getOrdinal())
  end
},

-- fire magic

{ 
  name = "fireburst",
  uiName = "Fireburst",
  gesture = 1,
  manaCost = 25,
  skill = "elemental_magic",
  requirements = { "elemental_magic", 1 },
  icon = 60,
  spellIcon = 1,
  description = "Conjures a blast of fire that deals fire damage to all foes directly in front of you.\n- Cost : 25 energy\n- Power : 22",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(22, champion, "elemental_magic")
	
	spells_functions.script.druidPower(champion, power)
	spells_functions.script.elementalistPower("fire", champion, power)
	
    spells_functions.script.frontAttack("fireburst", power, champion:getOrdinal())
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "fire_wall",
  uiName = "Fire Wall",
  skill = "elemental_magic",
  requirements = {"elemental_magic", 2},
  gesture = 14,
  manaCost = 30,
  description = "Burns the ground hitting your opponents in a line.\n- Cost : 30 energy\n- Power : 20\n- Range : Elemental Magic + 2 tiles",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local range = spells_functions.script.quantum(2 + 5*spells_functions.script.getSkillPower(champion, "elemental_magic"))
    local power = spells_functions.script.getPower(4, champion, "elemental_magic") -- 4 damage x 5 ticks
    local spl = spells_functions.script.frontAttack("fire_wall", power, champion:getOrdinal())
    spl.iceshards:setRange(range)
    if not spl.tiledamager:isEnabled() then playSound("spell_fizzle") spl:destroy() end
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "fireball",
  uiName = "Fireball",
  gesture = 1236,
  manaCost = 43,
  skill = "elemental_magic",
  requirements = { "elemental_magic", 3, "concentration", 1 },
  icon = 61,
  spellIcon = 7,
  description = "A flaming ball of fire shoots from your fingertips causing devastating damage to your foes.\n- Cost : 43 energy\n- Power : 30\n\n[Missile Weapons 3]:\nFor the next 15 seconds, your next missile weapon attack also triggers this spell for free.",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local power = spells_functions.script.getPower(30, champion, "elemental_magic")
    local ord = champion:getOrdinal()
    --if champion:getSkillLevel("missile_weapons") > 2 and not trigger then spells_functions.script.maxEffectIcons("fireball", 15, ord) end
    spells_functions.script.missile("fireball_large_cast", ord, power)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "fire_shield",
  uiName = "Fire Shield",
  gesture = 52145,
  manaCost = 50,
  skill = "elemental_magic",
  requirements = { "elemental_magic", 3, "concentration", 3 },
  icon = 66,
  spellIcon = 12,
  description = "Creates a magical shield reducing fire damage against the party.\n- Cost : 50 energy\n- Duration : 50 seconds",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalShields(50, champion, true, false, false, false)
  end
},

{
  name = "fire_aura",
  uiName = "Fire Aura",
  skill = "elemental_magic",
  requirements = {"elemental_magic", 4, "concentration", 2},
  gesture = 1458,
  manaCost = 70,
  description = "Burns enemies in melee range.\n- Cost : 70 energy\n- Power : 4 damage per second on nearest tiles\n- Duration : 45 seconds\n\n[Spellblade]:\nDuration increased by 5 seconds per skill point.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local duration = spells_functions.script.getPower(45 + (champion:getSkillLevel("spellblade") * 5), champion, "elemental_magic")
    spells_functions.script.partySound("fire_elemental_burn", duration, 3, 3)
    spells_functions.script.partyLight("fire", duration, vec(1, 0.25, 0), 10)
    playSound("generic_spell")
    GameMode.fadeOut(0xFF8040, 0)
    GameMode.fadeIn(0xFFF0E0, 3)
    -- spawns <effects> around entity <centerID> up to <range> tiles on xy plan,
    -- and elevation if <sphere> is true, in <duration> seconds,
    -- with <power> decreasing with squared distance, cast by <ordinal> champion,
    -- checking line of fire if <checkMode> ~= "NA".
    -- function zoneEffects(effects, centerID, range, sphere, duration, power, ordinal, checkMode)
    spells_functions.script.durationEffects(0, duration, "zoneEffects", {"fire_aura_blast", "party", 1.5, false, 0, 4, champion:getOrdinal()})
    spells_functions.script.stopInvisibility()
    spells_functions.script.maxEffectIcons("fire_aura", duration)
  end
},

{
  name = "meteor_storm",
  uiName = "Meteor Storm",
  gesture = 14563,
  manaCost = 80,
  skill = "elemental_magic",
  requirements = { "elemental_magic", 5, "concentration", 3 },
  icon = 99,
  spellIcon = 8,
  description = "Unleashes a devastating storm of meteors on your foes.\n- Cost : 80 energy\n- Power : 30 per meteor",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "elemental_magic")
    spells_functions.script.missiles(power, {"fireball_large_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

-- air magic

{
  name = "shock",
  uiName = "Shock",
  gesture = 3,
  manaCost = 20,
  skill = "air_magic",
  requirements = { "elemental_magic", 1 },
  icon = 64,
  spellIcon = 6,
  description = "Conjures a blast of electricity that deals shock damage to all foes directly in front of you.\n- Cost : 20 energy\n- Power : 19",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(19, champion, "elemental_magic")
	spells_functions.script.elementalistPower("air", champion, power)
    spells_functions.script.frontAttack("shockburst", power, champion:getOrdinal())
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "wind_rider",
  uiName = "Wind Rider",
  skill = "air_magic",
  requirements = {"air_magic", 2},
  gesture = 36,
  manaCost = 30,
  description = "Increases running speed and protects against falling damage. Also cleans the air around you. This spell is not cumulative.\n- Cost : 30 energy\n- Duration : 45 seconds\n\n[Agile]:\nRunning Speed increased by 10%.\n\n[Endurance]:\nDuration increased by 45 seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("magical_breathing")
    local power = spells_functions.script.getPower(1, champion, "air_magic")
    local duration = (champion:hasTrait("endurance") and 90 or 45) * power
    spells_functions.script.partySound("wind_howl_strong", 5, 1, 3)
    spells_functions.script.partyLight("air", duration, vec(0, 1, 1), 5, 1)
    spells_functions.script.setWindRider(power*(champion:hasTrait("agile") and 0.11 or 0.1), duration)
    spells_functions.script.setEffectIcons("wind_rider", duration)
  end
},

{
  name = "lightning_bolt",
  uiName = "Lightning Bolt",
  gesture = 236,
  manaCost = 35,
  skill = "elemental_magic",
  requirements = { "elemental_magic", 3, "concentration", 1 },  
  icon = 65,
  spellIcon = 9,
  description = "You channel the power of storms through your hands.\n- Cost : 35 energy\n- Power : 27\n\n[Missile Weapons 3]:\nFor the next 15 seconds, your next missile weapon attack also triggers this spell for free.",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local power = spells_functions.script.getPower(27, champion, "elemental_magic")
    local ord = champion:getOrdinal()
    if champion:getSkillLevel("missile_weapons") > 2 and not trigger then spells_functions.script.maxEffectIcons("lightning_bolt", 15, ord) end
    spells_functions.script.missile("lightning_bolt_greater_cast", ord, power)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "invisibility",
  uiName = "Invisibility",
  gesture = 3658,
  manaCost = 45,
  skill = "air_magic",
  requirements = { "air_magic", 3, "concentration", 2 },
  icon = 74,
  spellIcon = 15,
  description = "Turns yourself and your friends invisible.\n- Cost : 45 energy\n- Duration : 25 seconds\n\n[Rogue]:\nDuration increased by 15 seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(champion:hasTrait("rogue") and 40 or 25, champion, "air_magic")
    spells_functions.script.maxConditionValue("invisibility", duration)
    spells_functions.script.maxEffectIcons("invisibility", duration)
  end
},

{
  name = "shock_shield",
  uiName = "Shock Shield",
  gesture = 52365,
  manaCost = 50,
  skill = "air_magic",
  requirements = { "air_magic", 3, "concentration", 3 },
  icon = 69,
  spellIcon = 16,
  description = "Creates a magical shield reducing shock damage against the party.\n- Cost : 50 energy\n- Duration : 50 seconds\n\n[Concentration 5]:\nThis spell does not remove other existing elemental shields and its duration becomes cumulative.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalShields(50, champion, false, true, false, false)
  end
},

{
  name = "thunder_storm",
  uiName = "Thunder Storm",
  skill = "air_magic",
  requirements = {"air_magic", 5, "concentration", 3},
  gesture = 3654,
  manaCost = 65,
  description = "Unleashes a devastating storm of thunder on your foes.\n- Cost : 65 energy\n- Power : 27 per bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "elemental_magic")
    spells_functions.script.missiles(power, {"lightning_bolt_greater_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

-- water magic

{
  name = "frost_burst",
  uiName = "Frostburst",
  skill = "elemental_magic",
  requirements = {"elemental_magic", 1},
  gesture = 9,
  manaCost = 25,
  description = "Conjures ice that deals damage to all foes directly in front of you and freezes them.\n- Cost : 25 energy\n- Power : 11\n- Duration : 0 to Water Magic + 3 seconds",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(11, champion, "elemental_magic")
	spells_functions.script.elementalistPower("cold", champion, power)
    spells_functions.script.frontAttack("frostburst_cast", power, champion:getOrdinal())
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "regeneration",
  uiName = "Regeneration",
  skill = "water_magic",
  requirements = {"water_magic", 1, "concentration", 1},
  gesture = 9652,
  manaCost = 0,
  description = "Heals the most wounded party member over time.\n- Cost : 20% maximum energy\n- Power : 20% maximum energy\n- Duration : 15 seconds\n\n[Accuracy 3]:\nAffects all champions.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local indexMostWounded = spells_functions.script.mostWounded()
    local cost = 0.2 * champion:getMaxEnergy()
    spells_functions.script.paySpellCost(champion, cost)
    local ratio = spells_functions.script.getPower(1, champion, "water_magic")
    local power = cost * ratio
    local duration = spells_functions.script.quantum(15 * ratio)
    local tick = power / (1 + duration)
    if champion:getSkillLevel("accuracy") > 2 then
      spells_functions.script.durationEffects(0, duration, "healParty", {tick, false})
      spells_functions.script.maxEffectIcons("regeneration", duration)
    else 
      spells_functions.script.durationEffects(0, duration, "heal", {indexMostWounded, tick})
      spells_functions.script.maxEffectIcons("regeneration", duration, indexMostWounded)
    end
    playSound("heal_party")
    spells_functions.script.partyLight("water", duration, vec(0, 0.5, 1), 5)
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local indexMostWounded = spells_functions.script.mostWounded()
    if indexMostWounded == 0 then hudPrint("Nobody is wounded.") playSound("spell_fizzle") return false end
    local cost = 0.2 * champion:getMaxEnergy()
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

{
  name = "ice_shards",
  uiName = "Ice Shards",
  gesture = 789,
  manaCost = 30,
  skill = "elemental_magic",
  requirements = {"elemental_magic", 2},
  icon = 70,
  spellIcon = 3,
  description = "Deathly sharp spikes of ice thrust from the ground hitting your opponents in a line.\n- Cost : 30 energy\n- Power : 18\n- Range : Water Magic + 2 tiles",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local range = spells_functions.script.quantum(2 + 5*spells_functions.script.getSkillPower(champion, "elemental_magic"))
    local power = spells_functions.script.getPower(18, champion, "elemental_magic")
    local spl = spells_functions.script.frontAttack("ice_shards", power, champion:getOrdinal())
    spl.iceshards:setRange(range)
    if not spl.tiledamager:isEnabled() then playSound("spell_fizzle") end
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "osmosis",
  uiName = "Osmosis",
  skill = "water_magic",
  requirements = {"water_magic", 2, "concentration", 1},
  gesture = 69854,
  manaCost = 50,
  description = "Gradually transfers health and energy between you and your friends, trying to keep everyone at the same proportional health and energy.\n- Cost : 50 energy\n- Duration : 15 seconds\n\n[Battle Mage]:\nDuration increased by 5 seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("heal_party")
    local ratio = spells_functions.script.getPower(1, champion, "water_magic")
    local power = 0.01 + 0.49*(ratio-1)/ratio
    local duration = (champion:hasTrait("battle_mage") and 20 or 15) * ratio
    spells_functions.script.osmosis(power, duration)
    spells_functions.script.partyLight("water", duration, vec(0, 0, 1), 7)
    spells_functions.script.maxEffectIcons("osmosis", duration)
  end
},

{
  name = "frostbolt",
  uiName = "Frostbolt",
  gesture = 698,
  manaCost = 37,
  skill = "elemental_magic",
  requirements = { "elemental_magic", 3, "concentration", 1 },
  icon = 71,
  spellIcon = 4,
  description = "You hurl a bolt of icy death dealing ranged damage and freezing your opponents. Every point in Water Magic increases the probability and duration of the freezing effect.\n- Cost : 37 energy\n- Power : 15\n\n[Missile Weapons 3]:\nFor the next 15 seconds, your next missile weapon attack also triggers this spell for free.",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local power = spells_functions.script.getPower(15, champion, "elemental_magic")
    local ord = champion:getOrdinal()
    if champion:getSkillLevel("missile_weapons") > 2 and not trigger then spells_functions.script.maxEffectIcons("frostbolt", 15, ord) end
    spells_functions.script.missile("frostbolt_cast", ord, power)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "frost_shield",
  uiName = "Frost Shield",
  gesture = 58965,
  manaCost = 50,
  skill = "elemental_magic",
  requirements = { "elemental_magic", 3, "concentration", 3 },
  icon = 68,
  spellIcon = 14,
  description = "Creates a magical shield reducing cold damage against the party.\n- Cost : 50 energy\n- Duration : 50 seconds\n\n[Concentration 5]:\nThis spell does not remove other existing elemental shields and its duration becomes cumulative.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalShields(50, champion, false, false, true, false)
  end
},

{
  name = "freeze_rune",
  uiName = "Freeze Rune",
  skill = "elemental_magic",
  requirements = {"elemental_magic", 4},
  gesture = 965,
  manaCost = 50,
  description = "Creates a rune trap that freezes anyone who steps on it. You can have up to 1 + Concentration traps at any time.\n- Cost : 50 energy\n- Power : 10",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local power = spells_functions.script.getPower(10, champion, "elemental_magic")
    spells_functions.script.ward("freeze_trap", power, champion:getOrdinal(), vec(0, 0.5, 1))
    spells_functions.script.partyLight("water", 1, vec(0, 0.5, 1), 10)
  end,
},

{
  name = "conjure_ice",
  uiName = "Conjure Ice",
  skill = "elemental_magic",
  requirements = {"elemental_magic", 5},
  gesture = 96,
  manaCost = 50,
  description = "Conjures a block of ice in front of the party. It can take as much damage as the spell power before it breaks. It takes one damage each second or when it is walked on, traps an ennemy, is pushed, or more if it hits the ground or is struck.\nCost : 50 energy\n- Power : 20\n\n[Cold-blooded]:\nPower increased by 10.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("frostburst")
    local x,y = spells_functions.script.getFrontTarget(true) -- blockedByHealth = true
    local power = spells_functions.script.getPower(champion:hasTrait("cold_resistant") and 30 or 20, champion, "elemental_magic")
	local cube = spawn("ice_cube", party.level, x, y, party.facing, party.elevation).health:setHealth(power)
    spells_functions.script.partyLight("water", 1, vec(0, 0.5, 1), 10)
  end,
},

{
  name = "ice_storm",
  uiName = "Ice Storm",
  skill = "elemental_magic",
  requirements = {"elemental_magic", 5, "concentration", 3},
  gesture = 9654,
  manaCost = 69,
  description = "Unleashes a devastating storm of ice on your foes.\n- Cost : 69 energy\n- Power : 15 per bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "elemental_magic")
    spells_functions.script.missiles(power, {"frostbolt_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

-- earth magic

{
  name = "poison_cloud",
  uiName = "Poison Cloud",
  gesture = 7,
  manaCost = 27,
  skill = "poison_mastery",
  requirements = { "poison_mastery", 1 },  
  icon = 62,
  spellIcon = 2,
  description = "Summons a toxic cloud of poison that deals damage over time.\n- Cost : 27 energy\n- Power : 5 damage each 0.8 second\n- Duration : 20 seconds\n\n[Insectoid, Earth Magic 5]:\nA swarm of insects also follows and devours any enemy that gets too close.\n- Power : 2 damage per second\n- Duration : 60 seconds",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(5, champion, "poison_mastery")
    spells_functions.script.frontAttack("poison_cloud_large", power, champion:getOrdinal())
    if champion:hasTrait("insectoid") and skillLevel > 4 then 
      spells_functions.script.frontAttack("swarm_cloud", power*2/5, champion:getOrdinal())
    end
    spells_functions.script.stopInvisibility()
  end
},

-- {
  -- name = "stone_rain",
  -- uiName = "Stone Rain",
  -- skill = "earth_magic",
  -- requirements = {"earth_magic", 2},
  -- gesture = 74,
  -- manaCost = 44,
  -- description = "Conjures several rocks that deals physical damage to all foes directly in front of you.\n- Cost : 44 energy\n- Power : 10 per rock",
  -- onCast = function(champion, x, y, direction, elevation, skillLevel)
    -- playSound("generic_spell")
    -- local power = spells_functions.script.getPower(4, champion, "earth_magic")
    -- spells_functions.script.rocksFall(power, champion:getOrdinal())
    -- spells_functions.script.stopInvisibility()
  -- end
-- },

{
  name = "poison_bolt",
  uiName = "Poison Bolt",
  gesture = 478,
  manaCost = 32,
  skill = "poison_mastery",
  requirements = { "poison_mastery", 3, "concentration", 1 },  
  icon = 63,
  spellIcon = 10,
  description = "A sizzling venomous bolt of poison shoots from your hands.\n- Cost : 32 energy\n- Power : 15\n\n[Missile Weapons 3]:\nFor the next 15 seconds, your next missile weapon attack also triggers this spell for free.",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local power = spells_functions.script.getPower(15, champion, "poison_mastery")
    local ord = champion:getOrdinal()
    if champion:getSkillLevel("missile_weapons") > 2 and not trigger then spells_functions.script.maxEffectIcons("poison_bolt", 15, ord) end
    spells_functions.script.missile("poison_bolt_greater_cast", ord, power)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "poison_shield",
  uiName = "Poison Shield",
  gesture = 58745,
  manaCost = 50,
  skill = "poison_mastery",
  requirements = { "poison_mastery", 3, "concentration", 3 },
  icon = 67,
  spellIcon = 17,
  description = "Creates a magical shield reducing poison damage against the party.\n- Cost : 50 energy\n- Duration : 50 seconds\n\n[Concentration 5]:\nThis spell does not remove other existing elemental shields and its duration becomes cumulative.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalShields(50, champion, false, false, false, true)
  end
},

{
  name = "entangling_roots_rune",
  uiName = "Entangling Roots Rune",
  skill = "poison_mastery",
  requirements = {"poison_mastery", 2, "alchemist", 4},
  gesture = 745,
  manaCost = 50,
  description = "Creates a rune trap that entangles anyone who steps on it. You can have up to 1 + Concentration traps at any time.\n- Cost : 50 energy\n- Power : 20\n\n[Alchemist]:\nPower increased by 20.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local power = spells_functions.script.getPower(champion:hasTrait("alchemist") and 40 or 20, champion, "poison_mastery")
    spells_functions.script.ward("entangling_roots_trap", power, champion:getOrdinal(), vec(0.3, 1, 0.6))
    spells_functions.script.partyLight("earth", 1, vec(0.5, 1, 0), 10)
  end,
},

-- {
  -- name = "stone_storm",
  -- uiName = "Stone Storm",
  -- skill = "earth_magic",
  -- requirements = {"earth_magic", 4, "concentration", 1},
  -- gesture = 7852,
  -- manaCost = 53,
  -- description = "Unleashes a devastating storm of rocks on your foes.\n- Cost : 53 energy\n- Power : 10 per rock\n\n[Throwing X]:\nPower increased by an additional X% for each point of strength you have.",
  -- onCast = function(champion, x, y, direction, elevation, skillLevel)
    -- party.party:shakeCamera(0.1, 9)
    -- playSound("earthquake")
    -- local power = spells_functions.script.getPower(5, champion, "earth_magic") + champion:getSkillLevel("throwing")*champion:getCurrentStat("strength")*0.05
    -- spells_functions.script.missiles(power, {"rock_spell"}, champion:getOrdinal(), 1, true)
    -- spells_functions.script.stopInvisibility()
  -- end
-- },

{
  name = "poison_storm",
  uiName = "Poison Storm",
  skill = "poison_mastery",
  requirements = {"poison_mastery", 5, "concentration", 3},
  gesture = 7456,
  manaCost = 60,
  description = "Unleashes a devastating storm of poison on your foes.\n- Cost : 60 energy\n- Power : 15 per bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "poison_mastery")
    spells_functions.script.missiles(power, {"poison_bolt_greater_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

-- fire & air magic

{
  name = "demonic_pact",
  uiName = "Demonic Pact",
  requirements = {"fire_magic", 1, "air_magic", 1},
  gesture = 41236,
  manaCost = 0,
  description = "Converts up to 1% of your current health into energy every second.\n- Cost : 0 energy\n- Duration : 30 seconds\n\n[Daemon Ancestor]:\nThe conversion rate is doubled.\n\n[Fire Magic 3, Air Magic 3]:\nYou gain spell critical chance equal to half your missing health percentage. This effect is not cumulative.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(30, champion, "fire_magic", "air_magic")
    local ord = champion:getOrdinal()
    spells_functions.script.durationEffects(1, duration, "demonicPact", {ord, champion:hasTrait("fire_resistant") and 0.02 or 0.01})
    spells_functions.script.partyLight("fire_air", duration, vec(1, 0, 0), 5)
    spells_functions.script.insertEffectIcons("demonic_pact", duration, ord)
  end,
},

{
  name = "time_bolt",
  uiName = "Time Bolt",
  requirements = {"fire_magic", 2, "air_magic", 2},
  gesture = 123,
  manaCost = 50,
  description = "You hurl a bolt of mystical energy dealing fire and shock ranged damage to your opponents, and throwing them to the near future.\n- Cost : 50 energy\n- Power : 30\n- Duration : 5 seconds\n\n[Throwing X]:\nPower increased by X. Duration increased by X seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local ratio = spells_functions.script.getPower(1, champion, "fire_magic", "air_magic")
    local throw = champion:getSkillLevel("throwing")
    local power = (30+throw) * ratio
    local duration = (5+throw) * ratio
    spells_functions.script.missile("time_bolt", champion:getOrdinal(), power, duration)
    spells_functions.script.stopInvisibility()
  end,
},

{
  name = "burning_thunder_shield",
  uiName = "Burning Thunder Mage Armor",
  requirements = {"fire_magic", 3, "air_magic", 3},
  gesture = 0,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nFire & Air +3%\nWater & Earth -3%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("burning_thunder_shield", champion)
  end
},

{
  name = "burning_thunder",
  uiName = "Burning Thunder",
  requirements = {"fire_magic", 4, "air_magic", 4},
  gesture = 14563,
  manaCost = 73,
  description = "Unleashes a devastating storm of fire and thunder on your foes.\n- Cost : 73 energy\n- Power : 30 per fireball, 27 per lightning bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "fire_magic", "air_magic")
    spells_functions.script.missiles(power, {"fireball_large_cast", "lightning_bolt_greater_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "haste",
  uiName = "Haste",
  requirements = {"fire_magic", 5, "air_magic", 5},
  gesture = 1236,
  manaCost = 100,
  description = "Your cooldown times are halved. Only duration is cumulative.\n- Cost : 100 energy\n- Duration : 30 seconds\n\n[Accuracy 3]:\nAffects all champions.\n\n[Quick]:\nDuration increased by 10 seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(champion:hasTrait("quick") and 40 or 30, champion, "fire_magic", "air_magic")
    local ordinal = iff(champion:getSkillLevel("accuracy") > 2, nil, champion:getOrdinal())
    spells_functions.script.addConditionValue("haste_spell", duration, ordinal)
    spells_functions.script.partyLight("fire_air", 1, vec(1, 0, 0.5), 40)
    spells_functions.script.setConditionIcons("haste_spell", "haste", ordinal)
  end
},

-- air & water magic

{
  name = "shadowlands_vision",
  uiName = "Shadowlands Vision",
  requirements = {"air_magic", 1, "water_magic", 1},
  gesture = 369,
  manaCost = 5,
  description = "You can see undeads, elementals and constructs positions through walls.\n- Cost : 5 energy\n- Duration : 2 minutes\n\n[Lizardman]:\nDuration is doubled.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(champion:hasTrait("lizardman") and 240 or 120, champion, "air_magic", "water_magic")
    spells_functions.script.partyLight("air_water", 1, vec(0.25, 0.25, 1), 30)
    spells_functions.script.maxEffectIcons("shadowlands_vision", duration)
  end
},

{
  name = "water_breathing",
  uiName = "Water Breathing",
  requirements = {"air_magic", 2, "water_magic", 2},
  gesture = 2369,
  manaCost = 30,
  description = "Gives you and your friends the ability to breathe under water.\n- Cost : 30 energy\n- Duration : 15 seconds\n\n[Athletics X]:\nDuration increased by X seconds.\n\n[Cold-blooded]:\nDuration is doubled.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = (15 + champion:getSkillLevel("athletics"))*(champion:hasTrait("cold_resistant") and 2 or 1)
    duration = spells_functions.script.getPower(duration, champion, "air_magic", "water_magic")
    spells_functions.script.maxConditionValue("water_breathing", duration)
    spells_functions.script.partyLight("air_water", 1, vec(0.5, 0.75, 1), 30)
    spells_functions.script.maxEffectIcons("water_breathing", duration)
  end,
},

{
  name = "blizzard_shield",
  uiName = "Blizzard Mage Armor",
  requirements = {"air_magic", 3, "water_magic", 3},
  gesture = 5236985,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nAir & Water +3%\nEarth & Fire -3%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("blizzard_shield", champion)
  end
},

{
  name = "blizzard",
  uiName = "Blizzard",
  requirements = {"air_magic", 4, "water_magic", 4},
  gesture = 32589,
  manaCost = 67,
  description = "Unleashes a devastating storm of ice and thunder on your foes.\n- Cost : 67 energy\n- Power : 27 per lightning bolt, 15 per frost bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "air_magic", "water_magic")
    spells_functions.script.missiles(power, {"lightning_bolt_greater_cast", "frostbolt_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "psychic_shield",
  uiName = "Psychic Shield",
  requirements = {"air_magic", 5, "water_magic", 5},
  gesture = 23698,
  manaCost = 42,
  description = "Doubles all champions energy regeneration rate. Damage dealt to you and your friends reduces energy before health. Only duration is cumulative.\n- Cost : 42 energy\n- Duration : 30 seconds\n\n[Wizard]:\nDuration increased by 10 seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(champion:hasTrait("wizard") and 40 or 30, champion, "air_magic", "water_magic")
    spells_functions.script.addConditionValue("energy_shield", duration)
    spells_functions.script.addEffectIcons("psychic_shield", duration)
  end,
},

-- water & earth magic

{
  name = "health_shield",
  uiName = "Health Shield",
  requirements = {"water_magic", 2, "earth_magic", 2},
  gesture = 47896,
  manaCost = 60,
  description = "Heals champions when they receive damage or when the spell expires.\n- Cost : 60 energy\n- Power : 80\n- Duration : 20 seconds\n\n[Endurance]:\nDuration increased by 10 seconds.\n\n[Athletics 2]:\nHeal power increased by 20.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("heal_party")
    local ratio = spells_functions.script.getPower(1, champion, "water_magic", "earth_magic")
    local power = (champion:getSkillLevel("athletics") > 1 and 100 or 80) * ratio
    local duration = (champion:hasTrait("endurance") and 30 or 20) * ratio
    spells_functions.script.healthShieldStart(power, duration)
    spells_functions.script.partyLight("water_earth", duration, vec(0.25, 1, 1), 3)
    spells_functions.script.maxEffectIcons("health_shield", duration)
  end
},

{
  name = "fever_shield",
  uiName = "Fever Mage Armor",
  requirements = {"water_magic", 3, "earth_magic", 3},
  gesture = 5478965,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nWater & Earth +3%\nFire & Air -3%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("fever_shield", champion)
  end
},

{
  name = "cold_fever",
  uiName = "Cold Fever",
  requirements = {"water_magic", 4, "earth_magic", 4},
  gesture = 74569,
  manaCost = 65,
  description = "Unleashes a devastating storm of ice and poison on your foes.\n- Cost : 65 energy\n- Power : 15 per frost bolt, 15 per poison bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "water_magic", "earth_magic")
    spells_functions.script.missiles(power, {"frostbolt_cast", "poison_bolt_greater_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "feast",
  uiName = "Feast",
  requirements = {"water_magic", 5, "earth_magic", 5},
  gesture = 7896,
  manaCost = 0,
  description = "Feeds the party.\n- Cost : 150 energy\n- Duration : 5 seconds\n\n[Farmer]:\nThis spell costs 75 energy instead.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("consume_food")
    local cost = champion:hasTrait("farmer") and 75 or 150
    spells_functions.script.paySpellCost(champion, cost)
    local duration = spells_functions.script.quantumPower(5, champion, "water_magic", "earth_magic")
    spells_functions.script.durationEffects(1, duration, "feed", {10})
    spells_functions.script.partyLight("water_earth", duration, vec(0.25, 1, 1), 3)
    spells_functions.script.maxEffectIcons("feast", duration)
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = champion:hasTrait("farmer") and 75 or 150
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

-- earth & fire magic

{
  name = "explosion",
  uiName = "Explosion",
  requirements = {"earth_magic", 1, "fire_magic", 1},
  gesture = 741,
  manaCost = 50,
  description = "Burns and hits all adjacent foes and knockback them.\n- Cost : 50 energy\n- Power : 20\n\n[Aggressive]:\nDeals 20% more damage.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(champion:hasTrait("aggressive") and 24 or 20, champion, "earth_magic", "fire_magic")
    for dir=0,3 do
      local nx = x
      local ny = y
      local obs = party.map:checkObstacle(party,dir)
      if (not obs) or obs == "dynamic_obstacle" or obs == "obstacle" then
        local dx,dy = getForward(dir)
        nx = x+dx
        ny = y+dy
      end
      local burst = spawn("explosion",party.level,nx,ny,dir,elevation)
      burst.tiledamager:setAttackPower(power)
      burst.tiledamager:setCastByChampion(champion:getOrdinal())
    end
    playSound("fireburst")
    party.party:shakeCamera(power/24,0.8)
    party.party:playScreenEffect("fireball_screen")
    spells_functions.script.partyLight("earth_fire", 1, vec(1, 0.5, 0), 25)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "berserk",
  uiName = "Berserk",
  requirements = {"earth_magic", 2, "fire_magic", 2},
  gesture = 7412,
  manaCost = 0,
  description = "Grants champions strength and vitality equal to their level and converts food level into health and energy over time.\n- Cost : 80 energy\n- Duration : 25 seconds\n\n[Barbarian]:\nThis spell costs 20 energy instead.\n\n[Fast Metabolism]:\nDoubles the conversion rate for you, whoever casts the spell.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local cost = champion:hasTrait("barbarian") and 20 or 80
    spells_functions.script.paySpellCost(champion, cost)
    local duration = spells_functions.script.getPower(25, champion, "earth_magic", "fire_magic")
    spells_functions.script.maxConditionValue("berserk", duration)
    spells_functions.script.durationEffects(0, duration, "metabolism", {0.5, true, true})
    spells_functions.script.partyLight("earth_fire", duration, vec(1, 1, 0), 3)
    spells_functions.script.maxEffectIcons("berserk", duration)
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = champion:hasTrait("barbarian") and 20 or 80
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

{
  name = "volcanic_shield",
  uiName = "Volcanic Mage Armor",
  requirements = {"earth_magic", 3, "fire_magic", 3},
  gesture = 5874125,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nEarth & Fire +3%\nAir & Water -3%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("volcanic_shield", champion)
  end
},

{
  name = "volcano",
  uiName = "Volcano",
  requirements = {"earth_magic", 4, "fire_magic", 4},
  gesture = 78521,
  manaCost = 70,
  description = "Unleashes a devastating storm of fire and toxic smoke on your foes.\n- Cost : 92 energy\n- Power : 30 per fireball, 15 per poison bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "earth_magic", "fire_magic")
    spells_functions.script.missiles(power, {"poison_bolt_greater_cast", "fireball_large_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "eruption",
  uiName = "Eruption",
  requirements = {"earth_magic", 5, "fire_magic", 5},
  gesture = 8741,
  manaCost = 100,
  description = "A wave of volcanic eruption surges around you, burning and poisoning your foes.\n- Cost : 100 energy\n- Power : 30\n- Range : 1\n\n[Battle Mage, Dodge 2]:\nA second wave surges 1 second later, with half power and half range.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("magma_golem_meteor_fall")
    local ratio = spells_functions.script.getPower(1, champion, "earth_magic", "fire_magic")
    local power = 30 * ratio
    local range = 1 * ratio
    -- spawns <effects> around entity <centerID> up to <range> tiles on xy plan,
    -- and elevation if <sphere> is true, in <duration> seconds,
    -- with <power> decreasing with squared distance, cast by <ordinal> champion,
    -- checking line of fire if <checkMode> ~= "NA".
    -- function zoneEffects(effects, centerID, range, sphere, duration, power, ordinal, checkMode)
    spells_functions.script.zoneEffects("volcanic_eruption", "party", range, false, 1, power, champion:getOrdinal())
    if champion:hasTrait("battle_mage") and champion:getSkillLevel("dodge") > 1 then
      spells_functions.script.delayEffects(1, spells_functions.script.zoneEffects, {"volcanic_eruption", "party", range/2, false, 1, power/2, champion:getOrdinal()})
    end
  end,
},

-- fire & water magic

{
  name = "force_of_will",
  uiName = "Force of Will",
  requirements = {"fire_magic", 1, "water_magic", 1},
  gesture = 14589,
  manaCost = 50,
  description = "You are immune to head wounds.\n- Cost : 50 energy\n- Duration : 5 minutes\n\n[Strong Mind]:\nDuration is doubled.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(champion:hasTrait("strong_mind") and 600 or 300, champion, "fire_magic", "water_magic")
    for ord = 1,4 do spells_functions.script.cure(ord, 1, {"head_wound"}) end
    spells_functions.script.partyLight("fire_water", 1, vec(0.75, 0.5, 1), 50)
    spells_functions.script.addEffectIcons("force_of_will", duration, champion:getOrdinal())
  end
},

{
  name = "antipode",
  uiName = "Antipode",
  requirements = {"fire_magic", 2, "water_magic", 2},
  gesture = 12569,
  manaCost = 0,
  description = "You hurl two bolts of fire and icy death dealing ranged damage and freezing your opponents.\n- Cost : 80 energy\n- Power : 30 fire damage, 15 cold damage\n\n[Endure Elements]:\nThis spell costs 40 energy instead.\n\n[Firearms 3]:\nFor the next 15 seconds, your next firearm attack also triggers this spell for free.",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local ord = champion:getOrdinal()
    if not trigger then
      local cost = champion:hasTrait("endure_elements") and 40 or 80
      spells_functions.script.paySpellCost(champion, cost)
      if champion:getSkillLevel("firearms") > 2 then spells_functions.script.maxEffectIcons("antipode", 15, ord) end
    end
    spells_functions.script.missile("fireball_andak", ord, spells_functions.script.getPower(30, champion, "fire_magic"))
    local f = spells_functions.script.missile("frostbolt_andak", ord, spells_functions.script.getPower(15, champion, "water_magic"))
    f.data:set("dt", math.pi)
    spells_functions.script.stopInvisibility()
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = champion:hasTrait("endure_elements") and 40 or 80
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

{
  name = "frostfire_shield",
  uiName = "Frostfire Mage Armor",
  requirements = {"fire_magic", 3, "water_magic", 3},
  gesture = 541258965,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nFire & Water +3%\nAir & Earth -3%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("frostfire_shield", champion)
  end
},

{
  name = "fire_and_ice",
  uiName = "Fire & Ice",
  requirements = {"fire_magic", 4, "water_magic", 4},
  gesture = 14569,
  manaCost = 75,
  description = "Unleashes a devastating storm of fire and ice on your foes.\n- Cost : 75 energy\n- Power : 30 per fireball, 15 per frost bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "fire_magic", "water_magic")
    spells_functions.script.missiles(power, {"fireball_large_cast", "frostbolt_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "negentropy",
  uiName = "Negentropy",
  requirements = {"fire_magic", 5, "water_magic", 5},
  gesture = 12589,
  manaCost = 100,
  description = "Burns and freezes enemies around you.\n- Cost : 100 energy\n- Power : 2 damage per second on nearest tiles\n- Range : 3 tiles\n- Duration : 30 seconds\n\n[Aura]:\nDeals 10% more damage.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local power = (spells_functions.script.getSkillPower(champion, "fire_magic")+1) * (champion:hasTrait("aura") and 2.2 or 2)
    local duration = spells_functions.script.getPower(30, champion, "water_magic")
    spells_functions.script.partySound("fire_elemental_burn", duration, 3, 3)
    spells_functions.script.partyLight("fire_water", duration, vec(0.75, 0.25, 1), 10)
    -- spawns <effects> around entity <centerID> up to <range> tiles on xy plan,
    -- and elevation if <sphere> is true, in <duration> seconds,
    -- with <power> decreasing with squared distance, cast by <ordinal> champion,
    -- checking line of fire if <checkMode> ~= "NA".
    -- function zoneEffects(effects, centerID, range, sphere, duration, power, ordinal, checkMode)
    spells_functions.script.durationEffects(0, duration, "zoneEffects", {"negentropy_blast", "party", 3, false, 0, power, champion:getOrdinal()})
    spells_functions.script.stopInvisibility()
    spells_functions.script.maxEffectIcons("negentropy", duration)
  end
},

-- air & earth magic 

{
  name = "copycat",
  uiName = "Copycat",
  requirements = {"air_magic", 1, "earth_magic", 1},
  gesture = 78523,
  manaCost = 0,
  description = "Copies the last spell cast. You regain 15% of its energy cost over 15 seconds.\n\n[Human]:\nYou regain 20% of its energy cost over 15 seconds instead.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    spells_functions.script.copycat(champion, x, y, direction, elevation, champion:hasTrait("human") and 0.2 or 0.15)
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    if not spells_functions.script.lastSpellCast then hudPrint("Nothing to copy.") playSound("spell_fizzle") return false end
    local spell = spells_functions.script.defByName[spells_functions.script.lastSpellCast]
    if champion:getEnergy() < spell.manaCost then return false,"no_energy" end
    if spell.preCast then return spell.preCast(champion, x, y, direction, elevation, skillLevel) end
  end,
},

{
  name = "magic_bridge",
  uiName = "Magic Bridge",
  requirements = {"air_magic", 2, "earth_magic", 2},
  gesture = 2365478,
  manaCost = 80,
  description = "Conjure a magical platform for a brief time in front of the party.\n- Cost : 80 energy.\n- Duration : 3 seconds\n\n[Wizard]:\nDuration is doubled.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local duration = spells_functions.script.getPower(champion:hasTrait("wizard") and 6 or 3, champion, "air_magic", "earth_magic")
    spells_functions.script.magicBridge(champion, x, y, direction, elevation, duration)
  end,
},

{
  name = "acid_storm_shield",
  uiName = "Acid Storm Mage Armor",
  requirements = {"air_magic", 3, "earth_magic", 3},
  gesture = 523654785,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nAir & Earth +3%\nFire & Water -3%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("acid_storm_shield", champion)
  end
},

{
  name = "acid_storm",
  uiName = "Acid Storm",
  requirements = {"air_magic", 4, "earth_magic", 4},
  gesture = 74563,
  manaCost = 63,
  description = "Unleashes a devastating storm of thunder and poison on your foes.\n- Cost : 73 energy\n- Power : 27 per lightning bolt, 10 per rock",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "air_magic", "earth_magic")
    spells_functions.script.missiles(power, {"lightning_bolt_greater_cast", "poison_bolt_greater_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "angelic_shield",
  uiName = "Angelic Shield",
  requirements = {"air_magic", 5, "earth_magic", 5},
  gesture = 32547,
  manaCost = 60,
  description = "Reduces all damage on you and your friends.\n- Cost : 60 energy\n- Power : up to 20% damage reduction\n- Duration : 30 seconds\n\n[Fighter]:\nDuration increased by 10 seconds.\n\n[Knight]:\nReduces damage by up to 40% instead.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local power = spells_functions.script.getPower(1, champion, "air_magic", "earth_magic")
    local shield = 1 - (champion:hasTrait("knight") and 0.4 or 0.2)*(power-1)/power
    local duration = (champion:hasTrait("fighter") and 40 or 30)*power
    spells_functions.script.addShield(shield, duration)
    spells_functions.script.partyLight("air_earth", 1, vec(1, 1, 1), 40)
    spells_functions.script.insertEffectIcons("angelic_shield", duration)
  end
},

-- air, water and earth magic 

{
  name = "detect_life",
  uiName = "Detect Life",
  requirements = {"air_magic", 1, "water_magic", 1, "earth_magic", 1},
  gesture = 236987,
  manaCost = 20,
  description = "You can see enemies positions through walls.\n- Cost : 20 energy\n- Duration : 2 minutes\n\n[Farmer]:\nDuration is doubled.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(champion:hasTrait("farmer") and 240 or 120, champion, "air_magic", "water_magic", "earth_magic")
    spells_functions.script.partyLight("air_water_earth", 1, vec(0, 0.5, 1), 30)
    spells_functions.script.maxEffectIcons("detect_life", duration)
  end
},

{
  name = "nature_shield",
  uiName = "Nature Mage Armor",
  requirements = {"air_magic", 2, "water_magic", 2, "earth_magic", 2},
  gesture = 547896325,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nAir, Water & Earth +2%\nFire -6%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("nature_shield", champion)
  end
},

{
  name = "wrath_of_nature",
  uiName = "Wrath of Nature",
  requirements = {"air_magic", 3, "water_magic", 3, "earth_magic", 3},
  gesture = 36987,
  manaCost = 65,
  description = "Unleashes a devastating storm of lightning, ice and poison on your foes.\n- Cost : 65 energy\n- Power : 27 per lightning bolt, 15 per frost bolt, 15 per poison bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "air_magic", "water_magic", "earth_magic")
    spells_functions.script.missiles(power, {"lightning_bolt_greater_cast", "frostbolt_cast", "poison_bolt_greater_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "nature_grace",
  uiName = "Nature Grace",
  requirements = {"air_magic", 4, "water_magic", 4, "earth_magic", 4},
  gesture = 369874,
  manaCost = 50,
  description = "Cures negative conditions from champions over time.\n- Cost : 50 energy\n- Duration : 6 seconds\n\n[Natural Armor]:\nDuration increased by 3 seconds.\n\n[Alchemist]:\nDuration increased by 3 seconds.\n\n[Ratling]:\nInstantly cures disease.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    if champion:hasTrait("ratling") then for ord = 1,4 do spells_functions.script.cure(ord, 1, {"diseased"}) end end
    local duration = 2
    if champion:hasTrait("natural_armor") then duration = duration+1 end
    if champion:hasTrait("alchemist") then duration = duration+1 end
    duration = 3*spells_functions.script.quantumPower(duration, champion, "air_magic", "water_magic", "earth_magic")
    spells_functions.script.durationEffects(3, duration, "cure", {champion:getOrdinal(), 1}, 3)
    spells_functions.script.partyLight("air_water_earth", duration, vec(0, 1, 1), 4)
    spells_functions.script.maxEffectIcons("nature_grace", duration)
  end
},

{
  name = "drain_life_bolt",
  uiName = "Drain Life Bolt",
  requirements = {"air_magic", 5, "water_magic", 5, "earth_magic", 5},
  gesture = 2369874,
  manaCost = 80,
  description = "You hurl a bolt draining health and healing all champions over time.\n- Cost : 80 energy\n- Power : 30\n- Duration : 10 seconds\n\n[Healthy]:\nDrains 10% more health.\n\n[Firearms 3]:\nFor the next 15 seconds, your next firearm attack also triggers this spell for free.",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local ord = champion:getOrdinal()
    if champion:getSkillLevel("firearms") > 2 and not trigger then spells_functions.script.maxEffectIcons("drain_life_bolt", 15, ord) end
    local ratio = spells_functions.script.getPower(1, champion, "air_magic", "water_magic", "earth_magic")
    local power = (champion:hasTrait("healthy") and 33 or 30) * ratio
    local duration = spells_functions.script.quantum(10 * ratio)
    spells_functions.script.missile("drain_life_bolt", ord, power, duration)
    spells_functions.script.partyLight("air_water_earth", 1, vec(0, 1, 1), 50)
    spells_functions.script.stopInvisibility()
  end
},

-- water, earth and fire magic 

{
  name = "oracle",
  uiName = "Oracle",
  requirements = {"water_magic", 1, "earth_magic", 1, "fire_magic", 1},
  gesture = 987412,
  manaCost = 50,
  description = "You can see items and secret buttons positions through walls.\n- Cost : 50 energy\n- Duration : 2 minutes\n\n[Rogue]:\nDuration is doubled.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(champion:hasTrait("rogue") and 240 or 120, champion, "water_magic", "earth_magic", "fire_magic")
    spells_functions.script.partyLight("water_earth_fire", 1, vec(0, 0.5, 1), 30)
    spells_functions.script.maxEffectIcons("oracle", duration)
  end,
},

{
  name = "asphyxia_shield",
  uiName = "Asphyxia Mage Armor",
  requirements = {"water_magic", 2, "earth_magic", 2, "fire_magic", 2},
  gesture = 569874125,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nWater, Earth & Fire +2%\nAir -6%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("asphyxia_shield", champion)
  end
},

{
  name = "asphyxia",
  uiName = "Asphyxia",
  requirements = {"water_magic", 3, "earth_magic", 3, "fire_magic", 3},
  gesture = 98741,
  manaCost = 70,
  description = "Unleashes a devastating storm of ice, poison and fire on your foes.\n- Cost : 70 energy\n- Power : 15 per frost bolt, 15 per poison bolt, 30 per fireball",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "water_magic", "earth_magic", "fire_magic")
    spells_functions.script.missiles(power, {"frostbolt_cast", "poison_bolt_greater_cast", "fireball_large_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "vengeance",
  uiName = "Vengeance",
  requirements = {"water_magic", 4, "earth_magic", 4, "fire_magic", 4},
  gesture = 698741,
  manaCost = 0,
  description = "Whenever you or your friends receive damage, you gain strength, dexterity and willpower equal to that damage. These bonuses can never be more than 10% of the champion's maximum health, are cumulative and decrease with time.\n- Cost : 100 energy\n- Duration : 30 seconds\n\n[Barbarian]:\nThis spell costs 25 energy instead.\n\n[Fighter]:\nDuration increased by 10 seconds.\n\n[Chitin Armor]:\nDuration increased by 10 seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local cost = champion:hasTrait("barbarian") and 25 or 100
    spells_functions.script.paySpellCost(champion, cost)
    local duration = 30
    if champion:hasTrait("fighter") then duration = duration+10 end
    if champion:hasTrait("chitin_armor") then duration = duration+10 end
    duration = spells_functions.script.getPower(duration, champion, "water_magic", "earth_magic", "fire_magic")
    spells_functions.script.vengeance(duration)
    spells_functions.script.partyLight("water_earth_fire", 1, vec(0.75, 1, 0.5), 50)
    spells_functions.script.maxEffectIcons("vengeance", duration)
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = champion:hasTrait("barbarian") and 25 or 100
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

{
  name = "all_shall_fall",
  uiName = "All Shall Fall",
  requirements = {"water_magic", 5, "earth_magic", 5, "fire_magic", 5},
  gesture = 9874521,
  manaCost = 100,
  description = "Burns, freezes, knocks back ennemies and makes them loose flying for a short time around you.\n- Cost : 100 energy\n- Power : 2 damage per second on nearest tiles\n- Range : 3.5 tiles\nDuration : 25 seconds\n\n[Aura]:\nDuration increased by 5 seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local power = (spells_functions.script.getSkillPower(champion, "fire_magic")+1) * 2
    local duration = spells_functions.script.getPower(champion:hasTrait("aura") and 30 or 25, champion, "water_magic", "earth_magic")
    local range = 3.5
    spells_functions.script.partySound("fire_elemental_burn", duration, 10, 10)
    spells_functions.script.partyLight("water_earth_fire", duration, vec(1, 1, 1), 5, 1)
    -- spawns <effects> around entity <centerID> up to <range> tiles on xy plan,
    -- and elevation if <sphere> is true, in <duration> seconds,
    -- with <power> decreasing with squared distance, cast by <ordinal> champion,
    -- checking line of fire if <checkMode> ~= "NA".
    -- function zoneEffects(effects, centerID, range, sphere, duration, power, ordinal, checkMode)
    spells_functions.script.durationEffects(0, duration, "zoneEffects", {"all_shall_fall_blast", "party", range, true, 0, power, champion:getOrdinal()})
    spells_functions.script.stopInvisibility()
    spells_functions.script.maxEffectIcons("all_shall_fall", duration)
  end
},

-- earth, fire & air magic 

{
  name = "misdirection",
  uiName = "Misdirection",
  requirements = {"earth_magic", 1, "fire_magic", 1, "air_magic", 1},
  gesture = 741236,
  manaCost = 30,
  description = "Redirects all damage received to the most healthy (on cast) among you and your friends. Grants this champion a magical shield.\n- Cost : 30 energy\n- Duration : 15 seconds\n- Power : up to 20% damage reduction\n\n[Knight]:\nRedirects damage to you and reduces it by up to 40% instead.\n\n[Fighter]:\nDuration increased by 5 seconds.\n\n[Martial Training]:\nDuration increased by 5 seconds.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local power = spells_functions.script.getPower(1, champion, "earth_magic", "fire_magic", "air_magic")
    local duration = (15 + (champion:hasTrait("fighter") and 5 or 0) + (champion:hasTrait("weapon_specialization") and 5 or 0))*power
    local kni = champion:hasTrait("knight")
    local ord = kni and champion:getOrdinal() or spells_functions.script.mostHealthy()
    local old = spells_functions.script.tauntTank
    if old>0 then spells_functions.script.removeEffectIcons("misdirection", 0, old) end
    spells_functions.script.taunt(duration, ord)
    spells_functions.script.addShield(1-(kni and 0.4 or 0.2)*(power-1)/power, duration, ord)
    spells_functions.script.partyLight("earth_fire_air", 1, vec(1, 0.25, 0), 30)
    spells_functions.script.insertEffectIcons("misdirection", duration, ord)
  end
},

{
  name = "desolation_shield",
  uiName = "Desolation Mage Armor",
  requirements = {"earth_magic", 2, "fire_magic", 2, "air_magic", 2},
  gesture = 587412365,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nEarth, Fire & Air +2%\nWater -6%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("desolation_shield", champion)
  end
},

{
  name = "desolation",
  uiName = "Desolation",
  requirements = {"earth_magic", 3, "fire_magic", 3, "air_magic", 3},
  gesture = 74123,
  manaCost = 68,
  description = "Unleashes a devastating storm of poison, fire and ligthning on your foes.\n- Cost : 68 energy\nPower : 15 per poison bolt, 30 per fireball, 27 per lightning bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "earth_magic", "fire_magic", "air_magic")
    spells_functions.script.missiles(power, {"poison_bolt_greater_cast", "fireball_large_cast", "lightning_bolt_greater_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "swap",
  uiName = "Swap",
  requirements = {"earth_magic", 4, "fire_magic", 4, "air_magic", 4},
  gesture = 7854123,
  manaCost = 0,
  description = "Launches a pure magical bolt which deals no damage but swaps the party's position if it hits a living obstacle.\n- Cost : 250 energy\n\n[Head Hunter or Mutation]:\nThis spell costs 125 energy instead.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = (champion:hasTrait("head_hunter") or champion:hasTrait("mutation")) and 125 or 250
    spells_functions.script.paySpellCost(champion, cost)
    spells_functions.script.missile("swap_bolt", champion:getOrdinal())
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = (champion:hasTrait("head_hunter") or champion:hasTrait("mutation")) and 125 or 250
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

{
  name = "life_steal_bolt",
  uiName = "Vampiric Bolt",
  requirements = {"earth_magic", 5, "fire_magic", 5, "air_magic", 5},
  gesture = 8741236,
  manaCost = 120,
  description = "You hurl a bolt stealing health and healing all champions.\n- Cost : 120 energy\n- Power : 40\n\n[Tough]:\nDrains 10% more health.\n\n[Firearms 3]:\nFor the next 15 seconds, your next firearm attack also triggers this spell for free.",
  onCast = function(champion, x, y, direction, elevation, skillLevel, trigger)
    local ord = champion:getOrdinal()
    if champion:getSkillLevel("firearms") > 2 and not trigger then spells_functions.script.maxEffectIcons("life_steal_bolt", 15, ord) end
    local power = spells_functions.script.getPower(champion:hasTrait("tough") and 44 or 40, champion, "earth_magic", "fire_magic", "air_magic")
    spells_functions.script.missile("life_steal_bolt", ord, power)
    spells_functions.script.stopInvisibility()
  end
},

-- fire, air and water magic 

{
  name = "cure_petrify",
  uiName = "Flow of Mind",
  requirements = {"fire_magic", 1, "air_magic", 1, "water_magic", 1},
  gesture = 412369,
  manaCost = 25,
  description = "You and your friends are immune to petrified and paralyzed conditions. Duration is cumulative.\n- Cost : 25 energy\n- Duration : 20 seconds\n\n[Poison Resistant]:\nDuration is doubled.\n\n[Poison Immunity]:\nDuration is doubled.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = 20 * (champion:hasTrait("poison_resistant") and 2 or 1) * (champion:hasTrait("poison_immunity") and 2 or 1)
    duration = spells_functions.script.getPower(duration, champion, "fire_magic", "air_magic", "water_magic")
    for ord = 1,4 do spells_functions.script.cure(ord, 2, {"paralyzed", "petrified"}) end
    spells_functions.script.partyLight("flow_of_mind", 1, vec(1, 0.5, 0.75), 40)
    spells_functions.script.addEffectIcons("cure_petrify", duration)
  end
},

{
  name = "sky_shield",
  uiName = "Sky Mage Armor",
  requirements = {"fire_magic", 2, "air_magic", 2, "water_magic", 2},
  gesture = 541236985,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nFire, Air & Water +2%\nEarth -6%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("sky_shield", champion)
  end
},

{
  name = "wrath_of_the_sky",
  uiName = "Wrath of the Sky",
  requirements = {"fire_magic", 3, "air_magic", 3, "water_magic", 3},
  gesture = 12369,
  manaCost = 68,
  description = "Unleashes a devastating storm of fire, ligthning and ice on your foes.\n- Cost : 68 energy\nPower : 30 per fireball, 27 per lightning bolt, 15 per frost bolt",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "fire_magic", "air_magic", "water_magic")
    spells_functions.script.missiles(power, {"fireball_large_cast", "lightning_bolt_greater_cast", "frostbolt_cast"}, champion:getOrdinal(), 1, true)
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "transfer",
  uiName = "Transfer",
  requirements = {"fire_magic", 4, "air_magic", 4, "water_magic", 4},
  gesture = 1236589,
  manaCost = 0,
  description = "Launches a pure magical bolt which deals no damage but teleports the party if it hits a lifeless obstacle.\n- Cost : 250 energy\n\n[Skilled]:\nThis spell costs 125 energy instead.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = champion:hasTrait("skilled") and 125 or 250
    spells_functions.script.paySpellCost(champion, cost)
    spells_functions.script.missile("transfer_bolt", champion:getOrdinal())
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = champion:hasTrait("skilled") and 125 or 250
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

{
  name = "energy_whirl",
  uiName = "Energy Whirl",
  requirements = {"fire_magic", 5, "air_magic", 5, "water_magic", 5},
  gesture = 41236985,
  manaCost = 10,
  description = "For the duration, each spell cast by you or your friends restores 75% of its energy cost over 15 seconds. Only duration is cumulative.\n- Cost : 10 energy\n- Duration : 30 seconds\n\n[Wizard]:\nDuration is doubled.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local duration = spells_functions.script.getPower(champion:hasTrait("wizard") and 60 or 30, champion, "air_magic", "water_magic")
    spells_functions.script.addEffectIcons("energy_whirl", duration)
  end
},

-- fire, air, water and earth magic 

{
  name = "elemental_shield",
  uiName = "Elemental Mage Armor",
  requirements = {"fire_magic", 1, "air_magic", 1, "water_magic", 1, "earth_magic", 1},
  gesture = 236987412,
  manaCost = 0,
  description = "Creates a Mage Armor enhancing your magical power and draining all your energy, or cancels it if it is already active. You can only have one Mage Armor active at any time.\nSpells power per level:\nFire, Air, Water & Earth +1.5%\nConcentration -6%\n- Cost : 0 energy\n- Duration : until canceled",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    spells_functions.script.elementalArmor("elemental_shield", champion)
  end
},

{
  name = "elemental_storm",
  uiName = "Elemental Storm",
  requirements = {"fire_magic", 2, "air_magic", 2, "water_magic", 2, "earth_magic", 2},
  gesture = 1478963,
  manaCost = 69,
  description = "Unleashes a devastating storm of fire, ligthning, ice and poison on your foes.\n- Cost : 69 energy\nPower : 30 per fireball, 27 per lightning bolt, 15 per frost bolt, 15 per poison bolt\n\n[Wizard]:\nFor 15 seconds, you gain Concentration spells power +100%.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local power = spells_functions.script.getPower(2.5, champion, "fire_magic", "air_magic", "water_magic", "earth_magic")
    spells_functions.script.missiles(power, {"fireball_large_cast", "lightning_bolt_greater_cast", "frostbolt_cast", "poison_bolt_greater_cast"}, champion:getOrdinal(), 1, true)
    if champion:hasTrait("wizard") then
      spells_functions.script.addSkillPower(champion, "concentration", 100, 15)
    end
    spells_functions.script.stopInvisibility()
  end
},

{
  name = "immortal",
  uiName = "Immortal",
  requirements = {"fire_magic", 3, "air_magic", 3, "water_magic", 3, "earth_magic", 3},
  gesture = 7412369,
  manaCost = 200,
  description = "Protects you and your alive friends from death once. Regained health depends on spell power and number of champions protected. This spell is not cumulative.\n- Cost : 200 energy\n- Power : 100\n- Duration : 30 seconds\n\n[Battle Mage]:\nDuration increased by 10 seconds.\n\n[Athletics 2]:\nPower increased by 50.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local ratio = spells_functions.script.getPower(1, champion, "fire_magic", "air_magic", "water_magic", "earth_magic")
    local power = (champion:getSkillLevel("athletics") > 1 and 150 or 100) * ratio
    local duration = (champion:hasTrait("battle_mage") and 40 or 30) * ratio
    local champions = spells_functions.script.getChampions("alive")
    for _,c in ipairs(champions) do
      local ord = c:getOrdinal()
      spells_functions.script.resurrectGain[ord] = power/#champions
      spells_functions.script.maxConditionValue("revive", duration, ord)
    end
    spells_functions.script.maxEffectIcons("immortal", duration)
  end
},

{
  name = "might",
  uiName = "Might",
  requirements = {"fire_magic", 4, "air_magic", 4, "water_magic", 4, "earth_magic", 4},
  gesture = 1236987,
  manaCost = 0,
  description = "Doubles strength, agility, vitality and willpower of all champions. Only duration is cumulative.\n- Cost : 120 energy\n- Duration : 15 seconds\n\n[Fighter]:\nThis spell costs 60 energy instead.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    playSound("generic_spell")
    local cost = champion:hasTrait("fighter") and 60 or 120
    spells_functions.script.paySpellCost(champion, cost)
    local duration = spells_functions.script.getPower(15, champion, "fire_magic", "air_magic", "water_magic", "earth_magic")
    spells_functions.script.addConditionValue("might", duration)
    spells_functions.script.partyLight("fire_air_water_earth", 1, vec(1, 1, 1), 10)
    spells_functions.script.addEffectIcons("might", duration)
  end,
  preCast = function(champion, x, y, direction, elevation, skillLevel)
    local cost = champion:hasTrait("fighter") and 60 or 120
    if champion:getEnergy() < cost then return false,"no_energy" end
  end,
},

{
  name = "alter_time",
  uiName = "Alter Time",
  requirements = {"fire_magic", 5, "air_magic", 5, "water_magic", 5, "earth_magic", 5},
  gesture = 3214789,
  manaCost = 150,
  description = "Slows the flowing of time and gives you and your friends haste and running speed to compensate. The duration of the spell from your point of view is affected by the time dilation. This spell is not cumulative.\n- Cost : 150 energy\n- Duration : 5 seconds\n\n[Rogue]:\nDuration increased by 2 seconds.\n\n[Evasive]:\nTime dilation increased by 22%.",
  onCast = function(champion, x, y, direction, elevation, skillLevel)
    local duration = spells_functions.script.getPower(champion:hasTrait("rogue") and 7 or 5, champion, "fire_magic", "air_magic", "water_magic", "earth_magic")
    spells_functions.script.alterTime(champion:hasTrait("evasive") and 0.45 or 0.5, duration)
    spells_functions.script.partyLight("fire_air_water_earth", duration, vec(0.25, 0, 1), 5)
    spells_functions.script.maxEffectIcons("alter_time", duration)
  end
},

-- hidden spells

{
  name = "not_enough_energy",
  uiName = "Not Enough Energy",
  requirements = {},
  gesture = 121,
  manaCost = math.huge,
  icon = 59,
  spellIcon = 0,
  description = "",
  onCast = function(champion, x, y, direction, elevation, skillLevel) end,
  hidden = true,
},

{
  name = "open_serpent_door",
  uiName = "Open Door",
  gesture = 0,
  manaCost = 25,
  onCast = "openDoor",
  skill = "concentration",
  requirements = { "concentration", 1 },
  icon = 59,
  spellIcon = 0,
  description = "",
  hidden = true,
},

{
  name = "disintegrate",
  uiName = "Disintegrate",
  gesture = 0,
  manaCost = 0,
  onCast = "disintegrate",
  skill = "concentration",
  requirements = { "concentration", 5 },
  icon = 59,
  spellIcon = 0,
  description = "",
  hidden = true,
},

{
  name = "balance",
  uiName = "Balance",
  gesture = 0,
  manaCost = 10,
  onCast = "balance",
  skill = "concentration",
  requirements = {},
  icon = 59,
  spellIcon = 0,
  description = "",
  hidden = true,
},

{
  name = "cause_fear",
  uiName = "Cause Fear",
  gesture = 0,
  manaCost = 25,
  onCast = "causeFear",
  skill = "concentration",
  requirements = { "concentration", 3 },
  icon = 33,
  spellIcon = 0,
  description = "",
  hidden = true,
},

{
  name = "heal",
  uiName = "Heal",
  gesture = 0,
  manaCost = 50,
  onCast = "heal",
  skill = "concentration",
  requirements = { "concentration", 3 },
  icon = 33,
  spellIcon = 0,
  description = "",
  hidden = true,
},

}

for i,def in pairs(defOrdered) do
  if not def.icon then
    def.icon = 0
    def.iconAtlas = path.."textures/gui/icons_75x75/"..def.name..".tga"
    def.spellIcon = 0
    def.spellIconAtlas = path.."textures/gui/icons_50x50/"..def.name..".tga"
  end
  def.index = i
end

defByName = {} for _,def in pairs(defOrdered) do defByName[def.name] = def end

data = {}
function get(name) return data[name] end
function set(name,value) data[name] = value end

function quantum(float)
  local int = math.floor(float)
  if math.random() < float-int then return int+1 else return int end
end

function setPower(champion, skill, slot, num) data[skill..champion:getOrdinal()..slot] = num end

skillSpells = {concentration = "arcane_nova", fire_magic = "fire_wall", air_magic = "shock", water_magic = "ice_shards", earth_magic = "healing"}
function addSkillPower(champion, skill, num, duration)
  local ord = champion:getOrdinal()
  local key = skill..ord
  local power = get(key) or {}
  power[#power+1] = {num, party.gametime:getValue()+duration}
  set(key, power)
  local spell = skillSpells[skill]
  if spell then maxEffectIcons(spell, duration, ord) end
end

function getSkillPower(champion, skill)
  local ord = champion:getOrdinal()
  local result = champion:getSkillLevel(skill) / 5
  local k = skill..ord
  for slot = 1,10 do
    local p = data[k..slot]
    if p then result = result + p/100 end
  end
  local power,t = get(skill..ord) or {}, party.gametime:getValue()
  for i = #power,1,-1 do if t > power[i][2] then table.remove(power,i) else result = result + power[i][1]/100 end end
  local armor = get("mage_armor"..ord)
  if armor then
    armor = armor and mageArmors[armor]
    if armor then result = result + (armor[skill] or 0)*champion:getLevel()/100 end
  end
  return result>0 and result or 0
end

function getSpellCriticalChance(champion)
  local chance = 0
  if champion:hasTrait("mage_strike") then
	  chance = chance + (3 * champion:getSkillLevel("critical"))
	  for slot = 1,ItemSlot.Bracers do
		local item = champion:getItem(slot)
		if item and item.equipmentitem then
		  local crit = item.equipmentitem:getCriticalChance()
		  if crit and crit ~= 0 then chance = chance + crit end
		end
	  end
  end
  return chance
end

function getPower(base, champion, skill1, skill2, skill3, skill4, skill5)
	local f = getSkillPower(champion, skill1) + champion:getCurrentStat("willpower")/50 + 1
	if skill2 then
		f = f + getSkillPower(champion, skill2)
		if skill3 then
			f = f + getSkillPower(champion, skill3)
			if skill4 then
				f = f + getSkillPower(champion, skill4)
				if skill5 then
					f = f + getSkillPower(champion, skill5)
				end 
			end 
		end 
	end
	if champion:hasTrait("persistence") then
		f = f * (1.00 + (champion:getCurrentStat("strength") * 0.01))
	end	
  return base * f * (get("crit") and 2 or 1)
end

function quantumPower(base, champion, skill1, skill2, skill3, skill4, skill5)
  return quantum(getPower(base, champion, skill1, skill2, skill3, skill4, skill5))
end

function silentZone()
  for i = 1,4 do
    local c = party.party:getChampion(i)
    c:setConditionValue("silence", math.huge)
  end
end
function normalZone()
  for i = 1,4 do
    local c = party.party:getChampion(i)
    c:removeCondition("silence")
  end
end

function onCastSpell(champion, spellName)
  if champion:hasCondition("frozen_champion") then
    champion:regainEnergy(defByName[spellName].manaCost)
    hudPrint(champion:getName().." is frozen.")
    playSound("spell_fizzle")
    return false
  end
  if champion:hasCondition("silence") then
    champion:regainEnergy(defByName[spellName].manaCost)
    hudPrint(champion:getName().." can't cast spells.")
    playSound("spell_fizzle")
    return false
  end
  --if defByName[spellName].hidden then return true end
  local cast = spellKnown(champion, spellName)
  if cast then
    if defByName[spellName].preCast then
      local success,failReason = defByName[spellName].preCast(champion, party.x, party.y, party.facing, party.elevation, champion:getSkillLevel(defByName[spellName].skill or "concentration"))
      if success == false then
        if failReason == "no_energy" then
          champion:castSpell(121)
        else
          local sound = false
          for _,c in ipairs(getChampions("alive")) do
            if not c:hasTrait(spellName) then
              local learn = true
              local req = defByName[spellName].requirements
              for r = 1,#req,2 do if c:getSkillLevel(req[r]) < req[r+1] then learn = false break end end
              if learn then c:addTrait(spellName) hudPrint(c:getName().." learned a new spell!") sound = true end
            end
          end
          if sound then playSound("discover_spell") end
        end
        champion:regainEnergy(defByName[spellName].manaCost)
        return false
      end
    end
    local crit = math.random()*100 < getSpellCriticalChance(champion)
    if crit then
      champion:showAttackResult("Critical", "HitSplashLarge")
      if champion:hasTrait("spirit") then
        local ord = champion:getOrdinal()
        setArcane(arcanePower[ord]+1, ord)
      end
    end
    set("crit", crit)
    hasPaidSpellCost(champion, defByName[spellName].manaCost)
    if spellName ~= "copycat" then lastSpellCast = spellName end
    local sound = false
    for _,c in ipairs(getChampions("alive")) do
      if c ~= champion and not c:hasTrait(spellName) then
        local learn = true
        local req = defByName[spellName].requirements
        for r = 1,#req,2 do if c:getSkillLevel(req[r]) < req[r+1] then learn = false break end end
        if learn then c:addTrait(spellName) hudPrint(c:getName().." learned a new spell!") sound = true end
      end
    end
    if sound then playSound("discover_spell") end
  else
    champion:regainEnergy(defByName[spellName].manaCost)
    hudPrint(champion:getName().." must learn this spell from a scroll or another caster before casting it.")
    playSound("spell_fizzle")
  end
  return cast
end

missile_cast = {"darkbolt", "fireball", "lightning_bolt", "frostbolt", "poison_bolt"}
firearm_cast = {"antipode", "drain_life_bolt", "life_steal_bolt"}
function onAttack(champion, action, slot)
  if champion:hasCondition("frozen_champion") then return false end
  if action then
    if action:getClass() == "MeleeAttackComponent" then
      local item = champion:getItem(slot)
      if not item then return end
      local spell = champion:hasTrait("spell_slinger") and defByName[functions.script.spellSlinger[champion:getOrdinal()]] or nil
      if not spell then return end
      for i = 1,quantum(action:getCooldown()*0.05) do
        set("crit", math.random()*100 < getSpellCriticalChance(champion))
        spell.onCast(champion, party.x, party.y, party.facing, party.elevation, 3)
      end
    else
      -- local tab = (action:getClass() == "RangedAttackComponent" and missile_cast) or (action:getClass() == "FirearmAttackComponent" and firearm_cast)
      -- if tab then
        -- local ammo = action:getAmmo()
        -- local item = champion:getOtherHandItem(slot)
        -- if not ammo or (item and item.go.name == ammo) then
          -- local ord = champion:getOrdinal()
          -- for _,name in ipairs(tab) do
            -- if hasEffectIcons(name, ord) then
              -- local spell = defByName[name]
              -- set("crit", math.random()*100 < getSpellCriticalChance(champion))
              -- spell.onCast(champion, party.x, party.y, party.facing, party.elevation, champion:getSkillLevel(spell.skill or "concentration"), true)
              -- removeEffectIcons(name, 0, ord)
            -- end
          -- end
        -- end
      -- end
    end
  end
  return true
end

sacred_armor = true
function onDamage(champion, damage, damageType)
  deepSleep = false
  if champion:hasCondition("frozen_champion") and damageType == "fire" then champion:setConditionValue("frozen_champion", 0.01) end
  local ordinal = champion:getOrdinal()
  if tauntTank > 0 and tauntTank ~= ordinal then
    if party.gametime:getValue() < tauntTime then
      party.party:getChampionByOrdinal(tauntTank):damage(damage, damageType)
      partyLight("shield", 0.5, vec(1, 1, 1), 100, 1, 0.1)
      return false
    else
      tauntTank = 0
    end
  end
  if vengeanceToDo and vengeanceTime then
    if party.gametime:getValue() < vengeanceTime then
      local power = math.min(damage, champion:getMaxHealth()/10-(champion:getConditionValue("vengeance") or 0))
      addConditionValue("vengeance", power, ordinal)
    else
      vengeanceTime = nil
    end
  end
  if champion:hasCondition("invulnerability") then return false end
  if sacred_armor and champion:hasTrait("sacred_armor") then
    sacred_armor = false
    champion:damage(damage*0.9, damageType)
    sacred_armor = true
    return false
  end
  local shield = shield[ordinal]
  if shield[1] and #shield[3] > 0 then
    shield[1] = false
    vengeanceToDo = false
    champion:damage(damage*shield[2], damageType)
    vengeanceToDo = true
    shield[1] = true
    return false
  end
  if champion:hasCondition("energy_shield") then
    local energy = champion:getEnergy()
    if energy > 0 then
      if energy < damage then
        champion:setEnergy(0)
        vengeanceToDo = false
        champion:damage(damage-energy, damageType)
        vengeanceToDo = true
      else
        champion:regainEnergy(-damage)
      end
      partyLight("shield", 0.5, vec(1, 1, 1), 100, 1, 0.1)
      return false
    end
  end
  return true
end

function onDie(champion)
  if champion:hasCondition("revive") then
    local ord = champion:getOrdinal()
    resurrect(resurrectGain[ord], champion)
    resurrectGain[ord] = 0
    champion:removeCondition("revive")
    for _,c in ipairs(getChampions()) do if c:hasCondition("revive") then return end end
    removeEffectIcons("immortal")
  elseif tauntTank == champion:getOrdinal() then
    tauntTank = 0
  end    
end

function onReceiveCondition(champion, condition)
  if condition == "petrified" or condition == "paralyzed" then
    if hasEffectIcons("cure_petrify") then return false end
  elseif condition == "head_wound" then
    if hasEffectIcons("force_of_will", champion:getOrdinal()) then return false end
  elseif condition == "poison" then
    if champion:hasTrait("poison_immunity") then return false end
  end
  if tauntTank > 0 and tauntTank ~= champion:getOrdinal() then
    if party.gametime:getValue() < tauntTime then
      for _,c in ipairs(negative_conditions) do
        if c == condition then
          partyLight("shield", 0.5, vec(1, 1, 1), 100, 1, 0.1)
          local shield = shield[tauntTank]
          if #shield[3] > 0 and shield[2] <= math.random() then return false end
          party.party:getChampionByOrdinal(tauntTank):setCondition(condition)
          return false
        end
      end
    else
      tauntTank = 0
    end
  end
end

function checkLineOfFire(map, x1, y1, z1, x2, y2, z2, dim1, dim2, dim3)
  local dx, dy, dz = x2-x1, y2-y1, z2-z1
  local sx, sy, sz = math.sign(dx), math.sign(dy), math.sign(dz)
  local ax, ay, az = sx*dx, sy*dy, sz*dz
  local tiles = ax + ay + az
  if tiles < 1 then return true end
  if not dim1 then
    for e in map:entitiesAt(x2, y2) do
      if e.elevation == z2 and e.forcefield and not e.health and e.forcefield:isEnabled() then return false end
    end
    if ax == ay and ay == az then
      return checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "x", "y", "z")
          or checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "y", "z", "x")
          or checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "z", "x", "y")
          or checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "z", "y", "x")
          or checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "y", "x", "z")
          or checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "x", "z", "y")
    elseif ax > 0 and ax == ay then 
      return checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "x", "y", "z")
          or checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "y", "x", "z")
    elseif ay > 0 and ay == az then 
      return checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "y", "z", "x")
          or checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "z", "y", "x")
    elseif az > 0 and az == ax then 
      return checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "z", "x", "y")
          or checkLineOfFire(map, x1, y1, z1, x2, y2, z2, "x", "z", "y")
    else
      dim1, dim2, dim3 = "x", "y", "z"
    end
  end
  local steps = {}
  local dimensions = {dim1, dim2, dim3}
  for _,dim in ipairs(dimensions) do
    if dim == "x" then if sx ~= 0 then table.insert(steps, {x = sx, y =  0, z =  0}) end end 
    if dim == "y" then if sy ~= 0 then table.insert(steps, {x =  0, y = sy, z =  0}) end end 
    if dim == "z" then if sz ~= 0 then table.insert(steps, {x =  0, y =  0, z = sz}) end end
  end
  local x, y, z = x1, y1, z1
  for i = 1, tiles do
    local xf, yf, zf = x1+i*dx/tiles, y1+i*dy/tiles, z1+i*dz/tiles
    local d2min = math.huge
    local xt, yt, zt = nil, nil, nil
    for _,s in ipairs(steps) do
      local xm, ym, zm = x + s.x, y + s.y, z + s.z
      local d2 = (xm-xf)^2 + (ym-yf)^2 + (zm-zf)^2
      if d2 < d2min then d2min, xt, yt, zt = d2, xm, ym, zm end
    end
    if x == xt and y == yt then
      local zu, zd = math.max(z, zt), math.min(z, zt)
      if map:getElevation(x, y) > zd then return false end
      for e in map:entitiesAt(x, y) do
        if e.platform and e.platform:isEnabled() and e.elevation == zu then return false end
      end
    else
      if not map:checkLineOfFire(x, y, xt, yt, z) then return false end
    end
    --spawn("flashflare_cloud", map.level, x, y, 1, z)
    x, y, z = xt, yt, zt
  end
  --spawn("flashflare_cloud", map.level, x, y, 1, z)
  return true
end

-- Builtin burst spell rules:
-- Try to target the square in front of the party.
-- If this square is solid, or is blocked by an ObstacleComponent that would
-- block the party and its parent GameObject does NOT have a component named
-- "health", target the party's square instead.
-- If the path between the party and this square is blocked by a door, target
-- the party's square instead.
--
-- This function emulates this behaviour.
--
-- NOTE: The builtin poison_cloud spell is a little different: it can be cast
-- through sparse doors (but not non-sparse ones). This behaviour in the
-- original game is intended, and easy to replicate, but since it leads to
-- abuses I don't think anyone actually wants it, so I haven't implemented it.
function getFrontTarget(blockedByHealth)
  local dx,dy = getForward(party.facing)
  local nx = party.x+dx
  local ny = party.y+dy
  local obs = party.map:checkObstacle(party, party.facing)
  if obs == "door" or obs == "wall" then
    return party.x, party.y
  elseif obs == "obstacle" then
    for e in party.map:entitiesAt(nx, ny) do
      if e.elevation == party.elevation and (blockedByHealth or not e.health) then
        for _,c in e:componentIterator() do
          if (c:getClass() == "ObstacleComponent" and c:getBlockParty()) or (c:getClass() == "ForceFieldComponent" and c:isEnabled()) then
            return party.x, party.y
          end
        end
      end
    end
    for e in party.map:entitiesAt(party.x, party.y) do
      if e.elevation == party.elevation then
        for _,c in e:componentIterator() do
          if c:getClass() == "ForceFieldComponent" and c:isEnabled() then
            return party.x, party.y
          end
        end
      end
    end
  end
  return nx, ny
end

function frontAttack(attack, power, ordinal)
	local x,y = getFrontTarget()
	local dx,dy = getFrontTarget()
	local a = spawn(attack, party.level, x, y, party.facing, party.elevation)
		if attack == "poison_cloud_large" then
		local success = 0
		for e in party.map:entitiesAt(dx, dy) do
			if e ~= nil then			
				local herb_items = {"blooddrop_cap", "blooddrop_cap", "etherweed", "etherweed", "mudwort", "mudwort", "blackmoss", "falconskyre", "falconskyre"}
				local herb = herb_items[math.random(#herb_items)]
				if e.name == "borra" then	
					spawn(herb, 1, e.x, e.y, e.facing, e.elevation)
					success = success + 1
					e:destroy()
				elseif e.name == "bread" then
					spawn(herb, 1, e.x, e.y, e.facing, e.elevation)
					success = success + 1
					e:destroy()
				elseif e.name == "pitroot_bread" then
					spawn(herb, 1, e.x, e.y, e.facing, e.elevation)
					success = success + 1
					e:destroy()
				elseif e.name == "baked_maggot" then
					spawn(herb, 1, e.x, e.y, e.facing, e.elevation)
					success = success + 1
					e:destroy()
				end
			end		
		end
		if success > 0 then
			hudPrint("The caustic fumes caused herbs to sprout from the food...")
		end
	end
	if a.tiledamager then a.tiledamager:setCastByChampion(ordinal) a.tiledamager:setAttackPower(power) end
	if a.cloudspell then a.cloudspell:setCastByChampion(ordinal) a.cloudspell:setAttackPower(power) end
	if a.forcefield then delayedCall(a.id, power, "deactivate") delayEffects(power+3, destroy, {a.id}) end
	return a
end

function destroy(o) if o then o = findEntity(o) if o then o:destroy() end end end

function missiles(power, tab, ordinal, duration, random)
  power = quantum(power)
  if (power < 1) then return end
  local start = math.random(#tab)
  if not duration then duration = 1 end
  for i = 0, power-1 do
   delayEffects(duration*i/power, baseMissile, {tab[1 + (start + i)%#tab], ordinal, random})
  end
end

function baseMissile(name, ordinal, random) missile(name, ordinal, nil, nil, random) end

function missile(name, ordinal, attackPower, duration, random)
  local m = spawn(name, party.level, party.x, party.y, party.facing, party.elevation)
  m:setWorldPosition(getPosition(ordinal, random))
  m.projectile:setIgnoreEntity(party)
  m.projectile:setCastByChampion(ordinal)
  if attackPower then m.data:set("attackPower", attackPower) end
  if duration then m.data:set("duration", duration) end
  return m
end

function getPosition(ordinal, random)
  local left = nil
  for i = 1,4 do
    if party.party:getChampion(i):getOrdinal() == ordinal then
      left = i == 1 or i == 3
      break
    end
  end
  local dx = nil
  local dy = random and (1.35 + 0.5*math.random() - 0.25) or 1.35
  local dz = nil
  if party.facing == 0 then
    dx = left and -0.1 or 0.1
    dz = -1
    if random then dx = dx + math.random() - 0.5 end
  elseif party.facing == 1 then
    dz = left and 0.1 or -0.1
    dx = -1
    if random then dz = dz + math.random() - 0.5 end
  elseif party.facing == 2 then
    dx = left and 0.1 or -0.1
    dz = 1
    if random then dx = dx + math.random() - 0.5 end
  else -- party.facing == 3
    dz = left and -0.1 or 0.1
    dx = 1
    if random then dz = dz + math.random() - 0.5 end
  end
  return party:getWorldPosition()+vec(dx,dy,dz)
end

function stopInvisibility()
  for i = 1,4 do
    party.party:getChampionByOrdinal(i):removeCondition("invisibility")
  end
  removeEffectIcons("invisibility")
end

-- delayedCall alternative

delayedEffects = {}

function delayEffects(delay, func, args)
  if delay > 0 then
    delay = delay + party.gametime:getValue()
    local de = delayedEffects
    while de.n and de.n.t <= delay do de = de.n end
    if de.t == delay then
      table.insert(de, math.random(#de+1), {f = func, a = args})
    else
      de.n = {t = delay, {f = func, a = args}, n = de.n}
    end
  else
    func(unpack(args))
  end
end

maxEffectsPerFrame = 16
function updateDelayedEffects(t,l)
  local limit = l or maxEffectsPerFrame
  local de = delayedEffects
  while de and de.n and de.n.t <= t do
    local i = #de.n
    if i > 0 then
      local e = de.n[i] 
      de.n[i] = nil
      e.f(unpack(e.a))
      if limit > 1 then limit = limit-1 else return end
    else
      de.n = de.n.n
    end
    de = de.n
  end
  if limit < (l or maxEffectsPerFrame) then updateDelayedEffects(t,limit) end
end

function setMaxEffectsPerFrame(n) maxEffectsPerFrame = n end

function durationEffects(start, stop, funcName, args, step)
  for delay = start,stop,step or 1 do delayEffects(delay, self[funcName], args) end
end

function addDurationEffects(name, start, stop, funcName, args, step)
  name = name.."_until"
  local d = get(name)
  local t = party.gametime:getValue()
  if d and d > t then
    durationEffects(d-t+math.max(start, step or 1), d-t+stop, funcName, args, step)
    set(name, d+stop)
  else
    durationEffects(start, stop, funcName, args, step)
    set(name, t+stop)
  end
end

function maxDurationEffects(name, start, stop, funcName, args, step)
  name = name.."_until"
  local d = get(name)
  local t = party.gametime:getValue()
  if d and d > t then
    if d-t > stop then return end
    durationEffects(d-t+math.max(start, step or 1), stop, funcName, args, step)
  else
    durationEffects(start, stop, funcName, args, step)
  end
  set(name, t+stop)
end

-- spawns <effects> around entity <centerID> up to <range> tiles on xy plan,
-- and elevation if <sphere> is true, in <duration> seconds,
-- with <power> decreasing with squared distance, cast by <ordinal> champion,
-- checking line of fire if <checkMode> ~= "NA".
function zoneEffects(effects, centerID, range, sphere, duration, power, ordinal, checkMode)
  local w, h = party.map:getWidth(), party.map:getHeight()
  local r, rz, r2 = math.ceil(range), sphere and math.ceil(range) or 0, range*range
  local c = findEntity(centerID) or party
  local ox, oy, oz = c.x, c.y, c.elevation
  for dx = math.max(-r,-ox),math.min(r,w-ox-1) do
    local x = ox + dx
    for dy = math.max(-r,-oy),math.min(r,h-oy-1) do
      local y = oy + dy
      local dxy2 = dx*dx + dy*dy
      if dxy2 <= r2 then
        for dz = math.max(-rz,-7-oz),math.min(rz,7-oz) do
          local z = oz + dz
          local d2 = dxy2 + dz*dz
          if d2 <= r2 and (checkMode == "NA" or checkLineOfFire(party.map, ox, oy, oz, x, y, z)) then
            local ratio, delay = d2>1 and 1-(d2-1)/r2 or 1, duration*d2/r2
            delayEffects(delay, tileEffects, {effects, x, y, z, dx, dy, dz, (power or 0)*ratio, ordinal})
          end
        end
      end
    end
  end
end

function tileEffects(effects, x, y, z, dx, dy, dz, power, ordinal)
  if type(effects) == "table" then
    for _,effect in ipairs(effects) do tileEffect(effect, x, y, z, dx, dy, dz, power, ordinal) end
  else
    tileEffect(effects, x, y, z, dx, dy, dz, power, ordinal)
  end
end

function tileEffect(effect, x, y, z, dx, dy, dz, power, ordinal)
  local center = false
  if type(effect) == "table" then center = effect[2] effect = effect[1] end
  if not center and dx == 0 and dy == 0 and dz == 0 then return end
  for _,d in ipairs(damageTypes) do
    if effect == d then
      local flags = DamageFlags.Impact + DamageFlags.CameraShake + DamageFlags["Champion"..ordinal]
      damageTile(party.level, x, y, party.facing, z, flags, effect, power)
      return
    end
  end
  local e = spawn(effect, level, x, y, math.random(0,3), z)
  if e.tiledamager then e.tiledamager:setAttackPower(power) e.tiledamager:setCastByChampion(ordinal) end
  if e.cloudspell then e.cloudspell:setAttackPower(power) e.cloudspell:setCastByChampion(ordinal) end
end

damageTypes = {"physical", "fire", "shock", "cold", "poison"}

function randomOrder(tab)
  local result = {}
  for i = 1,#tab do table.insert(result, math.random(i), tab[i]) end
  return result
end

function getChampions(filter, result, order)
  local tab = {} for i = 1,4 do table.insert(tab, party.party:getChampionByOrdinal(i)) end
  if filter == "enabled" then
    for i = #tab,1,-1 do if not tab[i]:getEnabled() then table.remove(tab, i) end end
  elseif filter == "alive" then
    for i = #tab,1,-1 do if not tab[i]:getEnabled() or not tab[i]:isAlive() then table.remove(tab, i) end end
  elseif filter == "dead" then
    for i = #tab,1,-1 do if not tab[i]:getEnabled() or tab[i]:isAlive() then table.remove(tab, i) end end
  end
  if result == "ordinal" then for i = 1,#tab do tab[i] = tab[i]:getOrdinal() end end
  if order == "random" then return randomOrder(tab) else return tab end
end

function mostWounded()
  local minHP = 1
  local indexMostWounded = 0
  local champions = getChampions("alive", "object", "random")
  for _,c in ipairs(champions) do
    local hp = c:getHealth() / c:getMaxHealth()
    if hp < minHP then minHP = hp indexMostWounded = c:getOrdinal() end
  end
  if indexMostWounded == 0 then
    local maxWounds = 0
    for _,c in ipairs(champions) do
      local w = 0
      for _,v in ipairs(wounds) do if c:getConditionValue(v) ~= 0 then w = w+1 end end
      if w > maxWounds then maxWounds = w indexMostWounded = c:getOrdinal() end
    end
  end
  return indexMostWounded
end

function mostHealthy()
  local maxHP = 0
  local indexMostHealthy = 0
  local champions = getChampions("alive", "object", "random")
  for _,c in ipairs(champions) do
    local hp = c:getHealth()
    if hp > maxHP then maxHP = hp indexMostHealthy = c:getOrdinal() end
  end
  return indexMostHealthy
end

function paySpellCost(champion, cost)
  if champion:isAlive() then
    champion:regainEnergy(-cost)
    hasPaidSpellCost(champion, cost)
  end
end

function hasPaidSpellCost(champion, cost)
  if cost > 0 then
    if copySpellCast then
      local ord = champion:getOrdinal()
      durationEffects(1, 15, "energy", {ord, cost*copySpellCast/15, false})
    end
    if hasEffectIcons("energy_whirl") then
      local ord = champion:getOrdinal()
      durationEffects(1, 15, "energy", {ord, cost/20, false})
    end
    if get("crit") then
      if champion:hasTrait("earth_mastery") then
        local ord = champion:getOrdinal()
        heal(ord, 0.2*cost)
      end
      if champion:hasTrait("water_mastery") then
        local ord = champion:getOrdinal()
        energy(ord, 0.2*cost)
      end
    end
  end
end

function energy(ordinal, gain, show)
  local c = party.party:getChampionByOrdinal(ordinal)
  if c:isAlive() then if show then c:playHealingIndicator() end c:regainEnergy(gain) end
end

wounds = {"chest_wound", "head_wound", "left_hand_wound", "right_hand_wound", "leg_wound", "feet_wound"}

function heal(ordinal, gain)
  local c = party.party:getChampionByOrdinal(ordinal)
  if c:isAlive() then
    local maxWounds = quantum(#wounds * (1 - (c:getHealth()+gain) / c:getMaxHealth()))
    if gain ~= 0 then c:playHealingIndicator() c:regainHealth(gain) end
    local n = 0
    local cured = false
    for _,v in ipairs(randomOrder(wounds)) do
      if c:getConditionValue(v) ~= 0 then
        n = n + 1
        if n > maxWounds then
          c:setConditionValue(v, 0)
          cured = true
        end
      end
    end
    if cured then playSound("heal_party") end
  end
end

function healParty(power, sound)
  local c = {}
  local h = {}
  local ht = 0
  for i = 1, 4 do
    c[i] = party.party:getChampionByOrdinal(i)
    h[i] = c[i]:isAlive() and c[i]:getMaxHealth()-c[i]:getHealth() or 0
    ht = ht + h[i]
  end
  if ht > 0 then for i = 1,4 do h[i] = h[i]/ht end end
  for i = 1,4 do heal(i, power * h[i]) end
  if ht > 0 and sound ~= false then playSound("heal_party") end
end

negative_conditions =
{ "cursed",
  "diseased",
  "paralyzed",
  "petrified",
  "poison",
  "slow",
  "chest_wound",
  "feet_wound",
  "head_wound",
  "left_hand_wound",
  "leg_wound",
  "right_hand_wound",
  "frozen_champion",
  "blind",
  "silence",
}

function cure(ordinal, n, conditions, message)
  local healer = party.party:getChampionByOrdinal(ordinal)
  if n < 1 then hudPrint("Not enough skill.") playSound("spell_fizzle") return false end
  local cured = false
  local champions = getChampions("enabled", "object", "random")
  conditions = randomOrder(conditions or negative_conditions)
  for i = 1,#champions do
    for _,v in ipairs(conditions) do
      if champions[i]:getConditionValue(v) ~= 0 then
        champions[i]:setConditionValue(v, 0)
        champions[i]:playHealingIndicator()
        cured = true
        n = n - 1
        if n < 1 then playSound("heal_party") return cured end
      end
    end
  end
  if cured then playSound("heal_party") elseif message then hudPrint(message) playSound("spell_fizzle") end
  return cured
end

function resurrect(gain, champion)
  local deadChampions = getChampions("dead")
  if #deadChampions > 0 then
    local c = champion or deadChampions[math.random(#deadChampions)]
    c:playHealingIndicator()
    c:setHealth(gain)
    playSound("heal_party")
    return #deadChampions, c:getOrdinal()
  end
  hudPrint("Nobody is dead.")
  playSound("spell_fizzle")
  return 0, 0    
end

function resurrectAndHealParty(power, sound)
  local c = {}
  local h = {}
  local ht = 0
  for i = 1, 4 do
    c[i] = party.party:getChampionByOrdinal(i)
    h[i] = c[i]:getMaxHealth() - c[i]:getHealth()
    ht = ht + h[i]
  end
  if ht > 0 then for i = 1,4 do h[i] = h[i]/ht end end
  for i = 1,4 do if c[i]:isAlive() then heal(i, power * h[i]) else c[i]:setHealth(power * h[i]) c[i]:playHealingIndicator() sound = true end end
  if ht > 0 and sound ~= false then playSound("heal_party") end
end

function damageParty(power, damageType, sound)
  local c = {}
  local h = {}
  local ht = 0
  for i = 1,4 do
    c[i] = party.party:getChampionByOrdinal(i)
    h[i] = c[i]:getHealth()
    ht = ht + h[i]
  end
  for i = 1,4 do
    if h[i] > 0 then
      if sound ~= false then c[i]:playDamageSound() end
      c[i]:damage(power * h[i] / ht, damageType)
    end
  end
end

function xpGrantingDeath(monster)
  if monster:getExp() then
    monster:showDamageText("+"..monster:getExp().." xp", "FFFF64")
    for i = 1,4 do
      local champ = party.party:getChampionByOrdinal(i)
      if champ:isAlive() and champ:getClass() ~= "farmer" then champ:gainExp(monster:getExp()) end
    end
  end
  monster:die()
end

function partySound(name, duration, fadeIn, fadeOut)
  local sound, count = party:getComponent(name), get("sound_"..name) or 0
  if sound == nil then
    sound = party:createComponent("Sound", name)
    sound:setSound(name)
    sound:fadeOut(0)
    sound:setSoundType("ambient")
  end
  if count == 0 then sound:fadeIn(fadeIn) end
  set("sound_"..name, count + 1)
  delayEffects(duration-fadeOut, partySoundStop, {name, fadeOut})
end

function partySoundStop(name, fadeOut)
  local sound = party:getComponent(name)
  if sound == nil then return end
  local count = get("sound_"..name) - 1
  set("sound_"..name, count)
  if count == 0 then sound:fadeOut(fadeOut) end
end

lights = {}

function partyLight(name, duration, color, brightness, variationAmount, variationTime)
  local now = party.gametime:getValue()
  lights[#lights+1] =
  { name = name,
    stop = now + duration, -- (seconds)
    brightness = brightness,
    color = {color[1],color[2],color[3]},
    variationAmount = variationAmount or 0.5, -- 0 to 1
    variationTime = variationTime or 0.25, -- seconds
    variationNext = now, -- (seconds)
    variation = 1,
  }
end

function partyLightStopAll(name)
  for i = #lights,1,-1 do if lights[i].name == name then table.remove(lights, i) end end
end

function hasPartyLight(name, ignoreDarkness)
  if darknessUntil and not ignoreDarkness then return false end
  for _,light in ipairs(lights) do if light.name == name then return true end end
  return false
end

function updateLights(t)
  if darknessUntil and t > darknessUntil then darknessUntil = nil end
  local color, range, brightness
  if darknessUntil then
    color = vec(0.1, 0.13, 0.25)
    range = 7
    brightness = 2
  else
    brightness = party.torch:getBrightness()
    color = brightness * party.torch:getColor()
    for i = #lights,1,-1 do
      local light = lights[i]
      if light.stop > t then
        if t > light.variationNext then
          light.variation = 1 + light.variationAmount * (2*math.random()-1)
          light.variationNext = light.variationNext + light.variationTime * (math.random()+0.5)
        end
        local b = light.brightness * light.variation
        color = color + b * vec(light.color[1],light.color[2],light.color[3])
        brightness = brightness + b
      else
        table.remove(lights, i)
      end
    end
    color = color/brightness
    range = 15*(5+brightness)/(13+brightness)
    brightness = 50*brightness/(50+brightness)
  end
  local old = 0.125^Time.deltaTime()
  local new = 1-old
  if brightness==brightness then party.light:setBrightness(old*party.light:getBrightness() + new*brightness) end
  if color[1]==color[1] and color[2]==color[2] and color[3]==color[3] then party.light:setColor(old*party.light:getColor() + new*color) end
  if range==range then party.light:setRange(old*party.light:getRange() + new*range) end
  party.light:setOffset(party.torch:getOffset())
end

darknessUntil = nil
function darknessStart(duration)
  local t = party.gametime:getValue() + duration
  if not darknessUntil or t > darknessUntil then darknessUntil = t end
end
function darknessStop()
  darknessUntil = nil
end

function addConditionValue(condition, duration, ordinal)
  if ordinal then
    local c = party.party:getChampionByOrdinal(ordinal)
    c:setConditionValue(condition, duration + (c:getConditionValue(condition) or 0))
  else
    for i = 1,4 do addConditionValue(condition, duration, i) end
  end
end

function maxConditionValue(condition, duration, ordinal)
  if ordinal then
    local c = party.party:getChampionByOrdinal(ordinal)
    if duration > (c:getConditionValue(condition) or 0) then c:setConditionValue(condition, duration) end
  else
    for i = 1,4 do maxConditionValue(condition, duration, i) end
  end
end

function elementalShields(duration, caster, f, a, w, e)
  --local old = caster:getSkillLevel("concentration")>4 and 1 or 0
  local old = 0
  f = (f and getPower(duration, caster,  "fire_magic") or 0) + old*removeEffectIcons(  "fire_shield")
  a = (a and getPower(duration, caster,   "air_magic") or 0) + old*removeEffectIcons( "shock_shield")
  w = (w and getPower(duration, caster, "water_magic") or 0) + old*removeEffectIcons( "frost_shield")
  e = (e and getPower(duration, caster, "earth_magic") or 0) + old*removeEffectIcons("poison_shield")
  insertEffectIcons(  "fire_shield", f)
  insertEffectIcons( "shock_shield", a)
  insertEffectIcons( "frost_shield", w)
  insertEffectIcons("poison_shield", e)
  for _,c in ipairs(getChampions()) do
    c:setConditionValue(  "fire_shield", f)
    c:setConditionValue( "shock_shield", a)
    c:setConditionValue( "frost_shield", w)
    c:setConditionValue("poison_shield", e)
  end
end

function elementalShieldSingle(duration, caster, f, a, w, e)
  --local old = caster:getSkillLevel("concentration")>4 and 1 or 0
  local old = 1
  f = (f and duration or 0) + old*removeEffectIcons(  "fire_shield")
  a = (a and duration or 0) + old*removeEffectIcons( "shock_shield")
  w = (w and duration or 0) + old*removeEffectIcons( "frost_shield")
  e = (e and duration or 0) + old*removeEffectIcons("poison_shield")
  insertEffectIcons(  "fire_shield", f)
  insertEffectIcons( "shock_shield", a)
  insertEffectIcons( "frost_shield", w)
  insertEffectIcons("poison_shield", e)
  caster:setConditionValue(  "fire_shield", f)
  caster:setConditionValue( "shock_shield", a)
  caster:setConditionValue( "frost_shield", w)
  caster:setConditionValue("poison_shield", e)
end

mageArmors =
{        balance_armor = {concentration =  6, fire_magic=-1.5, air_magic=-1.5, water_magic=-1.5, earth_magic=-1.5, uiName = "Arcane Mage Armor", description = "\nSpells power per level:\nConcentration +6%\nFire, Air, Water & Earth -1.5%"},
            fire_armor = {concentration =  0, fire_magic =  6, air_magic = -1, water_magic = -4, earth_magic = -1, uiName =   "Fire Mage Armor", description = "\nSpells power per level:\nFire +6%\nAir & Earth -1%\nWater -4%"},
             air_armor = {concentration =  0, fire_magic = -1, air_magic =  6, water_magic = -1, earth_magic = -4, uiName =    "Air Mage Armor", description = "\nSpells power per level:\nAir +6%\nWater & Fire -1%\nEarth -4%"},
           water_armor = {concentration =  0, fire_magic = -4, air_magic = -1, water_magic =  6, earth_magic = -1, uiName =  "Water Mage Armor", description = "\nSpells power per level:\nWater +6%\nEarth & Air -1%\nFire -4%"},
           earth_armor = {concentration =  0, fire_magic = -1, air_magic = -4, water_magic = -1, earth_magic =  6, uiName =  "Earth Mage Armor", description = "\nSpells power per level:\nEarth +6%\nFire & Water -1%\nAir -4%"},

burning_thunder_shield = {concentration =  0, fire_magic =  3, air_magic =  3, water_magic = -3, earth_magic = -3, description = "\nSpells power per level:\nFire & Air +3%\nWater & Earth -3%"},
       blizzard_shield = {concentration =  0, fire_magic = -3, air_magic =  3, water_magic =  3, earth_magic = -3, description = "\nSpells power per level:\nAir & Water +3%\nEarth & Fire -3%"},
          fever_shield = {concentration =  0, fire_magic = -3, air_magic = -3, water_magic =  3, earth_magic =  3, description = "\nSpells power per level:\nWater & Earth +3%\nFire & Air -3%"},
       volcanic_shield = {concentration =  0, fire_magic =  3, air_magic = -3, water_magic = -3, earth_magic =  3, description = "\nSpells power per level:\nEarth & Fire +3%\nAir & Water -3%"},
      frostfire_shield = {concentration =  0, fire_magic =  3, air_magic = -3, water_magic =  3, earth_magic = -3, description = "\nSpells power per level:\nFire & Water +3%\nAir & Earth -3%"},
     acid_storm_shield = {concentration =  0, fire_magic = -3, air_magic =  3, water_magic = -3, earth_magic =  3, description = "\nSpells power per level:\nAir & Earth +3%\nFire & Water -3%"},

         nature_shield = {concentration =  0, fire_magic = -6, air_magic =  2, water_magic =  2, earth_magic =  2, description = "\nSpells power per level:\nAir, Water & Earth +2%\nFire -6%"},
       asphyxia_shield = {concentration =  0, fire_magic =  2, air_magic = -6, water_magic =  2, earth_magic =  2, description = "\nSpells power per level:\nWater, Earth & Fire +2%\nAir -6%"},
     desolation_shield = {concentration =  0, fire_magic =  2, air_magic =  2, water_magic = -6, earth_magic =  2, description = "\nSpells power per level:\nEarth, Fire & Air +2%\nWater -6%"},
            sky_shield = {concentration =  0, fire_magic =  2, air_magic =  2, water_magic =  2, earth_magic = -6, description = "\nSpells power per level:\nFire, Air & Water +2%\nEarth -6%"},

      elemental_shield = {concentration = -6, fire_magic =1.5, air_magic =1.5, water_magic =1.5, earth_magic =1.5, description = "\nSpells power per level:\nFire, Air, Water & Earth +1.5%\nConcentration -6%"},
}

function elementalArmor(armor, caster)
  local ord = caster:getOrdinal()
  local old = get("mage_armor"..ord)
  local new = old ~= armor and armor or nil
  if old then
    caster:removeCondition(old)
    --removeEffectIcons(old, 0, ord)
  end
  if new then
    caster:setConditionValue(new, math.huge)
    --insertEffectIcons(new, math.huge, ord)
    caster:setEnergy(0)
  end
  set("mage_armor"..ord, new)
end

effectIcons = {size = 0}
function insertEffectIcons(spell, duration, ord)
  local eff,expire = effectIcons, party.gametime:getValue() + duration
  while eff.n and eff.n.t > expire do eff = eff.n end
  local i,ix,iy = defByName[spell].iconAtlas,0,0
  if not i then
    i = "assets/textures/gui/skills.tga"
    local index = defByName[spell].icon
    ix =           (index%10)*75
    iy = math.floor(index/10)*75
  end
  eff.n = {name = spell, icon = i, ordinal = ord, x = ix, y = iy, t = expire, n = eff.n}
  effectIcons.size = effectIcons.size+1
end
function removeEffectIcons(spell, duration, ord)
  local eff,t = effectIcons, party.gametime:getValue()
  while eff.n do
    if eff.n.name == spell and eff.n.ordinal == ord then
      duration = math.max(duration or 0, eff.n.t-t)
      eff.n = eff.n.n
      effectIcons.size = effectIcons.size-1
    else
      eff = eff.n
    end 
  end
  return duration or 0
end
function hasEffectIcons(spell, ord)
  local eff = effectIcons
  while eff.n do
    if eff.n.name == spell and eff.n.ordinal == ord then return true end 
    eff = eff.n
  end
  return false
end
function maxEffectIcons(spell, duration, ord)
  insertEffectIcons(spell, removeEffectIcons(spell, duration, ord), ord)
end
function addEffectIcons(spell, duration, ord)
  insertEffectIcons(spell, duration + removeEffectIcons(spell, 0, ord), ord)
end
function setEffectIcons(spell, duration, ord)
  removeEffectIcons(spell, 0, ord) if duration then insertEffectIcons(spell, duration, ord) end
end
function setConditionIcons(condition, spell, ord)
  if ord then
    local c = party.party:getChampionByOrdinal(ord)
    setEffectIcons(spell, c:getEnabled() and c:getConditionValue(condition), ord)
  else
    for ord = 1,4 do setConditionIcons(condition, spell, ord) end
  end
end
fontSize = {"tiny", "small", "medium", "large"}
function drawEffectIcons(pcomp, context)	
  for _,c in ipairs(getChampions()) do if not c:hasCondition("invisibility") then removeEffectIcons("invisibility") break end end
  if effectIcons.size<1 then return end
  local w,h = context.width,context.height
  local f = math.min(1, (w-0.5*h)/(effectIcons.size*75))
  local eff,t,x,size = effectIcons, party.gametime:getValue(), 10, 0
  context.font(fontSize[1+math.floor(#fontSize*f)] or "large")
  while eff.n do
    if eff.n.t > t then
      local d = eff.n.t-t
      local a = d<math.huge and 255*(1-math.sin(d*10)^2/(d*0.1+1)) or 255
      context.color(255, 255, 255, a)
      --context.drawImage2(fileName, x, y, srcX, srcY, srcWidth, srcHeight, destWidth, destHeight)
      context.drawImage2(eff.n.icon, f*x, h-f*85, eff.n.x, eff.n.y, 75, 75, f*75, f*75)
      if eff.n.ordinal then
        context.color(255, 255, 255, a*math.sin(t*2)^2)
        context.drawImage2("$portrait"..ordinalToIndex(eff.n.ordinal), f*x, h-f*85, 0, 0, 128, 128, f*75, f*75)
      end
      context.color(255, 255, 255, 255)
      if d<math.huge then context.drawText(math.floor(d).."s", f*x, h-f*10) end
      x = x+75
      eff = eff.n
      size = size+1
    else
      eff.n = nil
      effectIcons.size = size
      playSound("spell_expires")
    end
  end
end
function ordinalToIndex(ordinal)
  for i = 1,4 do if party.party:getChampion(i):getOrdinal() == ordinal then return i end end
end
if self and self.go then
  party.party:addConnector("onDrawGui", self.go.id, "drawEffectIcons")
end

-- concentration

arcanePower = {0,0,0,0}
arcaneTimer = {}

function setArcane(new, ordinal)
  arcanePower[ordinal] = math.clamp(new,0,5)
  arcaneTimer[ordinal] = party.gametime:getValue()+15
end

function drawArcane(pcomp, context)	
  local w,h = context.width,context.height
  local r = w / h
  local f = (r<1.3 and 0.8 or r<1.4 and 0.9 or 1)*context.height/1080
  for i = 1,4 do
    local champion = party.party:getChampion(i)
    if champion:getEnabled() then
      local ordinal = champion:getOrdinal()
      local arcane = arcanePower[ordinal]
      if arcane > 0 then
        local d = arcaneTimer[ordinal]-party.gametime:getValue()
        if d > 0 then
          context.color(255, 255, 255, 255*(1-math.sin(d*10)^2/(d*d*0.1+1)))
          --context.drawImage2(fileName, x, y, srcX, srcY, srcWidth, srcHeight, destWidth, destHeight)
          local x,y = 345 - (i-1)%2 * 205, 690 + math.floor((i-1)/2) * 200
          context.drawImage2(path.."textures/gui/conditions/arcane"..arcane..".tga", w-f*x, f*y, 0, 0, 32, 32, f*32, f*32)
        else
          arcanePower[ordinal] = 0
        end
      end
    end
  end
end
if self and self.go then
  party.party:addConnector("onDrawGui", self.go.id, "drawArcane")
end

function mirror(ordinal)
  if ordinal then
    local c = party.party:getChampionByOrdinal(ordinal)
    local maxH = c:getMaxHealth() 
    local maxE = c:getMaxEnergy() 
    local h = c:getHealth() / maxH 
    local e = c:getEnergy() / maxE
    c:setHealth(maxH * e)
    c:setEnergy(maxE * h)
  else
    for _,i in ipairs(getChampions("alive", "ordinal")) do mirror(i) end
  end
end

-- fire magic

function metabolism(foodRate, e, h)
  for _,c in ipairs(getChampions("alive")) do
    local tf = (c:hasTrait("fast_metabolism") and 0.1 or 0.05) * c:getFood() / 1000
    local te = e and math.min(tf, 1 - c:getEnergy() / c:getMaxEnergy()) or 0
    local th = h and math.min(tf, 1 - c:getHealth() / c:getMaxHealth()) or 0
    if te > 0 then c:consumeFood(foodRate * te * 1000) energy(c:getOrdinal(), te * c:getMaxEnergy(), true) end
    if th > 0 then c:consumeFood(foodRate * th * 1000) heal  (c:getOrdinal(), th * c:getMaxHealth(), true) end
  end
end

-- air magic

windRiderPower = 0
windRiderTimer = 0
function setWindRider(pow, duration)
  party.party:setMovementSpeed((party.party:getMovementSpeed() or 1)-windRiderPower+pow)
  windRiderPower = pow
  windRiderTimer = party.gametime:getValue()+duration
end
function windRider()
  if party.gametime:getValue() < windRiderTimer then
    if party.gravity:getFallingSpeed() > 7 then party.gravity:setFallingSpeed(7) end
  elseif windRiderPower > 0 then
    setWindRider(0,0)
  end
end
if self and self.go then
  party.frametimer:addConnector("onActivate", self.go.id, "windRider")
end

deepSleep = false
function sleep(id, duration)
  local o = findEntity(id)
  if not o then return end
  if o.monster then
    o.monster:setCondition("sleep", duration)
  elseif o.party then
    deepSleep = true
    o.party:rest()
    delayEffects(duration, wakeUp, {})    
  end
end

function wakeUp()
  deepSleep = false
  party.party:wakeUp(false)
end

tpX = nil
tpY = nil
tpF = nil
tpE = nil
tpL = nil

function memorizeDestination(o)
  tpX = o.x;
  tpY = o.y;
  tpF = o.facing;
  tpE = o.elevation;
  tpL = o.level;
  playSound("power_attack_charging")
  hudPrint("Destination memorized")
end

function teleportation()
  if tpX then
    party:setPosition(tpX, tpY, tpF, tpE, tpL)
    spawn("teleportation_effect", tpL, tpX, tpY, tpF, tpE)
  else
    memorizeDestination(party)
  end
end

-- water magic

function checkIceBlock(o, deltaTime)
  local ground = o.map:getElevation(o.x, o.y)
  local pressed = 0
  for e in o.map:entitiesAt(o.x, o.y) do
    if e.monster then if e.elevation == o.elevation then e.monster:setCondition("frozen", 1) pressed = pressed + 1 end
    elseif e.platform and e.platform:isEnabled() and e.elevation > ground and e.elevation <= o.elevation then ground = e.elevation
    elseif e.name == "ice_cube" and e.elevation > o.elevation then pressed = pressed + 1
    elseif e.pit and e.pit:isEnabled() and e.pit:isOpen() and o.map:getElevation(o.x, o.y) == ground then ground = -14
    end
  end
  local vz = o.data:get("vz") or 0
  local fix_top = false
  if ground ~= o.elevation then
    vz = vz + 9.81 * deltaTime            -- earth gravity force at altitude 0 is ~9,81 m/s²
    local dz = vz * deltaTime / 3         -- the distance unit is 3 meters long
    if dz ~= 0 then
      fix_top = true
      if o.elevation-dz > ground then
        o:setPosition(o.x, o.y, o.facing, o.elevation-dz, o.level)
        if o.dynamicobstacle then o:removeComponent("dynamicobstacle") end
      elseif ground == -14 and o.map:getAdjacentLevel(0,0,1) then
        local map = o.map:getAdjacentLevel(0,0,1)
        o:removeComponent("projectilecollider")
        o:setPosition(o.x, o.y, o.facing, map:getCeilingElevation(o.x, o.y), map:getLevel())
        o:createComponent("ProjectileCollider")
        if o.dynamicobstacle then o:removeComponent("dynamicobstacle") end
      else
        o:setPosition(o.x, o.y, o.facing, ground, o.level)
        local flags = DamageFlags.Impact + DamageFlags.CameraShake + DamageFlags.Champion1
        damageTile(o.level, o.x, o.y, o.facing, o.elevation, flags, "physical", vz)
        vz = 0
        if not o.dynamicobstacle then o:createComponent("DynamicObstacle") end
      end
    end
    o.data:set("vz", vz)
  end
  local top_id = o.data:get("top")
  local top
  if top_id then
    top = findEntity(top_id)
  else
    top = spawn("ice_cube_top")
    top_id = top.id
    o.data:set("top", top_id)
  end
  if top then
    top:setPosition(o.x, o.y, o.facing, o.elevation+1, o.level)
    if top.floortrigger:isActivated() then pressed = pressed + 1 end
    local damage = deltaTime * (1+pressed)
    local flags = DamageFlags.Impact + DamageFlags.Champion1
    if o.health:getHealth() > damage then
      o.health:setHealth(o.health:getHealth()-damage)
    else
      damageTile(o.level, o.x, o.y, o.facing, o.elevation, flags, "physical", damage)
    end
    damage = quantum(damage)
    if damage>0 then damageTile(o.level, o.x, o.y, o.facing, o.elevation, flags, "cold", damage) end
  end
end

function pushIceBlock(o)
  local dx,dy = getForward(party.facing)
  local inv = nil
  o.forcefield:disable()
  o.obstacle:disable()
  if not o.map:checkLineOfFire(o.x, o.y, o.x+dx, o.y+dy, o.elevation) then
    inv = spawn("invisible_wall", o.level, o.x+dx, o.y+dy, o.facing, o.elevation)
  end
  o.forcefield:enable()
  o.obstacle:enable()
  local flags = DamageFlags.Impact + DamageFlags.CameraShake + DamageFlags.Champion1
  damageTile(o.level, o.x, o.y, o.facing, o.elevation, flags, "physical", 1)
  for e in o.map:entitiesAt(o.x, o.y) do if e.monster and e.elevation == o.elevation then return end end
  spawn("invisible_pushable_block_floor", o.level, o.x   , o.y   , o.facing, o.elevation, "push_source").controller:activate()
  spawn("invisible_pushable_block_floor", o.level, o.x+dx, o.y+dy, o.facing, o.elevation, "push_target").controller:activate()
  o.pushableblock:push(party.facing)
  push_source:destroy()
  push_target:destroy()
  o.pushableblock:deactivate()
  playSound("ice_guardian_walk")
  if inv then inv:destroy() end
  --for _,comp in o:componentIterator() do print(comp:getClass()) end
end

function osmosis(power, duration)
  durationEffects(0, duration, "osmosisTick", {power})
end

function osmosisTick(power)
  local stat
  local minStat = 1
  local maxStat = 0
  local minOrdinal = 0
  local maxOrdinal = 0
  local minIsHealth, maxIsHealth
  for _,c in ipairs(getChampions("alive", "object", "random")) do
    local ordinal = c:getOrdinal()
    stat = c:getHealth() / c:getMaxHealth()
    if stat < minStat then minStat = stat minOrdinal = ordinal minIsHealth = true end
    if stat > maxStat then maxStat = stat maxOrdinal = ordinal maxIsHealth = true end
    stat = c:getEnergy() / c:getMaxEnergy()
    if stat < minStat then minStat = stat minOrdinal = ordinal minIsHealth = false end
    if stat > maxStat then maxStat = stat maxOrdinal = ordinal maxIsHealth = false end
  end
  if minOrdinal > 0 and maxOrdinal > 0 and (minOrdinal ~= maxOrdinal or minIsHealth ~= maxIsHealth) then
    local cMin = party.party:getChampionByOrdinal(minOrdinal)
    local cMax = party.party:getChampionByOrdinal(maxOrdinal)
    minStat = minIsHealth and cMin:getMaxHealth() or cMin:getMaxEnergy()
    maxStat = maxIsHealth and cMax:getMaxHealth() or cMax:getMaxEnergy()
    local minCurrent = minIsHealth and cMin:getHealth() or cMin:getEnergy()
    local maxCurrent = maxIsHealth and cMax:getHealth() or cMax:getEnergy()
    stat = quantum((maxCurrent*minStat - minCurrent*maxStat) / (minStat + maxStat) * power)
    if stat > 0 then
      if minIsHealth then heal(minOrdinal, stat) else energy(minOrdinal, stat, true) end
      if maxIsHealth then heal(maxOrdinal,-stat) else energy(maxOrdinal,-stat, true) end
    end
  end
end

function freezeParty()
  local frozen,warm = false,false
  for _,c in ipairs(getChampions("enabled")) do if c:hasCondition("frozen_champion") then frozen = true else warm = true end end
  GameMode.setGameFlag("DisableMovement", frozen)
  GameMode.setGameFlag("DisableMouseLook", not warm)
  GameMode.setGameFlag("DisableKeyboardShortcuts", not warm)
end
if self and self.go then party.frametimer:addConnector("onActivate", self.go.id, "freezeParty") end

-- earth magic

function rocksFall(power, ordinal, duration, x, y)
  power = quantum(power)
  duration = duration or 1
  if not x then x,y = getFrontTarget() end
  for i = 0,power-1 do delayEffects((i+math.random())*duration/power, rockFall, {x, y, ordinal}) end
end

function rockFall(x, y, ordinal)
  local r = spawn("rock_fall_spell", party.level, x, y, party.facing, party.elevation)
  r.projectile:setCastByChampion(ordinal)
  r:setSubtileOffset(2*math.random() - 1, 2*math.random() - 1)
end

function rocksErupt(power, ordinal, duration, x, y)
  power = quantum(power)
  duration = duration or 1
  if not x then x,y = getFrontTarget() end
  for i = 0,power-1 do delayEffects((i+math.random())*duration/power, rockErupt, {x, y, ordinal}) end
end

function rockErupt(x, y, ordinal)
  local r = spawn("earthquake_rock", party.level, x, y, math.random(0,3), party.elevation)
  r.projectile:setCastByChampion(ordinal)
  r:setSubtileOffset(3*math.random() - 1.5, 3*math.random() - 1.5)
end

-- fire & air magic

function demonicPact(ordinal, factor)
  local blood = party.party:getChampionByOrdinal(ordinal):getHealth() * factor
  if blood > 0 then energy(ordinal, blood) heal(ordinal, -blood) end
end

-- air & water magic

function detectDeath(timer)
  if spells_functions.script.hasEffectIcons("shadowlands_vision") then
    local c = timer.go.monster:shootProjectile("blob",0,0,"capsule")
    local o = c:getWorldPosition() - timer.go:getWorldPosition()
    local v = c:getWorldPosition() - party:getWorldPosition() - vec(0,1.3,0)
    local f = timer.go.facing
    local l = (v.x*v.x + v.y*v.y + v.z*v.z)^0.5
    if l > 0 then
      v = (f==0 and v or f==1 and vec(-v.z,v.y,v.x) or f==2 and vec(-v.x,v.y,-v.z) or vec(v.z,v.y,-v.x))/l
      local ax = 180/math.pi*math.asin(v.y)
      local ay = 180/math.pi*math.acos(v.z)*(v.x < 0 and 1 or -1)
      timer.go.detectedmodel:setRotationAngles(90+ax, ay, 0)
    end
    timer.go.detectedmodel:setOffset(f==0 and o or f==1 and vec(-o.z,o.y,o.x) or f==2 and vec(-o.x,o.y,-o.z) or vec(o.z,o.y,-o.x))
    c:destroy()
    timer.go.detectedmodel:enable()
  else
    timer.go.detectedmodel:disable()
  end
end

-- water & earth magic

healthShieldPower = 0
healthShieldCount = 0

function healthShieldStart(power, duration) 
  if healthShieldCount == 0 then
    party.party:addConnector("onDamage", "spells_functions", "healShield") --onDamage(self, champion, damage, damageType)
  end
  healthShieldPower = healthShieldPower + power
  healthShieldCount = healthShieldCount + 1
  delayEffects(duration, healthShieldStop, {})
end

function healShield(self, champion, damage, damageType)
  if champion:isAlive() then
    local h = math.min(champion:getMaxHealth() - champion:getHealth(), healthShieldPower / 4)
    if h > 0 then heal(champion:getOrdinal(), h, true) healthShieldPower = healthShieldPower - h end
  end
end

function healthShieldStop()
  healthShieldCount = healthShieldCount - 1
  if healthShieldCount == 0 then
    party.party:removeConnector("onDamage", "spells_functions", "healShield") --onDamage(self, champion, damage, damageType)
    healParty(healthShieldPower)
    healthShieldPower = 0
  end
end

function feed(amount)
  for _,c in ipairs(getChampions("alive")) do
    c:modifyFood(amount)
    if champions and champions.script and champions.script.modifyWater then
      champions.script.modifyWater(c,amount)
    end
  end
end

-- earth & fire magic

-- fire & water magic

-- air & earth magic

lastSpellCast = false
copySpellCast = false
function copycat(champion, x, y, direction, elevation, gain)
  local spell = defByName[lastSpellCast]
  local skillLevel = champion:getSkillLevel(spell.skill or "concentration")
  copySpellCast = gain
  paySpellCost(champion, spell.manaCost)
  spell.onCast(champion, x, y, direction, elevation, skillLevel)
  copySpellCast = false
end

checkBridge = false

function magicBridge(champion, x, y, direction, elevation, duration)
  if direction == 0 then y = y-1 elseif direction == 1 then x = x+1 elseif direction == 2 then y = y+1 else x = x-1 end
  --Makes sure only one magic platform exists at a time. The game will crash if two entities with the same ID exist.
  local bridgeelevation = party.map:getElevation(x, y)
  local bridgeceiling = party.map:getCeilingElevation(x, y)
  local hasbridge = false
  --Checks for existing platforms by name
  for i in party.map:entitiesAt(x, y) do
    if i.elevation == elevation then   
      if i.platform and i.platform:isEnabled() then
        hasbridge = true
      elseif i.pit and i.pit:isEnabled() and i.pit:isOpen() then
        bridgeelevation = -math.huge
      end
    end
  end
  --Makes sure the tile where the magic platform will appear has a lower floor and a higher ceiling than the tile the party is standing on. 
  --Also makes sure no other platforms exist there and that the party has line of sight, so it will work through wall grating, but not secret doors.
  --This prevents the magic platform from appearing inside of a floor or an existing bridge, which looks bad.
  if bridgeelevation < elevation and bridgeceiling > elevation and not hasbridge and party.map:checkLineOfSight(party.x, party.y, x, y, elevation) then
    if magic_spell_bridge then
      magic_spell_bridge:destroy()
      playSound("spell_expires")
      removeEffectIcons("magic_bridge")
    end
    spawn("magic_bridge", party.level, x, y, direction, elevation, "magic_spell_bridge")
    magic_spell_bridge.particle:fadeOut(0)
    magic_spell_bridge.light:fadeOut(0)
    magic_spell_bridge.sound:fadeOut(0)
    magic_spell_bridge.platform:disable()
    local init = magic_spell_bridge:createComponent("Particle","init")
    init:setParticleSystem("magic_bridge_init")
    init:setDisableSelf(true)
    local timer = magic_spell_bridge:createComponent("Timer","timer1")
    timer:setTimerInterval(1)
    timer:addConnector("onActivate", "spells_functions", "startBridge")
    local timer = magic_spell_bridge:createComponent("Timer","timer2")
    timer:setTimerInterval(1+duration)
    timer:addConnector("onActivate", "spells_functions", "removeBridge")
    playSound("generic_spell")
    insertEffectIcons("magic_bridge", duration+1)
  else
    hudPrint("You can not create a magic bridge here.")
    playSound("spell_fizzle")
  end
end

function startBridge()
  magic_spell_bridge.platform:enable()
  magic_spell_bridge.particle:fadeIn(1)
  magic_spell_bridge.light:fadeIn(1)
  magic_spell_bridge.sound:fadeIn(1)
  magic_spell_bridge:removeComponent("timer1")
end

function removeBridge()
  if magic_spell_bridge then magic_spell_bridge:destroyDelayed() playSound("spell_expires") end
end

shield = {{true, 1, {}}, {true, 1, {}}, {true, 1, {}}, {true, 1, {}}}

function addShield(factor, duration, ordinal)
  if ordinal then
    local s = shield[ordinal]
    table.insert(s[3], factor)
    local f = 1 for i = 1,#s[3] do f = f * s[3][i] end s[2] = f
    local c = party.party:getChampionByOrdinal(ordinal)
    delayEffects(duration, removeShield, {factor, ordinal})
  else
    for i = 1,4 do addShield(factor, duration, i) end
  end
end

function removeShield(factor, ordinal)
  local s = shield[ordinal]
  for i = 1,#s[3] do if s[3][i] == factor then table.remove(s[3], i) break end end
  s[2] = 1 for i = 1,#s[3] do s[2] = s[2] * s[3][i] end 
end

function lessShielded()
  local r = math.random(4)
  for i = r,r+2 do if shield[1+i%4][2] < shield[r][2] then r = 1+i%4 end end
  return r
end

-- air, water & earth magic

function drainLifeBlast(id, health, duration)
  drainLife(id, health, duration)
  local o = findEntity(id)
  if o then  
    for e in party.map:entitiesAt(o.x, o.y) do
      if e ~= o and e.monster and e.elevation == o.elevation then
        drainLife(e.id, health, duration)
      end
    end
  end
end        

function drainLife(id, health, duration)
  local e = findEntity(id)
  local monster = e and e.monster
  if monster then
    if monster:hasTrait("time_traveler") then
      delayEffects(1, drainLife, {id, health, duration})
    elseif monster:isAlive() and not monster:getMonsterFlag("NonMaterial") then
      local h = quantum(duration < 1 and health or health/duration)
      local m = monster:getHealth()
      local g = e.goromorgshield and e.goromorgshield:isEnabled() and e.goromorgshield:getEnergy() or 0
      local f = 1
      if monster:hasTrait("undead") then
        -- draining undeads is not wise
        monster:setHealth(math.min(m+h, monster:getMaxHealth()))
        monster:showDamageText("+"..h, "00FF00")
        f = -1
      elseif monster:hasTrait("elemental") or monster:hasTrait("construct") then
        -- elementals and constructs are immune to leech
        monster:showDamageText("Immune")
        duration = 0
        f = 0
      elseif monster:getMonsterFlag("Invulnerable") then
        monster:showDamageText("0")
        duration = 0
        f = 0
      else
        if e.goromorgshield then
          if h <= g then
            e.goromorgshield:setEnergy(g-h)
            g = h
            h = 0
          elseif g > 0 then
            e.goromorgshield:setEnergy(0)
            h = h-g
          end
        end
        if h > 0 then
          if h < m then
            monster:showDamageText(""..h)
            monster:setHealth(m-h)
          else
            h = m
            monster:showDamageText(""..h)
            if monster:getMonsterFlag("CantDie") then monster:setHealth(0.001) else xpGrantingDeath(monster) end
            duration = 0
          end
        end
        h = h+g
      end
      f = f*h
      if f ~= 0 then
        local drain = e:spawn("life_drain")
        drain.data:set("health",f)
        local center = monster:shootProjectile("blob",0,0,"capsule")
        drain:setWorldPosition(center:getWorldPosition())
        center:destroy()
        if f < 0 then drain.particle:setParticleSystem("dark_bolt") end
        if monster:isGroupLeader() then
          monster:setAIState("default")
          if e.move then if math.random()*100 < e.brain:getMorale() then e.brain:pursuit() else e.brain:flee() end end
        end
      end
      if duration >= 1 and health > h then delayEffects(1, drainLife, {id, health-h, duration-1}) end
    end
  end
end

-- water, earth & fire magic

g1dsblarge = {0,1.86697,0.06029}
g1dsbsmall = {0.312,1.91593,-0.005}
g1psbsmall = {0,1.70663,-0.071}
g1tsblarge = {0.40781,1.73694,0.025}
g1tsbsmall = {-0.08450,1.97,-0.005}
g1tsbtiny = {-0.13955,1.39222,-0.005}

buttons = {
	dungeon_secret_button_small = {-0.355,1.03484,0},
	dungeon_secret_button_large = {-0.409,1.375,-0.0157},
	mine_support_secret_button = {-0.5084,1.75266,-0.05846},
	tomb_secret_button_small = {-0.371,1.30075,-0.002},
	forest_ruins_secret_button_small = {0.47917,1.02165,-0.14998},
	forest_ruins_secret_button_big = {0.05694,1.62365,-0.17098},
	dm_secret_button_big = {0,1.9895,-0.03613},
	dm_secret_button_midbottom = {0.00287,0.92838,-0.06473},
	dm_secret_button_crack = {0.66989,0.7803,0.09607},
	dm_secret_button_mini = {0.74954,2.11307,-0.05127},
	g1_dungeon_secret_button_large = g1dsblarge,
	g1_dungeon_secret_button_small = g1dsbsmall,
	g1_deep_dungeon_secret_button_large = g1dsblarge,
	g1_deep_dungeon_secret_button_small = g1dsbsmall,
	g1_northern_dungeon_secret_button_large = g1dsblarge,
	g1_northern_dungeon_secret_button_small = g1dsbsmall,
	g1_prison_secret_button_small = g1psbsmall,
	g1_solaris_prison_secret_button_small = g1psbsmall,
	g1_temple_secret_button_large = g1tsblarge,
	g1_temple_secret_button_small = g1tsbsmall,
	g1_temple_secret_button_tiny = g1tsbtiny,
	g1_dark_temple_secret_button_large = g1tsblarge,
	g1_dark_temple_secret_button_small = g1tsbsmall,
	g1_dark_temple_secret_button_tiny = g1tsbtiny,
	g1_darkelf_temple_secret_button_large = g1tsblarge,
	g1_darkelf_temple_secret_button_small = g1tsbsmall,
	g1_darkelf_temple_secret_button_tiny = g1tsbtiny,
	g1_deep_temple_secret_button_large = g1tsblarge,
	g1_deep_temple_secret_button_small = g1tsbsmall,
	g1_deep_temple_secret_button_tiny = g1tsbtiny,
	g1_frozen_temple_secret_button_large = g1tsblarge,
	g1_frozen_temple_secret_button_small = g1tsbsmall,
	g1_frozen_temple_secret_button_tiny = g1tsbtiny,
	g1_high_temple_secret_button_large = g1tsblarge,
	g1_high_temple_secret_button_small = g1tsbsmall,
	g1_high_temple_secret_button_tiny = g1tsbtiny,
	g1_highelf_temple_secret_button_large = g1tsblarge,
	g1_highelf_temple_secret_button_small = g1tsbsmall,
	g1_highelf_temple_secret_button_tiny = g1tsbtiny,
	g1_southern_temple_secret_button_large = g1tsblarge,
	g1_southern_temple_secret_button_small = g1tsbsmall,
	g1_southern_temple_secret_button_tiny = g1tsbtiny,
	g1_mine_secret_button_large = {-0.4,1.73505,0.00415},
	g1_mine_secret_button_small = {0.24295,1.9596,-0.01512},
	sx_town_secret_button_large = g1dsblarge,
	sx_town_secret_button_small = g1dsbsmall,
}

function detectOracle(timer)
  if spells_functions.script.hasEffectIcons("oracle") then
    if timer.go.item then
      local p = timer.go:getWorldPosition()
      local a = party.gametime:getValue() + p.x + p.y + p.z
      timer.go.detectedmodel:setRotationAngles(83*a, 89*a, 97*a)
    else
      local o
      o = spells_functions.script.buttons[timer.go.name]
      o = vec(o[1], o[2], o[3])
      local v = timer.go:getWorldPosition() - party:getWorldPosition() - vec(0,1.3,0)
      local f = timer.go.facing
      local l = (v.x*v.x + v.y*v.y + v.z*v.z)^0.5
      v.x = v.x + (f==0 and o.x or f==1 and o.z or f==2 and -o.x or -o.z)
      v.y = v.y + o.y
      v.z = v.z + (f==0 and o.z or f==1 and -o.x or f==2 and -o.z or o.x)
      if l > 0 then
        v = (f==0 and v or f==1 and vec(-v.z,v.y,v.x) or f==2 and vec(-v.x,v.y,-v.z) or vec(v.z,v.y,-v.x))/l
        local ax = 180/math.pi*math.asin(v.y)
        local ay = 180/math.pi*math.acos(v.z)*(v.x < 0 and 1 or -1)
        timer.go.detectedmodel:setRotationAngles(90+ax, ay, 0)
      end
      timer.go.detectedmodel:setOffset(o)
    end
    timer.go.detectedmodel:enable()
  else
    timer.go.detectedmodel:disable()
  end
end

vengeanceTime = nil
vengeanceToDo = true
function vengeance(duration) vengeanceTime = math.max(vengeanceTime or 0, party.gametime:getValue() + duration) end

function fly(id)
  local entity = findEntity(id)
  if entity and entity.monster:isAlive() then entity.monster:setFlying(true) entity.gravity:disable() end
end

-- earth, fire & air magic

tauntTime = 0
tauntTank = 0
function taunt(duration, ord)
  tauntTime = party.gametime:getValue() + duration
  tauntTank = ord
end

function swap(x, y, z, f, l, map)
  local w = map:getWidth()
  local h = map:getHeight()
  local px = party.x
  local py = party.y
  local pz = party.elevation
  local pf = party.facing
  local pl = party.level
  local pm = party.map
  local monsters = {}
  local msg = "Impossible to teleport there."
  local tp = false
  if 0<=x and x<w and 0<=y and y<h and -8<z and z<8 then
    for entity in map:entitiesAt(x, y) do
      if (entity.monster and entity.elevation == z) then
        if entity.monster:isImmuneTo("swap") then
          msg = "Immune"
          tp = false
          break
        else
          monsters[#monsters+1] = entity
          tp = true
        end
      end
    end
  end
  if tp then
    for _,e in ipairs(monsters) do e:setPosition(px, py, pf, pz, pl) end
    party:setPosition(x, y, f, z, l)
    spawn("teleportation_effect", l, x, y, f, z)
  else
    hudPrint(msg)
    playSound("spell_fizzle")
    spawn("teleportation_failed_effect", l, x, y, f, z)
  end
end

-- fire, air & water magic

function transfer(x, y, z, f, l, map)
  local w = map:getWidth()
  local h = map:getHeight()
  local msg = "Impossible to teleport there."
  local tp = true
  if 0<=x and x<w and 0<=y and y<h and -8<z and z<8 then
    for entity in map:entitiesAt(x, y) do
      if (entity.monster and entity.elevation == z) then
        msg = "Impossible to teleport onto living forms."
        tp = false
        break
      end
    end
  end
  if tp then
    party:setPosition(x, y, f, z, l)
    spawn("teleportation_effect", l, x, y, f, z)
  else
    hudPrint(msg)
    playSound("spell_fizzle")
    spawn("teleportation_failed_effect", l, x, y, f, z)
  end
end

function detectLife(timer)
  if spells_functions.script.hasEffectIcons("detect_life") then
    local c = timer.go.monster:shootProjectile("blob",0,0,"capsule")
    local o = c:getWorldPosition() - timer.go:getWorldPosition()
    local v = c:getWorldPosition() - party:getWorldPosition() - vec(0,1.3,0)
    local f = timer.go.facing
    local l = (v.x*v.x + v.y*v.y + v.z*v.z)^0.5
    if l > 0 then
      v = (f==0 and v or f==1 and vec(-v.z,v.y,v.x) or f==2 and vec(-v.x,v.y,-v.z) or vec(v.z,v.y,-v.x))/l
      local ax = 180/math.pi*math.asin(v.y)
      local ay = 180/math.pi*math.acos(v.z)*(v.x < 0 and 1 or -1)
      timer.go.detectedmodel:setRotationAngles(90+ax, ay, 0)
    end
    timer.go.detectedmodel:setOffset(f==0 and o or f==1 and vec(-o.z,o.y,o.x) or f==2 and vec(-o.x,o.y,-o.z) or vec(o.z,o.y,-o.x))
    c:destroy()
    timer.go.detectedmodel:enable()
  else
    timer.go.detectedmodel:disable()
  end
end

-- fire, air, water & earth magic

function alterTime(factor, duration)
  local tab = get("alterTime") or {}
  tab[#tab+1] = {factor = factor, stop = party.gametime:getValue() + duration}
  set("alterTime", tab)
  maxConditionValue("alter_time", duration)  
end

function updateTimeScale()
  local t = party.gametime:getValue()
  local tab = get("alterTime") or {}
  local factor = #tab > 0 and tab[1].factor or 1
  for i = #tab,1,-1 do
    local e = tab[i]
    if t > e.stop then table.remove(tab, i) else factor = math.min(factor, e.factor) end
  end
  tab.scale = 1/factor
  local realSpeed = party.party:getMovementSpeed() or 1
  local baseSpeed = realSpeed - (tab.speed or 0)
  tab.speed = baseSpeed * (tab.scale-1)
  set("alterTime", tab)
  local needSpeed = baseSpeed + tab.speed
  if realSpeed ~= needSpeed then party.party:setMovementSpeed(needSpeed) end
  if GameMode.getTimeMultiplier() ~= factor and not party.party:isResting() then GameMode.setTimeMultiplier(factor) end
end

if self and self.go then party.frametimer:addConnector("onActivate", self.go.id, "updateTimeScale") end

function getTimeScale()
  local tab = get("alterTime")
  return tab and tab.scale or 1
end

might = {strength = {0, 0, 0, 0}, dexterity = {0, 0, 0, 0}, vitality = {0, 0, 0, 0}, willpower = {0, 0, 0, 0}}

resurrectGain = {0,0,0,0}

-- enchantments

enchant =
{ fireResistance = {function(e,v) e:setResistFire(v+(e:getResistFire() or 0)) end, 5},
  shockResistance = {function(e,v) e:setResistShock(v+(e:getResistShock() or 0)) end, 5},
  coldResistance = {function(e,v) e:setResistCold(v+(e:getResistCold() or 0)) end, 5},
  poisonResistance = {function(e,v) e:setResistPoison(v+(e:getResistPoison() or 0)) end, 5},
  strength = {function(e,v) e:setStrength(v+(e:getStrength() or 0)) end, 2},
  dexterity = {function(e,v) e:setDexterity(v+(e:getDexterity() or 0)) end, 2},
  willpower = {function(e,v) e:setWillpower(v+(e:getWillpower() or 0)) end, 2},
  vitality = {function(e,v) e:setVitality(v+(e:getVitality() or 0)) end, 2},
  accuracy = {function(e,v) e:setAccuracy(v+(e:getAccuracy() or 0)) end, 3},
  haste = {function(e,v) e:setCooldownRate(v+(e:getCooldownRate() or 0)) end, 3},
  evasion = {function(e,v) e:setEvasion(v+(e:getEvasion() or 0)) end, 5},
  protection = {function(e,v) e:setProtection(v+(e:getProtection() or 0)) end, 5},
  health = {function(e,v) e:setHealth(v+(e:getHealth() or 0)) end, 10},
  healthRegen = {function(e,v) e:setHealthRegenerationRate(v+(e:getHealthRegenerationRate() or 0)) end, 20},
  energy = {function(e,v) e:setEnergy(v+(e:getEnergy() or 0)) end, 10},
  energyRegen = {function(e,v) e:setEnergyRegenerationRate(v+(e:getEnergyRegenerationRate() or 0)) end, 20},
  fireMelee = {function(e,v) e.go.item:addTrait("fire_gauntlets") end, 1},
  lightWeight = {function(e,v) e.go.item:setWeight(e.go.item:getWeight()/(1+v)) end, 1},
  aquatic = {function(e,v) e.go.item:addTrait("aquatic") end, 1},
  foodRate = {function(e,v)
    v = -v
    e:setFoodRate(v+(e:getFoodRate() or 0))
    local eff = e.go.item:getGameEffect()
    eff = (eff and eff ~= "") and eff.."\n" or ""
    e.go.item:setGameEffect(eff.."Food Consumption Rate "..(v>0 and "+"..v or v).."%")
  end, 5},
  --experience = {function(e,v) e:setExpRate(v+(e:getExpRate() or 0)) end, 4},
  --critical = {function(e,v) e:setCriticalChance(v+(e:getCriticalChance() or 0)) end, 1},
  antigravityBag = function(o,v)
    o.data:set("factor",1-v)
    local names = {"Minor Astral Dimension ","Astral Dimension ","Major Astral Dimension ","Perfect Astral Dimension "}
    o.item:setUiName(names[math.floor(#names*v)]..o.item:getUiName())
    o.item:setGameEffect("Reduces its content weight by "..math.floor(v*100).."%.")
    o.particle:enable()
  end,
}

fireEnchantment =
{
byName =
{ long_sword            = {"fire_blade_minor"},
  fire_blade_minor      = {"fire_blade_minor", "fire_blade"},
  fire_blade            = {"fire_blade_minor", "fire_blade", "fire_blade_major"},
  lightning_blade_minor = {"fire_blade_minor"},
  lightning_blade       = {"fire_blade_minor", "fire_blade_minor", "fire_blade"},
  lightning_blade_major = {"fire_blade_minor", "fire_blade", "fire_blade"},
  frozen_blade_minor    = {"fire_blade_minor"},
  frozen_blade          = {"fire_blade_minor", "fire_blade_minor", "fire_blade"},
  frozen_blade_major    = {"fire_blade_minor", "fire_blade", "fire_blade"},
  venomous_blade_minor  = {"fire_blade_minor"},
  venomous_blade        = {"fire_blade_minor", "fire_blade_minor", "fire_blade"},
  venomous_blade_major  = {"fire_blade_minor", "fire_blade", "fire_blade"},
  blooddrop_cap  = {"falconskyre"},
  falconskyre    = {"blooddrop_cap"},
  etherweed      = {"blooddrop_cap"},
  mudwort        = {"blooddrop_cap"},
  blackmoss      = {"blackmoss", "blackmoss", "crystal_flower"},
  crystal_flower = {"crystal_flower", "crystal_flower", "blackmoss"},
  water_flask            = {"potion_rage"},
  potion_healing         = {"potion_rage"},
  potion_greater_healing = {"potion_rage", "potion_bear_form"},
  potion_energy          = {"potion_rage"},
  potion_greater_energy  = {"potion_rage", "potion_speed"},
  potion_poison          = {"water_flask"},
  potion_shield          = {"potion_rage"},
  potion_cure_poison     = {"potion_rage"},
  potion_cure_disease    = {"potion_rage"},
  potion_rage            = {"potion_speed", "potion_healing", "potion_greater_healing"},
  potion_speed           = {"potion_rage", "potion_energy", "potion_greater_energy"},
  potion_bear_form       = {"potion_rage"},
  potion_resurrection    = {"fire_bomb"},
  potion_strength        = {"potion_vitality"},
  potion_dexterity       = {"potion_strength"},
  potion_vitality        = {"potion_strength"},
  potion_willpower       = {"potion_strength"},
  fire_bomb   = {"potion_resurrection"},
  shock_bomb  = {"fire_bomb"},
  frost_bomb  = {"fire_bomb"},
  poison_bomb = {"fire_bomb"},
  branch = {"torch"},
  torch = {"torch_everburning"},
  arrow = {"fire_arrow"},
  quarrel = {"fire_quarrel"},
  fire_arrow = {"arrow"},
  fire_quarrel = {"quarrel"},
  shock_arrow = {"fire_arrow"},
  shock_quarrel = {"fire_quarrel"},
  cold_arrow = {"fire_arrow"},
  cold_quarrel = {"fire_quarrel"},
  poison_arrow = {"fire_arrow"},
  poison_quarrel = {"fire_quarrel"},
  lightning_rod = {"fire_rod"},
  frozen_rod = {"fire_rod"},
  venomous_rod = {"fire_rod"},
},
equipment = {{enchant.strength, enchant.accuracy, enchant.energy, enchant.coldResistance, enchant.fireMelee}, " (Fire enchantment)"},
food = {"turtle_eggs", "cheese", "horned_fruit", "blueberry_pie"},
}

airEnchantment =
{
byName =
{ long_sword            = {"lightning_blade_minor"},
  fire_blade_minor      = {"lightning_blade_minor"},
  fire_blade            = {"lightning_blade_minor", "lightning_blade_minor", "lightning_blade"},
  fire_blade_major      = {"lightning_blade_minor", "lightning_blade", "lightning_blade"},
  lightning_blade_minor = {"lightning_blade_minor", "lightning_blade"},
  lightning_blade       = {"lightning_blade_minor", "lightning_blade", "lightning_blade_major"},
  frozen_blade_minor    = {"lightning_blade_minor"},
  frozen_blade          = {"lightning_blade_minor", "lightning_blade_minor", "lightning_blade"},
  frozen_blade_major    = {"lightning_blade_minor", "lightning_blade", "lightning_blade"},
  venomous_blade_minor  = {"lightning_blade_minor"},
  venomous_blade        = {"lightning_blade_minor", "lightning_blade_minor", "lightning_blade"},
  venomous_blade_major  = {"lightning_blade_minor", "lightning_blade", "lightning_blade"},
  blooddrop_cap  = {"falconskyre"},
  falconskyre    = {"etherweed"},
  etherweed      = {"falconskyre"},
  mudwort        = {"falconskyre"},
  blackmoss      = {"blackmoss", "blackmoss", "crystal_flower"},
  crystal_flower = {"crystal_flower", "crystal_flower", "blackmoss"},
  water_flask            = {"potion_speed"},
  potion_healing         = {"potion_speed"},
  potion_greater_healing = {"potion_speed", "potion_cure_poison"},
  potion_energy          = {"potion_speed"},
  potion_greater_energy  = {"potion_speed", "potion_bear_form"},
  potion_poison          = {"potion_cure_poison"},
  potion_shield          = {"potion_speed"},
  potion_cure_poison     = {"potion_cure_disease"},
  potion_cure_disease    = {"potion_speed"},
  potion_rage            = {"potion_speed", "potion_energy", "potion_greater_energy"},
  potion_speed           = {"potion_healing", "potion_greater_healing"},
  potion_bear_form       = {"potion_speed"},
  potion_resurrection    = {"shock_bomb"},
  potion_strength        = {"potion_dexterity"},
  potion_dexterity       = {"potion_vitality"},
  potion_vitality        = {"potion_dexterity"},
  potion_willpower       = {"potion_dexterity"},
  fire_bomb   = {"shock_bomb"},
  shock_bomb  = {"potion_resurrection"},
  frost_bomb  = {"shock_bomb"},
  poison_bomb = {"shock_bomb"},
  wooden_box = {"bottomless_sack"},
  arrow = {"shock_arrow"},
  quarrel = {"shock_quarrel"},
  fire_arrow = {"shock_arrow"},
  fire_quarrel = {"shock_quarrel"},
  shock_arrow = {"arrow"},
  shock_quarrel = {"quarrel"},
  cold_arrow = {"shock_arrow"},
  cold_quarrel = {"shock_quarrel"},
  poison_arrow = {"shock_arrow"},
  poison_quarrel = {"shock_quarrel"},
  fire_rod = {"lightning_rod"},
  frozen_rod = {"lightning_rod"},
  venomous_rod = {"lightning_rod"},
},
equipment = {{enchant.dexterity, enchant.energyRegen, enchant.evasion, enchant.poisonResistance, enchant.lightWeight}, " (Air enchantment)"},
food = {"cheese", "horned_fruit", "turtle_eggs", "blueberry_pie"},
container = enchant.antigravityBag,
}

waterEnchantment =
{
byName =
{ long_sword            = {"frozen_blade_minor"},
  fire_blade_minor      = {"frozen_blade_minor"},
  fire_blade            = {"frozen_blade_minor", "frozen_blade_minor", "frozen_blade"},
  fire_blade_major      = {"frozen_blade_minor", "frozen_blade", "frozen_blade"},
  lightning_blade_minor = {"frozen_blade_minor"},
  lightning_blade       = {"frozen_blade_minor", "frozen_blade_minor", "frozen_blade"},
  lightning_blade_major = {"frozen_blade_minor", "frozen_blade", "frozen_blade"},
  frozen_blade_minor    = {"frozen_blade_minor", "frozen_blade"},
  frozen_blade          = {"frozen_blade_minor", "frozen_blade", "frozen_blade_major"},
  venomous_blade_minor  = {"frozen_blade_minor"},
  venomous_blade        = {"frozen_blade_minor", "frozen_blade_minor", "frozen_blade"},
  venomous_blade_major  = {"frozen_blade_minor", "frozen_blade", "frozen_blade"},
  blooddrop_cap  = {"etherweed"},
  falconskyre    = {"etherweed"},
  etherweed      = {"mudwort"},
  mudwort        = {"etherweed"},
  blackmoss      = {"blackmoss", "blackmoss", "crystal_flower"},
  crystal_flower = {"crystal_flower", "crystal_flower", "blackmoss"},
  flask                  = {"water_flask"},
  water_flask            = {"potion_energy"},
  potion_healing         = {"potion_energy",},
  potion_greater_healing = {"potion_energy", "potion_greater_energy"},
  potion_energy          = {"potion_healing", "potion_greater_energy"},
  potion_greater_energy  = {"potion_healing", "potion_greater_healing"},
  potion_poison          = {"water_flask"},
  potion_shield          = {"potion_energy", "potion_greater_energy"},
  potion_cure_poison     = {"potion_energy", "potion_greater_energy"},
  potion_cure_disease    = {"potion_energy", "potion_greater_energy"},
  potion_rage            = {"potion_energy", "potion_greater_energy"},
  potion_speed           = {"potion_energy", "potion_greater_energy"},
  potion_bear_form       = {"potion_greater_energy"},
  potion_resurrection    = {"frost_bomb"},
  potion_strength        = {"potion_willpower"},
  potion_dexterity       = {"potion_willpower"},
  potion_vitality        = {"potion_willpower"},
  potion_willpower       = {"potion_vitality"},
  fire_bomb   = {"frost_bomb"},
  shock_bomb  = {"frost_bomb"},
  frost_bomb  = {"potion_resurrection"},
  poison_bomb = {"frost_bomb"},
  arrow = {"cold_arrow"},
  quarrel = {"cold_quarrel"},
  fire_arrow = {"cold_arrow"},
  fire_quarrel = {"cold_quarrel"},
  shock_arrow = {"cold_arrow"},
  shock_quarrel = {"cold_quarrel"},
  cold_arrow = {"arrow"},
  cold_quarrel = {"quarrel"},
  poison_arrow = {"cold_arrow"},
  poison_quarrel = {"cold_quarrel"},
  fire_rod = {"frozen_rod"},
  lightning_rod = {"frozen_rod"},
  venomous_rod = {"frozen_rod"},
},
equipment = {{enchant.willpower, enchant.haste, enchant.health, enchant.fireResistance, enchant.aquatic}, " (Water enchantment)"},
food = {"turtle_eggs", "horned_fruit", "cheese", "blueberry_pie"},
}

earthEnchantment =
{
byName =
{ long_sword            = {"venomous_blade_minor"},
  fire_blade_minor      = {"venomous_blade_minor"},
  fire_blade            = {"venomous_blade_minor", "venomous_blade_minor", "venomous_blade"},
  fire_blade_major      = {"venomous_blade_minor", "venomous_blade", "venomous_blade"},
  lightning_blade_minor = {"venomous_blade_minor"},
  lightning_blade       = {"venomous_blade_minor", "venomous_blade_minor", "venomous_blade"},
  lightning_blade_major = {"venomous_blade_minor", "venomous_blade", "venomous_blade"},
  frozen_blade_minor    = {"venomous_blade_minor"},
  frozen_blade          = {"venomous_blade_minor", "venomous_blade_minor", "venomous_blade"},
  frozen_blade_major    = {"venomous_blade_minor", "venomous_blade", "venomous_blade"},
  venomous_blade_minor  = {"venomous_blade_minor", "venomous_blade"},
  venomous_blade        = {"venomous_blade_minor", "venomous_blade", "venomous_blade_major"},
  blooddrop_cap  = {"mudwort"},
  falconskyre    = {"mudwort"},
  etherweed      = {"mudwort"},
  mudwort        = {"blooddrop_cap"},
  blackmoss      = {"blackmoss", "blackmoss", "crystal_flower"},
  crystal_flower = {"crystal_flower", "crystal_flower", "blackmoss"},
  flask                  = {"potion_poison"},
  water_flask            = {"potion_healing"},
  potion_healing         = {"potion_energy", "potion_cure_disease", "potion_greater_healing"},
  potion_greater_healing = {"potion_energy", "potion_greater_energy"},
  potion_energy          = {"potion_healing"},
  potion_greater_energy  = {"potion_healing", "potion_cure_disease", "potion_bear_form"},
  potion_poison          = {"water_flask"},
  potion_shield          = {"potion_healing", "potion_greater_healing"},
  potion_cure_poison     = {"potion_healing", "potion_greater_healing"},
  potion_cure_disease    = {"potion_healing", "potion_greater_healing"},
  potion_rage            = {"potion_healing", "potion_greater_healing"},
  potion_speed           = {"potion_healing", "potion_greater_healing"},
  potion_bear_form       = {"potion_greater_healing"},
  potion_resurrection    = {"poison_bomb"},
  potion_strength        = {"potion_vitality"},
  potion_dexterity       = {"potion_vitality"},
  potion_vitality        = {"potion_strength"},
  potion_willpower       = {"potion_vitality"},
  fire_bomb   = {"poison_bomb"},
  shock_bomb  = {"poison_bomb"},
  frost_bomb  = {"poison_bomb"},
  poison_bomb = {"potion_resurrection"},
  sack = {"bottomless_sack"},
  arrow = {"poison_arrow"},
  quarrel = {"poison_quarrel"},
  fire_arrow = {"poison_arrow"},
  fire_quarrel = {"poison_quarrel"},
  shock_arrow = {"poison_arrow"},
  shock_quarrel = {"poison_quarrel"},
  cold_arrow = {"poison_arrow"},
  cold_quarrel = {"poison_quarrel"},
  poison_arrow = {"arrow"},
  poison_quarrel = {"quarrel"},
  fire_rod = {"venomous_rod"},
  lightning_rod = {"venomous_rod"},
  frozen_rod = {"venomous_rod"},
},
equipment = {{enchant.vitality, enchant.healthRegen, enchant.protection, enchant.shockResistance, enchant.foodRate}, " (Earth enchantment)"},
food = {"horned_fruit", "cheese", "turtle_eggs", "blueberry_pie"},
container = enchant.antigravityBag,
}

-- enchanted ammo

damageType =
{ arrow = "physical", fire_arrow = "fire", shock_arrow = "shock", cold_arrow = "cold", poison_arrow = "poison",
  quarrel = "physical", fire_quarrel = "fire", shock_quarrel = "shock", cold_quarrel = "cold", poison_quarrel = "poison",
}

function onAttackAmmo(self, champion, slot, chainIndex)
  local dt = champion:getOtherHandItem(slot)
  dt = dt and damageType[dt.go.name]
  if dt then self:setDamageType(dt) end
end

-- enchantment spells functions

function getShardEnchant(container, capacity)
  for slot = 1,capacity do
    local item = container:getItem(slot)
    if item then
      if item.go.containeritem then
        local ritem,rcont = getShardEnchant(item.go.containeritem, item.go.containeritem:getCapacity())
        if ritem then return ritem,rcont end
      elseif item.go.name == "crystal_shard_enchantment" then
        return item,container
      end
    end
  end
end

function consumeShardEnchant(ritem,rcont)
  local stack = ritem:getStackSize()
  if stack>1 then ritem:setStackSize(stack-1) else rcont:removeItem(ritem) end
end

function enchantment(tab, power, caster, cost)
  local ritem,rcont = getShardEnchant(caster, ItemSlot.MaxSlots)
  if not ritem then
    hudPrint("You need a crystal shard of enchantment to cast this spell.")
    playSound("spell_fizzle")
    caster:regainEnergy(cost)
    return false
  end
  local item = getMouseItem()
  if item then
    power = math.max(0,(power-1)/power)
    for old,new in pairs(tab.byName) do
      if item.go.name == old then
        power = quantum(1 + (#new-1)*power)
        if item:getStackable() then
          local stack = item:getStackSize()
          local item = spawn(new[power]).item
          if item:getStackable() then
            item:setStackSize(stack)
          elseif stack>1 then
            hudPrint("You can enchant only one item of that kind at a time.")
            playSound("spell_fizzle")
            item:destroy()
            caster:regainEnergy(cost)
            return false
          end
          setMouseItem(item)
          consumeShardEnchant(ritem,rcont)
        elseif item.go.containeritem and item.go.containeritem:getItemCount() > 0 then
          hudPrint("You must empty this container before enchanting it.")
          playSound("spell_fizzle")
          caster:regainEnergy(cost)
          return false
        else 
          setMouseItem(spawn(new[power]).item)
          consumeShardEnchant(ritem,rcont)
        end
        playSound("generic_spell")
        return
      end
    end
    if item.go.equipmentitem or item.go.meleeattack or item:hasTrait("firearm") or item:hasTrait("missile_weapon") then
      item = spawn(item.go.name).item
      item:setUiName(item:getUiName()..tab.equipment[2])
      item:addTrait("enchanted")
      if not item.go.equipmentitem then
        item.go:createComponent("EquipmentItem")
        item.go.equipmentitem:setSlot(ItemSlot.Weapon)
      end      
      for _,new in ipairs(tab.equipment[1]) do
        local modifier = quantum(new[2]*power*(0.95+0.05*caster:getLevel()))
        if modifier>0 then new[1](item.go.equipmentitem, modifier) end
      end
      setMouseItem(item)
      consumeShardEnchant(ritem,rcont)
      playSound("generic_spell")
      return
    end
    if item.go.usableitem and item.go.usableitem:getNutritionValue() and item.go.usableitem:getNutritionValue()>0 then
      local new = tab.food
      power = quantum(1 + (#new-1)*power*math.random())
      if item:getStackable() then
        local stack = item:getStackSize()
        item = spawn(new[power]).item
        item:setStackSize(stack)
        setMouseItem(item)
      else 
        setMouseItem(spawn(new[power]).item)
      end
      consumeShardEnchant(ritem,rcont)
      playSound("generic_spell")
      return
    end
    if item.go.containeritem and tab.container then
      if item.go.containeritem:getItemCount() < 1 then
        item = spawn(item.go.name).item
        item:addTrait("enchanted")
        tab.container(item.go, power)
        setMouseItem(item)
        consumeShardEnchant(ritem,rcont)
        playSound("generic_spell")
        return
      else
        hudPrint("You must empty this container before enchanting it.")
        playSound("spell_fizzle")
        caster:regainEnergy(cost)
        return false
      end
    end
    hudPrint("You cannot enchant this item.")
  else
    hudPrint("You must pick an item to enchant.")
  end
  playSound("spell_fizzle")
end

traps = {{},{},{},{}}

function ward(effect, power, ordinal, color)
  local x, y = getFrontTarget()
  local rune = spawn("trap_rune", party.level, x, y, party.facing, party.elevation)
  rune.iceshards:setRange(1)
  if not rune.tiledamager:isEnabled() then playSound("spell_fizzle") rune:destroy() return end
  if color then rune.light:setColor(color) end
  rune.data:set("effect", effect)
  rune.data:set("attackPower", power)
  rune.data:set("champion", ordinal)
  local tab = traps[ordinal]
  tab[#tab+1] = rune.id
  local maxTraps = 1 + 5*spells_functions.script.getSkillPower(party.party:getChampionByOrdinal(ordinal), "concentration")
  while #tab > maxTraps do
    rune = findEntity(tab[1])
    if rune then rune:destroy() end
    table.remove(tab, 1)
  end
end

function spawnScrolls()
  for i = 1, #defOrdered do
    if not defOrdered[i].hidden then
      local name = defOrdered[i].name
      local needed = true
      for i = 1,4 do
        local c = party.party:getChampionByOrdinal(i)
        if c:hasTrait(name) then needed = false break end
      end
      if needed then spawn("scroll_"..name, party.level, party.x, party.y, party.facing, party.elevation) end
    end
  end
end



-- spellbook

function learnAllSpells()
  local book = locateSpellbook()
  if not book then hudPrint("You need a spellbook to store all that knowledge!") return end
  for _,spell in ipairs(defOrdered) do if not spell.hidden then learnNewSpell(spell.name,true) end end
  if currentPage then closeCurrentPage(book) end
  sortSpells(book)
  openLastPage(book)
  hudPrint("You learned all spells !")
end

PAGE_COUNT = math.ceil((#defOrdered-2)/14)

function onPickUpItem(item)
  if item.go.spellscrollitem and item.go.spellscrollitem.getSpell then
    learnNewSpell(item.go.spellscrollitem:getSpell())
  elseif item.go.name == "spellbook" then
    checkUnlearnedScrolls(item)
  end
end

function onClickItemSlot(champion,container,slot,button)
  if champion and champion:hasCondition("frozen_champion") then return false end
  if container then
    -- Do not let the party treat the spellbook as a real container, or the spell
    -- descs as real items
    if container.go.item:hasTrait("fixed_container") then
      local itm = container:getItem(slot)
      if itm then
        if itm.go.name == "spellbook_rarrow" then
          nextPage(container.go.item)
        elseif itm.go.name == "spellbook_larrow" then
          prevPage(container.go.item)
        end
      end
      return false
    end
  elseif button == 2 and champion then
    -- When opening a different container, check for scrolls inside it
    local itm = champion:getItem(slot)
    if itm and not itm:hasTrait("fixed_container") and itm.go.containeritem and itm.go.containeritem.getCapacity then
      for slot=1,itm.go.containeritem:getCapacity() do
        local itm2 = itm.go.containeritem:getItem(slot)
        if itm2 then onPickUpItem(itm2) end -- check spell scroll or book
      end
    end
  end
end

currentPage = nil
lastPage = nil

function spellKnown(champion,spell)
  if defByName[spell].known then
    return true
-- allow learning spell from a champion casting it without the scroll
  elseif champion:hasTrait(spell) then
    learnNewSpell(spell)
    return true
-- allow learning spell from scroll if party has dropped spellbook for some reason
  elseif party.party:isCarrying("scroll_"..spell) then
    learnNewSpell(spell)
    return true
  else
    return false
  end
end

function learnNewSpell(spell,skipSort,silent,book)
  if defByName[spell].known then
    return false
  else
    book = book or locateSpellbook()
    if book then
      defByName[spell].known = true
      addSpellItem(book,spell,skipSort,silent)
    end
  end
end

-- Check the party's inventory for spellscrollitems that haven't been added to
-- the spellbook (because the spellbook was out of inventory when they were
-- picked up)
function checkUnlearnedScrolls(book)
  if getMouseItem() and not getMouseItem():hasTrait("fixed_container") and getMouseItem().go.spellscrollitem and getMouseItem().go.spellscrollitem.getSpell then
    learnNewSpell(getMouseItem().go.spellscrollitem.getSpell(),false,false,book)
  end
  local function searchContainer(c)
    for index=1,c:getCapacity() do
      local itm = c:getItem(index)
      if itm and not itm:hasTrait("fixed_container") then
        if itm.go.spellscrollitem and itm.go.spellscrollitem.getSpell then
          learnNewSpell(itm.go.spellscrollitem:getSpell(),false,false,book)
        else
          for _,comp in itm.go:componentIterator() do
            if comp:getClass() == "ContainerItemComponent" then
              searchContainer(comp)
            end
          end
        end
      end
    end
  end
  for i=1,4 do
    local champion = party.party:getChampion(i)
    for slt,itm in champion:carriedItems() do
      if not itm:hasTrait("fixed_container") then
        if itm.go.spellscrollitem and itm.go.spellscrollitem.getSpell then
          learnNewSpell(itm.go.spellscrollitem:getSpell(),false,false,book)
        else
          for _,c in itm.go:componentIterator() do
            if c:getClass() == "ContainerItemComponent" then
              searchContainer(c)
            end
          end
        end
      end
    end
  end
end

function closeCurrentPage(book)
  if currentPage then
    closePage(book,currentPage)
    lastPage = currentPage
    currentPage = nil
  end
end

function openLastPage(book)
  if lastPage and not currentPage then
    openPage(book,lastPage)
  end
end

function nextPage(book)
  if currentPage then
    local n = math.min(currentPage+1,PAGE_COUNT)
    closeCurrentPage(book)
    openPage(book,n)
  end
  playSound("map_turn_page")
end

function prevPage(book)
  if currentPage then
    local n = math.max(currentPage-1,1)
    closeCurrentPage(book)
    openPage(book,n)
  end
  playSound("map_turn_page")
end

-- Return a page's contents to its page container
function closePage(book,index)
  local open = book.go.containeritem
  local page = getPageItem(book):getComponent("page"..tostring(index))
  for slot=1,open:getCapacity() do
    local itm = open:getItem(slot)
    if itm then
      open:removeItemFromSlot(slot)
      page:insertItem(slot,itm)
    end
  end
end

-- Move a page's contents to the main container
function openPage(book,index)
  currentPage = index
  local open = book.go.containeritem
  local page = getPageItem(book):getComponent("page"..tostring(index))
  for slot=1,page:getCapacity() do
    local itm = page:getItem(slot)
    if itm then
      page:removeItemFromSlot(slot)
      open:insertItem(slot,itm)
    end
  end
end

function addSpellItem(book,spell,skipSort,silent)
  local def = defByName[spell]
  local desc = spawn("spellbook_desc")
  desc.spellscrollitem:setSpell(spell)
  desc.item:setUiName(def.uiName)
  desc.item:setGfxAtlas(def.iconAtlas or "assets/textures/gui/skills.tga")
  if def.iconAtlas then -- HACK: make spells_large.tga work
    desc.item:setGfxIndex(13*math.floor(def.icon/4) + def.icon%4)
  else
    desc.item:setGfxIndex(13*math.floor(def.icon/10) + def.icon%10)
  end
  if currentPage then closeCurrentPage(book) end
  if insertInNextFreeSlot(book,desc.item) and not silent then hudPrint(def.uiName.." has been added to the spellbook.") end
  if not skipSort then sortSpells(book) end
  openLastPage(book)
end

function insertInNextFreeSlot(book,item)
  for i=1,PAGE_COUNT do
    local page = getPageItem(book):getComponent("page"..tostring(i))
    for slot=1,page:getCapacity() do
      if not page:getItem(slot) then
        if slot == 16 and i < PAGE_COUNT then
          page:insertItem(slot,spawn("spellbook_rarrow").item)
          getPageItem(book):getComponent("page"..tostring(i+1)):insertItem(13,spawn("spellbook_larrow").item)
        else
          page:insertItem(slot,item)
          return true
        end
      end
    end
  end
end

function sortSpells(book)
  local list = {}

  -- Build list and clear pages of spell descs (but not arrows)
  for i=1,PAGE_COUNT do
    local page = getPageItem(book):getComponent("page"..tostring(i))
    for slot=1,page:getCapacity() do
      if validSpellSlot(i,slot) and page:getItem(slot) then
        table.insert(list,page:getItem(slot))
        page:removeItemFromSlot(slot)
      end
    end
  end

  table.sort(list,comparator)

  -- Rebuild pages
  local listIndex = 1
  for i=1,PAGE_COUNT do
    local page = getPageItem(book):getComponent("page"..tostring(i))
    for slot=1,page:getCapacity() do
      if validSpellSlot(i,slot) then
        page:insertItem(slot,list[listIndex])
        listIndex = listIndex+1
        if listIndex > #list then return end
      end
    end
  end
end

function validSpellSlot(pageIndex,slot)
  return not (pageIndex ~= 1 and slot == 13 or pageIndex ~= PAGE_COUNT and slot == 16)
end

function comparator(a,b)
  a = defByName[a.go.spellscrollitem:getSpell()].index
  b = defByName[b.go.spellscrollitem:getSpell()].index
  return a < b
end

-- Find the most spellcasty champion and give them the spellbook, with known spells of total requirements level or less.
function giveSpellbook(level)
  local book = locateSpellbook()
  if not book then
    local highestSpelliness = 0
    local spelliestChampion = 1
    local spellSkills = {"concentration","fire_magic","air_magic","earth_magic","water_magic"}
    for i=1,4 do
      local spelliness = 0
      local c = party.party:getChampion(i)
      if c:getEnabled() then
        for _,sk in ipairs(spellSkills) do
          spelliness = spelliness+c:getSkillLevel(sk)
        end
        if c:hasTrait("hand_caster") then spelliness = spelliness+4 end
        spelliness = spelliness+c:getMaxEnergy()/100
        if spelliness > highestSpelliness then
          highestSpelliness = spelliness
          spelliestChampion = i
        end
      end
    end
    local c = party.party:getChampion(spelliestChampion)
    book = spawn("spellbook").item
    for slot=ItemSlot.BackpackFirst,ItemSlot.BackpackLast do
      if not c:getItem(slot) then
        c:insertItem(slot,book)
        break
      end
    end
  end
  initBookItem(book, level)
end

function initBookId(id, level)
  local book = findEntity(id)
  if not book then return end
  initBookItem(book.item, level)
end

function initBookItem(book, level)
  getPageItem(book)
  level = level or starting_spells_level
  if level>0 then
    for _,def in ipairs(defOrdered) do
      if not def.hidden then
        local req = 0
        for i = 2,#def.requirements,2 do req = req + def.requirements[i] end
        if req <= level then learnNewSpell(def.name,true,true,book) end
      end
    end
  end
  openPage(book,1)
end

function getPageItem(book)
  return findEntity("pages_"..book.go.id) or
  spawn("spellbook_storageitem",self.go.level,self.go.x,self.go.y,self.go.facing,self.go.elevation,"pages_"..book.go.id)
end

-- Locate the spellbook in the party's inventory, if they have it. Recursively
-- searches containers, not that this is really needed...
function locateSpellbook()
  if getMouseItem() and getMouseItem().go.name == "spellbook" then return getMouseItem() end
  local book,champion,container,slot
  local function searchContainer(c)
    for index=1,c:getCapacity() do
      local itm = c:getItem(index)
      if itm then
        if itm.go.name == "spellbook" then
          book = itm
          container = c
          slot = index
          return itm
        else
          for _,comp in itm.go:componentIterator() do
            if comp:getClass() == "ContainerItemComponent" then
              return searchContainer(comp)
            end
          end
        end
      end
    end
  end
  for i=1,4 do
    local champion = party.party:getChampion(i)
    for slt,itm in champion:carriedItems() do
      if itm.go.name == "spellbook" then
        book = itm
        slot = slt
      else
        for _,c in itm.go:componentIterator() do
          if c:getClass() == "ContainerItemComponent" then
            searchContainer(c)
            if book then break end
          end
        end
      end
      if book then break end
    end
    if book then break end
  end
  if book then
    return book,champion,container,slot
  end
end

function elementalistPower(element, champion, power)
	if champion:getClass() == "elementalist" then
		local shield_dur = 10 + (math.floor(champion:getLevel() / 5) * 5)
		if element == "fire" then
			spells_functions.script.addConditionValue("elemental_balance_fire", 15, champion:getOrdinal())
			if champion:hasCondition("elemental_balance_cold") or champion:hasCondition("elemental_balance_air") then
				power = power * 1.3
				--print("fire spell power up")
			end
			champion:removeCondition("elemental_balance_cold")
			champion:removeCondition("elemental_balance_air")
			spells_functions.script.elementalShieldSingle(shield_dur, champion, true, false, false, false)
		elseif element == "cold" then
			spells_functions.script.addConditionValue("elemental_balance_cold", 15, champion:getOrdinal())
			if champion:hasCondition("elemental_balance_fire") or champion:hasCondition("elemental_balance_air") then
				power = power * 1.3
				--print("cold spell power up")
			end
			champion:removeCondition("elemental_balance_fire")
			champion:removeCondition("elemental_balance_air")
			spells_functions.script.elementalShieldSingle(shield_dur, champion, false, false, true, false)
		elseif element == "air" then
			spells_functions.script.addConditionValue("elemental_balance_air", 15, champion:getOrdinal())
			if champion:hasCondition("elemental_balance_cold") or champion:hasCondition("elemental_balance_fire") then
				power = power * 1.3
				--print("shock spell power up")
			end
			champion:removeCondition("elemental_balance_cold")
			champion:removeCondition("elemental_balance_fire")
			spells_functions.script.elementalShieldSingle(shield_dur, champion, false, true, false, false)
		end
	end
end

function druidPower(champion, power)
	if champion:getClass() == "druid" and champion:hasTrait("blooddrop_cap") then
		power = power * 1.2
		champion:setCondition("blooddrop_rage")
		champion:addTrait("blooddrop_rage")
	end
end