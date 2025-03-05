local donggu_building_rnd1_array = 
{
    "assets/images/Other_SPRs/RNC_DAEJEON_STATION_SPR.png",
    "assets/images/Other_SPRs/RNC_DAEJEON_DONG_OFFICE_BUILDING.png"
}

local donggu_building_rnd2_array = 
{
    "assets/images/Other_SPRs/RNC_DAEJEON_EAST_ROADWAY_SPR.png",
    "assets/images/Other_SPRs/RNC_DAEJEON_METRO_STATION_SPR.png"
}

local donggu_level_idx_array = 
{
    "assets/images/Stage_SPRs/RNC_DONG_GU_DAEJEON_SPR.png",
    "assets/images/Stage_SPRs/RNC_DONG_GU_DAEJEON_SPR_EN.png"
}

local donggu_building_rnd1 = {}
local donggu_building_rnd2 = {}
local donggu_level_idx = {}

-- 각각의 이미지를 로드하여 배열에 추가
for i, v in ipairs(donggu_building_rnd1_array) do
    donggu_building_rnd1[i] = love.graphics.newImage(v)
    donggu_building_rnd1[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(donggu_building_rnd2_array) do
    donggu_building_rnd2[i] = love.graphics.newImage(v)
    donggu_building_rnd2[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(donggu_level_idx_array) do
    donggu_level_idx[i] = love.graphics.newImage(v)
    donggu_level_idx[i]:setFilter("nearest", "nearest")
end

Donggu_Background = {}

function Donggu_Background:new()

    local current_Table = 
    {
        x = -50,
        y = 465,
        z = -10,

        wave_count_h = 0,

        rnd_1 = love.math.random(1,2),
        x2 = love.graphics.getWidth(),
        
        rnd_2 = love.math.random(1,2)
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function Donggu_Background:Init()
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

function Donggu_Background:Update()
    self.wave_count_h = Lerp(1,self.wave_count_h,0.95)
end

function Donggu_Background:draw()

    love.graphics.push()
    
    if C_GameManager.current_Level == "donggu" then
        if not C_GameManager.isGameOver then
            if C_GameManager.endless_Mode then
                love.graphics.draw(donggu_building_rnd1[self.rnd_1],self.x,self.y - 387,0,16,16)
                love.graphics.draw(donggu_building_rnd2[self.rnd_2],self.x2 - 200,self.y - 387,0,16,16)

                if Current_Lang.language_current == 1 then
                    love.graphics.draw(donggu_level_idx[1],640,200,0,1,self.wave_count_h)
                elseif Current_Lang.language_current == 2 or Current_Lang.language_current == 3 then
                    love.graphics.draw(donggu_level_idx[2],640,200,0,1,self.wave_count_h)
                end
                
                if C_GameManager.score[C_GameManager.current_Level_idx] >= 1000 and C_GameManager.current_sub_lock_level == 1 then
                    C_GameManager.current_sub_lock_level = 2
                end
            end
        end
    end


    love.graphics.pop()
end

function Donggu_Background:ReBoot()
    self.wave_count_h = 0
    self.x = -80

    self.rnd_1 = love.math.random(1,2)
    self.rnd_2 = love.math.random(1,2)

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