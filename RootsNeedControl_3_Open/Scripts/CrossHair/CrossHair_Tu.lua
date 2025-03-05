local crossHair_SPR_Array = 
{
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_01.png"
}

local crossHair_SPR_Side_Array =
{
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_SIDE1.png",
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_SIDE2.png"
}

local crossHairSPR = {}
local crossHairSide_SPR = {}

for i, v in ipairs(crossHair_SPR_Array) do
    crossHairSPR[i] = love.graphics.newImage(v)
    crossHairSPR[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(crossHair_SPR_Side_Array) do
    crossHairSide_SPR[i] = love.graphics.newImage(v)
    crossHairSide_SPR[i]:setFilter("nearest", "nearest")
end

CrossHair_Tut = {}

function CrossHair_Tut:new(speed, setPower, playerTarget, warRain)
    local current_Table = 
    {
        x = 740,
        y = 400,
        z = 10,
        w = 2,
        h = 2,
        currentPower = 0,
        set_Power = setPower,
        tag = "CrossHair",
        speed = speed,
        reloadSpeed = 0.0,
        isReload = false,
        side_x1 = 0,
        side_x2 = 0,
        side_y = 0,
        
        isHidden = false,
        movedirection = love.math.random(1,4),
        currentTimer = 0.0,
        player_Target = playerTarget,
        current_Target = nil,
        current_warRain = warRain
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function CrossHair_Tut:Init()
    self.currentPower = self.set_Power

    self.side_x1 = (self.x - 32)
    self.side_x2 = (self.x + 46)
    self.side_y = self.y
end

function CrossHair_Tut:Update()

    if C_Tutorial_Level_Manager.tutorial_idx == 1 then

        self.currentTimer = self.currentTimer + 1

        if self.currentTimer % 120 == 0 then
            
            self.movedirection = love.math.random(1,4)

            self.currentTimer = 0.0
        end

        if self.movedirection == 1 then
            self.x = self.x + self.speed
        elseif self.movedirection == 2 then
            self.x = self.x - self.speed
        elseif self.movedirection == 3 then
            self.y = self.y - self.speed
        elseif self.movedirection == 4 then
            self.y = self.y + self.speed
        end
    elseif C_Tutorial_Level_Manager.tutorial_idx == 2 then
        self.x = Lerp(self.player_Target.x + 24, self.x,0.95555)
        self.y = Lerp(self.player_Target.y + 40, self.y,0.95555)

        if self:Hit_Collison_Check(self.player_Target,64,128) then
            self.player_Target.current_ROOTS:Downgrade_ROOTS()
        end
    elseif C_Tutorial_Level_Manager.tutorial_idx == 3 then
        
        if C_Tutorial_Level_Manager.current_Idx == 1 then
            
            if self.current_Target ~= nil then
                self.x = Lerp(self.current_Target.x, self.x,0.9555)
                self.y = Lerp(self.current_Target.y, self.y,0.9555)

                if self:Hit_Collison_Check(self.current_Target, 8,8) then
                    self:Attack()
                    self.current_Target.isDestroyed = true
                end

                if self.current_Target.isDestroyed then
                    self.current_Target = nil
                end
            end

        elseif C_Tutorial_Level_Manager.current_Idx == 2 then

            if self.movedirection > 2 then
                self.x = (self.player_Target.x + 64)
                self.movedirection = love.math.random(1,2)
            end

            if self.x <= 100 and self.movedirection == 2 then
                self.movedirection = 1
            end

            if self.x >= 1000 and self.movedirection == 1 then
                self.movedirection = 2
            end

            if self.movedirection == 1 then
                self.x = self.x + self.speed
            elseif self.movedirection == 2 then
                self.x = self.x - self.speed
            end

            if self:Hit_Collison_Check(self.player_Target,64,128) then
                if self.x >= 400 and self.movedirection == 1 then
                    self.player_Target.isRight = true 
                elseif self.x <= 850 and self.movedirection == 2 then
                    self.player_Target.isRight = false
                end

                self.player_Target:MovePushing(self)
                self.player_Target.current_ROOTS:Downgrade_ROOTS()
            end
            
            self.y = Lerp(self.player_Target.y + 55, self.y,0.95555)
        end 
    elseif C_Tutorial_Level_Manager.tutorial_idx == 4 then

        if C_Tutorial_Level_Manager.current_Idx == 2 then
            self.x = Lerp(self.current_warRain.x + 120, self.x,0.9853285)
            self.y = Lerp(self.player_Target.y - 40, self.y,0.955)
        end 
    elseif C_Tutorial_Level_Manager.tutorial_idx == 5 then

        if C_Tutorial_Level_Manager.current_Idx == 2 then
            if self.current_Target ~= nil then
                self.x = Lerp(self.current_Target.x, self.x,0.9555)
                self.y = Lerp(self.current_Target.y, self.y,0.9555)

                if self:Hit_Collison_Check(self.current_Target, 8,8) then
                    self:Attack()
                    self.current_Target.isDestroyed = true
                end

                if self.current_Target.isDestroyed then
                    self.current_Target = nil
                end
            end
        end

    end

    self.side_x1 = Lerp((self.x - 32),self.side_x1,0.8)
    self.side_x2 = Lerp((self.x + 46),self.side_x2,0.8)

    self.side_y = self.y

    self.w = Lerp(2,self.w,0.955)
    self.h = Lerp(2,self.h,0.955)

    if self.x <= -30 then
        if love.window.getFullscreen() then
            self.x = love.graphics.getWidth()
        else
            self.x = (love.graphics.getWidth() + 310)
        end
    end

    if self.y <= -30 then
        if love.window.getFullscreen() then
            self.y = 1000
        else
            self.y = (love.graphics.getHeight() + 310)
        end
    end

    if love.window.getFullscreen() then
        if self.x >= 1580 then
            self.x = -10
        end

        if self.y >= 1000 then
            self.y = -30
        end
    else
        if self.x >= (love.graphics.getWidth() + 310) then
            self.x = -30
        end
        
        if self.y >= (love.graphics.getHeight() + 310) then
            self.y = -30
        end
    end

end

function CrossHair_Tut:draw()
    love.graphics.push()

    local width, height = crossHairSPR[1]:getDimensions()
    
    love.graphics.draw(crossHairSPR[1],self.x,self.y,0,self.w,self.h, width / 2, height / 2)

    love.graphics.draw(crossHairSide_SPR[1],self.side_x1,self.side_y,0,2,2, width / 2, height / 2)
    love.graphics.draw(crossHairSide_SPR[2],self.side_x2,self.side_y,0,2,2, width / 2, height / 2)

    love.graphics.pop()
end

function CrossHair_Tut:Attack()
    self.w = 4
    self.h = 4

    self.side_x1 = (self.x - 48)
    self.side_x2 = (self.x + 62)
end

function CrossHair_Tut:Hit_Collison_Check(target,w,h)

    local width, height = crossHairSPR[1]:getDimensions()

    if target.x + w > self.x and target.x < self.x + width and
       target.y + h > self.y and target.y < self.y + height then
        return true
    end

    return false
end

function CrossHair_Tut:Hit_Collison_Check_Rotation_To(target,w,h,r)
    local width, height = crossHairSPR[1]:getDimensions()

    if target.x + w > self.x and target.x < self.x + width and
       target.y + h > self.y and target.y < self.y + height and (r > 0 or r < 0) then

        if target.tag == "Rocket" then
            self:Attack()
            target.isDestroyed = true
        end
        return true
    end

    return false
end

function CrossHair_Tut:StartHere(x,y)
    self.x = x
    self.y = y 
end

function CrossHair_Tut:ReBoot()
    self.x = 560
    self.y = 550
    self.z = 10
    self.speed = 2

    self.currentPower = self.set_Power
    self.isReload = false

    self.side_x1 = (self.x - 32)
    self.side_x2 = (self.x + 46)

    self.w = 2
    self.h = 2
end