-- DebugMode Manager�� �۾� ���������� ���Ǵ�
-- ���� �ҽ��ڵ��Դϴ�.

-- ���� �� �ҽ��ڵ��� ������ �Լ��� �������Ͽ����� ������� �ʽ��ϴ�.

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