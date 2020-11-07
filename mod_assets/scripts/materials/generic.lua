defineMaterial{
	name = "wood_barrel01",
	diffuseMap = "assets/textures/props/wood_barrel_dif.tga",
	specularMap = "assets/textures/props/wood_barrel_spec.tga",
	normalMap = "assets/textures/props/wood_barrel_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "lever_frame",
	diffuseMap = "assets/textures/props/dungeon_lever_dif.tga",
	specularMap = "assets/textures/props/dungeon_lever_spec.tga",
	normalMap = "assets/textures/props/dungeon_lever_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "dungeon_door_lock",
	diffuseMap = "assets/textures/props/dungeon_key_lock_dif.tga",
	specularMap = "assets/textures/props/dungeon_key_lock_spec.tga",
	normalMap = "assets/textures/props/dungeon_key_lock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "wall_keyhole",
	diffuseMap = "assets/textures/env/wall_keyhole_dif.tga",
	specularMap = "assets/textures/env/wall_keyhole_spec.tga",
	normalMap = "assets/textures/env/wall_keyhole_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 25,
	depthBias = 0,
}

defineMaterial{
	name = "swipe01",
	diffuseMap = "assets/textures/swipes/swipe01.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "Clamp",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "dungeon_torch_holder",
	diffuseMap = "assets/textures/props/dungeon_torch_holder_dif.tga",
	specularMap = "assets/textures/props/dungeon_torch_holder_spec.tga",
	normalMap = "assets/textures/props/dungeon_torch_holder_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 100,
	depthBias = 0,
}

defineMaterial{
	name = "healing_crystal",
	diffuseMap = "assets/textures/env/healing_crystal_dif.tga",
	specularMap = "assets/textures/env/healing_crystal_dif.tga",
	normalMap = "assets/textures/env/healing_crystal_normal.tga",
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
	shadeTex = "assets/textures/env/healing_crystal_shadetex.tga",
	shadeTexAngle = 0,
	crystalIntensity = 3,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*0.8)
	end,
}

defineMaterial{
	name = "dungeon_button",
	diffuseMap = "assets/textures/props/dungeon_button_dif.tga",
	specularMap = "assets/textures/props/dungeon_button_spec.tga",
	normalMap = "assets/textures/props/dungeon_button_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "circle_keyhole",
	diffuseMap = "assets/textures/props/circle_key_lock_dif.tga",
	specularMap = "assets/textures/props/circle_key_lock_spec.tga",
	normalMap = "assets/textures/props/circle_key_lock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "ornament_lock",
	diffuseMap = "assets/textures/env/ornament_lock_dif.tga",
	specularMap = "assets/textures/env/ornament_lock_spec.tga",
	normalMap = "assets/textures/env/ornament_lock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "ornament_lock_amateria",
	diffuseMap = "assets/textures/env/ornament_lock_dif.tga",
	specularMap = "assets/textures/env/ornament_lock_spec.tga",
	normalMap = "assets/textures/env/ornament_lock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 0,
	depthBias = 0,
}

defineMaterial{
	name = "white_light",
	diffuseMap = "assets/textures/common/white.tga",
	doubleSided = false,
	lighting = false,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "wall_keyhole_gear",
	diffuseMap = "assets/textures/env/wall_keyhole_gear_dif.tga",
	specularMap = "assets/textures/env/wall_keyhole_gear_spec.tga",
	normalMap = "assets/textures/env/wall_keyhole_gear_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "wall_golden_keyhole",
	diffuseMap = "assets/textures/env/wall_keyhole_golden_dif.tga",
	specularMap = "assets/textures/env/wall_keyhole_golden_spec.tga",
	normalMap = "assets/textures/env/wall_keyhole_golden_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 85,
	depthBias = 0,
}

defineMaterial{
	name = "wall_keyhole_round",
	diffuseMap = "assets/textures/env/wall_keyhole_round_dif.tga",
	specularMap = "assets/textures/env/wall_keyhole_round_spec.tga",
	normalMap = "assets/textures/env/wall_keyhole_round_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 65,
	depthBias = 0,
}

defineMaterial{
	name = "spider_eggs",
	diffuseMap = "assets/textures/props/spider_eggs_dif.tga",
	specularMap = "assets/textures/props/spider_eggs_spec.tga",
	normalMap = "assets/textures/props/spider_eggs_normal.tga",
	emissiveMap = "assets/textures/props/spider_eggs_emissive.tga",	
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "wall_ivy",
	diffuseMap = "assets/textures/props/wall_ivy_dif.tga",
	specularMap = "assets/textures/props/wall_ivy_spec.tga",
	normalMap = "assets/textures/props/wall_ivy_normal.tga",
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
	name = "dungeon_wall_dirt",
	diffuseMap = "assets/textures/props/dungeon_wall_dirt_dif.tga",
	specularMap = "assets/textures/props/dungeon_wall_dirt_spec.tga",
	normalMap = "assets/textures/props/dungeon_wall_dirt_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	castShadow = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "floor_corpse",
	diffuseMap = "assets/textures/props/floor_corpse_dif.tga",
	specularMap = "assets/textures/props/floor_corpse_spec.tga",
	normalMap = "assets/textures/props/floor_corpse_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "ice_shards",
	diffuseMap = "assets/textures/monsters/frozen_dif.tga",
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
	shadeTex = "assets/textures/env/healing_crystal_shadetex.tga",
	shadeTexAngle = 0,
	crystalIntensity = 3,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*1.3)
	end,
}

defineMaterial{
	name = "ice_puddle",
	diffuseMap = "assets/textures/effects/ice_puddle_dif.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Translucent",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "wood_pole",
	diffuseMap = "assets/textures/props/wood_block_dif.tga",
	specularMap = "assets/textures/props/wood_block_spec.tga",
	normalMap = "assets/textures/props/wood_block_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "chest_wooden",
	diffuseMap = "assets/textures/props/chest_wooden_dif.tga",
	specularMap = "assets/textures/props/chest_wooden_spec.tga",
	normalMap = "assets/textures/props/chest_wooden_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "silver_lock",
	diffuseMap = "assets/textures/env/silver_lock_dif.tga",
	specularMap = "assets/textures/env/silver_lock_spec.tga",
	normalMap = "assets/textures/env/silver_lock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 40,
	depthBias = 0,
}

defineMaterial{
	name = "demon_head",
	diffuseMap = "assets/textures/props/demon_head_dif.tga",
	specularMap = "assets/textures/props/demon_head_spec.tga",
	normalMap = "assets/textures/props/demon_head_normal.tga",
	--emissiveMap = "assets/textures/props/demon_head_emissive.tga",	
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "spell_receptor",
	diffuseMap = "assets/textures/props/spell_receptor_dif.tga",
	specularMap = "assets/textures/props/spell_receptor_spec.tga",
	normalMap = "assets/textures/props/spell_receptor_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "pushable_block",
	diffuseMap = "assets/textures/env/pushable_block_dif.tga",
	specularMap = "assets/textures/env/pushable_block_spec.tga",
	normalMap = "assets/textures/env/pushable_block_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "pushable_block_floor01",
	diffuseMap = "assets/textures/env/pushable_block_floor_dif.tga",
	specularMap = "assets/textures/env/pushable_block_floor_spec.tga",
	normalMap = "assets/textures/env/pushable_block_floor_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "pushable_block_floor_light",
	diffuseMap = "assets/textures/env/pushable_block_floor_light_dif.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "pushable_block_floor_light_red",
	diffuseMap = "assets/textures/env/pushable_block_floor_light_red_dif.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "fire_beam",
	diffuseMap = "assets/textures/effects/fire_beam.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
	onUpdate = function(self, time)
		self:setTexcoordScaleOffset(0.5, 1, time*0.05, 0)
	end,
}

defineMaterial{
	name = "magma",
	diffuseMap = "assets/textures/env/magma_dif.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 60,
	depthBias = 0,
	onUpdate = function(self, time)
		self:setTexcoordScaleOffset(0.5, 1, time*0.05, 0)
	end,
}

defineMaterial{
	name = "dig_hole",
	diffuseMap = "assets/textures/props/dig_hole_dif.tga",
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

defineMaterial{
	name = "turtle_nest",
	diffuseMap = "assets/textures/env/turtle_nest_dif.tga",
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

defineMaterial{
	name = "wood_planks_tile",
	diffuseMap = "assets/textures/env/wood_planks_tile_dif.tga",
	specularMap = "assets/textures/env/wood_planks_tile_spec.tga",
	normalMap = "assets/textures/env/wood_planks_tile_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 90,
	--glossiness = 60,
	depthBias = 0,
}

defineMaterial{
	name = "trap_rune",
	diffuseMap = "assets/textures/effects/trap_rune_dif.tga",
	doubleSided = false,
	lighting = false,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "force_field",
	diffuseMap = "assets/textures/effects/force_field_dif.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
	onUpdate = function(self, time)
		self:setTexcoordScaleOffset(0.5, 1, time*0.05, 0)
	end,
}

defineMaterial{
	name = "blue_beam",
	diffuseMap = "assets/textures/effects/blue_beam.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "WrapU_ClampV_ClampW",
	glossiness = 60,
	depthBias = 0,
	onUpdate = function(self, time)
		self:setTexcoordScaleOffset(0.5, 1, time*0.02, 0)
	end,
}

defineMaterial{
	name = "black",
	diffuseMap = "assets/textures/common/black.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 0,
	depthBias = 0,
}

defineMaterial{
	name = "breakable_object_crack",
	diffuseMap = "assets/textures/props/breakable_object_crack_dif.tga",
	specularMap = "assets/textures/common/black.tga",
	doubleSided = true,
	lighting = true,
	alphaTest = true,
	castShadow = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 0,
	depthBias = 0,
}

defineMaterial{
	name = "nexus_lock",
	diffuseMap = "assets/textures/env/nexus_lock_dif.tga",
	specularMap = "assets/textures/env/nexus_lock_spec.tga",
	normalMap = "assets/textures/env/nexus_lock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 80,
	depthBias = 0,
}

defineMaterial{
	name = "mine_lock",
	diffuseMap = "assets/textures/env/mine_lock_dif.tga",
	specularMap = "assets/textures/env/mine_lock_spec.tga",
	normalMap = "assets/textures/env/mine_lock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 40,
	depthBias = 0,
}

defineMaterial{
	name = "skull_lock",
	diffuseMap = "assets/textures/env/skull_lock_dif.tga",
	specularMap = "assets/textures/env/skull_lock_spec.tga",
	normalMap = "assets/textures/env/skull_lock_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 40,
	depthBias = 0,
}

defineMaterial{
	name = "crystal_shard_recharge",
	diffuseMap = "assets/textures/env/healing_crystal_dif.tga",
	specularMap = "assets/textures/env/healing_crystal_dif.tga",
	normalMap = "assets/textures/env/healing_crystal_normal.tga",
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
	shadeTex = "assets/textures/env/red_gem_shadetex.tga",
	shadeTexAngle = 0,
	crystalIntensity = 16,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*0.8)
	end,
}

defineMaterial{
	name = "crystal_shard_protection",
	diffuseMap = "assets/textures/env/healing_crystal_dif.tga",
	specularMap = "assets/textures/env/healing_crystal_dif.tga",
	normalMap = "assets/textures/env/healing_crystal_normal.tga",
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
	shadeTex = "assets/textures/env/green_slime_shadetex.tga",
	shadeTexAngle = 0,
	crystalIntensity = 16,
	onUpdate = function(self, time)
		self:setParam("shadeTexAngle", time*0.8)
	end,
}

defineMaterial{
	name = "balance_tile_rune",
	diffuseMap = "assets/textures/env/balance_tile_rune.tga",
	doubleSided = false,
	lighting = false,
	alphaTest = false,
	blendMode = "Modulative",
	textureAddressMode = "Wrap",
	glossiness = 0,
	depthBias = 0,
}

defineMaterial{
	name = "red_aura",
	diffuseMap = "mod_assets/textures/effects/red_aura.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Additive",
	glossiness = 60,
	depthBias = 0,
	onUpdate = function(self, time)
	end,
}

defineMaterial{
	name = "red_beam",
	diffuseMap = "mod_assets/textures/effects/red_beam.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Additive",
	-- textureAddressMode = "WrapU_ClampV_ClampW",
	glossiness = 60,
	depthBias = 0,
	onUpdate = function(self, time)
		-- self:setTexcoordScaleOffset(0.5, 1, time*0.02, 0)
	end,
}

defineMaterial{
	name = "beam",
	diffuseMap = "mod_assets/textures/effects/beam.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Additive",
	glossiness = 60,
	depthBias = 0,
	onUpdate = function(self, time)
		self:setTexcoordScaleOffset(1, 1, time*8, 0)
	end,
}

defineMaterial{
	name = "short_beam",
	diffuseMap = "mod_assets/textures/effects/short_beam.tga",
	doubleSided = true,
	lighting = false,
	alphaTest = false,
	blendMode = "Additive",
	glossiness = 60,
	depthBias = 0,
}