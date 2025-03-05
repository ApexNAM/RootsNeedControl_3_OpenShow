local k99_tank_L_destoryed = 
{
    "assets/images/Tank_SPRs/RNC_TANK_SPR_HIT_DESTORYS_1.png",
    "assets/images/Tank_SPRs/RNC_TANK_SPR_HIT_DESTORYS_3.png",
    "assets/images/Tank_SPRs/RNC_TANK_SPR_HIT_DESTORYS_5.png"
}

local k99_tank_R_destoryed = 
{
    "assets/images/Tank_SPRs/RNC_TANK_SPR_HIT_DESTORYS_2.png",
    "assets/images/Tank_SPRs/RNC_TANK_SPR_HIT_DESTORYS_4.png",
    "assets/images/Tank_SPRs/RNC_TANK_SPR_HIT_DESTORYS_6.png"
}

local k98_tank_L_destoryed = 
{
    "assets/images/Tank_SPRs/RNC_RPC_SPR_HIT_DESTORYS_1.png",
    "assets/images/Tank_SPRs/RNC_RPC_SPR_HIT_DESTORYS_3.png",
    "assets/images/Tank_SPRs/RNC_RPC_SPR_HIT_DESTORYS_5.png"
}

local k98_tank_R_destoryed = 
{
    "assets/images/Tank_SPRs/RNC_RPC_SPR_HIT_DESTORYS_2.png",
    "assets/images/Tank_SPRs/RNC_RPC_SPR_HIT_DESTORYS_4.png",
    "assets/images/Tank_SPRs/RNC_RPC_SPR_HIT_DESTORYS_6.png"
}

local zj_C_L_destroyed = 
{
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_HIT_DESTORYS_1.png",
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_HIT_DESTORYS_3.png",
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_HIT_DESTORYS_5.png"
}

local zj_C_R_destroyed = 
{
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_HIT_DESTORYS_2.png",
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_HIT_DESTORYS_4.png",
    "assets/images/Tank_SPRs/RNC_DAEDUCK_TANK_HIT_DESTORYS_6.png"
}

local k99_SPRs_L_destroyed = {}
local k99_SPRs_R_destroyed = {}

local k98_SPRs_L_destroyed = {}
local k98_SPRs_R_destroyed = {}

local zj_C_Tank_SPRs_L_destroyed = {}
local zj_C_Tank_SPRs_R_destroyed = {}

for i, v in ipairs(k99_tank_L_destoryed) do
    k99_SPRs_L_destroyed[i] = love.graphics.newImage(v)
    k99_SPRs_L_destroyed[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(k99_tank_R_destoryed) do
    k99_SPRs_R_destroyed[i] = love.graphics.newImage(v)
    k99_SPRs_R_destroyed[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(k98_tank_L_destoryed) do
    k98_SPRs_L_destroyed[i] = love.graphics.newImage(v)
    k98_SPRs_L_destroyed[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(k98_tank_R_destoryed) do
    k98_SPRs_R_destroyed[i] = love.graphics.newImage(v)
    k98_SPRs_R_destroyed[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(zj_C_L_destroyed) do
    zj_C_Tank_SPRs_L_destroyed[i] = love.graphics.newImage(v)
    zj_C_Tank_SPRs_L_destroyed[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(zj_C_R_destroyed) do
    zj_C_Tank_SPRs_R_destroyed[i] = love.graphics.newImage(v)
    zj_C_Tank_SPRs_R_destroyed[i]:setFilter("nearest", "nearest")
end

Tank_Destroyed = {}

function Tank_Destroyed:new(sx,sy, sisRight)
    local current_Table = 
    {
        x = sx,
        y = sy,
        z = 2,
        r = 0,
        gravity = love.math.random(300,600),
        vy = -love.math.random(300,600),
        tag = "Effect",
        isDestroyed = false,
        isRight = sisRight,
        rndxspd = love.math.random(0.25,0.75),
        randoms = love.math.random(1,3),
        rnd360 = love.math.random(360),
        smoke_time = 0.0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function Tank_Destroyed:Init()
    self.vy = self.gravity
    self.r = self.rnd360
end

function Tank_Destroyed:Update()

    self.y = self.y + self.vy * love.timer.getDelta()
    self.vy = self.vy + self.gravity * love.timer.getDelta()

    if self.isRight then
        self.x = self.x - self.rndxspd
    else
        self.x = self.x + self.rndxspd
    end

    self.r = love.timer.getTime()

    if self.y > 590 then
        self.isDestroyed = true
    end

    self.smoke_time = self.smoke_time + 1

    if self.smoke_time % 10 == 0 then
        SpawnEffectPublic1(self.x,self.y)
    end

    if self.smoke_time % 20 == 0 then
        SpawnEffectPublic2(self.x,self.y, self.r)
        self.smoke_time = 0.0
    end
end

function Tank_Destroyed:draw()

    love.graphics.push()

    if not C_GameManager.isGameOver then

        if self.isRight then

            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(k99_SPRs_L_destroyed[self.randoms],self.x,self.y,self.r,4,4)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(k98_SPRs_L_destroyed[self.randoms],self.x,self.y,self.r,4,4)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(zj_C_Tank_SPRs_L_destroyed[self.randoms],self.x,self.y,self.r,4,4)
            else
                love.graphics.draw(k99_SPRs_L_destroyed[self.randoms],self.x,self.y,self.r,4,4)
            end
        else
            if C_GameManager.current_Level == C_GameManager.set_Level[1] then
                love.graphics.draw(k99_SPRs_R_destroyed[self.randoms],self.x,self.y,self.r,4,4)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
                love.graphics.draw(k98_SPRs_R_destroyed[self.randoms],self.x,self.y,self.r,4,4)
            elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
                love.graphics.draw(zj_C_Tank_SPRs_R_destroyed[self.randoms],self.x,self.y,self.r,4,4)
            else
                love.graphics.draw(k99_SPRs_R_destroyed[self.randoms],self.x,self.y,self.r,4,4)
            end
        end

    end

    love.graphics.pop()
end

function Tank_Destroyed:ReBoot()
    self.isDestroyed = true
end