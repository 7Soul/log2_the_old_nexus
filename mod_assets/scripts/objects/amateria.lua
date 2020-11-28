
amateriaTimer = {
	class = "Timer",
	name = "amateriaTimer",
	triggerOnStart = true,
	timerInterval = 0.05,
	currentLevelOnly = true,
	onInit = function(self)
		self:setTriggerOnStart(true)
		self:setTimerInterval(0.05)
		self:setCurrentLevelOnly(true)
	end,
	onActivate = function(self)
	-- 	if self.go.level == party.level then
    --     -- Disables particles based on distance from party
    --     if self.go.amateriaParticles then
    --         local obj1 = party
    --         local obj2 = self.go
    --         local distance = math.abs(math.sqrt(((obj1.x - obj2.x) ^ 2) + ((obj1.y - obj2.y) ^ 2)))
            
    --         if distance > 0 then
    --             self.go.amateriaParticles:stop()
    --             if self.go.amateriaParticles2 then self.go.amateriaParticles2:stop() end
    --         else
    --             self.go.amateriaParticles:start()
    --             if self.go.amateriaParticles2 then self.go.amateriaParticles2:start() end
    --         end
    --     end
    --     -- Glitch
	-- 	local m = self.go.data.get("m")
	-- 	if m == nil then return false end
	-- 	local d = self.go.data.get("delay") or 0
	-- 	d = d - 0.1
	-- 	self.go.data.set("delay", d )

	-- 	if d > 0 then return false end

	-- 	if self.go.data.get("last_random1", r1) == nil then
    --         local r1,r2,r3,r4 = math.random(75,125) * 0.01, math.random(75,125) * 0.01, math.random(75,125) * 0.01, 1
	-- 		m.x = m.x * r1
	-- 		m.y = m.y * r2
	-- 		m.z = m.z * r3
	-- 		m.w = m.w * r4
	-- 		self.go:setWorldRotation(m)
	-- 		self.go.data.set("last_random1", r1)
	-- 		self.go.data.set("last_random2", r2)
	-- 		self.go.data.set("last_random3", r3)
	-- 		self.go.data.set("last_random4", r4)
	-- 		self.go.data.set("delay", 0 )
	-- 	else
	-- 		local r1 = self.go.data.get("last_random1")
	-- 		local r2 = self.go.data.get("last_random2")
	-- 		local r3 = self.go.data.get("last_random3")
	-- 		local r4 = self.go.data.get("last_random4")
	-- 		m.x = m.x / r1
	-- 		m.y = m.y / r2
	-- 		m.z = m.z / r3
	-- 		m.w = m.w / r4
	-- 		self.go:setWorldRotation(m)
	-- 		self.go.data.set("last_random1", nil)
	-- 		if math.random() < 0.2 then
	-- 			self.go.data.set("delay", math.random() * 1 )
	-- 		else
	-- 			self.go.data.set("delay", math.random(15,50) )
	-- 		end
    --     end
	-- end
	end,
}
