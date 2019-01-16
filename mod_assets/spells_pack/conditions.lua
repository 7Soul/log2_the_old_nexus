defineCondition
{ name = "silence",
  uiName = "Silence",
  description = "You can't cast spells.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/silence.tga",
  beneficial = false,
  harmful = true,
  onStart = function(self, champion)
    if not self:getDuration() then self:setDuration(math.random(6,10)) end
  end,
}

defineCondition
{ name = "invulnerability",
  uiName = "Invulnerability",
  description = "Prevents all damage.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/invulnerability.tga",
  beneficial = true,
  harmful = false,
}

for spell,effect in pairs(mageArmors) do defineCondition
{ name = spell,
  uiName = effect.uiName or defByName[spell].uiName,
  description = effect.description,
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/"..spell..".tga",
  beneficial = true,
  harmful = false,
}
end

-- concentration magic

defineCondition
{ name = "protective_shield",
  uiName = "Magical Shield",
  description = "Protection +25.\n\n[Battle Mage or Knight]:\nProtection +50 instead.",
  icon = 19,
  beneficial = true,
  harmful = false,
  onRecomputeStats = function(self, champion)
	local shield = (champion:hasTrait("battle_mage") or champion:hasTrait("knight")) and 50 or 25
    champion:addStatModifier("protection", shield)
  end,
  onStart = function(self, champion)
    if not self:getDuration() then self:setDuration(40) end
  end,
}

-- water magic

defineCondition
{ name = "frozen_champion",
  uiName = "Frozen",
  description = "You can't move, cast spells or attack.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/frozen.tga",
  beneficial = false,
  harmful = true,
  onStart = function(self, champion)
    playSound("frostburst")
    if not self:getDuration() then self:setDuration(math.random(3,5)) end
  end,
  onStop = function(self, champion)
    playSound("ice_hit")
  end,
}

-- fire & air magic

defineCondition
{ name = "haste_spell",
  uiName = "Haste",
  description = "Cooldown times are halved.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/haste.tga",
  beneficial = true,
  harmful = false,
  tickInterval = 0,
  onStart = function(self, champion)
    local key = "haste_spell"..champion:getOrdinal()
    spells_functions.script.set(key, champion:getCurrentStat("cooldown_rate"))
  end,
  onStop = function(self, champion)
    local key = "haste_spell"..champion:getOrdinal()
    spells_functions.script.set(key)
  end,
  onRecomputeStats = function(self, champion)
    local key = "haste_spell"..champion:getOrdinal()
    local val = spells_functions.script.get(key) or 0
    champion:addStatModifier("cooldown_rate", val)
    spells_functions.script.set("current_"..key, val)
  end,
  onTick = function(self, champion)
    local key = "haste_spell"..champion:getOrdinal()
    local val = champion:getCurrentStat("cooldown_rate") - (spells_functions.script.get(key) or 0)
    spells_functions.script.set(key, val==val and val or 0)
  end,
}

-- air & water magic

defineCondition
{ name = "energy_shield",
  uiName = "Psychic shield",
  description = "Energy absorbs damage. Doubles your energy regeneration rate.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/energy_shield.tga",
  beneficial = true,
  harmful = false,
  tickInterval = 0,
  onStart = function(self, champion)
    local key = "energy_shield_regen"..champion:getOrdinal()
    spells_functions.script.set(key, champion:getCurrentStat("energy_regeneration_rate"))
  end,
  onStop = function(self, champion)
    local key = "energy_shield_regen"..champion:getOrdinal()
    spells_functions.script.set(key)
  end,
  onRecomputeStats = function(self, champion)
    local key = "energy_shield_regen"..champion:getOrdinal()
    champion:addStatModifier("energy_regeneration_rate", (spells_functions.script.get(key) or 0))
  end,
  onTick = function(self, champion)
    local key = "energy_shield_regen"..champion:getOrdinal()
    local val = champion:getCurrentStat("energy_regeneration_rate") - (spells_functions.script.get(key) or 0)
    spells_functions.script.set(key, val==val and val or 0)
  end,
}

-- earth & fire magic

defineCondition
{ name = "valor",
  uiName = "Valor",
  description = "Grants you +1 Strength (+1 per 2 levels).",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/valor.tga",
  beneficial = true,
  harmful = false,
  tickInterval = 0,
  onRecomputeStats = function(self, champion)
    champion:addStatModifier("strength", math.floor(champion:getLevel() / 2) + 1)
  end,
}

-- water, earth and fire magic

defineCondition
{ name = "vengeance",
  uiName = "Vengeance",
  description = "You gain temporary strength, dexterity and willpower equal to damage you received. These bonuses can never be over 10% of your maximum health.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/vengeance.tga",
  beneficial = true,
  harmful = false,
  tickInterval = 0,
  onRecomputeStats = function(self, champion)
    champion:addStatModifier( "strength", spells_functions.script.quantum(self:getDuration()))
    champion:addStatModifier("dexterity", spells_functions.script.quantum(self:getDuration()))
    champion:addStatModifier("willpower", spells_functions.script.quantum(self:getDuration()))
  end,
  onTick = function(self, champion)
    if self:getDuration() > champion:getMaxHealth()/5 then self:setDuration(champion:getMaxHealth()/5) end
  end,
}

-- fire, air, water & earth magic

defineCondition
{ name = "might",
  uiName = "Might",
  description = "Doubles strength, dexterity, vitality and willpower.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/might.tga",
  beneficial = true,
  harmful = false,
  tickInterval = 0,
  onStart = function(self, champion)
    local ordinal = champion:getOrdinal()
    for att,tab in pairs(spells_functions.script.might) do tab[ordinal] = champion:getCurrentStat(att) end
  end,
  onStop = function(self, champion)
    local ordinal = champion:getOrdinal()
    for att,tab in pairs(spells_functions.script.might) do tab[ordinal] = 0 end
  end,
  onRecomputeStats = function(self, champion)
    local ordinal = champion:getOrdinal()
    for att,tab in pairs(spells_functions.script.might) do champion:addStatModifier(att, tab[ordinal]) end
  end,
  onTick = function(self, champion)
    local ordinal = champion:getOrdinal()
    for att,tab in pairs(spells_functions.script.might) do
      local val = champion:getCurrentStat(att) - tab[ordinal]
      tab[ordinal] = val==val and val or 0
    end
  end,
}

defineCondition
{ name = "revive",
  uiName = "Revive",
  description = "Resurrects you the next time you die.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/revive.tga",
  beneficial = true,
  harmful = false,
  tickInterval = 0.1,
  onTick = function(self, champion)
    spells_functions.script.partyLight("immortal", 0.1, vec(1, 1, 1), 3)    
  end,
}

defineCondition
{ name = "alter_time",
  uiName = "Alter Time",
  description = "Slows the flowing of time and gives you haste and running speed to compensate.",
  icon = 0,
  iconAtlas = path.."textures/gui/conditions/alter_time.tga",
  beneficial = true,
  harmful = false,
  tickInterval = 0,
  onStart = function(self, champion)
    local ord = champion:getOrdinal()
    local key1 = "alter_time"..ord
    local key2 = "haste_spell"..ord
    local haste = champion:hasCondition("haste_spell") and spells_functions.script.get(key2) or 0
    spells_functions.script.set(key1, (champion:getCurrentStat("cooldown_rate") - haste) * (spells_functions.script.getTimeScale() - 1))
  end,
  onStop = function(self, champion)
    local key = "alter_time"..champion:getOrdinal()
    spells_functions.script.set(key)
  end,
  onRecomputeStats = function(self, champion)
    local key = "alter_time"..champion:getOrdinal()
    champion:addStatModifier("cooldown_rate", (spells_functions.script.get(key) or 0))
  end,
  onTick = function(self, champion)
    local ord = champion:getOrdinal()
    local key1 = "alter_time"..ord
    local key2 = "current_haste_spell"..ord
    local alter = spells_functions.script.get(key1) or 0
    local haste = champion:hasCondition("haste_spell") and spells_functions.script.get(key2) or 0
    local val = (champion:getCurrentStat("cooldown_rate") - alter - haste) * (spells_functions.script.getTimeScale() - 1)
    spells_functions.script.set(key1, val==val and val or 0)
  end,
}
