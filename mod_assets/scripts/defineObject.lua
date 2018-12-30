local orig_defineObject = defineObject

local onEquipItem = function(self, champion, slot)
	functions.script.onEquipItem(self, champion, slot)
end

local onUnequipItem = function(self, champion, slot)
	functions.script.onUnequipItem(self, champion, slot)
end

local onAttack = function(self, champion, slot, chainIndex)
	local item = champion:getItem(slot)
	functions.script.onMeleeAttack(self, item, champion, slot, chainIndex)
end

local onHitMonster = function(self, monster, tside, damage, champion)
	functions.script.monster_attacked(self, monster, tside, damage, champion)		
	functions.script.reset_attack(self)
end

local onPostAttack = function(self, monster, tside, damage, champion)
	functions.script.reset_attack(self)
end

local onFirearmAttack = function(self, champion, slot)
	functions.script.onFirearmAttack(self, champion, slot)
end

local onFirearmPostAttack = function(self, champion, slot)
	local secondary2 = functions.script.secondary
	functions.script.onPostFirearmAttack(self, champion, slot, secondary2)
	functions.script.reset_attack(self)
end

local onThrowAttack = function(self, champion, slot, chainIndex)
	functions.script.onThrowAttack(self, champion, slot, chainIndex)
end

local onMonsterDealDamage = function(self, champion, damage)
	functions.script.onMonsterDealDamage(self, champion, damage)
end

local onWInit = function(self)
	if self.go.item:hasTrait("flurry") then
		local c = self.go:createComponent("MeleeAttack","flurry")
		functions.script.updateSecondary(self, c, "flurry")		
	end
	
	if self.go.item:hasTrait("cleave") then
		local c = self.go:createComponent("MeleeAttack","cleave")
		functions.script.updateSecondary(self, c, "cleave")		
	end
	
	if self.go.item:hasTrait("stun") then
		local c = self.go:createComponent("MeleeAttack","stun")
		functions.script.updateSecondary(self, c, "stun")
	end
	
	if self.go.item:hasTrait("chop") then
		local c = self.go:createComponent("MeleeAttack","chop")
		functions.script.updateSecondary(self, c, "chop")
	end
	
	if self.go.item:hasTrait("devastate") then
		local c = self.go:createComponent("MeleeAttack","devastate")
		functions.script.updateSecondary(self, c, "devastate")
	end
	
	if self.go.item:hasTrait("banish") then
		local c = self.go:getComponent("banish")
		functions.script.updateSecondary(self, c, "banish")
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
				c.onAttack = onAttack
				c.onHitMonster = onHitMonster
				c.onPostAttack = onPostAttack
				c.onInit = onWInit
			end
			if c.class == "FirearmAttack" then
				c.onAttack = onFirearmAttack
				c.onPostAttack = onFirearmPostAttack
			end
			if c.class == "ThrowAttack" then
				c.onAttack = onThrowAttack
				c.onPostAttack = onPostAttack
			end
			if c.class == "MonsterAttack" then
				c.onDealDamage = onMonsterDealDamage
			end
		end
	end
	orig_defineObject(def)
end