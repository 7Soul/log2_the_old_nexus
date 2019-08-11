shape = { false, false, false, false, 
          false, false, false, false, 
          false, false, false, false, 
          false, false, false, false }

function activate(sender)
    local block = nil
    local shape1 = { {2,1}, {1,2}, {2,2}, {3,2}, {2,3} }
    local shape2 = { {1,1}, {2,1}, {3,1} }
    local pushableCenterAt = {8,13}
    local bridgeAt = {12,13}
    local bridgeArea = 4

    for i = 1, 16 do
        local e = findEntity("mbridge_"..i)
        shape[i] = false
    end

    for p = 1, 2 do
        block = findEntity("pushable"..p)

        local x, y = 0
        for yy = 0, bridgeArea-1 do
            for xx = 0, bridgeArea-1 do
                x = bridgeAt[1] + xx
                y = bridgeAt[2] + yy
                rbx = block.x - pushableCenterAt[1] - 1
                rby = block.y - pushableCenterAt[2] - 1
                index = ((yy * 4) + (xx + 1))
                tx = ((yy - rby) * 3) + (xx - rbx + 1)

                local id = index
                local e = findEntity("mbridge_"..id)
                if e then
                    if p == 1 then
                        for shapeloop1 = 1, #shape1 do
                            local ex = e.x - bridgeAt[1] + 1
                            local ey = e.y - bridgeAt[2] + 1
                            if ex == shape1[shapeloop1][1] + rbx and ey == shape1[shapeloop1][2] + rby then
                                shape[index] = true
                            end
                        end
                    elseif p == 2 then
                        for shapeloop2 = 1, #shape2 do
                            local ex = e.x - bridgeAt[1] + 1
                            local ey = e.y - bridgeAt[2] + 1
                            if ex == shape1[shapeloop2][1] + rbx and ey == shape1[shapeloop2][2] + rby then
                                shape[index] = true
                            end
                        end
                    end
                end
            end
        end
        for i = 1, #shape do
            local e = findEntity("mbridge_"..i)
            if e then 
                if shape[i] then
                    e.controller:activate()
                else
                    e.controller:deactivate()
                end
            end
        end
    end
end

function deactivate(sender)
    

end