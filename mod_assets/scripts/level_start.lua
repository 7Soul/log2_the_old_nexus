editing = 0
xx,yy,zz = 0, 0, 0
xr,yr,zr = 0, 0, 0
posx = 0
posy = 0
posz = 0
rotx = 0
roty = 0
rotz = 0
gotDevice = false

function revealMap(noMobs)
	local startx, starty = party.x, party.y
	for x=0,31 do
		for y=0,31 do
			local zfloor = Dungeon.getMap(party.level):getElevation(x, y)
			
			if not Dungeon.getMap(party.level):isBlocked(x, y, zfloor) then
				party:setPosition(x, y, party.facing, zfloor, party.level)
			end
		end
	end
	party:setPosition(startx, starty, party.facing, party.elevation, party.level)

	if no_mobs then
		killAllMobs()
	end
end

function killAllMobs()
	for entity in Dungeon.getMap(party.level):allEntities() do
		if entity.monster then
			entity:destroy()
		end
	end
end

function start()
	print("functions2 initiated")
	
	-------------------
	-- Second Beach ---
	-------------------
	if second_beach_present_heightmap then
		local level = second_beach_present_heightmap.level
		skies[level] = second_beach_present_sky.id

		beach_rock_1x1_low_6.model:setOffset(vec(-1.5,-0.8,0))
		beach_rock_spire_4.model:setOffset(vec(-20,0,0))
		beach_rock_1x1_4.model:setOffset(vec(-20,1,-10))
		beach_rock_spire_5.model:setOffset(vec(40,0,0))
		beach_rock_2x1_9.model:setOffset(vec(-20,-2,-8))
	
		-- Area around wrecked ship --
		beach_boulder_3:setWorldPosition(beach_boulder_3:getWorldPosition() + vec(2.7,3.1,2.2)) -- present
		beach_boulder_3:setWorldRotationAngles(126,0,0) -- present
		Dungeon.getMap(1):setAutomapTile(24,18,0)
		
		beach_shipwreck_land_hull_1.model:setOffset(vec(0.27,-1.35,5.65))
		beach_shipwreck_land_hull_1.model:setRotationAngles(17.1,6.2,24.5)
		
		local pos = forest_ruins_pillar_fallen_1:getWorldPosition()
		forest_ruins_pillar_fallen_1:setWorldPosition(vec(pos.x + 1.77, pos.y + 0, pos.z - 2.03))
		forest_ruins_pillar_fallen_1:setWorldRotationAngles(0,67,0)
		
		beach_ocean_2:setWorldRotationAngles(0,45,0)
		
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
		beach_wall_button_5:setWorldPosition(beach_wall_button_5:getWorldPosition() + vec(0,0,-0.3)) -- present

		beach_rock_1x1_low_74:setWorldPosition(beach_rock_1x1_low_74:getWorldPosition() + vec(1.5,-0.4,1.6))
		beach_rock_1x1_low_74:setWorldRotationAngles(0,-45,0)
		beach_rock_1x1_low_75:setWorldPosition(beach_rock_1x1_low_75:getWorldPosition() + vec(1.6,3.8,1.5))
		beach_rock_1x1_low_75:setWorldRotationAngles(0,50,180)
		beach_lock_ornate_3:setWorldPosition(vec(20.86,-1.04,20.08))
		beach_lock_ornate_3:setWorldRotationAngles(70.4,-32.8,71.2)

		-- Time Device altar
		forest_altar_1:setWorldPosition(forest_altar_1:getWorldPosition() + vec(0,0,1.0))
		for _,entity in forest_altar_1.surface:contents() do
			if entity.go.name == "enchanted_timepiece" then
				local m = entity.go:getWorldPosition()
				entity.go:setWorldPosition(m + vec(0.2,0,1.25))
			end
		end
		timenote_1_1:setWorldPosition(timenote_1_1:getWorldPosition() + vec(0,0,1.2))
		beach_lock_ornate_1:setWorldPosition(beach_lock_ornate_1:getWorldPosition() + vec(0.12,-0.64,0.32))
		beach_lock_ornate_1:setWorldRotationAngles(16,25,9.6)

		-- items and objects
		wooden_box_2.model:setOffset(vec(-0.6,0.7,-0.6))
		wooden_box_2.model:setRotationAngles(-30,35,35)
		shovel_1.model:setOffset(vec(0.6,0.58,-0.0))
		shovel_1.model:setRotationAngles(45,-10,-90)
		beach_sandpile_1.model:setOffset(vec(-0.45,-0.35,2))	
		
		daemon_head_3:setWorldPosition(daemon_head_3:getWorldPosition() + vec(-0.27,0,0.0))
		mine_ceiling_lantern_4:setWorldPosition(mine_ceiling_lantern_4:getWorldPosition() + vec(-1.5,-0.7,0.9))
	end

	if second_beach_past_heightmap then
		local level = second_beach_past_heightmap.level
		skies[level] = second_beach_past_sky.id

		beach_ocean_3:setWorldRotationAngles(0,45,0)
		beach_boulder_7:setWorldPosition(beach_boulder_7:getWorldPosition() + vec(2.7,3.1,2.2)) -- present
		beach_boulder_7:setWorldRotationAngles(126,0,0) -- present
	end
	-------------------
	-- Minute Grotto --
	-------------------
	if minute_grotto_present_heightmap then
		local level = minute_grotto_present_heightmap.level
		skies[level] = minute_grotto_present_sky.id

		-- Move 3x1 rocks to cover ceiling
		for e in Dungeon.getMap(level):allEntities() do
			if e and e.name == "beach_rock_3x1" then
				local m = e:getWorldPosition()
				e:setWorldPosition(m + vec(-5,5,-2.7))
				e:setWorldRotationAngles(104,0,96)
			end
		end
		
		beach_rock_1x1_low_38:setWorldPosition(beach_rock_1x1_low_38:getWorldPosition() + vec(1.5,-0.4,1.6))
		beach_rock_1x1_low_38:setWorldRotationAngles(0,-45,0)
		beach_rock_1x1_low_39:setWorldPosition(beach_rock_1x1_low_39:getWorldPosition() + vec(1.6,3.8,1.5))
		beach_rock_1x1_low_39:setWorldRotationAngles(0,50,180)	
		beach_high_rock_pillar_01_10:setWorldPosition(beach_high_rock_pillar_01_10:getWorldPosition() + vec(0.75,0.75,0.4))
		
		-- Items --
		throwing_knife_2:setWorldPosition(vec(30.19,1.27,35.73))
		throwing_knife_2:setWorldRotationAngles(115,133,-40)
		note_1:setWorldPosition(vec(30.07,1.00,35.89))
		note_1:setWorldRotationAngles(87.2,26.4,-2.4)
		iron_key_1:setWorldPosition(vec(36.05,-0.14,70.51))
		iron_key_1:setWorldRotationAngles(33,62,23)
	end

	if minute_grotto_past_heightmap then
		local level = minute_grotto_past_heightmap.level
		skies[level] = minute_grotto_past_sky.id

		-- Move 3x1 rocks to cover ceiling
		for e in Dungeon.getMap(level):allEntities() do
			if e and e.name == "beach_rock_3x1" then
				local m = e:getWorldPosition()
				e:setWorldPosition(m + vec(-5,5,-2.7))
				e:setWorldRotationAngles(104,0,96)
			end
		end
	end
	
	--------------------
	-- Bridge of Ages --
	--------------------
	if bridge_of_eras_present_heightmap then
		local level = bridge_of_eras_present_heightmap.level
		skies[level] = bridge_of_eras_present_sky.id

		short_bow_1:setWorldPosition(vec(73.55,0.76,32.91))
		short_bow_1:setWorldRotationAngles(101,-2.4,72)
		short_bow_1.gravity:disable()	
		arrow_1:setWorldPosition(vec(73.26,0.36,32.69))
		arrow_1:setWorldRotationAngles(13.6,13.6,55.2)
		arrow_1.gravity:disable()
		arrow_2:setWorldPosition(vec(73.58,0.47,32.81))
		arrow_2:setWorldRotationAngles(75.2,6.4,81.6)
		arrow_2.gravity:disable()
		arrow_3:setWorldPosition(vec(48.34,0.53,34.98))
		arrow_3:setWorldRotationAngles(11.2,-36,84.8)
		arrow_3.gravity:disable()
		lock_round_1:setWorldPosition(vec(69.11,0.06,21))

		local entity = findEntity("forest_old_oak_28")
		local pos = entity:getWorldPosition()
		entity:setWorldPosition(vec(pos.x + 0.4, pos.y + 3.0, pos.z - 0.1))
		entity:setWorldRotationAngles(0,270+55,0)
		local m = entity:getWorldRotation()
		local scale = 2.8
		m.x = m.x * scale
		m.y = m.y * scale
		m.z = m.z * scale
		m.w = m.w * scale
		entity:setWorldRotation(m)
		
		for i=1,11 do
			entity = findEntity("giant_tree_"..i)
			if entity then
				local scale = 3
				m = entity:getWorldRotation()
				m.x = m.x * scale
				m.y = m.y * scale
				m.z = m.z * scale
				m.w = m.w * scale
				entity:setWorldRotation(m)
			end

			entity = findEntity("giant_tree_corner_"..i)
			if entity then
				m = entity:getWorldRotation()
				m.x = m.x * 4
				m.y = m.y * 4
				m.z = m.z * 4
				m.w = m.w * 4
				entity:setWorldRotation(m)
				local pos = entity:getWorldPosition()
				entity:setWorldPosition(vec(pos.x + 1.5, pos.y, pos.z - 1.5))
			end

			entity = findEntity("bridge_pillar_sound_"..i)
			if entity then 
				if i < 7 then
					local pos = entity:getWorldPosition()
					entity:setWorldPosition(vec(pos.x + 0, pos.y - 1, pos.z + 0))
				else
					local pos = entity:getWorldPosition()
					entity:setWorldPosition(vec(pos.x + 0.6, pos.y - 1, pos.z + 0.6))
				end
			end
		end

		for i=1,4 do
			-- findEntity("demo_pillar_"..i):setWorldPosition(vec(81, 0, 59.4 + (i*3) - 3))
			-- findEntity("demo_button_1_"..i):setWorldPosition(vec(80.87, 0, 59.4 + (i*3) - 3))
			findEntity("gate_demo_1_"..i.."_bot"):setWorldPosition(findEntity("gate_demo_1_"..i.."_top"):getWorldPosition() + vec(0,-0.5,0))
		end
	end

	if bridge_of_eras_past_heightmap then
		local level = bridge_of_eras_past_heightmap.level
		skies[level] = bridge_of_eras_past_sky.id

	end
	
	--------------------
	--  Ruined City   --
	--------------------
	if ruined_city_present_heightmap then
		local level = ruined_city_present_heightmap.level
		skies[level] = ruined_city_present_sky.id

		mine_ceiling_lantern_6:setWorldPosition(vec(7.5,-0.25,39))
		forest_lantern_blue_4:setWorldPosition(vec(14.6,-3,46.5))
		city_lock_ornate_1:setWorldPosition(vec(75.4,0,82.5))
		turnButton:setWorldPosition(vec(51.3,0,70.5))
	end

	if ruined_city_past_heightmap then
		local level = ruined_city_past_heightmap.level
		skies[level] = ruined_city_past_sky.id

		mine_ceiling_lantern_6:setWorldPosition(vec(7.5,-0.25,39))
		forest_lantern_blue_4:setWorldPosition(vec(14.6,-3,46.5))
		city_lock_ornate_1:setWorldPosition(vec(75.4,0,82.5))
		turnButton:setWorldPosition(vec(51.3,0,70.5))
	end
	
	--------------------
	--  Unnamed Cave  --
	--------------------
	if blowpipe_1 then
		blowpipe_1:setWorldPosition(vec(5.5,0.51,30.19))
		blowpipe_1:setWorldRotationAngles(0,5.6,104)
	end
	
	------------------------
	--  Castle Courtyard  --
	------------------------
	if forest_fountain_1 then
		forest_fountain_1:setWorldPosition(vec(45,0,66))
		-- forest_plant_cluster_01_67.model:setEmissiveColor(vec(0.05,-0.02,-0.01))
		-- forest_spruce_sapling_01_16.model:setEmissiveColor(vec(0.05,-0.02,-0.01))
		-- for i=8,19 do
		-- 	local e = findEntity("forest_oak_cluster_noicon_"..i)
		-- 	local v = math.random(-2.2,-2.9)
		-- 	e:setWorldPosition(e:getWorldPosition() + vec(0, v, 0))
		-- end
	end
	
	-------------------------
	-- Century Battlefield --
	-------------------------
	if deco_sword_1 then
		for i=1,72 do
			local sword = findEntity("deco_sword_"..i) 
			if sword then
			local pos = sword:getWorldPosition()
			if sword.facing == 0 or sword.facing == 2 then
				pos.x = pos.x - 1.4 + (math.random() * 2.8)
				pos.z = math.floor((pos.z - 0.0 + (math.random() * 3)) / 3) * 3
			else
				pos.z = pos.z - 1.4 + (math.random() * 2.8)
				pos.x = math.floor((pos.x - 0.0 + (math.random() * 3)) / 3) * 3
			end
			--for entity in Dungeon.getMap(sword.level):entitiesAt(sword.x, sword.y) do
				--while sword.x == entity.x and sword.y == entity.y do 
					--findEntity("deco_sword_"..i):setWorldPosition(vec(math.floor((57 + math.random() * 30) / 3) * 3, 0.11 + math.random() * 0.45, math.floor((50 + math.random() * 30) / 3) * 3))
					sword:setWorldPosition(pos.x, pos.y + math.random() * 0.4, pos.z)
					sword:setWorldRotationAngles(math.random() * 360, -15 + math.random() * 30, 75 + math.random() * 30)
					local m = sword:getWorldRotation()
					local scale = 1 + (math.random() * 0.5)
					m.x = m.x * scale
					m.y = m.y * scale
					m.z = m.z * scale
					m.w = m.w * scale
					sword:setWorldRotation(m)
				--end
			--end
			end
		end
		local m = dead_crystal_1:getWorldRotation()
		local scale = 1.6
		m.x = m.x * scale
		m.y = m.y * scale
		m.z = m.z * scale
		m.w = m.w * scale
		dead_crystal_1:setWorldRotation(m)
	end

	-- Mark potions for the Perfect Mix perk
	for map = 1, 12 do
		for entity in Dungeon.getMap(map):allEntities() do
			if entity and entity.item then
				if entity.item:hasTrait("potion") and entity.potion_stack then
					for s = 1, entity.item:getStackSize() do
						entity.potion_stack:insert("normal")
					end
				end

				local container = entity.containeritem
				if container then
					local capacity = container:getCapacity()
					for j=1,capacity do
						local item2 = container:getItem(j)
						if item2 and item2:hasTrait("potion") and item2.go.potion_stack then
							for s = 1, item2:getStackSize() do
								item2.go.potion_stack:insert("normal")
							end
						end
					end
				end
			end	
			if entity then
				local surface = entity.surface
				if surface and entity.name ~= "beach_ocean" then
					for index, item2 in surface:contents() do
						if item2 and item2:hasTrait("potion") and item2.go.potion_stack then
							for s = 1, item2:getStackSize() do
								item2.go.potion_stack:insert("normal")
							end
							-- print(item2.go.id)
						end
					end
				end
			end
		end
	end

	for i=1,4 do
		local champion = party.party:getChampionByOrdinal(i)
		for j=1,32 do
			local item = champion:getItem(j)
			if item and item.go.potion_stack then
				for s = 1, item:getStackSize() do
					item.go.potion_stack:insert("normal")
				end
			end
		end
	end
	if objname then
		if objname2 then
			-- Model within object
			local pos = findEntity(objname):getComponent(objname2):getOffset()
			posx = pos.x
			posy = pos.y
			posz = pos.z
		else
			-- Object
			local pos = findEntity(objname):getWorldPosition()
			posx = pos.x
			posy = pos.y
			posz = pos.z
		end
		local rot = vec(0, 0, 0)
		rotx = rot.x
		roty = rot.y
		rotz = rot.z
	end
end

--------------------------------------------------------------------------
-- Offset and Rotate Level Object                                       --
--------------------------------------------------------------------------

objname = "beach_lock_ornate_3"
objname2 = nil

function move(x,y,z)
	if objname then
		xx = xx + x*1
		yy = yy + y*1
		zz = zz + z*1
		if objname2 then
		-- Model within object
		findEntity(objname):getComponent(objname2):setOffset(vec(posx + xx, posy + yy, posz + zz))
		print("Offset: ", findEntity(objname):getComponent(objname2):getOffset())
		else
		-- Object
		findEntity(objname):setWorldPosition(vec(posx + xx, posy + yy, posz + zz))
		print("Offset: ", findEntity(objname).x * 3, findEntity(objname).y * 3 )
		print("Offset: ", findEntity(objname):getWorldPosition())
		end
	end
end

function rotate(x,y,z)
	if objname then
		xr = xr + x*8
		yr = yr + y*8
		zr = zr + z*8
		if objname2 then
		-- Model within object
		findEntity(objname):getComponent(objname2):setRotationAngles(rotx + xr, roty + yr, rotz + zr)
		else
		-- Object
		findEntity(objname):setWorldRotationAnglesWithOrder(xr, yr, zr, "xyz")
		end
		print("Rotation: ", rotx + xr, roty + yr, rotz + zr)
	end
end

function debug()
	if objname then
		print(objname .. "'s components:")
		for _,c in findEntity(objname):componentIterator() do
			print(c:getName())
		end
		findEntity(objname).model:setDebugDraw(true)
	end
end


----------------------------------------
--------- Time Travel Effect -----------
----------------------------------------

skyMode = "normal"
skyTimer = 0
timeTravelTimer = 0
deviceMaxCharge = 5
travel_mode = ""
travel_crystal = {}
destination = {}
skies = {}
travel_path = {}

function setSkyMode(n, d)
	if not d then d = {} end
	skyMode = n
	destination = d
	if n == "travel_back_end" then
		playSound("teleport")
	end
	if n == "travel_forward_end" then
		playSound("teleport")
	end
end

function updateTimeTravelTimer(n)
	timeTravelTimer = round(n)
	local location = { party.x, party.y, party.elevation }
	travel_path[#travel_path+1] = location
	
	if timeTravelTimer >= 5 then
		tryTimeTravel("timer")
	end
end

function tryTimeTravel(type)
	if functions2.script.skyMode ~= "normal" then return false end
	if type == "device" or type == "teleporter" then 
		travel_path = { { party.x, party.y, party.elevation } }
	end
	local period = party.data:get("period") or "present"
	local offset = period == "present" and 1 or -1

	-- Locate crystal to keep device charged at the other time period
	if type == "device" then
		travel_crystal = {}
		local dx,dy = getForward(party.facing)
		for e in Dungeon.getMap(party.level):entitiesAt(party.x + dx, party.y + dy) do
			if e and (e.name == "healing_crystal" or e.name == "dead_crystal") then
				travel_crystal[1] = e.x
				travel_crystal[2] = e.y
				travel_crystal[3] = e.elevation
				travel_crystal[4], travel_crystal[5], travel_crystal[6] = e.map:getLevelCoord()
			end
		end
	end

	local obstacle = false
	local elevation = false
	local platform = false
	local d = {}
	
	-- Check if the party's position in the other time period is valid
	if #travel_path ~= 0 then
		for i=#travel_path,1,-1 do
			obstacle = Dungeon.getMap(party.level + offset):isBlocked(travel_path[i][1], travel_path[i][2], travel_path[i][3]) or false
			elevation = Dungeon.getMap(party.level + offset):getElevation(travel_path[i][1], travel_path[i][2]) == travel_path[i][3]
			platform = false
			for e in Dungeon.getMap(party.level + offset):entitiesAt(travel_path[i][1], travel_path[i][2]) do
				if e.platform and e.elevation == travel_path[i][3] then platform = true end
			end
			if ((not obstacle and elevation) or (not obstacle and platform)) and #travel_crystal ~= 0 then
				d = travel_path[i]
				break 
			end
		end
	end

	-- Check if target location is at floor level or a platform and no obstacles are there
	if ((not obstacle and elevation) or (not obstacle and platform)) and #travel_crystal ~= 0 then
		if period == "present" then
			party.data:set("period", "past")
			playSound("time_1")
			setSkyMode("travel_back", d)
		else
			party.data:set("period", "present")
			playSound("time_2")
			setSkyMode("travel_forward", d)
		end
		travel_mode = type
		travel_path = { { party.x, party.y, party.elevation } }
	else
		if type == "device" then
			hudPrint("The coordinates of your destination are unsafe.")
		end
	end

	if #travel_crystal == 0 then
		hudPrint("A crystal is necessary to travel.")
		return false
	end
end

function teleportParty(level, x, y, elevation)
	party:setPosition(x, y, party.facing, elevation, level)
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
	if not skies[party.level] then return false end
	local x,y,z = destination[1], destination[2], destination[3]
	local sky = findEntity(skies[party.level]).sky
	local fog_min = 1
	local fog_base = 440
	local fog_var = 350
	if string.match(sky.go.name, "past") then
		fog_base = fog_base - 50
	end

	if sky.go == bridge_of_eras_present_sky then
		fog_min = 5
		fog_base = 11
		fog_var = 1
	elseif sky.go == bridge_of_eras_past_sky then
		fog_min = 5
		fog_base = 11
		fog_var = 1
	end
	-- print("timer: " .. skyTimer .. " / mode: " .. skyMode)
	-- print(sky:getFogRange()[1] .. " / " .. sky:getFogRange()[2])
	if skyMode == "normal" then
		skyTimer = 0
		if (sky.go == bridge_of_eras_present_sky or sky.go == bridge_of_eras_past_sky) then
			sky:setFogRange({fog_min, fog_base})
		else
			sky:setFogRange({1, fog_base + (math.cos((t+0.5)/30*90) * fog_var)})
		end
	elseif skyMode == "travel_back" then
		party.party:setMovementSpeed(0)
		if sky:getFogRange()[2] > 1 then
			skyTimer = math.min(skyTimer + ((2.5 + (skyTimer * 0.02)) * 2), fog_base+fog_var)
			sky:setFogRange({0, math.max(fog_base + ((math.cos((t+0.5)/30*90) * fog_var)) - (skyTimer * 2),1)})
			-- GameMode.fadeOut(0xFFFFFF, 1.0)
			-- GameMode.setTimeMultiplier(math.max(0.5 - (skyTimer/500), 0.02))
			GameMode.setTimeMultiplier(0.5)
		else			
			party.party:shakeCamera(0.1,1)
			sky:setFogRange({0,1})
			-- GameMode.fadeOut(0xDDDDFF, 0.2)
			setSkyMode("travel_back_end")
			delayedCall("functions2", 0.1, "teleportParty", party.level + 1, x, y, z)
			delayedCall("functions2", 0.15, "setSkyMode", "arrive_back")
		end
	elseif skyMode == "arrive_back" then
		if sky:getFogRange()[2] < 1 then
			skyTimer = math.max(skyTimer - (2.5 + (skyTimer * 0.05)), 0)
			sky:setFogRange({0, fog_base + ((math.cos((t+0.5)/30*90) * fog_var)) - (skyTimer * 2)})
			-- GameMode.fadeIn(0xFFFFFF, 1.0)
		else
			sky:setFogRange({1, fog_base + (math.cos((t+0.5)/30*90) * fog_var)})
			-- GameMode.fadeIn(0xDDDDFF, 0.3)
			delayedCall("functions2", 0.1, "setSkyMode", "arrive_back_end")
		end
	elseif skyMode == "arrive_back_end" then
		party.party:setMovementSpeed(1)
		skyTimer = 0
		setSkyMode("normal")
		GameMode.setTimeMultiplier(1)
		timeTravelTimer = 1
		
	elseif skyMode == "travel_forward" then
		party.party:setMovementSpeed(0)
		if sky:getFogRange()[2] > 1 then
			skyTimer = math.min(skyTimer + ((2.5 + (skyTimer * 0.02)) * 2), fog_base+fog_var)
			sky:setFogRange({0, math.max(fog_base + ((math.cos((t+0.5)/30*90) * fog_var)) - (skyTimer * 2),1)})
			-- GameMode.fadeOut(0xFFFFFF, 2)
			-- GameMode.setTimeMultiplier(math.max(0.5 - (skyTimer/850), 0.01))
			GameMode.setTimeMultiplier(0.5)
		else
			party.party:shakeCamera(0.1,1)
			sky:setFogRange({0,1})
			-- GameMode.fadeOut(0xDDDDFF, 0.2)
			setSkyMode("travel_forward_end")
			delayedCall("functions2", 0.1, "teleportParty", party.level - 1, x, y, z)
			delayedCall("functions2", 0.15, "setSkyMode", "arrive_forward")
		end
	elseif skyMode == "arrive_forward" then
		if sky:getFogRange()[2] < 1 then
			skyTimer = math.max(skyTimer - (2.5 + (skyTimer * 0.05)), 0)
			sky:setFogRange({0, fog_base + ((math.cos((t+0.5)/30*90) * fog_var)) - (skyTimer * 2)})
			-- GameMode.fadeIn(0xFFFFFF, 2)
		else
			sky:setFogRange({1, fog_base + (math.cos((t+0.5)/30*90) * fog_var)})
			-- GameMode.fadeIn(0xDDDDFF, 0.5)
			delayedCall("functions2", 0.1, "setSkyMode", "arrive_forward_end")
		end
	elseif skyMode == "arrive_forward_end" then
		party.party:setMovementSpeed(1)
		skyTimer = 0
		setSkyMode("normal")
		GameMode.setTimeMultiplier(1)
		timeTravelTimer = 0
	end

	-- Wave motion for oar boat and sack
	if beach_ocean_2 then
		findEntity("beach_ocean_2"):getComponent("surface"):setOffset(vec(0, -1.4 + (math.cos((t+0.5)/30*90) * 0.2), 0))
		findEntity("beach_ocean_3"):getComponent("surface"):setOffset(vec(0, -1.4 + (math.cos((t+0.5)/30*90) * 0.2), 0))
		findEntity("beach_ocean_4"):getComponent("surface"):setOffset(vec(0, -1.4 + (math.cos((t+0.5)/30*90) * 0.2), 0))
		findEntity("beach_oar_boat_1").model:setOffset(vec(0, 0.6 + ((math.cos((t+0.5)/30*90) * 0.2) + (math.cos(party.gametime2:getValue()/100)*0.1) ), 0))
		findEntity("beach_oar_boat_1").model:setRotationAngles( math.cos((party.gametime2:getValue()+20) / 50) * 4.0 , 10 + t, 0)
	end
	-- 
	if sack_5 then 
		if not functions.script.get("got_starting_sack") then
			sack_5:setWorldPosition(vec(82.66,-1.45 + ((math.cos((t+0.5)/30*90) * 0.2) + (math.cos(party.gametime2:getValue()/100)*0.1) + (math.cos((party.gametime2:getValue()+20) / 50) * -0.05) ),87.8))
		end
	else
		functions.script.set("got_starting_sack", true)
	end
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

function multiply( m1, m2 )
    if #m1[1] ~= #m2 then       -- inner matrix-dimensions must agree
        return nil
    end 
 
    local res = {}
 
    for i = 1, #m1 do
        res[i] = {}
        for j = 1, #m2[1] do
            res[i][j] = 0
            for k = 1, #m2 do
                res[i][j] = res[i][j] + m1[i][k] * m2[k][j]
            end
        end
    end
 
    return res
end

function round(n)
	return math.floor(n * 1 + 0.5) / 1
end