StarField = { }

function StarField:new()
    local current_Table = 
    {
        stars = {},

        starcount = 100,
        maxDistance = 150,
        center_x = 755,
        center_y = 450,
    }

    setmetatable(current_Table, self)
    self.__index = self

    return current_Table
end

function StarField:Init()
    local range = 12500

    for i=1, self.starcount do
        local xp = math.floor(range - math.random(range * 2))
        local yp = math.floor(range - math.random(range * 2))
        local zp = math.random(self.maxDistance)

        table.insert(self.stars, {x=xp,y=yp,z=zp})
    end
end

function StarField:draw()
    for i=1, #self.stars do
        self.stars[i].z = self.stars[i].z - 1

        if self.stars[i].z <= 0 then
            self.stars[i].z = self.maxDistance
        end

        local cz = self.stars[i].z

        local cx = self.stars[i].x / cz
        local cy = self.stars[i].y / cz

        if cx < -self.center_x or cx > self.center_x then
            self.stars[i].z = self.maxDistance
        end

        if cy < -self.center_y or cy > self.center_y then
            self.stars[i].z = self.maxDistance
        end


        if not C_GameManager.isGameOver then
            love.graphics.setColor(love.math.colorFromBytes(C_GameManager.current_Col_R,C_GameManager.current_Col_G,C_GameManager.current_Col_B))
            love.graphics.circle("fill",self.center_x + cx, self.center_y + cy, 2.5)
        end
    end
end

function StarField:ReBoot()
    for i=#self.stars, 1, -1 do
        table.remove(self.stars, i)
    end
end