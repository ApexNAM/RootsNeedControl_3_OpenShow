require("Scripts.Levels.Tutorial_Objects.Player_Tut")
require("Scripts.CrossHair.CrossHair_Tu")
require("Scripts.Levels.Tutorial_Objects.Roots_Tut")
require("Scripts.Levels.Tutorial_Objects.WarRain_Tut")

Tutorial_Level_Manager = {}

local playerGround_SPR_Array = {"assets/images/Other_SPRs/PlayerGround_SPR.png"}

local playerTut = PlayerCore_Tut:new(500,465,0.25,true)
local roots_tut = RootsCoreTut:new(playerTut)

local warCloud = WarCloudCore_Tut:new()
local warRain = {}

local crosshair_tut = CrossHair_Tut:new(2,30, playerTut, warCloud)

local current_Effect = {}
local scoreTEXTs = {}

local rockets = {} -- 생성 오브젝트들 (로켓)
local rockets_length = {} -- 로켓 용량 및 목록

local all_objects_tut = 
{
    playerTut,
    roots_tut,
    warCloud,
    crosshair_tut
}

function Tutorial_Level_Manager:new()
    local current_Table = 
    {
        tutorial_idx = 1,
        playerGround_SPR = {},
        isEnd = false,
        current_Idx = 1
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function Tutorial_Level_Manager:Init()

    for i, v in ipairs(playerGround_SPR_Array) do
        self.playerGround_SPR[i] = love.graphics.newImage(v)
        self.playerGround_SPR[i]:setFilter("nearest", "nearest")
    end

    playerTut:AddROOTS(roots_tut)

    for i, currentObjects in ipairs(all_objects_tut) do
        currentObjects:Init()
    end
end

function Tutorial_Level_Manager:Update()

    if not self.isEnd then
        for i, currentObjects in ipairs(all_objects_tut) do
            currentObjects:Update()

            if currentObjects.tag == "Rocket" then
                        
                local current_Rocket = currentObjects

                current_Rocket.smokeTime = current_Rocket.smokeTime + 1

                if current_Rocket.smokeTime % 60 == 0 then

                    if current_Rocket.isRight then
                        Effect_RocketSmoke(current_Effect, current_Rocket.x - 32, current_Rocket.y - 16,1,1,all_objects_tut)
                    else
                        Effect_RocketSmoke(current_Effect, current_Rocket.x + 2, current_Rocket.y - 16,1,1,all_objects_tut)
                    end

                    current_Rocket.smokeTime = 0.0
                end
                
                if self.current_Idx == 1 then
                    if C_Tutorial_Level_Manager.tutorial_idx == 3 then
                        if Distance(current_Rocket, crosshair_tut) > 2 then
                            if crosshair_tut.current_Target == nil then
                                crosshair_tut.current_Target = current_Rocket
                            end
                        else
                            crosshair_tut.x = Lerp(playerTut.x + 24, crosshair_tut.x,0.95)
                            crosshair_tut.y = Lerp(playerTut.y + 40, crosshair_tut.y,0.95)
                
                            if crosshair_tut:Hit_Collison_Check(playerTut,64,128) then
                                roots_tut:Downgrade_ROOTS()
                            end
                        end
                    end
                elseif self.current_Idx == 2 then
                
                    if C_Tutorial_Level_Manager.tutorial_idx == 5 then
                        if Distance(current_Rocket, crosshair_tut) > 2 then
                            if crosshair_tut.current_Target == nil then
                                crosshair_tut.current_Target = current_Rocket
                            end
                        else
                            crosshair_tut.x = Lerp(playerTut.x + 24, crosshair_tut.x,0.95)
                            crosshair_tut.y = Lerp(playerTut.y + 40, crosshair_tut.y,0.95)
                
                            if crosshair_tut:Hit_Collison_Check(playerTut,64,128) then
                                roots_tut:Downgrade_ROOTS()
                            end
                        end
                    end
                end
        
                if roots_tut:OnCollisonDamage(current_Rocket) then
                    Effect_Explosion_Tut(current_Effect,math.random(current_Rocket.x - 10, current_Rocket.x + 10), 
                    math.random(current_Rocket.y - 10, current_Rocket.y + 10),3,3,all_objects_tut, 0)
        
                    Current_RNC_Camera:_Setter_Offset(4)
        
                    Spawn_ScoreTEXT_Tut(current_Rocket.x,current_Rocket.y,"TakeDamage", all_objects_tut, scoreTEXTs)

                    table.remove(rockets_length, current_Rocket[i]) -- 파괴된 로켓 용량을 제거합니다.
                    table.remove(all_objects_tut,i) -- 로켓 오브젝트를 제거합니다.
                end
        
                -- 로켓 파괴시 테이블에 로켓을 제거합니다.
                if current_Rocket.isDestroyed then
                    table.insert(scoreTEXTs, ScoreTextObject:new(current_Rocket.x,current_Rocket.y,"TakeScore"))
                    table.insert(all_objects_tut, scoreTEXTs[#scoreTEXTs])
        
                    table.remove(rockets_length, current_Rocket[i]) -- 파괴된 로켓 용량을 제거합니다.
                    table.remove(all_objects_tut,i) -- 로켓 오브젝트를 제거합니다.
                end
            end

            if currentObjects.tag == "Cloud" then

                if C_Tutorial_Level_Manager.tutorial_idx == 4 and C_Tutorial_Level_Manager.current_Idx == 2 then
                    local current_Cloud = currentObjects

                    if Distance_Value(current_Cloud.desPoint + 1, current_Cloud.x) < 3 then
                        for i=1,math.random(1,4) do
                            SpawnRain(current_Cloud.x + math.random(40,120), current_Cloud.y + 30,warRain,all_objects_tut)
                        end 
                    end
                end
            end

            if currentObjects.tag == "WarRain" then
                local current_rain_TakeDamage = currentObjects

                if current_rain_TakeDamage:Hit_Player(playerTut) then

                    Spawn_ScoreTEXT_Tut(current_rain_TakeDamage.x,current_rain_TakeDamage.y,"TakeDamage", all_objects_tut, scoreTEXTs)

                    Current_RNC_Camera:_Setter_Offset(4)
                    current_rain_TakeDamage.isDestroyed = true
                end

                if crosshair_tut:Hit_Collison_Check(current_rain_TakeDamage, 64, 64) then

                    table.insert(scoreTEXTs, ScoreTextObject:new(playerTut.x,playerTut.y,"recover!"))
                    table.insert(all_objects_tut, scoreTEXTs[#scoreTEXTs])

                    current_rain_TakeDamage:CollisionCrossHair()
                end

                if current_rain_TakeDamage.isDestroyed then

                    local rnd = math.random(1,2)

                    Effect_BloodRain_Tok_Tut(current_Effect,current_rain_TakeDamage.x,
                    current_rain_TakeDamage.y,rnd,rnd,all_objects_tut)

                    table.remove(all_objects_tut,i)
                end
            end

            if currentObjects.tag == "ScoreTEXT" then
                local current_ScoreTEXT = currentObjects

                if current_ScoreTEXT.isDestroyed then
                    table.remove(all_objects_tut,i)
                end
            end

            if currentObjects.tag == "Effect" then
                local effect = currentObjects

                if effect.isDestroyed then
                    table.remove(current_Effect, effect[i])
                    table.remove(all_objects_tut,i)
                end
            end

            if self.current_Idx == 1 then
                if C_Tutorial_Level_Manager.tutorial_idx == 3 then
                    if #rockets_length == 0 then
                        local max = (roots_tut.roots_level * 5)
            
                        for i=1,max do 
                            SpawnRocket_Tut(rockets,all_objects_tut,rockets_length)
                        end
                    end
                end
            elseif self.current_Idx == 2 then
            
                if C_Tutorial_Level_Manager.tutorial_idx == 5 then
                    if #rockets_length == 0 then
                        local max = (roots_tut.roots_level * 5)
            
                        for i=1,max do 
                            SpawnRocket_Tut(rockets,all_objects_tut,rockets_length)
                        end
                    end
                end
            end
        end
    end

    if self.current_Idx == 1 then
        if C_Tutorial_Level_Manager.tutorial_idx == 4 then
            self.isEnd = true
        else
            self.isEnd = false
        end
    elseif self.current_Idx == 2 then
    
        if C_Tutorial_Level_Manager.tutorial_idx == 6 then
            self.isEnd = true
        else
            self.isEnd = false
        end
    end
end

function Tutorial_Level_Manager:draw()

    if not self.isEnd then
        love.graphics.draw(self.playerGround_SPR[1],-love.graphics.getWidth(), 590,0,love.graphics.getWidth(), 0.6)
        
        table.sort(all_objects_tut, SortingLayer)

        for i, currentObjects in ipairs(all_objects_tut) do
            currentObjects:draw()
        end
    end
end

function Tutorial_Level_Manager:ReBoot()
    for i = #all_objects_tut, 1, -1 do

        local currentObj = all_objects_tut[i]

        currentObj:ReBoot()

        if currentObj.tag == "Rocket" then
            table.remove(rockets_length, currentObj[i])
            table.remove(all_objects_tut, i)
        end

        if currentObj.tag == "ScoreTEXT" then
            table.remove(all_objects_tut, i)
        end
        
        if currentObj.tag == "WarRain" then
            table.remove(all_objects_tut, i)
        end

        if currentObj.tag == "Effect" then
            table.remove(current_Effect, currentObj[i])
            table.remove(all_objects_tut,i)
        end
    end

    self.isEnd = false
end

C_Tutorial_Level_Manager = Tutorial_Level_Manager:new()

-- 튜토리얼 애니메이션 클래스


require("Scripts.Other.Tutorial_Animation_Tables")

Tutorial_Animation_Object = {}

function Tutorial_Animation_Object:new(x,y,w,h,img_Table,len,looping)
    local current_Table = 
    {
        x = x,
        y = y,
        w = w,
        h = h,
        t_Images = {},
        drawIDX = 1,
        img_length = len,
        anim_deltaTime = 0.0,
        looping = looping,
        current_Img_Table = img_Table
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function Tutorial_Animation_Object:Init()
    for i, v in ipairs(self.current_Img_Table) do
        self.t_Images[i] = love.graphics.newImage(v)
        self.t_Images[i]:setFilter("nearest", "nearest")
    end
end

function Tutorial_Animation_Object:Update()

    if self.looping then
        self.anim_deltaTime = self.anim_deltaTime + 1

        if self.anim_deltaTime % 4 == 0 then
            self.drawIDX = self.drawIDX + 1
            self.anim_deltaTime = 0.0
        end
        
        if self.drawIDX > self.img_length then
            self.drawIDX = 1
        end
    end
end

function Tutorial_Animation_Object:draw()
    love.graphics.push()

    local width, height = self.t_Images[self.drawIDX]:getDimensions()
    love.graphics.draw(self.t_Images[self.drawIDX],self.x,self.y,0,self.w,self.h, width / 2, height / 2)

    love.graphics.pop()
end

--
-- 튜토리얼 변수들

local endingScreen_1 = Tutorial_Animation_Object:new(750,250,1.5,1.5,Ending_Screen_Image,3,false)
local endingScreen_2 = Tutorial_Animation_Object:new(750,250,1.5,1.5,Ending_Screen_Image_2,3,false)
local endingScreen_3 = Tutorial_Animation_Object:new(750,250,1.5,1.5,Ending_Screen_Image_3,3,false)

function Tutorial_Init()
    endingScreen_1:Init()
    endingScreen_2:Init()
    endingScreen_3:Init()
end

function Ending_Draw(idx)
    endingScreen_1.drawIDX = idx
    endingScreen_1:draw()
end

function Ending_Draw_2(idx)
    endingScreen_2.drawIDX = idx
    endingScreen_2:draw()
end

function Ending_Draw_3(idx)
    endingScreen_3.drawIDX = idx
    endingScreen_3:draw()
end