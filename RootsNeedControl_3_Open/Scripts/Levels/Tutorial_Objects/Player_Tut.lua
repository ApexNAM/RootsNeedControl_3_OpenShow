require("Scripts.Managers.CameraManager")
require("Scripts.Players.PlayerHealth")
require("Scripts.Managers.DebugDrawManager")

PlayerCore_Tut = {}

local player_SPR_Array = {"assets/images/Player_SPRs/Player_Character_SPR_PRT_01.png"}

function PlayerCore_Tut:new(x,y,MoveSpeed,isRight)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 0,
        current_ROOTS = nil,
        tag = "Player",
        MoveSpeed = MoveSpeed,
        isRight = isRight,
        health = PlayerHealth:new(100),
        player_SPR = {},
        prevMouseX = 0, 
        prevMouseY = 0,
        isMouseRight = true,
        canMove = false
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function PlayerCore_Tut:Init()

    for i, v in ipairs(player_SPR_Array) do
        self.player_SPR[i] = love.graphics.newImage(v)
        self.player_SPR[i]:setFilter("nearest", "nearest")
    end
end

function PlayerCore_Tut:AddROOTS(roots)
    self.current_ROOTS = roots
end

function PlayerCore_Tut:Update()
    
    if self.canMove then
        if self.isRight then
            self.x = self.x + (self.current_ROOTS.roots_level / 4)
        else
            self.x = self.x - (self.current_ROOTS.roots_level / 4)
        end
    end

    if love.window.getFullscreen() then

        local width, height = love.window.getDesktopDimensions()

        if width == 1280 and height == 720 then
            if self.x > 1270 then
                self.x = 1270
                self.health:DeadNow()
            end
        elseif width == 1920 and height == 1080 then
            if self.x > 1400 then
                self.x = 1400
                self.health:DeadNow()
            end
        elseif width == 2560 and height == 1440 then
            if self.x > 1380 then
                self.x = 1380
                self.health:DeadNow()
            end
        else
            if self.x > (love.graphics.getWidth() - 100) then
                self.x = (love.graphics.getWidth() - 100)
                self.health:DeadNow()
            end
        end
    else
        if self.x > love.graphics.getWidth() + 200 then
            self.x = love.graphics.getWidth() + 200
            self.health:DeadNow()
        end
    end
end

function PlayerCore_Tut:draw()

    love.graphics.push()

    love.graphics.draw(self.player_SPR[1],self.x - 32,self.y,0,2,2)

    love.graphics.pop()
end

function PlayerCore_Tut:MovePushing()

    if self.isRight then
        if self.x < 850 then
            self.x = self.x + 16
        end
    else
        if self.x > 400 then
            self.x = self.x - 16
        end
    end
end

function PlayerCore_Tut:StartCoreHere(x)
    self.x = x
end

function PlayerCore_Tut:ReBoot()
    self.x = 500
    self.y = 465
    self.z = 0
    self.MoveSpeed = 0.25
    self.isRight = true
    self.gravity = 0.5
    self.canMove = false
end