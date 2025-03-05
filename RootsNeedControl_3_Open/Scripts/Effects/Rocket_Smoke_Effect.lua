local rocketSmoke_SPR_Array = 
{
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0000.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0010.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0020.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0030.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0040.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0050.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0060.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0070.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0080.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0090.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0100.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0110.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0120.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0130.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0140.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0150.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0160.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0170.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0180.png",
    "assets/images/Effects_SPRs/Rocket_Smoke_SPRs/RocketSmoke_rnc0190.png"
}

local rocketSmoke_SPR = {}

for i, v in ipairs(rocketSmoke_SPR_Array) do
    rocketSmoke_SPR[i] = love.graphics.newImage(v)
    rocketSmoke_SPR[i]:setFilter("nearest", "nearest")
end

RocketSmoke = {}

function RocketSmoke:new(x,y,w,h)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 1,
        w = w,
        h = h,
        tag = "Effect",
        RocketSmoke_idx = 1,
        isDestroyed = false,
        RocketSmokeTime = 0.0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function RocketSmoke:Init()

end

function RocketSmoke:Update()
    
    self.RocketSmokeTime = self.RocketSmokeTime + 1

    if self.RocketSmokeTime % 9 == 0 then
        self.RocketSmoke_idx = self.RocketSmoke_idx + 1
        self.RocketSmokeTime = 0.0
    end

    if self.RocketSmoke_idx > 20 then
        self.RocketSmoke_idx = 20
        self.isDestroyed = true
    end
end

function RocketSmoke:draw()
    love.graphics.push()

    if not C_GameManager.isGameOver then
        love.graphics.draw(rocketSmoke_SPR[self.RocketSmoke_idx],self.x,self.y,0,self.w,self.h)
    end

    love.graphics.pop()
end

function RocketSmoke:ReBoot()
    self.isDestroyed = true
end