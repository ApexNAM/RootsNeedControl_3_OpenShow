Rnc_Camera = {}

function Rnc_Camera:new()
    local current_Table = 
    {
        x = 0,
        y = 0,
        scaleX = 1,
        scaleY = 1,
        rotation = 0,
        offset = 0.0,
        cameraShakeEnabled = true
    }

    setmetatable(current_Table, self)
    self.__index = self

    return current_Table
end

function Rnc_Camera:set()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)

    if love.window.getFullscreen() then

        local width, height = love.window.getDesktopDimensions()

        if width == 1280 and height == 720 then
            love.graphics.scale(1280 / 1536, 720 / 864)
        elseif width == 1920 and height == 1080 then
            love.graphics.scale(1920 / 1536, 1080 / 864)
        elseif width == 2560 and height == 1440 then
            love.graphics.scale(2560 / 1536, 1440 / 864)
        else
            love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
        end

    else
        local screenWidth, screenHeight = love.window.getMode()
        love.graphics.scale(screenWidth /1536, screenHeight/864)
    end

    love.graphics.translate(-self.x, -self.y)
end

function Rnc_Camera:unset()
  love.graphics.pop()  
end

function Rnc_Camera:Movement(x,y)
    self.x = self.x + (x or 0)
    self.y = self.y + (y or 0)
end

function Rnc_Camera:Rotate(dir)
    self.rotation = self.rotation + dir
end

function Rnc_Camera:Scaled(x,y)
    x = x or 1
    self.scaleX = self.scaleX * x
    self.scaleY = self.scaleY * (y or x)
end

function Rnc_Camera:SetterPos(x,y)
    self.x = x or self.x
    self.y = y or self.y
end

function Rnc_Camera:SetterScale(x,y)
    self.scaleX = x or self.scaleX
    self.scaleY = y or self.scaleY
end

function Rnc_Camera:_Setter_Offset(val)
    self.offset = val
end

function Rnc_Camera:OnCameraShake()
    local fade = 0.95
    
    local offset_x = 16 - love.math.random(32)
    local offset_y = 16 - love.math.random(32)

    offset_x = offset_x * self.offset
    offset_y = offset_y * self.offset

    if self.cameraShakeEnabled then
        self:SetterPos(offset_x,offset_y)
    end
    
    self.offset = self.offset * fade

    if self.offset < 0.05 then
        self.offset = 0
    end
end

Current_RNC_Camera = Rnc_Camera:new()