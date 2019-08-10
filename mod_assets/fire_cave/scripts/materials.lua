defineMaterial{
	name = "rc_lava_pure",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_lava_pure_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_lava_pure_dif.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_lava_pure_normal.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 0,
	depthBias = 0,
	onUpdate = function(self, time)
		self:setTexcoordScaleOffset(1, 1, time*-0.04, time*0.02)
	end,
}

-- defineMaterial{
-- 	name = "rc_lava_river_solid",
-- 	diffuseMap = "mod_assets/fire_cave/textures/env/rc_lava_river_dif.tga",
-- 	specularMap = "mod_assets/fire_cave/textures/env/rc_lava_river_dif.tga",
-- 	normalMap = "mod_assets/fire_cave/textures/env/rc_lava_pure_normal.tga",
-- 	doubleSided = false,
-- 	lighting = false,
-- 	alphaTest = false,
-- 	blendMode = "Opaque",
-- 	textureAddressMode = "Wrap",
-- 	glossiness = 0,
-- 	depthBias = 0,
-- 	onUpdate = function(self, time)
-- 		self:setTexcoordScaleOffset(1, 1, time*0, time*-0.03)
-- 	end,
-- }

-- defineMaterial{
-- 	name = "rc_lava_river2",
-- 	diffuseMap = "mod_assets/fire_cave/textures/env/rc_lava_river2_dif.tga",
-- 	specularMap = "mod_assets/fire_cave/textures/env/rc_lava_river2_dif.tga",
-- 	normalMap = "mod_assets/fire_cave/textures/env/rc_lava_pure_normal.tga",
-- 	doubleSided = false,
-- 	lighting = false,
-- 	alphaTest = false,
-- 	blendMode = "Opaque",
-- 	textureAddressMode = "Wrap",
-- 	glossiness = 0,
-- 	depthBias = 0,
-- 	onUpdate = function(self, time)
-- 		self:setTexcoordScaleOffset(1, 1, time*0, time*-0.5)
-- 	end,
-- }

defineMaterial{
	name = "rc_lava_rocky",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_lava_rocky_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_lava_rocky_dif.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_lava_rocky_normal.tga",
	emissiveMap = "mod_assets/fire_cave/textures/env/rc_lava_rocky_emissive.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
	onUpdate = function(self, time)
		self:setTexcoordScaleOffset(1, 1, time*-0.002, time*0.002)
	end,
}

defineMaterial{
	name = "rc_molten_rock",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_molten_rock_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_molten_rock_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_molten_rock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 70,
	depthBias = 0,
}

defineMaterial{
	name = "rc_molten_rock2",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_molten_rock2_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_molten_rock2_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_molten_rock2_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 70,
	depthBias = 0,
}

defineMaterial{
	name = "rc_grass",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_grass_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_grass_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_grass_normal.tga",
	doubleSided = true,
	lighting = true,
	castShadow = false,
	ambientOcclusion = false,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 10,
	depthBias = 0,
}

defineMaterial{
	name = "rc_clear",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_clear.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_clear.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_clear.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 0,
	depthBias = 0,
}

defineMaterial{
	name = "rc_crystal",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_crystal_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_crystal_dif.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_crystal_normal.tga",
	doubleSided = false,
	lighting = true,
	ambientOcclusion = false,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
	
	-- custom shader
	shader = "crystal",
	shadeTex = "mod_assets/fire_cave/textures/env/rc_crystal_shadetex3.tga",
	shadeTexAngle = 0,
	crystalIntensity = 3,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*0.2)
	end,
}

defineMaterial{
	name = "rc_crystal_2",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_crystal_2_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_crystal_2_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_crystal_2_normal.tga",
	emissiveMap = "mod_assets/fire_cave/textures/env/rc_crystal_2_glow.tga",
	doubleSided = false,
	lighting = true,
	ambientOcclusion = false,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 100,
	depthBias = 0,
}

defineMaterial{
	name = "rc_crystal_3",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_crystal_3_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_yellow_orange.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_crystal_3_normal.tga",
	doubleSided = false,
	lighting = true,
	ambientOcclusion = false,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 100,
	depthBias = 0,
	
	shader = "crystal",
	shadeTex = "mod_assets/fire_cave/textures/env/rc_crystal_shadetex3.tga",
	shadeTexAngle = 0,
	crystalIntensity = 4,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*0.2)
	end,
}

defineMaterial{
	name = "rc_old_key_01",
	diffuseMap = "mod_assets/fire_cave/textures/items/rc_old_key_01_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/items/rc_old_key_01_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/items/rc_old_key_01_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "rc_old_key_02",
	diffuseMap = "mod_assets/fire_cave/textures/items/rc_old_key_02_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/items/rc_old_key_02_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/items/rc_old_key_02_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "rc_old_key_03",
	diffuseMap = "mod_assets/fire_cave/textures/items/rc_old_key_03_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/items/rc_old_key_03_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/items/rc_old_key_03_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "rc_gem_rock",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_gem_rock_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_gem_rock_spec.tga",
	emissiveMap = "mod_assets/fire_cave/textures/env/rc_gem_rock_emissive.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_gem_rock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 90,
	depthBias = 0,
}

defineMaterial{
	name = "rc_metal_parts",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_metal_parts_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_metal_parts_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_metal_parts_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "rc_metal_parts2",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_metal_parts2_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_metal_parts2_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_metal_parts2_normal.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stone02",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone02_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone02_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone02_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stone_door_01",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_door_01_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_door_01_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_door_01_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

-- defineMaterial{
-- 	name = "rc_stone_door_02",
-- 	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_door_02_dif.tga",
-- 	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_door_02_spec.tga",
-- 	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_door_02_normal.tga",
-- 	doubleSided = false,
-- 	lighting = true,
-- 	alphaTest = false,
-- 	blendMode = "Opaque",
-- 	textureAddressMode = "Wrap",
-- 	glossiness = 50,
-- 	depthBias = 0,
-- }

-- defineMaterial{
-- 	name = "rc_puz_pedestal_01",
-- 	diffuseMap = "mod_assets/fire_cave/textures/env/rc_puz_pedestal_01_dif.tga",
-- 	specularMap = "mod_assets/fire_cave/textures/env/rc_puz_pedestal_01_spec.tga",
-- 	normalMap = "mod_assets/fire_cave/textures/env/rc_puz_pedestal_01_normal.tga",
-- 	doubleSided = false,
-- 	lighting = true,
-- 	alphaTest = false,
-- 	blendMode = "Opaque",
-- 	textureAddressMode = "Wrap",
-- 	glossiness = 50,
-- 	depthBias = 0,
-- }

defineMaterial{
	name = "rc_lever",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_lever_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_lever_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_lever_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

-- defineMaterial{
-- 	name = "rc_unique_lever",
-- 	diffuseMap = "mod_assets/fire_cave/textures/env/rc_unique_lever_dif.tga",
-- 	specularMap = "mod_assets/fire_cave/textures/env/rc_unique_lever_spec.tga",
-- 	normalMap = "mod_assets/fire_cave/textures/env/rc_unique_lever_normal.tga",
-- 	doubleSided = false,
-- 	lighting = true,
-- 	alphaTest = false,
-- 	blendMode = "Opaque",
-- 	textureAddressMode = "Wrap",
-- 	glossiness = 50,
-- 	depthBias = 0,
-- }

defineMaterial{
	name = "rc_stone_parts",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_parts_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_parts_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_parts_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_debris",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_debris_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_debris_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_debris_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_bricks_1",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_bricks_1_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_bricks_1_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_bricks_1_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_bricks_2",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_bricks_2_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_bricks_2_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_bricks_2_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_bricks_2",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_bricks_2_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_bricks_2_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_bricks_2_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_bricks_3",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_bricks_3_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_bricks_3_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_bricks_3_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stone_stairs",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_stairs_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_stairs_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_stairs_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stone_blocks_01",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_01_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_01_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_01_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stone_blocks_02",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_02_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_02_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_02_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stone_blocks_03",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_03_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_03_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_blocks_03_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 70,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stonewall_02",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stonewall_02_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stonewall_02_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stonewall_02_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 70,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stonepillar_02",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stonepillar_02_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stonepillar_02_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stonepillar_02_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 90,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stonepillar_02_burnt",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stonepillar_02_burnt_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stonepillar_02_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stonepillar_02_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 90,
	depthBias = 0,
}

defineMaterial{
	name = "rc_rocks",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_rocks_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_rocks_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_rocks_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 90,
	depthBias = 0,
}

defineMaterial{
	name = "rc_rock_07",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_rock_07_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_rock_07_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_rock_07_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 55,
	depthBias = 0,
}

defineMaterial{
	name = "rc_rock_main",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_rock_main_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_rock_main_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_rock_main_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 70,
	depthBias = 0,
}

defineMaterial{
	name = "rc_secret_button",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_secret_button_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_secret_button_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_secret_button_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 70,
	depthBias = 0,
}

defineMaterial{
	name = "rc_ruins_01",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_ruins_01_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_ruins_01_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_ruins_01_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 70,
	depthBias = 0,
}

defineMaterial{
	name = "rc_wood_01",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_wood_01_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_wood_01_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_wood_01_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 40,
	depthBias = 0,
}

defineMaterial{
	name = "rc_dirt_splat",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_dirt_splat_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_dirt_splat_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_dirt_splat_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 75,
	depthBias = 0,
}

defineMaterial{
	name = "rc_rock_skull",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_rock_skull_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_rock_skull_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_rock_skull_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 70,
	depthBias = 0,
}

-- defineMaterial{
-- 	name = "rc_stone_box",
-- 	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_box_dif.tga",
-- 	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_box_spec.tga",
-- 	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_box_normal.tga",
-- 	doubleSided = false,
-- 	lighting = true,
-- 	alphaTest = false,
-- 	blendMode = "Opaque",
-- 	textureAddressMode = "Wrap",
-- 	glossiness = 55,
-- 	depthBias = 0,
-- }

defineMaterial{
	name = "rc_stone_trims",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_trims_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_trims_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_trims_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 55,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stone_trims_red",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_trims_red_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_trims_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_trims_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 55,
	depthBias = 0,
}

defineMaterial{
	name = "rc_ground01",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_ground01_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_ground01_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_ground01_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 75,
	depthBias = 0,
}

defineMaterial{
	name = "rc_ground02",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_ground02_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_ground02_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_ground02_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 75,
	depthBias = 0,
}

defineMaterial{
	name = "rc_stone_tiles",
	diffuseMap = "mod_assets/fire_cave/textures/env/rc_stone_tiles_dif.tga",
	specularMap = "mod_assets/fire_cave/textures/env/rc_stone_tiles_spec.tga",
	normalMap = "mod_assets/fire_cave/textures/env/rc_stone_tiles_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 75,
	depthBias = 0,
}