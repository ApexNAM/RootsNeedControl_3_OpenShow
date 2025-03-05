require("Scripts.Players.PlayerController")
require("Scripts.Managers.CameraManager")
require("Scripts.Managers.DebugDrawManager")

local rootsSPRs = 
{
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_00.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_01.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_02.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_03.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_04.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_05.png"
}

RootsCore = {}

function RootsCore:new(playerCore, playerHealth, playerCrossHair)
    local current_Table = 
    {
        x = 0,
        y = 0,
        z = 0,
        h = {50,82,120,160,195,250},
        tag = "Roots",
        currentPlayerCore = playerCore,
        currentPlayerHealth = playerHealth,
        currentPlayerCrossHair = playerCrossHair,
        roots_level = 1,
        roots_SPR = {},
        timer = 0.0,
        deadTime = 0.0,
        returnHPTime = 0.0,
        rootDownTime = 0.0
    }
    
    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function RootsCore:Init()

    for i, v in ipairs(rootsSPRs) do
        self.roots_SPR[i] = love.graphics.newImage(v)
    end

    self.roots_level = 1
end

function RootsCore:Update()

    if not self.currentPlayerHealth.isDead then
        if self.roots_level < 6 then
            self.deadTime = 0.0
            self.timer = self.timer + 1

            if self.timer % C_GameManager.current_RootSpeed == 0 then
                Current_RNC_Camera:_Setter_Offset(0.25)
                self.roots_level = self.roots_level + 1
                C_GameManager:SpeedUp()
                self.timer = 0.0
            end

            if C_GameManager.difficulty_current == C_GameManager.difficultyStates[1] then
                self.currentPlayerHealth.can_rehealth = true
            end

        elseif self.roots_level >= 6 then
            self.timer = 0.0
            self.deadTime = self.deadTime + 1

            if self.deadTime % C_GameManager.current_DamageSpeed_From_Root == 0 then
                self.currentPlayerHealth:TakeDamage(1)
                self.deadTime = 0.0
            end

            if C_GameManager.difficulty_current == C_GameManager.difficultyStates[1] then
                self.currentPlayerHealth.can_rehealth = false
            end
        end
    end
    
    self.x = self.currentPlayerCore.x - 70
    self.y = self.currentPlayerCore.y + 120
end

-- 뿌리의 길이에 따라 충돌 판정 크기가 변동됩니다. (self.roots_level 로부터)
function RootsCore:OnCollisonDamage(target)
    if self.roots_level == 1 then
        if target.x + 8 > self.x and target.x < (self.x + 70) + 64 and
           target.y + 8 > self.y and target.y < (self.y + 8) + self.h[1] then

            return true
        end
    elseif self.roots_level == 2 then
        if target.x + 8 > self.x and target.x < (self.x + 52) + 97 and
           target.y + 8 > self.y and target.y < (self.y + 8) + self.h[2] then

            return true
        end
    elseif self.roots_level == 3 then
        if target.x + 8 > self.x and target.x < (self.x + 52) + 97 and
           target.y + 8 > self.y and target.y < (self.y + 8) + self.h[3] then

            return true
        end
    elseif self.roots_level == 4 then
        if target.x + 8 > self.x and target.x < (self.x + 32) + 132 and
           target.y + 8 > self.y and target.y < (self.y + 8) + self.h[4] then

            return true
        end        
    elseif self.roots_level == 5 then
        if target.x + 8 > self.x and target.x < (self.x - 18) + 225 and
           target.y + 8 > self.y and target.y < (self.y + 8) + self.h[5] then

            return true
        end        
    elseif self.roots_level == 6 then
        if target.x + 8 > self.x and target.x < (self.x - 18) + 248 and
            target.y + 8 > self.y and target.y < (self.y + 8) + self.h[6] then

            return true
        end        
    end

 return false
end

function RootsCore:draw()

    love.graphics.push()

    if not C_GameManager.isGameOver then
        if self.roots_level > 0 then
            love.graphics.draw(self.roots_SPR[self.roots_level],self.x - 24,self.y + 9,0,2,2)
        end
    end
    
    love.graphics.pop()

    if Debug_Manager.debugMode then

        love.graphics.push()

        if self.roots_level == 1 then
            love.graphics.rectangle("line",self.x + 70, self.y + 8, 64,self.h[1])
        elseif self.roots_level == 2 then
            love.graphics.rectangle("line",self.x + 52, self.y + 8, 97,self.h[2])
        elseif self.roots_level == 3 then
            love.graphics.rectangle("line",self.x + 52, self.y + 8, 97,self.h[3])
        elseif self.roots_level == 4 then
            love.graphics.rectangle("line",self.x + 32, self.y + 8, 132,self.h[4])
        elseif self.roots_level == 5 then
            love.graphics.rectangle("line",self.x - 18, self.y + 8, 225,self.h[5])
        elseif self.roots_level == 6 then
            love.graphics.rectangle("line",self.x - 18, self.y + 8, 248,self.h[6])
        end 

        love.graphics.pop()
    end
end 

function RootsCore:Downgrade_ROOTS()

    self.rootDownTime = self.rootDownTime + 1

    if self.rootDownTime % 20 == 0 then
        if self.roots_level > 1 then
            C_GameManager:AddScore()
            C_GameManager:SpeedDown()
            self.roots_level = self.roots_level - 1
        end

        self.rootDownTime = 0.0
    end
end

function RootsCore:ReBoot()
    self.z = 0
    self.currentPlayerHealth:ReBoot()
    self.roots_level = 1
    self.timer = 0.0
    self.deadTime = 0.0
    self.returnHPTime = 0.0
end