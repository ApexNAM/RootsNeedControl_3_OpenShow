WarRainCore = {}

local rainSPR_Array = 
{
    "assets/images/Rain_SPRs/RNC_RAIN_RED_SPR.png",
    "assets/images/Rain_SPRs/RNC_RAIN_WHITE_SPR.png"
}

local rainSPR = {}

for i, v in ipairs(rainSPR_Array) do
    rainSPR[i] = love.graphics.newImage(v)
    rainSPR[i]:setFilter("nearest", "nearest")
end

function WarRainCore:new(x,y)

    local current_Table = 
    {    
        x = x,
        y = y,
        z = 1,
        hp = 3,
        rainSPR_idx = 1,
        tag = "WarRain",
        isDestroyed = false,
        random_Speed = math.random(5,10)
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function WarRainCore:Init()
    self.random_Speed = math.random(3,5)
end

function WarRainCore:Update()
    self.y = self.y + self.random_Speed

    if self.y > 540 then
        Current_RNC_Camera:_Setter_Offset(0.5)
        self.isDestroyed = true 
    end

    if self.hp % 2 == 0 then
        self.rainSPR_idx = 2
    else
        self.rainSPR_idx = 1
    end
end

function WarRainCore:draw()
    love.graphics.push()

    if not C_GameManager.isGameOver then
        love.graphics.draw(rainSPR[self.rainSPR_idx],self.x,self.y,0,4,4)
    end

    if Debug_Manager.debugMode then
        love.graphics.rectangle("line",self.x,self.y,64,64)
    end

    love.graphics.pop()
end

function WarRainCore:ReBoot()
    self.isDestroyed = true 
end

function WarRainCore:Hit_Player(targetPlayer)

    if targetPlayer.x + 64 > self.x and targetPlayer.x < self.x + 16 and
       targetPlayer.y + 128 > self.y and targetPlayer.y < self.y + 16 then
        return true
    end

    return false
end

function WarRainCore:CollisionCrossHair()
    self.hp = self.hp - 1

    if self.hp < 0 and not self.isDestroyed then
        self.isDestroyed = true
    end
end