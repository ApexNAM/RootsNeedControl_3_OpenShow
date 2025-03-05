local rocket_SPR_Array = 
{
    "assets/images/Other_SPRs/ROCK_SPR_LEFT.png",
    "assets/images/Other_SPRs/ROCK_SPR_RIGHT.png"
}

local rocket_SPR = {}

for i, v in ipairs(rocket_SPR_Array) do
    rocket_SPR[i] = love.graphics.newImage(v)
    rocket_SPR[i]:setFilter("nearest", "nearest")
end

Rocket_Tut = {}

function Rocket_Tut:new(x,y,MoveSpeed,isRight)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 1,
        tag = "Rocket",
        MoveSpeed = MoveSpeed,
        isRight = isRight,
        isDestroyed = false,
        smokeTime = 0.0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function Rocket_Tut:Init()
    self.isDestroyed = false
end

function Rocket_Tut:Update()

    if self.isRight then
        self.x = self.x + self.MoveSpeed

        if self.x > 1600 then
            self.isRight = false
        end 
    else
        self.x = self.x - self.MoveSpeed

        if self.x < -30 then
            self.isRight = true
        end
    end

    if C_Tutorial_Level_Manager.current_Idx == 1 then
        if C_Tutorial_Level_Manager.tutorial_idx ~= 3 then
            self.isDestroyed = true
        end
    elseif C_Tutorial_Level_Manager.current_Idx == 2 then
    
        if C_Tutorial_Level_Manager.tutorial_idx ~= 5 then
            self.isDestroyed = true
        end
    end
end

function Rocket_Tut:OnCollisonHit(target, w,h)
    if target.x + w > self.x and target.x < self.x + 8 and
       target.y + h > self.y and target.y < self.y + 8 then

        return true
    end

    return false
end

function Rocket_Tut:draw()
    love.graphics.push()
    
    local width, height = rocket_SPR[1]:getDimensions()

    if self.isRight then
        love.graphics.draw(rocket_SPR[2],self.x,self.y,0,1,1,width / 2, height / 2)
    else
        love.graphics.draw(rocket_SPR[1],self.x,self.y,0,1,1,width / 2, height / 2)
    end

    love.graphics.pop()
end

function Rocket_Tut:ReBoot()
    self.isDestroyed = true
end