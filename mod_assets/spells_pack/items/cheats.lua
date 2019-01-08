defineObject{
  name = "crystal_shard_leveling",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/crystal_shard.fbx",
    },
    {
      class = "Item",
      uiName = "Crystal Shard of Leveling",
      gfxIndex = 437,
      weight = 0.3,
      --stackable = true,
      gameEffect = "A mighty cheat leveling all your champions !",
      description = "This crystal shard is loaded with raw energy. It makes your fingertips tingle.",
    },
    {
      class = "Light",
      offset = vec(0, 0.02, 0),
      range = 0.5,
      color = vec(0.8, 1.66, 2.55),
      brightness = 10,
      castShadow = false,
      fillLight = true,
    },
    {
      class = "UsableItem",
      sound = "heal_party",
      onUseItem = function(self, champion)
        local minLevel = math.huge
        for i = 1,4 do
          local l = party.party:getChampionByOrdinal(i):getLevel()
          if l<minLevel then minLevel = l end
        end
        for i = 1,4 do
          local c = party.party:getChampionByOrdinal(i)
          if c:getLevel() <= minLevel then c:levelUp() end
          local missing = 0
          local skills = { 
	         "accuracy","athletics", "armors", "critical", "dodge", "ranged_weapons",
	         "throwing", "firearms", "light_weapons", "heavy_weapons", "concentration", "alchemy",
	         "fire_magic","earth_magic","water_magic","air_magic" 
          }
          for _,skill in ipairs(skills) do
            missing = missing + 5 - c:getSkillLevel(skill)
          end
          if c:getSkillPoints() > missing then c:setSkillPoints(missing) end
        end
        hudPrint(champion:getName().." leveled up the party !")
        return false       
      end,
    },
  },
}

defineObject{
  name = "crystal_shard_skills",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/crystal_shard_protection.fbx",
    },
    {
      class = "Item",
      uiName = "Crystal Shard of Skills",
      gfxIndex = 439,
      weight = 0.3,
      --stackable = true,
      gameEffect = "A mighty cheat maxing all your champions skills !",
      description = "This crystal shard is loaded with raw energy. It makes your fingertips tingle.",
    },
    {
      class = "Light",
      offset = vec(0, 0.02, 0),
      range = 0.5,
      color = vec(0,2.55, 0),
      brightness = 10,
      castShadow = false,
      fillLight = true,
    },
    {
      class = "UsableItem",
      sound = "heal_party",
      onUseItem = function(self, champion)
        for i = 1,4 do
          local c = party.party:getChampionByOrdinal(i)
          local skills = { 
	         "accuracy","athletics", "armors", "critical", "dodge", "ranged_weapons",
	         "throwing", "firearms", "light_weapons", "heavy_weapons", "concentration", "alchemy",
	         "fire_magic","earth_magic","water_magic","air_magic" 
          }
          for _,skill in ipairs(skills) do
            c:trainSkill(skill, 5)
          end
          c:setSkillPoints(0)
        end
        hudPrint(champion:getName().." maxed up the party skills !")
        return false       
      end,
    },
  },
}

defineObject{
  name = "crystal_shard_scrolls",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/crystal_shard_recharge.fbx",
    },
    {
      class = "Item",
      uiName = "Crystal Shard of Scrolls",
      gfxIndex = 438,
      weight = 0.3,
      --stackable = true,
      gameEffect = "A mighty cheat creating all unlearned spells scrolls !",
      description = "This crystal shard is loaded with raw energy. It makes your fingertips tingle.",
    },
    {
      class = "Light",
      offset = vec(0, 0.02, 0),
      range = 0.5,
      color = vec(2.55, 0, 0.25),
      brightness = 10,
      castShadow = false,
      fillLight = true,
    },
    {
      class = "UsableItem",
      sound = "heal_party",
      onUseItem = function(self, champion)
        spells_functions.script.spawnScrolls()
        hudPrint(champion:getName().." created all spells scrolls !")
        return false       
      end,
    },
  },
}

defineObject{
  name = "crystal_shard_spells",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/crystal_shard_recharge.fbx",
    },
    {
      class = "Item",
      uiName = "Crystal Shard of Spells",
      gfxIndex = 438,
      weight = 0.3,
      --stackable = true,
      gameEffect = "A mighty cheat to learn all spells !",
      description = "This crystal shard is loaded with raw energy. It makes your fingertips tingle.",
    },
    {
      class = "Light",
      offset = vec(0, 0.02, 0),
      range = 0.5,
      color = vec(2.55, 0, 0.25),
      brightness = 10,
      castShadow = false,
      fillLight = true,
    },
    {
      class = "UsableItem",
      sound = "heal_party",
      onUseItem = function(self, champion)
        spells_functions.script.learnAllSpells()
        return false       
      end,
    },
  },
}