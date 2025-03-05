require("Scripts.Maths.Distance")

WarCloudCore_Tut = {}

local cloudSPR_Array = {"assets/images/Other_SPRs/RNC_CLOUD_SPR.png"}

function WarCloudCore_Tut:new()
    local current_Table = 
    {
        x = 630,
        y = -70,
        z = 2,
        tag = "Cloud",
        cloudSPR = {},
        rndSize = 6,
        desPoint = math.random(100,love.graphics.getWidth() - 100)
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function WarCloudCore_Tut:Init()
    self.desPoint = math.random(100,1240)

    for i, v in ipairs(cloudSPR_Array) do
        self.cloudSPR[i] = love.graphics.newImage(v)
        self.cloudSPR[i]:setFilter("nearest", "nearest")
    end
end

function WarCloudCore_Tut:Update()

    if C_Tutorial_Level_Manager.tutorial_idx == 4 and C_Tutorial_Level_Manager.current_Idx == 2 then
        self.x = Lerp(self.desPoint + 1,self.x, 0.98500)

        if Distance_Value(self.desPoint + 1, self.x) < 2 then
            self.desPoint = math.random(100,1240)
        end
    end
end

function WarCloudCore_Tut:draw()
    love.graphics.push()

    if C_Tutorial_Level_Manager.tutorial_idx == 4 and C_Tutorial_Level_Manager.current_Idx == 2 then
        love.graphics.draw(self.cloudSPR[1],self.x,self.y,0, 4, 4)
    end

    love.graphics.pop()
end

function WarCloudCore_Tut:ReBoot()
    self.x = 630
end