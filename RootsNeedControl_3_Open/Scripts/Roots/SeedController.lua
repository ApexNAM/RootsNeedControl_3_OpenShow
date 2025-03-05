SeedCore = {}

local seed_SPR = {}
local seed_SPR_Array = {"assets/images/Other_SPRs/START_WATER_BALL_SPR.png"}

for i, v in ipairs(seed_SPR_Array) do
    seed_SPR[i] = love.graphics.newImage(v)
    seed_SPR[i]:setFilter("nearest", "nearest")
end

function SeedCore:new(x,y)

    local current_Table = 
    {
        x = x,
        y = y,
        z = 1,
        isShow = false,
        seed_SPR = {}
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function SeedCore:Init()
    self.isShow = false
end

function SeedCore:Update()

    if self.isShow then
        if self.y < 550 then
            self.y = self.y + 5
        end
    end
end

function SeedCore:draw()
    love.graphics.push()

    if self.isShow then
        love.graphics.draw(seed_SPR[1],self.x - 16,self.y,0,2,2)
    end

    love.graphics.pop()
end

function SeedCore:IsPlayerCoreEnabled()
    if self.y >= 550 then
        return true 
    end

    return false
end

function SeedCore:ReBoot(x,y)
    self.x = x or 0
    self.y = y or 0
    self.z = 1
    
    self.isShow = true
end