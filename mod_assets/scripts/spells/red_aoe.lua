defineObject{
	name = "red_aoe",
	components = {
		{
			class = "Model",
			model = "mod_assets/models/effects/red_aoe.fbx",
			offset = vec(0, 0.05, 0),
		},
		{
            class = "Model",
            name = "model2",
			model = "mod_assets/models/effects/red_aoe.fbx",
			offset = vec(0, -0.15, 0),
		},
		{
			class = "Light",
			offset = vec(0, 0.05, 0),
			range = 6,
			color = vec(1.0, 0.25, 0.1),
			brightness = 10,
			castShadow = false,
            fillLight = true,
            onInit = function(self)
                self.go:playSound("monster_cast")
            end,
            onUpdate = function(self)
				local t = self.go.life:getValue() / 20
                self.go.model:setRotationAngles(0,t,0)
                self.go.model2:setRotationAngles(0,-t/2,0)
                
                local m = self.go.data:get("m")
                local scale = 1.0 + (math.cos(t/10) * 0.0095)
                m.x = m.x * scale
                m.y = m.y * scale
                m.z = m.z * scale
                m.w = m.w * scale
                self.go:setWorldRotation(m)
                self.go.life:increment()

                if t*20 > 15 then
                    local y = (self.go.data:get("y") or self.go.data:get("startY")) + 0.001
                    y = y - (0.01 * t * 20 * 0.05)
                    self.go.data:set("y", y)
                    self.go:setWorldPositionY(y)
                    if t*20 > 35 then
                        self.go:destroy()
                    end
                end
            end,
        },
        {
			class = "Script",
			name = "data",
			source = [[data = {}
function get(self,name) return self.data[name] end
function set(self,name,value) self.data[name] = value end]],
            onInit = function(self)
                local scale = 0.6
                local m = self.go:getWorldRotation()
                m.x = m.x * scale
                m.y = m.y * scale
                m.z = m.z * scale
                m.w = m.w * scale
                self.go:setWorldRotation(m)
				self.go.data:set("m", self.go:getWorldRotation())
				self.go.data:set("startY", self.go:getWorldPositionY())
			end,
		},
		{
			class = "Sound",
			sound = "monster_cast",
		},
		{
			class = "Counter",
			name = "life",
		},	
	},
	placement = "floor",
	editorIcon = 272,
	tags = { "obstacle" },
}

defineSound{
	name = "monster_cast",
	filename = "mod_assets/sounds/monster_cast.wav",
	loop = false,
	volume = 1,
	minDistance = 1,
	maxDistance = 10,
}