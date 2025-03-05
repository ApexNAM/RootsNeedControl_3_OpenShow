local fd96_SPR_Bullet = love.graphics.newImage("assets/images/Other_SPRs/RNC_FD_96_BULLET_SPR.png")
fd96_SPR_Bullet:setFilter("nearest", "nearest")

FD_96_Bullet = {}

function FD_96_Bullet:new(x,y,r)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 1,
        r = r,
        w = 8,
        h = 8,
        tag = "FD_96_Bullet",
        isDestroyed = false
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function FD_96_Bullet:Init()

end

function FD_96_Bullet:Update()
    self.x = self.x + math.cos(self.r) * 50
    self.y = self.y + math.sin(self.r) * 50

    if self.y >  590 then
        self.isDestroyed = true 
    end
end

function FD_96_Bullet:draw()
    love.graphics.push()

    local width, height = fd96_SPR_Bullet:getDimensions()
    
    if not C_GameManager.isGameOver then
        love.graphics.draw(fd96_SPR_Bullet,self.x,self.y,self.r,2,2,width / 2, height / 2)
    end
    
    if Debug_Manager.debugMode then
        love.graphics.push()
    
        love.graphics.translate(self.x, self.y)
        love.graphics.rotate(self.r)
        love.graphics.rectangle("line", -width, -height, self.w, self.h)
    
        love.graphics.pop()
    end

    love.graphics.pop()
end

function FD_96_Bullet:ReBoot()
    self.isDestroyed = true
end