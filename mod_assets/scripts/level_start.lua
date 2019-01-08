editing = 0
xx,yy,zz = 0, 0, 0
xr,yr,zr = 0, 0, 0
posx = 0
posy = 0
posz = 0
gotDevice = false

function start()
	local reveal_map = false
	if reveal_map then
		local startx, starty = party.x, party.y
		for x=0,31 do
			for y=0,31 do
				party:setPosition(x, y, party.facing, party.elevation, party.level)
			end
		end
		party:setPosition(startx, starty, party.facing, party.elevation, party.level)
	end
	-- scenery
	findEntity("beach_rock_1x1_low_6"):getComponent("model"):setOffset(vec(-1.5,-0.8,0))
	findEntity("beach_rock_spire_4"):getComponent("model"):setOffset(vec(-20,0,0))
	findEntity("beach_rock_1x1_4"):getComponent("model"):setOffset(vec(-20,1,-10))
	findEntity("beach_rock_spire_5"):getComponent("model"):setOffset(vec(40,0,0))
	findEntity("beach_rock_2x1_9"):getComponent("model"):setOffset(vec(-20,-2,-8))
	
	-- Area around wrecked ship --
	beach_boulder_3:setWorldPosition(beach_boulder_3:getWorldPosition() + vec(2.7,3.1,2.2)) -- present
	beach_boulder_3:setWorldRotationAngles(126,0,0) -- present
	Dungeon.getMap(1):setAutomapTile(24,18,0)
	beach_boulder_7:setWorldPosition(beach_boulder_7:getWorldPosition() + vec(2.7,3.1,2.2)) -- present
	beach_boulder_7:setWorldRotationAngles(126,0,0) -- present
	
	findEntity("beach_shipwreck_land_hull_1"):getComponent("model"):setOffset(vec(0.27,-1.35,5.65))
	findEntity("beach_shipwreck_land_hull_1"):getComponent("model"):setRotationAngles(17.1,6.2,24.5)
	
	local pos = forest_ruins_pillar_fallen_1:getWorldPosition()
	forest_ruins_pillar_fallen_1:setWorldPosition(vec(pos.x + 1.77, pos.y + 0, pos.z - 2.03))
	forest_ruins_pillar_fallen_1:setWorldRotationAngles(0,67,0)
	
	beach_ocean_2:setWorldRotationAngles(0,45,0) -- present
	beach_ocean_3:setWorldRotationAngles(0,45,0) -- past
	
	-- Start area pier --
	forest_bridge_1:setWorldPosition(forest_bridge_1:getWorldPosition() + vec(0,-1.5,0))
	forest_bridge_2:setWorldPosition(forest_bridge_2:getWorldPosition() + vec(0,-1.5,0))
	for i=13,16 do
		findEntity("forest_bridge_pillar_"..i):setWorldPositionY(-3.5)
		findEntity("forest_bridge_pillar_"..i):setWorldPosition(findEntity("forest_bridge_pillar_"..i):getWorldPosition() + vec(0,0,1.5))
	end	
	invisible_platform_15:setWorldPositionY(-0.5)
	invisible_platform_16:setWorldPositionY(-0.5)
	invisible_platform_17:setWorldPositionY(-0.75)
	
	forest_bridge_no_icon_4:setWorldPosition(forest_bridge_no_icon_4:getWorldPosition() + vec(0,-3.14,0.38))
	forest_bridge_no_icon_4:setWorldRotationAngles(45,0,0)
	
	-- Beach cliff objects and decoration --
	for i=1,14 do		
		findEntity("invisible_platform_"..i):setWorldPositionY(0.0)
	end
	for i=1,16 do
		findEntity("beach_ground_01_"..i):setWorldPositionY(0.0)
	end
	for i=1,18 do
		findEntity("forest_elevation_edge_"..i):setWorldPositionY(-3)
	end
	beach_rock_1x1_lowest_10:setWorldPosition(beach_rock_1x1_lowest_10:getWorldPosition() + vec(0,0.8,0.5)) -- present
	beach_rock_1x1_lowest_22:setWorldPosition(beach_rock_1x1_lowest_22:getWorldPosition() + vec(0,0.8,0.5)) -- past
	forest_bridge_no_icon_1:setWorldPosition(forest_bridge_no_icon_1:getWorldPosition() + vec(0.0,-2.54,0.2)) -- present
	forest_bridge_no_icon_1:setWorldRotationAngles(42,0,0) -- present
	forest_bridge_no_icon_2:setWorldPosition(forest_bridge_no_icon_2:getWorldPosition() + vec(0.0,-2.54,0.2)) -- past
	forest_bridge_no_icon_2:setWorldRotationAngles(42,0,0) -- past
	forest_bridge_pillar_1:setWorldPosition(forest_bridge_pillar_1:getWorldPosition() + vec(0.05,-3.07,-1)) -- present
	forest_bridge_pillar_10:setWorldPosition(forest_bridge_pillar_10:getWorldPosition() + vec(0.05,-3.07,-1)) -- past
	for i=2,12 do
		findEntity("forest_bridge_pillar_"..i):setWorldPosition(findEntity("forest_bridge_pillar_"..i):getWorldPosition() + vec(0.3,-1.52,-1.5))
	end
		
	-- Beach cliff rocks (block view from ocean corner) -- 
	beach_rock_3x1_8:setWorldPosition(beach_rock_3x1_8:getWorldPosition() + vec(8.0,0.0,0.0)) -- present
	beach_rock_3x1_8:setWorldRotationAngles(0,45,0) -- present
	beach_rock_3x1_1:setWorldPosition(beach_rock_3x1_1:getWorldPosition() + vec(8.0,0.0,0.0)) -- past
	beach_rock_3x1_1:setWorldRotationAngles(0,45,0) -- past
	
	-- Beach central cave --
	beach_rock_wall_01_1:setWorldPosition(beach_rock_wall_01_1:getWorldPosition() + vec(-1.6,0.0,-0.45)) -- present
	beach_rock_wall_01_1:setWorldRotationAngles(0,-41,0) -- present
	beach_rock_1x1_low_28:setWorldPosition(beach_rock_1x1_low_28:getWorldPosition() + vec(-0.45,3.4,-5.4)) -- present
	beach_rock_1x1_low_28:setWorldRotationAngles(0,90,180) -- present
	beach_rock_arch_15:setWorldRotationAngles(0,45,0) -- present
	beach_boulder_11:setWorldPosition(beach_boulder_11:getWorldPosition() + vec(1.9,0.36,-4.5)) -- present
	forest_bridge_no_icon_3:setWorldPosition(forest_bridge_no_icon_3:getWorldPosition() + vec(-2.48,1.14,-3.46)) -- present
	forest_bridge_no_icon_3:setWorldRotationAngles(-22,98,0) -- present
	beach_boulder_13:setWorldPosition(beach_boulder_13:getWorldPosition() + vec(1.18,3.42,-0.12)) -- present

	-- Time Device altar (present only)
	forest_altar_1:setWorldPosition(forest_altar_1:getWorldPosition() + vec(0,0,1.0))
	enchanted_timepiece_1:setWorldPosition(enchanted_timepiece_1:getWorldPosition() + vec(0.5,0,1.0))
	timenote_1_1:setWorldPosition(timenote_1_1:getWorldPosition() + vec(0,0,1.2))
	beach_lock_ornate_1:setWorldPosition(beach_lock_ornate_1:getWorldPosition() + vec(0.12,-0.64,0.32))
	beach_lock_ornate_1:setWorldRotationAngles(16,25,9.6)

	-- items and objects
	findEntity("wooden_box_2"):getComponent("model"):setOffset(vec(-0.6,0.7,-0.6))
	findEntity("wooden_box_2"):getComponent("model"):setRotationAngles(-30,35,35)
	findEntity("shovel_1"):getComponent("model"):setOffset(vec(0.6,0.58,-0.0))
	findEntity("shovel_1"):getComponent("model"):setRotationAngles(45,-10,-90)
	findEntity("beach_sandpile_1"):getComponent("model"):setOffset(vec(-0.45,-0.35,2))	
	
	daemon_head_3:setWorldPosition(daemon_head_3:getWorldPosition() + vec(-0.27,0,0.0))
	mine_ceiling_lantern_4:setWorldPosition(mine_ceiling_lantern_4:getWorldPosition() + vec(-1.5,-0.7,0.9))
	
	-------------------
	-- Minute Grotto --
	-------------------
	for i=27,36 do
		findEntity("beach_rock_3x1_"..i):setWorldPosition(findEntity("beach_rock_3x1_"..i):getWorldPosition() + vec(-5,5,-2.7))
		findEntity("beach_rock_3x1_"..i):setWorldRotationAngles(104,0,96)
	end
	
	beach_rock_1x1_low_38:setWorldPosition(beach_rock_1x1_low_38:getWorldPosition() + vec(1.5,-0.4,1.6))
	beach_rock_1x1_low_38:setWorldRotationAngles(0,-45,0)
	beach_rock_1x1_low_39:setWorldPosition(beach_rock_1x1_low_39:getWorldPosition() + vec(1.6,3.8,1.5))
	beach_rock_1x1_low_39:setWorldRotationAngles(0,50,180)	
	beach_high_rock_pillar_01_10:setWorldPosition(beach_high_rock_pillar_01_10:getWorldPosition() + vec(0.75,0.75,0.4))
	
	-- Items --
	throwing_knife_2:setWorldPosition(throwing_knife_2:getWorldPosition() + vec(-0.19,1.84,1.46))
	throwing_knife_2:setWorldRotationAngles(115,133,-40)
	note_1:setWorldPosition(note_1:getWorldPosition() + vec(-0.26,1.65,0.96))
	note_1:setWorldRotationAngles(87.2,26.4,-2.4)
	iron_key_1:setWorldPosition(iron_key_1:getWorldPosition() + vec(-0.34,0.69,0.05))
	iron_key_1:setWorldRotationAngles(33,62,23)

	
	local pos = mine_ceiling_lantern_4:getWorldPosition()
	posx = pos.x
	posy = pos.y
	posz = pos.z
end

objname = "mine_ceiling_lantern_4"

function move(x,y,z)
	xx = xx + x*1
	yy = yy + y*1
	zz = zz + z*1
	findEntity(objname):setWorldPosition(vec(posx + xx, posy + yy, posz + zz))
	--findEntity(objname):getComponent("socket"):setOffset(vec(xx, yy, zz))
	print("Offset: ", xx, yy, zz)
end

function rotate(x,y,z)
	xr = xr + x*8
	yr = yr + y*8
	zr = zr + z*8
	findEntity(objname):setWorldRotationAnglesWithOrder(xr, yr, zr, "xyz")
	--findEntity(objname):getComponent("socket"):setRotationAngles(xr, yr, zr)
	print("Rotation: ", xr, yr, zr)
end

----------------------------------------
--------- Time Travel Effect -----------
----------------------------------------

skyMode = "normal"
skyTimer = 0
timeTravelTimer = 0
deviceMaxCharge = 5

function setSkyMode(n)
	skyMode = n
	if n == "travel_back_end" then
		playSound("teleport")
	end
	if n == "travel_forward_end" then
		playSound("teleport")
	end
end

function updateTimeTravelTimer(n)
	timeTravelTimer = math.max(timeTravelTimer + n, 0)
	if timeTravelTimer == 0 then
		playSound("time_1")
		playSound("time_2")
		setSkyMode("travel_forward")
	end
end

function teleportParty(level)
	party:setPosition(party.x, party.y, party.facing, party.elevation, level)
	GameMode.setTimeOfDay((GameMode.getTimeOfDay() + 1) % 2)
	if gotDevice and not party.party:isCarrying("enchanted_timepiece") then
		local timepiece = nil
		local tpSpawned = false
		if getMouseItem() and getMouseItem().go.name == "enchanted_timepiece" then
			return
		end
		for i=1,99 do
			timepiece = findEntity("enchanted_timepiece_"..i)
			if timepiece then timepiece:destroy() end
		end	
		for i=1,4 do
			local champion = party.party:getChampionByOrdinal(i)
			for j=1,32 do
				if j <= 2 or j >= 13 then
					if champion:getItem(j) == nil then					
						champion:insertItem(j, spawn("enchanted_timepiece").item)
						tpSpawned = true
						return
					end
				end
			end
		end
	end
end

function updateSky(t)
	local sky = findEntity("forest_day_sky_2").sky
	local fog_base = 440
	local fog_var = 350
	if party.level == 1 then
		sky = findEntity("forest_day_sky_2").sky
		fog_base = 470
		fog_var = 350
	elseif  party.level == 2 then
		sky = findEntity("beach_day_sky_2").sky
		fog_base = 420
		fog_var = 350
	end
	
	if skyMode == "normal" then
		sky:setFogRange({1, fog_base + (math.cos((t+0.5)/30*90) * fog_var)})
	elseif skyMode == "travel_back" then
		party.party:setMovementSpeed(0)
		if sky:getFogRange()[2] > 1 then
			skyTimer = math.min((skyTimer + 0.1) + (skyTimer * 0.02), fog_base+fog_var)
			sky:setFogRange({0, math.max(fog_base + ((math.cos((t+0.5)/30*90) * fog_var)) - (skyTimer * 2),1)})
			GameMode.fadeOut(0xFFFFFF, 2)
			GameMode.setTimeMultiplier(math.max(0.5 - (skyTimer/500), 0.02))
		else			
			party.party:shakeCamera(0.1,1)
			sky:setFogRange({0,1})
			GameMode.fadeOut(0xDDDDFF, 0.2)
			setSkyMode("travel_back_end")
			delayedCall("functions2", 0.2, "teleportParty", party.level + 1)
			delayedCall("functions2", 0.5, "setSkyMode", "arrive_back")
		end
	elseif skyMode == "arrive_back" then
		if sky:getFogRange()[2] < 1 then
			skyTimer = math.max((skyTimer - 0.01) - (skyTimer * 0.01),0)
			sky:setFogRange({0, fog_base + ((math.cos((t+0.5)/30*90) * fog_var)) - (skyTimer * 2)})
			GameMode.fadeIn(0xFFFFFF, 2)
		else
			sky:setFogRange({1, fog_base + (math.cos((t+0.5)/30*90) * fog_var)})
			GameMode.fadeIn(0xDDDDFF, 0.5)
			delayedCall("functions2", 0.5, "setSkyMode", "arrive_back_end")
		end
	elseif skyMode == "arrive_back_end" then
		party.party:setMovementSpeed(1)
		skyTimer = 0
		setSkyMode("normal")
		GameMode.setTimeMultiplier(1)
		timeTravelTimer = deviceMaxCharge
		
	elseif skyMode == "travel_forward" then
		party.party:setMovementSpeed(0)
		if sky:getFogRange()[2] > 1 then
			skyTimer = math.min((skyTimer + 0.5) + (skyTimer * 0.1), fog_base+fog_var)
			sky:setFogRange({0, math.max(fog_base + ((math.cos((t+0.5)/30*90) * fog_var)) - (skyTimer * 2),1)})
			GameMode.fadeOut(0xFFFFFF, 2)
			GameMode.setTimeMultiplier(math.max(0.5 - (skyTimer/850), 0.01))
		else
			party.party:shakeCamera(0.1,1)
			sky:setFogRange({0,1})
			GameMode.fadeOut(0xDDDDFF, 0.2)
			setSkyMode("travel_forward_end")
			delayedCall("functions2", 0.2, "teleportParty", party.level - 1)
			delayedCall("functions2", 0.5, "setSkyMode", "arrive_forward")
		end
	elseif skyMode == "arrive_forward" then
		if sky:getFogRange()[2] < 1 then
			skyTimer = math.max((skyTimer - 0.5) - (skyTimer * 0.02),0)
			sky:setFogRange({0, fog_base + ((math.cos((t+0.5)/30*90) * fog_var)) - (skyTimer * 2)})
			GameMode.fadeIn(0xFFFFFF, 2)
		else
			sky:setFogRange({1, fog_base + (math.cos((t+0.5)/30*90) * fog_var)})
			GameMode.fadeIn(0xDDDDFF, 0.5)
			delayedCall("functions2", 0.5, "setSkyMode", "arrive_forward_end")
		end
	elseif skyMode == "arrive_forward_end" then
		party.party:setMovementSpeed(1)
		skyTimer = 0
		setSkyMode("normal")
		GameMode.setTimeMultiplier(1)
		timeTravelTimer = 0
	end
	
	findEntity("beach_ocean_2"):getComponent("surface"):setOffset(vec(0, -1.4 + (math.cos((t+0.5)/30*90) * 0.2), 0))
	findEntity("beach_ocean_3"):getComponent("surface"):setOffset(vec(0, -1.4 + (math.cos((t+0.5)/30*90) * 0.2), 0))
	findEntity("beach_ocean_4"):getComponent("surface"):setOffset(vec(0, -1.4 + (math.cos((t+0.5)/30*90) * 0.2), 0))
end

function setGotDevice()
	gotDevice = true
end

checkIronKeyBurnBool = false
function checkIronKeyBurn(party, item)
	if not checkIronKeyBurnBool and item.go.id == "iron_key_1" then
		local c = math.ceil(math.random() * 4)		
		local damage = math.max(1 + (math.random() * 11) + party:getChampion(c):getHealth() * 0.2, 1)
		if party:getChampion(c):getHealth() < damage then
			party:getChampion(c):setHealth(party:getChampion(c):getHealth() + damage)
		end
		party:getChampion(c):damage(damage, "fire")
		party:getChampion(c):playDamageSound()
		checkIronKeyBurnBool = true
	end
end