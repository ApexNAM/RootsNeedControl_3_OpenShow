PlayerHealth = {}

function PlayerHealth:new(max_Health)
    local current_Table =
    {
        isDead = false,
        current_health = 0,
        max_Health = max_Health,
        returnTime = 0.0,
        can_rehealth = true
    }

    setmetatable(current_Table, self)
    self.__index = self

    return current_Table
end

function PlayerHealth:Init()
    self.current_health = self.max_Health
end

function PlayerHealth:TakeDamage(damage)
    if not self.isDead then
        Current_RNC_Camera:_Setter_Offset(1.5)
        C_GameManager:ChangeStarFieldColor(220,20,60)
        C_GameManager:PlayTakeDamageSound()
        
        self.current_health = self.current_health - damage

        if self.current_health <= 0 then
            self:DeadNow()
        end
    end
end

function PlayerHealth:DeadNow()
    Current_RNC_Camera:_Setter_Offset(3)
    self.current_health = 0
    self.isDead = true
end

function PlayerHealth:AddHealth()
    if not self.isDead then
        self.current_health = self.current_health + 1

        if self.current_health >= self.max_Health then
            self.current_health = self.max_Health
        end
    end
end

function PlayerHealth:ReturnHealth()
    if C_GameManager.difficulty_current == C_GameManager.difficultyStates[1] then

        if self.can_rehealth then
            if self.current_health < self.max_Health then
                self.returnTime = self.returnTime + 1

                if self.returnTime % 160 == 0 then
                    self.current_health = self.current_health + 10
                    self.returnTime = 0.0
                end
            end
        end
    end
end

function PlayerHealth:ReBoot()
    self.isDead = false
    self.current_health = self.max_Health
end