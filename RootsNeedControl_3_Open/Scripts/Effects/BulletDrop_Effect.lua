local bullet_Drop_SPR_Array = 
{
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0000.png",
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0010.png",
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0020.png",
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0030.png",
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0040.png",
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0050.png",
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0060.png",
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0070.png",
    "assets/images/Bullet_Drop_SPRs/RNC_Bullet_Drop_SPR0080.png"
}   

local bullet_Drop_SPR = {}

for i, v in ipairs(bullet_Drop_SPR_Array) do
    bullet_Drop_SPR[i] = love.graphics.newImage(v)
    bullet_Drop_SPR[i]:setFilter("nearest", "nearest")
end

Bullet_Drop_Effect = {}

function Bullet_Drop_Effect:new(x,y,r)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 5,
        r = r,
        w = 2,
        h = 2,
        tag = "Effect",
        isDestroyed = false,
        dropSpeed = 5,
        drop_idx = 1,
        drop_Time = 0.0,
        gravity = 5500,
        vy = 0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function Bullet_Drop_Effect:Init()

end

function Bullet_Drop_Effect:Update()

    self.dropSpeed = self.dropSpeed - 0.1

    if self.dropSpeed < 0 then
        self.dropSpeed = 0
    end

    self.x = self.x + self.dropSpeed
    
    self.y = self.y + self.vy * love.timer.getDelta()
    self.vy = self.vy + self.gravity * love.timer.getDelta()

    self.r = love.timer.getTime()

    if self.y > 2000 then
        self.isDestroyed = true
    end

    self.drop_Time = self.drop_Time + 1

    if self.drop_Time % 8 == 0 then
        self.drop_idx = self.drop_idx + 1
        self.drop_Time = 0.0
    end

    if self.drop_idx >= 9 then
        self.isDestroyed = true
    end
end

function Bullet_Drop_Effect:draw()

    local width, height = bullet_Drop_SPR[1]:getDimensions()

    if not C_GameManager.isGameOver then
        love.graphics.draw(bullet_Drop_SPR[self.drop_idx],self.x,self.y,self.r,0.5,0.5,width / 2, height / 2)
    end
end

function Bullet_Drop_Effect:ReBoot()
    self.isDestroyed = true
end