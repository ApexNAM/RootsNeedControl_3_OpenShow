-- DebugMode Manager는 작업 과정에서만 사용되는
-- 개발 소스코드입니다.

-- 실제 이 소스코드의 변수와 함수는 빌드파일에서는 사용하지 않습니다.

RNC_Debug_Mode_Manager = {}

function RNC_Debug_Mode_Manager:new()

    local current_Table = { debugMode = false; }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

function RNC_Debug_Mode_Manager:OnDebugMode(check)
    self.debugMode = check
end

Debug_Manager = RNC_Debug_Mode_Manager:new()