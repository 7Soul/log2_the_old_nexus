defineMaterial{
	name = "zarchton",
	diffuseMap = "mod_assets/textures/monsters/zarchton_dif.tga",
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
	name = "amateria",
	diffuseMap = "mod_assets/textures/effects/beam.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 0,
	depthBias = 0,
	onUpdate = function(self, time)
		self:setTexcoordScaleOffset(1, 1, time*8, 0)
	end,
}