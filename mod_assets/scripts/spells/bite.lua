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