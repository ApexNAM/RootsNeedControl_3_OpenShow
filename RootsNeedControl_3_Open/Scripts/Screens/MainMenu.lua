require("Scripts.Maths.Distance")
require("Scripts.Levels.Tutorial_Level")
require("Scripts.Managers.CrossHairManager")

local completeScreenSPR = 
{
    "assets/images/Wave_SPRs/Wave_Daejeon_Level_5_SPR.png"
}

local completeScreenSPR2 = 
{
    "assets/images/Wave_SPRs/Wave_Sejong_Level_5_SPR.png"
}

local completeScreenSPR3 = 
{
    "assets/images/Wave_SPRs/Wave_Incheon_Level_5_SPR.png"
}

local daejeon_level_completeScreenSPR = {} 
local sejong_level_completeScreenSPR = {} 
local incheon_level_completeScreenSPR = {} 

for i, v in ipairs(completeScreenSPR) do
    daejeon_level_completeScreenSPR[i] = love.graphics.newImage(v)
    daejeon_level_completeScreenSPR[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(completeScreenSPR2) do
    sejong_level_completeScreenSPR[i] = love.graphics.newImage(v)
    sejong_level_completeScreenSPR[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(completeScreenSPR3) do
    incheon_level_completeScreenSPR[i] = love.graphics.newImage(v)
    incheon_level_completeScreenSPR[i]:setFilter("nearest", "nearest")
end

MainMenuScreen = {}

function MainMenuScreen:new()
    local current_Table = 
    {
        MenuStates = 
        {
            "PressButtonHome", --1
            "In_Home", -- 2
            "Select_Stage", -- 3
            "Game_Option", -- 4
            "Tutorial_Guide", -- 5
            "CreditScreen", -- 6
            "EndingScreen", -- 7
            "GameEndedScreen", -- 8
            "SelectDifficultyScreen", -- 9
            "Normal_Tutorial_Guide", -- 10
            "Hard_Tutorial_Guide" -- 11
        },

        current_Menu = nil,

        kr_font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",20),
        en_font = love.graphics.newFont("assets/Fonts/pico-8.ttf",20),

        game_logo = love.graphics.newImage("assets/images/Other_SPRs/rnc_logo.png"),
        game_logo_endless = love.graphics.newImage("assets/images/Other_SPRs/RNC_Daejeon.png"),

        menu_x = -100,
        menu_y = 240,

        press_x = 3000,
        
        current_Size = 5,

        main_menu_x_current = 650,
        main_menu_x = { 655, 585, 630 },
        main_menu_idx = 1,
        main_menu_states_TEXT = {"게임 시작 ! ->", "<- 게임 환경설정 ->", " <- 게임 종료"},
        main_menu_states_TEXT_JP = {"ゲームスタート！ ->", "<- ゲーム環境設定 ->", " <- ゲーム終了"},

        select_menu_x_current = 650,
        select_menu_x = { 668, 630, 600, 600 },
        select_menu_states_idx = 1,
        select_menu_states_TEXT = {"보통 (1P) ->", "<- 보통 (2P) ->", " <- 어려움 (1P) -> "," <- 어려움 (2P)"},
        select_menu_states_TEXT_JP = {"普通モード (1P) ->", "<- 普通モード (2P) ->", " <- 困難モード (1P) -> "," <- 困難モード (2P)"},

        main_menu_x_current_en = 650,
        main_menu_x_en = { 580, 540, 550 },
        main_menu_idx_en = 1,
        main_menu_states_TEXT_en = {"start game ! ->", "<- game option ->", " <- quit game"},

        select_menu_x_current_en = 650,
        select_menu_x_en =  { 660, 630, 630, 630 },
        select_menu_states_idx_en = 1,
        select_menu_states_TEXT_en = {"normal (1p) ->", "<- normal (2p) ->", " <- hard (1p) -> "," <- hard (2p)"},

        tutorial_idx = 1,

        kr_press_Font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",20),
        en_press_Font = love.graphics.newFont("assets/Fonts/pico-8.ttf",20),

        kr_main_menu_Font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",40),
        en_main_menu_Font = love.graphics.newFont("assets/Fonts/pico-8.ttf",40),

        kr_game_setting_Font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",60),
        en_game_setting_Font = love.graphics.newFont("assets/Fonts/pico-8.ttf",60),

        kr_game_setting_Font_2 = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",40),
        en_game_setting_Font_2 = love.graphics.newFont("assets/Fonts/pico-8.ttf",25),

        kr_key_guide_small = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",15),
        en_key_guide_small = love.graphics.newFont("assets/Fonts/pico-8.ttf",15),

        kr_tutorial_font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",30),
        en_tutorial_font = love.graphics.newFont("assets/Fonts/pico-8.ttf",20),


        rocket_spr_t = love.graphics.newImage("assets/images/Other_SPRs/ROCK_SPR_RIGHT_Who.png"),
        tank_spr_t = love.graphics.newImage("assets/images/Tank_SPRs/RNC_TANK_RIGHT_SPR_WHO.png"),
        jet_spr_t = love.graphics.newImage("assets/images/Other_SPRs/RNC_FD_96_Right_SPR_Who.png"),

        exit_Time = 0.0,
        game_Ended_Time = 0.0,

        game_ending_idx_text = 1,

        setting_menu_idx = 1
    }

    setmetatable(current_Table, self)
    self.__index = self

    return current_Table
end

function MainMenuScreen:Init()

    self.current_Menu = self.MenuStates[1]

    self.game_logo:setFilter("nearest", "nearest")
    self.game_logo_endless:setFilter("nearest","nearest")

    self.rocket_spr_t:setFilter("nearest", "nearest")
    self.tank_spr_t:setFilter("nearest", "nearest")
    self.jet_spr_t:setFilter("nearest", "nearest")

    self.kr_press_Font:setFilter("nearest", "nearest")
    self.en_press_Font:setFilter("nearest", "nearest")

    self.kr_main_menu_Font:setFilter("nearest", "nearest")
    self.en_main_menu_Font:setFilter("nearest", "nearest")

    self.kr_game_setting_Font:setFilter("nearest", "nearest")
    self.en_game_setting_Font:setFilter("nearest", "nearest")

    self.kr_game_setting_Font_2:setFilter("nearest", "nearest")
    self.en_game_setting_Font_2:setFilter("nearest", "nearest")

    self.kr_key_guide_small:setFilter("nearest", "nearest")
    self.en_key_guide_small:setFilter("nearest", "nearest")

    self.kr_tutorial_font:setFilter("nearest", "nearest")
    self.en_tutorial_font:setFilter("nearest", "nearest")
end

function MainMenuScreen:Update()
    if Current_Lang.language_current == 1 or Current_Lang.language_current == 3 then
        love.graphics.setFont(self.kr_font)

        if self.current_Menu == self.MenuStates[1] then
            self.menu_x = Lerp(300,self.menu_x, 0.95)
            self.press_x = Lerp(530,self.press_x,0.8)
            self.current_Size = Lerp(40,self.current_Size, 0.965)
        elseif self.current_Menu == self.MenuStates[2] then

            self.menu_x = Lerp(300,self.menu_x, 0.95)
            self.press_x = Lerp(530,self.press_x,0.8)
            self.current_Size = Lerp(40,self.current_Size, 0.965)

            self.menu_y = Lerp(95,self.menu_y,0.95)
    
            self.main_menu_x_current = Lerp(self.main_menu_x[self.main_menu_idx],self.main_menu_x_current, 0.85)
        
        elseif self.current_Menu == self.MenuStates[3] then
            
        elseif self.current_Menu == self.MenuStates[4] then
    
        elseif self.current_Menu == self.MenuStates[5] then

        elseif self.current_Menu == self.MenuStates[6] then
            self.exit_Time = self.exit_Time + 1

            if self.exit_Time > 500 then
                love.event.quit()
                self.exit_Time = 0.0
            end
        elseif self.current_Menu == self.MenuStates[7] then

        elseif self.current_Menu == self.MenuStates[8] then
            self.game_Ended_Time = self.game_Ended_Time + 1

            if self.game_Ended_Time % 300 == 0 then
                self.current_Menu = self.MenuStates[7]
                self.game_Ended_Time = 0.0
            end
        elseif self.current_Menu == self.MenuStates[9] then
            self.select_menu_x_current = Lerp(self.select_menu_x[self.select_menu_states_idx],self.select_menu_x_current, 0.85)
        elseif self.current_Menu == self.MenuStates[10] then
            C_Tutorial_Level_Manager:Update()
        elseif self.current_Menu == self.MenuStates[11] then
            C_Tutorial_Level_Manager:Update()
        end
    elseif Current_Lang.language_current == 2 then
        love.graphics.setFont(self.en_font)

        if self.current_Menu == self.MenuStates[1] then
            self.menu_x = Lerp(300,self.menu_x, 0.95)
            self.press_x = Lerp(565,self.press_x,0.8)
            self.current_Size = Lerp(40,self.current_Size, 0.965)
        elseif self.current_Menu == self.MenuStates[2] then

            self.menu_x = Lerp(300,self.menu_x, 0.95)
            self.press_x = Lerp(565,self.press_x,0.8)
            self.current_Size = Lerp(40,self.current_Size, 0.965)

            self.menu_y = Lerp(95,self.menu_y,0.95)
    
            self.main_menu_x_current_en = Lerp(self.main_menu_x_en[self.main_menu_idx_en],self.main_menu_x_current_en, 0.85)
        
        elseif self.current_Menu == self.MenuStates[3] then
            
        elseif self.current_Menu == self.MenuStates[4] then
    
        elseif self.current_Menu == self.MenuStates[5] then

        elseif self.current_Menu == self.MenuStates[6] then
            self.exit_Time = self.exit_Time + 1

            if self.exit_Time > 500 then
                love.event.quit()
                self.exit_Time = 0.0
            end
        elseif self.current_Menu == self.MenuStates[7] then

        elseif self.current_Menu == self.MenuStates[8] then
            self.game_Ended_Time = self.game_Ended_Time + 1

            if self.game_Ended_Time % 300 == 0 then
                self.current_Menu = self.MenuStates[7]
                self.game_Ended_Time = 0.0
            end
        elseif self.current_Menu == self.MenuStates[9] then
            self.select_menu_x_current_en = Lerp(self.select_menu_x_en[self.select_menu_states_idx_en],self.select_menu_x_current_en, 0.85)
        elseif self.current_Menu == self.MenuStates[10] then
            C_Tutorial_Level_Manager:Update()
        elseif self.current_Menu == self.MenuStates[11] then
            C_Tutorial_Level_Manager:Update()
        end
    end
end

function MainMenuScreen:draw()

    if Current_Lang.language_current == 1 then
        if self.current_Menu == self.MenuStates[1] then

            if not C_GameManager.endless_Mode then
                love.graphics.draw(self.game_logo, self.menu_x, 240,0,1.5,1.5)
            else
                love.graphics.draw(self.game_logo_endless, self.menu_x, 240,0,1.5,1.5)
            end

            love.graphics.setFont(self.kr_press_Font)
            love.graphics.print("[X]키를 누르면 시작합니다!",self.press_x, 500,0,self.current_Size / 20)
            love.graphics.print("SkagoGames 2023. made in Skago.",600,770,0)
        elseif self.current_Menu == self.MenuStates[2] then

            if not C_GameManager.endless_Mode then
                love.graphics.draw(self.game_logo, self.menu_x, self.menu_y,0,1.5,1.5)
            else
                love.graphics.draw(self.game_logo_endless, self.menu_x, self.menu_y,0,1.5,1.5)
            end

            love.graphics.setFont(self.kr_main_menu_Font)
            love.graphics.print(self.main_menu_states_TEXT[self.main_menu_idx],self.main_menu_x_current, 500)

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[ESC] - 뒤로가기 / [<-] - 이전 / [->] - 다음 / [X] - 메뉴 선택",100,800)
            love.graphics.print("SkagoGames 2023. made in Skago.",1230,800,0)

        elseif self.current_Menu == self.MenuStates[3] then
            
        elseif self.current_Menu == self.MenuStates[4] then

            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.print("환경 설정", 630, 150)

            if self.setting_menu_idx == 1 then
                love.graphics.setFont(self.kr_game_setting_Font_2)
                love.graphics.print("[number 1.] 배경음악 및 효과음 활성화 여부: "..tostring(C_GameManager.isMusicEnabled),300,250)
                love.graphics.print("[number 2.] 카메라 흔들림 여부: "..tostring(Current_RNC_Camera.cameraShakeEnabled),300,300)
                love.graphics.print("[number 3.] 언어 설정: "..Current_Lang.language[1],300,350)
                love.graphics.print("[number 4.] 전체 화면 여부 : "..tostring(love.window.getFullscreen()), 300, 400)

                if C_GameManager.can_Endless_Mode then
                    love.graphics.print("[number 5.] 무한 모드 활성화 여부 : "..tostring(C_GameManager.endless_Mode), 300, 450)
                else
                    love.graphics.print("[잠금] 무한 모드 활성화 여부 : "..tostring(C_GameManager.endless_Mode), 300, 450)
                end

                love.graphics.print("[number 6.] 게임 색상 변경 : "..tostring(C_ShaderManager.current_Shader), 300, 500)
            
                love.graphics.setFont(self.kr_key_guide_small)
                love.graphics.print("[ESC] - 뒤로가기 / [1] ~ [6] - 설정 선택 / [->] 조준경 변경",100,800)
            elseif self.setting_menu_idx == 2 then
                love.graphics.setFont(self.kr_game_setting_Font_2)
                love.graphics.print("1 Player", 330, 250)
                love.graphics.print("2 Player", 1040, 250)

                local width, height = GetWH_Center()
                -- 1 player 
                love.graphics.draw(C_CrossHair_Manager:PrintCenter(false),405,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintLeft(false),405 - 64,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintRight(false),405 + 98,350,0,4,4, width / 2, height / 2)

                -- 2 player
                love.graphics.draw(C_CrossHair_Manager:PrintCenter(true),1120,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintLeft(true),1120 - 64,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintRight(true),1120 + 98,350,0,4,4, width / 2, height / 2)

                love.graphics.setFont(self.kr_key_guide_small)
                love.graphics.print("[ESC] - 뒤로가기 / [1] ~ [3] - 조준경 스킨 변경 (1P) / [4] ~ [6] - 조준경 스킨 변경 (2P) / [<-] 환경 설정",100,800)
            end


        elseif self.current_Menu == self.MenuStates[5] then


            if not C_GameManager.endless_Mode then
                love.graphics.setFont(self.kr_game_setting_Font)
                love.graphics.printf("상황 설명", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.kr_tutorial_font)

                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.print("대전광역시에 방문해주셔서 고맙습니다!",120,250)
                    love.graphics.print("20XX년.. 대전시는 '뿌리꽃'이라는 한 식물에 의해 압도적으로 발전하게 됩니다.",120,290)
                    love.graphics.print("뿌리꽃은 뿌리를 통해 초능력 현상과 무한한 자원을 통해 대전을 최대도시로 성장시켰습니다.",120,325)
                    love.graphics.print("그러나 대전은 위기에 처합니다. 대전에 의해 주도권을 잃어버린 대기업에 의해 위기에 처합니다.",120,380)
                    love.graphics.print("기업들이 뿌리꽃을 위협하자 뿌리꽃의 뿌리는 불안정해지기 시작했습니다.",120,410)

                    love.graphics.print("그래서 당신을 부른겁니다. 뿌리꽃을 보호해주세요. 방법을 알려드리겠습니다.\n\n스테이지 최고 점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then

                    if C_GameManager.current_lock_level >= 2 then
                        love.graphics.print("세종특별자치시에 방문해주셔서 고맙습니다!",120,250)
                        love.graphics.print("전투로부터 몇년 후.. 뿌리꽃은 어느 날 갑자기 사라졌습니다.",120,290)
                        love.graphics.print("시간이 지나면서.. 어째서인지 뿌리꽃은 세종시에서 발견하게 되었습니다.",120,325)
                        love.graphics.print("대기업들의 뿌리꽃 파괴는 현재진행형입니다. 그렇게 기업들은 또 다시 뿌리꽃을 파괴하려고 합니다.",120,380)
                        love.graphics.print("뿌리꽃은 이제 대기업들의 제거 대상이라는 것을 재확인했습니다. 우리는 어떻게 했을까요?",120,410)

                        love.graphics.print("그래서 당신을 부른겁니다. 뿌리꽃을 다시 한번 보호해주세요. 방법을 알려드리겠습니다.\n\n스테이지 최고 점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("이 스테이지는 잠금처리 된 상황입니다.",C_GameManager.textWidth, 250, love.graphics.getWidth(), "center")
                        love.graphics.printf("해당 스테이지를 잠금해제 처리를 위해서는 다음과 같은 행동이 필요합니다.",C_GameManager.textWidth, 290, love.graphics.getWidth(), "center")
                        love.graphics.printf("대전광역시 스테이지 (비-엔들리스 모드)를 완료 하십시오.",C_GameManager.textWidth, 325, love.graphics.getWidth(), "center")
                    end


                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then

                    if C_GameManager.current_lock_level >= 3 then
                        love.graphics.print("인천광역시에 방문해주셔서 고맙습니다!",120,250)
                        love.graphics.print("뿌리꽃이 다시 돌아왔습니다. 뿌리꽃은 인천 계양구에서 발견되었습니다.",120,290)
                        love.graphics.print("그리고 이상하게도 뿌리꽃은 쇠락했던 수도권을 풍부하게 발전시키게 됩니다.",120,325)
                        love.graphics.print("이 사실을 알게 된 대전시는 뿌리꽃을 되찾기 위해 병력을 모아 인천으로 향하고 있습니다.",120,380)
                        love.graphics.print("이제 기업들은 입장이 바뀌었습니다. 뿌리꽃은 기업의 영광을 되찾을 수 있는 유일한 존재라는 것을..",120,410)

                        love.graphics.print("그래서 기업들은 이제 뿌리꽃과 화해를 선언하여 대전시로부터 뿌리꽃을 지키려고 합니다...\n\n스테이지 최고 점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("이 스테이지는 잠금처리 된 상황입니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("해당 스테이지를 잠금해제 처리를 위해서는 다음과 같은 행동이 필요합니다.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("세종특별자치시 스테이지 (비-엔들리스 모드)를 완료 하십시오.",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                end
            else
                love.graphics.setFont(self.kr_game_setting_Font)
                love.graphics.printf("무한의 대전광역시", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.kr_tutorial_font)

                if C_GameManager.current_Level == C_GameManager.set_Level[4] then
                    love.graphics.print("동구에 방문해주셔서 고맙습니다!",120,250)
                    love.graphics.print("대전광역시의 원조와 같은 동구. 대기업 연합군의 침공 역시 동구에서 발생했습니다.",120,290)
                    love.graphics.print("그중에서 대기업 동부전선은 동구에 존재하는 뿌리꽃인 판암꽃을 파괴하려고 합니다.",120,325)
                    love.graphics.print("판암꽃은 대전광역시에서 최초로 발견된 뿌리꽃의 종류 중 하나입니다.",120,380)
                    love.graphics.print("동구청은 판암꽃의 파괴를 막기 위해 대전광역시청보다 신속하게 움직이고 있습니다..",120,410)
        
                    love.graphics.print("대전광역시청의 지원이 올때까지.. 판암꽃을 지켜봅시다!\n\n스테이지 최고 점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                elseif C_GameManager.current_Level == C_GameManager.set_Level[5] then
        
                    if C_GameManager.current_sub_lock_level >= 2 then
                        love.graphics.print("중구에 방문해주셔서 고맙습니다!",120,250)
                        love.graphics.print("과거 대전광역시의 중심지이자 충청남도의 중심지였던 중구.",120,290)
                        love.graphics.print("하지만 뿌리꽃이 중구에서도 등장하면서 쇠락한 중구는 다시 발전하게 됩니다.",120,325)
                        love.graphics.print("그러나 또 다시 위기를 맞이하게 됩니다. 바로 대기업 연합군이죠.",120,380)
                        love.graphics.print("중구청은 과거 중구의 영광을 위하여 다른 자치구보다 협조적으로 움직이고 있습니다.",120,410)
        
                        love.graphics.print("옛 중구의 영광을 위하여!\n\n스테이지 최고 점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("이 스테이지는 잠금처리 된 상황입니다.",C_GameManager.textWidth, 250, love.graphics.getWidth(), "center")
                        love.graphics.printf("해당 스테이지를 잠금해제 처리를 위해서는 다음과 같은 행동이 필요합니다.",C_GameManager.textWidth, 290, love.graphics.getWidth(), "center")
                        love.graphics.printf("대전광역시 동구 스테이지에서 1000점을 달성 하십시오.",C_GameManager.textWidth, 325, love.graphics.getWidth(), "center")
                    end
        
        
                elseif C_GameManager.current_Level == C_GameManager.set_Level[6] then
        
                    if C_GameManager.current_sub_lock_level >= 3 then
                        love.graphics.print("서구에 방문해주셔서 고맙습니다!",120,250)
                        love.graphics.print("대전광역시의 수도와 같은 역할. 서구.",120,290)
                        love.graphics.print("예상치 못한 상황이 발생하게 됩니다. 뿌리꽃의 등장했습니다.",120,325)
                        love.graphics.print("뿌리꽃은 대전의 중심지인 서구를 더 강력하게 키워나갔습니다.",120,380)
                        love.graphics.print("하지만 대기업 연합군의 등장으로 서구는 위기를 맞이하게 됩니다.",120,410)
        
                        love.graphics.print("서구의 발전을 위하여.. 그리고 대전과 뿌리꽃을 위하여....\n\n스테이지 최고 점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("이 스테이지는 잠금처리 된 상황입니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("해당 스테이지를 잠금해제 처리를 위해서는 다음과 같은 행동이 필요합니다.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("대전광역시 중구 스테이지에서 1000점을 달성 하십시오.",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[7] then
        
                    if C_GameManager.current_sub_lock_level >= 4 then
                        love.graphics.print("유성구에 방문해주셔서 고맙습니다!",120,250)
                        love.graphics.print("대전광역시에서 가장 중요한 자치구.. 유성구!",120,290)
                        love.graphics.print("유성구는 뿌리꽃에 대한 연구를 통해 대전광역시를 성장시켰습니다.",120,325)
                        love.graphics.print("이 때문일까.. 대기업 연합군에게 가장 먼저 공격당한 유성구..",120,380)
                        love.graphics.print("그러나 유성구는 포기하지 않습니다. 뿌리꽃에 대해 열심히 연구한 유성구입니다.",120,410)
        
                        love.graphics.print("유성구는 뿌리꽃의 가치를 위해.. 더 열심히 싸우고 있습니다.\n\n스테이지 최고 점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("이 스테이지는 잠금처리 된 상황입니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("해당 스테이지를 잠금해제 처리를 위해서는 다음과 같은 행동이 필요합니다.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("대전광역시 서구 스테이지에서 1000점을 달성 하십시오.",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[8] then
        
                    if C_GameManager.current_sub_lock_level >= 5 then
                        love.graphics.print("대덕구에 방문해주셔서 고맙습니다!",120,250)
                        love.graphics.print("대전에서 가장 평화로운 자치구인 대덕구에서..",120,290)
                        love.graphics.print("마지막 전투가 벌어지고 있습니다....",120,325)
                        love.graphics.print("바로 대기업 연합군과의 마지막 전투인 대덕전투.",120,380)
                        love.graphics.print("모든 지역은 뿌리꽃을 지켜냈지만.. 대덕구는 그렇지 않은 상황입니다.",120,410)
        
                        love.graphics.print("대덕 전투에서 승리하여 대전과 뿌리꽃을 지켜냅시다!\n\n스테이지 최고 점수 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("이 스테이지는 잠금처리 된 상황입니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("해당 스테이지를 잠금해제 처리를 위해서는 다음과 같은 행동이 필요합니다.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("대전광역시 유성구 스테이지에서 1000점을 달성 하십시오.",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                end
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[X] - 난이도 선택으로 이동하기 / [<-][->] - 다른 시나리오 선택",100,800)
            
        elseif self.current_Menu == self.MenuStates[6] then
            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.printf("정리 소개", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

            love.graphics.setFont(self.kr_tutorial_font)
            love.graphics.print("제작자 : 최예찬 (!CyberApex) / 개발 기간 : 2023.02.16 ~ 2023.03.09",180,250)
            love.graphics.print("제작 도구 : Love2D 게임 프레임워크",180,285)
            love.graphics.print("프로그래밍 언어 : Lua (Lua.runtime.version: LuaJIT)",180,320)
            love.graphics.print("개발 환경 : Visual Studio Code",180,380)

            love.graphics.print("리소스 도구 1 : Blender (모델링 및 이미지 렌더링)",180,415)
            love.graphics.print("리소스 도구 2: Aseprite (리소스 보조 제작)",180,450)

            love.graphics.print("폰트 리소스 : Galmuri9.ttf (KR) / pico-8.ttf (EN)",180,515)
            love.graphics.print("사운드 리소스 : freesound.org / pico-8 sfx (자작) / K00Sin (스테이지 배경음악 제작 지원)",180,545)
        elseif self.current_Menu == self.MenuStates[7] then

            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw(1)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("대기업들의 군대들이 전멸되었습니다.",180,450)
                    love.graphics.print("대전이 폐허가 되었습니다. 그러나 뿌리꽃은 무사합니다.",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw(2)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("대전을 재건하기 위해 중앙정부와 시민단체들이 대전을 방문했습니다.",180,450)
                    love.graphics.print("그러나.. 우리는 걱정하지 않아도 됩니다. 뿌리꽃이 우리 대전을 재건할 것입니다.",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw(3)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("뿌리꽃이 바로 대전이고, 대전이 바로 당신입니다.\nTHE END. 플레이해주셔서 감사합니다.\n\n최종점수는 "..C_GameManager.score[C_GameManager.current_Level_idx].."점입니다.",180,450)
                    love.graphics.print("다음 페이지로 넘어가면 메인메뉴로 돌아갑니다.\n다음에도 대전을 지켜주세요 !",180,650)
                end
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw_2(1)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("대기업들의 군대들은 또 패배되었습니다.",180,450)
                    love.graphics.print("세종시도 과거 대전처럼 피해를 입었습니다. 하지만 뿌리꽃은 안전합니다.",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw_2(2)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("뿌리꽃은 다음 날 사라졌습니다. 어디로 갔을까요?",180,450)
                    love.graphics.print("중앙정부는 뿌리꽃에 대한 의문을 품은 채 세종시를 재건합니다.",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw_2(3)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("세종이 미래다.\nTHE END. 플레이해주셔서 감사합니다.\n\n최종점수는 "..C_GameManager.score[C_GameManager.current_Level_idx].."점입니다.",180,450)
                    love.graphics.print("다음 페이지로 넘어가면 메인메뉴로 돌아갑니다.\n다음에도 세종을 지켜주세요 !",180,650)
                end
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw_3(1)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("드디어 기업들은 승리했습니다! 대전시는 인천에서 철수했습니다.",180,450)
                    love.graphics.print("기업들은 희망을 얻게 되었습니다. 뿌리꽃은 더이상 기업의 적이 아닙니다.",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw_3(2)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("2년 후.. 기업들과 대전시는 화해를 선언하였습니다.",180,450)
                    love.graphics.print("이로써 오랜 전쟁은 인천 영종도에서 평화협정을 통해 종결되었습니다.",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw_3(3)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("영원한 평화를 위하여...\nTHE END. 플레이해주셔서 감사합니다.\n\n최종점수는 "..C_GameManager.score[C_GameManager.current_Level_idx].."점입니다.",180,450)
                    love.graphics.print("다음 페이지로 넘어가면 메인메뉴로 돌아갑니다.\n다음에도 인천을 지켜주세요 !",180,650)

                    if not C_GameManager.can_Endless_Mode then
                        love.graphics.setFont(self.kr_key_guide_small)
                        love.graphics.print("무한 모드 'Roots Need Daejeon 0.5'가 잠금해제 되었습니다.",180,750)
                    end
                end
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[->] - 다음 페이지",100,800)
        elseif self.current_Menu == self.MenuStates[8] then
            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(daejeon_level_completeScreenSPR[1],640,200,0,1,1)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(sejong_level_completeScreenSPR[1],640,200,0,1,1)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(incheon_level_completeScreenSPR[1],640,200,0,1,1)
            end
        elseif self.current_Menu == self.MenuStates[9] then

            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.printf("난이도 설정", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

            love.graphics.setFont(self.kr_game_setting_Font_2)
            love.graphics.print(self.select_menu_states_TEXT[self.select_menu_states_idx],self.select_menu_x_current, 300)

            love.graphics.setFont(self.kr_tutorial_font)

            if self.select_menu_states_idx == 1 then
                love.graphics.printf("체력은 자동으로 회복되고, 피구름은 등장하지 않습니다.", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx == 2 then
                love.graphics.printf("플레이어 인원은 2인으로 구성됩니다.", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("체력은 자동으로 회복되고, 피구름은 등장하지 않습니다.", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx == 3 then
                love.graphics.printf("체력은 조준경을 붉은 물방울에 맞아야 회복되고, 피구름이 등장합니다.", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("그리고 뿌리꽃의 위치를 조준경을 통해 변경할 수 있습니다.", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
                love.graphics.printf("진행률이 거의 도달하면 뿌리꽃은 통제를 잃게 됩니다! 명심하세요!", C_GameManager.textWidth, 620, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx == 4 then
                love.graphics.printf("플레이어 인원은 2인으로 구성됩니다.", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("체력은 조준경을 붉은 물방울에 맞아야 회복되고, 피구름이 등장합니다.", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
                love.graphics.printf("그리고 뿌리꽃의 위치를 조준경을 통해 변경할 수 있습니다.", C_GameManager.textWidth, 620, love.graphics.getWidth(), "center")
                love.graphics.printf("진행률이 거의 도달하면 뿌리꽃은 통제를 잃게 됩니다! 명심하세요!", C_GameManager.textWidth, 670, love.graphics.getWidth(), "center")
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[X] - 해당 난이도 선택 / [<-][->] - 다른 난이도 선택",100,800)

        elseif self.current_Menu == self.MenuStates[10] then

            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.printf("튜토리얼", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")
            
            C_Tutorial_Level_Manager:draw()

            love.graphics.setFont(self.kr_press_Font)
            if C_Tutorial_Level_Manager.tutorial_idx == 1 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("방향키를 이용하여 조준경을 조작할 수 있습니다.\n\n2인모드 : [esdf]",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("방향키를 이용하여 조준경을 조작할 수 있습니다.\n\n마우스 : 움직이기\n\n만약 [SPACE]키를 누르면 자동모드로 전환됩니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end
                
            elseif C_Tutorial_Level_Manager.tutorial_idx == 2 then
                love.graphics.printf("뿌리꽃을 조준한 상태로 가만히 있으면 뿌리의 길이가 줄여집니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
            elseif C_Tutorial_Level_Manager.tutorial_idx == 3 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("적을 조준한 상태에서 [X] 또는 [M]키를 누르면 뿌리꽃을 위협하는 적들을 파괴할 수 있습니다.\n\n2인모드 : [W]\n\n시간이 지나면 다양한 적들과 대립할 수 있습니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("적을 조준한 상태에서 [X]키를 누르면 뿌리꽃을 위협하는 적들을 파괴할 수 있습니다.\n[R]키를 통해 충전이 가능하지만 완전히 충전되지 않고 절반 정도 충전됩니다.\n\n마우스 : 좌클릭\n\n시간이 지나면 다양한 적들과 대립할 수 있습니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end
        
            elseif C_Tutorial_Level_Manager.tutorial_idx == 4 then
                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.printf("행운을 빕니다! 뿌리꽃은 무너진 대전의 유일한 희망입니다!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                    love.graphics.printf("행운을 빕니다! 다시 반복되지 않도록.. 세종을 지켜봅시다!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    love.graphics.printf("이제 상황은 바뀌었습니다! 뿌리꽃은 이제 기업부활의 희망입니다!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("행운을 빕니다! 대전 전역을 열심히 지켜주세요!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                end
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[<-] - 이전 페이지 / [->] - 다음 페이지",100,800)
        elseif self.current_Menu == self.MenuStates[11] then
            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.printf("튜토리얼", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")
            
            C_Tutorial_Level_Manager:draw()

            love.graphics.setFont(self.kr_press_Font)
            if C_Tutorial_Level_Manager.tutorial_idx == 1 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("방향키를 이용하여 조준경을 조작할 수 있습니다.\n\n2인모드 : [esdf]",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("방향키를 이용하여 조준경을 조작할 수 있습니다.\n\n마우스 (1인모드 한정) : 움직이기",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end
                
            elseif C_Tutorial_Level_Manager.tutorial_idx == 2 then
                love.graphics.printf("뿌리꽃을 조준한 상태로 가만히 있으면 뿌리의 길이가 줄여집니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
            elseif C_Tutorial_Level_Manager.tutorial_idx == 3 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("조준한 상태에서 ([Z] 또는 [N]) + [좌우 방향키]키를 누르면 뿌리꽃의 위치를 변경할 수 있습니다..\n\n2인모드 : [Q] + [S,F]\n\n그러나 진행률이 높게 되면 뿌리꽃은 자유자재로 움직일 수 있습니다. 이때부터는 통제에 집중해야 합니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("조준한 상태에서 [Z] + [좌우 방향키]키를 누르면 뿌리꽃의 위치를 변경할 수 있습니다..\n\n마우스 (1인모드 한정) : [마우스 우클릭] + [마우스 좌우 이동]\n\n그러나 진행률이 높게 되면 뿌리꽃은 자유자재로 움직일 수 있습니다. 이때부터는 통제에 집중해야 합니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end

                
            elseif C_Tutorial_Level_Manager.tutorial_idx == 4 then
                love.graphics.printf("구름에서 나오는 붉은 물방울은 뿌리꽃에게 치명적이지만\n조준경이 물방울에 맞을 경우 뿌리꽃의 체력을 회복시킵니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
            elseif C_Tutorial_Level_Manager.tutorial_idx == 5 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("적을 조준한 상태에서 [X] 또는 [M]키를 누르면 뿌리꽃을 위협하는 적들을 파괴할 수 있습니다.\n\n2인모드 : [W]\n\n시간이 지나면 다양한 적들과 대립할 수 있습니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("적을 조준한 상태에서 [X]키를 누르면 뿌리꽃을 위협하는 적들을 파괴할 수 있습니다.\n[R]키를 통해 충전이 가능하지만 완전히 충전되지 않고 절반 정도 충전됩니다.\n\n마우스 : 좌클릭\n\n시간이 지나면 다양한 적들과 대립할 수 있습니다.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end
            elseif C_Tutorial_Level_Manager.tutorial_idx == 6 then
                
            
                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.printf("행운을 빕니다! 뿌리꽃은 무너진 대전의 유일한 희망입니다!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                    love.graphics.printf("행운을 빕니다! 다시 반복되지 않도록.. 세종을 지켜봅시다!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    love.graphics.printf("이제 상황은 바뀌었습니다! 뿌리꽃은 이제 기업부활의 희망입니다!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("행운을 빕니다! 대전 전역을 열심히 지켜주세요!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                end
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[<-] - 이전 페이지 / [->] - 다음 페이지",100,800)
        end
 
    elseif Current_Lang.language_current == 2 then
        if self.current_Menu == self.MenuStates[1] then

            if not C_GameManager.endless_Mode then
                love.graphics.draw(self.game_logo, self.menu_x, 240,0,1.5,1.5)
            else
                love.graphics.draw(self.game_logo_endless, self.menu_x, 240,0,1.5,1.5)
            end

            love.graphics.setFont(self.en_press_Font)
            love.graphics.print("press [x] start!",self.press_x, 500, 0, self.current_Size / 20)
            love.graphics.print("skagogames 2023. made in skago.",555,770,0)
            
        elseif self.current_Menu == self.MenuStates[2] then

            if not C_GameManager.endless_Mode then
                love.graphics.draw(self.game_logo, self.menu_x, self.menu_y,0,1.5,1.5)
            else
                love.graphics.draw(self.game_logo_endless, self.menu_x, self.menu_y,0,1.5,1.5)
            end

            love.graphics.setFont(self.en_main_menu_Font)
            love.graphics.print(self.main_menu_states_TEXT_en[self.main_menu_idx_en],self.main_menu_x_current_en, 500)

            love.graphics.setFont(self.en_key_guide_small)
            love.graphics.print("[esc] - go back /  [<-] - previous /  [->] - next / [x] - select menu",100,800)
            love.graphics.print("skagogames 2023. made in skago.",1100,800,0)
        elseif self.current_Menu == self.MenuStates[3] then
            
        elseif self.current_Menu == self.MenuStates[4] then

            love.graphics.setFont(self.en_game_setting_Font)
            love.graphics.print("game setting", 530, 150)

            if self.setting_menu_idx == 1 then
                love.graphics.setFont(self.en_game_setting_Font_2)
                love.graphics.print("[number 1.] background music and sfx enabled: "..tostring(C_GameManager.isMusicEnabled),300,250)
                love.graphics.print("[number 2.] camera shake enabled: "..tostring(Current_RNC_Camera.cameraShakeEnabled),300,300)
                love.graphics.print("[number 3.] language : "..Current_Lang.language[2],300,350)
                love.graphics.print("[number 4.] fullscreen enabled : "..tostring(love.window.getFullscreen()), 300, 400)

                if C_GameManager.can_Endless_Mode then
                    love.graphics.print("[number 5.] endless mode enabled : "..tostring(C_GameManager.endless_Mode), 300, 450)
                else
                    love.graphics.print("[locked.] endless mode enabled : "..tostring(C_GameManager.endless_Mode), 300, 450)
                end
                
                love.graphics.print("[number 6.] game color change : "..tostring(C_ShaderManager.current_Shader), 300, 500)

                love.graphics.setFont(self.en_key_guide_small)
                love.graphics.print("[esc] - go back /  [1~6] - enabled or disabled setting / [->] - change crosshair",100,800)
            elseif self.setting_menu_idx == 2 then
                love.graphics.setFont(self.en_game_setting_Font_2)
                love.graphics.print("1 player", 335, 250)
                love.graphics.print("2 player", 1050, 250)

                local width, height = GetWH_Center()
                -- 1 player 
                love.graphics.draw(C_CrossHair_Manager:PrintCenter(false),405,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintLeft(false),405 - 64,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintRight(false),405 + 98,350,0,4,4, width / 2, height / 2)

                -- 2 player
                love.graphics.draw(C_CrossHair_Manager:PrintCenter(true),1120,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintLeft(true),1120 - 64,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintRight(true),1120 + 98,350,0,4,4, width / 2, height / 2)

                love.graphics.setFont(self.kr_key_guide_small)
                love.graphics.print("[esc] - go back /  [1~3] - change crosshair skin (1p) / [4~6] - hange crosshair skin (2p) / [<-] - game setting",100,800)
            end


        elseif self.current_Menu == self.MenuStates[5] then

            if not C_GameManager.endless_Mode then
                love.graphics.setFont(self.en_game_setting_Font)
                love.graphics.printf("hello!", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.en_tutorial_font)
                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.print("thank you for visiting daejeon! and thank you for your help.",120,250)
                    love.graphics.print("one day in 20xx... daejeon was overwhelmingly developed by a plant called roots flower.",120,290)
                    love.graphics.print("root flower has grown daejeon into the largest city..",120,325)
                    love.graphics.print("through supernatural powers and infinite resources through its roots.",120,360)
                    love.graphics.print("but as daejeon grows, large companies lose control,",120,390)

                    love.graphics.print("as companies threatened the root flower, the root of the root flower began to become unstable.",120,440)
                    love.graphics.print("that's why i called you. learn how to protect roots flower.\n\nhighscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)

                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                    if C_GameManager.current_lock_level >= 2 then
                        love.graphics.print("thank you for visiting sejong city!",120,250)
                        love.graphics.print("a few years after the battle.. the root flower suddenly disappeared one day.",120,290)
                        love.graphics.print("as time goes by.. for some reason, the root flower was found in sejong city.",120,325)
                        love.graphics.print("the destruction of root flowers by large corporations is ongoing.",120,380)
                        love.graphics.print("..and so companies are trying to destroy the root flower again.",120,410)
                        love.graphics.print("we have reaffirmed that root flowers are now subject to removal by large corporations. what did we do?",120,450)

                        love.graphics.print("that's why i called you. please protect the root flower again. i'll tell you how.\n\nhighscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("this stage is locked out.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("the following actions are required to unlock the stage.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("you need stage clear (daejeon stage)",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    if C_GameManager.current_lock_level >= 3 then
                        love.graphics.print("thank you for visiting incheon city! and the position has changed.",120,250)
                        love.graphics.print("the root flower is back. root flowers were found in gyeyang-gu, incheon.",120,290)
                        love.graphics.print("and strangely enough, root flowers enrich the declining metropolitan area.",120,325)
                        love.graphics.print("upon learning of this, the daejeon city invades incheon to regain the root flower.",120,380)
                        love.graphics.print("companies are now protecting the root flower, in order to revive the glory of the past.",120,410)

                        love.graphics.print("so companies are now trying to protect incheon to protect the root flower.\n\nhighscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("this stage is locked out.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("the following actions are required to unlock the stage.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("you need stage clear (sejong city stage)",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                end 
            else
                love.graphics.setFont(self.en_game_setting_Font)
                love.graphics.printf("around the daejeon", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.en_tutorial_font)

                if C_GameManager.current_Level == C_GameManager.set_Level[4] then
                    love.graphics.print("thank you for visiting dong-gu!",120,250)
                    love.graphics.print("the allied invasion of large corporations started in the east.",120,290)
                    love.graphics.print("the goal of companies is to destroy the root flower.",120,325)
                    love.graphics.print("the root flower in dong-gu is the first root flower in daejeon.",120,380)
                    love.graphics.print("the office is moving quickly to prevent the destruction of the root flower..",120,410)
        
                    love.graphics.print("let's protect the root flower until the end!\n\nhighscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                elseif C_GameManager.current_Level == C_GameManager.set_Level[5] then
        
                    if C_GameManager.current_sub_lock_level >= 2 then
                        love.graphics.print("thank you for visiting jung-gu!",120,250)
                        love.graphics.print("jung-gu, formerly the center of daejeon.",120,290)
                        love.graphics.print("however, jung-gu, where the root flower has declined, will develop again.",120,325)
                        love.graphics.print("but we're facing another crisis. it's a coalition of large corporations.",120,380)
                        love.graphics.print("jung-gu office builds strong security for the glory of jung-gu in the past.",120,410)
        
                        love.graphics.print("to the glory of jung-gu!\n\nhighscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("this stage is locked out.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("the following actions are required to unlock the stage.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("achieve 1000 points at dong-gu stage in daejeon.",C_GameManager.textWidth, 325, love.graphics.getWidth(), "center")
                    end
        
        
                elseif C_GameManager.current_Level == C_GameManager.set_Level[6] then
        
                    if C_GameManager.current_sub_lock_level >= 3 then
                        love.graphics.print("thank you for visiting seo-gu!",120,250)
                        love.graphics.print("the capital city of daejeon.",120,290)
                        love.graphics.print("unexpected situations will occur. the root flower has appeared.",120,325)
                        love.graphics.print("the root flower grew stronger in the west, the center of daejeon.",120,380)
                        love.graphics.print("but with the emergence of a coalition of large corporations, the west faces a crisis.",120,410)
        
                        love.graphics.print("for the development of the seo-gu. and daejeon.\n\nhighscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("this stage is locked out.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("the following actions are required to unlock the stage.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("achieve 1000 points at jung-gu stage in daejeon.",C_GameManager.textWidth, 325, love.graphics.getWidth(), "center")
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[7] then
        
                    if C_GameManager.current_sub_lock_level >= 4 then
                        love.graphics.print("thank you for visiting yuseong!",120,250)
                        love.graphics.print("the most important autonomous region in daejeon!",120,290)
                        love.graphics.print("yuseong-gu grew daejeon through research on root flowers.",120,325)
                        love.graphics.print("but yuseong-gu was severely damaged by the coalition of large companies..",120,380)
                        love.graphics.print("however, yuseong-gu does not give up.",120,410)
        
                        love.graphics.print("this is yuseong-gu who studied the root flower hard.\n\nhighscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("this stage is locked out.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("the following actions are required to unlock the stage.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("achieve 1000 points at seo-gu stage in daejeon.",C_GameManager.textWidth, 325, love.graphics.getWidth(), "center")
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[8] then
        
                    if C_GameManager.current_sub_lock_level >= 5 then
                        love.graphics.print("thank you for visiting daedeok!",120,250)
                        love.graphics.print("the most peaceful borough in daejeon..",120,290)
                        love.graphics.print("there's a final battle going on...",120,325)
                        love.graphics.print("the battle of daedeok.",120,380)
                        love.graphics.print("the last battle against the allied forces of large corporations.",120,410)
        
                        love.graphics.print("let's win the battle and protect daejeon and root flower!\n\nhighscore : "..C_GameManager.highScore[C_GameManager.current_Level_idx],120,480)
                    else
                        love.graphics.printf("this stage is locked out.",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("the following actions are required to unlock the stage.",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("achieve 1000 points at yuseong stage in daejeon.",C_GameManager.textWidth, 325, love.graphics.getWidth(), "center")
                    end
                end
            end

            love.graphics.setFont(self.en_key_guide_small)
            love.graphics.print("[x] - go select difficulty / [<-][->] change episode",100,800)
        elseif self.current_Menu == self.MenuStates[6] then
            love.graphics.setFont(self.en_game_setting_Font)
            love.graphics.printf("credits", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

            love.graphics.setFont(self.en_tutorial_font)
            love.graphics.print("produced by yechan choi (!cyberapex) / (devtime) - 2023.02.16 ~ 2023.03.09",180,250)
            love.graphics.print("game engine or framework : love2d game framework",180,285)
            love.graphics.print("programming language : lua (lua.runtime.version: luajit)",180,320)
            love.graphics.print("ide : visual studio code",180,380)

            love.graphics.print("sprite program 1 : blender (model and image rendering)",180,415)
            love.graphics.print("sprite program 2: aseprite (sub sprite)",180,450)

            love.graphics.print("use font : galmuri9.ttf (kr) / pico-8.ttf (en)",180,515)
            love.graphics.print("use sound : freesound.org / pico-8 sfx (made with.) / K00Sin (supporting stage bgm production)",180,545)
        elseif self.current_Menu == self.MenuStates[7] then

            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw(1)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("the armies of large corporations were wiped out.",180,450)
                    love.graphics.print("daejeon is in ruins. but the roots flower is safe.",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw(2)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("the central government and civic groups visited daejeon to rebuild it.",180,450)
                    love.graphics.print("but... we don't have to worry. roots will rebuild our daejeon.",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw(3)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("daejeon is u :)\nTHE END. thank you for playing!\n\nfinal score : "..C_GameManager.score[C_GameManager.current_Level_idx],180,450)
                    love.graphics.print("press [->] return main menu. and see you again !",180,650)
                end
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw_2(1)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("the armies of large corporations were defeated again.",180,450)
                    love.graphics.print("sejong city was damaged like daejeon in the past. but root flowers are safe.",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw_2(2)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("the root flower disappeared the next day. where did it go?",180,450)
                    love.graphics.print("the government reconstructs sejong city with the question of root flowers.",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw_2(3)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("sejong is future!\nTHE END. thank you for playing!\n\nfinal score : "..C_GameManager.score[C_GameManager.current_Level_idx],180,450)
                    love.graphics.print("press [->] return main menu. and see you again !",180,650)
                end
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw_3(1)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("the companies finally won! daejeon city withdrew from incheon.",180,450)
                    love.graphics.print("businesses have become hopeful. the root flower is no longer the enemy of business.",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw_3(2)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("two years later, companies and daejeon city declared reconciliation.",180,450)
                    love.graphics.print("thus, the long war ended through a peace treaty in yeongjongdo, incheon.",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw_3(3)
                    love.graphics.setFont(self.en_tutorial_font)
                    love.graphics.print("for eternal peace...together!\nTHE END. thank you for playing!\n\nfinal score : "..C_GameManager.score[C_GameManager.current_Level_idx],180,450)
                    love.graphics.print("press [->] return main menu. and see you again !",180,550)

                    if not C_GameManager.can_Endless_Mode then
                        love.graphics.setFont(self.en_key_guide_small)
                        love.graphics.print("endless mode 'roots need daejeon 0.5' unlocked! ",180,650)
                    end
                end
            end

            love.graphics.setFont(self.en_key_guide_small)
            love.graphics.print("[->] - next page",100,800)
        elseif self.current_Menu == self.MenuStates[8] then
            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(daejeon_level_completeScreenSPR[1],640,200,0,1,1)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(sejong_level_completeScreenSPR[1],640,200,0,1,1)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(incheon_level_completeScreenSPR[1],640,200,0,1,1)
            end
        elseif self.current_Menu == self.MenuStates[9] then
            love.graphics.setFont(self.en_game_setting_Font)
            love.graphics.printf("difficulty", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

            love.graphics.setFont(self.en_game_setting_Font_2)
            love.graphics.print(self.select_menu_states_TEXT_en[self.select_menu_states_idx_en],self.select_menu_x_current_en, 300)

            love.graphics.setFont(self.en_tutorial_font)

            if self.select_menu_states_idx_en == 1 then
                love.graphics.printf("physical strength automatically recovers, and blood clouds do not appear.", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx_en == 2 then
                love.graphics.printf("the number of players is 2 people.", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("Physical strength automatically recovers, and blood clouds do not appear.", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx_en == 3 then
                love.graphics.printf("physical strength recovers by hitting crosshair with red droplets, and blood clouds appear.", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("and you can change the location of root flowers.", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
                love.graphics.printf("when the progress is almost reached, the root flower loses control! keep that in mind!", C_GameManager.textWidth, 620, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx_en == 4 then
                love.graphics.printf("the number of players is 2 people.", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("physical strength recovers by hitting crosshair with red droplets, and blood clouds appear.", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
                love.graphics.printf("and you can change the location of root flowers.", C_GameManager.textWidth, 620, love.graphics.getWidth(), "center")
                love.graphics.printf("when the progress is almost reached, the root flower loses control! keep that in mind!", C_GameManager.textWidth, 670, love.graphics.getWidth(), "center")
            end

            love.graphics.setFont(self.en_key_guide_small)
            love.graphics.print("[X] - select this difficulty / [<-][->] - select other difficulty",100,800)
            
        elseif self.current_Menu == self.MenuStates[10] then

            love.graphics.setFont(self.en_game_setting_Font)
            love.graphics.printf("tutorial", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

            C_Tutorial_Level_Manager:draw()

            love.graphics.setFont(self.en_press_Font)
            if C_Tutorial_Level_Manager.tutorial_idx == 1 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("you can use the [arrow key] to move the crosshair.\n\n2 player mode : [e,s,d,f]",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("you can use the [arrow key] to move the crosshair.\n\nmouse : move\n\nif press [space] key to switch to auto mode.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                end
                
            elseif C_Tutorial_Level_Manager.tutorial_idx == 2 then
                love.graphics.printf("staying still with the root flower aimed at reduces the length of the root.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
            elseif C_Tutorial_Level_Manager.tutorial_idx == 3 then
                
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("press the [x] or [m] key while aiming to destroy enemies who threaten the root flower.\n\n2 player mode : [w]\n\nover time, you can confront various enemies.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("press the [x] key while aiming to destroy enemies who threaten the root flower.\n\npress the [r] key to charge it, but it is not fully charged, but half charged.\n\nmouse : left mouse button\n\nover time, you can confront various enemies.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                end
            elseif C_Tutorial_Level_Manager.tutorial_idx == 4 then
                love.graphics.setFont(self.en_game_setting_Font_2)
                
            
                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.printf("good luck! and please protect daejeon!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                    love.graphics.printf("good luck! and please protect sejong!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    love.graphics.printf("now things have changed!\n\nroot flower is now a hope for corporate revival!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("good luck! please protect the entire daejeon!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                end
            end

            love.graphics.setFont(self.en_key_guide_small)
            love.graphics.print("[<-] - previous page /  [->] - next page",100,800)
        elseif self.current_Menu == self.MenuStates[11] then

            love.graphics.setFont(self.en_game_setting_Font)
            love.graphics.printf("tutorial", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

            C_Tutorial_Level_Manager:draw()

            love.graphics.setFont(self.en_press_Font)
            if C_Tutorial_Level_Manager.tutorial_idx == 1 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("you can use the [arrow key] to move the crosshair.\n\n2 player mode : [e,s,d,f]",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("you can use the [arrow key] to move the crosshair.\n\nmouse : move",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                end

            elseif C_Tutorial_Level_Manager.tutorial_idx == 2 then
                love.graphics.printf("staying still with the root flower aimed at reduces the length of the root.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")

            elseif C_Tutorial_Level_Manager.tutorial_idx == 3 then

                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("while aiming enemies, press the ([z] or [n]) + [arrow key (left right)]\nkey to change the position of the root flower.\n\n2 player mode input : [q] + [s,f]\n\nhowever, if the progress is high, the root flower can move freely.\nfrom this point on, you have to focus on control.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")

                else
                    love.graphics.printf("while aiming enemies, press the [z] + [arrow key (left right)]\nkey to change the position of the root flower.\n\nmouse (1P only): [right mouse button] + [left or right mouse move]\n\nhowever, if the progress is high, the root flower can move freely.\nfrom this point on, you have to focus on control.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                end
            
            elseif C_Tutorial_Level_Manager.tutorial_idx == 4 then
                love.graphics.printf("red droplets from clouds are fatal to root flowers,\nbut if crosshair is hit by water droplets, it restores hp in root flowers.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
            elseif C_Tutorial_Level_Manager.tutorial_idx == 5 then

                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("press the [x] or [m] key while aiming to destroy enemies who threaten the root flower.\n\n2 player mode : [w]\n\nover time, you can confront various enemies.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("press the [x] key while aiming to destroy enemies who threaten the root flower.\n\npress the [r] key to charge it, but it is not fully charged, but half charged.\n\nmouse mouse (1P only): left mouse button\n\nover time, you can confront various enemies.",C_GameManager.textWidth,250,love.graphics.getWidth(), "center")
                end

                
            elseif C_Tutorial_Level_Manager.tutorial_idx == 6 then
                love.graphics.setFont(self.en_game_setting_Font_2)

                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.printf("good luck! and please protect daejeon!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                    love.graphics.printf("good luck! and please protect sejong!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    love.graphics.printf("now things have changed!\n\nroot flower is now a hope for corporate revival!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("good luck! please protect the entire daejeon!",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                end
            end

            love.graphics.setFont(self.en_key_guide_small)
            love.graphics.print("[<-] - previous page /  [->] - next page",100,800)
        end
    
    elseif Current_Lang.language_current == 3 then
        if self.current_Menu == self.MenuStates[1] then

            if not C_GameManager.endless_Mode then
                love.graphics.draw(self.game_logo, self.menu_x, 240,0,1.5,1.5)
            else
                love.graphics.draw(self.game_logo_endless, self.menu_x, 240,0,1.5,1.5)
            end

            love.graphics.setFont(self.kr_press_Font)
            love.graphics.print("[X]キーを押すと始まります！",self.press_x, 500,0,self.current_Size / 20)
            love.graphics.print("SkagoGames 2023. made in Skago.",600,770,0)
        elseif self.current_Menu == self.MenuStates[2] then

            if not C_GameManager.endless_Mode then
                love.graphics.draw(self.game_logo, self.menu_x, self.menu_y,0,1.5,1.5)
            else
                love.graphics.draw(self.game_logo_endless, self.menu_x, self.menu_y,0,1.5,1.5)
            end

            love.graphics.setFont(self.kr_main_menu_Font)
            love.graphics.print(self.main_menu_states_TEXT_JP[self.main_menu_idx],self.main_menu_x_current - 30, 500)

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[ESC] - 後ろに行く / [<- ] - 以前 / [->] - 次 / [X] - メニュー選択",100,800)
            love.graphics.print("SkagoGames 2023. made in Skago.",1230,800,0)

        elseif self.current_Menu == self.MenuStates[3] then
            
        elseif self.current_Menu == self.MenuStates[4] then

            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.print("環境設定", 630, 150)

            if self.setting_menu_idx == 1 then
                love.graphics.setFont(self.kr_game_setting_Font_2)
                love.graphics.print("[number 1.] BGM及び効果音を活性化するかどうか: "..tostring(C_GameManager.isMusicEnabled),200,250)
                love.graphics.print("[number 2.] カメラが揺れているかどうか: "..tostring(Current_RNC_Camera.cameraShakeEnabled),200,300)
                love.graphics.print("[number 3.] 言語設定: "..Current_Lang.language[3],200,350)
                love.graphics.print("[number 4.] 全体画面可否: "..tostring(love.window.getFullscreen()), 200, 400)

                if C_GameManager.can_Endless_Mode then
                    love.graphics.print("[number 5.] 無限モードを有効にするかどうか : "..tostring(C_GameManager.endless_Mode), 200, 450)
                else
                    love.graphics.print("[ロック] 無限モードを有効にするかどうか : "..tostring(C_GameManager.endless_Mode), 200, 450)
                end

                love.graphics.print("[number 6.] ゲームのカラー変更 : "..tostring(C_ShaderManager.current_Shader), 200, 500)

                love.graphics.setFont(self.kr_key_guide_small)
                love.graphics.print("[ESC] - 後ろに行く / [1]~[6] - 設定選択 / [->] - クロスヘアの変更",100,800)
            elseif self.setting_menu_idx == 2 then
                love.graphics.setFont(self.kr_game_setting_Font_2)
                love.graphics.print("1 Player", 330, 250)
                love.graphics.print("2 Player", 1040, 250)

                local width, height = GetWH_Center()
                -- 1 player 
                love.graphics.draw(C_CrossHair_Manager:PrintCenter(false),405,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintLeft(false),405 - 64,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintRight(false),405 + 98,350,0,4,4, width / 2, height / 2)

                -- 2 player
                love.graphics.draw(C_CrossHair_Manager:PrintCenter(true),1120,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintLeft(true),1120 - 64,350,0,4,4, width / 2, height / 2)
                love.graphics.draw(C_CrossHair_Manager:PrintRight(true),1120 + 98,350,0,4,4, width / 2, height / 2)

                love.graphics.setFont(self.kr_key_guide_small)
                love.graphics.print("[ESC] - 後ろに行く / [1] ~ [3] - クロスヘア スキン変更 (1P) / [4] ~ [6] - クロスヘア スキン変更 (2P) / [<-] 環境設定",100,800)
            end


        elseif self.current_Menu == self.MenuStates[5] then


            if not C_GameManager.endless_Mode then
                love.graphics.setFont(self.kr_game_setting_Font)
                love.graphics.printf("シナリオ", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.kr_tutorial_font)

                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.print("大田広域市にお越しいただきありがとうございます！",80,250)
                    love.graphics.print("20XX年、大田市は「根の花」という植物によって圧倒的に発展します。",80,290)
                    love.graphics.print("根の花は根を通じて超能力現象と無限の資源を通じて大田を最大都市に成長させました。",80,325)
                    love.graphics.print("しかし、大田は危機に瀕しています。 大田によって主導権を失った大企業によって危機に瀕しています。",80,380)
                    love.graphics.print("企業が根の花を脅かすと、根の花の根は不安定になり始めました。",80,410)

                    love.graphics.print("それであなたを呼んだのです。 根の花を保護してください。 方法をお教えします。\n\n最高点 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],80,480)
                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then

                    if C_GameManager.current_lock_level >= 2 then
                        love.graphics.print("世宗特別自治市にお越しいただき、ありがとうございます！",80,250)
                        love.graphics.print("戦闘から何年後.. 根の花はある日突然消えました。",80,290)
                        love.graphics.print("時間が経つにつれて.. なぜか根の花は世宗市で発見されました。",80,325)
                        love.graphics.print("大企業の根の花破壊は現在進行形です。 そのように企業は再び根の花を破壊しようとしています。",80,380)
                        love.graphics.print("根の花は今や大企業の除去対象であることを再確認しました。 私たちはどうしたのでしょうか？",80,410)

                        love.graphics.print("それであなたを呼んだのです。 根の花をもう一度保護してください。 方法をお教えします。\n\n最高点 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],80,480)
                    else
                        love.graphics.printf("このステージはロックされています。",C_GameManager.textWidth, 250, love.graphics.getWidth(), "center")
                        love.graphics.printf("当該ステージをロック解除処理するためには、次のような行動が必要です。",C_GameManager.textWidth, 290, love.graphics.getWidth(), "center")
                        love.graphics.printf("大田広域市ステージ(ビーエンドレスモード)を完了してください。",C_GameManager.textWidth, 325, love.graphics.getWidth(), "center")
                    end


                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then

                    if C_GameManager.current_lock_level >= 3 then
                        love.graphics.print("仁川広域市にお越しいただきありがとうございます！",60,250)
                        love.graphics.print("根の花がまた戻ってきました。 根の花は仁川桂陽区で発見されました。",60,290)
                        love.graphics.print("そして不思議なことに、根の花は衰退していた首都圏を豊かに発展させます。",60,325)
                        love.graphics.print("このことを知った大田市は根の花を取り戻すために兵力を集めて仁川に向かっています。",60,380)
                        love.graphics.print("今や企業は立場が変わりました。 根の花は企業の栄光を取り戻すことができる唯一の存在だということを..",60,410)

                        love.graphics.print("それで企業はこれから根の花との和解を宣言し大田市から根の花を守ろうとしています···\n\n最高点 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],60,480)
                    else
                        love.graphics.printf("このステージはロックされています。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("当該ステージをロック解除処理するためには、次のような行動が必要です。",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("世宗特別自治市ステージ(ビーエンドレスモード)を完了してください。",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                end
            else
                love.graphics.setFont(self.kr_game_setting_Font)
                love.graphics.printf("永遠の大田広域市", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

                love.graphics.setFont(self.kr_tutorial_font)

                if C_GameManager.current_Level == C_GameManager.set_Level[4] then
                    love.graphics.print("東区にお越しいただきありがとうございます！",100,250)
                    love.graphics.print("大田広域市の元祖と同じ東区。 大企業連合軍の侵攻も東区で発生しました。",100,290)
                    love.graphics.print("その中で大企業東部戦線は東区に存在する根の花である板岩の花を破壊しようとしています。",100,325)
                    love.graphics.print("板岩花は大田広域市で最初に発見された根の花の種類の一つです。",100,380)
                    love.graphics.print("東区役所は板岩の花の破壊を防ぐため、大田広域市庁より迅速に動いています..",100,410)
        
                    love.graphics.print("大田広域市庁の支援が来るまで.. 板岩の花を見守りましょう！\n\n最高点 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],100,480)
                elseif C_GameManager.current_Level == C_GameManager.set_Level[5] then
        
                    if C_GameManager.current_sub_lock_level >= 2 then
                        love.graphics.print("中区にお越しいただきありがとうございます！",100,250)
                        love.graphics.print("かつて大田広域市の中心地であり忠清南道の中心地だった中区。",100,290)
                        love.graphics.print("しかし、根の花が中区でも登場し、衰退した中区は再び発展することになります。",100,325)
                        love.graphics.print("しかし、再び危機を迎えることになります。 まさに大企業連合軍です。",100,380)
                        love.graphics.print("中区庁は過去中区の栄光のために他の自治区より協力的に動いています。",100,410)
        
                        love.graphics.print("旧中区の栄光のために！\n\n最高点 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],100,480)
                    else
                        love.graphics.printf("このステージはロックされています。",C_GameManager.textWidth, 250, love.graphics.getWidth(), "center")
                        love.graphics.printf("当該ステージをロック解除処理するためには、次のような行動が必要です。",C_GameManager.textWidth, 290, love.graphics.getWidth(), "center")
                        love.graphics.printf("大田広域市東区ステージで1000点を達成してください。",C_GameManager.textWidth, 325, love.graphics.getWidth(), "center")
                    end
        
        
                elseif C_GameManager.current_Level == C_GameManager.set_Level[6] then
        
                    if C_GameManager.current_sub_lock_level >= 3 then
                        love.graphics.print("西区に訪問してくださってありがとうございます！",100,250)
                        love.graphics.print("大田広域市の首都のような役割。 西欧。",100,290)
                        love.graphics.print("予期せぬ状況が発生します。 根の花が登場しました。",100,325)
                        love.graphics.print("根の花は大田の中心地である西欧をより強力に育てていきました。",100,380)
                        love.graphics.print("しかし、大企業連合軍の登場により、西欧は危機を迎えることになります。",100,410)
        
                        love.graphics.print("西欧の発展のために.. そして大田と根の花のために···\n\n最高点 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],100,480)
                    else
                        love.graphics.printf("このステージはロックされています。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("当該ステージをロック解除処理するためには、次のような行動が必要です。",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("大田広域市中区のステージで1000点を達成してください。",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[7] then
        
                    if C_GameManager.current_sub_lock_level >= 4 then
                        love.graphics.print("儒城区にお越しいただきありがとうございます！",100,250)
                        love.graphics.print("大田広域市で最も重要な自治区.. 流星球！",100,290)
                        love.graphics.print("儒城区は根の花に関する研究を通じて大田広域市を成長させました。",100,325)
                        love.graphics.print("このためだろうか.. 大企業連合軍に真っ先に攻撃された儒城区..",100,380)
                        love.graphics.print("しかし、儒城区は諦めません。 根の花について一生懸命研究した油性球です。",100,410)
        
                        love.graphics.print("儒城区は根の花の価値のために.. もっと頑張って戦っています。\n\n最高点 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],100,480)
                    else
                        love.graphics.printf("このステージはロックされています。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("当該ステージをロック解除処理するためには、次のような行動が必要です。",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("大田広域市西区ステージで1000点を達成してください。",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[8] then
        
                    if C_GameManager.current_sub_lock_level >= 5 then
                        love.graphics.print("大徳区に訪問してくださってありがとうございます！",100,250)
                        love.graphics.print("大田で一番平和な自治区の大徳区で..",100,290)
                        love.graphics.print("最後の戦闘が繰り広げられています···",100,325)
                        love.graphics.print("大企業連合軍との最後の戦闘である大徳戦闘。",100,380)
                        love.graphics.print("すべての地域は根の花を守り抜いたが.. 大徳区はそうではない状況です。",100,410)
        
                        love.graphics.print("大徳の戦いに勝利して大田と根の花を守りましょう！\n\n最高点 : "..C_GameManager.highScore[C_GameManager.current_Level_idx],100,480)
                    else
                        love.graphics.printf("このステージはロックされています。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                        love.graphics.printf("当該ステージをロック解除処理するためには、次のような行動が必要です。",C_GameManager.textWidth,290, love.graphics.getWidth(), "center")
                        love.graphics.printf("大田広域市儒城区のステージで1000点を達成してください。",C_GameManager.textWidth,325, love.graphics.getWidth(), "center")
                    end
                end
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[X] - 難易度選択に移動する / [<-][->] - 他のシナリオ選択",100,800)
            
        elseif self.current_Menu == self.MenuStates[6] then
            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.printf("整理紹介", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

            love.graphics.setFont(self.kr_tutorial_font)
            love.graphics.print("製作者 : チェ·イェチャン(!CyberApex) / 開発期間 : 2023.02.16~2023.03.09",180,250)
            love.graphics.print("制作ツール : Love2Dゲームフレームワーク",180,285)
            love.graphics.print("プログラミング言語 : Lua (Lua.runtime.version: LuaJIT)",180,320)
            love.graphics.print("開発環境 : Visual Studio Code",180,380)

            love.graphics.print("リソース ツール 1: Blender (モデリングおよびイメージレンダリング)",180,415)
            love.graphics.print("リソース ツール 2: Aseprite (リソース補助制作)",180,450)

            love.graphics.print("フォントリソース : Galmuri9.ttf (JP) / pico-8.ttf (EN)",180,515)
            love.graphics.print("サウンドリソース : freesound.org / pico-8 sfx (自作) / K00Sin (ステージBGM制作支援)",180,545)
        elseif self.current_Menu == self.MenuStates[7] then

            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw(1)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("大企業の軍隊が全滅しました。",180,450)
                    love.graphics.print("大田が廃墟となりました。 しかし、根の花は無事です。",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw(2)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("大田を再建するために中央政府と市民団体が大田を訪問しました。",180,450)
                    love.graphics.print("しかし..私たちは心配する必要はありません。 根の花が私たち大田を再建するでしょう。",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw(3)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("根の花が大田で、大田がまさにあなたです。\nTHE END. プレイしてくださってありがとうございます。\n\n最終点数は.. "..C_GameManager.score[C_GameManager.current_Level_idx].."点です。",180,450)
                    love.graphics.print("次のページに進むと、メインメニューに戻ります。\n次も大田を守ってください！",180,650)
                end
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw_2(1)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("大企業の軍隊はまた敗北しました！",180,450)
                    love.graphics.print("世宗市も過去の大田のように被害を受けました。 しかし、根の花は安全です。",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw_2(2)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("根の花は翌日消えました。 どこに行ったんでしょうか？",180,450)
                    love.graphics.print("中央政府は根の花について疑問を抱いたまま世宗市を再建します。",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw_2(3)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("世宗が未来だ。\nTHE END. プレイしてくださってありがとうございます。\n\n最終点数は.. "..C_GameManager.score[C_GameManager.current_Level_idx].."点です。",180,450)
                    love.graphics.print("次のページに進むと、メインメニューに戻ります。\n次回も世宗を守ってください！",180,650)
                end
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                if self.game_ending_idx_text == 1 then
                    Ending_Draw_3(1)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("ついに企業は勝利しました！ 大田市は仁川から撤退しました。",180,450)
                    love.graphics.print("企業は希望を得るようになりました。 根の花はもはや企業の敵ではありません。",180,480)

                elseif self.game_ending_idx_text == 2 then
                    Ending_Draw_3(2)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("2年後、企業と大田市は和解を宣言しました。",180,450)
                    love.graphics.print("これで長い戦争は仁川永宗島での平和協定によって終結しました。",180,480)
                elseif self.game_ending_idx_text == 3 then
                    Ending_Draw_3(3)

                    love.graphics.setFont(self.kr_tutorial_font)
                    love.graphics.print("永遠の平和のために···\nTHE END. プレイしてくださってありがとうございます。\n\n最終点数は.. "..C_GameManager.score[C_GameManager.current_Level_idx].."点です。",180,450)
                    love.graphics.print("次のページに進むと、メインメニューに戻ります。\n次も仁川を守ってください！",180,650)

                    
                    if not C_GameManager.can_Endless_Mode then
                        love.graphics.setFont(self.kr_key_guide_small)
                        love.graphics.print("無限モード「Roots Need Daejeon 0.5」がロック解除されました。",180,750)
                    end
                end
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[->] - 次のページ",100,800)
        elseif self.current_Menu == self.MenuStates[8] then
            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(daejeon_level_completeScreenSPR[1],640,200,0,1,1)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(sejong_level_completeScreenSPR[1],640,200,0,1,1)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(incheon_level_completeScreenSPR[1],640,200,0,1,1)
            end
        elseif self.current_Menu == self.MenuStates[9] then

            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.printf("難易度設定", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

            love.graphics.setFont(self.kr_game_setting_Font_2)
            love.graphics.print(self.select_menu_states_TEXT_JP[self.select_menu_states_idx],self.select_menu_x_current - 50, 300)

            love.graphics.setFont(self.kr_tutorial_font)

            if self.select_menu_states_idx == 1 then
                love.graphics.printf("体力は自動的に回復し、血雲は登場しません。", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx == 2 then
                love.graphics.printf("プレイヤーの人数は2人で構成されます。", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("体力は自動的に回復し、血雲は登場しません。", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx == 3 then
                love.graphics.printf("体力は照準鏡を赤いしずくに打たないと回復できず、血雲が登場します。", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("そして根花の位置を照準鏡で変更することができます。", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
                love.graphics.printf("進行率がほぼ到達すると、根の花はコントロールを失います！ 肝に銘じてください！", C_GameManager.textWidth, 620, love.graphics.getWidth(), "center")
            elseif self.select_menu_states_idx == 4 then
                love.graphics.printf("プレイヤーの人数は2人で構成されます。", C_GameManager.textWidth, 500, love.graphics.getWidth(), "center")
                love.graphics.printf("体力は照準鏡を赤いしずくに打たないと回復できず、血雲が登場します。", C_GameManager.textWidth, 550, love.graphics.getWidth(), "center")
                love.graphics.printf("そして根花の位置を照準鏡で変更することができます。", C_GameManager.textWidth, 620, love.graphics.getWidth(), "center")
                love.graphics.printf("進行率がほぼ到達すると、根の花はコントロールを失います！ 肝に銘じてください！", C_GameManager.textWidth, 670, love.graphics.getWidth(), "center")
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[X] - 該当難易度選択 / [<- ][->] - 他の難易度選択",100,800)

        elseif self.current_Menu == self.MenuStates[10] then

            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.printf("チュートリアル", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")
            
            C_Tutorial_Level_Manager:draw()

            love.graphics.setFont(self.kr_press_Font)
            if C_Tutorial_Level_Manager.tutorial_idx == 1 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("方向キーを利用して照準鏡を操作することができます。\n\n2人モード : [esdf]",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("方向キーを利用して照準鏡を操作することができます。\n\nマウス:動く\n\nもし[SPACE]キーを押すと自動モードに切り替わります。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end
                
            elseif C_Tutorial_Level_Manager.tutorial_idx == 2 then
                love.graphics.printf("根の花を照準した状態でじっとしていると根の長さが短くなります。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
            elseif C_Tutorial_Level_Manager.tutorial_idx == 3 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("敵を照準した状態で[X]または[M]キーを押すと、根の花を脅かす敵を破壊することができます。\n\n2人モード:[W]\n\n時間が経過すると、様々な敵と対立する可能性があります。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("敵を照準した状態で[X]キーを押すと、根の花を脅かす敵を破壊することができます。\n[R]キーを介して充電が可能ですが、完全に充電されず、半分程度充電されます。\n\nマウス:左クリック\n\n時間が経つと様々な敵と対立することができます。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end
        
            elseif C_Tutorial_Level_Manager.tutorial_idx == 4 then
                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.printf("幸運を祈ります！ 根の花は崩れた大田の唯一の希望です！",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                    love.graphics.printf("幸運を祈ります！ 二度と繰り返されないように.. 世宗を見守りましょう！",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    love.graphics.printf("もう状況は変わりました！ 根の花はもう企業復活の希望です！",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("幸運を祈ります！ 大田全域を熱心に守ってください！",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                end
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[<-] - 前のページ / [->] - 次のページ",100,800)
        elseif self.current_Menu == self.MenuStates[11] then
            love.graphics.setFont(self.kr_game_setting_Font)
            love.graphics.printf("チュートリアル", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")
            
            C_Tutorial_Level_Manager:draw()

            love.graphics.setFont(self.kr_press_Font)
            if C_Tutorial_Level_Manager.tutorial_idx == 1 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("方向キーを利用して照準鏡を操作することができます。\n\n2人モード : [esdf]",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("方向キーを利用して照準鏡を操作することができます。\n\nマウス:動く\n\nもし[SPACE]キーを押すと自動モードに切り替わります。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end
                
            elseif C_Tutorial_Level_Manager.tutorial_idx == 2 then
                love.graphics.printf("根の花を照準した状態でじっとしていると根の長さが短くなります。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
            elseif C_Tutorial_Level_Manager.tutorial_idx == 3 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("照準した状態で([Z]または[N])+[左右方向キー]キーを押すと根花の位置を変更できます..\n\n2人モード:[Q]+[S,F]\n\nしかし進行率が高くなると根花は自由自在に動くことができます。 この時からは統制に集中しなければなりません。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("照準した状態で[Z]+[左右方向キー]キーを押すと根花の位置を変更できます..\n\nマウス（1人モード限定）:[マウス右クリック]+[マウス左右移動]\n\nしかし進行率が高くなると根花は自由自在に動くことができます。 この時からは統制に集中しなければなりません。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end

                
            elseif C_Tutorial_Level_Manager.tutorial_idx == 4 then
                love.graphics.printf("雲から出る赤いしずくは根の花に致命的ですが、\n照準鏡が水滴に当たると根の花の体力を回復させます。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
            elseif C_Tutorial_Level_Manager.tutorial_idx == 5 then
                if C_GameManager.is2PlayerMode then
                    love.graphics.printf("敵を照準した状態で[X]または[M]キーを押すと、根の花を脅かす敵を破壊することができます。\n\n2人モード:[W]\n\n時間が経過すると、様々な敵と対立する可能性があります。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("敵を照準した状態で[X]キーを押すと、根の花を脅かす敵を破壊することができます。\n[R]キーを介して充電が可能ですが、完全に充電されず、半分程度充電されます。\n\nマウス:左クリック\n\n時間が経つと様々な敵と対立することができます。",C_GameManager.textWidth,250, love.graphics.getWidth(), "center")
                end
            elseif C_Tutorial_Level_Manager.tutorial_idx == 6 then
                
                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    love.graphics.printf("幸運を祈ります！ 根の花は崩れた大田の唯一の希望です！",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                    love.graphics.printf("幸運を祈ります！ 二度と繰り返されないように.. 世宗を見守りましょう！",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    love.graphics.printf("もう状況は変わりました！ 根の花はもう企業復活の希望です！",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                else
                    love.graphics.printf("幸運を祈ります！ 大田全域を熱心に守ってください！",C_GameManager.textWidth,350,love.graphics.getWidth(), "center")
                end
            end

            love.graphics.setFont(self.kr_key_guide_small)
            love.graphics.print("[<-] - 前のページ / [->] - 次のページ",100,800)
        end
    end
end

function MainMenuScreen:Input_Released(key)
    if Current_Lang.language_current == 1 then
        if self.current_Menu == self.MenuStates[1] then
            if key == "x" and self.menu_x > 250 then
                self.current_Menu = self.MenuStates[2]
            end

            if key == "escape" then
                self.current_Menu = self.MenuStates[6]
            end

        elseif self.current_Menu == self.MenuStates[2] then

            if key == "left" and self.main_menu_idx > 1 then
                self.main_menu_x_current = -2000
                self.main_menu_idx = self.main_menu_idx - 1
            elseif key == "right" and self.main_menu_idx < 3 then
                self.main_menu_x_current = 2000
                self.main_menu_idx = self.main_menu_idx + 1
            end

            if key == "x" then

                if self.main_menu_idx == 1 then
                    --ChangeScene(3)
                    self.current_Menu = self.MenuStates[5]
                elseif self.main_menu_idx == 2 then
                    self.current_Menu = self.MenuStates[4]
                elseif self.main_menu_idx == 3 then
                    self.current_Menu = self.MenuStates[6]
                end
            end

            self:MainMenu_Released(key)

        elseif self.current_Menu == self.MenuStates[3] then
            
        elseif self.current_Menu == self.MenuStates[4] then

            if key == "escape" then
                self:ChangeScene_MainMenu(2)
            end

            if self.setting_menu_idx == 1 then
                if (key == "1" or key == "kp1") and C_GameManager.isMusicEnabled then
                    C_GameManager.isMusicEnabled = false
                elseif (key == "1" or key == "kp1") and not C_GameManager.isMusicEnabled then
                    C_GameManager.isMusicEnabled = true
                end

                if (key == "2" or key == "kp2") and Current_RNC_Camera.cameraShakeEnabled then
                    Current_RNC_Camera.cameraShakeEnabled = false
                elseif (key == "2" or key == "kp2") and not Current_RNC_Camera.cameraShakeEnabled then
                    Current_RNC_Camera.cameraShakeEnabled = true
                end

                if key == "3" or key == "kp3" then
                    Current_Lang.language_current = 2
                end

                if (key == "4" or key == "kp4") and not love.window.getFullscreen() then
                    C_GameManager.isFullScreen = true
                    love.window.setMode(1920,1080, {fullscreen = true, fullscreentype = "desktop", highdpi = true, vsync = false })
                elseif (key == "4" or key == "kp4") and love.window.getFullscreen() then
                    C_GameManager.isFullScreen = false
                    love.window.setMode(1280,720, {fullscreen = false, fullscreentype = "desktop", highdpi = true, vsync = false })
                end

                if C_GameManager.can_Endless_Mode then

                    if (key == "5" or key == "kp5") and not C_GameManager.endless_Mode then
                        C_GameManager.current_Level_idx = 4
                        C_GameManager.current_Level = C_GameManager.set_Level[4]
                        C_GameManager.endless_Mode = true
                    elseif (key == "5" or key == "kp5") and C_GameManager.endless_Mode then
                        C_GameManager.current_Level_idx = 1
                        C_GameManager.current_Level = C_GameManager.set_Level[1]
                        C_GameManager.endless_Mode = false
                    end

                end

                if (key == "6" or key == "kp6") then
                    C_ShaderManager:ChangeShader()
                end

                if (key == "right") then
                    self.setting_menu_idx = 2
                end
            elseif self.setting_menu_idx == 2 then
                if (key == "1" or key == "kp1") then
                    if C_CrossHair_Manager.crosshair_left_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_left_idx_1 = C_CrossHair_Manager.crosshair_left_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_left_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_left_idx_1 = 1
                    end
                end

                if (key == "2" or key == "kp2") then
                    if C_CrossHair_Manager.crosshair_center_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_center_idx_1 = C_CrossHair_Manager.crosshair_center_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_center_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_center_idx_1 = 1
                    end
                end

                if (key == "3" or key == "kp3") then
                    if C_CrossHair_Manager.crosshair_right_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_right_idx_1 = C_CrossHair_Manager.crosshair_right_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_right_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_right_idx_1 = 1
                    end
                end

                if (key == "4" or key == "kp4") then
                    if C_CrossHair_Manager.crosshair_left_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_left_idx_2 = C_CrossHair_Manager.crosshair_left_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_left_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_left_idx_2 = 1
                    end
                end

                if (key == "5" or key == "kp5") then
                    if C_CrossHair_Manager.crosshair_center_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_center_idx_2 = C_CrossHair_Manager.crosshair_center_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_center_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_center_idx_2 = 1
                    end
                end

                if (key == "6" or key == "kp6") then
                    if C_CrossHair_Manager.crosshair_right_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_right_idx_2 = C_CrossHair_Manager.crosshair_right_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_right_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_right_idx_2 = 1
                    end
                end


                if (key == "left") then
                    self.setting_menu_idx = 1
                end
            end

        elseif self.current_Menu == self.MenuStates[5] then

            if not C_GameManager.endless_Mode then
                if key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[1] and C_GameManager.current_lock_level >= 1) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[2] and C_GameManager.current_lock_level >= 2) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[3] and C_GameManager.current_lock_level >= 3) then 
                    self.current_Menu = self.MenuStates[9]
                end

                if key == "left" and C_GameManager.current_Level_idx > 1 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx - 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                elseif key == "right" and C_GameManager.current_Level_idx < 3 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx + 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                end
            else
                if key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[4] and C_GameManager.current_sub_lock_level >= 1) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[5] and C_GameManager.current_sub_lock_level >= 2) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[6] and C_GameManager.current_sub_lock_level >= 3) then 
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[7] and C_GameManager.current_sub_lock_level >= 4) then 
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[8] and C_GameManager.current_sub_lock_level >= 5) then 
                    self.current_Menu = self.MenuStates[9]
                end

                if key == "left" and C_GameManager.current_Level_idx > 4 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx - 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                elseif key == "right" and C_GameManager.current_Level_idx < 8 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx + 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                end
            end

            if key == "escape" then
                self.current_Menu = self.MenuStates[2]
            end

        elseif self.current_Menu == self.MenuStates[7] then
            if key == "right" and self.game_ending_idx_text < 4 then
                self.game_ending_idx_text = self.game_ending_idx_text + 1
            end

            if self.game_ending_idx_text == 4 then

                C_GameManager.score[C_GameManager.current_Level_idx] = 0

                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    if C_GameManager.current_lock_level <= 1 then
                        C_GameManager.current_lock_level = C_GameManager.current_lock_level + 1
                    end

                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                    if C_GameManager.current_lock_level <= 2 then
                        C_GameManager.current_lock_level = C_GameManager.current_lock_level + 1
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    if not C_GameManager.can_Endless_Mode then
                        C_GameManager.can_Endless_Mode = true
                    end
                end

                ReturnGame()
                self.game_ending_idx_text = 1
            end
        elseif self.current_Menu == self.MenuStates[9] then

            if key == "left" and self.select_menu_states_idx > 1 then
                self.select_menu_x_current = -2000
                self.select_menu_states_idx = self.select_menu_states_idx - 1
            elseif key == "right" and self.select_menu_states_idx < 4 then
                self.select_menu_x_current = 2000
                self.select_menu_states_idx = self.select_menu_states_idx + 1
            end

            if key == "x" then
                if self.select_menu_states_idx == 1 then
                    C_Tutorial_Level_Manager.current_Idx = 1
                    C_GameManager.is2PlayerMode = false
                    self.current_Menu = self.MenuStates[10]
                elseif self.select_menu_states_idx == 2 then
                    C_Tutorial_Level_Manager.current_Idx = 1
                    C_GameManager.is2PlayerMode = true
                    self.current_Menu = self.MenuStates[10]
                elseif self.select_menu_states_idx == 3 then
                    C_Tutorial_Level_Manager.current_Idx = 2
                    C_GameManager.is2PlayerMode = false
                    self.current_Menu = self.MenuStates[11]
                elseif self.select_menu_states_idx == 4 then
                    C_Tutorial_Level_Manager.current_Idx = 2
                    C_GameManager.is2PlayerMode = true
                    self.current_Menu = self.MenuStates[11]
                end
            end

            if key == "escape" then
                self:ChangeScene_MainMenu(2)
            end

        elseif self.current_Menu == self.MenuStates[10] then
            if key == "right" and C_Tutorial_Level_Manager.tutorial_idx < 5 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx + 1
            elseif key == "left" and C_Tutorial_Level_Manager.tutorial_idx > 1 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx - 1
            end

            if C_Tutorial_Level_Manager.tutorial_idx == 5 then
                C_GameManager:differentChanged(1)
                ChangeScene(3)
                C_Tutorial_Level_Manager:ReBoot()
                C_Tutorial_Level_Manager.tutorial_idx = 1
            end
        elseif self.current_Menu == self.MenuStates[11] then
            if key == "right" and C_Tutorial_Level_Manager.tutorial_idx < 7 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx + 1
            elseif key == "left" and C_Tutorial_Level_Manager.tutorial_idx > 1 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx - 1
            end

            if C_Tutorial_Level_Manager.tutorial_idx == 7 then
                C_GameManager:differentChanged(2)
                ChangeScene(3)
                C_Tutorial_Level_Manager:ReBoot()
                C_Tutorial_Level_Manager.tutorial_idx = 1
            end
        end
    elseif Current_Lang.language_current == 2 then
        if self.current_Menu == self.MenuStates[1] then
            if key == "x" and self.press_x > 525 then
                self.current_Menu = self.MenuStates[2]
            end

            if key == "escape" then
                self.current_Menu = self.MenuStates[6]
            end

        elseif self.current_Menu == self.MenuStates[2] then

            if key == "left" and self.main_menu_idx_en > 1 then
                self.main_menu_x_current_en = -2000
                self.main_menu_idx_en = self.main_menu_idx_en - 1
            elseif key == "right" and self.main_menu_idx_en < 3 then
                self.main_menu_x_current_en = 2000
                self.main_menu_idx_en = self.main_menu_idx_en + 1
            end

            if key == "x" then

                if self.main_menu_idx_en == 1 then
                    self.current_Menu = self.MenuStates[5]
                elseif self.main_menu_idx_en == 2 then
                    self.current_Menu = self.MenuStates[4]
                elseif self.main_menu_idx_en == 3 then
                    self.current_Menu = self.MenuStates[6]
                end
            end

            self:MainMenu_Released(key)

        elseif self.current_Menu == self.MenuStates[3] then
            
        elseif self.current_Menu == self.MenuStates[4] then
            if key == "escape" then
                self:ChangeScene_MainMenu(2)
            end

            if self.setting_menu_idx == 1 then
                if (key == "1" or key == "kp1") and C_GameManager.isMusicEnabled then
                    C_GameManager.isMusicEnabled = false
                elseif (key == "1" or key == "kp1") and not C_GameManager.isMusicEnabled then
                    C_GameManager.isMusicEnabled = true
                end

                if (key == "2" or key == "kp2") and Current_RNC_Camera.cameraShakeEnabled then
                    Current_RNC_Camera.cameraShakeEnabled = false
                elseif (key == "2" or key == "kp2") and not Current_RNC_Camera.cameraShakeEnabled then
                    Current_RNC_Camera.cameraShakeEnabled = true
                end

                if key == "3" or key == "kp3" then
                    Current_Lang.language_current = 3
                end

                if (key == "4" or key == "kp4") and not love.window.getFullscreen() then
                    C_GameManager.isFullScreen = true
                    love.window.setMode(1920,1080, {fullscreen = true, fullscreentype = "desktop", highdpi = true, vsync = false })
                elseif (key == "4" or key == "kp4") and love.window.getFullscreen() then
                    C_GameManager.isFullScreen = false
                    love.window.setMode(1280,720, {fullscreen = false, fullscreentype = "desktop", highdpi = true, vsync = false })
                end

                if C_GameManager.can_Endless_Mode then

                    if (key == "5" or key == "kp5") and not C_GameManager.endless_Mode then
                        C_GameManager.current_Level_idx = 4
                        C_GameManager.current_Level = C_GameManager.set_Level[4]
                        C_GameManager.endless_Mode = true
                    elseif (key == "5" or key == "kp5") and C_GameManager.endless_Mode then
                        C_GameManager.current_Level_idx = 1
                        C_GameManager.current_Level = C_GameManager.set_Level[1]
                        C_GameManager.endless_Mode = false
                    end

                end

                if (key == "6" or key == "kp6") then
                    C_ShaderManager:ChangeShader()
                end

                if (key == "right") then
                    self.setting_menu_idx = 2
                end

            elseif self.setting_menu_idx == 2 then
                if (key == "1" or key == "kp1") then
                    if C_CrossHair_Manager.crosshair_left_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_left_idx_1 = C_CrossHair_Manager.crosshair_left_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_left_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_left_idx_1 = 1
                    end
                end

                if (key == "2" or key == "kp2") then
                    if C_CrossHair_Manager.crosshair_center_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_center_idx_1 = C_CrossHair_Manager.crosshair_center_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_center_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_center_idx_1 = 1
                    end
                end

                if (key == "3" or key == "kp3") then
                    if C_CrossHair_Manager.crosshair_right_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_right_idx_1 = C_CrossHair_Manager.crosshair_right_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_right_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_right_idx_1 = 1
                    end
                end

                if (key == "4" or key == "kp4") then
                    if C_CrossHair_Manager.crosshair_left_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_left_idx_2 = C_CrossHair_Manager.crosshair_left_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_left_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_left_idx_2 = 1
                    end
                end

                if (key == "5" or key == "kp5") then
                    if C_CrossHair_Manager.crosshair_center_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_center_idx_2 = C_CrossHair_Manager.crosshair_center_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_center_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_center_idx_2 = 1
                    end
                end

                if (key == "6" or key == "kp6") then
                    if C_CrossHair_Manager.crosshair_right_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_right_idx_2 = C_CrossHair_Manager.crosshair_right_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_right_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_right_idx_2 = 1
                    end
                end


                if (key == "left") then
                    self.setting_menu_idx = 1
                end
            end

        elseif self.current_Menu == self.MenuStates[5] then

            if not C_GameManager.endless_Mode then
                if key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[1] and C_GameManager.current_lock_level >= 1) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[2] and C_GameManager.current_lock_level >= 2) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[3] and C_GameManager.current_lock_level >= 3) then 
                    self.current_Menu = self.MenuStates[9]
                end

                if key == "left" and C_GameManager.current_Level_idx > 1 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx - 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                elseif key == "right" and C_GameManager.current_Level_idx < 3 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx + 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                end
            else
                if key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[4] and C_GameManager.current_sub_lock_level >= 1) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[5] and C_GameManager.current_sub_lock_level >= 2) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[6] and C_GameManager.current_sub_lock_level >= 3) then 
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[7] and C_GameManager.current_sub_lock_level >= 4) then 
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[8] and C_GameManager.current_sub_lock_level >= 5) then 
                    self.current_Menu = self.MenuStates[9]
                end

                if key == "left" and C_GameManager.current_Level_idx > 4 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx - 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                elseif key == "right" and C_GameManager.current_Level_idx < 8 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx + 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                end
            end

            if key == "escape" then
                self.current_Menu = self.MenuStates[2]
            end

        elseif self.current_Menu == self.MenuStates[7] then
            if key == "right" and self.game_ending_idx_text < 4 then
                self.game_ending_idx_text = self.game_ending_idx_text + 1
            end

            if self.game_ending_idx_text == 4 then

                C_GameManager.score[C_GameManager.current_Level_idx] = 0

                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    if C_GameManager.current_lock_level <= 1 then
                        C_GameManager.current_lock_level = C_GameManager.current_lock_level + 1
                    end

                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then

                    if C_GameManager.current_lock_level <= 2 then
                        C_GameManager.current_lock_level = C_GameManager.current_lock_level + 1
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    if not C_GameManager.can_Endless_Mode then
                        C_GameManager.can_Endless_Mode = true
                    end
                end

                ReturnGame()
                self.game_ending_idx_text = 1
            end
        elseif self.current_Menu == self.MenuStates[9] then

            if key == "left" and self.select_menu_states_idx_en > 1 then
                self.select_menu_x_current_en = -2000
                self.select_menu_states_idx_en = self.select_menu_states_idx_en - 1
            elseif key == "right" and self.select_menu_states_idx_en < 4 then
                self.select_menu_x_current_en = 2000
                self.select_menu_states_idx_en = self.select_menu_states_idx_en + 1
            end
            
            if key == "x" then
                if self.select_menu_states_idx_en == 1 then
                    C_GameManager.is2PlayerMode = false
                    C_Tutorial_Level_Manager.current_Idx = 1
                    self.current_Menu = self.MenuStates[10]
                elseif self.select_menu_states_idx_en == 2 then
                    C_GameManager.is2PlayerMode = true
                    C_Tutorial_Level_Manager.current_Idx = 1
                    self.current_Menu = self.MenuStates[10]
                elseif self.select_menu_states_idx_en == 3 then
                    C_GameManager.is2PlayerMode = false
                    C_Tutorial_Level_Manager.current_Idx = 2
                    self.current_Menu = self.MenuStates[11]
                elseif self.select_menu_states_idx_en == 4 then
                    C_GameManager.is2PlayerMode = true
                    C_Tutorial_Level_Manager.current_Idx = 2
                    self.current_Menu = self.MenuStates[11]
                end
            end

            if key == "escape" then
                self:ChangeScene_MainMenu(2)
            end

        elseif self.current_Menu == self.MenuStates[10] then
            if key == "right" and C_Tutorial_Level_Manager.tutorial_idx < 5 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx + 1
            elseif key == "left" and C_Tutorial_Level_Manager.tutorial_idx > 1 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx - 1
            end

            if C_Tutorial_Level_Manager.tutorial_idx == 5 then
                C_GameManager:differentChanged(1)
                ChangeScene(3)
                C_Tutorial_Level_Manager:ReBoot()
                C_Tutorial_Level_Manager.tutorial_idx = 1
            end
        elseif self.current_Menu == self.MenuStates[11] then
            if key == "right" and C_Tutorial_Level_Manager.tutorial_idx < 7 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx + 1
            elseif key == "left" and C_Tutorial_Level_Manager.tutorial_idx > 1 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx - 1
            end

            if C_Tutorial_Level_Manager.tutorial_idx == 7 then
                C_GameManager:differentChanged(2)
                ChangeScene(3)
                C_Tutorial_Level_Manager:ReBoot()
                C_Tutorial_Level_Manager.tutorial_idx = 1
            end
        end
    
    elseif Current_Lang.language_current == 3 then
        if self.current_Menu == self.MenuStates[1] then
            if key == "x" and self.menu_x > 250 then
                self.current_Menu = self.MenuStates[2]
            end

            if key == "escape" then
                self.current_Menu = self.MenuStates[6]
            end

        elseif self.current_Menu == self.MenuStates[2] then

            if key == "left" and self.main_menu_idx > 1 then
                self.main_menu_x_current = -2000
                self.main_menu_idx = self.main_menu_idx - 1
            elseif key == "right" and self.main_menu_idx < 3 then
                self.main_menu_x_current = 2000
                self.main_menu_idx = self.main_menu_idx + 1
            end

            if key == "x" then

                if self.main_menu_idx == 1 then
                    --ChangeScene(3)
                    self.current_Menu = self.MenuStates[5]
                elseif self.main_menu_idx == 2 then
                    self.current_Menu = self.MenuStates[4]
                elseif self.main_menu_idx == 3 then
                    self.current_Menu = self.MenuStates[6]
                end
            end

            self:MainMenu_Released(key)

        elseif self.current_Menu == self.MenuStates[3] then
            
        elseif self.current_Menu == self.MenuStates[4] then

            if key == "escape" then
                self:ChangeScene_MainMenu(2)
            end

            if self.setting_menu_idx == 1 then

                if (key == "1" or key == "kp1") and C_GameManager.isMusicEnabled then
                    C_GameManager.isMusicEnabled = false
                elseif (key == "1" or key == "kp1") and not C_GameManager.isMusicEnabled then
                    C_GameManager.isMusicEnabled = true
                end

                if (key == "2" or key == "kp2") and Current_RNC_Camera.cameraShakeEnabled then
                    Current_RNC_Camera.cameraShakeEnabled = false
                elseif (key == "2" or key == "kp2") and not Current_RNC_Camera.cameraShakeEnabled then
                    Current_RNC_Camera.cameraShakeEnabled = true
                end

                if key == "3" or key == "kp3" then
                    Current_Lang.language_current = 1
                end

                if (key == "4" or key == "kp4") and not love.window.getFullscreen() then
                    C_GameManager.isFullScreen = true
                    love.window.setMode(1920,1080, {fullscreen = true, fullscreentype = "desktop", highdpi = true, vsync = false })
                elseif (key == "4" or key == "kp4") and love.window.getFullscreen() then
                    C_GameManager.isFullScreen = false
                    love.window.setMode(1280,720, {fullscreen = false, fullscreentype = "desktop", highdpi = true, vsync = false })
                end

                if C_GameManager.can_Endless_Mode then

                    if (key == "5" or key == "kp5") and not C_GameManager.endless_Mode then
                        C_GameManager.current_Level_idx = 4
                        C_GameManager.current_Level = C_GameManager.set_Level[4]
                        C_GameManager.endless_Mode = true
                    elseif (key == "5" or key == "kp5") and C_GameManager.endless_Mode then
                        C_GameManager.current_Level_idx = 1
                        C_GameManager.current_Level = C_GameManager.set_Level[1]
                        C_GameManager.endless_Mode = false
                    end

                end

                if (key == "6" or key == "kp6") then
                    C_ShaderManager:ChangeShader()
                end

                if (key == "right") then
                    self.setting_menu_idx = 2
                end
            elseif self.setting_menu_idx == 2 then

                if (key == "1" or key == "kp1") then
                    if C_CrossHair_Manager.crosshair_left_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_left_idx_1 = C_CrossHair_Manager.crosshair_left_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_left_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_left_idx_1 = 1
                    end
                end

                if (key == "2" or key == "kp2") then
                    if C_CrossHair_Manager.crosshair_center_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_center_idx_1 = C_CrossHair_Manager.crosshair_center_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_center_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_center_idx_1 = 1
                    end
                end

                if (key == "3" or key == "kp3") then
                    if C_CrossHair_Manager.crosshair_right_idx_1 < 3 then
                        C_CrossHair_Manager.crosshair_right_idx_1 = C_CrossHair_Manager.crosshair_right_idx_1 + 1
                    elseif C_CrossHair_Manager.crosshair_right_idx_1 >= 3 then
                        C_CrossHair_Manager.crosshair_right_idx_1 = 1
                    end
                end

                if (key == "4" or key == "kp4") then
                    if C_CrossHair_Manager.crosshair_left_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_left_idx_2 = C_CrossHair_Manager.crosshair_left_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_left_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_left_idx_2 = 1
                    end
                end

                if (key == "5" or key == "kp5") then
                    if C_CrossHair_Manager.crosshair_center_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_center_idx_2 = C_CrossHair_Manager.crosshair_center_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_center_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_center_idx_2 = 1
                    end
                end

                if (key == "6" or key == "kp6") then
                    if C_CrossHair_Manager.crosshair_right_idx_2 < 3 then
                        C_CrossHair_Manager.crosshair_right_idx_2 = C_CrossHair_Manager.crosshair_right_idx_2 + 1
                    elseif C_CrossHair_Manager.crosshair_right_idx_2 >= 3 then
                        C_CrossHair_Manager.crosshair_right_idx_2 = 1
                    end
                end


                if (key == "left") then
                    self.setting_menu_idx = 1
                end
            end

        elseif self.current_Menu == self.MenuStates[5] then

            if not C_GameManager.endless_Mode then
                if key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[1] and C_GameManager.current_lock_level >= 1) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[2] and C_GameManager.current_lock_level >= 2) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[3] and C_GameManager.current_lock_level >= 3) then 
                    self.current_Menu = self.MenuStates[9]
                end

                if key == "left" and C_GameManager.current_Level_idx > 1 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx - 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                elseif key == "right" and C_GameManager.current_Level_idx < 3 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx + 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                end
            else
                if key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[4] and C_GameManager.current_sub_lock_level >= 1) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[5] and C_GameManager.current_sub_lock_level >= 2) then
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[6] and C_GameManager.current_sub_lock_level >= 3) then 
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[7] and C_GameManager.current_sub_lock_level >= 4) then 
                    self.current_Menu = self.MenuStates[9]
                elseif key == "x" and (C_GameManager.current_Level == C_GameManager.set_Level[8] and C_GameManager.current_sub_lock_level >= 5) then 
                    self.current_Menu = self.MenuStates[9]
                end

                if key == "left" and C_GameManager.current_Level_idx > 4 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx - 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                elseif key == "right" and C_GameManager.current_Level_idx < 8 then
                    C_GameManager.current_Level_idx = C_GameManager.current_Level_idx + 1
                    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
                end
            end

            if key == "escape" then
                self.current_Menu = self.MenuStates[2]
            end

        elseif self.current_Menu == self.MenuStates[7] then
            if key == "right" and self.game_ending_idx_text < 4 then
                self.game_ending_idx_text = self.game_ending_idx_text + 1
            end

            if self.game_ending_idx_text == 4 then

                C_GameManager.score[C_GameManager.current_Level_idx] = 0

                if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                    if C_GameManager.current_lock_level <= 1 then
                        C_GameManager.current_lock_level = C_GameManager.current_lock_level + 1
                    end

                elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then

                    if C_GameManager.current_lock_level <= 2 then
                        C_GameManager.current_lock_level = C_GameManager.current_lock_level + 1
                    end
                elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                    if not C_GameManager.can_Endless_Mode then
                        C_GameManager.can_Endless_Mode = true
                    end
                end

                ReturnGame()
                self.game_ending_idx_text = 1
            end
        elseif self.current_Menu == self.MenuStates[9] then

            if key == "left" and self.select_menu_states_idx > 1 then
                self.select_menu_x_current = -2000
                self.select_menu_states_idx = self.select_menu_states_idx - 1
            elseif key == "right" and self.select_menu_states_idx < 4 then
                self.select_menu_x_current = 2000
                self.select_menu_states_idx = self.select_menu_states_idx + 1
            end

            if key == "x" then
                if self.select_menu_states_idx == 1 then
                    C_Tutorial_Level_Manager.current_Idx = 1
                    C_GameManager.is2PlayerMode = false
                    self.current_Menu = self.MenuStates[10]
                elseif self.select_menu_states_idx == 2 then
                    C_Tutorial_Level_Manager.current_Idx = 1
                    C_GameManager.is2PlayerMode = true
                    self.current_Menu = self.MenuStates[10]
                elseif self.select_menu_states_idx == 3 then
                    C_Tutorial_Level_Manager.current_Idx = 2
                    C_GameManager.is2PlayerMode = false
                    self.current_Menu = self.MenuStates[11]
                elseif self.select_menu_states_idx == 4 then
                    C_Tutorial_Level_Manager.current_Idx = 2
                    C_GameManager.is2PlayerMode = true
                    self.current_Menu = self.MenuStates[11]
                end
            end

            if key == "escape" then
                self:ChangeScene_MainMenu(2)
            end

        elseif self.current_Menu == self.MenuStates[10] then
            if key == "right" and C_Tutorial_Level_Manager.tutorial_idx < 5 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx + 1
            elseif key == "left" and C_Tutorial_Level_Manager.tutorial_idx > 1 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx - 1
            end

            if C_Tutorial_Level_Manager.tutorial_idx == 5 then
                C_GameManager:differentChanged(1)
                ChangeScene(3)
                C_Tutorial_Level_Manager:ReBoot()
                C_Tutorial_Level_Manager.tutorial_idx = 1
            end
        elseif self.current_Menu == self.MenuStates[11] then
            if key == "right" and C_Tutorial_Level_Manager.tutorial_idx < 7 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx + 1
            elseif key == "left" and C_Tutorial_Level_Manager.tutorial_idx > 1 then
                C_Tutorial_Level_Manager.tutorial_idx = C_Tutorial_Level_Manager.tutorial_idx - 1
            end

            if C_Tutorial_Level_Manager.tutorial_idx == 7 then
                C_GameManager:differentChanged(2)
                ChangeScene(3)
                C_Tutorial_Level_Manager:ReBoot()
                C_Tutorial_Level_Manager.tutorial_idx = 1
            end
        end
    end
end


function MainMenuScreen:MainMenu_Released(key)
    if key == "escape" then
        self:ReBoot_MainMenu_1()
        self:ChangeScene_MainMenu(1)
    end
end

function MainMenuScreen:ChangeScene_MainMenu(idx)
    self.current_Menu = self.MenuStates[idx]
end

function MainMenuScreen:ReBoot_MainMenu_1()
    self.menu_x = -100
    self.menu_y = 240
    self.press_x = 3000
    self.current_Size = 5
end

function MainMenuScreen:ReBoot_MainMenu_2()
    self.menu_x = 300
    self.menu_y = 240
    self.press_x = 530
    self.current_Size = 5
end
