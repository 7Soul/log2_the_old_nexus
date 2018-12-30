function getComponent(def, class)
  if def.components then
    for _,c in ipairs(def.components) do
      if c.class == class then return c end
    end
  end
end

function contains(tab, elt)
  if tab then
    for _,e in ipairs(tab) do
      if e == elt then return true end
    end
  end
  return false
end

function detectDeath(timer) spells_functions.script.detectDeath(timer) end
function detectOracle(timer) spells_functions.script.detectOracle(timer) end
function detectLife(timer) spells_functions.script.detectLife(timer) end

oldDefineObject = defineObject

defineObject = function(def)
  local mat,act = nil,nil
  local monster = getComponent(def, "Monster")
  if monster then
    mat = contains(monster.traits,    "undead") and "detect_undead"
       or contains(monster.traits, "elemental") and "detect_elemental"
       or contains(monster.traits, "construct") and "detect_construct"
       or "detect_life"
    act = mat == "detect_life" and detectLife or detectDeath
  elseif getComponent(def, "Item") then
    mat = "detect_item"
    act = detectOracle
  elseif def.name:find("secret_button") then
    mat = "detect_construct"
    act = detectOracle
  end
  if mat then
    def.components[#def.components+1] =
    {
      class = "Model",
      name = "detectedmodel",
      model = "assets/models/effects/trap_rune.fbx",
      material = mat,
      boundBox = {size = vec(100000,100000,100000)},
      enabled = false,
    }
    def.components[#def.components+1] =
    {
      class = "Timer",
      name = "detectedtimer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = act,
    }
  end
  oldDefineObject(def)
end