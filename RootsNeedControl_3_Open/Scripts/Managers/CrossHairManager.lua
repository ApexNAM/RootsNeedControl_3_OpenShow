local crossHair_SPR_Array = 
{
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_01.png",
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_02.png",
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_03.png"
}

local crossHair_LeftSub_Array = 
{
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_SIDE1.png",
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_2_SIDE1.png",
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_3_SIDE1.png",
}

local crossHair_RightSub_Array = 
{
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_SIDE2.png",
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_2_SIDE2.png",
    "assets/images/Player_SPRs/Player_CrossHair_SPR_PRT_3_SIDE2.png"
}

local crossHair_SPR = {}
local crossHair_L_Sub = {}
local crossHair_R_Sub = {}

for i, v in ipairs(crossHair_SPR_Array) do
    crossHair_SPR[i] = love.graphics.newImage(v)
    crossHair_SPR[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(crossHair_LeftSub_Array) do
    crossHair_L_Sub[i] = love.graphics.newImage(v)
    crossHair_L_Sub[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(crossHair_RightSub_Array) do
    crossHair_R_Sub[i] = love.graphics.newImage(v)
    crossHair_R_Sub[i]:setFilter("nearest", "nearest")
end



CrossHair_Manager = {}



function CrossHair_Manager:new()
    local current_Table = 
    {
        crosshair_center_idx_1 = 1,
        crosshair_center_idx_2 = 1,

        crosshair_left_idx_1 = 1,
        crosshair_left_idx_2 = 1,

        crosshair_right_idx_1 = 1,
        crosshair_right_idx_2 = 1
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function CrossHair_Manager:PrintCenter(is2Player)
    if is2Player then
        return crossHair_SPR[self.crosshair_center_idx_2]
    else
        return crossHair_SPR[self.crosshair_center_idx_1]
    end
end

function CrossHair_Manager:PrintLeft(is2Player)
    if is2Player then
        return crossHair_L_Sub[self.crosshair_left_idx_2]
    else
        return crossHair_L_Sub[self.crosshair_left_idx_1]
    end
end

function CrossHair_Manager:PrintRight(is2Player)
    if is2Player then
        return crossHair_R_Sub[self.crosshair_right_idx_2]
    else
        return crossHair_R_Sub[self.crosshair_right_idx_1]
    end
end

C_CrossHair_Manager = CrossHair_Manager:new()

function GetWH_Center()
    return crossHair_SPR[C_CrossHair_Manager.crosshair_center_idx_1]:getDimensions()
end
