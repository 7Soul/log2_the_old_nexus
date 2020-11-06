defineObject{
	name = "skull",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/skull.fbx",
		},
		{
			class = "Item",
			uiName = "Skull",
			traits = { "skull" },
			gfxIndex = 31,
			weight = 1.0,
		}
	},
	tags = { "item_misc" }
}

defineObject{
	name = "blue_gem",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blue_gem.fbx",
		},
		{
			class = "Item",
			uiName = "Blue Gem",
			gfxIndex = 118,
			weight = 0.2,
			traits = { "gem" },
		}
	},
	tags = { "item_misc" }
}

defineObject{
	name = "green_gem",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/green_gem.fbx",
		},
		{
			class = "Item",
			uiName = "Green Gem",
			gfxIndex = 119,
			weight = 0.2,
			traits = { "gem" },
		}
	},
	tags = { "item_misc" }
}

defineObject{
	name = "red_gem",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/red_gem.fbx",
		},
		{
			class = "Item",
			uiName = "Red Gem",
			gfxIndex = 218,
			weight = 0.2,
			traits = { "gem" },
		}
	},
	tags = { "item_misc" }
}

defineObject{
	name = "compass",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/compass.fbx",
		},
		{
			class = "Item",
			uiName = "Compass",
			description = "For many old fashioned adventurers and explorers, not even a sharp sword is as important a tool as a compass.",
			gfxIndex = 161,
			weight = 0.2,
		}
	},
	tags = { "item_misc" }
}

defineObject{
	name = "cursed_compass",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/compass.fbx",
		},
		{
			class = "Item",
			uiName = "Cursed Compass",
			description = "The needle on this compass twitches nervously.",
			gfxIndex = 161,
			weight = 0.2,
		}
	},
	tags = { "item_misc" }
}

defineObject{
	name = "timepiece",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/timepiece.fbx",
		},
		{
			class = "Item",
			uiName = "Timepiece",
			gfxIndex = 453,
			weight = 0.2,
		},
		{
			class = "UsableItem",
			onUseItem = function(self)
				local t = GameMode:getTimeOfDay()
				t = math.floor((t*12+9)%24)
				if t == 0 then
					hudPrint("It is midnight.")
				elseif t < 6 then
					hudPrint("It is "..t.." hours after midnight.")
				elseif t < 12 then
					hudPrint("It is "..math.abs(t-12).." hours before noon.")
				elseif t == 12 then
					hudPrint("It is noon.")
				elseif t < 18 then
					hudPrint("It is "..(t-12).." hours after noon.")
				else
					hudPrint("It is "..math.abs(t-24).." hours before midnight.")
				end

				return false
			end,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "enchanted_timepiece",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/timepiece.fbx",
		},
		{
			class = "Item",
			uiName = "Time Device",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 13,
			weight = 0.15,
		},
		{
			class = "Particle",
			particleSystem = "enchanted_timepiece",
		},
		{
			class = "Light",
			range = 1,
			color = vec(0.7, 0.8, 2.5),
			offset = vec(0,0.2,0),
			brightness = 20,
			castShadow = false,
		},
		{
			class = "UsableItem",
			onUseItem = function(self)
				local icon = self.go.item:getGfxIndex()
				if icon == 26 then
					delayedCall("functions2", 0, "tryTimeTravel", "device")
				else
					if icon == 13 then
						hudPrint("The Time Device has no charge.")
					elseif icon > 13 and icon < 26 then
						hudPrint("The seconds are ticking down!")
					elseif icon > 26 and icon < 39 then
						hudPrint("The second hand isn't moving thanks to the crystal.")
					end
				end
				return false
			end,
		},
	},
	tags = { "item_misc" }
}

defineParticleSystem{
	name = "enchanted_timepiece",
	emitters = {
		-- stars
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 3,
			boxMin = {-0.1, -0.1, -0.1},
			boxMax = { 0.1, 0.1, 0.1},
			sprayAngle = {0,360},
			velocity = {0.0,0.05},
			objectSpace = true,
			texture = "assets/textures/particles/glitter_silver.tga",
			lifetime = {1,2},
			color0 = {0.7, 0.8, 1.0},
			opacity = 0.8,
			fadeIn = 0.2,
			fadeOut = 0.2,
			size = {0.05, 0.25},
			gravity = {0,0,0},
			airResistance = 0.2,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.1,
		},
	}
}

defineObject{
	name = "remains_of_toorum",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/remains_of_toorum.fbx",
		},
		{
			class = "Item",
			uiName = "Remains of Toorum",
			description = "Long ago decayed remains of a human. The bones have a strange aura.",
			gfxIndex = 212,
			weight = 5.0,
		},
		{
			class = "Particle",
			particleSystem = "glitter_toorum",
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "horn",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/horn.fbx",
		},
		{
			class = "Item",
			uiName = "Horn of Summoning",
			gfxIndex = 297,
			weight = 1.0,
			primaryAction = "blow",
			description = "This horn has a pungent earthy smell.",
		},
		{
			class = "ItemAction",
			name = "blow",
			uiName = "Blow Horn",
			cooldown = 4,
			onAttack = function(self)
				for e in party.map:entitiesAt(party.x, party.y) do
					if e.script and e.script.blowTheHorn then
						e.script:blowTheHorn()
					end
				end
				playSound("blow_horn")
			end,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "flute",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/flute.fbx",
		},
		{
			class = "Item",
			uiName = "Flute",
			gfxIndex = 316,
			impactSound = "impact_blunt",
			weight = 1.3,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "rope",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rope.fbx",
		},
		{
			class = "Item",
			uiName = "Rope",
			description = "A long and sturdy rope is the best ally of all daring spelunkers.",
			gfxIndex = 318,
			impactSound = "impact_blunt",
			weight = 4.3,
			primaryAction = "climb",
			traits = { "usable" },
		},
		{
			class = "RopeTool",
			name = "climb",
			uiName = "Climb Down",
			cooldown = 4.5,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "power_gem_item",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/power_gem.fbx",
			castShadow = false,
		},
		{
			class = "Particle",
			particleSystem = "power_gem_item",
			--parentNode = "power_gem",
		},
		{
			class = "Item",
			uiName = "Power Gem",
			description = "A beautiful gem that radiates light in all the colors of the spectrum.",
			gfxIndex = 207,
			weight = 0.2,
			traits = { "power_gem" },
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "power_gem",
	baseObject = "base_obstacle",
	components = {
		{
			class = "Model",
			model = "assets/models/env/power_gem.fbx",
			castShadow = false,
		},
		{
			class = "Animation",
			animations = {
				rise = "assets/animations/env/power_gem_rise.fbx",
				idle = "assets/animations/env/power_gem_idle.fbx",
			},
			playOnInit = "rise",
			onAnimationEvent = function(self, event)
				if event == "idle" then
					self:play("idle", true)
				end
			end,
		},
		{
			class = "Clickable",
			offset = vec(0.0, 1.2, 0),
			size = vec(0.25, 0.25, 0.25),
			maxDistance = 1,
			--debugDraw = true,
			onClick = function(self)
				if getMouseItem() == nil then
					local item = self.go:spawn("power_gem_item")
					setMouseItem(item.item)
					self.go:destroy()
				end
			end,
		},
		{
			class = "Particle",
			particleSystem = "power_gem",
			parentNode = "power_gem",
		},
		{
			class = "Sound",
			offset = vec(0, 1.5, 0),
			sound = "power_gem_ambient",
		},
		{
			class = "Light",
			parentNode = "power_gem",
			range = 4,
			color = vec(0.9, 0.9, 1.2),
			brightness = 10,
			castShadow = true,
			shadowMapSize = 64,
			onUpdate = function(self)
				local m = 4 -- time multiplier
				local t = Time.currentTime()* m
				
				local r = math.sin(t) * 0.5+0.5
				local g = math.sin(t + m*0.33) * 0.5+0.5
				local b = math.sin(t + m*0.66) * 0.5+0.5
				
				local saturation = 0.8
				r = r*saturation+1-saturation
				g = g*saturation+1-saturation
				b = b*saturation+1-saturation
				self:setColor(vec(r,g,b))
			end,
		},
	},
	editorIcon = 268,
	tags = { "item_misc" }
}

defineAnimationEvent{
	animation = "assets/animations/env/power_gem_rise.fbx",
	event = "idle",
	normalizedTime = 1,
}

defineObject{
	name = "essence_fire",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/essence_fire.fbx",
		},
		{
			class = "Item",
			uiName = "Essence of Fire",
			gfxIndex = 346,
			impactSound = "impact_blunt",
			weight = 0,
			traits = { "essence" },
		},
		{
			class = "Particle",
			particleSystem = "essence_fire",
		},
		{
			class = "Light",
			offset = vec(0, 0.5, 0),
			range = 1.5,
			color = vec(1, 0.5, 0.25),
			brightness = 30,
			castShadow = false,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "essence_air",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/essence_air.fbx",
		},
		{
			class = "Item",
			uiName = "Essence of Air",
			gfxIndex = 347,
			impactSound = "impact_blunt",
			weight = 0,
			traits = { "essence" },
		},
		{
			class = "Particle",
			particleSystem = "essence_air",
		},
		{
			class = "Light",
			offset = vec(0, 0.4, 0),
			range = 1.5,
			color = vec(0.5, 1, 1),
			brightness = 30,
			castShadow = false,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "essence_earth",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/essence_earth.fbx",
		},
		{
			class = "Item",
			uiName = "Essence of Earth",
			gfxIndex = 348,
			impactSound = "impact_blunt",
			weight = 0,
			traits = { "essence" },
		},
		{
			class = "Particle",
			particleSystem = "essence_earth",
		},
		{
			class = "Light",
			offset = vec(0, 0.5, 0),
			range = 1.5,
			color = vec(0.5, 1, 0.5),
			brightness = 30,
			castShadow = false,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "essence_water",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/essence_water.fbx",
		},
		{
			class = "Item",
			uiName = "Essence of Water",
			gfxIndex = 349,
			impactSound = "impact_blunt",
			weight = 0,
			traits = { "essence" },
		},
		{
			class = "Particle",
			particleSystem = "essence_water",
		},
		{
			class = "Light",
			offset = vec(0, 0.5, 0),
			range = 1.5,
			color = vec(0.25, 0.5, 1.25),
			brightness = 30,
			castShadow = false,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "essence_balance",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/essence_balance.fbx",
		},
		{
			class = "Item",
			uiName = "Essence of Balance",
			gfxIndex = 345,
			impactSound = "impact_blunt",
			weight = 0,
			traits = { "essence" },
		},
		{
			class = "Light",
			offset = vec(0, 0.3, 0),
			range = 1.5,
			color = vec(0.75, 0.2, 1),
			brightness = 30,
			castShadow = false,
		},
		{
			class = "Particle",
			particleSystem = "essence_balance",
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "lock_pick",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/lockpicks.fbx",
		},
		{
			class = "Item",
			uiName = "Lock Picks",
			stackable = true,
			gfxIndex = 356,
			weight = 0.2,
		},
		{
			class = "Particle",
			particleSystem = "glitter_silver",
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "mortar",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/mortar_pestle.fbx",
		},
		{
			class = "Item",
			uiName = "Mortar and Pestle",
			gfxIndex = 117,
			weight = 1.0,
			description = "An alchemist tool used to craft potions from herbs.",
			traits = { "usable" },
		},
		{
			class = "CraftPotion",
			requirements = { "alchemy", 1 },
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "figure_skeleton",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/figure_skeleton.fbx",
		},
		{
			class = "Item",
			uiName = "Skeleton Figurine",
			gfxIndex = 363,
			description = "This figurine is crafted out of a single piece of pale bone.",
			weight = 0.2,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "figure_snail",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/figure_snail.fbx",
		},
		{
			class = "Item",
			uiName = "Snail Figurine",
			gfxIndex = 362,
			description = "A crudely carved figurine representing a giant snail - a known delicacy in some parts of the realm.",
			weight = 0.2,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "figure_ogre",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/figure_ogre.fbx",
		},
		{
			class = "Item",
			uiName = "Ogre Figurine",
			description = "Tiny intricate tools have left their markings all over this figurine. They almost look like battle scars.",
			gfxIndex = 364,
			weight = 0.2,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "figure_crowern",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/figure_crowern.fbx",
		},
		{
			class = "Item",
			uiName = "Crowern Figurine",
			description = "Even though this figurine is somewhat primitive, the detailing of the feathers is impressive.",
			gfxIndex = 365,
			weight = 0.2,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "figure_ice_guardian",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/figure_ice_guardian.fbx",
		},
		{
			class = "Item",
			uiName = "Ice Guardian Figurine",
			description = "This figurine depicts an armor clad spirit covered in icicles.",
			gfxIndex = 434,
			weight = 0.2,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "shovel",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/shovel.fbx",	
		},
		{
			class = "Item",
			uiName = "Shovel",
			description = "This simple but reliable tool is favored by masons, farmers and treasure hunters alike.",
			gfxIndex = 404,	
			impactSound = "impact_blade",
			weight = 3,
			primaryAction = "dig",
			traits = { "usable" },
		},
		{
			class = "DiggingTool",
			name = "dig",
			uiName = "Dig",
			cooldown = 4.5,
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "meteorite",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/meteor_hammer_rock.fbx",
		},
		{
			class = "Item",
			uiName = "Meteorite",
			gfxIndex = 408,
			description = "The meteorite is still almost too hot to touch.",
			weight = 6.0,
		},
		{
			class = "Particle",
			particleSystem = "meteor_hammer",
			offset = vec(-0.3,0,0.3),
		},
	},
	tags = { "item_misc" }
}

defineObject{
	name = "magic_ruby",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/red_gem.fbx",
		},
		{
			class = "Item",
			uiName = "Ruby of Specks",
			description = "An enchanted ruby that possesses the power of the fire element.",
			gameEffect = [[Increases fire damage by 20% (+5% per 5 Strength) for 5 spell casts.
			- Magic Spark spell casts Fire for this duration.			
			- Takes 1 day to recharge.
			- This gem burns out after a few days.]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 43,
			weight = 0.1,
			traits = { "magic_gem" },
		},
		{
			class = "UsableItem",
			onUseItem = function(self, champion)
				if self.go.data:get("charges") == 24 then
					local id = champion:getOrdinal()
					local power = 1.2 + (math.floor(champion:getCurrentStat("strength") / 5) * 0.05)
					functions.script.set_c("ruby_power", id, power)
					functions.script.set_c("ruby_charges",  id, 5)
					self.go.data:set("charges", 0)
					self.go.data:set("icon", self.go.item:getGfxIndex())
					playSound("generic_spell")
					self.go.item:setGfxIndex(self.go.item:getGfxIndex() + 2)
				else
					hudPrint("The gem needs to recharge.")
				end
				return false
			end,
		},
		{
			class = "Particle",
			particleSystem = "magic_ruby",
		},	
	},
}

defineParticleSystem{
	name = "magic_ruby",
	emitters = {
		-- smoke
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,30},
			velocity = {0.1,0.5},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.15, 0.15, 0.15},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.3},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},

		-- flames
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.1, 0,  -0.1},
			boxMax = { 0.1, 0.1, 0.1},
			sprayAngle = {0,10},
			velocity = {0.1, 0.1},
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.25, 0.85},
			colorAnimation = true,
			color0 = {2, 2, 2},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.035, 0.01},
			gravity = {0,1,0},
			airResistance = 1.0,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.1,
		},
	}
}


defineObject{
	name = "magic_aquamarine",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/blue_gem.fbx",
		},
		{
			class = "Item",
			uiName = "Aquamarine of Cold",
			description = "An enchanted aquamarine that possesses the power of the ice element.",
			gameEffect = [[Increases cold damage by 20% (+5% per 5 Willpower) for 5 spell casts.
			- Magic Spark spell casts Ice for this duration.			
			- Takes 1 day to recharge.
			- This gem burns out after a few days.]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 46,
			weight = 0.1,
			traits = { "magic_gem" },
		},
		{
			class = "UsableItem",
			onUseItem = function(self, champion)
				if self.go.data:get("charges") == 24 then
					local id = champion:getOrdinal()
					local power = 1.2 + (math.floor(champion:getCurrentStat("willpower") / 5) * 0.05)
					functions.script.set_c("aquamarine_power", id, power)
					functions.script.set_c("aquamarine_charges",  id, 5)
					self.go.data:set("charges", 0)
					self.go.data:set("icon", self.go.item:getGfxIndex())
					playSound("generic_spell")
					self.go.item:setGfxIndex(self.go.item:getGfxIndex() + 2)
				else
					hudPrint("The gem needs to recharge.")
				end
				return false
			end,
		},
		{
			class = "Particle",
			particleSystem = "magic_aquamarine",
		},	
	},
}

defineParticleSystem{
	name = "magic_aquamarine",
	emitters = {
		-- smoke
		{
			emissionRate = 4,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,30},
			velocity = {0.01,0.1},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.9, 1.25, 1.5},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.3},
			gravity = {0,-0.2,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},

		-- cold
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.1, 0,  -0.1},
			boxMax = { 0.1, 0.1, 0.1},
			sprayAngle = {0,10},
			velocity = {0.1, 0.1},
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.25, 0.85},
			colorAnimation = true,
			color0 = {0.25, 1, 2},
			color1 = {0.25, 1.0, 2.0},
			color2 = {0.25, 0.5, 1.0},
			color3 = {0.1, 0.3, 1.0},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.035, 0.01},
			gravity = {0,0.5,0},
			airResistance = 1.0,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.1,
		},
	}
}

defineObject{
	name = "magic_topaz",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/green_gem.fbx",
		},
		{
			class = "Item",
			uiName = "Topaz of Sparks",
			description = "An enchanted topaz that possesses the power of the shock element.",
			gameEffect = [[Increases shock damage by 20% (+5% per 5 Dexterity) for 5 spell casts.
			- Magic Spark spell casts Shock for this duration.			
			- Takes 1 day to recharge.
			- This gem burns out after a few days.]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 49,
			weight = 0.1,
			traits = { "magic_gem" },
		},
		{
			class = "UsableItem",
			onUseItem = function(self, champion)
				if self.go.data:get("charges") == 24 then
					local id = champion:getOrdinal()
					local power = 1.2 + (math.floor(champion:getCurrentStat("dexterity") / 5) * 0.05)
					functions.script.set_c("topaz_power", id, power)
					functions.script.set_c("topaz_charges",  id, 5)
					self.go.data:set("charges", 0)
					self.go.data:set("icon", self.go.item:getGfxIndex())
					playSound("generic_spell")
					self.go.item:setGfxIndex(self.go.item:getGfxIndex() + 2)
				else
					hudPrint("The gem needs to recharge.")
				end
				return false
			end,
		},
		{
			class = "Particle",
			particleSystem = "magic_topaz",
		},	
	},
}

defineParticleSystem{
	name = "magic_topaz",
	emitters = {
		-- smoke bright
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,30},
			velocity = {0.01,0.1},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.9, 1.25, 1.5},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.3},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},
		
		-- smoke dark
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,30},
			velocity = {0.01,0.1},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.25, 0.25, 0.25},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.3},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},

		-- shock
		{
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.15, 0,  -0.15},
			boxMax = { 0.15, 0.1, 0.15},
			sprayAngle = {0,10},
			velocity = {0.1, 0.1},
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 32,
			lifetime = {0.25, 1.0},
			colorAnimation = true,
			color0 = {0.25, 2, 1},
			color1 = {0.25, 2, 1},
			color2 = {0.25, 0.5, 1},
			color3 = {0.1, 0.3, 1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.05, 0.02},
			gravity = {0,0.1,0},
			airResistance = 1.0,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.1,
		},
	}
}

defineObject{
	name = "magic_quartz",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/green_gem.fbx",
		},
		{
			class = "Item",
			uiName = "Quartz of Toxins",
			description = "An enchanted quartz that possesses the power of poison.",
			gameEffect = [[Increases poison damage by 20% (+5% per 5 Vitality) for 5 spell casts.			
			- Takes 1 day to recharge.
			- This gem burns out after a few days.]],
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 52,
			weight = 0.1,
			traits = { "magic_gem" },
		},
		{
			class = "UsableItem",
			onUseItem = function(self, champion)
				if self.go.data:get("charges") == 24 then
					local id = champion:getOrdinal()
					local power = 1.2 + (math.floor(champion:getCurrentStat("vitality") / 5) * 0.05)
					functions.script.set_c("topaz_power", id, power)
					functions.script.set_c("topaz_charges",  id, 5)
					self.go.data:set("charges", 0)
					self.go.data:set("icon", self.go.item:getGfxIndex())
					playSound("generic_spell")
					self.go.item:setGfxIndex(self.go.item:getGfxIndex() + 2)
				else
					hudPrint("The gem needs to recharge.")
				end
				return false
			end,
		},
		{
			class = "Particle",
			particleSystem = "magic_quartz",
		},
	},
}

defineParticleSystem{
	name = "magic_quartz",
	emitters = {
		-- smoke
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.1, -0.05, -0.1},
			boxMax = { 0.1, 0.1,  0.1},
			sprayAngle = {0,30},
			velocity = {0.01,0.1},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.2, 0.2, 0.2},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.4},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},
		
		-- smoke
		{
			emissionRate = 3,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.05, -0.05, -0.05},
			boxMax = { 0.05, 0.1,  0.05},
			sprayAngle = {0,30},
			velocity = {0.01,0.02},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1.75},
			color0 = {0.2, 1.25, 0.2},
			opacity = 0.75,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.1, 0.4},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.6,
			blendMode = "Translucent",
		},
	}
}

defineObject{
	name = "coal",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rock.fbx",
		},
		{
			class = "Item",
			uiName = "Lump of Coal",
			description = "This used to be an enchanted gem but now it's nothing but a useless little lump of coal.",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 42,
			weight = 0.1,
			stackable = true,
		},
	},
}

defineObject{
	name = "doubloon",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rock.fbx",
		},
		{
			class = "Item",
			uiName = "Doubloon",
			description = "A golden coin.",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 42,
			weight = 0.01,
			stackable = true,
		},
	},
}

defineObject{
	name = "cursed_doubloon",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/rock.fbx",
		},
		{
			class = "Item",
			uiName = "Cursed Doubloon",
			description = "A golden coin that attracts bad omens.",
			gfxAtlas = "mod_assets/textures/gui/items.dds",
			gfxIndex = 42,
			weight = 0.01,
			stackable = true,
		},
	},
}