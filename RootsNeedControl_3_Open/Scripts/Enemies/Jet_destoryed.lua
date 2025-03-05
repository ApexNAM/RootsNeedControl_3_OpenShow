local fd_96_spr_des_array =
{
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_FD_96_SPR_DESTORYED_1.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_FD_96_SPR_DESTORYED_2.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_FD_96_SPR_DESTORYED_3.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_FD_96_SPR_DESTORYED_4.png"
}

local fd_98_spr_des_Array = 
{
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_FD_98_SPR_DESTORYED_1.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_FD_98_SPR_DESTORYED_2.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_FD_98_SPR_DESTORYED_3.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_FD_98_SPR_DESTORYED_4.png"
}

local am_x_spr_des_Array = 
{
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_AM_X_SPR_DESTORYED_1.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_AM_X_SPR_DESTORYED_2.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_AM_X_SPR_DESTORYED_3.png",
    "assets/images/Effects_SPRs/JET_DESTORYED/RNC_AM_X_SPR_DESTORYED_4.png",
}

local fd96_SPR_Des = {}
local fd98_SPR_Des = {}
local am_x_SPR_Des = {}

for i, v in ipairs(fd_96_spr_des_array) do
    fd96_SPR_Des[i] = love.graphics.newImage(v)
    fd96_SPR_Des[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(fd_98_spr_des_Array) do
    fd98_SPR_Des[i] = love.graphics.newImage(v)
    fd98_SPR_Des[i]:setFilter("nearest", "nearest")
end

for i, v in ipairs(am_x_spr_des_Array) do
    am_x_SPR_Des[i] = love.graphics.newImage(v)
    am_x_SPR_Des[i]:setFilter("nearest", "nearest")
end

JET_Destroyed = {}

function JET_Destroyed:new(sx,sy)
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
        rndxspd = love.math.random(0.25,0.75),
        randoms = love.math.random(1,4),
        rnd360 = love.math.random(360),
        smoke_time = 0.0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function JET_Destroyed:Init()
    self.vy = self.gravity
    self.r = self.rnd360
end

function JET_Destroyed:Update()

    self.y = self.y + self.vy * love.timer.getDelta()
    self.vy = self.vy + self.gravity * love.timer.getDelta()

    if self.isRight then
        self.x = self.x - self.rndxspd
    else
        self.x = self.x + self.rndxspd
    end

    if self.y > 590 then
        self.isDestroyed = true
    end

    self.r = love.timer.getTime()

    self.smoke_time = self.smoke_time + 1

    if self.smoke_time % 10 == 0 then
        SpawnEffectPublic1(self.x,self.y)
    end

    if self.smoke_time % 20 == 0 then
        SpawnEffectPublic2(self.x,self.y, self.r)
        self.smoke_time = 0.0
    end
end

function JET_Destroyed:draw()

    love.graphics.push()

    local width, height = fd96_SPR_Des[1]:getDimensions()

    if not C_GameManager.isGameOver then

        if C_GameManager.current_Level == C_GameManager.set_Level[1] then
            love.graphics.draw(fd96_SPR_Des[self.randoms],self.x,self.y,self.r,2,2,width / 2, height / 2)
        elseif C_GameManager.current_Level == C_GameManager.set_Level[2] then
            love.graphics.draw(fd98_SPR_Des[self.randoms],self.x,self.y,self.r,2,2,width / 2, height / 2)
        elseif C_GameManager.current_Level == C_GameManager.set_Level[3] then
            love.graphics.draw(am_x_SPR_Des[self.randoms],self.x,self.y,self.r,2,2,width / 2, height / 2)
        else
            love.graphics.draw(fd96_SPR_Des[self.randoms],self.x,self.y,self.r,2,2,width / 2, height / 2)
        end
    end

    love.graphics.pop()
end

function JET_Destroyed:ReBoot()
    self.isDestroyed = true
end