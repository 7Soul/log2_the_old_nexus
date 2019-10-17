partyDef =
{
  name = "party",
  baseObject = "party",
  components = {
    {
      class = "Timer",
      name = "frametimer",
      timerInterval = 0,
      triggerOnStart = true,
      onActivate = function(self)
        local t = self.go.gametime:getValue()+Time.deltaTime()
        self.go.gametime:setValue(t)
        if spells_functions then
          spells_functions.script.updateLights(t)
          spells_functions.script.updateDelayedEffects(t)
        end
      end,
    },
    {
      class = "Counter",
      name = "gametime",
    },
    {
      class = "Light",
      brightness = 0,
      castShadow = false,
      color = vec(1, 1, 1),
      range = 9,
      type = "point",
      onInit = function(self) self.go.torch:disable() end,
    },
  },
}

if hook_framework then
  partyDef.components[1].onInit =
  function(self)
    fw.script:set('party.spell_pack.onAttack',function(hook,party,champion,action,slot)
      return spells_functions.script.onAttack(champion, action, slot)
    end)
    fw.script:set('party.spell_pack.onCastSpell',function(hook,party,champion,spellName)
      return spells_functions.script.onCastSpell(champion, spellName)
    end)
    fw.script:set('party.spell_pack.onWakeUp',function(hook,party)
      return not spells_functions.script.deepSleep
    end)
    fw.script:set('party.spell_pack.onDamage',function(hook,party,champion,damage,damageType)
      return spells_functions.script.onDamage(champion, damage, damageType)
    end)
    fw.script:set('party.spell_pack.onDie',function(hook,party,champion)
      return spells_functions.script.onDie(champion)
    end)
    fw.script:set('party.spell_pack.onReceiveCondition',function(hook,party,champion,condition)
      return spells_functions.script.onReceiveCondition(champion, condition)
    end)
    -- spellbook
    -- fw.script:set("party.spell_pack.onClickItemSlot",function(hook,party,champion,container,slot,button)
    --   return spells_functions.script.onClickItemSlot(champion,container,slot,button)
    -- end)
    -- fw.script:set("party.spell_pack.onPickUpItem",function(hook,party,item)
    --   return spells_functions.script.onPickUpItem(item)
    -- end)
  end
else
  partyDef.components[#partyDef.components+1] =
  {
    class = "Party",
    onDrawGui = function(self) return true end,
    onDrawInventory = function(self) return true end,
    onDrawStats = function(self) return true end,
    onDrawSkills = function(self) return true end,
    onDrawTraits = function(self) return true end,
    onAttack = function(self, champion, action, slot)
      return spells_functions.script.onAttack(champion, action, slot)
    end,
    onCastSpell = function(self, champion, spellName)
      return spells_functions.script.onCastSpell(champion, spellName)
    end,
    onWakeUp = function(self)
      return not spells_functions.script.deepSleep
    end,
    onDamage = function(self, champion, damage, damageType)
      return spells_functions.script.onDamage(champion, damage, damageType)
    end,
    onDie = function(self, champion)
      return spells_functions.script.onDie(champion)
    end,
    onReceiveCondition = function(self, champion, condition)
      return spells_functions.script.onReceiveCondition(champion, condition)
    end,
    -- spellbook
    -- onClickItemSlot = function(self,champion,container,slot,button)
    --   return spells_functions.script.onClickItemSlot(champion,container,slot,button)
    -- end,
    -- onPickUpItem = function(self,item)
    --   return spells_functions.script.onPickUpItem(item)
    -- end,
  }
end

defineObject(partyDef)
