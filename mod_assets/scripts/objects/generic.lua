defineObject{
	name = "party",
	components = {
		{
			class = "Party",
		},
		{
			class = "Light",
			name = "torch",
			range = 12,
		},
	},
	editorIcon = 32,
	placement = "floor",
}

defineObject{
	name = "teleporter",
	components = {
		{
			class = "Particle",
			particleSystem = "teleporter",		
		},
		{
			class = "Light",
			color = vec(69/255, 95/255, 115/255),
			brightness = 15,
			range = 8,
			castShadow = true,
			shadowMapSize = 128,
			staticShadows = true,
			staticShadowDistance = 0,	-- use static shadows always
			offset = vec(0, 1.5, 0),
			onUpdate = function(self)
				self:setBrightness((math.noise(Time.currentTime() + 12) * 0.5 + 0.5 + 0.1) * 15)
			end,
		},
		{
			class = "Sound",
			sound = "teleporter_ambient",
		},
		{
			class = "Teleporter",
		},
		{
			class = "Controller",
			onInitialActivate = function(self)
				self.go.teleporter:enable()
			end,
			onInitialDeactivate = function(self)
				self.go.teleporter:disable()
				self.go.light:fadeOut(0)
				self.go.sound:fadeOut(0)
				self.go.particle:fadeOut(0)
			end,
			onActivate = function(self)
				self.go.teleporter:enable()
				self.go.light:fadeIn(0.01)
				self.go.sound:fadeIn(0.1)
				self.go.particle:fadeIn(0.01)
			end,
			onDeactivate = function(self)
				self.go.teleporter:disable()
				self.go.light:fadeOut(0.01)
				self.go.sound:fadeOut(0.1)
				self.go.particle:fadeOut(0.01)
			end,
			onToggle = function(self)
				if self.go.teleporter:isEnabled() then
					self:deactivate()
				else
					self:activate()
				end
			end,
		},
	},
	placement = "floor",
	editorIcon = 36,
	tags = { "puzzle" }
}

defineObject{
	name = "invisible_teleporter",
	components = {
		{
			class = "Teleporter",
		},
		{
			class = "Controller",
			onInitialActivate = function(self)
				self.go.teleporter:enable()
			end,
			onInitialDeactivate = function(self)
				self.go.teleporter:disable()
			end,
			onActivate = function(self)
				self.go.teleporter:enable()
			end,
			onDeactivate = function(self)
				self.go.teleporter:disable()
			end,
			onToggle = function(self)
				if self.go.teleporter:isEnabled() then
					self:deactivate()
				else
					self:activate()
				end
			end,
		},
	},
	placement = "floor",
	editorIcon = 36,
	tags = { "puzzle" }
}

defineObject{
	name = "teleportation_effect",
	components = {
		{
			class = "Particle",
			particleSystem = "teleportation",
			destroyObject = true,
		},
		{
			class = "Light",
			color = vec(69/255, 95/255, 115/255),
			brightness = 40,
			range = 4,
			offset = vec(0, 1.2, 0),
			fadeOut = 0.5,
			disableSelf = true,
			fillLight = true,
		},
		{
			class = "Sound",
			sound = "teleport",
		},
	},
	placement = "floor",
	editorIcon = 100,
	tags = { "puzzle" }
}

defineObject{
	name = "wall_trigger",
	components = {
		{
			class = "WallTrigger",
		},
		{
			class = "ProjectileCollider",
			size = vec(2.5, 3, 0.5),
			--debugDraw = true,
		},
	},
	placement = "wall",
	editorIcon = 72,
	tags = { "puzzle" }
}

defineObject{
	name = "receptor",
	baseObject = "wall_trigger",
	components = {
		{
			class = "Model",
			model = "assets/models/env/spell_receptor.fbx",
			staticShadow = true,
		}
	},
	tags = { "puzzle" }
}

defineObject{
	name = "timer",
	components = {
		{
			class = "Timer",
		},
		{
			class = "Controller",
			onStart = function(self)
				self.go.timer:start()
			end,
			onStop = function(self)
				self.go.timer:stop()
			end,
			onPause = function(self)
				self.go.timer:pause()
			end,
		},
	},
	placement = "floor",
	tags = { "scripting" },
	editorIcon = 64,
}

defineObject{
	name = "counter",
	components = {
		{
			class = "Counter",
		},
		{
			class = "Controller",
			onIncrement = function(self)
				self.go.counter:increment()
			end,
			onDecrement = function(self)
				self.go.counter:decrement()
			end,
			onReset = function(self)
				self.go.counter:reset()
			end,
		},
	},
	placement = "floor",
	tags = { "scripting" },
	editorIcon = 68,
}

defineObject{
	name = "spawner",
	components = {
		{
			class = "Spawner",
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.spawner:activate()
			end,
		},
	},
	placement = "floor",
	tags = { "scripting" },
	editorIcon = 80,
}

defineObject{
	name = "blocker",
	components = {
		{
			class = "Obstacle",
			blockParty = true,
			blockItems = true,
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.obstacle:enable()
			end,
			onDeactivate = function(self)
				self.go.obstacle:disable()
			end,
			onToggle = function(self)
				if self.go.obstacle:isEnabled() then
					self.go.obstacle:disable()
				else
					self.go.obstacle:enable()
				end
			end,
		},
	},
	tags = { "scripting" },
	placement = "floor",
	editorIcon = 96,
}

defineObject{
	name = "invisible_wall",
	baseObject = "base_obstacle",
	editorIcon = 96,
}

defineObject{
	name = "invisible_rocky_wall",
	baseObject = "base_obstacle",
	automapTile = "rocky_wall",
	editorIcon = 96,
}

defineObject{
	name = "invisible_platform",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Platform",
		},
		{
			class = "Controller",
			onInitialActivate = function(self)
				self.go.platform:enable()
			end,
			onInitialDeactivate = function(self)
				self.go.platform:disable()
			end,
			onActivate = function(self)
				self.go.platform:enable()
			end,
			onDeactivate = function(self)
				self.go.platform:disable()
			end,
			onToggle = function(self)
				if self.go.platform:isEnabled() then
					self:deactivate()
				else
					self:activate()
				end
			end,
		},
	},
	editorIcon = 276,
}

defineObject{
	name = "particle_system",
	components = {
		{
			class = "Particle",
			particleSystem = "blob",
			destroyObject = true,
		}
	},
	placement = "floor",
	editorIcon = 100,
}

defineObject{
	name = "sound",
	components = {
		{
			class = "Sound",
			sound = "teleporter_ambient",
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.sound:enable()
			end,
			onDeactivate = function(self)
				self.go.sound:disable()
			end,
			onToggle = function(self)
				if self.go.sound:isEnabled() then
					self.go.sound:disable()
				else
					self.go.sound:enable()
				end
			end,
		},
	},
	placement = "floor",
	editorIcon = 232,
}

defineObject{
	name = "secret",
	components = {
		{
			class = "Secret",
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.secret:activate()
			end,
		},
	},
	placement = "floor",
	editorIcon = 76,
}

defineObject{
	name = "map_marker",
	components = {
		{
			class = "MapMarker",
		}
	},
	placement = "floor",
	editorIcon = 100,
	automapIcon = 144,
}

defineObject{
	name = "script_entity",
	components = {
		{
			class = "ScriptController",
			name = "controller",
		},
		{
			class = "Script",
		},		
	},
	placement = "floor",
	tags = { "scripting" },
	editorIcon = 148,
}

defineObject{
	name = "boss_fight",
	components = {
		{
			class = "BossFight",
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.bossfight:activate()
			end,
			onDeactivate = function(self)
				self.go.bossfight:deactivate()
			end,
		},
	},
	placement = "floor",
	tags = { "scripting" },
	editorIcon = 280,
}

defineObject{
	name = "wall_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_button.fbx",
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/wall_button_press.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0,1.375,0),
			size = vec(0.25, 0.25, 0.25),
			--debugDraw = true,
		},
		{
			class = "Button",
			sound = "button",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = { "puzzle" }
}

defineObject{
	name = "fence_button",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_button.fbx",
			offset = vec(0,-0.3,-0.18),
		},
		{
			class = "Model",
			name = "backface",
			model = "assets/models/env/wall_button.fbx",
			offset = vec(0,-0.3,-0.18),
			rotation = vec(0,180,0),
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/wall_button_press.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0,1.375-0.3,-0.1),
			size = vec(0.25, 0.25, 0.25),
			-- debugDraw = true,
		},
		{
			class = "Button",
			sound = "button",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = { "puzzle" }
}

defineObject{
	name = "lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lever.fbx",
			offset = vec(0, 1.375, 0),
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/lever_down.fbx",
				deactivate = "assets/animations/env/lever_up.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0,1.375,0),
			size = vec(0.4, 0.6, 0.4),
			--debugDraw = true,
		},
		{
			class = "Lever",
			sound = "lever",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = { "puzzle" }
}

defineObject{
	name = "floor_trigger",
	components = {
		{
			class = "FloorTrigger",
		},
	},
	placement = "floor",
	editorIcon = 140,
	tags = { "puzzle" }
}

defineObject{
	name = "torch_holder",
	components = {
		{
			class = "Model",
			model = "assets/models/env/torch_holder.fbx",
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0.0, 1.4, 0.0),
			size = vec(0.35, 0.6, 0.15),
			--debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(0.05, 1.53, -0.25),
			rotation = vec(0, -20, -90),
			onAcceptItem = function(self, item)
				return (item.go.name == "torch" or item.go.name == "torch_everburning") and self:count() == 0
			end,
			--debugDraw = true,
		},
		{
			class = "Particle",
			particleSystem = "torch",
			offset = vec(-0.015, 1.85, -0.4),
		},
		{
			class = "Light",
			range = 15,
			color = vec(1.3, 0.68, 0.35),
			brightness = 10,
			castShadow = true,
			staticShadows = true,
			shadowMapSize = 256,
			offset = vec(-0.015, 2.05, -0.45),
			onUpdate = function(self)
				local noise = math.noise(Time.currentTime()*3 + 123) * 0.5 + 0.9
				self:setBrightness(noise * 10)
			end,
		},
		{
			class = "Sound",
			sound = "torch_burning",
		},
		{
			class = "TorchHolderController",
			name = "controller",
		},
	},
	placement = "wall",
	editorIcon = 84,
	tags = { "puzzle" }
}

defineObject{
	name = "altar",
	baseObject = "base_altar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dungeon_altar.fbx",
			staticShadow = true,
		},
	},
	automapIcon = 152,
	tags = { "puzzle" }
}

defineObject{
	name = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.375, 0),
			size = vec(0.4, 0.4, 0.4),
			--debugDraw = true,
		},
		{
			class = "Lock",
			sound = "key_lock",
		},
	},
	placement = "wall",
	editorIcon = 20,
	tags = { "puzzle" }
}

defineObject{
	name = "lock_round",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock_round.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "lock_ornate",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock_ornament.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "lock_gold",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock_golden.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "lock_gear",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock_gear.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "lock_prison",
	baseObject = "lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lock_prison.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
	},
	tags = { "puzzle" }
}

defineObject{
	name = "daemon_head",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/demon_head.fbx",
			staticShadow = true,
		}
	},
	editorIcon = 92,
	minimalSaveState = true,
	tags = { "puzzle" }
}

defineObject{
    name = "floor_corpse",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/floor_corpse.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
    name = "floor_dirt",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/floor_dirt.fbx",
		}
	},
	minimalSaveState = true,
}

defineObject{
	name = "healing_crystal",
	components = {
		{
			class = "Model",
			model = "assets/models/env/healing_crystal.fbx",
			castShadow = false,
		},
		{
			class = "Particle",
			particleSystem = "crystal",
		},
		{
			class = "Light",
			offset = vec(0,1,0),
			color = vec(39/255, 90/255, 205/255),
			range = 7,
			shadowMapSize = 128,
			castShadow = true,
			staticShadows = true,
		},
		{
			class = "Sound",
			offset = vec(0, 1.5, 0),
			sound = "crystal_ambient",
		},
		{
			class = "Animation",
			animations = {
				spin = "assets/animations/env/healing_crystal_spin.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(0, 1.5, 0),
			size = vec(1.6, 2, 1.6),
			maxDistance = 1,
			onClick = function(self)
				for c=1,4 do
					local champion = party.party:getChampion(c)
					if champion:isArmorSetEquipped("crystal") then
						champion:addTrait("crystal_health")
						functions.script.set_c("crystal_health", champion:getOrdinal(), 50)
					end
				end
			end,
		},
		{
			class = "Obstacle",
		},
		{
			class = "ProjectileCollider",
		},
		{
			class = "Crystal",
			cooldown = 120,
		},
	},
	placement = "floor",
	editorIcon = 60,
	automapIcon = 104,
	automapIconLayer = 1,
}

defineObject{
	name = "chest",
	components = {
		{
			class = "Model",
			model = "assets/models/env/treasure_chest.fbx",
		},
		{
			class = "Model",
			name = "lock",
			model = "assets/models/env/treasure_chest_lock.fbx",
			offset = vec(0, 0.41406, 0.54883),
			enabled = false,
		},
		{
			class = "Animation",
			animations = {
				open = "assets/animations/env/treasure_chest_open.fbx",
				close = "assets/animations/env/treasure_chest_close.fbx",
			}
		},
		{
			class = "Clickable",
			offset = vec(0,0.5,0),
			size = vec(1.5, 1.0, 1.0),
			maxDistance = 1,
			--debugDraw = true,
			onClick = function(self)
				local champion = nil
				for i=1,4 do
					champion = party.party:getChampion(i)
					if champion:hasTrait("multipurpose") and self.go.chest:getLocked() then
						if champion:isAlive() and champion:getEnergy() == champion:getMaxEnergy() then
							champion:regainEnergy(champion:getEnergy() * -0.99)
							self.go.chest:setLocked(false)
							
							local stat = math.random(1,4)
							if stat == 1 then
								champion:addStatModifier("strength", 1)
								hudPrint(champion:getName() .. " gained +1 Strength.")		
							elseif stat == 2 then
								champion:addStatModifier("dexterity", 1)
								hudPrint(champion:getName() .. " gained +1 Dexterity.")
							elseif stat == 3 then
								champion:addStatModifier("vitality", 1)
								hudPrint(champion:getName() .. " gained +1 Vitality.")
							elseif stat == 4 then
								champion:addStatModifier("willpower", 1)
								hudPrint(champion:getName() .. " gained +1 Willpower.")
							end
							break
						else
							-- if tinkerer is dead and you're trying to use a lock pick, use it normally
							if getMouseItem() and getMouseItem().go.name == "lock_pick" then
								local stacksize = getMouseItem().go.item:getStackSize()
								local lock = getMouseItem()
								if stacksize > 1 then
									lock:setStackSize(stacksize - 1)
									setMouseItem(lock)
								else
									setMouseItem(nil)
								end
							end		
						end
					end
				end
			end
		},
		{
			class = "Obstacle",
			hitSound = "barrel_hit",
		},
		{
			class = "ProjectileCollider",
		},
		{
			class = "Surface",
			offset = vec(0,0.153,0),
			size = vec(1.5, 0.85),
			--debugDraw = true,
		},		
		{
			class = "Chest",
		},
	},
	placement = "floor",
	editorIcon = 216,
	automapIcon = 124,
	automapIconLayer = 1,
}

defineObject{
	name = "door_pullchain",
	components = {
		{
			class = "Model",
			model = "assets/models/env/door_pullchain.fbx",
		},
		{
			class = "Animation",
			animations = {
				pull = "assets/animations/env/door_pullchain.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(1.3, 1.3,-0.4),
			size = vec(0.3, 0.6, 0.3),
			--debugDraw = true,			
		},
		{
			class = "PullChain",
		},
	},
	placement = "wall",
	editorIcon = nil,	-- editor icon not set so that pullchains are not visible in editor
}

defineObject{
	name = "door_lever",
	components = {
		{
			class = "Model",
			model = "assets/models/env/wall_lever.fbx",
			offset = vec(1.4, 1.375, -0.23),
		},
		--{
		--	class = "Animation",
		--	animations = {
		--		activate = "assets/animations/env/lever_down.fbx",
		--		deactivate = "assets/animations/env/lever_up.fbx",
		--	}
		--},
		{
			class = "Clickable",
			offset = vec(0,1.375,0),
			size = vec(0.4, 0.6, 0.4),
			--debugDraw = true,
		},
		{
			class = "PullChain",
			--sound = "lever",
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = { "puzzle" }
}

defineObject{
	name = "floor_spike_trap",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/tomb_floor_spiketrap.fbx",
		},
		{
			class = "Animation",
			animations = {
				activate = "assets/animations/env/tomb_floor_spiketrap_hit.fbx",
			},
		},
		{
			class = "TileDamager",
			attackPower = 50,
 			damageType = "physical",	-- TODO: change to "pure"
 			screenEffect = "damage_screen",
 			cameraShake = true,
			sound = "spike_trap",
			floorTrap = true,
			enabled = false,
			onHitObstacle = function(self, obstacle)
				if obstacle.go.name == "beach_thicket_01" then return false end
			end,
			onHitMonster = function(self, monster)
				if monster.go.name == "air_elemental" then return false end
			end,
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.animation:play("activate")
				self.go.tiledamager:enable()
			end,
		},
	},
	editorIcon = 284,
	tags = { "puzzle" }
}

defineObject{
	name = "dig_hole",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/dig_hole.fbx",
			offset = vec(0,0.01,0),
		}
	},
}

defineObject{
	name = "ladder",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/ladder.fbx",
			offset = vec(0,0,-0.4),
		},
		{
			class = "Ladder",
		},
		{
			class = "Clickable",
			offset = vec(0, 1.6, -0.4),
			size = vec(0.8, 1.6, 0.4),
			frontFacing = true,
			--debugDraw = true,
		},
	},
	editorIcon = 248,
	automapIcon = 140,
	tags = { "level_design" },
}

defineObject{
	name = "ladder_broken",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/env/ladder_broken.fbx",
			offset = vec(0,0,1),
		},
	},
	editorIcon = 248,
	--automapIcon = 140,
	tags = { "level_design" },
}

defineObject{
	name = "ladder_broken_2",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/env/ladder_broken_2.fbx",
			offset = vec(0,0,-0.4),
		},
	},
	editorIcon = 248,
	automapIcon = 140,
	tags = { "level_design" },
}

defineObject{
	name = "ladder_metal",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/ladder_metal.fbx",
			offset = vec(0,0,-0.4),
			staticShadow = true,
		},
		{
			class = "Ladder",
		},
		{
			class = "Clickable",
			offset = vec(0, 1.6, -0.4),
			size = vec(0.8, 1.6, 0.4),
			frontFacing = true,
			--debugDraw = true,
		},
	},
	editorIcon = 248,
	automapIcon = 140,
	tags = { "level_design" },
}

defineObject{
	name = "ladder_metal_4m",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/ladder_metal_4m.fbx",
			offset = vec(0,0,-0.4),
			staticShadow = true,
		},
		{
			class = "Ladder",
		},
		{
			class = "Clickable",
			offset = vec(0, 1.6, -0.4),
			size = vec(0.8, 1.6, 0.4),
			frontFacing = true,
			--debugDraw = true,
		},
	},
	editorIcon = 248,
	automapIcon = 140,
	tags = { "level_design" },
}

defineObject{
	name = "pedestal",
	components = {
		{
			class = "Model",
			model = "assets/models/env/beach_pedestal.fbx",
			staticShadow = true,
			offset = vec(0, 0, -0.2),
		},
		{
			class = "Surface",
			offset = vec(0, 0.85, 0),
			size = vec(1, 0.65),
			--debugDraw = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 0.85+0.1, 0),
			size = vec(1.1, 0.2, 0.9),
			pedestal = true,
			--debugDraw = true,
		},
		{
			class = "Door",
			openVelocity = 1,
			closeVelocity = 1,
			sparse = true,
		},
		{
			class = "ItemConstrainBox",
			offset = vec(0, 0.4, 0),
			size = vec(1.1, 0.8, 0.9),
			--debugDraw = true,
		},
		{
			class = "ProjectileCollider",
			size = vec(1.1, 3, 0.75),
			--debugDraw = true,
		},
	},
	placement = "wall",
	editorIcon = 8,
	tags = { "puzzle" }
}

-- this is for a trickster puzzle where pulling on door pullchain triggers a script
defineObject{
	name = "pullchain",
	components = {
		{
			class = "Model",
			model = "assets/models/env/door_pullchain.fbx"
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/door_pullchain.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(1.3,1.2,-0.5),
			size = vec(0.25, 0.5, 0.25),
			--debugDraw = true,
		},
		{
			class = "Button",
			sound = "button",
		},
	},
	placement = "wall",
	editorIcon = 12,
}

defineObject{
	name = "ceiling_witch_lantern",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_ceiling_lantern.fbx",
			staticShadow = true,
		},
		{
			class = "Light",
			offset = vec(0, 2.90, 0),
			range = 10,
			color = vec(0.5, 0.7, 1),
			brightness = 7,
			castShadow = true,
			staticShadows = true,
			onUpdate = function(self)
				local noise = math.sin(Time.currentTime()*2 + 123) * 0.2 + 1
				self:setBrightness(noise * 6)
			end,
		},
		{
			class = "Particle",
			particleSystem = "witch_lantern",
			offset = vec(0, 2.90, 0),
		},
	},
	placement = "floor",
	editorIcon = 88,
	tags = { "level_decoration" },
}

defineObject{
	name = "k_decal",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/env/k_decal.fbx",
		},
	},
	minimalSaveState = true,
}

defineObject{
	name = "nexus_lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/nexus_lock.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
		{
			name = "stand",
			class = "Model",
			model = "assets/models/env/beach_lock_support.fbx",
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.375, 0),
			size = vec(0.4, 0.4, 0.4),
			--debugDraw = true,
		},
		{
			class = "Lock",
			sound = "key_lock",
		},
	},
	placement = "wall",
	editorIcon = 20,
}

defineObject{
	name = "mine_lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_lock.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.375, 0),
			size = vec(0.4, 0.4, 0.4),
			--debugDraw = true,
		},
		{
			class = "Lock",
			sound = "key_lock",
		},
	},
	placement = "wall",
	editorIcon = 20,
	tags = { "puzzle" }
}

defineObject{
	name = "skull_lock",
	components = {
		{
			class = "Model",
			model = "assets/models/env/skull_lock.fbx",
			offset = vec(0, 1.375, 0),
			staticShadow = true,
		},
		{
			class = "Clickable",
			offset = vec(0, 1.375, 0),
			size = vec(0.4, 0.4, 0.4),
			--debugDraw = true,
		},
		{
			class = "Lock",
			sound = "key_lock",
		},
	},
	placement = "wall",
	editorIcon = 20,
	tags = { "puzzle" }
}

-- dummy particle light for low quality rendering mode
defineObject{
	name = "dummy_light",
	components = {
		{
			class = "Particle",
			particleSystem = "dummy_light",
			offset = vec(0, 0.5, 0),
		},
		{
			class = "Controller",
			onActivate = function(self)
				self.go.particle:enable()
			end,
			onDeactivate = function(self)
				self.go.particle:disable()
			end,
			onToggle = function(self)
				if self.go.particle:isEnabled() then
					self.go.particle:disable()
				else
					self.go.particle:enable()
				end
			end,
		},
	},
	placement = "floor",
	editorIcon = 88,
}

defineObject{
	name = "crystal_area",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Particle",
			particleSystem = "crystal_area",
			offset = vec(0, 0.06, 0),
		},
		{
			class = "MapGraphics",
			image = "mod_assets/textures/automap/crystal_border.dds",
			rotate = true,
			offset0 = vec(0, 0),
			offset1 = vec(0, 0),
			offset2 = vec(0, 0),
			offset3 = vec(0, 0),
		},
	},
	editorIcon = 276,
}

defineParticleSystem{
	name = "crystal_area",
	emitters = {		
		-- Border emitter
		{
			emissionRate = 75,
			emissionTime = 0,
			maxParticles = 250,
			boxMin = {1.5, 0, 1.5},
			boxMax = {-1.5, -0.06, 1.4},
			sprayAngle = {0,2},
			velocity = {0.0,0.2},
			objectSpace = true,
			texture = "assets/textures/particles/glitter_silver.tga",
			lifetime = {1.75,2},
			color0 = {1.0, 2.0, 3.0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.8,
			size = {0.05, 0.2},
			gravity = {0,-0.25,0},
			airResistance = 0.1,
			clampToGroundPlane = true,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.2,
		},
	}
}

defineObject{
	name = "crystal_area_inside",
	baseObject = "base_floor_decoration",
	components = {
		{
			class = "Particle",
			particleSystem = "crystal_area_inside",
			offset = vec(0, 0.06, 0),
		},
		{
			class = "MapGraphics",
			image = "mod_assets/textures/automap/crystal_area.dds",
			rotate = true,
			offset0 = vec(0, 0),
			offset1 = vec(0, 0),
			offset2 = vec(0, 0),
			offset3 = vec(0, 0),
		},
	},
	editorIcon = 276,
}

defineParticleSystem{
	name = "crystal_area_inside",
	emitters = {
		-- fog
		{
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 1, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,0.4},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {3,3},
			color0 = {0.1, 0.125, 0.15},
			opacity = 0.2,
			fadeIn = 2,
			fadeOut = 2,
			size = {1, 2},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
		},

		-- stars
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-1.5, 0,-1.5},
			boxMax = { 1.5, 0.25, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,0.4},
			objectSpace = true,
			texture = "assets/textures/particles/glitter_silver.tga",
			lifetime = {1,3},
			color0 = {0.1, 0.125, 0.15},
			opacity = 1,
			fadeIn = 0.5,
			fadeOut = 0.5,
			size = {0.05, 0.15},
			gravity = {0,-0.05,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},

		-- stars floor
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-1.5, 0, -1.5},
			boxMax = { 1.5, 0.06, 1.5},
			sprayAngle = {0,30},
			velocity = {0.0,0.1},
			objectSpace = true,
			texture = "assets/textures/particles/glitter_silver.tga",
			lifetime = {1,1.5},
			color0 = {1.0*1.5, 1.1*1.5, 1.5*1.5},
			opacity = 1.0,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.05, 0.25},
			gravity = {0,-0.1,0},
			airResistance = 0.2,
			rotationSpeed = 2,
			--clampToGroundPlane = true,
			blendMode = "Additive",
			depthBias = 0.1,
		},
	}
}

defineObject{
	name = "deco_sword",
	components = {
		{
			class = "Model",
			model = "assets/models/items/long_sword.fbx",
		},
	},
	placement = "floor",
	editorIcon = 24,
	tags = { "decoration" }
}


defineObject{
	name = "dead_crystal",
	components = {
		{
			class = "Model",
			model = "assets/models/env/healing_crystal.fbx",
			castShadow = false,
			offset = vec(-0.4, -1.2, 0),
			rotation = vec(0, 45, 18),
		},
		{
			class = "Particle",
			particleSystem = "crystal",
		},
		{
			class = "Light",
			offset = vec(0,1,0),
			color = vec(39/255, 90/255, 205/255),
			range = 5,
			shadowMapSize = 128,
			castShadow = true,
			staticShadows = true,
		},
		{
			class = "Sound",
			offset = vec(0, 1.5, 0),
			sound = "crystal_ambient",
		},
		{
			class = "Obstacle",
		},
		{
			class = "ProjectileCollider",
		},
		{
			class = "Crystal",
			cooldown = math.huge,
			onInit = function(self)
				self:setCooldown(math.huge)
				self:deactivate()
			end,
		},
	},
	placement = "floor",
	editorIcon = 60,
	automapIcon = 104,
	automapIconLayer = 1,
}

defineObject{
	name = "patcher",
	components = {
		{
			class = "Light",
			onInit = function(self)
				if self.go.id == "patcher_1" then
					if self.go.x == 0 and self.go.y == 0 then
						--do stuff
						self.go.setPosition(1, self.go.y, self.go.facing, self.go.elevation, self.go.level)
					end
				end
			end
		},
	},
	minimalSaveState = true,
	placement = "floor",
	editorIcon = 136,
}

defineObject{
	name = "time_hint_floorCircle",
	components = {
		{
			class = "Particle",
			particleSystem = "floorCircle",
			emitterMesh = "assets/models/env/forest_ruins_fallen_bricks.fbx",
		},
	},
	placement = "floor",
	editorIcon = 136,
	minimalSaveState = true,
}

defineParticleSystem{
	name = "floorCircle",
	emitters = {
		-- fog
		{
			emitterShape = "MeshShape",
			emissionRate = 40,
			emissionTime = 0,
			maxParticles = 150,
			boxMin = {-1.5,-0.5,-0.15},
			boxMax = { 1.5, 0.5, 0.0},
			sprayAngle = {0,360},
			--velocity = {0.05, 0.06},
			objectSpace = false,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {1,5},
			color0 = {1.5, 0.1, 0.1},
			opacity = 0.45,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.25, 0.5},
			gravity = {0,-0.1,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.1,
			clampToGroundPlane = true,
		},
		{
			emitterShape = "MeshShape",
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 10,
			--boxMin = {-1.5,-0.5,-0.15},
			--boxMax = { 1.5, 2.5, 0.0},
			sprayAngle = {0,360},
			--velocity = {0.05, 0.06},
			objectSpace = false,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {1,4},
			color0 = {2.0, 0.5, 0.5},
			opacity = 0.9,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.25, 0.4},
			gravity = {0,0.025,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.1,
			clampToGroundPlane = true,
		},
		{
			emitterShape = "MeshShape",
			emissionRate = 5,
			emissionTime = 0,
			maxParticles = 10,
			--boxMin = {-1.5,-0.5,-0.15},
			--boxMax = { 1.5, 2.5, 0.0},
			sprayAngle = {0,360},
			velocity = {0.01, 0.05},
			objectSpace = false,
			texture = "assets/textures/particles/glow.tga",
			lifetime = {6,8},
			color0 = {1.5, 0.1, 0.1},
			opacity = 0.05,
			fadeIn = 2,
			fadeOut = 2,
			size = {1, 2},
			gravity = {0,-0.05,0},
			airResistance = 0.05,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.3,
			clampToGroundPlane = true,
		},
	}
}

defineObject{
	name = "wall_button_new",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/env/wall_button_centered.fbx",
			offset = vec(0,0,0),
			debugDraw = true,
		},
		{
			class = "Animation",
			animations = {
				press = "assets/animations/env/wall_button_press.fbx",
			},
			onAnimationEvent = function(self, event)
				self.go.model:setOffset(vec(0,-1.375,0))
			end,
		},
		{
			class = "Clickable",
			offset = vec(0,0,0),
			size = vec(0.25, 0.25, 0.25),
			debugDraw = true,
			onInit = function(self)
				-- self.go:setWorldPositionY(1.375)
			end,
			onClick = function(self)
				-- local posx = self.go.data:get("posx") or 0
				-- local posy = self.go.data:get("posy") or 0
				-- local posz = self.go.data:get("posz") or 0

				local rot = self.go.data:get("rot") or 0
				rot = (rot + 1) % 8
				-- self.go:setWorldPosition(vec(posx , posy + (math.cos(rot) * -0.6875), posz + (math.sin(rot) * -0.6875) ))
				-- self.go.clickable:setOffset(vec(0, 0, (math.cos(rot) * 1.5) ))
				self.go.model:setOffset(vec(0,-1.375,0))
				print(self.go.model:getOffset())
				self.go.model:setRotationAngles(0, 0, rot * 45)
				-- print(rot * 45)
				self.go.data:set("rot", rot)
			end
		},
		{
			class = "Button",
			sound = "button",
		},
		{
			class = "Script",
			name = "data",
			source = [[data = {}
function get(self,name) return self.data[name] end
function set(self,name,value) self.data[name] = value end]],
			onInit = function(self)
				local pos = self.go:getWorldPosition()				
				self.go.data:set("posx", pos.x)
				self.go.data:set("posy", pos.y)
				self.go.data:set("posz", pos.z)
			end,
		},
	},
	placement = "wall",
	editorIcon = 12,
	tags = { "puzzle" }
}

defineObject{
	name = "wall_invis_no_icon",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Door",
		},
	},
	automapIcon = -1,
	minimalSaveState = true,
	tags = { "base" },
}

defineObject{
	name = "bridge_pillar_sound",
	baseObject = "base_pillar",
	components = {
		{
			class = "Model",
			model = "assets/models/env/mine_support_pillar_01.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
		},
		{
			class = "Model",
			name = "pillar2",
			model = "assets/models/env/mine_support_pillar_01.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
			offset = vec(0,-3,0),
		},
		{
			class = "Model",
			name = "pillar3",
			model = "assets/models/env/mine_support_pillar_01.fbx",
			dissolveStart = 2,
			dissolveEnd = 4,
			staticShadow = true,
			offset = vec(0,-6,0),
		},
		{
			class = "Controller",
			onInitialActivate = function(self)
				for i = 1,3 do
					local light = self.go:getComponent("light_"..i)
					if light then light:setBrightness(50) end
				end
				self.go.particle:enable()
			end,
			onInitialDeactivate = function(self)
				for i = 1,3 do
					local light = self.go:getComponent("light_"..i)
					if light then light:setBrightness(0) end
				end
				self.go.particle:disable()
			end,
			onActivate = function(self)
				for i = 1,3 do
					local light = self.go:getComponent("light_"..i)
					if light then light:setBrightness(50) end
				end
			end,
			onDeactivate = function(self)
				for i = 1,3 do
					local light = self.go:getComponent("light_"..i)
					if light then light:setBrightness(0) end
				end
			end,
			onToggle = function(self)
				if self.go.light_1:getBrightness() ~= 0 then
					self:deactivate()
				else
					if self.go.light_1:getBrightness() == 50 then
						self:activate()
					end
				end
			end,
		},
		{
			class = "Counter",
			name = "counter",
		},
		{
			class = "Particle",
			particleSystem = "bridge_pillar_sound",
			offset = vec(0,3.2,0)
		},

		{
			class = "Script",
			name = "data",
			source = [[data = { ["index"] = 0, ["angle1"] = 0, ["angle2"] = nil, ["angle3"] = nil, ["targets"] = { 0, 5 }, ["has_energy"] = false }
function get(self,name) return data[name] end
function set(self,name,value) data[name] = value end]],
            onInit = function(self)
				self.go.data:set("posStart", self.go:getWorldPosition() + vec(0,0.5,0))
				self.go:setPosition(self.go.x, self.go.y, 0, self.go.elevation, self.go.level)

				for i=1,3 do
					if self:get("angle"..i) ~= nil then
						local plate = self.go:createComponent("Model", "metal_plate_"..i)
						plate:setModel("mod_assets/models/env/light_plate.fbx")

						local angle = math.rad(self:get("angle"..i))
						plate:setOffset(vec(math.cos(angle) * 0.05, (i/3*1.25) + 1.5, math.sin(angle) * 0.05))
						plate:setRotationAngles(0,math.deg(angle),0)

						local light = self.go:createComponent("Light", "light_"..i)
						light:setRange(0.5)
						light:setColor(vec(0.5, 0.7, 1))
						light:setCastShadow(true)
						light:setStaticShadows(true)
						light:setOffset(vec(math.cos(angle) * 0.35, (i/3*1.25) + 1.4, math.sin(angle) * 0.35))
						light:setBrightness(0)
						self.go.data:set("plate_angle_"..i, angle)
						self.go.data:set("plate_pos_"..i, plate:getOffset())
					end
				end
			end,
		},
	},
}

defineParticleSystem{
	name = "bridge_pillar_sound",
	emitters = {
		-- glow
		{
			emissionRate = 7,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = {0.1, 0.1, 0.1},
			sprayAngle = {0,360},
			velocity = {0.1,0.2},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.4,0.8},
			color0 = {0.7, 0.8, 1.0},
			opacity = 0.7,
			fadeIn = 0.05,
			fadeOut = 0.2,
			size = {1.0, 1.0},
			gravity = {0,0.5,0},
			airResistance = 0.2,
			rotationSpeed = 0.3,
			blendMode = "Additive",
			depthBias = 0.5,
		},
		-- stars
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.1, 0.1, -0.1},
			boxMax = {0.1, 0.1, 0.1},
			sprayAngle = {0,360},
			velocity = {0.1,0.3},
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {1.8,2},
			color0 = {1.5,1.6,1.7},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 1.0,
			size = {0.1, 0.3},
			gravity = {0,0.3,0},
			airResistance = 0.8,
			rotationSpeed = 2,
			blendMode = "Additive",
			depthBias = 0.5,
		},
	}
}


defineObject{
	name = "bridge_receptacle",
	baseObject = "base_wall_decoration",
	components = {
		{
			class = "Model",
			model = "assets/models/items/acolyte_staff.fbx",
			staticShadow = true,
			offset = vec(0,0.4,0),
			rotation = vec(152,12,274),
			onInit = function(self)
				local scale = 1.5
				local m = self.go:getWorldRotation()
				m.x = m.x * scale
				m.y = m.y * scale
				m.z = m.z * scale
				m.w = m.w * scale
				self.go:setWorldRotation(m)
			end,
		},
		-- {
		-- 	class = "Model",
		-- 	name = "model2",
		-- 	model = "assets/models/items/acolyte_staff.fbx",
		-- 	staticShadow = true,
		-- 	offset = vec(0,0.4,0),
		-- 	-- rotation = vec(152,12,174)
		-- },
		{
			class = "Clickable",
			offset = vec(0.075, 1.2, 0.10),
			size = vec(0.3, 0.4, 0.1),
			-- debugDraw = true,
		},
		{
			class = "Socket",
			offset = vec(0.06, 1.19, -0.03),
			rotation = vec(0, 0, 0),
			onAcceptItem = function(self, item)
				if item.go.name ~= "crystal_shard_healing" then
					hudPrint("The item does not fit well into the statue's hands.")
					return false
				else
					playSound("key_lock")
					return true
				end
			end,
			-- debugDraw = true,
		},
		{
			class = "ItemConstrainBox",
			offset = vec(0, 1.5, 0),
			size = vec(0.9, 2, 0.9),
			-- debugDraw = true,
		},
		{
			class = "ProjectileCollider",
			size = vec(1.1, 2, 0.8),
			-- debugDraw = true,
		},
	},
}


defineObject{
	name = "beam",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/effects/beam.fbx",
			-- debugDraw = true,
		},
		{
			class = "Light",
			offset = vec(0, 0.05, 0),
			range = 7,
			color = vec(0.25, 0.4, 1.0),
			brightness = 20,
			castShadow = true,
            fillLight = true,
            onInit = function(self)
				
            end,
            onUpdate = function(self)
				if self.go.data then
				local index = self.go.data:get("index")
				local posStart = self.go.data:get("posStart")
				local angle = self.go.data:get("angle")
				local angle2 = self.go.data:get("angle2")

				local dir = vec(math.sin(math.rad(angle)), 0, math.cos(math.rad(angle)))
				self.go:setWorldPosition( posStart + (dir * index * 3) + (dir * 1.5) )
				self.go:setWorldRotationAngles(0, angle*-1, 0)
				end
            end,
        },
        {
			class = "Script",
			name = "data",
			source = [[data = { ["angle"] = 0, ["angle2"] = 0, ["index"] = 0 }
function get(self,name) return self.data[name] end
function set(self,name,value) self.data[name] = value end]],
            onInit = function(self)
				self.go.data:set("posStart", self.go:getWorldPosition() + vec(0,0.5,0))
				self.go.data:set("angle2", 0)
			end,
		},
		{
			class = "Sound",
			sound = "monster_cast",
		},
		{
			class = "Counter",
			name = "angle",
		},
	},
	placement = "floor",
	editorIcon = 272,
	tags = { "obstacle" },
}


defineObject{
	name = "short_beam",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/effects/short_beam.fbx",
			-- debugDraw = true,
		},
		{
			class = "Light",
			range = 7,
			color = vec(0.25, 0.4, 1.0),
			brightness = 20,
			castShadow = true,
            fillLight = true,
            onInit = function(self)
				
            end,
            onUpdate = function(self)
				if self.go.data then
				local posStart = self.go.data:get("posStart")
				local angle = self.go.data:get("angle")

				local dir = vec(math.sin(math.rad(angle)), 0, math.cos(math.rad(angle)))
				self.go:setWorldPosition( posStart )
				self.go:setWorldRotationAngles(0, -angle, 0)
				end
            end,
        },
        {
			class = "Script",
			name = "data",
			source = [[data = {  }
function get(self,name) return self.data[name] end
function set(self,name,value) self.data[name] = value end]],
            onInit = function(self)
				
			end,
		},
		{
			class = "Sound",
			sound = "monster_cast",
		},
		{
			class = "Counter",
			name = "angle",
		},
	},
	placement = "floor",
	editorIcon = 272,
	tags = { "obstacle" },
}


defineObject{
	name = "time_crystal",
	components = {
		{
			class = "Model",
			model = "assets/models/env/healing_crystal.fbx",
			castShadow = false,
		},
		{
			class = "Particle",
			particleSystem = "crystal",
		},
		{
			class = "Light",
			offset = vec(0,1,0),
			color = vec(39/255, 205/255, 90/255),
			range = 7,
			shadowMapSize = 128,
			castShadow = true,
			staticShadows = true,
		},
		{
			class = "Sound",
			offset = vec(0, 1.5, 0),
			sound = "crystal_ambient",
		},
		{
			class = "Animation",
			animations = {
				spin = "assets/animations/env/healing_crystal_spin.fbx",
			},
		},
		{
			class = "Clickable",
			offset = vec(0, 1.5, 0),
			size = vec(1.6, 2, 1.6),
			maxDistance = 1,
			onClick = function(self)
				functions2.script.setSkyMode("travel_back")
				playSound("time_1")
			end,
		},
		{
			class = "Obstacle",
		},
		{
			class = "ProjectileCollider",
		},
		-- {
		-- 	class = "Crystal",
		-- 	cooldown = 120,
		-- },
	},
	placement = "floor",
	editorIcon = 60,
	automapIcon = 104,
	automapIconLayer = 1,
}

-- defineObject{
-- 	name = "beam",
-- 	components = {
-- 		{
-- 			class = "Script",
-- 			name = "data",
-- 			source = [[data = { ["angle"] = 45, ["angle2"] = 0, ["index"] = 0 }
-- function get(self,name) return self.data[name] end
-- function set(self,name,value) self.data[name] = value end]],
-- 			onInit = function(self)
-- 				self.go.data:set("m", self.go:getWorldRotation())
-- 				self.go.data:set("posStart", self.go:getWorldPosition() + vec(0,0.5,0))
-- 				self.go.data:set("angle2", 0)
-- 			end,
-- 		},
-- 		{
-- 			class = "Model",
-- 			model = "mod_assets/models/effects/beam.fbx",
-- 			offset = vec(0, 0, 0),
-- 		},
-- 		{
-- 			class = "Light",
-- 			offset = vec(0, 0.05, 0),
-- 			range = 6,
-- 			color = vec(1.0, 0.25, 0.1),
-- 			brightness = 10,
-- 			castShadow = false,
--             fillLight = true,
--             onInit = function(self)
-- 				-- if self.go.data then
-- 				-- 	local index = self.go.data:get("index")
-- 				-- 	local r = math.rad(self.go.data:get("angle"))
-- 				-- 	local r2 = math.rad(self.go.data:get("angle2"))
					
-- 				-- 	local m = self.go.data:get("m")
	
-- 				-- 	local mx = { m.x[1], m.x[2], m.x[3], m.x[4] }
-- 				-- 	local my = { m.y[1], m.y[2], m.y[3], m.y[4] }
-- 				-- 	local mz = { m.z[1], m.z[2], m.z[3], m.z[4] }
-- 				-- 	local mw = { m.w[1], m.w[2], m.w[3], m.w[4] }
-- 				-- 	local ident_matrix = { mx, my, mz, mw } 
-- 				-- 	local rotate_matrix = {
-- 				-- 	{math.sin(r)*math.cos(r2), math.sin(r)*math.sin(r2), math.cos(r), 0},
-- 				-- 	{math.cos(r)*math.cos(r2), math.cos(r)*math.sin(r2),-math.sin(r), 0},
-- 				-- 	{-math.sin(r2),            math.cos(r2),            0,            0},
-- 				-- 	{0,0,0,1},
-- 				-- 	}
-- 				-- 	local newM = functions2.script.multiply( rotate_matrix, ident_matrix )
-- 				-- 	m.x = newM[1]
-- 				-- 	m.y = newM[2]
-- 				-- 	m.z = newM[3]
-- 				-- 	m.w = newM[4]
-- 				-- 	self.go:setWorldRotation(m)
	
-- 				-- 	-- local dir = vec.truncate(newM,3)
-- 				-- 	-- local dir = vec(math.sin(math.rad(r)), 0, math.cos(math.rad(r)))
-- 				-- 	-- self.go:setWorldPosition( posStart + (dir * index * 3) + (dir * 1.5) )
-- 				-- 	-- self.go:setWorldRotationAngles(0, r*-1, 0)
-- 				-- end
				
--             end,
--             onUpdate = function(self)
-- 				if self.go.data then
-- 				local index = self.go.data:get("index")
-- 				local r = math.rad(self.go.data:get("angle"))
-- 				local r2 = math.rad(self.go.data:get("angle2"))
-- 				local posStart = self.go.data:get("posStart")
-- 				local m = self.go.data:get("m")

-- 				-- local mx = { m.x[1], m.x[2], m.x[3], m.x[4] }
-- 				-- local my = { m.y[1], m.y[2], m.y[3], m.y[4] }
-- 				-- local mz = { m.z[1], m.z[2], m.z[3], m.z[4] }
-- 				-- local mw = { m.w[1], m.w[2], m.w[3], m.w[4] }
-- 				-- local ident_matrix = { mx, my, mz, mw } 
-- 				-- local rotate_matrix = {
-- 				-- {math.sin(r)*math.cos(r2), math.sin(r)*math.sin(r2), math.cos(r), 0},
-- 				-- {math.cos(r)*math.cos(r2), math.cos(r)*math.sin(r2),-math.sin(r), 0},
-- 				-- {-math.sin(r2),            math.cos(r2),            0,            0},
-- 				-- {0,0,0,1},
-- 				-- }
-- 				-- local newM = functions2.script.multiply( rotate_matrix, ident_matrix )
-- 				-- m.x = newM[1]
-- 				-- m.y = newM[2]
-- 				-- m.z = newM[3]
-- 				-- m.w = newM[4]
-- 				-- self.go:setWorldRotation(m)

-- 				-- local dir = vec.truncate(newM,3)
-- 				-- local dir = vec(math.sin(math.rad(r)), 0, math.cos(math.rad(r)))
-- 				-- self.go:setWorldPosition( posStart + (dir * index * 3) + (dir * 1.5) )
-- 				-- self.go:setWorldRotationAngles(0, r*-1, 0)

-- 				-- local distance = vec(posStart.x, posStart.z, posStart.y) - vec(party.x, party.z, party.y)
-- 				-- local directionA = vec.normalize(vec(0, 1, 0))
-- 				-- local directionB = vec.normalize(vec.clone(distance))
-- 				-- local rotationAngle = math.acos(vec.dot(directionA, directionB));
-- 				-- local rotationAxis = vec.normalize(vec.cross(vec.clone(directionA), directionB))
-- 				-- print(rotationAngle)
-- 				-- print(rotationAxis)
-- 				end
--             end,
--         },
       
-- 		{
-- 			class = "Sound",
-- 			sound = "monster_cast",
-- 		},
-- 		{
-- 			class = "Counter",
-- 			name = "angle",
-- 		},
-- 	},
-- 	placement = "floor",
-- 	editorIcon = 272,
-- 	tags = { "obstacle" },
-- }