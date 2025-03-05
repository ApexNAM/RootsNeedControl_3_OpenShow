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

RootsCoreTut = {}

function RootsCoreTut:new(currentPlayers)
    local current_Table = 
    {
        x = 0,
        y = 0,
        z = 0,
        h = {50,82,120,160,195,250},
        tag = "Roots",
        currentPlayerCore = nil,
        roots_level = 1,
        roots_SPR = {},
        timer = 0.0,
        deadTime = 0.0,
        returnHPTime = 0.0,
        rootDownTime = 0.0,
        currentPlayer = currentPlayers
    }
    
    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function RootsCoreTut:Init()

    for i, v in ipairs(rootsSPRs) do
        self.roots_SPR[i] = love.graphics.newImage(v)
        self.roots_SPR[i]:setFilter("nearest", "nearest")
    end

    self.roots_level = 1
end

function RootsCoreTut:Update()

    if self.roots_level < 6 then
        self.deadTime = 0.0
        self.timer = self.timer + 1

        if self.timer % C_GameManager.current_RootSpeed == 0 then
            Current_RNC_Camera:_Setter_Offset(0.25)
            self.roots_level = self.roots_level + 1
            self.timer = 0.0
        end
    end
    
    self.x = self.currentPlayer.x - 70
    self.y = self.currentPlayer.y + 120
end

function RootsCoreTut:OnCollisonDamage(target)
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

function RootsCoreTut:draw()

    love.graphics.push()

    if self.roots_level > 0 then
        love.graphics.draw(self.roots_SPR[self.roots_level],self.x - 24,self.y + 9,0,2,2)
    end
    
    love.graphics.pop()
end 

function RootsCoreTut:Downgrade_ROOTS()

    self.rootDownTime = self.rootDownTime + 1

    if self.rootDownTime % 20 == 0 then
        if self.roots_level > 1 then
            self.roots_level = self.roots_level - 1
        end

        self.rootDownTime = 0.0
    end
end

function RootsCoreTut:ReBoot()
    self.z = 0
    self.roots_level = 1
    self.timer = 0.0
    self.deadTime = 0.0
    self.returnHPTime = 0.0
end