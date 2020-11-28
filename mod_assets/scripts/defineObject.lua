

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
	functions.script.onHitMonster(self, monster, tside, damage, champion)
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

local onDamageMonster = function(self, damage, damageType)
	functions.script.onDamageMonster(self, damage, damageType)
end

local onAnimationEvent = function(self, event)
	functions.script.onAnimationEvent(self, event)
end

local onWInit = function(self)
	if functions and functions.script then
		local meleeSecondaries = { "banish", "bash", "bite", "chop", "chip", "cleave", "dagger_throw", "devastate", "flurry", "knockback", "leech", "reap", "stun", "thrust" }
		for i=1,#meleeSecondaries do
			if self.go.meleeattack and self.go.item:hasTrait(meleeSecondaries[i]) and self:getName() ~= "meleeattack" then
				local c = self.go:getComponent(meleeSecondaries[i])
				functions.script.updateSecondary(self.go.meleeattack, c, meleeSecondaries[i], 0)
			end
		end

		local rangedSecondaries = { "volley", "power_bolt" }
		for i=1,#rangedSecondaries do
			if self.go.rangedattack and self.go.item:hasTrait(rangedSecondaries[i]) and self:getName() ~= "rangedattack" then
				local c = self.go:getComponent(rangedSecondaries[i])
				functions.script.updateSecondary(self.go.rangedattack, c, rangedSecondaries[i], 0)
			end
		end

		local throwingSecondaries = { "volley" }
		for i=1,#throwingSecondaries do
			if self.go.throwattack and self.go.item:hasTrait(throwingSecondaries[i]) and self:getName() ~= "throwattack" then
				local c = self.go:getComponent(throwingSecondaries[i])
				functions.script.updateSecondary(self.go.throwattack, c, throwingSecondaries[i], 0)
			end
		end
	end
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
