local junggu_building_rnd1_array = 
{
    "assets/images/Other_SPRs/RNC_DAEJEON_SUNGSIMDANG_MAIN_SPR.png",
    "assets/images/Other_SPRs/RNC_OLD_CHUNGNAM_OFFICE_SPR.png"
}

local junggu_building_rnd2_array = 
{
    "assets/images/Other_SPRs/RNC_DAEJEON_JUNG_OFFICE_BUILDING.png",
    "assets/images/Other_SPRs/RNC_DAEJEON_OWO_WORLD_SPR.png"
}

local junggu_level_idx_array = 
{
    "assets/images/Stage_SPRs/RNC_JUNG_GU_DAEJEON_SPR.png",
    "assets/images/Stage_SPRs/RNC_JUNG_GU_DAEJEON_SPR_EN.png"
}

local junggu_building_rnd1 = {}
local junggu_building_rnd2 = {}
local junggu_level_idx = {}

-- 각각의 이미지를 로드하여 배열에 추가
for i, v in ipairs(junggu_building_rnd1_array) do
    junggu_building_rnd1[i] = love.graphics.newImage(v)
    junggu_building_rnd1[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(junggu_building_rnd2_array) do
    junggu_building_rnd2[i] = love.graphics.newImage(v)
    junggu_building_rnd2[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(junggu_level_idx_array) do
    junggu_level_idx[i] = love.graphics.newImage(v)
    junggu_level_idx[i]:setFilter("nearest", "nearest")
end

Jonggu_Background = {}

function Jonggu_Background:new()

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

function Jonggu_Background:Init()
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

function Jonggu_Background:Update()
    self.wave_count_h = Lerp(1,self.wave_count_h,0.95)
end

function Jonggu_Background:draw()

    love.graphics.push()
    
    if C_GameManager.current_Level == "junggu" then
        if not C_GameManager.isGameOver then
            if C_GameManager.endless_Mode then
                love.graphics.draw(junggu_building_rnd1[self.rnd_1],self.x,self.y - 387,0,16,16)
                love.graphics.draw(junggu_building_rnd2[self.rnd_2],self.x2 - 200,self.y - 387,0,16,16)

                if Current_Lang.language_current == 1 then
                    love.graphics.draw(junggu_level_idx[1],640,200,0,1,self.wave_count_h)
                elseif Current_Lang.language_current == 2 or Current_Lang.language_current == 3 then
                    love.graphics.draw(junggu_level_idx[2],640,200,0,1,self.wave_count_h)
                end

                if C_GameManager.score[C_GameManager.current_Level_idx] >= 1000 and C_GameManager.current_sub_lock_level == 2 then
                    C_GameManager.current_sub_lock_level = 3
                end
            end
        end
    end


    love.graphics.pop()
end

function Jonggu_Background:ReBoot()
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