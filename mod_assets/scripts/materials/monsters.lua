defineMaterial{
	name = "spider",
	diffuseMap = "assets/textures/monsters/spider_dif.tga",
	specularMap = "assets/textures/monsters/spider_spec.tga",
	normalMap = "assets/textures/monsters/spider_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 40,
	depthBias = 0,
}

defineMaterial{
	name = "skeleton_bow",
	diffuseMap = "assets/textures/monsters/skeleton_warrior_bow_dif.tga",
	specularMap = "assets/textures/monsters/skeleton_warrior_bow_spec.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "crowern",
	diffuseMap = "assets/textures/monsters/crowern_dif.tga",
	specularMap = "assets/textures/monsters/crowern_spec.tga",
	normalMap = "assets/textures/monsters/crowern_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 15,
	depthBias = 0,
}

defineMaterial{
	name = "cave_grab",
	diffuseMap = "assets/textures/monsters/cave_crab_dif.tga",
	specularMap = "assets/textures/monsters/cave_crab_spec.tga",
	normalMap = "assets/textures/monsters/cave_crab_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 55,
	depthBias = 0,
}

defineMaterial{
	name = "shrakk_torr",
	diffuseMap = "assets/textures/monsters/shrakk_torr_dif.tga",
	specularMap = "assets/textures/monsters/shrakk_torr_spec.tga",
	normalMap = "assets/textures/monsters/shrakk_torr_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 45,
	depthBias = 0,
}

defineMaterial{
	name = "herder",
	diffuseMap = "assets/textures/monsters/herder_dif.tga",
	specularMap = "assets/textures/monsters/herder_spec.tga",
	normalMap = "assets/textures/monsters/herder_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 40,
	depthBias = 0,
}

defineMaterial{
	name = "green_slime",
	diffuseMap = "assets/textures/monsters/green_slime_dif.tga",
	specularMap = "assets/textures/common/white.tga",
	normalMap = "assets/textures/monsters/green_slime_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,

	-- custom shader
	shader = "crystal",
	shadeTex = "assets/textures/env/green_slime_shadetex.tga",
	shadeTexAngle = 0,
	crystalIntensity = 3,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*0.2)
	end,
}

defineMaterial{
	name = "wyvern",
	diffuseMap = "assets/textures/monsters/wyvern_dif.tga",
	specularMap = "assets/textures/monsters/wyvern_spec.tga",
	normalMap = "assets/textures/monsters/wyvern_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "mummy",
	diffuseMap = "assets/textures/monsters/mummy_dif.tga",
	specularMap = "assets/textures/monsters/mummy_spec.tga",
	normalMap = "assets/textures/monsters/mummy_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "snake",
	diffuseMap = "assets/textures/monsters/snake_dif.tga",
	specularMap = "assets/textures/monsters/snake_spec.tga",
	normalMap = "assets/textures/monsters/snake_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "sand_warg",
	diffuseMap = "assets/textures/monsters/sand_warg_dif.tga",
	specularMap = "assets/textures/monsters/sand_warg_spec.tga",
	normalMap = "assets/textures/monsters/sand_warg_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "fjeld_warg",
	diffuseMap = "assets/textures/monsters/fjeld_warg_dif.tga",
	specularMap = "assets/textures/monsters/sand_warg_spec.tga",
	normalMap = "assets/textures/monsters/sand_warg_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "sand_warg_fur",
	diffuseMap = "assets/textures/monsters/sand_warg_fur_dif.tga",
	specularMap = "assets/textures/monsters/sand_warg_fur_spec.tga",
	normalMap = "assets/textures/monsters/sand_warg_fur_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "dark_acolyte",
	diffuseMap = "assets/textures/monsters/dark_acolyte_dif.tga",
	specularMap = "assets/textures/monsters/dark_acolyte_spec.tga",
	normalMap = "assets/textures/monsters/dark_acolyte_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 25,
	depthBias = 0,
}

defineMaterial{
	name = "dark_acolyte_snake",
	diffuseMap = "assets/textures/monsters/dark_acolyte_snake_dif.tga",
	specularMap = "assets/textures/monsters/snake_spec.tga",
	normalMap = "assets/textures/monsters/snake_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "rat_swarm",
	diffuseMap = "assets/textures/monsters/rat_swarm_dif.tga",
	specularMap = "assets/textures/monsters/rat_swarm_spec.tga",
	normalMap = "assets/textures/monsters/rat_swarm_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 15,
	depthBias = 0,
}

defineMaterial{
	name = "medusa",
	diffuseMap = "assets/textures/monsters/medusa_dif.tga",
	specularMap = "assets/textures/monsters/medusa_spec.tga",
	normalMap = "assets/textures/monsters/medusa_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 25,
	depthBias = 0,
}

defineMaterial{
	name = "forest_ogre",
	diffuseMap = "assets/textures/monsters/forest_ogre_dif.tga",
	specularMap = "assets/textures/monsters/forest_ogre_spec.tga",
	normalMap = "assets/textures/monsters/forest_ogre_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "forest_ogre_club",
	diffuseMap = "assets/textures/monsters/forest_ogre_club_dif.tga",
	specularMap = "assets/textures/monsters/forest_ogre_club_spec.tga",
	normalMap = "assets/textures/monsters/forest_ogre_club_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "stone_elemental",
	diffuseMap = "assets/textures/monsters/stone_elemental_dif.tga",
	specularMap = "assets/textures/monsters/stone_elemental_spec.tga",
	normalMap = "assets/textures/monsters/stone_elemental_normal.tga",
	emissiveMap = "assets/textures/monsters/stone_elemental_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "turtle",
	diffuseMap = "assets/textures/monsters/turtle_dif.tga",
	specularMap = "assets/textures/monsters/turtle_spec.tga",
	normalMap = "assets/textures/monsters/turtle_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "zarchton",
	diffuseMap = "assets/textures/monsters/zarchton_dif.tga",
	specularMap = "assets/textures/monsters/zarchton_spec.tga",
	normalMap = "assets/textures/monsters/zarchton_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "zarchton_wand",
	diffuseMap = "assets/textures/monsters/zarchton_wand_dif.tga",
	specularMap = "assets/textures/monsters/zarchton_wand_spec.tga",
	normalMap = "assets/textures/monsters/zarchton_wand_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "eyctopus",
	diffuseMap = "assets/textures/monsters/eyctopus_dif.tga",
	specularMap = "assets/textures/monsters/eyctopus_spec.tga",
	normalMap = "assets/textures/monsters/eyctopus_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "eyctopus_eye",
	diffuseMap = "assets/textures/monsters/eyctopus_dif.tga",
	specularMap = "assets/textures/monsters/eyctopus_spec.tga",
	normalMap = "assets/textures/monsters/eyctopus_normal.tga",
	emissiveMap = "assets/textures/monsters/eyctopus_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 800,
	depthBias = 0,
}

defineMaterial{
	name = "giant_mosquito",
	diffuseMap = "assets/textures/monsters/giant_mosquito_dif.tga",
	specularMap = "assets/textures/monsters/giant_mosquito_spec.tga",
	normalMap = "assets/textures/monsters/giant_mosquito_normal.tga",
	emissiveMap = "assets/textures/monsters/giant_mosquito_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "skeleton_knight",
	diffuseMap = "assets/textures/monsters/skeleton_knight_dif.tga",
	specularMap = "assets/textures/monsters/skeleton_knight_spec.tga",
	normalMap = "assets/textures/monsters/skeleton_knight_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "skeleton_knight_weapons",
	diffuseMap = "assets/textures/monsters/skeleton_knight_weapons_dif.tga",
	specularMap = "assets/textures/monsters/skeleton_knight_weapons_spec.tga",
	normalMap = "assets/textures/monsters/skeleton_knight_weapons_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "skeleton_warrior",
	diffuseMap = "assets/textures/monsters/skeleton_warrior_dif.tga",
	specularMap = "assets/textures/monsters/skeleton_warrior_spec.tga",
	normalMap = "assets/textures/monsters/skeleton_warrior_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 75,
	depthBias = 0,
}

defineMaterial{
	name = "undead",
	diffuseMap = "assets/textures/monsters/undead_dif.tga",
	specularMap = "assets/textures/monsters/undead_spec.tga",
	normalMap = "assets/textures/monsters/undead_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "twigroot",
	diffuseMap = "assets/textures/monsters/twigroot_dif.tga",
	specularMap = "assets/textures/monsters/twigroot_spec.tga",
	normalMap = "assets/textures/monsters/twigroot_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "swamp_toad",
	diffuseMap = "assets/textures/monsters/swamp_toad_dif.tga",
	--specularMap = "assets/textures/common/black.tga",
	specularMap = "assets/textures/monsters/swamp_toad_spec.tga",
	normalMap = "assets/textures/monsters/swamp_toad_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "viper_root",
	diffuseMap = "assets/textures/monsters/viper_root_dif.tga",
	--specularMap = "assets/textures/common/black.tga",
	specularMap = "assets/textures/monsters/viper_root_spec.tga",
	normalMap = "assets/textures/monsters/viper_root_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "viper_root_tentacle",
	diffuseMap = "assets/textures/env/viper_root_tentacle_dif.tga",
	specularMap = "assets/textures/env/forest_thorns_spec.tga",
	normalMap = "assets/textures/env/forest_thorns_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 10,
	depthBias = 0,
}

defineMaterial{
	name = "ice_guardian",
	diffuseMap = "assets/textures/monsters/ice_guardian_dif.tga",
	specularMap = "assets/textures/monsters/ice_guardian_spec.tga",
	normalMap = "assets/textures/monsters/ice_guardian_normal.tga",
	emissiveMap = "assets/textures/monsters/ice_guardian_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "ice_guardian_crystal",
    diffuseMap = "assets/textures/monsters/ice_guardian_dif.tga",
	specularMap = "assets/textures/monsters/ice_guardian_spec.tga",
	normalMap = "assets/textures/monsters/ice_guardian_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
	
	-- custom shader
	shader = "crystal",
	shadeTex = "assets/textures/env/healing_crystal_shadetex.tga",
	shadeTexAngle = 0,
	crystalIntensity = 3,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*0.8)
	end,
}

defineMaterial{
	name = "trickster",
	diffuseMap = "assets/textures/monsters/trickster_dif.tga",
	specularMap = "assets/textures/monsters/trickster_spec.tga",
	normalMap = "assets/textures/monsters/trickster_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 85,
	depthBias = 0,
}

defineMaterial{
	name = "crow",
	diffuseMap = "assets/textures/monsters/crow_dif.tga",
	specularMap = "assets/textures/monsters/crow_spec.tga",
	normalMap = "assets/textures/monsters/crow_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 45,
	depthBias = 0,
}

defineMaterial{
	name = "mimic",
	diffuseMap = "assets/textures/monsters/mimic_dif.tga",
	specularMap = "assets/textures/monsters/mimic_spec.tga",
	normalMap = "assets/textures/monsters/mimic_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 100,
	depthBias = 0,
}

defineMaterial{
	name = "pirate_ratling_trooper",
	diffuseMap = "assets/textures/monsters/ratling_dif.tga",
	specularMap = "assets/textures/monsters/ratling_spec.tga",
	normalMap = "assets/textures/monsters/ratling_normal.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 90,
	depthBias = 0,
}

defineMaterial{
	name = "ratling_fur",
	diffuseMap = "assets/textures/monsters/ratling_fur_dif.tga",
	specularMap = "assets/textures/monsters/ratling_fur_spec.tga",
	normalMap = "assets/textures/monsters/ratling_fur_normal.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 90,
	depthBias = 0,
}

defineMaterial{
	name = "ratling_boss",
	diffuseMap = "assets/textures/monsters/ratling_boss_dif.tga",
	specularMap = "assets/textures/monsters/ratling_boss_spec.tga",
	normalMap = "assets/textures/monsters/ratling_boss_normal.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 90,
	depthBias = 0,
}

defineMaterial{
	name = "ratling_cannon",
	diffuseMap = "assets/textures/monsters/ratling_cannon_dif.tga",
	specularMap = "assets/textures/monsters/ratling_cannon_spec.tga",
	normalMap = "assets/textures/monsters/ratling_cannon_normal.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "xeloroid",
	diffuseMap = "assets/textures/monsters/xeloroid_dif.tga",
	specularMap = "assets/textures/monsters/xeloroid_spec.tga",
	normalMap = "assets/textures/monsters/xeloroid_normal.tga",
	emissiveMap = "assets/textures/monsters/xeloroid_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 100,
	depthBias = 0,
}

defineMaterial{
	name = "small_fish",
	diffuseMap = "assets/textures/monsters/small_fish_dif.tga",
	specularMap = "assets/textures/monsters/small_fish_spec.tga",
	normalMap = "assets/textures/monsters/small_fish_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "lindworm",
	diffuseMap = "assets/textures/monsters/lindworm_dif.tga",
	specularMap = "assets/textures/monsters/lindworm_spec.tga",
	normalMap = "assets/textures/monsters/lindworm_normal.tga",
	emissiveMap = "assets/textures/monsters/lindworm_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "ice_crab",
	diffuseMap = "mod_assets/textures/monsters/ice_crab_dif.tga",
	specularMap = "mod_assets/textures/monsters/ice_crab_spec.tga",
	normalMap = "assets/textures/monsters/cave_crab_normal.tga",
	emissiveMap = "mod_assets/textures/monsters/ice_crab_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,

	-- custom shader
	-- shader = "crystal",
	-- shadeTex = "assets/textures/env/healing_crystal_shadetex.tga",
	-- shadeTexAngle = 0,
	-- crystalIntensity = 2,
	-- onUpdate = function(self, time)
	-- 	self:setParam("shadeTexAngle", time * 2.0)
	-- end,
}

defineMaterial{
	name = "lava_crab",
	diffuseMap = "mod_assets/textures/monsters/lava_crab_dif.tga",
	specularMap = "mod_assets/textures/monsters/lava_crab_spec.tga",
	normalMap = "assets/textures/monsters/stone_elemental_normal.tga",
	emissiveMap = "mod_assets/textures/monsters/lava_crab_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "burnt_twigroot",
	diffuseMap = "mod_assets/textures/monsters/burnt_twigroot_dif.tga",
	specularMap = "mod_assets/textures/monsters/burnt_twigroot_spec.tga",
	normalMap = "mod_assets/textures/monsters/burnt_twigroot_normal.tga",
	emissiveMap = "mod_assets/textures/monsters/burnt_twigroot_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "burnt_ivy",
	diffuseMap = "mod_assets/textures/monsters/burnt_ivy_dif.tga",
	specularMap = "mod_assets/textures/monsters/burnt_ivy_spec.tga",
	normalMap = "mod_assets/textures/monsters/burnt_ivy_normal.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	castShadow = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 25,
	depthBias = 0,
}

defineMaterial{
	name = "burnt_branch",
	diffuseMap = "mod_assets/textures/monsters/burnt_branch_dif.tga",
	specularMap = "mod_assets/textures/monsters/burnt_branch_spec.tga",
	normalMap = "mod_assets/textures/monsters/burnt_branch_normal.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 10,
	depthBias = 0,
}

defineMaterial{
	name = "scorched_root",
	diffuseMap = "mod_assets/textures/monsters/scorched_root_dif.tga",
	--specularMap = "assets/textures/common/black.tga",
	specularMap = "mod_assets/textures/monsters/scorched_root_spec.tga",
	normalMap = "mod_assets/textures/monsters/scorched_root_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "scorched_root_tentacle",
	diffuseMap = "mod_assets/textures/monsters/scorched_root_tentacle_dif.tga",
	specularMap = "assets/textures/env/forest_thorns_spec.tga",
	normalMap = "assets/textures/env/forest_thorns_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 10,
	depthBias = 0,
}

defineMaterial{
	name = "scorched_leaf_cluster",
	diffuseMap = "mod_assets/textures/monsters/scorched_leaf_cluster_dif.tga",
	specularMap = "assets/textures/common/black.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 10,
	depthBias = 0,
}

defineMaterial{
	name = "scorched_dig_hole",
	diffuseMap = "mod_assets/textures/monsters/scorched_dig_hole_dif.tga",
	specularMap = "assets/textures/common/black.tga",
	normalMap = "assets/textures/props/dig_hole_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	castShadow = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}
