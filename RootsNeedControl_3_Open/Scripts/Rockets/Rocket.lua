require("Scripts.Managers.DebugDrawManager")

local rocket_SPR_Array = 
{
    "assets/images/Other_SPRs/ROCK_SPR_LEFT.png",
    "assets/images/Other_SPRs/ROCK_SPR_RIGHT.png"
}

local rocket_new_SPR_Array = 
{
    "assets/images/Other_SPRs/ROCK_SPR_LEFT_2.png",
    "assets/images/Other_SPRs/ROCK_SPR_RIGHT_2.png"
}

local rocket_new_SPR_Daeduck_Array = 
{
    "assets/images/Other_SPRs/ROCK_SPR_LEFT_3.png",
    "assets/images/Other_SPRs/ROCK_SPR_RIGHT_3.png"
}

local rocket_SPR = {}
local rocket_new_SPR = {}
local rocket_new_SPR_Daeduck = {}

for i, v in ipairs(rocket_SPR_Array) do
    rocket_SPR[i] = love.graphics.newImage(v)
    rocket_SPR[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(rocket_new_SPR_Array) do
    rocket_new_SPR[i] = love.graphics.newImage(v)
    rocket_new_SPR[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(rocket_new_SPR_Daeduck_Array) do
    rocket_new_SPR_Daeduck[i] = love.graphics.newImage(v)
    rocket_new_SPR_Daeduck[i]:setFilter("nearest", "nearest")
end


Rocket = {}

function Rocket:new(x,y,MoveSpeed,isRight)
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

function Rocket:Init()
    self.isDestroyed = false
end

function Rocket:Update()

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
end

function Rocket:OnCollisonHit(target, w,h)
    if target.x + w > self.x and target.x < self.x + 8 and
       target.y + h > self.y and target.y < self.y + 8 then

        return true
    end

    return false
end

function Rocket:draw()
    love.graphics.push()
    
    local width, height = rocket_SPR[1]:getDimensions()

    if not C_GameManager.isGameOver then
        if self.isRight then
            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(rocket_SPR[2],self.x,self.y,0,1,1,width / 2, height / 2)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(rocket_new_SPR[2],self.x,self.y,0,1,1,width / 2, height / 2)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(rocket_new_SPR_Daeduck[2],self.x,self.y,0,1,1,width / 2, height / 2)
            else
                love.graphics.draw(rocket_SPR[2],self.x,self.y,0,1,1,width / 2, height / 2)
            end
        else

            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(rocket_SPR[1],self.x,self.y,0,1,1,width / 2, height / 2)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(rocket_new_SPR[1],self.x,self.y,0,1,1,width / 2, height / 2)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(rocket_new_SPR_Daeduck[1],self.x,self.y,0,1,1,width / 2, height / 2)
            else
                love.graphics.draw(rocket_SPR[1],self.x,self.y,0,1,1,width / 2, height / 2)
            end
        end
    end
    
    if Debug_Manager.debugMode then
        love.graphics.translate(self.x, self.y)
        love.graphics.rectangle("line",-width / 2,-height / 2,32,32)
    end

    love.graphics.pop()
end

function Rocket:ReBoot()
    self.isDestroyed = true
end
