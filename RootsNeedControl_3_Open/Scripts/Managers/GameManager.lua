GameManager = {}
GameManager.queue = {}
GameManager.playlist = {}
GameManager.currentsong = -1

function GameManager:new()
    local current_Table = 
    {
        firstLangChanged = true,

        current_lock_level = 1,
        current_sub_lock_level = 1,
        
        set_Level = 
        {
            "Daejeon",
            "Sejong",
            "Incehon",
            "donggu",
            "junggu",
            "seogu",
            "yuseong",
            "daeduck"
        },

        current_Level = "Daejeon",
        current_Level_idx = 1,

        difficultyStates = 
        {
            "normal",
            "hard"
        },

        difficulty_current = nil,

        z = 1,
        crossHairSpeed = 3,

        rocket_Spd_min = 4,
        rocket_Spd_max = 7,

        tank_Spd_idx = 1,
        fd96_Spd_idx = 1,

        score = {0,0,0,0,0,0,0,0},
        highScore = {0,0,0,0,0,0,0,0},

        current_RootSpeed = 240,
        current_DamageSpeed_From_Root = 30,
        isGameOver = false,
        isMusicEnabled = true,

        greenColor = {10,174,77},
        redColor = {220,20,60},

        current_Col_R = 10,
        current_Col_G = 174,
        current_Col_B = 77,

        damage_Time = 0.0,
        game_Time = 0.0,
        isFullScreen = true,

        kr_wave_Font = love.graphics.newFont("assets/Fonts/Galmuri9.ttf",20),
        en_wave_Font = love.graphics.newFont("assets/Fonts/pico-8.ttf",20),

        damageSound = "assets/Sounds/rnc_wav_damage.wav",
        fireSound = "assets/Sounds/rnc_wav_fire.wav",
        rainySound = "assets/Sounds/rnc_wav_rain_sound.wav",
        hitSound = "assets/Sounds/rnc_wav_hit.wav",
        fireSound2 = "assets/Sounds/rnc_wav_fire.wav",

        introSound = "assets/Sounds/rnc_intro_sound.wav",
        introSound2 = "assets/Sounds/rnc_intro_end_sound.wav",

        backgroundMusic1 = nil,
        backgroundMusic2 = nil,
        backgroundMusic3 = nil,
        backgroundMusic4 = nil,

        can_Endless_Mode = false,
        endless_Mode = false,

        is2PlayerMode = false,
        textWidth =  (1536 - love.graphics.getWidth()) / 2.5 * love.graphics.getWidth() / 1536
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function GameManager:Init()
    self.score[self.current_Level_idx] = 0
    
    self.kr_wave_Font:setFilter("nearest", "nearest")
    self.en_wave_Font:setFilter("nearest", "nearest")

    self.difficulty_current = self.difficultyStates[1]

    self.backgroundMusic1 = love.audio.newSource("assets/Sounds/Music/Rootsneedscontrol_Stage_Deajeon.ogg", "stream")
    self.backgroundMusic2 = love.audio.newSource("assets/Sounds/Music/Rootsneedscontrol_Stage_Sejong.ogg","stream")
    self.backgroundMusic3 = love.audio.newSource("assets/Sounds/Music/Rootsneedscontrol_Stage_Incheon.ogg","stream")
    self.backgroundMusic4 = love.audio.newSource("assets/Sounds/Music/Rootsneedscontrol_Stage_Infinite.ogg","stream")

    self.backgroundMusic1:setLooping(true)
    self.backgroundMusic2:setLooping(true)
    self.backgroundMusic3:setLooping(true)
    self.backgroundMusic4:setLooping(true)

    self:ScreenUpdate()
end

function GameManager:Update()

    self:SoundUpdate()
    self:playMusic()
    
    if self.score[self.current_Level_idx] % 10 == 0 and self.score[self.current_Level_idx] ~= 0 then
        self:SpeedDown()
        self.score[self.current_Level_idx] = self.score[self.current_Level_idx] + 1
    end

    if not self.isGameOver then
        if self.score[self.current_Level_idx] > self.highScore[self.current_Level_idx] then
            self.highScore[self.current_Level_idx] = self.score[self.current_Level_idx]
        end
    end

    if self.current_Col_R ~= 10 and
       self.current_Col_G ~= 174 and
       self.current_Col_B ~= 77 then

        self.damage_Time = self.damage_Time + 1

        if self.damage_Time >= 10 then
            self:ChangeStarFieldColor(10,174,77)
            self.damage_Time = 0.0
        end
    end
end

function GameManager:draw()

end

function GameManager:ReBoot()
    self.crossHairSpeed = 3
    self.rocket_Spd_min = 4
    self.rocket_Spd_max = 7

    self.tank_Spd_min = 0.25
    self.tank_Spd_max = 0.5

    self.isGameOver = false

    if self.isFullScreen then
        self.textWidth = (1536 - love.graphics.getWidth()) / 2.5 * love.graphics.getWidth() / 1536
    else
        self.textWidth = (1536 - love.graphics.getWidth()) / 2 * 1280 / 1536
    end

    self.backgroundMusic1:stop()
    self.backgroundMusic2:stop()
    self.backgroundMusic3:stop()
    self.backgroundMusic4:stop()
end

function GameManager:differentChanged(idx)
    self.difficulty_current = self.difficultyStates[idx]
end

function GameManager:differentIndex()
    if self.difficulty_current == self.difficultyStates[1] then
        return 1
    elseif self.difficulty_current == self.difficultyStates[2] then
        return 2
    end
end

function GameManager:AddScore()
    self.score[C_GameManager.current_Level_idx] = self.score[C_GameManager.current_Level_idx] + 1
end

function GameManager:SpeedUp()

    if self.crossHairSpeed < 6 then
        self.crossHairSpeed = self.crossHairSpeed + 0.25
    end

    if self.rocket_Spd_min < 10 then
        self.rocket_Spd_min = self.rocket_Spd_min + 1
    end

    if self.rocket_Spd_max < 20 then
        self.rocket_Spd_max = self.rocket_Spd_max + 1
    end
end

function GameManager:SpeedDown()

    if self.crossHairSpeed > 3 then
        self.crossHairSpeed = self.crossHairSpeed - 0.25
    end

    if self.rocket_Spd_min > 4 then
        self.rocket_Spd_min = self.rocket_Spd_min - 1
    end

    if self.rocket_Spd_max > 7 then
        self.rocket_Spd_max = self.rocket_Spd_max - 1
    end
end

local function shuffle(playlist)
    local n = #playlist
    for i = n, 2, -1 do
      local j = math.random(i)
      playlist[i], playlist[j] = playlist[j], playlist[i]
    end
end

function GameManager:playSound(sndData)
	local src = love.audio.newSource(sndData, "stream")
	table.insert(self.queue, src)

	love.audio.play(src)
end

function GameManager:playMusic()

    if self.isMusicEnabled then
        if StartGameEnabled() then

            if self.current_Level == "Daejeon" then
                if not self.backgroundMusic1:isPlaying() then
                    self.backgroundMusic1:play()
                end
            elseif self.current_Level == "Sejong" then
                if not self.backgroundMusic2:isPlaying() then
                    self.backgroundMusic2:play()
                end
            elseif self.current_Level == "Incehon" then
                if not self.backgroundMusic3:isPlaying() then
                    self.backgroundMusic3:play()
                end
            else
                if not self.backgroundMusic4:isPlaying() then
                    self.backgroundMusic4:play()
                end
            end
        elseif C_GameManager.isGameOver then
            self.backgroundMusic1:stop()
            self.backgroundMusic2:stop()
            self.backgroundMusic3:stop()
            self.backgroundMusic4:stop()
        else
            self.backgroundMusic1:stop()
            self.backgroundMusic2:stop()
            self.backgroundMusic3:stop()
            self.backgroundMusic4:stop()
        end
    end
end

function GameManager:shuffle(first, ...)
	local playlist
	if type(first) == "table" then
		playlist = first
	else
		playlist = {first, ...}
	end
	shuffle(playlist)
	return unpack(playlist)
end

function GameManager:SoundUpdate()

	local removelist = {}

	for i, v in ipairs(self.queue) do
		if not v:isPlaying() then
			table.insert(removelist, i)
		end
	end

	for i, v in ipairs(removelist) do
		table.remove(self.queue, v-i+1)
	end

	if self.currentsong ~= -1 and self.playlist and not self.playlist[self.currentsong]:isPlaying() then
		self.currentsong = self.currentsong + 1
		if self.currentsong > #self.playlist then
			self.currentsong = 1
		end

		love.audio.play(self.playlist[self.currentsong])
	end
end

function GameManager:PlayTakeDamageSound()
    if self.isMusicEnabled then
        love.audio.setVolume(1.0)
        self:playSound(self.damageSound)
    end
end

function GameManager:FD96_FireSound()
    if self.isMusicEnabled then
        love.audio.setVolume(0.25)
        self:playSound(self.fireSound)
    end
end

function GameManager:RainySound()
    if self.isMusicEnabled then
        love.audio.setVolume(0.8)
        self:playSound(self.rainySound)
    end
end

function GameManager:Hit_Attack_Sound()
    if self.isMusicEnabled then
        love.audio.setVolume(1.0)
        self:playSound(self.hitSound)
    end
end

function GameManager:CrossHair_Attack_Sound()
    if self.isMusicEnabled then
        love.audio.setVolume(0.5)
        self:playSound(self.hitSound)
    end
end

function GameManager:Intro_Sound1()
    if self.isMusicEnabled then
        love.audio.setVolume(1.0)
        self:playSound(self.introSound)
    end
end

function GameManager:Intro_Sound2()
    if self.isMusicEnabled then
        love.audio.setVolume(1.0)
        self:playSound(self.introSound2)
    end
end

function GameManager:ChangeStarFieldColor(r,g,b)
    self.current_Col_R = r
    self.current_Col_G = g
    self.current_Col_B = b
end

function GameManager:ScreenUpdate()
    if self.isFullScreen then
        self.textWidth = (1536 - love.graphics.getWidth()) / 2.5 * love.graphics.getWidth() / 1536
    else
        self.textWidth = (1536 - love.graphics.getWidth()) / 2 * 1280 / 1536
    end
end

C_GameManager = GameManager:new() -- �ٸ� ���������� ��� �����մϴ�.