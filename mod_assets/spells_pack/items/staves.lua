defineObject{
  name = "fire_rod",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/lightning_rod.fbx",
    },
    {
      class = "Item",
      uiName = "Fire Rod",
      description = "Flammes appear every time this rod moves through the air.",
      gfxAtlas = path.."textures/gui/fire_rod.dds",
      gfxIndex = 0,
      gfxIndexPowerAttack = 441,
      impactSound = "impact_blunt",
      weight = 1.7,
      primaryAction = "meleeattack",
      secondaryAction = "castspell",
    },
    {
      class = "MeleeAttack",
      attackPower = 14,
      accuracy = 0,
      cooldown = 4,
      damageType = "fire",
      swipe = "vertical",
      attackSound = "swipe",
      baseDamageStat = "strength",
      gameEffect = "Restores one charge of this rod. Fire spells power +20% for 30 seconds.",
      onAttack = function(self, champion, slot, chainIndex)
        spells_functions.script.addSkillPower(champion, "fire_magic", 20, 30)
        local charge = math.min(self.go.castspell:getCharges()+1, self.go.castspell:getMaxCharges())
        self.go.castspell:recharge()
        self.go.castspell:setCharges(charge)
      end,
    },
    {
      class = "CastSpell",
      uiName = "Fireburst",
      cooldown = 5,
      spell = "fireburst",
      energyCost = 5,
      power = 3,
      charges = 3,
      fullGfxIndex = 0,
      emptyGfxIndex = 1,
    },
    {
      class = "Particle",
      particleSystem = "fire_rod",
    },
  },
  tags = { "weapon" },
}

defineObject{
  name = "lightning_rod",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/lightning_rod.fbx",
    },
    {
      class = "Item",
      uiName = "Lightning Rod",
      description = "A rolling thunder can be heard every time this rod moves through the air.",
      gfxIndex = 222,
      gfxIndexPowerAttack = 441,
      impactSound = "impact_blunt",
      weight = 1.7,
      primaryAction = "meleeattack",
      secondaryAction = "castspell",
    },
    {
      class = "MeleeAttack",
      attackPower = 14,
      accuracy = 0,
      cooldown = 4,
      damageType = "shock",
      swipe = "vertical",
      attackSound = "swipe",
      baseDamageStat = "dexterity",
      gameEffect = "Restores one charge of this rod. Air spells power +20% for 30 seconds.",
      onAttack = function(self, champion, slot, chainIndex)
        spells_functions.script.addSkillPower(champion, "air_magic", 20, 30)
        local charge = math.min(self.go.castspell:getCharges()+1, self.go.castspell:getMaxCharges())
        self.go.castspell:recharge()
        self.go.castspell:setCharges(charge)
      end,
    },
    {
      class = "CastSpell",
      uiName = "Shock",
      cooldown = 5,
      spell = "shock",
      energyCost = 5,
      power = 3,
      charges = 3,
      fullGfxIndex = 222,
      emptyGfxIndex = 223,
    },
    {
      class = "Particle",
      particleSystem = "lightning_rod",
    },
  },
  tags = { "weapon" },
}

defineObject{
  name = "frozen_rod",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/lightning_rod.fbx",
    },
    {
      class = "Item",
      uiName = "Frozen Rod",
      description = "A cold wind blows every time this rod moves through the air.",
      gfxAtlas = path.."textures/gui/frozen_rod.dds",
      gfxIndex = 0,
      gfxIndexPowerAttack = 441,
      impactSound = "impact_blunt",
      weight = 1.7,
      primaryAction = "meleeattack",
      secondaryAction = "castspell",
    },
    {
      class = "MeleeAttack",
      attackPower = 14,
      accuracy = 0,
      cooldown = 4,
      damageType = "cold",
      swipe = "vertical",
      attackSound = "swipe",
      baseDamageStat = "willpower",
      gameEffect = "Restores one charge of this rod. Water spells power +20% for 30 seconds.",
      onAttack = function(self, champion, slot, chainIndex)
        spells_functions.script.addSkillPower(champion, "water_magic", 20, 30)
        local charge = math.min(self.go.castspell:getCharges()+1, self.go.castspell:getMaxCharges())
        self.go.castspell:recharge()
        self.go.castspell:setCharges(charge)
      end,
    },
    {
      class = "CastSpell",
      uiName = "Frostburst",
      cooldown = 5,
      spell = "frost_burst",
      energyCost = 5,
      power = 3,
      charges = 3,
      fullGfxIndex = 0,
      emptyGfxIndex = 1,
    },
    {
      class = "Particle",
      particleSystem = "frozen_rod",
    },
  },
  tags = { "weapon" },
}

defineObject{
  name = "venomous_rod",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/lightning_rod.fbx",
    },
    {
      class = "Item",
      uiName = "Venomous Rod",
      description = "A snake bite can be heard every time this rod moves through the air.",
      gfxAtlas = path.."textures/gui/venomous_rod.dds",
      gfxIndex = 0,
      gfxIndexPowerAttack = 441,
      impactSound = "impact_blunt",
      weight = 1.7,
      primaryAction = "meleeattack",
      secondaryAction = "castspell",
    },
    {
      class = "MeleeAttack",
      attackPower = 14,
      accuracy = 0,
      cooldown = 4,
      damageType = "poison",
      swipe = "vertical",
      attackSound = "swipe",
      baseDamageStat = "vitality",
      gameEffect = "Restores one charge of this rod. Earth spells power +20% for 30 seconds.",
      onAttack = function(self, champion, slot, chainIndex)
        spells_functions.script.addSkillPower(champion, "earth_magic", 20, 30)
        local charge = math.min(self.go.castspell:getCharges()+1, self.go.castspell:getMaxCharges())
        self.go.castspell:recharge()
        self.go.castspell:setCharges(charge)
      end,
    },
    {
      class = "CastSpell",
      uiName = "Poison Cloud",
      cooldown = 5,
      spell = "poison_cloud",
      energyCost = 5,
      power = 3,
      charges = 3,
      fullGfxIndex = 0,
      emptyGfxIndex = 1,
    },
    {
      class = "Particle",
      particleSystem = "venomous_rod",
    },
  },
  tags = { "weapon" },
}

elem = {"fire","lightning","frozen","venomous"}
rate = {100,100,100,100}
maxp = {200,100,1000,100}
velo = {{0.05, 0.2},{0,0},{0.3,0.6},{0.1,0.3}}
etex = {
  "assets/textures/particles/torch_flame.tga",
  "assets/textures/particles/lightning01.tga",
  "assets/textures/particles/teleporter.tga",
  "assets/textures/particles/bubble.tga",
}
frat = {35,4,nil,nil}
fsiz = {64,256,nil,nil}
fcnt = {16,4,nil,nil}
life = {{0.4,0.8},{0.1,0.3},{10,10},{0.1,1}}
cola = {true,nil,nil,nil}
col0 = {{2,2,2},{1.5,1.5,1.5},{1,2,4},{1,2,1.5}}
col1 = {{1,1,1},nil,nil,nil}
col2 = {{1,0.5,0.25},nil,nil,nil}
col3 = {{1,0.3,0.1},nil,nil,nil}
fout = {0.3,0.1,9.9,0.1}
size = {{0.125,0.2},{0.125,0.5},{0.05,0.1},{0.01,0.02}}
grav = {0,0,-1,1}
ares = {1,5,1,5}
rots = {1,1,2,2}
smok = {
  "assets/textures/particles/smoke_01.tga",
  "assets/textures/particles/ice_guardian_smoke.tga",
  "assets/textures/particles/fog.tga",
  "assets/textures/particles/poison_cloud.tga",
}
smoc = {{0.25,0.25,0.25},{0.05,0.25,0.25},{0.14,0.352941,0.803922},{0.352941,0.803922,0.14}}
smog = {0,0.1,0,0.2}
smor = {1,1,3,3}
smob = {"Translucent","Additive","Additive","Additive"}
colg = {{0.9,0.4,0.2},{0.3,0.5,0.7},{0.35,0.55,0.75},{0.45,0.75,0.6}}

for e = 1,4 do
  local n = elem[e].."_rod"
  defineParticleSystem
  {
    name = n,
    emitters =
    {
      {
        emissionRate = rate[e],
        maxParticles = maxp[e],
        emissionTime = 0,
        boxMin = {0.3,0.01,-0.05},
        boxMax = {0.5,0.15, 0.05},
        sprayAngle = {0,360},
        velocity = velo[e],
        texture = etex[e],
        frameRate = frat[e],
        frameSize = fsiz[e],
        frameCount = fcnt[e],
        lifetime = life[e],
        colorAnimation = cola[e],
        color0 = col0[e],
        color1 = col1[e],
        color2 = col2[e],
        color3 = col3[e],
        opacity = 0.25,
        fadeIn = 0.1,
        fadeOut = fout[e],
        size = size[e],
        gravity = {0,grav[e],0},
        airResistance = ares[e],
        rotationSpeed = rots[e],
        blendMode = "Additive",
        clampToGroundPlane = true,
      },
      {
        emissionRate = 10,
        maxParticles = 30,
        emissionTime = 0,
        boxMin = {0.3,0,0},
        boxMax = {0.5,0,0},
        sprayAngle = {0,360},
        velocity = {0.1,0.2},
        texture = smok[e],
        lifetime = {1,3},
        color0 = smoc[e],
        opacity = 0.2,
        fadeIn = 0.1,
        fadeOut = 0.9,
        size = {0.2,0.5},
        gravity = {0,smog[e],0},
        airResistance = 0.1,
        rotationSpeed = smor[e],
        blendMode = smob[e],
      },
      {
        spawnBurst = true,
        emissionRate = 1,
        maxParticles = 1,
        emissionTime = 0,
        boxMin = {0.1,0.1,0},
        boxMax = {0.1,0.1,0},
        sprayAngle = {0,30},
        velocity = {0,0},
        texture = "assets/textures/particles/glow.tga",
        lifetime = {1000000, 1000000},
        colorAnimation = false,
        color0 = colg[e],
        opacity = 0.1,
        fadeIn = 0.1,
        fadeOut = 0.1,
        size = {1.5,1.5},
        gravity = {0,0,0},
        airResistance = 1,
        rotationSpeed = 2,
        blendMode = "Additive",
        objectSpace = true,
        depthBias = 0.5,
      }
    }
  }
end