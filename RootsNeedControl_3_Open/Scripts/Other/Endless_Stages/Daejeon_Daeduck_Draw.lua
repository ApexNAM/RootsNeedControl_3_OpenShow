local daeduck_level_idx_array = 
{
    "assets/images/Stage_SPRs/RNC_DAEDUCK_GU_DAEJEON_SPR.png",
    "assets/images/Stage_SPRs/RNC_DAEDUCK_GU_DAEJEON_SPR_EN.png"
}

local daeduck_building_rnd1 = love.graphics.newImage("assets/images/Other_SPRs/RNC_DAEJEON_DONG_CUNG_DANG_HOUSE.png")
daeduck_building_rnd1:setFilter("nearest", "nearest")

local daeduck_building_rnd2 = love.graphics.newImage("assets/images/Other_SPRs/RNC_DAEJEON_OH_JEOUNG_DONG_HOUSE.png")
daeduck_building_rnd2:setFilter("nearest", "nearest")

local daeduck_level_idx = {}

-- 각각의 이미지를 로드하여 배열에 추가

for i, v in ipairs(daeduck_level_idx_array) do
    daeduck_level_idx[i] = love.graphics.newImage(v)
    daeduck_level_idx[i]:setFilter("nearest", "nearest")
end

Daeduck_Background = {}

function Daeduck_Background:new()

    local current_Table = 
    {
        x = -50,
        y = 465,
        z = -10,

        wave_count_h = 0,
        x2 = love.graphics.getWidth()
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function Daeduck_Background:Init()
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

function Daeduck_Background:Update()
    self.wave_count_h = Lerp(1,self.wave_count_h,0.95)
end

function Daeduck_Background:draw()

    love.graphics.push()
    
    if C_GameManager.current_Level == "daeduck" then
        if not C_GameManager.isGameOver then
            if C_GameManager.endless_Mode then
                love.graphics.draw(daeduck_building_rnd1,self.x,self.y - 387,0,16,16)
                love.graphics.draw(daeduck_building_rnd2,self.x2 - 200,self.y - 387,0,16,16)

                if Current_Lang.language_current == 1 then
                    love.graphics.draw(daeduck_level_idx[1],640,200,0,1,self.wave_count_h)
                elseif Current_Lang.language_current == 2 or Current_Lang.language_current == 3 then
                    love.graphics.draw(daeduck_level_idx[2],640,200,0,1,self.wave_count_h)
                end
            end
        end
    end


    love.graphics.pop()
end

function Daeduck_Background:ReBoot()
    self.wave_count_h = 0

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