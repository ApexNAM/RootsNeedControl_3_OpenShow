SG_logo = 
{
    "assets/images/SkagoGames_SPRs/SkagoIntro_0.png",
    "assets/images/SkagoGames_SPRs/SkagoIntro_1.png",
    "assets/images/SkagoGames_SPRs/SkagoIntro_2.png",
    "assets/images/SkagoGames_SPRs/SkagoIntro_3.png",
    "assets/images/SkagoGames_SPRs/SkagoIntro_4.png",
    "assets/images/SkagoGames_SPRs/SkagoIntro_5.png",
    "assets/images/SkagoGames_SPRs/SkagoIntro_6.png",
    "assets/images/SkagoGames_SPRs/SkagoIntro_7.png",
} 

IntroScreen = {}

local SkagoGames_Logos = {}

for i, v in ipairs(SG_logo) do
    SkagoGames_Logos[i] = love.graphics.newImage(v)
end

function IntroScreen:new()
    local current_Table = 
    {
        x = 610,
        y = 200,
        intro_idx = 1,
        intro_Time = 0.0,
        font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",80),
        font2 = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",30),
        current_Size = 0,
        ty = 800,
        t2y = 800,
        nextSceneTime = 0.0,
        isIntroEnded = false
    }

    setmetatable(current_Table, self)
    self.__index = self

    return current_Table
end

function IntroScreen:Init()
    self.font:setFilter("nearest","nearest")
    self.font2:setFilter("nearest","nearest")
end

function IntroScreen:Update()
    
    self.intro_Time = self.intro_Time + 1

    if self.intro_Time % (60 / self.intro_idx) == 0 and not self.isIntroEnded then

        if self.intro_idx < 8 then
            C_GameManager:Intro_Sound1()
            Current_RNC_Camera:_Setter_Offset(self.intro_idx / 1)
            self.intro_idx = self.intro_idx + 1
        elseif self.intro_idx == 8 then
            C_GameManager:Intro_Sound2()
            self.isIntroEnded = true
        end

        self.intro_Time = 0.0
    end

    if self.intro_idx >= 8 and self.isIntroEnded then
        self.intro_Time = 0.0

        self.ty = Lerp(520, self.ty,0.955)
        self.t2y = Lerp(770,self.t2y,0.9999)

        self.nextSceneTime = self.nextSceneTime + 1

        if self.nextSceneTime > 400 then

            if C_GameManager.firstLangChanged then
                ChangeScene(6)
            else
                ChangeScene(2)
            end

            self.nextSceneTime = 0.0
            self.isIntroEnded = false
        end
    end
end

function IntroScreen:draw()
    love.graphics.draw(SkagoGames_Logos[self.intro_idx], self.x, self.y,0,1.5,1.5)

    if self.intro_idx == 8 then
        love.graphics.setFont(self.font)
        love.graphics.print("SkagoGames",540,self.ty,0)

        love.graphics.setFont(self.font2)
        love.graphics.print("SkagoGames 2023. made in Skago.",520,self.t2y,0)
    end
end