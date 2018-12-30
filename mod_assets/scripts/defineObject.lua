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
	--functions.script.reset_attack(self)
end

local onThrowAttack = function(self, champion, slot, chainIndex)
	functions.script.onThrowAttack(self, champion, slot, chainIndex)
end

local onMonsterDealDamage = function(self, champion, damage)
	functions.script.onMonsterDealDamage(self, champion, damage)
end

local onInit = function(self)
	if self.go.item:hasTrait("flurry") then
		local c = self.go:createComponent("MeleeAttack","flurry")
		c:setAccuracy(20)
		c:setAttackPower(self:getAttackPower() / 2)
		c:setBaseDamageStat(self:getBaseDamageStat())
		c:setCooldown(self:getCooldown() * 1.5)
		c:setEnergyCost(40)
		c:setGameEffect("A series of three quick slashes with deadly accuracy.")
		c:setPierce(iff(self:getPierce(),self:getPierce(), 0))
		c:setRepeatCount(3)
		c:setRepeatDelay(0.2)
		c:setSwipe("flurry")
		c:setUiName("Flurry of Slashes")
		if c.go.item:hasTrait("light_weapon") then
			c:setRequirements({"light_weapons", 4})
		elseif c.go.item:hasTrait("heavy_weapon") then
			c:setRequirements({"heavy_weapons", 4})
		end
		c.go.item:setSecondaryAction("flurry")
	end
	
	-- if self.go.item:hasTrait("cleave") then
		-- local c = self.go:createComponent("MeleeAttack","cleave")
		-- c:setAccuracy(20)
		-- c:setAttackPower(self:getAttackPower() * 2.5)
		-- c:setBaseDamageStat(self:getBaseDamageStat())
		-- c:setCooldown(self:getCooldown() * 1.5)
		-- c:setEnergyCost(40)
		-- c:setGameEffect("")
		-- c:setPierce(iff(self:getPierce(),self:getPierce() + 10, 10))
		-- c:setSwipe("flurry")
		-- c:setUiName("Cleave")
		-- if c.go.item:hasTrait("light_weapon") then
			-- c:setRequirements({"light_weapons", 4})
		-- elseif c.go.item:hasTrait("heavy_weapon") then
			-- c:setRequirements({"heavy_weapons", 4})
		-- end
		-- c.go.item:setSecondaryAction("clave")
	-- end
	
	-- if self.go.item:hasTrait("stun") then
		-- local c = self.go:createComponent("MeleeAttack","cleave")
		-- c:setAccuracy(20)
		-- c:setAttackPower(self:getAttackPower() * 2)
		-- c:setBaseDamageStat(self:getBaseDamageStat())
		-- c:setCooldown(self:getCooldown() * 1.5)
		-- c:setEnergyCost(40)
		-- c:setGameEffect("")
		-- c:setPierce(iff(self:getPierce(),self:getPierce(), 0))
		-- c:setCauseCondition("stunned")
		-- c:setSwipe("stun")
		-- c:setUiName("Stun")
		-- if c.go.item:hasTrait("light_weapon") then
			-- c:setRequirements({"light_weapons", 3})
		-- elseif c.go.item:hasTrait("heavy_weapon") then
			-- c:setRequirements({"heavy_weapons", 3})
		-- end
		-- c.go.item:setSecondaryAction("stun")
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
				c.onAttack = onAttack
				c.onHitMonster = onHitMonster
				c.onPostAttack = onPostAttack
				c.onInit = onInit
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