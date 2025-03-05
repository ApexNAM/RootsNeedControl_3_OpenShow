local daejeon_building_rnd1_array = 
{
    "assets/images/Other_SPRs/RNC_DAEJEON_SUNGSIMDANG_MAIN_SPR.png",
    "assets/images/Other_SPRs/RNC_DAEJEON_CITY_HAIL_SPR.png",
    "assets/images/Other_SPRs/RNC_DAEJEON_STATION_SPR.png"
}

local daejeon_building_rnd2_array = 
{
    "assets/images/Other_SPRs/RNC_DAEJEON_EXPO_TOWER_SPR.png",
    "assets/images/Other_SPRs/RNC_DAEJEON_TOWER_SPR.png"
}

local daejeon_level_idx_array = 
{
    "assets/images/Wave_SPRs/Wave_Daejeon_Level_1_SPR.png",
    "assets/images/Wave_SPRs/Wave_Daejeon_Level_2_SPR.png",
    "assets/images/Wave_SPRs/Wave_Daejeon_Level_3_SPR.png",
    "assets/images/Wave_SPRs/Wave_Daejeon_Level_4_SPR.png",
    "assets/images/Wave_SPRs/Wave_Daejeon_Level_5_SPR.png"
}

local daejeon_building_rnd1 = {}
local daejeon_building_rnd2 = {}
local daejeon_level_idx = {}

-- 각각의 이미지를 로드하여 배열에 추가
for i, v in ipairs(daejeon_building_rnd1_array) do
    daejeon_building_rnd1[i] = love.graphics.newImage(v)
    daejeon_building_rnd1[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(daejeon_building_rnd2_array) do
    daejeon_building_rnd2[i] = love.graphics.newImage(v)
    daejeon_building_rnd2[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(daejeon_level_idx_array) do
    daejeon_level_idx[i] = love.graphics.newImage(v)
    daejeon_level_idx[i]:setFilter("nearest", "nearest")
end

Daejeon_Background = {}
Daejeon_Level = 1

function Daejeon_Background:new()

    local current_Table = 
    {
        x = -50,
        y = 465,
        z = -10,

        wave_count_h = 0,

        rnd_1 = math.random(1,3),
        x2 = love.graphics.getWidth(),
        
        rnd_2 = math.random(1,2)
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function Daejeon_Background:Init()
    self.x = -80

    if love.window.getFullscreen() then

        local width, height = love.window.getDesktopDimensions()

        if width == 1280 and height == 720 then
            self.x2 = 1250
        elseif width == 1920 and height == 1080 then
            self.x2 = 1280
        elseif width == 2560 and height == 1440 then
            self.x2 = 1280
        else
            self.x2 = love.graphics.getWidth() - 225
        end
    else
        self.x2 = love.graphics.getWidth()
    end
end

function Daejeon_Background:Update()
    self.wave_count_h = Lerp(1,self.wave_count_h,0.95)
end

function Daejeon_Background:draw()

    love.graphics.push()
    
    if C_GameManager.current_Level == "Daejeon" then
        if not C_GameManager.isGameOver then
            love.graphics.draw(daejeon_building_rnd1[self.rnd_1],self.x,self.y - 387,0,16,16)
            love.graphics.draw(daejeon_building_rnd2[self.rnd_2],self.x2,self.y - 387,0,8,8)
    
            if not C_GameManager.endless_Mode then
                love.graphics.draw(daejeon_level_idx[Daejeon_Level],640,200,0,1,self.wave_count_h)
            end
        end
    end


    love.graphics.pop()
end

function Daejeon_Background:ReBoot()
    self.wave_count_h = 0
    Daejeon_Level = 1

    self.rnd_1 = love.math.random(1,3)
    self.rnd_2 = love.math.random(1,2)

    self.x = -80

    if love.window.getFullscreen() then

        local width, height = love.window.getDesktopDimensions()

        if width == 1280 and height == 720 then
            self.x2 = 1250
        elseif width == 1920 and height == 1080 then
            self.x2 = 1280
        elseif width == 2560 and height == 1440 then
            self.x2 = 1280
        else
            self.x2 = love.graphics.getWidth() - 225
        end
    else
        self.x2 = love.graphics.getWidth()
    end
end