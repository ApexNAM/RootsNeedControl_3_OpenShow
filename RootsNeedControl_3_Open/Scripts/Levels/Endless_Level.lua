require("Scripts.Players.PlayerController")
require("Scripts.CrossHair.CrossHair")
require("Scripts.Players.PlayerDeadBody")
require("Scripts.Roots.SeedController")
require("Scripts.Roots.RootsController")
require("Scripts.Screens.PlayerScreen")
require("Scripts.Screens.MainMenu")
require("Scripts.Rockets.Rocket")
require("Scripts.Rockets.ScoreTEXT")
require("Scripts.Enemies.FD_96")
require("Scripts.Enemies.FD_96_Bullet")
require("Scripts.Enemies.K99")
require("Scripts.Other.WarCloud")
require("Scripts.Rains.WarRain")
require("Scripts.Managers.PlayerGround")
require("Scripts.Other.Daejeon_Draw")
require("Scripts.Other.Sejong_Draw")
require("Scripts.Other.Incheon_Draw")

require("Scripts.Other.Endless_Stages.Daejeon_Donggu_Draw")
require("Scripts.Other.Endless_Stages.Daejeon_Junggu_Draw")
require("Scripts.Other.Endless_Stages.Daejeon_Seogu_Draw")
require("Scripts.Other.Endless_Stages.Daejeon_Yuseonggu_Draw")
require("Scripts.Other.Endless_Stages.Daejeon_Daeduck_Draw")

require("Scripts.Other.SpawnFunc")
require("Scripts.Effects.Explosion_Effect")
require("Scripts.Effects.Rocket_Smoke_Effect")
require("Scripts.Effects.BloodRainTok_Effect")
require("Scripts.Effects.BulletDrop_Effect")
require("Scripts.Enemies.Tank_destoryed")
require("Scripts.Enemies.Jet_destoryed")

require("Scripts.Managers.GameManager")

-- 변수들

local kr_font_back = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",28)
local en_font_back = love.graphics.newFont("assets/Fonts/pico-8.ttf",25)

local start_Seed = SeedCore:new(740, -100)

local playerGround = PlayerGroundManager:new()
local playerCore = PlayerCore:new(500,465,0.25,true) -- 플레이어 캐릭터 (체력 포함)

local crosshair = CrossHair_Mixed:new(2,30,false) -- 크로스헤어 (Player 1)
local crosshair_sub = CrossHair_Mixed:new(2,30,true) -- 크로스헤어 (Player2)

local roots = RootsCore:new(playerCore, playerCore.health, crosshair) -- 뿌리

local playerScreen = PlayerScreen:new(playerCore, playerCore.health, roots, crosshair) -- 플레이어 화면 (ui)
local playerDeadBody = PlayerDeadCore:new(playerCore, roots)

local warCloud = WarCloudCore:new()
local warRain = {}

local rockets = {} -- 생성 오브젝트들 (로켓)
local rockets_length = {} -- 로켓 용량 및 목록

local fd96s = {} -- 전투기 오브젝트들 
local fd96s_length = {} -- 전투키 용량 및 목록

local fd96s_Bullet = {} -- 전투기 총알 목록

local k99Tanks = {} -- 탱크 오브젝트들
local k99Tanks_length = {} -- 탱크 용량 및 목록

-- Effects var
local current_Effect = {}
local scoreTEXTs = {} -- 로켓 파괴 목록

local daejeon_cities = Daejeon_Background:new()
local sejong_cities = Sejong_Background:new()
local incheon_cities = Incheon_Background:new()


local donggu = Donggu_Background:new()
local junggu = Jonggu_Background:new()
local seogu = Seogu_Background:new()
local yuseong = Yuseong_Background:new()
local daeduck = Daeduck_Background:new()

local exitCoolTime = 0.0

-- 오브젝트들 목록

local all_objects = { 
    playerCore, 
    crosshair, 
    crosshair_sub,
    roots,
    playerGround, 
    playerScreen,
    daejeon_cities, 
    sejong_cities,
    incheon_cities,
    donggu,
    junggu,
    seogu,
    yuseong,
    daeduck,
    C_GameManager,
    playerDeadBody,
    warCloud
}

local exitCount = 1
local waveCount = 1

local secCount = 0
local minCount = 0
local hourCount = 0

local tank_Kill_Count = 0
local fd96_kill_Count = 0

local all_Kill_Count = 0

function Defense_Init()

    for i, currentObjects in ipairs(all_objects) do
        currentObjects:Init()
    end
    
    playerCore:AddROOTS(roots)
    start_Seed.isShow = true
end

function Defense_Start_Ready()
    start_Seed:Update()
    Current_RNC_Camera:SetterPos(0,Lerp(0,start_Seed.y - 520,0.65))

    if start_Seed:IsPlayerCoreEnabled() then

        if not C_GameManager.is2PlayerMode then
            crosshair_sub.isHidden = true
        else
            crosshair_sub.isHidden = false

            crosshair:StartHere(math.random(100,800),math.random(100,800))
            crosshair_sub:StartHere(math.random(100,800),math.random(100,800))
        end
        
        start_Seed.isShow = false
        playerCore:StartCoreHere(start_Seed.x)
        ChangeScene(4)
    end
end

function Defense_Start_Ready_Draw()
    local playerGround_SPR = love.graphics.newImage("assets/images/Other_SPRs/PlayerGround_SPR.png")
    love.graphics.draw(playerGround_SPR, -love.graphics.getWidth(), 590 ,0, love.graphics.getWidth(), 0.6)

    if not C_GameManager.endless_Mode then
        daejeon_cities:draw()
        sejong_cities:draw()
        incheon_cities:draw()
    else
        donggu:draw()
        junggu:draw()
        seogu:draw()
        yuseong:draw()
        daeduck:draw()
    end

    start_Seed:draw()
    warCloud:draw()
end

function Update_Wave()

    if not C_GameManager.endless_Mode then
        waveCount = waveCount + 1

        if waveCount == 5 then
            RebootAll()
            Current_RNC_Camera:_Setter_Offset(10)
            Get_MainMenu():ChangeScene_MainMenu(8)
            ChangeScene(2)
        end
    end
end

function Wave_Roots_level()

    if roots.roots_level == 6 then
        return 0
    elseif roots.roots_level == 5 then
        return 1
    elseif roots.roots_level == 4 then
        return 2
    elseif roots.roots_level == 3 then
        return 3
    elseif roots.roots_level == 2 then
        return 4
    elseif roots.roots_level == 1 then
        return 5
    end
end

function Root_length_Count_Normal()
    if roots.roots_level == 1 then
        return 25
    elseif roots.roots_level == 2 then
        return 18
    elseif roots.roots_level == 3 then
        return 12
    elseif roots.roots_level == 4 then
        return 8
    elseif roots.roots_level == 5 then
        return 4
    elseif roots.roots_level == 6 then
        return 1
    end
end

function Root_length_Count_Hard()
    if roots.roots_level == 1 then
        return 30
    elseif roots.roots_level == 2 then
        return 24
    elseif roots.roots_level == 3 then
        return 18
    elseif roots.roots_level == 4 then
        return 10
    elseif roots.roots_level == 5 then
        return 8
    elseif roots.roots_level == 6 then
        return 4
    end
end


function Defense_Update()
    local camX = Lerp(0,Current_RNC_Camera.x,0.85)
    local camY = Lerp(0,Current_RNC_Camera.y, 0.85)

    Current_RNC_Camera:SetterPos(camX,camY)
    
    if playerCore.health.isDead then
        playerDeadBody:Update()
    else

        if waveCount >= 4 and C_GameManager.difficulty_current == C_GameManager.difficultyStates[2] then
            playerCore.canMove = true
        end

        if crosshair:Hit_Collison_Check(playerCore,64,128) then
            roots:Downgrade_ROOTS()
        end

        if C_GameManager.is2PlayerMode then
            if crosshair_sub:Hit_Collison_Check(playerCore,64,128) then
                roots:Downgrade_ROOTS()
            end
        end

        if not C_GameManager.endless_Mode then
            if C_GameManager.difficulty_current == C_GameManager.difficultyStates[1] then
                secCount = secCount + Root_length_Count_Normal()
            elseif C_GameManager.difficulty_current == C_GameManager.difficultyStates[2] then 
                secCount = secCount + Root_length_Count_Hard()
            end
            
            if secCount % (30 + roots.roots_level) == 0 then
                minCount = minCount + 1
                secCount = 0
            end

            if minCount >= 60 then
                hourCount = hourCount + 1
                minCount = 0
            end

            if hourCount >= 6 then
                Update_Wave()
                hourCount = 0
            end
        else
            waveCount = 4
        end

        Daejeon_Level = waveCount
        Sejong_Level = waveCount
        Incheon_Level = waveCount

        if all_Kill_Count > 60 and not all_Kill_Count == 0 then
            Update_Wave()
            all_Kill_Count = 0
        end

        if crosshair.autoMode then
            if crosshair.isReload then
                crosshair.current_Target = playerCore
            end
        end

        for i, currentObjects in ipairs(all_objects) do
            currentObjects:Update()
    
            -- 오브젝트들의 태그가 Rocket이라면 이 함수를 실행. (Rocket 관련 함수)
            if currentObjects.tag == "Rocket" then
                
                local current_Rocket = currentObjects

                if crosshair.autoMode then
                    
                    if crosshair.currentPower > 0 then
                        if Distance(current_Rocket, crosshair) > 1 then
                            if crosshair.current_Target == nil then
                                crosshair.current_Target = current_Rocket
                            end
                        end

                        if crosshair:Hit_Collison_Check(current_Rocket,32,32) then
                            CrossHair_Attack_Controller_Input(crosshair)
                        end
                    end
                end
                
                current_Rocket.smokeTime = current_Rocket.smokeTime + 1

                if current_Rocket.smokeTime % 60 == 0 then

                    if current_Rocket.isRight then
                        Effect_RocketSmoke(current_Effect, current_Rocket.x - 32, current_Rocket.y - 16,1,1,all_objects)
                    else
                        Effect_RocketSmoke(current_Effect, current_Rocket.x + 2, current_Rocket.y - 16,1,1,all_objects)
                    end

                    current_Rocket.smokeTime = 0.0
                end
    
                if roots:OnCollisonDamage(current_Rocket) then

                    if crosshair.autoMode then
                        crosshair.current_Target = nil
                    end
                    
                    Effect_Explosion(current_Effect,math.random(current_Rocket.x - 10, current_Rocket.x + 10), 
                    math.random(current_Rocket.y - 10, current_Rocket.y + 10),3,3,all_objects, 0)

                    Current_RNC_Camera:_Setter_Offset(4)
                    playerCore.health:TakeDamage(10)

                    Spawn_ScoreTEXT(current_Rocket.x,current_Rocket.y,"TakeDamage")

                    table.remove(rockets_length, current_Rocket[i]) -- 파괴된 로켓 용량을 제거합니다.
                    table.remove(all_objects,i) -- 로켓 오브젝트를 제거합니다.
                end
    
                -- 로켓 파괴시 테이블에 로켓을 제거합니다.
                if current_Rocket.isDestroyed then
                    C_GameManager:AddScore()
                    
                    Spawn_ScoreTEXT(current_Rocket.x,current_Rocket.y,"TakeScore")
    
                    table.remove(rockets_length, current_Rocket[i]) -- 파괴된 로켓 용량을 제거합니다.
                    table.remove(all_objects,i) -- 로켓 오브젝트를 제거합니다.
                end
            end
            
            if currentObjects.tag == "ScoreTEXT" then
                local current_ScoreTEXT = currentObjects
    
                if current_ScoreTEXT.isDestroyed then
                    table.remove(all_objects,i)
                end
            end

            if currentObjects.tag == "FD_96" then

                local current_FD96 = currentObjects

                if crosshair.autoMode then
                    
                    if crosshair.currentPower > 0 then
                        if Distance(current_FD96, crosshair) > 1 then
                            if crosshair.current_Target == nil then
                                crosshair.current_Target = current_FD96
                            end
                        end

                        if crosshair:Hit_Collison_Check(current_FD96,128,128) then
                            CrossHair_Attack_Controller_Input(crosshair)
                            crosshair.current_Target = nil
                        end
                    end
                end

                if not current_FD96.isHit then
                    if DistanceY(playerCore, current_FD96) < 100 and current_FD96.ammo > 0 then
                        current_FD96.isStopped_AND_Attack = true
                    else
                        current_FD96.isStopped_AND_Attack = false
                    end

                    if current_FD96.isStopped_AND_Attack then
                        current_FD96.attackTime = current_FD96.attackTime + 1

                        if current_FD96.attackTime % 12 == 0 then
                            C_GameManager:FD96_FireSound()
                            SpawnFD96_Bullet(fd96s_Bullet, all_objects, current_FD96.x, current_FD96.y, current_FD96.r)
                            current_FD96.ammo = current_FD96.ammo - 1
                            current_FD96.attackTime = 0.0
                        end
                    end
                else
                    local wh = math.random(1,2)
                    Effect_Explosion(current_Effect,current_FD96.x - 32,current_FD96.y - 64,wh,wh,all_objects,0)
                end 

                if current_FD96.isDestroyed then
                    for i=1,6 do
                        JET_Destroyed_Drop(current_Effect, current_FD96, all_objects)
                    end
                    
                    C_GameManager:Hit_Attack_Sound()
                    Spawn_ScoreTEXT(current_FD96.x,current_FD96.y,"TakeScore")

                    table.remove(fd96s_length, current_FD96[i])
                    table.remove(all_objects,i) 
                end
            end

            if currentObjects.tag == "FD_96_Bullet" then
                
                local fd96B = currentObjects

                if roots:OnCollisonDamage(fd96B) then
                    Current_RNC_Camera:_Setter_Offset(0.25)

                    if roots.roots_level < 6 then
                        C_GameManager:ChangeStarFieldColor(255,127,0)
                        C_GameManager:PlayTakeDamageSound()
                        roots.roots_level = roots.roots_level + 1
                    elseif roots.roots_level >= 6 then
                        playerCore.health:TakeDamage(10)
                    end

                    fd96B.isDestroyed = true

                    Spawn_ScoreTEXT(fd96B.x,fd96B.y,"TakeDamage")
                end

                if fd96B.y > 590 then
                    local wh = math.random(1,2)
                    Effect_Explosion(current_Effect,math.random(fd96B.x - 10, fd96B.x + 10),
                    math.random(560, 580),wh,wh,all_objects,0)
                end

                if crosshair:Hit_Collison_Check_Rotation_To(fd96B,16,16, fd96B.r) then
                    fd96B.isDestroyed = true
                end

                if fd96B.isDestroyed then
                    table.remove(all_objects,i)
                end
            end

            if currentObjects.tag == "Cloud" then
                local current_Cloud = currentObjects

                if Distance_Value(current_Cloud.desPoint + 1, current_Cloud.x) < 3 then
                    for i=1,math.random(1,4) do
                        SpawnRain(current_Cloud.x + math.random(40,120), current_Cloud.y + 30,warRain,all_objects)
                    end 
                end
            end

            if currentObjects.tag == "WarRain" then
                local current_rain_TakeDamage = currentObjects

                if current_rain_TakeDamage:Hit_Player(playerCore) then

                    Spawn_ScoreTEXT(current_rain_TakeDamage.x,current_rain_TakeDamage.y,"TakeDamage")

                    Current_RNC_Camera:_Setter_Offset(4)
                    playerCore.health:TakeDamage(30)
                    current_rain_TakeDamage.isDestroyed = true
                end

                if crosshair:Hit_Collison_Check(current_rain_TakeDamage, 64, 64) then
                    table.insert(scoreTEXTs, ScoreTextObject:new(playerCore.x,playerCore.y,"recover!"))
                    table.insert(all_objects, scoreTEXTs[#scoreTEXTs])

                    playerCore.health:AddHealth(10)
                    current_rain_TakeDamage:CollisionCrossHair()
                end

                if C_GameManager.is2PlayerMode then
                    if crosshair_sub:Hit_Collison_Check(current_rain_TakeDamage, 64, 64) then
                        playerCore.health:AddHealth(10)
                        current_rain_TakeDamage:CollisionCrossHair()
                    end
                end

                if current_rain_TakeDamage.isDestroyed then

                    local rnd = math.random(1,2)
                    Effect_BloodRain_Tok(current_Effect,current_rain_TakeDamage.x,
                    current_rain_TakeDamage.y,rnd,rnd,all_objects)

                    table.remove(all_objects,i)
                end
            end

            if currentObjects.tag == "Tank" then
                local current_Tank = currentObjects

                if crosshair.autoMode then
                    
                    if crosshair.currentPower > 0 then
                        if Distance(current_Tank, crosshair) > 1 then
                            if crosshair.current_Target == nil then
                                crosshair.current_Target = current_Tank
                            end
                        end

                        if crosshair:Hit_Collison_Check(current_Tank,128,128) then
                            CrossHair_Attack_Controller_Input(crosshair)
                            crosshair.current_Target = nil
                        end
                    end
                end
                
                if DistanceX(playerCore, current_Tank) < 100 then

                    if roots.roots_level < 6 then
                        C_GameManager:ChangeStarFieldColor(255,127,0)
                        C_GameManager:PlayTakeDamageSound()
                        roots.roots_level = roots.roots_level + 1
                    elseif roots.roots_level >= 6 then
                        playerCore.health:TakeDamage(20)
                    end

                    if current_Tank.isRight then
                        current_Tank.r = -0.25
                        current_Tank.x = current_Tank.x - 120
                    else
                        current_Tank.r = 0.25
                        current_Tank.x = current_Tank.x + 120
                    end
                end

                if current_Tank.isDestroyed then
                    for i=1,5 do
                        Tank_Destroyed_Drop(current_Effect,current_Tank,all_objects)
                    end

                    Spawn_ScoreTEXT(current_Tank.x,current_Tank.y,"TakeScore")

                    table.remove(k99Tanks_length, current_Tank[i])
                    table.remove(all_objects,i)
                end
            end

            if currentObjects.tag == "Effect" then
                local effect = currentObjects

                if effect.isDestroyed then
                    table.remove(current_Effect, effect[i])
                    table.remove(all_objects,i)
                end
            end
        end

        if crosshair:Hit_Collison_Check(playerCore,64,128) then
            playerCore:MovePushing(crosshair)
        end

        if crosshair_sub:Hit_Collison_Check(playerCore,64,128) then
            playerCore:MovePushing(crosshair_sub)
        end

        if waveCount >= 1 then
            if #rockets_length == 0 then
                
                all_Kill_Count = all_Kill_Count + Wave_Roots_level()
                local max = (roots.roots_level * 5)

                for i=1,max do 
                    SpawnRocket(rockets,all_objects, rockets_length)
                end
            end
        end

        if waveCount >= 2 then
            if #k99Tanks_length == 0 then

                all_Kill_Count = all_Kill_Count + Wave_Roots_level()
                local max = (roots.roots_level + 3)
                
                for i=1,max do 
                    Spawn_K99_Tank(k99Tanks, k99Tanks_length, all_objects)
                end
            end
        end

        if waveCount >= 3 then
            if #fd96s_length == 0 then

                all_Kill_Count = all_Kill_Count + Wave_Roots_level()
                for i=1,roots.roots_level do 
                    SpawnFD96(fd96s, all_objects, fd96s_length, playerCore)
                end
            end
        end
    end
end

function Defense_Update_Draw()

    table.sort(all_objects, SortingLayer)

    for i, currentObjects in ipairs(all_objects) do
        currentObjects:draw()
    end

    if not C_GameManager.isGameOver then
        if exitCount == 0 then
            if Current_Lang.language_current == 1 then

                love.graphics.setFont(kr_font_back)
                love.graphics.printf("한번 더 누르면 메인메뉴로 돌아갑니다.", C_GameManager.textWidth,300, love.graphics.getWidth(), "center")

                exitCoolTime = exitCoolTime + 1

                if exitCoolTime >= 200 then
                    exitCount = 1
                    exitCoolTime = 0.0
                end

            elseif Current_Lang.language_current == 2 then

                love.graphics.setFont(en_font_back)
                love.graphics.printf("press [esc] key again return main menu.", C_GameManager.textWidth,300, love.graphics.getWidth(), "center")

                exitCoolTime = exitCoolTime + 1

                if exitCoolTime >= 200 then
                    exitCount = 1
                    exitCoolTime = 0.0
                end
            elseif Current_Lang.language_current == 3 then

                love.graphics.setFont(kr_font_back)
                love.graphics.printf("もう一度押すとメインメニューに戻ります。", C_GameManager.textWidth,300, love.graphics.getWidth(), "center")

                exitCoolTime = exitCoolTime + 1

                if exitCoolTime >= 200 then
                    exitCount = 1
                    exitCoolTime = 0.0
                end

            end
        end
    else
        exitCount = 1
        exitCoolTime = 0.0
    end
end

function Defense_Update_released(key)

    if not C_GameManager.isGameOver then
        if (key == "x" or key == "m") and crosshair.currentPower > 0 then
            CrossHair_Attack_Controller_Input(crosshair)
        end

        if key == "w" and crosshair_sub.currentPower > 0 and C_GameManager.is2PlayerMode then
            CrossHair_Attack_Controller_Input(crosshair_sub)
        end

        if not C_GameManager.is2PlayerMode and C_GameManager.difficulty_current == C_GameManager.difficultyStates[1] then
            if key == "space" and not crosshair.autoMode then
                crosshair.autoMode = true
            elseif key == "space" and crosshair.autoMode then

                if crosshair.current_Target ~= nil then
                    crosshair.current_Target = nil
                end

                crosshair.autoMode = false
            end
        end
    end

    if key == "escape" and exitCount == 0 then
        C_GameManager.score[C_GameManager.current_Level_idx] = 0

        RebootAll()
        RemakeStarField()

        start_Seed:ReBoot(740,-100)
        Get_MainMenu():ReBoot_MainMenu_2()
        Get_MainMenu():ChangeScene_MainMenu(2)
        ChangeScene(2)
    elseif key == "escape" and exitCount == 1 then
        exitCount = 0
    end
end

function Defense_Update_released_Mouse(key)
    if not C_GameManager.isGameOver then
        if key == 1 and crosshair.currentPower > 0 then
            CrossHair_Attack_Controller_Input(crosshair)
        end
    end
end

function Defense_GameOver_Input_released(key)
    if key == "y" then
        SaveGame()
        C_GameManager.score[C_GameManager.current_Level_idx] = 0
        RemakeStarField()
        start_Seed:ReBoot(740,-100)
        Get_MainMenu():ReBoot_MainMenu_2()
        Get_MainMenu():ChangeScene_MainMenu(2)
        ChangeScene(3)
    elseif key == "n" or key == "escape" then
        C_GameManager.score[C_GameManager.current_Level_idx] = 0
        ReturnGame()
    end
end

function ReturnGame()
    RebootAll()
    RemakeStarField()
    start_Seed:ReBoot(740,-100)
    Get_MainMenu():ReBoot_MainMenu_2()
    Get_MainMenu():ChangeScene_MainMenu(2)
    ChangeScene(2)
end

-- RebootAll
-- 게임플레이 종료 시 기록된 오브젝트들의 내용을 초기화합니다.
function RebootAll()
    for i = #all_objects, 1, -1 do

        local currentObj = all_objects[i]

        currentObj:ReBoot()

        if currentObj.tag == "Rocket" then
            table.remove(rockets_length, currentObj[i])
            table.remove(all_objects, i)
        end

        if currentObj.tag == "ScoreTEXT" then
            table.remove(all_objects, i)
        end

        if currentObj.tag == "FD_96" then
            table.remove(fd96s_length, currentObj[i])
            table.remove(all_objects, i)
        end
        
        if currentObj.tag == "FD_96_Bullet" then
            table.remove(all_objects, i)
        end
        
        if currentObj.tag == "WarRain" then
            table.remove(all_objects, i)
        end
        
        if currentObj.tag == "Tank" then
            table.remove(k99Tanks_length, currentObj[i])
            table.remove(all_objects, i)
        end

        if currentObj.tag == "Effect" then
            table.remove(current_Effect, currentObj[i])
            table.remove(all_objects,i)
        end
    end

    exitCount = 1
    exitCoolTime = 0.0

    secCount = 0
    minCount = 0
    hourCount = 0

    C_GameManager.tank_Spd_idx = 1
    C_GameManager.fd96_Spd_idx = 1

    tank_Kill_Count = 0
    fd96_kill_Count = 0
    all_Kill_Count = 0

    C_GameManager:ChangeStarFieldColor(10,174,77)
    ResetStarField()
    waveCount = 1
end

function CrossHair_Attack_Controller_Input(crosshair_Target)

    crosshair_Target.w = 4
    crosshair_Target.h = 4

    crosshair_Target.side_x1 = (crosshair_Target.x - 48)
    crosshair_Target.side_x2 = (crosshair_Target.x + 62)

    for i, currentObjects in ipairs(all_objects) do

        if currentObjects.tag == "Rocket" then
                
            local current_Rocket = currentObjects

            if crosshair_Target:Hit_Collison_Check(current_Rocket,32,32) then
                Effect_Explosion(current_Effect,current_Rocket.x - 32,current_Rocket.y - 32,3,3,all_objects,0)
                C_GameManager:Hit_Attack_Sound()
                Current_RNC_Camera:_Setter_Offset(2)
                current_Rocket.isDestroyed = true
            end
        end

        if currentObjects.tag == "FD_96" then

            local current_FD96 = currentObjects

            if crosshair_Target:Hit_Collison_Check(current_FD96,128,128) then
                C_GameManager:Hit_Attack_Sound()
                C_GameManager:AddScore()
                Current_RNC_Camera:_Setter_Offset(6)
                Effect_Explosion(current_Effect,current_FD96.x - 64,current_FD96.y - 32,6,6,all_objects,0)
                current_FD96.isHit = true

                fd96_kill_Count = fd96_kill_Count + 1

                if fd96_kill_Count % 30 == 0  and fd96_kill_Count ~= 0 then
                    if C_GameManager.fd96_Spd_idx < 16 then
                        C_GameManager.fd96_Spd_idx = C_GameManager.fd96_Spd_idx + 1
                    end
                end
            end
        end

        if currentObjects.tag == "Tank" then
            local current_Tank = currentObjects
            
            if crosshair_Target:Hit_Collison_Check(current_Tank,128,128) then
                C_GameManager:Hit_Attack_Sound()
                C_GameManager:AddScore()

                Current_RNC_Camera:_Setter_Offset(1.5)
                current_Tank:TakeDamage()

                tank_Kill_Count = tank_Kill_Count + 1

                if tank_Kill_Count % 30 == 0 and tank_Kill_Count ~= 0 then
                    if C_GameManager.tank_Spd_idx < 16 then
                        C_GameManager.tank_Spd_idx = C_GameManager.tank_Spd_idx + 1
                    end
                end
            end
        end
    end 

    crosshair_Target.currentPower = crosshair_Target.currentPower - 1
    Effect_BulletDrop(current_Effect,crosshair_Target.x,crosshair_Target.y, all_objects)
    C_GameManager:CrossHair_Attack_Sound()
end

function Spawn_ScoreTEXT(x,y,t)
    table.insert(scoreTEXTs, ScoreTextObject:new(x, y, t))
    table.insert(all_objects, scoreTEXTs[#scoreTEXTs])
end

function Spawn_ScoreTEXT_Tut(x,y,t, all_objects_tut, this_scoreTEXTs)
    table.insert(this_scoreTEXTs, ScoreTextObject:new(x, y, t))
    table.insert(all_objects_tut, this_scoreTEXTs[#this_scoreTEXTs])
end

function SpawnEffectPublic1(x,y)
    Effect_RocketSmoke(current_Effect,x,y,1,1,all_objects)
end

function SpawnEffectPublic2(x,y,r)
    Effect_Explosion(current_Effect,x,y,3,3,all_objects,r)
end