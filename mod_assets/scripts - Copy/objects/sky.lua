defineObject{
	name = "beach_day_sky",
	components = {
		{
			class = "Model",
			model = "assets/models/env/sky.fbx",
			sortOffset = 200000,	-- force water rendering before other transparent surfaces
			renderHack = "Sky",
		},
		{
			class = "Model",
			name = "nightSky",
			model = "assets/models/env/sky.fbx",
			material = "night_sky",
			sortOffset = 199999,	-- force water rendering before other transparent surfaces
			renderHack = "Sky",
		},
		{
			class = "Model",
			name = "stars",
			model = "assets/models/env/stars.fbx",
			sortOffset = 199998,	-- stars are rendered after night sky
			renderHack = "Sky",
		},
		{
			class = "Light",
			type = "directional",
			castShadow = true,
		},
		{
			class = "Light",
			name = "ambient",
			type = "ambient",
		},
		{
			class = "Sky",
			--farClip = 1000,
			sunColor1 = vec(1 * 1.0, 1 * 0.6, 1 * 0.8) * 5.5,--day
			sunColor2 = vec(11, 7, 6) * 0.5,--dawn/dusk
			sunColor3 = vec(9, 7, 7) * 0.03,--night
			fogMode = "linear_lit",
			fogColor1 = vec(0.9, 0.7, 0.6) * 0.95,
			fogColor2 = vec(0.9, 0.6, 0.45) * 0.8,
			fogColor3 = vec(0.9, 0.7, 0.6) * 0.5,
			fogRange = {1,1},
			ambientIntensity = 3.0,
			tonemapSaturation = 1.25,
		},
		{
			class = "LensFlare",
		},
	},
	placement = "floor",
	editorIcon = 100,
	reflectionMode = "always",
}

defineObject{
	name = "forest_day_sky",
	components = {
		{
			class = "Model",
			model = "assets/models/env/sky.fbx",
			sortOffset = 200000,	-- force water rendering before other transparent surfaces
			renderHack = "Sky",
		},
		{
			class = "Model",
			name = "nightSky",
			model = "assets/models/env/sky.fbx",
			material = "night_sky",
			sortOffset = 199999,	-- force water rendering before other transparent surfaces
			renderHack = "Sky",
		},
		{
			class = "Model",
			name = "stars",
			model = "assets/models/env/stars.fbx",
			sortOffset = 199998,	-- stars are rendered after night sky
			renderHack = "Sky",
		},
		{
			class = "Light",
			type = "directional",
			castShadow = true,
		},
		{
			class = "Light",
			name = "ambient",
			type = "ambient",
		},
		{
			class = "Sky",
			--farClip = 1000,
			sunColor1 = vec(1 * 0.85, 1 * 0.9, 1 * 1.0) * 4.0,--day
			sunColor2 = vec(10, 7, 6) * 0.5,--dawn/dusk
			sunColor3 = vec(5, 5, 10) * 0.03,--night
			fogMode = "linear_lit",
			fogColor1 = vec(1.0, 1.0, 1.0) * 0.7,
			fogColor2 = vec(0.8, 0.9, 1.0)*0.8,
			fogColor3 = vec(1.0, 1.0, 1.0)*0.5,
			fogRange = {1,1},
			ambientIntensity = 1.0,
			tonemapSaturation = 0.9,
		},
		{
			class = "LensFlare",
		},
	},
	placement = "floor",
	editorIcon = 100,
	reflectionMode = "always",
}

defineObject{
	name = "bridge_sky",
	components = {
		{
			class = "Model",
			model = "assets/models/env/sky.fbx",
			sortOffset = 200000,	-- force water rendering before other transparent surfaces
			renderHack = "Sky",
		},
		{
			class = "Model",
			name = "nightSky",
			model = "assets/models/env/sky.fbx",
			material = "night_sky",
			sortOffset = 199999,	-- force water rendering before other transparent surfaces
			renderHack = "Sky",
		},
		{
			class = "Model",
			name = "stars",
			model = "assets/models/env/stars.fbx",
			sortOffset = 199998,	-- stars are rendered after night sky
			renderHack = "Sky",
		},
		{
			class = "Light",
			type = "directional",
			castShadow = true,
		},
		{
			class = "Light",
			name = "ambient",
			type = "ambient",
		},
		{
			class = "Sky",
			farClip = 11,
			sunColor1 = vec(1 * 1.0, 1 * 0.6, 1 * 0.8) * 5.0  * 0.5,--day
			sunColor2 = vec(1, 0.85, 1) * 2.5  * 0.5,--dawn/dusk
			sunColor3 = vec(0.8, 0.85, 1) * 0.2  * 0.5,--night
			fogMode = "linear_lit",
			fogColor1 = vec(0.7, 0.85, 0.9) * 0.25 * 0.5,
			fogColor2 = vec(0.7, 0.85, 0.9) * 0.2 * 0.5,
			fogColor3 = vec(0.7, 0.85, 0.9) * 0.1 * 0.5,
			fogRange = {5,11},
			ambientIntensity = 1.0,
			tonemapSaturation = 1.25,
		},
		-- {
			-- class = "LensFlare",
		-- },
	},
	placement = "floor",
	editorIcon = 100,
	reflectionMode = "always",
}

defineObject{
	name = "dungeon_sky",
	components = {
		{
			class = "Model",
		},
		{
			class = "Model",
			name = "nightSky",
			material = "night_sky",
		},
		{
			class = "Model",
			name = "stars",
		},
		{
			class = "Sky",
			-- farClip = 11,
			sunColor1 = vec(0, 0, 0),--day
			sunColor2 = vec(0, 0, 0),--dawn/dusk
			sunColor3 = vec(0, 0, 0),--night
			fogMode = "linear_lit",
			fogColor1 = vec(0.12, 0.1, 0.13),
			fogColor2 = vec(0.12, 0.1, 0.13),
			fogColor3 = vec(0.12, 0.1, 0.13),
			fogRange = {1,1},
			ambientIntensity = 1.0,
			tonemapSaturation = 0.9,
		},
		{
			class = "Light",
			type = "directional",
			castShadow = false,
			brightness = 0,
			range = 0,
		},
		{
			class = "Light",
			name = "ambient",
			type = "ambient",
			castShadow = false,
			brightness = 0,
			range = 0,
		},
	},
	placement = "floor",
	editorIcon = 100,
	reflectionMode = "always",
}

defineObject{
	name = "dungeon_sky_past",
	components = {
		{
			class = "Model",
		},
		{
			class = "Model",
			name = "nightSky",
			material = "night_sky",
		},
		{
			class = "Model",
			name = "stars",
		},
		{
			class = "Sky",
			-- farClip = 11,
			sunColor1 = vec(0, 0, 0),--day
			sunColor2 = vec(0, 0, 0),--dawn/dusk
			sunColor3 = vec(0, 0, 0),--night
			fogMode = "linear_lit",
			fogColor1 = vec(0.13, 0.11, 0.12),
			fogColor2 = vec(0.13, 0.11, 0.12),
			fogColor3 = vec(0.13, 0.11, 0.12),
			fogRange = {1,1},
			ambientIntensity = 3.0,
			tonemapSaturation = 1.25,
		},
		{
			class = "Light",
			type = "directional",
			castShadow = false,
			brightness = 0,
			range = 0,
		},
		{
			class = "Light",
			name = "ambient",
			type = "ambient",
			castShadow = false,
			brightness = 0,
			range = 0,
		},
	},
	placement = "floor",
	editorIcon = 100,
	reflectionMode = "always",
}

