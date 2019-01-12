local userData =
{ class = "Script",
  name = "data",
  source = [[
    data = {}
    function get(self,name) return self.data[name] end
    function set(self,name,value) self.data[name] = value end
  ]],      
}

function hit(self, what, entity)
  local e = self.go:spawn(self.go.data:get("hitEffect"))
  e:setWorldPosition(self.go:getWorldPosition())
  local attackPower = self.go.data:get("attackPower")
  if e.tiledamager then
    e.tiledamager:setCastByChampion(self:getCastByChampion() or 1)
    if attackPower then e.tiledamager:setAttackPower(attackPower) end
	-- Add elemental exploitation tag
	if party.party:getChampionByOrdinal(self:getCastByChampion()):hasTrait("elemental_exploitation") then
		functions.script.set_c("elemental_exploitation", self:getCastByChampion(), true)
	end	
  end
  if e.cloudspell then
    e.cloudspell:setCastByChampion(self:getCastByChampion() or 1)
    if attackPower then e.cloudspell:setAttackPower(attackPower) end
    local duration = self.go.data:get("duration")
    if duration then e.cloudspell:setDuration(duration) end
	-- Add elemental exploitation tag
	if party.party:getChampionByOrdinal(self:getCastByChampion()):hasTrait("elemental_exploitation") then
		functions.script.set_c("elemental_exploitation", self:getCastByChampion(), true)
	end
  end
end

function cycle(self)
  local wp = self.go:getWorldPosition()
  wp.x = wp.x-(self.go.data:get("dx") or 0)
  wp.y = wp.y-(self.go.data:get("dy") or 0)
  wp.z = wp.z-(self.go.data:get("dz") or 0)
  local t, dx, dz = party.gametime:getValue() + (self.go.data:get("dt") or 0)
      if self.go.facing == 0 then t = t+wp.z dx =  0.25*math.cos(t) dz = 0
  elseif self.go.facing == 1 then t = t+wp.x dz = -0.25*math.cos(t) dx = 0
  elseif self.go.facing == 2 then t = t-wp.z dx = -0.25*math.cos(t) dz = 0
  else                            t = t-wp.x dz =  0.25*math.cos(t) dx = 0
  end
  local dy = 0.25*math.sin(t) 
  wp.x = wp.x+dx
  wp.y = wp.y+dy
  wp.z = wp.z+dz
  self.go.data:set("dx", dx)
  self.go.data:set("dy", dy)
  self.go.data:set("dz", dz)
  self.go:setWorldPosition(wp)
end

function initCloud(self)
  for e in self.go.map:entitiesAt(self.go.x, self.go.y) do
    if e ~= self.go and self.go.elevation == e.elevation and e.name == self.go.name then
      local d = e.cloudspell:getDuration()
      if d < self:getDuration() then
        if d > 2 then
          e.particle:fadeOut(2)
          e.light:fadeOut(2)
        end
      else
        self.go.particle:fadeOut(0)
        self.go.light:fadeOut(0)
      end
    end
  end
end

defineObject{
  name = "trap_rune",
  baseObject = "base_spell",
  components = {
    userData,
    {
      class = "Model",
      model = "assets/models/effects/trap_rune.fbx",
      material = "rune_off",
      offset = vec(0, 0.1, 0),
    },
    {
      class = "Timer",
      timerInterval = 10,
      triggerOnStart = false,
      currentLevelOnly = false,
      disableSelf = true,
      onActivate = function(self)
        self.go.floortrigger:enable()
        self.go:playSound("light")
        self.go.model:setMaterial(self.go.data:get("effect"))
        self.go.build:fadeOut(1)
        self.go.light:fadeIn(1)
      end,
    },
    {
      class = "FloorTrigger",
      --triggeredByItem = false,
      enabled = false,
      onActivate = function(self)
        -- function zoneEffects(effects, centerID, range, sphere, duration, power, ordinal, checkMode)
        spells_functions.script.zoneEffects({{self.go.data:get("effect"), true}}, self.go.id, 1, false, 0, self.go.data:get("attackPower"), self.go.data:get("champion"))
        self.go:destroy()
      end,
    },
    {
      class = "Particle",
      name = "impact",
      particleSystem = "trickster_death_smoke_bomb",
      offset = vec(0, 0, 0),
      sortOffset = 3,
      disableSelf = true,
    },
    {
      class = "Light",
      name = "build",
      color = vec(1, 1, 1),
      brightness = 3,
      range = 5,
      offset = vec(0, 0.2, 0),
      disableSelf = true,
    },
    {
      class = "Light",
      color = vec(1, 1, 1),
      brightness = 30,
      range = 5,
      offset = vec(0, 0.2, 0),
      onInit = function(self) self:fadeOut(0) end,
    },
    {
      class = "IceShards",
      delay = 0.3,
    },
    {
      class = "TileDamager",
      attackPower = 0,
      damageType = "physical",
    },
  }
}

-- concentration magic

defineObject{
  name = "holy_light",
  baseObject = "base_spell",
  components = {
    {
      class = "TileDamager",
      attackPower = 0,
      damageType = "pure",
      --sound = "dispel_hit",
      onHitMonster = function(self, monster)
        monster:setCondition("blinded", 20)
        if monster:hasTrait("undead") and monster.go.brain then
          monster.go.brain:startFleeing()
          monster.go.brain:setMorale(0)
        end
      end,
      onHitChampion = function(self, champion)
        GameMode.fadeOut(0xFFFFFF, 0)
        GameMode.fadeIn(0xFFFFFF, 1)
      end,
    },
  },
}

defineObject{
  name = "dispel_cast",
  baseObject = "dispel_projectile",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "dispel_blast"}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      collisionMask = 3,  -- collide with magical fields (bit 1) and everything else (bit 0)
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "dark_bolt_cast",
  baseObject = "dark_bolt",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "dark_bolt_blast", attackPower=13}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "light_bolt",
  baseObject = "base_spell",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "light_blast", attackPower=13}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 40,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "light_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "blob_hit",
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(0.4, 0.5, 0.6),
      brightness = 40,
      range = 10,
      fadeOut = 0.5,
    },
    {
      class = "Sound",
      sound = "blob_hit",
    },
    {
      class = "TileDamager",
      attackPower = 0,
      damageType = "pure",
      onHitMonster = function(self, monster)
        monster:setCondition("blinded", 20)
        if monster:hasTrait("undead") and monster.go.brain then
          monster.go.brain:startFleeing()
          monster.go.brain:setMorale(0)
        end
      end,
      onHitChampion = function(self, champion)
        GameMode.fadeOut(0xFFFFFF, 0)
        GameMode.fadeIn(0xFFFFFF, 1)
      end,
    },
  },
}

defineObject{
  name = "arcane_bolt",
  baseObject = "base_spell",
  components = {
    {
      class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "arcane_blast", dt = 2*math.pi*math.random()}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Particle",
      particleSystem = "arcane_bolt",
    },
    {
      class = "Light",
      color = vec(1, 0.6, 1),
      brightness = 7,
      range = 5,
    },
    {
      class = "Sound",
      sound = "arcane_bolt_fly",
      pitch = 0.5,
    },
    {
      class = "Sound",
      name = "launchSound",
      sound = "arcane_launch",
      volume = 0.8,
      onInit = function(self) self:setPitch(1.2+math.random()*0.6) end,
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 5,
      radius = 0.1,
      onProjectileHit = hit,
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = cycle,
    },
  },
}

defineObject{
  name = "arcane_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "TileDamager",
      attackPower = 15,
      damageType = "pure",
      --onHitObstacle = function(self, obstacle) print("tile damager ordinal = "..self:getCastByChampion()) end,
      --onHitMonster = function(self, monster)   print("tile damager ordinal = "..self:getCastByChampion()) end,
      --onHitChampion = function(self, champion) print("tile damager ordinal = "..self:getCastByChampion()) end,
    },
    {
      class = "Particle",
      particleSystem = "arcane_blast",
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(1, 0.6, 1),
      brightness = 10,
      range = 7,
      fadeOut = 0.5,
      disableSelf = true,
    },
    {
      class = "Sound",
      sound = "arcane_hit",
      onInit = function(self) self:setPitch(1.2+math.random()*0.6) end,
    },
  },
}

defineObject{
  name = "arcane_flash_bolt",
  baseObject = "base_spell",
  components = {
    {
      class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "arcane_flash_blast"}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Particle",
      particleSystem = "arcane_flash_bolt",
    },
    {
      class = "Light",
      color = vec(1, 1, 1),
      brightness = 8,
      range = 7,
    },
    {
      class = "Sound",
      sound = "arcane_bolt_fly",
    },
    {
      class = "Sound",
      name = "launchSound",
      sound = "arcane_launch",
      volume = 0.8,
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 30,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "arcane_flash_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "TileDamager",
      attackPower = 0,
      damageType = "pure",
      sound = "arcane_hit",
    },
    {
      class = "Particle",
      particleSystem = "arcane_flash_blast",
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(1, 1, 1),
      brightness = 16,
      range = 10,
      fadeOut = 0.5,
      disableSelf = true,
    },
  },
}

defineObject{
  name = "arcane_nova_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "arcane_nova_blast",
      offset = vec(0, 1.5, 0),
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(1, 0.8, 1),
      brightness = 15,
      range = 3,
      fadeOut = 0.25,
      offset = vec(0, 1.5, 0),
      disableSelf = true,
    },
    {
      class = "Sound",
      sound = "arcane_hit",
      onInit = function(self) self:setPitch(1+math.random()) end,
      offset = vec(0, 1.5, 0),
    },
    {
      class = "TileDamager",
      attackPower = 0,
      damageType = "pure",
    },
  },
}

defineObject{
  name = "dark_bolt_andak",
  baseObject = "dark_bolt_cast",
  components = {
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = cycle,
    },
  },
}

-- fire magic

defineObject{
  name = "fire_wall",
  baseObject = "base_spell",
  components = {
    {
      class = "Model",
      model = "assets/models/effects/wall_fire.fbx",
      sortOffset = 1,
    },
    {
      class = "Animation",
      animations = {
        idle = "assets/animations/effects/wall_fire.fbx",
      },
      playOnInit = "idle",
      onAnimationEvent = function(self, event)
        if event == "end" then
          self.go.particle:stop()
          self.go.particle2:stop()
          self.go.particle:fadeOut(1)
          self.go.particle2:fadeOut(1)
          self.go.light:fadeOut(1)
        end
      end,
    },
    {
      class = "Particle",
      particleSystem = "wall_fire_smoke",
      offset = vec(0, 0, 0),
      sortOffset = 3,
      --destroyObject = true,
    },
    {
      class = "Particle",
      name = "particle2",
      particleSystem = "wall_fire",
      offset = vec(0, 0, 0),
      --destroyObject = true,
    },
    {
      class = "Particle",
      name = "impact",
      particleSystem = "wall_fire_impact",
      offset = vec(0, 0, 0),
      sortOffset = 3,
      --destroyObject = true,
    },
    {
      class = "Light",
      color = vec(0.75, 0.4, 0.25),
      brightness = 40,
      range = 6,
      offset = vec(0, 1.2, 0),
      --fadeOut = 0.75,
      disableSelf = true,
    },
    {
      class = "TileDamager",
      attackPower = 4,
      damageType = "fire",
      damageFlags = DamageFlags.DamageSourceIceShards,
      repeatCount = 5,
      repeatDelay = 4.3/5,
    },
    {
      class = "IceShards",
      delay = 0.3,
    },
  },
}

defineObject{
	name = "fireburst",
	baseObject = "fireburst",
	components = {
		{
			class = "TileDamager",
			attackPower = 20,
			damageType = "fire",
			sound = "fireburst",
			screenEffect = "fireball_screen",			
			--cameraShake = true,
			onHitMonster = function(self, monster)
				local champion = party.party:getChampionByOrdinal(self:getCastByChampion())
				local skillLevel = champion:getSkillLevel("elemental_magic")
				if monster:isAlive() and skillLevel >= 3 then
					monster:setCondition("burning", skillLevel * 5)
					-- mark condition so that exp is awarded if monster is killed by the condition
					local burning = monster.go.burning
					local ordinal = self:getCastByChampion()
					if burning and ordinal then burning:setCausedByChampion(ordinal) end
				end
			end
		},	
	},
}

defineObject{
  name = "fireball_small_cast",
  baseObject = "fireball_small",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "fireball_blast_large", attackPower=30}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "fireball_medium_cast",
  baseObject = "fireball_medium",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "fireball_blast_large", attackPower=50}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "fireball_large_cast",
  baseObject = "fireball_large",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "fireball_blast_large", attackPower=70}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "flashflare",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "flashflare",
      offset = vec(0, 0.2, 0),
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(1, 0.75, 0.5),
      brightness = 700,
      range = 15,
      offset = vec(0, 0.2, 0),
      fadeOut = 1.75,
      disableSelf = true,
    },
    {
      class = "TileDamager",
      attackPower = 50,
      castByChampion = 1,
      damageType = "fire",
      woundChance = 100,
      sound = "magic_hit_09",
      screenEffect = "flashflare_screen",
      onHitMonster = function(self, monster)
        monster:setCondition("blinded", 20)
      end,
      onHitChampion = function(self, champion)
        GameMode.fadeOut(0xFFFFFF, 0)
        GameMode.fadeIn(0xFFFFFF, 20)
      end,
    },
  },
}

defineObject{
  name = "fire_aura_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "fire_aura",
      offset = vec(0, 0, 0),
      destroyObject = true,
      onInit = function(self) self:fadeOut(2) end,
    },
    {
      class = "TileDamager",
      attackPower = 1,
      castByChampion = 1,
      damageType = "fire",
      onHitMonster = function(self, monster)
        if monster:isAlive() then
          monster:setCondition("burning", 15)
          -- mark condition so that exp is awarded if monster is killed by the condition
          local burning = monster.go.burning
          local ordinal = self:getCastByChampion()
          if burning and ordinal then burning:setCausedByChampion(ordinal) end
        end
      end,
    },
  },
}

defineObject{
  name = "fireball_andak",
  baseObject = "fireball_large_cast",
  components = {
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = cycle,
    },
  },
}

-- air magic

defineObject{
  name = "lightning_bolt_greater_cast",
  baseObject = "lightning_bolt_greater",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "lightning_bolt_greater_blast", attackPower=27}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "sleep_trap",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "sleep_trap",
      offset = vec(0, 0.2, 0),
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(0, 0.25, 0.5),
      brightness = 70,
      range = 8,
      offset = vec(0, 0.2, 0),
      fadeOut = 1.75,
      disableSelf = true,
    },
    {
      class = "TileDamager",
      attackPower = 25,
      castByChampion = 1,
      damageType = "shock",
      sound = "shockburst",
      onHitMonster = function(self, monster)
        delayedCall("spells_functions", 0, "sleep", monster.go.id, 20)
      end,
      onHitChampion = function(self, champion)
        delayedCall("spells_functions", 0, "sleep", party.id, 20)
      end,
    },
  },
}

defineObject{
  name = "teleporter_cast",
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
      staticShadowDistance = 0, -- use static shadows always
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
      class = "FloorTrigger",
      triggeredByDigging = false, 
      triggeredByItem = false,  
      triggeredByMonster = false, 
      triggeredByParty = true,  
      triggeredByPushableBlock = false,
      onActivate = function(self)
        spells_functions.script.teleportation()
        self.go:destroy()
      end,
    },
    {
      class = "Timer",
      timerInterval = 3,
      triggerOnStart = false,
      currentLevelOnly = false,
      onActivate = function(self)
        spells_functions.script.memorizeDestination(self.go)
        self.go:destroy()
      end,
      onInit = function(self)
        self.go.particle:fadeOut(3)
        self.go.light:fadeOut(3)
        self.go.sound:fadeOut(3)
      end,
    },
  },
  placement = "floor",
  editorIcon = 36,
}

defineObject{
  name = "lightning_bolt_andak",
  baseObject = "lightning_bolt_greater_cast",
  components = {
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = cycle,
    },
  },
}

-- water magic

defineObject{
  name = "frostburst_cast",
  baseObject = "frostburst",
  components = {
    {
      class = "TileDamager",
      attackPower = 11,
      castByChampion = 1,
      damageType = "cold",
      sound = "frostburst",
      onHitMonster = function(self, monster)
        monster:setCondition("frozen", math.random()*(3+party.party:getChampionByOrdinal(self:getCastByChampion()):getSkillLevel("water_magic")))
      end,
    },
  },
}

defineObject{
  name = "frostbolt_cast",
  baseObject = "frostbolt_5",
  components = {
    {
      class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "frostbolt_blast_5", attackPower=15}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "ice_cube",
  --baseObject = "base_obstacle",
  components = {
    {
      class = "Model",
      model = "assets/models/env/pushable_block_01.fbx",
      material = "ice_cube",
      offset = vec(0, 0, 0),
    },
    {
      class = "Health",
      health = 10,
      immunities = {"cold"},
      onDie = function(self)
        self.go:spawn("frostburst").tiledamager:disable()
        self.go:playSound("frostburst")
        local top_id = self.go.data:get("top") if not top_id then return end
        local top = findEntity(top_id) if not top then return end
        top:destroy()
      end,
    },
    {
      class = "ProjectileCollider",
    },
    {
      class = "ForceField",
      hitSound = "ice_hit",
      hitEffect = "hit_ice_block",
    },
    {
      class = "Obstacle",
      hitSound = "ice_hit",
      hitEffect = "hit_ice_block",
    },
    {
      class = "DynamicObstacle",
    },
    userData,
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      onActivate = function(self)
        spells_functions.script.checkIceBlock(self.go, Time.deltaTime())
      end,
    },
    {
      class = "PushableBlock",
    },
    {
      class = "Clickable",
      name = "clickNorth",
      offset = vec(0, 1.15, 1.2),
      size = vec(1.2, 1.2, 0.1),
      maxDistance = 1,
      onClick = function(self)
        if party.facing == (self.go.facing+2) % 4 then spells_functions.script.pushIceBlock(self.go) end
      end,
    },
    {
      class = "Clickable",
      name = "clickEast",
      offset = vec(1.2, 1.15, 0),
      size = vec(0.1, 1.2, 1.2),
      maxDistance = 1,
      onClick = function(self)
        if party.facing == (self.go.facing+3) % 4 then spells_functions.script.pushIceBlock(self.go) end
      end,
    },
    {
      class = "Clickable",
      name = "clickSouth",
      offset = vec(0, 1.15, -1.2),
      size = vec(1.2, 1.2, 0.1),
      maxDistance = 1,
      onClick = function(self)
        if party.facing == self.go.facing then spells_functions.script.pushIceBlock(self.go) end
      end,
    },
    {
      class = "Clickable",
      name = "clickWest",
      offset = vec(-1.2, 1.15, 0),
      size = vec(0.1, 1.2, 1.2),
      maxDistance = 1,
      onClick = function(self)
        if party.facing == (self.go.facing+1) % 4 then spells_functions.script.pushIceBlock(self.go) end
      end,
    },
  },
  placement = "floor",
  editorIcon = 272,
  tags = { "obstacle" },
}

defineObject{
  name = "ice_cube_top",
  baseObject = "base_floor_decoration",
  components = {
    {
      class = "Platform",
    },
    {
      class = "FloorTrigger",
      activateSound = "terracotta_jar_hit",
      deactivateSound = "terracotta_jar_hit",
      pressurePlate = true, -- indicates a real pressure plate (camera is tilted down and items are constrained on the plate)
    },
  },
}

defineObject{
  name = "invisible_pushable_block_floor",
  baseObject = "base_floor_decoration",
  components = {
    {
      class = "PushableBlockFloor",
      name = "controller",
    },
  },
  replacesFloor = false,
}

defineObject{
  name = "freeze_trap",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "freeze_trap",
      offset = vec(0, 0.2, 0),
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(0.75, 2.4, 5.25),
      brightness = 70,
      range = 8,
      offset = vec(0, 0.2, 0),
      fadeOut = 1.75,
      disableSelf = true,
    },
    {
      class = "TileDamager",
      attackPower = 15,
      castByChampion = 1,
      damageType = "cold",
      sound = "frostburst",
      screenEffect = "ice_screen",
      onHitMonster = function(self, monster)
        monster:setCondition("frozen", self:getAttackPower()/3)
      end,
      onHitChampion = function(self, champion)
        spells_functions.script.maxConditionValue("frozen_champion", self:getAttackPower()/3, champion:getOrdinal())
        GameMode.fadeOut(0x55AAFF, 0)
        GameMode.fadeIn(0x55AAFF, 3)
      end,
    },
  },
}

defineObject{
  name = "frostbolt_andak",
  baseObject = "frostbolt_cast",
  components = {
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = cycle,
    },
  },
}

-- earth magic

defineObject{
  name = "poison_cloud_small",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "poison_cloud_small",
      offset = vec(0, 1.5, 0),
    },
    {
      class = "Light",
      offset = vec(0, 1.5, 0),
      color = vec(0.5, 0.5, 0.25),
      brightness = 7,
      range = 5,
      fadeOut = 13,
      disableSelf = true,
    },    
    {
      class = "CloudSpell",
      attackPower = 5,
      damageInterval = 0.8,
      damageType = "poison",
      duration = 10,
      sound = "poison_cloud",
      onInit = initCloud,
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = function(self)
        if spells_functions.script.windRiderPower > 0 and self.go.cloudspell:getAttackPower() > 0 then
          local dx,dy,dz = self.go.x-party.x, self.go.y-party.y, self.go.elevation-party.elevation
          if dx*dx + dy*dy + dz*dz < 25 then
            self.go.cloudspell:setAttackPower(0)
            if self.go.particle then self.go.particle:fadeOut(2) end
            if self.go.light then self.go.light:fadeOut(2) end
          end
        end
      end,
    },
  },
}

defineObject{
  name = "poison_cloud_medium",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "poison_cloud_medium",
      offset = vec(0, 1.5, 0),
    },
    {
      class = "Light",
      offset = vec(0, 1.5, 0),
      color = vec(0.5, 0.5, 0.25),
      brightness = 7,
      range = 5,
      fadeOut = 13,
      disableSelf = true,
    },    
    {
      class = "CloudSpell",
      attackPower = 5,
      damageInterval = 0.4,
      damageType = "poison",
      duration = 15,
      sound = "poison_cloud",
      onInit = initCloud,
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = function(self)
        if spells_functions.script.windRiderPower > 0 and self.go.cloudspell:getAttackPower() > 0 then
          local dx,dy,dz = self.go.x-party.x, self.go.y-party.y, self.go.elevation-party.elevation
          if dx*dx + dy*dy + dz*dz < 25 then
            self.go.cloudspell:setAttackPower(0)
            if self.go.particle then self.go.particle:fadeOut(2) end
            if self.go.light then self.go.light:fadeOut(2) end
          end
        end
      end,
    },
  },
}

defineObject{
  name = "poison_cloud_large",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "poison_cloud_large",
      offset = vec(0, 1.5, 0),
    },
    {
      class = "Light",
      offset = vec(0, 1.5, 0),
      color = vec(0.5, 0.5, 0.25),
      brightness = 7,
      range = 5,
      fadeOut = 13,
      disableSelf = true,
    },    
    {
      class = "CloudSpell",
      attackPower = 5,
      damageInterval = 0.2,
      damageType = "poison",
      duration = 20,
      sound = "poison_cloud",
      onInit = initCloud,
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = function(self)
        if spells_functions.script.windRiderPower > 0 and self.go.cloudspell:getAttackPower() > 0 then
          local dx,dy,dz = self.go.x-party.x, self.go.y-party.y, self.go.elevation-party.elevation
          if dx*dx + dy*dy + dz*dz < 25 then
            self.go.cloudspell:setAttackPower(0)
            if self.go.particle then self.go.particle:fadeOut(2) end
            if self.go.light then self.go.light:fadeOut(2) end
          end
        end
      end,
    },
  },
}

defineObject{
  name = "swarm_cloud",
  baseObject = "base_spell",
  components = {
    userData,
    {
      class = "Particle",
      particleSystem = "poison_fireflies",
      offset = vec(0, 1.8, 0),
    },
    {
      class = "Light",
      offset = vec(0, 1.8, 0),
      range = 5,
      color = vec(0.2, 0.75, 0.5),
      brightness = 4,
      fillLight = true,
    },
    {
      class = "TileDamager",
      attackPower = 3,
      damageType = "poison",
      destroyObject = true,
      repeatCount = 60,
      repeatDelay = 1,
      onHitMonster = function(self, monster)
        local old = self.go.data:get("target")
        if monster:isAlive() and monster.go.id ~= old then
          local resist = monster:getResistance("poison") or "normal"
          if resist ~= "immune" and resist ~= "absorb" then
            local oldRes = old and old.monster and (old.monster:getResistance("poison") or "normal") or "none"
            local tab = {none = 0, resist = 1, normal = 2, weak = 3, vulnerable = 4}
            if tab[resist] > tab[oldRes] then self.go.data:set("target", monster.go.id) end
          end
        end
        return true
      end,
      onHitChampion = function(self, champion) return false end,
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = function(self)
        local t0 = self.go.data:get("t0")
        if t0 and party.gametime:getValue()-t0 >= 57 then self.go.particle:fadeOut(3) self.go.light:fadeOut(3) self.go.data:set("t0") end
        local target = self.go.data:get("target")
        if not target then return end
        target = findEntity(target)
        if not target or not target.monster:isAlive() then self.go.data:set("target") return end
        self.go:setWorldPosition(0.9*self.go:getWorldPosition() + 0.1*target:getWorldPosition())
      end,
      onInit = function(self) self.go.data:set("t0", party.gametime:getValue()) end,
    },
  },
}

defineObject{
  name = "rock_fall_spell",
  baseObject = "base_spell",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "rock_blast"}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Model",
      model = "assets/models/items/rock.fbx",
      onInit = function(self) self:setRotationAngles(math.random(360), math.random(360), math.random(360)) end,
    },
    {
      class = "Particle",
      particleSystem = "rock_spell",
    },
    {
      class = "Projectile",
      spawnOffsetY = 3,
      velocity = 0,
      gravity = 10,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "rock_spell",
  baseObject = "base_spell",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "rock_blast"}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Model",
      model = "assets/models/items/rock.fbx",
      onInit = function(self) self:setRotationAngles(math.random(360), math.random(360), math.random(360)) end,
    },
    {
      class = "Particle",
      particleSystem = "rock_spell",
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 20,
      gravity = 1,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "rock_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "rock_blast",
      destroyObject = true,
    },
    {
      class = "TileDamager",
      attackPower = 10,
      castByChampion = 1,
      damageType = "physical",
      woundChance = 5,
      sound = "impact_punch",
    },
  },
}

defineObject{
  name = "poison_bolt_greater_cast",
  baseObject = "poison_bolt_greater",
  components = {
    { class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "poison_bolt_greater_blast_cast", attackPower=15}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = hit,
    },
  },
}

defineObject{
  name = "poison_bolt_greater_blast_cast",
  baseObject = "poison_bolt_blast",
  components = {
    {
      class = "TileDamager",
      attackPower = 15,
      damageType = "poison",
      sound = "poison_bolt_hit",
      screenEffect = "poison_bolt_screen",
      onInit = function(self)
        local cloudspell = self.go:spawn("poison_cloud_medium").cloudspell
        if cloudspell then cloudspell:setCastByChampion(1) end
      end,
      onHitMonster = function(self, monster)
        monster:setCondition("poisoned", 25)
        -- mark condition so that exp is awarded if monster is killed by the condition
        local poisonedCondition = monster.go.poisoned
        local ord = self:getCastByChampion()
        if poisonedCondition and ord then
          poisonedCondition:setCausedByChampion(ord)
        end
      end,
    },
  },
}

defineObject{
  name = "entangling_roots_trap",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "entangling_roots_trap",
      offset = vec(0, 0.2, 0),
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(0.5, 1, 0.75),
      brightness = 70,
      range = 8,
      offset = vec(0, 0.2, 0),
      fadeOut = 1.75,
      disableSelf = true,
    },
    {
      class = "TileDamager",
      attackPower = 25,
      castByChampion = 1,
      damageType = "poison",
      woundChance = 10,
      sound = "viper_root_rise",
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = false,
      disableSelf = true,
      onActivate = function(self) self.go:spawn("thorn_wall_trap") end,
    },
  },
}

defineObject{
  name = "thorn_wall_trap",
  baseObject = "thorn_wall",
  components = {
    {
      class = "ForceField",
    },
    {
      class = "TileDamager",
    },
    {
      class = "IceShards",
      delay = 0,
      range = 0,
    },
  },
}

defineObject{
  name = "earthquake_tick",
  baseObject = "base_spell",
  components = {
    {
      class = "Script",
      name = "tiledamager",
      source = [[
        data = {}
        function setAttackPower(self,power) self.data.power = power trigger(self) end
        function setCastByChampion(self,ordinal) self.data.ordinal = ordinal trigger(self) end
        function trigger(self)
          if not self.data.power or not self.data.ordinal then return end
          if self:isEnabled() then spells_functions.script.rocksErupt(self.data.power/5, self.data.ordinal, 7.5, self.go.x, self.go.y) end
          self.go:destroyDelayed()
        end
      ]],      
    },
    {
      class = "IceShards",
      delay = 0,
      range = 0,
    },
  },
}

defineObject{
  name = "earthquake_rock",
  baseObject = "base_spell",
  components = {
    {
      class = "Script",
      name = "data",
      source = [[
        data = {hitEffect = "earthquake_blast"}
        function get(self,name) return self.data[name] end
        function set(self,name,value) self.data[name] = value end
      ]],      
    },
    {
      class = "Model",
      model = "assets/models/items/rock.fbx",
      onInit = function(self) self:setRotationAngles(math.random(360), math.random(360), math.random(360)) end,
    },
    {
      class = "Particle",
      particleSystem = "rock_spell",
    },
    {
      class = "Projectile",
      spawnOffsetY = 0.2,
      velocity = 1,
      gravity = 10,
      radius = 0.1,
      onProjectileHit = hit,
      onInit = function(self) self:setIgnoreEntity("party") self:setFallingVelocity(5) end
    },
  },
}

defineObject{
  name = "earthquake_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "rock_blast",
      destroyObject = true,
    },
    {
      class = "TileDamager",
      attackPower = 5,
      castByChampion = 1,
      damageType = "physical",
      --sound = "impact_punch",
      onHitChampion = function(self, champion) return false end,
    },
  },
}

defineObject{
  name = "poison_bolt_andak",
  baseObject = "poison_bolt_greater_cast",
  components = {
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = cycle,
    },
  },
}

-- fire & air magic

defineObject{
  name = "time_bolt",
  baseObject = "base_spell",
  components = {
    userData,
    {
      class = "Particle",
      particleSystem = "time_bolt",
    },
    {
      class = "Light",
      color = vec(0.5, 0.25, 1),
      brightness = 8,
      range = 7,
    },
    {
      class = "Sound",
      sound = "teleporter_ambient",
    },
    {
      class = "Sound",
      name = "launchSound",
      sound = "teleport",
      volume = 0.8,
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = function(self, what, entity)
        local attackPower, duration = self.go.data:get("attackPower"), self.go.data:get("duration")
        --print("time_bolt hits")
        --print("what = "..tostring(what))
        --if entity then print("entity = "..entity.name) end
        self.go:spawn("teleportation_effect")
        local travelers = {}
        for e in self.go.map:entitiesAt(self.go.x, self.go.y) do
          if e.monster and e.elevation == self.go.elevation then
            --print("time travel for "..e.name.." (id="..e.id..")")
            local details = {e.id}
            for _,c in e:componentIterator() do
              if c:isEnabled() and c:getClass() ~= "UggardianFlamesComponent" then
                details[#details+1] = c:getName()
                c:disable()
              end
            end
            travelers[#travelers+1] = details
            e:setPosition(e.x, e.y, e.facing, -1000, e.level)
            e.monster:addTrait("time_traveler")
          end
        end
        local blast = self.go:spawn("time_blast")
        blast.data:set("travelers", travelers)
        blast.data:set("attackPower", attackPower)
        blast.data:set("caster", self:getCastByChampion())
        blast.timer:setTimerInterval(duration)
        spells_functions.script.insertEffectIcons("time_bolt", duration)
      end
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = function(self)
        local wp = self.go:getWorldPosition()
        local t,x,z = party.gametime:getValue()
            if self.go.facing == 0 then t = t+wp.z z = true x = false
        elseif self.go.facing == 1 then t = t+wp.x x = true z = false
        elseif self.go.facing == 2 then t = t-wp.z z = true x = false
        else                            t = t-wp.x x = true z = false
        end
        t = t*60
        self.go:setWorldRotationAngles(x and t or 0, 0, z and t or 0)
      end,
    },
  },
}

defineObject{
  name = "time_blast",
  baseObject = "base_spell",
  components = {
    userData,
    {
      class = "Timer",
      timerInterval = math.huge,
      triggerOnStart = false,
      currentLevelOnly = false,
      onActivate = function(self)
        local travelers, attackPower, caster = self.go.data:get("travelers"), self.go.data:get("attackPower"), self.go.data:get("caster")
        if #travelers > 0 then
          local push = {}
          for e in self.go.map:entitiesAt(self.go.x, self.go.y) do
            if e.elevation == self.go.elevation then push[#push+1] = e.monster or e.party end
          end
          if #push > 0 then
            local valid = {}
            local check = function(x1,y1,x2,y2,e)
              return self.go.map:checkLineOfFire(x1,y1,x2,y2,e) and not (party.x==x2 and party.y==y2 and party.elevation==e)
            end
            if check(self.go.x, self.go.y, self.go.x, self.go.y-1, self.go.elevation) then valid[#valid+1] = 0 end
            if check(self.go.x, self.go.y, self.go.x+1, self.go.y, self.go.elevation) then valid[#valid+1] = 1 end
            if check(self.go.x, self.go.y, self.go.x, self.go.y+1, self.go.elevation) then valid[#valid+1] = 2 end
            if check(self.go.x, self.go.y, self.go.x-1, self.go.y, self.go.elevation) then valid[#valid+1] = 3 end
            if #valid < 1 then self.go:setTimerInterval(1) return end
            for _,p in ipairs(push) do p:knockback(valid[math.random(#valid)]) end
          end
          for _,t in ipairs(travelers) do
            local traveler = findEntity(t[1])
            if traveler then
              for i = 2,#t do local c = traveler:getComponent(t[i]) if c then c:enable() end end
              traveler:setPosition(self.go.x, self.go.y, traveler.facing, self.go.elevation, self.go.level)
              traveler.monster:removeTrait("time_traveler")
            end
          end
        end
        self.go:spawn("teleportation_effect")
        local f = self.go:spawn("fireburst")
        f.tiledamager:setCastByChampion(caster)
        f.tiledamager:setAttackPower(attackPower/2)
        local s = self.go:spawn("shockburst")
        s.tiledamager:setCastByChampion(caster)
        s.tiledamager:setAttackPower(attackPower/2)
        self.go:destroyDelayed()
      end,
    },
  },
}

-- air & water magic

-- water & earth magic

-- earth & fire magic

defineObject{
  name = "explosion",
  baseObject = "base_spell",
  components = {
    {
      class = "TileDamager",
      attackPower = 20,
      damageType = "physical",
      destroyObject = true,
      onHitMonster = function(self, monster)
        if monster:isAlive() then
          if monster:getResistance("physical") ~= "immune" and monster:getResistance("physical") ~= "absorb" and not monster:isImmuneTo("knockback") then
            monster:knockback(self.go.facing)
          end
          if monster:getResistance("fire") ~= "immune" and monster:getResistance("fire") ~= "absorb" and not monster:isImmuneTo("burning") then
            monster:setCondition("burning", 15)
            -- mark condition so that exp is awarded if monster is killed by the condition
            local burning = monster.go.burning
            local ordinal = self:getCastByChampion()
            if burning and ordinal then burning:setCausedByChampion(ordinal) end
          end
        end
        return true
      end,
      onHitChampion = function(self, champion)
        return false
      end,
    },
  },
}

defineObject{
  name = "volcanic_eruption",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "volcanic_eruption",
      offset = vec(0, 1.3, 0),
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(1, 1, 1),
      brightness = 10,
      range = 6,
      offset = vec(0, 1.3, 0),
      fadeOut = 0.75,
      disableSelf = true,
      fillLight = true,
    },
    {
      class = "TileDamager",
      attackPower = 10,
      damageType = "fire",
      onHitMonster = function(self, monster)
        if monster:isAlive() then
          monster:setCondition("burning", 5)
          -- mark condition so that exp is awarded if monster is killed by the condition
          local burning = monster.go.burning
          local ordinal = self:getCastByChampion()
          if burning and ordinal then burning:setCausedByChampion(ordinal) end
  
          monster:setCondition("poisoned", 25)
          -- mark condition so that exp is awarded if monster is killed by the condition
          local poisonedCondition = monster.go.poisoned
          if poisonedCondition and ordinal then poisonedCondition:setCausedByChampion(ordinal) end
        end
      end,
    },
  },
}

-- fire & water magic

defineObject{
  name = "negentropy_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "fire_aura",
      offset = vec(0, 0, 0),
      destroyObject = true,
    },
    {
      class = "TileDamager",
      attackPower = 1,
      castByChampion = 1,
      damageType = "fire",
      onHitMonster = function(self, monster)
        if monster:isAlive() then
          if self:getDamageType() == "fire" then
            monster:setCondition("burning", 1)
            -- mark condition so that exp is awarded if monster is killed by the condition
            local burning = monster.go.burning
            local ordinal = self:getCastByChampion()
            if burning and ordinal then burning:setCausedByChampion(ordinal) end
          else
            monster:setCondition("frozen", 1)
          end
        end
      end,
      onInit = function(self)
        if math.random() < 0.5 then
          self.go.particle:setParticleSystem("ice_aura")
          self:setDamageType("cold")
        end
        self.go.particle:fadeOut(2)
      end,
    },
  },
}

-- air & earth magic 

-- air, water & earth magic

defineObject{
  name = "drain_life_bolt",
  baseObject = "base_spell",
  components = {
    userData,
    {
      class = "Particle",
      particleSystem = "drain_life_bolt",
    },
    {
      class = "Light",
      color = vec(0.25, 0.5, 1),
      brightness = 8,
      range = 7,
    },
    {
      class = "Sound",
      sound = "dark_bolt",
    },
    {
      class = "Sound",
      name = "launchSound",
      sound = "dark_bolt_launch",
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = function(self, what, entity)
        if what == "entity" then
          spells_functions.script.drainLifeBlast(entity.id, self.go.data:get("attackPower"), self.go.data:get("duration"))
        end
        spawn("arcane_flash_blast"):setWorldPosition(self.go:getWorldPosition())
      end
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = function(self)
        local wp = self.go:getWorldPosition()
        local t,x,z = party.gametime:getValue()
            if self.go.facing == 0 then t = t+wp.z z = true x = false
        elseif self.go.facing == 1 then t = t+wp.x x = true z = false
        elseif self.go.facing == 2 then t = t-wp.z z = true x = false
        else                            t = t-wp.x x = true z = false
        end
        t = t*60
        self.go:setWorldRotationAngles(x and t or 0, 0, z and t or 0)
      end,
    },
  },
}

defineObject{
  name = "life_drain",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "life_drain",
    },
    {
      class = "Sound",
      sound = "poison_bolt",
    },
    {
      class = "Sound",
      name = "launchSound",
      sound = "poison_bolt_launch",
    },
    userData,
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = function(self)
        local wp,pp = self.go:getWorldPosition(),party:getWorldPosition()
        pp.y = pp.y+1
        if (wp.x-pp.x)^2 + (wp.y-pp.y)^2 + (wp.z-pp.z)^2 > 1 then
          local f1 = 0.25^Time.deltaTime()
          local f2 = 1-f1
          wp.x = f1*wp.x + f2*pp.x
          wp.y = f1*wp.y + f2*pp.y
          wp.z = f1*wp.z + f2*pp.z
          self.go:setWorldPosition(wp)
        else
          local h = self.go.data:get("health")
          if h<0 then
            spells_functions.script.damageParty(h, "pure", true)
          else
            spells_functions.script.healParty(h, true)
          end
          self.go:spawn("blood_blast"):setWorldPosition(wp)
          self.go:destroy()
        end
      end,
    },
  },
}

defineObject{
  name = "blood_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "blood_hit",
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(1, 0.7, 0.5),
      brightness = 40,
      range = 10,
      fadeOut = 0.5,
    },
  },
}

-- water, earth & fire magic

defineObject{
  name = "all_shall_fall_blast",
  baseObject = "base_spell",
  components = {
    {
      class = "Particle",
      particleSystem = "fire_aura",
      offset = vec(0, 0, 0),
      destroyObject = true,
    },
    {
      class = "TileDamager",
      attackPower = 1,
      castByChampion = 1,
      damageType = "fire",
      onHitMonster = function(self, monster)
        if monster:isAlive() then
          if self:getDamageType() == "fire" then
            monster:setCondition("burning", 1)
            -- mark condition so that exp is awarded if monster is killed by the condition
            local burning = monster.go.burning
            local ordinal = self:getCastByChampion()
            if burning and ordinal then burning:setCausedByChampion(ordinal) end
          else
            monster:setCondition("frozen", 1)
          end
          if monster:getFlying() then
            monster:setFlying(false)
            monster.go.gravity:enable()
            spells_functions.script.delayEffects(10, spells_functions.script.fly, {monster.go.id})
          end
          local dx, dy = monster.go.x-party.x, monster.go.y-party.y
          local ax, ay = math.abs(dx), math.abs(dy)
          monster:knockback(math.random(ax+ay)>ax and (dy<0 and 0 or 2) or (dx<0 and 3 or 1))
        end
      end,
      onInit = function(self)
        if math.random() < 0.5 then
          self.go.particle:setParticleSystem("ice_aura")
          self:setDamageType("cold")
        end
        self.go.particle:fadeOut(2)
      end,
    },
  },
}

-- earth, fire & air magic

defineObject{
  name = "life_steal_bolt",
  baseObject = "base_spell",
  components = {
    userData,
    {
      class = "Particle",
      particleSystem = "life_steal_bolt",
    },
    {
      class = "Light",
      color = vec(0.25, 0.5, 1),
      brightness = 8,
      range = 7,
    },
    {
      class = "Sound",
      sound = "dark_bolt",
    },
    {
      class = "Sound",
      name = "launchSound",
      sound = "dark_bolt_launch",
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = function(self, what, entity)
        if what == "entity" then
          spells_functions.script.drainLifeBlast(entity.id, self.go.data:get("attackPower"), 0)
        end
        spawn("arcane_flash_blast"):setWorldPosition(self.go:getWorldPosition())
      end
    },
    {
      class = "Timer",
      timerInterval = 0,
      triggerOnStart = true,
      currentLevelOnly = true,
      onActivate = function(self)
        local wp = self.go:getWorldPosition()
        local t,x,z = party.gametime:getValue()
            if self.go.facing == 0 then t = t+wp.z z = true x = false
        elseif self.go.facing == 1 then t = t+wp.x x = true z = false
        elseif self.go.facing == 2 then t = t-wp.z z = true x = false
        else                            t = t-wp.x x = true z = false
        end
        t = -t*60
        self.go:setWorldRotationAngles(x and t or 0, 0, z and t or 0)
      end,
    },
  },
}

defineObject{
  name = "swap_bolt",
  baseObject = "base_spell",
  components = {
    userData,
    {
      class = "Particle",
      particleSystem = "swap_bolt",
    },
    {
      class = "Light",
      color = vec(0.6, 0.6, 0.6),
      brightness = 16,
      range = 8,
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = function(self, what, entity)
        spells_functions.script.swap(self.go.x, self.go.y, self.go.elevation, self.go.facing, self.go.level, self.go.map)
      end,
    },
    {
      class = "Sound",
      sound = "teleporter_ambient",
    },
    {
      class = "Sound",
      name = "launchSound",
      sound = "teleport",
    },
  },
}

defineObject{
  name = "teleportation_failed_effect",
  components = {
    {
      class = "Particle",
      particleSystem = "teleportation_failed",
      destroyObject = true,
    },
    {
      class = "Light",
      color = vec(115/255, 95/255, 69/255),
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
}

-- fire, air & water magic

defineObject{
  name = "transfer_bolt",
  baseObject = "base_spell",
  components = {
    userData,
    {
      class = "Particle",
      particleSystem = "transfer_bolt",
    },
    {
      class = "Light",
      color = vec(0.6, 0.6, 0.6),
      brightness = 16,
      range = 8,
    },
    {
      class = "Projectile",
      spawnOffsetY = 1.35,
      velocity = 10,
      radius = 0.1,
      onProjectileHit = function(self, what, entity)
        spells_functions.script.transfer(self.go.x, self.go.y, self.go.elevation, self.go.facing, self.go.level, self.go.map)
      end,
    },
    {
      class = "Sound",
      sound = "teleporter_ambient",
    },
    {
      class = "Sound",
      name = "launchSound",
      sound = "teleport",
    },
  },
}