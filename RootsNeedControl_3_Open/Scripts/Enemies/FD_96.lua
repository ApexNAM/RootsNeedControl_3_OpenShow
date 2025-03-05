local fd_96_spr_array =
{
    "assets/images/Other_SPRs/RNC_FD_96_SPR.png",
    "assets/images/Other_SPRs/RNC_FD_96_Right_SPR.png"
}

local fd_98_spr_Array = 
{
    "assets/images/Other_SPRs/RNC_FD_98_SPR.png",
    "assets/images/Other_SPRs/RNC_FD_98_Right_SPR.png"
}

local am_x_spr_Array = 
{
    "assets/images/Other_SPRs/RNC_AM_X_SPR.png",
    "assets/images/Other_SPRs/RNC_AM_X_Right_SPR.png"
}

local fd96_SPR = {}
local fd98_SPR = {}
local am_x_SPR = {}

for i, v in ipairs(fd_96_spr_array) do
    fd96_SPR[i] = love.graphics.newImage(v)
    fd96_SPR[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(fd_98_spr_Array) do
    fd98_SPR[i] = love.graphics.newImage(v)
    fd98_SPR[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(am_x_spr_Array) do
    am_x_SPR[i] = love.graphics.newImage(v)
    am_x_SPR[i]:setFilter("nearest", "nearest")
end

FD_96 = {}

function FD_96:new(x,y,r,targetPlayer,set_Speed)

    local current_Table = 
    {
        x = x,
        y = y,
        z = 1,
        r = r,
        w = 128,
        h = 128,
        attackTime = 0.0,
        tag = "FD_96",
        drawIDX = 1,
        isDestroyed = false,
        targetPlayer = targetPlayer,
        isStopped_AND_Attack = false,
        ammo = 50,
        currentSpeed = set_Speed,
        fallingY = 0.5,
        isHit = false
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function FD_96:Init()
    
end

function FD_96:Update()

    if not self.isHit then
        self.drawIDX = 1

        if not self.isStopped_AND_Attack then

            self.x = self.x + math.cos(self.r) * self.currentSpeed
            self.y = self.y + math.sin(self.r) * self.currentSpeed

            if self.ammo <= 0 then
                self.r = Lerp(math.rad(-90),self.r, 0.95)

                self.x = self.x + math.cos(self.r) * (self.currentSpeed + 5)
                self.y = self.y + math.sin(self.r) * (self.currentSpeed + 5)

                if self.y < -80 then
                    self.x = math.random(love.graphics.getWidth())
                    self.ammo = 50
                end
            else
                self.r = math.rad(90)

                if self.r < 0 then
                    self.r = self.r + 2 * math.pi
                end
            end
        else
            if self.ammo < 0 then
                self.isStopped_AND_Attack = false
            else
                if C_GameManager.difficulty_current == C_GameManager.difficultyStates[1] then
                    self.r = Lerp(math.atan2(self.targetPlayer.current_ROOTS.y - self.y, (self.targetPlayer.current_ROOTS.x + 10) - self.x),self.r,0.99)
                elseif C_GameManager.difficulty_current == C_GameManager.difficultyStates[2] then
                    self.r = Lerp(math.atan2(self.targetPlayer.current_ROOTS.y - self.y, (self.targetPlayer.current_ROOTS.x + 65) - self.x),self.r,0.99)
                end
            end
        end
    else
        self.drawIDX = 2
        self.isStopped_AND_Attack = false
        self.fallingY = self.fallingY + 0.05

        self.y = self.y + self.fallingY
        self.r = Lerp(math.rad(-90), self.r,0.955)

        if self.y >  590 then
            self.isDestroyed = true 
        end
    end
end

function FD_96:draw()

    love.graphics.push()
    
    local width, height = fd96_SPR[1]:getDimensions()

    if not C_GameManager.isGameOver then

        if C_GameManager.current_Level == C_GameManager.set_Level[1] then
            love.graphics.draw(fd96_SPR[self.drawIDX],self.x,self.y,self.r,2,2,width / 2, height / 2)
        elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
            love.graphics.draw(fd98_SPR[self.drawIDX],self.x,self.y,self.r,2,2,width / 2, height / 2)
        elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
            love.graphics.draw(am_x_SPR[self.drawIDX],self.x,self.y,self.r,2,2,width / 2, height / 2)
        else
            love.graphics.draw(fd96_SPR[self.drawIDX],self.x,self.y,self.r,2,2,width / 2, height / 2)
        end
    end
    
    if Debug_Manager.debugMode then
        love.graphics.push()
    
        love.graphics.translate(self.x, self.y)
        love.graphics.rotate(self.r)
        love.graphics.rectangle("line", -width, -height, self.w, self.h)
    
        love.graphics.pop()
    end

    love.graphics.pop()
end

function FD_96:ReBoot()
    self.isDestroyed = true
end