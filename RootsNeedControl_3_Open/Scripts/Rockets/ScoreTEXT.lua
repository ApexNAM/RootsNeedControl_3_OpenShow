require("Scripts.Managers.LanguageManager")

local font_kr_add_Score = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",30)
local font_en_add_Score = love.graphics.newFont("assets/Fonts/pico-8.ttf",30)
local font_kr_TakeDamage = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",40)
local font_en_TakeDamage = love.graphics.newFont("assets/Fonts/pico-8.ttf",40)

ScoreTextObject = {}

function ScoreTextObject:new(x,y,del_Type)
    local current_Table = 
    {
        x = x,
        y = y,
        z = 1,
        tag = "ScoreTEXT",
        delete_Time = 0.0,
        isDestroyed = false,
        delete_Type = del_Type,
    }

    setmetatable(current_Table, self)
    self.__index = self

    return current_Table
end

function ScoreTextObject:Init()
    self.delete_Time = 0.0
    self.isDestroyed = false
end

function ScoreTextObject:Update()
    
    if not self.isDestroyed then
        self.y = self.y - 0.25

        self.delete_Time = self.delete_Time + 1

        if self.delete_Time % 120 == 0 then
            self.delete_Time = 0.0
            self.isDestroyed = true
        end
    end
end

function ScoreTextObject:draw()

    love.graphics.push()

    if not C_GameManager.isGameOver then
        if self.delete_Type == "TakeScore" then

            if Current_Lang.language_current == 1 then
                love.graphics.setFont(font_kr_add_Score)
                love.graphics.print("destoryed!",self.x,self.y)
            elseif Current_Lang.language_current == 2 then
                love.graphics.setFont(font_en_add_Score)
                love.graphics.print("destoryed!",self.x,self.y)
            elseif Current_Lang.language_current == 3 then
                love.graphics.setFont(font_kr_add_Score)
                love.graphics.print("破壊された！",self.x,self.y)
            end

        elseif self.delete_Type == "TakeDamage" then
            love.graphics.setColor(255,0,0,255)

            if Current_Lang.language_current == 1 then
                love.graphics.setFont(font_kr_TakeDamage)
                love.graphics.print("damaged!",self.x,self.y)
            elseif Current_Lang.language_current == 2 then
                love.graphics.setFont(font_en_TakeDamage)
                love.graphics.print("damaged!",self.x,self.y)
            elseif Current_Lang.language_current == 3 then
                love.graphics.setFont(font_kr_TakeDamage)
                love.graphics.print("致命的な！",self.x,self.y)
            end

            love.graphics.setColor(255,255,255,255)
        elseif self.delete_Type == "recover!" then
            love.graphics.setColor(000,102,000,255)

            if Current_Lang.language_current == 1 then
                love.graphics.setFont(font_kr_TakeDamage)
                love.graphics.print("add hp!",self.x + love.math.random(-0.5,0.5),self.y)
            elseif Current_Lang.language_current == 2 then
                love.graphics.setFont(font_en_TakeDamage)
                love.graphics.print("add hp!",self.x + love.math.random(-0.5,0.5),self.y)
            elseif Current_Lang.language_current == 3 then
                love.graphics.setFont(font_kr_TakeDamage)
                love.graphics.print("回復！",self.x,self.y)
            end

            love.graphics.setColor(255,255,255,255)
        end
    end
    
    love.graphics.pop()
end

function ScoreTextObject:ReBoot()
    self.isDestroyed = true
end