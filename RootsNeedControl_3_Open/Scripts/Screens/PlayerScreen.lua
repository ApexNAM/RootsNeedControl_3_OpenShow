require("Scripts.Players.PlayerController")
require("Scripts.Players.PlayerHealth")
require("Scripts.Managers.LanguageManager")

local ui_powerbar_Array = 
{
    "assets/images/UI_SPRs/Player_UI_SPR_UI_RNC1.png",
    "assets/images/UI_SPRs/Player_UI_SPR_UI_RNC2.png",
    "assets/images/UI_SPRs/Player_UI_SPR_UI_RNC3.png",
    "assets/images/UI_SPRs/Player_UI_SPR_UI_RNC4.png",
    "assets/images/UI_SPRs/Player_UI_SPR_UI_RNC5.png",
    "assets/images/UI_SPRs/Player_UI_SPR_UI_RNC6.png"
}

local ui_hpBar_Array =    
{
    "assets/images/UI_SPRs/HP_Check_SPR_UI_RNC1.png",
    "assets/images/UI_SPRs/HP_Check_SPR_UI_RNC2.png",
    "assets/images/UI_SPRs/HP_Check_SPR_UI_RNC3.png",
    "assets/images/UI_SPRs/HP_Check_SPR_UI_RNC4.png",
    "assets/images/UI_SPRs/HP_Check_SPR_UI_RNC5.png"
}

local ui_2P_Array = {"assets/images/UI_SPRs/Player_UI_SPR_UI_RNC_2P.png"}


local ui_powerbar = {}
local ui_hpBar = {}
local ui_2P = {}

for i, v in ipairs(ui_powerbar_Array) do
    ui_powerbar[i] = love.graphics.newImage(v)
    ui_powerbar[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(ui_hpBar_Array) do
    ui_hpBar[i] = love.graphics.newImage(v)
    ui_hpBar[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(ui_2P_Array) do
    ui_2P[i] = love.graphics.newImage(v)
    ui_2P[i]:setFilter("nearest", "nearest")
end

PlayerScreen = {}


function PlayerScreen:new(playerCore, playerHP, playerROOTS, playerCrossHair)
    local current_Table = 
    {
        z = 50,
        playerCore = playerCore,
        playerHP = playerHP,
        playerROOTS = playerROOTS,
        playerCrossHair = playerCrossHair,

        kr_font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",20),
        en_font = love.graphics.newFont("assets/Fonts/pico-8.ttf",20),

        ui_power_idx = 1,
        ui_power_reloadTime = 0.0,

        ui_hp_idx = 1,
        kr_Font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",34),
        en_Font = love.graphics.newFont("assets/Fonts/pico-8.ttf",30),

        mission_timer = 0.0,
        mission_y = -100,
        show_mission = true,

        kr_Font_M = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",100),
        en_Font_M = love.graphics.newFont("assets/Fonts/pico-8.ttf",100),
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function PlayerScreen:Init()

end

function PlayerScreen:Update()

    if not C_GameManager.isGameOver then
        if self.show_mission then
            self.mission_y = Lerp(300,self.mission_y, 0.95)

            self.mission_timer = self.mission_timer + 1

            if self.mission_timer % 240 == 0 then
                self.mission_timer = 0.0
                self.show_mission = false
            end
        else
            self.mission_y = Lerp(love.graphics.getHeight() + 1000,self.mission_y, 0.95)
        end
    end 
    
    if self.playerCrossHair.currentPower >= 25 then
        self.ui_power_idx = 1
    elseif self.playerCrossHair.currentPower > 20 then
        self.ui_power_idx = 2
    elseif self.playerCrossHair.currentPower > 10 then   
        self.ui_power_idx = 3
    elseif self.playerCrossHair.currentPower > 5 then
        self.ui_power_idx = 4
    elseif self.playerCrossHair.currentPower == 0 then

        self.ui_power_reloadTime = self.ui_power_reloadTime + 1

        if self.ui_power_reloadTime % 60 == 0 then

            if self.ui_power_idx == 5 then
                self.ui_power_idx = 6
            elseif self.ui_power_idx == 6 then
                self.ui_power_idx = 5
            else
                self.ui_power_idx = 5
            end

            self.ui_power_reloadTime = 0.0
        end
    end

    if self.playerHP.current_health >= 90 then
        self.ui_hp_idx = 1
    elseif self.playerHP.current_health > 70 then
        self.ui_hp_idx = 2
    elseif self.playerHP.current_health > 50 then
        self.ui_hp_idx = 3
    elseif self.playerHP.current_health > 20 then
        self.ui_hp_idx = 4
    elseif self.playerHP.current_health == 0 then
        self.ui_hp_idx = 5
    end
end

function PlayerScreen:draw()

    love.graphics.push()

    if not C_GameManager.isGameOver then

        love.graphics.draw(ui_hpBar[self.ui_hp_idx],30,30,0,4,4)

        if not C_GameManager.is2PlayerMode then
            love.graphics.draw(ui_powerbar[self.ui_power_idx],30,30,0,4,4)

            if Current_Lang.language_current == 1 then
                love.graphics.setFont(self.kr_Font_M)
                love.graphics.printf("게임 목표", C_GameManager.textWidth, self.mission_y, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.kr_Font)

                if C_GameManager.endless_Mode then
                    love.graphics.printf("오랫동안 뿌리꽃을 지켜라!", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("100% 도달까지 뿌리꽃을 지켜라!", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                end
            elseif Current_Lang.language_current == 2 then
                love.graphics.setFont(self.en_Font_M)
                love.graphics.printf("game mission", C_GameManager.textWidth, self.mission_y, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.en_Font)

                if C_GameManager.endless_Mode then
                    love.graphics.printf("protect the root flower for a long time!", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("protect the root flower to 100%!", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                end
            elseif Current_Lang.language_current == 3 then
                love.graphics.setFont(self.kr_Font_M)
                love.graphics.printf("ゲーム目標", C_GameManager.textWidth, self.mission_y, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.kr_Font)

                if C_GameManager.endless_Mode then
                    love.graphics.printf("長い間、根の花を守れ！", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("100%到達まで根の花を守れ！", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                end
            end
        else
            love.graphics.draw(ui_2P[1],30,30,0,4,4)

            if Current_Lang.language_current == 1 then
                love.graphics.setFont(self.kr_Font_M)
                love.graphics.printf("게임 목표", C_GameManager.textWidth, self.mission_y, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.kr_Font)
               
                if C_GameManager.endless_Mode then
                    love.graphics.printf("오랫동안 뿌리꽃을 지켜라! 함께!", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("100% 도달까지 뿌리꽃을 지켜라! 함께!", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                end

            elseif Current_Lang.language_current == 2 then
                love.graphics.setFont(self.en_Font_M)
                love.graphics.printf("game mission", C_GameManager.textWidth, self.mission_y, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.en_Font)

                if C_GameManager.endless_Mode then
                    love.graphics.printf("protect the root flower for a long time together!", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("protect the root flower to 100% together!", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                end
            elseif Current_Lang.language_current == 3 then
                love.graphics.setFont(self.kr_Font_M)
                love.graphics.printf("ゲーム目標", C_GameManager.textWidth, self.mission_y, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.kr_Font)
               
                if C_GameManager.endless_Mode then
                    love.graphics.printf("長い間、根の花を守れ！ 一緒に！", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("100%到達まで根の花を守れ！ 一緒に！", C_GameManager.textWidth, self.mission_y + 110, love.graphics.getWidth(), "center")
                end
            end
        end

        if Current_Lang.language_current == 1 then
            
            love.graphics.setFont(self.kr_Font)

            if love.window.getFullscreen() then
                local width, height = love.window.getDesktopDimensions()

                if width == 1280 and height == 720 then
                    love.graphics.print("점수 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 50,30,0)
                love.graphics.print("최고점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 50,80,0)
                elseif width == 1920 and height == 1080 then
                    love.graphics.print("점수 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 680,30,0)
                love.graphics.print("최고점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 680,80,0)
                elseif width == 2560 and height == 1440 then
                    love.graphics.print("점수 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 120,30,0)
                love.graphics.print("최고점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 120,80,0)
                else
                    love.graphics.print("점수 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 280,30,0)
                    love.graphics.print("최고점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 280,80,0)
                end
            else
                love.graphics.print("점수 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 30,30,0)
                love.graphics.print("최고점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 30,80,0)
            end
        elseif Current_Lang.language_current == 2 then

            love.graphics.setFont(self.en_Font)

            if love.window.getFullscreen() then

                local width, height = love.window.getDesktopDimensions()

                if width == 1280 and height == 720 then
                    love.graphics.print("score : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 80,50,0)
                    love.graphics.print("highscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 80,100,0)
                elseif width == 1920 and height == 1080 then
                    love.graphics.print("score : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 740,50,0)
                    love.graphics.print("highscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 740,100,0)
                elseif width == 2560 and height == 1440 then
                    love.graphics.print("score : "..C_GameManager.score[C_GameManager.current_Level_idx],1200,50,0)
                    love.graphics.print("highscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],1200,100,0)
                else
                    love.graphics.print("score : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 320,50,0)
                    love.graphics.print("highscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 320,100,0)
                end

            else
                love.graphics.print("score : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 100,50,0)
                love.graphics.print("highscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 100,100,0)
            end
        elseif Current_Lang.language_current == 3 then
            love.graphics.setFont(self.kr_Font)

            if love.window.getFullscreen() then
                local width, height = love.window.getDesktopDimensions()

                if width == 1280 and height == 720 then
                    love.graphics.print("点数 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 50,30,0)
                love.graphics.print("最高点数 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 50,80,0)
                elseif width == 1920 and height == 1080 then
                    love.graphics.print("点数 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 680,30,0)
                love.graphics.print("最高点数 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 680,80,0)
                elseif width == 2560 and height == 1440 then
                    love.graphics.print("点数 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 120,30,0)
                love.graphics.print("最高点数 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 120,80,0)
                else
                    love.graphics.print("点数 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 280,30,0)
                    love.graphics.print("最高点数 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 280,80,0)
                end
            else
                love.graphics.print("点数 : "..C_GameManager.score[C_GameManager.current_Level_idx],love.graphics.getWidth() - 30,30,0)
                love.graphics.print("最高点数 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],love.graphics.getWidth() - 30,80,0)
            end
        end
    end

    love.graphics.pop()
end

function PlayerScreen:ReBoot()
    self.ui_power_idx = 1
    self.ui_hp_idx = 1

    self.ui_power_reloadTime = 0.0
    self.show_mission = true
    self.mission_timer = 0.0
    self.mission_y = -100
end