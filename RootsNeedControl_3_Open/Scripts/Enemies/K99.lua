local k99_Tank_SPRs_LEFT = {
    "assets/images/Tank_SPRs/RNC_TANK_LEFT_SPR.png",
    "assets/images/Tank_SPRs/RNC_TANK_LEFT_SPR_HIT.png"
}


local k99_Tank_SPRs_RIGHT = {
    "assets/images/Tank_SPRs/RNC_TANK_RIGHT_SPR.png",
    "assets/images/Tank_SPRs/RNC_TANK_RIGHT_SPR_HIT.png"
}

local k98_RPC_SPRs_LEFT = {
    "assets/images/Tank_SPRs/RNC_RPC_LEFT_SPR.png",
    "assets/images/Tank_SPRs/RNC_RPC_LEFT_SPR_HIT.png"
}

local k98_RPC_SPRs_RIGHT = {
    "assets/images/Tank_SPRs/RNC_RPC_RIGHT_SPR.png",
    "assets/images/Tank_SPRs/RNC_RPC_RIGHT_SPR_HIT.png"
}

local zj_C_Tank_SPRs_LEFT = {

    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_LEFT_SPR.png",
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_LEFT_HIT_SPR.png"
}

local zj_C_Tank_SPRs_RIGHT = {
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_RIGHT_SPR.png",
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_RIGHT_HIT_SPR.png"
}

local k99_SPRs_L = {}
local k99_SPRs_R = {}

local k98_SPRs_L = {}
local k98_SPRs_R = {}

local zj_C_Tank_SPRs_L = {}
local zj_C_Tank_SPRs_R = {}

for i, v in ipairs(k99_Tank_SPRs_LEFT) do
    k99_SPRs_L[i] = love.graphics.newImage(v)
    k99_SPRs_L[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(k99_Tank_SPRs_RIGHT) do
    k99_SPRs_R[i] = love.graphics.newImage(v)
    k99_SPRs_R[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(k98_RPC_SPRs_LEFT) do
    k98_SPRs_L[i] = love.graphics.newImage(v)
    k98_SPRs_L[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(k98_RPC_SPRs_RIGHT) do
    k98_SPRs_R[i] = love.graphics.newImage(v)
    k98_SPRs_R[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(zj_C_Tank_SPRs_LEFT) do
    zj_C_Tank_SPRs_L[i] = love.graphics.newImage(v)
    zj_C_Tank_SPRs_L[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(zj_C_Tank_SPRs_RIGHT) do
    zj_C_Tank_SPRs_R[i] = love.graphics.newImage(v)
    zj_C_Tank_SPRs_R[i]:setFilter("nearest", "nearest")
end

K99_Tank = {}

function K99_Tank:new(x,isRight,moveSpeed)
    local current_Table = {
        x = x,
        y = 465,
        z = 1,
        r = 0,
        hp = 3,
        spr_idx = 1,
        attackTime = 0.0,
        tag = "Tank",
        isDestroyed = false,
        isRight = isRight,
        moveSpeed = moveSpeed,
        healthTime = 0.0,
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function K99_Tank:Init()

end

function K99_Tank:Update()

    if self.isRight then
        self.x = self.x + self.moveSpeed

        if self.x > love.graphics.getWidth() - 100 then
            self.isRight = false
        end
    else
        self.x = self.x - self.moveSpeed
        
        if self.x < 100 then
            self.isRight = true
        end
    end

    if self.spr_idx == 2 then
        self.healthTime = self.healthTime + 1

        if self.healthTime % 30 == 0 then
            self.spr_idx = 1
        end
    end

    if self.r ~= 0 then
        self.r = Lerp(0,self.r,0.95)
    end
end

function K99_Tank:draw()

    love.graphics.push()

    if not C_GameManager.isGameOver then
        if self.isRight then

            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(k99_SPRs_L[self.spr_idx],self.x,self.y,self.r,4,4)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(k98_SPRs_L[self.spr_idx],self.x,self.y,self.r,4,4)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(zj_C_Tank_SPRs_L[self.spr_idx],self.x,self.y,self.r,4,4)
            else
                love.graphics.draw(k99_SPRs_L[self.spr_idx],self.x,self.y,self.r,4,4)
            end
        else
            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(k99_SPRs_R[self.spr_idx],self.x,self.y,self.r,4,4)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(k98_SPRs_R[self.spr_idx],self.x,self.y,self.r,4,4)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(zj_C_Tank_SPRs_R[self.spr_idx],self.x,self.y,self.r,4,4)
            else
                love.graphics.draw(k99_SPRs_R[self.spr_idx],self.x,self.y,self.r,4,4)
            end
        end
    end

    if Debug_Manager.debugMode then
        love.graphics.rectangle("line",self.x,self.y + 100,128,32)
    end

    love.graphics.pop()
end

function K99_Tank:TakeDamage()
    self.spr_idx = 2
    self.hp = self.hp - 1

    if self.hp < 0 and not self.isDestroyed then
        self.isDestroyed = true
    end
end

function K99_Tank:ReBoot()
    self.isDestroyed = true
end