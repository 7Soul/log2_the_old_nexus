defineObject{
  name = "short_bow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/short_bow.fbx",
    },
    {
      class = "Item",
      uiName = "Short Bow",
      gfxIndex = 13,
      gfxIndexPowerAttack = 466,
      impactSound = "impact_blunt",
      secondaryAction = "volley",
      weight = 1.0,
      traits = { "missile_weapon" },
    },
    {
      class = "RangedAttack",
      attackPower = 12,
      cooldown = 4,
      attackSound = "swipe_bow",
      ammo = "arrow",
      onAttack = function(self, champion, slot, chainIndex) spells_functions.script.onAttackAmmo(self, champion, slot, chainIndex) end,
    },
    {
      class = "RangedAttack",
      name = "volley",
      uiName = "Volley",
      energyCost = 40,
      repeatCount = 2,
      repeatDelay = 0.2,
      requirements = { "missile_weapons", 5 },
      attackSound = "swipe_bow",
      ammo = "arrow",
      gameEffect = "Quickly shoot two arrows at once.",
      attackPower = 12,
      cooldown = 4,
      onAttack = function(self, champion, slot, chainIndex) spells_functions.script.onAttackAmmo(self, champion, slot, chainIndex) end,
    },
  },
  tags = { "weapon", "weapon_missile" },
}

defineObject{
  name = "longbow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/longbow.fbx",
    },
    {
      class = "Item",
      uiName = "Crookhorn Longbow",
      description = "A powerful bow made from the horns of a crookhorn ram.",
      gfxIndex = 165,
      gfxIndexPowerAttack = 98,
      impactSound = "impact_blunt",
      secondaryAction = "volley",
      weight = 1.6,
      traits = { "missile_weapon" },
    },
    {
      class = "RangedAttack",
      attackPower = 16,
      cooldown = 4.5,
      attackSound = "swipe_bow",
      ammo = "arrow",
      onAttack = function(self, champion, slot, chainIndex) spells_functions.script.onAttackAmmo(self, champion, slot, chainIndex) end,
    },
    {
      class = "RangedAttack",
      name = "volley",
      uiName = "Volley",
      energyCost = 40,
      repeatCount = 2,
      repeatDelay = 0.2,
      requirements = { "missile_weapons", 5 },
      attackSound = "swipe_bow",
      ammo = "arrow",
      gameEffect = "Quickly shoot two arrows at once.",
      attackPower = 16,
      cooldown = 4.5,
      onAttack = function(self, champion, slot, chainIndex) spells_functions.script.onAttackAmmo(self, champion, slot, chainIndex) end,
    },
  },
  tags = { "weapon", "weapon_missile" },
}

defineObject{
  name = "crossbow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/crossbow.fbx",
    },
    {
      class = "Item",
      uiName = "Crossbow",
      gfxIndex = 14,
      impactSound = "impact_blunt",
      weight = 1.5,
      traits = { "missile_weapon" },
    },
    {
      class = "RangedAttack",
      attackPower = 22,
      cooldown = 5.5,
      attackSound = "swipe_bow",
      ammo = "quarrel",
      onAttack = function(self, champion, slot, chainIndex) spells_functions.script.onAttackAmmo(self, champion, slot, chainIndex) end,
    },
  },
  tags = { "weapon", "weapon_missile" },
}

defineObject{
  name = "lightning_bow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/flame_arc.fbx",
    },
    {
      class = "Item",
      uiName = "Lightning Bow",
      description = "Lightning runes are carved on the limbs of this bow. They glow brightly when the bowstring is pulled taut.",
      gfxIndex = 445,
      gfxIndexPowerAttack = 446,
      impactSound = "impact_blunt",
      secondaryAction = "shockArrow",
      weight = 1.8,
      traits = { "missile_weapon" },
    },
    {
      class = "RangedAttack",
      attackPower = 19,
      cooldown = 4.5,
      attackSound = "swipe_bow",
      ammo = "arrow",
      onAttack = function(self, champion, slot, chainIndex) spells_functions.script.onAttackAmmo(self, champion, slot, chainIndex) end,
    },
    {
      class = "RangedAttack",
      name = "shockArrow",
      uiName = "Shock Arrow",
      attackPower = 30,
      accuracy = 10,
      damageType = "shock",
      cooldown = 4.5,
      attackSound = "lightning_bolt_launch",
      ammo = "arrow",
      projectileItem = "shock_arrow", -- converts shot arrows to shock arrows
      energyCost = 30,
      requirements = { "missile_weapons", 4, "air_magic", 1 },
      gameEffect = "Shoot an arrow enchanted with the energy of storms."
    },
  },
  tags = { "weapon", "weapon_missile" },
}

-- ammo ------------------------------------------------------------------------

defineObject{
  name = "arrow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/arrow.fbx",
    },
    {
      class = "Item",
      uiName = "Broadhead Arrow",
      gfxIndex = 107,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      weight = 0.1,
    },
    {
      class = "AmmoItem",
      ammoType = "arrow",
    },
  },
}

defineObject{
  name = "quarrel",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarrel.fbx",
    },
    {
      class = "Item",
      uiName = "Crossbow Quarrel",
      gfxIndex = 120,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      weight = 0.2,
    },
    {
      class = "AmmoItem",
      ammoType = "quarrel",
    },
  },
}

-- fire ------------------------------------------------------------------------

defineParticleSystem{
  name = "fire_arrow",
  emitters = {
    -- smoke
    {
      emissionRate = 10,
      emissionTime = 0,
      maxParticles = 100,
      boxMin = {0.0, 0.0, 0.0},
      boxMax = {0.0, 0.0, 0.0},
      sprayAngle = {0,360},
      velocity = {0.1,0.1},
      texture = "assets/textures/particles/smoke_01.tga",
      lifetime = {1,1},
      color0 = {0.25, 0.25, 0.25},
      opacity = 0.5,
      fadeIn = 0.1,
      fadeOut = 0.9,
      size = {0.3, 0.5},
      gravity = {0,0,0},
      airResistance = 0.1,
      rotationSpeed = 1,
      blendMode = "Translucent",
    },

    -- flames
    {
      emissionRate = 30,
      emissionTime = 0,
      maxParticles = 50,
      boxMin = { 0.0, 0.0, 0.0},
      boxMax = { 0.0, 0.0, 0.0},
      sprayAngle = {0,360},
      velocity = {0.05, 0.2},
      texture = "assets/textures/particles/torch_flame.tga",
      frameRate = 35,
      frameSize = 64,
      frameCount = 16,
      lifetime = {0.8, 0.8},
      colorAnimation = true,
      color0 = {2, 2, 2},
      color1 = {1.0, 1.0, 1.0},
      color2 = {1.0, 0.5, 0.25},
      color3 = {1.0, 0.3, 0.1},
      opacity = 0.5,
      fadeIn = 0.15,
      fadeOut = 0.3,
      size = {0.125, 0.1},
      gravity = {0,0,0},
      airResistance = 1,
      rotationSpeed = 1,
      blendMode = "Additive",
      objectSpace = true,
    },

    -- flame trail
    {
      emissionRate = 200,
      emissionTime = 0,
      maxParticles = 200,
      boxMin = { 0.0, 0.0, 0.0},
      boxMax = { 0.0, 0.0, 0.0},
      sprayAngle = {0,360},
      velocity = {0.05, 0.2},
      texture = "assets/textures/particles/torch_flame.tga",
      frameRate = 35,
      frameSize = 64,
      frameCount = 16,
      lifetime = {0.4, 0.8},
      colorAnimation = true,
      color0 = {2, 2, 2},
      color1 = {1.0, 1.0, 1.0},
      color2 = {1.0, 0.5, 0.25},
      color3 = {1.0, 0.3, 0.1},
      opacity = 0.5,
      fadeIn = 0.01,
      fadeOut = 0.3,
      size = {0.125, 0.2},
      gravity = {0,0,0},
      airResistance = 1,
      rotationSpeed = 1,
      blendMode = "Additive",
    },

    -- glow
    {
      spawnBurst = true,
      emissionRate = 1,
      emissionTime = 0,
      maxParticles = 1,
      boxMin = {0,0,-0.1},
      boxMax = {0,0,-0.1},
      sprayAngle = {0,30},
      velocity = {0,0},
      texture = "assets/textures/particles/glow.tga",
      lifetime = {1000000, 1000000},
      colorAnimation = false,
      color0 = {0.3, 0.13, 0.06},
      opacity = 0.2,
      fadeIn = 0.1,
      fadeOut = 0.1,
      size = {1.5, 1.5},
      gravity = {0,0,0},
      airResistance = 1,
      rotationSpeed = 2,
      blendMode = "Additive",
      objectSpace = true,
    }
  }
}

defineObject{
  name = "fire_arrow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/arrow.fbx",
    },
    {
      class = "Item",
      uiName = "Flaming Broadhead Arrow",
      gfxIndex = 108,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      --convertToItemOnImpact = "arrow",  -- convert to normal arrow on impact
      weight = 0.1,
    },
    {
      class = "AmmoItem",
      ammoType = "arrow",
      attackPower = 5,
    },
    {
      class = "Particle",
      offset = vec(0.5, 0, 0),
      particleSystem = "fire_arrow",
    },
  },
}

defineObject{
  name = "fire_quarrel",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarrel.fbx",
    },
    {
      class = "Item",
      uiName = "Fire Quarrel",
      gfxIndex = 121,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      weight = 0.2,
    },
    {
      class = "AmmoItem",
      ammoType = "quarrel",
      attackPower = 5,
    },
    {
      class = "Particle",
      offset = vec(0.4, 0, 0),
      particleSystem = "fire_arrow",
    },
  },
}

-- air -------------------------------------------------------------------------

defineParticleSystem{
  name = "shock_arrow",
  emitters = {
    {
      emissionRate = 15,
      emissionTime = 0,
      maxParticles = 1000,
      boxMin = { 0,0,0 },
      boxMax = { 0,0,0 },
      sprayAngle = {0,360},
      velocity = {0,0},
      objectSpace = true,
      texture = "assets/textures/particles/lightning01.tga",
      frameRate = 4,
      frameSize = 256,
      frameCount = 4,
      lifetime = {0.1,0.3},
      color0 = {1.5,1.5,1.5},
      opacity = 1,
      fadeIn = 0.1,
      fadeOut = 0.1,
      size = {0.125, 1.0},
      gravity = {0,0,0},
      airResistance = 5,
      rotationSpeed = 1,
      blendMode = "Additive",
    },

    -- core
    {
      emissionRate = 10,
      emissionTime = 0,
      maxParticles = 1000,
      boxMin = { 0,0,0 },
      boxMax = { 0,0,0 },
      sprayAngle = {0,360},
      velocity = {0,0},
      objectSpace = true,
      texture = "assets/textures/particles/lightning01.tga",
      frameRate = 4,
      frameSize = 256,
      frameCount = 4,
      lifetime = {0.1,0.3},
      color0 = {1.5,1.5,1.5},
      opacity = 1,
      fadeIn = 0.1,
      fadeOut = 0.1,
      size = {0.2, 0.7},
      gravity = {0,0,0},
      airResistance = 5,
      rotationSpeed = 1,
      blendMode = "Additive",
    },

    -- glow
    {
      spawnBurst = true,
      emissionRate = 1,
      emissionTime = 0,
      maxParticles = 1,
      boxMin = {0,0,0.0},
      boxMax = {0,0,0.0},
      sprayAngle = {0,30},
      velocity = {0,0},
      texture = "assets/textures/particles/glow.tga",
      lifetime = {1000000, 1000000},
      colorAnimation = false,
      color0 = {0.25,0.32,0.5},
      opacity = 0.3,
      fadeIn = 0.1,
      fadeOut = 0.1,
      size = {1.0, 1.0},
      gravity = {0,0,0},
      airResistance = 1,
      rotationSpeed = 2,
      blendMode = "Additive",
      objectSpace = true,
    }
  }
}

defineObject{
  name = "shock_arrow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/arrow.fbx",
    },
    {
      class = "Item",
      uiName = "Lightning Arrow",
      gfxIndex = 111,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      --convertToItemOnImpact = "arrow",  -- convert to normal arrow on impact
      weight = 0.1,
    },
    {
      class = "AmmoItem",
      ammoType = "arrow",
      attackPower = 5,
    },
    {
      class = "Particle",
      offset = vec(0.5, 0, 0),
      particleSystem = "shock_arrow",
    },
  },
}

defineObject{
  name = "shock_quarrel",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarrel.fbx",
    },
    {
      class = "Item",
      uiName = "Lightning Quarrel",
      gfxIndex = 124,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      weight = 0.2,
    },
    {
      class = "AmmoItem",
      ammoType = "quarrel",
      attackPower = 5,
    },
    {
      class = "Particle",
      offset = vec(0.4, 0, 0),
      particleSystem = "shock_arrow",
    },
  },
}

-- water -----------------------------------------------------------------------

defineParticleSystem{
  name = "frost_arrow",
  emitters = {
    -- fog
    {
      emissionRate = 10,
      emissionTime = 0,
      maxParticles = 1000,
      boxMin = {-0.25,-0.25,-0.25},
      boxMax = { 0.25, 0.25, 0.25},
      sprayAngle = {0,360},
      velocity = {0.1,0.2},
      objectSpace = true,
      texture = "assets/textures/particles/fog.tga",
      lifetime = {3,3},
      color0 = {0.14, 0.352941, 0.803922},
      opacity = 0.4,
      fadeIn = 0.2,
      fadeOut = 2.2,
      size = {0.2, 0.4},
      gravity = {0,0,0},
      airResistance = 0.1,
      rotationSpeed = 3,
      blendMode = "Additive",
    },

    -- stars
    {
      emissionRate = 100,
      emissionTime = 0,
      maxParticles = 1000,
      boxMin = {-0.1, -0.1, -0.1},
      boxMax = { 0.1,  0.1,  0.1},
      sprayAngle = {0,360},
      velocity = {1,3},
      objectSpace = false,
      texture = "assets/textures/particles/teleporter.tga",
      lifetime = {0.1,0.15},
      color0 = {4.0,4.0,4.0},
      opacity = 1,
      fadeIn = 0.1,
      fadeOut = 0.1,
      size = {0.05, 0.5},
      gravity = {0,0,0},
      airResistance = 5,
      rotationSpeed = 2,
      blendMode = "Additive",
    },

    -- glow
    {
      spawnBurst = true,
      emissionRate = 1,
      emissionTime = 0,
      maxParticles = 1,
      boxMin = {0,0,0.0},
      boxMax = {0,0,0.0},
      sprayAngle = {0,30},
      velocity = {0,0},
      texture = "assets/textures/particles/glow.tga",
      lifetime = {1000000, 1000000},
      colorAnimation = false,
      color0 = {0.45,0.75,0.75},
      opacity = 0.3,
      fadeIn = 0.1,
      fadeOut = 0.1,
      size = {0.8, 0.8},
      gravity = {0,0,0},
      airResistance = 1,
      rotationSpeed = 2,
      blendMode = "Additive",
      objectSpace = true,
    }
  }
}

defineObject{
  name = "cold_arrow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/arrow.fbx",
    },
    {
      class = "Item",
      uiName = "Frost Arrow",
      gfxIndex = 109,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      --convertToItemOnImpact = "arrow",  -- convert to normal arrow on impact
      weight = 0.1,
    },
    {
      class = "AmmoItem",
      ammoType = "arrow",
      attackPower = 5,
    },
    {
      class = "Particle",
      offset = vec(0.5, 0, 0),
      particleSystem = "frost_arrow",
    },
  },
}

defineObject{
  name = "cold_quarrel",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarrel.fbx",
    },
    {
      class = "Item",
      uiName = "Frost Quarrel",
      gfxIndex = 122,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      weight = 0.2,
    },
    {
      class = "AmmoItem",
      ammoType = "quarrel",
      attackPower = 5,
    },
    {
      class = "Particle",
      offset = vec(0.4, 0, 0),
      particleSystem = "frost_arrow",
    },
  },
}

-- earth -----------------------------------------------------------------------

defineParticleSystem{
  name = "poison_arrow",
  emitters = {
    -- fog
    {
      emissionRate = 10,
      emissionTime = 0,
      maxParticles = 1000,
      boxMin = {-0.25,-0.25,-0.25},
      boxMax = { 0.25, 0.25, 0.25},
      sprayAngle = {0,360},
      velocity = {0.1,0.2},
      objectSpace = true,
      texture = "assets/textures/particles/poison_cloud.tga",
      lifetime = {3,3},
      color0 = {0.352941, 0.803922, 0.14},
      opacity = 0.8,
      fadeIn = 0.2,
      fadeOut = 2.2,
      size = {0.2, 0.4},
      gravity = {0,0.2,0},
      airResistance = 0.1,
      rotationSpeed = 3,
      blendMode = "Additive",
    },

    -- stars
    {
      emissionRate = 100,
      emissionTime = 0,
      maxParticles = 1000,
      boxMin = {-0.1, -0.1, -0.1},
      boxMax = { 0.1,  0.1,  0.1},
      sprayAngle = {0,360},
      velocity = {0.1,0.3},
      objectSpace = false,
      texture = "assets/textures/particles/bubble.tga",
      lifetime = {0.1,1},
      color0 = {1.0,2.0,1.5},
      opacity = 1,
      fadeIn = 0.1,
      fadeOut = 0.1,
      size = {0.01, 0.02},
      gravity = {0,1,0},
      airResistance = 5,
      rotationSpeed = 2,
      blendMode = "Additive",
    },

    -- glow
    {
      spawnBurst = true,
      emissionRate = 1,
      emissionTime = 0,
      maxParticles = 1,
      boxMin = {0,0,0.0},
      boxMax = {0,0,0.0},
      sprayAngle = {0,30},
      velocity = {0,0},
      texture = "assets/textures/particles/glow.tga",
      lifetime = {1000000, 1000000},
      colorAnimation = false,
      color0 = {0.45,0.85,0.65},
      opacity = 0.3,
      fadeIn = 0.1,
      fadeOut = 0.1,
      size = {0.8, 0.8},
      gravity = {0,0,0},
      airResistance = 1,
      rotationSpeed = 2,
      blendMode = "Additive",
      objectSpace = true,
    }
  }
}

defineObject{
  name = "poison_arrow",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/arrow.fbx",
    },
    {
      class = "Item",
      uiName = "Poison Arrow",
      gfxIndex = 110,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      weight = 0.1,
    },
    {
      class = "AmmoItem",
      ammoType = "arrow",
      attackPower = 5,
    },
    {
      class = "Particle",
      offset = vec(0.5, 0, 0),
      particleSystem = "poison_arrow",
    },
  },
}

defineObject{
  name = "poison_quarrel",
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/quarrel.fbx",
    },
    {
      class = "Item",
      uiName = "Poison Quarrel",
      gfxIndex = 123,
      impactSound = "impact_arrow",
      stackable = true,
      sharpProjectile = true,
      projectileRotationY = 90,
      weight = 0.2,
    },
    {
      class = "AmmoItem",
      ammoType = "quarrel",
      attackPower = 5,
    },
    {
      class = "Particle",
      offset = vec(0.4, 0, 0),
      particleSystem = "poison_arrow",
    },
  },
}

