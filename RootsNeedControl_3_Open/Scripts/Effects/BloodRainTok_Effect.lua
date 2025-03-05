local BloodRain_Effect_SPR_Array = 
{
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0000.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0010.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0020.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0030.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0040.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0050.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0060.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0070.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0080.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0090.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0100.png",
    "assets/images/Effects_SPRs/BloodRain_Tok_SPRs/BloodRain_Tok_Effect_rnc0110.png"
}

local bloodRain_SPR = {}

for i, v in ipairs(BloodRain_Effect_SPR_Array) do
    bloodRain_SPR[i] = love.graphics.newImage(v)
    bloodRain_SPR[i]:setFilter("nearest", "nearest")
end

BloodRain_Effect = {}

function BloodRain_Effect:new(x,y,w,h)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 2,
        w = w,
        h = h,
        tag = "Effect",
        bloodRain_idx = 1,
        isDestroyed = false,
        rainyTime = 0.0
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function BloodRain_Effect:Init()

end

function BloodRain_Effect:Update()
    
    self.rainyTime = self.rainyTime + 1

    if self.rainyTime % 2 == 0 then
        self.bloodRain_idx = self.bloodRain_idx + 1
        self.rainyTime = 0.0
    end

    if self.bloodRain_idx > 12 then
        self.bloodRain_idx = 12
        self.isDestroyed = true
    end
end

function BloodRain_Effect:draw()
    love.graphics.push()

    if not C_GameManager.isGameOver then
        love.graphics.draw(bloodRain_SPR[self.bloodRain_idx],self.x,self.y,0,self.w,self.h)
    end

    love.graphics.pop()
end

function BloodRain_Effect:ReBoot()
    self.isDestroyed = true
end