LanguageManager = {}

function LanguageManager:new(setlang)

    local current_Table = 
    {
        language = {"한국어", "english", "日本語"},
        language_current = setlang
    }

    setmetatable(current_Table, self)
    self.__index = self
    
    return current_Table
end

Current_Lang = LanguageManager:new(2)