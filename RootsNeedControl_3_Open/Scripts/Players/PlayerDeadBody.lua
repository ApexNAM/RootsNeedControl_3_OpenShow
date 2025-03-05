local rootsSPRs_DEAD = 
{
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_00_DEAD.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_01_DEAD.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_02_DEAD.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_03_DEAD.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_04_DEAD.png",
    "assets/images/Roots_SPRs/ROOTS_SPR_LEVEL_05_DEAD.png"
}

local player_SPR_Dead_Array = {"assets/images/Player_SPRs/Player_Character_SPR_PRT_DeadBody.png"}

local player_SPR_Dead = {}
local roots_SPR_Dead = {}

for i, v in ipairs(player_SPR_Dead_Array) do
    player_SPR_Dead[i] = love.graphics.newImage(v)
    player_SPR_Dead[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(rootsSPRs_DEAD) do
    roots_SPR_Dead[i] = love.graphics.newImage(v)
    roots_SPR_Dead[i]:setFilter("nearest", "nearest")
end

PlayerDeadCore = {}

function PlayerDeadCore:new(playerCore, root)
    local current_Table = 
    {
        cx = 0,
        cy = 0,
        rtx = 0,
        rty = 0,
        z = 0,
        roots_level = 1,
        playerCore = playerCore,
        root = root,
        coolTime = 0.0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function PlayerDeadCore:Init()    
    self.roots_level = self.root.roots_level
end

function PlayerDeadCore:Update()
    self.cx = self.playerCore.x
    self.cy = self.playerCore.y

    self.rtx = self.root.x
    self.rty = self.root.y

    self.z = 2

    self.roots_level = self.root.roots_level

    if self.playerCore.health.isDead then

        C_GameManager.isGameOver = true

        self.coolTime = self.coolTime + 1

        if self.coolTime > 300 then
            C_GameManager.isGameOver = false
            RebootAll()
            Current_RNC_Camera:_Setter_Offset(10)
            ChangeScene(5)
            self.coolTime = 0.0
        end
    end
end

function PlayerDeadCore:draw()
    if C_GameManager.isGameOver then
        love.graphics.draw(player_SPR_Dead[1],self.cx,self.cy,-0.15,2,2)

        if self.roots_level > 1 then
            love.graphics.draw(roots_SPR_Dead[self.roots_level],self.rtx,self.rty,0.25,2,2)
        end
    end
end

function PlayerDeadCore:ReBoot()
    self.cx = self.playerCore.x
    self.cy = self.playerCore.y

    self.rtx = self.root.x
    self.rty = self.root.y

    self.z = 2

    self.roots_level = self.root.roots_level

    self.coolTime = 0.0
end