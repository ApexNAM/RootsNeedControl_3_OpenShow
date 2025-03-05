local explosion_SPR_Array =
{
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0000.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0010.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0020.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0030.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0040.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0050.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0060.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0070.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0080.png",
    "assets/images/Effects_SPRs/Boom_SPRs/Boom_Rnc_Effect0090.png"
}

local explosion_SPR = {}

for i, v in ipairs(explosion_SPR_Array) do
    explosion_SPR[i] = love.graphics.newImage(v)
    explosion_SPR[i]:setFilter("nearest", "nearest")
end

ExplosionEffects = {}

function ExplosionEffects:new(x,y,w,h,r)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 2,
        r = r,
        w = w,
        h = h,
        tag = "Effect",
        explosion_idx = 1,
        isDestroyed = false,
        explosionTime = 0.0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function ExplosionEffects:Init()

end

function ExplosionEffects:Update()

    self.x = self.x + math.cos(self.r)
    self.y = self.y + math.sin(self.r)
    
    self.explosionTime = self.explosionTime + 1

    if self.explosionTime % 10 == 0 then
        self.explosion_idx = self.explosion_idx + 1
        self.explosionTime = 0.0
    end

    if self.explosion_idx > 9 then
        self.explosion_idx = 9
        self.isDestroyed = true
    end
end

function ExplosionEffects:draw()
    love.graphics.push()

    if not C_GameManager.isGameOver then
        love.graphics.draw(explosion_SPR[self.explosion_idx],self.x,self.y,self.r,self.w,self.h)
    end

    love.graphics.pop()
end

function ExplosionEffects:ReBoot()
    self.isDestroyed = true
end

-- 튜토리얼 전용

ExplosionEffects_Tutorial = {}

function ExplosionEffects_Tutorial:new(x,y,w,h,r)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 2,
        r = r,
        w = w,
        h = h,
        tag = "Effect",
        explosion_idx = 1,
        isDestroyed = false,
        explosionTime = 0.0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function ExplosionEffects_Tutorial:Init()

end

function ExplosionEffects_Tutorial:Update()

    self.x = self.x + math.cos(self.r)
    self.y = self.y + math.sin(self.r)
    
    self.explosionTime = self.explosionTime + 1

    if self.explosionTime % 10 == 0 then
        self.explosion_idx = self.explosion_idx + 1
        self.explosionTime = 0.0
    end

    if self.explosion_idx > 9 then
        self.explosion_idx = 9
        self.isDestroyed = true
    end
end

function ExplosionEffects_Tutorial:draw()
    love.graphics.push()

    love.graphics.draw(explosion_SPR[self.explosion_idx],self.x,self.y,self.r,self.w,self.h)

    love.graphics.pop()
end

function ExplosionEffects_Tutorial:ReBoot()
    self.isDestroyed = true
end