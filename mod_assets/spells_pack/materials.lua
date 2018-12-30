defineMaterial{
  name = "ice_cube",

  -- Option with "The Winter Tileset" by Skuggasveinn (you can remove the 3 duplicated files in the "textures" directory of the spells pack).
  --diffuseMap  = "mod_assets/sx_winter_tileset/textures/sx_winter_ice_ground_01_dif.tga",
  --specularMap = "mod_assets/sx_winter_tileset/textures/sx_winter_ice_ground_01_spec.tga",
  --normalMap   = "mod_assets/sx_winter_tileset/textures/sx_winter_ice_ground_01_normal.tga",

  -- Option without "The Winter Tileset" by Skuggasveinn (you need the 3 duplicated files in the "textures" directory of the spells pack).
  diffuseMap  = path.."textures/sx_winter_ice_ground_01_dif.tga",
  specularMap = path.."textures/sx_winter_ice_ground_01_spec.tga",
  normalMap   = path.."textures/sx_winter_ice_ground_01_normal.tga",

  doubleSided = true,
  lighting = true,
  alphaTest = false,
  castShadow = true,
  blendMode = "Translucent",
  textureAddressMode = "Wrap",
  glossiness = 800,
  depthBias = 0,
}

defineMaterial{
  name = "detect_life",
  diffuseMap = path.."textures/particles/star.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = -200000,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/env/green_slime_shadetex.tga",
  shadeTexAngle = 0,
  crystalIntensity = 6,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.8)
  end,
}

defineMaterial{
  name = "detect_undead",
  diffuseMap = path.."textures/particles/star.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = -200000,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/env/red_gem_shadetex.tga",
  shadeTexAngle = 0,
  crystalIntensity = 6,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.8)
  end,
}

defineMaterial{
  name = "detect_elemental",
  diffuseMap = path.."textures/particles/star.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = -200000,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/items/apprentice_orb_dif.tga",
  shadeTexAngle = 0,
  crystalIntensity = 2,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.8)
  end,
}

defineMaterial{
  name = "detect_construct",
  diffuseMap = path.."textures/particles/star.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = -200000,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/effects/force_field_dif.tga",
  shadeTexAngle = 0,
  crystalIntensity = 8,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.2)
  end,
}

defineMaterial{
  name = "detect_item",
  diffuseMap = path.."textures/particles/star.tga",
  doubleSided = true,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = -200000,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/monsters/green_slime_dif.tga",
  shadeTexAngle = 0,
  crystalIntensity = 0.25,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.2)
    self:setTexcoordScaleOffset(2+math.cos(time), 2+math.sin(time), 0, 0)
  end,
}

-- trap runes

defineMaterial{
  name = "rune_off",
  diffuseMap = "assets/textures/effects/trap_rune_dif.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = 0,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/particles/glow_ring.tga",
  shadeTexAngle = 0,
  crystalIntensity = 16,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.8)
  end,
}

defineMaterial{
  name = "flashflare",
  diffuseMap = "assets/textures/effects/trap_rune_dif.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = 0,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/items/essence_orb_fire_dif.tga",
  shadeTexAngle = 0,
  crystalIntensity = 16,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.8)
  end,
}

defineMaterial{
  name = "sleep_trap",
  diffuseMap = "assets/textures/effects/trap_rune_dif.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = 0,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/effects/portal_disp.tga",
  shadeTexAngle = 0,
  crystalIntensity = 16,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.8)
  end,
}

defineMaterial{
  name = "freeze_trap",
  diffuseMap = "assets/textures/effects/trap_rune_dif.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = 0,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/items/apprentice_orb_dif.tga",
  shadeTexAngle = 0,
  crystalIntensity = 16,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.8)
  end,
}

defineMaterial{
  name = "entangling_roots_trap",
  diffuseMap = "assets/textures/effects/trap_rune_dif.tga",
  doubleSided = false,
  lighting = false,
  alphaTest = false,
  ambientOcclusion = false,
  blendMode = "Additive",
  textureAddressMode = "Clamp",
  glossiness = 20,
  depthBias = 0,

  -- custom shader
  shader = "crystal",
  shadeTex = "assets/textures/items/essence_orb_earth_dif.tga",
  shadeTexAngle = 0,
  crystalIntensity = 16,
  onUpdate = function(self, time)
    self:setParam("shadeTexAngle", time*0.8)
  end,
}
