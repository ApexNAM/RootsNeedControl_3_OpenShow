Serialize = require("lib/ser")

require("Scripts.Managers.ShaderManager")
require("Scripts.Screens.IntroScreen")
require("Scripts.Managers.DebugDrawManager")
require("Scripts.Managers.CameraManager")
require("Scripts.Managers.LanguageManager")
require("Scripts.Other.StarField_Effect")
require("Scripts.Levels.Endless_Level")
require("Scripts.Levels.Tutorial_Level")

require("mainClock")

-- 게임 모드
local GameStates = 
{
    "Intro",
    "Main_Menu",
    "Get_Ready",
    "InGame",
    "GameOver",
    "LanguageSelected",
    "ClockScene"
}

local introScreen = IntroScreen:new()

local currentGameStates = GameStates[1]
local mainMenuScreen = MainMenuScreen:new()
local starField = StarField:new()

local gameOverText_kr = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",50)
local continue_TEXT_kr = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",50)
local continue_TEXT_2_kr = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",28)

local gameOverText_en = love.graphics.newFont("assets/Fonts/pico-8.ttf",50)
local continue_TEXT_en = love.graphics.newFont("assets/Fonts/pico-8.ttf",28)


function love.load()
    C_ShaderManager:Init()
    C_Tutorial_Level_Manager:Init()

    love.mouse.setVisible(false)
    love.mouse.setGrabbed(true)
    
    LoadGame()

    if C_GameManager.isFullScreen then
        local width, height = love.window.getDesktopDimensions()

        if width == 1280 and height == 720 then
            love.window.setMode(1280,720, {fullscreen = true, fullscreentype = "desktop", highdpi = true, vsync = false }) 
        elseif width == 1920 and height == 1080 then
            love.window.setMode(1920,1080, {fullscreen = true, fullscreentype = "desktop", highdpi = true, vsync = false})
        elseif width == 2560 and height == 1440 then
            love.window.setMode(2560, 1440, {fullscreen = true, fullscreentype = "desktop", highdpi = true, vsync = false})
        end
    else 
        love.window.setMode(1280,720, {fullscreen = false, fullscreentype = "desktop", highdpi = true, vsync = false})
    end

    introScreen:Init()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    mainMenuScreen:Init()

    Defense_Init()
    Tutorial_Init()

    starField:Init()
    
    collectgarbage("stop")
end

function love.update(dt)
    C_GameManager:ScreenUpdate()

    if currentGameStates == GameStates[1] then
        introScreen:Update()
    elseif currentGameStates == GameStates[2] then
        mainMenuScreen:Update()
    elseif currentGameStates == GameStates[3] then
        Defense_Start_Ready()
    elseif currentGameStates == GameStates[4] then
        Defense_Update()
    end
end

function love.draw()
    C_ShaderManager:draw()
    Current_RNC_Camera:set()

    if currentGameStates ~= GameStates[1] then
        starField:draw()
        love.graphics.setColor(love.math.colorFromBytes(255,255,255))
    end
    
    if currentGameStates == GameStates[1] then
        introScreen:draw()
    elseif currentGameStates == GameStates[2] then
        mainMenuScreen:draw()
    elseif currentGameStates == GameStates[3] then
        Defense_Start_Ready_Draw()
    elseif currentGameStates == GameStates[4] then
        Defense_Update_Draw()
    elseif currentGameStates == GameStates[5] then
        if Current_Lang.language_current == 1 then

            love.graphics.setFont(gameOverText_kr)
            love.graphics.printf("게임오버!", C_GameManager.textWidth, 300,love.graphics.getWidth(), "center")


            love.graphics.setFont(continue_TEXT_kr)
            love.graphics.printf("RE ?", C_GameManager.textWidth, 360, love.graphics.getWidth(), "center")

            love.graphics.printf("마지막 점수 : "..C_GameManager.score[C_GameManager.current_Level_idx], C_GameManager.textWidth ,590, love.graphics.getWidth(), "center")


            love.graphics.setFont(continue_TEXT_2_kr)
            love.graphics.printf("[y] or [n]", C_GameManager.textWidth, 430, love.graphics.getWidth(), "center")
            
        elseif Current_Lang.language_current == 2 then


            love.graphics.setFont(gameOverText_en)
            love.graphics.printf("game over!", C_GameManager.textWidth, 300,love.graphics.getWidth(), "center")

            love.graphics.printf("last score : "..C_GameManager.score[C_GameManager.current_Level_idx], C_GameManager.textWidth,590,love.graphics.getWidth(), "center")

            love.graphics.setFont(continue_TEXT_en)
            love.graphics.printf("continue?", C_GameManager.textWidth, 360, love.graphics.getWidth(), "center")
            love.graphics.printf("[y] or [n]", C_GameManager.textWidth, 430, love.graphics.getWidth(), "center")
        elseif Current_Lang.language_current == 3 then
            love.graphics.setFont(gameOverText_kr)
            love.graphics.printf("ゲームオーバー！", C_GameManager.textWidth, 300,love.graphics.getWidth(), "center")

            love.graphics.setFont(continue_TEXT_kr)
            love.graphics.printf("再挑戦？", C_GameManager.textWidth, 360, love.graphics.getWidth(), "center")
            love.graphics.printf("最後の点数 : "..C_GameManager.score[C_GameManager.current_Level_idx], C_GameManager.textWidth ,590, love.graphics.getWidth(), "center")

            love.graphics.setFont(continue_TEXT_2_kr)
            love.graphics.printf("[y] or [n]", C_GameManager.textWidth, 430, love.graphics.getWidth(), "center")
        end
    elseif currentGameStates == GameStates[6] then
        love.graphics.setFont(gameOverText_kr)
        love.graphics.printf("language selection 언어 선택 言語選択", C_GameManager.textWidth, 150, love.graphics.getWidth(), "center")

        love.graphics.setFont(continue_TEXT_2_kr)
        love.graphics.printf("language can be changed in preferences.\n언어는 환경설정에서 변경이 가능합니다.\n言語は環境設定で変更できます。", C_GameManager.textWidth, 320, love.graphics.getWidth(), "center")
        

        love.graphics.setFont(continue_TEXT_2_kr)
        love.graphics.printf("[Z] - english\t\t [X] - 한국어\t\t [C] - 日本語", C_GameManager.textWidth, 450, love.graphics.getWidth(), "center")
    elseif currentGameStates == GameStates[7] then
        DrawClock()
    end


    Current_RNC_Camera:OnCameraShake()
    Current_RNC_Camera:unset()
end

function love.keyreleased(key)

    if currentGameStates == GameStates[1] then

    elseif currentGameStates == GameStates[2] then
        mainMenuScreen:Input_Released(key)
        
        if key == "down" then
            currentGameStates = GameStates[7]
        end

    elseif currentGameStates == GameStates[3] then

    elseif currentGameStates == GameStates[4] then
        Defense_Update_released(key)
    elseif currentGameStates == GameStates[5] then
        Defense_GameOver_Input_released(key)
    elseif currentGameStates == GameStates[6] then
        if key == "z" then
            Current_Lang.language_current = 2
            C_GameManager.firstLangChanged = false
            SaveGame()
            ChangeScene(2)
        elseif key == "x" then
            Current_Lang.language_current = 1
            C_GameManager.firstLangChanged = false
            SaveGame()
            ChangeScene(2)
        elseif key == "c" then
            Current_Lang.language_current = 3
            C_GameManager.firstLangChanged = false
            SaveGame()
            ChangeScene(2)
        end
    elseif currentGameStates == GameStates[7] then
        if GlobalInput == key then
            currentGameStates = GameStates[2] 
            GlobalInput = false
        end
    end
end

function love.keypressed(key, uni)
    GlobalInput = key
end

function love.mousereleased(x,y, button)

    if currentGameStates == GameStates[1] then

    elseif currentGameStates == GameStates[2] then

    elseif currentGameStates == GameStates[3] then

    elseif currentGameStates == GameStates[4] then
        Defense_Update_released_Mouse(button)
    elseif currentGameStates == GameStates[5] then

    end
end

function love.quit()
    SaveGame()
end

function love.run()
    if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
  
    local dt = 0
    local lastTime = love.timer.getTime()
  
    -- Main loop
    while true do
      love.event.pump()
  
      for name, a,b,c,d,e,f in love.event.poll() do
        if name == "quit" then
          if not love.quit or not love.quit() then
            return a
          end
        end
  
        love.handlers[name](a,b,c,d,e,f)
      end
  
      love.timer.step()
  
      dt = love.timer.getTime() - lastTime
      lastTime = love.timer.getTime()
  
      if love.update then love.update(dt) end
  
      love.graphics.clear()
      if love.draw then love.draw() end
  
      love.graphics.present()
  
      -- Sleep to prevent hogging CPU time
      local sleeptime = 1/120 - love.timer.getTime() + lastTime
      if sleeptime > 0 then love.timer.sleep(sleeptime) end
    end
  end
  

function SaveGame()

    local Data = {}

    Data.current_HighScore = C_GameManager.highScore
    Data.current_MusicEnabled = C_GameManager.isMusicEnabled
    Data.current_CameraShake = Current_RNC_Camera.cameraShakeEnabled
    Data.current_FullScreen = C_GameManager.isFullScreen
    Data.current_lang = Current_Lang.language_current
    Data.current_Endless_Mode = C_GameManager.endless_Mode
    Data.current_Can_Endless_Mode = C_GameManager.can_Endless_Mode
    Data.current_Locked_Level = C_GameManager.current_lock_level
    Data.current_Color_Type = C_ShaderManager.current_Shader
    Data.current_Color_Type_IDX = C_ShaderManager.current_Shader_idx
    Data.current_Locked_Level_Sub = C_GameManager.current_sub_lock_level
    Data.current_Stage = C_GameManager.current_Level_idx
    Data.current_langFirstChanged = C_GameManager.firstLangChanged

    Data.current_center_idx_1 = C_CrossHair_Manager.crosshair_center_idx_1 
    Data.current_center_idx_2 = C_CrossHair_Manager.crosshair_center_idx_2

    Data.current_crosshair_left_idx_1 = C_CrossHair_Manager.crosshair_left_idx_1
    Data.current_crosshair_left_idx_2 = C_CrossHair_Manager.crosshair_left_idx_2

    Data.current_crosshair_right_idx_1 = C_CrossHair_Manager.crosshair_right_idx_1 
    Data.current_crosshair_right_idx_2 = C_CrossHair_Manager.crosshair_right_idx_2

    love.filesystem.write("rnc_file_steam.lua", Serialize(Data))
end

function LoadGame()
    if not love.filesystem.getInfo("rnc_file_steam.lua") then
        SaveGame()
    end

    local Data = love.filesystem.load("rnc_file_steam.lua")()

    C_GameManager.highScore = Data.current_HighScore
    C_GameManager.isMusicEnabled = Data.current_MusicEnabled
    Current_RNC_Camera.cameraShakeEnabled = Data.current_CameraShake
    C_GameManager.isFullScreen = Data.current_FullScreen
    Current_Lang.language_current = Data.current_lang
    C_GameManager.endless_Mode = Data.current_Endless_Mode
    C_GameManager.can_Endless_Mode = Data.current_Can_Endless_Mode
    C_GameManager.current_lock_level = Data.current_Locked_Level
    C_ShaderManager.current_Shader = Data.current_Color_Type
    C_ShaderManager.current_Shader_idx = Data.current_Color_Type_IDX
    C_GameManager.current_sub_lock_level = Data.current_Locked_Level_Sub
    C_GameManager.current_Level_idx = Data.current_Stage
    C_GameManager.firstLangChanged = Data.current_langFirstChanged 

    C_CrossHair_Manager.crosshair_center_idx_1 = Data.current_center_idx_1
    C_CrossHair_Manager.crosshair_center_idx_2 = Data.current_center_idx_2

    C_CrossHair_Manager.crosshair_left_idx_1 = Data.current_crosshair_left_idx_1
    C_CrossHair_Manager.crosshair_left_idx_2 = Data.current_crosshair_left_idx_2

    C_CrossHair_Manager.crosshair_right_idx_1 = Data.current_crosshair_right_idx_1
    C_CrossHair_Manager.crosshair_right_idx_2 = Data.current_crosshair_right_idx_2

    C_GameManager.current_Level = C_GameManager.set_Level[C_GameManager.current_Level_idx]
end

function SortingLayer(a,b)
    return a.z < b.z 
end

function ChangeScene(idx)
    currentGameStates = GameStates[idx]
end

function StartGameEnabled()
    if currentGameStates == GameStates[4] then
        return true
    end

    return false
end

function Get_MainMenu()
    return mainMenuScreen
end

function ResetStarField()
    starField:ReBoot()
end

function RemakeStarField()
    starField:Init()
end