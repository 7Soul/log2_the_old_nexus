defineObject{
	name = "flintlock",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/pistol.fbx",
		},
		{
			class = "Item",
			uiName = "Flintlock",
			description = "A simple firearm. Popular with pirate ship crews.",
			gfxIndex = 333,
			impactSound = "impact_blunt",
			weight = 1.1,			
			traits = { "firearm", "upgradable" },
		},
		{
			class = "FirearmAttack",
			attackPower = 14,
			cooldown = 6,
			attackSound = "gun_shot_small",
			ammo = "pellet",
			jamChance = 0,
			requirements = { "firearms", 1 },
		},
	},
	tags = { "weapon_firearm" }
}

defineObject{
	name = "arquebus",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/arquebus.fbx",
		},
		{
			class = "Item",
			uiName = "Arquebus",
			description = "This large rifle packs enough punch to blast a hole through the hull of a ratling caravel.",
			gfxIndex = 331,
			impactSound = "impact_blunt",
			weight = 3.5,
			traits = { "firearm" },
		},
		{
			class = "FirearmAttack",
			attackPower = 35,
			cooldown = 6,
			attackSound = "gun_shot_large",
			ammo = "pellet",
			backfireChance = 10,
			requirements = { "firearms", 3 },
		},
	},
	tags = { "weapon_firearm" }
}

defineObject{
	name = "revolver",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/revolver.fbx",
		},
		{
			class = "Item",
			uiName = "Dragonbreath Revolver",
			description = "Powerful runes and enchantments are inscribed upon this weapon to keep its intricate mechanisms working.",
			gfxIndex = 332,
			gfxIndexPowerAttack = 417,
			impactSound = "impact_blunt",
			secondaryAction = "reload",
			weight = 1.5,
			traits = { "firearm" },
		},
		{
			class = "FirearmAttack",
			attackPower = 22,
			cooldown = 1.5,
			attackSound = "gun_shot_small",
			ammo = "pellet",
			clipSize = 6,
			jamChance = 0,
			requirements = { "firearms", 3 },
		},
		{
			class = "ReloadFirearm",
			uiName = "Reload",
			name = "reload",
			requirements = { "firearms", 3 },
			gameEffect = "Reloads all six chambers of the revolver.",
			onAttack = function(self, champion, slot)
				functions.script.reload(self, champion, slot)
			end
		},
	},
	tags = { "weapon_firearm" }
}

defineObject{
	name = "repeater",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/repeater.fbx",
		},
		{
			class = "Item",
			uiName = "Repeater",
			description = "A crude but effective firearm. Also known as the \"Gunpowder Hog\" for its ability to fire pellets in quick bursts.",
			gfxIndex = 337,
			gfxIndexPowerAttack = 97,
			impactSound = "impact_blunt",
			weight = 4.4,
			secondaryAction = "repeatFire",
			traits = { "firearm" },
		},
		{
			class = "FirearmAttack",
			attackPower = 38,
			cooldown = 6,
			attackSound = "gun_shot_small",
			ammo = "pellet",
			requirements = { "firearms", 4 },
		},
		{
			class = "FirearmAttack",
			name = "repeatFire",
			uiName = "Repeat Fire",
			gameEffect = "Fires a deadly hail of bullets.",
			energyCost = 30,
			attackPower = 17,
			cooldown = 6,
			attackSound = "gun_shot_small",
			ammo = "pellet",
			repeatCount = 6,
			repeatDelay = 0.15,
			jamChance = 0,
			requirements = { "firearms", 5 },
		},
	},
	tags = { "weapon_firearm" }
}

defineObject{
	name = "hand_cannon",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/hand_cannon.fbx",
		},
		{
			class = "Item",
			uiName = "Hand Cannon",
			description = "Commonly found on ship decks, this cannon has been modified by ratling mechanics to be more portable.",
			gfxIndex = 330,
			gfxIndexPowerAttack = 418,
			impactSound = "impact_blunt",
			secondaryAction = "bigShot",
			weight = 15.0,
			traits = { "firearm" },
		},
		{
			class = "FirearmAttack",
			attackPower = 80,
			cooldown = 6,
			attackSound = "gun_shot_cannon",
			ammo = "cannon_ball",
			requirements = { "firearms", 4 },
			onAttack = function(self)
				-- never jams but can backfire
				self.go.item:setJammed(false)
			end,
			onBackfire = function(self)
				local dust = party:spawn("particle_system")
				dust.particle:setParticleSystem("hit_firearm_large")
				dust:setWorldPositionY(dust:getWorldPositionY() + 1.3)				
			end,
		},
		{
			class = "FirearmAttack",
			name = "bigShot",
			uiName = "Big Shot",
			gameEffect = "Overloads the cannon with gunpowder which, when ignited, hurls the cannon ball with a devastating speed.",
			attackPower = 120,
			energyCost = 50,
			cooldown = 6,
			attackSound = "gun_shot_cannon",
			ammo = "cannon_ball",
			backfireChance = 15,
			knockback = true,
			requirements = { "firearms", 5 },
			onAttack = function(self)
				-- never jams but can backfire
				self.go.item:setJammed(false)
			end,
			onBackfire = function(self)
				local dust = party:spawn("particle_system")
				dust.particle:setParticleSystem("hit_firearm_large")
				dust:setWorldPositionY(dust:getWorldPositionY() + 1.3)				
			end,
			onPostAttack = function(self)
				local dust = party:spawn("particle_system")
				dust.particle:setParticleSystem("hit_firearm_large")
				dust:setWorldPositionY(dust:getWorldPositionY() + 1.3)

				party.party:shakeCamera(0.8, 0.3)

				party.party:knockback((party.facing + 2) % 4)

				if not party.party:isMoving() then
					for i=3,4 do
						local champion = party.party:getChampion(i)
						if champion:isAlive() then
							champion:damage(math.random(1,5), "physical")
							champion:playDamageSound()
						end
					end
				end
			end,
		},
	},
	tags = { "weapon_firearm" }
}

defineObject{
	name = "pellet_box",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/pellet_box.fbx",
		},
		{
			class = "Item",
			uiName = "Pellets",
			gfxIndex = 334,
			gfxIndexInHand = 335,
			stackable = true,
			multiple = 10,
			weight = 0.05,
		},
		{
			class = "AmmoItem",
			ammoType = "pellet",
		},
	},
	tags = { "weapon_firearm" }
}

defineObject{
	name = "cannon_ball",
	baseObject = "base_item",
	components = {
		{
			class = "Model",
			model = "assets/models/items/cannon_ball.fbx",
		},
		{
			class = "Item",
			uiName = "Cannon Ball",
			gfxIndex = 339,
			impactSound = "impact_blunt",
			stackable = true,
			projectileRotationSpeed = 10,
			projectileRotationZ = -30,
			weight = 1.0,
			traits = { "cannon_ball" },
		},
		{
			class = "AmmoItem",
			ammoType = "cannon_ball",
		},
	},
	tags = { "weapon_firearm" }
}
