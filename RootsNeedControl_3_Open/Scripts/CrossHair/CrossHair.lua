require("Scripts.Managers.DebugDrawManager")
require("Scripts.Managers.CrossHairManager")

local kr_font_back = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",28)
local en_font_back = love.graphics.newFont("assets/Fonts/pico-8.ttf",25)

local kr_key_guide_small_2Player = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",15)
local en_key_guide_small_2Player = love.graphics.newFont("assets/Fonts/pico-8.ttf",15)

CrossHair_Mixed = {}

function CrossHair_Mixed:new(speed, setPower, is2Player)
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
        isSubReload = false,
        side_x1 = 0,
        side_x2 = 0,
        side_y = 0,
        is2Player = is2Player,
        
        input_player = 
        {
            {"left","right","up","down"},
            {"s","f","e","d"},
        },

        input_action_player =
        {
            {"z","x"},
            {"q","w"},
            {"n","m"}
        },

        input_current_idx = 0,
        isHidden = false,

        mousePrevX = 0,
        mousePrevY = 0,
        
        autoMode = false,
        current_Target = nil
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function CrossHair_Mixed:Init()
    self.currentPower = self.set_Power

    self.side_x1 = (self.x - 32)
    self.side_x2 = (self.x + 46)
    self.side_y = self.y

    if self.is2Player then
        self.input_current_idx = 2

        if not C_GameManager.is2PlayerMode then
            self.isHidden = true
        else
            self.isHidden = false
        end
    else
        self.input_current_idx = 1
    end
end

function CrossHair_Mixed:Update()

    if not self.isHidden then
        self.speed = C_GameManager.crossHairSpeed

        if not C_GameManager.is2PlayerMode then

            if not self.autoMode then
                local mouseX, mouseY = love.mouse.getPosition()
                local scaleMouse = love.graphics.getDimensions() / 1536

                if mouseX ~= self.mousePrevX or mouseY ~= self.mousePrevY then

                    self.x = mouseX / scaleMouse
                    self.y = mouseY / scaleMouse
                end

                self.mousePrevX, self.mousePrevY = mouseX, mouseY

                if love.keyboard.isDown("r") and 
                (self.currentPower < (self.set_Power - 10)) and not self.isSubReload then
                    self.isSubReload = true
                end
    
            end
        end

        if love.keyboard.isDown(self.input_player[self.input_current_idx][1]) and self.x > -30 then
            self.x = self.x - self.speed   

            if self.x <= -30 then
                if love.window.getFullscreen() then
                    self.x = love.graphics.getWidth()
                else
                    self.x = (love.graphics.getWidth() + 310)
                end
            end
        end

        if love.window.getFullscreen() then
            if love.keyboard.isDown(self.input_player[self.input_current_idx][2]) and self.x < 1580 then
                self.x = self.x + self.speed

                if self.x >= 1580 then
                    self.x = -10
                end
            end
        else
            if love.keyboard.isDown(self.input_player[self.input_current_idx][2]) and self.x < (love.graphics.getWidth() + 310) then
                self.x = self.x + self.speed

                if self.x >= (love.graphics.getWidth() + 310) then
                    self.x = -30
                end
            end
        end

        if love.keyboard.isDown(self.input_player[self.input_current_idx][3]) and self.y > -30 then
            self.y = self.y - self.speed

            if self.y <= -30 then
                if love.window.getFullscreen() then
                    self.y = 1000
                else
                    self.y = (love.graphics.getHeight() + 310)
                end
            end
        end

        if love.window.getFullscreen() then
            if love.keyboard.isDown(self.input_player[self.input_current_idx][4]) and self.y < 1000 then
                self.y = self.y + self.speed

                if self.y >= 1000 then
                    self.y = -30
                end
            end
        else
            if love.keyboard.isDown(self.input_player[self.input_current_idx][4]) and self.y < (love.graphics.getHeight() + 310) then
                self.y = self.y + self.speed

                if self.y >= (love.graphics.getHeight() + 310) then
                    self.y = -30
                end
            end
        end

        if self.autoMode then

            if not C_GameManager.is2PlayerMode then
                if self.current_Target ~= nil then

                    if self.current_Target.tag == "Player" then
                        self.x = Lerp(self.current_Target.x + 24, self.x,0.955)
                        self.y = Lerp(self.current_Target.y + 40, self.y,0.955)
                    elseif self.current_Target.tag == "Tank" then
                        self.x = Lerp(self.current_Target.x + 40, self.x,0.955)
                        self.y = Lerp(self.current_Target.y + 40, self.y,0.955)
                    else
                        self.x = Lerp(self.current_Target.x, self.x,0.9555)
                        self.y = Lerp(self.current_Target.y, self.y,0.9555)
                    end

                    if self.current_Target.isDestroyed then
                        self.current_Target = nil
                    end
                end

                if self.x <= -30 then
                    if love.window.getFullscreen() then
                        self.x = love.graphics.getWidth()
                    else
                        self.x = (love.graphics.getWidth() + 310)
                    end
                end

                if love.window.getFullscreen() then
                    if self.x >= 1580 then
                        self.x = -10
                    end
                else
                    if self.x >= (love.graphics.getWidth() + 310) then
                        self.x = -30
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
                    if self.y >= 1000 then
                        self.y = -30
                    end
                else
                    if self.y >= (love.graphics.getHeight() + 310) then
                        self.y = -30
                    end
                end
            end
        end

        if self.currentPower <= 0 and not self.isReload then
            self.currentPower = 0
            self.isReload = true
        end

        if self.isReload then
            self.side_y = Lerp(self.y - 32, self.side_y, 0.55)

            self.reloadSpeed = self.reloadSpeed + 1

            if self.reloadSpeed % 200 == 0 then

                if self.autoMode then
                    if self.current_Target ~= nil then
                        self.current_Target = nil
                    end
                end

                self.currentPower = self.set_Power
                self.isReload = false
            end
        end

        if self.isSubReload then
            self.side_y = Lerp(self.y - 16, self.side_y, 0.55)

            self.reloadSpeed = self.reloadSpeed + 1

            if self.reloadSpeed % 100 == 0 then
                self.currentPower = (self.set_Power - 10)
                self.isSubReload = false
            end
        end

        if not self.isReload and not self.isSubReload then
            self.side_y = Lerp(self.y, self.side_y, 0.9)
        end

        self.side_x1 = Lerp((self.x - 32),self.side_x1,0.8)
        self.side_x2 = Lerp((self.x + 46),self.side_x2,0.8)

        self.w = Lerp(2,self.w,0.955)
        self.h = Lerp(2,self.h,0.955)
    end
end

function CrossHair_Mixed:draw()
    love.graphics.push()

    local width, height = GetWH_Center()
    
    if not C_GameManager.isGameOver then

        if not self.isHidden then

            love.graphics.draw(C_CrossHair_Manager:PrintCenter(self.is2Player),self.x,self.y,0,self.w,self.h, width / 2, height / 2)

            if not self.is2Player then
                love.graphics.draw(C_CrossHair_Manager:PrintLeft(false),self.side_x1,self.side_y,0,2,2, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintRight(false),self.side_x2,self.side_y,0,2,2, width / 2, height / 2)
            else
                love.graphics.draw(C_CrossHair_Manager:PrintLeft(true),self.side_x1,self.side_y,0,2,2, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintRight(true),self.side_x2,self.side_y,0,2,2, width / 2, height / 2)
            end
        end

        if not self.is2Player then

            if self.autoMode then
                if Current_Lang.language_current == 1 then
                    love.graphics.setFont(kr_font_back)
                    love.graphics.printf("자동모드 실행중...", C_GameManager.textWidth, 200, love.graphics.getWidth(), "center")
                elseif Current_Lang.language_current == 2 then
                    love.graphics.setFont(en_font_back)
                    love.graphics.printf("auto mode enabled...", C_GameManager.textWidth, 200, love.graphics.getWidth(), "center")
                elseif Current_Lang.language_current == 3 then
                    love.graphics.setFont(kr_font_back)
                    love.graphics.printf("自動モード実行中···", C_GameManager.textWidth, 200, love.graphics.getWidth(), "center")
                end
            end

            if self.isReload then
                if Current_Lang.language_current == 1 then
                    love.graphics.setFont(kr_font_back)
                    love.graphics.printf("운동력 충전중입니다...", C_GameManager.textWidth, 300, love.graphics.getWidth(), "center")
                elseif Current_Lang.language_current == 2 then
                    love.graphics.setFont(en_font_back)
                    love.graphics.printf("reload power...", C_GameManager.textWidth, 300, love.graphics.getWidth(), "center")
                elseif Current_Lang.language_current == 3 then
                    love.graphics.setFont(kr_font_back)
                    love.graphics.printf("運動力充電中です···", C_GameManager.textWidth, 300, love.graphics.getWidth(), "center")
                end
            end

            if self.isSubReload then
                if Current_Lang.language_current == 1 then
                    love.graphics.setFont(kr_font_back)
                    love.graphics.printf("운동력 긴급 충전중입니다...", C_GameManager.textWidth, 300, love.graphics.getWidth(), "center")
                elseif Current_Lang.language_current == 2 then
                    love.graphics.setFont(en_font_back)
                    love.graphics.printf("reload quick power...", C_GameManager.textWidth, 300, love.graphics.getWidth(), "center")
                elseif Current_Lang.language_current == 3 then
                    love.graphics.setFont(kr_font_back)
                    love.graphics.printf("運動力緊急充電中です···", C_GameManager.textWidth, 300, love.graphics.getWidth(), "center")
                end
            end
        end

        if C_GameManager.is2PlayerMode then

            if Current_Lang.language_current == 1 then
                love.graphics.setFont(kr_key_guide_small_2Player)

                love.graphics.print("power:"..self.currentPower,self.x - 30.0 ,self.y + 30.0)

                if self.is2Player then
                    love.graphics.print("player_2",self.x - 30.0 ,self.y - 45.0)
                else
                    love.graphics.print("player_1",self.x - 30.0 ,self.y - 45.0)
                end

            elseif Current_Lang.language_current == 2 then
                love.graphics.setFont(en_key_guide_small_2Player)

                love.graphics.print("power:"..self.currentPower,self.x - 38.0 ,self.y + 30.0)

                if self.is2Player then
                    love.graphics.print("player_2",self.x - 38.0 ,self.y - 45.0)
                else
                    love.graphics.print("player_1",self.x - 38.0 ,self.y - 45.0)
                end
            elseif Current_Lang.language_current == 3 then
                love.graphics.setFont(kr_key_guide_small_2Player)

                love.graphics.print("パワー:"..self.currentPower,self.x - 38.0 ,self.y + 30.0)

                if self.is2Player then
                    love.graphics.print("player_2",self.x - 38.0 ,self.y - 45.0)
                else
                    love.graphics.print("player_1",self.x - 38.0 ,self.y - 45.0)
                end
            end
        end
    end
    
    if Debug_Manager.debugMode then
        love.graphics.translate(self.x, self.y)
        love.graphics.rectangle("line",-width,-height,32,32)
    end

    love.graphics.pop()
end

function CrossHair_Mixed:Hit_Collison_Check(target,w,h)

    local width, height = GetWH_Center()

    if self.x < target.x + w and target.x < self.x + width and
       self.y < target.y + h and target.y < self.y + height then
        return true
    end

    return false
end

function CrossHair_Mixed:Hit_Collison_Check_Rotation_To(target,w,h,r)
    local width, height = GetWH_Center()

    if self.x < target.x + w and target.x < self.x + width and
       self.y < target.y + h and target.y < self.y + height and (r > 0 or r < 0) then
        return true
    end

    return false
end

function CrossHair_Mixed:StartHere(x,y)
    self.x = x
    self.y = y 
end

function CrossHair_Mixed:AddPower()

    if self.currentPower > self.set_Power then
        self.currentPower = self.set_Power
    end

    self.currentPower = self.currentPower + 5
end

function CrossHair_Mixed:ReBoot()
    self.x = 560
    self.y = 550
    self.z = 10
    self.speed = 2

    self.currentPower = self.set_Power
    self.isReload = false
    self.isSubReload = false

    self.side_x1 = (self.x - 32)
    self.side_x2 = (self.x + 46)

    self.w = 2
    self.h = 2

    self.autoMode = false
    self.current_Target = nil

    if self.is2Player then
        self.input_current_idx = 2

        if not C_GameManager.is2PlayerMode then
            self.isHidden = true
        else
            self.isHidden = false
        end
    else
        self.input_current_idx = 1
    end
end