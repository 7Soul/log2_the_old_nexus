local orig_defineObject = defineObject

local onEquipItem = function(self, champion, slot)
	functions.script.onEquipItem(self, champion, slot)
end

local onUnequipItem = function(self, champion, slot)
	functions.script.onUnequipItem(self, champion, slot)
end

local onMeleeAttack = function(self, champion, slot, chainIndex)
	local item = champion:getItem(slot)
	local secondary2 = functions.script.secondary
	functions.script.onMeleeAttack(self, item, champion, slot, chainIndex, secondary2)
end

local onHitMonster = function(self, monster, tside, damage, champion)
	local secondary2 = functions.script.secondary
	local item = self.go.item
	functions.script.monster_attacked(self, monster, tside, damage, champion)
	functions.script.reset_attack(self, champion, slot, secondary2, item) -- (when hit)
end

local onProjectileHitMonster = function(self, item, damage, damageType)
	
	return functions.script.onProjectileHitMonster(self, item, damage, damageType)
end

local onPostAttack = function(self, champion, slot)
	local secondary2 = functions.script.secondary
	local item = self.go.item
	functions.script.reset_attack(self, champion, slot, secondary2, item) -- (when misses)
end

local onFirearmAttack = function(self, champion, slot)
	local item = self.go.item
	functions.script.onFirearmAttack(self, champion, slot, item)
end

local onFirearmPostAttack = function(self, champion, slot)
	local secondary2 = functions.script.secondary
	local item = self.go.item
	functions.script.onPostFirearmAttack(self, champion, slot, secondary2, item)
	functions.script.reset_attack(self, champion, slot, secondary2, item)
end

local onThrowAttack = function(self, champion, slot, chainIndex)
	local item = self.go.item
	functions.script.onThrowAttack(self, champion, slot, chainIndex, item)
end

local onMissileAttack = function(self, champion, slot, chainIndex)
	local item = champion:getItem(slot)
	functions.script.onMissileAttack(self, champion, slot, chainIndex, item)
end

local onMonsterDealDamage = function(self, champion, damage)
	functions.script.onMonsterDealDamage(self, champion, damage)
end

local onMonsterDie = function(self)
	functions.script.onMonsterDie(self)
end

local onDamage = function(self, damage, damageType)
	functions.script.onDamageMonster(self, damage, damageType)
end

local onAnimationEvent = function(self, event)
	functions.script.onAnimationEvent(self, event)
end

local onWInit = function(self)
	if self.go.item:hasTrait("flurry") then
		local c = self.go:createComponent("MeleeAttack", "flurry")
		functions.script.updateSecondary(self, c, "flurry", 0)	
	end
	
	if self.go.item:hasTrait("cleave") then
		local c = self.go:createComponent("MeleeAttack", "cleave")
		functions.script.updateSecondary(self, c, "cleave", 0)		
	end
	
	if self.go.item:hasTrait("stun") then
		local c = self.go:createComponent("MeleeAttack", "stun")
		functions.script.updateSecondary(self, c, "stun", 0)
	end
	
	if self.go.item:hasTrait("chop") and self:getName() ~= "meleeattack" then
		if functions.script then
			local c = self.go:getComponent("chop")
			if not c then
				c = self.go:createComponent("MeleeAttack", "chop")
			end
			functions.script.updateSecondary(self.go.meleeattack, c, "chop", 0)
		end
	end
	
	if self.go.item:hasTrait("dagger_throw") then
		if functions.script then
			local c = self.go:getComponent("dagger_throw")
			if c == nil then
				c = self.go:createComponent("MeleeAttack", "dagger_throw")
			end
			functions.script.updateSecondary(self.go.meleeattack, c, "dagger_throw", 0)
		end
	end
	
	if self.go.item:hasTrait("devastate") then
		local c = self.go:createComponent("MeleeAttack", "devastate")
		functions.script.updateSecondary(self, c, "devastate", 0)
	end
	
	if self.go.item:hasTrait("banish") then
		local c = self.go:getComponent("banish")
		functions.script.updateSecondary(self, c, "banish", 0)
	end
	
	-- if self.go.item:hasTrait("volley") then
	-- 	if functions.script then
	-- 		local c = self.go:getComponent("volley")
	-- 		if c == nil then
	-- 			c = self.go:createComponent("RangedAttack", "volley")
	-- 		end
	-- 		functions.script.updateSecondary(self.go.rangedattack, c, "volley")
	-- 	end
	-- end
end

defineObject = function(def)
	if def.components then
		for _,c in pairs(def.components) do
			if c.class == "Item" then
				c.onEquipItem = onEquipItem
				c.onUnequipItem = onUnequipItem
			end
			if c.class == "MeleeAttack" then
				c.onAttack = onMeleeAttack
				c.onHitMonster = onHitMonster
				c.onPostAttack = onPostAttack
				c.onInit = onWInit
			end
			if c.class == "FirearmAttack" then
				c.onAttack = onFirearmAttack
				c.onPostAttack = onFirearmPostAttack
				c.onHitMonster = onHitMonster
				c.onInit = onWInit
			end
			if c.class == "ThrowAttack" then
				c.onAttack = onThrowAttack
				c.onPostAttack = onPostAttack
				c.onInit = onWInit
			end
			if c.class == "RangedAttack" then
				c.onAttack = onMissileAttack
				c.onPostAttack = onPostAttack
				c.onInit = onWInit
			end
			if c.class == "MonsterAttack" then
				c.onDealDamage = onMonsterDealDamage
			end
			if c.class == "Monster" then
				c.onDie = onMonsterDie
				c.onDamage = onDamageMonster
				c.onProjectileHit = onProjectileHitMonster
			end
			if c.class == "Animation" then
				--c.onAnimationEvent = onAnimationEvent
			end
		end
	end
	orig_defineObject(def)
end