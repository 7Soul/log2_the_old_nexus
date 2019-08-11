defineObject{
	name = "liz_bite",
	baseObject = "base_spell",
	components = {
		{ 
			class = "Script",
			name = "data",
			source = [[
					data = {}
					function get(self,name) return self.data[name] end
					function set(self,name,value) self.data[name] = value end
					]],      
		},
		{
			class = "TileDamager",
			attackPower = 1,
			damageType = "physical",
			sound = "turtle_attack",
			damageFlags = DamageFlags.NoLingeringEffects,
			onHitChampion = function(self, champion)
				return false
			end,
			onHitMonster = function(self, monster)			
				local champion = party.party:getChampionByOrdinal(self:getCastByChampion())
				local accuracy = functions.script.get_c("bite_accuracy", self:getCastByChampion())
				local evasion = monster:getEvasion()
				local protection = monster:getProtection()
				self:setAttackPower(self:getAttackPower() - ((protection-5) * (math.random() + 0.5)))
				local hitChance = math.clamp(60 + accuracy - evasion, 5, 95) / 100
				if math.random() > hitChance then
					monster:showDamageText("miss", "AAAAAA")
					return false
				else
					return true
				end
			end
		},
		{
			class = "Sound",
			sound = "turtle_attack",
		},
	},
}

defineObject{
	name = "broadside",
	baseObject = "base_spell",
	components = {
		{ 
			class = "Script",
			name = "data",
			source = [[
					data = {}
					function get(self,name) return self.data[name] end
					function set(self,name,value) self.data[name] = value end
					]],      
		},
		{
			class = "Particle",
			particleSystem = "hit_firearm",
			offset = vec(0, 1.2, 0),
			destroyObject = true,
		},
		{
			class = "Light",
			color = vec(0.75, 0.4, 0.25),
			brightness = 40,
			range = 4,
			offset = vec(0, 1.2, 0),
			fadeOut = 0.75,
			disableSelf = true,
		},
		{
			class = "TileDamager",
			attackPower = 1,
			damageType = "physical",
			sound = "fireburst",
			damageFlags = DamageFlags.NoLingeringEffects,
			onHitChampion = function(self, champion)
				return false
			end,
		},
		{
			class = "Sound",
			sound = "fireburst",
		},
	},
}

defineObject{
	name = "voodoo",
	baseObject = "base_spell",
	components = {
		{
			class = "TileDamager",
			attackPower = 1,
			damageType = "physical",
			sound = "turtle_attack",
			damageFlags = DamageFlags.NoLingeringEffects,
			onHitChampion = function(self, champion)
				return false
			end,
			onHitMonster = function(self, monster)
				monster:addTrait("bleeding")
			end
		},
		{
			class = "Sound",
			sound = "turtle_attack",
		},
	},
}