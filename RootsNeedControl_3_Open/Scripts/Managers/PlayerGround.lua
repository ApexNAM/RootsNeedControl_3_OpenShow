PlayerGroundManager = {}

local playerGround_SPR_Array = {"assets/images/Other_SPRs/PlayerGround_SPR.png"}

function PlayerGroundManager:new()
    local current_Table = 
    {
        x = -love.graphics.getWidth(),
        y = 590,
        z = 1,
        width = love.graphics.getWidth(),
        playerGround_SPR = {}
    }

    setmetatable(current_Table, self)
    self.__index = self

    return current_Table
end

function PlayerGroundManager:Init()
    self.x = -love.graphics.getWidth()
    self.y = 590
    self.z = 1

    for i, v in ipairs(playerGround_SPR_Array) do
        self.playerGround_SPR[i] = love.graphics.newImage(v)
        self.playerGround_SPR[i]:setFilter("nearest", "nearest")
    end
end

function PlayerGroundManager:Update()
    
end

function PlayerGroundManager:draw()
    love.graphics.push()

    if not C_GameManager.isGameOver then
        love.graphics.draw(self.playerGround_SPR[1],self.x, self.y,0, self.width, 0.6)
    end
    
    love.graphics.pop()
end

function PlayerGroundManager:ReBoot()
    
end