-- enchanted items

rate = {200,100,100,100}
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

function emition(e,q)
  return {
    emissionRate = rate[e]*q,
    maxParticles = maxp[e]*q,
    emissionTime = 0,
    boxMin = {-0.3,0.01,-0.05},
    boxMax = { 0.6,0.05, 0.05},
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
    opacity = 0.25*q,
    fadeIn = 0.1,
    fadeOut = fout[e],
    size = size[e],
    gravity = {0,grav[e],0},
    airResistance = ares[e],
    rotationSpeed = rots[e],
    blendMode = "Additive",
    clampToGroundPlane = true,
  }
end

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

function smoke(e,q)
  return {
    emissionRate = 10*q,
    maxParticles = 30*q,
    emissionTime = 0,
    boxMin = {-0.3,0,0},
    boxMax = { 0.5,0,0},
    sprayAngle = {0,360},
    velocity = {0.1,0.2},
    texture = smok[e],
    lifetime = {1,3},
    color0 = smoc[e],
    opacity = 0.2*q,
    fadeIn = 0.1,
    fadeOut = 0.9,
    size = {0.2,0.5},
    gravity = {0,smog[e],0},
    airResistance = 0.1,
    rotationSpeed = smor[e],
    blendMode = smob[e],
  }
end

colg = {{0.9,0.4,0.2},{0.3,0.5,0.7},{0.35,0.55,0.75},{0.45,0.75,0.6}}

function glow(e,q)
  return {
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
    opacity = 0.1*q,
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
end

elem = {"fire","lightning","frozen","venomous"}
qual = {"_minor","","_major"}
stex = {
  "assets/textures/env/magma_dif.tga",
  "assets/textures/items/essence_orb_air_dif.tga",
  "assets/textures/items/cannon_ball_spec.tga",
  "assets/textures/items/essence_orb_earth_dif.tga",
}
iten = {{0,5},{0,15},{0,10},{0,10}}
uiql = {"Minor ","","Major "}
uiel = {"Fireblade","Lightning Blade","Frozen Blade","Venomous Blade"}
desc = {
  "A magical fire flickers on the glowing hot steel of this blade.",
  "A rolling thunder can be heard every time the blade of this sword moves through the air.",
  "Sparkling snowflakes slowly fall every time the blade of this sword moves through the air.",
  "A corrosive liquid continually seeps along the glowing steel of this blade.",
}
gfxa = {nil,nil,path.."textures/gui/items_atlas.dds",path.."textures/gui/items_atlas.dds"}
gfxi = {215,210,0,2}
gfxp = {432,431,4,4}
attp = {16,26,36}
damt = {"fire","shock","cold","poison"}
uisp = {
  {"Fireburst","Fireball","Meteor Storm"},
  {"Shock","Lightning Bolt","Thunder Storm"},
  {"Frost Burst","Frostbolt","Ice Storm"},
  {"Poison Cloud","Poison Bolt","Poison Storm"},
}
spel = {
  {"fireburst","fireball","meteor_storm"},
  {"shock","lightning_bolt","thunder_storm"},
  {"frost_burst","frostbolt","ice_storm"},
  {"poison_cloud","poison_bolt","poison_storm"},
}
cost = {15,25,35}
gfxf = {215,210,0,2}
gfxe = {216,308,1,3}

for e = 1,4 do
for q = 1,3 do
local n = elem[e].."_blade"..qual[q]
defineMaterial{
  name = n,
  diffuseMap = "assets/textures/items/long_sword_dif.tga",
  specularMap = "assets/textures/items/long_sword_spec.tga",
  doubleSided = false,
  lighting = true,
  alphaTest = false,
  blendMode = "Opaque",
  textureAddressMode = "Wrap",
  glossiness = 45,
  depthBias = 0,
  shader = "crystal",
  shadeTex = stex[e],
  crystalIntensity = iten[e][1]+q*iten[e][2],
  onUpdate = function(material, time) material:setParam("shadeTexAngle",time/8) end,
}
defineParticleSystem{name = n, emitters = {emition(e,q), smoke(e,q), glow(e,q)}}
defineObject{
  name = n,
  baseObject = "base_item",
  components = {
    {
      class = "Model",
      model = "assets/models/items/long_sword.fbx",
      material = n,
    },
    {
      class = "Item",
      uiName = uiql[q]..uiel[e],
      description = desc[e],
      gfxAtlas = gfxa[e],
      gfxIndex = gfxi[e],
      gfxIndexPowerAttack = gfxp[e],
      impactSound = "impact_blade",
      weight = 3.2,
      secondaryAction = "castspell",
      traits = { "light_weapon", "sword" },
    },
    {
      class = "MeleeAttack",
      attackPower = attp[q],
      damageType = damt[e],
      accuracy = 0,
      cooldown = 3.7,
      swipe = "vertical",
      attackSound = "swipe",
      requirements = { "light_weapons", 1 },
    },
    {
      class = "CastSpell",
      uiName = uisp[e][q],
      spell = spel[e][q],
      energyCost = cost[q],
      power = 4,
      charges = 9,
      cooldown = 5,
      fullGfxIndex = gfxf[e],
      emptyGfxIndex = gfxe[e],
      requirements = { "concentration", 1 },
    },
    {
      class = "Particle",
      particleSystem = n,
    },
  },
  tags = { "weapon" },
}
end
end

