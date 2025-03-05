require("Scripts.Managers.CameraManager")
require("Scripts.Players.PlayerHealth")
require("Scripts.Managers.DebugDrawManager")

PlayerCore = {}

local player_SPR_Array = {"assets/images/Player_SPRs/Player_Character_SPR_PRT_01.png"}

function PlayerCore:new(x,y,MoveSpeed,isRight)
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

function PlayerCore:Init()

    for i, v in ipairs(player_SPR_Array) do
        self.player_SPR[i] = love.graphics.newImage(v)
    end

    self.health:Init()
end

-- 뿌리를 플레이어 캐릭터 변수에 추가합니다.
function PlayerCore:AddROOTS(roots)
    self.current_ROOTS = roots
end

function PlayerCore:Update()

    self.MoveSpeed = C_GameManager.coreSpeed
    
    if not self.health.isDead then

        if self.canMove then
            if self.isRight then
                self.x = self.x + (self.current_ROOTS.roots_level / 4)
            else
                self.x = self.x - (self.current_ROOTS.roots_level / 4)
            end
        end

        if C_GameManager.difficulty_current == C_GameManager.difficultyStates[2] then
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

        if self.x <= 100 then
            self.x = 100
            self.health:DeadNow()
        end

        self.health:ReturnHealth()
    end
end

function PlayerCore:draw()

    love.graphics.push()

    if not C_GameManager.isGameOver then
        love.graphics.draw(self.player_SPR[1],self.x - 32,self.y,0,2,2)
    end

    if Debug_Manager.debugMode then
        love.graphics.rectangle("line",self.x,self.y,64,128)
    end

    love.graphics.pop()
end

function PlayerCore:MovePushing(crosshair)
    if C_GameManager.difficulty_current == C_GameManager.difficultyStates[2] then
        if (love.keyboard.isDown(crosshair.input_action_player[crosshair.input_current_idx][1]) or 
            love.keyboard.isDown(crosshair.input_action_player[3][1])) and 
            love.keyboard.isDown(crosshair.input_player[crosshair.input_current_idx][1]) then
            Current_RNC_Camera:_Setter_Offset(0.5)

            if self.x > 0 then
                self.x = self.x - 16
                self.isRight = false
            end

        elseif (love.keyboard.isDown(crosshair.input_action_player[crosshair.input_current_idx][1]) or 
                love.keyboard.isDown(crosshair.input_action_player[3][1])) and 
                love.keyboard.isDown(crosshair.input_player[crosshair.input_current_idx][2]) then
            Current_RNC_Camera:_Setter_Offset(0.5)

            if love.window.getFullscreen() then
                if self.x < (love.graphics.getWidth()) then
                    self.x = self.x + 16
                    self.isRight = true
                end
            else
                if self.x < (love.graphics.getWidth() + 200) then
                    self.x = self.x + 16
                    self.isRight = true
                end
            end
        end


        local mouseX, mouseY = love.mouse.getPosition()

        if mouseX < self.prevMouseX then
            self.isMouseRight = false
        elseif mouseX > self.prevMouseX then
            self.isMouseRight = true
        end

        self.prevMouseX, self.prevMouseY = mouseX, mouseY

        if love.mouse.isDown(2) and not self.isMouseRight then
            Current_RNC_Camera:_Setter_Offset(0.5)
            
            if self.x > 0 then
                self.x = self.x - 16
                self.isRight = false
            end
        elseif love.mouse.isDown(2) and self.isMouseRight then
            Current_RNC_Camera:_Setter_Offset(0.5)

            if love.window.getFullscreen() then
                if self.x < (love.graphics.getWidth()) then
                    self.x = self.x + 16
                    self.isRight = true
                end
            else
                if self.x < (love.graphics.getWidth() + 200) then
                    self.x = self.x + 16
                    self.isRight = true
                end
            end
        end
    end
end

function PlayerCore:StartCoreHere(x)
    self.x = x
end

function PlayerCore:ReBoot()
    self.x = 500
    self.y = 465
    self.z = 0
    self.MoveSpeed = 0.25
    self.isRight = true
    self.gravity = 0.5
    self.canMove = false
end